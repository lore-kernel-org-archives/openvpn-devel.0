From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 25 Jun 2025 12:38:09 +0000
References: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <82969827b512e02ca869fbe6203cb2cbc15ccf8f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q22yHoiD5Ms="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Check message-id too
 when doing sessionid cookie
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

--Q22yHoiD5Ms=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail

to review the following change.


Change subject: Check message-id too when doing sessionid cookie
......................................................................

Check message-id too when doing sessionid cookie

This fixes that control packets on a floating client can trigger
creating a new session in rare instances.

Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
---
M src/openvpn/mudp.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_pkt.h
M tests/unit_tests/openvpn/test_pkt.c
4 files changed, 96 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1067/1

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
index bfd405f..4b28798 100644
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
+        /* same check. Anything larger than 1 is not considered part of the
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
index 98a39d3..53c1a5c 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -94,6 +94,9 @@
     VERDICT_VALID_ACK_V1,
     /** The packet is a valid control packet with appended wrapped client =
key */
     VERDICT_VALID_WKC_V1,
+    /** the packet is valid but failed the check of being belong to the pa=
ckets
+     * that could be in the three-handshake */
+    VERDICT_INVALID_PKTID,
     /** the packet failed on of the various checks */
     VERDICT_INVALID
 };
@@ -180,17 +183,24 @@
 /**
  * Checks if a control packet has a correct HMAC server session id
  *
+ * This will also consider packets that have a packet id higher
+ * than 1 to be invalid as they are not part of the initial
+ * three way handshake of OpenVPN and should not create a new
+ * connection.
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
+                      bool check_session_id_hmac);

 /*
  * Write a control channel authentication record.
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index ebffabe..09fba8c 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -170,6 +170,17 @@
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
 struct tls_auth_standalone
 init_tas_auth(int key_direction)
 {
@@ -439,7 +450,7 @@
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);

     /* This is a valid packet but containing a random id instead of an HMA=
C id*/
-    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30, fal=
se);
     assert_false(valid);

     free_tls_pre_decrypt_state(&state);
@@ -470,7 +481,7 @@
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);

-    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid =3D check_session_id_hmac(&state, &from.dest, hmac, 30, tru=
e);
     assert_true(valid);

     free_tls_pre_decrypt_state(&state);
@@ -479,6 +490,41 @@
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
+    free_tls_pre_decrypt_state(&state);
+    free_buf(&buf);
+    hmac_ctx_cleanup(hmac);
+    hmac_ctx_free(hmac);
+}
+
+
+
 static hmac_ctx_t *
 init_static_hmac(void)
 {
@@ -667,6 +713,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Q22yHoiD5Ms=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Check message-id too when doing sessionid cookie<br><br>This=
 fixes that control packets on a floating client can trigger<br>creating a =
new session in rare instances.<br><br>Change-Id: I6752dcd5aff3e5cea2b439366=
479e86751a1c403<br>---<br>M src/openvpn/mudp.c<br>M src/openvpn/ssl_pkt.c<b=
r>M src/openvpn/ssl_pkt.h<br>M tests/unit_tests/openvpn/test_pkt.c<br>4 fil=
es changed, 96 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/67/1067/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 93e65e0..9cd667c=
 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/=
openvpn/mudp.c</span><br><span>@@ -63,7 +63,6 @@</span><br><span>     msg(D=
_MULTI_DEBUG, &quot;Reset packet from client, sending HMAC based reset chal=
lenge&quot;);</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> /* Returns true if this pack=
et should create a new session */</span><br><span> static bool</span><br><s=
pan> do_pre_decrypt_check(struct multi_context *m,</span><br><span>@@ -155,=
7 +154,8 @@</span><br><span>          * need to contain the peer id */</spa=
n><br><span>         struct gc_arena gc =3D gc_new();</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool ret =3D chec=
k_session_id_hmac(state, from, hmac, handwindow);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        bool pkt_is_ack =3D (verdict =3D=3D V=
ERDICT_VALID_ACK_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        bool ret =3D check_session_id_hmac(state, from, hmac, handwindow,=
 pkt_is_ack);</span><br><span> </span><br><span>         const char *peer =
=3D print_link_socket_actual(&amp;m-&gt;top.c2.from, &amp;gc);</span><br><s=
pan>         uint8_t pkt_firstbyte =3D *BPTR( &amp;m-&gt;top.c2.buf);</span=
><br><span>@@ -171,6 +171,7 @@</span><br><span>             msg(D_MULTI_DEB=
UG, &quot;Valid packet (%s) with HMAC challenge from peer (%s), &quot;</spa=
n><br><span>                 &quot;accepting new connection.&quot;, packet_=
opcode_name(op), peer);</span><br><span>         }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>         gc_free(&amp;gc);<=
/span><br><span> </span><br><span>         return ret;</span><br><span>diff=
 --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</span><br><span>inde=
x bfd405f..4b28798 100644</span><br><span>--- a/src/openvpn/ssl_pkt.c</span=
><br><span>+++ b/src/openvpn/ssl_pkt.c</span><br><span>@@ -293,6 +293,7 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><spa=
n>  * This function is similar to tls_pre_decrypt, except it is called</spa=
n><br><span>  * when we are in server mode and receive an initial incoming<=
/span><br><span>@@ -530,7 +531,8 @@</span><br><span> check_session_id_hmac(=
struct tls_pre_decrypt_state *state,</span><br><span>                      =
 const struct openvpn_sockaddr *from,</span><br><span>                     =
  hmac_ctx_t *hmac,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                    int handwindow)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                      int handwindow,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      bool pkt_is_ack)</s=
pan><br><span> {</span><br><span>     if (!from)</span><br><span>     {</sp=
an><br><span>@@ -545,6 +547,36 @@</span><br><span>         return false;</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Check if the packet ID of the packet or ACKED pac=
ket  is &lt;=3D 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (int i =3D 0; i &lt; ack.len; i++)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* This packet ACKs a packet that has a higher packet id =
than the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
ones expected in the three-way handshake, consider it as invalid</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * for the session */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ack.pack=
et_id[i] &gt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!pkt_is_ack)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        packet_id_type message_id;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* Extract the packet ID from the packet=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!rel=
iable_ack_read_packet_id(&amp;buf, &amp;message_id))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* same check. Anything larger than 1 is not considered part of th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * three-w=
ay handshake */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (message_id &gt; 1)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* check adjacent =
timestamps too */</span><br><span>     for (int offset =3D -2; offset &lt;=
=3D 1; offset++)</span><br><span>     {</span><br><span>diff --git a/src/op=
envpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h</span><br><span>index 98a39d3..53c1=
a5c 100644</span><br><span>--- a/src/openvpn/ssl_pkt.h</span><br><span>+++ =
b/src/openvpn/ssl_pkt.h</span><br><span>@@ -94,6 +94,9 @@</span><br><span> =
    VERDICT_VALID_ACK_V1,</span><br><span>     /** The packet is a valid co=
ntrol packet with appended wrapped client key */</span><br><span>     VERDI=
CT_VALID_WKC_V1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /** the packet is valid but failed the check of being belong to the packet=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * that could =
be in the three-handshake */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    VERDICT_INVALID_PKTID,</span><br><span>     /** the packet fai=
led on of the various checks */</span><br><span>     VERDICT_INVALID</span>=
<br><span> };</span><br><span>@@ -180,17 +183,24 @@</span><br><span> /**</s=
pan><br><span>  * Checks if a control packet has a correct HMAC server sess=
ion id</span><br><span>  *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * This will also consider packets that have a packet id higher</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * than 1 to be invalid =
as they are not part of the initial</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * three way handshake of OpenVPN and should not create a n=
ew</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connection.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span>  *=
 @param state         session information</span><br><span>  * @param from  =
        link_socket from the client</span><br><span>  * @param hmac        =
  the hmac context to use for the calculation</span><br><span>  * @param ha=
ndwindow    the quantisation of the current time</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param pkt_is_ack    the packet being check=
ed is a P_ACK_V1</span><br><span>  * @return              the expected serv=
er session id</span><br><span>  */</span><br><span> bool</span><br><span> c=
heck_session_id_hmac(struct tls_pre_decrypt_state *state,</span><br><span> =
                      const struct openvpn_sockaddr *from,</span><br><span>=
                       hmac_ctx_t *hmac,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                      int handwindow);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                      int handwindow,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
   bool check_session_id_hmac);</span><br><span> </span><br><span> /*</span=
><br><span>  * Write a control channel authentication record.</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/open=
vpn/test_pkt.c</span><br><span>index ebffabe..09fba8c 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_pkt.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_pkt.c</span><br><span>@@ -170,6 +170,17 @@</span><br><=
span>     0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e</span><br><span> };</spa=
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
r: hsl(120, 100%, 40%);">+</span><br><span> struct tls_auth_standalone</spa=
n><br><span> init_tas_auth(int key_direction)</span><br><span> {</span><br>=
<span>@@ -439,7 +450,7 @@</span><br><span>     assert_int_equal(verdict, VE=
RDICT_VALID_CONTROL_V1);</span><br><span> </span><br><span>     /* This is =
a valid packet but containing a random id instead of an HMAC id*/</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check_sessio=
n_id_hmac(&amp;state, &amp;from.dest, hmac, 30);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool valid =3D check_session_id_hmac(&amp;=
state, &amp;from.dest, hmac, 30, false);</span><br><span>     assert_false(=
valid);</span><br><span> </span><br><span>     free_tls_pre_decrypt_state(&=
amp;state);</span><br><span>@@ -470,7 +481,7 @@</span><br><span>     verdic=
t =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</spa=
n><br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool vali=
d =3D check_session_id_hmac(&amp;state, &amp;from.dest, hmac, 30);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_ses=
sion_id_hmac(&amp;state, &amp;from.dest, hmac, 30, true);</span><br><span> =
    assert_true(valid);</span><br><span> </span><br><span>     free_tls_pre=
_decrypt_state(&amp;state);</span><br><span>@@ -479,6 +490,41 @@</span><br>=
<span>     hmac_ctx_free(hmac);</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_verify_hmac_none_out_of_range=
_ack(void **ut_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_t *=
hmac =3D session_id_hmac_init();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct link_socket_actual from =3D { 0 };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    from.dest.addr.sa.sa_family =3D AF_INET;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_pre_decr=
ypt_state state =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct b=
uffer buf =3D alloc_buf(1024);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    enum first_packet_verdict verdict;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tas.tls_wrap.mode =3D TLS_WRAP_NONE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_reset_len(&amp;buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_write(&amp;buf, client_ack_123_none_random_=
id, sizeof(client_ack_123_none_random_id));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    verdict =
=3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(verdi=
ct, VERDICT_VALID_ACK_V1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* shoul=
d fail because it acks 2 */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool valid =3D check_session_id_hmac(&amp;state, &amp;from.dest=
, hmac, 30, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_false(valid);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pr=
e_decrypt_state(&amp;state);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    hmac_ctx_cleanup(hmac);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    hmac_ctx_free(hmac);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static hmac_=
ctx_t *</span><br><span> init_static_hmac(void)</span><br><span> {</span><b=
r><span>@@ -667,6 +713,7 @@</span><br><span>         cmocka_unit_test(test_=
calc_session_id_hmac_static),</span><br><span>         cmocka_unit_test(tes=
t_verify_hmac_none),</span><br><span>         cmocka_unit_test(test_verify_=
hmac_tls_auth),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),</span><br><sp=
an>         cmocka_unit_test(test_generate_reset_packet_plain),</span><br><=
span>         cmocka_unit_test(test_generate_reset_packet_tls_auth),</span>=
<br><span>         cmocka_unit_test(test_extract_control_message)</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1067?usp=3Demail">change 1067</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1067?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6752dcd5aff3e5cea2b43936647=
9e86751a1c403 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1067 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Q22yHoiD5Ms=--

