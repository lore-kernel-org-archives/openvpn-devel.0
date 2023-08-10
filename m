From: Arne Schwabe <arne@...1227...>
Date: Thu, 10 Aug 2023 16:02:10 +0200
Message-Id: <20230810140210.4047842-1-arne@...1227...>
In-Reply-To: <20230130172936.3444840-2-arne@...1227...>
References: <20230130172936.3444840-2-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix unaligned access in macOS/Solaris
 hwaddr
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

The undefined behaviour USAN clang checker found this.

This fix is a bit messy but so are the original structures.

Patch v2: handle the fact we need to beyond the struct ifr
          correctly when mapping the result to struct sockaddr_dl

Change-Id: Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/route.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 90e981e97..bcf6fb878 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3641,7 +3641,7 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
     if (rgi->flags & RGI_IFACE_DEFINED)
     {
         struct ifconf ifc;
-        struct ifreq *ifr;
+        struct ifreq ifr;
         const int bufsize = 4096;
         char *buffer;
 
@@ -3666,23 +3666,37 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
 
         for (cp = buffer; cp <= buffer + ifc.ifc_len - sizeof(struct ifreq); )
         {
-            ifr = (struct ifreq *)cp;
+            /* this is not always using an 8 byte alignment that struct ifr
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
+                     * sockaddr_dl has 12 bytes space for the inrerface name and
+                     * the hw address. So the last 4 that might be part of the
+                     * hw address are not in if_addr, so we need
+                     *
+                     * So we use a memcpy here to avoid the warnings with ASAN
+                     * that we are doing a very nasty cast here
+                     */
+                    struct sockaddr_dl sdl = { 0 };
+                    memcpy(&sdl, cp + offsetof(struct ifreq, ifr_addr), sizeof(sdl));
+                    memcpy(rgi->hwaddr, LLADDR(&sdl), 6);
                     rgi->flags |= RGI_HWADDR_DEFINED;
                 }
             }
-- 
2.39.2 (Apple Git-143)


