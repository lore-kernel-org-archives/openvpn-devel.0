From: chantra <chantra@...1258...>
In-Reply-To: <4C49C13B.4050004@...1114...>
References: <4C494C31.7020601@...1114...>
	<20100723140617.19037.qmail@...1287...>
	<4C49C13B.4050004@...1114...>
Content-Type: multipart/mixed; boundary="=-KD7gIRHHCRvGNWuvpOug"
Date: Fri, 30 Jul 2010 11:27:50 +0200
Message-ID: <1280482071.6083.50.camel@...1259...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [RFC] - (ticket #29) - Fix for --push-reset
	resetting --topology and --route-gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--=-KD7gIRHHCRvGNWuvpOug
Content-Type: multipart/alternative; boundary="=-p0jgjQPtRZJLkDIAnG1D"

--=-p0jgjQPtRZJLkDIAnG1D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



> >> 3) Add a flag to the PUSH_REPLY list indicating if it is immutable

I cooked up a patch that would do that:
https://community.openvpn.net/openvpn/attachment/ticket/29/0001-Make-some-push-options-not-resetable-by-ccd-config.patch


        Make some push options not resetable by ccd config
        
        Fixes bug ticket 29
        <https://community.openvpn.net/openvpn/ticket/29>
        
        When client configuration has a 'push-reset' option,
        non-immutable global options will not be pushed to client.
        
        Only options added after the *last* push-reset will be set
        immutable.
        
        This way, if push-reset is given in ccd files and plugin
        returned list, only the configuration options from the plugin
        will be set immutable.


I tried the following scenarios (in topology subnet):
client with no ccd file and no options returned by connect_v2 plugin
call -> OK
client with push-reset in ccd file and push reset in connect_v2 plugin
call -> OK (only connect_v2 options are pushed to client)
client with push-reset in ccd file and no push-reset in connect_v2
plugin call -> OK (only got options from ccd file and connect_v2)
client with ccd file and options returned by connect_v2 plugin call (no
push-reset in either case) -> OK (got global config + ccd file config +
connect_v2 config)

I am not really happy with all those 
last_option = mi->context.options.push_list.tail;
...
if (mi->context.options.push_reset){}

But this is the only way I can think off in order to make sure that the
latest push-reset will take precedence.

Any comments are welcome.

Tks

chantra

-- 
http://www.debuntu.org

--=-p0jgjQPtRZJLkDIAnG1D
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.3">
</HEAD>
<BODY>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
&gt;&gt; 3) Add a flag to the PUSH_REPLY list indicating if it is immutable
</PRE>
</BLOCKQUOTE>
I cooked up a patch that would do that:<BR>
<A HREF="https://community.openvpn.net/openvpn/attachment/ticket/29/0001-Make-some-push-options-not-resetable-by-ccd-config.patch">https://community.openvpn.net/openvpn/attachment/ticket/29/0001-Make-some-push-options-not-resetable-by-ccd-config.patch</A><BR>
<BR>
<BLOCKQUOTE>
<PRE>
Make some push options not resetable by ccd config

Fixes bug ticket 29
&lt;https://community.openvpn.net/openvpn/ticket/29&gt;

When client configuration has a 'push-reset' option,
non-immutable global options will not be pushed to client.

Only options added after the *last* push-reset will be set
immutable.

This way, if push-reset is given in ccd files and plugin
returned list, only the configuration options from the plugin
will be set immutable.
</PRE>
</BLOCKQUOTE>
<BR>
I tried the following scenarios (in topology subnet):<BR>
client with no ccd file and no options returned by connect_v2 plugin call -&gt; OK<BR>
client with push-reset in ccd file and push reset in connect_v2 plugin call -&gt; OK (only connect_v2 options are pushed to client)<BR>
client with push-reset in ccd file and no push-reset in connect_v2 plugin call -&gt; OK (only got options from ccd file and connect_v2)<BR>
client with ccd file and options returned by connect_v2 plugin call (no push-reset in either case) -&gt; OK (got global config + ccd file config + connect_v2 config)<BR>
<BR>
I am not really happy with all those <BR>
last_option = mi-&gt;context.options.push_list.tail;<BR>
...<BR>
if (mi-&gt;context.options.push_reset){}<BR>
<BR>
But this is the only way I can think off in order to make sure that the latest push-reset will take precedence.<BR>
<BR>
Any comments are welcome.<BR>
<BR>
Tks<BR>
<BR>
chantra<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<PRE>
-- 
<A HREF="http://www.debuntu.org">http://www.debuntu.org</A>
</PRE>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-p0jgjQPtRZJLkDIAnG1D--

--=-KD7gIRHHCRvGNWuvpOug
Content-Disposition: attachment;
	filename="0001-Make-some-push-options-not-resetable-by-ccd-config.patch"
Content-Type: text/x-patch;
	name="0001-Make-some-push-options-not-resetable-by-ccd-config.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 05a33ce2a522e404d99b0815f4dca8eb914bd642 Mon Sep 17 00:00:00 2001
From: chantra <chantra@...1258...>
Date: Thu, 29 Jul 2010 10:14:26 +0200
Subject: [PATCH] Make some push options not resetable by ccd config

Fixes bug ticket 29
<https://community.openvpn.net/openvpn/ticket/29>

When client configuration has a 'push-reset' option,
non-immutable global options will not be pushed to client.

Only options added after the *last* push-reset will be set
immutable.

This way, if push-reset is given in ccd files and plugin
returned list, only the configuration options from the plugin
will be set immutable.

Signed-off-by: chantra <chantra@...1258...>
---
 helper.c   |    5 ++++
 multi.c    |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 options.c  |    3 +-
 options.h  |    1 +
 push.c     |    3 +-
 pushlist.h |    1 +
 6 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/helper.c b/helper.c
index a9d7fd9..44723b4 100644
--- a/helper.c
+++ b/helper.c
@@ -256,11 +256,13 @@ helper_client_server (struct options *o)
 	      o->ifconfig_pool_netmask = o->server_netmask;
 		  
 	      push_option (o, print_opt_route_gateway (o->server_network + 1, &o->gc), M_USAGE);
+	      o->push_list.tail->immutable = true;
 	    }
 	  else
 	    ASSERT (0);
 
 	  push_option (o, print_opt_topology (topology, &o->gc), M_USAGE);
+	  o->push_list.tail->immutable = true;
 	}
       else if (dev == DEV_TYPE_TAP)
 	{
@@ -283,6 +285,7 @@ helper_client_server (struct options *o)
 	  o->ifconfig_pool_netmask = o->server_netmask;
 
 	  push_option (o, print_opt_route_gateway (o->server_network + 1, &o->gc), M_USAGE);
+	  o->push_list.tail->immutable = true;
 	}
       else
 	{
@@ -355,10 +358,12 @@ helper_client_server (struct options *o)
 	  ifconfig_pool_verify_range (M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
 	  o->ifconfig_pool_netmask = o->server_bridge_netmask;
 	  push_option (o, print_opt_route_gateway (o->server_bridge_ip, &o->gc), M_USAGE);
+	  o->push_list.tail->immutable = true;
 	}
       else if (o->server_bridge_proxy_dhcp && !(o->server_flags & SF_NO_PUSH_ROUTE_GATEWAY))
 	{
 	  push_option (o, print_opt_route_gateway_dhcp (&o->gc), M_USAGE);
+	  o->push_list.tail->immutable = true;
 	}
     }
   else
diff --git a/multi.c b/multi.c
index dc26a02..899a345 100644
--- a/multi.c
+++ b/multi.c
@@ -1283,6 +1283,20 @@ multi_set_virtual_addr_env (struct multi_context *m, struct multi_instance *mi)
 }
 
 /*
+ * Set list entry immutable flag to immutable
+ * until end of list
+ */
+static void
+multi_client_connect_post_set_immutable (struct push_entry *e,
+			   bool immutable)
+{
+	while( e ){
+		e->immutable = immutable;
+		e = e->next;
+	}
+}
+
+/*
  * Called after client-connect script is called
  */
 static void
@@ -1442,6 +1456,8 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
     {
       struct gc_arena gc = gc_new ();
       unsigned int option_types_found = 0;
+      struct push_entry *immutable_from_option = NULL, *last_option = NULL;
+      bool push_reset = false;
 
       const unsigned int option_permissions_mask =
 	  OPT_P_INSTANCE
@@ -1487,12 +1503,18 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	  /* try common-name file */
 	  if (test_file (ccd_file))
 	    {
+	      last_option = mi->context.options.push_list.tail;
 	      options_server_import (&mi->context.options,
 				     ccd_file,
 				     D_IMPORT_ERRORS|M_OPTERR,
 				     option_permissions_mask,
 				     &option_types_found,
 				     mi->context.c2.es);
+	      if (mi->context.options.push_reset){
+				     immutable_from_option = last_option;
+				     push_reset = true;
+				     mi->context.options.push_reset = false;
+					}
 	    }
 	  else /* try default file */
 	    {
@@ -1502,12 +1524,19 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
 	      if (test_file (ccd_file))
 		{
+		  last_option = mi->context.options.push_list.tail;
 		  options_server_import (&mi->context.options,
 					 ccd_file,
 					 D_IMPORT_ERRORS|M_OPTERR,
 					 option_permissions_mask,
 					 &option_types_found,
 					 mi->context.c2.es);
+
+		   if (mi->context.options.push_reset){
+					 immutable_from_option = last_option;
+					 push_reset = true;
+					 mi->context.options.push_reset = false;
+	     }
 		}
 	    }
 	}
@@ -1545,7 +1574,14 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	    }
 	  else
 	    {
+	      last_option = mi->context.options.push_list.tail;
 	      multi_client_connect_post (m, mi, dc_file, option_permissions_mask, &option_types_found);
+	      if (mi->context.options.push_reset){
+						immutable_from_option = last_option;
+						push_reset = true;
+						mi->context.options.push_reset = false;
+	      }
+
 	      ++cc_succeeded_count;
 	    }
         script_depr_failed:
@@ -1566,8 +1602,15 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	    }
 	  else
 	    {
+	      last_option = mi->context.options.push_list.tail;
 	      multi_client_connect_post_plugin (m, mi, &pr, option_permissions_mask, &option_types_found);
 	      ++cc_succeeded_count;
+	      if (mi->context.options.push_reset){
+						immutable_from_option = last_option;
+						push_reset = true;
+						mi->context.options.push_reset = false;
+				}
+
 	    }
 
 	  plugin_return_free (&pr);
@@ -1596,8 +1639,14 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
 	  if (openvpn_execve_check (&argv, mi->context.c2.es, S_SCRIPT, "client-connect command failed"))
 	    {
+	      last_option = mi->context.options.push_list.tail;
 	      multi_client_connect_post (m, mi, dc_file, option_permissions_mask, &option_types_found);
 	      ++cc_succeeded_count;
+	      if (mi->context.options.push_reset){
+						immutable_from_option = last_option;
+						push_reset = true;
+						mi->context.options.push_reset = false;
+	      }
 	    }
 	  else
 	    cc_succeeded = false;
@@ -1611,8 +1660,14 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 #ifdef MANAGEMENT_DEF_AUTH
       if (cc_succeeded && mi->cc_config)
 	{
+	  last_option = mi->context.options.push_list.tail;
 	  multi_client_connect_mda (m, mi, mi->cc_config, option_permissions_mask, &option_types_found);
 	  ++cc_succeeded_count;
+	  if (mi->context.options.push_reset){
+		    immutable_from_option = last_option;
+		    push_reset = true;
+		    mi->context.options.push_reset = false;
+	  }
 	}
 #endif
 
@@ -1625,7 +1680,16 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	  msg (D_MULTI_ERRORS, "MULTI: client has been rejected due to 'disable' directive");
 	  cc_succeeded = false;
 	}
-
+  /*
+   * Set option push_reset to true if push-reset option
+   * was ever encountered, and set to immutable
+   * options added since last push-reset
+   */
+  mi->context.options.push_reset = push_reset;
+  if( push_reset ){
+		multi_client_connect_post_set_immutable(
+			immutable_from_option ? immutable_from_option->next : mi->context.options.push_list.head, true);
+  }
       if (cc_succeeded)
 	{
 	  /*
diff --git a/options.c b/options.c
index b78158e..20c5f60 100644
--- a/options.c
+++ b/options.c
@@ -691,6 +691,7 @@ init_options (struct options *o, const bool init_gc)
   o->route_delay_window = 30;
   o->max_routes = MAX_ROUTES_DEFAULT;
   o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
+  o->push_reset = false;
 #ifdef ENABLE_OCC
   o->occ = true;
 #endif
@@ -4789,7 +4790,7 @@ add_option (struct options *options,
   else if (streq (p[0], "push-reset"))
     {
       VERIFY_PERMISSION (OPT_P_INSTANCE);
-      push_reset (options);
+      options->push_reset = true;
     }
   else if (streq (p[0], "ifconfig-pool") && p[1] && p[2])
     {
diff --git a/options.h b/options.h
index 240f3bb..4b1597f 100644
--- a/options.h
+++ b/options.h
@@ -378,6 +378,7 @@ struct options
   in_addr_t server_bridge_pool_end;
 
   struct push_list push_list;
+  bool push_reset;
   bool ifconfig_pool_defined;
   in_addr_t ifconfig_pool_start;
   in_addr_t ifconfig_pool_end;
diff --git a/push.c b/push.c
index 1320bec..9d994a5 100644
--- a/push.c
+++ b/push.c
@@ -183,7 +183,7 @@ send_push_reply (struct context *c)
 
   while (e)
     {
-      if (e->enable)
+      if (e->enable && (!c->options.push_reset || e->immutable))
 	{
 	  const int l = strlen (e->option);
 	  if (BLEN (&buf) + l >= safe_cap)
@@ -290,6 +290,7 @@ clone_push_list (struct options *o)
       while (e)
 	{
 	  push_option_ex (o, string_alloc (e->option, &o->gc), true, M_FATAL);
+	  o->push_list.tail->immutable = e->immutable;
 	  e = e->next;
 	}
     }
diff --git a/pushlist.h b/pushlist.h
index b252676..11356dd 100644
--- a/pushlist.h
+++ b/pushlist.h
@@ -30,6 +30,7 @@
 struct push_entry {
   struct push_entry *next;
   bool enable;
+  bool immutable;
   const char *option;
 };
 
-- 
1.5.6.5


--=-KD7gIRHHCRvGNWuvpOug--



