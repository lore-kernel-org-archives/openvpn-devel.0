From: Arne Schwabe <arne@...1227...>
Date: Mon, 30 Jan 2023 14:20:09 +0100
Message-Id: <20230130132010.3415087-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Fix unaligned access in macOS/Solaris
 hwaddr and auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The undefined behaviour USAN clang checker found these two cases. The optimiser
of clang/gcc will optimise the memcpy away in the auth_token case and output
excactly the same assembly on amd64/arm64 but it is still better to not rely
on undefined behaviour.

The hw addr fix is a mess but so are the original structures.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/auth_token.c | 10 ++++++++--
 src/openvpn/route.c      | 32 +++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 7b963a9c5..530b3aa4c 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -324,8 +324,14 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
     const uint8_t *tstamp_initial = sessid + AUTH_TOKEN_SESSION_ID_LEN;
     const uint8_t *tstamp = tstamp_initial + sizeof(int64_t);
 
-    uint64_t timestamp = ntohll(*((uint64_t *) (tstamp)));
-    uint64_t timestamp_initial = ntohll(*((uint64_t *) (tstamp_initial)));
+    /* This might not be aligned to an uint64, use memcpy to avoid
+     * unaligned access */
+    uint64_t timestamp = 0, timestamp_initial = 0;
+    memcpy(&timestamp, tstamp, sizeof(uint64_t));
+    timestamp = ntohll(timestamp);
+
+    memcpy(&timestamp_initial, tstamp_initial, sizeof(uint64_t));
+    timestamp_initial = ntohll(timestamp_initial);
 
     hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
     if (check_hmac_token(ctx, b64decoded, up->username))
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 82519c94b..06bfb799c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3637,7 +3637,7 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
     if (rgi->flags & RGI_IFACE_DEFINED)
     {
         struct ifconf ifc;
-        struct ifreq *ifr;
+        struct ifreq ifr;
         const int bufsize = 4096;
         char *buffer;
 
@@ -3662,23 +3662,37 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
 
         for (cp = buffer; cp <= buffer + ifc.ifc_len - sizeof(struct ifreq); )
         {
-            ifr = (struct ifreq *)cp;
+            /* this is not always using an 8byte alignment that struct ifr
+             * requires */
+            memcpy(&ifr, cp, sizeof(struct ifreq));
 #if defined(TARGET_SOLARIS)
-            const size_t len = sizeof(ifr->ifr_name) + sizeof(ifr->ifr_addr);
+            const size_t len = sizeof(ifr.ifr_name) + sizeof(ifr.ifr_addr);
 #else
-            const size_t len = sizeof(ifr->ifr_name) + max(sizeof(ifr->ifr_addr), ifr->ifr_addr.sa_len);
+            const size_t len = sizeof(ifr.ifr_name) + max(sizeof(ifr.ifr_addr), ifr.ifr_addr.sa_len);
 #endif
 
-            if (!ifr->ifr_addr.sa_family)
+            if (!ifr.ifr_addr.sa_family)
             {
                 break;
             }
-            if (!strncmp(ifr->ifr_name, rgi->iface, IFNAMSIZ))
+            if (!strncmp(ifr.ifr_name, rgi->iface, IFNAMSIZ))
             {
-                if (ifr->ifr_addr.sa_family == AF_LINK)
+                if (ifr.ifr_addr.sa_family == AF_LINK)
                 {
-                    struct sockaddr_dl *sdl = (struct sockaddr_dl *)&ifr->ifr_addr;
-                    memcpy(rgi->hwaddr, LLADDR(sdl), 6);
+                    /* This is a broken member access. struct sockaddr_dl has
+                     * 20 bytes while if_addr has only 16 bytes. So casting if_addr
+                     * to struct sockaddr_dl gives (legitimate) warnings
+                     *
+                     * sockaddr_dl has 12 bytes space for the hw address and
+                     * Ethernet only uses 6 bytes. So the last 4 that are
+                     * truncated and not in if_addr can be ignored here.
+                     *
+                     * So we use a memcpy here to avoid the warnings with ASAN
+                     * that we are doing a very nasty cast here
+                     */
+                    struct sockaddr_dl sdl = { 0 };
+                    memcpy(&sdl, &ifr.ifr_addr, sizeof(ifr.ifr_addr));
+                    memcpy(rgi->hwaddr, LLADDR(&sdl), 6);
                     rgi->flags |= RGI_HWADDR_DEFINED;
                 }
             }
-- 
2.37.1 (Apple Git-137.1)


