From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 18 Apr 2026 18:33:04 +0000
In-Reply-To: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
References: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, matthias.andree@...68...,
 frank@...2641...
Message-ID: <43680f83a6ddf7f04fbe4b30384e786edec8cb85-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VrjwDFFRKTo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, mandree <matthias.andree@...68...>

--VrjwDFFRKTo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: OpenSSL 4.0: Use X509_check_certificate_times instead of X5=
09_cmp_time
......................................................................

OpenSSL 4.0: Use X509_check_certificate_times instead of X509_cmp_time

The X509_cmp_time function is deprecated in OpenSSL 4.0. So we avoid it and
use the new API.

Change-Id: I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1595
Message-Id: <20260417164644.17897-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
651.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 55 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1595/6

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
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: mandree <matthias.andree@...68...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VrjwDFFRKTo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">OpenSSL 4.0: Use X509_check_certifi=
cate_times instead of X509_cmp_time<br><br>The X509_cmp_time function is de=
precated in OpenSSL 4.0. So we avoid it and<br>use the new API.<br><br>Chan=
ge-Id: I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5<br>Signed-off-by: Arne Sch=
wabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1595<br>Message-I=
d: &lt;20260417164644.17897-1-gert@...1296...&gt;<br>URL: https://www.mail-=
archive.com/openvpn-devel@lists.sourceforge.net/msg36651.html<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_opens=
sl.c<br>1 file changed, 55 insertions(+), 0 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/15=
95/6</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_opens=
sl.c</span><br><span>index efe5b5b..6130dc3 100644</span><br><span>--- a/sr=
c/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</sp=
an><br><span>@@ -634,6 +634,7 @@</span><br><span> #endif /* if OPENSSL_VERS=
ION_NUMBER &lt; 0x30000000L */</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER =
&lt; 0x40000000L</span><br><span> void</span><br><span> tls_ctx_check_cert_=
time(const struct tls_root_ctx *ctx)</span><br><span> {</span><br><span>@@ =
-669,6 +670,60 @@</span><br><span>         msg(M_WARN, &quot;WARNING: Your =
certificate has expired!&quot;);</span><br><span>     }</span><br><span> }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+tls_ctx_check_cert_time(const struct tls_root_ctx=
 *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const X509 *cert;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ctx);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    cert =3D SSL_CTX_get0_certificate(ctx-&gt;ctx);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (cert =3D=3D NULL)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return; /* Nothing to check if there i=
s no certificate */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    X509_VERIFY_PARAM *vpm =3D X5=
09_VERIFY_PARAM_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vpm =3D=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TLS_DEBUG_=
MED, &quot;Failed to initialise certificate verification parameters.&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    X509_VERIFY_PARAM_set_flags(vpm, X509_V_FLAG_USE_CH=
ECK_TIME);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    X509_=
VERIFY_PARAM_set_time(vpm, now);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t error =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt ret =3D X509_check_certificate_times(vpm, cert, &amp;error);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    X509_VERIFY_PARAM_free(vpm)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D 1)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch =
(error)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        case X509_V_ERR_ER=
ROR_IN_CERT_NOT_BEFORE_FIELD:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(D_TLS_DEBUG_MED, &quot;Failed to read certificate=
 notBefore field.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case X=
509_V_ERR_CERT_NOT_YET_VALID:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(M_WARN, &quot;WARNING: Your certificate is not ye=
t valid!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        case X509_V_ERR=
_ERROR_IN_CERT_NOT_AFTER_FIELD:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_TLS_DEBUG_MED, &quot;Failed to read certifica=
te notAfter field.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case =
X509_V_ERR_CERT_HAS_EXPIRED:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(M_WARN, &quot;WARNING: Your certificate has expire=
d!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
 void</span><br><span> tls_ctx_load_dh_params(struct tls_root_ctx *ctx, con=
st char *dh_file, bool dh_file_inline)</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3D=
email">change 1595</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25=
ded81f0f5ddd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1595 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: mandree &lt;matthias.andree@...2908...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--VrjwDFFRKTo=--

