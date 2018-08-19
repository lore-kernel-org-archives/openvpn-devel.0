From: Gert Doering <gert@...1296...>
Date: Sun, 19 Aug 2018 22:07:03 +0200
Message-Id: <20180819200703.20362-1-gert@...1296...>
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

Tested, verified, and fixed on FreeBSD 10.4, NetBSD 7.0.1, OpenBSD 6.0,
and OpenSolaris 10.  Compile-tested on MacOS X.

Trac: #1085

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index db7c25ff..8fa07afa 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1091,7 +1091,7 @@ do_ifconfig(struct tuntap *tt,
                         actual
                         );
         }
-        else if (tt->topology == TOP_SUBNET)
+        else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             argv_printf(&argv,
                         "%s %s %s %s netmask %s mtu %d up",
@@ -1173,7 +1173,7 @@ do_ifconfig(struct tuntap *tt,
             }
         }
 
-        if (!tun && tt->topology == TOP_SUBNET)
+        if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             /* Add a network route for the local tun interface */
             struct route_ipv4 r;
@@ -1210,7 +1210,7 @@ do_ifconfig(struct tuntap *tt,
                         tun_mtu
                         );
         }
-        else if (tt->topology == TOP_SUBNET)
+        else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             remote_end = create_arbitrary_remote( tt );
             argv_printf(&argv,
@@ -1239,7 +1239,7 @@ do_ifconfig(struct tuntap *tt,
         openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig failed");
 
         /* Add a network route for the local tun interface */
-        if (!tun && tt->topology == TOP_SUBNET)
+        if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             struct route_ipv4 r;
             CLEAR(r);
@@ -1282,7 +1282,7 @@ do_ifconfig(struct tuntap *tt,
                         tun_mtu
                         );
         }
-        else if (tt->topology == TOP_SUBNET)
+        else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             remote_end = create_arbitrary_remote( tt );
             argv_printf(&argv,
@@ -1316,7 +1316,7 @@ do_ifconfig(struct tuntap *tt,
         openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
 
         /* Add a network route for the local tun interface */
-        if (!tun && tt->topology == TOP_SUBNET)
+        if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             struct route_ipv4 r;
             CLEAR(r);
@@ -1372,7 +1372,7 @@ do_ifconfig(struct tuntap *tt,
         }
         else
         {
-            if (tt->topology == TOP_SUBNET)
+            if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
             {
                 argv_printf(&argv,
                             "%s %s %s %s netmask %s mtu %d up",
@@ -1402,7 +1402,7 @@ do_ifconfig(struct tuntap *tt,
         tt->did_ifconfig = true;
 
         /* Add a network route for the local tun interface */
-        if (!tun && tt->topology == TOP_SUBNET)
+        if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             struct route_ipv4 r;
             CLEAR(r);
@@ -1445,7 +1445,7 @@ do_ifconfig(struct tuntap *tt,
                         tun_mtu
                         );
         }
-        else if (tt->topology == TOP_SUBNET)
+        else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             remote_end = create_arbitrary_remote( tt );
             argv_printf(&argv,
@@ -1475,7 +1475,7 @@ do_ifconfig(struct tuntap *tt,
         tt->did_ifconfig = true;
 
         /* Add a network route for the local tun interface */
-        if (!tun && tt->topology == TOP_SUBNET)
+        if (!tun && tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
         {
             struct route_ipv4 r;
             CLEAR(r);
-- 
2.18.0


