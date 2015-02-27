From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 27 Feb 2015 19:01:27 +0200
Message-Id: <1425056487-27492-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Notify clients about server's
	restart/shutdown
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

When server gets shutdown signal (SIGUSR1, SIGTERM, SIGHUP, SIGINT), it
broadcasts new OCC_SHUTTING_DOWN command to all clients and reschedules
received signal in 2 secs.

When client receives OCC_SHUTTING_DOWN, it fires SIGUSR1 and switches to
the next remote.
---
 src/openvpn/multi.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++----
 src/openvpn/multi.h | 14 +++++++++++-
 src/openvpn/occ.c   |  8 +++++++
 src/openvpn/occ.h   |  6 +++++
 4 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4412491..b5f2dd2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -396,6 +396,8 @@ multi_init (struct multi_context *m, struct context *t, bool tcp_mode, int threa
         t->options.stale_routes_check_interval, t->options.stale_routes_ageing_time);
       event_timeout_init (&m->stale_routes_check_et, t->options.stale_routes_check_interval, 0);
     }
+
+  m->deferred_signal.signal_received = 0;
 }
 
 const char *
@@ -603,6 +605,25 @@ multi_close_instance (struct multi_context *m,
   perf_pop ();
 }
 
+void
+multi_broadcast_shutdown (struct multi_context *m)
+{
+  msg (D_LOW, "multi_broadcast_shutdown");
+
+  struct gc_arena gc = gc_new ();
+  struct buffer buf = alloc_buf_gc (BUF_SIZE (&m->top.c2.frame), &gc);
+
+  buf_init (&buf, FRAME_HEADROOM (&m->top.c2.frame));
+  buf_safe (&buf, MAX_RW_SIZE_TUN (&m->top.c2.frame));
+  buf_write (&buf, occ_magic, OCC_STRING_SIZE);
+
+  buf_write_u8 (&buf, OCC_SHUTTING_DOWN);
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
+      if (m->earliest_wakeup == (struct multi_instance*)&m->deferred_signal)
+	{
+	  schedule_remove_entry(m->schedule, (struct schedule_entry*) &m->deferred_signal);
+	  throw_signal(m->deferred_signal.signal_received);
+        }
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
@@ -2699,6 +2728,10 @@ multi_top_free (struct multi_context *m)
   free_context_buffers (m->top.c2.buffers);
 }
 
+bool is_shutdown_signal(int sig) {
+    return (sig == SIGUSR1 || sig == SIGTERM || sig == SIGHUP || sig == SIGINT);
+}
+
 /*
  * Return true if event loop should break,
  * false if it should continue.
@@ -2714,6 +2747,28 @@ multi_process_signal (struct multi_context *m)
       m->top.sig->signal_received = 0;
       return false;
     }
+  else if (proto_is_dgram(m->top.options.ce.proto) &&
+      is_shutdown_signal(m->top.sig->signal_received) &&
+      (m->deferred_signal.signal_received == 0))
+    {
+      // broadcast OCC_SHUTTING_DOWN to all connected clients
+      multi_broadcast_shutdown(m);
+
+      // schedule signal
+      openvpn_gettimeofday (&m->deferred_signal.wakeup, NULL);
+      struct timeval tv;
+      tv.tv_sec = 2;
+      tv.tv_usec = 0;
+      tv_add (&m->deferred_signal.wakeup, &tv);
+
+      m->deferred_signal.signal_received = m->top.sig->signal_received;
+
+      schedule_add_entry (m->schedule, (struct schedule_entry *) &m->deferred_signal,
+      		      &m->deferred_signal.wakeup, compute_wakeup_sigma (&m->deferred_signal.wakeup));
+
+      m->top.sig->signal_received = 0;
+      return false;
+  }
   return true;
 }
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 32b89d2..c9c1940 100644
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
+  struct deferred_signal_schedule_entry deferred_signal;
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
index ff48706..3695b07 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -390,6 +390,14 @@ process_received_occ_msg (struct context *c)
       c->sig->signal_received = SIGTERM;
       c->sig->signal_text = "remote-exit";
       break;
+
+    case OCC_SHUTTING_DOWN:
+      msg (D_LOW, "RECEIVED OCC_SHUTTING_DOWN");
+      c->sig->signal_received = SIGUSR1;
+      c->sig->signal_text = "remote-shutdown";
+      c->options.no_advance = false;
+      break;
+
     }
   c->c2.buf.len = 0; /* don't pass packet on */
 }
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 5d88cc9..0d10f2e 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -69,6 +69,12 @@
  */
 #define OCC_EXIT               6
 
+
+/*
+ * Notifies clients that server is shutting down
+ */
+#define OCC_SHUTTING_DOWN      7
+
 /*
  * Used to conduct a load test command sequence
  * of UDP connection for empirical MTU measurement.
-- 
1.9.1


