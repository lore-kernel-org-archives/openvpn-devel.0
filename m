From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 20 Dec 2024 14:49:59 +0000
References: <gerrit.1734706182000.I81440ac28a1ad553652e201234e5ddfe03a8c190@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a159b2d02a7bc4ec90fd87fbd1a0755dfd692f85-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MGJqC9CQcVE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not attempt to
 decrypt packets anymore after 2**36 failed decryptions
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

--MGJqC9CQcVE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail

to review the following change.


Change subject: Do not attempt to decrypt packets anymore after 2**36 faile=
d decryptions
......................................................................

Do not attempt to decrypt packets anymore after 2**36 failed decryptions

To avoid attacks (especially on Chacha20-Poly1305) we do not allow
decryption anymore after 2**36 failed verifications.

Change-Id: I81440ac28a1ad553652e201234e5ddfe03a8c190
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/ssl.c
3 files changed, 40 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/843/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index faf69fc..88a9f24 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -405,7 +405,13 @@
 {
     static const char error_prefix[] =3D "AEAD Decrypt error";
     struct packet_id_net pin =3D { 0 };
-    const struct key_ctx *ctx =3D &opt->key_ctx_bi.decrypt;
+    struct key_ctx *ctx =3D &opt->key_ctx_bi.decrypt;
+
+    if (cipher_decrypt_verify_fail_exceeded(ctx))
+    {
+        CRYPT_DROP("Decryption failed verification limit reached.");
+    }
+
     int outlen;
     struct gc_arena gc;

@@ -416,6 +422,8 @@
     ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);

+
+
     dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s",
          format_hex(BPTR(buf), BLEN(buf), 80, &gc));
=20
@@ -511,6 +519,7 @@
     if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen,
                                     &outlen, tag_ptr, tag_size))
     {
+        ctx->failed_verifications++;
         CRYPT_DROP("packet tag authentication failed");
     }
     ASSERT(buf_inc_len(&work, outlen));
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 4579b65..bb417e1 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -181,6 +181,8 @@
      * with the current key in number of 128 bit blocks (only used for
      * AEAD ciphers) */
     uint64_t plaintext_blocks;
+    /** number of failed verification using this cipher */
+    uint64_t failed_verifications;
 };

 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -623,6 +625,29 @@
 cipher_get_aead_limits(const char *ciphername);

 /**
+ * Check if the number of failed decryption is over the acceptable limit.
+ * We
+ */
+static inline bool
+cipher_decrypt_verify_fail_exceeded(const struct key_ctx *ctx)
+{
+    /* Use 2**36, same as TLS 1.3 */
+    return ctx->failed_verifications >  (1ull << 36);
+}
+
+/**
+ * Check if the number of failed decryption is approaching the limit and we
+ * should try to move to a new key
+ */
+static inline bool
+cipher_decrypt_verify_fail_warn(const struct key_ctx *ctx)
+{
+    /* Use 2**35, half the amount after which we refuse to decrypt */
+    return ctx->failed_verifications >  (1ull << 35);
+}
+
+
+/**
  * Blocksize used for the AEAD limit caluclation
  *
  * Since cipher_ctx_block_size() is not reliable and will return 1 in many
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c77c4ed..73201ef 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3042,6 +3042,11 @@
         return true;
     }

+    if (cipher_decrypt_verify_fail_warn(&key_ctx_bi->decrypt))
+    {
+        return true;
+    }
+
     return false;
 }
 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I81440ac28a1ad553652e201234e5ddfe03a8c190
Gerrit-Change-Number: 843
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--MGJqC9CQcVE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Do not attempt to decrypt packets anymore after 2**36 failed =
decryptions<br><br>To avoid attacks (especially on Chacha20-Poly1305) we do=
 not allow<br>decryption anymore after 2**36 failed verifications.<br><br>C=
hange-Id: I81440ac28a1ad553652e201234e5ddfe03a8c190<br>Signed-off-by: Arne =
Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/o=
penvpn/crypto.h<br>M src/openvpn/ssl.c<br>3 files changed, 40 insertions(+)=
, 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/43/843/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvp=
n/crypto.c</span><br><span>index faf69fc..88a9f24 100644</span><br><span>--=
- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><=
br><span>@@ -405,7 +405,13 @@</span><br><span> {</span><br><span>     stati=
c const char error_prefix[] =3D &quot;AEAD Decrypt error&quot;;</span><br><=
span>     struct packet_id_net pin =3D { 0 };</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const struct key_ctx *ctx =3D &amp;opt-&gt;key_=
ctx_bi.decrypt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.decrypt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (cipher_decrypt_verify_fail_exceeded(ctx))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        CRYPT_DROP(&quot;Decryption faile=
d verification limit reached.&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     int outlen;</span><br><span>     struct gc_arena =
gc;</span><br><span> </span><br><span>@@ -416,6 +422,8 @@</span><br><span> =
    ASSERT(buf-&gt;len &gt; 0);</span><br><span>     ASSERT(ctx-&gt;cipher)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;,</span><br><span>   =
       format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br><span> </s=
pan><br><span>@@ -511,6 +519,7 @@</span><br><span>     if (!cipher_ctx_fina=
l_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen,</span><br><span>     =
                                &amp;outlen, tag_ptr, tag_size))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 ctx-&gt;failed_verifications++;</span><br><span>         CRYPT_DROP(&quot;=
packet tag authentication failed&quot;);</span><br><span>     }</span><br><=
span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span>diff --gi=
t a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index 4579b=
65..bb417e1 100644</span><br><span>--- a/src/openvpn/crypto.h</span><br><sp=
an>+++ b/src/openvpn/crypto.h</span><br><span>@@ -181,6 +181,8 @@</span><br=
><span>      * with the current key in number of 128 bit blocks (only used =
for</span><br><span>      * AEAD ciphers) */</span><br><span>     uint64_t =
plaintext_blocks;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /** number of failed verification using this cipher */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint64_t failed_verifications;</sp=
an><br><span> };</span><br><span> </span><br><span> #define KEY_DIRECTION_B=
IDIRECTIONAL 0 /* same keys for both directions */</span><br><span>@@ -623,=
6 +625,29 @@</span><br><span> cipher_get_aead_limits(const char *ciphername=
);</span><br><span> </span><br><span> /**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Check if the number of failed decryption is over t=
he acceptable limit.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * We</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+cipher_decrypt_verify_fail_exc=
eeded(const struct key_ctx *ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Use 2**36, same as TLS 1.3 */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ctx-&gt;failed_verifications &gt;  (1ull &lt;&lt; 36=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Check if the number of failed decryption is approaching the limit a=
nd we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * should try =
to move to a new key</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_decrypt_v=
erify_fail_warn(const struct key_ctx *ctx)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Use 2**35, half the amount after which we refuse to decrypt */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctx-&gt;f=
ailed_verifications &gt;  (1ull &lt;&lt; 35);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Blocks=
ize used for the AEAD limit caluclation</span><br><span>  *</span><br><span=
>  * Since cipher_ctx_block_size() is not reliable and will return 1 in man=
y</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span>=
<br><span>index c77c4ed..73201ef 100644</span><br><span>--- a/src/openvpn/s=
sl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -3042,6 +30=
42,11 @@</span><br><span>         return true;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(cipher_decrypt_verify_fail_warn(&amp;key_ctx_bi-&gt;decrypt))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     return false;</span><br><span> }</spa=
n><br><span> /*</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail">change 843</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/843?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81440ac28a1ad553652e201234e=
5ddfe03a8c190 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 843 </div>
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


--MGJqC9CQcVE=--

