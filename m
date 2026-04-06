From: "Bluca (Code Review)" <gerrit@...515...>
Date: Mon, 6 Apr 2026 11:44:07 +0000
References: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
Reply-To: luca.boccassi@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <981a77a6368821bac7b0ae039e57cbda350e9e16-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lZ1bRpWjkHU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add new helpers to
 handle key exchange (S_SENT_KEY/S_START) with larg...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lZ1bRpWjkHU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail

to review the following change.


Change subject: Add new helpers to handle key exchange (S_SENT_KEY/S_START)=
 with large passwords
......................................................................

Add new helpers to handle key exchange (S_SENT_KEY/S_START) with large pass=
words

The current key exchange uses an intermediate buffer hardcoded
at 2048 bytes, that cannot handle anything longer, as it gets
silently truncated.

This breaks using JIT use-once tokens for authentications, that
are becoming common in enterprise devices to reduce attack
surfaces, as the tokens are typically long JWT encoded strings.

Add new helpers that, instead of doing a single 2048 bytes
read/write from/to the TLS layer, reads/writes all the available
data when doing the key method 2 exchange.
Other stages of the protocol are unaffected. Note that this is
an intermediary buffer, the TLS layer is already handling
fragmented/reassembled frames appropriately, so there is no
on-the-wire difference, aside from letting the client send more
data.

Older servers will simply continue to truncate passwords longer
than the existing limit, as they are doing currently, so no
incompatible changes, behaviour stays the same and current valid
passwords are still valid when the new client uses them.
When an old client talks to a new server, likewise there are no
changes, as the previous clients have the embedded limit, so all
existing passwords will continue to work.

Tested combinations:

old client <--> new server
new client <--> old server
new client <--> new server

With the last combination, a large password can be used successfully.
With either an old server or old client, existing limits apply and
a clear error is shown in case one tries a password longer than the
existing limits.

Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
---
M src/openvpn/common.h
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
3 files changed, 116 insertions(+), 17 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1622/1

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index aa7b721..b67a6f4 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -69,6 +69,16 @@
  */
 #define TLS_CHANNEL_BUF_SIZE 2048

+/*
+ * Buffer size for key method 2 exchange data. This needs to be
+ * large enough to hold the key source material, options string,
+ * username, password and peer info. When USER_PASS_LEN is larger
+ * than the default TLS channel size (e.g. with ENABLE_PKCS11),
+ * we need a larger buffer. The key exchange write and read paths
+ * handle this by doing multiple TLS writes/reads as needed.
+ */
+#define KEY_METHOD_BUF_SIZE (TLS_CHANNEL_BUF_SIZE + 2 * USER_PASS_LEN)
+
 /* TLS control buffer minimum size
  *
  * A control frame might have IPv6 header (40 byte),
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 576157d..83bc46e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -860,6 +860,8 @@
     ks->plaintext_read_buf =3D alloc_buf(TLS_CHANNEL_BUF_SIZE);
     ks->plaintext_write_buf =3D alloc_buf(TLS_CHANNEL_BUF_SIZE);
     ks->ack_write_buf =3D alloc_buf(BUF_SIZE(&session->opt->frame));
+    ks->key_method_send_buf =3D alloc_buf(KEY_METHOD_BUF_SIZE);
+    ks->key_method_recv_buf =3D alloc_buf(KEY_METHOD_BUF_SIZE);
     reliable_init(ks->send_reliable, BUF_SIZE(&session->opt->frame),
                   session->opt->frame.buf.headroom, TLS_RELIABLE_N_SEND_BU=
FFERS,
                   ks->key_id ? false : session->opt->xmit_hold);
@@ -915,6 +917,8 @@
     free_buf(&ks->plaintext_read_buf);
     free_buf(&ks->plaintext_write_buf);
     free_buf(&ks->ack_write_buf);
+    free_buf(&ks->key_method_send_buf);
+    free_buf(&ks->key_method_recv_buf);
     buffer_list_free(ks->paybuf);

     reliable_free(ks->send_reliable);
@@ -2624,6 +2628,54 @@
     return true;
 }

+/**
+ * Read all currently available plaintext from the TLS object into buf,
+ * doing multiple reads if necessary. This is used for key method 2
+ * exchange data which may exceed a single TLS_CHANNEL_BUF_SIZE read
+ * when long passwords/tokens are used.
+ */
+static bool
+read_incoming_tls_plaintext_multi(struct key_state *ks, struct buffer *buf,
+                                  interval_t *wakeup, bool *continue_tls_p=
rocess)
+{
+    struct buffer tmp =3D alloc_buf(TLS_CHANNEL_BUF_SIZE);
+
+    while (buf_forward_capacity(buf) > 0)
+    {
+        buf_init(&tmp, 0);
+        int status =3D key_state_read_plaintext(&ks->ks_ssl, &tmp);
+
+        update_time();
+        if (status =3D=3D -1)
+        {
+            msg(D_TLS_ERRORS,
+                "TLS Error: TLS object -> incoming plaintext read error");
+            free_buf(&tmp);
+            return false;
+        }
+        if (status =3D=3D 1)
+        {
+            if (!buf_write(buf, BPTR(&tmp), BLEN(&tmp)))
+            {
+                msg(D_TLS_ERRORS,
+                    "TLS Error: key exchange plaintext too large");
+                free_buf(&tmp);
+                return false;
+            }
+            *continue_tls_process =3D true;
+            *wakeup =3D 0;
+            dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext (key exchange)");
+        }
+        else
+        {
+            break;
+        }
+    }
+
+    free_buf(&tmp);
+    return true;
+}
+
 static bool
 write_outgoing_tls_ciphertext(struct tls_session *session, bool *continue_=
tls_process)
 {
@@ -2836,22 +2888,40 @@
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
+        /* For key exchange, read all available plaintext into a buffer
+         * that is large enough for long passwords/tokens. Multiple reads
+         * are done to handle data exceeding TLS_CHANNEL_BUF_SIZE. */
+        if (!read_incoming_tls_plaintext_multi(ks, &ks->key_method_recv_bu=
f,
+                                               wakeup, &continue_tls_proce=
ss))
         {
             goto error;
         }
     }
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
+        }
+    }

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
@@ -2861,13 +2931,12 @@
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
@@ -2877,20 +2946,38 @@
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
index 6f310a5..6f3da11 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -241,6 +241,8 @@
     struct buffer plaintext_read_buf;
     struct buffer plaintext_write_buf;
     struct buffer ack_write_buf;
+    struct buffer key_method_send_buf; /* larger buffer for key method 2 w=
rite */
+    struct buffer key_method_recv_buf; /* larger buffer for key method 2 r=
ead */

     struct reliable *send_reliable; /* holds a copy of outgoing packets un=
til ACK received */
     struct reliable *rec_reliable;  /* order incoming ciphertext packets b=
efore we pass to TLS */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Gerrit-Change-Number: 1622
Gerrit-PatchSet: 1
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--lZ1bRpWjkHU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Bluca would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Add new helpers to handle key exchange (S_S=
ENT_KEY/S_START) with large passwords<br><br>The current key exchange uses =
an intermediate buffer hardcoded<br>at 2048 bytes, that cannot handle anyth=
ing longer, as it gets<br>silently truncated.<br><br>This breaks using JIT =
use-once tokens for authentications, that<br>are becoming common in enterpr=
ise devices to reduce attack<br>surfaces, as the tokens are typically long =
JWT encoded strings.<br><br>Add new helpers that, instead of doing a single=
 2048 bytes<br>read/write from/to the TLS layer, reads/writes all the avail=
able<br>data when doing the key method 2 exchange.<br>Other stages of the p=
rotocol are unaffected. Note that this is<br>an intermediary buffer, the TL=
S layer is already handling<br>fragmented/reassembled frames appropriately,=
 so there is no<br>on-the-wire difference, aside from letting the client se=
nd more<br>data.<br><br>Older servers will simply continue to truncate pass=
words longer<br>than the existing limit, as they are doing currently, so no=
<br>incompatible changes, behaviour stays the same and current valid<br>pas=
swords are still valid when the new client uses them.<br>When an old client=
 talks to a new server, likewise there are no<br>changes, as the previous c=
lients have the embedded limit, so all<br>existing passwords will continue =
to work.<br><br>Tested combinations:<br><br>old client &lt;--&gt; new serve=
r<br>new client &lt;--&gt; old server<br>new client &lt;--&gt; new server<b=
r><br>With the last combination, a large password can be used successfully.=
<br>With either an old server or old client, existing limits apply and<br>a=
 clear error is shown in case one tries a password longer than the<br>exist=
ing limits.<br><br>Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f<br>=
Signed-off-by: Luca Boccassi &lt;luca.boccassi@...277...&gt;<br>---<br>M sr=
c/openvpn/common.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_common.h<br>=
3 files changed, 116 insertions(+), 17 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1622/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/common.h b/src/openvpn/common.h</span><br>=
<span>index aa7b721..b67a6f4 100644</span><br><span>--- a/src/openvpn/commo=
n.h</span><br><span>+++ b/src/openvpn/common.h</span><br><span>@@ -69,6 +69=
,16 @@</span><br><span>  */</span><br><span> #define TLS_CHANNEL_BUF_SIZE 2=
048</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Buffer size =
for key method 2 exchange data. This needs to be</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * large enough to hold the key source materia=
l, options string,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* username, password and peer info. When USER_PASS_LEN is larger</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * than the default TLS channe=
l size (e.g. with ENABLE_PKCS11),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * we need a larger buffer. The key exchange write and read p=
aths</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * handle this =
by doing multiple TLS writes/reads as needed.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define KEY_METHOD_BUF_SIZE (TLS_CHANNEL_BUF_SIZE + 2 * USER_PASS=
_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /* TLS control buffer minimum size</span><br><span>  *</span><br><span>=
  * A control frame might have IPv6 header (40 byte),</span><br><span>diff =
--git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 576157d=
..83bc46e 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>++=
+ b/src/openvpn/ssl.c</span><br><span>@@ -860,6 +860,8 @@</span><br><span> =
    ks-&gt;plaintext_read_buf =3D alloc_buf(TLS_CHANNEL_BUF_SIZE);</span><b=
r><span>     ks-&gt;plaintext_write_buf =3D alloc_buf(TLS_CHANNEL_BUF_SIZE)=
;</span><br><span>     ks-&gt;ack_write_buf =3D alloc_buf(BUF_SIZE(&amp;ses=
sion-&gt;opt-&gt;frame));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ks-&gt;key_method_send_buf =3D alloc_buf(KEY_METHOD_BUF_SIZE);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;key_method_=
recv_buf =3D alloc_buf(KEY_METHOD_BUF_SIZE);</span><br><span>     reliable_=
init(ks-&gt;send_reliable, BUF_SIZE(&amp;session-&gt;opt-&gt;frame),</span>=
<br><span>                   session-&gt;opt-&gt;frame.buf.headroom, TLS_RE=
LIABLE_N_SEND_BUFFERS,</span><br><span>                   ks-&gt;key_id ? f=
alse : session-&gt;opt-&gt;xmit_hold);</span><br><span>@@ -915,6 +917,8 @@<=
/span><br><span>     free_buf(&amp;ks-&gt;plaintext_read_buf);</span><br><s=
pan>     free_buf(&amp;ks-&gt;plaintext_write_buf);</span><br><span>     fr=
ee_buf(&amp;ks-&gt;ack_write_buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free_buf(&amp;ks-&gt;key_method_send_buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;ks-&gt;key_meth=
od_recv_buf);</span><br><span>     buffer_list_free(ks-&gt;paybuf);</span><=
br><span> </span><br><span>     reliable_free(ks-&gt;send_reliable);</span>=
<br><span>@@ -2624,6 +2628,54 @@</span><br><span>     return true;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read=
 all currently available plaintext from the TLS object into buf,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * doing multiple reads if nec=
essary. This is used for key method 2</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * exchange data which may exceed a single TLS_CHANNEL_BU=
F_SIZE read</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * when =
long passwords/tokens are used.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_incomin=
g_tls_plaintext_multi(struct key_state *ks, struct buffer *buf,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
   interval_t *wakeup, bool *continue_tls_process)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer tmp =3D alloc_buf(TLS_CHANNEL_BUF_SIZE);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (buf_forward_capacity(buf) &gt;=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        buf_init(&amp;tmp, 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int status =
=3D key_state_read_plaintext(&amp;ks-&gt;ks_ssl, &amp;tmp);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        update_time();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (status =3D=3D -1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;TLS Error: TLS obje=
ct -&gt; incoming plaintext read error&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            free_buf(&amp;tmp);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (status =3D=3D 1)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!buf_write(buf, BPTR(&amp=
;tmp), BLEN(&amp;tmp)))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    &quot;TLS Error: key exchange plaintext too=
 large&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           free_buf(&amp;tmp);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                return false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            *continue_tls_process =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            *wakeup =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_TLS_DEBUG,=
 &quot;TLS -&gt; Incoming Plaintext (key exchange)&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;tmp);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> wr=
ite_outgoing_tls_ciphertext(struct tls_session *session, bool *continue_tls=
_process)</span><br><span> {</span><br><span>@@ -2836,22 +2888,40 @@</span>=
<br><span>     }</span><br><span> </span><br><span>     /* Read incoming pl=
aintext from TLS object */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct buffer *buf =3D &amp;ks-&gt;plaintext_read_buf;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf-&gt;len)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool in_key_exchange_read =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (ks-&gt;=
state =3D=3D S_SENT_KEY &amp;&amp; !session-&gt;opt-&gt;server)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        || (ks-&gt;state =3D=3D=
 S_START &amp;&amp; session-&gt;opt-&gt;server);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (in_key_exchange_read)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (!read_incoming_tls_pla=
intext(ks, buf, wakeup, &amp;continue_tls_process))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* For key exchange, read all ava=
ilable plaintext into a buffer</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * that is large enough for long passwords/tokens. Multi=
ple reads</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 are done to handle data exceeding TLS_CHANNEL_BUF_SIZE. */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!read_incoming_tls_plai=
ntext_multi(ks, &amp;ks-&gt;key_method_recv_buf,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                              =
 wakeup, &amp;continue_tls_process))</span><br><span>         {</span><br><=
span>             goto error;</span><br><span>         }</span><br><span>  =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct buffer *buf =3D &amp;ks-&=
gt;plaintext_read_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!buf-&gt;len)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (!read_incoming_tls_plaintext(ks, buf, wakeup, &amp;continue_=
tls_process))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Send Key */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D &amp;ks-&=
gt;plaintext_write_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (!buf-&gt;len</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Send Key -- use larger key_method_send_buf for assembly to suppor=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * long passwo=
rds/tokens that exceed TLS_CHANNEL_BUF_SIZE */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!ks-&gt;key_method_send_buf.len</span><b=
r><span>         &amp;&amp; ((ks-&gt;state =3D=3D S_START &amp;&amp; !sessi=
on-&gt;opt-&gt;server)</span><br><span>             || (ks-&gt;state =3D=3D=
 S_GOT_KEY &amp;&amp; session-&gt;opt-&gt;server)))</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!key_metho=
d_2_write(buf, multi, session))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!key_method_2_write(&amp;ks-&gt;key_method_send_buf=
, multi, session))</span><br><span>         {</span><br><span>             =
goto error;</span><br><span>         }</span><br><span>@@ -2861,13 +2931,12=
 @@</span><br><span>         ks-&gt;state =3D S_SENT_KEY;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* Receive Key */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    buf =3D &amp;ks-&gt;plaintext_read_buf;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (buf-&gt;len</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Receive Key -- use the larger key_method_rec=
v_buf */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLE=
N(&amp;ks-&gt;key_method_recv_buf)</span><br><span>         &amp;&amp; ((ks=
-&gt;state =3D=3D S_SENT_KEY &amp;&amp; !session-&gt;opt-&gt;server)</span>=
<br><span>             || (ks-&gt;state =3D=3D S_START &amp;&amp; session-&=
gt;opt-&gt;server)))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (!key_method_2_read(buf, multi, session))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!key_met=
hod_2_read(&amp;ks-&gt;key_method_recv_buf, multi, session))</span><br><spa=
n>         {</span><br><span>             goto error;</span><br><span>     =
    }</span><br><span>@@ -2877,20 +2946,38 @@</span><br><span>         ks-&=
gt;state =3D S_GOT_KEY;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* Write outgoing plaintext =
to TLS object */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
uf =3D &amp;ks-&gt;plaintext_write_buf;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (buf-&gt;len)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Write key exchange data to TLS object */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;key_method_se=
nd_buf.len)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        int status =3D key_state_write_plaintext(&amp;ks-&gt;k=
s_ssl, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 int status =3D key_state_write_plaintext(&amp;ks-&gt;ks_ssl, &amp;ks-&gt;k=
ey_method_send_buf);</span><br><span>         if (status =3D=3D -1)</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(D_TLS_ERRORS, &quot;TLS ERROR: Outgoing Plaintext -&gt; TLS o=
bject write error&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(D_TLS_ERRORS, &quot;TLS ERROR: Key Method -&gt; TLS o=
bject write error&quot;);</span><br><span>             goto error;</span><b=
r><span>         }</span><br><span>         if (status =3D=3D 1)</span><br>=
<span>         {</span><br><span>             continue_tls_process =3D true=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_T=
LS_DEBUG, &quot;Outgoing Plaintext -&gt; TLS&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_TLS_DEBUG, &quot;Key M=
ethod -&gt; TLS&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Write outgoing plaintext to TLS =
object */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer *b=
uf =3D &amp;ks-&gt;plaintext_write_buf;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (buf-&gt;len)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            int status =3D key_state_write_plaintext(&amp;ks=
-&gt;ks_ssl, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (status =3D=3D -1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                msg(D_TLS_ERRORS, &quot;TLS ERROR: Outgoing Plaintex=
t -&gt; TLS object write error&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                goto error;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (status =3D=3D 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                continue_tls_process =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                dmsg=
(D_TLS_DEBUG, &quot;Outgoing Plaintext -&gt; TLS&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>        =
 }</span><br><span>     }</span><br><span>     if (!check_outgoing_cipherte=
xt(ks, session, &amp;continue_tls_process))</span><br><span>diff --git a/sr=
c/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index 6f3=
10a5..6f3da11 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><=
br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -241,6 +241,8 @@=
</span><br><span>     struct buffer plaintext_read_buf;</span><br><span>   =
  struct buffer plaintext_write_buf;</span><br><span>     struct buffer ack=
_write_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer key_method_send_buf; /* larger buffer for key method 2 write */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer key=
_method_recv_buf; /* larger buffer for key method 2 read */</span><br><span=
> </span><br><span>     struct reliable *send_reliable; /* holds a copy of =
outgoing packets until ACK received */</span><br><span>     struct reliable=
 *rec_reliable;  /* order incoming ciphertext packets before we pass to TLS=
 */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">change 1622</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1622?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I055c64ca8b23066e70eea7d7ded=
dfb14f5354c5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1622 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--lZ1bRpWjkHU=--

