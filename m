From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 15 Aug 2025 13:58:49 +0000
In-Reply-To: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
References: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <c95289a671abcb944e2e9471eefe530d64ea0655-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iJpLicr0gn4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Check message
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

--iJpLicr0gn4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail

to look at the new patch set (#6).


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
ids 0 or 1 from any later packet.

This will now trigger (at verb 4 or higher) a messaged like:

   Packet (P_ACK_V1) with invalid or missing SID

instead.

Also remove a few duplicated free_tls_pre_decrypt_state in test_ssl.

Reported-By: Walter Doekes <walter.openvpn@...2889...>
Tested-By: Walter Doekes <walter.openvpn@...2889...>

Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/mudp.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_pkt.h
M tests/unit_tests/openvpn/test_pkt.c
4 files changed, 129 insertions(+), 24 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1067/6

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 7259a4b..31134be 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -151,7 +151,8 @@
          * need to contain the peer id */
         struct gc_arena gc =3D gc_new();

-        bool ret =3D check_session_id_hmac(state, from, hmac, handwindow);
+        bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
+        bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac, hand=
window, pkt_is_ack);

         const char *peer =3D print_link_socket_actual(&m->top.c2.from, &gc=
);
         uint8_t pkt_firstbyte =3D *BPTR(&m->top.c2.buf);
@@ -159,7 +160,8 @@

         if (!ret)
         {
-            msg(D_MULTI_MEDIUM, "Packet (%s) with invalid or missing SID f=
rom %s",
+            msg(D_MULTI_MEDIUM, "Packet (%s) with invalid or missing SID f=
rom"
+                                " %s or wrong packet id",
                 packet_opcode_name(op), peer);
         }
         else
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index b901f87..6ec05a7 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -496,8 +496,11 @@
 }

 bool
-check_session_id_hmac(struct tls_pre_decrypt_state *state, const struct op=
envpn_sockaddr *from,
-                      hmac_ctx_t *hmac, int handwindow)
+check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
+                              const struct openvpn_sockaddr *from,
+                              hmac_ctx_t *hmac,
+                              int handwindow,
+                              bool pkt_is_ack)
 {
     if (!from)
     {
@@ -512,6 +515,36 @@
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
index 8fe4880..96cdd68 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -178,14 +178,20 @@
 /**
  * Checks if a control packet has a correct HMAC server session id
  *
+ * This will also consider packets that have a packet id higher
+ * than 1 or ack packets higher than 1 to be invalid as they are
+ * not part of the initial three way handshake of OpenVPN and should
+ * not create a new connection.
+ *
  * @param state         session information
  * @param from          link_socket from the client
  * @param hmac          the hmac context to use for the calculation
  * @param handwindow    the quantisation of the current time
+ * @param pkt_is_ack    the packet being checked is a P_ACK_V1
  * @return              the expected server session id
  */
-bool check_session_id_hmac(struct tls_pre_decrypt_state *state, const stru=
ct openvpn_sockaddr *from,
-                           hmac_ctx_t *hmac, int handwindow);
+bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, co=
nst struct openvpn_sockaddr *from,
+                                   hmac_ctx_t *hmac, int handwindow, bool =
pkt_is_ack);

 /*
  * Write a control channel authentication record.
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 65b31e7..5122766 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -139,6 +139,27 @@
                                               0xc8, 0x01, 0x00, 0x00, 0x00=
, 0x00, 0xdd, 0x85,
                                               0xdb, 0x53, 0x56, 0x23, 0xb0=
, 0x2e };

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
@@ -256,12 +277,10 @@
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
@@ -279,7 +298,6 @@
     assert_int_equal(verdict, VERDICT_INVALID);
     free_tls_pre_decrypt_state(&state);

-    free_tls_pre_decrypt_state(&state);
     /* Wrong key direction gives a wrong hmac key and should not validate =
*/
     free_key_ctx_bi(&tas.tls_wrap.opt.key_ctx_bi);
     free_tas(&tas);
@@ -319,15 +337,12 @@
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
@@ -405,7 +420,7 @@
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);

     /* This is a valid packet but containing a random id instead of an HMA=
C id*/
-    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid =3D check_session_hmac_and_pkt_id(&state, &from.dest, hmac,=
 30, false);
     assert_false(valid);

     free_tls_pre_decrypt_state(&state);
@@ -436,7 +451,7 @@
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);

-    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid =3D check_session_hmac_and_pkt_id(&state, &from.dest, hmac,=
 30, true);
     assert_true(valid);

     free_tls_pre_decrypt_state(&state);
@@ -445,6 +460,51 @@
     hmac_ctx_free(hmac);
 }

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
@@ -634,16 +694,20 @@
 main(void)
 {
     openvpn_unit_test_setup();
-    const struct CMUnitTest tests[] =3D { cmocka_unit_test(test_tls_decryp=
t_lite_none),
-                                        cmocka_unit_test(test_tls_decrypt_=
lite_auth),
-                                        cmocka_unit_test(test_tls_decrypt_=
lite_crypt),
-                                        cmocka_unit_test(test_parse_ack),
-                                        cmocka_unit_test(test_calc_session=
_id_hmac_static),
-                                        cmocka_unit_test(test_verify_hmac_=
none),
-                                        cmocka_unit_test(test_verify_hmac_=
tls_auth),
-                                        cmocka_unit_test(test_generate_res=
et_packet_plain),
-                                        cmocka_unit_test(test_generate_res=
et_packet_tls_auth),
-                                        cmocka_unit_test(test_extract_cont=
rol_message) };
+
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_tls_decrypt_lite_none),
+        cmocka_unit_test(test_tls_decrypt_lite_auth),
+        cmocka_unit_test(test_tls_decrypt_lite_crypt),
+        cmocka_unit_test(test_parse_ack),
+        cmocka_unit_test(test_calc_session_id_hmac_static),
+        cmocka_unit_test(test_verify_hmac_none),
+        cmocka_unit_test(test_verify_hmac_tls_auth),
+        cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
+        cmocka_unit_test(test_generate_reset_packet_plain),
+        cmocka_unit_test(test_generate_reset_packet_tls_auth),
+        cmocka_unit_test(test_extract_control_message)
+    };

 #if defined(ENABLE_CRYPTO_OPENSSL)
     OpenSSL_add_all_algorithms();

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
Gerrit-Change-Number: 1067
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--iJpLicr0gn4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Check message id/acked ids too when doing sessionid cookie checks<br=
><br>This fixes that control packets on a floating client can trigger<br>cr=
eating a new session in special circumstances:<br><br>To trigger this circu=
mstance a connection needs to<br><br>- starts on IP A<br>- successfully flo=
ats to IP B by data packet<br>- then has a control packet from IP A before =
any<br>  data packet can trigger the float back to IP A<br><br>and all of t=
his needs to happen in the 60s time<br>that hmac cookie is valid in the def=
ault<br>configuration.<br><br>In this scenario we would trigger a new conne=
ction as the HMAC<br>session id would be valid.<br><br>This patch adds chec=
king also of the message-id and acked ids to<br>discern packet from the ini=
tial three-way handshake where these<br>ids 0 or 1 from any later packet.<b=
r><br>This will now trigger (at verb 4 or higher) a messaged like:<br><br> =
  Packet (P_ACK_V1) with invalid or missing SID<br><br>instead.<br><br>Also=
 remove a few duplicated free_tls_pre_decrypt_state in test_ssl.<br><br>Rep=
orted-By: Walter Doekes &lt;walter.openvpn@...2889...&gt;<br>Tested-By: Wal=
ter Doekes &lt;walter.openvpn@...2889...&gt;<br><br>Change-Id: I6752dcd5aff=
3e5cea2b439366479e86751a1c403<br>Signed-off-by: Arne Schwabe &lt;arne@...1711...=
27...&gt;<br>---<br>M src/openvpn/mudp.c<br>M src/openvpn/ssl_pkt.c<br>M sr=
c/openvpn/ssl_pkt.h<br>M tests/unit_tests/openvpn/test_pkt.c<br>4 files cha=
nged, 129 insertions(+), 24 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/67/1067/6</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 7259a4b..31134be 100=
644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/open=
vpn/mudp.c</span><br><span>@@ -151,7 +151,8 @@</span><br><span>          * =
need to contain the peer id */</span><br><span>         struct gc_arena gc =
=3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        bool ret =3D check_session_id_hmac(state, from, hmac, han=
dwindow);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bo=
ol pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        bool ret =3D check_session_hma=
c_and_pkt_id(state, from, hmac, handwindow, pkt_is_ack);</span><br><span> <=
/span><br><span>         const char *peer =3D print_link_socket_actual(&amp=
;m-&gt;top.c2.from, &amp;gc);</span><br><span>         uint8_t pkt_firstbyt=
e =3D *BPTR(&amp;m-&gt;top.c2.buf);</span><br><span>@@ -159,7 +160,8 @@</sp=
an><br><span> </span><br><span>         if (!ret)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MU=
LTI_MEDIUM, &quot;Packet (%s) with invalid or missing SID from %s&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULT=
I_MEDIUM, &quot;Packet (%s) with invalid or missing SID from&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    &quot; %s or wrong packet id&quot;,</span><br><span>                 pa=
cket_opcode_name(op), peer);</span><br><span>         }</span><br><span>   =
      else</span><br><span>diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn=
/ssl_pkt.c</span><br><span>index b901f87..6ec05a7 100644</span><br><span>--=
- a/src/openvpn/ssl_pkt.c</span><br><span>+++ b/src/openvpn/ssl_pkt.c</span=
><br><span>@@ -496,8 +496,11 @@</span><br><span> }</span><br><span> </span>=
<br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_=
session_id_hmac(struct tls_pre_decrypt_state *state, const struct openvpn_s=
ockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
               hmac_ctx_t *hmac, int handwindow)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+check_session_hmac_and_pkt_id(struct tls_pre_d=
ecrypt_state *state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                              const struct openvpn_sockaddr *from,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
   hmac_ctx_t *hmac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                              int handwindow,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                              bool pkt_is_ack)</=
span><br><span> {</span><br><span>     if (!from)</span><br><span>     {</s=
pan><br><span>@@ -512,6 +515,36 @@</span><br><span>         return false;</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Check if the packet ID of the packet or ACKED pa=
cket  is &lt;=3D 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (int i =3D 0; i &lt; ack.len; i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* This packet ACKs a packet that has a higher packet id=
 than the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 ones expected in the three-way handshake, consider it as invalid</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * for the session */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ack.pac=
ket_id[i] &gt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!pkt_is_ack)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        packet_id_type message_id;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* Extract the packet ID from the packe=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!re=
liable_ack_read_packet_id(&amp;buf, &amp;message_id))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* similar check. Anything larger than 1 is not considered part of=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * thre=
e-way handshake */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (message_id &gt; 1)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* check adjace=
nt timestamps too */</span><br><span>     for (int offset =3D -2; offset &l=
t;=3D 1; offset++)</span><br><span>     {</span><br><span>diff --git a/src/=
openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h</span><br><span>index 8fe4880..96=
cdd68 100644</span><br><span>--- a/src/openvpn/ssl_pkt.h</span><br><span>++=
+ b/src/openvpn/ssl_pkt.h</span><br><span>@@ -178,14 +178,20 @@</span><br><=
span> /**</span><br><span>  * Checks if a control packet has a correct HMAC=
 server session id</span><br><span>  *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * This will also consider packets that have a packet id=
 higher</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * than 1 or=
 ack packets higher than 1 to be invalid as they are</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * not part of the initial three way hand=
shake of OpenVPN and should</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * not create a new connection.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span>  * @param state         session inf=
ormation</span><br><span>  * @param from          link_socket from the clie=
nt</span><br><span>  * @param hmac          the hmac context to use for the=
 calculation</span><br><span>  * @param handwindow    the quantisation of t=
he current time</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param pkt_is_ack    the packet being checked is a P_ACK_V1</span><br><span>=
  * @return              the expected server session id</span><br><span>  *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_session_i=
d_hmac(struct tls_pre_decrypt_state *state, const struct openvpn_sockaddr *=
from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
           hmac_ctx_t *hmac, int handwindow);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool check_session_hmac_and_pkt_id(struct tls_pre=
_decrypt_state *state, const struct openvpn_sockaddr *from,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
hmac_ctx_t *hmac, int handwindow, bool pkt_is_ack);</span><br><span> </span=
><br><span> /*</span><br><span>  * Write a control channel authentication r=
ecord.</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt.c b/t=
ests/unit_tests/openvpn/test_pkt.c</span><br><span>index 65b31e7..5122766 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt.c</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>@@ -139,6 +1=
39,27 @@</span><br><span>                                               0xc=
8, 0x01, 0x00, 0x00, 0x00, 0x00, 0xdd, 0x85,</span><br><span>              =
                                 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e };</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* no =
tls-auth, P_ACK_V1, acks 0,1, and 2 */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+const uint8_t client_ack_123_none_random_id[] =3D {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x28,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    0xae, 0xb9, 0xaf, 0xe1, 0xf0, =
0x1d, 0x79, 0xc8,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  0x03,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x00, 0x=
00, 0x00, 0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
0x00, 0x00, 0x00, 0x01,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0x00, 0x00, 0x00, 0x02,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    0xdd, 0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* no tls-auth, P_CONTROL_V1, acks 0, msg-id 2 */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+const uint8_t client_control_none_rand=
om_id[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x=
20,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xae, 0xb9, =
0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    0x01,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    0x00, 0x00, 0x00, 0x00,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    0x02</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct tls_auth=
_standalone</span><br><span> init_tas_auth(int key_direction)</span><br><sp=
an> {</span><br><span>@@ -256,12 +277,10 @@</span><br><span>     assert_int=
_equal(verdict, VERDICT_VALID_RESET_V2);</span><br><span>     free_tls_pre_=
decrypt_state(&amp;state);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    free_tls_pre_decrypt_state(&amp;state);</span><b=
r><span>     /* The pre decrypt function should not modify the buffer, so c=
alling it</span><br><span>      * again should have the same result */</spa=
n><br><span>     verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &am=
p;from, &amp;buf);</span><br><span>     assert_int_equal(verdict, VERDICT_V=
ALID_RESET_V2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fr=
ee_tls_pre_decrypt_state(&amp;state);</span><br><span> </span><br><span>   =
  /* and buf memory should be equal */</span><br><span>     assert_memory_e=
qual(BPTR(&amp;buf), client_reset_v2_tls_auth, sizeof(client_reset_v2_tls_a=
uth));</span><br><span>@@ -279,7 +298,6 @@</span><br><span>     assert_int_=
equal(verdict, VERDICT_INVALID);</span><br><span>     free_tls_pre_decrypt_=
state(&amp;state);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    free_tls_pre_decrypt_state(&amp;state);</span><br><span>=
     /* Wrong key direction gives a wrong hmac key and should not validate =
*/</span><br><span>     free_key_ctx_bi(&amp;tas.tls_wrap.opt.key_ctx_bi);<=
/span><br><span>     free_tas(&amp;tas);</span><br><span>@@ -319,15 +337,12=
 @@</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);=
</span><br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free_tls_pre_=
decrypt_state(&amp;state);</span><br><span>     buf_reset_len(&amp;buf);</s=
pan><br><span>     buf_write(&amp;buf, client_reset_v2_tls_crypt, sizeof(cl=
ient_reset_v2_none));</span><br><span>     verdict =3D tls_pre_decrypt_lite=
(&amp;tas, &amp;state, &amp;from, &amp;buf);</span><br><span>     assert_in=
t_equal(verdict, VERDICT_VALID_RESET_V2);</span><br><span>     free_tls_pre=
_decrypt_state(&amp;state);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    free_tls_pre_decrypt_state(&amp;state);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* This=
 is not a reset packet and should trigger the other response */</span><br><=
span>     buf_reset_len(&amp;buf);</span><br><span>     buf_write(&amp;buf,=
 client_ack_tls_auth_randomid, sizeof(client_ack_tls_auth_randomid));</span=
><br><span>@@ -405,7 +420,7 @@</span><br><span>     assert_int_equal(verdic=
t, VERDICT_VALID_CONTROL_V1);</span><br><span> </span><br><span>     /* Thi=
s is a valid packet but containing a random id instead of an HMAC id*/</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check_s=
ession_id_hmac(&amp;state, &amp;from.dest, hmac, 30);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_session_hmac_and=
_pkt_id(&amp;state, &amp;from.dest, hmac, 30, false);</span><br><span>     =
assert_false(valid);</span><br><span> </span><br><span>     free_tls_pre_de=
crypt_state(&amp;state);</span><br><span>@@ -436,7 +451,7 @@</span><br><spa=
n>     verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &a=
mp;buf);</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V=
1);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    bool valid =3D check_session_id_hmac(&amp;state, &amp;from.dest, hmac, =
30);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =
=3D check_session_hmac_and_pkt_id(&amp;state, &amp;from.dest, hmac, 30, tru=
e);</span><br><span>     assert_true(valid);</span><br><span> </span><br><s=
pan>     free_tls_pre_decrypt_state(&amp;state);</span><br><span>@@ -445,6 =
+460,51 @@</span><br><span>     hmac_ctx_free(hmac);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_verify_h=
mac_none_out_of_range_ack(void **ut_state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    hmac_ctx_t *hmac =3D session_id_hmac_init();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct link_socket_actual from =3D { 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    from.dest.addr.sa.sa_family =
=3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standa=
lone tas =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer buf =3D alloc_buf(1024);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    enum first_packet_verdict verdict;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tas.tls_wrap.mode =3D TLS_WRAP_NONE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buf_reset_len(&amp;buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, client=
_ack_123_none_random_id, sizeof(client_ack_123_none_random_id));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from=
, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* should fail because it acks 2 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool valid =3D check_session_hmac_and_pkt_id=
(&amp;state, &amp;from.dest, hmac, 30, true);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_false(valid);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_state(&amp;state);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Try test with the control with a=
 too high message id now */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    buf_reset_len(&amp;buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buf_write(&amp;buf, client_control_none_random_id, siz=
eof(client_control_none_random_id));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(verdict, VERDICT_VALID_CONTROL_V1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* should fail because it has message id 2 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    valid =3D check_session_hmac_and_pkt_=
id(&amp;state, &amp;from.dest, hmac, 30, true);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(valid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free_tls_pre_decrypt_state(&amp;state);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_cleanup(hmac);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_free(hmac);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static hmac_ctx_t *=
</span><br><span> init_static_hmac(void)</span><br><span> {</span><br><span=
>@@ -634,16 +694,20 @@</span><br><span> main(void)</span><br><span> {</span=
><br><span>     openvpn_unit_test_setup();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const struct CMUnitTest tests[] =3D { cmocka_unit_=
test(test_tls_decrypt_lite_none),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                        cmocka_unit_test(test_t=
ls_decrypt_lite_auth),</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                        cmocka_unit_test(test_tls_decrypt_=
lite_crypt),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                               cmocka_unit_test(test_parse_ack),</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
        cmocka_unit_test(test_calc_session_id_hmac_static),</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
   cmocka_unit_test(test_verify_hmac_none),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                        cmocka_unit_t=
est(test_verify_hmac_tls_auth),</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                        cmocka_unit_test(test_gen=
erate_reset_packet_plain),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                        cmocka_unit_test(test_generate=
_reset_packet_tls_auth),</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                        cmocka_unit_test(test_extract_co=
ntrol_message) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct CMUn=
itTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_tls_decrypt_lite_none),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tls_decryp=
t_lite_auth),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(test_tls_decrypt_lite_crypt),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_parse_ack),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_calc_session_id_hmac_static),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_verify_hmac_none),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
verify_hmac_tls_auth),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_generate_reset_packet_plain),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(test_generate_reset_packet_tls_auth)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_extract_control_message)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    };</span><br><span> </span><br><span> #if defined(ENAB=
LE_CRYPTO_OPENSSL)</span><br><span>     OpenSSL_add_all_algorithms();</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1067?usp=3Demail">change 1067</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1067?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6752dcd5aff3e5cea2b43936647=
9e86751a1c403 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1067 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--iJpLicr0gn4=--

