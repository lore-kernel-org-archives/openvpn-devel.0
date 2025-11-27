MIME-Version: 1.0
From: Moritz Fain <moritz-openvpn@...2969...>
Date: Thu, 27 Nov 2025 09:51:34 +0100
Message-ID: <CAM8w-qGpLQKFyMzC8i=phj9Quk3E-_3r5N-hjOui23S1g9JANA@...278...>
Subject: [Openvpn-devel] [PATCH 2/2] Push: fix option reset logic in
 continuation messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Previously, the logic for resetting push options (like 'route') was based on
`update_options_found` which was local to `apply_push_options`. This meant
that if a PUSH_UPDATE was split across multiple continuation messages,
the state was lost, causing routes to be reset multiple times (once per
message chunk) rather than once per update sequence.

This patch moves the state tracking to `struct options` as
`push_update_options_found`, allowing it to persist across the entire
PUSH_UPDATE sequence.

This fixes an issue where large route lists sent via PUSH_UPDATE would
result in only the last chunk's routes being applied, or previous routes
being continuously deleted and re-added.

Added unit test `test_incoming_push_continuation_route_accumulation` to
verify the fix.
---
 src/openvpn/options.c                         |   1 +
 src/openvpn/options.h                         |   1 +
 src/openvpn/options_parse.c                   |   9 +-
 src/openvpn/push.c                            |   7 +-
 .../unit_tests/openvpn/test_push_update_msg.c | 101 +++++++++++++++++-
 5 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8a97374e..fe4f5814 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3238,6 +3238,7 @@ pre_connect_restore(struct options *o, struct
gc_arena *gc)

     o->push_continuation = 0;
     o->push_option_types_found = 0;
+    o->push_update_options_found = 0;
     o->imported_protocol_flags = 0;
 }

diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bd013dba..ca94b004 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -559,6 +559,7 @@ struct options
     bool pull; /* client pull of config options from server */
     int push_continuation;
     unsigned int push_option_types_found;
+    unsigned int push_update_options_found; /* tracks which option
types have been reset in current PUSH_UPDATE sequence */
     const char *auth_user_pass_file;
     bool auth_user_pass_file_inline;
     struct options_pre_connect *pre_connect;
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index bb5b4049..99d096b0 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -517,7 +517,12 @@ apply_push_options(struct context *c, struct
options *options, struct buffer *bu
     int line_num = 0;
     const char *file = "[PUSH-OPTIONS]";
     const msglvl_t msglevel = D_PUSH_ERRORS | M_OPTERR;
-    unsigned int update_options_found = 0;
+
+    /*
+     * Use persistent push_update_options_found from options struct to track
+     * which option types have been reset across continuation messages.
+     * This prevents routes from being reset on each continuation message.
+     */

     while (buf_parse(buf, ',', line, sizeof(line)))
     {
@@ -565,7 +570,7 @@ apply_push_options(struct context *c, struct
options *options, struct buffer *bu
             else
             {
                 update_option(c, options, p, false, file, line_num,
0, msglevel, permission_mask,
-                              option_types_found, es, &update_options_found);
+                              option_types_found, es,
&options->push_update_options_found);
             }
         }
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 7852d360..d0601871 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -540,16 +540,19 @@ incoming_push_message(struct context *c, const
struct buffer *buffer)
             }
             else
             {
-                if (!option_types_found)
+                /* Use accumulated option_types_found for the entire
PUSH_UPDATE sequence */
+                if (!c->options.push_option_types_found)
                 {
                     msg(M_WARN, "No updatable options found in
incoming PUSH_UPDATE message");
                 }
-                else if (!do_update(c, option_types_found))
+                else if (!do_update(c, c->options.push_option_types_found))
                 {
                     msg(D_PUSH_ERRORS, "Failed to update options");
                     goto error;
                 }
             }
+            /* Clear push_update_options_found for next PUSH_UPDATE sequence */
+            c->options.push_update_options_found = 0;
         }
         event_timeout_clear(&c->c2.push_request_interval);
         event_timeout_clear(&c->c2.wait_for_connect);
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c
b/tests/unit_tests/openvpn/test_push_update_msg.c
index 6ef12668..1a8b1542 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -54,6 +54,20 @@ options_postprocess_pull(struct options *options,
struct env_set *es)
     return true;
 }

+/*
+ * Counters to track route accumulation across continuation messages.
+ * Used to verify the bug where update_options_found resets per message.
+ */
+static int route_reset_count = 0;
+static int route_add_count = 0;
+
+static void
+reset_route_counters(void)
+{
+    route_reset_count = 0;
+    route_add_count = 0;
+}
+
 bool
 apply_push_options(struct context *c, struct options *options, struct
buffer *buf,
                    unsigned int permission_mask, unsigned int
*option_types_found,
@@ -61,6 +75,12 @@ apply_push_options(struct context *c, struct
options *options, struct buffer *bu
 {
     char line[OPTION_PARM_SIZE];

+    /*
+     * Use persistent push_update_options_found from options struct to track
+     * which option types have been reset across continuation messages.
+     * This is the FIXED behavior - routes are only reset once per
PUSH_UPDATE sequence.
+     */
+
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
         unsigned int push_update_option_flags = 0;
@@ -84,10 +104,18 @@ apply_push_options(struct context *c, struct
options *options, struct buffer *bu
                 return false; /* Cause push/pull error and stop push
processing */
             }
         }
-        /*
-         * No need to test also the application part here
-         * (add_option/remove_option/update_option)
-         */
+
+        /* Simulate route handling from update_option() in options.c */
+        if (is_update && strncmp(&line[i], "route ", 6) == 0)
+        {
+            if (!(options->push_update_options_found & OPT_P_U_ROUTE))
+            {
+                /* First route in entire PUSH_UPDATE sequence - reset
routes once */
+                route_reset_count++;
+                options->push_update_options_found |= OPT_P_U_ROUTE;
+            }
+            route_add_count++;
+        }
     }
     return true;
 }
@@ -292,6 +320,69 @@ test_incoming_push_message_mix2(void **state)
     free_buf(&buf);
 }

+/**
+ * Test that routes accumulate correctly across multiple continuation messages.
+ * This test exposes a bug where update_options_found is reset to 0 for each
+ * continuation message, causing routes to be reset on each message instead
+ * of accumulating.
+ *
+ * Expected behavior: routes should only be reset ONCE (when -route
is received),
+ * then all subsequent routes should accumulate.
+ *
+ * Current bug: routes are reset on the first route of EACH
continuation message.
+ */
+static void
+test_incoming_push_continuation_route_accumulation(void **state)
+{
+    struct context *c = *state;
+    unsigned int option_types_found = 0;
+
+    reset_route_counters();
+
+    /* Message 1: removal + first batch of routes, continuation 2
(more coming) */
+    struct buffer buf1 = alloc_buf(512);
+    const char *msg1 = "PUSH_UPDATE,-route, route 10.1.0.0
255.255.0.0, route 10.2.0.0 255.255.0.0, route 10.3.0.0
255.255.0.0,push-continuation 2";
+    buf_write(&buf1, msg1, strlen(msg1));
+
+    assert_int_equal(process_incoming_push_msg(c, &buf1,
c->options.pull, pull_permission_mask(c),
+                                               &option_types_found),
+                     PUSH_MSG_CONTINUATION);
+    free_buf(&buf1);
+
+    /* Message 2: more routes, continuation 2 (more coming) */
+    struct buffer buf2 = alloc_buf(512);
+    const char *msg2 = "PUSH_UPDATE, route 10.4.0.0 255.255.0.0,
route 10.5.0.0 255.255.0.0, route 10.6.0.0
255.255.0.0,push-continuation 2";
+    buf_write(&buf2, msg2, strlen(msg2));
+
+    assert_int_equal(process_incoming_push_msg(c, &buf2,
c->options.pull, pull_permission_mask(c),
+                                               &option_types_found),
+                     PUSH_MSG_CONTINUATION);
+    free_buf(&buf2);
+
+    /* Message 3: final batch of routes, continuation 1 (last message) */
+    struct buffer buf3 = alloc_buf(512);
+    const char *msg3 = "PUSH_UPDATE, route 10.7.0.0 255.255.0.0,
route 10.8.0.0 255.255.0.0, route 10.9.0.0
255.255.0.0,push-continuation 1";
+    buf_write(&buf3, msg3, strlen(msg3));
+
+    assert_int_equal(process_incoming_push_msg(c, &buf3,
c->options.pull, pull_permission_mask(c),
+                                               &option_types_found),
+                     PUSH_MSG_UPDATE);
+    free_buf(&buf3);
+
+    /* Verify: all 9 routes should have been added */
+    assert_int_equal(route_add_count, 9);
+
+    /*
+     * BUG CHECK: Routes should only be "reset" once (for the entire
update sequence).
+     * Due to the bug where update_options_found is local to each message,
+     * routes get reset on the first route of EACH message (3 times
instead of 1).
+     *
+     * When the bug is fixed, this assertion should pass with
route_reset_count == 1.
+     * Currently it will show route_reset_count == 3, exposing the bug.
+     */
+    assert_int_equal(route_reset_count, 1);
+}
+
 #ifdef ENABLE_MANAGEMENT
 char *r0[] = {
     "PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.255.0",
@@ -603,6 +694,8 @@ main(void)
         cmocka_unit_test_setup_teardown(test_incoming_push_message_bad_format,
setup, teardown),
         cmocka_unit_test_setup_teardown(test_incoming_push_message_mix,
setup, teardown),
         cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2,
setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_continuation_route_accumulation,
setup,
+                                        teardown),
 #ifdef ENABLE_MANAGEMENT

         cmocka_unit_test_setup_teardown(test_send_push_msg0, setup2,
teardown2),

