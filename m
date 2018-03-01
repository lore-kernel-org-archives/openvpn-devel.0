MIME-Version: 1.0
In-Reply-To: <CAKuzo_hThVb9Gozz_T0sn0iZoyfNNzR5JnLEtxSrP8x2xTDy0A@...278...>
References: <1480022363-24222-1-git-send-email-selva.nair@...277...>
 <1480051264-30193-1-git-send-email-selva.nair@...277...>
 <CAKuzo_hThVb9Gozz_T0sn0iZoyfNNzR5JnLEtxSrP8x2xTDy0A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 1 Mar 2018 11:09:32 -0500
Message-ID: <CAKuzo_gBWiY==v8bjuaOgq8F2R=gq0a5RNN28VvXphj1p2e2vA@...278...>
Subject: [Openvpn-devel] Fwd: [PATCH] Delete the IPv6 route to the
 "connected" network on tun close
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This one is too old to cleanly apply, but still sending again
just to get it into patchwork.
(For some reason bouncing to patchwork somehow never works for me, else
this could have beaten the oldest pending patch record :)

---------- Forwarded message ----------
From: Selva Nair <selva.nair@...277...>
Date: Thu, Nov 24, 2016 at 4:19 PM
Subject: [PATCH] Delete the IPv6 route to the "connected" network on tun close
To: openvpn-devel@lists.sourceforge.net
Cc: Selva Nair <selva.nair@...277...>


This was missing on Windows when interactive service is in use.

- Added route_ipv6_clear_host_bits(r6) to delete_route_ipv6: this is
  required for Windows IP-helper API. Won't hurt other platforms (?)

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/route.c | 2 ++
 src/openvpn/tun.c   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index fec12c1..85f969e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2124,6 +2124,8 @@ delete_route_ipv6 (const struct route_ipv6 *r6,
const struct tuntap *tt, unsigne

   gc_init (&gc);

+  route_ipv6_clear_host_bits (r6);
+
   network = print_in6_addr( r6->network, 0, &gc);
   gateway = print_in6_addr( r6->gateway, 0, &gc);

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

