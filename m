From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 13 Oct 2015 17:45:58 +0300
Message-Id: <1444747558-23291-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1425307803-14166-1-git-send-email-lstipakov@...277...>
References: <1425307803-14166-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v3] Notify clients about server's
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
explicit-exit-notify is set, server sends RESTART control channel command to
all clients and reschedules received signal in 2 secs.

When client receives RESTART command, it either reconnects to the same server or
advances to the new one, depends on parameter comes with RESTART
command - behavior is controlled by explicit-exit-notify in the server config.

v3:
 - Use control channel "RESTART" command instead of new OCC code to
notify clients
 - Configure on the server side (by value of explicit-exit-notify) if
client should reconnect to the same server or advance to the next one
 - Fix compilation when OCC is disabled (--enable-small)
 - Update man page

v2:
 - Take into use explicit-exit-notify on the server side
 - OCC_SHUTTING_DOWN renamed to OCC_SERVER_EXIT
 - Code prettifying

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 doc/openvpn.8         | 15 ++++++++++--
 src/openvpn/multi.c   | 68 ++++++++++++++++++++++++++++++++++++++++++++++++---
 src/openvpn/multi.h   |  9 +++++++
 src/openvpn/options.c |  9 +++----
 src/openvpn/push.c    |  6 +++++
 5 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e213f5a..0a00dec 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3829,8 +3829,19 @@ option will tell the server to immediately close its client instance object
 rather than waiting for a timeout.  The
 .B n
 parameter (default=1) controls the maximum number of attempts that the client
-will try to resend the exit notification message.  OpenVPN will not send any exit
-notifications unless this option is enabled.
+will try to resend the exit notification message. 
+
+In UDP server mode, send RESTART control channel command to connected clients. The
+.B n
+parameter (default=1) controls client behavior. With
+.B n
+= 1 client will attempt to reconnect
+to the same server, with
+.B n
+= 2 client will advance to the next server.
+
+OpenVPN will not send any exit
+notifications unless this option is enabled. 
 .\"*********************************************************
 .SS Data Channel Encryption Options:
 These options are meaningful for both Static & TLS-negotiated key modes
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 902c4dc..d16b145 100644
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
@@ -2572,10 +2574,18 @@ multi_process_timeout (struct multi_context *m, const unsigned int mpp_flags)
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
@@ -2700,6 +2710,48 @@ multi_top_free (struct multi_context *m)
   free_context_buffers (m->top.c2.buffers);
 }
 
+static bool
+is_exit_restart(int sig)
+{
+  return (sig == SIGUSR1 || sig == SIGTERM || sig == SIGHUP || sig == SIGINT);
+}
+
+static void
+multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
+{
+  struct hash_iterator hi;
+  struct hash_element *he;
+  struct timeval tv;
+
+  /* tell all clients to restart */
+  hash_iterator_init (m->iter, &hi);
+  while ((he = hash_iterator_next (&hi)))
+    {
+      struct multi_instance *mi = (struct multi_instance *) he->value;
+      if (!mi->halt)
+        {
+	  send_control_channel_string (&mi->context, next_server ? "RESTART,[N]" : "RESTART", D_PUSH);
+	  multi_schedule_context_wakeup(m, mi);
+        }
+    }
+  hash_iterator_free (&hi);
+
+  /* reschedule signal */
+  ASSERT (!openvpn_gettimeofday (&m->deferred_shutdown_signal.wakeup, NULL));
+  tv.tv_sec = 2;
+  tv.tv_usec = 0;
+  tv_add (&m->deferred_shutdown_signal.wakeup, &tv);
+
+  m->deferred_shutdown_signal.signal_received = m->top.sig->signal_received;
+
+  schedule_add_entry (m->schedule,
+		      (struct schedule_entry *) &m->deferred_shutdown_signal,
+		      &m->deferred_shutdown_signal.wakeup,
+		      compute_wakeup_sigma (&m->deferred_shutdown_signal.wakeup));
+
+  m->top.sig->signal_received = 0;
+}
+
 /*
  * Return true if event loop should break,
  * false if it should continue.
@@ -2715,6 +2767,16 @@ multi_process_signal (struct multi_context *m)
       m->top.sig->signal_received = 0;
       return false;
     }
+#ifdef ENABLE_OCC
+  else if (proto_is_dgram(m->top.options.ce.proto) &&
+      is_exit_restart(m->top.sig->signal_received) &&
+      (m->deferred_shutdown_signal.signal_received == 0) &&
+      m->top.options.ce.explicit_exit_notification != 0)
+    {
+      multi_push_restart_schedule_exit(m, m->top.options.ce.explicit_exit_notification == 2);
+      return false;
+    }
+#endif
   return true;
 }
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 32b89d2..a5745d3 100644
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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index de4fa38..18acb3a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -493,8 +493,9 @@ static const char usage_message[] =
   "                  waiting for a response before trying the next server.\n"
 #endif
 #ifdef ENABLE_OCC
-  "--explicit-exit-notify [n] : On exit/restart, send exit signal to\n"
-  "                  server/remote. n = # of retries, default=1.\n"
+  "--explicit-exit-notify [n] : On exit/restart, send exit signal/restart command to\n"
+  "                  server/remote or client. In client mode: n = # of retries, default=1.\n"
+  "                  In server mode: 1 - reconnect to same server, 2 - advance to next server, default=1.\n"
 #endif
 #ifdef ENABLE_CRYPTO
   "\n"
@@ -2020,10 +2021,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
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
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index b9d0c4c..aed0a68 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -105,6 +105,7 @@ server_pushed_signal (struct context *c, const struct buffer *buffer, const bool
 	m = BSTR (&buf);
 
       /* preserve cached passwords? */
+      /* advance to next server? */
       {
 	bool purge = true;
 
@@ -115,6 +116,11 @@ server_pushed_signal (struct context *c, const struct buffer *buffer, const bool
 	      {
 		if (m[i] == 'P')
 		  purge = false;
+		else if (m[i] == 'N')
+		  {
+		    /* next server? */
+		    c->options.no_advance = false;
+		  }
 	      }
 	  }
 	if (purge)
-- 
1.9.1


