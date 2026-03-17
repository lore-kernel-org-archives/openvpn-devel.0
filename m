From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Mar 2026 13:32:12 +0000
References: <gerrit.1773754326000.I74841d3611c62d3c59fc839bc73a0c83ce025262@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <ac573f9442ad0d5429322d47fec73a5e116c9435-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XLAWINuGTS0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not support
 tls_ctx_set_cert_profile on AWS-LC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XLAWINuGTS0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1579?usp=3Demail )


Change subject: Do not support tls_ctx_set_cert_profile on AWS-LC
......................................................................

Do not support tls_ctx_set_cert_profile on AWS-LC

SSL_CTX_set_security_level does nothing on AWS-LC and gives a deprecated
warning on compile. It is better to give the user a warning than to
effectively silently ignore it as well.

Change-Id: I74841d3611c62d3c59fc839bc73a0c83ce025262
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 4 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1579/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 48cbaa8..66f3e91 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -518,8 +518,9 @@
 void
 tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 {
-#if OPENSSL_VERSION_NUMBER > 0x10100000L \
-    && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3=
060000fL)
+#if OPENSSL_VERSION_NUMBER > 0x10100000L                                  =
          \
+    && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3=
060000fL) \
+    && !defined(OPENSSL_IS_AWSLC)
     /* OpenSSL does not have certificate profiles, but a complex set of
      * callbacks that we could try to implement to achieve something simil=
ar.
      * For now, use OpenSSL's security levels to achieve similar (but not =
equal)
@@ -549,7 +550,7 @@
     if (profile)
     {
         msg(M_WARN,
-            "WARNING: OpenSSL 1.1.0 and LibreSSL do not support "
+            "WARNING: OpenSSL 1.1.0, aws-lc and LibreSSL do not support "
             "--tls-cert-profile, ignoring user-set profile: '%s'",
             profile);
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74841d3611c62d3c59fc839bc73a0c83ce025262
Gerrit-Change-Number: 1579
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XLAWINuGTS0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1579?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Do not support tls_ctx_set_cert_profile on AWS-LC<br><br>SSL_CTX_set_se=
curity_level does nothing on AWS-LC and gives a deprecated<br>warning on co=
mpile. It is better to give the user a warning than to<br>effectively silen=
tly ignore it as well.<br><br>Change-Id: I74841d3611c62d3c59fc839bc73a0c83c=
e025262<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M =
src/openvpn/ssl_openssl.c<br>1 file changed, 4 insertions(+), 3 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/79/1579/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/s=
rc/openvpn/ssl_openssl.c</span><br><span>index 48cbaa8..66f3e91 100644</spa=
n><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openv=
pn/ssl_openssl.c</span><br><span>@@ -518,8 +518,9 @@</span><br><span> void<=
/span><br><span> tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const c=
har *profile)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L \</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &amp;&amp; (!defined(LIBRESSL_VERSIO=
N_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3060000fL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &gt; 0x101000=
00L                                            \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &amp;&amp; (!defined(LIBRESSL_VERSION_NUMB=
ER) || LIBRESSL_VERSION_NUMBER &gt; 0x3060000fL) \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &amp;&amp; !defined(OPENSSL_IS_AWSLC)</s=
pan><br><span>     /* OpenSSL does not have certificate profiles, but a com=
plex set of</span><br><span>      * callbacks that we could try to implemen=
t to achieve something similar.</span><br><span>      * For now, use OpenSS=
L&#39;s security levels to achieve similar (but not equal)</span><br><span>=
@@ -549,7 +550,7 @@</span><br><span>     if (profile)</span><br><span>     =
{</span><br><span>         msg(M_WARN,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            &quot;WARNING: OpenSSL 1.1.0 and LibreSSL do n=
ot support &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;WARNING: OpenSSL 1.1.0, aws-lc and LibreSSL do not support =
&quot;</span><br><span>             &quot;--tls-cert-profile, ignoring user=
-set profile: &#39;%s&#39;&quot;,</span><br><span>             profile);</s=
pan><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail">change 1579=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74841d3611c62d3c59fc839bc73=
a0c83ce025262 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1579 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--XLAWINuGTS0=--

