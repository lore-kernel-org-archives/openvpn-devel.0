From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 30 Apr 2024 12:54:36 +0000
In-Reply-To: <gerrit.1714407751000.I5bfa3630ad4dff2807705658bc877c4a429a39ce@...2715...>
References: <gerrit.1714407751000.I5bfa3630ad4dff2807705658bc877c4a429a39ce@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <536e79f5d35e728f76d5e558e14eaa436b5e67ac-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XY00Iy5ZI/k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove custom TLS
 1.0 PRF implementation only used by LibreSSL/wolfSSL
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

--XY00Iy5ZI/k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/560?usp=3Demail

to look at the new patch set (#3).


Change subject: Remove custom TLS 1.0 PRF implementation only used by Libre=
SSL/wolfSSL
......................................................................

Remove custom TLS 1.0 PRF implementation only used by LibreSSL/wolfSSL

After the removal of the OpenSSL 1.0.2 support, LibreSSL/wolfSSL are the
only libraries that still needs the custom implementation.

Since our LibreSSL/wolfSSL support is always best effort, we can afford to
limit LibreSSL support in this way. If they want to support this, they
should expose the functionality as well.

Change-Id: I5bfa3630ad4dff2807705658bc877c4a429a39ce
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
M tests/unit_tests/openvpn/test_crypto.c
2 files changed, 12 insertions(+), 175 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/560/3

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 64ad346..a86b1ab 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1372,7 +1372,7 @@

     return ret;
 }
-#elif !defined(LIBRESSL_VERSION_NUMBER)
+#elif !defined(LIBRESSL_VERSION_NUMBER) && !defined(ENABLE_CRYPTO_WOLFSSL)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
@@ -1419,183 +1419,14 @@
     return ret;
 }
 #else  /* if defined(LIBRESSL_VERSION_NUMBER) */
-/*
- * Generate the hash required by for the \c tls1_PRF function.
- *
- * We cannot use our normal hmac_* function as they do not work
- * in a FIPS environment (no MD5 allowed, which we need). Instead
- * we need to directly use the EVP_MD_* API with the special
- * EVP_MD_CTX_FLAG_NON_FIPS_ALLOW flag.
- *
- * The function below is adapted from OpenSSL 1.0.2t
- *
- * @param md_kt         Message digest to use
- * @param sec           Secret to base the hash on
- * @param sec_len       Length of the secret
- * @param seed          Seed to hash
- * @param seed_len      Length of the seed
- * @param out           Output buffer
- * @param olen          Length of the output buffer
- */
-static
-bool
-tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
-            int sec_len, const void *seed, int seed_len,
-            unsigned char *out, int olen)
-{
-    int chunk;
-    size_t j;
-    EVP_MD_CTX *ctx, *ctx_tmp, *ctx_init;
-    EVP_PKEY *mac_key;
-    unsigned char A1[EVP_MAX_MD_SIZE];
-    size_t A1_len =3D EVP_MAX_MD_SIZE;
-    int ret =3D false;
-
-    chunk =3D EVP_MD_size(md);
-    OPENSSL_assert(chunk >=3D 0);
-
-    ctx =3D md_ctx_new();
-    ctx_tmp =3D md_ctx_new();
-    ctx_init =3D md_ctx_new();
-    EVP_MD_CTX_set_flags(ctx_init, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);
-    mac_key =3D EVP_PKEY_new_mac_key(EVP_PKEY_HMAC, NULL, sec, sec_len);
-    if (!mac_key)
-    {
-        goto err;
-    }
-    if (!EVP_DigestSignInit(ctx_init, NULL, md, NULL, mac_key))
-    {
-        goto err;
-    }
-    if (!EVP_MD_CTX_copy_ex(ctx, ctx_init))
-    {
-        goto err;
-    }
-    if (!EVP_DigestSignUpdate(ctx, seed, seed_len))
-    {
-        goto err;
-    }
-    if (!EVP_DigestSignFinal(ctx, A1, &A1_len))
-    {
-        goto err;
-    }
-
-    for (;; )
-    {
-        /* Reinit mac contexts */
-        if (!EVP_MD_CTX_copy_ex(ctx, ctx_init))
-        {
-            goto err;
-        }
-        if (!EVP_DigestSignUpdate(ctx, A1, A1_len))
-        {
-            goto err;
-        }
-        if (olen > chunk && !EVP_MD_CTX_copy_ex(ctx_tmp, ctx))
-        {
-            goto err;
-        }
-        if (!EVP_DigestSignUpdate(ctx, seed, seed_len))
-        {
-            goto err;
-        }
-
-        if (olen > chunk)
-        {
-            j =3D olen;
-            if (!EVP_DigestSignFinal(ctx, out, &j))
-            {
-                goto err;
-            }
-            out +=3D j;
-            olen -=3D j;
-            /* calc the next A1 value */
-            if (!EVP_DigestSignFinal(ctx_tmp, A1, &A1_len))
-            {
-                goto err;
-            }
-        }
-        else
-        {
-            A1_len =3D EVP_MAX_MD_SIZE;
-            /* last one */
-            if (!EVP_DigestSignFinal(ctx, A1, &A1_len))
-            {
-                goto err;
-            }
-            memcpy(out, A1, olen);
-            break;
-        }
-    }
-    ret =3D true;
-err:
-    EVP_PKEY_free(mac_key);
-    EVP_MD_CTX_free(ctx);
-    EVP_MD_CTX_free(ctx_tmp);
-    EVP_MD_CTX_free(ctx_init);
-    OPENSSL_cleanse(A1, sizeof(A1));
-    return ret;
-}
-
-/*
- * Use the TLS PRF function for generating data channel keys.
- * This code is based on the OpenSSL library.
- *
- * TLS generates keys as such:
- *
- * master_secret[48] =3D PRF(pre_master_secret[48], "master secret",
- *                         ClientHello.random[32] + ServerHello.random[32])
- *
- * key_block[] =3D PRF(SecurityParameters.master_secret[48],
- *                 "key expansion",
- *                 SecurityParameters.server_random[32] +
- *                 SecurityParameters.client_random[32]);
- *
- * Notes:
- *
- * (1) key_block contains a full set of 4 keys.
- * (2) The pre-master secret is generated by the client.
- */
+/* LibreSSL and wolfSSL do not expose a TLS 1.0/1.1 PRF via the same APIs =
as
+ * OpenSSL does. As result they will only be able to support
+ * peers that support TLS EKM like when running with OpenSSL 3.x FIPS */
 bool
 ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec,
              int slen, uint8_t *out1, int olen)
 {
-    bool ret =3D true;
-    struct gc_arena gc =3D gc_new();
-    /* For some reason our md_get("MD5") fails otherwise in the unit test =
*/
-    const EVP_MD *md5 =3D EVP_md5();
-    const EVP_MD *sha1 =3D EVP_sha1();
-
-    uint8_t *out2 =3D (uint8_t *)gc_malloc(olen, false, &gc);
-
-    int len =3D slen/2;
-    const uint8_t *S1 =3D sec;
-    const uint8_t *S2 =3D &(sec[len]);
-    len +=3D (slen&1); /* add for odd, make longer */
-
-    if (!tls1_P_hash(md5, S1, len, label, label_len, out1, olen))
-    {
-        ret =3D false;
-        goto done;
-    }
-
-    if (!tls1_P_hash(sha1, S2, len, label, label_len, out2, olen))
-    {
-        ret =3D false;
-        goto done;
-    }
-
-    for (int i =3D 0; i < olen; i++)
-    {
-        out1[i] ^=3D out2[i];
-    }
-
-    secure_memzero(out2, olen);
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%d]: %s", olen, format_hex(out1,=
 olen, 0, &gc));
-done:
-    gc_free(&gc);
-    return ret;
+    return false;
 }
 #endif /* if LIBRESSL_VERSION_NUMBER */
 #endif /* ENABLE_CRYPTO_OPENSSL */
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 01c16c9..8dbe1d9 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -160,9 +160,15 @@


     uint8_t out[32];
-    ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out));
+    bool ret =3D ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, siz=
eof(out));

+#if defined(LIBRESSL_VERSION_NUMBER) || defined(ENABLE_CRYPTO_WOLFSSL)
+    /* No TLS1 PRF support in these libraries */
+    assert_false(ret);
+#else
+    assert_true(true);
     assert_memory_equal(good_prf, out, sizeof(out));
+#endif
 }

 static uint8_t testkey[20] =3D {0x0b, 0x00};

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/560?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5bfa3630ad4dff2807705658bc877c4a429a39ce
Gerrit-Change-Number: 560
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--XY00Iy5ZI/k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/560?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Remove custom TLS 1.0 PRF implementation only used by LibreSSL/wolfSS=
L<br><br>After the removal of the OpenSSL 1.0.2 support, LibreSSL/wolfSSL a=
re the<br>only libraries that still needs the custom implementation.<br><br=
>Since our LibreSSL/wolfSSL support is always best effort, we can afford to=
<br>limit LibreSSL support in this way. If they want to support this, they<=
br>should expose the functionality as well.<br><br>Change-Id: I5bfa3630ad4d=
ff2807705658bc877c4a429a39ce<br>Signed-off-by: Arne Schwabe &lt;arne@...2068...=
7...&gt;<br>---<br>M src/openvpn/crypto_openssl.c<br>M tests/unit_tests/ope=
nvpn/test_crypto.c<br>2 files changed, 12 insertions(+), 175 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/56=
0/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_=
openssl.c</span><br><span>index 64ad346..a86b1ab 100644</span><br><span>---=
 a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_op=
enssl.c</span><br><span>@@ -1372,7 +1372,7 @@</span><br><span> </span><br><=
span>     return ret;</span><br><span> }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#elif !defined(LIBRESSL_VERSION_NUMBER)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#elif !defined(LIBRESSL_VERSION_NUMB=
ER) &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span> bool</span>=
<br><span> ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *s=
ecret,</span><br><span>              int secret_len, uint8_t *output, int o=
utput_len)</span><br><span>@@ -1419,183 +1419,14 @@</span><br><span>     re=
turn ret;</span><br><span> }</span><br><span> #else  /* if defined(LIBRESSL=
_VERSION_NUMBER) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Generate the hash =
required by for the \c tls1_PRF function.</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * We cannot use our normal hmac_* function as they do not work</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * in a FIPS environment (no MD5=
 allowed, which we need). Instead</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * we need to directly use the EVP_MD_* API with the special</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * EVP_MD_CTX_FLAG_NON_F=
IPS_ALLOW flag.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * The function below is =
adapted from OpenSSL 1.0.2t</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param md_=
kt         Message digest to use</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param sec           Secret to base the hash on</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * @param sec_len       Length of t=
he secret</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param se=
ed          Seed to hash</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param seed_len      Length of the seed</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @param out           Output buffer</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * @param olen          Length of t=
he output buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-tls1_P_hash(const EVP_MD *md, const unsigned char *sec,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int sec_l=
en, const void *seed, int seed_len,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            unsigned char *out, int olen)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int chunk;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    size_t j;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   EVP_MD_CTX *ctx, *ctx_tmp, *ctx_init;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    EVP_PKEY *mac_key;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    unsigned char A1[EVP_MAX_MD_SIZE];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    size_t A1_len =3D EVP_MAX_MD_SIZE;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D false=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    chunk =3D EVP_MD_size(md);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    OPENSSL_assert(chunk &gt;=3D=
 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ctx =3D md_ctx_new();</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ctx_tmp =3D md_ctx_new();</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx_init =3D md_ctx_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP_MD_CTX_se=
t_flags(ctx_init, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    mac_key =3D EVP_PKEY_new_mac_key(EVP_PKEY_=
HMAC, NULL, sec, sec_len);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!mac_key)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto er=
r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!EVP_DigestSignInit(ctx_ini=
t, NULL, md, NULL, mac_key))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        g=
oto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!EVP_MD_CTX_copy_ex(c=
tx, ctx_init))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto err;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!EVP_DigestSignUpdate(ctx, seed, se=
ed_len))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        goto err;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!EVP_DigestSignFinal(ctx, A1, &amp;A1_len=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        goto err;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   for (;; )</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Reinit mac con=
texts */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!=
EVP_MD_CTX_copy_ex(ctx, ctx_init))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(!EVP_DigestSignUpdate(ctx, A1, A1_len))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            goto err;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (olen &gt; chunk &amp;&amp; !EVP_MD_CTX_copy_ex(ctx_tmp, ctx))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            goto err;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (!EVP_DigestSignUpdate(ctx, seed, seed_le=
n))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            goto err;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (olen &gt; chunk)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            j =3D olen;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            if (!EVP_DigestSignFinal(ctx, out, &amp;j))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            out +=3D j;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            olen -=3D j;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            /* calc the next A1 value =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!EV=
P_DigestSignFinal(ctx_tmp, A1, &amp;A1_len))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                goto err;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            A1_len =3D=
 EVP_MAX_MD_SIZE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* last one */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (!EVP_DigestSignFinal(ctx, A1, &amp;A1_len))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            memcpy(out, A1, olen);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ret =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-err:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP_PKE=
Y_free(mac_key);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    E=
VP_MD_CTX_free(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   EVP_MD_CTX_free(ctx_tmp);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    EVP_MD_CTX_free(ctx_init);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    OPENSSL_cleanse(A1, sizeof(A1));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * Use the TLS PRF function for ge=
nerating data channel keys.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * This code is based on the OpenSSL library.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * TLS generates keys as such:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * master_secret[48] =3D PRF(pre_master_secret[48], &quot;master secret&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             =
            ClientHello.random[32] + ServerHello.random[32])</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * key_block[] =3D PRF(SecurityParameters.master_secret=
[48],</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *              =
   &quot;key expansion&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *                 SecurityParameters.server_random[32] +</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *                 SecurityPara=
meters.client_random[32]);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Notes:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * (1) key_block contains a full set of 4 k=
eys.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (2) The pre-ma=
ster secret is generated by the client.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* LibreSSL and wolfSSL do not expose a TLS 1.0/1.1 PRF via the same APIs=
 as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OpenSSL does.=
 As result they will only be able to support</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * peers that support TLS EKM like when running wi=
th OpenSSL 3.x FIPS */</span><br><span> bool</span><br><span> ssl_tls1_PRF(=
const uint8_t *label, int label_len, const uint8_t *sec,</span><br><span>  =
            int slen, uint8_t *out1, int olen)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D true;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* For some=
 reason our md_get(&quot;MD5&quot;) fails otherwise in the unit test */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    const EVP_MD *md5 =3D=
 EVP_md5();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
EVP_MD *sha1 =3D EVP_sha1();</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *o=
ut2 =3D (uint8_t *)gc_malloc(olen, false, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int len =3D slen/2;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const uint8_t *S1 =3D sec;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const uint8_t *S2 =3D &amp;(sec[len]);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    len +=3D (slen&amp;1); /* ad=
d for odd, make longer */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tls1_P_h=
ash(md5, S1, len, label, label_len, out1, olen))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ret =3D false;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        goto done;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tls1_P_hash(sha1, S=
2, len, label, label_len, out2, olen))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        ret =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; olen; i++=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        out1[i] ^=3D out2[i];</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    secure_memzero(out2, olen);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_PRF out[%d]: %s&quot;, olen, format_=
hex(out1, olen, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-done:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return f=
alse;</span><br><span> }</span><br><span> #endif /* if LIBRESSL_VERSION_NUM=
BER */</span><br><span> #endif /* ENABLE_CRYPTO_OPENSSL */</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c</span><br><span>index 01c16c9..8dbe1d9 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -160,9 +160,15 @@</s=
pan><br><span> </span><br><span> </span><br><span>     uint8_t out[32];</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ssl_tls1_PRF(seed, se=
ed_len, secret, secret_len, out, sizeof(out));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool ret =3D ssl_tls1_PRF(seed, seed_len, se=
cret, secret_len, out, sizeof(out));</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL_VERSION_NUMBER) || =
defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* No TLS1 PRF support in these libraries */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ret);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(true);</span><br><span>     as=
sert_memory_equal(good_prf, out, sizeof(out));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </spa=
n><br><span> static uint8_t testkey[20] =3D {0x0b, 0x00};</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/560?usp=3Demail">change 560</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/560?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5bfa3630ad4dff2807705658bc8=
77c4a429a39ce </div>
<div style=3D"display:none"> Gerrit-Change-Number: 560 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--XY00Iy5ZI/k=--

