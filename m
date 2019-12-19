From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 19 Dec 2019 13:18:21 +0200
Message-Id: <20191219111821.313-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tun.c: do not add/remove routes on tun
 open/close
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

Commit 1c4a47f added route manipulation to open/close tun functions,
which is not really needed:

 - routes are added in check_add_routes(), triggered by timer

 - routes are removed in delete_routes(), called by do_close_tun()

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/route.c |  2 +-
 src/openvpn/route.h |  3 ---
 src/openvpn/tun.c   | 17 -----------------
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index cc6d5519..97e90e56 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3019,7 +3019,7 @@ out:
     return ret;
 }
 
-bool
+static bool
 do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct tuntap *tt)
 {
     DWORD if_index = windows_route_find_if_index(r, tt);
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 27b652cd..7dd96091 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -321,9 +321,6 @@ void setenv_routes(struct env_set *es, const struct route_list *rl);
 
 void setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6);
 
-bool do_route_ipv4_service(const bool add, const struct route_ipv4 *r,
-                           const struct tuntap *tt);
-
 bool is_special_addr(const char *addr_str);
 
 void get_default_gateway(struct route_gateway_info *rgi,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8d87ac41..ad497a71 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -860,21 +860,6 @@ delete_route_connected_v6_net(struct tuntap *tt,
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) */
 
-#if defined(_WIN32)
-void
-do_route_ipv4_service_tun(bool add, const struct tuntap *tt)
-{
-    struct route_ipv4 r4;
-    CLEAR(r4);
-    r4.network = tt->local & tt->remote_netmask;
-    r4.netmask = tt->remote_netmask;
-    r4.gateway = tt->local;
-    r4.metric = 0;                     /* connected route */
-    r4.flags = RT_DEFINED | RT_METRIC_DEFINED;
-    do_route_ipv4_service(add, &r4, tt);
-}
-#endif
-
 #if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)  \
     || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
 /* we can't use true subnet mode on tun on all platforms, as that
@@ -1406,7 +1391,6 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         if (tt->options.msg_channel && tt->wintun)
         {
             do_address_service(true, AF_INET, tt);
-            do_route_ipv4_service_tun(true, tt);
             do_dns_service(true, AF_INET, tt);
         }
         else
@@ -6489,7 +6473,6 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
     {
         if (tt->options.msg_channel)
         {
-            do_route_ipv4_service_tun(false, tt);
             do_address_service(false, AF_INET, tt);
             do_dns_service(false, AF_INET, tt);
         }
-- 
2.17.1


