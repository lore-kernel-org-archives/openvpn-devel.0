From: Jan Just Keijser <janjust@...1147...>
Date: Tue,  7 Feb 2012 16:29:47 +0100
Message-Id: <1328628587-4906-1-git-send-email-janjust@...1147...>
Subject: [Openvpn-devel] [PATCH] Made some options connection-entry specific
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

Made some options connection-entry specific:
 fragment  
 mssfix
 tun-mtu
 tun-mtu-extra
 link-mtu  
 mtu_discover_type
 explicit-exit-notification
in order to support stuff like
<connection>
  remote host
  proto udp
  fragment  
  explicit-exit-notification 3
</connection>
<connection> 
  remote host 
  proto tcp
</connection>

Signed-off-by: Jan Just Keijser <janjust@...1147...>
---
 forward.c |    2 +-
 init.c    |   38 ++++++++++---------
 occ.c     |    2 +-
 options.c |  125 +++++++++++++++++++++++++++++++------------------------------
 options.h |   36 +++++++++---------
 sig.c     |    6 +-
 6 files changed, 107 insertions(+), 102 deletions(-)

diff --git a/forward.c b/forward.c
index dfef4ef..96c6b9a 100644
--- a/forward.c
+++ b/forward.c
@@ -1005,7 +1005,7 @@ process_incoming_tun (struct context *c)
 void
 process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf)
 {
-  if (!c->options.mssfix)
+  if (!c->options.ce.mssfix)
     flags &= ~PIPV4_MSSFIX;
 #if PASSTOS_CAPABILITY
   if (!c->options.passtos)
diff --git a/init.c b/init.c
index 51b0d64..8f42120 100644
--- a/init.c
+++ b/init.c
@@ -1786,10 +1786,10 @@ do_deferred_options (struct context *c, const unsigned int found)
 #ifdef ENABLE_OCC
   if (found & OPT_P_EXPLICIT_NOTIFY)
     {
-      if (!proto_is_udp(c->options.ce.proto) && c->options.explicit_exit_notification)
+      if (!proto_is_udp(c->options.ce.proto) && c->options.ce.explicit_exit_notification)
 	{
 	  msg (D_PUSH, "OPTIONS IMPORT: --explicit-exit-notify can only be used with --proto udp");
-	  c->options.explicit_exit_notification = 0;
+	  c->options.ce.explicit_exit_notification = 0;
 	}
       else
 	msg (D_PUSH, "OPTIONS IMPORT: explicit notify parm(s) modified");
@@ -1962,10 +1962,10 @@ frame_finalize_options (struct context *c, const struct options *o)
     }
   
   frame_finalize (&c->c2.frame,
-		  o->link_mtu_defined,
-		  o->link_mtu,
-		  o->tun_mtu_defined,
-		  o->tun_mtu);
+		  o->ce.link_mtu_defined,
+		  o->ce.link_mtu,
+		  o->ce.tun_mtu_defined,
+		  o->ce.tun_mtu);
 }
 
 /*
@@ -2411,8 +2411,8 @@ do_init_frame (struct context *c)
   /*
    * Adjust frame size based on the --tun-mtu-extra parameter.
    */
-  if (c->options.tun_mtu_extra_defined)
-    tun_adjust_frame_parameters (&c->c2.frame, c->options.tun_mtu_extra);
+  if (c->options.ce.tun_mtu_extra_defined)
+    tun_adjust_frame_parameters (&c->c2.frame, c->options.ce.tun_mtu_extra);
 
   /*
    * Adjust frame size based on link socket parameters.
@@ -2441,13 +2441,13 @@ do_init_frame (struct context *c)
   /*
    * MTU advisories
    */
-  if (c->options.fragment && c->options.mtu_test)
+  if (c->options.ce.fragment && c->options.mtu_test)
     msg (M_WARN,
 	 "WARNING: using --fragment and --mtu-test together may produce an inaccurate MTU test result");
 #endif
 
 #ifdef ENABLE_FRAGMENT
-  if ((c->options.mssfix || c->options.fragment)
+  if ((c->options.ce.mssfix || c->options.ce.fragment)
       && TUN_MTU_SIZE (&c->c2.frame_fragment) != ETHERNET_MTU)
     msg (M_WARN,
 	 "WARNING: normally if you use --mssfix and/or --fragment, you should also set --tun-mtu %d (currently it is %d)",
@@ -2619,9 +2619,9 @@ do_init_buffers (struct context *c)
 static void
 do_init_fragment (struct context *c)
 {
-  ASSERT (c->options.fragment);
+  ASSERT (c->options.ce.fragment);
   frame_set_mtu_dynamic (&c->c2.frame_fragment,
-			 c->options.fragment, SET_MTU_UPPER_BOUND);
+			 c->options.ce.fragment, SET_MTU_UPPER_BOUND);
   fragment_frame_init (c->c2.fragment, &c->c2.frame_fragment);
 }
 #endif
@@ -2632,10 +2632,10 @@ do_init_fragment (struct context *c)
 static void
 do_init_mssfix (struct context *c)
 {
-  if (c->options.mssfix)
+  if (c->options.ce.mssfix)
     {
       frame_set_mtu_dynamic (&c->c2.frame,
-			     c->options.mssfix, SET_MTU_UPPER_BOUND);
+			     c->options.ce.mssfix, SET_MTU_UPPER_BOUND);
     }
 }
 
@@ -2691,7 +2691,7 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.ce.connect_retry_seconds,
 			   c->options.ce.connect_timeout,
 			   c->options.ce.connect_retry_max,
-			   c->options.mtu_discover_type,
+			   c->options.ce.mtu_discover_type,
 			   c->options.rcvbuf,
 			   c->options.sndbuf,
 			   c->options.mark,
@@ -3406,7 +3408,7 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
 
 #ifdef ENABLE_FRAGMENT
   /* initialize internal fragmentation object */
-  if (options->fragment && (c->mode == CM_P2P || child))
+  if (options->ce.fragment && (c->mode == CM_P2P || child))
     c->c2.fragment = fragment_init (&c->c2.frame);
 #endif
 
@@ -3442,7 +3444,7 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
 
 #ifdef ENABLE_FRAGMENT
   /* initialize internal fragmentation capability with known frame size */
-  if (options->fragment && (c->mode == CM_P2P || child))
+  if (options->ce.fragment && (c->mode == CM_P2P || child))
     do_init_fragment (c);
 #endif
 
diff --git a/occ.c b/occ.c
index bcf91cc..2fdbff0 100644
--- a/occ.c
+++ b/occ.c
@@ -368,7 +368,7 @@ process_received_occ_msg (struct context *c)
 	       c->c2.max_recv_size_remote,
 	       c->c2.max_send_size_remote,
 	       c->c2.max_recv_size_local);
-	  if (!c->options.fragment
+	  if (!c->options.ce.fragment
 	      && (proto_is_dgram(c->options.ce.proto))
 	      && c->c2.max_send_size_local > TUN_MTU_MIN
 	      && (c->c2.max_recv_size_remote < c->c2.max_send_size_local
diff --git a/options.c b/options.c
index ce23dbc..df8dc91 100644
--- a/options.c
+++ b/options.c
@@ -765,10 +765,10 @@ init_options (struct options *o, const bool init_gc)
   o->status_file_update_freq = 60;
   o->status_file_version = 1;
   o->ce.bind_local = true;
-  o->tun_mtu = TUN_MTU_DEFAULT;
-  o->link_mtu = LINK_MTU_DEFAULT;
-  o->mtu_discover_type = -1;
-  o->mssfix = MSSFIX_DEFAULT;
+  o->ce.tun_mtu = TUN_MTU_DEFAULT;
+  o->ce.link_mtu = LINK_MTU_DEFAULT;
+  o->ce.mtu_discover_type = -1;
+  o->ce.mssfix = MSSFIX_DEFAULT;
   o->route_delay_window = 30;
   o->max_routes = MAX_ROUTES_DEFAULT;
   o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
@@ -1361,8 +1361,26 @@ show_connection_entry (const struct connection_entry *o)
   SHOW_INT (socks_proxy_port);
   SHOW_BOOL (socks_proxy_retry);
 #endif
+  SHOW_INT (tun_mtu);
+  SHOW_BOOL (tun_mtu_defined);
+  SHOW_INT (link_mtu);
+  SHOW_BOOL (link_mtu_defined);
+  SHOW_INT (tun_mtu_extra);
+  SHOW_BOOL (tun_mtu_extra_defined);
+
+  SHOW_INT (mtu_discover_type);
+
+#ifdef ENABLE_FRAGMENT
+  SHOW_INT (fragment);
+#endif
+  SHOW_INT (mssfix);
+  
+#ifdef ENABLE_OCC
+  SHOW_INT (explicit_exit_notification);
+#endif
 }
 
+
 static void
 show_connection_entries (const struct options *o)
 {
@@ -1433,19 +1451,6 @@ show_settings (const struct options *o)
 #ifdef HAVE_GETTIMEOFDAY
   SHOW_INT (shaper);
 #endif
-  SHOW_INT (tun_mtu);
-  SHOW_BOOL (tun_mtu_defined);
-  SHOW_INT (link_mtu);
-  SHOW_BOOL (link_mtu_defined);
-  SHOW_INT (tun_mtu_extra);
-  SHOW_BOOL (tun_mtu_extra_defined);
-
-#ifdef ENABLE_FRAGMENT
-  SHOW_INT (fragment);
-#endif
-
-  SHOW_INT (mtu_discover_type);
-
 #ifdef ENABLE_OCC
   SHOW_INT (mtu_test);
 #endif
@@ -1460,16 +1465,11 @@ show_settings (const struct options *o)
   SHOW_INT (ping_rec_timeout_action);
   SHOW_BOOL (ping_timer_remote);
   SHOW_INT (remap_sigusr1);
-#ifdef ENABLE_OCC
-  SHOW_INT (explicit_exit_notification);
-#endif
   SHOW_BOOL (persist_tun);
   SHOW_BOOL (persist_local_ip);
   SHOW_BOOL (persist_remote_ip);
   SHOW_BOOL (persist_key);
 
-  SHOW_INT (mssfix);
-  
 #if PASSTOS_CAPABILITY
   SHOW_BOOL (passtos);
 #endif
@@ -1959,7 +1959,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
   /*
    * Sanity check on MTU parameters
    */
-  if (options->tun_mtu_defined && options->link_mtu_defined)
+  if (options->ce.tun_mtu_defined && options->ce.link_mtu_defined)
     msg (M_USAGE, "only one of --tun-mtu or --link-mtu may be defined (note that --ifconfig implies --link-mtu %d)", LINK_MTU_DEFAULT);
 
 #ifdef ENABLE_OCC
@@ -2042,12 +2042,12 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
    */
 
 #ifdef ENABLE_FRAGMENT
-  if (!proto_is_udp(ce->proto) && options->fragment)
+  if (!proto_is_udp(ce->proto) && ce->fragment)
     msg (M_USAGE, "--fragment can only be used with --proto udp");
 #endif
 
 #ifdef ENABLE_OCC
-  if (!proto_is_udp(ce->proto) && options->explicit_exit_notification)
+  if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
     msg (M_USAGE, "--explicit-exit-notify can only be used with --proto udp");
 #endif
 
@@ -2132,7 +2132,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       if (!(dev == DEV_TYPE_TAP || (dev == DEV_TYPE_TUN && options->topology == TOP_SUBNET)) && options->ifconfig_pool_netmask)
 	msg (M_USAGE, "The third parameter to --ifconfig-pool (netmask) is only valid in --dev tap mode");
 #ifdef ENABLE_OCC
-      if (options->explicit_exit_notification)
+      if (ce->explicit_exit_notification)
 	msg (M_USAGE, "--explicit-exit-notify cannot be used with --mode server");
 #endif
       if (options->routes && (options->routes->flags & RG_ENABLE))
@@ -2427,27 +2427,28 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
   /* if protocol forcing is enabled, disable all protocols except for the forced one */
   if (o->proto_force >= 0 && proto_is_tcp(o->proto_force) != proto_is_tcp(ce->proto))
     ce->flags |= CE_DISABLED;
-}
-
-static void
-options_postprocess_mutate_invariant (struct options *options)
-{
-  const int dev = dev_type_enum (options->dev, options->dev_type);
 
   /*
    * If --mssfix is supplied without a parameter, default
    * it to --fragment value, if --fragment is specified.
    */
-  if (options->mssfix_default)
+  if (o->ce.mssfix_default)
     {
 #ifdef ENABLE_FRAGMENT
-      if (options->fragment)
-	options->mssfix = options->fragment;
+      if (ce->fragment)
+	o->ce.mssfix = ce->fragment;
 #else
       msg (M_USAGE, "--mssfix must specify a parameter");
 #endif      
     }
 
+}
+
+static void
+options_postprocess_mutate_invariant (struct options *options)
+{
+  const int dev = dev_type_enum (options->dev, options->dev_type);
+
   /*
    * In forking TCP server mode, you don't need to ifconfig
    * the tap device (the assumption is that it will be bridged).
@@ -2459,14 +2460,14 @@ options_postprocess_mutate_invariant (struct options *options)
    * Set MTU defaults
    */
   {
-    if (!options->tun_mtu_defined && !options->link_mtu_defined)
+    if (!options->ce.tun_mtu_defined && !options->ce.link_mtu_defined)
       {
-	options->tun_mtu_defined = true;
+	options->ce.tun_mtu_defined = true;
       }
-    if ((dev == DEV_TYPE_TAP) && !options->tun_mtu_extra_defined)
+    if ((dev == DEV_TYPE_TAP) && !options->ce.tun_mtu_extra_defined)
       {
-	options->tun_mtu_extra_defined = true;
-	options->tun_mtu_extra = TAP_MTU_EXTRA_DEFAULT;
+	options->ce.tun_mtu_extra_defined = true;
+	options->ce.tun_mtu_extra = TAP_MTU_EXTRA_DEFAULT;
       }
   }
 
@@ -2952,7 +2953,7 @@ options_string (const struct options *o,
 #endif
 
 #ifdef ENABLE_FRAGMENT
-  if (o->fragment)
+  if (o->ce.fragment)
     buf_printf (&out, ",mtu-dynamic");
 #endif
 
@@ -4696,39 +4697,40 @@ add_option (struct options *options,
     }
   else if ((streq (p[0], "link-mtu") || streq (p[0], "udp-mtu")) && p[1])
     {
-      VERIFY_PERMISSION (OPT_P_MTU);
-      options->link_mtu = positive_atoi (p[1]);
-      options->link_mtu_defined = true;
+      VERIFY_PERMISSION (OPT_P_MTU|OPT_P_CONNECTION);
+      options->ce.link_mtu = positive_atoi (p[1]);
+      options->ce.link_mtu_defined = true;
     }
   else if (streq (p[0], "tun-mtu") && p[1])
     {
-      VERIFY_PERMISSION (OPT_P_MTU);
-      options->tun_mtu = positive_atoi (p[1]);
-      options->tun_mtu_defined = true;
+      VERIFY_PERMISSION (OPT_P_MTU|OPT_P_CONNECTION);
+      options->ce.tun_mtu = positive_atoi (p[1]);
+      options->ce.tun_mtu_defined = true;
     }
   else if (streq (p[0], "tun-mtu-extra") && p[1])
     {
-      VERIFY_PERMISSION (OPT_P_MTU);
-      options->tun_mtu_extra = positive_atoi (p[1]);
-      options->tun_mtu_extra_defined = true;
+      VERIFY_PERMISSION (OPT_P_MTU|OPT_P_CONNECTION);
+      options->ce.tun_mtu_extra = positive_atoi (p[1]);
+      options->ce.tun_mtu_extra_defined = true;
     }
 #ifdef ENABLE_FRAGMENT
   else if (streq (p[0], "mtu-dynamic"))
     {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
+      VERIFY_PERMISSION (OPT_P_MTU|OPT_P_CONNECTION);
       msg (msglevel, "--mtu-dynamic has been replaced by --fragment");
       goto err;
     }
   else if (streq (p[0], "fragment") && p[1])
     {
-      VERIFY_PERMISSION (OPT_P_MTU);
-      options->fragment = positive_atoi (p[1]);
+//      VERIFY_PERMISSION (OPT_P_MTU);
+      VERIFY_PERMISSION (OPT_P_MTU|OPT_P_CONNECTION);
+      options->ce.fragment = positive_atoi (p[1]);
     }
 #endif
   else if (streq (p[0], "mtu-disc") && p[1])
     {
-      VERIFY_PERMISSION (OPT_P_MTU);
-      options->mtu_discover_type = translate_mtu_discover_type_name (p[1]);
+      VERIFY_PERMISSION (OPT_P_MTU|OPT_P_CONNECTION);
+      options->ce.mtu_discover_type = translate_mtu_discover_type_name (p[1]);
     }
 #ifdef ENABLE_OCC
   else if (streq (p[0], "mtu-test"))
@@ -5073,14 +5075,15 @@ add_option (struct options *options,
 #ifdef ENABLE_OCC
   else if (streq (p[0], "explicit-exit-notify"))
     {
-      VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY);
+      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
+//      VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY);
       if (p[1])
 	{
-	  options->explicit_exit_notification = positive_atoi (p[1]);
+	  options->ce.explicit_exit_notification = positive_atoi (p[1]);
 	}
       else
 	{
-	  options->explicit_exit_notification = 1;
+	  options->ce.explicit_exit_notification = 1;
 	}
     }
 #endif
@@ -5336,13 +5339,13 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "mssfix"))
     {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
+      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       if (p[1])
 	{
-	  options->mssfix = positive_atoi (p[1]);
+	  options->ce.mssfix = positive_atoi (p[1]);
 	}
       else
-	options->mssfix_default = true;
+	options->ce.mssfix_default = true;
 
     }
 #ifdef ENABLE_OCC
diff --git a/options.h b/options.h
index 81e0757..0f9d260 100644
--- a/options.h
+++ b/options.h
@@ -111,6 +111,24 @@ struct connection_entry
   bool socks_proxy_retry;
 #endif
 
+  int tun_mtu;           /* MTU of tun device */
+  bool tun_mtu_defined;  /* true if user overriding parm with command line option */
+  int tun_mtu_extra;
+  bool tun_mtu_extra_defined;
+  int link_mtu;          /* MTU of device over which tunnel packets pass via TCP/UDP */
+  bool link_mtu_defined; /* true if user overriding parm with command line option */
+
+  /* Advanced MTU negotiation and datagram fragmentation options */
+  int mtu_discover_type; /* used if OS supports setting Path MTU discovery options on socket */
+
+  int fragment;          /* internal fragmentation size */
+  int mssfix;            /* Upper bound on TCP MSS */
+  bool mssfix_default;   /* true if --mssfix was supplied without a parameter */
+
+#ifdef ENABLE_OCC
+  int explicit_exit_notification;  /* Explicitly tell peer when we are exiting via OCC_EXIT message */
+#endif
+
 # define CE_DISABLED (1<<0)
 #if HTTP_PROXY_FALLBACK
 # define CE_HTTP_PROXY_FALLBACK (1<<1)
@@ -248,24 +266,13 @@ struct options
 #ifdef HAVE_GETTIMEOFDAY
   int shaper;
 #endif
-  int tun_mtu;           /* MTU of tun device */
-  int tun_mtu_extra;
-  bool tun_mtu_extra_defined;
-  int link_mtu;          /* MTU of device over which tunnel packets pass via TCP/UDP */
-  bool tun_mtu_defined;  /* true if user overriding parm with command line option */
-  bool link_mtu_defined; /* true if user overriding parm with command line option */
 
   int proto_force;
 
-  /* Advanced MTU negotiation and datagram fragmentation options */
-  int mtu_discover_type; /* used if OS supports setting Path MTU discovery options on socket */
-
 #ifdef ENABLE_OCC
   bool mtu_test;
 #endif
 
-  int fragment;                 /* internal fragmentation size */
-
 #ifdef ENABLE_MEMSTATS
   char *memstats_fn;
 #endif
@@ -288,18 +295,11 @@ struct options
 # define PING_RESTART 2
   int ping_rec_timeout_action;  /* What action to take on ping_rec_timeout (exit or restart)? */
 
-#ifdef ENABLE_OCC
-  int explicit_exit_notification;  /* Explicitly tell peer when we are exiting via OCC_EXIT message */
-#endif
-
   bool persist_tun;             /* Don't close/reopen TUN/TAP dev on SIGUSR1 or PING_RESTART */
   bool persist_local_ip;        /* Don't re-resolve local address on SIGUSR1 or PING_RESTART */
   bool persist_remote_ip;       /* Don't re-resolve remote address on SIGUSR1 or PING_RESTART */
   bool persist_key;             /* Don't re-read key files on SIGUSR1 or PING_RESTART */
 
-  int mssfix;                   /* Upper bound on TCP MSS */
-  bool mssfix_default;          /* true if --mssfix was supplied without a parameter */
-
 #if PASSTOS_CAPABILITY
   bool passtos;                  
 #endif
diff --git a/sig.c b/sig.c
index d73525f..a5703f0 100644
--- a/sig.c
+++ b/sig.c
@@ -300,8 +300,8 @@ process_explicit_exit_notification_timer_wakeup (struct context *c)
 			     &c->c2.timeval,
 			     ETT_DEFAULT))
     {
-      ASSERT (c->c2.explicit_exit_notification_time_wait && c->options.explicit_exit_notification);
-      if (now >= c->c2.explicit_exit_notification_time_wait + c->options.explicit_exit_notification)
+      ASSERT (c->c2.explicit_exit_notification_time_wait && c->options.ce.explicit_exit_notification);
+      if (now >= c->c2.explicit_exit_notification_time_wait + c->options.ce.explicit_exit_notification)
 	{
 	  event_timeout_clear (&c->c2.explicit_exit_notification_interval);
 	  c->sig->signal_received = SIGTERM;
@@ -340,7 +340,7 @@ process_sigterm (struct context *c)
 {
   bool ret = true;
 #ifdef ENABLE_OCC
-  if (c->options.explicit_exit_notification
+  if (c->options.ce.explicit_exit_notification
       && !c->c2.explicit_exit_notification_time_wait)
     {
       process_explicit_exit_notification_init (c);
-- 
1.7.4.4


