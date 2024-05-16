From: Gert Doering <gert@...1296...>
Date: Thu, 16 May 2024 13:58:08 +0200
Message-ID: <20240516120434.23499-1-gert@...1296...>
In-Reply-To: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
References: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Only schedule_exit() once
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

This patch was assigned a CVE number after already reviewed and ACKed,
because it was discovered that a misbehaving client can use the (now
fixed) server behaviour to avoid being disconnected by means of a
managment interface "client-kill" command - the security issue here is
"client can circumvent security policy set by management interface".

This only affects previously authenticated clients, and only management
client-kill, so normal renegotion / AUTH_FAIL ("your session ends") is not
affected.

CVE: 2024-28882

Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661
Signed-off-by: Reynir Björnsson <reynir@...2756...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/555
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8d10f25..01165b2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -514,17 +514,24 @@
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
+    if (event_timeout_defined(&c->c2.scheduled_exit))
+    {
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
index 1b406b9..17e7e80 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -204,7 +204,11 @@
      * */
     if (c->options.mode == MODE_SERVER)
     {
-        schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
+        if (!schedule_exit(c))
+	{
+		/* Return early when we don't need to notify management */
+		return;
+	}
     }
     else
     {
@@ -391,7 +395,7 @@
 void
 send_auth_failed(struct context *c, const char *client_reason)
 {
-    if (event_timeout_defined(&c->c2.scheduled_exit))
+    if (!schedule_exit(c))
     {
         msg(D_TLS_DEBUG, "exit already scheduled for context");
         return;
@@ -401,8 +405,6 @@
     static const char auth_failed[] = "AUTH_FAILED";
     size_t len;
 
-    schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
-
     len = (client_reason ? strlen(client_reason)+1 : 0) + sizeof(auth_failed);
     if (len > PUSH_BUNDLE_SIZE)
     {
@@ -492,7 +494,7 @@
 void
 send_restart(struct context *c, const char *kill_msg)
 {
-    schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
+    schedule_exit(c);
     send_control_channel_string(c, kill_msg ? kill_msg : "RESTART", D_PUSH);
 }
 

