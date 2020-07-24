From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 24 Jul 2020 14:26:31 +0300
Message-Id: <20200724112631.195-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Remove unused no-op function
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Body of check_subnet_conflict() was commented out
(#if 0) back in 2011, so it is safe now to completely
elimitate this function, including all calls to it.

As a bonus, remove unused local variable in do_set_mtu_service().

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/route.c |  1 -
 src/openvpn/tun.c   | 48 ---------------------------------------------
 src/openvpn/tun.h   |  4 ----
 3 files changed, 53 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index b57da5dd..966f6297 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1215,7 +1215,6 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
 
         for (r = rl->routes; r; r = r->next)
         {
-            check_subnet_conflict(r->network, r->netmask, "route");
             if (flags & ROUTE_DELETE_FIRST)
             {
                 delete_route(r, tt, flags, &rl->rgi, es, ctx);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 82d96927..8a132b4d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -221,7 +221,6 @@ out:
 static bool
 do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
 {
-    DWORD len;
     bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
@@ -466,44 +465,6 @@ check_addr_clash(const char *name,
     gc_free(&gc);
 }
 
-/*
- * Issue a warning if ip/netmask (on the virtual IP network) conflicts with
- * the settings on the local LAN.  This is designed to flag issues where
- * (for example) the OpenVPN server LAN is running on 192.168.1.x, but then
- * an OpenVPN client tries to connect from a public location that is also running
- * off of a router set to 192.168.1.x.
- */
-void
-check_subnet_conflict(const in_addr_t ip,
-                      const in_addr_t netmask,
-                      const char *prefix)
-{
-#if 0 /* too many false positives */
-    struct gc_arena gc = gc_new();
-    in_addr_t lan_gw = 0;
-    in_addr_t lan_netmask = 0;
-
-    if (get_default_gateway(&lan_gw, &lan_netmask) && lan_netmask)
-    {
-        const in_addr_t lan_network = lan_gw & lan_netmask;
-        const in_addr_t network = ip & netmask;
-
-        /* do the two subnets defined by network/netmask and lan_network/lan_netmask intersect? */
-        if ((network & lan_netmask) == lan_network
-            || (lan_network & netmask) == network)
-        {
-            msg(M_WARN, "WARNING: potential %s subnet conflict between local LAN [%s/%s] and remote VPN [%s/%s]",
-                prefix,
-                print_in_addr_t(lan_network, 0, &gc),
-                print_in_addr_t(lan_netmask, 0, &gc),
-                print_in_addr_t(network, 0, &gc),
-                print_in_addr_t(netmask, 0, &gc));
-        }
-    }
-    gc_free(&gc);
-#endif /* if 0 */
-}
-
 void
 warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)
 {
@@ -763,15 +724,6 @@ init_tun(const char *dev,        /* --dev option */
                                      tt->remote_netmask);
                 }
             }
-
-            if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
-            {
-                check_subnet_conflict(tt->local, tt->remote_netmask, "TUN/TAP adapter");
-            }
-            else if (tt->type == DEV_TYPE_TUN)
-            {
-                check_subnet_conflict(tt->local, IPV4_NETMASK_HOST, "TUN/TAP adapter");
-            }
         }
 
 #ifdef _WIN32
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 99826cf7..e73be206 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -309,10 +309,6 @@ const char *ifconfig_options_string(const struct tuntap *tt, bool remote, bool d
 
 bool is_tun_p2p(const struct tuntap *tt);
 
-void check_subnet_conflict(const in_addr_t ip,
-                           const in_addr_t netmask,
-                           const char *prefix);
-
 void warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx);
 
 /*
-- 
2.17.1


