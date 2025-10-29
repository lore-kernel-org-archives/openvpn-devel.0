From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 13:18:20 +0000
In-Reply-To: <gerrit.1761581200000.Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9@...2715...>
References: <gerrit.1761581200000.Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a0292f94b2271831470d3b2e894bae239662ee24-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IMB1D2axsWQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE server:
 invalid read bug-fix and unit-tests improvements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IMB1D2axsWQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: PUSH_UPDATE server: invalid read bug-fix and unit-tests imp=
rovements
......................................................................

PUSH_UPDATE server: invalid read bug-fix and unit-tests improvements

The number of messages calculated before the call to message_splitter(), us=
ed
in the memory allocation in the buffer array, could in certain cases be less
than one than the actual number of messages, thus causing an override of the
sentinel buffer in message_splitter and therefore an invalid read in
send_single_push_update(). The case in question would be, for example, a
sequence of three options "A, B, C" with the size of B equal to safe_cap - 1
and the sum of the sizes of A and C less than safe_cap - 2.
The buffer array was therefore replaced with a list of buffers to completely
avoid calculating the number of messages before it was actually computed.
The test case in question has been added to the unit tests.
The unit tests have been improved using cmocka macros.

Change-Id: Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/test_push_update_msg.c
2 files changed, 137 insertions(+), 57 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1316/4

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 552679a..51c7b5f 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -91,7 +91,7 @@
  * Return `false` on failure an `true` on success.
  */
 static bool
-message_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, =
const size_t safe_cap)
+message_splitter(const char *s, struct buffer_list *msgs, struct gc_arena =
*gc, const size_t safe_cap)
 {
     if (!s || !*s)
     {
@@ -100,7 +100,6 @@

     char *str =3D gc_strdup(s, gc);
     size_t i =3D 0;
-    int im =3D 0;

     while (*str)
     {
@@ -115,37 +114,38 @@
             }
             str[ci] =3D '\0';
             /* copy from i to (ci -1) */
-            msgs[im] =3D forge_msg(str, ",push-continuation 2", gc);
+            struct buffer tmp =3D forge_msg(str, ",push-continuation 2", g=
c);
+            buffer_list_push(msgs, BSTR(&tmp));
             i =3D ci + 1;
         }
         else
         {
-            if (im)
+            if (msgs->head)
             {
-                msgs[im] =3D forge_msg(str, ",push-continuation 1", gc);
+                struct buffer tmp =3D forge_msg(str, ",push-continuation 1=
", gc);
+                buffer_list_push(msgs, BSTR(&tmp));
             }
             else
             {
-                msgs[im] =3D forge_msg(str, NULL, gc);
+                struct buffer tmp =3D forge_msg(str, NULL, gc);
+                buffer_list_push(msgs, BSTR(&tmp));
             }
             i =3D strlen(str);
         }
         str =3D &str[i];
-        im++;
     }
     return true;
 }

 /* send the message(s) prepared to one single client */
 static bool
-send_single_push_update(struct multi_context *m, struct multi_instance *mi=
, struct buffer *msgs)
+send_single_push_update(struct multi_context *m, struct multi_instance *mi=
, struct buffer_list *msgs)
 {
-    if (!msgs[0].data || !*(msgs[0].data))
+    if (!msgs->head)
     {
         return false;
     }

-    int i =3D -1;
     unsigned int option_types_found =3D 0;
     struct context *c =3D &mi->context;
     struct options o;
@@ -160,9 +160,10 @@
     o.ifconfig_local =3D canary;
     o.ifconfig_ipv6_local =3D canary;

-    while (msgs[++i].data && *(msgs[i].data))
+    struct buffer_entry *e =3D msgs->head;
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
-        struct buffer tmp_msg =3D msgs[i];
+        struct buffer tmp_msg =3D e->buf;
         buf_string_compare_advance(&tmp_msg, push_update_cmd);
         unsigned int permission_mask =3D pull_permission_mask(c);
         if (process_push_update(c, &o, permission_mask, &option_types_foun=
d, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u", c->c2.tls_multi->peer_id);
         }
+        e =3D e->next;
     }

     if (option_types_found & OPT_P_UP)
@@ -270,12 +272,11 @@
      * we want to send exceeds that size we have to split it into smaller =
messages */
     ASSERT(push_bundle_size > extra);
     const size_t safe_cap =3D push_bundle_size - extra;
-    size_t msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_ca=
p) !=3D 0);
-    struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeof(struct buffe=
r), true, &gc);
+    struct buffer_list *msgs =3D buffer_list_new();

-    msgs[msgs_num].data =3D NULL;
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
             msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported=
 peer with ID: %u", mi->context.c2.tls_multi->peer_id);
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
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
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
 send_control_channel_string(struct context *c, const char *str, msglvl_t m=
sglevel)
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
 char *r0[] =3D {
-    "PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.255.0"
+    "PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.255.0",
+    NULL
 };
 char *r1[] =3D {
     "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalala=
lalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redire=
ct-gateway local,push-continuation 2",
-    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0,push-continuation 1"
+    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0,push-continuation 1",
+    NULL
 };
 char *r3[] =3D {
-    "PUSH_UPDATE,,,"
+    "PUSH_UPDATE,,,",
+    NULL
 };
 char *r4[] =3D {
     "PUSH_UPDATE,-dhcp-option, blablalalalalalalalalalalalalf, lalalalalal=
alalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redire=
ct-gateway local,push-continuation 2",
-    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1"
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1",
+    NULL
 };
 char *r5[] =3D {
     "PUSH_UPDATE,,-dhcp-option, blablalalalalalalalalalalalalf, lalalalala=
lalalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redire=
ct-gateway local,push-continuation 2",
-    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,push-continuation 1"
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,push-continuation 1",
+    NULL
 };
 char *r6[] =3D {
     "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalala=
lalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8, redir=
ect-gateway 10.10.10.10,,push-continuation 2",
-    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1"
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1",
+    NULL
 };
 char *r7[] =3D {
     "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,push-continuation 2",
-    "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,push-continuation 1"
+    "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,push-continuation 1",
+    NULL
 };
 char *r8[] =3D {
     "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalala=
lalalalalalalalaf,push-continuation 2",
     "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redire=
ct-gateway\n local,push-continuation 2",
-    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0\n\n\n,push-continuation 1"
+    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0\n\n\n,push-continuation 1=
",
+    NULL
 };
 char *r9[] =3D {
-    "PUSH_UPDATE,,"
+    "PUSH_UPDATE,,",
+    NULL
 };
-
+char *r11[] =3D {
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-cont=
inuation 1",
+    NULL
+};
+char *r12[] =3D {
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,push-continuation 2",
+    "PUSH_UPDATE,abc,push-continuation 1",
+    NULL
+};
+char *r13[] =3D {
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,",
+    NULL
+};
+char *r14[] =3D {
+    "PUSH_UPDATE,a,push-continuation 2",
+    "PUSH_UPDATE,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,push-continuation 2",
+    "PUSH_UPDATE,a,push-continuation 1",
+    NULL
+};

 const char *msg0 =3D "redirect-gateway local,route 192.168.1.0 255.255.255=
.0";
 const char *msg1 =3D "-dhcp-option,blablalalalalalalalalalalalalf, lalalal=
alalalalalalalalalalaf,"
@@ -365,32 +389,50 @@
                     "daisy damage damp dance danger daring dash daughter d=
awn day deal debate debris decade december decide decline"
                     "decorate decrease deer defense define defy degree del=
ay deliver demand demise denial";
=20
+const char *msg11 =3D "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a";
+
+const char *msg12 =3D "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,abc";
+
+const char *msg13 =3D "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,";
+
+const char *msg14 =3D "a,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,a";
+
 #define PUSH_BUNDLE_SIZE_TEST 184

+#define expect_control_channel_strings(res)                          \
+    do                                                               \
+    {                                                                \
+        for (int j =3D 0; res[j] !=3D NULL; j++)                         \
+        {                                                            \
+            expect_string(send_control_channel_string, str, res[j]); \
+        }                                                            \
+    } while (0)
+
 static void
 test_send_push_msg0(void **state)
 {
-    i =3D 0;
-    res =3D r0;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings(r0);
     assert_int_equal(send_push_update(m, &cid, msg0, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }
+
 static void
 test_send_push_msg1(void **state)
 {
-    i =3D 0;
-    res =3D r1;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings(r1);
     assert_int_equal(send_push_update(m, &cid, msg1, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

 static void
 test_send_push_msg2(void **state)
 {
-    i =3D 0;
-    res =3D NULL;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
     assert_int_equal(send_push_update(m, &cid, msg2, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), -EINVAL);
@@ -399,83 +441,110 @@
 static void
 test_send_push_msg3(void **state)
 {
-    i =3D 0;
-    res =3D r3;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings(r3);
     assert_int_equal(send_push_update(m, &cid, msg3, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

 static void
 test_send_push_msg4(void **state)
 {
-    i =3D 0;
-    res =3D r4;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings(r4);
     assert_int_equal(send_push_update(m, &cid, msg4, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

 static void
 test_send_push_msg5(void **state)
 {
-    i =3D 0;
-    res =3D r5;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings(r5);
     assert_int_equal(send_push_update(m, &cid, msg5, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

 static void
 test_send_push_msg6(void **state)
 {
-    i =3D 0;
-    res =3D r6;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings(r6);
     assert_int_equal(send_push_update(m, &cid, msg6, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

 static void
 test_send_push_msg7(void **state)
 {
-    i =3D 0;
-    res =3D r7;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings(r7);
     assert_int_equal(send_push_update(m, &cid, msg7, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

 static void
 test_send_push_msg8(void **state)
 {
-    i =3D 0;
-    res =3D r8;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings(r8);
     assert_int_equal(send_push_update(m, &cid, msg8, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

 static void
 test_send_push_msg9(void **state)
 {
-    i =3D 0;
-    res =3D r9;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings(r9);
     assert_int_equal(send_push_update(m, &cid, msg9, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

 static void
 test_send_push_msg10(void **state)
 {
-    i =3D 0;
-    res =3D NULL;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
     assert_int_equal(send_push_update(m, &cid, msg10, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), -EINVAL);
 }

+static void
+test_send_push_msg11(void **state)
+{
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    expect_control_channel_strings(r11);
+    assert_int_equal(send_push_update(m, &cid, msg11, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg12(void **state)
+{
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    expect_control_channel_strings(r12);
+    assert_int_equal(send_push_update(m, &cid, msg12, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg13(void **state)
+{
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    expect_control_channel_strings(r13);
+    assert_int_equal(send_push_update(m, &cid, msg13, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg14(void **state)
+{
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    expect_control_channel_strings(r14);
+    assert_int_equal(send_push_update(m, &cid, msg14, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
 #undef PUSH_BUNDLE_SIZE_TEST

 static int
@@ -535,6 +604,7 @@
         cmocka_unit_test_setup_teardown(test_incoming_push_message_mix, se=
tup, teardown),
         cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, s=
etup, teardown),
 #ifdef ENABLE_MANAGEMENT
+
         cmocka_unit_test_setup_teardown(test_send_push_msg0, setup2, teard=
own2),
         cmocka_unit_test_setup_teardown(test_send_push_msg1, setup2, teard=
own2),
         cmocka_unit_test_setup_teardown(test_send_push_msg2, setup2, teard=
own2),
@@ -545,7 +615,11 @@
         cmocka_unit_test_setup_teardown(test_send_push_msg7, setup2, teard=
own2),
         cmocka_unit_test_setup_teardown(test_send_push_msg8, setup2, teard=
own2),
         cmocka_unit_test_setup_teardown(test_send_push_msg9, setup2, teard=
own2),
-        cmocka_unit_test_setup_teardown(test_send_push_msg10, setup2, tear=
down2)
+        cmocka_unit_test_setup_teardown(test_send_push_msg10, setup2, tear=
down2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg11, setup2, tear=
down2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg12, setup2, tear=
down2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg13, setup2, tear=
down2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg14, setup2, tear=
down2)
 #endif
     };


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9
Gerrit-Change-Number: 1316
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>

--IMB1D2axsWQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #4</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">PUSH_UPDATE server: invalid =
read bug-fix and unit-tests improvements<br><br>The number of messages calc=
ulated before the call to message_splitter(), used<br>in the memory allocat=
ion in the buffer array, could in certain cases be less<br>than one than th=
e actual number of messages, thus causing an override of the<br>sentinel bu=
ffer in message_splitter and therefore an invalid read in<br>send_single_pu=
sh_update(). The case in question would be, for example, a<br>sequence of t=
hree options &quot;A, B, C&quot; with the size of B equal to safe_cap - 1<b=
r>and the sum of the sizes of A and C less than safe_cap - 2.<br>The buffer=
 array was therefore replaced with a list of buffers to completely<br>avoid=
 calculating the number of messages before it was actually computed.<br>The=
 test case in question has been added to the unit tests.<br>The unit tests =
have been improved using cmocka macros.<br><br>Change-Id: Idba419681fe3ccc4=
e6e2f6ce7592332dcff62cd9<br>Signed-off-by: Marco Baffo &lt;marco@...2726...=
&gt;<br>---<br>M src/openvpn/push_util.c<br>M tests/unit_tests/openvpn/test=
_push_update_msg.c<br>2 files changed, 137 insertions(+), 57 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/16/1316/4</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/push_util.c b/src/op=
envpn/push_util.c</span><br><span>index 552679a..51c7b5f 100644</span><br><=
span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/openvpn/push_u=
til.c</span><br><span>@@ -91,7 +91,7 @@</span><br><span>  * Return `false` =
on failure an `true` on success.</span><br><span>  */</span><br><span> stat=
ic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-message_splitt=
er(const char *s, struct buffer *msgs, struct gc_arena *gc, const size_t sa=
fe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+message_spli=
tter(const char *s, struct buffer_list *msgs, struct gc_arena *gc, const si=
ze_t safe_cap)</span><br><span> {</span><br><span>     if (!s || !*s)</span=
><br><span>     {</span><br><span>@@ -100,7 +100,6 @@</span><br><span> </sp=
an><br><span>     char *str =3D gc_strdup(s, gc);</span><br><span>     size=
_t i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int im=
 =3D 0;</span><br><span> </span><br><span>     while (*str)</span><br><span=
>     {</span><br><span>@@ -115,37 +114,38 @@</span><br><span>             =
}</span><br><span>             str[ci] =3D &#39;\0&#39;;</span><br><span>  =
           /* copy from i to (ci -1) */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            msgs[im] =3D forge_msg(str, &quot;,push-conti=
nuation 2&quot;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            struct buffer tmp =3D forge_msg(str, &quot;,push-continuation=
 2&quot;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span>            =
 i =3D ci + 1;</span><br><span>         }</span><br><span>         else</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (im)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (msgs-&gt;head)</span><br><span>             {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                msgs[im] =3D forg=
e_msg(str, &quot;,push-continuation 1&quot;, gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                struct buffer tmp =3D forge_m=
sg(str, &quot;,push-continuation 1&quot;, gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                buffer_list_push(msgs, BSTR(&amp=
;tmp));</span><br><span>             }</span><br><span>             else</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                msgs[im] =3D forge_msg(str, NULL, gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                struct buffer tmp=
 =3D forge_msg(str, NULL, gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                buffer_list_push(msgs, BSTR(&amp;tmp));</span><b=
r><span>             }</span><br><span>             i =3D strlen(str);</spa=
n><br><span>         }</span><br><span>         str =3D &amp;str[i];</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        im++;</span><br><spa=
n>     }</span><br><span>     return true;</span><br><span> }</span><br><sp=
an> </span><br><span> /* send the message(s) prepared to one single client =
*/</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-send_single_push_update(struct multi_context *m, struct multi_ins=
tance *mi, struct buffer *msgs)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+send_single_push_update(struct multi_context *m, struct multi_i=
nstance *mi, struct buffer_list *msgs)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!msgs[0].data || !*(msgs[0].dat=
a))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!msgs-&g=
t;head)</span><br><span>     {</span><br><span>         return false;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int i =3D -1;</span><br><span>     unsigned int option_ty=
pes_found =3D 0;</span><br><span>     struct context *c =3D &amp;mi-&gt;con=
text;</span><br><span>     struct options o;</span><br><span>@@ -160,9 +160=
,10 @@</span><br><span>     o.ifconfig_local =3D canary;</span><br><span>  =
   o.ifconfig_ipv6_local =3D canary;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    while (msgs[++i].data &amp;&amp; *(msg=
s[i].data))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer_entry *e =3D msgs-&gt;head;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    while (e)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (!send_control_channel_string(c=
, BSTR(&amp;msgs[i]), D_PUSH))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!send_control_channel_string(c, BSTR(&amp;e-&gt;buf)=
, D_PUSH))</span><br><span>         {</span><br><span>             return f=
alse;</span><br><span>         }</span><br><span>@@ -182,13 +183,14 @@</spa=
n><br><span>          * Also we need to make a temporary copy so we can buf=
_advance()</span><br><span>          * without modifying original buffer.</=
span><br><span>          */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        struct buffer tmp_msg =3D msgs[i];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        struct buffer tmp_msg =3D e-&gt;buf;</=
span><br><span>         buf_string_compare_advance(&amp;tmp_msg, push_updat=
e_cmd);</span><br><span>         unsigned int permission_mask =3D pull_perm=
ission_mask(c);</span><br><span>         if (process_push_update(c, &amp;o,=
 permission_mask, &amp;option_types_found, &amp;tmp_msg, true) =3D=3D PUSH_=
MSG_ERROR)</span><br><span>         {</span><br><span>             msg(M_WA=
RN, &quot;Failed to process push update message sent to client ID: %u&quot;=
, c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span>         }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        e =3D e-&gt;next;</span><=
br><span>     }</span><br><span> </span><br><span>     if (option_types_fou=
nd &amp; OPT_P_UP)</span><br><span>@@ -270,12 +272,11 @@</span><br><span>  =
    * we want to send exceeds that size we have to split it into smaller me=
ssages */</span><br><span>     ASSERT(push_bundle_size &gt; extra);</span><=
br><span>     const size_t safe_cap =3D push_bundle_size - extra;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    size_t msgs_num =3D (strlen=
(msg) / safe_cap) + ((strlen(msg) % safe_cap) !=3D 0);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct buffer *msgs =3D gc_malloc((msg=
s_num + 1) * sizeof(struct buffer), true, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer_list *msgs =3D buffer_l=
ist_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    msgs[msgs_num].data =3D NULL;</span><br><span>     if (!message_=
splitter(msg, msgs, &amp;gc, safe_cap))</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        buffer_list_free(msgs);<=
/span><br><span>         gc_free(&amp;gc);</span><br><span>         return =
-EINVAL;</span><br><span>     }</span><br><span>@@ -286,6 +287,7 @@</span><=
br><span> </span><br><span>         if (!mi)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            buffer_list=
_free(msgs);</span><br><span>             gc_free(&amp;gc);</span><br><span=
>             return -ENOENT;</span><br><span>         }</span><br><span>@@=
 -293,6 +295,7 @@</span><br><span>         if (!support_push_update(mi))</s=
pan><br><span>         {</span><br><span>             msg(M_CLIENT, &quot;P=
USH_UPDATE: not sending message to unsupported peer with ID: %u&quot;, mi-&=
gt;context.c2.tls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            buffer_list_free(msgs);</span><br><span>     =
        gc_free(&amp;gc);</span><br><span>             return 0;</span><br>=
<span>         }</span><br><span>@@ -300,11 +303,13 @@</span><br><span>    =
     if (!mi-&gt;halt</span><br><span>             &amp;&amp; send_single_p=
ush_update(m, mi, msgs))</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buffer_list_free(msgs);</span=
><br><span>             gc_free(&amp;gc);</span><br><span>             retu=
rn 1;</span><br><span>         }</span><br><span>         else</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       buffer_list_free(msgs);</span><br><span>             gc_free(&amp;gc=
);</span><br><span>             return 0;</span><br><span>         }</span>=
<br><span>@@ -334,6 +339,7 @@</span><br><span>     }</span><br><span> </spa=
n><br><span>     hash_iterator_free(&amp;hi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buffer_list_free(msgs);</span><br><span>     =
gc_free(&amp;gc);</span><br><span>     return count;</span><br><span> }</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b=
/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>index 516e=
94c..6ef1266 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pus=
h_update_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_push_upd=
ate_msg.c</span><br><span>@@ -130,18 +130,11 @@</span><br><span>     return=
 true;</span><br><span> }</span><br><span> #else  /* ifndef ENABLE_MANAGEME=
NT */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-char **res;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-int i;</span><br><span> </=
span><br><span> bool</span><br><span> send_control_channel_string(struct co=
ntext *c, const char *str, msglvl_t msglevel)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (res &amp;&amp; res[i] &a=
mp;&amp; strcmp(res[i], str))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
printf(&quot;\n\nexpected: %s\n\n  actual: %s\n\n&quot;, res[i], str);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    i++;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    check_expected(str);</span><br><span>     return =
true;</span><br><span> }</span><br><span> </span><br><span>@@ -301,44 +294,=
75 @@</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br=
><span> char *r0[] =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &quot;PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.2=
55.0&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot=
;PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.255.0&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><=
span> };</span><br><span> char *r1[] =3D {</span><br><span>     &quot;PUSH_=
UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalal=
alalaf,push-continuation 2&quot;,</span><br><span>     &quot;PUSH_UPDATE, a=
kakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redirect-gateway local,pus=
h-continuation 2&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &quot;PUSH_UPDATE,route 192.168.1.0 255.255.255.0,push-continuation 1=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUS=
H_UPDATE,route 192.168.1.0 255.255.255.0,push-continuation 1&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><span> }=
;</span><br><span> char *r3[] =3D {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &quot;PUSH_UPDATE,,,&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,,&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><span> };</span><br=
><span> char *r4[] =3D {</span><br><span>     &quot;PUSH_UPDATE,-dhcp-optio=
n, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-conti=
nuation 2&quot;,</span><br><span>     &quot;PUSH_UPDATE, akakakakakakakakak=
akakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local,push-continuation 2&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_=
UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, route=
 192.168.1.0 255.255.255.0,,push-continuation 1&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><span> };</span><br><=
span> char *r5[] =3D {</span><br><span>     &quot;PUSH_UPDATE,,-dhcp-option=
, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-contin=
uation 2&quot;,</span><br><span>     &quot;PUSH_UPDATE, akakakakakakakakaka=
kakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local,push-continuation 2&q=
uot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_U=
PDATE, route 192.168.1.0 255.255.255.0,push-continuation 1&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, route 1=
92.168.1.0 255.255.255.0,push-continuation 1&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><span> };</span><br><s=
pan> char *r6[] =3D {</span><br><span>     &quot;PUSH_UPDATE,-dhcp-option,b=
lablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuat=
ion 2&quot;,</span><br><span>     &quot;PUSH_UPDATE, akakakakakakakakakakak=
af, dhcp-option DNS 8.8.8.8, redirect-gateway 10.10.10.10,,push-continuatio=
n 2&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;P=
USH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, r=
oute 192.168.1.0 255.255.255.0,,push-continuation 1&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><span> };</span><=
br><span> char *r7[] =3D {</span><br><span>     &quot;PUSH_UPDATE,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,push-continuation 2&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &quot;PUSH_UPDATE,,,,,,,,,,,,,,,,,,,push-continuation 1&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDA=
TE,,,,,,,,,,,,,,,,,,,push-continuation 1&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    NULL</span><br><span> };</span><br><span> c=
har *r8[] =3D {</span><br><span>     &quot;PUSH_UPDATE,-dhcp-option,blablal=
alalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2&=
quot;,</span><br><span>     &quot;PUSH_UPDATE, akakakakakakakakakakakaf, dh=
cp-option DNS 8.8.8.8,redirect-gateway\n local,push-continuation 2&quot;,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_UPDATE,r=
oute 192.168.1.0 255.255.255.0\n\n\n,push-continuation 1&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,route 192.=
168.1.0 255.255.255.0\n\n\n,push-continuation 1&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><span> };</span><br><=
span> char *r9[] =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &quot;PUSH_UPDATE,,&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;PUSH_UPDATE,,&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    NULL</span><br><span> };</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+char *r11[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,push-continuation 2&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_U=
PDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,push-continuation 2&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,push-continuation 1&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    NULL</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
char *r12[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,push-continuation 2&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,abc,push-conti=
nuation 1&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 NULL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+char *r13[] =3D {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a=
,&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NULL</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+char *r14[] =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,push-continuation=
 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
PUSH_UPDATE,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaa,push-continuation 2&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,push-continuation=
 1&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NULL</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span> <=
/span><br><span> const char *msg0 =3D &quot;redirect-gateway local,route 19=
2.168.1.0 255.255.255.0&quot;;</span><br><span> const char *msg1 =3D &quot;=
-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,=
&quot;</span><br><span>@@ -365,32 +389,50 @@</span><br><span>              =
       &quot;daisy damage damp dance danger daring dash daughter dawn day d=
eal debate debris decade december decide decline&quot;</span><br><span>    =
                 &quot;decorate decrease deer defense define defy degree de=
lay deliver demand demise denial&quot;;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+const char *msg11 =3D &quot;a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    &quot;a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+const char *msg12 =3D &quot;a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a=
,abc&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg13 =3D &quot=
;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,,,,,,a,&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg14 =
=3D &quot;a,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaa,a&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> #define PUSH_BUNDLE_SIZE_TEST 184</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define exp=
ect_control_channel_strings(res)                          \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    do                             =
                                  \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {                                                      =
          \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
for (int j =3D 0; res[j] !=3D NULL; j++)                         \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {                   =
                                         \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            expect_string(send_control_channel_strin=
g, str, res[j]); \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }                                                            \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    } while (0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void=
</span><br><span> test_send_push_msg0(void **state)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    i =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    res =3D r0;</span><br><span>   =
  struct multi_context *m =3D *state;</span><br><span>     const unsigned l=
ong cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
xpect_control_channel_strings(r0);</span><br><span>     assert_int_equal(se=
nd_push_update(m, &amp;cid, msg0, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</=
span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> static void</span><br><span> test_send_push_msg1(void **sta=
te)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res =
=3D r1;</span><br><span>     struct multi_context *m =3D *state;</span><br>=
<span>     const unsigned long cid =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    expect_control_channel_strings(r1);</span><br><sp=
an>     assert_int_equal(send_push_update(m, &amp;cid, msg1, UPT_BY_CID, PU=
SH_BUNDLE_SIZE_TEST), 1);</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span> test_send_push_msg2(void **state)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i =3D =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res =3D NULL;</=
span><br><span>     struct multi_context *m =3D *state;</span><br><span>   =
  const unsigned long cid =3D 0;</span><br><span>     assert_int_equal(send=
_push_update(m, &amp;cid, msg2, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), -EINVAL=
);</span><br><span>@@ -399,83 +441,110 @@</span><br><span> static void</spa=
n><br><span> test_send_push_msg3(void **state)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    i =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    res =3D r3;</span><br><span>     str=
uct multi_context *m =3D *state;</span><br><span>     const unsigned long c=
id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect=
_control_channel_strings(r3);</span><br><span>     assert_int_equal(send_pu=
sh_update(m, &amp;cid, msg3, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
> test_send_push_msg4(void **state)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    i =3D 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    res =3D r4;</span><br><span>     struct multi_c=
ontext *m =3D *state;</span><br><span>     const unsigned long cid =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_control_ch=
annel_strings(r4);</span><br><span>     assert_int_equal(send_push_update(m=
, &amp;cid, msg4, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span> =
}</span><br><span> </span><br><span> static void</span><br><span> test_send=
_push_msg5(void **state)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    i =3D 0;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    res =3D r5;</span><br><span>     struct multi_context *m =
=3D *state;</span><br><span>     const unsigned long cid =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel_stri=
ngs(r5);</span><br><span>     assert_int_equal(send_push_update(m, &amp;cid=
, msg5, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span> test_send_push_msg6=
(void **state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    res =3D r6;</span><br><span>     struct multi_context *m =3D *state;=
</span><br><span>     const unsigned long cid =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel_strings(r6);</=
span><br><span>     assert_int_equal(send_push_update(m, &amp;cid, msg6, UP=
T_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span> }</span><br><span> <=
/span><br><span> static void</span><br><span> test_send_push_msg7(void **st=
ate)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res=
 =3D r7;</span><br><span>     struct multi_context *m =3D *state;</span><br=
><span>     const unsigned long cid =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    expect_control_channel_strings(r7);</span><br><s=
pan>     assert_int_equal(send_push_update(m, &amp;cid, msg7, UPT_BY_CID, P=
USH_BUNDLE_SIZE_TEST), 1);</span><br><span> }</span><br><span> </span><br><=
span> static void</span><br><span> test_send_push_msg8(void **state)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res =3D r8;</s=
pan><br><span>     struct multi_context *m =3D *state;</span><br><span>    =
 const unsigned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    expect_control_channel_strings(r8);</span><br><span>     as=
sert_int_equal(send_push_update(m, &amp;cid, msg8, UPT_BY_CID, PUSH_BUNDLE_=
SIZE_TEST), 1);</span><br><span> }</span><br><span> </span><br><span> stati=
c void</span><br><span> test_send_push_msg9(void **state)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    res =3D r9;</span><br><sp=
an>     struct multi_context *m =3D *state;</span><br><span>     const unsi=
gned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    expect_control_channel_strings(r9);</span><br><span>     assert_int_eq=
ual(send_push_update(m, &amp;cid, msg9, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST),=
 1);</span><br><span> }</span><br><span> </span><br><span> static void</spa=
n><br><span> test_send_push_msg10(void **state)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    i =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    res =3D NULL;</span><br><span>     =
struct multi_context *m =3D *state;</span><br><span>     const unsigned lon=
g cid =3D 0;</span><br><span>     assert_int_equal(send_push_update(m, &amp=
;cid, msg10, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), -EINVAL);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_se=
nd_push_msg11(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 multi_context *m =3D *state;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const unsigned long cid =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    expect_control_channel_strings(r11);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_pus=
h_update(m, &amp;cid, msg11, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_send_push_msg12(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct multi_context *m =3D *state;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel_strings(r12)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(send_push_update(m, &amp;cid, msg12, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST),=
 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_send_push_msg13(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct multi_context *m =3D *state;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel=
_strings(r13);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(send_push_update(m, &amp;cid, msg13, UPT_BY_CID, PUSH_BUNDL=
E_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+test_send_push_msg14(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *state;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned long cid =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_co=
ntrol_channel_strings(r14);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(send_push_update(m, &amp;cid, msg14, UPT_BY_CI=
D, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> #undef PUSH_BUNDLE_SIZE_TEST</span><br><span> </span><br><span> =
static int</span><br><span>@@ -535,6 +604,7 @@</span><br><span>         cmo=
cka_unit_test_setup_teardown(test_incoming_push_message_mix, setup, teardow=
n),</span><br><span>         cmocka_unit_test_setup_teardown(test_incoming_=
push_message_mix2, setup, teardown),</span><br><span> #ifdef ENABLE_MANAGEM=
ENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>         cmocka_unit_test_setup_teardown(test_send_push_msg0, setup2, tear=
down2),</span><br><span>         cmocka_unit_test_setup_teardown(test_send_=
push_msg1, setup2, teardown2),</span><br><span>         cmocka_unit_test_se=
tup_teardown(test_send_push_msg2, setup2, teardown2),</span><br><span>@@ -5=
45,7 +615,11 @@</span><br><span>         cmocka_unit_test_setup_teardown(te=
st_send_push_msg7, setup2, teardown2),</span><br><span>         cmocka_unit=
_test_setup_teardown(test_send_push_msg8, setup2, teardown2),</span><br><sp=
an>         cmocka_unit_test_setup_teardown(test_send_push_msg9, setup2, te=
ardown2),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmoc=
ka_unit_test_setup_teardown(test_send_push_msg10, setup2, teardown2)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_s=
etup_teardown(test_send_push_msg10, setup2, teardown2),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown=
(test_send_push_msg11, setup2, teardown2),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_pu=
sh_msg12, setup2, teardown2),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test_setup_teardown(test_send_push_msg13, set=
up2, teardown2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test_setup_teardown(test_send_push_msg14, setup2, teardown=
2)</span><br><span> #endif</span><br><span>     };</span><br><span> </span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1316?usp=3Demail">change 1316</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1316?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idba419681fe3ccc4e6e2f6ce759=
2332dcff62cd9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1316 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>

</body></html>=

--IMB1D2axsWQ=--

