From: Arne Schwabe <arne@...1227...>
Date: Mon,  7 Jul 2014 14:12:19 +0200
Message-Id: <1404735142-31420-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/4] Remove #ifdefs for client nat support.
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

The client-nat feature was always unconditionally enabled
---
 src/openvpn/clinat.c  |  4 ----
 src/openvpn/clinat.h  |  2 +-
 src/openvpn/forward.c | 12 +++++++-----
 src/openvpn/multi.c   |  2 --
 src/openvpn/openvpn.h |  2 --
 src/openvpn/options.c | 18 +-----------------
 src/openvpn/options.h |  7 -------
 src/openvpn/push.c    |  4 ----
 src/openvpn/syshead.h |  5 -----
 9 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index af75fc9..ddefe12 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -30,8 +30,6 @@
 
 #include "syshead.h"
 
-#if defined(ENABLE_CLIENT_NAT)
-
 #include "clinat.h"
 #include "proto.h"
 #include "socket.h"
@@ -265,5 +263,3 @@ client_nat_transform (const struct client_nat_option_list *list,
 	}
     }
 }
-
-#endif
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index d55a727..a5779e1 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -22,7 +22,7 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#if !defined(CLINAT_H) && defined(ENABLE_CLIENT_NAT)
+#if !defined(CLINAT_H)
 #define CLINAT_H
 
 #include "buffer.h"
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8d524ce..e607859 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1018,6 +1018,8 @@ process_ip_header (struct context *c, unsigned int flags, struct buffer *buf)
   if (!c->options.passtos)
     flags &= ~PIPV4_PASSTOS;
 #endif
+  if (!c->options.client_nat)
+    flags &= ~PIPV4_CLIENT_NAT;
   if (!c->options.route_gateway_via_dhcp)
     flags &= ~PIPV4_EXTRACT_DHCP_ROUTER;
 
@@ -1027,11 +1029,13 @@ process_ip_header (struct context *c, unsigned int flags, struct buffer *buf)
        * The --passtos and --mssfix options require
        * us to examine the IPv4 header.
        */
+
+      if (flags & (PIP_MSSFIX
 #if PASSTOS_CAPABILITY
-      if (flags & (PIPV4_PASSTOS|PIP_MSSFIX))
-#else
-      if (flags & PIP_MSSFIX)
+	  | PIPV4_PASSTOS
 #endif
+	  | PIPV4_CLIENT_NAT
+	  ))
 	{
 	  struct buffer ipbuf = *buf;
 	  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
@@ -1046,14 +1050,12 @@ process_ip_header (struct context *c, unsigned int flags, struct buffer *buf)
 	      if (flags & PIP_MSSFIX)
 		mss_fixup_ipv4 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
 
-#ifdef ENABLE_CLIENT_NAT
 	      /* possibly do NAT on packet */
 	      if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
 		{
 		  const int direction = (flags & PIPV4_OUTGOING) ? CN_INCOMING : CN_OUTGOING;
 		  client_nat_transform (c->options.client_nat, &ipbuf, direction);
 		}
-#endif
 	      /* possibly extract a DHCP router message */
 	      if (flags & PIPV4_EXTRACT_DHCP_ROUTER)
 		{
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 5910154..9a2b023 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1296,9 +1296,7 @@ multi_select_virtual_addr (struct multi_context *m, struct multi_instance *mi)
       mi->context.c2.push_ifconfig_defined = true;
       mi->context.c2.push_ifconfig_local = mi->context.options.push_ifconfig_local;
       mi->context.c2.push_ifconfig_remote_netmask = mi->context.options.push_ifconfig_remote_netmask;
-#ifdef ENABLE_CLIENT_NAT
       mi->context.c2.push_ifconfig_local_alias = mi->context.options.push_ifconfig_local_alias;
-#endif
 
       /* the current implementation does not allow "static IPv4, pool IPv6",
        * (see below) so issue a warning if that happens - don't break the
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 7ad6c55..4f9c4d1 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -454,9 +454,7 @@ struct context_2
   time_t sent_push_reply_expiry;
   in_addr_t push_ifconfig_local;
   in_addr_t push_ifconfig_remote_netmask;
-#ifdef ENABLE_CLIENT_NAT
   in_addr_t push_ifconfig_local_alias;
-#endif
 
   bool            push_ifconfig_ipv6_defined;
   struct in6_addr push_ifconfig_ipv6_local;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fd486b9..a3d67aa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -243,9 +243,7 @@ static const char usage_message[] =
   "                  Add 'bypass-dns' flag to similarly bypass tunnel for DNS.\n"
   "--redirect-private [flags]: Like --redirect-gateway, but omit actually changing\n"
   "                  the default gateway.  Useful when pushing private subnets.\n"
-#ifdef ENABLE_CLIENT_NAT
   "--client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT rule.\n"
-#endif
 #ifdef ENABLE_PUSH_PEER_INFO
   "--push-peer-info : (client only) push client info to server.\n"
 #endif
@@ -1322,9 +1320,7 @@ options_detach (struct options *o)
 {
   gc_detach (&o->gc);
   o->routes = NULL;
-#ifdef ENABLE_CLIENT_NAT
   o->client_nat = NULL;
-#endif
 #if P2MP_SERVER
   clone_push_list(o);
 #endif
@@ -1344,14 +1340,12 @@ rol6_check_alloc (struct options *options)
     options->routes_ipv6 = new_route_ipv6_option_list (&options->gc);
 }
 
-#ifdef ENABLE_CLIENT_NAT
 static void
 cnol_check_alloc (struct options *options)
 {
   if (!options->client_nat)
     options->client_nat = new_client_nat_list (&options->gc);
 }
-#endif
 
 #ifndef ENABLE_SMALL
 static void
@@ -1553,11 +1547,9 @@ show_settings (const struct options *o)
   SHOW_BOOL (allow_pull_fqdn);
   if (o->routes)
     print_route_options (o->routes, D_SHOW_PARMS);
-  
-#ifdef ENABLE_CLIENT_NAT
+
   if (o->client_nat)
     print_client_nat_list(o->client_nat, D_SHOW_PARMS);
-#endif
 
 #ifdef ENABLE_MANAGEMENT
   SHOW_STR (management_addr);
@@ -2819,13 +2811,11 @@ pre_pull_save (struct options *o)
 	  o->pre_pull->routes_ipv6 = clone_route_ipv6_option_list(o->routes_ipv6, &o->gc);
 	  o->pre_pull->routes_ipv6_defined = true;
 	}
-#ifdef ENABLE_CLIENT_NAT
       if (o->client_nat)
 	{
 	  o->pre_pull->client_nat = clone_client_nat_option_list(o->client_nat, &o->gc);
 	  o->pre_pull->client_nat_defined = true;
 	}
-#endif
     }
 }
 
@@ -2855,7 +2845,6 @@ pre_pull_restore (struct options *o, struct gc_arena *gc)
       else
 	o->routes_ipv6 = NULL;
 
-#ifdef ENABLE_CLIENT_NAT
       if (pp->client_nat_defined)
 	{
 	  cnol_check_alloc (o);
@@ -2863,7 +2852,6 @@ pre_pull_restore (struct options *o, struct gc_arena *gc)
 	}
       else
 	o->client_nat = NULL;
-#endif
 
       o->foreign_option_index = pp->foreign_option_index;
     }
@@ -5212,14 +5200,12 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_PERSIST_IP);
       options->persist_remote_ip = true;
     }
-#ifdef ENABLE_CLIENT_NAT
   else if (streq (p[0], "client-nat") && p[1] && p[2] && p[3] && p[4])
     {
       VERIFY_PERMISSION (OPT_P_ROUTE);
       cnol_check_alloc (options);
       add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3], p[4], msglevel);
     }
-#endif
   else if (streq (p[0], "route") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_ROUTE);
@@ -5805,10 +5791,8 @@ add_option (struct options *options,
 	  options->push_ifconfig_defined = true;
 	  options->push_ifconfig_local = local;
 	  options->push_ifconfig_remote_netmask = remote_netmask;
-#ifdef ENABLE_CLIENT_NAT
 	  if (p[3])
 	    options->push_ifconfig_local_alias = getaddr (GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[3], 0, NULL, NULL);
-#endif
 	}
       else
 	{
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a3b76d3..30f09da 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -71,10 +71,8 @@ struct options_pre_pull
   bool routes_ipv6_defined;
   struct route_ipv6_option_list *routes_ipv6;
 
-#ifdef ENABLE_CLIENT_NAT
   bool client_nat_defined;
   struct client_nat_option_list *client_nat;
-#endif
 
   int foreign_option_index;
 };
@@ -352,10 +350,7 @@ struct options
   bool route_nopull;
   bool route_gateway_via_dhcp;
   bool allow_pull_fqdn; /* as a client, allow server to push a FQDN for certain parameters */
-
-#ifdef ENABLE_CLIENT_NAT
   struct client_nat_option_list *client_nat;
-#endif
 
 #ifdef ENABLE_OCC
   /* Enable options consistency check between peers */
@@ -436,9 +431,7 @@ struct options
   bool push_ifconfig_defined;
   in_addr_t push_ifconfig_local;
   in_addr_t push_ifconfig_remote_netmask;
-#ifdef ENABLE_CLIENT_NAT
   in_addr_t push_ifconfig_local_alias;
-#endif
   bool push_ifconfig_constraint_defined;
   in_addr_t push_ifconfig_constraint_network;
   in_addr_t push_ifconfig_constraint_netmask;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 1de9f74..ea788b0 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -68,7 +68,6 @@ receive_auth_failed (struct context *c, const struct buffer *buffer)
 	  ASSERT (0);
 	}
       c->sig->signal_text = "auth-failure";
-#ifdef ENABLE_MANAGEMENT
       if (management)
 	{
 	  const char *reason = NULL;
@@ -77,7 +76,6 @@ receive_auth_failed (struct context *c, const struct buffer *buffer)
 	    reason = BSTR (&buf);
 	  management_auth_failure (management, UP_TYPE_AUTH, reason);
 	} else
-#endif
 	{
 #ifdef ENABLE_CLIENT_CR
 	  struct buffer buf = *buffer;
@@ -294,10 +292,8 @@ send_push_reply (struct context *c)
   if (c->c2.push_ifconfig_defined && c->c2.push_ifconfig_local && c->c2.push_ifconfig_remote_netmask)
     {
       in_addr_t ifconfig_local = c->c2.push_ifconfig_local;
-#ifdef ENABLE_CLIENT_NAT
       if (c->c2.push_ifconfig_local_alias)
 	ifconfig_local = c->c2.push_ifconfig_local_alias;
-#endif
       buf_printf (&buf, ",ifconfig %s %s",
 		  print_in_addr_t (ifconfig_local, 0, &gc),
 		  print_in_addr_t (c->c2.push_ifconfig_remote_netmask, 0, &gc));
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 22ea5a0..3a789bc 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -723,11 +723,6 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Do we support internal client-side NAT?
- */
-#define ENABLE_CLIENT_NAT
-
-/*
  * Compression support
  */
 #if defined(ENABLE_SNAPPY) || defined(ENABLE_LZO) || defined(ENABLE_LZ4) || \
-- 
1.8.5.2 (Apple Git-48)


