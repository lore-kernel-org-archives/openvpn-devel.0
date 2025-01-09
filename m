From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 9 Jan 2025 21:26:01 +0000
In-Reply-To: <gerrit.1734706182000.I81440ac28a1ad553652e201234e5ddfe03a8c190@...2715...>
References: <gerrit.1734706182000.I81440ac28a1ad553652e201234e5ddfe03a8c190@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <8f3822baac0b4bfb5a2f3c918fc579a66a4eb410-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vavCZzfjejk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vavCZzfjejk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/84=
3?usp=3Demail )

Change subject: Do not attempt to decrypt packets anymore after 2**36 faile=
d decryptions
......................................................................

Do not attempt to decrypt packets anymore after 2**36 failed decryptions

To avoid attacks (especially on Chacha20-Poly1305) we do not allow
decryption anymore after 2**36 failed verifications.

After 2**35, we trigger a renegotiation (to avoid that situation).

For the theoretical background, see

   - https://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/
   - RFC 9147 (DTLS 1.3) section 4.5.3 "AEAD limits"
   - https://eprint.iacr.org/2024/051.pdf

Change-Id: I81440ac28a1ad553652e201234e5ddfe03a8c190
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250109174928.17862-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
387.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/ssl.c
3 files changed, 41 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index df38cdd..ee9b0c6 100644
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

@@ -511,6 +517,7 @@
     if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen,
                                     &outlen, tag_ptr, tag_size))
     {
+        ctx->failed_verifications++;
         CRYPT_DROP("packet tag authentication failed");
     }
     ASSERT(buf_inc_len(&work, outlen));
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 3ad31c5..fe81c7f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -209,6 +209,8 @@
      * with the current key in number of 128 bit blocks (only used for
      * AEAD ciphers) */
     uint64_t plaintext_blocks;
+    /** number of failed verification using this cipher */
+    uint64_t failed_verifications;
 };

 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -661,6 +663,32 @@
 cipher_get_aead_limits(const char *ciphername);

 /**
+ * Check if the number of failed decryption is over the acceptable limit.
+ */
+static inline bool
+cipher_decrypt_verify_fail_exceeded(const struct key_ctx *ctx)
+{
+    /* Use 2**36, same as DTLS 1.3. Strictly speaking this only guarantees
+     * the security margin for packets up to 2^10 blocks (16384 bytes)
+     * but we accept slightly lower security bound for the edge
+     * of Chacha20-Poly1305 and packets over 16k as MTUs over 16k are
+     * extremely rarely used */
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
index cf7f34f..e4a7b57 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3005,6 +3005,11 @@
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
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--vavCZzfjejk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/843?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Do not attempt to decrypt packets anymore afte=
r 2**36 failed decryptions<br><br>To avoid attacks (especially on Chacha20-=
Poly1305) we do not allow<br>decryption anymore after 2**36 failed verifica=
tions.<br><br>After 2**35, we trigger a renegotiation (to avoid that situat=
ion).<br><br>For the theoretical background, see<br><br>   - https://datatr=
acker.ietf.org/doc/draft-irtf-cfrg-aead-limits/<br>   - RFC 9147 (DTLS 1.3)=
 section 4.5.3 &quot;AEAD limits&quot;<br>   - https://eprint.iacr.org/2024=
/051.pdf<br><br>Change-Id: I81440ac28a1ad553652e201234e5ddfe03a8c190<br>Sig=
ned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: MaxF &lt;max@=
...2606...&gt;<br>Message-Id: &lt;20250109174928.17862-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg30387.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/ssl.c=
<br>3 files changed, 41 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span=
>index df38cdd..ee9b0c6 100644</span><br><span>--- a/src/openvpn/crypto.c</=
span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -405,7 +405,13=
 @@</span><br><span> {</span><br><span>     static const char error_prefix[=
] =3D &quot;AEAD Decrypt error&quot;;</span><br><span>     struct packet_id=
_net pin =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.decrypt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct key_ctx *ctx =3D &a=
mp;opt-&gt;key_ctx_bi.decrypt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
cipher_decrypt_verify_fail_exceeded(ctx))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        CRYPT_DROP(&quot;Decryption failed verification limit reach=
ed.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     =
int outlen;</span><br><span>     struct gc_arena gc;</span><br><span> </spa=
n><br><span>@@ -511,6 +517,7 @@</span><br><span>     if (!cipher_ctx_final_=
check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen,</span><br><span>       =
                              &amp;outlen, tag_ptr, tag_size))</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
tx-&gt;failed_verifications++;</span><br><span>         CRYPT_DROP(&quot;pa=
cket tag authentication failed&quot;);</span><br><span>     }</span><br><sp=
an>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span>diff --git =
a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index 3ad31c5=
..fe81c7f 100644</span><br><span>--- a/src/openvpn/crypto.h</span><br><span=
>+++ b/src/openvpn/crypto.h</span><br><span>@@ -209,6 +209,8 @@</span><br><=
span>      * with the current key in number of 128 bit blocks (only used fo=
r</span><br><span>      * AEAD ciphers) */</span><br><span>     uint64_t pl=
aintext_blocks;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/** number of failed verification using this cipher */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint64_t failed_verifications;</span=
><br><span> };</span><br><span> </span><br><span> #define KEY_DIRECTION_BID=
IRECTIONAL 0 /* same keys for both directions */</span><br><span>@@ -661,6 =
+663,32 @@</span><br><span> cipher_get_aead_limits(const char *ciphername);=
</span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Check if the number of failed decryption is over the=
 acceptable limit.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_decrypt_ver=
ify_fail_exceeded(const struct key_ctx *ctx)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Use 2**36, same as DTLS 1.3. Strictly speaking this only guar=
antees</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the se=
curity margin for packets up to 2^10 blocks (16384 bytes)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * but we accept slightly lower s=
ecurity bound for the edge</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * of Chacha20-Poly1305 and packets over 16k as MTUs over 16k ar=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * extremely r=
arely used */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn ctx-&gt;failed_verifications &gt;  (1ull &lt;&lt; 36);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if t=
he number of failed decryption is approaching the limit and we</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * should try to move to a new k=
ey</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+cipher_decrypt_verify_fail_warn(co=
nst struct key_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Use 2*=
*35, half the amount after which we refuse to decrypt */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return ctx-&gt;failed_verification=
s &gt;  (1ull &lt;&lt; 35);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span>  * Blocksize used for the A=
EAD limit caluclation</span><br><span>  *</span><br><span>  * Since cipher_=
ctx_block_size() is not reliable and will return 1 in many</span><br><span>=
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index cf=
7f34f..e4a7b57 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><sp=
an>+++ b/src/openvpn/ssl.c</span><br><span>@@ -3005,6 +3005,11 @@</span><br=
><span>         return true;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_decrypt_ve=
rify_fail_warn(&amp;key_ctx_bi-&gt;decrypt))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     return false;</span><br><span> }</span><br><span> /*</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/843?usp=3Demail">change 843</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/843?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81440ac28a1ad553652e201234e=
5ddfe03a8c190 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 843 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--vavCZzfjejk=--

