From: Gert Doering <gert@...1296...>
Date: Mon, 13 Jan 2014 22:54:33 +0100
Message-Id: <1389650074-18455-1-git-send-email-gert@...1296...>
In-Reply-To: <20140113185822.GV226@...1296...>
References: <20140113185822.GV226@...1296...>
Subject: [Openvpn-devel] [PATCH 1/2] Rename "struct route" to "struct
	route_ipv4"
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

To fix trac #340, we need to rename our "struct route" to avoid a
collision with "struct route" from <net/route.h> on *BSD.

No functional changes.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 36 ++++++++++++++++++------------------
 src/openvpn/route.h | 10 +++++-----
 src/openvpn/tun.c   |  6 +++---
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index f051dd3..d6344b9 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -49,7 +49,7 @@
 #define METRIC_NOT_USED ((DWORD)-1)
 #endif
 
-static void delete_route (struct route *r, const struct tuntap *tt, unsigned int flags, const struct route_gateway_info *rgi, const struct env_set *es);
+static void delete_route (struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags, const struct route_gateway_info *rgi, const struct env_set *es);
 
 static void get_bypass_addresses (struct route_bypass *rb, const unsigned int flags);
 
@@ -150,7 +150,7 @@ struct route_list *
 new_route_list (const int max_routes, struct gc_arena *a)
 {
   struct route_list *ret;
-  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_list, struct route, max_routes, a);
+  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_list, struct route_ipv4, max_routes, a);
   ret->capacity = max_routes;
   return ret;
 }
@@ -165,7 +165,7 @@ new_route_ipv6_list (const int max_routes, struct gc_arena *a)
 }
 
 static const char *
-route_string (const struct route *r, struct gc_arena *gc)
+route_string (const struct route_ipv4 *r, struct gc_arena *gc)
 {
   struct buffer out = alloc_buf_gc (256, gc);
   buf_printf (&out, "ROUTE network %s netmask %s gateway %s",
@@ -267,7 +267,7 @@ is_special_addr (const char *addr_str)
 }
 
 static bool
-init_route (struct route *r,
+init_route (struct route_ipv4 *r,
 	    struct addrinfo **network_list,
 	    const struct route_option *ro,
 	    const struct route_list *rl)
@@ -484,7 +484,7 @@ void
 clear_route_list (struct route_list *rl)
 {
   const int capacity = rl->capacity;
-  const size_t rl_size = array_mult_safe (sizeof(struct route), capacity, sizeof(struct route_list));
+  const size_t rl_size = array_mult_safe (sizeof(struct route_ipv4), capacity, sizeof(struct route_list));
   memset(rl, 0, rl_size);
   rl->capacity = capacity;
 }
@@ -519,7 +519,7 @@ add_block_local_item (struct route_list *rl,
       && rl->rgi.gateway.netmask < 0xFFFFFFFF
       && (rl->n)+2 <= rl->capacity)
     {
-      struct route r;
+      struct route_ipv4 r;
       unsigned int l2;
 
       /* split a route into two smaller blocking routes, and direct them to target */
@@ -649,7 +649,7 @@ init_route_list (struct route_list *rl,
     for (i = 0; i < opt->n; ++i)
       {
         struct addrinfo* netlist;
-	struct route r;
+	struct route_ipv4 r;
 
 	if (!init_route (&r,
 			 &netlist,
@@ -760,7 +760,7 @@ add_route3 (in_addr_t network,
 	    const struct route_gateway_info *rgi,
 	    const struct env_set *es)
 {
-  struct route r;
+  struct route_ipv4 r;
   CLEAR (r);
   r.flags = RT_DEFINED;
   r.network = network;
@@ -778,7 +778,7 @@ del_route3 (in_addr_t network,
 	    const struct route_gateway_info *rgi,
 	    const struct env_set *es)
 {
-  struct route r;
+  struct route_ipv4 r;
   CLEAR (r);
   r.flags = RT_DEFINED|RT_ADDED;
   r.network = network;
@@ -1028,7 +1028,7 @@ add_routes (struct route_list *rl, struct route_ipv6_list *rl6, const struct tun
       
       for (i = 0; i < rl->n; ++i)
 	{
-	  struct route *r = &rl->routes[i];
+	  struct route_ipv4 *r = &rl->routes[i];
 	  check_subnet_conflict (r->network, r->netmask, "route");
 	  if (flags & ROUTE_DELETE_FIRST)
 	    delete_route (r, tt, flags, &rl->rgi, es);
@@ -1060,7 +1060,7 @@ delete_routes (struct route_list *rl, struct route_ipv6_list *rl6,
       int i;
       for (i = rl->n - 1; i >= 0; --i)
 	{
-	  struct route * r = &rl->routes[i];
+	  struct route_ipv4 * r = &rl->routes[i];
 	  delete_route (r, tt, flags, &rl->rgi, es);
 	}
       rl->iflags &= ~RL_ROUTES_ADDED;
@@ -1154,7 +1154,7 @@ print_default_gateway(const int msglevel, const struct route_gateway_info *rgi)
 #endif
 
 static void
-print_route (const struct route *r, int level)
+print_route (const struct route_ipv4 *r, int level)
 {
   struct gc_arena gc = gc_new ();
   if (r->flags & RT_DEFINED)
@@ -1171,7 +1171,7 @@ print_routes (const struct route_list *rl, int level)
 }
 
 static void
-setenv_route (struct env_set *es, const struct route *r, int i)
+setenv_route (struct env_set *es, const struct route_ipv4 *r, int i)
 {
   struct gc_arena gc = gc_new ();
   if (r->flags & RT_DEFINED)
@@ -1288,7 +1288,7 @@ is_on_link (const int is_local_route, const unsigned int flags, const struct rou
 }
 
 void
-add_route (struct route *r,
+add_route (struct route_ipv4 *r,
 	   const struct tuntap *tt,
 	   unsigned int flags,
 	   const struct route_gateway_info *rgi, /* may be NULL */
@@ -1741,7 +1741,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 }
 
 static void
-delete_route (struct route *r,
+delete_route (struct route_ipv4 *r,
 	      const struct tuntap *tt,
 	      unsigned int flags,
 	      const struct route_gateway_info *rgi,
@@ -2246,7 +2246,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 }
 
 static DWORD
-windows_route_find_if_index (const struct route *r, const struct tuntap *tt)
+windows_route_find_if_index (const struct route_ipv4 *r, const struct tuntap *tt)
 {
   struct gc_arena gc = gc_new ();
   DWORD ret = TUN_ADAPTER_INDEX_INVALID;
@@ -2291,7 +2291,7 @@ windows_route_find_if_index (const struct route *r, const struct tuntap *tt)
 }
 
 bool
-add_route_ipapi (const struct route *r, const struct tuntap *tt, DWORD adapter_index)
+add_route_ipapi (const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapter_index)
 {
   struct gc_arena gc = gc_new ();
   bool ret = false;
@@ -2365,7 +2365,7 @@ add_route_ipapi (const struct route *r, const struct tuntap *tt, DWORD adapter_i
 }
 
 bool
-del_route_ipapi (const struct route *r, const struct tuntap *tt)
+del_route_ipapi (const struct route_ipv4 *r, const struct tuntap *tt)
 {
   struct gc_arena gc = gc_new ();
   bool ret = false;
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index a40de32..fe9b461 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -110,7 +110,7 @@ struct route_ipv6_option_list {
   struct route_ipv6_option routes_ipv6[EMPTY_ARRAY_SIZE];
 };
 
-struct route {
+struct route_ipv4 {
 # define RT_DEFINED        (1<<0)
 # define RT_ADDED          (1<<1)
 # define RT_METRIC_DEFINED (1<<2)
@@ -190,7 +190,7 @@ struct route_list {
   unsigned int flags;     /* RG_x flags */
   int capacity;
   int n;
-  struct route routes[EMPTY_ARRAY_SIZE];
+  struct route_ipv4 routes[EMPTY_ARRAY_SIZE];
 };
 
 #if P2MP
@@ -223,7 +223,7 @@ struct route_ipv6_list *new_route_ipv6_list (const int max_routes, struct gc_are
 void add_route_ipv6 (struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
 void delete_route_ipv6 (const struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
 
-void add_route (struct route *r,
+void add_route (struct route_ipv4 *r,
 		const struct tuntap *tt,
 		unsigned int flags,
 		const struct route_gateway_info *rgi,
@@ -301,8 +301,8 @@ void print_routes (const struct route_list *rl, int level);
 
 void show_routes (int msglev);
 bool test_routes (const struct route_list *rl, const struct tuntap *tt);
-bool add_route_ipapi (const struct route *r, const struct tuntap *tt, DWORD adapter_index);
-bool del_route_ipapi (const struct route *r, const struct tuntap *tt);
+bool add_route_ipapi (const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapter_index);
+bool del_route_ipapi (const struct route_ipv4 *r, const struct tuntap *tt);
 
 #else
 static inline bool test_routes (const struct route_list *rl, const struct tuntap *tt) { return true; }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a300275..672486e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -909,7 +909,7 @@ do_ifconfig (struct tuntap *tt,
       if (!tun && tt->topology == TOP_SUBNET)
 	{
 	  /* Add a network route for the local tun interface */
-	  struct route r;
+	  struct route_ipv4 r;
 	  CLEAR (r);      
 	  r.flags = RT_DEFINED | RT_METRIC_DEFINED;
 	  r.network = tt->local & tt->remote_netmask;
@@ -1106,7 +1106,7 @@ do_ifconfig (struct tuntap *tt,
       /* Add a network route for the local tun interface */
       if (!tun && tt->topology == TOP_SUBNET)
 	{
-	  struct route r;
+	  struct route_ipv4 r;
 	  CLEAR (r);
 	  r.flags = RT_DEFINED;
 	  r.network = tt->local & tt->remote_netmask;
@@ -1172,7 +1172,7 @@ do_ifconfig (struct tuntap *tt,
 	/* Add a network route for the local tun interface */
       if (!tun && tt->topology == TOP_SUBNET)
         {
-          struct route r;
+          struct route_ipv4 r;
           CLEAR (r);
           r.flags = RT_DEFINED;
           r.network = tt->local & tt->remote_netmask;
-- 
1.8.3.2


