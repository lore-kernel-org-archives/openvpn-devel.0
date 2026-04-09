From: "Bluca (Code Review)" <gerrit@...515...>
Date: Thu, 9 Apr 2026 01:08:10 +0000
In-Reply-To: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
References: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
Reply-To: luca.boccassi@...277..., arne-openvpn@...1227...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <15f9c2c4b8e808b4c27c4445aebeb0facc44219f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2RzlD2QesmQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl: use TLS
 record-sized buffers for key method 2 exchange
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, selvanair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2RzlD2QesmQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Bluca, plaisthos, selvanair.

Hello plaisthos, selvanair,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


Change subject: ssl: use TLS record-sized buffers for key method 2 exchange
......................................................................

ssl: use TLS record-sized buffers for key method 2 exchange

The current key exchange uses plaintext_read_buf/plaintext_write_buf
(sized at TLS_CHANNEL_BUF_SIZE, 2048 bytes) as intermediary buffers
for the key method 2 exchange. Passwords or tokens longer than
~1900 bytes (after accounting for key material, options and peer
info overhead) get silently truncated.

This breaks using JIT use-once tokens for authentication, which are
becoming common in enterprise setups. These tokens are typically
long JWT-encoded strings that exceed the 2048-byte buffer.

Instead of increasing TLS_CHANNEL_BUF_SIZE (which would change the
control channel framing and require both endpoints to be updated),
introduce separate key_method_send_buf and key_method_recv_buf
buffers in key_state, sized at TLS_RECORD_MAX_SIZE (16384 bytes,
the maximum plaintext payload of a single TLS record).

On the write side, key_method_2_write() assembles the full payload
into the 16 KB buffer, which is then passed to the TLS library via
a single key_state_write_plaintext() call. The TLS library creates
one TLS record, and the existing write_outgoing_tls_ciphertext()
already splits the resulting ciphertext into properly-sized reliable
transport packets.

On the read side, a single key_state_read_plaintext() call reads
into the 16 KB buffer. Since SSL_read/BIO_read returns one TLS
record worth of data per call, this preserves the one-read-per-
message framing assumption used throughout OpenVPN.

All other control channel messages (push, CR_RESPONSE, etc.)
continue to use the original 2048-byte plaintext_read/write_buf.

When the key exchange payload exceeds TLS_CHANNEL_BUF_SIZE and the
connection subsequently fails (state never reaches S_ACTIVE), a
diagnostic message is printed at key_state teardown to help the
user identify that the server may not support large payloads.

Protocol compatibility:
- old client <-> new server: no change, old limits apply
- new client <-> old server: large passwords will cause the old
  server to truncate/fail; a clear error message is shown
- new client <-> new server: large passwords work

Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
---
M src/openvpn/common.h
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
3 files changed, 88 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1622/3

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index aa7b721..b1a8516 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -69,6 +69,17 @@
  */
 #define TLS_CHANNEL_BUF_SIZE 2048

+/*
+ * Buffer size for key method 2 exchange data (send and receive).
+ * A single TLS record can carry up to 2^14 (16384) bytes of
+ * plaintext. We size the key exchange buffers to a full TLS
+ * record so that payloads larger than TLS_CHANNEL_BUF_SIZE
+ * (e.g. with long PKCS#11 passwords/tokens) can be sent and
+ * received in a single TLS read/write without breaking the
+ * one-read-per-message assumption used elsewhere.
+ */
+#define TLS_RECORD_MAX_SIZE (1 << 14)
+
 /* TLS control buffer minimum size
  *
  * A control frame might have IPv6 header (40 byte),
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 576157d..c8bf35c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -860,6 +860,8 @@
     ks->plaintext_read_buf =3D alloc_buf(TLS_CHANNEL_BUF_SIZE);
     ks->plaintext_write_buf =3D alloc_buf(TLS_CHANNEL_BUF_SIZE);
     ks->ack_write_buf =3D alloc_buf(BUF_SIZE(&session->opt->frame));
+    ks->key_method_send_buf =3D alloc_buf(TLS_RECORD_MAX_SIZE);
+    ks->key_method_recv_buf =3D alloc_buf(TLS_RECORD_MAX_SIZE);
     reliable_init(ks->send_reliable, BUF_SIZE(&session->opt->frame),
                   session->opt->frame.buf.headroom, TLS_RELIABLE_N_SEND_BU=
FFERS,
                   ks->key_id ? false : session->opt->xmit_hold);
@@ -906,6 +908,17 @@
 static void
 key_state_free(struct key_state *ks, bool clear)
 {
+    if (ks->key_method_large_payload && ks->state >=3D S_SENT_KEY
+        && ks->state < S_ACTIVE)
+    {
+        /* Servers before a7f80d402f do not send back a useful error so pr=
int one */
+        msg(M_WARN, "Connection failed after sending a key exchange "
+            "payload larger than %d bytes (due to a long password). "
+            "This may happen when the server does not support large "
+            "key exchange payloads, try with a smaller password.",
+            TLS_CHANNEL_BUF_SIZE);
+    }
+
     ks->state =3D S_UNDEF;

     key_state_ssl_free(&ks->ks_ssl);
@@ -915,6 +928,8 @@
     free_buf(&ks->plaintext_read_buf);
     free_buf(&ks->plaintext_write_buf);
     free_buf(&ks->ack_write_buf);
+    free_buf(&ks->key_method_send_buf);
+    free_buf(&ks->key_method_recv_buf);
     buffer_list_free(ks->paybuf);

     reliable_free(ks->send_reliable);
@@ -2836,38 +2851,61 @@
     }

     /* Read incoming plaintext from TLS object */
-    struct buffer *buf =3D &ks->plaintext_read_buf;
-    if (!buf->len)
+    bool in_key_exchange_read =3D
+        (ks->state =3D=3D S_SENT_KEY && !session->opt->server)
+        || (ks->state =3D=3D S_START && session->opt->server);
+
+    if (in_key_exchange_read)
     {
-        if (!read_incoming_tls_plaintext(ks, buf, wakeup, &continue_tls_pr=
ocess))
+        /* For key exchange, read into a buffer large enough for a full
+         * TLS record (16 KB) so that long passwords/tokens that exceed
+         * TLS_CHANNEL_BUF_SIZE are received in a single read. */
+        if (!BLEN(&ks->key_method_recv_buf))
         {
-            goto error;
+            if (!read_incoming_tls_plaintext(ks, &ks->key_method_recv_buf,
+                                             wakeup, &continue_tls_process=
))
+            {
+                goto error;
+            }
+        }
+    }
+    else
+    {
+        struct buffer *buf =3D &ks->plaintext_read_buf;
+        if (!buf->len)
+        {
+            if (!read_incoming_tls_plaintext(ks, buf, wakeup, &continue_tl=
s_process))
+            {
+                goto error;
+            }
         }
     }

-    /* Send Key */
-    buf =3D &ks->plaintext_write_buf;
-    if (!buf->len
+    /* Send Key -- use larger key_method_send_buf for assembly to support
+     * long passwords/tokens that exceed TLS_CHANNEL_BUF_SIZE */
+    if (!ks->key_method_send_buf.len
         && ((ks->state =3D=3D S_START && !session->opt->server)
             || (ks->state =3D=3D S_GOT_KEY && session->opt->server)))
     {
-        if (!key_method_2_write(buf, multi, session))
+        if (!key_method_2_write(&ks->key_method_send_buf, multi, session))
         {
             goto error;
         }

+        ks->key_method_large_payload =3D
+            BLEN(&ks->key_method_send_buf) > TLS_CHANNEL_BUF_SIZE;
+
         continue_tls_process =3D true;
         dmsg(D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
         ks->state =3D S_SENT_KEY;
     }

-    /* Receive Key */
-    buf =3D &ks->plaintext_read_buf;
-    if (buf->len
+    /* Receive Key -- use the larger key_method_recv_buf */
+    if (BLEN(&ks->key_method_recv_buf)
         && ((ks->state =3D=3D S_SENT_KEY && !session->opt->server)
             || (ks->state =3D=3D S_START && session->opt->server)))
     {
-        if (!key_method_2_read(buf, multi, session))
+        if (!key_method_2_read(&ks->key_method_recv_buf, multi, session))
         {
             goto error;
         }
@@ -2877,20 +2915,38 @@
         ks->state =3D S_GOT_KEY;
     }

-    /* Write outgoing plaintext to TLS object */
-    buf =3D &ks->plaintext_write_buf;
-    if (buf->len)
+    /* Write key exchange data to TLS object */
+    if (ks->key_method_send_buf.len)
     {
-        int status =3D key_state_write_plaintext(&ks->ks_ssl, buf);
+        int status =3D key_state_write_plaintext(&ks->ks_ssl, &ks->key_met=
hod_send_buf);
         if (status =3D=3D -1)
         {
-            msg(D_TLS_ERRORS, "TLS ERROR: Outgoing Plaintext -> TLS object=
 write error");
+            msg(D_TLS_ERRORS, "TLS ERROR: Key Method -> TLS object write e=
rror");
             goto error;
         }
         if (status =3D=3D 1)
         {
             continue_tls_process =3D true;
-            dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
+            dmsg(D_TLS_DEBUG, "Key Method -> TLS");
+        }
+    }
+
+    /* Write outgoing plaintext to TLS object */
+    {
+        struct buffer *buf =3D &ks->plaintext_write_buf;
+        if (buf->len)
+        {
+            int status =3D key_state_write_plaintext(&ks->ks_ssl, buf);
+            if (status =3D=3D -1)
+            {
+                msg(D_TLS_ERRORS, "TLS ERROR: Outgoing Plaintext -> TLS ob=
ject write error");
+                goto error;
+            }
+            if (status =3D=3D 1)
+            {
+                continue_tls_process =3D true;
+                dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
+            }
         }
     }
     if (!check_outgoing_ciphertext(ks, session, &continue_tls_process))
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 6f310a5..913a0c2 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -241,6 +241,9 @@
     struct buffer plaintext_read_buf;
     struct buffer plaintext_write_buf;
     struct buffer ack_write_buf;
+    struct buffer key_method_send_buf; /* larger buffer for key method 2 w=
rite */
+    struct buffer key_method_recv_buf; /* larger buffer for key method 2 r=
ead */
+    bool key_method_large_payload;     /* key exchange exceeded TLS_CHANNE=
L_BUF_SIZE */

     struct reliable *send_reliable; /* holds a copy of outgoing packets un=
til ACK received */
     struct reliable *rec_reliable;  /* order incoming ciphertext packets b=
efore we pass to TLS */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Gerrit-Change-Number: 1622
Gerrit-PatchSet: 3
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: Bluca <luca.boccassi@...277...>
Gerrit-Attention: selvanair <selva.nair@...277...>

--2RzlD2QesmQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Bluca, plaisthos, selvanair. </p>
<p>Bluca <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">ssl: use TLS record-sized buffe=
rs for key method 2 exchange<br><br>The current key exchange uses plaintext=
_read_buf/plaintext_write_buf<br>(sized at TLS_CHANNEL_BUF_SIZE, 2048 bytes=
) as intermediary buffers<br>for the key method 2 exchange. Passwords or to=
kens longer than<br>~1900 bytes (after accounting for key material, options=
 and peer<br>info overhead) get silently truncated.<br><br>This breaks usin=
g JIT use-once tokens for authentication, which are<br>becoming common in e=
nterprise setups. These tokens are typically<br>long JWT-encoded strings th=
at exceed the 2048-byte buffer.<br><br>Instead of increasing TLS_CHANNEL_BU=
F_SIZE (which would change the<br>control channel framing and require both =
endpoints to be updated),<br>introduce separate key_method_send_buf and key=
_method_recv_buf<br>buffers in key_state, sized at TLS_RECORD_MAX_SIZE (163=
84 bytes,<br>the maximum plaintext payload of a single TLS record).<br><br>=
On the write side, key_method_2_write() assembles the full payload<br>into =
the 16 KB buffer, which is then passed to the TLS library via<br>a single k=
ey_state_write_plaintext() call. The TLS library creates<br>one TLS record,=
 and the existing write_outgoing_tls_ciphertext()<br>already splits the res=
ulting ciphertext into properly-sized reliable<br>transport packets.<br><br=
>On the read side, a single key_state_read_plaintext() call reads<br>into t=
he 16 KB buffer. Since SSL_read/BIO_read returns one TLS<br>record worth of=
 data per call, this preserves the one-read-per-<br>message framing assumpt=
ion used throughout OpenVPN.<br><br>All other control channel messages (pus=
h, CR_RESPONSE, etc.)<br>continue to use the original 2048-byte plaintext_r=
ead/write_buf.<br><br>When the key exchange payload exceeds TLS_CHANNEL_BUF=
_SIZE and the<br>connection subsequently fails (state never reaches S_ACTIV=
E), a<br>diagnostic message is printed at key_state teardown to help the<br=
>user identify that the server may not support large payloads.<br><br>Proto=
col compatibility:<br>- old client &lt;-&gt; new server: no change, old lim=
its apply<br>- new client &lt;-&gt; old server: large passwords will cause =
the old<br>  server to truncate/fail; a clear error message is shown<br>- n=
ew client &lt;-&gt; new server: large passwords work<br><br>Change-Id: I055=
c64ca8b23066e70eea7d7deddfb14f5354c5f<br>Signed-off-by: Luca Boccassi &lt;l=
uca.boccassi@...277...&gt;<br>---<br>M src/openvpn/common.h<br>M src/openvp=
n/ssl.c<br>M src/openvpn/ssl_common.h<br>3 files changed, 88 insertions(+),=
 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/22/1622/3</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/co=
mmon.h b/src/openvpn/common.h</span><br><span>index aa7b721..b1a8516 100644=
</span><br><span>--- a/src/openvpn/common.h</span><br><span>+++ b/src/openv=
pn/common.h</span><br><span>@@ -69,6 +69,17 @@</span><br><span>  */</span><=
br><span> #define TLS_CHANNEL_BUF_SIZE 2048</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Buffer size for key method 2 exchange data (sen=
d and receive).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A=
 single TLS record can carry up to 2^14 (16384) bytes of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * plaintext. We size the key exchange=
 buffers to a full TLS</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * record so that payloads larger than TLS_CHANNEL_BUF_SIZE</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * (e.g. with long PKCS#11 passw=
ords/tokens) can be sent and</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * received in a single TLS read/write without breaking the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * one-read-per-message as=
sumption used elsewhere.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLS=
_RECORD_MAX_SIZE (1 &lt;&lt; 14)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> /* TLS control buffer minimum size</span><br=
><span>  *</span><br><span>  * A control frame might have IPv6 header (40 b=
yte),</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</s=
pan><br><span>index 576157d..c8bf35c 100644</span><br><span>--- a/src/openv=
pn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -860,6 =
+860,8 @@</span><br><span>     ks-&gt;plaintext_read_buf =3D alloc_buf(TLS_=
CHANNEL_BUF_SIZE);</span><br><span>     ks-&gt;plaintext_write_buf =3D allo=
c_buf(TLS_CHANNEL_BUF_SIZE);</span><br><span>     ks-&gt;ack_write_buf =3D =
alloc_buf(BUF_SIZE(&amp;session-&gt;opt-&gt;frame));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;key_method_send_buf =3D alloc_=
buf(TLS_RECORD_MAX_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ks-&gt;key_method_recv_buf =3D alloc_buf(TLS_RECORD_MAX_SIZE);</s=
pan><br><span>     reliable_init(ks-&gt;send_reliable, BUF_SIZE(&amp;sessio=
n-&gt;opt-&gt;frame),</span><br><span>                   session-&gt;opt-&g=
t;frame.buf.headroom, TLS_RELIABLE_N_SEND_BUFFERS,</span><br><span>        =
           ks-&gt;key_id ? false : session-&gt;opt-&gt;xmit_hold);</span><b=
r><span>@@ -906,6 +908,17 @@</span><br><span> static void</span><br><span> =
key_state_free(struct key_state *ks, bool clear)</span><br><span> {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;key_method_l=
arge_payload &amp;&amp; ks-&gt;state &gt;=3D S_SENT_KEY</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; ks-&gt;state &lt; S_=
ACTIVE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Servers before =
a7f80d402f do not send back a useful error so print one */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Connection=
 failed after sending a key exchange &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &quot;payload larger than %d bytes (due=
 to a long password). &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot;This may happen when the server does not support=
 large &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &quot;key exchange payloads, try with a smaller password.&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            TLS_CHANNEL_=
BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     k=
s-&gt;state =3D S_UNDEF;</span><br><span> </span><br><span>     key_state_s=
sl_free(&amp;ks-&gt;ks_ssl);</span><br><span>@@ -915,6 +928,8 @@</span><br>=
<span>     free_buf(&amp;ks-&gt;plaintext_read_buf);</span><br><span>     f=
ree_buf(&amp;ks-&gt;plaintext_write_buf);</span><br><span>     free_buf(&am=
p;ks-&gt;ack_write_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free_buf(&amp;ks-&gt;key_method_send_buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;ks-&gt;key_method_recv_=
buf);</span><br><span>     buffer_list_free(ks-&gt;paybuf);</span><br><span=
> </span><br><span>     reliable_free(ks-&gt;send_reliable);</span><br><spa=
n>@@ -2836,38 +2851,61 @@</span><br><span>     }</span><br><span> </span><b=
r><span>     /* Read incoming plaintext from TLS object */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D &amp;ks-&gt=
;plaintext_read_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!buf-&gt;len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bool in_key_exchange_read =3D</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        (ks-&gt;state =3D=3D S_SENT_KEY &amp;&amp; !session-=
&gt;opt-&gt;server)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        || (ks-&gt;state =3D=3D S_START &amp;&amp; session-&gt;opt-&gt;serv=
er);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (in_key_exchange_read)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (!read_incoming_tls_plaintext(ks, buf, wakeup, &amp;continue_tls_pr=
ocess))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* F=
or key exchange, read into a buffer large enough for a full</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * TLS record (16 KB) so th=
at long passwords/tokens that exceed</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * TLS_CHANNEL_BUF_SIZE are received in a single r=
ead. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
!BLEN(&amp;ks-&gt;key_method_recv_buf))</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            goto error;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!read_inco=
ming_tls_plaintext(ks, &amp;ks-&gt;key_method_recv_buf,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
      wakeup, &amp;continue_tls_process))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                goto error;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer *buf =3D =
&amp;ks-&gt;plaintext_read_buf;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!buf-&gt;len)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (!read_incoming_tls_plaintext(ks, buf, wakeup, &amp;=
continue_tls_process))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span>         }</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Sen=
d Key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D &=
amp;ks-&gt;plaintext_write_buf;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (!buf-&gt;len</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Send Key -- use larger key_method_send_buf for assembly t=
o support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * lon=
g passwords/tokens that exceed TLS_CHANNEL_BUF_SIZE */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!ks-&gt;key_method_send_buf.len<=
/span><br><span>         &amp;&amp; ((ks-&gt;state =3D=3D S_START &amp;&amp=
; !session-&gt;opt-&gt;server)</span><br><span>             || (ks-&gt;stat=
e =3D=3D S_GOT_KEY &amp;&amp; session-&gt;opt-&gt;server)))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!k=
ey_method_2_write(buf, multi, session))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!key_method_2_write(&amp;ks-&gt;key_method_=
send_buf, multi, session))</span><br><span>         {</span><br><span>     =
        goto error;</span><br><span>         }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;key_method_larg=
e_payload =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      BLEN(&amp;ks-&gt;key_method_send_buf) &gt; TLS_CHANNEL_BUF_SIZE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>       =
  continue_tls_process =3D true;</span><br><span>         dmsg(D_TLS_DEBUG_=
MED, &quot;STATE S_SENT_KEY&quot;);</span><br><span>         ks-&gt;state =
=3D S_SENT_KEY;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* Receive Key */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    buf =3D &amp;ks-&gt;plaintext_read_b=
uf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;le=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Receive Key=
 -- use the larger key_method_recv_buf */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (BLEN(&amp;ks-&gt;key_method_recv_buf)</span><=
br><span>         &amp;&amp; ((ks-&gt;state =3D=3D S_SENT_KEY &amp;&amp; !s=
ession-&gt;opt-&gt;server)</span><br><span>             || (ks-&gt;state =
=3D=3D S_START &amp;&amp; session-&gt;opt-&gt;server)))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!key_m=
ethod_2_read(buf, multi, session))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!key_method_2_read(&amp;ks-&gt;key_method_recv_b=
uf, multi, session))</span><br><span>         {</span><br><span>           =
  goto error;</span><br><span>         }</span><br><span>@@ -2877,20 +2915,=
38 @@</span><br><span>         ks-&gt;state =3D S_GOT_KEY;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* Write outgoing plaintext to TLS object */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf =3D &amp;ks-&gt;plaintext_write_buf=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Write key ex=
change data to TLS object */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ks-&gt;key_method_send_buf.len)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int status =3D ke=
y_state_write_plaintext(&amp;ks-&gt;ks_ssl, buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        int status =3D key_state_write_plaint=
ext(&amp;ks-&gt;ks_ssl, &amp;ks-&gt;key_method_send_buf);</span><br><span> =
        if (status =3D=3D -1)</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &quot;TLS =
ERROR: Outgoing Plaintext -&gt; TLS object write error&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &q=
uot;TLS ERROR: Key Method -&gt; TLS object write error&quot;);</span><br><s=
pan>             goto error;</span><br><span>         }</span><br><span>   =
      if (status =3D=3D 1)</span><br><span>         {</span><br><span>     =
        continue_tls_process =3D true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            dmsg(D_TLS_DEBUG, &quot;Outgoing Plaintext -&g=
t; TLS&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       dmsg(D_TLS_DEBUG, &quot;Key Method -&gt; TLS&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Write outgoing plaintext to TLS object */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct buffer *buf =3D &amp;ks-&gt;plaintext_write_buf;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (buf-&gt=
;len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            int status =
=3D key_state_write_plaintext(&amp;ks-&gt;ks_ssl, buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (status =3D=3D -1)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_TLS_ERROR=
S, &quot;TLS ERROR: Outgoing Plaintext -&gt; TLS object write error&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                got=
o error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (s=
tatus =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      continue_tls_process =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                dmsg(D_TLS_DEBUG, &quot;Outgoing Plaintext=
 -&gt; TLS&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span>         }</span><br><span>     }</span><br><s=
pan>     if (!check_outgoing_ciphertext(ks, session, &amp;continue_tls_proc=
ess))</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/s=
sl_common.h</span><br><span>index 6f310a5..913a0c2 100644</span><br><span>-=
-- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.=
h</span><br><span>@@ -241,6 +241,9 @@</span><br><span>     struct buffer pl=
aintext_read_buf;</span><br><span>     struct buffer plaintext_write_buf;</=
span><br><span>     struct buffer ack_write_buf;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer key_method_send_buf; /* larg=
er buffer for key method 2 write */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer key_method_recv_buf; /* larger buffer for=
 key method 2 read */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool key_method_large_payload;     /* key exchange exceeded TLS_CHANN=
EL_BUF_SIZE */</span><br><span> </span><br><span>     struct reliable *send=
_reliable; /* holds a copy of outgoing packets until ACK received */</span>=
<br><span>     struct reliable *rec_reliable;  /* order incoming ciphertext=
 packets before we pass to TLS */</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail=
">change 1622</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I055c64ca8b23066e70eea7d7ded=
dfb14f5354c5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1622 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Bluca &lt;luca.boccassi@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>

</body></html>=

--2RzlD2QesmQ=--

