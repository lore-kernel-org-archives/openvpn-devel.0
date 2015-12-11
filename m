From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 11 Dec 2015 23:55:53 +0200
Message-Id: <1449870953-14049-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master] Use adapter index for
	add/delete_route_ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Trac #637

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/route.c | 16 ++++++++++++----
 src/openvpn/tun.c   |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 4a60345..2012b5c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1770,13 +1770,17 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 
 #elif defined (WIN32)
 
+  struct buffer out = alloc_buf_gc (64, &gc);
   if ( r6->adapter_index )		/* vpn server special route */
     {
-      struct buffer out = alloc_buf_gc (64, &gc);
       buf_printf (&out, "interface=%d", r6->adapter_index );
-      device = buf_bptr(&out);
       gateway_needed = true;
     }
+  else
+    {
+      buf_printf (&out, "interface=%d", tt->adapter_index );
+    }
+  device = buf_bptr(&out);
 
   /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
   argv_printf (&argv, "%s%sc interface ipv6 add route %s/%d %s",
@@ -2168,13 +2172,17 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 
 #elif defined (WIN32)
 
+  struct buffer out = alloc_buf_gc (64, &gc);
   if ( r6->adapter_index )		/* vpn server special route */
     {
-      struct buffer out = alloc_buf_gc (64, &gc);
       buf_printf (&out, "interface=%d", r6->adapter_index );
-      device = buf_bptr(&out);
       gateway_needed = true;
     }
+  else
+    {
+      buf_printf (&out, "interface=%d", tt->adapter_index );
+    }
+  device = buf_bptr(&out);
 
   /* netsh interface ipv6 delete route 2001:db8::/32 MyTunDevice */
   argv_printf (&argv, "%s%sc interface ipv6 delete route %s/%d %s",
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 014d988..aed5e75 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1328,6 +1328,8 @@ do_ifconfig (struct tuntap *tt,
 	 */
 	saved_actual = tt->actual_name;
 	tt->actual_name = (char*) actual;
+	/* we use adapter_index in add_route_ipv6 */
+	tt->adapter_index = idx;
 	add_route_connected_v6_net(tt, es);
 	tt->actual_name = saved_actual;
       }
-- 
1.9.1


