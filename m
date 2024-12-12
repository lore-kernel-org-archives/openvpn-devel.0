From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 15:26:38 +0000
In-Reply-To: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...,
 max@...2606..., a@...2181...
Message-ID: <cac93726ec91150e276c7ec557659d85ce973ce3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YQL6OO/6Wro="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Use XOR instead of
 concatenation for calculation of IV from implicit IV
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, syzzer <steffan@...1856...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YQL6OO/6Wro=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#11) to the change originally created b=
y plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Use XOR instead of concatenation for calculation of IV from=
 implicit IV
......................................................................

Use XOR instead of concatenation for calculation of IV from implicit IV

This change prepares the extended packet id data where also the packet id
part of the IV will be derived using xor.  Using xor also in the AEAD
case where this degenerates to a concatenation allows using the same
IV generation code later.

Change-Id: I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Steffan Karger <steffan@...1856...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241212143845.4090-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
097.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/ssl.c
M tests/unit_tests/openvpn/test_ssl.c
4 files changed, 33 insertions(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/797/11

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 8f34eaa..d548c8d 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -94,12 +94,16 @@
             goto err;
         }

-        /* Remainder of IV consists of implicit part (unique per session) =
*/
-        ASSERT(buf_write(&iv_buffer, ctx->implicit_iv, ctx->implicit_iv_le=
n));
-        ASSERT(iv_buffer.len =3D=3D iv_len);
+        /* Write packet id part of IV to work buffer */
+        ASSERT(buf_write(&work, iv, packet_id_size(false)));

-        /* Write explicit part of IV to work buffer */
-        ASSERT(buf_write(&work, iv, iv_len - ctx->implicit_iv_len));
+        /* This generates the IV by XORing the implicit part of the IV
+         * with the packet id already written to the iv buffer */
+        for (int i =3D 0; i < iv_len; i++)
+        {
+            iv[i] =3D iv[i] ^ ctx->implicit_iv[i];
+        }
+
         dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv, iv_len, 0,=
 &gc));

         /* Init cipher_ctx with IV.  key & keylen are already initialized =
*/
@@ -390,16 +394,21 @@
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };
         const int iv_len =3D cipher_ctx_iv_length(ctx->cipher);
-        const size_t packet_iv_len =3D iv_len - ctx->implicit_iv_len;
+        const size_t packet_iv_len =3D packet_id_size(false);

-        ASSERT(ctx->implicit_iv_len <=3D iv_len);
-        if (buf->len + ctx->implicit_iv_len < iv_len)
+        if (buf->len < packet_iv_len)
         {
             CRYPT_ERROR("missing IV info");
         }

         memcpy(iv, BPTR(buf), packet_iv_len);
-        memcpy(iv + packet_iv_len, ctx->implicit_iv, ctx->implicit_iv_len);
+
+        /* This generates the IV by XORing the implicit part of the IV
+         * with the packet id already written to the iv buffer */
+        for (int i =3D 0; i < iv_len; i++)
+        {
+            iv[i] =3D iv[i] ^ ctx->implicit_iv[i];
+        }

         dmsg(D_PACKET_CONTENT, "DECRYPT IV: %s", format_hex(iv, iv_len, 0,=
 &gc));

@@ -920,7 +929,6 @@
         hmac_ctx_free(ctx->hmac);
         ctx->hmac =3D NULL;
     }
-    ctx->implicit_iv_len =3D 0;
 }

 void
@@ -1036,18 +1044,15 @@
         cipher_ctx_t *cipher =3D co->key_ctx_bi.encrypt.cipher;
         if (cipher_ctx_mode_aead(cipher))
         {
-            size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - sizeof(p=
acket_id_type);
             ASSERT(cipher_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH=
);
             ASSERT(cipher_ctx_iv_length(cipher) >=3D OPENVPN_AEAD_MIN_IV_L=
EN);

             /* Generate dummy implicit IV */
             ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
                               OPENVPN_MAX_IV_LENGTH));
-            co->key_ctx_bi.encrypt.implicit_iv_len =3D impl_iv_len;

             memcpy(co->key_ctx_bi.decrypt.implicit_iv,
                    co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENG=
TH);
-            co->key_ctx_bi.decrypt.implicit_iv_len =3D impl_iv_len;
         }
     }

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 074dad6..04d7bb2 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -163,6 +163,17 @@
 {
     cipher_ctx_t *cipher;       /**< Generic cipher %context. */
     hmac_ctx_t *hmac;           /**< Generic HMAC %context. */
+    /**
+     * This implicit IV will be always XORed with the packet id that is se=
nt on
+     * the wire to get the IV. For the common AEAD ciphers of AES-GCM and
+     * Chacha20-Poly1305, the length of the IV is 12 bytes (96 bits).
+     *
+     * For non-epoch 32bit packet id AEAD format we set the first 32
+     * bits of implicit_iv to 0.
+     * Xor with the packet id in this case works as concatenation:
+     * after xor the lower 32 bit of the IV are the packet id and
+     * the rest of the IV is from the implicit IV.
+     */
     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
     /**< The implicit part of the IV */
     size_t implicit_iv_len;     /**< The length of implicit_iv */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33c22b4..fcfb344 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1542,10 +1542,11 @@
         size_t impl_iv_len =3D 0;
         ASSERT(cipher_ctx_iv_length(ctx->cipher) >=3D OPENVPN_AEAD_MIN_IV_=
LEN);
         impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_=
id_type);
-        ASSERT(impl_iv_len <=3D OPENVPN_MAX_IV_LENGTH);
+        ASSERT(impl_iv_len + sizeof(packet_id_type) <=3D OPENVPN_MAX_IV_LE=
NGTH);
         ASSERT(impl_iv_len <=3D key_len);
-        memcpy(ctx->implicit_iv, key, impl_iv_len);
-        ctx->implicit_iv_len =3D impl_iv_len;
+        CLEAR(ctx->implicit_iv);
+        /* The first bytes of the IV are filled with the packet id */
+        memcpy(ctx->implicit_iv + sizeof(packet_id_type), key, impl_iv_len=
);
     }
 }

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index a1ca344..ae33cc6 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -284,18 +284,15 @@

     if (cipher_ctx_mode_aead(cipher))
     {
-        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - sizeof(packe=
t_id_type);
         ASSERT(cipher_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH);
         ASSERT(cipher_ctx_iv_length(cipher) >=3D OPENVPN_AEAD_MIN_IV_LEN);

         /* Generate dummy implicit IV */
         ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
                           OPENVPN_MAX_IV_LENGTH));
-        co->key_ctx_bi.encrypt.implicit_iv_len =3D impl_iv_len;

         memcpy(co->key_ctx_bi.decrypt.implicit_iv,
                co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
-        co->key_ctx_bi.decrypt.implicit_iv_len =3D impl_iv_len;
     }
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6
Gerrit-Change-Number: 797
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: syzzer <steffan@...1856...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--YQL6OO/6Wro=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #11</strong> to the change originally c=
reated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/797?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Use XOR instead of concatenation for calculation of =
IV from implicit IV<br><br>This change prepares the extended packet id data=
 where also the packet id<br>part of the IV will be derived using xor.  Usi=
ng xor also in the AEAD<br>case where this degenerates to a concatenation a=
llows using the same<br>IV generation code later.<br><br>Change-Id: I74216d=
776d3e0a8dc987ec7b1671c8e8dcccdbd6<br>Signed-off-by: Arne Schwabe &lt;arne@=
...1227...&gt;<br>Acked-by: MaxF &lt;max@...2606...&gt;<br>Acked-by: Antoni=
o Quartulli &lt;antonio@...2726...&gt;<br>Acked-by: Steffan Karger &lt;stef=
fan@...1856...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Mes=
sage-Id: &lt;20241212143845.4090-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30097.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/cryp=
to.c<br>M src/openvpn/crypto.h<br>M src/openvpn/ssl.c<br>M tests/unit_tests=
/openvpn/test_ssl.c<br>4 files changed, 33 insertions(+), 19 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/79=
7/11</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span=
><br><span>index 8f34eaa..d548c8d 100644</span><br><span>--- a/src/openvpn/=
crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -94,=
12 +94,16 @@</span><br><span>             goto err;</span><br><span>       =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* Remainder of IV consists of implicit part (unique per session) *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_w=
rite(&amp;iv_buffer, ctx-&gt;implicit_iv, ctx-&gt;implicit_iv_len));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(iv_buffer.len=
 =3D=3D iv_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* Write packet id part of IV to work buffer */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(buf_write(&amp;work, iv, p=
acket_id_size(false)));</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /* Write explicit part of IV to work buffer */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_wri=
te(&amp;work, iv, iv_len - ctx-&gt;implicit_iv_len));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* This generates the IV by XORin=
g the implicit part of the IV</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * with the packet id already written to the iv buffer */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =
=3D 0; i &lt; iv_len; i++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         iv[i] =3D iv[i] ^ ctx-&gt;implicit_iv[i];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>         dmsg(D_PACKET_CONTENT, &quot=
;ENCRYPT IV: %s&quot;, format_hex(iv, iv_len, 0, &amp;gc));</span><br><span=
> </span><br><span>         /* Init cipher_ctx with IV.  key &amp; keylen a=
re already initialized */</span><br><span>@@ -390,16 +394,21 @@</span><br><=
span>     {</span><br><span>         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D =
{ 0 };</span><br><span>         const int iv_len =3D cipher_ctx_iv_length(c=
tx-&gt;cipher);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  const size_t packet_iv_len =3D iv_len - ctx-&gt;implicit_iv_len;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const size_t packet_=
iv_len =3D packet_id_size(false);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(ctx-&gt;implicit_iv_len &lt;=
=3D iv_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (buf-&gt;len + ctx-&gt;implicit_iv_len &lt; iv_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (buf-&gt;len &lt; packet_iv_le=
n)</span><br><span>         {</span><br><span>             CRYPT_ERROR(&quo=
t;missing IV info&quot;);</span><br><span>         }</span><br><span> </spa=
n><br><span>         memcpy(iv, BPTR(buf), packet_iv_len);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        memcpy(iv + packet_iv_len, ctx=
-&gt;implicit_iv, ctx-&gt;implicit_iv_len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* This generates the IV by XORing the implicit part of the IV=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * with the=
 packet id already written to the iv buffer */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; iv_len; i++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            iv[i] =3D iv[i] ^ ct=
x-&gt;implicit_iv[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span> </span><br><span>         dmsg(D_PACKET_CONTEN=
T, &quot;DECRYPT IV: %s&quot;, format_hex(iv, iv_len, 0, &amp;gc));</span><=
br><span> </span><br><span>@@ -920,7 +929,6 @@</span><br><span>         hma=
c_ctx_free(ctx-&gt;hmac);</span><br><span>         ctx-&gt;hmac =3D NULL;</=
span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    ctx-&gt;implicit_iv_len =3D 0;</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span>@@ -1036,18 +1044,15 @@</span><br><span>=
         cipher_ctx_t *cipher =3D co-&gt;key_ctx_bi.encrypt.cipher;</span><=
br><span>         if (cipher_ctx_mode_aead(cipher))</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            size_t=
 impl_iv_len =3D cipher_ctx_iv_length(cipher) - sizeof(packet_id_type);</sp=
an><br><span>             ASSERT(cipher_ctx_iv_length(cipher) &lt;=3D OPENV=
PN_MAX_IV_LENGTH);</span><br><span>             ASSERT(cipher_ctx_iv_length=
(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span> </span><br><spa=
n>             /* Generate dummy implicit IV */</span><br><span>           =
  ASSERT(rand_bytes(co-&gt;key_ctx_bi.encrypt.implicit_iv,</span><br><span>=
                               OPENVPN_MAX_IV_LENGTH));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            co-&gt;key_ctx_bi.encrypt.imp=
licit_iv_len =3D impl_iv_len;</span><br><span> </span><br><span>           =
  memcpy(co-&gt;key_ctx_bi.decrypt.implicit_iv,</span><br><span>           =
         co-&gt;key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            co-&gt;key_ct=
x_bi.decrypt.implicit_iv_len =3D impl_iv_len;</span><br><span>         }</s=
pan><br><span>     }</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index 074dad6..04d7bb2=
 100644</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/sr=
c/openvpn/crypto.h</span><br><span>@@ -163,6 +163,17 @@</span><br><span> {<=
/span><br><span>     cipher_ctx_t *cipher;       /**&lt; Generic cipher %co=
ntext. */</span><br><span>     hmac_ctx_t *hmac;           /**&lt; Generic =
HMAC %context. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * This im=
plicit IV will be always XORed with the packet id that is sent on</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * the wire to get the IV=
. For the common AEAD ciphers of AES-GCM and</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * Chacha20-Poly1305, the length of the IV is =
12 bytes (96 bits).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * For no=
n-epoch 32bit packet id AEAD format we set the first 32</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * bits of implicit_iv to 0.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * Xor with the packet=
 id in this case works as concatenation:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * after xor the lower 32 bit of the IV are the pa=
cket id and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * t=
he rest of the IV is from the implicit IV.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span>     uint8_t implicit_iv[OPE=
NVPN_MAX_IV_LENGTH];</span><br><span>     /**&lt; The implicit part of the =
IV */</span><br><span>     size_t implicit_iv_len;     /**&lt; The length o=
f implicit_iv */</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openv=
pn/ssl.c</span><br><span>index 33c22b4..fcfb344 100644</span><br><span>--- =
a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span=
>@@ -1542,10 +1542,11 @@</span><br><span>         size_t impl_iv_len =3D 0;=
</span><br><span>         ASSERT(cipher_ctx_iv_length(ctx-&gt;cipher) &gt;=
=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span>         impl_iv_len =3D ciph=
er_ctx_iv_length(ctx-&gt;cipher) - sizeof(packet_id_type);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(impl_iv_len &lt;=3D OPE=
NVPN_MAX_IV_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ASSERT(impl_iv_len + sizeof(packet_id_type) &lt;=3D OPENVPN_MAX_IV=
_LENGTH);</span><br><span>         ASSERT(impl_iv_len &lt;=3D key_len);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy(ctx-&gt;im=
plicit_iv, key, impl_iv_len);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        ctx-&gt;implicit_iv_len =3D impl_iv_len;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        CLEAR(ctx-&gt;implicit_iv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The first b=
ytes of the IV are filled with the packet id */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        memcpy(ctx-&gt;implicit_iv + sizeof(pac=
ket_id_type), key, impl_iv_len);</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>index a1ca344=
..ae33cc6 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@=
@ -284,18 +284,15 @@</span><br><span> </span><br><span>     if (cipher_ctx_=
mode_aead(cipher))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        size_t impl_iv_len =3D cipher_ctx_iv_length(cip=
her) - sizeof(packet_id_type);</span><br><span>         ASSERT(cipher_ctx_i=
v_length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>         A=
SSERT(cipher_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span>=
<br><span> </span><br><span>         /* Generate dummy implicit IV */</span=
><br><span>         ASSERT(rand_bytes(co-&gt;key_ctx_bi.encrypt.implicit_iv=
,</span><br><span>                           OPENVPN_MAX_IV_LENGTH));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        co-&gt;key_ctx_bi.e=
ncrypt.implicit_iv_len =3D impl_iv_len;</span><br><span> </span><br><span> =
        memcpy(co-&gt;key_ctx_bi.decrypt.implicit_iv,</span><br><span>     =
           co-&gt;key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co-&gt;key_ctx_=
bi.decrypt.implicit_iv_len =3D impl_iv_len;</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">chan=
ge 797</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b167=
1c8e8dcccdbd6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 797 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@...1856...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--YQL6OO/6Wro=--

