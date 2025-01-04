From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 4 Jan 2025 22:51:55 +0000
In-Reply-To: <gerrit.1734706182000.I81440ac28a1ad553652e201234e5ddfe03a8c190@...2715...>
References: <gerrit.1734706182000.I81440ac28a1ad553652e201234e5ddfe03a8c190@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <322eeca81814a3696b47b77a205c5e5b31be7651-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JM1NB2xvjnQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JM1NB2xvjnQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

Hello MaxF, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by MaxF


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
3 files changed, 41 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/843/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--JM1NB2xvjnQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Do not attempt to decrypt packets anymore after 2**36=
 failed decryptions<br><br>To avoid attacks (especially on Chacha20-Poly130=
5) we do not allow<br>decryption anymore after 2**36 failed verifications.<=
br><br>Change-Id: I81440ac28a1ad553652e201234e5ddfe03a8c190<br>Signed-off-b=
y: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br=
>M src/openvpn/crypto.h<br>M src/openvpn/ssl.c<br>3 files changed, 41 inser=
tions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/43/843/4</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/sr=
c/openvpn/crypto.c</span><br><span>index df38cdd..ee9b0c6 100644</span><br>=
<span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c=
</span><br><span>@@ -405,7 +405,13 @@</span><br><span> {</span><br><span>  =
   static const char error_prefix[] =3D &quot;AEAD Decrypt error&quot;;</sp=
an><br><span>     struct packet_id_net pin =3D { 0 };</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const struct key_ctx *ctx =3D &amp;opt-=
&gt;key_ctx_bi.decrypt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.decrypt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (cipher_decrypt_verify_fail_exceeded(ctx))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        CRYPT_DROP(&quot;Decrypti=
on failed verification limit reached.&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     int outlen;</span><br><span>     struct g=
c_arena gc;</span><br><span> </span><br><span>@@ -511,6 +517,7 @@</span><br=
><span>     if (!cipher_ctx_final_check_tag(ctx-&gt;cipher, BPTR(&amp;work)=
 + outlen,</span><br><span>                                     &amp;outlen=
, tag_ptr, tag_size))</span><br><span>     {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        ctx-&gt;failed_verifications++;</span><br>=
<span>         CRYPT_DROP(&quot;packet tag authentication failed&quot;);</s=
pan><br><span>     }</span><br><span>     ASSERT(buf_inc_len(&amp;work, out=
len));</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/cryp=
to.h</span><br><span>index 3ad31c5..fe81c7f 100644</span><br><span>--- a/sr=
c/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><sp=
an>@@ -209,6 +209,8 @@</span><br><span>      * with the current key in numb=
er of 128 bit blocks (only used for</span><br><span>      * AEAD ciphers) *=
/</span><br><span>     uint64_t plaintext_blocks;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /** number of failed verification using t=
his cipher */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt64_t failed_verifications;</span><br><span> };</span><br><span> </span><b=
r><span> #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both direct=
ions */</span><br><span>@@ -661,6 +663,32 @@</span><br><span> cipher_get_ae=
ad_limits(const char *ciphername);</span><br><span> </span><br><span> /**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if the numbe=
r of failed decryption is over the acceptable limit.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+cipher_decrypt_verify_fail_exceeded(const struct key_ctx *=
ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Use 2**36, same as DTLS 1.=
3. Strictly speaking this only guarantees</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * the security margin for packets up to 2^10 blo=
cks (16384 bytes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * but we accept slightly lower security bound for the edge</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * of Chacha20-Poly1305 and p=
ackets over 16k as MTUs over 16k are</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * extremely rarely used */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return ctx-&gt;failed_verifications &gt;  =
(1ull &lt;&lt; 36);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Check if the number of failed decryption is approa=
ching the limit and we</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * should try to move to a new key</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+cipher_decrypt_verify_fail_warn(const struct key_ctx *ctx)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Use 2**35, half the amount after which we refu=
se to decrypt */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return ctx-&gt;failed_verifications &gt;  (1ull &lt;&lt; 35);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span>  * Blocksize used for the AEAD limit caluclation</span><br><span>  =
*</span><br><span>  * Since cipher_ctx_block_size() is not reliable and wil=
l return 1 in many</span><br><span>diff --git a/src/openvpn/ssl.c b/src/ope=
nvpn/ssl.c</span><br><span>index cf7f34f..e4a7b57 100644</span><br><span>--=
- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><sp=
an>@@ -3005,6 +3005,11 @@</span><br><span>         return true;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (cipher_decrypt_verify_fail_warn(&amp;key_ctx_bi-&gt;decry=
pt))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return false;</span=
><br><span> }</span><br><span> /*</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail"=
>change 843</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81440ac28a1ad553652e201234e=
5ddfe03a8c190 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 843 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JM1NB2xvjnQ=--

