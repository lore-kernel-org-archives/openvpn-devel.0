From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 14:27:23 +0000
In-Reply-To: <gerrit.1775344373000.Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929@...2715...>
References: <gerrit.1775344373000.Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <761f9d2fe1c5563399550a48ee7df9c62e786cc9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ttSnkn0O1bo="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ttSnkn0O1bo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1612?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: crypto_backend: Remove md_full
......................................................................

crypto_backend: Remove md_full

There was only one user for mbedtls < 4.0,
so remove all the unused implementations.

Identified by cppcheck.

Change-Id: Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1612
Message-Id: <20260405103110.32401-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
495.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls_legacy.c
M src/openvpn/crypto_mbedtls_legacy.h
M src/openvpn/crypto_openssl.c
M src/openvpn/ssl_mbedtls.c
6 files changed, 5 insertions(+), 54 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1612/2

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 0bfa8b4..b602ba1 100644
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
index c41daef..6662def 100644
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
index 087d94c..debd53d 100644
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
index 9900d06..c11cfd8 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929
Gerrit-Change-Number: 1612
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ttSnkn0O1bo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1612?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">crypto_backend: Remove md_full<br><=
br>There was only one user for mbedtls &lt; 4.0,<br>so remove all the unuse=
d implementations.<br><br>Identified by cppcheck.<br><br>Change-Id: Ie2285f=
5bf52f5c669fb01f9ae36d6aa1674f0929<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>G=
errit URL: https://gerrit.openvpn.net/c/openvpn/+/1612<br>Message-Id: &lt;2=
0260405103110.32401-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg36495.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/crypto_backend.h<=
br>M src/openvpn/crypto_mbedtls.c<br>M src/openvpn/crypto_mbedtls_legacy.c<=
br>M src/openvpn/crypto_mbedtls_legacy.h<br>M src/openvpn/crypto_openssl.c<=
br>M src/openvpn/ssl_mbedtls.c<br>6 files changed, 5 insertions(+), 54 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/12/1612/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_bac=
kend.h b/src/openvpn/crypto_backend.h</span><br><span>index 0bfa8b4..b602ba=
1 100644</span><br><span>--- a/src/openvpn/crypto_backend.h</span><br><span=
>+++ b/src/openvpn/crypto_backend.h</span><br><span>@@ -549,18 +549,6 @@</s=
pan><br><span>  *</span><br><span>  */</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * Calculates the message digest for the given buffer.</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param mdname        message digest name=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param src        =
   Buffer to digest. May not be NULL.</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param src_len       The length of the incoming buffer.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param dst         =
  Buffer to write the message digest to. May not be NULL.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @return              true on success, false on failure<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-bool md_full(const char *mdname, const u=
int8_t *src, size_t src_len, uint8_t *dst);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Allocate a n=
ew message digest context</span><br><span>  *</span><br><span>diff --git a/=
src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span=
>index c41daef..6662def 100644</span><br><span>--- a/src/openvpn/crypto_mbe=
dtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@=
@ -696,28 +696,6 @@</span><br><span>     return ctx;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-md_full(const char *mdna=
me, const uint8_t *src, size_t src_len, uint8_t *dst)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const md_info_t *md =3D md_get(mdname);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (md =3D=3D NULL)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* We depend =
on the caller to ensure that dst has enough room for the hash,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * so we just tell PSA that it=
 can hold the appropriate amount of bytes. */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    size_t dst_size =3D PSA_HASH_LENGTH(md-&gt;psa_=
alg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t hash_=
length =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    psa_status_t status =3D p=
sa_hash_compute(md-&gt;psa_alg, src, src_len, dst, dst_size, &amp;hash_leng=
th);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status !=
=3D PSA_SUCCESS || hash_length !=3D dst_size)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br>=
<span> md_ctx_free(md_ctx_t *ctx)</span><br><span> {</span><br><span>diff -=
-git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_leg=
acy.c</span><br><span>index 087d94c..debd53d 100644</span><br><span>--- a/s=
rc/openvpn/crypto_mbedtls_legacy.c</span><br><span>+++ b/src/openvpn/crypto=
_mbedtls_legacy.c</span><br><span>@@ -769,7 +769,7 @@</span><br><span>  */<=
/span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static const mbedtls_md_info_t *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+const mbedtls_md_info_t *</span><br><span> md_ge=
t(const char *digest)</span><br><span> {</span><br><span>     const mbedtls=
_md_info_t *md =3D NULL;</span><br><span>@@ -825,13 +825,6 @@</span><br><sp=
an>  *</span><br><span>  */</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-md_full(const char *mdname, const uint8_t *src, size_t src_len, uint=
8_t *dst)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_md_info_t *kt =
=3D md_get(mdname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return 0 =3D=3D mbedtls_md(kt, src, src_len, dst);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> mbedtls_md_context_t *</span><br><span> md_ct=
x_new(void)</span><br><span> {</span><br><span>diff --git a/src/openvpn/cry=
pto_mbedtls_legacy.h b/src/openvpn/crypto_mbedtls_legacy.h</span><br><span>=
index 1005057..23113be 100644</span><br><span>--- a/src/openvpn/crypto_mbed=
tls_legacy.h</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.h</spa=
n><br><span>@@ -137,4 +137,6 @@</span><br><span>  */</span><br><span> #defi=
ne mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__=
, __LINE__)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+const mbedtls_md_info_t *md_get(const char *digest);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* CRYP=
TO_MBEDTLS_H_ */</span><br><span>diff --git a/src/openvpn/crypto_openssl.c =
b/src/openvpn/crypto_openssl.c</span><br><span>index 9900d06..c11cfd8 10064=
4</span><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/=
src/openvpn/crypto_openssl.c</span><br><span>@@ -1107,17 +1107,6 @@</span><=
br><span>  *</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-md_full(const char *mdname, const uint8_t *src, size_t src_l=
en, uint8_t *dst)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int in_md_l=
en =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    evp_md_t=
ype *kt =3D md_get(mdname);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D=
 EVP_Digest(src, src_len, dst, &amp;in_md_len, kt, NULL);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    EVP_MD_free(kt);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return ret =3D=3D 1;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> EVP_MD_CTX *</span><br><span> md_ctx_ne=
w(void)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_mbe=
dtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index d0c481e..a62ff76 1=
00644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b=
/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -1029,8 +1029,9 @@</span><br>=
<span>     if (NULL !=3D ctx-&gt;crt_chain)</span><br><span>     {</span><b=
r><span>         mbedtls_x509_crt *cert =3D ctx-&gt;crt_chain;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const mbedtls_md_info_t =
*kt =3D md_get(&quot;SHA256&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!md_full(&quot;SHA256&quot;, ce=
rt-&gt;tbs.p, cert-&gt;tbs.len, sha256_hash))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (0 !=3D mbedtls_md(kt, cert-&gt;tbs.p,=
 cert-&gt;tbs.len, sha256_hash))</span><br><span>         {</span><br><span=
>             msg(M_WARN, &quot;WARNING: failed to personalise random&quot;=
);</span><br><span>         }</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1612?usp=3Demail">ch=
ange 1612</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1612?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2285f5bf52f5c669fb01f9ae36=
d6aa1674f0929 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1612 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ttSnkn0O1bo=--

