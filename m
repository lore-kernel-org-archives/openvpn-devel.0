From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 18 Feb 2014 18:59:55 +0100
Message-ID: <1392746395-19246-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1391000624-15092-1-git-send-email-heiko.hund@...1489...>
References: <1391000624-15092-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2] grow route lists dynamically
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

This removes the need for the --max-routes option. Instead of
allocating a fixed size array for the route(-option)s they are
managed in linked lists instead.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/init.c    |   4 +-
 src/openvpn/options.c |  33 ++-----
 src/openvpn/options.h |   3 +-
 src/openvpn/push.c    |   2 +-
 src/openvpn/route.c   | 234 ++++++++++++++++++++++----------------------------
 src/openvpn/route.h   |  38 ++++----
 6 files changed, 130 insertions(+), 184 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d324166..3b72b96 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1167,9 +1167,9 @@ static void
 do_alloc_route_list (struct context *c)
 {
   if (!c->c1.route_list)
-    c->c1.route_list = new_route_list (c->options.max_routes, &c->gc);
+    ALLOC_OBJ_CLEAR_GC (c->c1.route_list, struct route_list, &c->gc);
   if (c->options.routes_ipv6 && !c->c1.route_ipv6_list)
-    c->c1.route_ipv6_list = new_route_ipv6_list (c->options.max_routes, &c->gc);
+    ALLOC_OBJ_CLEAR_GC (c->c1.route_ipv6_list, struct route_ipv6_list, &c->gc);
 }
 
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9e21d5a..ef6170c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -218,8 +218,6 @@ static const char usage_message[] =
   "                  Add IPv6 route to routing table after connection\n"
   "                  is established.  Multiple routes can be specified.\n"
   "                  gateway default: taken from 'remote' in --ifconfig-ipv6\n"
-  "--max-routes n :  Specify the maximum number of routes that may be defined\n"
-  "                  or pulled from a server.\n"
   "--route-gateway gw|'dhcp' : Specify a default gateway for use with --route.\n"
   "--route-metric m : Specify a default metric for use with --route.\n"
   "--route-delay n [w] : Delay n seconds after connection initiation before\n"
@@ -796,7 +794,6 @@ init_options (struct options *o, const bool init_gc)
   o->ce.mtu_discover_type = -1;
   o->ce.mssfix = MSSFIX_DEFAULT;
   o->route_delay_window = 30;
-  o->max_routes = MAX_ROUTES_DEFAULT;
   o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
   o->proto_force = -1;
 #ifdef ENABLE_OCC
@@ -1340,14 +1337,14 @@ void
 rol_check_alloc (struct options *options)
 {
   if (!options->routes)
-    options->routes = new_route_option_list (options->max_routes, &options->gc);
+    options->routes = new_route_option_list (&options->gc);
 }
 
 void
 rol6_check_alloc (struct options *options)
 {
   if (!options->routes_ipv6)
-    options->routes_ipv6 = new_route_ipv6_option_list (options->max_routes, &options->gc);
+    options->routes_ipv6 = new_route_ipv6_option_list (&options->gc);
 }
 
 #ifdef ENABLE_CLIENT_NAT
@@ -1550,7 +1547,6 @@ show_settings (const struct options *o)
   SHOW_BOOL (route_delay_defined);
   SHOW_BOOL (route_nopull);
   SHOW_BOOL (route_gateway_via_dhcp);
-  SHOW_INT (max_routes);
   SHOW_BOOL (allow_pull_fqdn);
   if (o->routes)
     print_route_options (o->routes, D_SHOW_PARMS);
@@ -2829,7 +2825,7 @@ pre_pull_save (struct options *o)
 }
 
 void
-pre_pull_restore (struct options *o)
+pre_pull_restore (struct options *o, struct gc_arena *gc)
 {
   const struct options_pre_pull *pp = o->pre_pull;
   if (pp)
@@ -2841,7 +2837,7 @@ pre_pull_restore (struct options *o)
       if (pp->routes_defined)
 	{
 	  rol_check_alloc (o);
-	  copy_route_option_list (o->routes, pp->routes);
+	  copy_route_option_list (o->routes, pp->routes, gc);
 	}
       else
 	o->routes = NULL;
@@ -2849,7 +2845,7 @@ pre_pull_restore (struct options *o)
       if (pp->routes_ipv6_defined)
 	{
 	  rol6_check_alloc (o);
-	  copy_route_ipv6_option_list (o->routes_ipv6, pp->routes_ipv6);
+	  copy_route_ipv6_option_list (o->routes_ipv6, pp->routes_ipv6, gc);
 	}
       else
 	o->routes_ipv6 = NULL;
@@ -5227,23 +5223,10 @@ add_option (struct options *options,
 	}
       add_route_ipv6_to_option_list (options->routes_ipv6, p[1], p[2], p[3]);
     }
-  else if (streq (p[0], "max-routes") && p[1])
+  else if (streq (p[0], "max-routes"))
     {
-      int max_routes;
-
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      max_routes = atoi (p[1]);
-      if (max_routes < 0 || max_routes > 100000000)
-	{
-	  msg (msglevel, "--max-routes parameter is out of range");
-	  goto err;
-	}
-      if (options->routes || options->routes_ipv6)
-        {
-          msg (msglevel, "--max-routes must to be specifed before any route/route-ipv6/redirect-gateway option");
-          goto err;
-        }
-      options->max_routes = max_routes;
+      msg (msglevel, "--max-routes option ignored. The number of routes is unlimited as of version 2.4. "
+           "This option will be removed in a future version, please remove it from your configuration.");
     }
   else if (streq (p[0], "route-gateway") && p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bf232f4..27bbc14 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -343,7 +343,6 @@ struct options
   int route_delay;
   int route_delay_window;
   bool route_delay_defined;
-  int max_routes;
   struct route_option_list *routes;
   struct route_ipv6_option_list *routes_ipv6;			/* IPv6 */
   bool route_nopull;
@@ -715,7 +714,7 @@ void options_warning (char *actual, const char *expected);
 void options_postprocess (struct options *options);
 
 void pre_pull_save (struct options *o);
-void pre_pull_restore (struct options *o);
+void pre_pull_restore (struct options *o, struct gc_arena *gc);
 
 bool apply_push_options (struct options *options,
 			 struct buffer *buf,
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e971357..606bb05 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -456,7 +456,7 @@ process_incoming_push_msg (struct context *c,
 	    }
 	  if (!c->c2.did_pre_pull_restore)
 	    {
-	      pre_pull_restore (&c->options);
+	      pre_pull_restore (&c->options, &c->c2.gc);
 	      c->c2.did_pre_pull_restore = true;
 	    }
 	  if (apply_push_options (&c->options,
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d397f11..392e248 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -92,76 +92,62 @@ add_bypass_address (struct route_bypass *rb, const in_addr_t a)
 }
 
 struct route_option_list *
-new_route_option_list (const int max_routes, struct gc_arena *a)
+new_route_option_list (struct gc_arena *a)
 {
   struct route_option_list *ret;
-  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_option_list, struct route_option, max_routes, a);
-  ret->capacity = max_routes;
+  ALLOC_OBJ_CLEAR_GC (ret, struct route_option_list, a);
+  ret->gc = a;
   return ret;
 }
 
 struct route_ipv6_option_list *
-new_route_ipv6_option_list (const int max_routes, struct gc_arena *a)
+new_route_ipv6_option_list (struct gc_arena *a)
 {
   struct route_ipv6_option_list *ret;
-  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_ipv6_option_list, struct route_ipv6_option, max_routes, a);
-  ret->capacity = max_routes;
+  ALLOC_OBJ_CLEAR_GC (ret, struct route_ipv6_option_list, a);
+  ret->gc = a;
   return ret;
 }
 
+/*
+ * NOTE: structs are cloned/copied shallow by design.
+ * The routes list from src will stay intact since it is allocated using
+ * the options->gc. The cloned/copied lists will share this common tail
+ * to avoid copying the data around between pulls. Pulled routes use
+ * the c2->gc so they get freed immediately after a reconnect.
+ */
 struct route_option_list *
 clone_route_option_list (const struct route_option_list *src, struct gc_arena *a)
 {
-  const size_t rl_size = array_mult_safe (sizeof(struct route_option), src->capacity, sizeof(struct route_option_list));
-  struct route_option_list *ret = gc_malloc (rl_size, false, a);
-  memcpy (ret, src, rl_size);
+  struct route_option_list *ret;
+  ALLOC_OBJ_GC (ret, struct route_option_list, a);
+  *ret = *src;
   return ret;
 }
 
 struct route_ipv6_option_list *
 clone_route_ipv6_option_list (const struct route_ipv6_option_list *src, struct gc_arena *a)
 {
-  const size_t rl_size = array_mult_safe (sizeof(struct route_ipv6_option), src->capacity, sizeof(struct route_ipv6_option_list));
-  struct route_ipv6_option_list *ret = gc_malloc (rl_size, false, a);
-  memcpy (ret, src, rl_size);
+  struct route_ipv6_option_list *ret;
+  ALLOC_OBJ_GC (ret, struct route_ipv6_option_list, a);
+  *ret = *src;
   return ret;
 }
 
 void
-copy_route_option_list (struct route_option_list *dest, const struct route_option_list *src)
+copy_route_option_list (struct route_option_list *dest, const struct route_option_list *src, struct gc_arena *a)
 {
-  const size_t src_size = array_mult_safe (sizeof(struct route_option), src->capacity, sizeof(struct route_option_list));
-  if (src->capacity > dest->capacity)
-    msg (M_FATAL, PACKAGE_NAME " ROUTE: (copy) number of route options in src (%d) is greater than route list capacity in dest (%d)", src->capacity, dest->capacity);
-  memcpy (dest, src, src_size);
+  *dest = *src;
+  dest->gc = a;
 }
 
 void
 copy_route_ipv6_option_list (struct route_ipv6_option_list *dest,
-			     const struct route_ipv6_option_list *src)
+                             const struct route_ipv6_option_list *src,
+                             struct gc_arena *a)
 {
-  const size_t src_size = array_mult_safe (sizeof(struct route_ipv6_option), src->capacity, sizeof(struct route_ipv6_option_list));
-  if (src->capacity > dest->capacity)
-    msg (M_FATAL, PACKAGE_NAME " ROUTE: (copy) number of route options in src (%d) is greater than route list capacity in dest (%d)", src->capacity, dest->capacity);
-  memcpy (dest, src, src_size);
-}
-
-struct route_list *
-new_route_list (const int max_routes, struct gc_arena *a)
-{
-  struct route_list *ret;
-  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_list, struct route_ipv4, max_routes, a);
-  ret->capacity = max_routes;
-  return ret;
-}
-
-struct route_ipv6_list *
-new_route_ipv6_list (const int max_routes, struct gc_arena *a)
-{
-  struct route_ipv6_list *ret;
-  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_ipv6_list, struct route_ipv6, max_routes, a);
-  ret->capacity = max_routes;
-  return ret;
+  *dest = *src;
+  dest->gc = a;
 }
 
 static const char *
@@ -452,15 +438,14 @@ add_route_to_option_list (struct route_option_list *l,
 			  const char *metric)
 {
   struct route_option *ro;
-  if (l->n >= l->capacity)
-    msg (M_FATAL, PACKAGE_NAME " ROUTE: cannot add more than %d routes -- please increase the max-routes option in the client configuration file",
-	 l->capacity);
-  ro = &l->routes[l->n];
+  ALLOC_OBJ_GC (ro, struct route_option, l->gc);
   ro->network = network;
   ro->netmask = netmask;
   ro->gateway = gateway;
   ro->metric = metric;
-  ++l->n;
+  ro->next = l->routes;
+  l->routes = ro;
+
 }
 
 void
@@ -470,32 +455,26 @@ add_route_ipv6_to_option_list (struct route_ipv6_option_list *l,
 			  const char *metric)
 {
   struct route_ipv6_option *ro;
-  if (l->n >= l->capacity)
-    msg (M_FATAL, PACKAGE_NAME " ROUTE: cannot add more than %d IPv6 routes -- please increase the max-routes option in the client configuration file",
-	 l->capacity);
-  ro = &l->routes_ipv6[l->n];
+  ALLOC_OBJ_GC (ro, struct route_ipv6_option, l->gc);
   ro->prefix = prefix;
   ro->gateway = gateway;
   ro->metric = metric;
-  ++l->n;
+  ro->next = l->routes_ipv6;
+  l->routes_ipv6 = ro;
 }
 
 void
 clear_route_list (struct route_list *rl)
 {
-  const int capacity = rl->capacity;
-  const size_t rl_size = array_mult_safe (sizeof(struct route_ipv4), capacity, sizeof(struct route_list));
-  memset(rl, 0, rl_size);
-  rl->capacity = capacity;
+  gc_free (&rl->gc);
+  CLEAR (*rl);
 }
 
 void
 clear_route_ipv6_list (struct route_ipv6_list *rl6)
 {
-  const int capacity = rl6->capacity;
-  const size_t rl6_size = array_mult_safe (sizeof(struct route_ipv6), capacity, sizeof(struct route_ipv6_list));
-  memset(rl6, 0, rl6_size);
-  rl6->capacity = capacity;
+  gc_free (&rl6->gc);
+  CLEAR (*rl6);
 }
 
 void
@@ -516,22 +495,27 @@ add_block_local_item (struct route_list *rl,
 {
   const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
   if ((rl->rgi.flags & rgi_needed) == rgi_needed
-      && rl->rgi.gateway.netmask < 0xFFFFFFFF
-      && (rl->n)+2 <= rl->capacity)
+      && rl->rgi.gateway.netmask < 0xFFFFFFFF)
     {
-      struct route_ipv4 r;
+      struct route_ipv4 *r1, *r2;
       unsigned int l2;
 
+      ALLOC_OBJ_GC (r1, struct route_ipv4, &rl->gc);
+      ALLOC_OBJ_GC (r2, struct route_ipv4, &rl->gc);
+
       /* split a route into two smaller blocking routes, and direct them to target */
-      CLEAR(r);
-      r.flags = RT_DEFINED;
-      r.gateway = target;
-      r.network = gateway->addr & gateway->netmask;
       l2 = ((~gateway->netmask)+1)>>1;
-      r.netmask = ~(l2-1);
-      rl->routes[rl->n++] = r;
-      r.network += l2;
-      rl->routes[rl->n++] = r;
+      r1->flags = RT_DEFINED;
+      r1->gateway = target;
+      r1->network = gateway->addr & gateway->netmask;
+      r1->netmask = ~(l2-1);
+      r1->next = rl->routes;
+      rl->routes = r1;
+
+      *r2 = *r1;
+      r2->network += l2;
+      r2->next = rl->routes;
+      rl->routes = r2;
     }
 }
 
@@ -643,42 +627,29 @@ init_route_list (struct route_list *rl,
 
   /* parse the routes from opt to rl */
   {
-    int i = 0;
-    int j = rl->n;
-    bool warned = false;
-    for (i = 0; i < opt->n; ++i)
+    struct route_option *ro;
+    for (ro = opt->routes; ro; ro = ro->next)
       {
         struct addrinfo* netlist;
 	struct route_ipv4 r;
 
-	if (!init_route (&r,
-			 &netlist,
-			 &opt->routes[i],
-			 rl))
+	if (!init_route (&r, &netlist, ro, rl))
 	  ret = false;
 	else
 	  {
             struct addrinfo* curele;
             for (curele	= netlist; curele; curele = curele->ai_next)
 	      {
-		if (j < rl->capacity)
-		  {
-                    r.network = ntohl(((struct sockaddr_in*)(curele)->ai_addr)->sin_addr.s_addr);
-		    rl->routes[j++] = r;
-		  }
-		else
-		  {
-		    if (!warned)
-		      {
-			msg (M_WARN, PACKAGE_NAME " ROUTE: routes dropped because number of expanded routes is greater than route list capacity (%d)", rl->capacity);
-			warned = true;
-		      }
-		  }
+                struct route_ipv4 *new;
+                ALLOC_OBJ_GC (new, struct route_ipv4, &rl->gc);
+                *new = r;
+                new->network = ntohl (((struct sockaddr_in*)curele->ai_addr)->sin_addr.s_addr);
+                new->next = rl->routes;
+                rl->routes = new;
 	      }
             freeaddrinfo(netlist);
 	  }
       }
-    rl->n = j;
   }
 
   gc_free (&gc);
@@ -729,22 +700,21 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
     rl6->remote_endpoint_defined = false;
 
 
-  if (!(opt6->n >= 0 && opt6->n <= rl6->capacity))
-    msg (M_FATAL, PACKAGE_NAME " ROUTE6: (init) number of route options (%d) is greater than route list capacity (%d)", opt6->n, rl6->capacity);
-
-  /* parse the routes from opt to rl6 */
+  /* parse the routes from opt6 to rl6 */
   {
-    int i, j = 0;
-    for (i = 0; i < opt6->n; ++i)
+    struct route_ipv6_option *ro6;
+    for (ro6 = opt6->routes_ipv6; ro6; ro6 = ro6->next)
       {
-	if (!init_route_ipv6 (&rl6->routes_ipv6[j],
-			      &opt6->routes_ipv6[i],
-			      rl6 ))
+        struct route_ipv6 *r6;
+        ALLOC_OBJ_GC (r6, struct route_ipv6, &rl6->gc);
+        if (!init_route_ipv6 (r6, ro6, rl6))
 	  ret = false;
 	else
-	  ++j;
+          {
+            r6->next = rl6->routes_ipv6;
+            rl6->routes_ipv6 = r6;
+          }
       }
-    rl6->n = j;
   }
 
   gc_free (&gc);
@@ -1013,10 +983,10 @@ add_routes (struct route_list *rl, struct route_ipv6_list *rl6, const struct tun
   redirect_default_route_to_vpn (rl, tt, flags, es);
   if ( rl && !(rl->iflags & RL_ROUTES_ADDED) )
     {
-      int i;
+      struct route_ipv4 *r;
 
 #ifdef ENABLE_MANAGEMENT
-      if (management && rl->n)
+      if (management && rl->routes)
 	{
 	  management_set_state (management,
 				OPENVPN_STATE_ADD_ROUTES,
@@ -1025,10 +995,9 @@ add_routes (struct route_list *rl, struct route_ipv6_list *rl6, const struct tun
 				0);
 	}
 #endif
-      
-      for (i = 0; i < rl->n; ++i)
+
+      for (r = rl->routes; r; r = r->next)
 	{
-	  struct route_ipv4 *r = &rl->routes[i];
 	  check_subnet_conflict (r->network, r->netmask, "route");
 	  if (flags & ROUTE_DELETE_FIRST)
 	    delete_route (r, tt, flags, &rl->rgi, es);
@@ -1038,11 +1007,9 @@ add_routes (struct route_list *rl, struct route_ipv6_list *rl6, const struct tun
     }
   if (rl6 && !rl6->routes_added)
     {
-      int i;
-
-      for (i = 0; i < rl6->n; ++i)
+      struct route_ipv6 *r;
+      for (r = rl6->routes_ipv6; r; r = r->next)
 	{
-	  struct route_ipv6 *r = &rl6->routes_ipv6[i];
 	  if (flags & ROUTE_DELETE_FIRST)
 	    delete_route_ipv6 (r, tt, flags, es);
 	  add_route_ipv6 (r, tt, flags, es);
@@ -1057,10 +1024,9 @@ delete_routes (struct route_list *rl, struct route_ipv6_list *rl6,
 {
   if ( rl && rl->iflags & RL_ROUTES_ADDED )
     {
-      int i;
-      for (i = rl->n - 1; i >= 0; --i)
+      struct route_ipv4 *r;
+      for (r = rl->routes; r; r = r->next)
 	{
-	  struct route_ipv4 * r = &rl->routes[i];
 	  delete_route (r, tt, flags, &rl->rgi, es);
 	}
       rl->iflags &= ~RL_ROUTES_ADDED;
@@ -1075,10 +1041,9 @@ delete_routes (struct route_list *rl, struct route_ipv6_list *rl6,
 
   if ( rl6 && rl6->routes_added )
     {
-      int i;
-      for (i = rl6->n - 1; i >= 0; --i)
+      struct route_ipv6 *r6;
+      for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
 	{
-	  const struct route_ipv6 *r6 = &rl6->routes_ipv6[i];
 	  delete_route_ipv6 (r6, tt, flags, es);
 	}
       rl6->routes_added = false;
@@ -1115,12 +1080,12 @@ void
 print_route_options (const struct route_option_list *rol,
 		     int level)
 {
-  int i;
+  struct route_option *ro;
   if (rol->flags & RG_ENABLE)
     msg (level, "  [redirect_default_gateway local=%d]",
 	 (rol->flags & RG_LOCAL) != 0);
-  for (i = 0; i < rol->n; ++i)
-    print_route_option (&rol->routes[i], level);
+  for (ro = rol->routes; ro; ro = ro->next)
+    print_route_option (ro, level);
 }
 
 void
@@ -1165,9 +1130,9 @@ print_route (const struct route_ipv4 *r, int level)
 void
 print_routes (const struct route_list *rl, int level)
 {
-  int i;
-  for (i = 0; i < rl->n; ++i)
-    print_route (&rl->routes[i], level);
+  struct route_ipv4 *r;
+  for (r = rl->routes; r; r = r->next)
+    print_route (r, level);
 }
 
 static void
@@ -1193,9 +1158,10 @@ setenv_route (struct env_set *es, const struct route_ipv4 *r, int i)
 void
 setenv_routes (struct env_set *es, const struct route_list *rl)
 {
-  int i;
-  for (i = 0; i < rl->n; ++i)
-    setenv_route (es, &rl->routes[i], i + 1);
+  int i = 1;
+  struct route_ipv4 *r;
+  for (r = rl->routes; r; r = r->next)
+    setenv_route (es, r, i++);
 }
 
 static void
@@ -1221,9 +1187,10 @@ setenv_route_ipv6 (struct env_set *es, const struct route_ipv6 *r6, int i)
 void
 setenv_routes_ipv6 (struct env_set *es, const struct route_ipv6_list *rl6)
 {
-  int i;
-  for (i = 0; i < rl6->n; ++i)
-    setenv_route_ipv6 (es, &rl6->routes_ipv6[i], i + 1);
+  int i = 1;
+  struct route_ipv6 *r6;
+  for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
+    setenv_route_ipv6 (es, r6, i++);
 }
 
 /*
@@ -2137,6 +2104,7 @@ test_routes (const struct route_list *rl, const struct tuntap *tt)
   int count = 0;
   int good = 0;
   int ambig = 0;
+  int len = -1;
   bool adapter_up = false;
 
   if (is_adapter_up (tt, adapters))
@@ -2146,9 +2114,9 @@ test_routes (const struct route_list *rl, const struct tuntap *tt)
 
       if (rl)
 	{
-	  int i;
-	  for (i = 0; i < rl->n; ++i)
-	    test_route_helper (&ret, &count, &good, &ambig, adapters, rl->routes[i].gateway);
+	  struct route *r;
+	  for (r = rl->routes, len = 0; r; r = r->next, ++len)
+	    test_route_helper (&ret, &count, &good, &ambig, adapters, r->gateway);
 
 	  if ((rl->flags & RG_ENABLE) && (rl->spec.flags & RTSA_REMOTE_ENDPOINT))
 	    test_route_helper (&ret, &count, &good, &ambig, adapters, rl->spec.remote_endpoint);
@@ -2158,7 +2126,7 @@ test_routes (const struct route_list *rl, const struct tuntap *tt)
   msg (D_ROUTE, "TEST ROUTES: %d/%d succeeded len=%d ret=%d a=%d u/d=%s",
        good,
        count,
-       rl ? rl->n : -1,
+       len,
        (int)ret,
        ambig,
        adapter_up ? "up" : "down");
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index fe9b461..f3c0150 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -33,8 +33,6 @@
 #include "tun.h"
 #include "misc.h"
 
-#define MAX_ROUTES_DEFAULT 100
-
 #ifdef WIN32
 /*
  * Windows route methods
@@ -74,6 +72,7 @@ struct route_special_addr
 };
 
 struct route_option {
+  struct route_option *next;
   const char *network;
   const char *netmask;
   const char *gateway;
@@ -92,12 +91,12 @@ struct route_option {
 
 struct route_option_list {
   unsigned int flags;  /* RG_x flags */
-  int capacity;
-  int n;
-  struct route_option routes[EMPTY_ARRAY_SIZE];
+  struct route_option *routes;
+  struct gc_arena *gc;
 };
 
 struct route_ipv6_option {
+  struct route_ipv6_option *next;
   const char *prefix;		/* e.g. "2001:db8:1::/64" */
   const char *gateway;		/* e.g. "2001:db8:0::2" */
   const char *metric;		/* e.g. "5" */
@@ -105,15 +104,15 @@ struct route_ipv6_option {
 
 struct route_ipv6_option_list {
   unsigned int flags;
-  int capacity;
-  int n;
-  struct route_ipv6_option routes_ipv6[EMPTY_ARRAY_SIZE];
+  struct route_ipv6_option *routes_ipv6;
+  struct gc_arena *gc;
 };
 
 struct route_ipv4 {
 # define RT_DEFINED        (1<<0)
 # define RT_ADDED          (1<<1)
 # define RT_METRIC_DEFINED (1<<2)
+  struct route_ipv4 *next;
   unsigned int flags;
   const struct route_option *option;
   in_addr_t network;
@@ -123,6 +122,7 @@ struct route_ipv4 {
 };
 
 struct route_ipv6 {
+  struct route_ipv6 *next;
   bool defined;
   struct in6_addr network;
   unsigned int netbits;
@@ -140,9 +140,8 @@ struct route_ipv6_list {
   bool remote_endpoint_defined;
   bool did_redirect_default_gateway;			/* TODO (?) */
   bool did_local;					/* TODO (?) */
-  int capacity;
-  int n;
-  struct route_ipv6 routes_ipv6[EMPTY_ARRAY_SIZE];
+  struct route_ipv6 *routes_ipv6;
+  struct gc_arena gc;
 };
 
 
@@ -188,9 +187,8 @@ struct route_list {
   struct route_special_addr spec;
   struct route_gateway_info rgi;
   unsigned int flags;     /* RG_x flags */
-  int capacity;
-  int n;
-  struct route_ipv4 routes[EMPTY_ARRAY_SIZE];
+  struct route_ipv4 *routes;
+  struct gc_arena gc;
 };
 
 #if P2MP
@@ -208,17 +206,15 @@ struct iroute_ipv6 {
 };
 #endif
 
-struct route_option_list *new_route_option_list (const int max_routes, struct gc_arena *a);
-struct route_ipv6_option_list *new_route_ipv6_option_list (const int max_routes, struct gc_arena *a);
+struct route_option_list *new_route_option_list (struct gc_arena *a);
+struct route_ipv6_option_list *new_route_ipv6_option_list (struct gc_arena *a);
 
 struct route_option_list *clone_route_option_list (const struct route_option_list *src, struct gc_arena *a);
 struct route_ipv6_option_list *clone_route_ipv6_option_list (const struct route_ipv6_option_list *src, struct gc_arena *a);
-void copy_route_option_list (struct route_option_list *dest, const struct route_option_list *src);
+void copy_route_option_list (struct route_option_list *dest, const struct route_option_list *src, struct gc_arena *a);
 void copy_route_ipv6_option_list (struct route_ipv6_option_list *dest,
-				  const struct route_ipv6_option_list *src);
-
-struct route_list *new_route_list (const int max_routes, struct gc_arena *a);
-struct route_ipv6_list *new_route_ipv6_list (const int max_routes, struct gc_arena *a);
+                                  const struct route_ipv6_option_list *src,
+                                  struct gc_arena *a);
 
 void add_route_ipv6 (struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
 void delete_route_ipv6 (const struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
-- 
1.8.2.3


