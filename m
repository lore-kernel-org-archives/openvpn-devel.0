From: Antonio Quartulli <a@...2181...>
Date: Fri,  8 Sep 2017 10:01:04 +0800
Message-Id: <20170908020104.11435-1-a@...2181...>
In-Reply-To: <ccf26af7-4ce7-7f45-349b-2f6945fa643e@...2181...>
References: <ccf26af7-4ce7-7f45-349b-2f6945fa643e@...2181...>
Subject: [Openvpn-devel] [PATCH v2] route: cleanup codestyle and make code
 more readable
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
Cc: David Sommerseth <openvpn@...2080...>, Antonio Quartulli <a@...2181...>

This patch does not introduce any functional change.

The code in route.c seems to have been written in different
periods by different people, without sticking to a clear
codestyle. For this reason the code in this file in not
consistent at all.

Clean it up by:
- removing spaces from function invocations
- cutting line longer than 80 chars (where possible)
- moving function arguments on the same line when there is enough space
- adding empty line between var declarations and code
- adding empty line between code and final return
- adding empty line to make the code less sticky and easier to parse

Signed-off-by: Antonio Quartulli <a@...2181...>
---

v2:
- rebased on top of master;
- checked with uncrustify and fixes applied;
- there are some little discrepancies with what uncrustify wants me to do
  but I think it is wrong.



 src/openvpn/route.c | 1583 +++++++++++++++++++++++++--------------------------
 1 file changed, 786 insertions(+), 797 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8c71e6ec..310e510b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -56,15 +56,21 @@ static bool add_route_service(const struct route_ipv4 *, const struct tuntap *);
 
 static bool del_route_service(const struct route_ipv4 *, const struct tuntap *);
 
-static bool add_route_ipv6_service(const struct route_ipv6 *, const struct tuntap *);
+static bool add_route_ipv6_service(const struct route_ipv6 *,
+                                   const struct tuntap *);
 
-static bool del_route_ipv6_service(const struct route_ipv6 *, const struct tuntap *);
+static bool del_route_ipv6_service(const struct route_ipv6 *,
+                                   const struct tuntap *);
 
 #endif
 
-static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags, const struct route_gateway_info *rgi, const struct env_set *es);
+static void delete_route(struct route_ipv4 *r, const struct tuntap *tt,
+                         unsigned int flags,
+                         const struct route_gateway_info *rgi,
+                         const struct env_set *es);
 
-static void get_bypass_addresses(struct route_bypass *rb, const unsigned int flags);
+static void get_bypass_addresses(struct route_bypass *rb,
+                                 const unsigned int flags);
 
 #ifdef ENABLE_DEBUG
 
@@ -110,8 +116,10 @@ struct route_option_list *
 new_route_option_list(struct gc_arena *a)
 {
     struct route_option_list *ret;
+
     ALLOC_OBJ_CLEAR_GC(ret, struct route_option_list, a);
     ret->gc = a;
+
     return ret;
 }
 
@@ -119,8 +127,10 @@ struct route_ipv6_option_list *
 new_route_ipv6_option_list(struct gc_arena *a)
 {
     struct route_ipv6_option_list *ret;
+
     ALLOC_OBJ_CLEAR_GC(ret, struct route_ipv6_option_list, a);
     ret->gc = a;
+
     return ret;
 }
 
@@ -135,22 +145,28 @@ struct route_option_list *
 clone_route_option_list(const struct route_option_list *src, struct gc_arena *a)
 {
     struct route_option_list *ret;
+
     ALLOC_OBJ_GC(ret, struct route_option_list, a);
     *ret = *src;
+
     return ret;
 }
 
 struct route_ipv6_option_list *
-clone_route_ipv6_option_list(const struct route_ipv6_option_list *src, struct gc_arena *a)
+clone_route_ipv6_option_list(const struct route_ipv6_option_list *src,
+                             struct gc_arena *a)
 {
     struct route_ipv6_option_list *ret;
+
     ALLOC_OBJ_GC(ret, struct route_ipv6_option_list, a);
     *ret = *src;
+
     return ret;
 }
 
 void
-copy_route_option_list(struct route_option_list *dest, const struct route_option_list *src, struct gc_arena *a)
+copy_route_option_list(struct route_option_list *dest,
+                       const struct route_option_list *src, struct gc_arena *a)
 {
     *dest = *src;
     dest->gc = a;
@@ -169,15 +185,16 @@ static const char *
 route_string(const struct route_ipv4 *r, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(256, gc);
+
     buf_printf(&out, "ROUTE network %s netmask %s gateway %s",
                print_in_addr_t(r->network, 0, gc),
                print_in_addr_t(r->netmask, 0, gc),
-               print_in_addr_t(r->gateway, 0, gc)
-               );
+               print_in_addr_t(r->gateway, 0, gc));
     if (r->flags & RT_METRIC_DEFINED)
     {
         buf_printf(&out, " metric %d", r->metric);
     }
+
     return BSTR(&out);
 }
 
@@ -188,18 +205,22 @@ is_route_parm_defined(const char *parm)
     {
         return false;
     }
+
     if (!strcmp(parm, "default"))
     {
         return false;
     }
+
     return true;
 }
 
 static void
-setenv_route_addr(struct env_set *es, const char *key, const in_addr_t addr, int i)
+setenv_route_addr(struct env_set *es, const char *key, const in_addr_t addr,
+                  int i)
 {
     struct gc_arena gc = gc_new();
     struct buffer name = alloc_buf_gc(256, &gc);
+
     if (i >= 0)
     {
         buf_printf(&name, "route_%s_%d", key, i);
@@ -208,6 +229,7 @@ setenv_route_addr(struct env_set *es, const char *key, const in_addr_t addr, int
     {
         buf_printf(&name, "route_%s", key);
     }
+
     setenv_str(es, BSTR(&name), print_in_addr_t(addr, 0, &gc));
     gc_free(&gc);
 }
@@ -222,6 +244,7 @@ get_special_addr(const struct route_list *rl,
     {
         *status = true;
     }
+
     if (!strcmp(string, "vpn_gateway"))
     {
         if (rl)
@@ -279,6 +302,7 @@ get_special_addr(const struct route_list *rl,
         }
         return true;
     }
+
     return false;
 }
 
@@ -296,10 +320,8 @@ is_special_addr(const char *addr_str)
 }
 
 static bool
-init_route(struct route_ipv4 *r,
-           struct addrinfo **network_list,
-           const struct route_option *ro,
-           const struct route_list *rl)
+init_route(struct route_ipv4 *r, struct addrinfo **network_list,
+           const struct route_option *ro, const struct route_list *rl)
 {
     const in_addr_t default_netmask = IPV4_NETMASK_HOST;
     bool status;
@@ -320,7 +342,8 @@ init_route(struct route_ipv4 *r,
     /* get_special_addr replaces specialaddr with a special ip addr
      * like gw. getaddrinfo is called to convert a a addrinfo struct */
 
-    if (get_special_addr(rl, ro->network, (in_addr_t *) &special.s_addr, &status))
+    if (get_special_addr(rl, ro->network, (in_addr_t *) &special.s_addr,
+                         &status))
     {
         special.s_addr = htonl(special.s_addr);
         ret = openvpn_getaddrinfo(0, inet_ntoa(special), NULL, 0, NULL,
@@ -329,7 +352,8 @@ init_route(struct route_ipv4 *r,
     else
     {
         ret = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL,
-                                  ro->network, NULL, 0, NULL, AF_INET, network_list);
+                                  ro->network, NULL, 0, NULL, AF_INET,
+                                  network_list);
     }
 
     status = (ret == 0);
@@ -343,13 +367,8 @@ init_route(struct route_ipv4 *r,
 
     if (is_route_parm_defined(ro->netmask))
     {
-        r->netmask = getaddr(
-            GETADDR_HOST_ORDER
-            | GETADDR_WARN_ON_SIGNAL,
-            ro->netmask,
-            0,
-            &status,
-            NULL);
+        r->netmask = getaddr(GETADDR_HOST_ORDER | GETADDR_WARN_ON_SIGNAL,
+                             ro->netmask, 0, &status, NULL);
         if (!status)
         {
             goto fail;
@@ -366,14 +385,9 @@ init_route(struct route_ipv4 *r,
     {
         if (!get_special_addr(rl, ro->gateway, &r->gateway, &status))
         {
-            r->gateway = getaddr(
-                GETADDR_RESOLVE
-                | GETADDR_HOST_ORDER
-                | GETADDR_WARN_ON_SIGNAL,
-                ro->gateway,
-                0,
-                &status,
-                NULL);
+            r->gateway = getaddr(GETADDR_RESOLVE | GETADDR_HOST_ORDER
+                                 | GETADDR_WARN_ON_SIGNAL, ro->gateway, 0,
+                                 &status, NULL);
         }
         if (!status)
         {
@@ -402,8 +416,7 @@ init_route(struct route_ipv4 *r,
         if (r->metric < 0)
         {
             msg(M_WARN, PACKAGE_NAME " ROUTE: route metric for network %s (%s) must be >= 0",
-                ro->network,
-                ro->metric);
+                ro->network, ro->metric);
             goto fail;
         }
         r->flags |= RT_METRIC_DEFINED;
@@ -421,17 +434,17 @@ init_route(struct route_ipv4 *r,
 fail:
     msg(M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve route for host/network: %s",
         ro->network);
+
     return false;
 }
 
 static bool
-init_route_ipv6(struct route_ipv6 *r6,
-                const struct route_ipv6_option *r6o,
-                const struct route_ipv6_list *rl6 )
+init_route_ipv6(struct route_ipv6 *r6, const struct route_ipv6_option *r6o,
+                const struct route_ipv6_list *rl6)
 {
     CLEAR(*r6);
 
-    if (!get_ipv6_addr( r6o->prefix, &r6->network, &r6->netbits, M_WARN ))
+    if (!get_ipv6_addr(r6o->prefix, &r6->network, &r6->netbits, M_WARN))
     {
         goto fail;
     }
@@ -439,9 +452,10 @@ init_route_ipv6(struct route_ipv6 *r6,
     /* gateway */
     if (is_route_parm_defined(r6o->gateway))
     {
-        if (inet_pton( AF_INET6, r6o->gateway, &r6->gateway ) != 1)
+        if (inet_pton(AF_INET6, r6o->gateway, &r6->gateway) != 1)
         {
-            msg( M_WARN, PACKAGE_NAME "ROUTE6: cannot parse gateway spec '%s'", r6o->gateway );
+            msg(M_WARN, PACKAGE_NAME "ROUTE6: cannot parse gateway spec '%s'",
+                r6o->gateway);
         }
     }
     else if (rl6->spec_flags & RTSA_REMOTE_ENDPOINT)
@@ -463,8 +477,7 @@ init_route_ipv6(struct route_ipv6 *r6,
         if (r6->metric < 0)
         {
             msg(M_WARN, PACKAGE_NAME " ROUTE: route metric for network %s (%s) must be >= 0",
-                r6o->prefix,
-                r6o->metric);
+                r6o->prefix, r6o->metric);
             goto fail;
         }
         r6->flags |= RT_METRIC_DEFINED;
@@ -486,30 +499,28 @@ fail:
 }
 
 void
-add_route_to_option_list(struct route_option_list *l,
-                         const char *network,
-                         const char *netmask,
-                         const char *gateway,
+add_route_to_option_list(struct route_option_list *l, const char *network,
+                         const char *netmask, const char *gateway,
                          const char *metric)
 {
     struct route_option *ro;
     ALLOC_OBJ_GC(ro, struct route_option, l->gc);
+
     ro->network = network;
     ro->netmask = netmask;
     ro->gateway = gateway;
     ro->metric = metric;
     ro->next = l->routes;
     l->routes = ro;
-
 }
 
 void
 add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
-                              const char *prefix,
-                              const char *gateway,
+                              const char *prefix, const char *gateway,
                               const char *metric)
 {
     struct route_ipv6_option *ro;
+
     ALLOC_OBJ_GC(ro, struct route_ipv6_option, l->gc);
     ro->prefix = prefix;
     ro->gateway = gateway;
@@ -533,8 +544,7 @@ clear_route_ipv6_list(struct route_ipv6_list *rl6)
 }
 
 void
-route_list_add_vpn_gateway(struct route_list *rl,
-                           struct env_set *es,
+route_list_add_vpn_gateway(struct route_list *rl, struct env_set *es,
                            const in_addr_t addr)
 {
     ASSERT(rl);
@@ -549,8 +559,9 @@ add_block_local_item(struct route_list *rl,
                      in_addr_t target)
 {
     const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
-    if ((rl->rgi.flags & rgi_needed) == rgi_needed
-        && rl->rgi.gateway.netmask < 0xFFFFFFFF)
+
+    if (((rl->rgi.flags & rgi_needed) == rgi_needed)
+        && (rl->rgi.gateway.netmask < 0xFFFFFFFF))
     {
         struct route_ipv4 *r1, *r2;
         unsigned int l2;
@@ -558,7 +569,8 @@ add_block_local_item(struct route_list *rl,
         ALLOC_OBJ_GC(r1, struct route_ipv4, &rl->gc);
         ALLOC_OBJ_GC(r2, struct route_ipv4, &rl->gc);
 
-        /* split a route into two smaller blocking routes, and direct them to target */
+        /* split a route into two smaller blocking routes, and direct them to
+         * target */
         l2 = ((~gateway->netmask)+1)>>1;
         r1->flags = RT_DEFINED;
         r1->gateway = target;
@@ -578,10 +590,11 @@ static void
 add_block_local(struct route_list *rl)
 {
     const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
+
     if ((rl->flags & RG_BLOCK_LOCAL)
-        && (rl->rgi.flags & rgi_needed) == rgi_needed
+        && ((rl->rgi.flags & rgi_needed) == rgi_needed)
         && (rl->spec.flags & RTSA_REMOTE_ENDPOINT)
-        && rl->spec.remote_host_local != TLA_LOCAL)
+        && (rl->spec.remote_host_local != TLA_LOCAL))
     {
         size_t i;
 
@@ -597,9 +610,11 @@ add_block_local(struct route_list *rl)
         for (i = 0; i < rl->rgi.n_addrs; ++i)
         {
             const struct route_gateway_address *gwa = &rl->rgi.addrs[i];
+            in_addr_t net1 = rl->rgi.gateway.addr & rl->rgi.gateway.netmask;
+            in_addr_t net2 = gwa->addr & gwa->netmask;
+
             /* omit the add/subnet in &rl->rgi which we processed above */
-            if (!((rl->rgi.gateway.addr & rl->rgi.gateway.netmask) == (gwa->addr & gwa->netmask)
-                  && rl->rgi.gateway.netmask == gwa->netmask))
+            if ((net1 != net2) || (rl->rgi.gateway.netmask != gwa->netmask))
             {
                 add_block_local_item(rl, gwa, rl->spec.remote_endpoint);
             }
@@ -608,12 +623,9 @@ add_block_local(struct route_list *rl)
 }
 
 bool
-init_route_list(struct route_list *rl,
-                const struct route_option_list *opt,
-                const char *remote_endpoint,
-                int default_metric,
-                in_addr_t remote_host,
-                struct env_set *es)
+init_route_list(struct route_list *rl, const struct route_option_list *opt,
+                const char *remote_endpoint, int default_metric,
+                in_addr_t remote_host, struct env_set *es)
 {
     struct gc_arena gc = gc_new();
     bool ret = true;
@@ -655,14 +667,10 @@ init_route_list(struct route_list *rl,
     if (is_route_parm_defined(remote_endpoint))
     {
         bool defined = false;
-        rl->spec.remote_endpoint = getaddr(
-            GETADDR_RESOLVE
-            | GETADDR_HOST_ORDER
-            | GETADDR_WARN_ON_SIGNAL,
-            remote_endpoint,
-            0,
-            &defined,
-            NULL);
+        rl->spec.remote_endpoint = getaddr(GETADDR_RESOLVE
+                                           | GETADDR_HOST_ORDER
+                                           | GETADDR_WARN_ON_SIGNAL,
+                                           remote_endpoint, 0, &defined, NULL);
 
         if (defined)
         {
@@ -703,10 +711,13 @@ init_route_list(struct route_list *rl,
                 struct addrinfo *curele;
                 for (curele = netlist; curele; curele = curele->ai_next)
                 {
+                    struct sockaddr_in *ai_addr;
                     struct route_ipv4 *new;
+
                     ALLOC_OBJ_GC(new, struct route_ipv4, &rl->gc);
                     *new = r;
-                    new->network = ntohl(((struct sockaddr_in *)curele->ai_addr)->sin_addr.s_addr);
+                    ai_addr = (struct sockaddr_in *)curele->ai_addr;
+                    new->network = ntohl(ai_addr->sin_addr.s_addr);
                     new->next = rl->routes;
                     rl->routes = new;
                 }
@@ -719,6 +730,7 @@ init_route_list(struct route_list *rl,
     }
 
     gc_free(&gc);
+
     return ret;
 }
 
@@ -727,14 +739,13 @@ init_route_list(struct route_list *rl,
  * "good enough")
  */
 static bool
-route_ipv6_match_host( const struct route_ipv6 *r6,
-                       const struct in6_addr *host )
+route_ipv6_match_host(const struct route_ipv6 *r6, const struct in6_addr *host)
 {
     unsigned int bits = r6->netbits;
     int i;
     unsigned int mask;
 
-    if (bits>128)
+    if (bits > 128)
     {
         return false;
     }
@@ -752,9 +763,9 @@ route_ipv6_match_host( const struct route_ipv6 *r6,
         return true;
     }
 
-    mask = 0xff << (8-bits);
+    mask = 0xff << (8 - bits);
 
-    if ( (r6->network.s6_addr[i] & mask) == (host->s6_addr[i] & mask ))
+    if ((r6->network.s6_addr[i] & mask) == (host->s6_addr[i] & mask))
     {
         return true;
     }
@@ -765,8 +776,7 @@ route_ipv6_match_host( const struct route_ipv6 *r6,
 bool
 init_route_ipv6_list(struct route_ipv6_list *rl6,
                      const struct route_ipv6_option_list *opt6,
-                     const char *remote_endpoint,
-                     int default_metric,
+                     const char *remote_endpoint, int default_metric,
                      const struct in6_addr *remote_host_ipv6,
                      struct env_set *es)
 {
@@ -791,12 +801,13 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
     }
 
     msg(D_ROUTE, "GDG6: remote_host_ipv6=%s",
-        remote_host_ipv6 ?  print_in6_addr(*remote_host_ipv6, 0, &gc) : "n/a" );
+        remote_host_ipv6 ?  print_in6_addr(*remote_host_ipv6, 0, &gc) : "n/a");
 
     get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6);
     if (rl6->rgi6.flags & RGI_ADDR_DEFINED)
     {
-        setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->rgi6.gateway.addr_ipv6, 0, &gc));
+        setenv_str(es, "net_gateway_ipv6",
+                   print_in6_addr(rl6->rgi6.gateway.addr_ipv6, 0, &gc));
 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
         print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
@@ -806,16 +817,17 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
         dmsg(D_ROUTE, "ROUTE6: default_gateway=UNDEF");
     }
 
-    if (is_route_parm_defined( remote_endpoint ))
+    if (is_route_parm_defined(remote_endpoint))
     {
-        if (inet_pton( AF_INET6, remote_endpoint,
-                       &rl6->remote_endpoint_ipv6) == 1)
+        if (inet_pton(AF_INET6, remote_endpoint,
+                      &rl6->remote_endpoint_ipv6) == 1)
         {
             rl6->spec_flags |= RTSA_REMOTE_ENDPOINT;
         }
         else
         {
-            msg(M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve VPN endpoint: %s", remote_endpoint);
+            msg(M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve VPN endpoint: %s",
+                remote_endpoint);
             ret = false;
         }
     }
@@ -825,51 +837,51 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
      */
     need_remote_ipv6_route = false;
 
+    struct route_ipv6_option *ro6;
+
+    for (ro6 = opt6->routes_ipv6; ro6; ro6 = ro6->next)
     {
-        struct route_ipv6_option *ro6;
-        for (ro6 = opt6->routes_ipv6; ro6; ro6 = ro6->next)
+        struct route_ipv6 *r6;
+
+        ALLOC_OBJ_GC(r6, struct route_ipv6, &rl6->gc);
+        if (!init_route_ipv6(r6, ro6, rl6))
         {
-            struct route_ipv6 *r6;
-            ALLOC_OBJ_GC(r6, struct route_ipv6, &rl6->gc);
-            if (!init_route_ipv6(r6, ro6, rl6))
-            {
-                ret = false;
-            }
-            else
-            {
-                r6->next = rl6->routes_ipv6;
-                rl6->routes_ipv6 = r6;
+            ret = false;
+        }
+        else
+        {
+            r6->next = rl6->routes_ipv6;
+            rl6->routes_ipv6 = r6;
 
 #ifndef TARGET_ANDROID
-                /* On Android the VPNService protect function call will take of
-                 * avoiding routing loops, so ignore this part and let
-                 * need_remote_ipv6_route always evaluate to false
-                 */
-                if (remote_host_ipv6
-                    && route_ipv6_match_host( r6, remote_host_ipv6 ) )
-                {
-                    need_remote_ipv6_route = true;
-                    msg(D_ROUTE, "ROUTE6: %s/%d overlaps IPv6 remote %s, adding host route to VPN endpoint",
-                        print_in6_addr(r6->network, 0, &gc), r6->netbits,
-                        print_in6_addr(*remote_host_ipv6, 0, &gc));
-                }
-#endif
+            /* On Android the VPNService protect function call will take of
+             * avoiding routing loops, so ignore this part and let
+             * need_remote_ipv6_route always evaluate to false
+             */
+            if (remote_host_ipv6 && route_ipv6_match_host(r6, remote_host_ipv6))
+            {
+                need_remote_ipv6_route = true;
+                msg(D_ROUTE, "ROUTE6: %s/%d overlaps IPv6 remote %s, adding host route to VPN endpoint",
+                    print_in6_addr(r6->network, 0, &gc), r6->netbits,
+                    print_in6_addr(*remote_host_ipv6, 0, &gc));
             }
+#endif
         }
     }
 
     /* add VPN server host route if needed */
     if (need_remote_ipv6_route)
     {
-        if ( (rl6->rgi6.flags & (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED) ) ==
-             (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED) )
+        int defined = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+
+        if ((rl6->rgi6.flags & defined) == defined)
         {
             struct route_ipv6 *r6;
             ALLOC_OBJ_CLEAR_GC(r6, struct route_ipv6, &rl6->gc);
 
             r6->network = *remote_host_ipv6;
             r6->netbits = 128;
-            if (!(rl6->rgi6.flags & RGI_ON_LINK) )
+            if (!(rl6->rgi6.flags & RGI_ON_LINK))
             {
                 r6->gateway = rl6->rgi6.gateway.addr_ipv6;
             }
@@ -886,24 +898,22 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
         }
         else
         {
-            msg(M_WARN, "ROUTE6: IPv6 route overlaps with IPv6 remote address, but could not determine IPv6 gateway address + interface, expect failure\n" );
+            msg(M_WARN, "ROUTE6: IPv6 route overlaps with IPv6 remote address, but could not determine IPv6 gateway address + interface, expect failure\n");
         }
     }
 
     gc_free(&gc);
+
     return ret;
 }
 
 static void
-add_route3(in_addr_t network,
-           in_addr_t netmask,
-           in_addr_t gateway,
-           const struct tuntap *tt,
-           unsigned int flags,
-           const struct route_gateway_info *rgi,
-           const struct env_set *es)
+add_route3(in_addr_t network, in_addr_t netmask, in_addr_t gateway,
+           const struct tuntap *tt, unsigned int flags,
+           const struct route_gateway_info *rgi, const struct env_set *es)
 {
     struct route_ipv4 r;
+
     CLEAR(r);
     r.flags = RT_DEFINED;
     r.network = network;
@@ -913,17 +923,14 @@ add_route3(in_addr_t network,
 }
 
 static void
-del_route3(in_addr_t network,
-           in_addr_t netmask,
-           in_addr_t gateway,
-           const struct tuntap *tt,
-           unsigned int flags,
-           const struct route_gateway_info *rgi,
-           const struct env_set *es)
+del_route3(in_addr_t network, in_addr_t netmask, in_addr_t gateway,
+           const struct tuntap *tt, unsigned int flags,
+           const struct route_gateway_info *rgi, const struct env_set *es)
 {
     struct route_ipv4 r;
+
     CLEAR(r);
-    r.flags = RT_DEFINED|RT_ADDED;
+    r.flags = RT_DEFINED | RT_ADDED;
     r.network = network;
     r.netmask = netmask;
     r.gateway = gateway;
@@ -931,55 +938,44 @@ del_route3(in_addr_t network,
 }
 
 static void
-add_bypass_routes(struct route_bypass *rb,
-                  in_addr_t gateway,
-                  const struct tuntap *tt,
-                  unsigned int flags,
+add_bypass_routes(struct route_bypass *rb, in_addr_t gateway,
+                  const struct tuntap *tt, unsigned int flags,
                   const struct route_gateway_info *rgi,
                   const struct env_set *es)
 {
     int i;
+
     for (i = 0; i < rb->n_bypass; ++i)
     {
         if (rb->bypass[i])
         {
-            add_route3(rb->bypass[i],
-                       IPV4_NETMASK_HOST,
-                       gateway,
-                       tt,
-                       flags | ROUTE_REF_GW,
-                       rgi,
-                       es);
+            add_route3(rb->bypass[i], IPV4_NETMASK_HOST, gateway, tt,
+                       flags | ROUTE_REF_GW, rgi, es);
         }
     }
 }
 
 static void
-del_bypass_routes(struct route_bypass *rb,
-                  in_addr_t gateway,
-                  const struct tuntap *tt,
-                  unsigned int flags,
+del_bypass_routes(struct route_bypass *rb, in_addr_t gateway,
+                  const struct tuntap *tt, unsigned int flags,
                   const struct route_gateway_info *rgi,
                   const struct env_set *es)
 {
     int i;
+
     for (i = 0; i < rb->n_bypass; ++i)
     {
         if (rb->bypass[i])
         {
-            del_route3(rb->bypass[i],
-                       IPV4_NETMASK_HOST,
-                       gateway,
-                       tt,
-                       flags | ROUTE_REF_GW,
-                       rgi,
-                       es);
+            del_route3(rb->bypass[i], IPV4_NETMASK_HOST, gateway, tt,
+                       flags | ROUTE_REF_GW, rgi, es);
         }
     }
 }
 
 static void
-redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
+                              unsigned int flags, const struct env_set *es)
 {
     const char err[] = "NOTE: unable to redirect default gateway --";
 
@@ -987,9 +983,11 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
     {
         bool local = rl->flags & RG_LOCAL;
 
-        if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT) && (rl->flags & RG_REROUTE_GW))
+        if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT)
+            && (rl->flags & RG_REROUTE_GW))
         {
-            msg(M_WARN, "%s VPN gateway parameter (--route-gateway or --ifconfig) is missing", err);
+            msg(M_WARN, "%s VPN gateway parameter (--route-gateway or --ifconfig) is missing",
+                err);
         }
         /*
          * check if a default route is defined, unless:
@@ -999,7 +997,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
         else if (!(rl->rgi.flags & RGI_ADDR_DEFINED) && !local
                  && (rl->spec.remote_host != IPV4_INVALID_ADDR))
         {
-            msg(M_WARN, "%s Cannot read current default gateway from system", err);
+            msg(M_WARN, "%s Cannot read current default gateway from system",
+                err);
         }
         else if (!(rl->spec.flags & RTSA_REMOTE_HOST))
         {
@@ -1011,6 +1010,7 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
             if (rl->flags & RG_AUTO_LOCAL)
             {
                 const int tla = rl->spec.remote_host_local;
+
                 if (tla == TLA_NONLOCAL)
                 {
                     dmsg(D_ROUTE, "ROUTE remote_host is NOT LOCAL");
@@ -1029,13 +1029,9 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
                  * adding this special /32 route */
                 if (rl->spec.remote_host != IPV4_INVALID_ADDR)
                 {
-                    add_route3(rl->spec.remote_host,
-                               IPV4_NETMASK_HOST,
-                               rl->rgi.gateway.addr,
-                               tt,
-                               flags | ROUTE_REF_GW,
-                               &rl->rgi,
-                               es);
+                    add_route3(rl->spec.remote_host, IPV4_NETMASK_HOST,
+                               rl->rgi.gateway.addr, tt, flags | ROUTE_REF_GW,
+                               &rl->rgi, es);
                     rl->iflags |= RL_DID_LOCAL;
                 }
                 else
@@ -1046,29 +1042,20 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
 #endif /* ifndef TARGET_ANDROID */
 
             /* route DHCP/DNS server traffic through original default gateway */
-            add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags, &rl->rgi, es);
+            add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags,
+                              &rl->rgi, es);
 
             if (rl->flags & RG_REROUTE_GW)
             {
                 if (rl->flags & RG_DEF1)
                 {
                     /* add new default route (1st component) */
-                    add_route3(0x00000000,
-                               0x80000000,
-                               rl->spec.remote_endpoint,
-                               tt,
-                               flags,
-                               &rl->rgi,
-                               es);
+                    add_route3(0x00000000, 0x80000000, rl->spec.remote_endpoint,
+                               tt, flags, &rl->rgi, es);
 
                     /* add new default route (2nd component) */
-                    add_route3(0x80000000,
-                               0x80000000,
-                               rl->spec.remote_endpoint,
-                               tt,
-                               flags,
-                               &rl->rgi,
-                               es);
+                    add_route3(0x80000000, 0x80000000, rl->spec.remote_endpoint,
+                               tt, flags, &rl->rgi, es);
                 }
                 else
                 {
@@ -1081,13 +1068,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
                     }
 
                     /* add new default route */
-                    add_route3(0,
-                               0,
-                               rl->spec.remote_endpoint,
-                               tt,
-                               flags,
-                               &rl->rgi,
-                               es);
+                    add_route3(0, 0, rl->spec.remote_endpoint, tt, flags,
+                               &rl->rgi, es);
                 }
             }
 
@@ -1098,57 +1080,41 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
 }
 
 static void
-undo_redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+undo_redirect_default_route_to_vpn(struct route_list *rl,
+                                   const struct tuntap *tt, unsigned int flags,
+                                   const struct env_set *es)
 {
-    if (rl && rl->iflags & RL_DID_REDIRECT_DEFAULT_GATEWAY)
+    if (rl && (rl->iflags & RL_DID_REDIRECT_DEFAULT_GATEWAY))
     {
         /* delete remote host route */
         if (rl->iflags & RL_DID_LOCAL)
         {
-            del_route3(rl->spec.remote_host,
-                       IPV4_NETMASK_HOST,
-                       rl->rgi.gateway.addr,
-                       tt,
-                       flags | ROUTE_REF_GW,
-                       &rl->rgi,
+            del_route3(rl->spec.remote_host, IPV4_NETMASK_HOST,
+                       rl->rgi.gateway.addr, tt, flags | ROUTE_REF_GW, &rl->rgi,
                        es);
             rl->iflags &= ~RL_DID_LOCAL;
         }
 
         /* delete special DHCP/DNS bypass route */
-        del_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags, &rl->rgi, es);
+        del_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags,
+                          &rl->rgi, es);
 
         if (rl->flags & RG_REROUTE_GW)
         {
             if (rl->flags & RG_DEF1)
             {
                 /* delete default route (1st component) */
-                del_route3(0x00000000,
-                           0x80000000,
-                           rl->spec.remote_endpoint,
-                           tt,
-                           flags,
-                           &rl->rgi,
-                           es);
+                del_route3(0x00000000, 0x80000000, rl->spec.remote_endpoint,
+                           tt, flags, &rl->rgi, es);
 
                 /* delete default route (2nd component) */
-                del_route3(0x80000000,
-                           0x80000000,
-                           rl->spec.remote_endpoint,
-                           tt,
-                           flags,
-                           &rl->rgi,
-                           es);
+                del_route3(0x80000000, 0x80000000, rl->spec.remote_endpoint,
+                           tt, flags, &rl->rgi, es);
             }
             else
             {
                 /* delete default route */
-                del_route3(0,
-                           0,
-                           rl->spec.remote_endpoint,
-                           tt,
-                           flags,
-                           &rl->rgi,
+                del_route3(0, 0, rl->spec.remote_endpoint, tt, flags, &rl->rgi,
                            es);
                 /* restore original default route if there was any */
                 if (rl->rgi.flags & RGI_ADDR_DEFINED)
@@ -1164,23 +1130,21 @@ undo_redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *t
 }
 
 void
-add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
+           const struct tuntap *tt, unsigned int flags,
+           const struct env_set *es)
 {
     redirect_default_route_to_vpn(rl, tt, flags, es);
-    if (rl && !(rl->iflags & RL_ROUTES_ADDED) )
+
+    if (rl && !(rl->iflags & RL_ROUTES_ADDED))
     {
         struct route_ipv4 *r;
 
 #ifdef ENABLE_MANAGEMENT
         if (management && rl->routes)
         {
-            management_set_state(management,
-                                 OPENVPN_STATE_ADD_ROUTES,
-                                 NULL,
-                                 NULL,
-                                 NULL,
-                                 NULL,
-                                 NULL);
+            management_set_state(management, OPENVPN_STATE_ADD_ROUTES, NULL,
+                                 NULL, NULL, NULL, NULL);
         }
 #endif
 
@@ -1195,7 +1159,8 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tunt
         }
         rl->iflags |= RL_ROUTES_ADDED;
     }
-    if (rl6 && !(rl6->iflags & RL_ROUTES_ADDED) )
+
+    if (rl6 && !(rl6->iflags & RL_ROUTES_ADDED))
     {
         struct route_ipv6 *r;
 
@@ -1221,11 +1186,13 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tunt
 
 void
 delete_routes(struct route_list *rl, struct route_ipv6_list *rl6,
-              const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+              const struct tuntap *tt, unsigned int flags,
+              const struct env_set *es)
 {
     if (rl && rl->iflags & RL_ROUTES_ADDED)
     {
         struct route_ipv4 *r;
+
         for (r = rl->routes; r; r = r->next)
         {
             delete_route(r, tt, flags, &rl->rgi, es);
@@ -1240,9 +1207,10 @@ delete_routes(struct route_list *rl, struct route_ipv6_list *rl6,
         clear_route_list(rl);
     }
 
-    if (rl6 && (rl6->iflags & RL_ROUTES_ADDED) )
+    if (rl6 && (rl6->iflags & RL_ROUTES_ADDED))
     {
         struct route_ipv6 *r6;
+
         for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
         {
             delete_route_ipv6(r6, tt, flags, es);
@@ -1274,23 +1242,21 @@ show_opt(const char *option)
 static void
 print_route_option(const struct route_option *ro, int level)
 {
-    msg(level, "  route %s/%s/%s/%s",
-        show_opt(ro->network),
-        show_opt(ro->netmask),
-        show_opt(ro->gateway),
-        show_opt(ro->metric));
+    msg(level, "  route %s/%s/%s/%s", show_opt(ro->network),
+        show_opt(ro->netmask), show_opt(ro->gateway), show_opt(ro->metric));
 }
 
 void
-print_route_options(const struct route_option_list *rol,
-                    int level)
+print_route_options(const struct route_option_list *rol, int level)
 {
     struct route_option *ro;
+
     if (rol->flags & RG_ENABLE)
     {
         msg(level, "  [redirect_default_gateway local=%d]",
             (rol->flags & RG_LOCAL) != 0);
     }
+
     for (ro = rol->routes; ro; ro = ro->next)
     {
         print_route_option(ro, level);
@@ -1298,14 +1264,15 @@ print_route_options(const struct route_option_list *rol,
 }
 
 void
-print_default_gateway(const int msglevel,
-                      const struct route_gateway_info *rgi,
+print_default_gateway(const int msglevel, const struct route_gateway_info *rgi,
                       const struct route_ipv6_gateway_info *rgi6)
 {
     struct gc_arena gc = gc_new();
+
     if (rgi && (rgi->flags & RGI_ADDR_DEFINED))
     {
         struct buffer out = alloc_buf_gc(256, &gc);
+
         buf_printf(&out, "ROUTE_GATEWAY");
         if (rgi->flags & RGI_ON_LINK)
         {
@@ -1315,10 +1282,13 @@ print_default_gateway(const int msglevel,
         {
             buf_printf(&out, " %s", print_in_addr_t(rgi->gateway.addr, 0, &gc));
         }
+
         if (rgi->flags & RGI_NETMASK_DEFINED)
         {
-            buf_printf(&out, "/%s", print_in_addr_t(rgi->gateway.netmask, 0, &gc));
+            buf_printf(&out, "/%s", print_in_addr_t(rgi->gateway.netmask, 0,
+                                                    &gc));
         }
+
 #ifdef _WIN32
         if (rgi->flags & RGI_IFACE_DEFINED)
         {
@@ -1330,9 +1300,11 @@ print_default_gateway(const int msglevel,
             buf_printf(&out, " IFACE=%s", rgi->iface);
         }
 #endif
+
         if (rgi->flags & RGI_HWADDR_DEFINED)
         {
-            buf_printf(&out, " HWADDR=%s", format_hex_ex(rgi->hwaddr, 6, 0, 1, ":", &gc));
+            buf_printf(&out, " HWADDR=%s", format_hex_ex(rgi->hwaddr, 6, 0, 1,
+                                                         ":", &gc));
         }
         msg(msglevel, "%s", BSTR(&out));
     }
@@ -1340,16 +1312,20 @@ print_default_gateway(const int msglevel,
     if (rgi6 && (rgi6->flags & RGI_ADDR_DEFINED))
     {
         struct buffer out = alloc_buf_gc(256, &gc);
+
         buf_printf(&out, "ROUTE6_GATEWAY");
-        buf_printf(&out, " %s", print_in6_addr(rgi6->gateway.addr_ipv6, 0, &gc));
+        buf_printf(&out, " %s", print_in6_addr(rgi6->gateway.addr_ipv6, 0,
+                                               &gc));
         if (rgi6->flags & RGI_ON_LINK)
         {
             buf_printf(&out, " ON_LINK");
         }
+
         if (rgi6->flags & RGI_NETMASK_DEFINED)
         {
             buf_printf(&out, "/%d", rgi6->gateway.netbits_ipv6);
         }
+
 #ifdef _WIN32
         if (rgi6->flags & RGI_IFACE_DEFINED)
         {
@@ -1361,9 +1337,11 @@ print_default_gateway(const int msglevel,
             buf_printf(&out, " IFACE=%s", rgi6->iface);
         }
 #endif
+
         if (rgi6->flags & RGI_HWADDR_DEFINED)
         {
-            buf_printf(&out, " HWADDR=%s", format_hex_ex(rgi6->hwaddr, 6, 0, 1, ":", &gc));
+            buf_printf(&out, " HWADDR=%s", format_hex_ex(rgi6->hwaddr, 6, 0, 1,
+                                                         ":", &gc));
         }
         msg(msglevel, "%s", BSTR(&out));
     }
@@ -1376,6 +1354,7 @@ static void
 print_route(const struct route_ipv4 *r, int level)
 {
     struct gc_arena gc = gc_new();
+
     if (r->flags & RT_DEFINED)
     {
         msg(level, "%s", route_string(r, &gc));
@@ -1387,6 +1366,7 @@ void
 print_routes(const struct route_list *rl, int level)
 {
     struct route_ipv4 *r;
+
     for (r = rl->routes; r; r = r->next)
     {
         print_route(r, level);
@@ -1397,6 +1377,7 @@ static void
 setenv_route(struct env_set *es, const struct route_ipv4 *r, int i)
 {
     struct gc_arena gc = gc_new();
+
     if (r->flags & RT_DEFINED)
     {
         setenv_route_addr(es, "network", r->network, i);
@@ -1406,6 +1387,7 @@ setenv_route(struct env_set *es, const struct route_ipv4 *r, int i)
         if (r->flags & RT_METRIC_DEFINED)
         {
             struct buffer name = alloc_buf_gc(256, &gc);
+
             buf_printf(&name, "route_metric_%d", i);
             setenv_int(es, BSTR(&name), r->metric);
         }
@@ -1418,6 +1400,7 @@ setenv_routes(struct env_set *es, const struct route_list *rl)
 {
     int i = 1;
     struct route_ipv4 *r;
+
     for (r = rl->routes; r; r = r->next)
     {
         setenv_route(es, r, i++);
@@ -1428,19 +1411,20 @@ static void
 setenv_route_ipv6(struct env_set *es, const struct route_ipv6 *r6, int i)
 {
     struct gc_arena gc = gc_new();
+
     if (r6->flags & RT_DEFINED)
     {
-        struct buffer name1 = alloc_buf_gc( 256, &gc );
-        struct buffer val = alloc_buf_gc( 256, &gc );
-        struct buffer name2 = alloc_buf_gc( 256, &gc );
+        struct buffer name1 = alloc_buf_gc(256, &gc);
+        struct buffer val = alloc_buf_gc(256, &gc);
+        struct buffer name2 = alloc_buf_gc(256, &gc);
 
-        buf_printf( &name1, "route_ipv6_network_%d", i );
-        buf_printf( &val, "%s/%d", print_in6_addr( r6->network, 0, &gc ),
-                    r6->netbits );
-        setenv_str( es, BSTR(&name1), BSTR(&val) );
+        buf_printf(&name1, "route_ipv6_network_%d", i);
+        buf_printf(&val, "%s/%d", print_in6_addr(r6->network, 0, &gc),
+                   r6->netbits);
+        setenv_str(es, BSTR(&name1), BSTR(&val));
 
-        buf_printf( &name2, "route_ipv6_gateway_%d", i );
-        setenv_str( es, BSTR(&name2), print_in6_addr( r6->gateway, 0, &gc ));
+        buf_printf(&name2, "route_ipv6_gateway_%d", i);
+        setenv_str(es, BSTR(&name2), print_in6_addr(r6->gateway, 0, &gc));
     }
     gc_free(&gc);
 }
@@ -1449,6 +1433,7 @@ setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6)
 {
     int i = 1;
     struct route_ipv6 *r6;
+
     for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
     {
         setenv_route_ipv6(es, r6, i++);
@@ -1479,19 +1464,17 @@ setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6)
 #define LR_ERROR   2 /* caller should abort adding route */
 
 static int
-local_route(in_addr_t network,
-            in_addr_t netmask,
-            in_addr_t gateway,
+local_route(in_addr_t network, in_addr_t netmask, in_addr_t gateway,
             const struct route_gateway_info *rgi)
 {
     /* set LR_MATCH on local host routes */
-    const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED|RGI_IFACE_DEFINED);
-    if (rgi
-        && (rgi->flags & rgi_needed) == rgi_needed
-        && gateway == rgi->gateway.addr
-        && netmask == 0xFFFFFFFF)
+    const int rgi_needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED
+                            | RGI_IFACE_DEFINED);
+
+    if (rgi && ((rgi->flags & rgi_needed) == rgi_needed)
+        && (gateway == rgi->gateway.addr) && (netmask == 0xFFFFFFFF))
     {
-        if (((network ^  rgi->gateway.addr) & rgi->gateway.netmask) == 0)
+        if (((network ^ rgi->gateway.addr) & rgi->gateway.netmask) == 0)
         {
             return LR_MATCH;
         }
@@ -1499,9 +1482,11 @@ local_route(in_addr_t network,
         {
             /* examine additional subnets on gateway interface */
             size_t i;
+
             for (i = 0; i < rgi->n_addrs; ++i)
             {
                 const struct route_gateway_address *gwa = &rgi->addrs[i];
+
                 if (((network ^ gwa->addr) & gwa->netmask) == 0)
                 {
                     return LR_MATCH;
@@ -1509,21 +1494,23 @@ local_route(in_addr_t network,
             }
         }
     }
+
     return LR_NOMATCH;
 }
 
-/* Return true if the "on-link" form of the route should be used.  This is when the gateway for a
- * a route is specified as an interface rather than an address. */
+/* Return true if the "on-link" form of the route should be used.
+ * This is when the gateway for a route is specified as an interface rather
+ * than an address. */
 static inline bool
-is_on_link(const int is_local_route, const unsigned int flags, const struct route_gateway_info *rgi)
+is_on_link(const int is_local_route, const unsigned int flags,
+           const struct route_gateway_info *rgi)
 {
-    return rgi && (is_local_route == LR_MATCH || ((flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LINK)));
+    return rgi && ((is_local_route == LR_MATCH)
+                   || ((flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LINK)));
 }
 
 void
-add_route(struct route_ipv4 *r,
-          const struct tuntap *tt,
-          unsigned int flags,
+add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
           const struct route_gateway_info *rgi,  /* may be NULL */
           const struct env_set *es)
 {
@@ -1558,9 +1545,7 @@ add_route(struct route_ipv4 *r,
 
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s route add %s/%d",
-                iproute_path,
-                network,
+    argv_printf(&argv, "%s route add %s/%d", iproute_path, network,
                 netmask_to_netbits2(r->netmask));
 
     if (r->flags & RT_METRIC_DEFINED)
@@ -1577,14 +1562,14 @@ add_route(struct route_ipv4 *r,
         argv_printf_cat(&argv, "via %s", gateway);
     }
 #else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s add -net %s netmask %s",
-                ROUTE_PATH,
-                network,
+    argv_printf(&argv, "%s add -net %s netmask %s", ROUTE_PATH, network,
                 netmask);
+
     if (r->flags & RT_METRIC_DEFINED)
     {
         argv_printf_cat(&argv, "metric %d", r->metric);
     }
+
     if (is_on_link(is_local_route, flags, rgi))
     {
         argv_printf_cat(&argv, "dev %s", rgi->iface);
@@ -1596,14 +1581,16 @@ add_route(struct route_ipv4 *r,
 
 #endif  /*ENABLE_IPROUTE*/
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Linux route add command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: Linux route add command failed");
 
 #elif defined (TARGET_ANDROID)
     struct buffer out = alloc_buf_gc(128, &gc);
 
     if (rgi)
     {
-        buf_printf(&out, "%s %s %s dev %s", network, netmask, gateway, rgi->iface);
+        buf_printf(&out, "%s %s %s dev %s", network, netmask, gateway,
+                   rgi->iface);
     }
     else
     {
@@ -1614,16 +1601,15 @@ add_route(struct route_ipv4 *r,
 #elif defined (_WIN32)
     {
         DWORD ai = TUN_ADAPTER_INDEX_INVALID;
-        argv_printf(&argv, "%s%sc ADD %s MASK %s %s",
-                    get_win_sys_path(),
-                    WIN_ROUTE_PATH_SUFFIX,
-                    network,
-                    netmask,
-                    gateway);
+
+        argv_printf(&argv, "%s%sc ADD %s MASK %s %s", get_win_sys_path(),
+                    WIN_ROUTE_PATH_SUFFIX, network, netmask, gateway);
+
         if (r->flags & RT_METRIC_DEFINED)
         {
             argv_printf_cat(&argv, "METRIC %d", r->metric);
         }
+
         if (is_on_link(is_local_route, flags, rgi))
         {
             ai = rgi->adapter_index;
@@ -1635,28 +1621,33 @@ add_route(struct route_ipv4 *r,
         if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_SERVICE)
         {
             status = add_route_service(r, tt);
-            msg(D_ROUTE, "Route addition via service %s", status ? "succeeded" : "failed");
+            msg(D_ROUTE, "Route addition via service %s",
+                status ? "succeeded" : "failed");
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
         {
             status = add_route_ipapi(r, tt, ai);
-            msg(D_ROUTE, "Route addition via IPAPI %s", status ? "succeeded" : "failed");
+            msg(D_ROUTE, "Route addition via IPAPI %s",
+                status ? "succeeded" : "failed");
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_EXE)
         {
             netcmd_semaphore_lock();
-            status = openvpn_execve_check(&argv, es, 0, "ERROR: Windows route add command failed");
+            status = openvpn_execve_check(&argv, es, 0,
+                                          "ERROR: Windows route add command failed");
             netcmd_semaphore_release();
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_ADAPTIVE)
         {
             status = add_route_ipapi(r, tt, ai);
-            msg(D_ROUTE, "Route addition via IPAPI %s [adaptive]", status ? "succeeded" : "failed");
+            msg(D_ROUTE, "Route addition via IPAPI %s [adaptive]",
+                status ? "succeeded" : "failed");
             if (!status)
             {
                 msg(D_ROUTE, "Route addition fallback to route.exe");
                 netcmd_semaphore_lock();
-                status = openvpn_execve_check(&argv, es, 0, "ERROR: Windows route add command failed [adaptive]");
+                status = openvpn_execve_check(&argv, es, 0,
+                                              "ERROR: Windows route add command failed [adaptive]");
                 netcmd_semaphore_release();
             }
         }
@@ -1670,13 +1661,9 @@ add_route(struct route_ipv4 *r,
 
     /* example: route add 192.0.2.32 -netmask 255.255.255.224 somegateway */
 
-    argv_printf(&argv, "%s add",
-                ROUTE_PATH);
+    argv_printf(&argv, "%s add", ROUTE_PATH);
 
-    argv_printf_cat(&argv, "%s -netmask %s %s",
-                    network,
-                    netmask,
-                    gateway);
+    argv_printf_cat(&argv, "%s -netmask %s %s", network, netmask, gateway);
 
     /* Solaris can only distinguish between "metric 0" == "on-link on the
      * interface where the IP address given is configured" and "metric > 0"
@@ -1691,12 +1678,12 @@ add_route(struct route_ipv4 *r,
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route add command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: Solaris route add command failed");
 
 #elif defined(TARGET_FREEBSD)
 
-    argv_printf(&argv, "%s add",
-                ROUTE_PATH);
+    argv_printf(&argv, "%s add", ROUTE_PATH);
 
 #if 0
     if (r->flags & RT_METRIC_DEFINED)
@@ -1705,20 +1692,17 @@ add_route(struct route_ipv4 *r,
     }
 #endif
 
-    argv_printf_cat(&argv, "-net %s %s %s",
-                    network,
-                    gateway,
-                    netmask);
+    argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
 
     /* FIXME -- add on-link support for FreeBSD */
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD route add command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: FreeBSD route add command failed");
 
 #elif defined(TARGET_DRAGONFLY)
 
-    argv_printf(&argv, "%s add",
-                ROUTE_PATH);
+    argv_printf(&argv, "%s add", ROUTE_PATH);
 
 #if 0
     if (r->flags & RT_METRIC_DEFINED)
@@ -1727,20 +1711,17 @@ add_route(struct route_ipv4 *r,
     }
 #endif
 
-    argv_printf_cat(&argv, "-net %s %s %s",
-                    network,
-                    gateway,
-                    netmask);
+    argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
 
     /* FIXME -- add on-link support for Dragonfly */
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: DragonFly route add command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: DragonFly route add command failed");
 
 #elif defined(TARGET_DARWIN)
 
-    argv_printf(&argv, "%s add",
-                ROUTE_PATH);
+    argv_printf(&argv, "%s add", ROUTE_PATH);
 
 #if 0
     if (r->flags & RT_METRIC_DEFINED)
@@ -1754,25 +1735,20 @@ add_route(struct route_ipv4 *r,
         /* Mac OS X route syntax for ON_LINK:
          * route add -cloning -net 10.10.0.1 -netmask 255.255.255.255 -interface en0 */
         argv_printf_cat(&argv, "-cloning -net %s -netmask %s -interface %s",
-                        network,
-                        netmask,
-                        rgi->iface);
+                        network, netmask, rgi->iface);
     }
     else
     {
-        argv_printf_cat(&argv, "-net %s %s %s",
-                        network,
-                        gateway,
-                        netmask);
+        argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: OS X route add command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: OS X route add command failed");
 
 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
-    argv_printf(&argv, "%s add",
-                ROUTE_PATH);
+    argv_printf(&argv, "%s add", ROUTE_PATH);
 
 #if 0
     if (r->flags & RT_METRIC_DEFINED)
@@ -1781,25 +1757,24 @@ add_route(struct route_ipv4 *r,
     }
 #endif
 
-    argv_printf_cat(&argv, "-net %s %s -netmask %s",
-                    network,
-                    gateway,
-                    netmask);
+    argv_printf_cat(&argv, "-net %s %s -netmask %s", network, gateway, netmask);
 
     /* FIXME -- add on-link support for OpenBSD/NetBSD */
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route add command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: OpenBSD/NetBSD route add command failed");
 
 #elif defined(TARGET_AIX)
 
     {
         int netbits = netmask_to_netbits2(r->netmask);
-        argv_printf(&argv, "%s add -net %s/%d %s",
-                    ROUTE_PATH,
-                    network, netbits, gateway);
+
+        argv_printf(&argv, "%s add -net %s/%d %s", ROUTE_PATH, network, netbits,
+                    gateway);
         argv_msg(D_ROUTE, &argv);
-        status = openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
+        status = openvpn_execve_check(&argv, es, 0,
+                                      "ERROR: AIX route add command failed");
     }
 
 #else  /* if defined(TARGET_LINUX) */
@@ -1815,13 +1790,14 @@ done:
     {
         r->flags &= ~RT_ADDED;
     }
+
     argv_reset(&argv);
     gc_free(&gc);
 }
 
 
 static void
-route_ipv6_clear_host_bits( struct route_ipv6 *r6 )
+route_ipv6_clear_host_bits(struct route_ipv6 *r6)
 {
     /* clear host bit parts of route
      * (needed if routes are specified improperly, or if we need to
@@ -1844,19 +1820,18 @@ route_ipv6_clear_host_bits( struct route_ipv6 *r6 )
 }
 
 void
-add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
+               unsigned int flags, const struct env_set *es)
 {
     struct gc_arena gc;
     struct argv argv = argv_new();
-
     const char *network;
     const char *gateway;
     bool status = false;
     const char *device = tt->actual_name;
-
     bool gateway_needed = false;
 
-    if (!(r6->flags & RT_DEFINED) )
+    if (!(r6->flags & RT_DEFINED))
     {
         return;
     }
@@ -1865,7 +1840,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     if (r6->iface != NULL)              /* vpn server special route */
     {
         device = r6->iface;
-        if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
+        if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway))
         {
             gateway_needed = true;
         }
@@ -1876,11 +1851,11 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
 
     route_ipv6_clear_host_bits(r6);
 
-    network = print_in6_addr( r6->network, 0, &gc);
-    gateway = print_in6_addr( r6->gateway, 0, &gc);
+    network = print_in6_addr(r6->network, 0, &gc);
+    gateway = print_in6_addr(r6->gateway, 0, &gc);
 
-#if defined(TARGET_DARWIN)    \
-    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
+#if defined(TARGET_DARWIN)     \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)     \
     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
     /* the BSD platforms cannot specify gateway and interface independently,
@@ -1888,17 +1863,18 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
      * we build a combined "$gateway%$interface" gateway string
      */
     if (r6->iface != NULL && gateway_needed
-        && IN6_IS_ADDR_LINKLOCAL(&r6->gateway) )        /* fe80::...%intf */
+        && IN6_IS_ADDR_LINKLOCAL(&r6->gateway))        /* fe80::...%intf */
     {
-        int len = strlen(gateway) + 1 + strlen(r6->iface)+1;
-        char *tmp = gc_malloc( len, true, &gc );
-        snprintf( tmp, len, "%s%%%s", gateway, r6->iface );
+        int len = strlen(gateway) + 1 + strlen(r6->iface) + 1;
+        char *tmp = gc_malloc(len, true, &gc);
+
+        snprintf(tmp, len, "%s%%%s", gateway, r6->iface);
         gateway = tmp;
     }
 #endif
 
-    msg( M_INFO, "add_route_ipv6(%s/%d -> %s metric %d) dev %s",
-         network, r6->netbits, gateway, r6->metric, device );
+    msg(M_INFO, "add_route_ipv6(%s/%d -> %s metric %d) dev %s", network,
+        r6->netbits, gateway, r6->metric, device);
 
     /*
      * Filter out routes which are essentially no-ops
@@ -1911,45 +1887,40 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
      * interfaces.   OTOH, on "tap" interface, we must always set the
      * gateway unless the route is to be an on-link network
      */
-    if (tt->type == DEV_TYPE_TAP
-        && !( (r6->flags & RT_METRIC_DEFINED) && r6->metric == 0 ) )
+    if ((tt->type == DEV_TYPE_TAP)
+        && !((r6->flags & RT_METRIC_DEFINED) && (r6->metric == 0)))
     {
         gateway_needed = true;
     }
 
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s -6 route add %s/%d dev %s",
-                iproute_path,
-                network,
-                r6->netbits,
-                device);
+    argv_printf(&argv, "%s -6 route add %s/%d dev %s", iproute_path, network,
+                r6->netbits, device);
     if (gateway_needed)
     {
         argv_printf_cat(&argv, "via %s", gateway);
     }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
+    if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
         argv_printf_cat(&argv, " metric %d", r6->metric);
     }
 
 #else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s -A inet6 add %s/%d dev %s",
-                ROUTE_PATH,
-                network,
-                r6->netbits,
-                device);
+    argv_printf(&argv, "%s -A inet6 add %s/%d dev %s", ROUTE_PATH, network,
+                r6->netbits, device);
     if (gateway_needed)
     {
         argv_printf_cat(&argv, "gw %s", gateway);
     }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
+    if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
         argv_printf_cat(&argv, " metric %d", r6->metric);
     }
 #endif  /*ENABLE_IPROUTE*/
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Linux route -6/-A inet6 add command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: Linux route -6/-A inet6 add command failed");
 
 #elif defined (TARGET_ANDROID)
     struct buffer out = alloc_buf_gc(64, &gc);
@@ -1967,23 +1938,21 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     else
     {
         struct buffer out = alloc_buf_gc(64, &gc);
+
         if (r6->adapter_index)          /* vpn server special route */
         {
-            buf_printf(&out, "interface=%d", r6->adapter_index );
+            buf_printf(&out, "interface=%d", r6->adapter_index);
             gateway_needed = true;
         }
         else
         {
-            buf_printf(&out, "interface=%d", tt->adapter_index );
+            buf_printf(&out, "interface=%d", tt->adapter_index);
         }
         device = buf_bptr(&out);
 
         /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
         argv_printf(&argv, "%s%sc interface ipv6 add route %s/%d %s",
-                    get_win_sys_path(),
-                    NETSH_PATH_SUFFIX,
-                    network,
-                    r6->netbits,
+                    get_win_sys_path(), NETSH_PATH_SUFFIX, network, r6->netbits,
                     device);
 
         /* next-hop depends on TUN or TAP mode:
@@ -1991,13 +1960,13 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
          * - in TUN mode we use a special-case link-local address that the tapdrvr
          *   knows about and will answer ND (neighbor discovery) packets for
          */
-        if (tt->type == DEV_TYPE_TUN && !gateway_needed)
+        if ((tt->type == DEV_TYPE_TUN) && !gateway_needed)
         {
-            argv_printf_cat( &argv, " %s", "fe80::8" );
+            argv_printf_cat(&argv, " %s", "fe80::8");
         }
-        else if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
+        else if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway))
         {
-            argv_printf_cat( &argv, " %s", gateway );
+            argv_printf_cat(&argv, " %s", gateway);
         }
 
 #if 0
@@ -2010,12 +1979,13 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
         /* in some versions of Windows, routes are persistent across reboots by
          * default, unless "store=active" is set (pointed out by Tony Lim, thanks)
          */
-        argv_printf_cat( &argv, " store=active" );
+        argv_printf_cat(&argv, " store=active");
 
         argv_msg(D_ROUTE, &argv);
 
         netcmd_semaphore_lock();
-        status = openvpn_execve_check(&argv, es, 0, "ERROR: Windows route add ipv6 command failed");
+        status = openvpn_execve_check(&argv, es, 0,
+                                      "ERROR: Windows route add ipv6 command failed");
         netcmd_semaphore_release();
     }
 
@@ -2032,11 +2002,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
      * use the GW addresses - it seems to still work for fe80:: addresses,
      * however this is done internally.  NUD maybe?)
      */
-    argv_printf(&argv, "%s add -inet6 %s/%d %s",
-                ROUTE_PATH,
-                network,
-                r6->netbits,
-                gateway );
+    argv_printf(&argv, "%s add -inet6 %s/%d %s", ROUTE_PATH, network,
+                r6->netbits, gateway);
 
     /* on tun/tap, not "elsewhere"? -> metric 0 */
     if (!r6->iface)
@@ -2045,14 +2012,12 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route add -inet6 command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: Solaris route add -inet6 command failed");
 
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
-    argv_printf(&argv, "%s add -inet6 %s/%d",
-                ROUTE_PATH,
-                network,
-                r6->netbits);
+    argv_printf(&argv, "%s add -inet6 %s/%d", ROUTE_PATH, network, r6->netbits);
 
     if (gateway_needed)
     {
@@ -2064,13 +2029,13 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: *BSD route add -inet6 command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: *BSD route add -inet6 command failed");
 
 #elif defined(TARGET_DARWIN)
 
-    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d",
-                ROUTE_PATH,
-                network, r6->netbits );
+    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d", ROUTE_PATH, network,
+                r6->netbits);
 
     if (gateway_needed)
     {
@@ -2082,33 +2047,34 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: MacOS X route add -inet6 command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: MacOS X route add -inet6 command failed");
 
 #elif defined(TARGET_OPENBSD)
 
-    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d %s",
-                ROUTE_PATH,
-                network, r6->netbits, gateway );
+    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d %s", ROUTE_PATH, network,
+                r6->netbits, gateway);
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD route add -inet6 command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: OpenBSD route add -inet6 command failed");
 
 #elif defined(TARGET_NETBSD)
 
-    argv_printf(&argv, "%s add -inet6 %s/%d %s",
-                ROUTE_PATH,
-                network, r6->netbits, gateway );
+    argv_printf(&argv, "%s add -inet6 %s/%d %s", ROUTE_PATH, network,
+                r6->netbits, gateway);
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: NetBSD route add -inet6 command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: NetBSD route add -inet6 command failed");
 
 #elif defined(TARGET_AIX)
 
-    argv_printf(&argv, "%s add -inet6 %s/%d %s",
-                ROUTE_PATH,
-                network, r6->netbits, gateway);
+    argv_printf(&argv, "%s add -inet6 %s/%d %s", ROUTE_PATH, network,
+                r6->netbits, gateway);
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
+    status = openvpn_execve_check(&argv, es, 0,
+                                  "ERROR: AIX route add command failed");
 
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-up script");
@@ -2127,11 +2093,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
 }
 
 static void
-delete_route(struct route_ipv4 *r,
-             const struct tuntap *tt,
-             unsigned int flags,
-             const struct route_gateway_info *rgi,
-             const struct env_set *es)
+delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
+             const struct route_gateway_info *rgi, const struct env_set *es)
 {
     struct gc_arena gc;
     struct argv argv = argv_new();
@@ -2167,14 +2130,10 @@ delete_route(struct route_ipv4 *r,
 
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s route del %s/%d",
-                iproute_path,
-                network,
+    argv_printf(&argv, "%s route del %s/%d", iproute_path, network,
                 netmask_to_netbits2(r->netmask));
 #else
-    argv_printf(&argv, "%s del -net %s netmask %s",
-                ROUTE_PATH,
-                network,
+    argv_printf(&argv, "%s del -net %s netmask %s", ROUTE_PATH, network,
                 netmask);
 #endif /*ENABLE_IPROUTE*/
     if (r->flags & RT_METRIC_DEFINED)
@@ -2182,44 +2141,49 @@ delete_route(struct route_ipv4 *r,
         argv_printf_cat(&argv, "metric %d", r->metric);
     }
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Linux route delete command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: Linux route delete command failed");
 
 #elif defined (_WIN32)
 
-    argv_printf(&argv, "%s%sc DELETE %s MASK %s %s",
-                get_win_sys_path(),
-                WIN_ROUTE_PATH_SUFFIX,
-                network,
-                netmask,
-                gateway);
+    argv_printf(&argv, "%s%sc DELETE %s MASK %s %s", get_win_sys_path(),
+                WIN_ROUTE_PATH_SUFFIX, network, netmask, gateway);
 
     argv_msg(D_ROUTE, &argv);
 
     if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_SERVICE)
     {
         const bool status = del_route_service(r, tt);
-        msg(D_ROUTE, "Route deletion via service %s", status ? "succeeded" : "failed");
+
+        msg(D_ROUTE, "Route deletion via service %s",
+            status ? "succeeded" : "failed");
     }
     else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
     {
         const bool status = del_route_ipapi(r, tt);
-        msg(D_ROUTE, "Route deletion via IPAPI %s", status ? "succeeded" : "failed");
+
+        msg(D_ROUTE, "Route deletion via IPAPI %s",
+            status ? "succeeded" : "failed");
     }
     else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_EXE)
     {
         netcmd_semaphore_lock();
-        openvpn_execve_check(&argv, es, 0, "ERROR: Windows route delete command failed");
+        openvpn_execve_check(&argv, es, 0,
+                             "ERROR: Windows route delete command failed");
         netcmd_semaphore_release();
     }
     else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_ADAPTIVE)
     {
         const bool status = del_route_ipapi(r, tt);
-        msg(D_ROUTE, "Route deletion via IPAPI %s [adaptive]", status ? "succeeded" : "failed");
+
+        msg(D_ROUTE, "Route deletion via IPAPI %s [adaptive]",
+            status ? "succeeded" : "failed");
         if (!status)
         {
             msg(D_ROUTE, "Route deletion fallback to route.exe");
             netcmd_semaphore_lock();
-            openvpn_execve_check(&argv, es, 0, "ERROR: Windows route delete command failed [adaptive]");
+            openvpn_execve_check(&argv, es, 0,
+                                 "ERROR: Windows route delete command failed [adaptive]");
             netcmd_semaphore_release();
         }
     }
@@ -2230,69 +2194,57 @@ delete_route(struct route_ipv4 *r,
 
 #elif defined (TARGET_SOLARIS)
 
-    argv_printf(&argv, "%s delete %s -netmask %s %s",
-                ROUTE_PATH,
-                network,
-                netmask,
-                gateway);
+    argv_printf(&argv, "%s delete %s -netmask %s %s", ROUTE_PATH, network,
+                netmask, gateway);
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route delete command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: Solaris route delete command failed");
 
 #elif defined(TARGET_FREEBSD)
 
-    argv_printf(&argv, "%s delete -net %s %s %s",
-                ROUTE_PATH,
-                network,
-                gateway,
+    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, gateway,
                 netmask);
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD route delete command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: FreeBSD route delete command failed");
 
 #elif defined(TARGET_DRAGONFLY)
 
-    argv_printf(&argv, "%s delete -net %s %s %s",
-                ROUTE_PATH,
-                network,
-                gateway,
+    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, gateway,
                 netmask);
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: DragonFly route delete command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: DragonFly route delete command failed");
 
 #elif defined(TARGET_DARWIN)
 
     if (is_on_link(is_local_route, flags, rgi))
     {
-        argv_printf(&argv, "%s delete -cloning -net %s -netmask %s -interface %s",
-                    ROUTE_PATH,
-                    network,
-                    netmask,
-                    rgi->iface);
+        argv_printf(&argv,
+                    "%s delete -cloning -net %s -netmask %s -interface %s",
+                    ROUTE_PATH, network, netmask, rgi->iface);
     }
     else
     {
-        argv_printf(&argv, "%s delete -net %s %s %s",
-                    ROUTE_PATH,
-                    network,
-                    gateway,
-                    netmask);
+        argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network,
+                    gateway, netmask);
     }
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: OS X route delete command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: OS X route delete command failed");
 
 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
-    argv_printf(&argv, "%s delete -net %s %s -netmask %s",
-                ROUTE_PATH,
-                network,
-                gateway,
-                netmask);
+    argv_printf(&argv, "%s delete -net %s %s -netmask %s", ROUTE_PATH, network,
+                gateway, netmask);
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: OpenBSD/NetBSD route delete command failed");
 
 #elif defined(TARGET_ANDROID)
     msg(M_NONFATAL, "Sorry, deleting routes on Android is not possible. The VpnService API allows routes to be set on connect only.");
@@ -2301,11 +2253,12 @@ delete_route(struct route_ipv4 *r,
 
     {
         int netbits = netmask_to_netbits2(r->netmask);
-        argv_printf(&argv, "%s delete -net %s/%d %s",
-                    ROUTE_PATH,
-                    network, netbits, gateway);
+
+        argv_printf(&argv, "%s delete -net %s/%d %s", ROUTE_PATH, network,
+                    netbits, gateway);
         argv_msg(D_ROUTE, &argv);
-        openvpn_execve_check(&argv, es, 0, "ERROR: AIX route delete command failed");
+        openvpn_execve_check(&argv, es, 0,
+                             "ERROR: AIX route delete command failed");
     }
 
 #else  /* if defined(TARGET_LINUX) */
@@ -2319,7 +2272,8 @@ done:
 }
 
 void
-delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
+                  unsigned int flags, const struct env_set *es)
 {
     struct gc_arena gc;
     struct argv argv = argv_new();
@@ -2328,7 +2282,7 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
     const char *device = tt->actual_name;
     bool gateway_needed = false;
 
-    if ((r6->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
+    if ((r6->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED | RT_ADDED))
     {
         return;
     }
@@ -2343,34 +2297,35 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
 
     gc_init(&gc);
 
-    network = print_in6_addr( r6->network, 0, &gc);
-    gateway = print_in6_addr( r6->gateway, 0, &gc);
+    network = print_in6_addr(r6->network, 0, &gc);
+    gateway = print_in6_addr(r6->gateway, 0, &gc);
 
-#if defined(TARGET_DARWIN)    \
-    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
+#if defined(TARGET_DARWIN)       \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)      \
     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
     /* the BSD platforms cannot specify gateway and interface independently,
      * but for link-local destinations, we MUST specify the interface, so
      * we build a combined "$gateway%$interface" gateway string
      */
-    if (r6->iface != NULL && gateway_needed
-        && IN6_IS_ADDR_LINKLOCAL(&r6->gateway) )        /* fe80::...%intf */
+    if ((r6->iface != NULL) && gateway_needed
+        && IN6_IS_ADDR_LINKLOCAL(&r6->gateway))        /* fe80::...%intf */
     {
-        int len = strlen(gateway) + 1 + strlen(r6->iface)+1;
-        char *tmp = gc_malloc( len, true, &gc );
-        snprintf( tmp, len, "%s%%%s", gateway, r6->iface );
+        int len = strlen(gateway) + 1 + strlen(r6->iface) + 1;
+        char *tmp = gc_malloc(len, true, &gc);
+
+        snprintf(tmp, len, "%s%%%s", gateway, r6->iface);
         gateway = tmp;
     }
 #endif
 
-    msg( M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits );
+    msg(M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits);
 
     /* if we used a gateway on "add route", we also need to specify it on
      * delete, otherwise some OSes will refuse to delete the route
      */
-    if (tt->type == DEV_TYPE_TAP
-        && !( (r6->flags & RT_METRIC_DEFINED) && r6->metric == 0 ) )
+    if ((tt->type == DEV_TYPE_TAP)
+        && !((r6->flags & RT_METRIC_DEFINED) && (r6->metric == 0)))
     {
         gateway_needed = true;
     }
@@ -2378,32 +2333,27 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
 
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s -6 route del %s/%d dev %s",
-                iproute_path,
-                network,
-                r6->netbits,
-                device);
+    argv_printf(&argv, "%s -6 route del %s/%d dev %s", iproute_path, network,
+                r6->netbits, device);
     if (gateway_needed)
     {
         argv_printf_cat(&argv, "via %s", gateway);
     }
 #else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s -A inet6 del %s/%d dev %s",
-                ROUTE_PATH,
-                network,
-                r6->netbits,
-                device);
+    argv_printf(&argv, "%s -A inet6 del %s/%d dev %s", ROUTE_PATH, network,
+                r6->netbits, device);
     if (gateway_needed)
     {
         argv_printf_cat(&argv, "gw %s", gateway);
     }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
+    if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
         argv_printf_cat(&argv, " metric %d", r6->metric);
     }
 #endif  /*ENABLE_IPROUTE*/
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Linux route -6/-A inet6 del command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: Linux route -6/-A inet6 del command failed");
 
 #elif defined (_WIN32)
 
@@ -2414,23 +2364,21 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
     else
     {
         struct buffer out = alloc_buf_gc(64, &gc);
+
         if (r6->adapter_index)          /* vpn server special route */
         {
-            buf_printf(&out, "interface=%d", r6->adapter_index );
+            buf_printf(&out, "interface=%d", r6->adapter_index);
             gateway_needed = true;
         }
         else
         {
-            buf_printf(&out, "interface=%d", tt->adapter_index );
+            buf_printf(&out, "interface=%d", tt->adapter_index);
         }
         device = buf_bptr(&out);
 
         /* netsh interface ipv6 delete route 2001:db8::/32 MyTunDevice */
         argv_printf(&argv, "%s%sc interface ipv6 delete route %s/%d %s",
-                    get_win_sys_path(),
-                    NETSH_PATH_SUFFIX,
-                    network,
-                    r6->netbits,
+                    get_win_sys_path(), NETSH_PATH_SUFFIX, network, r6->netbits,
                     device);
 
         /* next-hop depends on TUN or TAP mode:
@@ -2439,13 +2387,13 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
          *   knows about and will answer ND (neighbor discovery) packets for
          * (and "route deletion without specifying next-hop" does not work...)
          */
-        if (tt->type == DEV_TYPE_TUN && !gateway_needed)
+        if ((tt->type == DEV_TYPE_TUN) && !gateway_needed)
         {
-            argv_printf_cat( &argv, " %s", "fe80::8" );
+            argv_printf_cat(&argv, " %s", "fe80::8");
         }
-        else if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
+        else if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway))
         {
-            argv_printf_cat( &argv, " %s", gateway );
+            argv_printf_cat(&argv, " %s", gateway);
         }
 
 #if 0
@@ -2459,12 +2407,13 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
          * in Windows 8(.1?), if you create them with "store=active", this is
          * how you should delete them as well (pointed out by Cedric Tabary)
          */
-        argv_printf_cat( &argv, " store=active" );
+        argv_printf_cat(&argv, " store=active");
 
         argv_msg(D_ROUTE, &argv);
 
         netcmd_semaphore_lock();
-        openvpn_execve_check(&argv, es, 0, "ERROR: Windows route delete ipv6 command failed");
+        openvpn_execve_check(&argv, es, 0,
+                             "ERROR: Windows route delete ipv6 command failed");
         netcmd_semaphore_release();
     }
 
@@ -2472,21 +2421,17 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
 
     /* example: route delete -inet6 2001:db8::/32 somegateway */
 
-    argv_printf(&argv, "%s delete -inet6 %s/%d %s",
-                ROUTE_PATH,
-                network,
-                r6->netbits,
-                gateway );
+    argv_printf(&argv, "%s delete -inet6 %s/%d %s", ROUTE_PATH, network,
+                r6->netbits, gateway);
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route delete -inet6 command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: Solaris route delete -inet6 command failed");
 
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
-    argv_printf(&argv, "%s delete -inet6 %s/%d",
-                ROUTE_PATH,
-                network,
-                r6->netbits );
+    argv_printf(&argv, "%s delete -inet6 %s/%d", ROUTE_PATH, network,
+                r6->netbits);
 
     if (gateway_needed)
     {
@@ -2498,13 +2443,13 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
     }
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: *BSD route delete -inet6 command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: *BSD route delete -inet6 command failed");
 
 #elif defined(TARGET_DARWIN)
 
-    argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d",
-                ROUTE_PATH,
-                network, r6->netbits );
+    argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d", ROUTE_PATH,
+                network, r6->netbits);
 
     if (gateway_needed)
     {
@@ -2516,31 +2461,31 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
     }
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: MacOS X route delete -inet6 command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: MacOS X route delete -inet6 command failed");
 
 #elif defined(TARGET_OPENBSD)
 
-    argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d %s",
-                ROUTE_PATH,
-                network, r6->netbits, gateway );
+    argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d %s", ROUTE_PATH,
+                network, r6->netbits, gateway);
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD route delete -inet6 command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: OpenBSD route delete -inet6 command failed");
 
 #elif defined(TARGET_NETBSD)
 
-    argv_printf(&argv, "%s delete -inet6 %s/%d %s",
-                ROUTE_PATH,
-                network, r6->netbits, gateway );
+    argv_printf(&argv, "%s delete -inet6 %s/%d %s", ROUTE_PATH, network,
+                r6->netbits, gateway);
 
     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: NetBSD route delete -inet6 command failed");
+    openvpn_execve_check(&argv, es, 0,
+                         "ERROR: NetBSD route delete -inet6 command failed");
 
 #elif defined(TARGET_AIX)
 
-    argv_printf(&argv, "%s delete -inet6 %s/%d %s",
-                ROUTE_PATH,
-                network, r6->netbits, gateway);
+    argv_printf(&argv, "%s delete -inet6 %s/%d %s", ROUTE_PATH, network,
+                r6->netbits, gateway);
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
 
@@ -2574,35 +2519,32 @@ get_windows_routing_table(struct gc_arena *gc)
         if (status != NO_ERROR)
         {
             msg(D_ROUTE, "NOTE: GetIpForwardTable returned error: %s (code=%u)",
-                strerror_win32(status, gc),
-                (unsigned int)status);
+                strerror_win32(status, gc), (unsigned int)status);
             rt = NULL;
         }
     }
+
     return rt;
 }
 
 static int
-test_route(const IP_ADAPTER_INFO *adapters,
-           const in_addr_t gateway,
+test_route(const IP_ADAPTER_INFO *adapters, const in_addr_t gateway,
            DWORD *index)
 {
     int count = 0;
     DWORD i = adapter_index_of_ip(adapters, gateway, &count, NULL);
+
     if (index)
     {
         *index = i;
     }
+
     return count;
 }
 
 static void
-test_route_helper(bool *ret,
-                  int *count,
-                  int *good,
-                  int *ambig,
-                  const IP_ADAPTER_INFO *adapters,
-                  const in_addr_t gateway)
+test_route_helper(bool *ret, int *count, int *good, int *ambig,
+                  const IP_ADAPTER_INFO *adapters, const in_addr_t gateway)
 {
     int c;
 
@@ -2645,27 +2587,27 @@ test_routes(const struct route_list *rl, const struct tuntap *tt)
         if (rl)
         {
             struct route_ipv4 *r;
+
             for (r = rl->routes, len = 0; r; r = r->next, ++len)
             {
-                test_route_helper(&ret, &count, &good, &ambig, adapters, r->gateway);
+                test_route_helper(&ret, &count, &good, &ambig, adapters,
+                                  r->gateway);
             }
 
-            if ((rl->flags & RG_ENABLE) && (rl->spec.flags & RTSA_REMOTE_ENDPOINT))
+            if ((rl->flags & RG_ENABLE)
+                && (rl->spec.flags & RTSA_REMOTE_ENDPOINT))
             {
-                test_route_helper(&ret, &count, &good, &ambig, adapters, rl->spec.remote_endpoint);
+                test_route_helper(&ret, &count, &good, &ambig, adapters,
+                                  rl->spec.remote_endpoint);
             }
         }
     }
 
     msg(D_ROUTE, "TEST ROUTES: %d/%d succeeded len=%d ret=%d a=%d u/d=%s",
-        good,
-        count,
-        len,
-        (int)ret,
-        ambig,
-        adapter_up ? "up" : "down");
+        good, count, len, (int)ret, ambig, adapter_up ? "up" : "down");
 
     gc_free(&gc);
+
     return ret;
 }
 
@@ -2689,13 +2631,11 @@ get_default_gateway_row(const MIB_IPFORWARDTABLE *routes)
             const DWORD metric = row->dwForwardMetric1;
 
             dmsg(D_ROUTE_DEBUG, "GDGR: route[%d] %s/%s i=%d m=%d",
-                 i,
-                 print_in_addr_t((in_addr_t) net, 0, &gc),
-                 print_in_addr_t((in_addr_t) mask, 0, &gc),
-                 (int)index,
+                 i, print_in_addr_t((in_addr_t) net, 0, &gc),
+                 print_in_addr_t((in_addr_t) mask, 0, &gc), (int)index,
                  (int)metric);
 
-            if (!net && !mask && metric < lowest_metric)
+            if (!net && !mask && (metric < lowest_metric))
             {
                 ret = row;
                 lowest_metric = metric;
@@ -2704,9 +2644,11 @@ get_default_gateway_row(const MIB_IPFORWARDTABLE *routes)
         }
     }
 
-    dmsg(D_ROUTE_DEBUG, "GDGR: best=%d lm=%u", best, (unsigned int)lowest_metric);
+    dmsg(D_ROUTE_DEBUG, "GDGR: best=%d lm=%u", best,
+         (unsigned int)lowest_metric);
 
     gc_free(&gc);
+
     return ret;
 }
 
@@ -2729,7 +2671,8 @@ get_default_gateway(struct route_gateway_info *rgi)
         if (rgi->gateway.addr)
         {
             rgi->flags |= RGI_ADDR_DEFINED;
-            a_index = adapter_index_of_ip(adapters, rgi->gateway.addr, NULL, &rgi->gateway.netmask);
+            a_index = adapter_index_of_ip(adapters, rgi->gateway.addr, NULL,
+                                          &rgi->gateway.netmask);
             if (a_index != TUN_ADAPTER_INDEX_INVALID)
             {
                 rgi->adapter_index = a_index;
@@ -2771,24 +2714,23 @@ windows_route_find_if_index(const struct route_ipv4 *r, const struct tuntap *tt)
 
     if (count == 0)
     {
-        msg(M_WARN, "Warning: route gateway is not reachable on any active network adapters: %s",
+        msg(M_WARN,
+            "Warning: route gateway is not reachable on any active network adapters: %s",
             print_in_addr_t(r->gateway, 0, &gc));
         ret = TUN_ADAPTER_INDEX_INVALID;
     }
     else if (count > 1)
     {
         msg(M_WARN, "Warning: route gateway is ambiguous: %s (%d matches)",
-            print_in_addr_t(r->gateway, 0, &gc),
-            count);
+            print_in_addr_t(r->gateway, 0, &gc), count);
         ret = TUN_ADAPTER_INDEX_INVALID;
     }
 
     dmsg(D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=%d count=%d index=%d",
-         on_tun,
-         count,
-         (int)ret);
+         on_tun, count, (int)ret);
 
     gc_free(&gc);
+
     return ret;
 }
 
@@ -2818,47 +2760,43 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
         DestinationAddress.Ipv6.sin6_addr = *dest;
     }
 
-    status = GetBestInterfaceEx( &DestinationAddress, &BestIfIndex );
+    status = GetBestInterfaceEx(&DestinationAddress, &BestIfIndex);
 
     if (status != NO_ERROR)
     {
         msg(D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=%u)",
-            strerror_win32(status, &gc),
-            (unsigned int)status);
+            strerror_win32(status, &gc), (unsigned int)status);
         goto done;
     }
 
-    msg( D_ROUTE, "GetBestInterfaceEx() returned if=%d", (int) BestIfIndex );
+    msg(D_ROUTE, "GetBestInterfaceEx() returned if=%d", (int)BestIfIndex);
 
-    status = GetBestRoute2( &InterfaceLuid, BestIfIndex, NULL,
-                            &DestinationAddress, 0,
-                            &BestRoute, &BestSourceAddress );
+    status = GetBestRoute2(&InterfaceLuid, BestIfIndex, NULL,
+                           &DestinationAddress, 0, &BestRoute,
+                           &BestSourceAddress);
 
     if (status != NO_ERROR)
     {
         msg(D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=%u)",
-            strerror_win32(status, &gc),
-            (unsigned int)status);
+            strerror_win32(status, &gc), (unsigned int)status);
         goto done;
     }
 
-    msg( D_ROUTE, "GDG6: II=%d DP=%s/%d NH=%s",
-         BestRoute.InterfaceIndex,
-         print_in6_addr( BestRoute.DestinationPrefix.Prefix.Ipv6.sin6_addr, 0, &gc),
-         BestRoute.DestinationPrefix.PrefixLength,
-         print_in6_addr( BestRoute.NextHop.Ipv6.sin6_addr, 0, &gc) );
-    msg( D_ROUTE, "GDG6: Metric=%d, Loopback=%d, AA=%d, I=%d",
-         (int) BestRoute.Metric,
-         (int) BestRoute.Loopback,
-         (int) BestRoute.AutoconfigureAddress,
-         (int) BestRoute.Immortal );
+    msg(D_ROUTE, "GDG6: II=%d DP=%s/%d NH=%s", BestRoute.InterfaceIndex,
+        print_in6_addr(BestRoute.DestinationPrefix.Prefix.Ipv6.sin6_addr, 0,
+                       &gc),
+        BestRoute.DestinationPrefix.PrefixLength,
+        print_in6_addr(BestRoute.NextHop.Ipv6.sin6_addr, 0, &gc));
+    msg(D_ROUTE, "GDG6: Metric=%d, Loopback=%d, AA=%d, I=%d",
+        (int)BestRoute.Metric, (int)BestRoute.Loopback,
+        (int)BestRoute.AutoconfigureAddress, (int)BestRoute.Immortal);
 
     rgi6->gateway.addr_ipv6 = BestRoute.NextHop.Ipv6.sin6_addr;
-    rgi6->adapter_index     = BestRoute.InterfaceIndex;
+    rgi6->adapter_index = BestRoute.InterfaceIndex;
     rgi6->flags |= RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
 
     /* on-link is signalled by receiving an empty (::) NextHop */
-    if (IN6_IS_ADDR_UNSPECIFIED(&BestRoute.NextHop.Ipv6.sin6_addr) )
+    if (IN6_IS_ADDR_UNSPECIFIED(&BestRoute.NextHop.Ipv6.sin6_addr))
     {
         rgi6->flags |= RGI_ON_LINK;
     }
@@ -2868,125 +2806,152 @@ done:
 }
 
 bool
-add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapter_index)
+add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt,
+                DWORD adapter_index)
 {
-    struct gc_arena gc = gc_new();
+    struct gc_arena gc;
     bool ret = false;
     DWORD status;
-    const DWORD if_index = (adapter_index == TUN_ADAPTER_INDEX_INVALID) ? windows_route_find_if_index(r, tt) : adapter_index;
-
-    if (if_index != TUN_ADAPTER_INDEX_INVALID)
-    {
-        MIB_IPFORWARDROW fr;
-        CLEAR(fr);
-        fr.dwForwardDest = htonl(r->network);
-        fr.dwForwardMask = htonl(r->netmask);
-        fr.dwForwardPolicy = 0;
-        fr.dwForwardNextHop = htonl(r->gateway);
-        fr.dwForwardIfIndex = if_index;
-        fr.dwForwardType = 4; /* the next hop is not the final dest */
-        fr.dwForwardProto = 3; /* PROTO_IP_NETMGMT */
-        fr.dwForwardAge = 0;
-        fr.dwForwardNextHopAS = 0;
-        fr.dwForwardMetric1 = (r->flags & RT_METRIC_DEFINED) ? r->metric : 1;
-        fr.dwForwardMetric2 = METRIC_NOT_USED;
-        fr.dwForwardMetric3 = METRIC_NOT_USED;
-        fr.dwForwardMetric4 = METRIC_NOT_USED;
-        fr.dwForwardMetric5 = METRIC_NOT_USED;
-
-        if ((r->network & r->netmask) != r->network)
-        {
-            msg(M_WARN, "Warning: address %s is not a network address in relation to netmask %s",
-                print_in_addr_t(r->network, 0, &gc),
-                print_in_addr_t(r->netmask, 0, &gc));
-        }
+    DWORD if_index;
 
-        status = CreateIpForwardEntry(&fr);
+    if (adapter_index == TUN_ADAPTER_INDEX_INVALID)
+    {
+        if_index = windows_route_find_if_index(r, tt);
+    }
+    else
+    {
+        if_index = adapter_index;
+    }
 
-        if (status == NO_ERROR)
-        {
-            ret = true;
-        }
-        else
-        {
-            /* failed, try increasing the metric to work around Vista issue */
-            const unsigned int forward_metric_limit = 2048; /* iteratively retry higher metrics up to this limit */
+    if (if_index == TUN_ADAPTER_INDEX_INVALID)
+    {
+        return false;
+    }
 
-            for (; fr.dwForwardMetric1 <= forward_metric_limit; ++fr.dwForwardMetric1)
+    gc = gc_new();
+    MIB_IPFORWARDROW fr;
+    CLEAR(fr);
+    fr.dwForwardDest = htonl(r->network);
+    fr.dwForwardMask = htonl(r->netmask);
+    fr.dwForwardPolicy = 0;
+    fr.dwForwardNextHop = htonl(r->gateway);
+    fr.dwForwardIfIndex = if_index;
+    fr.dwForwardType = 4; /* the next hop is not the final dest */
+    fr.dwForwardProto = 3; /* PROTO_IP_NETMGMT */
+    fr.dwForwardAge = 0;
+    fr.dwForwardNextHopAS = 0;
+    fr.dwForwardMetric1 = (r->flags & RT_METRIC_DEFINED) ? r->metric : 1;
+    fr.dwForwardMetric2 = METRIC_NOT_USED;
+    fr.dwForwardMetric3 = METRIC_NOT_USED;
+    fr.dwForwardMetric4 = METRIC_NOT_USED;
+    fr.dwForwardMetric5 = METRIC_NOT_USED;
+
+    if ((r->network & r->netmask) != r->network)
+    {
+        msg(M_WARN,
+            "Warning: address %s is not a network address in relation to netmask %s",
+            print_in_addr_t(r->network, 0, &gc),
+            print_in_addr_t(r->netmask, 0, &gc));
+    }
+
+    status = CreateIpForwardEntry(&fr);
+
+    if (status == NO_ERROR)
+    {
+        ret = true;
+    }
+    else
+    {
+        /* failed, try increasing the metric to work around Vista issue */
+
+        /* iteratively retry higher metrics up to this limit */
+        const unsigned int forward_metric_limit = 2048;
+
+        for (; fr.dwForwardMetric1 <= forward_metric_limit;
+             ++fr.dwForwardMetric1)
+        {
+            /* try a different forward type=3 ("the next hop is the final
+             * dest") in addition to 4. --redirect-gateway over RRAS seems
+             * to need this. */
+            for (fr.dwForwardType = 4; fr.dwForwardType >= 3;
+                 --fr.dwForwardType)
             {
-                /* try a different forward type=3 ("the next hop is the final dest") in addition to 4.
-                 * --redirect-gateway over RRAS seems to need this. */
-                for (fr.dwForwardType = 4; fr.dwForwardType >= 3; --fr.dwForwardType)
+                status = CreateIpForwardEntry(&fr);
+                if (status == NO_ERROR)
                 {
-                    status = CreateIpForwardEntry(&fr);
-                    if (status == NO_ERROR)
-                    {
-                        msg(D_ROUTE, "ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=%u and dwForwardType=%u",
-                            (unsigned int)fr.dwForwardMetric1,
-                            (unsigned int)fr.dwForwardType);
-                        ret = true;
-                        goto doublebreak;
-                    }
-                    else if (status != ERROR_BAD_ARGUMENTS)
-                    {
-                        goto doublebreak;
-                    }
+                    msg(D_ROUTE,
+                        "ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=%u and dwForwardType=%u",
+                        (unsigned int)fr.dwForwardMetric1,
+                        (unsigned int)fr.dwForwardType);
+                    ret = true;
+                    goto doublebreak;
+                }
+                else if (status != ERROR_BAD_ARGUMENTS)
+                {
+                    goto doublebreak;
                 }
             }
+        }
 
 doublebreak:
-            if (status != NO_ERROR)
-            {
-                msg(M_WARN, "ROUTE: route addition failed using CreateIpForwardEntry: %s [status=%u if_index=%u]",
-                    strerror_win32(status, &gc),
-                    (unsigned int)status,
-                    (unsigned int)if_index);
-            }
+        if (status != NO_ERROR)
+        {
+            msg(M_WARN,
+                "ROUTE: route addition failed using CreateIpForwardEntry: %s [status=%u if_index=%u]",
+                strerror_win32(status, &gc), (unsigned int)status,
+                (unsigned int)if_index);
         }
     }
 
     gc_free(&gc);
+
     return ret;
 }
 
 bool
 del_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt)
 {
-    struct gc_arena gc = gc_new();
+    struct gc_arena gc;
     bool ret = false;
     DWORD status;
     const DWORD if_index = windows_route_find_if_index(r, tt);
 
-    if (if_index != TUN_ADAPTER_INDEX_INVALID)
+    if (if_index == TUN_ADAPTER_INDEX_INVALID)
     {
-        MIB_IPFORWARDROW fr;
-        CLEAR(fr);
+        return false;
+    }
 
-        fr.dwForwardDest = htonl(r->network);
-        fr.dwForwardMask = htonl(r->netmask);
-        fr.dwForwardPolicy = 0;
-        fr.dwForwardNextHop = htonl(r->gateway);
-        fr.dwForwardIfIndex = if_index;
+    gc = gc_new();
+    MIB_IPFORWARDROW fr;
+    CLEAR(fr);
 
-        status = DeleteIpForwardEntry(&fr);
+    fr.dwForwardDest = htonl(r->network);
+    fr.dwForwardMask = htonl(r->netmask);
+    fr.dwForwardPolicy = 0;
+    fr.dwForwardNextHop = htonl(r->gateway);
+    fr.dwForwardIfIndex = if_index;
 
-        if (status == NO_ERROR)
-        {
-            ret = true;
-        }
-        else
-        {
-            msg(M_WARN, "ROUTE: route deletion failed using DeleteIpForwardEntry: %s",
-                strerror_win32(status, &gc));
-        }
+    status = DeleteIpForwardEntry(&fr);
+
+    if (status == NO_ERROR)
+    {
+        ret = true;
+    }
+    else
+    {
+        msg(M_WARN,
+            "ROUTE: route deletion failed using DeleteIpForwardEntry: %s",
+            strerror_win32(status, &gc));
     }
 
     gc_free(&gc);
+
     return ret;
 }
 
 static bool
-do_route_service(const bool add, const route_message_t *rt, const size_t size, HANDLE pipe)
+do_route_service(const bool add, const route_message_t *rt, const size_t size,
+                 HANDLE pipe)
 {
     DWORD len;
     bool ret = false;
@@ -3003,9 +2968,11 @@ do_route_service(const bool add, const route_message_t *rt, const size_t size, H
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%lu]",
-            (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
-            ack.error_number, rt->iface.index);
+        msg(M_WARN,
+            "ROUTE: route %s failed using service: %s [status=%u if_index=%lu]",
+            (add ? "addition" : "deletion"),
+            strerror_win32(ack.error_number, &gc), ack.error_number,
+            rt->iface.index);
         goto out;
     }
 
@@ -3013,13 +2980,16 @@ do_route_service(const bool add, const route_message_t *rt, const size_t size, H
 
 out:
     gc_free(&gc);
+
     return ret;
 }
 
 static bool
-do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct tuntap *tt)
+do_route_ipv4_service(const bool add, const struct route_ipv4 *r,
+                      const struct tuntap *tt)
 {
     DWORD if_index = windows_route_find_if_index(r, tt);
+
     if (if_index == ~0)
     {
         return false;
@@ -3048,7 +3018,8 @@ do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct t
 }
 
 static bool
-do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct tuntap *tt)
+do_route_ipv6_service(const bool add, const struct route_ipv6 *r,
+                      const struct tuntap *tt)
 {
     bool status;
     route_message_t msg = {
@@ -3062,7 +3033,7 @@ do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct t
         .prefix_len = r->netbits,
         .gateway.ipv6 = r->gateway,
         .iface = { .index = tt->adapter_index, .name = "" },
-        .metric = ( (r->flags & RT_METRIC_DEFINED) ? r->metric : -1)
+        .metric = ((r->flags & RT_METRIC_DEFINED) ? r->metric : -1)
     };
 
     if (r->adapter_index)               /* vpn server special route */
@@ -3074,8 +3045,8 @@ do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct t
      * The tapdrvr knows about it and will answer neighbor discovery packets.
      * (only do this for routes actually using the tun/tap device)
      */
-    if (tt->type == DEV_TYPE_TUN
-	 && msg.iface.index == tt->adapter_index )
+    if ((tt->type == DEV_TYPE_TUN)
+        && (msg.iface.index == tt->adapter_index))
     {
         inet_pton(AF_INET6, "fe80::8", &msg.gateway.ipv6);
     }
@@ -3087,9 +3058,9 @@ do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct t
     }
 
     status = do_route_service(add, &msg, sizeof(msg), tt->options.msg_channel);
-    msg(D_ROUTE, "IPv6 route %s via service %s",
-        add ? "addition" : "deletion",
+    msg(D_ROUTE, "IPv6 route %s via service %s", add ? "addition" : "deletion",
         status ? "succeeded" : "failed");
+
     return status;
 }
 
@@ -3125,17 +3096,13 @@ format_route_entry(const MIB_IPFORWARDROW *r, struct gc_arena *gc)
                print_in_addr_t(r->dwForwardDest, IA_NET_ORDER, gc),
                print_in_addr_t(r->dwForwardMask, IA_NET_ORDER, gc),
                print_in_addr_t(r->dwForwardNextHop, IA_NET_ORDER, gc),
-               (int)r->dwForwardPolicy,
-               (int)r->dwForwardIfIndex,
-               (int)r->dwForwardType,
-               (int)r->dwForwardProto,
-               (int)r->dwForwardAge,
-               (int)r->dwForwardNextHopAS,
-               (int)r->dwForwardMetric1,
-               (int)r->dwForwardMetric2,
-               (int)r->dwForwardMetric3,
-               (int)r->dwForwardMetric4,
+               (int)r->dwForwardPolicy, (int)r->dwForwardIfIndex,
+               (int)r->dwForwardType, (int)r->dwForwardProto,
+               (int)r->dwForwardAge, (int)r->dwForwardNextHopAS,
+               (int)r->dwForwardMetric1, (int)r->dwForwardMetric2,
+               (int)r->dwForwardMetric3, (int)r->dwForwardMetric4,
                (int)r->dwForwardMetric5);
+
     return BSTR(&out);
 }
 
@@ -3196,13 +3163,9 @@ get_default_gateway(struct route_gateway_info *rgi)
                     char name[16];
                     name[0] = 0;
                     const int np = sscanf(line, "%15s\t%x\t%x\t%x\t%*s\t%*s\t%d\t%x",
-                                          name,
-                                          &net_x,
-                                          &gw_x,
-                                          &flags,
-                                          &metric,
+                                          name, &net_x, &gw_x, &flags, &metric,
                                           &mask_x);
-                    if (np == 6 && (flags & IFF_UP))
+                    if ((np == 6) && (flags & IFF_UP))
                     {
                         const in_addr_t net = ntohl(net_x);
                         const in_addr_t mask = ntohl(mask_x);
@@ -3260,6 +3223,7 @@ get_default_gateway(struct route_gateway_info *rgi)
             msg(M_WARN, "GDG: socket() failed");
             goto done;
         }
+
         ifc.ifc_len = sizeof(ifs);
         ifc.ifc_req = ifs;
         if (ioctl(sd, SIOCGIFCONF, &ifc) < 0)
@@ -3272,80 +3236,84 @@ get_default_gateway(struct route_gateway_info *rgi)
         ifend = ifs + (ifc.ifc_len / sizeof(struct ifreq));
         for (ifr = ifc.ifc_req; ifr < ifend; ifr++)
         {
-            if (ifr->ifr_addr.sa_family == AF_INET)
+            if (ifr->ifr_addr.sa_family != AF_INET)
             {
-                /* get interface addr */
-                addr = ntohl(((struct sockaddr_in *) &ifr->ifr_addr)->sin_addr.s_addr);
+                continue;
+            }
 
-                /* get interface name */
-                strncpynt(ifreq.ifr_name, ifr->ifr_name, sizeof(ifreq.ifr_name));
+            /* get interface addr */
+            struct sockaddr_in *sk_addr = (struct sockaddr_in *)&ifr->ifr_addr;
+            addr = ntohl(sk_addr->sin_addr.s_addr);
 
-                /* check that the interface is up */
-                if (ioctl(sd, SIOCGIFFLAGS, &ifreq) < 0)
-                {
-                    continue;
-                }
-                if (!(ifreq.ifr_flags & IFF_UP))
+            /* get interface name */
+            strncpynt(ifreq.ifr_name, ifr->ifr_name, sizeof(ifreq.ifr_name));
+
+            /* check that the interface is up */
+            if (ioctl(sd, SIOCGIFFLAGS, &ifreq) < 0)
+            {
+                continue;
+            }
+            if (!(ifreq.ifr_flags & IFF_UP))
+            {
+                continue;
+            }
+
+            if (rgi->flags & RGI_ON_LINK)
+            {
+                /* check that interface name of current interface
+                 * matches interface name of best default route */
+                if (strcmp(ifreq.ifr_name, best_name))
                 {
                     continue;
                 }
-
-                if (rgi->flags & RGI_ON_LINK)
+#if 0
+                /* if point-to-point link, use remote addr as route gateway */
+                if ((ifreq.ifr_flags & IFF_POINTOPOINT)
+                    && (ioctl(sd, SIOCGIFDSTADDR, &ifreq) >= 0))
                 {
-                    /* check that interface name of current interface
-                     * matches interface name of best default route */
-                    if (strcmp(ifreq.ifr_name, best_name))
+                    rgi->gateway.addr = ntohl(addr->sin_addr.s_addr);
+                    if (rgi->gateway.addr)
                     {
-                        continue;
+                        rgi->flags &= ~RGI_ON_LINK;
                     }
-#if 0
-                    /* if point-to-point link, use remote addr as route gateway */
-                    if ((ifreq.ifr_flags & IFF_POINTOPOINT) && ioctl(sd, SIOCGIFDSTADDR, &ifreq) >= 0)
-                    {
-                        rgi->gateway.addr = ntohl(((struct sockaddr_in *) &ifreq.ifr_addr)->sin_addr.s_addr);
-                        if (rgi->gateway.addr)
-                        {
-                            rgi->flags &= ~RGI_ON_LINK;
-                        }
-                    }
-#endif
                 }
-                else
+#endif
+            }
+            else
+            {
+                /* get interface netmask */
+                if (ioctl(sd, SIOCGIFNETMASK, &ifreq) < 0)
                 {
-                    /* get interface netmask */
-                    if (ioctl(sd, SIOCGIFNETMASK, &ifreq) < 0)
-                    {
-                        continue;
-                    }
-                    netmask = ntohl(((struct sockaddr_in *) &ifreq.ifr_addr)->sin_addr.s_addr);
-
-                    /* check that interface matches default route */
-                    if (((rgi->gateway.addr ^ addr) & netmask) != 0)
-                    {
-                        continue;
-                    }
-
-                    /* save netmask */
-                    rgi->gateway.netmask = netmask;
-                    rgi->flags |= RGI_NETMASK_DEFINED;
+                    continue;
                 }
+                netmask = ntohl(sk_addr->sin_addr.s_addr);
 
-                /* save iface name */
-                strncpynt(rgi->iface, ifreq.ifr_name, sizeof(rgi->iface));
-                rgi->flags |= RGI_IFACE_DEFINED;
-
-                /* now get the hardware address. */
-                memset(&ifreq.ifr_hwaddr, 0, sizeof(struct sockaddr));
-                if (ioctl(sd, SIOCGIFHWADDR, &ifreq) < 0)
+                /* check that interface matches default route */
+                if (((rgi->gateway.addr ^ addr) & netmask) != 0)
                 {
-                    msg(M_WARN, "GDG: SIOCGIFHWADDR(%s) failed", ifreq.ifr_name);
-                    goto done;
+                    continue;
                 }
-                memcpy(rgi->hwaddr, &ifreq.ifr_hwaddr.sa_data, 6);
-                rgi->flags |= RGI_HWADDR_DEFINED;
 
-                break;
+                /* save netmask */
+                rgi->gateway.netmask = netmask;
+                rgi->flags |= RGI_NETMASK_DEFINED;
+            }
+
+            /* save iface name */
+            strncpynt(rgi->iface, ifreq.ifr_name, sizeof(rgi->iface));
+            rgi->flags |= RGI_IFACE_DEFINED;
+
+            /* now get the hardware address. */
+            memset(&ifreq.ifr_hwaddr, 0, sizeof(struct sockaddr));
+            if (ioctl(sd, SIOCGIFHWADDR, &ifreq) < 0)
+            {
+                msg(M_WARN, "GDG: SIOCGIFHWADDR(%s) failed", ifreq.ifr_name);
+                goto done;
             }
+            memcpy(rgi->hwaddr, &ifreq.ifr_hwaddr.sa_data, 6);
+            rgi->flags |= RGI_HWADDR_DEFINED;
+
+            break;
         }
     }
 
@@ -3375,16 +3343,16 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     int nls = -1;
     struct rtreq rtreq;
     struct rtattr *rta;
-
     char rtbuf[2000];
     ssize_t ssize;
 
     CLEAR(*rgi6);
 
-    nls = socket( PF_NETLINK, SOCK_RAW, NETLINK_ROUTE );
+    nls = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
     if (nls < 0)
     {
-        msg(M_WARN|M_ERRNO, "GDG6: socket() failed" ); goto done;
+        msg(M_WARN|M_ERRNO, "GDG6: socket() failed");
+        goto done;
     }
 
     /* bind() is not needed, no unsolicited msgs coming in */
@@ -3405,41 +3373,43 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     rta = (struct rtattr *)(((char *) &rtreq)+NLMSG_ALIGN(rtreq.nh.nlmsg_len));
     rta->rta_type = RTA_DST;
     rta->rta_len = RTA_LENGTH(16);
-    rtreq.nh.nlmsg_len = NLMSG_ALIGN(rtreq.nh.nlmsg_len)
-                         +RTA_LENGTH(16);
+    rtreq.nh.nlmsg_len = NLMSG_ALIGN(rtreq.nh.nlmsg_len) + RTA_LENGTH(16);
 
     if (dest == NULL)                   /* ::, unspecified */
     {
-        memset( RTA_DATA(rta), 0, 16 ); /* :: = all-zero */
+        memset(RTA_DATA(rta), 0, 16); /* :: = all-zero */
     }
     else
     {
-        memcpy( RTA_DATA(rta), (void *)dest, 16 );
+        memcpy(RTA_DATA(rta), (void *)dest, 16);
     }
 
     /* send and receive reply */
-    if (send( nls, &rtreq, rtreq.nh.nlmsg_len, 0 ) < 0)
+    if (send(nls, &rtreq, rtreq.nh.nlmsg_len, 0) < 0)
     {
-        msg(M_WARN|M_ERRNO, "GDG6: send() failed" ); goto done;
+        msg(M_WARN|M_ERRNO, "GDG6: send() failed");
+        goto done;
     }
 
     ssize = recv(nls, rtbuf, sizeof(rtbuf), MSG_TRUNC);
 
     if (ssize < 0)
     {
-        msg(M_WARN|M_ERRNO, "GDG6: recv() failed" ); goto done;
+        msg(M_WARN|M_ERRNO, "GDG6: recv() failed");
+        goto done;
     }
 
     if (ssize > sizeof(rtbuf))
     {
-        msg(M_WARN, "get_default_gateway_ipv6: returned message too big for buffer (%d>%d)", (int)ssize, (int)sizeof(rtbuf) );
+        msg(M_WARN,
+            "get_default_gateway_ipv6: returned message too big for buffer (%d>%d)",
+            (int)ssize, (int)sizeof(rtbuf));
         goto done;
     }
 
     struct nlmsghdr *nh;
 
-    for (nh = (struct nlmsghdr *)rtbuf;
-         NLMSG_OK(nh, ssize);
+    for (nh = (struct nlmsghdr *)rtbuf; NLMSG_OK(nh, ssize);
          nh = NLMSG_NEXT(nh, ssize))
     {
         struct rtmsg *rtm;
@@ -3467,7 +3437,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
         if (nh->nlmsg_type != RTM_NEWROUTE)
         {
             /* shouldn't happen */
-            msg(M_WARN, "GDG6: unexpected msg_type %d", nh->nlmsg_type );
+            msg(M_WARN, "GDG6: unexpected msg_type %d", nh->nlmsg_type);
             continue;
         }
 
@@ -3477,19 +3447,18 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
         /* we're only looking for routes in the main table, as "we have
          * no IPv6" will lead to a lookup result in "Local" (::/0 reject)
          */
-        if (rtm->rtm_family != AF_INET6
-            || rtm->rtm_table != RT_TABLE_MAIN)
+        if ((rtm->rtm_family != AF_INET6)
+            || (rtm->rtm_table != RT_TABLE_MAIN))
         {
+            /* we're not interested */
             continue;
-        }                               /* we're not interested */
-
-        for (rta = RTM_RTA(rtm);
-             RTA_OK(rta, attrlen);
+        }
+        for (rta = RTM_RTA(rtm); RTA_OK(rta, attrlen);
              rta = RTA_NEXT(rta, attrlen))
         {
             if (rta->rta_type == RTA_GATEWAY)
             {
-                if (RTA_PAYLOAD(rta) != sizeof(struct in6_addr) )
+                if (RTA_PAYLOAD(rta) != sizeof(struct in6_addr))
                 {
                     msg(M_WARN, "GDG6: RTA_GW size mismatch"); continue;
                 }
@@ -3498,24 +3467,26 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
             }
             else if (rta->rta_type == RTA_OIF)
             {
-                char ifname[IF_NAMESIZE+1];
+                char ifname[IF_NAMESIZE + 1];
                 int oif;
-                if (RTA_PAYLOAD(rta) != sizeof(oif) )
+
+                if (RTA_PAYLOAD(rta) != sizeof(oif))
                 {
-                    msg(M_WARN, "GDG6: oif size mismatch"); continue;
+                    msg(M_WARN, "GDG6: oif size mismatch");
+                    continue;
                 }
 
                 memcpy(&oif, RTA_DATA(rta), sizeof(oif));
                 if_indextoname(oif,ifname);
-                strncpy( rgi6->iface, ifname, sizeof(rgi6->iface)-1 );
+                strncpy(rgi6->iface, ifname, sizeof(rgi6->iface) - 1);
                 rgi6->flags |= RGI_IFACE_DEFINED;
             }
         }
     }
 
     /* if we have an interface but no gateway, the destination is on-link */
-    if ( ( rgi6->flags & (RGI_IFACE_DEFINED|RGI_ADDR_DEFINED) ) ==
-         RGI_IFACE_DEFINED)
+    int defined = RGI_IFACE_DEFINED | RGI_ADDR_DEFINED;
+    if ((rgi6->flags & defined) == RGI_IFACE_DEFINED)
     {
         rgi6->flags |= (RGI_ADDR_DEFINED | RGI_ON_LINK);
         if (dest)
@@ -3531,9 +3502,9 @@ done:
     }
 }
 
-#elif defined(TARGET_DARWIN) || defined(TARGET_SOLARIS)    \
-    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
-    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#elif defined(TARGET_DARWIN) || defined(TARGET_SOLARIS)        \
+      || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)     \
+      || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -3568,15 +3539,19 @@ struct rtmsg {
 
 #if defined(TARGET_SOLARIS)
 #define NEXTADDR(w, u) \
-    if (rtm_addrs & (w)) { \
+    if (rtm_addrs & (w)) \
+    { \
         l = ROUNDUP(sizeof(u)); memmove(cp, &(u), l); cp += l; \
     }
 
 #define ADVANCE(x, n) (x += ROUNDUP(sizeof(struct sockaddr_in)))
-#else  /* if defined(TARGET_SOLARIS) */
+#else  /* if !defined(TARGET_SOLARIS) */
 #define NEXTADDR(w, u) \
-    if (rtm_addrs & (w)) { \
-        l = ROUNDUP( ((struct sockaddr *)&(u))->sa_len); memmove(cp, &(u), l); cp += l; \
+    if (rtm_addrs & (w)) \
+    { \
+        l = ROUNDUP(((struct sockaddr *)&(u))->sa_len); \
+        memmove(cp, &(u), l); \
+        cp += l; \
     }
 
 #define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
@@ -3648,7 +3623,7 @@ get_default_gateway(struct route_gateway_info *rgi)
     do
     {
         l = read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
-    } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
+    } while ((l > 0) && ((rtm.rtm_seq != seq) || (rtm.rtm_pid != pid)));
     close(sockfd);
     sockfd = -1;
 
@@ -3683,7 +3658,9 @@ get_default_gateway(struct route_gateway_info *rgi)
     if (gate != NULL)
     {
         /* get default gateway addr */
-        rgi->gateway.addr = ntohl(((struct sockaddr_in *)gate)->sin_addr.s_addr);
+        struct sockaddr_in *addr = (struct sockaddr_in *)gate;
+
+        rgi->gateway.addr = ntohl(addr->sin_addr.s_addr);
         if (rgi->gateway.addr)
         {
             rgi->flags |= RGI_ADDR_DEFINED;
@@ -3692,8 +3669,9 @@ get_default_gateway(struct route_gateway_info *rgi)
         if (ifp)
         {
             /* get interface name */
-            const struct sockaddr_dl *adl = (struct sockaddr_dl *) ifp;
-            if (adl->sdl_nlen && adl->sdl_nlen < sizeof(rgi->iface))
+            const struct sockaddr_dl *adl = (struct sockaddr_dl *)ifp;
+
+            if (adl->sdl_nlen && (adl->sdl_nlen < sizeof(rgi->iface)))
             {
                 memcpy(rgi->iface, adl->sdl_data, adl->sdl_nlen);
                 rgi->iface[adl->sdl_nlen] = '\0';
@@ -3706,6 +3684,7 @@ get_default_gateway(struct route_gateway_info *rgi)
     if (rgi->flags & RGI_IFACE_DEFINED)
     {
         struct ifreq ifr;
+        struct sockaddr_in *addr;
 
         sockfd = socket(AF_INET, SOCK_DGRAM, 0);
         if (sockfd < 0)
@@ -3726,7 +3705,8 @@ get_default_gateway(struct route_gateway_info *rgi)
         close(sockfd);
         sockfd = -1;
 
-        rgi->gateway.netmask = ntohl(((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr.s_addr);
+        addr = (struct sockaddr_in *)&ifr.ifr_addr;
+        rgi->gateway.netmask = ntohl(addr->sin_addr.s_addr);
         rgi->flags |= RGI_NETMASK_DEFINED;
     }
 
@@ -3757,13 +3737,15 @@ get_default_gateway(struct route_gateway_info *rgi)
         close(sockfd);
         sockfd = -1;
 
-        for (cp = buffer; cp <= buffer + ifc.ifc_len - sizeof(struct ifreq); )
+        for (cp = buffer; cp <= (buffer + ifc.ifc_len - sizeof(struct ifreq)); )
         {
             ifr = (struct ifreq *)cp;
 #if defined(TARGET_SOLARIS)
             const size_t len = sizeof(ifr->ifr_name) + sizeof(ifr->ifr_addr);
 #else
-            const size_t len = sizeof(ifr->ifr_name) + max(sizeof(ifr->ifr_addr), ifr->ifr_addr.sa_len);
+            const size_t max_len = max(sizeof(ifr->ifr_addr),
+                                       ifr->ifr_addr.sa_len);
+            const size_t len = sizeof(ifr->ifr_name) + max_len;
 #endif
 
             if (!ifr->ifr_addr.sa_family)
@@ -3840,8 +3822,8 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     so_dst.sin6_family = AF_INET6;
     so_mask.sin6_family = AF_INET6;
 
-    if (dest != NULL                    /* specific host? */
-        && !IN6_IS_ADDR_UNSPECIFIED(dest) )
+    if ((dest != NULL)                   /* specific host? */
+        && !IN6_IS_ADDR_UNSPECIFIED(dest))
     {
         so_dst.sin6_addr = *dest;
         /* :: needs /0 "netmask", host route wants "no netmask */
@@ -3877,7 +3859,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     {
         l = read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
     }
-    while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
+    while ((l > 0) && ((rtm.rtm_seq != seq) || (rtm.rtm_pid != pid)));
 
     close(sockfd);
     sockfd = -1;
@@ -3918,16 +3900,16 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
 #ifndef TARGET_SOLARIS
         /* You do not really want to know... from FreeBSD's route.c
          * (KAME encodes the 16 bit scope_id in s6_addr[2] + [3],
-         * but for a correct link-local address these must be :0000: )
+         * but for a correct link-local address these must be :0000:)
          */
         if (gate->sa_len == sizeof(struct sockaddr_in6)
-            && IN6_IS_ADDR_LINKLOCAL(&gw) )
+            && IN6_IS_ADDR_LINKLOCAL(&gw))
         {
             gw.s6_addr[2] = gw.s6_addr[3] = 0;
         }
 
         if (gate->sa_len != sizeof(struct sockaddr_in6)
-            || IN6_IS_ADDR_UNSPECIFIED(&gw) )
+            || IN6_IS_ADDR_UNSPECIFIED(&gw))
         {
             rgi6->flags |= RGI_ON_LINK;
         }
@@ -3940,8 +3922,8 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
         if (ifp)
         {
             /* get interface name */
-            const struct sockaddr_dl *adl = (struct sockaddr_dl *) ifp;
-            if (adl->sdl_nlen && adl->sdl_nlen < sizeof(rgi6->iface))
+            const struct sockaddr_dl *adl = (struct sockaddr_dl *)ifp;
+            if (adl->sdl_nlen && (adl->sdl_nlen < sizeof(rgi6->iface)))
             {
                 memcpy(rgi6->iface, adl->sdl_data, adl->sdl_nlen);
                 rgi6->flags |= RGI_IFACE_DEFINED;
@@ -3989,6 +3971,7 @@ get_default_gateway(struct route_gateway_info *rgi)
 {
     CLEAR(*rgi);
 }
+
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
                          const struct in6_addr *dest)
@@ -4000,7 +3983,8 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
 #endif /* if defined(_WIN32) */
 
 bool
-netmask_to_netbits(const in_addr_t network, const in_addr_t netmask, int *netbits)
+netmask_to_netbits(const in_addr_t network, const in_addr_t netmask,
+                   int *netbits)
 {
     int i;
     const int addrlen = sizeof(in_addr_t) * 8;
@@ -4059,7 +4043,8 @@ netmask_to_netbits2(in_addr_t netmask)
 static void
 add_host_route_if_nonlocal(struct route_bypass *rb, const in_addr_t addr)
 {
-    if (test_local_addr(addr, NULL) == TLA_NONLOCAL && addr != 0 && addr != IPV4_NETMASK_HOST)
+    if ((test_local_addr(addr, NULL) == TLA_NONLOCAL)
+        && (addr != 0) && (addr != IPV4_NETMASK_HOST))
     {
         add_bypass_address(rb, addr);
     }
@@ -4071,7 +4056,10 @@ add_host_route_array(struct route_bypass *rb, const IP_ADDR_STRING *iplist)
     while (iplist)
     {
         bool succeed = false;
-        const in_addr_t ip = getaddr(GETADDR_HOST_ORDER, iplist->IpAddress.String, 0, &succeed, NULL);
+        const in_addr_t ip = getaddr(GETADDR_HOST_ORDER,
+                                     iplist->IpAddress.String, 0, &succeed,
+                                     NULL);
+
         if (succeed)
         {
             add_host_route_if_nonlocal(rb, ip);
@@ -4084,21 +4072,20 @@ static void
 get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)
 {
     struct gc_arena gc = gc_new();
-    /*bool ret_bool = false;*/
-
     /* get full routing table */
     const MIB_IPFORWARDTABLE *routes = get_windows_routing_table(&gc);
-
     /* get the route which represents the default gateway */
     const MIB_IPFORWARDROW *row = get_default_gateway_row(routes);
 
     if (row)
     {
         /* get the adapter which the default gateway is associated with */
-        const IP_ADAPTER_INFO *dgi = get_adapter_info(row->dwForwardIfIndex, &gc);
-
+        const IP_ADAPTER_INFO *dgi = get_adapter_info(row->dwForwardIfIndex,
+                                                      &gc);
         /* get extra adapter info, such as DNS addresses */
-        const IP_PER_ADAPTER_INFO *pai = get_per_adapter_info(row->dwForwardIfIndex, &gc);
+        const IP_PER_ADAPTER_INFO *pai;
+
+        pai = get_per_adapter_info(row->dwForwardIfIndex, &gc);
 
         /* Bypass DHCP server address */
         if ((flags & RG_BYPASS_DHCP) && dgi && dgi->DhcpEnabled)
@@ -4119,7 +4106,7 @@ get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)
 #else  /* if defined(_WIN32) */
 
 static void
-get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)   /* PLATFORM-SPECIFIC */
+get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)
 {
 }
 
@@ -4140,9 +4127,9 @@ int
 test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi)
 {
     struct gc_arena gc = gc_new();
-    const in_addr_t nonlocal_netmask = 0x80000000L; /* routes with netmask <= to this are considered non-local */
+    /* routes with netmask <= to this are considered non-local */
+    const in_addr_t nonlocal_netmask = 0x80000000L;
     int ret = TLA_NONLOCAL;
-
     /* get full routing table */
     const MIB_IPFORWARDTABLE *rt = get_windows_routing_table(&gc);
     if (rt)
@@ -4162,13 +4149,14 @@ test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi)
     }
 
     gc_free(&gc);
+
     return ret;
 }
 
 #else  /* if defined(_WIN32) */
 
 int
-test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi)  /* PLATFORM-SPECIFIC */
+test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi)
 {
     if (rgi)
     {
@@ -4181,6 +4169,7 @@ test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi)  /*
             return TLA_NONLOCAL;
         }
     }
+
     return TLA_NOT_IMPLEMENTED;
 }
 
-- 
2.14.1


