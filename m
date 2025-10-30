From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 20:52:35 +0100
Message-ID: <20251030195244.2659-1-gert@...1296...>
In-Reply-To: <gerrit.1761581200000.Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9@...2715...>
References: <gerrit.1761581200000.Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] PUSH_UPDATE server: invalid read bug-fix
 and unit-tests improvements
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

From: Marco Baffo <marco@...2726...>

The number of messages calculated before the call to message_splitter(),
used in the memory allocation in the buffer array, could in certain
cases be less than one than the actual number of messages, thus causing
an override of the sentinel buffer in message_splitter() and therefore
an invalid read in send_single_push_update().
The case in question would be, for example, a sequence of three options
"A,B,C" with the size of B equal to safe_cap - 1 and the sum of the
sizes of A and C less than safe_cap - 2.

The buffer array was therefore replaced with a list of buffers to
completely avoid calculating the number of messages before it was
actually computed.
The test case in question has been added to the unit tests.
The unit tests have been improved using cmocka macros.

Change-Id: Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1316
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1316
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 552679a..51c7b5f 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -91,7 +91,7 @@
  * Return `false` on failure an `true` on success.
  */
 static bool
-message_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, const size_t safe_cap)
+message_splitter(const char *s, struct buffer_list *msgs, struct gc_arena *gc, const size_t safe_cap)
 {
     if (!s || !*s)
     {
@@ -100,7 +100,6 @@
 
     char *str = gc_strdup(s, gc);
     size_t i = 0;
-    int im = 0;
 
     while (*str)
     {
@@ -115,37 +114,38 @@
             }
             str[ci] = '\0';
             /* copy from i to (ci -1) */
-            msgs[im] = forge_msg(str, ",push-continuation 2", gc);
+            struct buffer tmp = forge_msg(str, ",push-continuation 2", gc);
+            buffer_list_push(msgs, BSTR(&tmp));
             i = ci + 1;
         }
         else
         {
-            if (im)
+            if (msgs->head)
             {
-                msgs[im] = forge_msg(str, ",push-continuation 1", gc);
+                struct buffer tmp = forge_msg(str, ",push-continuation 1", gc);
+                buffer_list_push(msgs, BSTR(&tmp));
             }
             else
             {
-                msgs[im] = forge_msg(str, NULL, gc);
+                struct buffer tmp = forge_msg(str, NULL, gc);
+                buffer_list_push(msgs, BSTR(&tmp));
             }
             i = strlen(str);
         }
         str = &str[i];
-        im++;
     }
     return true;
 }
 
 /* send the message(s) prepared to one single client */
 static bool
-send_single_push_update(struct multi_context *m, struct multi_instance *mi, struct buffer *msgs)
+send_single_push_update(struct multi_context *m, struct multi_instance *mi, struct buffer_list *msgs)
 {
-    if (!msgs[0].data || !*(msgs[0].data))
+    if (!msgs->head)
     {
         return false;
     }
 
-    int i = -1;
     unsigned int option_types_found = 0;
     struct context *c = &mi->context;
     struct options o;
@@ -160,9 +160,10 @@
     o.ifconfig_local = canary;
     o.ifconfig_ipv6_local = canary;
 
-    while (msgs[++i].data && *(msgs[i].data))
+    struct buffer_entry *e = msgs->head;
+    while (e)
     {
-        if (!send_control_channel_string(c, BSTR(&msgs[i]), D_PUSH))
+        if (!send_control_channel_string(c, BSTR(&e->buf), D_PUSH))
         {
             return false;
         }
@@ -182,13 +183,14 @@
          * Also we need to make a temporary copy so we can buf_advance()
          * without modifying original buffer.
          */
-        struct buffer tmp_msg = msgs[i];
+        struct buffer tmp_msg = e->buf;
         buf_string_compare_advance(&tmp_msg, push_update_cmd);
         unsigned int permission_mask = pull_permission_mask(c);
         if (process_push_update(c, &o, permission_mask, &option_types_found, &tmp_msg, true) == PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to client ID: %u", c->c2.tls_multi->peer_id);
         }
+        e = e->next;
     }
 
     if (option_types_found & OPT_P_UP)
@@ -270,12 +272,11 @@
      * we want to send exceeds that size we have to split it into smaller messages */
     ASSERT(push_bundle_size > extra);
     const size_t safe_cap = push_bundle_size - extra;
-    size_t msgs_num = (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) != 0);
-    struct buffer *msgs = gc_malloc((msgs_num + 1) * sizeof(struct buffer), true, &gc);
+    struct buffer_list *msgs = buffer_list_new();
 
-    msgs[msgs_num].data = NULL;
     if (!message_splitter(msg, msgs, &gc, safe_cap))
     {
+        buffer_list_free(msgs);
         gc_free(&gc);
         return -EINVAL;
     }
@@ -286,6 +287,7 @@
 
         if (!mi)
         {
+            buffer_list_free(msgs);
             gc_free(&gc);
             return -ENOENT;
         }
@@ -293,6 +295,7 @@
         if (!support_push_update(mi))
         {
             msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi->context.c2.tls_multi->peer_id);
+            buffer_list_free(msgs);
             gc_free(&gc);
             return 0;
         }
@@ -300,11 +303,13 @@
         if (!mi->halt
             && send_single_push_update(m, mi, msgs))
         {
+            buffer_list_free(msgs);
             gc_free(&gc);
             return 1;
         }
         else
         {
+            buffer_list_free(msgs);
             gc_free(&gc);
             return 0;
         }
@@ -334,6 +339,7 @@
     }
 
     hash_iterator_free(&hi);
+    buffer_list_free(msgs);
     gc_free(&gc);
     return count;
 }
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 516e94c..6ef1266 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -130,18 +130,11 @@
     return true;
 }
 #else  /* ifndef ENABLE_MANAGEMENT */
-char **res;
-int i;
 
 bool
 send_control_channel_string(struct context *c, const char *str, msglvl_t msglevel)
 {
-    if (res && res[i] && strcmp(res[i], str))
-    {
-        printf("\n\nexpected: %s\n\n  actual: %s\n\n", res[i], str);
-        return false;
-    }
-    i++;
+    check_expected(str);
     return true;
 }
 
@@ -301,44 +294,75 @@
 
 #ifdef ENABLE_MANAGEMENT
 char *r0[] = {
-    "PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.255.0"
+    "PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.255.0",
+    NULL
 };
 char *r1[] = {
     "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redirect-gateway local,push-continuation 2",
-    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0,push-continuation 1"
+    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0,push-continuation 1",
+    NULL
 };
 char *r3[] = {
-    "PUSH_UPDATE,,,"
+    "PUSH_UPDATE,,,",
+    NULL
 };
 char *r4[] = {
     "PUSH_UPDATE,-dhcp-option, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local,push-continuation 2",
-    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1"
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1",
+    NULL
 };
 char *r5[] = {
     "PUSH_UPDATE,,-dhcp-option, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local,push-continuation 2",
-    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,push-continuation 1"
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,push-continuation 1",
+    NULL
 };
 char *r6[] = {
     "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8, redirect-gateway 10.10.10.10,,push-continuation 2",
-    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1"
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1",
+    NULL
 };
 char *r7[] = {
     "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,push-continuation 2",
-    "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,push-continuation 1"
+    "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,push-continuation 1",
+    NULL
 };
 char *r8[] = {
     "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redirect-gateway\n local,push-continuation 2",
-    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0\n\n\n,push-continuation 1"
+    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0\n\n\n,push-continuation 1",
+    NULL
 };
 char *r9[] = {
-    "PUSH_UPDATE,,"
+    "PUSH_UPDATE,,",
+    NULL
 };
-
+char *r11[] = {
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 1",
+    NULL
+};
+char *r12[] = {
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,push-continuation 2",
+    "PUSH_UPDATE,abc,push-continuation 1",
+    NULL
+};
+char *r13[] = {
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,",
+    NULL
+};
+char *r14[] = {
+    "PUSH_UPDATE,a,push-continuation 2",
+    "PUSH_UPDATE,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,push-continuation 2",
+    "PUSH_UPDATE,a,push-continuation 1",
+    NULL
+};
 
 const char *msg0 = "redirect-gateway local,route 192.168.1.0 255.255.255.0";
 const char *msg1 = "-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,"
@@ -365,32 +389,50 @@
                     "daisy damage damp dance danger daring dash daughter dawn day deal debate debris decade december decide decline"
                     "decorate decrease deer defense define defy degree delay deliver demand demise denial";
 
+const char *msg11 = "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a";
+
+const char *msg12 = "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,abc";
+
+const char *msg13 = "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,";
+
+const char *msg14 = "a,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,a";
+
 #define PUSH_BUNDLE_SIZE_TEST 184
 
+#define expect_control_channel_strings(res)                          \
+    do                                                               \
+    {                                                                \
+        for (int j = 0; res[j] != NULL; j++)                         \
+        {                                                            \
+            expect_string(send_control_channel_string, str, res[j]); \
+        }                                                            \
+    } while (0)
+
 static void
 test_send_push_msg0(void **state)
 {
-    i = 0;
-    res = r0;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
+    expect_control_channel_strings(r0);
     assert_int_equal(send_push_update(m, &cid, msg0, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
 }
+
 static void
 test_send_push_msg1(void **state)
 {
-    i = 0;
-    res = r1;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
+    expect_control_channel_strings(r1);
     assert_int_equal(send_push_update(m, &cid, msg1, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
 }
 
 static void
 test_send_push_msg2(void **state)
 {
-    i = 0;
-    res = NULL;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
     assert_int_equal(send_push_update(m, &cid, msg2, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), -EINVAL);
@@ -399,83 +441,110 @@
 static void
 test_send_push_msg3(void **state)
 {
-    i = 0;
-    res = r3;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
+    expect_control_channel_strings(r3);
     assert_int_equal(send_push_update(m, &cid, msg3, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
 }
 
 static void
 test_send_push_msg4(void **state)
 {
-    i = 0;
-    res = r4;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
+    expect_control_channel_strings(r4);
     assert_int_equal(send_push_update(m, &cid, msg4, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
 }
 
 static void
 test_send_push_msg5(void **state)
 {
-    i = 0;
-    res = r5;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
+    expect_control_channel_strings(r5);
     assert_int_equal(send_push_update(m, &cid, msg5, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
 }
 
 static void
 test_send_push_msg6(void **state)
 {
-    i = 0;
-    res = r6;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
+    expect_control_channel_strings(r6);
     assert_int_equal(send_push_update(m, &cid, msg6, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
 }
 
 static void
 test_send_push_msg7(void **state)
 {
-    i = 0;
-    res = r7;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
+    expect_control_channel_strings(r7);
     assert_int_equal(send_push_update(m, &cid, msg7, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
 }
 
 static void
 test_send_push_msg8(void **state)
 {
-    i = 0;
-    res = r8;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
+    expect_control_channel_strings(r8);
     assert_int_equal(send_push_update(m, &cid, msg8, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
 }
 
 static void
 test_send_push_msg9(void **state)
 {
-    i = 0;
-    res = r9;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
+    expect_control_channel_strings(r9);
     assert_int_equal(send_push_update(m, &cid, msg9, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
 }
 
 static void
 test_send_push_msg10(void **state)
 {
-    i = 0;
-    res = NULL;
     struct multi_context *m = *state;
     const unsigned long cid = 0;
     assert_int_equal(send_push_update(m, &cid, msg10, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), -EINVAL);
 }
 
+static void
+test_send_push_msg11(void **state)
+{
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    expect_control_channel_strings(r11);
+    assert_int_equal(send_push_update(m, &cid, msg11, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg12(void **state)
+{
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    expect_control_channel_strings(r12);
+    assert_int_equal(send_push_update(m, &cid, msg12, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg13(void **state)
+{
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    expect_control_channel_strings(r13);
+    assert_int_equal(send_push_update(m, &cid, msg13, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg14(void **state)
+{
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    expect_control_channel_strings(r14);
+    assert_int_equal(send_push_update(m, &cid, msg14, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
 #undef PUSH_BUNDLE_SIZE_TEST
 
 static int
@@ -535,6 +604,7 @@
         cmocka_unit_test_setup_teardown(test_incoming_push_message_mix, setup, teardown),
         cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, setup, teardown),
 #ifdef ENABLE_MANAGEMENT
+
         cmocka_unit_test_setup_teardown(test_send_push_msg0, setup2, teardown2),
         cmocka_unit_test_setup_teardown(test_send_push_msg1, setup2, teardown2),
         cmocka_unit_test_setup_teardown(test_send_push_msg2, setup2, teardown2),
@@ -545,7 +615,11 @@
         cmocka_unit_test_setup_teardown(test_send_push_msg7, setup2, teardown2),
         cmocka_unit_test_setup_teardown(test_send_push_msg8, setup2, teardown2),
         cmocka_unit_test_setup_teardown(test_send_push_msg9, setup2, teardown2),
-        cmocka_unit_test_setup_teardown(test_send_push_msg10, setup2, teardown2)
+        cmocka_unit_test_setup_teardown(test_send_push_msg10, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg11, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg12, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg13, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg14, setup2, teardown2)
 #endif
     };
 

