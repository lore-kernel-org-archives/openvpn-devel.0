From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 10:16:18 +0000
References: <gerrit.1757931374000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606..., gert@...1296...
Message-ID: <69b5202c86b17cbce546afa163966a3036aba82e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i4dwwNYL1lQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Check message
 id/acked ids too when doing sessionid cookie checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, MaxF <max@...2606...>

--i4dwwNYL1lQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1184?usp=3Demail

to review the following change.


Change subject: Check message id/acked ids too when doing sessionid cookie =
checks
......................................................................

Check message id/acked ids too when doing sessionid cookie checks

This fixes that control packets on a floating client can trigger
creating a new session in special circumstances:

To trigger this circumstance a connection needs to

- starts on IP A
- successfully floats to IP B by data packet
- then has a control packet from IP A before any
  data packet can trigger the float back to IP A

and all of this needs to happen in the 60s time
that hmac cookie is valid in the default
configuration.

In this scenario we would trigger a new connection as the HMAC
session id would be valid.

This patch adds checking also of the message-id and acked ids to
discern packet from the initial three-way handshake where these
ids are 0 or 1 from any later packet.

This will now trigger (at verb 4 or higher) a messaged like:

   Packet (P_ACK_V1) with invalid or missing SID

instead.

Also remove a few duplicated free_tls_pre_decrypt_state in test_ssl.

Reported-By: Walter Doekes <walter.openvpn@...2889...>
Tested-By: Walter Doekes <walter.openvpn@...2889...>

Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250819212214.16218-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
626.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mudp.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_pkt.h
M tests/unit_tests/openvpn/test_pkt.c
4 files changed, 117 insertions(+), 20 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1184/1

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index cdde0b5..0492311 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -153,7 +153,8 @@
          * need to contain the peer id */
         struct gc_arena gc =3D gc_new();

-        bool ret =3D check_session_id_hmac(state, from, hmac, handwindow);
+        bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
+        bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac, hand=
window, pkt_is_ack);

         const char *peer =3D print_link_socket_actual(&m->top.c2.from, &gc=
);
         uint8_t pkt_firstbyte =3D *BPTR( &m->top.c2.buf);
@@ -161,7 +162,8 @@

         if (!ret)
         {
-            msg(D_MULTI_MEDIUM, "Packet (%s) with invalid or missing SID f=
rom %s",
+            msg(D_MULTI_MEDIUM, "Packet (%s) with invalid or missing SID f=
rom"
+                " %s or wrong packet id",
                 packet_opcode_name(op), peer);
         }
         else
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 41299f4..432bb8b 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -527,10 +527,11 @@
 }

 bool
-check_session_id_hmac(struct tls_pre_decrypt_state *state,
-                      const struct openvpn_sockaddr *from,
-                      hmac_ctx_t *hmac,
-                      int handwindow)
+check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
+                              const struct openvpn_sockaddr *from,
+                              hmac_ctx_t *hmac,
+                              int handwindow,
+                              bool pkt_is_ack)
 {
     if (!from)
     {
@@ -545,6 +546,36 @@
         return false;
     }

+    /* Check if the packet ID of the packet or ACKED packet  is <=3D 1 */
+    for (int i =3D 0; i < ack.len; i++)
+    {
+        /* This packet ACKs a packet that has a higher packet id than the
+         * ones expected in the three-way handshake, consider it as invalid
+         * for the session */
+        if (ack.packet_id[i] > 1)
+        {
+            return false;
+        }
+    }
+
+    if (!pkt_is_ack)
+    {
+        packet_id_type message_id;
+        /* Extract the packet ID from the packet */
+        if (!reliable_ack_read_packet_id(&buf, &message_id))
+        {
+            return false;
+        }
+
+        /* similar check. Anything larger than 1 is not considered part of=
 the
+         * three-way handshake */
+        if (message_id > 1)
+        {
+            return false;
+        }
+    }
+
+
     /* check adjacent timestamps too */
     for (int offset =3D -2; offset <=3D 1; offset++)
     {
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 2033da6..1df691c 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -182,17 +182,20 @@
 /**
  * Checks if a control packet has a correct HMAC server session id
  *
- * @param client_sid    session id of the client
+ * This will also consider packets that have a packet id higher
+ * than 1 or ack packets higher than 1 to be invalid as they are
+ * not part of the initial three way handshake of OpenVPN and should
+ * not create a new connection.
+ *
+ * @param state         session information
  * @param from          link_socket from the client
  * @param hmac          the hmac context to use for the calculation
  * @param handwindow    the quantisation of the current time
+ * @param pkt_is_ack    the packet being checked is a P_ACK_V1
  * @return              the expected server session id
  */
-bool
-check_session_id_hmac(struct tls_pre_decrypt_state *state,
-                      const struct openvpn_sockaddr *from,
-                      hmac_ctx_t *hmac,
-                      int handwindow);
+bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, co=
nst struct openvpn_sockaddr *from,
+                                   hmac_ctx_t *hmac, int handwindow, bool =
pkt_is_ack);

 /*
  * Write a control channel authentication record.
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 74d7311..27f52cf 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -174,6 +174,27 @@
     0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e
 };

+/* no tls-auth, P_ACK_V1, acks 0,1, and 2 */
+const uint8_t client_ack_123_none_random_id[] =3D {
+    0x28,
+    0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,
+    0x03,
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x01,
+    0x00, 0x00, 0x00, 0x02,
+    0xdd, 0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e
+};
+
+/* no tls-auth, P_CONTROL_V1, acks 0, msg-id 2 */
+const uint8_t client_control_none_random_id[] =3D {
+    0x20,
+    0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,
+    0x01,
+    0x00, 0x00, 0x00, 0x00,
+    0x02
+};
+
+
 struct tls_auth_standalone
 init_tas_auth(int key_direction)
 {
@@ -294,12 +315,10 @@
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);

-    free_tls_pre_decrypt_state(&state);
     /* The pre decrypt function should not modify the buffer, so calling it
      * again should have the same result */
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
-    free_tls_pre_decrypt_state(&state);

     /* and buf memory should be equal */
     assert_memory_equal(BPTR(&buf), client_reset_v2_tls_auth, sizeof(clien=
t_reset_v2_tls_auth));
@@ -317,7 +336,6 @@
     assert_int_equal(verdict, VERDICT_INVALID);
     free_tls_pre_decrypt_state(&state);

-    free_tls_pre_decrypt_state(&state);
     /* Wrong key direction gives a wrong hmac key and should not validate =
*/
     free_key_ctx_bi(&tas.tls_wrap.opt.key_ctx_bi);
     free_tas(&tas);
@@ -357,15 +375,12 @@
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);

-    free_tls_pre_decrypt_state(&state);
     buf_reset_len(&buf);
     buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_none=
));
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);

-    free_tls_pre_decrypt_state(&state);
-
     /* This is not a reset packet and should trigger the other response */
     buf_reset_len(&buf);
     buf_write(&buf, client_ack_tls_auth_randomid, sizeof(client_ack_tls_au=
th_randomid));
@@ -443,7 +458,7 @@
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);

     /* This is a valid packet but containing a random id instead of an HMA=
C id*/
-    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid =3D check_session_hmac_and_pkt_id(&state, &from.dest, hmac,=
 30, false);
     assert_false(valid);

     free_tls_pre_decrypt_state(&state);
@@ -474,7 +489,7 @@
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);

-    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid =3D check_session_hmac_and_pkt_id(&state, &from.dest, hmac,=
 30, true);
     assert_true(valid);

     free_tls_pre_decrypt_state(&state);
@@ -483,6 +498,51 @@
     hmac_ctx_free(hmac);
 }
=20
+static void
+test_verify_hmac_none_out_of_range_ack(void **ut_state)
+{
+    hmac_ctx_t *hmac =3D session_id_hmac_init();
+
+    struct link_socket_actual from =3D { 0 };
+    from.dest.addr.sa.sa_family =3D AF_INET;
+
+    struct tls_auth_standalone tas =3D { 0 };
+    struct tls_pre_decrypt_state state =3D { 0 };
+
+    struct buffer buf =3D alloc_buf(1024);
+    enum first_packet_verdict verdict;
+
+    tas.tls_wrap.mode =3D TLS_WRAP_NONE;
+
+    buf_reset_len(&buf);
+    buf_write(&buf, client_ack_123_none_random_id, sizeof(client_ack_123_n=
one_random_id));
+
+
+    verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
+
+    /* should fail because it acks 2 */
+    bool valid =3D check_session_hmac_and_pkt_id(&state, &from.dest, hmac,=
 30, true);
+    assert_false(valid);
+    free_tls_pre_decrypt_state(&state);
+
+    /* Try test with the control with a too high message id now */
+    buf_reset_len(&buf);
+    buf_write(&buf, client_control_none_random_id, sizeof(client_control_n=
one_random_id));
+
+    verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
+
+    /* should fail because it has message id 2 */
+    valid =3D check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, =
true);
+    assert_false(valid);
+
+    free_tls_pre_decrypt_state(&state);
+    free_buf(&buf);
+    hmac_ctx_cleanup(hmac);
+    hmac_ctx_free(hmac);
+}
+
 static hmac_ctx_t *
 init_static_hmac(void)
 {
@@ -670,6 +730,7 @@
         cmocka_unit_test(test_calc_session_id_hmac_static),
         cmocka_unit_test(test_verify_hmac_none),
         cmocka_unit_test(test_verify_hmac_tls_auth),
+        cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
         cmocka_unit_test(test_extract_control_message)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1184?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
Gerrit-Change-Number: 1184
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newchange

--i4dwwNYL1lQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, cron2, flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1184?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Check message id/acked ids too when doing sessionid cookie c=
hecks<br><br>This fixes that control packets on a floating client can trigg=
er<br>creating a new session in special circumstances:<br><br>To trigger th=
is circumstance a connection needs to<br><br>- starts on IP A<br>- successf=
ully floats to IP B by data packet<br>- then has a control packet from IP A=
 before any<br>  data packet can trigger the float back to IP A<br><br>and =
all of this needs to happen in the 60s time<br>that hmac cookie is valid in=
 the default<br>configuration.<br><br>In this scenario we would trigger a n=
ew connection as the HMAC<br>session id would be valid.<br><br>This patch a=
dds checking also of the message-id and acked ids to<br>discern packet from=
 the initial three-way handshake where these<br>ids are 0 or 1 from any lat=
er packet.<br><br>This will now trigger (at verb 4 or higher) a messaged li=
ke:<br><br>   Packet (P_ACK_V1) with invalid or missing SID<br><br>instead.=
<br><br>Also remove a few duplicated free_tls_pre_decrypt_state in test_ssl=
.<br><br>Reported-By: Walter Doekes &lt;walter.openvpn@...2889...&gt;<br>Te=
sted-By: Walter Doekes &lt;walter.openvpn@...2889...&gt;<br><br>Change-Id: =
I6752dcd5aff3e5cea2b439366479e86751a1c403<br>Signed-off-by: Arne Schwabe &l=
t;arne@...1227...&gt;<br>Acked-by: MaxF &lt;max@...2606...&gt;<br>Message-I=
d: &lt;20250819212214.16218-1-gert@...1296...&gt;<br>URL: https://www.mail-=
archive.com/openvpn-devel@lists.sourceforge.net/msg32626.html<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/mudp.c<br=
>M src/openvpn/ssl_pkt.c<br>M src/openvpn/ssl_pkt.h<br>M tests/unit_tests/o=
penvpn/test_pkt.c<br>4 files changed, 117 insertions(+), 20 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/118=
4/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br>=
<span>index cdde0b5..0492311 100644</span><br><span>--- a/src/openvpn/mudp.=
c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -153,7 +153,8=
 @@</span><br><span>          * need to contain the peer id */</span><br><s=
pan>         struct gc_arena gc =3D gc_new();</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        bool ret =3D check_sessio=
n_id_hmac(state, from, hmac, handwindow);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        bool pkt_is_ack =3D (verdict =3D=3D VERDICT_V=
ALID_ACK_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac, handwindow,=
 pkt_is_ack);</span><br><span> </span><br><span>         const char *peer =
=3D print_link_socket_actual(&amp;m-&gt;top.c2.from, &amp;gc);</span><br><s=
pan>         uint8_t pkt_firstbyte =3D *BPTR( &amp;m-&gt;top.c2.buf);</span=
><br><span>@@ -161,7 +162,8 @@</span><br><span> </span><br><span>         i=
f (!ret)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(D_MULTI_MEDIUM, &quot;Packet (%s) with invali=
d or missing SID from %s&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_MULTI_MEDIUM, &quot;Packet (%s) with invalid =
or missing SID from&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                &quot; %s or wrong packet id&quot;,</span><br><span> =
                packet_opcode_name(op), peer);</span><br><span>         }</=
span><br><span>         else</span><br><span>diff --git a/src/openvpn/ssl_p=
kt.c b/src/openvpn/ssl_pkt.c</span><br><span>index 41299f4..432bb8b 100644<=
/span><br><span>--- a/src/openvpn/ssl_pkt.c</span><br><span>+++ b/src/openv=
pn/ssl_pkt.c</span><br><span>@@ -527,10 +527,11 @@</span><br><span> }</span=
><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-check_session_id_hmac(struct tls_pre_decrypt_state *state,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                      con=
st struct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                      hmac_ctx_t *hmac,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                      int handwindow)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+check_session_hmac_and_pk=
t_id(struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              const struct openvpn_so=
ckaddr *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                        hmac_ctx_t *hmac,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              int handwindow,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
   bool pkt_is_ack)</span><br><span> {</span><br><span>     if (!from)</spa=
n><br><span>     {</span><br><span>@@ -545,6 +546,36 @@</span><br><span>   =
      return false;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Check if the packet ID of t=
he packet or ACKED packet  is &lt;=3D 1 */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; ack.len; i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* This packet ACKs a packet that=
 has a higher packet id than the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * ones expected in the three-way handshake, consider =
it as invalid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * for the session */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (ack.packet_id[i] &gt; 1)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!pkt_is_ack)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        packet_id_type message_id;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Extract the p=
acket ID from the packet */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!reliable_ack_read_packet_id(&amp;buf, &amp;message_id)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* similar check. Anything larger than 1 is=
 not considered part of the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * three-way handshake */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (message_id &gt; 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     /* check adjacent timestamps too */</span><br><span>     for (int =
offset =3D -2; offset &lt;=3D 1; offset++)</span><br><span>     {</span><br=
><span>diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h</span><br=
><span>index 2033da6..1df691c 100644</span><br><span>--- a/src/openvpn/ssl_=
pkt.h</span><br><span>+++ b/src/openvpn/ssl_pkt.h</span><br><span>@@ -182,1=
7 +182,20 @@</span><br><span> /**</span><br><span>  * Checks if a control p=
acket has a correct HMAC server session id</span><br><span>  *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param client_sid    session id=
 of the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Th=
is will also consider packets that have a packet id higher</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * than 1 or ack packets higher than=
 1 to be invalid as they are</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * not part of the initial three way handshake of OpenVPN and shou=
ld</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * not create a n=
ew connection.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param state       =
  session information</span><br><span>  * @param from          link_socket =
from the client</span><br><span>  * @param hmac          the hmac context t=
o use for the calculation</span><br><span>  * @param handwindow    the quan=
tisation of the current time</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param pkt_is_ack    the packet being checked is a P_ACK_V1</sp=
an><br><span>  * @return              the expected server session id</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-check_session_id_hmac(st=
ruct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                      const struct openvpn_sockaddr *from,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                      hma=
c_ctx_t *hmac,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
               int handwindow);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state=
 *state, const struct openvpn_sockaddr *from,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                   hmac_ctx_t *hm=
ac, int handwindow, bool pkt_is_ack);</span><br><span> </span><br><span> /*=
</span><br><span>  * Write a control channel authentication record.</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_test=
s/openvpn/test_pkt.c</span><br><span>index 74d7311..27f52cf 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_pkt.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_pkt.c</span><br><span>@@ -174,6 +174,27 @@</span=
><br><span>     0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e</span><br><span> }=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* no tls-auth, P_ACK_V1, acks 0,1, and 2 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+const uint8_t client_ack_123_none_random_id[] =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x28,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    0xae, 0xb9, 0xaf, 0xe1, =
0xf0, 0x1d, 0x79, 0xc8,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0x03,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x=
00, 0x00, 0x00, 0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    0x00, 0x00, 0x00, 0x01,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    0x00, 0x00, 0x00, 0x02,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    0xdd, 0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* no tls-auth, P_CONTROL_V1, acks 0, msg-id 2 */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+const uint8_t client_control_n=
one_random_id[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    0x20,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xae=
, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    0x01,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    0x00, 0x00, 0x00, 0x00,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    0x02</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct =
tls_auth_standalone</span><br><span> init_tas_auth(int key_direction)</span=
><br><span> {</span><br><span>@@ -294,12 +315,10 @@</span><br><span>     as=
sert_int_equal(verdict, VERDICT_VALID_RESET_V2);</span><br><span>     free_=
tls_pre_decrypt_state(&amp;state);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    free_tls_pre_decrypt_state(&amp;state);=
</span><br><span>     /* The pre decrypt function should not modify the buf=
fer, so calling it</span><br><span>      * again should have the same resul=
t */</span><br><span>     verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;s=
tate, &amp;from, &amp;buf);</span><br><span>     assert_int_equal(verdict, =
VERDICT_VALID_RESET_V2);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    free_tls_pre_decrypt_state(&amp;state);</span><br><span> </span><br>=
<span>     /* and buf memory should be equal */</span><br><span>     assert=
_memory_equal(BPTR(&amp;buf), client_reset_v2_tls_auth, sizeof(client_reset=
_v2_tls_auth));</span><br><span>@@ -317,7 +336,6 @@</span><br><span>     as=
sert_int_equal(verdict, VERDICT_INVALID);</span><br><span>     free_tls_pre=
_decrypt_state(&amp;state);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    free_tls_pre_decrypt_state(&amp;state);</span><=
br><span>     /* Wrong key direction gives a wrong hmac key and should not =
validate */</span><br><span>     free_key_ctx_bi(&amp;tas.tls_wrap.opt.key_=
ctx_bi);</span><br><span>     free_tas(&amp;tas);</span><br><span>@@ -357,1=
5 +375,12 @@</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_R=
ESET_V2);</span><br><span>     free_tls_pre_decrypt_state(&amp;state);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free=
_tls_pre_decrypt_state(&amp;state);</span><br><span>     buf_reset_len(&amp=
;buf);</span><br><span>     buf_write(&amp;buf, client_reset_v2_tls_crypt, =
sizeof(client_reset_v2_none));</span><br><span>     verdict =3D tls_pre_dec=
rypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</span><br><span>     =
assert_int_equal(verdict, VERDICT_VALID_RESET_V2);</span><br><span>     fre=
e_tls_pre_decrypt_state(&amp;state);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    free_tls_pre_decrypt_state(&amp;state)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
  /* This is not a reset packet and should trigger the other response */</s=
pan><br><span>     buf_reset_len(&amp;buf);</span><br><span>     buf_write(=
&amp;buf, client_ack_tls_auth_randomid, sizeof(client_ack_tls_auth_randomid=
));</span><br><span>@@ -443,7 +458,7 @@</span><br><span>     assert_int_equ=
al(verdict, VERDICT_VALID_CONTROL_V1);</span><br><span> </span><br><span>  =
   /* This is a valid packet but containing a random id instead of an HMAC =
id*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool valid =
=3D check_session_id_hmac(&amp;state, &amp;from.dest, hmac, 30);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_sessi=
on_hmac_and_pkt_id(&amp;state, &amp;from.dest, hmac, 30, false);</span><br>=
<span>     assert_false(valid);</span><br><span> </span><br><span>     free=
_tls_pre_decrypt_state(&amp;state);</span><br><span>@@ -474,7 +489,7 @@</sp=
an><br><span>     verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &a=
mp;from, &amp;buf);</span><br><span>     assert_int_equal(verdict, VERDICT_=
VALID_ACK_V1);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    bool valid =3D check_session_id_hmac(&amp;state, &amp;from.d=
est, hmac, 30);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
bool valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from.dest, hm=
ac, 30, true);</span><br><span>     assert_true(valid);</span><br><span> </=
span><br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br><span=
>@@ -483,6 +498,51 @@</span><br><span>     hmac_ctx_free(hmac);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_verify_hmac_none_out_of_range_ack(void **ut_state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    hmac_ctx_t *hmac =3D session_id_hmac_init();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct link_socket_actual from =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    from.dest.addr.sa.s=
a_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_au=
th_standalone tas =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct tls_pre_decrypt_state state =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(1024);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    enum first_packet_verdict ve=
rdict;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    tas.tls_wrap.mode =3D TLS_WR=
AP_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    buf_reset_len(&amp;buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;bu=
f, client_ack_123_none_random_id, sizeof(client_ack_123_none_random_id));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, =
&amp;from, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* should fail because it acks 2 */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_session_hmac_a=
nd_pkt_id(&amp;state, &amp;from.dest, hmac, 30, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_state(&amp=
;state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Try test with the contr=
ol with a too high message id now */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buf_reset_len(&amp;buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, client_control_none_rando=
m_id, sizeof(client_control_none_random_id));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from=
, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* should fail because it has message id 2 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    valid =3D check_session_hmac_a=
nd_pkt_id(&amp;state, &amp;from.dest, hmac, 30, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    free_tls_pre_decrypt_state(&amp;state);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_cleanup(hmac)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_free(=
hmac);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static hmac_c=
tx_t *</span><br><span> init_static_hmac(void)</span><br><span> {</span><br=
><span>@@ -670,6 +730,7 @@</span><br><span>         cmocka_unit_test(test_c=
alc_session_id_hmac_static),</span><br><span>         cmocka_unit_test(test=
_verify_hmac_none),</span><br><span>         cmocka_unit_test(test_verify_h=
mac_tls_auth),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),</span><br><spa=
n>         cmocka_unit_test(test_generate_reset_packet_plain),</span><br><s=
pan>         cmocka_unit_test(test_generate_reset_packet_tls_auth),</span><=
br><span>         cmocka_unit_test(test_extract_control_message)</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1184?usp=3Demail">change 1184</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1184?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6752dcd5aff3e5cea2b43936647=
9e86751a1c403 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1184 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--i4dwwNYL1lQ=--

