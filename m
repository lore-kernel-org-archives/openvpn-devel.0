From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 12 Sep 2025 15:04:55 +0000
In-Reply-To: <gerrit.1754490554000.Ic88cd6e143bc48cab3c9ebb7c7007513803bd199@...2715...>
References: <gerrit.1754490554000.Ic88cd6e143bc48cab3c9ebb7c7007513803bd199@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <19227e59b5a4206d8e9f88fe811aeedca8f0cfbe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SRp+ZgOhyRk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpn_PRF: Change
 API to use size_t for lengths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SRp+ZgOhyRk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
35?usp=3Demail )

Change subject: openvpn_PRF: Change API to use size_t for lengths
......................................................................

openvpn_PRF: Change API to use size_t for lengths

Basically all users already wanted that anyway. And most
of the library functions also take size_t nowadays.

Change-Id: Ic88cd6e143bc48cab3c9ebb7c7007513803bd199
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250911201719.25773-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59232185/
URL: https://gerrit.openvpn.net/c/openvpn/+/1135
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_openssl.c
M src/openvpn/ssl.c
M tests/unit_tests/openvpn/test_crypto.c
6 files changed, 29 insertions(+), 29 deletions(-)




diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a63e543..4c0f684 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1903,8 +1903,8 @@
     uint8_t out[8];
     uint8_t expected_out[] =3D { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 =
};

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
index 86317dd..2423435 100644
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
@@ -1011,7 +1011,7 @@
 #ifdef ENABLE_DEBUG
     /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid u=
nused
      * variables warnings if compiled with --enable-small */
-    const int olen_orig =3D olen;
+    const size_t olen_orig =3D olen;
     const uint8_t *out_orig =3D out;
 #endif

@@ -1021,7 +1021,7 @@
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len=
, 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_=
len, 0, &gc));

-    int chunk =3D mbedtls_md_get_size(md_kt);
+    unsigned int chunk =3D mbedtls_md_get_size(md_kt);
     unsigned int A1_len =3D mbedtls_md_get_size(md_kt);

     /* This is the only place where we init an HMAC with a key that is not
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
@@ -1098,7 +1098,7 @@

     uint8_t *out2 =3D (uint8_t *)gc_malloc(olen, false, &gc);

-    int len =3D slen / 2;
+    size_t len =3D slen / 2;
     const uint8_t *S1 =3D sec;
     const uint8_t *S2 =3D &(sec[len]);
     len +=3D (slen & 1); /* add for odd, make longer */
@@ -1106,14 +1106,14 @@
     tls1_P_hash(md5, S1, len, label, label_len, out1, olen);
     tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);

-    for (int i =3D 0; i < olen; i++)
+    for (size_t i =3D 0; i < olen; i++)
     {
         out1[i] ^=3D out2[i];
     }

     secure_memzero(out2, olen);

-    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%d]: %s", olen, format_hex(out1,=
 olen, 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%zu]: %s", olen, format_hex(out1=
, olen, 0, &gc));

     gc_free(&gc);
     return true;
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 4fb6393..98fe37f 100644
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
index b7db1e7..c17e608 100644
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
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--SRp+ZgOhyRk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1135?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">openvpn_PRF: Change API to use size_t for len=
gths<br><br>Basically all users already wanted that anyway. And most<br>of =
the library functions also take size_t nowadays.<br><br>Change-Id: Ic88cd6e=
143bc48cab3c9ebb7c7007513803bd199<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>Acked-by: MaxF &lt;max@...2606...&gt;<br>Message-Id:=
 &lt;20250911201719.25773-1-gert@...1296...&gt;<br>URL: https://sourceforge=
.net/p/openvpn/mailman/message/59232185/<br>URL: https://gerrit.openvpn.net=
/c/openvpn/+/1135<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto_backend.h<br>M src/o=
penvpn/crypto_mbedtls.c<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/=
ssl.c<br>M tests/unit_tests/openvpn/test_crypto.c<br>6 files changed, 29 in=
sertions(+), 29 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span=
>index a63e543..4c0f684 100644</span><br><span>--- a/src/openvpn/crypto.c</=
span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -1903,8 +1903,=
8 @@</span><br><span>     uint8_t out[8];</span><br><span>     uint8_t expe=
cted_out[] =3D { &#39;q&#39;, &#39;D&#39;, 0xfe, &#39;%&#39;, &#39;@&#39;, =
&#39;s&#39;, &#39;u&#39;, 0x95 };</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ret =3D ssl_tls1_PRF((uint8_t *)see=
d, (int)strlen(seed), (uint8_t *)secret,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                           (int)strlen(secret), out, siz=
eof(out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int r=
et =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)secret,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  strlen(secret), out, sizeof(out));</span><br><span> </span><br><span>    =
 return (ret &amp;&amp; memcmp(out, expected_out, sizeof(out)) =3D=3D 0);</=
span><br><span> }</span><br><span>diff --git a/src/openvpn/crypto_backend.h=
 b/src/openvpn/crypto_backend.h</span><br><span>index 59418f6..b74cb7f 1006=
44</span><br><span>--- a/src/openvpn/crypto_backend.h</span><br><span>+++ b=
/src/openvpn/crypto_backend.h</span><br><span>@@ -716,7 +716,7 @@</span><br=
><span>  *</span><br><span>  * @return              true if successful, fal=
se on any error</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-bool ssl_tls1_PRF(const uint8_t *seed, int seed_len, const u=
int8_t *secret, int secret_len,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                  uint8_t *output, int output_len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool ssl_tls1_PRF(const uint8_t *=
seed, size_t seed_len, const uint8_t *secret, size_t secret_len,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                  uint8_t *out=
put, size_t output_len);</span><br><span> </span><br><span> #endif /* CRYPT=
O_BACKEND_H_ */</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.c b=
/src/openvpn/crypto_mbedtls.c</span><br><span>index 86317dd..2423435 100644=
</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b/s=
rc/openvpn/crypto_mbedtls.c</span><br><span>@@ -983,8 +983,8 @@</span><br><=
span>  * from recent versions, so we use our own implementation if necessar=
y. */</span><br><span> #if defined(HAVE_MBEDTLS_SSL_TLS_PRF) &amp;&amp; def=
ined(MBEDTLS_SSL_TLS_PRF_TLS1)</span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ssl_tls1_PRF(const uint8_t *seed, int seed_=
len, const uint8_t *secret, int secret_len,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-             uint8_t *output, int output_len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const uint8_t =
*seed, size_t seed_len, const uint8_t *secret, size_t secret_len,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+             uint8_t *output,=
 size_t output_len)</span><br><span> {</span><br><span>     return mbed_ok(=
mbedtls_ssl_tls_prf(MBEDTLS_SSL_TLS_PRF_TLS1, secret, secret_len, &quot;&qu=
ot;, seed,</span><br><span>                                        seed_len=
, output, output_len));</span><br><span>@@ -1002,8 +1002,8 @@</span><br><sp=
an>  * @param olen          Length of the output buffer</span><br><span>  *=
/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, in=
t sec_len, const uint8_t *seed,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            int seed_len, uint8_t *out, int olen)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+tls1_P_hash(const mbedtls_md_info_t=
 *md_kt, const uint8_t *sec, size_t sec_len, const uint8_t *seed,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            size_t seed_len, =
uint8_t *out, size_t olen)</span><br><span> {</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_LENGT=
H];</span><br><span>@@ -1011,7 +1011,7 @@</span><br><span> #ifdef ENABLE_DE=
BUG</span><br><span>     /* used by the D_SHOW_KEY_SOURCE, guarded with ENA=
BLE_DEBUG to avoid unused</span><br><span>      * variables warnings if com=
piled with --enable-small */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const int olen_orig =3D olen;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const size_t olen_orig =3D olen;</span><br><span> =
    const uint8_t *out_orig =3D out;</span><br><span> #endif</span><br><spa=
n> </span><br><span>@@ -1021,7 +1021,7 @@</span><br><span>     dmsg(D_SHOW_=
KEY_SOURCE, &quot;tls1_P_hash sec: %s&quot;, format_hex(sec, sec_len, 0, &a=
mp;gc));</span><br><span>     dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_P_hash see=
d: %s&quot;, format_hex(seed, seed_len, 0, &amp;gc));</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    int chunk =3D mbedtls=
_md_get_size(md_kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    unsigned int chunk =3D mbedtls_md_get_size(md_kt);</span><br><span>   =
  unsigned int A1_len =3D mbedtls_md_get_size(md_kt);</span><br><span> </sp=
an><br><span>     /* This is the only place where we init an HMAC with a ke=
y that is not</span><br><span>@@ -1089,8 +1089,8 @@</span><br><span>  * (2)=
 The pre-master secret is generated by the client.</span><br><span>  */</sp=
an><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssl=
_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec, int slen=
, uint8_t *out1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
        int olen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ss=
l_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, size=
_t slen, uint8_t *out1,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+             size_t olen)</span><br><span> {</span><br><span>     struc=
t gc_arena gc =3D gc_new();</span><br><span>     const md_kt_t *md5 =3D md_=
get(&quot;MD5&quot;);</span><br><span>@@ -1098,7 +1098,7 @@</span><br><span=
> </span><br><span>     uint8_t *out2 =3D (uint8_t *)gc_malloc(olen, false,=
 &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int len =3D slen / 2;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size_t len =3D slen / 2;</span><br><span>     const uint8_=
t *S1 =3D sec;</span><br><span>     const uint8_t *S2 =3D &amp;(sec[len]);<=
/span><br><span>     len +=3D (slen &amp; 1); /* add for odd, make longer *=
/</span><br><span>@@ -1106,14 +1106,14 @@</span><br><span>     tls1_P_hash(=
md5, S1, len, label, label_len, out1, olen);</span><br><span>     tls1_P_ha=
sh(sha1, S2, len, label, label_len, out2, olen);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; o=
len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (s=
ize_t i =3D 0; i &lt; olen; i++)</span><br><span>     {</span><br><span>   =
      out1[i] ^=3D out2[i];</span><br><span>     }</span><br><span> </span>=
<br><span>     secure_memzero(out2, olen);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_KEY_SOURCE, &quot;tl=
s1_PRF out[%d]: %s&quot;, olen, format_hex(out1, olen, 0, &amp;gc));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE=
, &quot;tls1_PRF out[%zu]: %s&quot;, olen, format_hex(out1, olen, 0, &amp;g=
c));</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><sp=
an>     return true;</span><br><span>diff --git a/src/openvpn/crypto_openss=
l.c b/src/openvpn/crypto_openssl.c</span><br><span>index 4fb6393..98fe37f 1=
00644</span><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>++=
+ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -1341,8 +1341,8 @@</spa=
n><br><span> }</span><br><span> #if (OPENSSL_VERSION_NUMBER &gt;=3D 0x30000=
000L) &amp;&amp; !defined(LIBRESSL_VERSION_NUMBER)</span><br><span> bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-ssl_tls1_PRF(const uint8=
_t *seed, int seed_len, const uint8_t *secret, int secret_len,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-             uint8_t *output, int =
output_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_tls1=
_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *secret, size_t se=
cret_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
   uint8_t *output, size_t output_len)</span><br><span> {</span><br><span> =
    bool ret =3D true;</span><br><span>     EVP_KDF_CTX *kctx =3D NULL;</sp=
an><br><span>@@ -1368,9 +1368,9 @@</span><br><span>     params[0] =3D</span=
><br><span>         OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST,=
 SN_md5_sha1, strlen(SN_md5_sha1));</span><br><span>     params[1] =3D OSSL=
_PARAM_construct_octet_string(OSSL_KDF_PARAM_SECRET, (uint8_t *)secret,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                         (size_t)secret_len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                                 =
 secret_len);</span><br><span>     params[2] =3D</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        OSSL_PARAM_construct_octet_string(OSSL_K=
DF_PARAM_SEED, (uint8_t *)seed, (size_t)seed_len);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        OSSL_PARAM_construct_octet_string(OS=
SL_KDF_PARAM_SEED, (uint8_t *)seed, seed_len);</span><br><span>     params[=
3] =3D OSSL_PARAM_construct_end();</span><br><span> </span><br><span>     i=
f (EVP_KDF_derive(kctx, output, output_len, params) &lt;=3D 0)</span><br><s=
pan>@@ -1392,15 +1392,15 @@</span><br><span> }</span><br><span> #elif defin=
ed(OPENSSL_IS_AWSLC)</span><br><span> bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ssl_tls1_PRF(const uint8_t *label, int label_len, cons=
t uint8_t *sec, int slen, uint8_t *out1,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-             int olen)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ssl_tls1_PRF(const uint8_t *label, size_t label_len, =
const uint8_t *sec, size_t slen, uint8_t *out1,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             size_t olen)</span><br><span> {</s=
pan><br><span>     CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen, l=
abel, label_len, NULL, 0, NULL, 0);</span><br><span> }</span><br><span> #el=
if !defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; !defined(ENABLE_CRYPTO_WOLF=
SSL)</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,=
 int secret_len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
        uint8_t *output, int output_len)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, con=
st uint8_t *secret, size_t secret_len,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             uint8_t *output, size_t output_len)</span><=
br><span> {</span><br><span>     EVP_PKEY_CTX *pctx =3D EVP_PKEY_CTX_new_id=
(EVP_PKEY_TLS1_PRF, NULL);</span><br><span>     if (!pctx)</span><br><span>=
@@ -1448,8 +1448,8 @@</span><br><span>  * OpenSSL does. As result they will=
 only be able to support</span><br><span>  * peers that support TLS EKM lik=
e when running with OpenSSL 3.x FIPS */</span><br><span> bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-ssl_tls1_PRF(const uint8_t *label, =
int label_len, const uint8_t *sec, int slen, uint8_t *out1,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             int olen)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const uint8_t *label,=
 size_t label_len, const uint8_t *sec, size_t slen, uint8_t *out1,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+             size_t olen)</s=
pan><br><span> {</span><br><span>     return false;</span><br><span> }</spa=
n><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><s=
pan>index b7db1e7..c17e608 100644</span><br><span>--- a/src/openvpn/ssl.c</=
span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1294,10 +1294,10=
 @@</span><br><span> }</span><br><span> </span><br><span> static bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_PRF(const uint8_t *=
secret, int secret_len, const char *label, const uint8_t *client_seed,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            int client_see=
d_len, const uint8_t *server_seed, int server_seed_len,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+openvpn_PRF(const uint8_t *secret, size=
_t secret_len, const char *label, const uint8_t *client_seed,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            size_t client_seed_le=
n, const uint8_t *server_seed, size_t server_seed_len,</span><br><span>    =
         const struct session_id *client_sid, const struct session_id *serv=
er_sid,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ui=
nt8_t *output, int output_len)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            uint8_t *output, size_t output_len)</span><br><span>=
 {</span><br><span>     /* concatenate seed components */</span><br><span> =
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/test=
s/unit_tests/openvpn/test_crypto.c</span><br><span>index 12ddaba..5df1046 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -16=
1,7 +161,7 @@</span><br><span> </span><br><span> </span><br><span>     uint=
8_t out[32];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool =
ret =3D ssl_tls1_PRF(seed, (int)seed_len, secret, (int)secret_len, out, siz=
eof(out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
ret =3D ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out));=
</span><br><span> </span><br><span> #if defined(LIBRESSL_VERSION_NUMBER) ||=
 defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span>     /* No TLS1 PRF support=
 in these libraries */</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1135?usp=3Demail">change 11=
35</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1135?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic88cd6e143bc48cab3c9ebb7c70=
07513803bd199 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1135 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--SRp+ZgOhyRk=--

