From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  2 Mar 2015 16:50:03 +0200
Message-Id: <1425307803-14166-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2] Notify clients about server's
	exit/restart
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

When server exits / restarts (gets SIGUSR1, SIGTERM, SIGHUP, SIGINT) and
explicit-exit-notify is set, server broadcasts new OCC_SERVER_EXIT command
to all clients and reschedules received signal in 2 secs.

When client receives OCC_SERVER_EXIT, it fires SIGUSR1 and switches to
the next server. Next server is defined as same remote with different IP address
if remote resolves into multiple addresses or next remote otherwise.

v2:
 - take into use explicit-exit-notify on the server side
 - OCC_SHUTTING_DOWN renamed to OCC_SERVER_EXIT
 - minor code prettifying

---
 src/openvpn/multi.c   | 66 +++++++++++++++++++++++++++++++++++++++++++++++----
 src/openvpn/multi.h   | 14 ++++++++++-
 src/openvpn/occ.c     |  8 +++++++
 src/openvpn/occ.h     |  6 +++++
 src/openvpn/options.c |  7 ++----
 src/openvpn/options.h |  3 ++-
 6 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4412491..b0d0e08 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -396,6 +396,8 @@ multi_init (struct multi_context *m, struct context *t, bool tcp_mode, int threa
         t->options.stale_routes_check_interval, t->options.stale_routes_ageing_time);
       event_timeout_init (&m->stale_routes_check_et, t->options.stale_routes_check_interval, 0);
     }
+
+  m->deferred_shutdown_signal.signal_received = 0;
 }
 
 const char *
@@ -603,6 +605,25 @@ multi_close_instance (struct multi_context *m,
   perf_pop ();
 }
 
+void
+multi_broadcast_server_exit (struct multi_context *m)
+{
+  msg (D_LOW, "multi_broadcast_server_exit");
+
+  struct gc_arena gc = gc_new ();
+  struct buffer buf = alloc_buf_gc (BUF_SIZE (&m->top.c2.frame), &gc);
+
+  buf_init (&buf, FRAME_HEADROOM (&m->top.c2.frame));
+  buf_safe (&buf, MAX_RW_SIZE_TUN (&m->top.c2.frame));
+  buf_write (&buf, occ_magic, OCC_STRING_SIZE);
+
+  buf_write_u8 (&buf, OCC_SERVER_EXIT);
+
+  multi_bcast (m, &buf, NULL, NULL);
+
+  gc_free (&gc);
+}
+
 /*
  * Called on shutdown or restart.
  */
@@ -1952,7 +1973,7 @@ multi_unicast (struct multi_context *m,
 /*
  * Broadcast a packet to all clients.
  */
-static void
+void
 multi_bcast (struct multi_context *m,
 	     const struct buffer *buf,
 	     const struct multi_instance *sender_instance,
@@ -2571,10 +2592,18 @@ multi_process_timeout (struct multi_context *m, const unsigned int mpp_flags)
   /* instance marked for wakeup? */
   if (m->earliest_wakeup)
     {
-      set_prefix (m->earliest_wakeup);
-      ret = multi_process_post (m, m->earliest_wakeup, mpp_flags);
+      if (m->earliest_wakeup == (struct multi_instance*)&m->deferred_shutdown_signal)
+	{
+	  schedule_remove_entry(m->schedule, (struct schedule_entry*) &m->deferred_shutdown_signal);
+	  throw_signal(m->deferred_shutdown_signal.signal_received);
+	}
+      else
+	{
+	  set_prefix (m->earliest_wakeup);
+	  ret = multi_process_post (m, m->earliest_wakeup, mpp_flags);
+	  clear_prefix ();
+	}
       m->earliest_wakeup = NULL;
-      clear_prefix ();
     }
   return ret;
 }
@@ -2699,6 +2728,12 @@ multi_top_free (struct multi_context *m)
   free_context_buffers (m->top.c2.buffers);
 }
 
+bool
+is_exit_restart(int sig)
+{
+  return (sig == SIGUSR1 || sig == SIGTERM || sig == SIGHUP || sig == SIGINT);
+}
+
 /*
  * Return true if event loop should break,
  * false if it should continue.
@@ -2714,6 +2749,29 @@ multi_process_signal (struct multi_context *m)
       m->top.sig->signal_received = 0;
       return false;
     }
+  else if (proto_is_dgram(m->top.options.ce.proto) &&
+      is_exit_restart(m->top.sig->signal_received) &&
+      (m->deferred_shutdown_signal.signal_received == 0) &&
+      m->top.options.ce.explicit_exit_notification)
+    {
+      /* broadcast OCC_SERVER_EXIT to clients */
+      multi_broadcast_server_exit(m);
+
+      /* schedule signal */
+      openvpn_gettimeofday (&m->deferred_shutdown_signal.wakeup, NULL);
+      struct timeval tv;
+      tv.tv_sec = 2;
+      tv.tv_usec = 0;
+      tv_add (&m->deferred_shutdown_signal.wakeup, &tv);
+
+      m->deferred_shutdown_signal.signal_received = m->top.sig->signal_received;
+
+      schedule_add_entry (m->schedule, (struct schedule_entry *) &m->deferred_shutdown_signal,
+			  &m->deferred_shutdown_signal.wakeup, compute_wakeup_sigma (&m->deferred_shutdown_signal.wakeup));
+
+      m->top.sig->signal_received = 0;
+      return false;
+  }
   return true;
 }
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 32b89d2..d968626 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -57,6 +57,13 @@ struct multi_reap
 };
 
 
+struct deferred_signal_schedule_entry
+{
+  struct schedule_entry se;
+  int signal_received;
+  struct timeval wakeup;
+};
+
 /**
  * Server-mode state structure for one single VPN tunnel.
  *
@@ -172,6 +179,8 @@ struct multi_context {
    * Timer object for stale route check
    */
   struct event_timeout stale_routes_check_et;
+
+  struct deferred_signal_schedule_entry deferred_shutdown_signal;
 };
 
 /*
@@ -190,7 +199,6 @@ struct multi_route
   time_t last_reference;
 };
 
-
 /**************************************************************************/
 /**
  * Main event loop for OpenVPN in server mode.
@@ -290,6 +298,10 @@ bool multi_process_post (struct multi_context *m, struct multi_instance *mi, con
 bool multi_process_incoming_link (struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags);
 
 
+void multi_bcast (struct multi_context *m, const struct buffer *buf,
+		  const struct multi_instance *sender_instance,
+		  const struct mroute_addr *sender_addr);
+
 /**
  * Determine the destination VPN tunnel of a packet received over the
  * virtual tun/tap network interface and then process it accordingly.
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index ff48706..8302488 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -390,6 +390,14 @@ process_received_occ_msg (struct context *c)
       c->sig->signal_received = SIGTERM;
       c->sig->signal_text = "remote-exit";
       break;
+
+    case OCC_SERVER_EXIT:
+      msg (D_LOW, "RECEIVED OCC_SERVER_EXIT");
+      c->sig->signal_received = SIGUSR1;
+      c->sig->signal_text = "remote-server-exit";
+      c->options.no_advance = false;
+      break;
+
     }
   c->c2.buf.len = 0; /* don't pass packet on */
 }
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 5d88cc9..22ba4dc 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -69,6 +69,12 @@
  */
 #define OCC_EXIT               6
 
+
+/*
+ * Notifies clients that server is exiting/restarting
+ */
+#define OCC_SERVER_EXIT        7
+
 /*
  * Used to conduct a load test command sequence
  * of UDP connection for empirical MTU measurement.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4ea03d1..c00b5a9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -496,7 +496,8 @@ static const char usage_message[] =
 #endif
 #ifdef ENABLE_OCC
   "--explicit-exit-notify [n] : On exit/restart, send exit signal to\n"
-  "                  server/remote. n = # of retries, default=1.\n"
+  "                  server/remote or client. n = # of retries, default=1.\n"
+  "                  n is ignored in server mode.\n"
 #endif
 #ifdef ENABLE_CRYPTO
   "\n"
@@ -2022,10 +2023,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--connect-freq only works with --mode server --proto udp.  Try --max-clients instead.");
       if (!(dev == DEV_TYPE_TAP || (dev == DEV_TYPE_TUN && options->topology == TOP_SUBNET)) && options->ifconfig_pool_netmask)
 	msg (M_USAGE, "The third parameter to --ifconfig-pool (netmask) is only valid in --dev tap mode");
-#ifdef ENABLE_OCC
-      if (ce->explicit_exit_notification)
-	msg (M_USAGE, "--explicit-exit-notify cannot be used with --mode server");
-#endif
       if (options->routes && (options->routes->flags & RG_ENABLE))
 	msg (M_USAGE, "--redirect-gateway cannot be used with --mode server (however --push \"redirect-gateway\" is fine)");
       if (options->route_delay_defined)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 7a8b21e..d232b83 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -121,7 +121,8 @@ struct connection_entry
   bool mssfix_default;   /* true if --mssfix was supplied without a parameter */
 
 #ifdef ENABLE_OCC
-  int explicit_exit_notification;  /* Explicitly tell peer when we are exiting via OCC_EXIT message */
+  /* Explicitly tell peer when we are exiting via OCC_EXIT (client to server) or OCC_SERVER_EXIT (server to client) message */
+  int explicit_exit_notification;
 #endif
 
 # define CE_DISABLED (1<<0)
-- 
1.9.1


