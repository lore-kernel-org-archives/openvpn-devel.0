From: Gert Doering <gert@...1296...>
Date: Sun, 26 Apr 2015 20:03:58 +0200
Message-Id: <1430071438-31675-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix FreeBSD ifconfig for topology subnet
	tunnels.
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

For "topology subnet", we only pretend to have a subnet and keep
using the tun if in point-to-point mode - but for that to fully
work, the "remote" address needs to be different from the "local"
address.  So just arbitrarily construct one from the on-link
subnet - base+1, if "that is not us", base+2, otherwise.

Fix trac #481

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 11a6d71..aa7a9f0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -626,6 +626,28 @@ void delete_route_connected_v6_net(struct tuntap * tt,
 }
 #endif
 
+#if defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
+/* we can't use true subnet mode on tun on all platforms, as that
+ * conflicts with IPv6 (wants to use ND then, which we don't do),
+ * but the OSes want "a remote address that is different from ours"
+ * - so we construct one, normally the first in the subnet, but if
+ * this is the same as ours, use the second one.
+ * The actual address does not matter at all, as the tun interface
+ * is still point to point and no layer 2 resolution is done...
+ */
+
+char *
+create_arbitrary_remote( struct tuntap *tt, struct gc_arena * gc )
+{
+  in_addr_t remote;
+
+  remote = (tt->local & tt->remote_netmask) +1;
+
+  if ( remote == tt->local ) remote ++;
+
+  return print_in_addr_t (remote, 0, &gc);
+}
+#endif
 
 /* execute the ifconfig command through the shell */
 void
@@ -1150,7 +1172,7 @@ do_ifconfig (struct tuntap *tt,
 			  IFCONFIG_PATH,
 			  actual,
 			  ifconfig_local,
-			  ifconfig_local,
+			  create_arbitrary_remote( tt, &gc ),
 			  tun_mtu,
 			  ifconfig_remote_netmask
 			  );
-- 
2.2.2


