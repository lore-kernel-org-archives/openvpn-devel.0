From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 16:24:11 +0000
References: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <70e28daf56d1fcb316441e97fce373c520a03cd8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WC40ZAsGVuQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: OpenSSL 4.0: Use
 X509_check_certificate_times instead of X509_cmp_time
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WC40ZAsGVuQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1595?usp=3Demail )


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
1 file changed, 47 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1595/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c8dd55a..4650b85 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -634,6 +634,7 @@
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 }

+#if OPENSSL_VERSION_NUMBER < 0x40000000L
 void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
@@ -669,6 +670,52 @@
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
+    }
+
+    X509_VERIFY_PARAM_set_flags(vpm, X509_V_FLAG_USE_CHECK_TIME);
+    X509_VERIFY_PARAM_set_time(vpm, now);
+
+    int error =3D 0;
+    int ret =3D X509_check_certificate_times(vpm, cert, &error);
+
+    if (error =3D=3D X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD)
+    {
+        msg(D_TLS_DEBUG_MED, "Failed to read certificate notBefore field."=
);
+    }
+    if (error =3D=3D X509_V_ERR_CERT_NOT_YET_VALID)
+    {
+        msg(M_WARN, "WARNING: Your certificate is not yet valid!");
+    }
+    if (ret =3D=3D X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD)
+    {
+        msg(D_TLS_DEBUG_MED, "Failed to read certificate notAfter field.");
+    }
+    if (error =3D=3D X509_V_ERR_CERT_HAS_EXPIRED)
+    {
+        msg(M_WARN, "WARNING: Your certificate has expired!");
+    }
+    X509_VERIFY_PARAM_free(vpm);
+}
+#endif

 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file, bool=
 dh_file_inline)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5
Gerrit-Change-Number: 1595
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WC40ZAsGVuQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1595?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">OpenSSL 4.0: Use X509_check_certificate_times instead of X509_cmp_time<=
br><br>The X509_cmp_time function is deprecated in OpenSSL 4.0. So we avoid=
 it and<br>use the new API.<br><br>Change-Id: I6c2eda0e5bbb3a70b404f821e25d=
ed81f0f5ddd5<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<=
br>M src/openvpn/ssl_openssl.c<br>1 file changed, 47 insertions(+), 0 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/95/1595/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl=
.c b/src/openvpn/ssl_openssl.c</span><br><span>index c8dd55a..4650b85 10064=
4</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src=
/openvpn/ssl_openssl.c</span><br><span>@@ -634,6 +634,7 @@</span><br><span>=
 #endif /* if OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if OPENSSL_VERSION_NUMBER &lt; 0x40000000L</span><br><span> void</span><br>=
<span> tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)</span><br><s=
pan> {</span><br><span>@@ -669,6 +670,52 @@</span><br><span>         msg(M_=
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
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    X509_VERIFY_PARAM_set_=
flags(vpm, X509_V_FLAG_USE_CHECK_TIME);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    X509_VERIFY_PARAM_set_time(vpm, now);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int error =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int ret =3D X509_check_certificate_times(vpm, c=
ert, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error =3D=3D =
X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_TLS_DEBUG_MED, &quot;Failed to read certificate notB=
efore field.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error=
 =3D=3D X509_V_ERR_CERT_NOT_YET_VALID)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_WARN, &quot;WARNING: Your certificate is not yet valid!&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D X509_V_=
ERR_ERROR_IN_CERT_NOT_AFTER_FIELD)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(D_TLS_DEBUG_MED, &quot;Failed to read certificate notAfter fie=
ld.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error =3D=3D X=
509_V_ERR_CERT_HAS_EXPIRED)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_WARN, &quot;WARNING: Your certificate has expired!&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    X509_VERIFY_PARAM_free(vpm);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> void=
</span><br><span> tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const ch=
ar *dh_file, bool dh_file_inline)</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail=
">change 1595</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25=
ded81f0f5ddd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1595 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--WC40ZAsGVuQ=--

