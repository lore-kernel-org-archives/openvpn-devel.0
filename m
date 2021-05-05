From: Antonio Quartulli <a@...2181...>
Date: Thu,  6 May 2021 01:12:55 +0200
Message-Id: <20210505231255.1880-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] forward: get rid of useless declarations
 for actually static functions
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

A bunch of functions defined in forward.c and declared in forward.h
are actually used only in forward.c.

For this very reason they don't need to be declared in forward.h at
all and can be defined as static.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/forward.c | 50 +++++++++++++++++++++----------------------
 src/openvpn/forward.h | 34 -----------------------------
 2 files changed, 25 insertions(+), 59 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e302d8e0..270c03c0 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -54,7 +54,7 @@ counter_type link_write_bytes_global; /* GLOBAL */
 
 #ifdef ENABLE_DEBUG
 
-const char *
+static const char *
 wait_status_string(struct context *c, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(64, gc);
@@ -67,7 +67,7 @@ wait_status_string(struct context *c, struct gc_arena *gc)
     return BSTR(&out);
 }
 
-void
+static void
 show_wait_status(struct context *c)
 {
     struct gc_arena gc = gc_new();
@@ -77,6 +77,19 @@ show_wait_status(struct context *c)
 
 #endif /* ifdef ENABLE_DEBUG */
 
+static void
+check_tls_errors_co(struct context *c)
+{
+    msg(D_STREAM_ERRORS, "Fatal TLS error (check_tls_errors_co), restarting");
+    register_signal(c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
+}
+
+static void
+check_tls_errors_nco(struct context *c)
+{
+    register_signal(c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
+}
+
 /*
  * TLS errors are fatal in TCP mode.
  * Also check for --tls-exit trigger.
@@ -138,7 +151,7 @@ context_reschedule_sec(struct context *c, int sec)
  * traffic on the control-channel.
  *
  */
-void
+static void
 check_tls(struct context *c)
 {
     interval_t wakeup = BIG_TIMEOUT;
@@ -176,24 +189,11 @@ check_tls(struct context *c)
     }
 }
 
-void
-check_tls_errors_co(struct context *c)
-{
-    msg(D_STREAM_ERRORS, "Fatal TLS error (check_tls_errors_co), restarting");
-    register_signal(c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
-}
-
-void
-check_tls_errors_nco(struct context *c)
-{
-    register_signal(c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
-}
-
 /*
  * Handle incoming configuration
  * messages on the control channel.
  */
-void
+static void
 check_incoming_control_channel(struct context *c)
 {
     int len = tls_test_payload_len(c->c2.tls_multi);
@@ -258,7 +258,7 @@ check_incoming_control_channel(struct context *c)
 /*
  * Periodically resend PUSH_REQUEST until PUSH message received
  */
-void
+static void
 check_push_request(struct context *c)
 {
     send_push_request(c);
@@ -276,7 +276,7 @@ check_push_request(struct context *c)
  * Note: The process_incoming_push_reply currently assumes that this function
  * only sets up the pull request timer when pull is enabled.
  */
-void
+static void
 check_connection_established(struct context *c)
 {
 
@@ -370,7 +370,7 @@ check_add_routes_action(struct context *c, const bool errors)
     initialization_sequence_completed(c, errors ? ISC_ERRORS : 0); /* client/p2p --route-delay was defined */
 }
 
-void
+static void
 check_add_routes(struct context *c)
 {
     if (test_routes(c->c1.route_list, c->c1.tuntap))
@@ -408,7 +408,7 @@ check_add_routes(struct context *c)
 /*
  * Should we exit due to inactivity timeout?
  */
-void
+static void
 check_inactivity_timeout(struct context *c)
 {
     msg(M_INFO, "Inactivity timeout (--inactive), exiting");
@@ -423,7 +423,7 @@ get_server_poll_remaining_time(struct event_timeout *server_poll_timeout)
     return max_int(0, remaining);
 }
 
-void
+static void
 check_server_poll_timeout(struct context *c)
 {
     event_timeout_reset(&c->c2.server_poll_interval);
@@ -453,7 +453,7 @@ schedule_exit(struct context *c, const int n_seconds, const int signal)
 /*
  * Scheduled exit?
  */
-void
+static void
 check_scheduled_exit(struct context *c)
 {
     register_signal(c, c->c2.scheduled_exit_signal, "delayed-exit");
@@ -462,7 +462,7 @@ check_scheduled_exit(struct context *c)
 /*
  * Should we write timer-triggered status file.
  */
-void
+static void
 check_status_file(struct context *c)
 {
     if (c->c1.status_output)
@@ -475,7 +475,7 @@ check_status_file(struct context *c)
 /*
  * Should we deliver a datagram fragment to remote?
  */
-void
+static void
 check_fragment(struct context *c)
 {
     struct link_socket_info *lsi = get_link_socket_info(c);
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 2a67c144..5d7566cf 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -68,44 +68,12 @@ extern counter_type link_read_bytes_global;
 
 extern counter_type link_write_bytes_global;
 
-void check_tls(struct context *c);
-
-void check_tls_errors_co(struct context *c);
-
-void check_tls_errors_nco(struct context *c);
-
-void check_incoming_control_channel(struct context *c);
-
-void check_scheduled_exit(struct context *c);
-
-void check_push_request(struct context *c);
-
-#ifdef ENABLE_FRAGMENT
-void check_fragment(struct context *c);
-
-#endif /* ENABLE_FRAGMENT */
-
-void check_connection_established(struct context *c);
-
-void check_add_routes(struct context *c);
-
-void check_inactivity_timeout(struct context *c);
-
-void check_server_poll_timeout(struct context *c);
-
-void check_status_file(struct context *c);
-
 void io_wait_dowork(struct context *c, const unsigned int flags);
 
 void pre_select(struct context *c);
 
 void process_io(struct context *c);
 
-const char *wait_status_string(struct context *c, struct gc_arena *gc);
-
-void show_wait_status(struct context *c);
-
-
 /**********************************************************************/
 /**
  * Process a data channel packet that will be sent through a VPN tunnel.
@@ -394,8 +362,6 @@ p2p_iow_flags(const struct context *c)
 static inline void
 io_wait(struct context *c, const unsigned int flags)
 {
-    void io_wait_dowork(struct context *c, const unsigned int flags);
-
     if (c->c2.fast_io && (flags & (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))
     {
         /* fast path -- only for TUN/TAP/UDP writes */
-- 
2.26.3


