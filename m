From: Arne Schwabe <arne@...1227...>
Date: Fri, 30 Nov 2012 20:17:56 +0100
Message-Id: <1354303076-13606-10-git-send-email-arne@...1227...>
In-Reply-To: <1354303076-13606-1-git-send-email-arne@...1227...>
References: <1354303076-13606-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 10/10] Implement dual stack client support
	for OpenVPN
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

This patch contains a number of changes. I did not further spit this since some changes make only sense being changed together.

Always use connection_list, simplifies the reconnection logic.

Change meaning of --connect-retry-max and --connect-retry to be used all connections. This now allows OpenVPN to quit after n unsuccessful udp connection attempts

Remove the tcp reconnection logic. Failing a TCP connection will now cause a USR1 like a UDP connection. Also extend sig->source from bool to int to specify signal source. This allows a finer grained reconnection logic if necessary in the future.

Dual-Stack support: if an address resolves to multiple records each address is tried in sequential order. Then proceed to next connection entry. Introduce the field current_remote to represent the current connecting remote. Also change some fields to struct addrinfo* form openvn_addr to store multiple addresses needed for the dual stack support.

Change meaning from udp and tcp to allow both IPv4 and IPv6. Introducue new udp4 and tcp4 to force IPv4.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8                |   21 +-
 src/openvpn/error.c          |    2 +-
 src/openvpn/forward-inline.h |    1 +
 src/openvpn/init.c           |  229 +++++++++-------
 src/openvpn/manage.c         |   27 +-
 src/openvpn/manage.h         |    2 +-
 src/openvpn/options.c        |  117 ++++-----
 src/openvpn/options.h        |   24 +-
 src/openvpn/ps.c             |    4 +-
 src/openvpn/push.c           |    2 +-
 src/openvpn/route.c          |    1 -
 src/openvpn/sig.c            |   22 +-
 src/openvpn/sig.h            |   11 +-
 src/openvpn/socket.c         |  591 +++++++++++++++++++-----------------------
 src/openvpn/socket.h         |   62 ++---
 src/openvpn/tun.c            |   11 +-
 src/openvpn/tun.h            |    2 +-
 17 files changed, 554 insertions(+), 575 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 01257b6..d66bd66 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -456,13 +456,9 @@ possess a built-in reliability layer.
 .\"*********************************************************
 .TP
 .B \-\-connect-retry n
-For
-.B \-\-proto tcp-client,
-take
+Wait
 .B n
-as the
-number of seconds to wait
-between connection retries (default=5).
+seconds  between connection attempts (default=5).
 .\"*********************************************************
 .TP
 .B \-\-connect-timeout n
@@ -474,12 +470,15 @@ seconds (default=10).
 .\"*********************************************************
 .TP
 .B \-\-connect-retry-max n
-For
-.B \-\-proto tcp-client,
-take
 .B n
-as the
-number of retries of connection attempt (default=infinite).
+specifies the number of times all 
+.B \-\-remote 
+respectively 
+.B <connection>
+statements are tried. Specifiying 
+.B n
+as one would try each entry exactly once. A sucessful connection 
+resets the counter. (default=umlimited).
 .\"*********************************************************
 .TP
 .B \-\-show-proxy-settings
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 4a0418a..ebe9a52 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -259,7 +259,7 @@ void x_msg_va (const unsigned int flags, const char *format, va_list arglist)
   if (flags & M_SSL)
     {
       int nerrs = 0;
-      int err;
+      size_t err;
       while ((err = ERR_get_error ()))
 	{
 	  openvpn_snprintf (m2, ERR_BUF_SIZE, "%s: %s",
diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
index 5853ce2..7eb480d 100644
--- a/src/openvpn/forward-inline.h
+++ b/src/openvpn/forward-inline.h
@@ -228,6 +228,7 @@ context_reschedule_sec (struct context *c, int sec)
 static inline struct link_socket_info *
 get_link_socket_info (struct context *c)
 {
+
   if (c->c2.link_socket_info)
     return c->c2.link_socket_info;
   else
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index bf72303..d895c35 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -282,84 +282,121 @@ static void
 init_connection_list (struct context *c)
 {
   struct connection_list *l = c->options.connection_list;
-  if (l)
+  l->current = -1;
+  if (c->options.remote_random)
     {
-      l->current = -1;
-      if (c->options.remote_random)
-	{
-	  int i;
-	  for (i = 0; i < l->len; ++i)
-	    {
-	      const int j = get_random () % l->len;
-	      if (i != j)
-		{
-		  struct connection_entry *tmp;
-		  tmp = l->array[i];
-		  l->array[i] = l->array[j];
-		  l->array[j] = tmp;
-		}
-	    }
-	}
+      int i;
+      for (i = 0; i < l->len; ++i)
+        {
+          const int j = get_random () % l->len;
+          if (i != j)
+            {
+              struct connection_entry *tmp;
+              tmp = l->array[i];
+              l->array[i] = l->array[j];
+              l->array[j] = tmp;
+            }
+        }
     }
 }
 
 /*
+ * Clear the remote address list
+ */
+static void clear_remote_addrlist (struct link_socket_addr *lsa)
+{
+    if (lsa->remote_list) {
+        freeaddrinfo(lsa->remote_list);
+    }
+    lsa->remote_list = NULL;
+    lsa->current_remote = NULL;
+}
+
+/*
  * Increment to next connection entry
  */
 static void
 next_connection_entry (struct context *c)
 {
   struct connection_list *l = c->options.connection_list;
-  if (l)
-    {
-      bool ce_defined;
-      struct connection_entry *ce;
-      int n_cycles = 0;
-
-      do {
-	ce_defined = true;
-	if (l->no_advance && l->current >= 0)
-	  {
-	    l->no_advance = false;
-	  }
-	else
-	  {
-	    if (++l->current >= l->len)
-	      {
-		l->current = 0;
-		++l->n_cycles;
-		if (++n_cycles >= 2)
-		  msg (M_FATAL, "No usable connection profiles are present");
-	      }
-	  }
+  bool ce_defined;
+  struct connection_entry *ce;
+  int n_cycles = 0;
+  
+  do {
+    ce_defined = true;
+    if (c->options.no_advance && l->current >= 0)
+      {
+        c->options.no_advance = false;
+      }
+    else
+      {
+        /* Check if there is another resolved address to try for
+         * the current connection */
+        if (c->c1.link_socket_addr.current_remote &&
+            c->c1.link_socket_addr.current_remote->ai_next)
+          {
+            c->c1.link_socket_addr.current_remote =
+                c->c1.link_socket_addr.current_remote->ai_next;
+          }
+        else
+          {
+            c->options.unsuccessful_attempts++;
+            if (++l->current >= l->len)
+              {
+                /* FIXME (schwabe) fix the persist-remote-ip option for real,
+                 * this is broken probably ever since connection lists and multiple
+                 * remote existed
+                 */
+                /*
+                 * Increase the number of connection attempts
+                 * If this is connect-retry-max * size(l)
+                 * OpenVPN will quit
+                 */
+                
+                if (!c->options.persist_remote_ip)
+                    clear_remote_addrlist (&c->c1.link_socket_addr);
+                
+                l->current = 0;
+                ++l->n_cycles;
+                if (++n_cycles >= 2)
+                    msg (M_FATAL, "No usable connection profiles are present");
+              }
+          }
+      }
 
-	ce = l->array[l->current];
+    ce = l->array[l->current];
 
-	if (ce->flags & CE_DISABLED)
-	  ce_defined = false;
+    if (ce->flags & CE_DISABLED)
+      ce_defined = false;
 
-	c->options.ce = *ce;
+    c->options.ce = *ce;
 #ifdef ENABLE_MANAGEMENT
-	if (ce_defined && management && management_query_remote_enabled(management))
-	  {
-	    /* allow management interface to override connection entry details */
-	    ce_defined = ce_management_query_remote(c);
-	    if (IS_SIG (c))
-	      break;
-	  }
-        else
+    if (ce_defined && management && management_query_remote_enabled(management))
+      {
+        /* allow management interface to override connection entry details */
+        ce_defined = ce_management_query_remote(c);
+        if (IS_SIG (c))
+          break;
+      }
+    else
 #endif
 
 #ifdef ENABLE_MANAGEMENT
-        if (ce_defined && management && management_query_proxy_enabled (management))
-          {
-            ce_defined = ce_management_query_proxy (c);
-            if (IS_SIG (c))
-              break;
-          }
+      if (ce_defined && management && management_query_proxy_enabled (management))
+        {
+          ce_defined = ce_management_query_proxy (c);
+          if (IS_SIG (c))
+            break;
+        }
 #endif
-      } while (!ce_defined);
-    }
+  } while (!ce_defined);
+  
+  /* Check if this connection attempt would bring us over the limit */
+  if (c->options.connect_retry_max > 0 &&
+      c->options.unsuccessful_attempts > (l->len  * c->options.connect_retry_max))
+      msg(M_FATAL, "All connections have been connect-retry-max (%d) times unsuccessful, exiting",
+          c->options.connect_retry_max);
   update_options_ce_post (&c->options);
 }
 
@@ -394,12 +431,6 @@ init_query_passwords (struct context *c)
 
 #ifdef GENERAL_PROXY_SUPPORT
 
-static int
-proxy_scope (struct context *c)
-{
-  return connection_list_defined (&c->options) ? 2 : 1;
-}
-
 static void
 uninit_proxy_dowork (struct context *c)
 {
@@ -461,17 +492,15 @@ init_proxy_dowork (struct context *c)
 }
 
 static void
-init_proxy (struct context *c, const int scope)
+init_proxy (struct context *c)
 {
-  if (scope == proxy_scope (c))
-    init_proxy_dowork (c);
+  init_proxy_dowork (c);
 }
 
 static void
 uninit_proxy (struct context *c)
 {
-  if (c->sig->signal_received != SIGUSR1 || proxy_scope (c) == 2)
-    uninit_proxy_dowork (c);
+   uninit_proxy_dowork (c);
 }
 
 #else
@@ -523,8 +552,6 @@ context_init_1 (struct context *c)
  }
 #endif
 
-  /* initialize HTTP or SOCKS proxy object at scope level 1 */
-  init_proxy (c, 1);
 }
 
 void
@@ -1219,6 +1246,9 @@ void
 initialization_sequence_completed (struct context *c, const unsigned int flags)
 {
   static const char message[] = "Initialization Sequence Completed";
+    
+  /* Reset the unsuccessful connection counter on complete initialisation */
+  c->options.unsuccessful_attempts=0;
 
   /* If we delayed UID/GID downgrade or chroot, do it now */
   do_uid_gid_chroot (c, true);
@@ -1237,9 +1267,9 @@ initialization_sequence_completed (struct context *c, const unsigned int flags)
   else
     msg (M_INFO, "%s", message);
 
-  /* Flag connection_list that we initialized */
-  if ((flags & (ISC_ERRORS|ISC_SERVER)) == 0 && connection_list_defined (&c->options))
-    connection_list_set_no_advance (&c->options);
+  /* Flag that we initialized */
+  if ((flags & (ISC_ERRORS|ISC_SERVER)) == 0)
+    c->options.no_advance=true;
 
 #ifdef WIN32
   fork_register_dns_action (c->c1.tuntap);
@@ -1353,8 +1383,8 @@ do_init_tun (struct context *c)
 			   c->options.ifconfig_ipv6_local,
 			   c->options.ifconfig_ipv6_netbits,
 			   c->options.ifconfig_ipv6_remote,
-			   addr_host (&c->c1.link_socket_addr.local),
-			   addr_host (&c->c1.link_socket_addr.remote_list),
+			   c->c1.link_socket_addr.bind_local,
+			   c->c1.link_socket_addr.remote_list,
 			   !c->options.ifconfig_nowarn,
 			   c->c2.es);
 
@@ -1809,13 +1839,10 @@ socket_restart_pause (struct context *c)
 
   switch (c->options.ce.proto)
     {
-    case PROTO_UDP:
-      if (proxy)
-	sec = c->options.ce.connect_retry_seconds;
-      break;
     case PROTO_TCP_SERVER:
       sec = 1;
       break;
+    case PROTO_UDP:
     case PROTO_TCP_CLIENT:
       sec = c->options.ce.connect_retry_seconds;
       break;
@@ -2585,7 +2612,6 @@ do_init_socket_1 (struct context *c, const int mode)
 #endif
 
   link_socket_init_phase1 (c->c2.link_socket,
-			   connection_list_defined (&c->options),
 			   c->options.ce.local,
 			   c->options.ce.local_port,
 			   c->options.ce.remote,
@@ -2610,9 +2636,7 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.ipchange,
 			   c->plugins,
 			   c->options.resolve_retry_seconds,
-			   c->options.ce.connect_retry_seconds,
 			   c->options.ce.connect_timeout,
-			   c->options.ce.connect_retry_max,
 			   c->options.ce.mtu_discover_type,
 			   c->options.rcvbuf,
 			   c->options.sndbuf,
@@ -2627,7 +2651,7 @@ static void
 do_init_socket_2 (struct context *c)
 {
   link_socket_init_phase2 (c->c2.link_socket, &c->c2.frame,
-			   &c->sig->signal_received);
+			   c->sig);
 }
 
 /*
@@ -2799,15 +2823,30 @@ do_close_link_socket (struct context *c)
       c->c2.link_socket = NULL;
     }
 
-  if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_remote_ip))
-    {
-      if (c->c1.link_socket_addr.remote_list)
-        freeaddrinfo(c->c1.link_socket_addr.remote_list);
+    
+  /* Preserve the resolved list of remote if the user request to or if we want
+   * reconnect to the same host again or there are still addresses that need
+   * to be tried */
+  if (!(c->sig->signal_received == SIGUSR1 &&
+        ( (c->options.persist_remote_ip)
+         ||
+         ( c->sig->source != SIG_SOURCE_HARD &&
+          ((c->c1.link_socket_addr.current_remote && c->c1.link_socket_addr.current_remote->ai_next)
+           || c->options.no_advance))
+         )))
+    {
+      clear_remote_addrlist(&c->c1.link_socket_addr);
+    }
+
+    /* Clear the remote actual address when persist_remote_ip is not in use */
+    if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_remote_ip))
       CLEAR (c->c1.link_socket_addr.actual);
-    }
 
-  if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_local_ip))
-    CLEAR (c->c1.link_socket_addr.local);
+  if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_local_ip)) {
+    if (c->c1.link_socket_addr.bind_local)
+        freeaddrinfo(c->c1.link_socket_addr.bind_local);
+    c->c1.link_socket_addr.bind_local=NULL;
+  }
 }
 
 /*
@@ -3230,7 +3269,7 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
   /* signals caught here will abort */
   c->sig->signal_received = 0;
   c->sig->signal_text = NULL;
-  c->sig->hard = false;
+  c->sig->source = SIG_SOURCE_SOFT;
 
   if (c->mode == CM_P2P)
     init_management_callback_p2p (c);
@@ -3316,7 +3355,7 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
     do_event_set_init (c, false);
 
   /* initialize HTTP or SOCKS proxy object at scope level 2 */
-  init_proxy (c, 2);
+  init_proxy (c);
 
   /* allocate our socket object */
   if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
@@ -3647,7 +3686,7 @@ close_context (struct context *c, int sig, unsigned int flags)
   if (c->sig->signal_received == SIGUSR1)
     {
       if ((flags & CC_USR1_TO_HUP)
-	  || (c->sig->hard && (flags & CC_HARD_USR1_TO_HUP)))
+	  || (c->sig->source == SIG_SOURCE_HARD && (flags & CC_HARD_USR1_TO_HUP)))
 	c->sig->signal_received = SIGHUP;
     }
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1ec9b74..dcd303c 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1461,7 +1461,7 @@ man_new_connection_post (struct management *man, const char *description)
 #endif
     msg (D_MANAGEMENT, "MANAGEMENT: %s %s",
 	 description,
-	 print_sockaddr (&man->settings.local, &gc));
+	 print_sockaddr (man->settings.local->ai_addr, &gc));
 
   buffer_list_reset (man->connection.out);
 
@@ -1569,7 +1569,8 @@ man_listen (struct management *man)
 #endif
 	{
 	  man->connection.sd_top = create_socket_tcp (AF_INET);
-	  socket_bind (man->connection.sd_top, &man->settings.local, "MANAGEMENT");
+	  socket_bind (man->connection.sd_top, man->settings.local,
+                       AF_INET, "MANAGEMENT");
 	}
 
       /*
@@ -1593,7 +1594,7 @@ man_listen (struct management *man)
       else
 #endif
 	msg (D_MANAGEMENT, "MANAGEMENT: TCP Socket listening on %s",
-	     print_sockaddr (&man->settings.local, &gc));
+	     print_sockaddr (man->settings.local->ai_addr, &gc));
     }
 
 #ifdef WIN32
@@ -1636,7 +1637,7 @@ man_connect (struct management *man)
     {
       man->connection.sd_cli = create_socket_tcp (AF_INET);
       status = openvpn_connect (man->connection.sd_cli,
-				&man->settings.local,
+				man->settings.local->ai_addr,
 				5,
 				&signal_received);
     }
@@ -1661,7 +1662,7 @@ man_connect (struct management *man)
 #endif
       msg (D_LINK_ERRORS,
 	   "MANAGEMENT: connect to %s failed: %s",
-	   print_sockaddr (&man->settings.local, &gc),
+	   print_sockaddr (man->settings.local->ai_addr, &gc),
 	   strerror_ts (status, &gc));
       throw_signal_soft (SIGTERM, "management-connect-failed");
       goto done;
@@ -2004,7 +2005,7 @@ man_settings_init (struct man_settings *ms,
 
       ms->write_peer_info_file = string_alloc (write_peer_info_file, NULL);
 
-#if UNIX_SOCK_SUPg
+#if UNIX_SOCK_SUPPORT
       if (ms->flags & MF_UNIX_SOCK)
 	sockaddr_unix_init (&ms->local_unix, addr);
       else
@@ -2021,13 +2022,9 @@ man_settings_init (struct man_settings *ms,
 	    }
 	  else
 	    {
-              struct addrinfo* ai;
               int status = openvpn_getaddrinfo(GETADDR_RESOLVE|GETADDR_WARN_ON_SIGNAL|GETADDR_FATAL,
-                                               addr, port, 0, NULL, AF_INET, &ai);
+                                               addr, port, 0, NULL, AF_INET, &ms->local);
               ASSERT(status==0);
-              ms->local.addr.in4 = *((struct sockaddr_in*)ai->ai_addr);
-              freeaddrinfo(ai);
-
 	    }
 	}
       
@@ -2512,7 +2509,13 @@ management_post_tunnel_open (struct management *man, const in_addr_t tun_local_i
       && man->connection.state == MS_INITIAL)
     {
       /* listen on our local TUN/TAP IP address */
-      man->settings.local.addr.in4.sin_addr.s_addr = htonl (tun_local_ip);
+      struct in_addr ia;
+      int ret;
+      
+      ia.s_addr = htonl(tun_local_ip);
+      ret = openvpn_getaddrinfo(0, inet_ntoa(ia), NULL, 0, NULL,
+                                AF_INET, &man->settings.local);
+      ASSERT (ret==0);
       man_connection_init (man);
     }
 
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 1498163..febeb01 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -212,7 +212,7 @@ struct man_persist {
 struct man_settings {
   bool defined;
   unsigned int flags; /* MF_x flags */
-  struct openvpn_sockaddr local;
+  struct addrinfo* local;
 #if UNIX_SOCK_SUPPORT
   struct sockaddr_un local_unix;
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2dd8c9d..7a3ac67 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -768,10 +768,10 @@ init_options (struct options *o, const bool init_gc)
   o->mode = MODE_POINT_TO_POINT;
   o->topology = TOP_NET30;
   o->ce.proto = PROTO_UDP;
-  o->ce.af = AF_INET;
+  o->ce.af = AF_UNSPEC;
   o->ce.connect_retry_seconds = 5;
   o->ce.connect_timeout = 10;
-  o->ce.connect_retry_max = 0;
+  o->connect_retry_max = 0;
   o->ce.local_port = o->ce.remote_port = OPENVPN_PORT;
   o->verbosity = 1;
   o->status_file_update_freq = 60;
@@ -1347,7 +1347,6 @@ show_connection_entry (const struct connection_entry *o)
   SHOW_BOOL (bind_local);
   SHOW_INT (connect_retry_seconds);
   SHOW_INT (connect_timeout);
-  SHOW_INT (connect_retry_max);
 
 #ifdef ENABLE_HTTP_PROXY
   if (o->http_proxy_options)
@@ -1424,6 +1423,7 @@ show_settings (const struct options *o)
 #endif
 #endif
 
+  SHOW_INT (connect_retry_max);
   show_connection_entries (o);
 
   SHOW_BOOL (remote_random);
@@ -1703,32 +1703,31 @@ void
 options_postprocess_http_proxy_override (struct options *o)
 {
   const struct connection_list *l = o->connection_list;
-   if (l)
+  int i;
+  bool succeed = false;
+  for (i = 0; i < l->len; ++i)
+    {
+      struct connection_entry *ce = l->array[i];
+      if (ce->proto == PROTO_TCP_CLIENT || ce->proto == PROTO_TCP)
+        {
+          ce->http_proxy_options = o->http_proxy_override;
+          succeed = true;
+        }
+    }
+  if (succeed)
     {
-      int i;
-      bool succeed = false;
       for (i = 0; i < l->len; ++i)
-	{
-	  struct connection_entry *ce = l->array[i];
-	  if (ce->proto == PROTO_TCP_CLIENT || ce->proto == PROTO_TCP)
-	    {
-	      ce->http_proxy_options = o->http_proxy_override;
-	      succeed = true;
-	    }
-	}
-      if (succeed)
-	{
-	  for (i = 0; i < l->len; ++i)
-	    {
-	      struct connection_entry *ce = l->array[i];
-	      if (ce->proto == PROTO_UDP)
-		{
-		  ce->flags |= CE_DISABLED;
-		}
-	    }
-	}
-      else
-        msg (M_WARN, "Note: option http-proxy-override ignored because no TCP-based connection profiles are defined");
+        {
+          struct connection_entry *ce = l->array[i];
+          if (ce->proto == PROTO_UDP)
+            {
+              ce->flags |= CE_DISABLED;
+            }
+        }
+    }
+  else
+    {
+      msg (M_WARN, "Note: option http-proxy-override ignored because no TCP-based connection profiles are defined");
     }
 }
 
@@ -1980,7 +1979,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
     msg (M_USAGE, "--socks-proxy can not be used in TCP Server mode");
 #endif
 
-  if (ce->proto == PROTO_TCP_SERVER && connection_list_defined (options))
+  if (ce->proto == PROTO_TCP_SERVER && (options->connection_list->len > 1))
     msg (M_USAGE, "TCP server mode allows at most one --remote address");
 
 #if P2MP_SERVER
@@ -2475,48 +2474,33 @@ options_postprocess_mutate (struct options *o)
   if (o->remote_list && !o->connection_list)
     {
       /*
-       * For compatibility with 2.0.x, map multiple --remote options
-       * into connection list (connection lists added in 2.1).
+       * Convert remotes into connection list
        */
-      if (o->remote_list->len > 1 || o->force_connection_list)
-	{
-	  const struct remote_list *rl = o->remote_list;
-	  int i;
-	  for (i = 0; i < rl->len; ++i)
-	    {
-	      const struct remote_entry *re = rl->array[i];
-	      struct connection_entry ce = o->ce;
-	      struct connection_entry *ace;
-
-	      ASSERT (re->remote);
-	      connection_entry_load_re (&ce, re);
-	      ace = alloc_connection_entry (o, M_USAGE);
-	      ASSERT (ace);
-	      *ace = ce;
-	    }
-	}
-      else if (o->remote_list->len == 1) /* one --remote option specified */
-	{
-	  connection_entry_load_re (&o->ce, o->remote_list->array[0]);
-	}
-      else
-	{
-	  ASSERT (0);
-	}
-    }
-  if (o->connection_list)
-    {
+      const struct remote_list *rl = o->remote_list;
       int i;
-      for (i = 0; i < o->connection_list->len; ++i)
-	options_postprocess_mutate_ce (o, o->connection_list->array[i]);
+      for (i = 0; i < rl->len; ++i)
+        {
+          const struct remote_entry *re = rl->array[i];
+          struct connection_entry ce = o->ce;
+          struct connection_entry *ace;
+          
+          ASSERT (re->remote);
+          connection_entry_load_re (&ce, re);
+          ace = alloc_connection_entry (o, M_USAGE);
+          ASSERT (ace);
+          *ace = ce;
+        }
+    }
 
+  ASSERT (o->connection_list);
+  int i;
+  for (i = 0; i < o->connection_list->len; ++i)
+	options_postprocess_mutate_ce (o, o->connection_list->array[i]);
+  
 #if HTTP_PROXY_OVERRIDE
-      if (o->http_proxy_override)
+  if (o->http_proxy_override)
 	options_postprocess_http_proxy_override(o);
 #endif
-    }
-  else
-    options_postprocess_mutate_ce (o, &o->ce);  
 
 #if P2MP
   /*
@@ -4125,7 +4109,6 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |= MF_QUERY_PROXY;
-      options->force_connection_list = true;
     }
   else if (streq (p[0], "management-hold"))
     {
@@ -4361,7 +4344,6 @@ add_option (struct options *options,
       options->http_proxy_override = parse_http_proxy_override(p[1], p[2], p[3], msglevel, &options->gc);
       if (!options->http_proxy_override)
 	goto err;
-      options->force_connection_list = true;
     }
 #endif
   else if (streq (p[0], "remote") && p[1])
@@ -4424,7 +4406,7 @@ add_option (struct options *options,
   else if (streq (p[0], "connect-retry-max") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      options->ce.connect_retry_max = positive_atoi (p[1]);
+      options->connect_retry_max = positive_atoi (p[1]);
     }
   else if (streq (p[0], "ipchange") && p[1])
     {
@@ -4843,7 +4825,6 @@ add_option (struct options *options,
 	  goto err;
 	}
       options->proto_force = proto_force;
-      options->force_connection_list = true;
     }
 #ifdef ENABLE_HTTP_PROXY
   else if (streq (p[0], "http-proxy") && p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index fde6468..62b1cbf 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -98,7 +98,6 @@ struct connection_entry
   bool bind_local;
   int connect_retry_seconds;
   bool connect_retry_defined;
-  int connect_retry_max;
   int connect_timeout;
   bool connect_timeout_defined;
 #ifdef ENABLE_HTTP_PROXY
@@ -156,7 +155,6 @@ struct connection_list
   int len;
   int current;
   int n_cycles;
-  bool no_advance;
   struct connection_entry *array[CONNECTION_LIST_SIZE];
 };
 
@@ -207,10 +205,15 @@ struct options
 #endif
 
   /* Networking parms */
+  int connect_retry_max;
   struct connection_entry ce;
   struct connection_list *connection_list;
+
   struct remote_list *remote_list;
-  bool force_connection_list;
+  /* Do not advanced the connection or remote addr list*/
+  bool no_advance;
+  /* Counts the number of unsuccessful connection attempts */
+  unsigned int unsuccessful_attempts;
 
 #if HTTP_PROXY_OVERRIDE
   struct http_proxy_options *http_proxy_override;
@@ -772,20 +775,5 @@ bool get_ipv6_addr( const char * prefix_str, struct in6_addr *network,
 		    unsigned int * netbits, char ** printable_ipv6, 
 		    int msglevel );
 
-/*
- * inline functions
- */
-static inline bool
-connection_list_defined (const struct options *o)
-{
-  return o->connection_list != NULL;
-}
-
-static inline void
-connection_list_set_no_advance (struct options *o)
-{
-  if (o->connection_list)
-    o->connection_list->no_advance = true;
-}
 
 #endif
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 98d6580..c186864 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -330,8 +330,8 @@ journal_add (const char *journal_dir, struct proxy_connection *pc, struct proxy_
   if (!getpeername (pc->sd, (struct sockaddr *) &from.addr.sa, &slen)
       && !getsockname (cp->sd, (struct sockaddr *) &to.addr.sa, &dlen))
     {
-      const char *f = print_sockaddr (&from, &gc);
-      const char *t = print_sockaddr (&to, &gc);
+      const char *f = print_openvpn_sockaddr (&from, &gc);
+      const char *t = print_openvpn_sockaddr (&to, &gc);
       fnlen =  strlen(journal_dir) + strlen(t) + 2;
       jfn = (char *) malloc(fnlen);
       check_malloc_return (jfn);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 05a38e0..929a2f2 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -49,7 +49,7 @@ void
 receive_auth_failed (struct context *c, const struct buffer *buffer)
 {
   msg (M_VERB0, "AUTH: Received control message: %s", BSTR(buffer));
-  connection_list_set_no_advance(&c->options);
+    c->options.no_advance=true;
   if (c->options.pull)
     {
       switch (auth_retry_get ())
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index b8704ff..e7ccd17 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -301,7 +301,6 @@ init_route (struct route *r,
     ret = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL,
                               ro->network, NULL, 0, NULL, AF_INET, network_list);
 
-
   status = (ret == 0);
 
   if (!status)
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 0ebde24..7ddfd0e 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -97,14 +97,14 @@ void
 throw_signal (const int signum)
 {
   siginfo_static.signal_received = signum;
-  siginfo_static.hard = true;
+  siginfo_static.source = SIG_SOURCE_HARD;
 }
 
 void
 throw_signal_soft (const int signum, const char *signal_text)
 {
   siginfo_static.signal_received = signum;
-  siginfo_static.hard = false;
+  siginfo_static.source = SIG_SOURCE_SOFT;
   siginfo_static.signal_text = signal_text;
 }
 
@@ -115,7 +115,7 @@ signal_reset (struct signal_info *si)
     {
       si->signal_received = 0;
       si->signal_text = NULL;
-      si->hard = false;
+      si->source = SIG_SOURCE_SOFT;
     }
 }
 
@@ -124,9 +124,23 @@ print_signal (const struct signal_info *si, const char *title, int msglevel)
 {
   if (si)
     {
-      const char *hs = (si->hard ? "hard" : "soft");
       const char *type = (si->signal_text ? si->signal_text : "");
       const char *t = (title ? title : "process");
+      const char *hs;
+      switch (si->source)
+        {
+        case SIG_SOURCE_SOFT:
+          hs= "soft";
+          break;
+        case SIG_SOURCE_HARD:
+          hs = "hard";
+          break;
+        case SIG_SOURCE_CONNECTION_FAILED:
+          hs = "connection failed(soft)";
+          break;
+        default:
+          ASSERT(0);
+        }
 
       switch (si->signal_received)
 	{
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 987efef..c2c7b54 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -28,6 +28,15 @@
 #include "status.h"
 #include "win32.h"
 
+
+
+#define SIG_SOURCE_SOFT 0
+#define SIG_SOURCE_HARD 1
+/* CONNECTION_FAILED is also a "soft" status,
+ * It is thrown if a connection attempt fails
+ */
+#define SIG_SOURCE_CONNECTION_FAILED 2
+
 /*
  * Signal information, including signal code
  * and descriptive text.
@@ -35,7 +44,7 @@
 struct signal_info
 {
   volatile int signal_received;
-  volatile bool hard;
+  volatile int source;
   const char *signal_text;
 };
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7b4a4fb..b3d805d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -172,17 +172,24 @@ openvpn_getaddrinfo (unsigned int flags,
   CLEAR(hints);
   hints.ai_family = ai_family;
   hints.ai_flags = AI_NUMERICHOST;
-  hints.ai_socktype = SOCK_STREAM;
+
   
   if(flags & GETADDR_PASSIVE)
       hints.ai_flags |= AI_PASSIVE;
+    
+  if(flags & GETADDR_DATAGRAM)
+      hints.ai_socktype = SOCK_DGRAM;
+  else
+      hints.ai_socktype = SOCK_STREAM;
 
   status = getaddrinfo(hostname, servname, &hints, res);
 
   if (status != 0) /* parse as numeric address failed? */
     {
       const int fail_wait_interval = 5; /* seconds */
-      int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 : (resolve_retry_seconds / fail_wait_interval);
+      /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
+      int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 :
+            ((resolve_retry_seconds + 4)/ fail_wait_interval);
       const char *fmt;
       int level = 0;
       
@@ -267,7 +274,8 @@ openvpn_getaddrinfo (unsigned int flags,
 
       /* hostname resolve succeeded */
 
-      /* Do not chose an IP Addresse by random or change the order *
+      /* 
+       * Do not chose an IP Addresse by random or change the order *
        * of IP addresses, doing so will break RFC 3484 address selection *
        */
     }
@@ -437,60 +445,6 @@ mac_addr_safe (const char *mac_addr)
   return true;
 }
 
-static void
-update_remote (const char* host,
-	       struct openvpn_sockaddr *addr,
-	       bool *changed,
-	       const unsigned int sockflags)
-{
-  switch(addr->addr.sa.sa_family)
-    {
-    case AF_INET:
-      if (host && addr)
-	{
-	  const in_addr_t new_addr = getaddr (
-					      sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sockflags),
-					      host,
-					      1,
-					      NULL,
-					      NULL);
-	  if (new_addr && addr->addr.in4.sin_addr.s_addr != new_addr)
-	    {
-	      addr->addr.in4.sin_addr.s_addr = new_addr;
-	      *changed = true;
-	    }
-	}
-      break;
-    case AF_INET6:
-      if (host && addr)
-        {
-          int status;
-          struct addrinfo* ai;
-
-          status = openvpn_getaddrinfo(sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sockflags), 
-                                       host, NULL, 1, NULL, AF_INET6, &ai);
-
-          if ( status ==0 )
-            {
-			  struct sockaddr_in6 sin6;
-			  CLEAR(sin6);
-			  sin6 = *((struct sockaddr_in6*)ai->ai_addr);
-              if (!IN6_ARE_ADDR_EQUAL(&sin6.sin6_addr, &addr->addr.in6.sin6_addr))
-              {
-                int port = addr->addr.in6.sin6_port;
-                /* ipv6 requires also eg. sin6_scope_id => easier to fully copy and override port */
-                addr->addr.in6 = sin6; 
-                addr->addr.in6.sin6_port = port;
-              }
-			  freeaddrinfo(ai);
-            }
-        }
-      break;
-    default:
-        ASSERT(0);
-  }
-}
-
 static int
 socket_get_sndbuf (int sd)
 {
@@ -662,51 +616,41 @@ create_socket_tcp (int af)
 }
 
 static socket_descriptor_t
-create_socket_udp (const unsigned int flags)
+create_socket_udp (const int af, const unsigned int flags)
 {
   socket_descriptor_t sd;
 
-  if ((sd = socket (PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0)
-    msg (M_ERR, "UDP: Cannot create UDP socket");
+  if ((sd = socket (af, SOCK_DGRAM, IPPROTO_UDP)) < 0)
+    msg (M_ERR, "UDP: Cannot create UDP/UDP6 socket");
 #if ENABLE_IP_PKTINFO
   else if (flags & SF_USE_IP_PKTINFO)
     {
       int pad = 1;
+      if(af == AF_INET) 
+        {
 #ifdef IP_PKTINFO
-      if (setsockopt (sd, SOL_IP, IP_PKTINFO,
-		      (void*)&pad, sizeof(pad)) < 0)
-        msg(M_ERR, "UDP: failed setsockopt for IP_PKTINFO");
+          if (setsockopt (sd, SOL_IP, IP_PKTINFO,
+                          (void*)&pad, sizeof(pad)) < 0)
+            msg(M_ERR, "UDP: failed setsockopt for IP_PKTINFO");
 #elif defined(IP_RECVDSTADDR)
-      if (setsockopt (sd, IPPROTO_IP, IP_RECVDSTADDR,
-		      (void*)&pad, sizeof(pad)) < 0)
-        msg(M_ERR, "UDP: failed setsockopt for IP_RECVDSTADDR");
+          if (setsockopt (sd, IPPROTO_IP, IP_RECVDSTADDR,
+                          (void*)&pad, sizeof(pad)) < 0)
+            msg(M_ERR, "UDP: failed setsockopt for IP_RECVDSTADDR");
 #else
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
 #endif
-    }
-#endif
-  return sd;
-}
-
-static socket_descriptor_t
-create_socket_udp6 (const unsigned int flags)
-{
-  socket_descriptor_t sd;
-
-  if ((sd = socket (PF_INET6, SOCK_DGRAM, IPPROTO_UDP)) < 0)
-    msg (M_ERR, "UDP: Cannot create UDP6 socket");
-#if ENABLE_IP_PKTINFO
-  else if (flags & SF_USE_IP_PKTINFO)
-    {
-      int pad = 1;
+        } 
+      else if (af == AF_INET6 ) 
+        {
 #ifndef IPV6_RECVPKTINFO /* Some older Darwin platforms require this */
-      if (setsockopt (sd, IPPROTO_IPV6, IPV6_PKTINFO,
-		      (void*)&pad, sizeof(pad)) < 0)
+          if (setsockopt (sd, IPPROTO_IPV6, IPV6_PKTINFO,
+                          (void*)&pad, sizeof(pad)) < 0)
 #else
-      if (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO,
-		      (void*)&pad, sizeof(pad)) < 0)
+          if (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO,
+                          (void*)&pad, sizeof(pad)) < 0)
 #endif
-	msg(M_ERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
+            msg(M_ERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
+        }
     }
 #endif
   return sd;
@@ -715,10 +659,16 @@ create_socket_udp6 (const unsigned int flags)
 static void
 create_socket (struct link_socket *sock)
 {
-  /* create socket */
-  if (sock->info.proto == PROTO_UDP && sock->info.af == AF_INET)
+  /* create socket, use information carried over from getaddrinfo */
+  const int ai_proto = sock->info.lsa->actual.ai_protocol;
+  const int ai_family = sock->info.lsa->actual.ai_family;
+    
+  ASSERT (sock->info.af == AF_UNSPEC  || sock->info.af == ai_family);
+
+    
+  if (ai_proto == IPPROTO_UDP)
     {
-      sock->sd = create_socket_udp (sock->sockflags);
+      sock->sd = create_socket_udp (ai_family, sock->sockflags);
       sock->sockflags |= SF_GETADDRINFO_DGRAM;
 
 #ifdef ENABLE_SOCKS
@@ -726,15 +676,9 @@ create_socket (struct link_socket *sock)
 	sock->ctrl_sd = create_socket_tcp (AF_INET);
 #endif
     }
-  else if (sock->info.proto == PROTO_TCP_SERVER
-	   || sock->info.proto == PROTO_TCP_CLIENT)
+  else if (ai_proto == IPPROTO_TCP)
     {
-      sock->sd = create_socket_tcp (sock->info.af);
-    }
-  else if (sock->info.proto == PROTO_UDP && sock->info.af == AF_INET6)
-    {
-      sock->sd = create_socket_udp6 (sock->sockflags);
-      sock->sockflags |= SF_GETADDRINFO_DGRAM;
+      sock->sd = create_socket_tcp (ai_family);
     }
   else
     {
@@ -745,10 +689,9 @@ create_socket (struct link_socket *sock)
 /*
  * Functions used for establishing a TCP stream connection.
  */
-
 static void
 socket_do_listen (socket_descriptor_t sd,
-		  const struct openvpn_sockaddr *local,
+		  const struct sockaddr *local,
 		  bool do_listen,
 		  bool do_set_nonblock)
 {
@@ -838,8 +781,7 @@ static int
 socket_listen_accept (socket_descriptor_t sd,
 		      struct link_socket_actual *act,
 		      const char *remote_dynamic,
-		      bool *remote_changed,
-		      const struct openvpn_sockaddr *local,
+		      const struct addrinfo *local,
 		      bool do_listen,
 		      bool nowait,
 		      volatile int *signal_received)
@@ -850,7 +792,7 @@ socket_listen_accept (socket_descriptor_t sd,
   int new_sd = SOCKET_UNDEFINED;
 
   CLEAR (*act);
-  socket_do_listen (sd, local, do_listen, true);
+  socket_do_listen (sd, local->ai_addr, do_listen, true);
 
   while (true)
     {
@@ -885,18 +827,26 @@ socket_listen_accept (socket_descriptor_t sd,
 
       if (socket_defined (new_sd))
 	{
-	  update_remote (remote_dynamic, &remote_verify, remote_changed, 0);
-	  if (addr_defined (&remote_verify)
-	      && !addr_match (&remote_verify, &act->dest))
-	    {
-	      msg (M_WARN,
-		   "TCP NOTE: Rejected connection attempt from %s due to --remote setting",
-		   print_link_socket_actual (act, &gc));
-	      if (openvpn_close_socket (new_sd))
-		msg (M_ERR, "TCP: close socket failed (new_sd)");
-	    }
+          struct addrinfo* ai;
+          if(remote_dynamic)
+              openvpn_getaddrinfo(0, remote_dynamic, NULL, 1, NULL,
+                                    remote_verify.addr.sa.sa_family, &ai);
+
+          if(ai && !addrlist_match(&remote_verify, ai))
+            {
+              msg (M_WARN,
+                   "TCP NOTE: Rejected connection attempt from %s due to --remote setting",
+                   print_link_socket_actual (act, &gc));
+              if (openvpn_close_socket (new_sd))
+                  msg (M_ERR, "TCP: close socket failed (new_sd)");
+              freeaddrinfo(ai);
+            }
 	  else
-	    break;
+            {
+              if(ai)
+                  freeaddrinfo(ai);
+              break;
+            }
 	}
       openvpn_sleep (1);
     }
@@ -912,17 +862,37 @@ socket_listen_accept (socket_descriptor_t sd,
 
 void
 socket_bind (socket_descriptor_t sd,
-             struct openvpn_sockaddr *local,
+             struct addrinfo *local,
+             int ai_family,
 	     const char *prefix)
 {
   struct gc_arena gc = gc_new ();
 
-  if (bind (sd, &local->addr.sa, af_addr_size(local->addr.sa.sa_family)))
+  /* FIXME (schwabe)
+   * getaddrinfo for the bind address might return multiple AF_INET/AF_INET6
+   * entries for the requested protocol.
+   * For example if an address has multiple A records
+   * What is the correct way to deal with it?
+   */
+  
+  ASSERT(local);
+  struct addrinfo* cur;
+    
+  /* find the first addrinfo with correct ai_family */
+  for (cur = local; cur; cur=cur->ai_next)
+    {
+      if(cur->ai_family == ai_family)
+          break;
+    }
+  if (!cur)
+      msg (M_FATAL, "%s: Socket bind failed: No addr to bind has no v4/v6 record", prefix);
+    
+  if (bind (sd, cur->ai_addr, cur->ai_addrlen))
     {
       const int errnum = openvpn_errno ();
       msg (M_FATAL, "%s: Socket bind failed on local address %s: %s",
 	   prefix,
-           print_sockaddr (local, &gc),
+           print_sockaddr_ex (local->ai_addr, ":", PS_SHOW_PORT, &gc),
            strerror_ts (errnum, &gc));
     }
   gc_free (&gc);
@@ -930,7 +900,7 @@ socket_bind (socket_descriptor_t sd,
 
 int
 openvpn_connect (socket_descriptor_t sd,
-		 struct openvpn_sockaddr *remote,
+		 const struct sockaddr *remote,
 		 int connect_timeout,
 		 volatile int *signal_received)
 {
@@ -938,7 +908,7 @@ openvpn_connect (socket_descriptor_t sd,
 
 #ifdef CONNECT_NONBLOCK
   set_nonblock (sd);
-  status = connect (sd, &remote->addr.sa, af_addr_size(remote->addr.sa.sa_family));
+  status = connect (sd, remote, af_addr_size(remote->sa_family));
   if (status)
     status = openvpn_errno ();
   if (
@@ -1010,85 +980,76 @@ openvpn_connect (socket_descriptor_t sd,
   return status;
 }
 
+void set_actual_address (struct link_socket_actual* actual, struct addrinfo* ai)
+{
+    CLEAR (*actual);
+    ASSERT (ai);
+    
+    if (ai->ai_family == AF_INET)
+        actual->dest.addr.in4 =
+        *((struct sockaddr_in*) ai->ai_addr);
+    else if (ai->ai_family == AF_INET6)
+        actual->dest.addr.in6 =
+        *((struct sockaddr_in6*) ai->ai_addr);
+    else
+        ASSERT(0);
+    
+    /* Copy addrinfo sock parameters for socket creating */
+    actual->ai_family = ai->ai_family;
+    actual->ai_protocol = ai->ai_protocol;
+    actual->ai_socktype = ai->ai_socktype;
+}
+
 void
 socket_connect (socket_descriptor_t *sd,
-                struct openvpn_sockaddr *local,
-                bool bind_local,
-		struct openvpn_sockaddr *remote,
-		const bool connection_profiles_defined,
-		const char *remote_dynamic,
-		bool *remote_changed,
-		const int connect_retry_seconds,
-		const int connect_timeout,
-		const int connect_retry_max,
-		const unsigned int sockflags,
-		volatile int *signal_received)
+                struct link_socket_addr *lsa,
+                const int connect_timeout,
+                struct signal_info* sig_info)
 {
   struct gc_arena gc = gc_new ();
-  int retry = 0;
-
+  const struct sockaddr *dest = &lsa->actual.dest.addr.sa;
+    
+  int status;
+      
 #ifdef CONNECT_NONBLOCK
-  msg (M_INFO, "Attempting to establish TCP connection with %s [nonblock]", 
-       print_sockaddr (remote, &gc));
+  msg (M_INFO, "Attempting to establish TCP connection with %s [nonblock]",
+       print_sockaddr (dest, &gc));
 #else
-  msg (M_INFO, "Attempting to establish TCP connection with %s", 
-       print_sockaddr (remote, &gc));
+  msg (M_INFO, "Attempting to establish TCP connection with %s",
+       print_sockaddr (dest, &gc));
 #endif
-
-  while (true)
-    {
-      int status;
-
+      
 #ifdef ENABLE_MANAGEMENT
-      if (management)
+  if (management)
 	management_set_state (management,
-			      OPENVPN_STATE_TCP_CONNECT,
-			      NULL,
-			      (in_addr_t)0,
-			      (in_addr_t)0);
+                          OPENVPN_STATE_TCP_CONNECT,
+                          NULL,
+                          (in_addr_t)0,
+                          (in_addr_t)0);
 #endif
 
-      status = openvpn_connect (*sd, remote, connect_timeout, signal_received);
+  /* Set the actual address */
+  status = openvpn_connect (*sd, dest, connect_timeout, &sig_info->signal_received);
 
-      get_signal (signal_received);
-      if (*signal_received)
+  get_signal (&sig_info->signal_received);
+  if (sig_info->signal_received)
 	goto done;
 
-      if (!status)
-	break;
-
-      msg (D_LINK_ERRORS,
-	   "TCP: connect to %s failed, will try again in %d seconds: %s",
-	   print_sockaddr (remote, &gc),
-	   connect_retry_seconds,
-	   strerror_ts (status, &gc));
-
-      gc_reset (&gc);
-
-      openvpn_close_socket (*sd);
-      *sd = SOCKET_UNDEFINED;
-
-      if ((connect_retry_max > 0 && ++retry >= connect_retry_max) || connection_profiles_defined)
-	{
-	  *signal_received = SIGUSR1;
-	  goto done;
-	}
+  if (status) {
 
-      openvpn_sleep (connect_retry_seconds);
+    msg (D_LINK_ERRORS,
+         "TCP: connect to %s failed: %s",
+         print_sockaddr (dest, &gc),
+         strerror_ts (status, &gc));
 
-      get_signal (signal_received);
-      if (*signal_received)
-	goto done;
-
-	*sd = create_socket_tcp (local->addr.sa.sa_family);
-
-      if (bind_local)
-        socket_bind (*sd, local, "TCP Client");
-      update_remote (remote_dynamic, remote, remote_changed, sockflags);
-    }
-
-  msg (M_INFO, "TCP connection established with %s", 
-       print_sockaddr (remote, &gc));
+    openvpn_close_socket (*sd);
+    *sd = SOCKET_UNDEFINED;
+    sig_info->signal_received = SIGUSR1;
+    sig_info->source = SIG_SOURCE_CONNECTION_FAILED;
+  } else {
+      msg (M_INFO, "TCP connection established with %s",
+        print_sockaddr (dest, &gc));
+  }
 
  done:
   gc_free (&gc);
@@ -1139,48 +1100,47 @@ frame_adjust_path_mtu (struct frame *frame, int pmtu, int proto)
 }
 
 static void
-resolve_bind_local (struct link_socket *sock)
+resolve_bind_local (struct link_socket *sock, const sa_family_t af)
 {
   struct gc_arena gc = gc_new ();
 
   /* resolve local address if undefined */
-  if (!addr_defined (&sock->info.lsa->local))
+  if (!sock->info.lsa->bind_local)
     {
+      int flags = GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL |
+                   GETADDR_FATAL | GETADDR_PASSIVE;
       int status;
-      struct addrinfo *ai;
+      
+      if(proto_is_dgram(sock->info.proto))
+          flags |= GETADDR_DATAGRAM;
  
-      /* may return AF_{INET|INET6} guessed from local_host */
-      const int af = addr_guess_family(sock->info.af, sock->local_host);
-      status = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL | GETADDR_PASSIVE,
-                                   sock->local_host, sock->local_port, 0, NULL, af, &ai);
-      if(status ==0) {
-        switch(af) {
-        case AF_INET:
-          sock->info.lsa->local.addr.in4 =  *((struct sockaddr_in*)(ai->ai_addr));
-
-        case AF_INET6:
-          sock->info.lsa->local.addr.in6 = *((struct sockaddr_in6*)(ai->ai_addr));
-          break;
-          freeaddrinfo(ai);
-        }
-      } else {
+      /* will return AF_{INET|INET6}from local_host */
+      status = openvpn_getaddrinfo(flags, sock->local_host, sock->local_port, 0,
+                                   NULL, af, &sock->info.lsa->bind_local);
+      if(status !=0) {
         msg (M_FATAL, "getaddrinfo() failed for local \"%s:%s\": %s",
              sock->local_host, sock->local_port,
-             gai_strerror(err));
+             gai_strerror(status));
       }
     }
 
-  /* bind to local address/port */
-  if (sock->bind_local)
-    {
+  gc_free (&gc);
+}
+
+static void bind_local (struct link_socket *sock)
+{
+    /* bind to local address/port */
+    if (sock->bind_local)
+      {
 #ifdef ENABLE_SOCKS
-      if (sock->socks_proxy && sock->info.proto == PROTO_UDP && sock->info.af == AF_INET)
-          socket_bind (sock->ctrl_sd, &sock->info.lsa->local, "SOCKS");
-      else
+        if (sock->socks_proxy && sock->info.proto == PROTO_UDP && sock->info.af == AF_INET)
+            socket_bind (sock->ctrl_sd, sock->info.lsa->bind_local,
+                         sock->info.lsa->actual.ai_family, "SOCKS");
+        else
 #endif
-          socket_bind (sock->sd, &sock->info.lsa->local, "TCP/UDP");
-    }
-  gc_free (&gc);
+            socket_bind (sock->sd, sock->info.lsa->bind_local,
+                         sock->info.lsa->actual.ai_family,  "TCP/UDP");
+      }
 }
 
 static void
@@ -1190,7 +1150,6 @@ resolve_remote (struct link_socket *sock,
 		volatile int *signal_received)
 {
   struct gc_arena gc = gc_new ();
-  int af;
 
   if (!sock->did_resolve_remote)
     {
@@ -1202,8 +1161,11 @@ resolve_remote (struct link_socket *sock,
 	      unsigned int flags = sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
 	      int retry = 0;
 	      int status = -1;
+              
+              if (proto_is_dgram(sock->info.proto))
+                  flags |= GETADDR_DATAGRAM;
 
-	      if (sock->connection_profiles_defined && sock->resolve_retry_seconds == RESOLV_RETRY_INFINITE)
+	      if (sock->resolve_retry_seconds == RESOLV_RETRY_INFINITE)
 		{
 		  if (phase == 2)
 		    flags |= (GETADDR_TRY_ONCE | GETADDR_FATAL);
@@ -1239,12 +1201,11 @@ resolve_remote (struct link_socket *sock,
 		}
 
 		  struct addrinfo* ai;
-
-		  /* Temporary fix, this need to be changed for dual stack */
-		  status = openvpn_getaddrinfo(flags, sock->remote_host, sock->remote_port,
-                                               retry, signal_received, af, &ai);
+		  status = openvpn_getaddrinfo (flags, sock->remote_host, sock->remote_port,
+                                               retry, signal_received, sock->info.af, &ai);
 		  if(status == 0) {
                           sock->info.lsa->remote_list = ai;
+                          sock->info.lsa->current_remote = ai;
 
 			  dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
 					flags,
@@ -1277,18 +1238,12 @@ resolve_remote (struct link_socket *sock,
 	}
       else
 	{
-	  CLEAR (sock->info.lsa->actual);
-	  /* TODO(schwabe) will only use first address als dest address */
-      if(sock->info.lsa->remote_list) {
-          if (sock->info.lsa->remote_list->ai_family == AF_INET)
-              sock->info.lsa->actual.dest.addr.in4 =
-              *((struct sockaddr_in*) sock->info.lsa->remote_list->ai_addr);
-          else if (sock->info.lsa->remote_list->ai_family == AF_INET6)
-              sock->info.lsa->actual.dest.addr.in6 =
-              *((struct sockaddr_in6*) sock->info.lsa->remote_list->ai_addr);
-          else
-              ASSERT(0);
-      }
+          CLEAR (sock->info.lsa->actual);
+          if(sock->info.lsa->current_remote)
+            {
+              set_actual_address (&sock->info.lsa->actual,
+                                  sock->info.lsa->current_remote);
+            }
 	}
 
       /* remember that we finished */
@@ -1299,6 +1254,8 @@ resolve_remote (struct link_socket *sock,
   gc_free (&gc);
 }
 
+
+
 struct link_socket *
 link_socket_new (void)
 {
@@ -1315,24 +1272,27 @@ link_socket_new (void)
 void
 create_new_socket (struct link_socket* sock, int mark)
 {
+   if (sock->bind_local) {
+      resolve_bind_local (sock, sock->info.af);
+  }
+  resolve_remote (sock, 1, NULL, NULL);
   create_socket (sock);
-    
+
   /* set socket buffers based on --sndbuf and --rcvbuf options */
   socket_set_buffers (sock->sd, &sock->socket_buffer_sizes);
     
   /* set socket to --mark packets with given value */
   socket_set_mark (sock->sd, mark);
+
+  if (sock->bind_local)
+    bind_local(sock);
     
-  if(sock->bind_local)
-      resolve_bind_local (sock);
-  resolve_remote (sock, 1, NULL, NULL);
 }
 
 
 /* bind socket if necessary */
 void
 link_socket_init_phase1 (struct link_socket *sock,
-			 const bool connection_profiles_defined,
 			 const char *local_host,
 			 const char *local_port,
 			 const char *remote_host,
@@ -1357,9 +1317,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *ipchange_command,
 			 const struct plugin_list *plugins,
 			 int resolve_retry_seconds,
-			 int connect_retry_seconds,
 			 int connect_timeout,
-			 int connect_retry_max,
 			 int mtu_discover_type,
 			 int rcvbuf,
 			 int sndbuf,
@@ -1368,8 +1326,6 @@ link_socket_init_phase1 (struct link_socket *sock,
 {
   ASSERT (sock);
 
-  sock->connection_profiles_defined = connection_profiles_defined;
-
   sock->local_host = local_host;
   sock->local_port = local_port;
   sock->remote_host = remote_host;
@@ -1386,9 +1342,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   sock->bind_local = bind_local;
   sock->inetd = inetd;
   sock->resolve_retry_seconds = resolve_retry_seconds;
-  sock->connect_retry_seconds = connect_retry_seconds;
   sock->connect_timeout = connect_timeout;
-  sock->connect_retry_max = connect_retry_max;
   sock->mtu_discover_type = mtu_discover_type;
 
 #ifdef ENABLE_DEBUG
@@ -1415,7 +1369,7 @@ link_socket_init_phase1 (struct link_socket *sock,
       ASSERT (!sock->inetd);
       sock->sd = accept_from->sd;
     }
-
+    
   if (false)
     ;
 #ifdef ENABLE_HTTP_PROXY
@@ -1492,7 +1446,7 @@ void phase2_inetd (struct link_socket* sock, const struct frame *frame,
       /* inetd: hint family type for dest = local's */
       struct openvpn_sockaddr local_addr;
       socklen_t addrlen = sizeof(local_addr);
-      if (getsockname (sock->sd, (struct sockaddr *)&local_addr, &addrlen) == 0) {
+      if (getsockname (sock->sd, &local_addr.addr.sa, &addrlen) == 0) {
         sock->info.lsa->actual.dest.addr.sa.sa_family = local_addr.addr.sa.sa_family;
         dmsg (D_SOCKET_DEBUG, "inetd(%s): using sa_family=%d from getsockname(%d)",
               proto2ascii(sock->info.proto, sock->info.af, false), local_addr.addr.sa.sa_family,
@@ -1510,8 +1464,7 @@ void phase2_inetd (struct link_socket* sock, const struct frame *frame,
       socket_listen_accept (sock->sd,
                             &sock->info.lsa->actual,
                             remote_dynamic,
-                            &remote_changed,
-                            &sock->info.lsa->local,
+                            sock->info.lsa->bind_local,
                             false,
                             sock->inetd == INETD_NOWAIT,
                             signal_received);
@@ -1558,11 +1511,23 @@ linksock_print_addr (struct link_socket *sock)
     
     if (sock->inetd)
       msg (msglevel, "%s link local: [inetd]", proto2ascii (sock->info.proto, sock->info.af, true));
-    else
-      msg (msglevel, "%s link local%s: %s",
+    else if (sock->bind_local)
+      {
+        /* Socket is always bound on the first matching address */
+        struct addrinfo *cur;
+        for (cur = sock->info.lsa->bind_local; cur; cur=cur->ai_next)
+          {
+            if(cur->ai_family == sock->info.lsa->actual.ai_family)
+                break;
+          }
+        ASSERT (cur);
+        msg (msglevel, "%s link local (bound): %s",
            proto2ascii (sock->info.proto, sock->info.af, true),
-           (sock->bind_local ? " (bound)" : ""),
-           print_sockaddr_ex (&sock->info.lsa->local.addr.sa, ":", sock->bind_local ? PS_SHOW_PORT : 0, &gc));
+           print_sockaddr(cur->ai_addr,&gc));
+      }
+    else
+        msg (msglevel, "%s link local: (not bound)",
+             proto2ascii (sock->info.proto, sock->info.af, true));
     
     /* print active remote address */
     msg (msglevel, "%s link remote: %s",
@@ -1576,8 +1541,8 @@ linksock_print_addr (struct link_socket *sock)
 }
 
 static void
-phase2_tcp_server (struct link_socket *sock, bool *remote_changed,
-                   const char *remote_dynamic, volatile int *signal_received)
+phase2_tcp_server (struct link_socket *sock, const char *remote_dynamic,
+                   volatile int *signal_received)
 {
   switch (sock->mode)
     {
@@ -1585,15 +1550,14 @@ phase2_tcp_server (struct link_socket *sock, bool *remote_changed,
       sock->sd = socket_listen_accept (sock->sd,
                                        &sock->info.lsa->actual,
                                        remote_dynamic,
-                                       remote_changed,
-                                       &sock->info.lsa->local,
+                                       sock->info.lsa->bind_local,
                                        true,
                                        false,
                                        signal_received);
       break;
     case LS_MODE_TCP_LISTEN:
       socket_do_listen (sock->sd,
-                        &sock->info.lsa->local,
+                        sock->info.lsa->bind_local->ai_addr,
                         true,
                         false);
       break;
@@ -1616,8 +1580,7 @@ phase2_tcp_server (struct link_socket *sock, bool *remote_changed,
 
 
 static void
-phase2_tcp_client (struct link_socket *sock, bool *remote_changed,
-                   const char *remote_dynamic, volatile int *signal_received)
+phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
 {
 #ifdef GENERAL_PROXY_SUPPORT
     bool proxy_retry = false;
@@ -1626,19 +1589,11 @@ phase2_tcp_client (struct link_socket *sock, bool *remote_changed,
 #endif
     do {
         socket_connect (&sock->sd,
-                        &sock->info.lsa->local,
-                        sock->bind_local,
-                        &sock->info.lsa->actual.dest,
-                        sock->connection_profiles_defined,
-                        remote_dynamic,
-                        remote_changed,
-                        sock->connect_retry_seconds,
+                        sock->info.lsa,
                         sock->connect_timeout,
-                        sock->connect_retry_max,
-                        sock->sockflags,
-                        signal_received);
+                        sig_info);
         
-        if (*signal_received)
+        if (sig_info->signal_received)
             return;
         
         if (false)
@@ -1651,7 +1606,7 @@ phase2_tcp_client (struct link_socket *sock, bool *remote_changed,
                                                              sock->proxy_dest_host,
                                                              sock->proxy_dest_port,
                                                              &sock->stream_buf.residual,
-                                                             signal_received);
+                                                             &sig_info->signal_received);
             }
 #endif
 #ifdef ENABLE_SOCKS
@@ -1661,11 +1616,13 @@ phase2_tcp_client (struct link_socket *sock, bool *remote_changed,
                                                 sock->sd,
                                                 sock->proxy_dest_host,
                                                 sock->proxy_dest_port,
-                                                signal_received);
+                                                &sig_info->signal_received);
             }
 #endif
         if (proxy_retry)
             {
+              /* TODO (schwabe): This code assumes AF_INET for the proxy socket
+               * when retrying a connection */
                 openvpn_close_socket (sock->sd);
                 sock->sd = create_socket_tcp (AF_INET);
             }
@@ -1675,32 +1632,23 @@ phase2_tcp_client (struct link_socket *sock, bool *remote_changed,
 
 #ifdef ENABLE_SOCKS
 static void
-phase2_socks_client (struct link_socket *sock, bool *remote_changed,
-                      const char *remote_dynamic, volatile int *signal_received)
+phase2_socks_client (struct link_socket *sock, struct signal_info *sig_info)
 {
     socket_connect (&sock->ctrl_sd,
-                    &sock->info.lsa->local,
-                    sock->bind_local,
-                    &sock->info.lsa->actual.dest,
-                    sock->connection_profiles_defined,
-                    remote_dynamic,
-                    remote_changed,
-                    sock->connect_retry_seconds,
+                    sock->info.lsa,
                     sock->connect_timeout,
-                    sock->connect_retry_max,
-                    sock->sockflags,
-                    signal_received);
+                    sig_info);
     
-    if (*signal_received)
+    if (sig_info->signal_received)
         return;
     
     establish_socks_proxy_udpassoc (sock->socks_proxy,
                                     sock->ctrl_sd,
                                     sock->sd,
                                     &sock->socks_relay.dest,
-                                    signal_received);
+                                    &sig_info->signal_received);
     
-    if (*signal_received)
+    if (sig_info->signal_received)
         return;
     
     sock->remote_host = sock->proxy_dest_host;
@@ -1711,7 +1659,7 @@ phase2_socks_client (struct link_socket *sock, bool *remote_changed,
     if (sock->info.lsa->remote_list)
         freeaddrinfo(sock->info.lsa->remote_list);
     
-    resolve_remote (sock, 1, NULL, signal_received);
+    resolve_remote (sock, 1, NULL, &sig_info->signal_received);
     
 }
 #endif
@@ -1720,18 +1668,17 @@ phase2_socks_client (struct link_socket *sock, bool *remote_changed,
 void
 link_socket_init_phase2 (struct link_socket *sock,
                          const struct frame *frame,
-                         volatile int *signal_received)
+                         struct signal_info *sig_info)
 {
   const char *remote_dynamic = NULL;
-  bool remote_changed = false;
   int sig_save = 0;
 
   ASSERT (sock);
 
-  if (signal_received && *signal_received)
+  if (sig_info && sig_info->signal_received)
     {
-      sig_save = *signal_received;
-      *signal_received = 0;
+      sig_save = sig_info->signal_received;
+      sig_info->signal_received = 0;
     }
 
   /* initialize buffers */
@@ -1748,56 +1695,46 @@ link_socket_init_phase2 (struct link_socket *sock,
   /* were we started by inetd or xinetd? */
   if (sock->inetd)
     {
-      phase2_inetd (sock, frame, remote_dynamic, signal_received);
-      if (*signal_received)
+      phase2_inetd (sock, frame, remote_dynamic,  &sig_info->signal_received);
+      if (sig_info && sig_info->signal_received)
         goto done;
 
     }
   else
     {
-      resolve_remote (sock, 2, &remote_dynamic, signal_received);
+      resolve_remote (sock, 2, &remote_dynamic,  &sig_info->signal_received);
 
-      if (*signal_received)
+      if (sig_info && sig_info->signal_received)
         goto done;
 
       if (sock->info.proto == PROTO_TCP_SERVER)
         {
-          phase2_tcp_server(sock, &remote_changed, remote_dynamic,
-                            signal_received);
+          phase2_tcp_server (sock, remote_dynamic,
+                             &sig_info->signal_received);
         }
       else if (sock->info.proto == PROTO_TCP_CLIENT)
         {
-          phase2_tcp_client(sock, &remote_changed, remote_dynamic,
-                            signal_received);
+          phase2_tcp_client (sock, sig_info);
     
         }
 #ifdef ENABLE_SOCKS
       else if (sock->info.proto == PROTO_UDP && sock->socks_proxy && sock->info.af == AF_INET)
         {
-          phase2_socks_client(sock, &remote_changed, remote_dynamic,
-                              signal_received);
+          phase2_socks_client (sock, sig_info);
 #endif
         }
-      if (*signal_received)
+      if (sig_info && sig_info->signal_received)
         goto done;
-    
-      if (remote_changed)
-        {
-          msg (M_INFO, "TCP/UDP: Dynamic remote address changed during TCP connection establishment");
-          /* TODO(schwabe) handle multiple addresses */
-          ASSERT(0);
-          addr_copy_host(&sock->info.lsa->remote_list->ai_addr, &sock->info.lsa->actual.dest);
-        }
     }
 
   phase2_set_socket_flags(sock);
   linksock_print_addr(sock);
  
  done:
-  if (sig_save && signal_received)
+  if (sig_save && sig_info)
     {
-      if (!*signal_received)
-        *signal_received = sig_save;
+      if (!sig_info->signal_received)
+        sig_info->signal_received = sig_save;
     }
 }
 
@@ -1930,10 +1867,7 @@ link_socket_bad_incoming_addr (struct buffer *buf,
 			       const struct link_socket_actual *from_addr)
 {
   struct gc_arena gc = gc_new ();
-  struct openvpn_sockaddr firstremoteaddr;
-
-  /* TODO(schwabe) Fix this and print all remote addresses */
-  firstremoteaddr.addr.in6 = *(struct sockaddr_in6*)info->lsa->remote_list->ai_addr;
+  struct addrinfo* ai;
 
   switch(from_addr->dest.addr.sa.sa_family)
     {
@@ -1943,7 +1877,12 @@ link_socket_bad_incoming_addr (struct buffer *buf,
 	   "TCP/UDP: Incoming packet rejected from %s[%d], expected peer address: %s (allow this incoming source address/port by removing --remote or adding --float)",
 	   print_link_socket_actual (from_addr, &gc),
 	   (int)from_addr->dest.addr.sa.sa_family,
-	   print_sockaddr (&firstremoteaddr, &gc));
+	   print_sockaddr_ex (info->lsa->remote_list->ai_addr,":" ,PS_SHOW_PORT, &gc));
+          /* print additional remote addresses */
+          for(ai=info->lsa->remote_list->ai_next;ai;ai=ai->ai_next) {
+             msg(D_LINK_ERRORS,"or from peer address: %s",
+                 print_sockaddr_ex(ai->ai_addr,":",PS_SHOW_PORT, &gc));
+          }
       break;
     }
   buf->len = 0;
@@ -1968,15 +1907,17 @@ link_socket_current_remote (const struct link_socket_info *info)
  * Maybe in the future consider PF_INET6 endpoints also ...
  * by now just ignore it
  *
+ * For --remote entries with multiple addresses this
+ * only return the actual endpoint we have sucessfully connected to
  */
-/* TODO(schwabe) what to do for a remote with multiple IPs? */
   if (lsa->actual.dest.addr.sa.sa_family != AF_INET)
     return IPV4_INVALID_ADDR;
 
   if (link_socket_actual_defined (&lsa->actual))
     return ntohl (lsa->actual.dest.addr.in4.sin_addr.s_addr);
-  else if (lsa->remote_list)
-    return ntohl (((struct sockaddr_in*)lsa->remote_list->ai_addr)->sin_addr.s_addr);
+  else if (lsa->current_remote)
+    return ntohl (((struct sockaddr_in*)lsa->current_remote->ai_addr)
+                    ->sin_addr.s_addr);
   else
     return 0;
 }
@@ -2214,12 +2155,12 @@ print_sockaddr_ex (const struct sockaddr *sa,
     case AF_INET6:
       buf_puts (&out, "[AF_INET6]");
       salen = sizeof (struct sockaddr_in6);
-      addr_is_defined = IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6*) sa)->sin6_addr);
+      addr_is_defined = !IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6*) sa)->sin6_addr);
       break;
     default:
       ASSERT(0);
     }
-	
+
   status = getnameinfo(sa, salen, hostaddr, sizeof (hostaddr),
               servname, sizeof(servname), NI_NUMERICHOST | NI_NUMERICSERV);
 
@@ -2457,10 +2398,12 @@ struct proto_names {
 /* Indexed by PROTO_x */
 static const struct proto_names proto_names[] = {
   {"proto-uninitialized",        "proto-NONE", AF_UNSPEC, PROTO_NONE},
-  {"udp",        "UDPv4", AF_INET, PROTO_UDP},
+  {"udp",        "UDP", AF_UNSPEC, PROTO_UDP},
+  {"udp4",        "UDPv4", AF_INET, PROTO_UDP},
   {"tcp-server", "TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER},
   {"tcp-client", "TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT},
-  {"tcp",        "TCPv4", AF_INET, PROTO_TCP},
+  {"tcp",        "TCP", AF_UNSPEC, PROTO_TCP},
+  {"tcp4",        "TCPv4", AF_INET, PROTO_TCP},
   {"udp6"       ,"UDPv6", AF_INET6, PROTO_UDP},
   {"tcp6-server","TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER},
   {"tcp6-client","TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT},
@@ -2793,7 +2736,7 @@ link_socket_write_tcp (struct link_socket *sock,
 
 #if ENABLE_IP_PKTINFO
 
-int
+size_t
 link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
 				     struct buffer *buf,
 				     struct link_socket_actual *to)
@@ -2806,7 +2749,7 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
   iov.iov_len = BLEN (buf);
   mesg.msg_iov = &iov;
   mesg.msg_iovlen = 1;
-  switch (sock->info.lsa->remote_list->ai_family)
+  switch (to->ai_family)
     {
     case AF_INET:
       {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index d341c0a..ae6cb9b 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -81,6 +81,11 @@ struct openvpn_sockaddr
 struct link_socket_actual
 {
   /*int dummy;*/ /* add offset to force a bug if dest not explicitly dereferenced */
+ int ai_family;	/* PF_xxx */
+ int ai_socktype;	/* SOCK_xxx */
+ int ai_protocol;	/* 0 or IPPROTO_xxx for IPv4 and IPv6 */
+
+    
   struct openvpn_sockaddr dest;
 #if ENABLE_IP_PKTINFO
   union {
@@ -97,8 +102,10 @@ struct link_socket_actual
 /* IP addresses which are persistant across SIGUSR1s */
 struct link_socket_addr
 {
-  struct openvpn_sockaddr local;
-  struct addrinfo* remote_list;   /* initial remote */
+  struct addrinfo* bind_local;
+  struct addrinfo* remote_list;   /* complete remote list */
+  struct addrinfo* current_remote;  /* remote used in the 
+                                     current connection attempt */
   struct link_socket_actual actual; /* reply to this address */
 };
 
@@ -176,9 +183,6 @@ struct link_socket
   /* used for long-term queueing of pre-accepted socket listen */
   bool listen_persistent_queued;
 
-  /* Does config file contain any <connection> ... </connection> blocks? */
-  bool connection_profiles_defined;
-
   const char *remote_host;
   const char *remote_port;
   const char *local_host;
@@ -196,9 +200,7 @@ struct link_socket
   int mode;
 
   int resolve_retry_seconds;
-  int connect_retry_seconds;
   int connect_timeout;
-  int connect_retry_max;
   int mtu_discover_type;
 
   struct socket_buffer_size socket_buffer_sizes;
@@ -280,11 +282,12 @@ int socket_finalize (
 struct link_socket *link_socket_new (void);
 
 void socket_bind (socket_descriptor_t sd,
-		  struct openvpn_sockaddr *local,
+		  struct addrinfo *local,
+                  int af_family,
 		  const char *prefix);
 
 int openvpn_connect (socket_descriptor_t sd,
-		     struct openvpn_sockaddr *remote,
+		     const struct sockaddr *remote,
 		     int connect_timeout,
 		     volatile int *signal_received);
 
@@ -294,7 +297,6 @@ int openvpn_connect (socket_descriptor_t sd,
 
 void
 link_socket_init_phase1 (struct link_socket *sock,
-			 const bool connection_profiles_defined,
 			 const char *local_host,
 			 const char *local_port,
 			 const char *remote_host,
@@ -319,9 +321,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *ipchange_command,
 			 const struct plugin_list *plugins,
 			 int resolve_retry_seconds,
-			 int connect_retry_seconds,
 			 int connect_timeout,
-			 int connect_retry_max,
 			 int mtu_discover_type,
 			 int rcvbuf,
 			 int sndbuf,
@@ -330,7 +330,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 
 void link_socket_init_phase2 (struct link_socket *sock,
 			      const struct frame *frame,
-			      volatile int *signal_received);
+			      struct signal_info *sig_info);
 
 void socket_adjust_frame_parameters (struct frame *frame, int proto);
 
@@ -360,12 +360,21 @@ const char *print_openvpn_sockaddr_ex (const struct openvpn_sockaddr *addr,
 }
 
 static inline
-const char *print_sockaddr (const struct openvpn_sockaddr *addr,
+const char *print_openvpn_sockaddr (const struct openvpn_sockaddr *addr,
 			    struct gc_arena *gc)
 {
     return print_sockaddr_ex (&addr->addr.sa, ":", PS_SHOW_PORT, gc);
 }
 
+static inline
+const char *print_sockaddr (const struct sockaddr *addr,
+                                    struct gc_arena *gc)
+{
+    return print_sockaddr_ex (addr, ":", PS_SHOW_PORT, gc);
+}
+
+
+
 const char *print_link_socket_actual_ex (const struct link_socket_actual *act,
 					 const char* separator,
 					 const unsigned int flags,
@@ -416,6 +425,9 @@ void link_socket_bad_incoming_addr (struct buffer *buf,
 				    const struct link_socket_info *info,
 				    const struct link_socket_actual *from_addr);
 
+void set_actual_address (struct link_socket_actual* actual,
+                         struct addrinfo* ai);
+
 void link_socket_bad_outgoing_addr (void);
 
 void setenv_trusted (struct env_set *es, const struct link_socket_info *info);
@@ -492,6 +504,7 @@ bool unix_socket_get_peer_uid_gid (const socket_descriptor_t sd, int *uid, int *
 #define GETADDR_UPDATE_MANAGEMENT_STATE (1<<8)
 #define GETADDR_RANDOMIZE             (1<<9)
 #define GETADDR_PASSIVE               (1<<10)
+#define GETADDR_DATAGRAM              (1<<11)
 
 in_addr_t getaddr (unsigned int flags,
 		   const char *hostname,
@@ -734,19 +747,6 @@ addr_copy_sa(struct openvpn_sockaddr *dst, const struct openvpn_sockaddr *src)
   dst->addr = src->addr;
 }
 
-static inline void
-addr_copy_host(struct openvpn_sockaddr *dst, const struct openvpn_sockaddr *src)
-{
-   switch(src->addr.sa.sa_family) {
-     case AF_INET:
-       dst->addr.in4.sin_addr.s_addr = src->addr.in4.sin_addr.s_addr;
-       break;
-     case AF_INET6: 
-       dst->addr.in6.sin6_addr = src->addr.in6.sin6_addr;
-       break;
-   }
-}
-
 static inline bool
 addr_inet4or6(struct sockaddr *addr)
 {
@@ -1000,13 +1000,13 @@ link_socket_write_win32 (struct link_socket *sock,
 
 #else
 
-static inline int
+static inline size_t
 link_socket_write_udp_posix (struct link_socket *sock,
 			     struct buffer *buf,
 			     struct link_socket_actual *to)
 {
 #if ENABLE_IP_PKTINFO
-  int link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
+  size_t link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
 					   struct buffer *buf,
 					   struct link_socket_actual *to);
 
@@ -1020,7 +1020,7 @@ link_socket_write_udp_posix (struct link_socket *sock,
 		   (socklen_t) af_addr_size(to->dest.addr.sa.sa_family));
 }
 
-static inline int
+static inline size_t
 link_socket_write_tcp_posix (struct link_socket *sock,
 			     struct buffer *buf,
 			     struct link_socket_actual *to)
@@ -1030,7 +1030,7 @@ link_socket_write_tcp_posix (struct link_socket *sock,
 
 #endif
 
-static inline int
+static inline size_t
 link_socket_write_udp (struct link_socket *sock,
 		       struct buffer *buf,
 		       struct link_socket_actual *to)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6c842d2..e889164 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -412,7 +412,7 @@ init_tun (const char *dev,       /* --dev option */
 	  const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */
 	  int         ifconfig_ipv6_netbits_parm,
 	  const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */
-	  in_addr_t local_public,
+	  struct addrinfo *local_public,
 	  struct addrinfo *remote_public,
 	  const bool strict_warn,
 	  struct env_set *es)
@@ -474,12 +474,15 @@ init_tun (const char *dev,       /* --dev option */
 	   * If local_public or remote_public addresses are defined,
 	   * make sure they do not clash with our virtual subnet.
 	   */
-
-	  check_addr_clash ("local",
+          
+          for(curele=remote_public;curele;curele=curele->ai_next) {
+            if(curele->ai_family == AF_INET)
+              check_addr_clash ("local",
 			    tt->type,
-			    local_public,
+                            ((struct sockaddr_in*)curele->ai_addr)->sin_addr.s_addr,
 			    tt->local,
 			    tt->remote_netmask);
+          }
 
           for(curele=remote_public;curele;curele=curele->ai_next) {
             if(curele->ai_family == AF_INET)
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ce23b0d..6a0470e 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -231,7 +231,7 @@ struct tuntap *init_tun (const char *dev,       /* --dev option */
 			 const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */
 			 int ifconfig_ipv6_netbits_parm,           /* --ifconfig parm 1 / bits */
 			 const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */
-			 in_addr_t local_public,
+			 struct addrinfo *local_public,
 			 struct addrinfo *remote_public,
 			 const bool strict_warn,
 			 struct env_set *es);
-- 
1.7.9.5


