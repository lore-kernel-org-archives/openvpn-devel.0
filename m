From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Aug 2025 13:39:56 +0000
In-Reply-To: <gerrit.1754490554000.Ic88cd6e143bc48cab3c9ebb7c7007513803bd199@...2715...>
References: <gerrit.1754490554000.Ic88cd6e143bc48cab3c9ebb7c7007513803bd199@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d65a07cfa0b1571889a6e55b4a2c3b1777b3573b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fmp/PqmTQ6s="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpn_PRF: Change
 API to use size_t for lenghts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fmp/PqmTQ6s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1135?usp=3Demail

to look at the new patch set (#7).


Change subject: openvpn_PRF: Change API to use size_t for lenghts
......................................................................

openvpn_PRF: Change API to use size_t for lenghts

Basically all users already wanted that anyway. And most
of the library functions also take size_t nowadays.

Change-Id: Ic88cd6e143bc48cab3c9ebb7c7007513803bd199
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_openssl.c
M src/openvpn/ssl.c
M tests/unit_tests/openvpn/test_crypto.c
6 files changed, 25 insertions(+), 25 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1135/7

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index af7583a..f0c7939 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1903,8 +1903,8 @@
     uint8_t out[8];
     uint8_t expected_out[] =3D { 'q', 'D', '\xfe', '%', '@', 's', 'u', '\x=
95' };

-    int ret =3D ssl_tls1_PRF((uint8_t *)seed, (int)strlen(seed), (uint8_t =
*)secret,
-                           (int)strlen(secret), out, sizeof(out));
+    int ret =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)sec=
ret,
+                           strlen(secret), out, sizeof(out));

     return (ret && memcmp(out, expected_out, sizeof(out)) =3D=3D 0);
 }
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 59418f6..b74cb7f 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -716,7 +716,7 @@
  *
  * @return              true if successful, false on any error
  */
-bool ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret=
, int secret_len,
-                  uint8_t *output, int output_len);
+bool ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *sec=
ret, size_t secret_len,
+                  uint8_t *output, size_t output_len);

 #endif /* CRYPTO_BACKEND_H_ */
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 86317dd..ce6cfe8 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -983,8 +983,8 @@
  * from recent versions, so we use our own implementation if necessary. */
 #if defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_TLS1)
 bool
-ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret, int=
 secret_len,
-             uint8_t *output, int output_len)
+ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *secret, =
size_t secret_len,
+             uint8_t *output, size_t output_len)
 {
     return mbed_ok(mbedtls_ssl_tls_prf(MBEDTLS_SSL_TLS_PRF_TLS1, secret, s=
ecret_len, "", seed,
                                        seed_len, output, output_len));
@@ -1002,8 +1002,8 @@
  * @param olen          Length of the output buffer
  */
 static void
-tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, int sec_le=
n, const uint8_t *seed,
-            int seed_len, uint8_t *out, int olen)
+tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t sec=
_len, const uint8_t *seed,
+            size_t seed_len, uint8_t *out, size_t olen)
 {
     struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
@@ -1089,8 +1089,8 @@
  * (2) The pre-master secret is generated by the client.
  */
 bool
-ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec, int =
slen, uint8_t *out1,
-             int olen)
+ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, s=
ize_t slen, uint8_t *out1,
+             size_t olen)
 {
     struct gc_arena gc =3D gc_new();
     const md_kt_t *md5 =3D md_get("MD5");
@@ -1113,7 +1113,7 @@

     secure_memzero(out2, olen);

-    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%d]: %s", olen, format_hex(out1,=
 olen, 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%zu]: %s", olen, format_hex(out1=
, olen, 0, &gc));

     gc_free(&gc);
     return true;
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 2351bfd..75af4f5 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1341,8 +1341,8 @@
 }
 #if (OPENSSL_VERSION_NUMBER >=3D 0x30000000L) && !defined(LIBRESSL_VERSION=
_NUMBER)
 bool
-ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret, int=
 secret_len,
-             uint8_t *output, int output_len)
+ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *secret, =
size_t secret_len,
+             uint8_t *output, size_t output_len)
 {
     bool ret =3D true;
     EVP_KDF_CTX *kctx =3D NULL;
@@ -1368,9 +1368,9 @@
     params[0] =3D
         OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST, SN_md5_sha=
1, strlen(SN_md5_sha1));
     params[1] =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SECRET,=
 (uint8_t *)secret,
-                                                  (size_t)secret_len);
+                                                  secret_len);
     params[2] =3D
-        OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SEED, (uint8_t *)=
seed, (size_t)seed_len);
+        OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SEED, (uint8_t *)=
seed, seed_len);
     params[3] =3D OSSL_PARAM_construct_end();

     if (EVP_KDF_derive(kctx, output, output_len, params) <=3D 0)
@@ -1392,15 +1392,15 @@
 }
 #elif defined(OPENSSL_IS_AWSLC)
 bool
-ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec, int =
slen, uint8_t *out1,
-             int olen)
+ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, s=
ize_t slen, uint8_t *out1,
+             size_t olen)
 {
     CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen, label, label_le=
n, NULL, 0, NULL, 0);
 }
 #elif !defined(LIBRESSL_VERSION_NUMBER) && !defined(ENABLE_CRYPTO_WOLFSSL)
 bool
-ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret, int=
 secret_len,
-             uint8_t *output, int output_len)
+ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *secret, =
size_t secret_len,
+             uint8_t *output, size_t output_len)
 {
     EVP_PKEY_CTX *pctx =3D EVP_PKEY_CTX_new_id(EVP_PKEY_TLS1_PRF, NULL);
     if (!pctx)
@@ -1448,8 +1448,8 @@
  * OpenSSL does. As result they will only be able to support
  * peers that support TLS EKM like when running with OpenSSL 3.x FIPS */
 bool
-ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec, int =
slen, uint8_t *out1,
-             int olen)
+ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, s=
ize_t slen, uint8_t *out1,
+             size_t olen)
 {
     return false;
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 85b018b..284d951 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1294,10 +1294,10 @@
 }

 static bool
-openvpn_PRF(const uint8_t *secret, int secret_len, const char *label, cons=
t uint8_t *client_seed,
-            int client_seed_len, const uint8_t *server_seed, int server_se=
ed_len,
+openvpn_PRF(const uint8_t *secret, size_t secret_len, const char *label, c=
onst uint8_t *client_seed,
+            size_t client_seed_len, const uint8_t *server_seed, size_t ser=
ver_seed_len,
             const struct session_id *client_sid, const struct session_id *=
server_sid,
-            uint8_t *output, int output_len)
+            uint8_t *output, size_t output_len)
 {
     /* concatenate seed components */

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 12ddaba..5df1046 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -161,7 +161,7 @@


     uint8_t out[32];
-    bool ret =3D ssl_tls1_PRF(seed, (int)seed_len, secret, (int)secret_len=
, out, sizeof(out));
+    bool ret =3D ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, siz=
eof(out));

 #if defined(LIBRESSL_VERSION_NUMBER) || defined(ENABLE_CRYPTO_WOLFSSL)
     /* No TLS1 PRF support in these libraries */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1135?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic88cd6e143bc48cab3c9ebb7c7007513803bd199
Gerrit-Change-Number: 1135
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--fmp/PqmTQ6s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #7</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1135?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpn_PRF: Change API to use size_t for lenghts<br><br>Basicall=
y all users already wanted that anyway. And most<br>of the library function=
s also take size_t nowadays.<br><br>Change-Id: Ic88cd6e143bc48cab3c9ebb7c70=
07513803bd199<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>---<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto_backend.h<br>M src=
/openvpn/crypto_mbedtls.c<br>M src/openvpn/crypto_openssl.c<br>M src/openvp=
n/ssl.c<br>M tests/unit_tests/openvpn/test_crypto.c<br>6 files changed, 25 =
insertions(+), 25 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/35/1135/7</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypt=
o.c b/src/openvpn/crypto.c</span><br><span>index af7583a..f0c7939 100644</s=
pan><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/=
crypto.c</span><br><span>@@ -1903,8 +1903,8 @@</span><br><span>     uint8_t=
 out[8];</span><br><span>     uint8_t expected_out[] =3D { &#39;q&#39;, &#3=
9;D&#39;, &#39;\xfe&#39;, &#39;%&#39;, &#39;@&#39;, &#39;s&#39;, &#39;u&#39=
;, &#39;\x95&#39; };</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int ret =3D ssl_tls1_PRF((uint8_t *)seed, (int)strlen(=
seed), (uint8_t *)secret,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                           (int)strlen(secret), out, sizeof(out));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D ssl_tls1=
_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)secret,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                           strlen(secret=
), out, sizeof(out));</span><br><span> </span><br><span>     return (ret &a=
mp;&amp; memcmp(out, expected_out, sizeof(out)) =3D=3D 0);</span><br><span>=
 }</span><br><span>diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/=
crypto_backend.h</span><br><span>index 59418f6..b74cb7f 100644</span><br><s=
pan>--- a/src/openvpn/crypto_backend.h</span><br><span>+++ b/src/openvpn/cr=
ypto_backend.h</span><br><span>@@ -716,7 +716,7 @@</span><br><span>  *</spa=
n><br><span>  * @return              true if successful, false on any error=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
bool ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,=
 int secret_len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
             uint8_t *output, int output_len);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool ssl_tls1_PRF(const uint8_t *seed, size_t se=
ed_len, const uint8_t *secret, size_t secret_len,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                  uint8_t *output, size_t out=
put_len);</span><br><span> </span><br><span> #endif /* CRYPTO_BACKEND_H_ */=
</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/cr=
ypto_mbedtls.c</span><br><span>index 86317dd..ce6cfe8 100644</span><br><spa=
n>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/cryp=
to_mbedtls.c</span><br><span>@@ -983,8 +983,8 @@</span><br><span>  * from r=
ecent versions, so we use our own implementation if necessary. */</span><br=
><span> #if defined(HAVE_MBEDTLS_SSL_TLS_PRF) &amp;&amp; defined(MBEDTLS_SS=
L_TLS_PRF_TLS1)</span><br><span> bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8=
_t *secret, int secret_len,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-             uint8_t *output, int output_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const uint8_t *seed, size_t =
seed_len, const uint8_t *secret, size_t secret_len,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             uint8_t *output, size_t outp=
ut_len)</span><br><span> {</span><br><span>     return mbed_ok(mbedtls_ssl_=
tls_prf(MBEDTLS_SSL_TLS_PRF_TLS1, secret, secret_len, &quot;&quot;, seed,</=
span><br><span>                                        seed_len, output, ou=
tput_len));</span><br><span>@@ -1002,8 +1002,8 @@</span><br><span>  * @para=
m olen          Length of the output buffer</span><br><span>  */</span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls=
1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, int sec_len, c=
onst uint8_t *seed,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          int seed_len, uint8_t *out, int olen)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+tls1_P_hash(const mbedtls_md_info_t *md_kt, con=
st uint8_t *sec, size_t sec_len, const uint8_t *seed,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            size_t seed_len, uint8_t *out=
, size_t olen)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><=
br><span>@@ -1089,8 +1089,8 @@</span><br><span>  * (2) The pre-master secre=
t is generated by the client.</span><br><span>  */</span><br><span> bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-ssl_tls1_PRF(const uint8=
_t *label, int label_len, const uint8_t *sec, int slen, uint8_t *out1,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-             int olen)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const uint=
8_t *label, size_t label_len, const uint8_t *sec, size_t slen, uint8_t *out=
1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             size=
_t olen)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span>     const md_kt_t *md5 =3D md_get(&quot;MD5&quot;);=
</span><br><span>@@ -1113,7 +1113,7 @@</span><br><span> </span><br><span>  =
   secure_memzero(out2, olen);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_PRF out[%=
d]: %s&quot;, olen, format_hex(out1, olen, 0, &amp;gc));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1=
_PRF out[%zu]: %s&quot;, olen, format_hex(out1, olen, 0, &amp;gc));</span><=
br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span>     retu=
rn true;</span><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/op=
envpn/crypto_openssl.c</span><br><span>index 2351bfd..75af4f5 100644</span>=
<br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/open=
vpn/crypto_openssl.c</span><br><span>@@ -1341,8 +1341,8 @@</span><br><span>=
 }</span><br><span> #if (OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L) &amp;&=
amp; !defined(LIBRESSL_VERSION_NUMBER)</span><br><span> bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-ssl_tls1_PRF(const uint8_t *seed, in=
t seed_len, const uint8_t *secret, int secret_len,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-             uint8_t *output, int output_len)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const u=
int8_t *seed, size_t seed_len, const uint8_t *secret, size_t secret_len,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             uint8_t *=
output, size_t output_len)</span><br><span> {</span><br><span>     bool ret=
 =3D true;</span><br><span>     EVP_KDF_CTX *kctx =3D NULL;</span><br><span=
>@@ -1368,9 +1368,9 @@</span><br><span>     params[0] =3D</span><br><span> =
        OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST, SN_md5_sha1=
, strlen(SN_md5_sha1));</span><br><span>     params[1] =3D OSSL_PARAM_const=
ruct_octet_string(OSSL_KDF_PARAM_SECRET, (uint8_t *)secret,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
             (size_t)secret_len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                  secret_len)=
;</span><br><span>     params[2] =3D</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SEE=
D, (uint8_t *)seed, (size_t)seed_len);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM=
_SEED, (uint8_t *)seed, seed_len);</span><br><span>     params[3] =3D OSSL_=
PARAM_construct_end();</span><br><span> </span><br><span>     if (EVP_KDF_d=
erive(kctx, output, output_len, params) &lt;=3D 0)</span><br><span>@@ -1392=
,15 +1392,15 @@</span><br><span> }</span><br><span> #elif defined(OPENSSL_I=
S_AWSLC)</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *s=
ec, int slen, uint8_t *out1,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-             int olen)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_=
t *sec, size_t slen, uint8_t *out1,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             size_t olen)</span><br><span> {</span><br><spa=
n>     CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen, label, label_=
len, NULL, 0, NULL, 0);</span><br><span> }</span><br><span> #elif !defined(=
LIBRESSL_VERSION_NUMBER) &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><=
br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssl_tls=
1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret, int secret_=
len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             uint=
8_t *output, int output_len)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *=
secret, size_t secret_len,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             uint8_t *output, size_t output_len)</span><br><span> {<=
/span><br><span>     EVP_PKEY_CTX *pctx =3D EVP_PKEY_CTX_new_id(EVP_PKEY_TL=
S1_PRF, NULL);</span><br><span>     if (!pctx)</span><br><span>@@ -1448,8 +=
1448,8 @@</span><br><span>  * OpenSSL does. As result they will only be abl=
e to support</span><br><span>  * peers that support TLS EKM like when runni=
ng with OpenSSL 3.x FIPS */</span><br><span> bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-ssl_tls1_PRF(const uint8_t *label, int label_le=
n, const uint8_t *sec, int slen, uint8_t *out1,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-             int olen)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const uint8_t *label, size_t labe=
l_len, const uint8_t *sec, size_t slen, uint8_t *out1,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             size_t olen)</span><br><spa=
n> {</span><br><span>     return false;</span><br><span> }</span><br><span>=
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 85=
b018b..284d951 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><sp=
an>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1294,10 +1294,10 @@</span><b=
r><span> }</span><br><span> </span><br><span> static bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-openvpn_PRF(const uint8_t *secret, int =
secret_len, const char *label, const uint8_t *client_seed,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            int client_seed_len, const=
 uint8_t *server_seed, int server_seed_len,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+openvpn_PRF(const uint8_t *secret, size_t secret_le=
n, const char *label, const uint8_t *client_seed,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            size_t client_seed_len, const uin=
t8_t *server_seed, size_t server_seed_len,</span><br><span>             con=
st struct session_id *client_sid, const struct session_id *server_sid,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            uint8_t *outpu=
t, int output_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           uint8_t *output, size_t output_len)</span><br><span> {</span><br=
><span>     /* concatenate seed components */</span><br><span> </span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests=
/openvpn/test_crypto.c</span><br><span>index 12ddaba..5df1046 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -161,7 +161,7 @=
@</span><br><span> </span><br><span> </span><br><span>     uint8_t out[32];=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D ssl_=
tls1_PRF(seed, (int)seed_len, secret, (int)secret_len, out, sizeof(out));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D ssl_=
tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out));</span><br><=
span> </span><br><span> #if defined(LIBRESSL_VERSION_NUMBER) || defined(ENA=
BLE_CRYPTO_WOLFSSL)</span><br><span>     /* No TLS1 PRF support in these li=
braries */</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1135?usp=3Demail">change 1135</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1135?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic88cd6e143bc48cab3c9ebb7c70=
07513803bd199 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1135 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--fmp/PqmTQ6s=--

