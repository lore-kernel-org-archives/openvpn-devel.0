From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 21 Nov 2023 19:36:00 +0000
References: <gerrit.1700595358000.Ic74195a4ed340547c5e862dc2438f95be318c286@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <61eeb6676f4c720e1ae1b76b62e2089ce9d691c6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qRt/xUaRXjE="; charset=UTF-8
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

--qRt/xUaRXjE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail

to review the following change.


Change subject: Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs
......................................................................

Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs

OpenSSL 3.0 introduced a new API for doing key derivation. So this leaves
use now with three different implementation for 1.0.2, 1.1.x and 3.x.

This was initially done to maybe still have a working TLS 1.0 PRF when
using OpenSSL 3.0, it gives the same error as with the older API but
since moving to a new API is always good, we use the new API when using
OpenSSL 3.0. We also print the internal OpenSSL error message when
the KDF fails.

Change-Id: Ic74195a4ed340547c5e862dc2438f95be318c286
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 50 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/457/1

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index fe1254f..7351a5f 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -54,6 +54,7 @@
 #endif
 #if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
 #include <openssl/provider.h>
+#include <openssl/core_names.h>
 #endif

 #if defined(_WIN32) && defined(OPENSSL_NO_EC)
@@ -1373,8 +1374,56 @@
 {
     return CRYPTO_memcmp(a, b, size);
 }
+#if (OPENSSL_VERSION_NUMBER >=3D 0x3000000L) && !defined(LIBRESSL_VERSION_=
NUMBER)
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
+    params[0] =3D OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST,
+                                                 SN_md5_sha1, strlen(SN_md=
5_sha1));
+    params[1] =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SECRET,
+                                                  secret, (size_t) secret_=
len);
+    params[2] =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SEED,
+                                                  seed, (size_t) seed_len);
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--qRt/xUaRXjE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs<b=
r><br>OpenSSL 3.0 introduced a new API for doing key derivation. So this le=
aves<br>use now with three different implementation for 1.0.2, 1.1.x and 3.=
x.<br><br>This was initially done to maybe still have a working TLS 1.0 PRF=
 when<br>using OpenSSL 3.0, it gives the same error as with the older API b=
ut<br>since moving to a new API is always good, we use the new API when usi=
ng<br>OpenSSL 3.0. We also print the internal OpenSSL error message when<br=
>the KDF fails.<br><br>Change-Id: Ic74195a4ed340547c5e862dc2438f95be318c286=
<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/ope=
nvpn/crypto_openssl.c<br>1 file changed, 50 insertions(+), 1 deletion(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/457=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_o=
penssl.c</span><br><span>index fe1254f..7351a5f 100644</span><br><span>--- =
a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_ope=
nssl.c</span><br><span>@@ -54,6 +54,7 @@</span><br><span> #endif</span><br>=
<span> #if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span> #inc=
lude &lt;openssl/provider.h&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &lt;openssl/core_names.h&gt;</span><br><span> #endif</=
span><br><span> </span><br><span> #if defined(_WIN32) &amp;&amp; defined(OP=
ENSSL_NO_EC)</span><br><span>@@ -1373,8 +1374,56 @@</span><br><span> {</spa=
n><br><span>     return CRYPTO_memcmp(a, b, size);</span><br><span> }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if (OPENSSL_VERSION_NUMB=
ER &gt;=3D 0x3000000L) &amp;&amp; !defined(LIBRESSL_VERSION_NUMBER)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const uint8_t *seed, int see=
d_len, const uint8_t *secret,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             int secret_len, uint8_t *output, int output_len)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    EVP_KDF_CTX *kctx =3D NULL;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if (OPENS=
SL_VERSION_NUMBER &gt;=3D 0x10100000L) &amp;&amp; !defined(LIBRESSL_VERSION=
_NUMBER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    EVP_KDF *kdf =3D EVP_KDF_f=
etch(NULL, &quot;TLS1-PRF&quot;, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!kdf)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    kctx =3D EVP_KDF_CTX_new(kdf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!kctx)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_PARAM par=
ams[4];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    params[0] =3D OSSL_PARAM_co=
nstruct_utf8_string(OSSL_KDF_PARAM_DIGEST,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                                 SN_=
md5_sha1, strlen(SN_md5_sha1));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    params[1] =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PA=
RAM_SECRET,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                          secret, (size_t) secret_len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    params[2] =3D OSSL_=
PARAM_construct_octet_string(OSSL_KDF_PARAM_SEED,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                             =
     seed, (size_t) seed_len);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    params[3] =3D OSSL_PARAM_construct_end();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (EVP_KDF_derive(kctx, output, output_len, params) =
&lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(D_TL=
S_DEBUG_LOW, &quot;Generating TLS 1.0 PRF using &quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   &quot;EVP_KDF_derive =
failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    goto out;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
et =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_KDF_free(kdf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_KDF_free(k=
df);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#elif (OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L) &amp;=
&amp; !defined(LIBRESSL_VERSION_NUMBER)</span><br><span> bool</span><br><sp=
an> ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,<=
/span><br><span>              int secret_len, uint8_t *output, int output_l=
en)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/457?usp=3Demail">change 457</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/457?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic74195a4ed340547c5e862dc243=
8f95be318c286 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 457 </div>
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


--qRt/xUaRXjE=--

