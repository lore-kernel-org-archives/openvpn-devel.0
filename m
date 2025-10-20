From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 20 Oct 2025 13:31:09 +0000
References: <gerrit.1760967063000.I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e49a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9ff6fe3a633b1424520c17052a4c0348c6a632a9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F4SVUXxTN/U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto_backend:
 Change len argument of md_ctx_update to size_t
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

--F4SVUXxTN/U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1287?usp=3Demail

to review the following change.


Change subject: crypto_backend: Change len argument of md_ctx_update to siz=
e_t
......................................................................

crypto_backend: Change len argument of md_ctx_update to size_t

The underlying APIs already use size_t and all the
users (only httpdigest and push) already put size_t
into it. So avoid conversion warnings.

Also fix one trivial conversion warning in push.c
to able to easily remove the -Wconversion override
from the affected code paths.

Change-Id: I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e49a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_openssl.c
M src/openvpn/httpdigest.c
M src/openvpn/push.c
5 files changed, 18 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1287/1

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 4d6a96c..e95752a 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -599,7 +599,7 @@
  * @param src           Buffer to digest. May not be NULL.
  * @param src_len       The length of the incoming buffer.
  */
-void md_ctx_update(md_ctx_t *ctx, const uint8_t *src, int src_len);
+void md_ctx_update(md_ctx_t *ctx, const uint8_t *src, size_t src_len);

 /*
  * Output the message digest to the given buffer.
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 076d4ee..2e328c3 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -765,6 +765,10 @@
     return 1;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  *
  * Generic message digest information functions
@@ -877,7 +881,7 @@
 }

 void
-md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
+md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_le=
n)
 {
     ASSERT(0 =3D=3D mbedtls_md_update(ctx, src, src_len));
 }
@@ -994,6 +998,11 @@
                                        seed_len, output, output_len));
 }
 #else /* defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_=
TLS1) */
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
@@ -1122,10 +1131,10 @@
     gc_free(&gc);
     return true;
 }
-#endif /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */

 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
+#endif /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */

 #endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 7688add..ef2dc4e 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1164,7 +1164,7 @@
 }

 void
-md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, int src_len)
+md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, size_t src_len)
 {
     EVP_DigestUpdate(ctx, src, src_len);
 }
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index f665b17..be20638 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -61,11 +61,6 @@
     Hex[HASHHEXLEN] =3D '\0';
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /* calculate H(A1) as per spec */
 void
 DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN=
 char *pszPassword,
@@ -150,8 +145,4 @@
     CvtHex(RespHash, Response);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* if PROXY_DIGEST_AUTH */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2c717c7..6f146fc 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -772,6 +772,10 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 send_push_reply_auth_token(struct tls_multi *multi)
 {
@@ -1046,7 +1050,7 @@
                             unsigned int *option_types_found, struct buffe=
r *buf)
 {
     int ret =3D PUSH_MSG_ERROR;
-    const uint8_t ch =3D buf_read_u8(buf);
+    const int ch =3D buf_read_u8(buf);
     if (ch =3D=3D ',')
     {
         struct buffer buf_orig =3D (*buf);
@@ -1090,10 +1094,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 process_incoming_push_msg(struct context *c, const struct buffer *buffer,
                           bool honor_received_options, unsigned int permis=
sion_mask,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1287?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e49a
Gerrit-Change-Number: 1287
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--F4SVUXxTN/U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1287?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">crypto_backend: Change len argument of md_c=
tx_update to size_t<br><br>The underlying APIs already use size_t and all t=
he<br>users (only httpdigest and push) already put size_t<br>into it. So av=
oid conversion warnings.<br><br>Also fix one trivial conversion warning in =
push.c<br>to able to easily remove the -Wconversion override<br>from the af=
fected code paths.<br><br>Change-Id: I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e=
49a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>=
M src/openvpn/crypto_backend.h<br>M src/openvpn/crypto_mbedtls.c<br>M src/o=
penvpn/crypto_openssl.c<br>M src/openvpn/httpdigest.c<br>M src/openvpn/push=
.c<br>5 files changed, 18 insertions(+), 18 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/12=
87/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto=
_backend.h</span><br><span>index 4d6a96c..e95752a 100644</span><br><span>--=
- a/src/openvpn/crypto_backend.h</span><br><span>+++ b/src/openvpn/crypto_b=
ackend.h</span><br><span>@@ -599,7 +599,7 @@</span><br><span>  * @param src=
           Buffer to digest. May not be NULL.</span><br><span>  * @param sr=
c_len       The length of the incoming buffer.</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void md_ctx_update(md_ctx_t *=
ctx, const uint8_t *src, int src_len);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void md_ctx_update(md_ctx_t *ctx, const uint8_t *src, si=
ze_t src_len);</span><br><span> </span><br><span> /*</span><br><span>  * Ou=
tput the message digest to the given buffer.</span><br><span>diff --git a/s=
rc/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>=
index 076d4ee..2e328c3 100644</span><br><span>--- a/src/openvpn/crypto_mbed=
tls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@=
 -765,6 +765,10 @@</span><br><span>     return 1;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /*</span><br><span>  *</span><br><span>  * Gene=
ric message digest information functions</span><br><span>@@ -877,7 +881,7 @=
@</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-md_ctx_update(mbedtls_md_context_t *=
ctx, const uint8_t *src, int src_len)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *s=
rc, size_t src_len)</span><br><span> {</span><br><span>     ASSERT(0 =3D=3D=
 mbedtls_md_update(ctx, src, src_len));</span><br><span> }</span><br><span>=
@@ -994,6 +998,11 @@</span><br><span>                                      =
  seed_len, output, output_len));</span><br><span> }</span><br><span> #else=
 /* defined(HAVE_MBEDTLS_SSL_TLS_PRF) &amp;&amp; defined(MBEDTLS_SSL_TLS_PR=
F_TLS1) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><b=
r><span>  * Generate the hash required by for the \c tls1_PRF function.</sp=
an><br><span>  *</span><br><span>@@ -1122,10 +1131,10 @@</span><br><span>  =
   gc_free(&amp;gc);</span><br><span>     return true;</span><br><span> }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_MBEDTLS_=
SSL_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br><span=
> </span><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br><=
span> #pragma GCC diagnostic pop</span><br><span> #endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* HAVE_MBEDTLS_SSL_TLS_PRF &am=
p;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br><span> </span><br><s=
pan> #endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span>diff --git a/src/op=
envpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index=
 7688add..ef2dc4e 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c=
</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -116=
4,7 +1164,7 @@</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_update(EVP_MD_CT=
X *ctx, const uint8_t *src, int src_len)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, siz=
e_t src_len)</span><br><span> {</span><br><span>     EVP_DigestUpdate(ctx, =
src, src_len);</span><br><span> }</span><br><span>diff --git a/src/openvpn/=
httpdigest.c b/src/openvpn/httpdigest.c</span><br><span>index f665b17..be20=
638 100644</span><br><span>--- a/src/openvpn/httpdigest.c</span><br><span>+=
++ b/src/openvpn/httpdigest.c</span><br><span>@@ -61,11 +61,6 @@</span><br>=
<span>     Hex[HASHHEXLEN] =3D &#39;\0&#39;;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* calculate H(A1) as per=
 spec */</span><br><span> void</span><br><span> DigestCalcHA1(IN char *pszA=
lg, IN char *pszUserName, IN char *pszRealm, IN char *pszPassword,</span><b=
r><span>@@ -150,8 +145,4 @@</span><br><span>     CvtHex(RespHash, Response)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* if PROXY_DIGEST_AU=
TH */</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c<=
/span><br><span>index 2c717c7..6f146fc 100644</span><br><span>--- a/src/ope=
nvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -77=
2,6 +772,10 @@</span><br><span>     return true;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> void</span><br><span> send_push_reply_auth_token=
(struct tls_multi *multi)</span><br><span> {</span><br><span>@@ -1046,7 +10=
50,7 @@</span><br><span>                             unsigned int *option_t=
ypes_found, struct buffer *buf)</span><br><span> {</span><br><span>     int=
 ret =3D PUSH_MSG_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const uint8_t ch =3D buf_read_u8(buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const int ch =3D buf_read_u8(buf);</span><br>=
<span>     if (ch =3D=3D &#39;,&#39;)</span><br><span>     {</span><br><spa=
n>         struct buffer buf_orig =3D (*buf);</span><br><span>@@ -1090,10 +=
1094,6 @@</span><br><span>     return ret;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> int</span><br><span> process_incoming_push_msg(struct context =
*c, const struct buffer *buffer,</span><br><span>                          =
 bool honor_received_options, unsigned int permission_mask,</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1287?usp=3Demail">change 1287</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1287?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I27f2fcd903d26ccbfbd0cdc45f9=
9cc3cd8b0e49a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1287 </div>
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

--F4SVUXxTN/U=--

