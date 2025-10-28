From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 19:22:22 +0000
In-Reply-To: <gerrit.1760967063000.I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e49a@...2715...>
References: <gerrit.1760967063000.I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e49a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <43b15b447e09710b99f214cb44a2266ce5d200e2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wjr+egz7XVk="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Wjr+egz7XVk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1287?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1287
Message-Id: <20251028185706.1247-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
973.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_openssl.c
M src/openvpn/httpdigest.c
M src/openvpn/push.c
5 files changed, 18 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1287/3

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
index f596b8c..ec0269c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1165,7 +1165,7 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I27f2fcd903d26ccbfbd0cdc45f99cc3cd8b0e49a
Gerrit-Change-Number: 1287
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Wjr+egz7XVk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1287?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">crypto_backend: Change len argument=
 of md_ctx_update to size_t<br><br>The underlying APIs already use size_t a=
nd all the<br>users (only httpdigest and push) already put size_t<br>into i=
t. So avoid conversion warnings.<br><br>Also fix one trivial conversion war=
ning in push.c<br>to able to easily remove the -Wconversion override<br>fro=
m the affected code paths.<br><br>Change-Id: I27f2fcd903d26ccbfbd0cdc45f99c=
c3cd8b0e49a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerr=
it.openvpn.net/c/openvpn/+/1287<br>Message-Id: &lt;20251028185706.1247-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg33973.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/crypto_backend.h<br>M src/openvpn/crypto_=
mbedtls.c<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/httpdigest.c<b=
r>M src/openvpn/push.c<br>5 files changed, 18 insertions(+), 18 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/87/1287/3</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_backend.h =
b/src/openvpn/crypto_backend.h</span><br><span>index 4d6a96c..e95752a 10064=
4</span><br><span>--- a/src/openvpn/crypto_backend.h</span><br><span>+++ b/=
src/openvpn/crypto_backend.h</span><br><span>@@ -599,7 +599,7 @@</span><br>=
<span>  * @param src           Buffer to digest. May not be NULL.</span><br=
><span>  * @param src_len       The length of the incoming buffer.</span><b=
r><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void md_c=
tx_update(md_ctx_t *ctx, const uint8_t *src, int src_len);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void md_ctx_update(md_ctx_t *ctx, co=
nst uint8_t *src, size_t src_len);</span><br><span> </span><br><span> /*</s=
pan><br><span>  * Output the message digest to the given buffer.</span><br>=
<span>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtl=
s.c</span><br><span>index 076d4ee..2e328c3 100644</span><br><span>--- a/src=
/openvpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.=
c</span><br><span>@@ -765,6 +765,10 @@</span><br><span>     return 1;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  *</spa=
n><br><span>  * Generic message digest information functions</span><br><spa=
n>@@ -877,7 +881,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_update(mb=
edtls_md_context_t *ctx, const uint8_t *src, int src_len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+md_ctx_update(mbedtls_md_context_t *c=
tx, const uint8_t *src, size_t src_len)</span><br><span> {</span><br><span>=
     ASSERT(0 =3D=3D mbedtls_md_update(ctx, src, src_len));</span><br><span=
> }</span><br><span>@@ -994,6 +998,11 @@</span><br><span>                  =
                      seed_len, output, output_len));</span><br><span> }</s=
pan><br><span> #else /* defined(HAVE_MBEDTLS_SSL_TLS_PRF) &amp;&amp; define=
d(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &=
quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /*</span><br><span>  * Generate the hash required by for the \c tl=
s1_PRF function.</span><br><span>  *</span><br><span>@@ -1122,10 +1131,10 @=
@</span><br><span>     gc_free(&amp;gc);</span><br><span>     return true;<=
/span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif /* HAVE_MBEDTLS_SSL_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1=
) */</span><br><span> </span><br><span> #if defined(__GNUC__) || defined(__=
clang__)</span><br><span> #pragma GCC diagnostic pop</span><br><span> #endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* HAVE_MBE=
DTLS_SSL_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br>=
<span> </span><br><span> #endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span=
>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</=
span><br><span>index f596b8c..ec0269c 100644</span><br><span>--- a/src/open=
vpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</sp=
an><br><span>@@ -1165,7 +1165,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_=
ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, int src_len)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+md_ctx_update(EVP_MD_CTX *ctx, con=
st uint8_t *src, size_t src_len)</span><br><span> {</span><br><span>     EV=
P_DigestUpdate(ctx, src, src_len);</span><br><span> }</span><br><span>diff =
--git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c</span><br><span=
>index f665b17..be20638 100644</span><br><span>--- a/src/openvpn/httpdigest=
.c</span><br><span>+++ b/src/openvpn/httpdigest.c</span><br><span>@@ -61,11=
 +61,6 @@</span><br><span>     Hex[HASHHEXLEN] =3D &#39;\0&#39;;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wcon=
version&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* ca=
lculate H(A1) as per spec */</span><br><span> void</span><br><span> DigestC=
alcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN char *p=
szPassword,</span><br><span>@@ -150,8 +145,4 @@</span><br><span>     CvtHex=
(RespHash, Response);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /=
* if PROXY_DIGEST_AUTH */</span><br><span>diff --git a/src/openvpn/push.c b=
/src/openvpn/push.c</span><br><span>index 2c717c7..6f146fc 100644</span><br=
><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</s=
pan><br><span>@@ -772,6 +772,10 @@</span><br><span>     return true;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> send_p=
ush_reply_auth_token(struct tls_multi *multi)</span><br><span> {</span><br>=
<span>@@ -1046,7 +1050,7 @@</span><br><span>                             un=
signed int *option_types_found, struct buffer *buf)</span><br><span> {</spa=
n><br><span>     int ret =3D PUSH_MSG_ERROR;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const uint8_t ch =3D buf_read_u8(buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const int ch =3D buf_read=
_u8(buf);</span><br><span>     if (ch =3D=3D &#39;,&#39;)</span><br><span> =
    {</span><br><span>         struct buffer buf_orig =3D (*buf);</span><br=
><span>@@ -1090,10 +1094,6 @@</span><br><span>     return ret;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> int</span><br><span> process_incoming_pu=
sh_msg(struct context *c, const struct buffer *buffer,</span><br><span>    =
                       bool honor_received_options, unsigned int permission=
_mask,</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1287?usp=3Demail">change 1287</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1287?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I27f2fcd903d26ccbfbd0cdc45f9=
9cc3cd8b0e49a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1287 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Wjr+egz7XVk=--

