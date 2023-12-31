From: Gert Doering <gert@...1296...>
Date: Sun, 31 Dec 2023 18:41:51 +0100
Message-Id: <20231231174151.26780-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] OpenSolaris: teach get_default_gateway() to
 get HWADDR
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

In the context of gerrit/454 it was uncovered that the existing
code never worked on OpenSolaris anyway because no AF_LINK
addresses are returned.  Debugging this, it was found that
SIOCGIFHWADDR exists instead, and "man if_tcp" claims "should
behave in a manner compatible with Linux".

So, copied and adjusted the linux code, and it works...

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0e6667f7..684b6357 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3643,8 +3643,8 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
 
 #if !defined(TARGET_SOLARIS)
     /* Illumos/Solaris does not provide AF_LINK entries when calling the
-     * SIOCGIFCONF API, so there is little sense to trying to figure out a
-     * MAC address from an API that does not provide that information */
+     * SIOCGIFCONF API, but does have SIOCGIFHWADDR - so ifdef needed
+     */
 
     /* try to read MAC addr associated with interface that owns default gateway */
     if (rgi->flags & RGI_IFACE_DEFINED)
@@ -3725,6 +3725,31 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
             cp += len;
         }
     }
+#else /* if !defined(TARGET_SOLARIS) */
+    /* try to read MAC addr associated with interface that owns default gateway */
+    if (rgi->flags & RGI_IFACE_DEFINED)
+    {
+        sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+        if (sockfd < 0)
+        {
+            msg(M_WARN, "GDG: socket #3 failed");
+            goto done;
+        }
+
+        struct ifreq ifreq = { 0 };
+
+        /* now get the hardware address. */
+        strncpynt(ifreq.ifr_name, rgi->iface, sizeof(ifreq.ifr_name));
+        if (ioctl(sockfd, SIOCGIFHWADDR, &ifreq) < 0)
+        {
+            msg(M_WARN, "GDG: SIOCGIFHWADDR(%s) failed", ifreq.ifr_name);
+        }
+        else
+        {
+            memcpy(rgi->hwaddr, &ifreq.ifr_addr.sa_data, 6);
+            rgi->flags |= RGI_HWADDR_DEFINED;
+        }
+    }
 #endif /* if !defined(TARGET_SOLARIS) */
 
 done:
-- 
2.23.0


