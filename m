From: Gert Doering <gert@...1296...>
Date: Mon,  8 Aug 2022 17:23:44 +0200
Message-Id: <20220808152344.17539-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] cleanup open_tun() for TARGET_NETBSD
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

- NetBSD "dynamic tap" (--dev tap -> tap<number>) handling had special
  #ifdef'ed code inside open_tun_generic() - pull out, move to NetBSD
  open_tun().  Roughly the same amount of code, less #ifdef, code flow
  is more clear.

- fix one spurious warning about "remote" not being initialized

- adjust NetBSD do_open() comments to actual code - the "pre NetBSD 4.0"
  code has long be removed, but the comment was still there.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 72 +++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 54f7d72c..9cba1c3a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1380,7 +1380,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     }
 
 #elif defined(TARGET_NETBSD)
-    in_addr_t remote_end;           /* for "virtual" subnet topology */
+    in_addr_t remote_end = INADDR_ANY;	/* for "virtual" subnet topology */
 
     if (tun)
     {
@@ -1762,29 +1762,6 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
              * explicit unit number.  Try opening /dev/[dev]n
              * where n = [0, 255].
              */
-#ifdef TARGET_NETBSD
-            /* on NetBSD, tap (but not tun) devices are opened by
-             * opening /dev/tap and then querying the system about the
-             * actual device name (tap0, tap1, ...) assigned
-             */
-            if (strcmp(dev, "tap") == 0)
-            {
-                struct ifreq ifr;
-                if ((tt->fd = open( "/dev/tap", O_RDWR)) < 0)
-                {
-                    msg(M_FATAL, "Cannot allocate NetBSD TAP dev dynamically");
-                }
-                if (ioctl( tt->fd, TAPGIFNAME, (void *)&ifr ) < 0)
-                {
-                    msg(M_FATAL, "Cannot query NetBSD TAP device name");
-                }
-                CLEAR(dynamic_name);
-                strncpy( dynamic_name, ifr.ifr_name, sizeof(dynamic_name)-1 );
-                dynamic_opened = true;
-                openvpn_snprintf(tunname, sizeof(tunname), "/dev/%s", dynamic_name );
-            }
-            else
-#endif
 
             if (!tun_name_is_fixed(dev))
             {
@@ -2759,24 +2736,51 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #elif defined(TARGET_NETBSD)
 
 /*
- * NetBSD before 4.0 does not support IPv6 on tun out of the box,
- * but there exists a patch (sys/net/if_tun.c, 1.79->1.80, see PR 32944).
- *
- * NetBSD 4.0 and up do, but we need to put the tun interface into
- * "multi_af" mode, which will prepend the address family to all packets
- * (same as OpenBSD and FreeBSD).  If this is not enabled, the kernel
- * silently drops all IPv6 packets on output and gets confused on input.
+ * NetBSD 4.0 and up support IPv6 on tun interfaces, but we need to put
+ * the tun interface into "multi_af" mode, which will prepend the address
+ * family to all packets (same as OpenBSD and FreeBSD).
  *
- * On earlier versions, multi_af is not available at all, so we have
- * two different NetBSD code variants here :-(
+ * If this is not enabled, the kernel silently drops all IPv6 packets on
+ * output and gets confused on input.
  *
+ * Note: --dev tap3 works *if* the interface is created externally by
+ *         "ifconfig tap3 create"
+ *         (and for devices beyond tap3, "mknod /dev/tapN c ...")
+ *       but we do not have code to do that inside OpenVPN
  */
 
 void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, tt);
+    /* on NetBSD, tap (but not tun) devices are opened by
+     * opening /dev/tap and then querying the system about the
+     * actual device name (tap0, tap1, ...) assigned
+     */
+    if (strcmp(dev, "tap") == 0)
+    {
+        struct ifreq ifr;
+        if ((tt->fd = open( "/dev/tap", O_RDWR)) < 0)
+        {
+            msg(M_FATAL, "Cannot allocate NetBSD TAP dev dynamically");
+        }
+        if (ioctl( tt->fd, TAPGIFNAME, (void *)&ifr ) < 0)
+        {
+            msg(M_FATAL, "Cannot query NetBSD TAP device name");
+        }
+        set_nonblock(tt->fd);
+        set_cloexec(tt->fd); /* don't pass fd to scripts */
+        msg(M_INFO, "TUN/TAP device %s opened", ifr.ifr_name);
+
+        tt->actual_name = string_alloc(ifr.ifr_name, NULL);
+    }
+    else
+    {
+        /* dynamic / named tun can be handled by the generic function
+         * named tap ("tap3") is handled there as well, if pre-created
+         */
+        open_tun_generic(dev, dev_type, dev_node, tt);
+    }
 
     if (tt->fd >= 0)
     {
-- 
2.30.2


