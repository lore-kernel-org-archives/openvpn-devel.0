From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 25 Apr 2024 17:50:07 +0200
Message-Id: <20240425155007.62606-1-frank@...2641...>
In-Reply-To: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
References: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Only schedule_exit() once
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?q?Reynir=20Bj=C3=B6rnsson?= <reynir@...2756...>

From: Reynir Björnsson <reynir@...2756...>

If an exit has already been scheduled we should not schedule it again.
Otherwise, the exit signal is never emitted if the peer reschedules the
exit before the timeout occurs.

schedule_exit() now only takes the context as argument. The signal is
hard coded to SIGTERM, and the interval is read directly from the
context options.

Furthermore, schedule_exit() now returns a bool signifying whether an
exit was scheduled; false if exit is already scheduled. The call sites
are updated accordingly. A notable difference is that management is only
notified *once* when an exit is scheduled - we no longer notify
management on redundant exit.

Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661
Signed-off-by: Reynir Björnsson <reynir@...2756...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/555
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8d10f25..937fae4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -514,17 +514,23 @@
 }
 
 /*
- * Schedule a signal n_seconds from now.
+ * Schedule a SIGTERM signal c->options.scheduled_exit_interval seconds from now.
  */
-void
-schedule_exit(struct context *c, const int n_seconds, const int signal)
+bool
+schedule_exit(struct context *c)
 {
+    const int n_seconds = c->options.scheduled_exit_interval;
+    /* don't reschedule if already scheduled. */
+    if (event_timeout_defined(&c->c2.scheduled_exit)) {
+        return false;
+    }
     tls_set_single_session(c->c2.tls_multi);
     update_time();
     reset_coarse_timers(c);
     event_timeout_init(&c->c2.scheduled_exit, n_seconds, now);
-    c->c2.scheduled_exit_signal = signal;
+    c->c2.scheduled_exit_signal = SIGTERM;
     msg(D_SCHED_EXIT, "Delayed exit in %d seconds", n_seconds);
+    return true;
 }
 
 /*
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 6fb5a18..422c591 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -303,7 +303,7 @@
 
 void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf);
 
-void schedule_exit(struct context *c, const int n_seconds, const int signal);
+bool schedule_exit(struct context *c);
 
 static inline struct link_socket_info *
 get_link_socket_info(struct context *c)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 1b406b9..db1fd2e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -191,6 +191,7 @@
 receive_exit_message(struct context *c)
 {
     dmsg(D_STREAM_ERRORS, "CC-EEN exit message received by peer");
+    bool notify_management = true;
     /* With control channel exit notification, we want to give the session
      * enough time to handle retransmits and acknowledgment, so that eventual
      * retries from the client to resend the exit or ACKs will not trigger
@@ -204,14 +205,14 @@
      * */
     if (c->options.mode == MODE_SERVER)
     {
-        schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
+        notify_management = schedule_exit(c);
     }
     else
     {
         register_signal(c->sig, SIGUSR1, "remote-exit");
     }
 #ifdef ENABLE_MANAGEMENT
-    if (management)
+    if (management && notify_management)
     {
         management_notify(management, "info", "remote-exit", "EXIT");
     }
@@ -391,7 +392,7 @@
 void
 send_auth_failed(struct context *c, const char *client_reason)
 {
-    if (event_timeout_defined(&c->c2.scheduled_exit))
+    if (!schedule_exit(c))
     {
         msg(D_TLS_DEBUG, "exit already scheduled for context");
         return;
@@ -401,8 +402,6 @@
     static const char auth_failed[] = "AUTH_FAILED";
     size_t len;
 
-    schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
-
     len = (client_reason ? strlen(client_reason)+1 : 0) + sizeof(auth_failed);
     if (len > PUSH_BUNDLE_SIZE)
     {
@@ -492,7 +491,7 @@
 void
 send_restart(struct context *c, const char *kill_msg)
 {
-    schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
+    schedule_exit(c);
     send_control_channel_string(c, kill_msg ? kill_msg : "RESTART", D_PUSH);
 }
 

