From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 29 Nov 2023 12:17:19 +0000
In-Reply-To: <gerrit.1700595358000.Ic74195a4ed340547c5e862dc2438f95be318c286@...2715...>
References: <gerrit.1700595358000.Ic74195a4ed340547c5e862dc2438f95be318c286@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <cdf9251cf4767462e406b8bcbc1149ae619621d5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uRyzQHSKhmI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement generating
 TLS 1.0 PRF using new OpenSSL 3.0 APIs
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

--uRyzQHSKhmI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail

to look at the new patch set (#6).


Change subject: Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs
......................................................................

Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs

OpenSSL 3.0 introduced a new API for doing key derivation. So this leaves
us now with three different implementation for 1.0.2, 1.1.x and 3.x.

This was initially done to maybe still have a working TLS 1.0 PRF when
using OpenSSL 3.0 in FIPS butit gives the same error as with the older API
but since moving to a new API is always good, we use the new API when using
OpenSSL 3.0. We also print the internal OpenSSL error message when
the KDF fails.

This also allows us now to compile an OpenSSL build that has been built with
OPENSSL_NO_MD5. Which is not yet common but might be in the future.

Change-Id: Ic74195a4ed340547c5e862dc2438f95be318c286
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 52 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/457/6

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index fe1254f..21b6a9c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -54,6 +54,7 @@
 #endif
 #if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
 #include <openssl/provider.h>
+#include <openssl/core_names.h>
 #endif

 #if defined(_WIN32) && defined(OPENSSL_NO_EC)
@@ -1373,8 +1374,58 @@
 {
     return CRYPTO_memcmp(a, b, size);
 }
+#if (OPENSSL_VERSION_NUMBER >=3D 0x30000000L) && !defined(LIBRESSL_VERSION=
_NUMBER)
+bool
+ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
+             int secret_len, uint8_t *output, int output_len)
+{
+    bool ret =3D true;
+    EVP_KDF_CTX *kctx =3D NULL;

-#if (OPENSSL_VERSION_NUMBER >=3D 0x10100000L) && !defined(LIBRESSL_VERSION=
_NUMBER)
+
+    EVP_KDF *kdf =3D EVP_KDF_fetch(NULL, "TLS1-PRF", NULL);
+    if (!kdf)
+    {
+        goto err;
+    }
+
+    kctx =3D EVP_KDF_CTX_new(kdf);
+
+    if (!kctx)
+    {
+        goto err;
+    }
+
+    OSSL_PARAM params[4];
+
+    /* The OpenSSL APIs require us to cast the const aways even though the
+     * strings are never changed and only read */
+    params[0] =3D OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST,
+                                                 SN_md5_sha1, strlen(SN_md=
5_sha1));
+    params[1] =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SECRET,
+                                                 (uint8_t *) secret, (size=
_t) secret_len);
+    params[2] =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SEED,
+                                                  (uint8_t *) seed, (size_=
t) seed_len);
+    params[3] =3D OSSL_PARAM_construct_end();
+
+    if (EVP_KDF_derive(kctx, output, output_len, params) <=3D 0)
+    {
+        crypto_msg(D_TLS_DEBUG_LOW, "Generating TLS 1.0 PRF using "
+                   "EVP_KDF_derive failed");
+        goto err;
+    }
+
+    goto out;
+
+err:
+    ret =3D false;
+out:
+    EVP_KDF_free(kdf);
+    EVP_KDF_free(kdf);
+
+    return ret;
+}
+#elif (OPENSSL_VERSION_NUMBER >=3D 0x10100000L) && !defined(LIBRESSL_VERSI=
ON_NUMBER)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic74195a4ed340547c5e862dc2438f95be318c286
Gerrit-Change-Number: 457
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--uRyzQHSKhmI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs<br><br>Op=
enSSL 3.0 introduced a new API for doing key derivation. So this leaves<br>=
us now with three different implementation for 1.0.2, 1.1.x and 3.x.<br><br=
>This was initially done to maybe still have a working TLS 1.0 PRF when<br>=
using OpenSSL 3.0 in FIPS butit gives the same error as with the older API<=
br>but since moving to a new API is always good, we use the new API when us=
ing<br>OpenSSL 3.0. We also print the internal OpenSSL error message when<b=
r>the KDF fails.<br><br>This also allows us now to compile an OpenSSL build=
 that has been built with<br>OPENSSL_NO_MD5. Which is not yet common but mi=
ght be in the future.<br><br>Change-Id: Ic74195a4ed340547c5e862dc2438f95be3=
18c286<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M s=
rc/openvpn/crypto_openssl.c<br>1 file changed, 52 insertions(+), 1 deletion=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
57/457/6</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/cr=
ypto_openssl.c</span><br><span>index fe1254f..21b6a9c 100644</span><br><spa=
n>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/cryp=
to_openssl.c</span><br><span>@@ -54,6 +54,7 @@</span><br><span> #endif</spa=
n><br><span> #if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span=
> #include &lt;openssl/provider.h&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;openssl/core_names.h&gt;</span><br><span> #e=
ndif</span><br><span> </span><br><span> #if defined(_WIN32) &amp;&amp; defi=
ned(OPENSSL_NO_EC)</span><br><span>@@ -1373,8 +1374,58 @@</span><br><span> =
{</span><br><span>     return CRYPTO_memcmp(a, b, size);</span><br><span> }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if (OPENSSL_VERSIO=
N_NUMBER &gt;=3D 0x30000000L) &amp;&amp; !defined(LIBRESSL_VERSION_NUMBER)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const uint8_t *seed, i=
nt seed_len, const uint8_t *secret,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             int secret_len, uint8_t *output, int output_le=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    EVP_KDF_CTX *kctx =3D NULL;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
(OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L) &amp;&amp; !defined(LIBRESSL_V=
ERSION_NUMBER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_KDF *kdf =3D EVP=
_KDF_fetch(NULL, &quot;TLS1-PRF&quot;, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!kdf)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    kctx =3D EVP_KDF_CTX_new(=
kdf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!kctx)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_PAR=
AM params[4];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The OpenSSL APIs r=
equire us to cast the const aways even though the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * strings are never changed and only rea=
d */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    params[0] =
=3D OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
              SN_md5_sha1, strlen(SN_md5_sha1));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    params[1] =3D OSSL_PARAM_construct_octet_s=
tring(OSSL_KDF_PARAM_SECRET,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                                 (uint8_t *) secre=
t, (size_t) secret_len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    params[2] =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SEE=
D,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                                 (uint8_t *) seed, (size_t) seed_len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    params[3] =3D OSSL_P=
ARAM_construct_end();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (EVP_KDF_d=
erive(kctx, output, output_len, params) &lt;=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        crypto_msg(D_TLS_DEBUG_LOW, &quot;Generating TLS 1=
.0 PRF using &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                   &quot;EVP_KDF_derive failed&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ret =3D false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    EVP_KDF_free(kdf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    EVP_KDF_free(kdf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif (OPENSSL_=
VERSION_NUMBER &gt;=3D 0x10100000L) &amp;&amp; !defined(LIBRESSL_VERSION_NU=
MBER)</span><br><span> bool</span><br><span> ssl_tls1_PRF(const uint8_t *se=
ed, int seed_len, const uint8_t *secret,</span><br><span>              int =
secret_len, uint8_t *output, int output_len)</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/457?u=
sp=3Demail">change 457</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic74195a4ed340547c5e862dc243=
8f95be318c286 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 457 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--uRyzQHSKhmI=--

