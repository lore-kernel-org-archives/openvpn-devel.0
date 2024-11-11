From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 01:59:44 +0000
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5719683e0d368a4edae012ee66a335b2d08f57aa-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kovvXCNnfEM="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kovvXCNnfEM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail

to review the following change.


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
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/ssl.c
M tests/unit_tests/openvpn/test_ssl.c
7 files changed, 37 insertions(+), 23 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/797/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d136663..a366474 100644
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
+        /* Remainder of IV consists of implicit part (unique per session)
+         * XOR of packet and implicit IV */
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
=20
         memcpy(iv, BPTR(buf), packet_iv_len);
-        memcpy(iv + packet_iv_len, ctx->implicit_iv, ctx->implicit_iv_len);
+
+        /* Remainder of IV consists of implicit part (unique per session)
+         * XOR of packet counter and implicit IV */
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
index 7b0f713..0ae86f4 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -163,9 +163,14 @@
 {
     cipher_ctx_t *cipher;       /**< Generic cipher %context. */
     hmac_ctx_t *hmac;           /**< Generic HMAC %context. */
+    /**
+     * This implicit IV will be always XORed with the packet id that is se=
nt on
+     * the wire to get the IV.  For the older AEAD format the first 32 bits
+     * of implicit_iv are always 0 so this works as concatenation: after x=
or
+     * the lower 32 bit of the IV are the packet id and the rest of the IV=
 is
+     * from the implicit IV.
+     */
     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
-    /**< The implicit part of the IV */
-    size_t implicit_iv_len;     /**< The length of implicit_iv */
     /** Counter for the number of plaintext encrypted using this cipher
      * in number of 128 bit blocks (only used for AEAD ciphers) */
     uint64_t plaintext_blocks;
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index f4c3b02..bdde16f 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -395,7 +395,9 @@
         key_len =3D cipher_kt_key_size(ciphername);

         nvlist_add_binary(nvl, "key", key, key_len);
-        nvlist_add_binary(nvl, "iv", implicit_iv, 8);
+        /* FreeBSD uses the contact operation, need to skip the first 4 nu=
ll
+         * bytes */
+        nvlist_add_binary(nvl, "iv", implicit_iv + 4, 8);
     }

     return (nvl);
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b038382..c3e2ecc 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -585,8 +585,9 @@
     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
     {
         NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, encrypt_key=
);
+        /* First 4 zero bytes as the kernel does concat instead of XOR */
         NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
-                encrypt_iv);
+                encrypt_iv + 4);
     }
     nla_nest_end(nl_msg, key_enc);
=20
@@ -595,8 +596,9 @@
     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
     {
         NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, decrypt_key=
);
+        /* First 4 zero bytes as the kernel does concat instead of XOR */
         NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
-                decrypt_iv);
+                decrypt_iv + 4);
     }
     nla_nest_end(nl_msg, key_dec);

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 9224bca..8f07ead 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -314,10 +314,12 @@

     CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
     crypto_data.Encrypt.KeyLen =3D (char)key_len;
+    /* First 4 zero bytes as ovpn-dco-win does concat instead of XOR */
     CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);

     CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
     crypto_data.Decrypt.KeyLen =3D (char)key_len;
+    /* First 4 zero bytes as ovpn-dco-win does concat instead of XOR */
     CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);

     ASSERT(crypto_data.CipherAlg > 0);
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--kovvXCNnfEM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Use XOR instead of concatenation for calculation of  IV from =
implicit IV<br><br>This change prepares the extended packet id data where a=
lso the packet id<br>part of the IV will be derived using xor.  Using xor a=
lso in the AEAD<br>case where this degenerates to a concatenation allows us=
ing the same<br>IV generation code later.<br><br>Change-Id: I74216d776d3e0a=
8dc987ec7b1671c8e8dcccdbd6<br>Signed-off-by: Arne Schwabe &lt;arne@...2639...=
..&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/=
openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win=
.c<br>M src/openvpn/ssl.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>7 fil=
es changed, 37 insertions(+), 23 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/97/797/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index d136663..a36=
6474 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ =
b/src/openvpn/crypto.c</span><br><span>@@ -95,12 +95,16 @@</span><br><span>=
             goto err;</span><br><span>         }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Remainder of IV co=
nsists of implicit part (unique per session) */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        ASSERT(buf_write(&amp;iv_buffer, ctx-&gt;=
implicit_iv, ctx-&gt;implicit_iv_len));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ASSERT(iv_buffer.len =3D=3D iv_len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* Write packet id part =
of IV to work buffer */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ASSERT(buf_write(&amp;work, iv, packet_id_size(false)));</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 Write explicit part of IV to work buffer */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        ASSERT(buf_write(&amp;work, iv, iv_len - ctx=
-&gt;implicit_iv_len));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* Remainder of IV consists of implicit part (unique per sessio=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * XOR of=
 packet and implicit IV */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        for (int i =3D 0; i &lt; iv_len; i++)</span><br><span style=
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
tyle=3D"color: hsl(120, 100%, 40%);">+        /* Remainder of IV consists o=
f implicit part (unique per session)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * XOR of packet counter and implicit IV */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; =
i &lt; iv_len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  iv[i] =3D iv[i] ^ ctx-&gt;implicit_iv[i];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><span>       =
  dmsg(D_PACKET_CONTENT, &quot;DECRYPT IV: %s&quot;, format_hex(iv, iv_len,=
 0, &amp;gc));</span><br><span> </span><br><span>@@ -963,7 +972,6 @@</span>=
<br><span>         hmac_ctx_free(ctx-&gt;hmac);</span><br><span>         ct=
x-&gt;hmac =3D NULL;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ctx-&gt;implicit_iv_len =3D 0;</span><br><span> }=
</span><br><span> </span><br><span> void</span><br><span>@@ -1079,18 +1087,=
15 @@</span><br><span>         cipher_ctx_t *cipher =3D co-&gt;key_ctx_bi.e=
ncrypt.cipher;</span><br><span>         if (cipher_ctx_mode_aead(cipher))</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - sizeo=
f(packet_id_type);</span><br><span>             ASSERT(cipher_ctx_iv_length=
(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>             ASSER=
T(cipher_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br>=
<span> </span><br><span>             /* Generate dummy implicit IV */</span=
><br><span>             ASSERT(rand_bytes(co-&gt;key_ctx_bi.encrypt.implici=
t_iv,</span><br><span>                               OPENVPN_MAX_IV_LENGTH)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            co-&gt;=
key_ctx_bi.encrypt.implicit_iv_len =3D impl_iv_len;</span><br><span> </span=
><br><span>             memcpy(co-&gt;key_ctx_bi.decrypt.implicit_iv,</span=
><br><span>                    co-&gt;key_ctx_bi.encrypt.implicit_iv, OPENV=
PN_MAX_IV_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         co-&gt;key_ctx_bi.decrypt.implicit_iv_len =3D impl_iv_len;</span><=
br><span>         }</span><br><span>     }</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>=
index 7b0f713..0ae86f4 100644</span><br><span>--- a/src/openvpn/crypto.h</s=
pan><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -163,9 +163,14 =
@@</span><br><span> {</span><br><span>     cipher_ctx_t *cipher;       /**&=
lt; Generic cipher %context. */</span><br><span>     hmac_ctx_t *hmac;     =
      /**&lt; Generic HMAC %context. */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * This implicit IV will be always XORed with the packet id tha=
t is sent on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
the wire to get the IV.  For the older AEAD format the first 32 bits</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * of implicit_iv are =
always 0 so this works as concatenation: after xor</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * the lower 32 bit of the IV are the pa=
cket id and the rest of the IV is</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * from the implicit IV.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span>     uint8_t implicit_iv[OPE=
NVPN_MAX_IV_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /**&lt; The implicit part of the IV */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    size_t implicit_iv_len;     /**&lt; The length of i=
mplicit_iv */</span><br><span>     /** Counter for the number of plaintext =
encrypted using this cipher</span><br><span>      * in number of 128 bit bl=
ocks (only used for AEAD ciphers) */</span><br><span>     uint64_t plaintex=
t_blocks;</span><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/open=
vpn/dco_freebsd.c</span><br><span>index f4c3b02..bdde16f 100644</span><br><=
span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_=
freebsd.c</span><br><span>@@ -395,7 +395,9 @@</span><br><span>         key_=
len =3D cipher_kt_key_size(ciphername);</span><br><span> </span><br><span> =
        nvlist_add_binary(nvl, &quot;key&quot;, key, key_len);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        nvlist_add_binary(nvl, &qu=
ot;iv&quot;, implicit_iv, 8);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* FreeBSD uses the contact operation, need to skip the f=
irst 4 null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * bytes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
nvlist_add_binary(nvl, &quot;iv&quot;, implicit_iv + 4, 8);</span><br><span=
>     }</span><br><span> </span><br><span>     return (nvl);</span><br><spa=
n>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br>=
<span>index b038382..c3e2ecc 100644</span><br><span>--- a/src/openvpn/dco_l=
inux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -58=
5,8 +585,9 @@</span><br><span>     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE=
)</span><br><span>     {</span><br><span>         NLA_PUT(nl_msg, OVPN_KEY_=
DIR_ATTR_CIPHER_KEY, key_len, encrypt_key);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* First 4 zero bytes as the kernel does co=
ncat instead of XOR */</span><br><span>         NLA_PUT(nl_msg, OVPN_KEY_DI=
R_ATTR_NONCE_TAIL, nonce_tail_len,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                encrypt_iv);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                encrypt_iv + 4);</span><br><span>    =
 }</span><br><span>     nla_nest_end(nl_msg, key_enc);</span><br><span> </s=
pan><br><span>@@ -595,8 +596,9 @@</span><br><span>     if (dco_cipher !=3D =
OVPN_CIPHER_ALG_NONE)</span><br><span>     {</span><br><span>         NLA_P=
UT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, decrypt_key);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* First 4 zero bytes a=
s the kernel does concat instead of XOR */</span><br><span>         NLA_PUT=
(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                decrypt_iv);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                decrypt_iv + 4);<=
/span><br><span>     }</span><br><span>     nla_nest_end(nl_msg, key_dec);<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/dco_win.c b/src/=
openvpn/dco_win.c</span><br><span>index 9224bca..8f07ead 100644</span><br><=
span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.=
c</span><br><span>@@ -314,10 +314,12 @@</span><br><span> </span><br><span> =
    CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);</span><br><s=
pan>     crypto_data.Encrypt.KeyLen =3D (char)key_len;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* First 4 zero bytes as ovpn-dco-wi=
n does concat instead of XOR */</span><br><span>     CopyMemory(crypto_data=
.Encrypt.NonceTail, encrypt_iv, nonce_len);</span><br><span> </span><br><sp=
an>     CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);</span><b=
r><span>     crypto_data.Decrypt.KeyLen =3D (char)key_len;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* First 4 zero bytes as ovpn-dc=
o-win does concat instead of XOR */</span><br><span>     CopyMemory(crypto_=
data.Decrypt.NonceTail, decrypt_iv, nonce_len);</span><br><span> </span><br=
><span>     ASSERT(crypto_data.CipherAlg &gt; 0);</span><br><span>diff --gi=
t a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index a8cc83b..2d=
6cf64 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/=
src/openvpn/ssl.c</span><br><span>@@ -1562,8 +1562,9 @@</span><br><span>   =
      impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - sizeof(packet_=
id_type);</span><br><span>         ASSERT(impl_iv_len &lt;=3D OPENVPN_MAX_I=
V_LENGTH);</span><br><span>         ASSERT(impl_iv_len &lt;=3D key_len);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy(ctx-&gt;i=
mplicit_iv, key, impl_iv_len);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        ctx-&gt;implicit_iv_len =3D impl_iv_len;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        CLEAR(ctx-&gt;implicit_iv);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The first =
bytes of the IV are filled with the packet id */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        memcpy(ctx-&gt;implicit_iv + sizeof(pa=
cket_id_type), key, impl_iv_len);</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>index a1ca34=
4..ae33cc6 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c=
</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>=
@@ -284,18 +284,15 @@</span><br><span> </span><br><span>     if (cipher_ctx=
_mode_aead(cipher))</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        size_t impl_iv_len =3D cipher_ctx_iv_length(ci=
pher) - sizeof(packet_id_type);</span><br><span>         ASSERT(cipher_ctx_=
iv_length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>         =
ASSERT(cipher_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span=
><br><span> </span><br><span>         /* Generate dummy implicit IV */</spa=
n><br><span>         ASSERT(rand_bytes(co-&gt;key_ctx_bi.encrypt.implicit_i=
v,</span><br><span>                           OPENVPN_MAX_IV_LENGTH));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        co-&gt;key_ctx_bi.=
encrypt.implicit_iv_len =3D impl_iv_len;</span><br><span> </span><br><span>=
         memcpy(co-&gt;key_ctx_bi.decrypt.implicit_iv,</span><br><span>    =
            co-&gt;key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co-&gt;key_ctx=
_bi.decrypt.implicit_iv_len =3D impl_iv_len;</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">cha=
nge 797</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b167=
1c8e8dcccdbd6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 797 </div>
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


--kovvXCNnfEM=--

