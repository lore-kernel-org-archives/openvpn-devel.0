From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:36:56 +0200
Message-Id: <20200810143707.5834-7-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 06/17] Remove a number of check/do_work
 wrapper calls from coarse_timers
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

This indirection is not very helpful in understanding the code
flow. Moving the check to process_coarse_timers and remove the
check function and rename the do_work function to the drop the do_work
as it does no longer serve a purpose

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 166 +++++++++++-------------------------------
 src/openvpn/forward.h |  12 +--
 src/openvpn/status.c  |  13 ----
 src/openvpn/status.h  |   2 -
 4 files changed, 47 insertions(+), 146 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8a0d63f7..7ac878f9 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -138,84 +138,6 @@ check_incoming_control_channel(struct context *c)
 #endif
 }
 
-/*
- * Should we add routes?
- */
-static inline void
-check_add_routes(struct context *c)
-{
-    void check_add_routes_dowork(struct context *c);
-
-    if (event_timeout_trigger(&c->c2.route_wakeup, &c->c2.timeval, ETT_DEFAULT))
-    {
-        check_add_routes_dowork(c);
-    }
-}
-
-/*
- * Should we exit due to inactivity timeout?
- */
-static inline void
-check_inactivity_timeout(struct context *c)
-{
-    void check_inactivity_timeout_dowork(struct context *c);
-
-    if (c->options.inactivity_timeout
-        && event_timeout_trigger(&c->c2.inactivity_interval, &c->c2.timeval, ETT_DEFAULT))
-    {
-        check_inactivity_timeout_dowork(c);
-    }
-}
-
-#if P2MP
-
-static inline void
-check_server_poll_timeout(struct context *c)
-{
-    void check_server_poll_timeout_dowork(struct context *c);
-
-    if (c->options.ce.connect_timeout
-        && event_timeout_trigger(&c->c2.server_poll_interval, &c->c2.timeval, ETT_DEFAULT))
-    {
-        check_server_poll_timeout_dowork(c);
-    }
-}
-
-/*
- * Scheduled exit?
- */
-static inline void
-check_scheduled_exit(struct context *c)
-{
-    void check_scheduled_exit_dowork(struct context *c);
-
-    if (event_timeout_defined(&c->c2.scheduled_exit))
-    {
-        if (event_timeout_trigger(&c->c2.scheduled_exit, &c->c2.timeval, ETT_DEFAULT))
-        {
-            check_scheduled_exit_dowork(c);
-        }
-    }
-}
-#endif /* if P2MP */
-
-/*
- * Should we write timer-triggered status file.
- */
-static inline void
-check_status_file(struct context *c)
-{
-    void check_status_file_dowork(struct context *c);
-
-    if (c->c1.status_output)
-    {
-        if (status_trigger_tv(c->c1.status_output, &c->c2.timeval))
-        {
-            check_status_file_dowork(c);
-        }
-    }
-}
-
 #ifdef ENABLE_FRAGMENT
 /*
  * Should we deliver a datagram fragment to remote?
@@ -232,37 +154,6 @@ check_fragment(struct context *c)
 }
 #endif
 
-#if P2MP
-
-/*
- * see if we should send a push_request in response to --pull
- */
-static inline void
-check_push_request(struct context *c)
-{
-    void check_push_request_dowork(struct context *c);
-
-    if (event_timeout_trigger(&c->c2.push_request_interval, &c->c2.timeval, ETT_DEFAULT))
-    {
-        check_push_request_dowork(c);
-    }
-}
-
-#endif
-
-/*
- * Should we persist our anti-replay packet ID state to disk?
- */
-static inline void
-check_packet_id_persist_flush(struct context *c)
-{
-    if (packet_id_persist_enabled(&c->c1.pid_persist)
-        && event_timeout_trigger(&c->c2.packet_id_persist_interval, &c->c2.timeval, ETT_DEFAULT))
-    {
-        packet_id_persist_save(&c->c1.pid_persist);
-    }
-}
-
 /*
  * Set our wakeup to 0 seconds, so we will be rescheduled
  * immediately.
@@ -410,7 +301,7 @@ check_incoming_control_channel_dowork(struct context *c)
  * Periodically resend PUSH_REQUEST until PUSH message received
  */
 void
-check_push_request_dowork(struct context *c)
+check_push_request(struct context *c)
 {
     send_push_request(c);
 
@@ -521,7 +412,7 @@ check_add_routes_action(struct context *c, const bool errors)
 }
 
 void
-check_add_routes_dowork(struct context *c)
+check_add_routes(struct context *c)
 {
     if (test_routes(c->c1.route_list, c->c1.tuntap))
     {
@@ -559,7 +450,7 @@ check_add_routes_dowork(struct context *c)
  * Should we exit due to inactivity timeout?
  */
 void
-check_inactivity_timeout_dowork(struct context *c)
+check_inactivity_timeout(struct context *c)
 {
     msg(M_INFO, "Inactivity timeout (--inactive), exiting");
     register_signal(c, SIGTERM, "inactive");
@@ -575,7 +466,7 @@ get_server_poll_remaining_time(struct event_timeout *server_poll_timeout)
 #if P2MP
 
 void
-check_server_poll_timeout_dowork(struct context *c)
+check_server_poll_timeout(struct context *c)
 {
     event_timeout_reset(&c->c2.server_poll_interval);
     ASSERT(c->c2.tls_multi);
@@ -605,7 +496,7 @@ schedule_exit(struct context *c, const int n_seconds, const int signal)
  * Scheduled exit?
  */
 void
-check_scheduled_exit_dowork(struct context *c)
+check_scheduled_exit(struct context *c)
 {
     register_signal(c, c->c2.scheduled_exit_signal, "delayed-exit");
 }
@@ -616,7 +507,7 @@ check_scheduled_exit_dowork(struct context *c)
  * Should we write timer-triggered status file.
  */
 void
-check_status_file_dowork(struct context *c)
+check_status_file(struct context *c)
 {
     if (c->c1.status_output)
     {
@@ -761,10 +652,18 @@ process_coarse_timers(struct context *c)
 {
     /* flush current packet-id to file once per 60
     * seconds if --replay-persist was specified */
-    check_packet_id_persist_flush(c);
+    if (packet_id_persist_enabled(&c->c1.pid_persist)
+        && event_timeout_trigger(&c->c2.packet_id_persist_interval, &c->c2.timeval, ETT_DEFAULT))
+    {
+        packet_id_persist_save(&c->c1.pid_persist);
+    }
 
-    /* should we update status file? */
-    check_status_file(c);
+    /* Should we write timer-triggered status file */
+    if (c->c1.status_output
+        && event_timeout_trigger(&c->c1.status_output->et, &c->c2.timeval, ETT_DEFAULT))
+    {
+        check_status_file(c);
+    }
 
     /* process connection establishment items */
     if (event_timeout_trigger(&c->c2.wait_for_connect, &c->c2.timeval, ETT_DEFAULT))
@@ -772,8 +671,11 @@ process_coarse_timers(struct context *c)
         check_connection_established(c);
     }
 #if P2MP
-    /* see if we should send a push_request in response to --pull */
-    check_push_request(c);
+    /* see if we should send a push_request (option --pull) */
+    if (event_timeout_trigger(&c->c2.push_request_interval, &c->c2.timeval, ETT_DEFAULT))
+    {
+        check_push_request(c);
+    }
 #endif
 
 #ifdef PLUGIN_PF
@@ -781,10 +683,18 @@ process_coarse_timers(struct context *c)
 #endif
 
     /* process --route options */
-    check_add_routes(c);
+    if (event_timeout_trigger(&c->c2.route_wakeup, &c->c2.timeval, ETT_DEFAULT))
+    {
+        check_add_routes(c);
+    }
 
     /* possibly exit due to --inactive */
-    check_inactivity_timeout(c);
+    if (c->options.inactivity_timeout
+        && event_timeout_trigger(&c->c2.inactivity_interval, &c->c2.timeval, ETT_DEFAULT))
+    {
+        check_inactivity_timeout(c);
+    }
+
     if (c->sig->signal_received)
     {
         return;
@@ -800,13 +710,19 @@ process_coarse_timers(struct context *c)
 #if P2MP
     if (c->c2.tls_multi)
     {
-        check_server_poll_timeout(c);
+        if (c->options.ce.connect_timeout
+            && event_timeout_trigger(&c->c2.server_poll_interval, &c->c2.timeval, ETT_DEFAULT))
+        {
+            check_server_poll_timeout(c);
+        }
         if (c->sig->signal_received)
         {
             return;
         }
-
-        check_scheduled_exit(c);
+        if (event_timeout_trigger(&c->c2.scheduled_exit, &c->c2.timeval, ETT_DEFAULT))
+        {
+            check_scheduled_exit(c);
+        }
         if (c->sig->signal_received)
         {
             return;
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 635e84ae..114a24e7 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -77,9 +77,9 @@ void check_tls_errors_nco(struct context *c);
 #if P2MP
 void check_incoming_control_channel_dowork(struct context *c);
 
-void check_scheduled_exit_dowork(struct context *c);
+void check_scheduled_exit(struct context *c);
 
-void check_push_request_dowork(struct context *c);
+void check_push_request(struct context *c);
 
 #endif /* P2MP */
 
@@ -90,13 +90,13 @@ void check_fragment_dowork(struct context *c);
 
 void check_connection_established(struct context *c);
 
-void check_add_routes_dowork(struct context *c);
+void check_add_routes(struct context *c);
 
-void check_inactivity_timeout_dowork(struct context *c);
+void check_inactivity_timeout(struct context *c);
 
-void check_server_poll_timeout_dowork(struct context *c);
+void check_server_poll_timeout(struct context *c);
 
-void check_status_file_dowork(struct context *c);
+void check_status_file(struct context *c);
 
 void io_wait_dowork(struct context *c, const unsigned int flags);
 
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 91391d1a..e8dcf7cd 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -146,19 +146,6 @@ status_trigger(struct status_output *so)
     }
 }
 
-bool
-status_trigger_tv(struct status_output *so, struct timeval *tv)
-{
-    if (so)
-    {
-        return event_timeout_trigger(&so->et, tv, ETT_DEFAULT);
-    }
-    else
-    {
-        return false;
-    }
-}
-
 void
 status_reset(struct status_output *so)
 {
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index 2a399d7d..66e5bc53 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -69,8 +69,6 @@ struct status_output *status_open(const char *filename,
                                   const struct virtual_output *vout,
                                   const unsigned int flags);
 
-bool status_trigger_tv(struct status_output *so, struct timeval *tv);
-
 bool status_trigger(struct status_output *so);
 
 void status_reset(struct status_output *so);
-- 
2.26.2


