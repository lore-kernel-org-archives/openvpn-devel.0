From: Gert Doering <gert@...1296...>
Date: Tue, 20 Feb 2018 17:00:16 +0100
Message-Id: <20180220160016.69786-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix removal of on-link prefix on windows
 with netsh
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
Cc: gert@...2377...

When adding / removing IPv6 routes, the host bits need to be zeroed or
netsh.exe will refuse to handle the route.

Commit a24dd2e31 changed the way this is done, breaking removal of
the on-link IPv6 prefix for windows + netsh.exe.

Fix by adding explicitly calling route_ipv6_clear_host_bits() from
delete_route_connected_v6_net().

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 2 +-
 src/openvpn/route.h | 2 ++
 src/openvpn/tun.c   | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ca8b182b..27b39c41 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1820,7 +1820,7 @@ done:
 }
 
 
-static void
+void
 route_ipv6_clear_host_bits( struct route_ipv6 *r6 )
 {
     /* clear host bit parts of route
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 2c6f9f16..69420228 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -254,6 +254,8 @@ void copy_route_ipv6_option_list(struct route_ipv6_option_list *dest,
                                  const struct route_ipv6_option_list *src,
                                  struct gc_arena *a);
 
+void route_ipv6_clear_host_bits( struct route_ipv6 *r6 );
+
 void add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
 
 void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 253d884b..1399aa83 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -839,6 +839,7 @@ delete_route_connected_v6_net(struct tuntap *tt,
     r6.gateway = tt->local_ipv6;
     r6.metric  = 0;                     /* connected route */
     r6.flags   = RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
+    route_ipv6_clear_host_bits(&r6);
     delete_route_ipv6(&r6, tt, 0, es);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) */
-- 
2.16.1


