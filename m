Message-Id: <200406170711.i5H7B0Kh040368@...242...>
From: Pavlin Radoslavov <pavlin@...241...>
Subject: [Openvpn-devel] Enabling multicast on OpenBSD tun interface
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Jun 17 08:03:04 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: pavlin@...241...

Hi!

[OS: OpenBSD-3.5]
[openvpn: 2.0_beta5, 1.5]

It appears that openvpn doesn't enable the multicast flag for the
tun interface on OpenBSD (on FreeBSD for example, the flag is always
set). E.g., if I use:

openvpn --local <...> --remote <...> --ifconfig <...> <...> --dev tun0

Then the interface doesn't have the MULTICAST flag set:

tun0: flags=51<UP,POINTOPOINT,RUNNING> mtu 1500
        inet ...

I believe the following simple patch (against 2.0_beta5) fixes the
problem.

Thanks,
Pavlin

--- tun.c.org	Sun Jun 13 00:34:28 2004
+++ tun.c	Tue Jun 15 23:24:58 2004
@@ -1274,6 +1274,24 @@
 open_tun (const char *dev, const char *dev_type, const char *dev_node, bool ipv6, struct tuntap *tt)
 {
   open_tun_generic (dev, dev_type, dev_node, ipv6, true, true, tt);
+
+  /* Enable multicast on the interface */
+  if (tt->fd >= 0)
+    {
+      struct tuninfo info;
+
+      if (ioctl (tt->fd, TUNGIFINFO, &info) < 0) {
+	msg (M_WARN | M_ERRNO, "Can't get interface info: %s",
+	  strerror(errno));
+      }
+
+      info.flags |= IFF_MULTICAST;
+
+      if (ioctl (tt->fd, TUNSIFINFO, &info) < 0) {
+	msg (M_WARN | M_ERRNO, "Can't set interface info: %s",
+	  strerror(errno));
+      }
+    }
 }
 
 void

