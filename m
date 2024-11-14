From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 14 Nov 2024 13:45:07 +0000
In-Reply-To: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296..., a@...2181...
Message-ID: <e2d95ff0daa1f1e1037be0ee48b6e0f7c66f8342-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m1pi0sIRYIc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--m1pi0sIRYIc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail

to look at the new patch set (#3).


Change subject: Use XOR instead of concatenation for calculation of  IV fro=
m implicit IV
......................................................................

Use XOR instead of concatenation for calculation of  IV from implicit IV

This change prepares the extended packet id data where also the packet id
part of the IV will be derived using xor.  Using xor also in the AEAD
case where this degenerates to a concatenation allows using the same
IV generation code later.

Change-Id: I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/ssl.c
M tests/unit_tests/openvpn/test_ssl.c
4 files changed, 31 insertions(+), 20 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/797/3

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d136663..53c990b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -95,12 +95,16 @@
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
@@ -428,16 +432,21 @@
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };
         const int iv_len =3D cipher_ctx_iv_length(ctx->cipher);
-        const size_t packet_iv_len =3D iv_len - ctx->implicit_iv_len;
+        const size_t packet_iv_len =3D packet_id_size(false);

-        ASSERT(ctx->implicit_iv_len <=3D iv_len);
-        if (buf->len + ctx->implicit_iv_len < iv_len)
+        if (buf->len < packet_id_size(false))
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

@@ -963,7 +972,6 @@
         hmac_ctx_free(ctx->hmac);
         ctx->hmac =3D NULL;
     }
-    ctx->implicit_iv_len =3D 0;
 }

 void
@@ -1079,18 +1087,15 @@
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
index 7b0f713..2baba73 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -163,9 +163,17 @@
 {
     cipher_ctx_t *cipher;       /**< Generic cipher %context. */
     hmac_ctx_t *hmac;           /**< Generic HMAC %context. */
+    /**
+     * This implicit IV will be always XORed with the packet id that is se=
nt on
+     * the wire to get the IV. For the common AEAD ciphers of AES-GCM and
+     * Chacha20-Poly1305, the length of the IV is 12 bytes (96 bits).
+     *
+     * For the older AEAD format we set the first 32 bits of implicit_iv t=
o 0.
+     * Xor with the packet id in this case works as concatenation:
+     * after xor the lower 32 bit of the IV are the packet id and
+     * the rest of the IV is from the implicit IV.
+     */
     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
-    /**< The implicit part of the IV */
-    size_t implicit_iv_len;     /**< The length of implicit_iv */
     /** Counter for the number of plaintext encrypted using this cipher
      * in number of 128 bit blocks (only used for AEAD ciphers) */
     uint64_t plaintext_blocks;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index a8cc83b..2d6cf64 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1562,8 +1562,9 @@
         impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_=
id_type);
         ASSERT(impl_iv_len <=3D OPENVPN_MAX_IV_LENGTH);
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--m1pi0sIRYIc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Use XOR instead of concatenation for calculation of  IV from implicit=
 IV<br><br>This change prepares the extended packet id data where also the =
packet id<br>part of the IV will be derived using xor.  Using xor also in t=
he AEAD<br>case where this degenerates to a concatenation allows using the =
same<br>IV generation code later.<br><br>Change-Id: I74216d776d3e0a8dc987ec=
7b1671c8e8dcccdbd6<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<b=
r>---<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/=
ssl.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>4 files changed, 31 inser=
tions(+), 20 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/97/797/3</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/=
src/openvpn/crypto.c</span><br><span>index d136663..53c990b 100644</span><b=
r><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto=
.c</span><br><span>@@ -95,12 +95,16 @@</span><br><span>             goto er=
r;</span><br><span>         }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /* Remainder of IV consists of implicit p=
art (unique per session) */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ASSERT(buf_write(&amp;iv_buffer, ctx-&gt;implicit_iv, ctx-&gt=
;implicit_iv_len));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      ASSERT(iv_buffer.len =3D=3D iv_len);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* Write packet id part of IV to work buffer=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(b=
uf_write(&amp;work, iv, packet_id_size(false)));</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* Write explicit part=
 of IV to work buffer */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        ASSERT(buf_write(&amp;work, iv, iv_len - ctx-&gt;implicit_iv_len=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* This =
generates the IV by XORing the implicit part of the IV</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * with the packet id already wr=
itten to the iv buffer */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for (int i =3D 0; i &lt; iv_len; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            iv[i] =3D iv[i] ^ ctx-&gt;implicit_iv[i=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         d=
msg(D_PACKET_CONTENT, &quot;ENCRYPT IV: %s&quot;, format_hex(iv, iv_len, 0,=
 &amp;gc));</span><br><span> </span><br><span>         /* Init cipher_ctx w=
ith IV.  key &amp; keylen are already initialized */</span><br><span>@@ -42=
8,16 +432,21 @@</span><br><span>     {</span><br><span>         uint8_t iv[=
OPENVPN_MAX_IV_LENGTH] =3D { 0 };</span><br><span>         const int iv_len=
 =3D cipher_ctx_iv_length(ctx-&gt;cipher);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        const size_t packet_iv_len =3D iv_len - ctx-&g=
t;implicit_iv_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const size_t packet_iv_len =3D packet_id_size(false);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(ctx=
-&gt;implicit_iv_len &lt;=3D iv_len);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (buf-&gt;len + ctx-&gt;implicit_iv_len &lt; iv_l=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (buf-=
&gt;len &lt; packet_id_size(false))</span><br><span>         {</span><br><s=
pan>             CRYPT_ERROR(&quot;missing IV info&quot;);</span><br><span>=
         }</span><br><span> </span><br><span>         memcpy(iv, BPTR(buf),=
 packet_iv_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   memcpy(iv + packet_iv_len, ctx-&gt;implicit_iv, ctx-&gt;implicit_iv_len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* This generates the IV by X=
ORing the implicit part of the IV</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * with the packet id already written to the iv buffe=
r */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (in=
t i =3D 0; i &lt; iv_len; i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            iv[i] =3D iv[i] ^ ctx-&gt;implicit_iv[i];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><s=
pan>         dmsg(D_PACKET_CONTENT, &quot;DECRYPT IV: %s&quot;, format_hex(=
iv, iv_len, 0, &amp;gc));</span><br><span> </span><br><span>@@ -963,7 +972,=
6 @@</span><br><span>         hmac_ctx_free(ctx-&gt;hmac);</span><br><span>=
         ctx-&gt;hmac =3D NULL;</span><br><span>     }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;implicit_iv_len =3D 0;</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span>@@ -107=
9,18 +1087,15 @@</span><br><span>         cipher_ctx_t *cipher =3D co-&gt;k=
ey_ctx_bi.encrypt.cipher;</span><br><span>         if (cipher_ctx_mode_aead=
(cipher))</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            size_t impl_iv_len =3D cipher_ctx_iv_length(ciph=
er) - sizeof(packet_id_type);</span><br><span>             ASSERT(cipher_ct=
x_iv_length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>       =
      ASSERT(cipher_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);=
</span><br><span> </span><br><span>             /* Generate dummy implicit =
IV */</span><br><span>             ASSERT(rand_bytes(co-&gt;key_ctx_bi.encr=
ypt.implicit_iv,</span><br><span>                               OPENVPN_MAX=
_IV_LENGTH));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    co-&gt;key_ctx_bi.encrypt.implicit_iv_len =3D impl_iv_len;</span><br><s=
pan> </span><br><span>             memcpy(co-&gt;key_ctx_bi.decrypt.implici=
t_iv,</span><br><span>                    co-&gt;key_ctx_bi.encrypt.implici=
t_iv, OPENVPN_MAX_IV_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            co-&gt;key_ctx_bi.decrypt.implicit_iv_len =3D impl_iv_l=
en;</span><br><span>         }</span><br><span>     }</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span=
><br><span>index 7b0f713..2baba73 100644</span><br><span>--- a/src/openvpn/=
crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -163=
,9 +163,17 @@</span><br><span> {</span><br><span>     cipher_ctx_t *cipher;=
       /**&lt; Generic cipher %context. */</span><br><span>     hmac_ctx_t =
*hmac;           /**&lt; Generic HMAC %context. */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * This implicit IV will be always XORed with the pa=
cket id that is sent on</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * the wire to get the IV. For the common AEAD ciphers of AES-GCM a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Chacha20-P=
oly1305, the length of the IV is 12 bytes (96 bits).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * For the older AEAD format we set the first 32 b=
its of implicit_iv to 0.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * Xor with the packet id in this case works as concatenation:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * after xor the lo=
wer 32 bit of the IV are the packet id and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * the rest of the IV is from the implicit IV.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><sp=
an>     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /**&lt; The implicit part of the IV */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t implicit_iv=
_len;     /**&lt; The length of implicit_iv */</span><br><span>     /** Cou=
nter for the number of plaintext encrypted using this cipher</span><br><spa=
n>      * in number of 128 bit blocks (only used for AEAD ciphers) */</span=
><br><span>     uint64_t plaintext_blocks;</span><br><span>diff --git a/src=
/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index a8cc83b..2d6cf64 1=
00644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/ope=
nvpn/ssl.c</span><br><span>@@ -1562,8 +1562,9 @@</span><br><span>         i=
mpl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - sizeof(packet_id_type=
);</span><br><span>         ASSERT(impl_iv_len &lt;=3D OPENVPN_MAX_IV_LENGT=
H);</span><br><span>         ASSERT(impl_iv_len &lt;=3D key_len);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy(ctx-&gt;implicit=
_iv, key, impl_iv_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ctx-&gt;implicit_iv_len =3D impl_iv_len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        CLEAR(ctx-&gt;implicit_iv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* The first bytes o=
f the IV are filled with the packet id */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        memcpy(ctx-&gt;implicit_iv + sizeof(packet_id=
_type), key, impl_iv_len);</span><br><span>     }</span><br><span> }</span>=
<br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.=
c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>index a1ca344..ae33=
cc6 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -284=
,18 +284,15 @@</span><br><span> </span><br><span>     if (cipher_ctx_mode_a=
ead(cipher))</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) -=
 sizeof(packet_id_type);</span><br><span>         ASSERT(cipher_ctx_iv_leng=
th(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>         ASSERT(=
cipher_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><s=
pan> </span><br><span>         /* Generate dummy implicit IV */</span><br><=
span>         ASSERT(rand_bytes(co-&gt;key_ctx_bi.encrypt.implicit_iv,</spa=
n><br><span>                           OPENVPN_MAX_IV_LENGTH));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        co-&gt;key_ctx_bi.encrypt=
.implicit_iv_len =3D impl_iv_len;</span><br><span> </span><br><span>       =
  memcpy(co-&gt;key_ctx_bi.decrypt.implicit_iv,</span><br><span>           =
     co-&gt;key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        co-&gt;key_ctx_bi.dec=
rypt.implicit_iv_len =3D impl_iv_len;</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">change 797=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b167=
1c8e8dcccdbd6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 797 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--m1pi0sIRYIc=--

