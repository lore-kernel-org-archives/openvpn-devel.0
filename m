From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:43 +0200
Message-Id: <1441985627-14822-7-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-1-git-send-email-gert@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 06/10] Implement handling of overlapping
	IPv6 routes with IPv6 remote VPN server address
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

- socket.[ch]: add link_socket_current_remote_ipv6() helper to extract
   current address of remote VPN server (if IPv6, NULL otherwise), IPv6
   equivalent to link_socket_current_remote()

- init.c: pass remote VPN server address to init_route_ipv6_list()
   (link_socket_current_remote_ipv6())

- route.h: add route_ipv6_gateway_info to route_ipv6_list, and reorder
   structures so that this actually compiles.  Add iface/adapter_index
   to struct route_ipv6 (for non-tun/tap routes).

- route.[ch]: add "const" to *dest argument to get_default_gateway_ipv6()

- route.c: add route_ipv6_match_host() helper to check whether an IPv6
   address is matched by a given "route_ipv6" IPv6 route)

- route.c: init_route_ipv6_list()
   - call get_default_gateway_ipv6()
   - check to-be-installed IPv6 routes against VPN server address (if IPv6)
   - if an overlap is seen, add a host route for the VPN server address
     via the just-discovered gateway to the list of IPv6 routes to be
     installed (rl6->routes_ipv6)
   - warn if overlap is detected but platform code has not been able to
     discover IPv6 default gateway

- route.c: add_route_ipv6() / delete_route_ipv6(): set "device" to
   "external default gateway interface" (r6->iface) instead of TUN/TAP
   device (if set), which nicely enables arbitrary gateway/interface
   combinations for Linux

- ssl.c: add "IV_RGI6=1" to push-peer-info data to let server know we can
  handle pushed IPv6 routes that overlap with server IPv6 address

- tun.c: when adding/removing on-link routes, CLEAR(r6) first to
  ensure new struct route_ipv6 members are cleared

Tested on Linux with iproute2 and /bin/route, on eth and tun routes.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c   |   4 +-
 src/openvpn/route.c  | 132 ++++++++++++++++++++++++++++++++++++++++++++++-----
 src/openvpn/route.h  |  36 ++++++++------
 src/openvpn/socket.c |  22 +++++++++
 src/openvpn/socket.h |   2 +
 src/openvpn/ssl.c    |   3 ++
 src/openvpn/tun.c    |   2 +
 7 files changed, 175 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4c17905..0416e35 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1179,6 +1179,7 @@ do_init_route_list (const struct options *options,
 static void
 do_init_route_ipv6_list (const struct options *options,
 		    struct route_ipv6_list *route_ipv6_list,
+		    const struct link_socket_info *link_socket_info,
 		    bool fatal,
 		    struct env_set *es)
 {
@@ -1198,6 +1199,7 @@ do_init_route_ipv6_list (const struct options *options,
 			options->routes_ipv6,
 			gw,
 			metric,
+			link_socket_current_remote_ipv6 (link_socket_info),
 			es))
     {
       if (fatal)
@@ -1391,7 +1393,7 @@ do_open_tun (struct context *c)
       if (c->options.routes && c->c1.route_list && c->c2.link_socket)
 	do_init_route_list (&c->options, c->c1.route_list, &c->c2.link_socket->info, false, c->c2.es);
       if (c->options.routes_ipv6 && c->c1.route_ipv6_list )
-	do_init_route_ipv6_list (&c->options, c->c1.route_ipv6_list, false, c->c2.es);
+	do_init_route_ipv6_list (&c->options, c->c1.route_ipv6_list, &c->c2.link_socket->info, false, c->c2.es);
 
       /* do ifconfig */
       if (!c->options.ifconfig_noexec
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index cca5cfe..555c3a6 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -658,29 +658,78 @@ init_route_list (struct route_list *rl,
   return ret;
 }
 
+/* check whether an IPv6 host address is covered by a given route_ipv6
+ * (not the most beautiful implementation in the world, but portable and
+ * "good enough")
+ */
+static bool
+route_ipv6_match_host( const struct route_ipv6 *r6,
+		       const struct in6_addr *host )
+{
+    int bits = r6->netbits;
+    int i;
+    unsigned int mask;
+
+    if ( bits<0 || bits>128 )
+	return false;
+
+    for( i=0; bits >= 8; i++, bits -= 8 )
+    {
+	if ( r6->network.s6_addr[i] != host->s6_addr[i] )
+	    return false;
+    }
+
+    if ( bits == 0 )
+	return true;
+
+    mask = 0xff << (8-bits);
+
+    if ( (r6->network.s6_addr[i] & mask) == (host->s6_addr[i] & mask ))
+	return true;
+
+    return false;
+}
+
 bool
 init_route_ipv6_list (struct route_ipv6_list *rl6,
 		 const struct route_ipv6_option_list *opt6,
 		 const char *remote_endpoint,
 		 int default_metric,
+		 const struct in6_addr *remote_host_ipv6,
 		 struct env_set *es)
 {
   struct gc_arena gc = gc_new ();
   bool ret = true;
+  bool need_remote_ipv6_route;
 
   clear_route_ipv6_list (rl6);
 
   rl6->flags = opt6->flags;
 
+  if (remote_host_ipv6)
+    {
+      rl6->remote_host_ipv6 = *remote_host_ipv6;
+      rl6->spec_flags |= RTSA_REMOTE_HOST;
+    }
+
   if (default_metric >= 0 )
     {
       rl6->default_metric = default_metric;
       rl6->spec_flags |= RTSA_DEFAULT_METRIC;
     }
 
-  /* "default_gateway" is stuff for "redirect-gateway", which we don't
-   * do for IPv6 yet -> TODO
-   */
+  msg (D_ROUTE, "GDG6: remote_host_ipv6=%s",
+	remote_host_ipv6?  print_in6_addr (*remote_host_ipv6, 0, &gc): "n/a" );
+
+  get_default_gateway_ipv6 (&rl6->rgi6, remote_host_ipv6);
+  if (rl6->rgi6.flags & RGI_ADDR_DEFINED)
+    {
+      setenv_str (es, "net_gateway_ipv6", print_in6_addr (rl6->rgi6.gateway.addr_ipv6, 0, &gc));
+#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+      print_default_gateway (D_ROUTE, NULL, &rl6->rgi6);
+#endif
+    }
+  else
     {
       dmsg (D_ROUTE, "ROUTE6: default_gateway=UNDEF");
     }
@@ -694,12 +743,16 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
         }
       else
 	{
-	  msg (M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve default gateway: %s", remote_endpoint);
+	  msg (M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve VPN endpoint: %s", remote_endpoint);
           ret = false;
 	}
     }
 
-  /* parse the routes from opt6 to rl6 */
+  /* parse the routes from opt6 to rl6
+   * discovering potential overlaps with remote_host_ipv6 in the process
+   */
+  need_remote_ipv6_route = false;
+
   {
     struct route_ipv6_option *ro6;
     for (ro6 = opt6->routes_ipv6; ro6; ro6 = ro6->next)
@@ -712,10 +765,49 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
           {
             r6->next = rl6->routes_ipv6;
             rl6->routes_ipv6 = r6;
+
+	    if ( remote_host_ipv6 &&
+		  route_ipv6_match_host( r6, remote_host_ipv6 ) )
+	      {
+		need_remote_ipv6_route = true;
+		msg (D_ROUTE, "ROUTE6: %s/%d overlaps IPv6 remote %s, adding host route to VPN endpoint",
+			print_in6_addr (r6->network, 0, &gc), r6->netbits,
+			print_in6_addr (*remote_host_ipv6, 0, &gc));
+	      }
           }
       }
   }
 
+  /* add VPN server host route if needed */
+  if ( need_remote_ipv6_route )
+    {
+      if ( (rl6->rgi6.flags & (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED) ) ==
+				    (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED) )
+        {
+	  struct route_ipv6 *r6;
+	  ALLOC_OBJ_CLEAR_GC (r6, struct route_ipv6, &rl6->gc);
+
+	  r6->network = *remote_host_ipv6;
+	  r6->netbits = 128;
+	  if ( !(rl6->rgi6.flags & RGI_ON_LINK) )
+	    { r6->gateway = rl6->rgi6.gateway.addr_ipv6; }
+	  r6->metric = 1;
+#ifdef WIN32
+	  r6->adapter_index = rl6->rgi6.adapter_index;
+#else
+	  r6->iface = rl6->rgi6.iface;
+#endif
+	  r6->flags = RT_DEFINED | RT_METRIC_DEFINED;
+
+	  r6->next = rl6->routes_ipv6;
+	  rl6->routes_ipv6 = r6;
+	}
+      else
+        {
+	  msg (M_WARN, "ROUTE6: IPv6 route overlaps with IPv6 remote address, but could not determine IPv6 gateway address + interface, expect failure\n" );
+	}
+    }
+
   gc_free (&gc);
   return ret;
 }
@@ -1570,6 +1662,15 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   if (! (r6->flags & RT_DEFINED) )
     return;
 
+#ifndef WIN32
+  if ( r6->iface != NULL )		/* vpn server special route */
+    {
+      device = r6->iface;
+      if ( !IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
+	  gateway_needed = true;
+    }
+#endif
+
   gc_init (&gc);
   argv_init (&argv);
 
@@ -1651,7 +1752,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
    * - in TUN mode we use a special-case link-local address that the tapdrvr
    *   knows about and will answer ND (neighbor discovery) packets for
    */
-  if ( tt->type == DEV_TYPE_TUN )
+  if ( tt->type == DEV_TYPE_TUN && !gateway_needed )
 	argv_printf_cat( &argv, " %s", "fe80::8" );
   else
 	argv_printf_cat( &argv, " %s", gateway );
@@ -1944,6 +2045,14 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   if ((r6->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
     return;
 
+#ifndef WIN32
+  if ( r6->iface != NULL )		/* vpn server special route */
+    {
+      device = r6->iface;
+      gateway_needed = true;
+    }
+#endif
+
   gc_init (&gc);
   argv_init (&argv);
 
@@ -2340,7 +2449,7 @@ windows_route_find_if_index (const struct route_ipv4 *r, const struct tuntap *tt
  */
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-			 struct in6_addr *dest)
+			 const struct in6_addr *dest)
 {
     msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system (windows)");
     CLEAR(*rgi6);
@@ -2675,7 +2784,7 @@ struct rtreq {
 
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-			 struct in6_addr *dest)
+			 const struct in6_addr *dest)
 {
     int nls = -1;
     struct rtreq rtreq;
@@ -2792,7 +2901,8 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
               RGI_IFACE_DEFINED )
     {
 	rgi6->flags |= (RGI_ADDR_DEFINED | RGI_ON_LINK);
-	rgi6->gateway.addr_ipv6 = *dest;
+	if ( dest )
+	    rgi6->gateway.addr_ipv6 = *dest;
     }
 
   done:
@@ -3046,7 +3156,7 @@ get_default_gateway (struct route_gateway_info *rgi)
  */
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-			 struct in6_addr *dest)
+			 const struct in6_addr *dest)
 {
     msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system (BSD and OSX)");
     CLEAR(*rgi6);
@@ -3087,7 +3197,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 }
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-			 struct in6_addr *dest)
+			 const struct in6_addr *dest)
 {
     msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system");
     CLEAR(*rgi6);
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 95cf99f..4bbcdb7 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -128,19 +128,12 @@ struct route_ipv6 {
   unsigned int netbits;
   struct in6_addr gateway;
   int metric;
-};
-
-struct route_ipv6_list {
-  unsigned int iflags;			/* RL_ flags, see route_list */
-
-  unsigned int spec_flags;		/* RTSA_ flags, route_special_addr */
-  struct in6_addr remote_endpoint_ipv6;	/* inside tun */
-  struct in6_addr remote_host_ipv6;	/* --remote address */
-  int default_metric;
-
-  unsigned int flags;			/* RG_x flags, see route_option_list */
-  struct route_ipv6 *routes_ipv6;
-  struct gc_arena gc;
+  /* gateway interface */
+# ifdef WIN32
+  DWORD adapter_index;		/* interface or ~0 if undefined */
+#else
+  char * iface;			/* interface name (null terminated) */
+#endif
 };
 
 
@@ -218,6 +211,20 @@ struct route_list {
   struct gc_arena gc;
 };
 
+struct route_ipv6_list {
+  unsigned int iflags;			/* RL_ flags, see route_list */
+
+  unsigned int spec_flags;		/* RTSA_ flags, route_special_addr */
+  struct in6_addr remote_endpoint_ipv6;	/* inside tun */
+  struct in6_addr remote_host_ipv6;	/* --remote address */
+  int default_metric;
+
+  struct route_ipv6_gateway_info rgi6;
+  unsigned int flags;			/* RG_x flags, see route_option_list */
+  struct route_ipv6 *routes_ipv6;
+  struct gc_arena gc;
+};
+
 #if P2MP
 /* internal OpenVPN route */
 struct iroute {
@@ -274,6 +281,7 @@ bool init_route_ipv6_list (struct route_ipv6_list *rl6,
 		      const struct route_ipv6_option_list *opt6,
 		      const char *remote_endpoint,
 		      int default_metric,
+		      const struct in6_addr *remote_host,
 		      struct env_set *es);
 
 void route_list_add_vpn_gateway (struct route_list *rl,
@@ -301,7 +309,7 @@ bool is_special_addr (const char *addr_str);
 
 void get_default_gateway (struct route_gateway_info *rgi);
 void get_default_gateway_ipv6 (struct route_ipv6_gateway_info *rgi,
-				struct in6_addr *dest);
+				const struct in6_addr *dest);
 void print_default_gateway(const int msglevel,
                            const struct route_gateway_info *rgi,
                            const struct route_ipv6_gateway_info *rgi6);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7f889b1..dcff7a3 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2143,6 +2143,28 @@ link_socket_current_remote (const struct link_socket_info *info)
     return 0;
 }
 
+const struct in6_addr *
+link_socket_current_remote_ipv6 (const struct link_socket_info *info)
+{
+  const struct link_socket_addr *lsa = info->lsa;
+
+/* This logic supports "redirect-gateway" semantic,
+ * for PF_INET6 routes over PF_INET6 endpoints
+ *
+ * For --remote entries with multiple addresses this
+ * only return the actual endpoint we have sucessfully connected to
+ */
+  if (lsa->actual.dest.addr.sa.sa_family != AF_INET6)
+    return NULL;
+
+  if (link_socket_actual_defined (&lsa->actual))
+    return &(lsa->actual.dest.addr.in6.sin6_addr);
+  else if (lsa->current_remote)
+    return &(((struct sockaddr_in6*)lsa->current_remote->ai_addr) ->sin6_addr);
+  else
+    return NULL;
+}
+
 /*
  * Return a status string describing socket state.
  */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 8e157c6..49cfab6 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -419,6 +419,8 @@ void bad_address_length (int actual, int expected);
  */
 #define IPV4_INVALID_ADDR 0xffffffff
 in_addr_t link_socket_current_remote (const struct link_socket_info *info);
+const struct in6_addr * link_socket_current_remote_ipv6
+				     (const struct link_socket_info *info);
 
 void link_socket_connection_initiated (const struct buffer *buf,
 				       struct link_socket_info *info,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4e44410..54a3e09 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1853,6 +1853,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       comp_generate_peer_info_string(&session->opt->comp_options, &out);
 #endif
 
+      /* support for redirecting IPv6 gateway */
+      buf_printf(&out, "IV_RGI6=1\n");
+
       if (session->opt->push_peer_info_detail >= 2)
         {
 	  /* push mac addr */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 766a73c..24a61ec 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -607,6 +607,7 @@ void add_route_connected_v6_net(struct tuntap * tt,
 {
     struct route_ipv6 r6;
 
+    CLEAR(r6);
     r6.network = tt->local_ipv6;
     r6.netbits = tt->netbits_ipv6;
     r6.gateway = tt->local_ipv6;
@@ -620,6 +621,7 @@ void delete_route_connected_v6_net(struct tuntap * tt,
 {
     struct route_ipv6 r6;
 
+    CLEAR(r6);
     r6.network = tt->local_ipv6;
     r6.netbits = tt->netbits_ipv6;
     r6.gateway = tt->local_ipv6;
-- 
2.3.6


