From: Gert Doering <gert@...1296...>
Date: Mon, 14 Sep 2020 09:08:43 +0200
Message-Id: <20200914070843.51678-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix combination of --dev tap and --topology
 subnet across multiple platforms.
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

--topology should have no effect in tap mode (tap is always "subnet"),
but due to the way options are checked, setting "topology subnet" caught
an improper branch on all non-linux and non-win32 platforms.

Easily tested by adding "--topology subnet" to a "--dev tap" t_client
test.

Tested, verified, and fixed on FreeBSD 13.3, NetBSD 8.1, OpenBSD 6.5,
OpenIndiana 2019 (Solaris) and MacOS X Mojave.

This is a forward-port of commit 6c13e24e5709 - the original intent
for "master" was to restructure tun.c in a larger way and clean up
these if() blocks more nicely... which has not happened yet, so this
patch is basically applying exactly the same changes to context that
has changed too much for git to be able to do this automatically.

Trac: #1085

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 651cb871..fde94294 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1224,7 +1224,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         argv_printf(&argv, "%s %s netmask 255.255.255.255", IFCONFIG_PATH,
                     ifname);
     }
-    else if (tt->topology == TOP_SUBNET)
+    else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
     {
         argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
                     ifname, ifconfig_local, ifconfig_local,
@@ -1243,7 +1243,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         solaris_error_close(tt, es, ifname, false);
     }
 
-    if (!tun && tt->topology == TOP_SUBNET)
+    if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
     {
         /* Add a network route for the local tun interface */
         struct route_ipv4 r;
@@ -1274,7 +1274,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else if (tt->topology == TOP_SUBNET)
+    else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
     {
         remote_end = create_arbitrary_remote( tt );
         argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up -link0",
@@ -1292,7 +1292,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig failed");
 
     /* Add a network route for the local tun interface */
-    if (!tun && tt->topology == TOP_SUBNET)
+    if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1312,7 +1312,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else if (tt->topology == TOP_SUBNET)
+    else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
     {
         remote_end = create_arbitrary_remote(tt);
         argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up", IFCONFIG_PATH,
@@ -1334,7 +1334,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
 
     /* Add a network route for the local tun interface */
-    if (!tun && tt->topology == TOP_SUBNET)
+    if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1366,7 +1366,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     }
     else
     {
-        if (tt->topology == TOP_SUBNET)
+        if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up",
                         IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_local,
@@ -1384,7 +1384,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     openvpn_execve_check(&argv, es, S_FATAL, "Mac OS X ifconfig failed");
 
     /* Add a network route for the local tun interface */
-    if (!tun && tt->topology == TOP_SUBNET)
+    if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
     {
         struct route_ipv4 r;
         CLEAR(r);
@@ -1406,7 +1406,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask, tun_mtu);
     }
-    else if (tt->topology == TOP_SUBNET)
+    else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
     {
         remote_end = create_arbitrary_remote( tt );
         argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up", IFCONFIG_PATH,
@@ -1423,7 +1423,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig failed");
 
     /* Add a network route for the local tun interface */
-    if (!tun && tt->topology == TOP_SUBNET)
+    if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
     {
         struct route_ipv4 r;
         CLEAR(r);
-- 
2.28.0


