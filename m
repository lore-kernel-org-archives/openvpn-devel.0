From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 17 Nov 2015 11:33:47 +0200
Message-Id: <1447752827-16720-1-git-send-email-lstipakov@...277...>
In-Reply-To: <56499CB2.9020405@...277...>
References: <56499CB2.9020405@...277...>
Subject: [Openvpn-devel] [PATCH v4] Notify clients about server's
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
explicit-exit-notify is set, server sends RESTART control channel
command to all clients and reschedules received signal in 2 secs.

When client receives RESTART command, it either reconnects to the same
server or advances to the new one, depends on parameter comes with
RESTART command - behavior is controlled by explicit-exit-notify in the
server config.

v4:
- Rebase on top of master
- Remove #ifdef ENABLE_OCC around connection_entry->explicit_exit_notification
since it is also used outside of OCC context
- Update usage message

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
 src/openvpn/multi.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++++---
 src/openvpn/multi.h   |  9 +++++++
 src/openvpn/options.c |  7 +++---
 src/openvpn/options.h |  4 +---
 src/openvpn/push.c    |  6 +++++
 6 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2978b7f..dfb63fc 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3886,8 +3886,19 @@ option will tell the server to immediately close its client instance object
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
index 7c3aaac..e153be7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -429,6 +429,8 @@ multi_init (struct multi_context *m, struct context *t, bool tcp_mode, int threa
         t->options.stale_routes_check_interval, t->options.stale_routes_ageing_time);
       event_timeout_init (&m->stale_routes_check_et, t->options.stale_routes_check_interval, 0);
     }
+
+  m->deferred_shutdown_signal.signal_received = 0;
 }
 
 const char *
@@ -2721,10 +2723,18 @@ multi_process_timeout (struct multi_context *m, const unsigned int mpp_flags)
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
@@ -2849,6 +2859,48 @@ multi_top_free (struct multi_context *m)
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
@@ -2864,6 +2916,14 @@ multi_process_signal (struct multi_context *m)
       m->top.sig->signal_received = 0;
       return false;
     }
+  else if (proto_is_dgram(m->top.options.ce.proto) &&
+      is_exit_restart(m->top.sig->signal_received) &&
+      (m->deferred_shutdown_signal.signal_received == 0) &&
+      m->top.options.ce.explicit_exit_notification != 0)
+    {
+      multi_push_restart_schedule_exit(m, m->top.options.ce.explicit_exit_notification == 2);
+      return false;
+    }
   return true;
 }
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 69ed85e..ec1e7ab 100644
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
@@ -181,6 +188,8 @@ struct multi_context {
   /* mapping between inotify watch descriptors and multi_instances */
   struct hash *inotify_watchers;
 #endif
+
+  struct deferred_signal_schedule_entry deferred_shutdown_signal;
 };
 
 /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 901d710..1c522b8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -469,6 +469,9 @@ static const char usage_message[] =
   "--stale-routes-check n [t] : Remove routes with a last activity timestamp\n"
   "                             older than n seconds. Run this check every t\n"
   "                             seconds (defaults to n).\n"
+  "--explicit-exit-notify [n] : In UDP server mode send [RESTART] command on exit/restart to connected\n"
+  "                             clients. n = 1 - reconnect to same server,\n"
+  "                             2 - advance to next server, default=1.\n"
 #if PORT_SHARE
   "--port-share host port [dir] : When run in TCP mode, proxy incoming HTTPS\n"
   "                  sessions to a web server at host:port.  dir specifies an\n"
@@ -2020,10 +2023,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
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
index c642aa0..d1333d3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -118,9 +118,7 @@ struct connection_entry
   int mssfix;            /* Upper bound on TCP MSS */
   bool mssfix_default;   /* true if --mssfix was supplied without a parameter */
 
-#ifdef ENABLE_OCC
-  int explicit_exit_notification;  /* Explicitly tell peer when we are exiting via OCC_EXIT message */
-#endif
+  int explicit_exit_notification;  /* Explicitly tell peer when we are exiting via OCC_EXIT or [RESTART] message */
 
 # define CE_DISABLED (1<<0)
 # define CE_MAN_QUERY_PROXY (1<<1)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a4cb726..d4f3cb6 100644
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


