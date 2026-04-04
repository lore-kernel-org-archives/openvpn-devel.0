From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 23:12:56 +0000
References: <gerrit.1775344373000.Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <050e3f9be80e22e8e80cf0bc50ea4994ca71e97f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QKIXn9ZHs5s="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto_backend:
 Remove md_full
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

--QKIXn9ZHs5s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1612?usp=3Demail

to review the following change.


Change subject: crypto_backend: Remove md_full
......................................................................

crypto_backend: Remove md_full

There was only one user for mbedtls < 4.0,
so remove all the unused implementations.

Identified by cppcheck.

Change-Id: Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls_legacy.c
M src/openvpn/crypto_mbedtls_legacy.h
M src/openvpn/crypto_openssl.c
M src/openvpn/ssl_mbedtls.c
6 files changed, 5 insertions(+), 54 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1612/1

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 4e9283d..360abbe 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -549,18 +549,6 @@
  *
  */

-/**
- * Calculates the message digest for the given buffer.
- *
- * @param mdname        message digest name
- * @param src           Buffer to digest. May not be NULL.
- * @param src_len       The length of the incoming buffer.
- * @param dst           Buffer to write the message digest to. May not be =
NULL.
- *
- * @return              true on success, false on failure
- */
-bool md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8=
_t *dst);
-
 /*
  * Allocate a new message digest context
  *
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index b0d0820..665257c0 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -696,28 +696,6 @@
     return ctx;
 }

-bool
-md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *d=
st)
-{
-    const md_info_t *md =3D md_get(mdname);
-    if (md =3D=3D NULL)
-    {
-        return false;
-    }
-
-    /* We depend on the caller to ensure that dst has enough room for the =
hash,
-     * so we just tell PSA that it can hold the appropriate amount of byte=
s. */
-    size_t dst_size =3D PSA_HASH_LENGTH(md->psa_alg);
-    size_t hash_length =3D 0;
-
-    psa_status_t status =3D psa_hash_compute(md->psa_alg, src, src_len, ds=
t, dst_size, &hash_length);
-    if (status !=3D PSA_SUCCESS || hash_length !=3D dst_size)
-    {
-        return false;
-    }
-    return true;
-}
-
 void
 md_ctx_free(md_ctx_t *ctx)
 {
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedt=
ls_legacy.c
index 3f04a3e..6556358 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -769,7 +769,7 @@
  */


-static const mbedtls_md_info_t *
+const mbedtls_md_info_t *
 md_get(const char *digest)
 {
     const mbedtls_md_info_t *md =3D NULL;
@@ -825,13 +825,6 @@
  *
  */

-bool
-md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *d=
st)
-{
-    const mbedtls_md_info_t *kt =3D md_get(mdname);
-    return 0 =3D=3D mbedtls_md(kt, src, src_len, dst);
-}
-
 mbedtls_md_context_t *
 md_ctx_new(void)
 {
diff --git a/src/openvpn/crypto_mbedtls_legacy.h b/src/openvpn/crypto_mbedt=
ls_legacy.h
index 1005057..23113be 100644
--- a/src/openvpn/crypto_mbedtls_legacy.h
+++ b/src/openvpn/crypto_mbedtls_legacy.h
@@ -137,4 +137,6 @@
  */
 #define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __=
func__, __LINE__)

+const mbedtls_md_info_t *md_get(const char *digest);
+
 #endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e49f654..e268d7c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1107,17 +1107,6 @@
  *
  */

-bool
-md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *d=
st)
-{
-    unsigned int in_md_len =3D 0;
-    evp_md_type *kt =3D md_get(mdname);
-
-    int ret =3D EVP_Digest(src, src_len, dst, &in_md_len, kt, NULL);
-    EVP_MD_free(kt);
-    return ret =3D=3D 1;
-}
-
 EVP_MD_CTX *
 md_ctx_new(void)
 {
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index d0c481e..a62ff76 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1029,8 +1029,9 @@
     if (NULL !=3D ctx->crt_chain)
     {
         mbedtls_x509_crt *cert =3D ctx->crt_chain;
+        const mbedtls_md_info_t *kt =3D md_get("SHA256");

-        if (!md_full("SHA256", cert->tbs.p, cert->tbs.len, sha256_hash))
+        if (0 !=3D mbedtls_md(kt, cert->tbs.p, cert->tbs.len, sha256_hash))
         {
             msg(M_WARN, "WARNING: failed to personalise random");
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1612?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929
Gerrit-Change-Number: 1612
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--QKIXn9ZHs5s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1612?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">crypto_backend: Remove md_full<br><br>There=
 was only one user for mbedtls &lt; 4.0,<br>so remove all the unused implem=
entations.<br><br>Identified by cppcheck.<br><br>Change-Id: Ie2285f5bf52f5c=
669fb01f9ae36d6aa1674f0929<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>---<br>M src/openvpn/crypto_backend.h<br>M src/openvpn/cryp=
to_mbedtls.c<br>M src/openvpn/crypto_mbedtls_legacy.c<br>M src/openvpn/cryp=
to_mbedtls_legacy.h<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/ssl_=
mbedtls.c<br>6 files changed, 5 insertions(+), 54 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/12/1612/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/=
crypto_backend.h</span><br><span>index 4e9283d..360abbe 100644</span><br><s=
pan>--- a/src/openvpn/crypto_backend.h</span><br><span>+++ b/src/openvpn/cr=
ypto_backend.h</span><br><span>@@ -549,18 +549,6 @@</span><br><span>  *</sp=
an><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * C=
alculates the message digest for the given buffer.</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param mdname        message digest name</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param src           Buffer to digest. M=
ay not be NULL.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @pa=
ram src_len       The length of the incoming buffer.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param dst           Buffer to write the=
 message digest to. May not be NULL.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
return              true on success, false on failure</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-bool md_full(const char *mdname, const uint8_t *src, size_t s=
rc_len, uint8_t *dst);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> /*</span><br><span>  * Allocate a new message digest con=
text</span><br><span>  *</span><br><span>diff --git a/src/openvpn/crypto_mb=
edtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index b0d0820..66525=
7c0 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><sp=
an>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -696,28 +696,6 @@<=
/span><br><span>     return ctx;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-md_full(const char *mdname, const uint8_t *=
src, size_t src_len, uint8_t *dst)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st md_info_t *md =3D md_get(mdname);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (md =3D=3D NULL)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* We depend on the caller to en=
sure that dst has enough room for the hash,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     * so we just tell PSA that it can hold the appro=
priate amount of bytes. */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    size_t dst_size =3D PSA_HASH_LENGTH(md-&gt;psa_alg);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    size_t hash_length =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    psa_status_t status =3D psa_hash_compute(md-=
&gt;psa_alg, src, src_len, dst, dst_size, &amp;hash_length);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (status !=3D PSA_SUCCESS || h=
ash_length !=3D dst_size)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> md_ctx_free(m=
d_ctx_t *ctx)</span><br><span> {</span><br><span>diff --git a/src/openvpn/c=
rypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c</span><br><spa=
n>index 3f04a3e..6556358 100644</span><br><span>--- a/src/openvpn/crypto_mb=
edtls_legacy.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.c</s=
pan><br><span>@@ -769,7 +769,7 @@</span><br><span>  */</span><br><span> </s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 const mbedtls_md_info_t *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+const mbedtls_md_info_t *</span><br><span> md_get(const char *digest=
)</span><br><span> {</span><br><span>     const mbedtls_md_info_t *md =3D N=
ULL;</span><br><span>@@ -825,13 +825,6 @@</span><br><span>  *</span><br><sp=
an>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_full(const=
 char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const mbedtls_md_info_t *kt =3D md_get(mdname);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0 =3D=3D mb=
edtls_md(kt, src, src_len, dst);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> mbedtls_md_context_t *</span><br><span> md_ctx_new(void)</span><br=
><span> {</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy.h =
b/src/openvpn/crypto_mbedtls_legacy.h</span><br><span>index 1005057..23113b=
e 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy.h</span><b=
r><span>+++ b/src/openvpn/crypto_mbedtls_legacy.h</span><br><span>@@ -137,4=
 +137,6 @@</span><br><span>  */</span><br><span> #define mbed_ok(errval) mb=
ed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+const mbedt=
ls_md_info_t *md_get(const char *digest);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #endif /* CRYPTO_MBEDTLS_H_ */</spa=
n><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_=
openssl.c</span><br><span>index e49f654..e268d7c 100644</span><br><span>---=
 a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_op=
enssl.c</span><br><span>@@ -1107,17 +1107,6 @@</span><br><span>  *</span><b=
r><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_full(=
const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    unsigned int in_md_len =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    evp_md_type *kt =3D md_get(mdna=
me);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D EVP_Digest(src, src_le=
n, dst, &amp;in_md_len, kt, NULL);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    EVP_MD_free(kt);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return ret =3D=3D 1;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> EVP_MD_CTX *</span><br><span> md_ctx_new(void)</span><br><span=
> {</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ss=
l_mbedtls.c</span><br><span>index d0c481e..a62ff76 100644</span><br><span>-=
-- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtl=
s.c</span><br><span>@@ -1029,8 +1029,9 @@</span><br><span>     if (NULL !=
=3D ctx-&gt;crt_chain)</span><br><span>     {</span><br><span>         mbed=
tls_x509_crt *cert =3D ctx-&gt;crt_chain;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        const mbedtls_md_info_t *kt =3D md_get(&quot;=
SHA256&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!md_full(&quot;SHA256&quot;, cert-&gt;tbs.p, cert-&g=
t;tbs.len, sha256_hash))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (0 !=3D mbedtls_md(kt, cert-&gt;tbs.p, cert-&gt;tbs.len, sh=
a256_hash))</span><br><span>         {</span><br><span>             msg(M_W=
ARN, &quot;WARNING: failed to personalise random&quot;);</span><br><span>  =
       }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1612?usp=3Demail">change 1612</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1612?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2285f5bf52f5c669fb01f9ae36=
d6aa1674f0929 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1612 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--QKIXn9ZHs5s=--

