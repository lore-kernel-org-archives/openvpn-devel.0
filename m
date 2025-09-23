From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 10:06:29 +0000
In-Reply-To: <gerrit.1754490554000.I22b93c807f1be99fab450708f686fce4aa6d5cef@...2715...>
References: <gerrit.1754490554000.I22b93c807f1be99fab450708f686fce4aa6d5cef@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2948eed7fba97f1a5abb56e4bcadc8697a72559c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R4WNBGugCMI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Handle return type
 of EVP_MD_size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--R4WNBGugCMI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
33?usp=3Demail )

Change subject: Handle return type of EVP_MD_size
......................................................................

Handle return type of EVP_MD_size

Return type is int, but we often use it in contexts
where we expect size_t. So just cast it. Nothing else
to do really.

Change-Id: I22b93c807f1be99fab450708f686fce4aa6d5cef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1133
Message-Id: <20250922204059.23226-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59237213/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_openssl.c
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/xkey_helper.c
3 files changed, 5 insertions(+), 5 deletions(-)




diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1f95fba..2d0265a 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1273,7 +1273,7 @@

     /* We need to make a copy of the key since the OSSL parameters
      * only reference it */
-    memcpy(ctx->key, key, EVP_MD_size(kt));
+    memcpy(ctx->key, key, (size_t)EVP_MD_size(kt));

     /* Lookup/setting of parameters in OpenSSL 3.0 are string based
      *
@@ -1282,7 +1282,7 @@
      * the constness away here.
      */
     ctx->params[0] =3D OSSL_PARAM_construct_utf8_string("digest", (char *)=
EVP_MD_get0_name(kt), 0);
-    ctx->params[1] =3D OSSL_PARAM_construct_octet_string("key", ctx->key, =
EVP_MD_size(kt));
+    ctx->params[1] =3D OSSL_PARAM_construct_octet_string("key", ctx->key, =
(size_t)EVP_MD_size(kt));
     ctx->params[2] =3D OSSL_PARAM_construct_end();

     if (!EVP_MAC_init(ctx->ctx, NULL, 0, ctx->params))
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 7a7b21e..f1b8902 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -341,7 +341,7 @@
 x509_get_sha1_fingerprint(X509 *cert, struct gc_arena *gc)
 {
     const EVP_MD *sha1 =3D EVP_sha1();
-    struct buffer hash =3D alloc_buf_gc(EVP_MD_size(sha1), gc);
+    struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);
     X509_digest(cert, EVP_sha1(), BPTR(&hash), NULL);
     ASSERT(buf_inc_len(&hash, EVP_MD_size(sha1)));
     return hash;
@@ -351,7 +351,7 @@
 x509_get_sha256_fingerprint(X509 *cert, struct gc_arena *gc)
 {
     const EVP_MD *sha256 =3D EVP_sha256();
-    struct buffer hash =3D alloc_buf_gc(EVP_MD_size(sha256), gc);
+    struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha256), gc);
     X509_digest(cert, EVP_sha256(), BPTR(&hash), NULL);
     ASSERT(buf_inc_len(&hash, EVP_MD_size(sha256)));
     return hash;
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 72a24b5..29208a0 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -351,7 +351,7 @@
         }
     }

-    if (tbslen !=3D EVP_MD_size(EVP_get_digestbyname(mdname)))
+    if (tbslen !=3D (size_t)EVP_MD_size(EVP_get_digestbyname(mdname)))
     {
         msg(M_WARN, "Error: encode_pkcs11: invalid input length <%zu>", tb=
slen);
         goto done;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1133?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I22b93c807f1be99fab450708f686fce4aa6d5cef
Gerrit-Change-Number: 1133
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--R4WNBGugCMI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1133?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Handle return type of EVP_MD_size<br><br>Retu=
rn type is int, but we often use it in contexts<br>where we expect size_t. =
So just cast it. Nothing else<br>to do really.<br><br>Change-Id: I22b93c807=
f1be99fab450708f686fce4aa6d5cef<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerr=
it URL: https://gerrit.openvpn.net/c/openvpn/+/1133<br>Message-Id: &lt;2025=
0922204059.23226-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/op=
envpn/mailman/message/59237213/<br>Signed-off-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>---<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/ssl_v=
erify_openssl.c<br>M src/openvpn/xkey_helper.c<br>3 files changed, 5 insert=
ions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c=
</span><br><span>index 1f95fba..2d0265a 100644</span><br><span>--- a/src/op=
envpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</=
span><br><span>@@ -1273,7 +1273,7 @@</span><br><span> </span><br><span>    =
 /* We need to make a copy of the key since the OSSL parameters</span><br><=
span>      * only reference it */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    memcpy(ctx-&gt;key, key, EVP_MD_size(kt));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    memcpy(ctx-&gt;key, key, (size_t=
)EVP_MD_size(kt));</span><br><span> </span><br><span>     /* Lookup/setting=
 of parameters in OpenSSL 3.0 are string based</span><br><span>      *</spa=
n><br><span>@@ -1282,7 +1282,7 @@</span><br><span>      * the constness awa=
y here.</span><br><span>      */</span><br><span>     ctx-&gt;params[0] =3D=
 OSSL_PARAM_construct_utf8_string(&quot;digest&quot;, (char *)EVP_MD_get0_n=
ame(kt), 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&=
gt;params[1] =3D OSSL_PARAM_construct_octet_string(&quot;key&quot;, ctx-&gt=
;key, EVP_MD_size(kt));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ctx-&gt;params[1] =3D OSSL_PARAM_construct_octet_string(&quot;key&q=
uot;, ctx-&gt;key, (size_t)EVP_MD_size(kt));</span><br><span>     ctx-&gt;p=
arams[2] =3D OSSL_PARAM_construct_end();</span><br><span> </span><br><span>=
     if (!EVP_MAC_init(ctx-&gt;ctx, NULL, 0, ctx-&gt;params))</span><br><sp=
an>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_o=
penssl.c</span><br><span>index 7a7b21e..f1b8902 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_ve=
rify_openssl.c</span><br><span>@@ -341,7 +341,7 @@</span><br><span> x509_ge=
t_sha1_fingerprint(X509 *cert, struct gc_arena *gc)</span><br><span> {</spa=
n><br><span>     const EVP_MD *sha1 =3D EVP_sha1();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct buffer hash =3D alloc_buf_gc(EVP=
_MD_size(sha1), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);</s=
pan><br><span>     X509_digest(cert, EVP_sha1(), BPTR(&amp;hash), NULL);</s=
pan><br><span>     ASSERT(buf_inc_len(&amp;hash, EVP_MD_size(sha1)));</span=
><br><span>     return hash;</span><br><span>@@ -351,7 +351,7 @@</span><br>=
<span> x509_get_sha256_fingerprint(X509 *cert, struct gc_arena *gc)</span><=
br><span> {</span><br><span>     const EVP_MD *sha256 =3D EVP_sha256();</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer hash =
=3D alloc_buf_gc(EVP_MD_size(sha256), gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer hash =3D alloc_buf_gc((size_t)EVP_=
MD_size(sha256), gc);</span><br><span>     X509_digest(cert, EVP_sha256(), =
BPTR(&amp;hash), NULL);</span><br><span>     ASSERT(buf_inc_len(&amp;hash, =
EVP_MD_size(sha256)));</span><br><span>     return hash;</span><br><span>di=
ff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c</span><br>=
<span>index 72a24b5..29208a0 100644</span><br><span>--- a/src/openvpn/xkey_=
helper.c</span><br><span>+++ b/src/openvpn/xkey_helper.c</span><br><span>@@=
 -351,7 +351,7 @@</span><br><span>         }</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tbs=
len !=3D EVP_MD_size(EVP_get_digestbyname(mdname)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tbslen !=3D (size_t)EVP_MD_size(E=
VP_get_digestbyname(mdname)))</span><br><span>     {</span><br><span>      =
   msg(M_WARN, &quot;Error: encode_pkcs11: invalid input length &lt;%zu&gt;=
&quot;, tbslen);</span><br><span>         goto done;</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1133?usp=3Demail">change 1133</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1133?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I22b93c807f1be99fab450708f68=
6fce4aa6d5cef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1133 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--R4WNBGugCMI=--

