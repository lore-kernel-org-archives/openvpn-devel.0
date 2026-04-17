From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 17 Apr 2026 10:44:40 +0000
In-Reply-To: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
References: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <817d632b2f57fb1eb51c391794964b801b866b34-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xDttFaRT8hA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: OpenSSL 4.0: Use
 X509_check_certificate_times instead of X509_cmp_time
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

--xDttFaRT8hA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail

to look at the new patch set (#5).


Change subject: OpenSSL 4.0: Use X509_check_certificate_times instead of X5=
09_cmp_time
......................................................................

OpenSSL 4.0: Use X509_check_certificate_times instead of X509_cmp_time

The X509_cmp_time function is deprecated in OpenSSL 4.0. So we avoid it and
use the new API.

Change-Id: I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 55 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1595/5

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index efe5b5b..6130dc3 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -634,6 +634,7 @@
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 }

+#if OPENSSL_VERSION_NUMBER < 0x40000000L
 void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
@@ -669,6 +670,60 @@
         msg(M_WARN, "WARNING: Your certificate has expired!");
     }
 }
+#else
+void
+tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
+{
+    const X509 *cert;
+    ASSERT(ctx);
+
+    cert =3D SSL_CTX_get0_certificate(ctx->ctx);
+
+    if (cert =3D=3D NULL)
+    {
+        return; /* Nothing to check if there is no certificate */
+    }
+
+    X509_VERIFY_PARAM *vpm =3D X509_VERIFY_PARAM_new();
+
+    if (vpm =3D=3D NULL)
+    {
+        msg(D_TLS_DEBUG_MED, "Failed to initialise certificate verificatio=
n parameters.");
+        return;
+    }
+
+    X509_VERIFY_PARAM_set_flags(vpm, X509_V_FLAG_USE_CHECK_TIME);
+    X509_VERIFY_PARAM_set_time(vpm, now);
+
+    int error =3D 0;
+    int ret =3D X509_check_certificate_times(vpm, cert, &error);
+    X509_VERIFY_PARAM_free(vpm);
+
+    if (ret =3D=3D 1)
+    {
+        return;
+    }
+
+    switch (error)
+    {
+        case X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD:
+            msg(D_TLS_DEBUG_MED, "Failed to read certificate notBefore fie=
ld.");
+            break;
+
+        case X509_V_ERR_CERT_NOT_YET_VALID:
+            msg(M_WARN, "WARNING: Your certificate is not yet valid!");
+            break;
+
+        case X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD:
+            msg(D_TLS_DEBUG_MED, "Failed to read certificate notAfter fiel=
d.");
+            break;
+
+        case X509_V_ERR_CERT_HAS_EXPIRED:
+            msg(M_WARN, "WARNING: Your certificate has expired!");
+            break;
+    }
+}
+#endif

 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file, bool=
 dh_file_inline)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5
Gerrit-Change-Number: 1595
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xDttFaRT8hA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #5</strong> to this change.</p><p><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1595?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">OpenSSL 4.0: Use X509_check_certificate_times instead of X509_cmp_time<=
br><br>The X509_cmp_time function is deprecated in OpenSSL 4.0. So we avoid=
 it and<br>use the new API.<br><br>Change-Id: I6c2eda0e5bbb3a70b404f821e25d=
ed81f0f5ddd5<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<=
br>M src/openvpn/ssl_openssl.c<br>1 file changed, 55 insertions(+), 0 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/95/1595/5</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl=
.c b/src/openvpn/ssl_openssl.c</span><br><span>index efe5b5b..6130dc3 10064=
4</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src=
/openvpn/ssl_openssl.c</span><br><span>@@ -634,6 +634,7 @@</span><br><span>=
 #endif /* if OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if OPENSSL_VERSION_NUMBER &lt; 0x40000000L</span><br><span> void</span><br>=
<span> tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)</span><br><s=
pan> {</span><br><span>@@ -669,6 +670,60 @@</span><br><span>         msg(M_=
WARN, &quot;WARNING: Your certificate has expired!&quot;);</span><br><span>=
     }</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_check_cert_time=
(const struct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst X509 *cert;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ASSERT(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    cert =3D SSL_CTX_get0=
_certificate(ctx-&gt;ctx);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert=
 =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return; /* N=
othing to check if there is no certificate */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    X50=
9_VERIFY_PARAM *vpm =3D X509_VERIFY_PARAM_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (vpm =3D=3D NULL)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(D_TLS_DEBUG_MED, &quot;Failed to initialise certificate verifi=
cation parameters.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    X509_VERIFY_PARAM_set_flag=
s(vpm, X509_V_FLAG_USE_CHECK_TIME);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    X509_VERIFY_PARAM_set_time(vpm, now);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int error =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int ret =3D X509_check_certificate_times(vpm, cert,=
 &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    X5=
09_VERIFY_PARAM_free(vpm);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =
=3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    switch (error)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        case X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_DEBUG_MED, &quot;=
Failed to read certificate notBefore field.&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case X509_V_ERR_CERT_NOT_YET_VALID:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;WARNIN=
G: Your certificate is not yet valid!&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        case X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_DEBUG_MED, &=
quot;Failed to read certificate notAfter field.&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        case X509_V_ERR_CERT_HAS_EXPIRED:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;WARNING=
: Your certificate has expired!&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span> </span><br><span> void</span><br><span> tls_ctx_load_dh_params(s=
truct tls_root_ctx *ctx, const char *dh_file, bool dh_file_inline)</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1595?usp=3Demail">change 1595</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1595?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25=
ded81f0f5ddd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1595 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--xDttFaRT8hA=--

