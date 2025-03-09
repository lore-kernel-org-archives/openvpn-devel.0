From: Gert Doering <gert@...1296...>
Date: Sun,  9 Mar 2025 17:55:00 +0100
Message-ID: <20250309165500.21796-1-gert@...1296...>
In-Reply-To: <gerrit.1736860439000.If570253e57371e4126b0e8aa4c349e2051cb8b00@...2715...>
References: <gerrit.1736860439000.If570253e57371e4126b0e8aa4c349e2051cb8b00@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Remove unused function
 check_subnet_conflict
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

From: Frank Lichtenheld <frank@...2641...>

This has been #if 0 for over a decade. Let's just
remove this.

Change-Id: If570253e57371e4126b0e8aa4c349e2051cb8b00
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/863
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 245b15b..dbdc01d 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1218,7 +1218,6 @@
 
         for (r = rl->routes; r; r = r->next)
         {
-            check_subnet_conflict(r->network, r->netmask, "route");
             if (flags & ROUTE_DELETE_FIRST)
             {
                 delete_route(r, tt, flags, &rl->rgi, es, ctx);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4817f45..de54e89 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -626,44 +626,6 @@
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
@@ -922,15 +884,6 @@
                                      tt->remote_netmask);
                 }
             }
-
-            if (!tun_p2p)
-            {
-                check_subnet_conflict(tt->local, tt->remote_netmask, "TUN/TAP adapter");
-            }
-            else
-            {
-                check_subnet_conflict(tt->local, IPV4_NETMASK_HOST, "TUN/TAP adapter");
-            }
         }
 
 #ifdef _WIN32
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ccba0bc..b616f5d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -355,10 +355,6 @@
 
 bool is_tun_p2p(const struct tuntap *tt);
 
-void check_subnet_conflict(const in_addr_t ip,
-                           const in_addr_t netmask,
-                           const char *prefix);
-
 void warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx);
 
 /**

