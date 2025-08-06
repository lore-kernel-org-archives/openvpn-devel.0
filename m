From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Aug 2025 14:29:38 +0000
References: <gerrit.1754490554000.I22b93c807f1be99fab450708f686fce4aa6d5cef@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2f140e89b88e1a50c329cf41a71d96f8f9db8d5f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/3VieYuW2vs="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/3VieYuW2vs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1133?usp=3Demail

to review the following change.


Change subject: Handle return type of EVP_MD_size
......................................................................

Handle return type of EVP_MD_size

Return type is int, but we often use it in contexts
where we expect size_t. So just cast it. Nothing else
to do really.

Change-Id: I22b93c807f1be99fab450708f686fce4aa6d5cef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto_openssl.c
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/xkey_helper.c
3 files changed, 5 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1133/1

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 4fb6393..2351bfd 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1273,7 +1273,7 @@
=20
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
index 1d83dfe..22659aa 100644
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
index 3820808..9541a7c 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--/3VieYuW2vs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1133?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Handle return type of EVP_MD_size<br><br>Return type is int,=
 but we often use it in contexts<br>where we expect size_t. So just cast it=
. Nothing else<br>to do really.<br><br>Change-Id: I22b93c807f1be99fab450708=
f686fce4aa6d5cef<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/ssl_verify_ope=
nssl.c<br>M src/openvpn/xkey_helper.c<br>3 files changed, 5 insertions(+), =
5 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/33/1133/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/sr=
c/openvpn/crypto_openssl.c</span><br><span>index 4fb6393..2351bfd 100644</s=
pan><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/=
openvpn/crypto_openssl.c</span><br><span>@@ -1273,7 +1273,7 @@</span><br><s=
pan> </span><br><span>     /* We need to make a copy of the key since the O=
SSL parameters</span><br><span>      * only reference it */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    memcpy(ctx-&gt;key, key, EVP_MD_s=
ize(kt));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy=
(ctx-&gt;key, key, (size_t)EVP_MD_size(kt));</span><br><span> </span><br><s=
pan>     /* Lookup/setting of parameters in OpenSSL 3.0 are string based</s=
pan><br><span>      *</span><br><span>@@ -1282,7 +1282,7 @@</span><br><span=
>      * the constness away here.</span><br><span>      */</span><br><span>=
     ctx-&gt;params[0] =3D OSSL_PARAM_construct_utf8_string(&quot;digest&qu=
ot;, (char *)EVP_MD_get0_name(kt), 0);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ctx-&gt;params[1] =3D OSSL_PARAM_construct_octet_strin=
g(&quot;key&quot;, ctx-&gt;key, EVP_MD_size(kt));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ctx-&gt;params[1] =3D OSSL_PARAM_construc=
t_octet_string(&quot;key&quot;, ctx-&gt;key, (size_t)EVP_MD_size(kt));</spa=
n><br><span>     ctx-&gt;params[2] =3D OSSL_PARAM_construct_end();</span><b=
r><span> </span><br><span>     if (!EVP_MAC_init(ctx-&gt;ctx, NULL, 0, ctx-=
&gt;params))</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c =
b/src/openvpn/ssl_verify_openssl.c</span><br><span>index 1d83dfe..22659aa 1=
00644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><spa=
n>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -341,7 +341,7 @=
@</span><br><span> x509_get_sha1_fingerprint(X509 *cert, struct gc_arena *g=
c)</span><br><span> {</span><br><span>     const EVP_MD *sha1 =3D EVP_sha1(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer h=
ash =3D alloc_buf_gc(EVP_MD_size(sha1), gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer hash =3D alloc_buf_gc((size_t)EV=
P_MD_size(sha1), gc);</span><br><span>     X509_digest(cert, EVP_sha1(), BP=
TR(&amp;hash), NULL);</span><br><span>     ASSERT(buf_inc_len(&amp;hash, EV=
P_MD_size(sha1)));</span><br><span>     return hash;</span><br><span>@@ -35=
1,7 +351,7 @@</span><br><span> x509_get_sha256_fingerprint(X509 *cert, stru=
ct gc_arena *gc)</span><br><span> {</span><br><span>     const EVP_MD *sha2=
56 =3D EVP_sha256();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct buffer hash =3D alloc_buf_gc(EVP_MD_size(sha256), gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer hash =3D all=
oc_buf_gc((size_t)EVP_MD_size(sha256), gc);</span><br><span>     X509_diges=
t(cert, EVP_sha256(), BPTR(&amp;hash), NULL);</span><br><span>     ASSERT(b=
uf_inc_len(&amp;hash, EVP_MD_size(sha256)));</span><br><span>     return ha=
sh;</span><br><span>diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xk=
ey_helper.c</span><br><span>index 3820808..9541a7c 100644</span><br><span>-=
-- a/src/openvpn/xkey_helper.c</span><br><span>+++ b/src/openvpn/xkey_helpe=
r.c</span><br><span>@@ -351,7 +351,7 @@</span><br><span>         }</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (tbslen !=3D EVP_MD_size(EVP_get_digestbyname(mdname)))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tbslen !=3D (=
size_t)EVP_MD_size(EVP_get_digestbyname(mdname)))</span><br><span>     {</s=
pan><br><span>         msg(M_WARN, &quot;Error: encode_pkcs11: invalid inpu=
t length &lt;%zu&gt;&quot;, tbslen);</span><br><span>         goto done;</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1133?usp=3Demail">change 1133</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1133?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I22b93c807f1be99fab450708f68=
6fce4aa6d5cef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1133 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--/3VieYuW2vs=--

