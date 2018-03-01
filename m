From: selva.nair@...277...
Date: Thu,  1 Mar 2018 15:34:44 -0500
Message-Id: <1519936484-26102-1-git-send-email-selva.nair@...277...>
In-Reply-To: <CAKuzo_gBWiY==v8bjuaOgq8F2R=gq0a5RNN28VvXphj1p2e2vA@...278...>
References: <CAKuzo_gBWiY==v8bjuaOgq8F2R=gq0a5RNN28VvXphj1p2e2vA@...278...>
Subject: [Openvpn-devel] [PATCH v3] Delete the IPv6 route to the "connected"
 network on tun close
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

From: Selva Nair <selva.nair@...277...>

This was missing on Windows when interactive service is in use.

v3: Mar 1, 2017: avoid code repetition and rebase to master

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/tun.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9f3b98d..263cacd 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6185,6 +6185,9 @@ close_tun(struct tuntap *tt)
     {
         if (tt->did_ifconfig_ipv6_setup)
         {
+            /* remove route pointing to interface */
+            delete_route_connected_v6_net(tt, NULL);
+
             if (tt->options.msg_channel)
             {
                 do_address_service(false, AF_INET6, tt);
@@ -6198,9 +6201,6 @@ close_tun(struct tuntap *tt)
                 const char *ifconfig_ipv6_local;
                 struct argv argv = argv_new();
 
-                /* remove route pointing to interface */
-                delete_route_connected_v6_net(tt, NULL);
-
                 /* "store=active" is needed in Windows 8(.1) to delete the
                  * address we added (pointed out by Cedric Tabary).
                  */
-- 
2.6.2


