From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 19:28:21 +0000
In-Reply-To: <gerrit.1761581200000.Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9@...2715...>
References: <gerrit.1761581200000.Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <93fee6bc811e4840b1e773a138ec3a8a7361db61-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="acw5G9ddd74="; charset=UTF-8
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

--acw5G9ddd74=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail

to look at the new patch set (#2).


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
2 files changed, 145 insertions(+), 32 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1316/2

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
index 516e94c..e450a31 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -136,11 +136,7 @@
 bool
 send_control_channel_string(struct context *c, const char *str, msglvl_t m=
sglevel)
 {
-    if (res && res[i] && strcmp(res[i], str))
-    {
-        printf("\n\nexpected: %s\n\n  actual: %s\n\n", res[i], str);
-        return false;
-    }
+    check_expected(str);
     i++;
     return true;
 }
@@ -301,44 +297,75 @@

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
@@ -365,8 +392,29 @@
                     "daisy damage damp dance danger daring dash daughter d=
awn day deal debate debris decade december decide decline"
                     "decorate decrease deer defense define defy degree del=
ay deliver demand demise denial";

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

+#define expect_control_channel_strings()                             \
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
@@ -374,8 +422,10 @@
     res =3D r0;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings();
     assert_int_equal(send_push_update(m, &cid, msg0, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }
+
 static void
 test_send_push_msg1(void **state)
 {
@@ -383,6 +433,7 @@
     res =3D r1;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings();
     assert_int_equal(send_push_update(m, &cid, msg1, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

@@ -403,6 +454,7 @@
     res =3D r3;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings();
     assert_int_equal(send_push_update(m, &cid, msg3, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

@@ -413,6 +465,7 @@
     res =3D r4;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings();
     assert_int_equal(send_push_update(m, &cid, msg4, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

@@ -423,6 +476,7 @@
     res =3D r5;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings();
     assert_int_equal(send_push_update(m, &cid, msg5, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

@@ -433,6 +487,7 @@
     res =3D r6;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings();
     assert_int_equal(send_push_update(m, &cid, msg6, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

@@ -443,6 +498,7 @@
     res =3D r7;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings();
     assert_int_equal(send_push_update(m, &cid, msg7, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

@@ -453,6 +509,7 @@
     res =3D r8;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings();
     assert_int_equal(send_push_update(m, &cid, msg8, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

@@ -463,6 +520,7 @@
     res =3D r9;
     struct multi_context *m =3D *state;
     const unsigned long cid =3D 0;
+    expect_control_channel_strings();
     assert_int_equal(send_push_update(m, &cid, msg9, UPT_BY_CID, PUSH_BUND=
LE_SIZE_TEST), 1);
 }

@@ -476,6 +534,50 @@
     assert_int_equal(send_push_update(m, &cid, msg10, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), -EINVAL);
 }

+static void
+test_send_push_msg11(void **state)
+{
+    i =3D 0;
+    res =3D r11;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    expect_control_channel_strings();
+    assert_int_equal(send_push_update(m, &cid, msg11, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg12(void **state)
+{
+    i =3D 0;
+    res =3D r12;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    expect_control_channel_strings();
+    assert_int_equal(send_push_update(m, &cid, msg12, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg13(void **state)
+{
+    i =3D 0;
+    res =3D r13;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    expect_control_channel_strings();
+    assert_int_equal(send_push_update(m, &cid, msg13, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg14(void **state)
+{
+    i =3D 0;
+    res =3D r14;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    expect_control_channel_strings();
+    assert_int_equal(send_push_update(m, &cid, msg14, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
 #undef PUSH_BUNDLE_SIZE_TEST

 static int
@@ -535,6 +637,7 @@
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
@@ -545,7 +648,11 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mrbff <marco@...2726...>

--acw5G9ddd74=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: mrbff, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">PUSH_UPDATE server: invalid read bug-fix and unit-tests=
 improvements<br><br>The number of messages calculated before the call to m=
essage_splitter(), used<br>in the memory allocation in the buffer array, co=
uld in certain cases be less<br>than one than the actual number of messages=
, thus causing an override of the<br>sentinel buffer in message_splitter an=
d therefore an invalid read in<br>send_single_push_update(). The case in qu=
estion would be, for example, a<br>sequence of three options &quot;A, B, C&=
quot; with the size of B equal to safe_cap - 1<br>and the sum of the sizes =
of A and C less than safe_cap - 2.<br>The buffer array was therefore replac=
ed with a list of buffers to completely<br>avoid calculating the number of =
messages before it was actually computed.<br>The test case in question has =
been added to the unit tests.<br>The unit tests have been improved using cm=
ocka macros.<br><br>Change-Id: Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9<br=
>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvp=
n/push_util.c<br>M tests/unit_tests/openvpn/test_push_update_msg.c<br>2 fil=
es changed, 145 insertions(+), 32 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1316/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br=
><span>index 552679a..51c7b5f 100644</span><br><span>--- a/src/openvpn/push=
_util.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -9=
1,7 +91,7 @@</span><br><span>  * Return `false` on failure an `true` on suc=
cess.</span><br><span>  */</span><br><span> static bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-message_splitter(const char *s, struct bu=
ffer *msgs, struct gc_arena *gc, const size_t safe_cap)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+message_splitter(const char *s, struct =
buffer_list *msgs, struct gc_arena *gc, const size_t safe_cap)</span><br><s=
pan> {</span><br><span>     if (!s || !*s)</span><br><span>     {</span><br=
><span>@@ -100,7 +100,6 @@</span><br><span> </span><br><span>     char *str=
 =3D gc_strdup(s, gc);</span><br><span>     size_t i =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int im =3D 0;</span><br><span> </=
span><br><span>     while (*str)</span><br><span>     {</span><br><span>@@ =
-115,37 +114,38 @@</span><br><span>             }</span><br><span>         =
    str[ci] =3D &#39;\0&#39;;</span><br><span>             /* copy from i t=
o (ci -1) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msgs[im] =3D forge_msg(str, &quot;,push-continuation 2&quot;, gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct buffer=
 tmp =3D forge_msg(str, &quot;,push-continuation 2&quot;, gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            buffer_list_push(msg=
s, BSTR(&amp;tmp));</span><br><span>             i =3D ci + 1;</span><br><s=
pan>         }</span><br><span>         else</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (im)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (msgs-&gt;=
head)</span><br><span>             {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                msgs[im] =3D forge_msg(str, &quot;,push-cont=
inuation 1&quot;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                struct buffer tmp =3D forge_msg(str, &quot;,push-continu=
ation 1&quot;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span>   =
          }</span><br><span>             else</span><br><span>             =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msgs=
[im] =3D forge_msg(str, NULL, gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                struct buffer tmp =3D forge_msg(str, NULL, g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span>             }</spa=
n><br><span>             i =3D strlen(str);</span><br><span>         }</spa=
n><br><span>         str =3D &amp;str[i];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        im++;</span><br><span>     }</span><br><span>  =
   return true;</span><br><span> }</span><br><span> </span><br><span> /* se=
nd the message(s) prepared to one single client */</span><br><span> static =
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_single_push_=
update(struct multi_context *m, struct multi_instance *mi, struct buffer *m=
sgs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_single_pus=
h_update(struct multi_context *m, struct multi_instance *mi, struct buffer_=
list *msgs)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (!msgs[0].data || !*(msgs[0].data))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!msgs-&gt;head)</span><br><span> =
    {</span><br><span>         return false;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i =
=3D -1;</span><br><span>     unsigned int option_types_found =3D 0;</span><=
br><span>     struct context *c =3D &amp;mi-&gt;context;</span><br><span>  =
   struct options o;</span><br><span>@@ -160,9 +160,10 @@</span><br><span> =
    o.ifconfig_local =3D canary;</span><br><span>     o.ifconfig_ipv6_local=
 =3D canary;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    while (msgs[++i].data &amp;&amp; *(msgs[i].data))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer_entry *e =3D m=
sgs-&gt;head;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wh=
ile (e)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (!send_control_channel_string(c, BSTR(&amp;msgs[i]), D_=
PUSH))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
send_control_channel_string(c, BSTR(&amp;e-&gt;buf), D_PUSH))</span><br><sp=
an>         {</span><br><span>             return false;</span><br><span>  =
       }</span><br><span>@@ -182,13 +183,14 @@</span><br><span>          * =
Also we need to make a temporary copy so we can buf_advance()</span><br><sp=
an>          * without modifying original buffer.</span><br><span>         =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buf=
fer tmp_msg =3D msgs[i];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        struct buffer tmp_msg =3D e-&gt;buf;</span><br><span>         =
buf_string_compare_advance(&amp;tmp_msg, push_update_cmd);</span><br><span>=
         unsigned int permission_mask =3D pull_permission_mask(c);</span><b=
r><span>         if (process_push_update(c, &amp;o, permission_mask, &amp;o=
ption_types_found, &amp;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)</span><br><sp=
an>         {</span><br><span>             msg(M_WARN, &quot;Failed to proc=
ess push update message sent to client ID: %u&quot;, c-&gt;c2.tls_multi-&gt=
;peer_id);</span><br><span>         }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        e =3D e-&gt;next;</span><br><span>     }</span><b=
r><span> </span><br><span>     if (option_types_found &amp; OPT_P_UP)</span=
><br><span>@@ -270,12 +272,11 @@</span><br><span>      * we want to send ex=
ceeds that size we have to split it into smaller messages */</span><br><spa=
n>     ASSERT(push_bundle_size &gt; extra);</span><br><span>     const size=
_t safe_cap =3D push_bundle_size - extra;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    size_t msgs_num =3D (strlen(msg) / safe_cap) + ((st=
rlen(msg) % safe_cap) !=3D 0);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeof(stru=
ct buffer), true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer_list *msgs =3D buffer_list_new();</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msgs[msgs_num].=
data =3D NULL;</span><br><span>     if (!message_splitter(msg, msgs, &amp;g=
c, safe_cap))</span><br><span>     {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        buffer_list_free(msgs);</span><br><span>         g=
c_free(&amp;gc);</span><br><span>         return -EINVAL;</span><br><span> =
    }</span><br><span>@@ -286,6 +287,7 @@</span><br><span> </span><br><span=
>         if (!mi)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            buffer_list_free(msgs);</span><br><sp=
an>             gc_free(&amp;gc);</span><br><span>             return -ENOE=
NT;</span><br><span>         }</span><br><span>@@ -293,6 +295,7 @@</span><b=
r><span>         if (!support_push_update(mi))</span><br><span>         {</=
span><br><span>             msg(M_CLIENT, &quot;PUSH_UPDATE: not sending me=
ssage to unsupported peer with ID: %u&quot;, mi-&gt;context.c2.tls_multi-&g=
t;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    buffer_list_free(msgs);</span><br><span>             gc_free(&amp;gc);<=
/span><br><span>             return 0;</span><br><span>         }</span><br=
><span>@@ -300,11 +303,13 @@</span><br><span>         if (!mi-&gt;halt</spa=
n><br><span>             &amp;&amp; send_single_push_update(m, mi, msgs))</=
span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            buffer_list_free(msgs);</span><br><span>             gc_f=
ree(&amp;gc);</span><br><span>             return 1;</span><br><span>      =
   }</span><br><span>         else</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            buffer_list_free(msgs=
);</span><br><span>             gc_free(&amp;gc);</span><br><span>         =
    return 0;</span><br><span>         }</span><br><span>@@ -334,6 +339,7 @=
@</span><br><span>     }</span><br><span> </span><br><span>     hash_iterat=
or_free(&amp;hi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buffer_list_free(msgs);</span><br><span>     gc_free(&amp;gc);</span><br>=
<span>     return count;</span><br><span> }</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/te=
st_push_update_msg.c</span><br><span>index 516e94c..e450a31 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@=
 -136,11 +136,7 @@</span><br><span> bool</span><br><span> send_control_chan=
nel_string(struct context *c, const char *str, msglvl_t msglevel)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (res =
&amp;&amp; res[i] &amp;&amp; strcmp(res[i], str))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        printf(&quot;\n\nexpected: %s\n\n  actual: %s\n\n&quot;=
, res[i], str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_expected(s=
tr);</span><br><span>     i++;</span><br><span>     return true;</span><br>=
<span> }</span><br><span>@@ -301,44 +297,75 @@</span><br><span> </span><br>=
<span> #ifdef ENABLE_MANAGEMENT</span><br><span> char *r0[] =3D {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_UPDATE,redirect-=
gateway local,route 192.168.1.0 255.255.255.0&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,redirect-gateway lo=
cal,route 192.168.1.0 255.255.255.0&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    NULL</span><br><span> };</span><br><span> char *=
r1[] =3D {</span><br><span>     &quot;PUSH_UPDATE,-dhcp-option,blablalalala=
lalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2&quot;=
,</span><br><span>     &quot;PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-op=
tion DNS 8.8.8.8,redirect-gateway local,push-continuation 2&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_UPDATE,route 19=
2.168.1.0 255.255.255.0,push-continuation 1&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,route 192.168.1.0 255.2=
55.255.0,push-continuation 1&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    NULL</span><br><span> };</span><br><span> char *r3[] =
=3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_U=
PDATE,,,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;PUSH_UPDATE,,,&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    NULL</span><br><span> };</span><br><span> char *r4[] =3D {</span=
><br><span>     &quot;PUSH_UPDATE,-dhcp-option, blablalalalalalalalalalalal=
alf, lalalalalalalalalalalalalalaf,push-continuation 2&quot;,</span><br><sp=
an>     &quot;PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8=
, redirect-gateway local,push-continuation 2&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_UPDATE, route 192.168.1.0 25=
5.255.255.0,,push-continuation 1&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,=
push-continuation 1&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    NULL</span><br><span> };</span><br><span> char *r5[] =3D {</span=
><br><span>     &quot;PUSH_UPDATE,,-dhcp-option, blablalalalalalalalalalala=
lalf, lalalalalalalalalalalalalalaf,push-continuation 2&quot;,</span><br><s=
pan>     &quot;PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.=
8, redirect-gateway local,push-continuation 2&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_UPDATE, route 192.168.1.0 25=
5.255.255.0,push-continuation 1&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;PUSH_UPDATE, route 192.168.1.0 255.255.255.0,pu=
sh-continuation 1&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    NULL</span><br><span> };</span><br><span> char *r6[] =3D {</span><=
br><span>     &quot;PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf=
, lalalalalalalalalalalalalalaf,push-continuation 2&quot;,</span><br><span>=
     &quot;PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8, =
redirect-gateway 10.10.10.10,,push-continuation 2&quot;,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_UPDATE, route 192.168.1.0=
 255.255.255.0,,push-continuation 1&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;PUSH_UPDATE, route 192.168.1.0 255.255.255.=
0,,push-continuation 1&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    NULL</span><br><span> };</span><br><span> char *r7[] =3D {</s=
pan><br><span>     &quot;PUSH_UPDATE,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,=
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,push-continuation 2&quot=
;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_UPDA=
TE,,,,,,,,,,,,,,,,,,,push-continuation 1&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,,,,,,,,,,,,,,,,,,,push-con=
tinuation 1&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   NULL</span><br><span> };</span><br><span> char *r8[] =3D {</span><br><sp=
an>     &quot;PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lala=
lalalalalalalalalalalalaf,push-continuation 2&quot;,</span><br><span>     &=
quot;PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redirec=
t-gateway\n local,push-continuation 2&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &quot;PUSH_UPDATE,route 192.168.1.0 255.255.255.=
0\n\n\n,push-continuation 1&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &quot;PUSH_UPDATE,route 192.168.1.0 255.255.255.0\n\n\n,p=
ush-continuation 1&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    NULL</span><br><span> };</span><br><span> char *r9[] =3D {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;PUSH_UPDATE,,&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPD=
ATE,,&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NUL=
L</span><br><span> };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *r11[] =3D {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,push-continuation 2&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PU=
SH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-conti=
nuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-con=
tinuation 1&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   NULL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+char *r12[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,=
,a,push-continuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;PUSH_UPDATE,abc,push-continuation 1&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+char *r13[] =3D {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+char *r14[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;PUSH_UPDATE,a,push-continuation 2&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,aaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,pu=
sh-continuation 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;PUSH_UPDATE,a,push-continuation 1&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    NULL</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span> </span><br><span> const char *=
msg0 =3D &quot;redirect-gateway local,route 192.168.1.0 255.255.255.0&quot;=
;</span><br><span> const char *msg1 =3D &quot;-dhcp-option,blablalalalalala=
lalalalalalalf, lalalalalalalalalalalalalalaf,&quot;</span><br><span>@@ -36=
5,8 +392,29 @@</span><br><span>                     &quot;daisy damage damp=
 dance danger daring dash daughter dawn day deal debate debris decade decem=
ber decide decline&quot;</span><br><span>                     &quot;decorat=
e decrease deer defense define defy degree delay deliver demand demise deni=
al&quot;;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const char *msg11 =3D &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+const char *msg12 =3D &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,abc&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+const char *msg13 =3D &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+const char *msg14 =3D &quot;a,aaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,a&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #define PUSH_BUNDLE_SIZE_TEST 184</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define expect_control_channel_strings() =
                            \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    do                                                           =
    \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {         =
                                                       \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        for (int j =3D 0; res[j] !=3D =
NULL; j++)                         \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {                                                 =
           \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     expect_string(send_control_channel_string, str, res[j]); \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }                      =
                                      \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    } while (0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static void</span><br><span> test_send_pu=
sh_msg0(void **state)</span><br><span> {</span><br><span>@@ -374,8 +422,10 =
@@</span><br><span>     res =3D r0;</span><br><span>     struct multi_conte=
xt *m =3D *state;</span><br><span>     const unsigned long cid =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_control_channe=
l_strings();</span><br><span>     assert_int_equal(send_push_update(m, &amp=
;cid, msg0, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span> }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static=
 void</span><br><span> test_send_push_msg1(void **state)</span><br><span> {=
</span><br><span>@@ -383,6 +433,7 @@</span><br><span>     res =3D r1;</span=
><br><span>     struct multi_context *m =3D *state;</span><br><span>     co=
nst unsigned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    expect_control_channel_strings();</span><br><span>     assert_=
int_equal(send_push_update(m, &amp;cid, msg1, UPT_BY_CID, PUSH_BUNDLE_SIZE_=
TEST), 1);</span><br><span> }</span><br><span> </span><br><span>@@ -403,6 +=
454,7 @@</span><br><span>     res =3D r3;</span><br><span>     struct multi=
_context *m =3D *state;</span><br><span>     const unsigned long cid =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_control_=
channel_strings();</span><br><span>     assert_int_equal(send_push_update(m=
, &amp;cid, msg3, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span> =
}</span><br><span> </span><br><span>@@ -413,6 +465,7 @@</span><br><span>   =
  res =3D r4;</span><br><span>     struct multi_context *m =3D *state;</spa=
n><br><span>     const unsigned long cid =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    expect_control_channel_strings();</span><br=
><span>     assert_int_equal(send_push_update(m, &amp;cid, msg4, UPT_BY_CID=
, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span> }</span><br><span> </span><b=
r><span>@@ -423,6 +476,7 @@</span><br><span>     res =3D r5;</span><br><spa=
n>     struct multi_context *m =3D *state;</span><br><span>     const unsig=
ned long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    expect_control_channel_strings();</span><br><span>     assert_int_equal=
(send_push_update(m, &amp;cid, msg5, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1)=
;</span><br><span> }</span><br><span> </span><br><span>@@ -433,6 +487,7 @@<=
/span><br><span>     res =3D r6;</span><br><span>     struct multi_context =
*m =3D *state;</span><br><span>     const unsigned long cid =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel_s=
trings();</span><br><span>     assert_int_equal(send_push_update(m, &amp;ci=
d, msg6, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span> }</span><=
br><span> </span><br><span>@@ -443,6 +498,7 @@</span><br><span>     res =3D=
 r7;</span><br><span>     struct multi_context *m =3D *state;</span><br><sp=
an>     const unsigned long cid =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    expect_control_channel_strings();</span><br><span>  =
   assert_int_equal(send_push_update(m, &amp;cid, msg7, UPT_BY_CID, PUSH_BU=
NDLE_SIZE_TEST), 1);</span><br><span> }</span><br><span> </span><br><span>@=
@ -453,6 +509,7 @@</span><br><span>     res =3D r8;</span><br><span>     st=
ruct multi_context *m =3D *state;</span><br><span>     const unsigned long =
cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expec=
t_control_channel_strings();</span><br><span>     assert_int_equal(send_pus=
h_update(m, &amp;cid, msg8, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><=
br><span> }</span><br><span> </span><br><span>@@ -463,6 +520,7 @@</span><br=
><span>     res =3D r9;</span><br><span>     struct multi_context *m =3D *s=
tate;</span><br><span>     const unsigned long cid =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel_strings();=
</span><br><span>     assert_int_equal(send_push_update(m, &amp;cid, msg9, =
UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span> }</span><br><span>=
 </span><br><span>@@ -476,6 +534,50 @@</span><br><span>     assert_int_equa=
l(send_push_update(m, &amp;cid, msg10, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), =
-EINVAL);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_send_push_msg11(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    res =3D r11;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_context *m =3D *state;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel_strings=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(send_push_update(m, &amp;cid, msg11, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST=
), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_send_push_msg12(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    res =3D r12;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_context *m =3D *state;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel_strings=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(send_push_update(m, &amp;cid, msg12, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST=
), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_send_push_msg13(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    res =3D r13;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_context *m =3D *state;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel_strings=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(send_push_update(m, &amp;cid, msg13, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST=
), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_send_push_msg14(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    res =3D r14;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_context *m =3D *state;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    expect_control_channel_strings=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(send_push_update(m, &amp;cid, msg14, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST=
), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #undef PUSH_B=
UNDLE_SIZE_TEST</span><br><span> </span><br><span> static int</span><br><sp=
an>@@ -535,6 +637,7 @@</span><br><span>         cmocka_unit_test_setup_tear=
down(test_incoming_push_message_mix, setup, teardown),</span><br><span>    =
     cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, setup=
, teardown),</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         cmocka_unit_te=
st_setup_teardown(test_send_push_msg0, setup2, teardown2),</span><br><span>=
         cmocka_unit_test_setup_teardown(test_send_push_msg1, setup2, teard=
own2),</span><br><span>         cmocka_unit_test_setup_teardown(test_send_p=
ush_msg2, setup2, teardown2),</span><br><span>@@ -545,7 +648,11 @@</span><b=
r><span>         cmocka_unit_test_setup_teardown(test_send_push_msg7, setup=
2, teardown2),</span><br><span>         cmocka_unit_test_setup_teardown(tes=
t_send_push_msg8, setup2, teardown2),</span><br><span>         cmocka_unit_=
test_setup_teardown(test_send_push_msg9, setup2, teardown2),</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test_setup_teard=
own(test_send_push_msg10, setup2, teardown2)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_=
push_msg10, setup2, teardown2),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_push_msg11, s=
etup2, teardown2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test_setup_teardown(test_send_push_msg12, setup2, teardo=
wn2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test_setup_teardown(test_send_push_msg13, setup2, teardown2),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_se=
tup_teardown(test_send_push_msg14, setup2, teardown2)</span><br><span> #end=
if</span><br><span>     };</span><br><span> </span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1316?=
usp=3Demail">change 1316</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1316?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idba419681fe3ccc4e6e2f6ce759=
2332dcff62cd9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1316 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>

</body></html>=

--acw5G9ddd74=--

