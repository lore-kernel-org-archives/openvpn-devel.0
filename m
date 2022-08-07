From: Gert Doering <gert@...1296...>
Date: Sun,  7 Aug 2022 21:35:35 +0200
Message-Id: <20220807193535.15377-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Cleanup: get rid of 'dynamic' argument of
 open_tun_generic()
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

All callers of open_tun_generic() always set dynamic=true - so just
get rid of it.  While at it, move "int i" into the for() loop.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 659bd245..6e7c0197 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1736,7 +1736,7 @@ tun_dco_enabled(struct tuntap *tt)
 #if !(defined(_WIN32) || defined(TARGET_LINUX))
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
-                 bool dynamic, struct tuntap *tt)
+                 struct tuntap *tt)
 {
     char tunname[256];
     char dynamic_name[256];
@@ -1767,7 +1767,7 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
              * opening /dev/tap and then querying the system about the
              * actual device name (tap0, tap1, ...) assigned
              */
-            if (dynamic && strcmp( dev, "tap" ) == 0)
+            if (strcmp( dev, "tap" ) == 0)
             {
                 struct ifreq ifr;
                 if ((tt->fd = open( "/dev/tap", O_RDWR)) < 0)
@@ -1786,10 +1786,9 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
             else
 #endif
 
-            if (dynamic && !tun_name_is_fixed(dev))
+            if (!tun_name_is_fixed(dev))
             {
-                int i;
-                for (i = 0; i < 256; ++i)
+                for (int i = 0; i < 256; ++i)
                 {
                     openvpn_snprintf(tunname, sizeof(tunname),
                                      "/dev/%s%d", dev, i);
@@ -2682,7 +2681,7 @@ void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, tt);
 
     /* Enable multicast on the interface */
     if (tt->fd >= 0)
@@ -2777,7 +2776,7 @@ void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, tt);
 
     if (tt->fd >= 0)
     {
@@ -2918,7 +2917,7 @@ void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, tt);
 
     if (tt->fd >= 0 && tt->type == DEV_TYPE_TUN)
     {
@@ -3047,7 +3046,7 @@ void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, tt);
 
     if (tt->fd >= 0)
     {
@@ -3300,7 +3299,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             {
                 /* No explicit utun and utun failed, try the generic way) */
                 msg(M_INFO, "Failed to open utun device. Falling back to /dev/tun device");
-                open_tun_generic(dev, dev_type, NULL, true, tt);
+                open_tun_generic(dev, dev_type, NULL, tt);
             }
             else
             {
@@ -3323,7 +3322,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             dev_node = NULL;
         }
 
-        open_tun_generic(dev, dev_type, dev_node, true, tt);
+        open_tun_generic(dev, dev_type, dev_node, tt);
     }
 }
 
@@ -7004,7 +7003,7 @@ void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, tt);
 }
 
 void
-- 
2.35.1


