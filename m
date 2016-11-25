From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Nov 2016 00:21:04 -0500
Message-Id: <1480051264-30193-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1480022363-24222-1-git-send-email-selva.nair@...277...>
References: <1480022363-24222-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Delete the IPv6 route to the "connected"
	network on tun close
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

This was missing on Windows when interactive service is in use.

- Added route_ipv6_clear_host_bits(r6) to delete_route_ipv6: this is
  required for Windows IP-helper API. Won't hurt other platforms (?)

v2: Be const correct: route in delete_route_ipv6() made non-const.
None of the exisitng calls are affected.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/route.c | 4 +++-
 src/openvpn/route.h | 2 +-
 src/openvpn/tun.c   | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index fec12c1..34b1196 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2102,7 +2102,7 @@ delete_route (struct route_ipv4 *r,
 }
 
 void
-delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+delete_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
 {
   struct gc_arena gc;
   struct argv argv = argv_new ();
@@ -2124,6 +2124,8 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 
   gc_init (&gc);
 
+  route_ipv6_clear_host_bits (r6);
+
   network = print_in6_addr( r6->network, 0, &gc);
   gateway = print_in6_addr( r6->gateway, 0, &gc);
 
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index c358681..70aeb65 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -252,7 +252,7 @@ void copy_route_ipv6_option_list (struct route_ipv6_option_list *dest,
                                   struct gc_arena *a);
 
 void add_route_ipv6 (struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
-void delete_route_ipv6 (const struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
+void delete_route_ipv6 (struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
 
 void add_route (struct route_ipv4 *r,
 		const struct tuntap *tt,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 560b1a8..40ce202 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5663,6 +5663,9 @@ close_tun (struct tuntap *tt)
         {
           if (tt->options.msg_channel)
             {
+              /* remove route pointing to interface */
+              delete_route_connected_v6_net(tt, NULL);
+
               do_address_service (false, AF_INET6, tt);
 	      if (tt->options.dns6_len > 0)
 		  do_dns6_service (false, tt);
-- 
2.1.4


