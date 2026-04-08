From: "Bluca (Code Review)" <gerrit@...515...>
Date: Wed, 8 Apr 2026 00:49:15 +0000
In-Reply-To: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
References: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
Reply-To: luca.boccassi@...277..., arne-openvpn@...1227...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <ec863163a91e4e7a8f420809e857c8c44d5b70e7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DLeBePOdRrI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, selvanair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DLeBePOdRrI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Bluca, plaisthos, selvanair.

Hello plaisthos, selvanair,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


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

Servers after a7f80d402f send a useful and clear error message.
With older servers the client will instead print a helpful error
for the user, to ensure a good UX in either case.

Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
---
M src/openvpn/common.h
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
3 files changed, 130 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1622/2

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
index 576157d..bcf2464 100644
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
@@ -906,6 +908,16 @@
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
+            "The server may not support large key exchange payloads.",
+            TLS_CHANNEL_BUF_SIZE);
+    }
+
     ks->state =3D S_UNDEF;

     key_state_ssl_free(&ks->ks_ssl);
@@ -915,6 +927,8 @@
     free_buf(&ks->plaintext_read_buf);
     free_buf(&ks->plaintext_write_buf);
     free_buf(&ks->ack_write_buf);
+    free_buf(&ks->key_method_send_buf);
+    free_buf(&ks->key_method_recv_buf);
     buffer_list_free(ks->paybuf);

     reliable_free(ks->send_reliable);
@@ -2624,6 +2638,54 @@
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
@@ -2836,38 +2898,58 @@
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
@@ -2877,20 +2959,38 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: Bluca <luca.boccassi@...277...>
Gerrit-Attention: selvanair <selva.nair@...277...>

--DLeBePOdRrI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Bluca, plaisthos, selvanair. </p>
<p>Bluca <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Add new helpers to handle key e=
xchange (S_SENT_KEY/S_START) with large passwords<br><br>The current key ex=
change uses an intermediate buffer hardcoded<br>at 2048 bytes, that cannot =
handle anything longer, as it gets<br>silently truncated.<br><br>This break=
s using JIT use-once tokens for authentications, that<br>are becoming commo=
n in enterprise devices to reduce attack<br>surfaces, as the tokens are typ=
ically long JWT encoded strings.<br><br>Add new helpers that, instead of do=
ing a single 2048 bytes<br>read/write from/to the TLS layer, reads/writes a=
ll the available<br>data when doing the key method 2 exchange.<br>Other sta=
ges of the protocol are unaffected. Note that this is<br>an intermediary bu=
ffer, the TLS layer is already handling<br>fragmented/reassembled frames ap=
propriately, so there is no<br>on-the-wire difference, aside from letting t=
he client send more<br>data.<br><br>Older servers will simply continue to t=
runcate passwords longer<br>than the existing limit, as they are doing curr=
ently, so no<br>incompatible changes, behaviour stays the same and current =
valid<br>passwords are still valid when the new client uses them.<br>When a=
n old client talks to a new server, likewise there are no<br>changes, as th=
e previous clients have the embedded limit, so all<br>existing passwords wi=
ll continue to work.<br><br>Tested combinations:<br><br>old client &lt;--&g=
t; new server<br>new client &lt;--&gt; old server<br>new client &lt;--&gt; =
new server<br><br>With the last combination, a large password can be used s=
uccessfully.<br>With either an old server or old client, existing limits ap=
ply and<br>a clear error is shown in case one tries a password longer than =
the<br>existing limits.<br><br>Servers after a7f80d402f send a useful and c=
lear error message.<br>With older servers the client will instead print a h=
elpful error<br>for the user, to ensure a good UX in either case.<br><br>Ch=
ange-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f<br>Signed-off-by: Luca B=
occassi &lt;luca.boccassi@...277...&gt;<br>---<br>M src/openvpn/common.h<br=
>M src/openvpn/ssl.c<br>M src/openvpn/ssl_common.h<br>3 files changed, 130 =
insertions(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/22/1622/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/common.h b/src/openvpn/common.h</span><br><span>index aa7b721..=
b67a6f4 100644</span><br><span>--- a/src/openvpn/common.h</span><br><span>+=
++ b/src/openvpn/common.h</span><br><span>@@ -69,6 +69,16 @@</span><br><spa=
n>  */</span><br><span> #define TLS_CHANNEL_BUF_SIZE 2048</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Buffer size for key method 2 exch=
ange data. This needs to be</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * large enough to hold the key source material, options string,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * username, password =
and peer info. When USER_PASS_LEN is larger</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * than the default TLS channel size (e.g. with ENA=
BLE_PKCS11),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * we n=
eed a larger buffer. The key exchange write and read paths</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * handle this by doing multiple TLS=
 writes/reads as needed.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define KEY=
_METHOD_BUF_SIZE (TLS_CHANNEL_BUF_SIZE + 2 * USER_PASS_LEN)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* TLS control bu=
ffer minimum size</span><br><span>  *</span><br><span>  * A control frame m=
ight have IPv6 header (40 byte),</span><br><span>diff --git a/src/openvpn/s=
sl.c b/src/openvpn/ssl.c</span><br><span>index 576157d..bcf2464 100644</spa=
n><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c=
</span><br><span>@@ -860,6 +860,8 @@</span><br><span>     ks-&gt;plaintext_=
read_buf =3D alloc_buf(TLS_CHANNEL_BUF_SIZE);</span><br><span>     ks-&gt;p=
laintext_write_buf =3D alloc_buf(TLS_CHANNEL_BUF_SIZE);</span><br><span>   =
  ks-&gt;ack_write_buf =3D alloc_buf(BUF_SIZE(&amp;session-&gt;opt-&gt;fram=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;key_=
method_send_buf =3D alloc_buf(KEY_METHOD_BUF_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;key_method_recv_buf =3D alloc_=
buf(KEY_METHOD_BUF_SIZE);</span><br><span>     reliable_init(ks-&gt;send_re=
liable, BUF_SIZE(&amp;session-&gt;opt-&gt;frame),</span><br><span>         =
          session-&gt;opt-&gt;frame.buf.headroom, TLS_RELIABLE_N_SEND_BUFFE=
RS,</span><br><span>                   ks-&gt;key_id ? false : session-&gt;=
opt-&gt;xmit_hold);</span><br><span>@@ -906,6 +908,16 @@</span><br><span> s=
tatic void</span><br><span> key_state_free(struct key_state *ks, bool clear=
)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (ks-&gt;key_method_large_payload &amp;&amp; ks-&gt;state &gt;=3D S_=
SENT_KEY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &am=
p;&amp; ks-&gt;state &lt; S_ACTIVE)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Servers before a7f80d402f do not send back a useful error so p=
rint one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN, &quot;Connection failed after sending a key exchange &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;paylo=
ad larger than %d bytes (due to a long password). &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;The server may not s=
upport large key exchange payloads.&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            TLS_CHANNEL_BUF_SIZE);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     ks-&gt;state =3D S_UNDEF;</sp=
an><br><span> </span><br><span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);=
</span><br><span>@@ -915,6 +927,8 @@</span><br><span>     free_buf(&amp;ks-=
&gt;plaintext_read_buf);</span><br><span>     free_buf(&amp;ks-&gt;plaintex=
t_write_buf);</span><br><span>     free_buf(&amp;ks-&gt;ack_write_buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;ks-&g=
t;key_method_send_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    free_buf(&amp;ks-&gt;key_method_recv_buf);</span><br><span>     buf=
fer_list_free(ks-&gt;paybuf);</span><br><span> </span><br><span>     reliab=
le_free(ks-&gt;send_reliable);</span><br><span>@@ -2624,6 +2638,54 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Read all currently available plaintext fro=
m the TLS object into buf,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * doing multiple reads if necessary. This is used for key method 2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * exchange data whi=
ch may exceed a single TLS_CHANNEL_BUF_SIZE read</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * when long passwords/tokens are used.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+read_incoming_tls_plaintext_multi(struct key_stat=
e *ks, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                  interval_t *wakeup, bool *continue=
_tls_process)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer tmp =
=3D alloc_buf(TLS_CHANNEL_BUF_SIZE);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  while (buf_forward_capacity(buf) &gt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf_init(&amp;tmp, 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        int status =3D key_state_read_plaintext(&amp;ks=
-&gt;ks_ssl, &amp;tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        update_=
time();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
status =3D=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              &quot;TLS Error: TLS object -&gt; incoming plaintext read err=
or&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   free_buf(&amp;tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (status =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (!buf_write(buf, BPTR(&amp;tmp), BLEN(&amp;tmp)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                msg(D_TLS_ERRORS,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quo=
t;TLS Error: key exchange plaintext too large&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                free_buf(&amp;tmp);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *continue=
_tls_process =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            *wakeup =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            dmsg(D_TLS_DEBUG, &quot;TLS -&gt; Incoming Plaintext =
(key exchange)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free_buf(&amp;tmp);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static bool</span><br><span> write_outgoing_tls_ciphertext(struct t=
ls_session *session, bool *continue_tls_process)</span><br><span> {</span><=
br><span>@@ -2836,38 +2898,58 @@</span><br><span>     }</span><br><span> </=
span><br><span>     /* Read incoming plaintext from TLS object */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D &amp=
;ks-&gt;plaintext_read_buf;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (!buf-&gt;len)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool in_key_exchange_read =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        (ks-&gt;state =3D=3D S_SENT_KEY &amp;&amp; !s=
ession-&gt;opt-&gt;server)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        || (ks-&gt;state =3D=3D S_START &amp;&amp; session-&gt;opt-&=
gt;server);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (in_key_exchange_rea=
d)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (!read_incoming_tls_plaintext(ks, buf, wakeup, &amp;continue=
_tls_process))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* For key exchange, read all available plaintext into a buffer</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * that is large eno=
ugh for long passwords/tokens. Multiple reads</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * are done to handle data exceeding TLS_=
CHANNEL_BUF_SIZE. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!read_incoming_tls_plaintext_multi(ks, &amp;ks-&gt;key_method_=
recv_buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                     wakeup, &amp;continue_tls_process))</s=
pan><br><span>         {</span><br><span>             goto error;</span><br=
><span>         }</span><br><span>     }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct buffer *buf =3D &amp;ks-&gt;plaintext_read_buf;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (!buf-&gt;len)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (!read_incoming_tls_plain=
text(ks, buf, wakeup, &amp;continue_tls_process))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                goto error;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* Send Key */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    buf =3D &amp;ks-&gt;plaintext_write_buf;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!buf-&gt;len</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Send Key -- use larger key_=
method_send_buf for assembly to support</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * long passwords/tokens that exceed TLS_CHANNEL_BU=
F_SIZE */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!k=
s-&gt;key_method_send_buf.len</span><br><span>         &amp;&amp; ((ks-&gt;=
state =3D=3D S_START &amp;&amp; !session-&gt;opt-&gt;server)</span><br><spa=
n>             || (ks-&gt;state =3D=3D S_GOT_KEY &amp;&amp; session-&gt;opt=
-&gt;server)))</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!key_method_2_write(buf, multi, session))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!key_method_2=
_write(&amp;ks-&gt;key_method_send_buf, multi, session))</span><br><span>  =
       {</span><br><span>             goto error;</span><br><span>         =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        ks-&gt;key_method_large_payload =3D</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            BLEN(&amp;ks-&gt;key_method_send_buf) &=
gt; TLS_CHANNEL_BUF_SIZE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>         continue_tls_process =3D true;</span><br><s=
pan>         dmsg(D_TLS_DEBUG_MED, &quot;STATE S_SENT_KEY&quot;);</span><br=
><span>         ks-&gt;state =3D S_SENT_KEY;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Rece=
ive Key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D=
 &amp;ks-&gt;plaintext_read_buf;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (buf-&gt;len</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Receive Key -- use the larger key_method_recv_buf */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(&amp;ks-&gt=
;key_method_recv_buf)</span><br><span>         &amp;&amp; ((ks-&gt;state =
=3D=3D S_SENT_KEY &amp;&amp; !session-&gt;opt-&gt;server)</span><br><span> =
            || (ks-&gt;state =3D=3D S_START &amp;&amp; session-&gt;opt-&gt;=
server)))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!key_method_2_read(buf, multi, session))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!key_method_2_read(=
&amp;ks-&gt;key_method_recv_buf, multi, session))</span><br><span>         =
{</span><br><span>             goto error;</span><br><span>         }</span=
><br><span>@@ -2877,20 +2959,38 @@</span><br><span>         ks-&gt;state =
=3D S_GOT_KEY;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* Write outgoing plaintext to TLS ob=
ject */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D &a=
mp;ks-&gt;plaintext_write_buf;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (buf-&gt;len)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Write key exchange data to TLS object */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;key_method_send_buf.le=
n)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        int status =3D key_state_write_plaintext(&amp;ks-&gt;ks_ssl, bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int stat=
us =3D key_state_write_plaintext(&amp;ks-&gt;ks_ssl, &amp;ks-&gt;key_method=
_send_buf);</span><br><span>         if (status =3D=3D -1)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(D_TLS_ERRORS, &quot;TLS ERROR: Outgoing Plaintext -&gt; TLS object wri=
te error&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(D_TLS_ERRORS, &quot;TLS ERROR: Key Method -&gt; TLS object wri=
te error&quot;);</span><br><span>             goto error;</span><br><span> =
        }</span><br><span>         if (status =3D=3D 1)</span><br><span>   =
      {</span><br><span>             continue_tls_process =3D true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_TLS_DEBUG,=
 &quot;Outgoing Plaintext -&gt; TLS&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            dmsg(D_TLS_DEBUG, &quot;Key Method -&gt=
; TLS&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Write outgoing plaintext to TLS object */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct buffer *buf =3D &am=
p;ks-&gt;plaintext_write_buf;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (buf-&gt;len)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            int status =3D key_state_write_plaintext(&amp;ks-&gt;ks_ss=
l, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (status =3D=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             msg(D_TLS_ERRORS, &quot;TLS ERROR: Outgoing Plaintext -&gt; TL=
S object write error&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                goto error;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (status =3D=3D 1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                continue_tls_process =3D true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                dmsg(D_TLS_DEB=
UG, &quot;Outgoing Plaintext -&gt; TLS&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><=
br><span>     }</span><br><span>     if (!check_outgoing_ciphertext(ks, ses=
sion, &amp;continue_tls_process))</span><br><span>diff --git a/src/openvpn/=
ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index 6f310a5..913a=
0c2 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+=
++ b/src/openvpn/ssl_common.h</span><br><span>@@ -241,6 +241,9 @@</span><br=
><span>     struct buffer plaintext_read_buf;</span><br><span>     struct b=
uffer plaintext_write_buf;</span><br><span>     struct buffer ack_write_buf=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
key_method_send_buf; /* larger buffer for key method 2 write */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer key_method_re=
cv_buf; /* larger buffer for key method 2 read */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool key_method_large_payload;     /* key=
 exchange exceeded TLS_CHANNEL_BUF_SIZE */</span><br><span> </span><br><spa=
n>     struct reliable *send_reliable; /* holds a copy of outgoing packets =
until ACK received */</span><br><span>     struct reliable *rec_reliable;  =
/* order incoming ciphertext packets before we pass to TLS */</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1622?usp=3Demail">change 1622</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1622?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I055c64ca8b23066e70eea7d7ded=
dfb14f5354c5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1622 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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

--DLeBePOdRrI=--

