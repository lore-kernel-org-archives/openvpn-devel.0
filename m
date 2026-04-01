From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 1 Apr 2026 11:56:52 +0000
In-Reply-To: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
References: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <c0869b00523eb0ad05e8b4aa02d1785d4a8d4552-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qVdfXns1sFo="; charset=UTF-8
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

--qVdfXns1sFo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
1 file changed, 53 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1595/3

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a26663a..fca1d73 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -615,6 +615,7 @@
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 }

+#if OPENSSL_VERSION_NUMBER < 0x40000000L
 void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
@@ -650,6 +651,58 @@
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
+    if (error =3D=3D X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD)
+    {
+        msg(D_TLS_DEBUG_MED, "Failed to read certificate notBefore field."=
);
+    }
+    if (error =3D=3D X509_V_ERR_CERT_NOT_YET_VALID)
+    {
+        msg(M_WARN, "WARNING: Your certificate is not yet valid!");
+    }
+    if (error =3D=3D X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD)
+    {
+        msg(D_TLS_DEBUG_MED, "Failed to read certificate notAfter field.");
+    }
+    if (error =3D=3D X509_V_ERR_CERT_HAS_EXPIRED)
+    {
+        msg(M_WARN, "WARNING: Your certificate has expired!");
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--qVdfXns1sFo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">OpenSSL 4.0: Use X509_check_=
certificate_times instead of X509_cmp_time<br><br>The X509_cmp_time functio=
n is deprecated in OpenSSL 4.0. So we avoid it and<br>use the new API.<br><=
br>Change-Id: I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5<br>Signed-off-by: A=
rne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<b=
r>1 file changed, 53 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1595/3<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<=
/span><br><span>index a26663a..fca1d73 100644</span><br><span>--- a/src/ope=
nvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><b=
r><span>@@ -615,6 +615,7 @@</span><br><span> #endif /* if OPENSSL_VERSION_N=
UMBER &lt; 0x30000000L */</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt; =
0x40000000L</span><br><span> void</span><br><span> tls_ctx_check_cert_time(=
const struct tls_root_ctx *ctx)</span><br><span> {</span><br><span>@@ -650,=
6 +651,58 @@</span><br><span>         msg(M_WARN, &quot;WARNING: Your certi=
ficate has expired!&quot;);</span><br><span>     }</span><br><span> }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+tls_ctx_check_cert_time(const struct tls_root_ctx *ctx=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const X509 *cert;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    cert =3D SSL_CTX_get0_certificate(ctx-&gt;ctx);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (cert =3D=3D NULL)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return; /* Nothing to check if there is n=
o certificate */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    X509_VERIFY_PARAM *vpm =3D X509_=
VERIFY_PARAM_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vpm =3D=3D =
NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TLS_DEBUG_MED,=
 &quot;Failed to initialise certificate verification parameters.&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    X509_VERIFY_PARAM_set_flags(vpm, X509_V_FLAG_USE_CHECK_=
TIME);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    X509_VERI=
FY_PARAM_set_time(vpm, now);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int er=
ror =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int r=
et =3D X509_check_certificate_times(vpm, cert, &amp;error);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    X509_VERIFY_PARAM_free(vpm);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D 1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error =
=3D=3D X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(D_TLS_DEBUG_MED, &quot;Failed to read certifica=
te notBefore field.&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (error =3D=3D X509_V_ERR_CERT_NOT_YET_VALID)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_WARN, &quot;WARNING: Your certificate is not yet =
valid!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error =3D=
=3D X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(D_TLS_DEBUG_MED, &quot;Failed to read certificate n=
otAfter field.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err=
or =3D=3D X509_V_ERR_CERT_HAS_EXPIRED)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_WARN, &quot;WARNING: Your certificate has expired!&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> void</s=
pan><br><span> tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char =
*dh_file, bool dh_file_inline)</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail">c=
hange 1595</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25=
ded81f0f5ddd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1595 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--qVdfXns1sFo=--

