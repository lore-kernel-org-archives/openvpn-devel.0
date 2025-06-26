From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 26 Jun 2025 08:14:23 +0000
In-Reply-To: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
References: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0ce8cd0299fe59653b623aa0f39ebf25341ff1eb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aUJaO1JcKRk="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aUJaO1JcKRk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail

to look at the new patch set (#3).


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

Reported-By: Walter Doekes <walter.openvpn@...2889...>
Tested-By: Walter Doekes <walter.openvpn@...2889...>

Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/mudp.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_pkt.h
M tests/unit_tests/openvpn/test_pkt.c
4 files changed, 112 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1067/3

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 93e65e0..9cd667c 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -63,7 +63,6 @@
     msg(D_MULTI_DEBUG, "Reset packet from client, sending HMAC based reset=
 challenge");
 }

-
 /* Returns true if this packet should create a new session */
 static bool
 do_pre_decrypt_check(struct multi_context *m,
@@ -155,7 +154,8 @@
          * need to contain the peer id */
         struct gc_arena gc =3D gc_new();

-        bool ret =3D check_session_id_hmac(state, from, hmac, handwindow);
+        bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
+        bool ret =3D check_session_id_hmac(state, from, hmac, handwindow, =
pkt_is_ack);

         const char *peer =3D print_link_socket_actual(&m->top.c2.from, &gc=
);
         uint8_t pkt_firstbyte =3D *BPTR( &m->top.c2.buf);
@@ -171,6 +171,7 @@
             msg(D_MULTI_DEBUG, "Valid packet (%s) with HMAC challenge from=
 peer (%s), "
                 "accepting new connection.", packet_opcode_name(op), peer);
         }
+
         gc_free(&gc);

         return ret;
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index bfd405f..0bbc465 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -293,6 +293,7 @@
     }
 }

+
 /*
  * This function is similar to tls_pre_decrypt, except it is called
  * when we are in server mode and receive an initial incoming
@@ -530,7 +531,8 @@
 check_session_id_hmac(struct tls_pre_decrypt_state *state,
                       const struct openvpn_sockaddr *from,
                       hmac_ctx_t *hmac,
-                      int handwindow)
+                      int handwindow,
+                      bool pkt_is_ack)
 {
     if (!from)
     {
@@ -545,6 +547,36 @@
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
index 98a39d3..1b6bcc0 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -180,17 +180,24 @@
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
 bool
 check_session_id_hmac(struct tls_pre_decrypt_state *state,
                       const struct openvpn_sockaddr *from,
                       hmac_ctx_t *hmac,
-                      int handwindow);
+                      int handwindow,
+                      bool pkt_is_ack);

 /*
  * Write a control channel authentication record.
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index ebffabe..56ed842 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -170,6 +170,27 @@
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
@@ -439,7 +460,7 @@
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);

     /* This is a valid packet but containing a random id instead of an HMA=
C id*/
-    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30, fal=
se);
     assert_false(valid);

     free_tls_pre_decrypt_state(&state);
@@ -470,7 +491,7 @@
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);

-    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30, tru=
e);
     assert_true(valid);

     free_tls_pre_decrypt_state(&state);
@@ -479,6 +500,50 @@
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
+    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30, tru=
e);
+    assert_false(valid);
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
+    valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30, true);
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
@@ -667,6 +732,7 @@
         cmocka_unit_test(test_calc_session_id_hmac_static),
         cmocka_unit_test(test_verify_hmac_none),
         cmocka_unit_test(test_verify_hmac_tls_auth),
+        cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
         cmocka_unit_test(test_extract_control_message)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
Gerrit-Change-Number: 1067
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--aUJaO1JcKRk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
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
  Packet (P_ACK_V1) with invalid or missing SID<br><br>instead.<br><br>Repo=
rted-By: Walter Doekes &lt;walter.openvpn@...2889...&gt;<br>Tested-By: Walt=
er Doekes &lt;walter.openvpn@...2889...&gt;<br><br>Change-Id: I6752dcd5aff3=
e5cea2b439366479e86751a1c403<br>Signed-off-by: Arne Schwabe &lt;arne@...2068...=
7...&gt;<br>---<br>M src/openvpn/mudp.c<br>M src/openvpn/ssl_pkt.c<br>M src=
/openvpn/ssl_pkt.h<br>M tests/unit_tests/openvpn/test_pkt.c<br>4 files chan=
ged, 112 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/67/1067/3</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 93e65e0..9cd667c 10064=
4</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvp=
n/mudp.c</span><br><span>@@ -63,7 +63,6 @@</span><br><span>     msg(D_MULTI=
_DEBUG, &quot;Reset packet from client, sending HMAC based reset challenge&=
quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> /* Returns true if this packet sho=
uld create a new session */</span><br><span> static bool</span><br><span> d=
o_pre_decrypt_check(struct multi_context *m,</span><br><span>@@ -155,7 +154=
,8 @@</span><br><span>          * need to contain the peer id */</span><br>=
<span>         struct gc_arena gc =3D gc_new();</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        bool ret =3D check_sess=
ion_id_hmac(state, from, hmac, handwindow);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        bool pkt_is_ack =3D (verdict =3D=3D VERDICT=
_VALID_ACK_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    bool ret =3D check_session_id_hmac(state, from, hmac, handwindow, pkt_i=
s_ack);</span><br><span> </span><br><span>         const char *peer =3D pri=
nt_link_socket_actual(&amp;m-&gt;top.c2.from, &amp;gc);</span><br><span>   =
      uint8_t pkt_firstbyte =3D *BPTR( &amp;m-&gt;top.c2.buf);</span><br><s=
pan>@@ -171,6 +171,7 @@</span><br><span>             msg(D_MULTI_DEBUG, &qu=
ot;Valid packet (%s) with HMAC challenge from peer (%s), &quot;</span><br><=
span>                 &quot;accepting new connection.&quot;, packet_opcode_=
name(op), peer);</span><br><span>         }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>         gc_free(&amp;gc);</span><=
br><span> </span><br><span>         return ret;</span><br><span>diff --git =
a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</span><br><span>index bfd40=
5f..0bbc465 100644</span><br><span>--- a/src/openvpn/ssl_pkt.c</span><br><s=
pan>+++ b/src/openvpn/ssl_pkt.c</span><br><span>@@ -293,6 +293,7 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
This function is similar to tls_pre_decrypt, except it is called</span><br>=
<span>  * when we are in server mode and receive an initial incoming</span>=
<br><span>@@ -530,7 +531,8 @@</span><br><span> check_session_id_hmac(struct=
 tls_pre_decrypt_state *state,</span><br><span>                       const=
 struct openvpn_sockaddr *from,</span><br><span>                       hmac=
_ctx_t *hmac,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
              int handwindow)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                      int handwindow,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                      bool pkt_is_ack)</span><b=
r><span> {</span><br><span>     if (!from)</span><br><span>     {</span><br=
><span>@@ -545,6 +547,36 @@</span><br><span>         return false;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* Check if the packet ID of the packet or ACKED packet  i=
s &lt;=3D 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
or (int i =3D 0; i &lt; ack.len; i++)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* This packet ACKs a packet that has a higher packet id than t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * ones e=
xpected in the three-way handshake, consider it as invalid</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * for the session */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ack.packet_id[=
i] &gt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!pkt_is_ack)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        packet_id_type message_id;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* Extract the packet ID from the packet */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!reliable_=
ack_read_packet_id(&amp;buf, &amp;message_id))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* similar check. Anything larger than 1 is not considered part of the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * three-way h=
andshake */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (message_id &gt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     /* check adjacent time=
stamps too */</span><br><span>     for (int offset =3D -2; offset &lt;=3D 1=
; offset++)</span><br><span>     {</span><br><span>diff --git a/src/openvpn=
/ssl_pkt.h b/src/openvpn/ssl_pkt.h</span><br><span>index 98a39d3..1b6bcc0 1=
00644</span><br><span>--- a/src/openvpn/ssl_pkt.h</span><br><span>+++ b/src=
/openvpn/ssl_pkt.h</span><br><span>@@ -180,17 +180,24 @@</span><br><span> /=
**</span><br><span>  * Checks if a control packet has a correct HMAC server=
 session id</span><br><span>  *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * This will also consider packets that have a packet id higher=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * than 1 or ack pa=
ckets higher than 1 to be invalid as they are</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * not part of the initial three way handshake of=
 OpenVPN and should</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * not create a new connection.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span>  * @param state         session information=
</span><br><span>  * @param from          link_socket from the client</span=
><br><span>  * @param hmac          the hmac context to use for the calcula=
tion</span><br><span>  * @param handwindow    the quantisation of the curre=
nt time</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pk=
t_is_ack    the packet being checked is a P_ACK_V1</span><br><span>  * @ret=
urn              the expected server session id</span><br><span>  */</span>=
<br><span> bool</span><br><span> check_session_id_hmac(struct tls_pre_decry=
pt_state *state,</span><br><span>                       const struct openvp=
n_sockaddr *from,</span><br><span>                       hmac_ctx_t *hmac,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
int handwindow);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   int handwindow,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                      bool pkt_is_ack);</span><br><span> </s=
pan><br><span> /*</span><br><span>  * Write a control channel authenticatio=
n record.</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt.c =
b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>index ebffabe..56ed84=
2 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt.c</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>@@ -170,6=
 +170,27 @@</span><br><span>     0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e</=
span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* no tls-auth, P_ACK_V1, acks 0,1, and 2 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+const uint8_t client_ack_123_none=
_random_id[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   0x28,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xae, 0=
xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    0x03,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    0x00, 0x00, 0x00, 0x00,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    0x00, 0x00, 0x00, 0x01,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    0x00, 0x00, 0x00, 0x02,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    0xdd, 0x85, 0xdb, 0x53, 0x56, 0x23, =
0xb0, 0x2e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* no tls-auth, P_CONTROL_V1, acks 0, msg-id =
2 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const uint8_t c=
lient_control_none_random_id[] =3D {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    0x20,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    0x01,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    0x00, 0x00, 0x00, 0x00,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    0x02</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> struct tls_auth_standalone</span><br><span> init_tas_auth(int key_d=
irection)</span><br><span> {</span><br><span>@@ -439,7 +460,7 @@</span><br>=
<span>     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);</span><br><=
span> </span><br><span>     /* This is a valid packet but containing a rand=
om id instead of an HMAC id*/</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    bool valid =3D check_session_id_hmac(&amp;state, &amp;from.dest=
, hmac, 30);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l valid =3D check_session_id_hmac(&amp;state, &amp;from.dest, hmac, 30, fal=
se);</span><br><span>     assert_false(valid);</span><br><span> </span><br>=
<span>     free_tls_pre_decrypt_state(&amp;state);</span><br><span>@@ -470,=
7 +491,7 @@</span><br><span>     verdict =3D tls_pre_decrypt_lite(&amp;tas,=
 &amp;state, &amp;from, &amp;buf);</span><br><span>     assert_int_equal(ve=
rdict, VERDICT_VALID_ACK_V1);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    bool valid =3D check_session_id_hmac(&amp;sta=
te, &amp;from.dest, hmac, 30);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool valid =3D check_session_id_hmac(&amp;state, &amp;from.d=
est, hmac, 30, true);</span><br><span>     assert_true(valid);</span><br><s=
pan> </span><br><span>     free_tls_pre_decrypt_state(&amp;state);</span><b=
r><span>@@ -479,6 +500,50 @@</span><br><span>     hmac_ctx_free(hmac);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_verify_hmac_none_out_of_range_ack(void **ut_state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    hmac_ctx_t *hmac =3D session_id_hmac_init();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_actual from =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    from.dest.a=
ddr.sa.sa_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tls_auth_standalone tas =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct tls_pre_decrypt_state state =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(1024);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum first_packet_ve=
rdict verdict;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas.tls_wrap.mode =
=3D TLS_WRAP_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_reset_len(&a=
mp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_wri=
te(&amp;buf, client_ack_123_none_random_id, sizeof(client_ack_123_none_rand=
om_id));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    verdict =3D tls_pre_decrypt_lite(&amp;tas, &a=
mp;state, &amp;from, &amp;buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* should fail because it acks 2 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_sess=
ion_id_hmac(&amp;state, &amp;from.dest, hmac, 30, true);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Try test with the control with a too high mes=
sage id now */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_reset_len(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    buf_write(&amp;buf, client_control_none_random_id, sizeof(client_co=
ntrol_none_random_id));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    verdict =3D=
 tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(verdict,=
 VERDICT_VALID_CONTROL_V1);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* shou=
ld fail because it has message id 2 */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    valid =3D check_session_id_hmac(&amp;state, &amp;fro=
m.dest, hmac, 30, true);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(valid);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_=
tls_pre_decrypt_state(&amp;state);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    hmac_ctx_cleanup(hmac);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    hmac_ctx_free(hmac);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static hmac_ctx_t *</span><br><span> init=
_static_hmac(void)</span><br><span> {</span><br><span>@@ -667,6 +732,7 @@</=
span><br><span>         cmocka_unit_test(test_calc_session_id_hmac_static),=
</span><br><span>         cmocka_unit_test(test_verify_hmac_none),</span><b=
r><span>         cmocka_unit_test(test_verify_hmac_tls_auth),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_ver=
ify_hmac_none_out_of_range_ack),</span><br><span>         cmocka_unit_test(=
test_generate_reset_packet_plain),</span><br><span>         cmocka_unit_tes=
t(test_generate_reset_packet_tls_auth),</span><br><span>         cmocka_uni=
t_test(test_extract_control_message)</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Dem=
ail">change 1067</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6752dcd5aff3e5cea2b43936647=
9e86751a1c403 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1067 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--aUJaO1JcKRk=--

