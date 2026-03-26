From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 26 Mar 2026 14:10:52 +0000
In-Reply-To: <gerrit.1773754326000.I74841d3611c62d3c59fc839bc73a0c83ce025262@...2715...>
References: <gerrit.1773754326000.I74841d3611c62d3c59fc839bc73a0c83ce025262@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <534dd5f6f3953b3327d96623dc6f9ee1f9209223-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QuM2+NFQXhE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QuM2+NFQXhE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Do not support tls_ctx_set_cert_profile on AWS-LC
......................................................................

Do not support tls_ctx_set_cert_profile on AWS-LC

SSL_CTX_set_security_level does nothing on AWS-LC and gives a deprecated
warning on compile. It is better to give the user a warning than to
effectively silently ignore it as well.

Change-Id: I74841d3611c62d3c59fc839bc73a0c83ce025262
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1579
Message-Id: <20260322111207.8346-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
243.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 5 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1579/3

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 48cbaa8..a26663a 100644
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
@@ -549,8 +550,8 @@
     if (profile)
     {
         msg(M_WARN,
-            "WARNING: OpenSSL 1.1.0 and LibreSSL do not support "
-            "--tls-cert-profile, ignoring user-set profile: '%s'",
+            "WARNING: OpenSSL 1.1.0, AWS-LC and LibreSSL < 3.6.0 do not "
+            "support --tls-cert-profile, ignoring user-set profile: '%s'",
             profile);
     }
 #endif /* if OPENSSL_VERSION_NUMBER > 0x10100000L */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74841d3611c62d3c59fc839bc73a0c83ce025262
Gerrit-Change-Number: 1579
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QuM2+NFQXhE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Do not support tls_ctx_set_c=
ert_profile on AWS-LC<br><br>SSL_CTX_set_security_level does nothing on AWS=
-LC and gives a deprecated<br>warning on compile. It is better to give the =
user a warning than to<br>effectively silently ignore it as well.<br><br>Ch=
ange-Id: I74841d3611c62d3c59fc839bc73a0c83ce025262<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1579<br>M=
essage-Id: &lt;20260322111207.8346-1-gert@...1296...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36243.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ss=
l_openssl.c<br>1 file changed, 5 insertions(+), 4 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/79/1579/3</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl=
_openssl.c</span><br><span>index 48cbaa8..a26663a 100644</span><br><span>--=
- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl=
.c</span><br><span>@@ -518,8 +518,9 @@</span><br><span> void</span><br><spa=
n> tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 OPENSSL_VERSION_NUMBER &gt; 0x10100000L \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || L=
IBRESSL_VERSION_NUMBER &gt; 0x3060000fL)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L           =
                                 \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESS=
L_VERSION_NUMBER &gt; 0x3060000fL) \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &amp;&amp; !defined(OPENSSL_IS_AWSLC)</span><br><span>=
     /* OpenSSL does not have certificate profiles, but a complex set of</s=
pan><br><span>      * callbacks that we could try to implement to achieve s=
omething similar.</span><br><span>      * For now, use OpenSSL&#39;s securi=
ty levels to achieve similar (but not equal)</span><br><span>@@ -549,8 +550=
,8 @@</span><br><span>     if (profile)</span><br><span>     {</span><br><s=
pan>         msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            &quot;WARNING: OpenSSL 1.1.0 and LibreSSL do not support &qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;=
--tls-cert-profile, ignoring user-set profile: &#39;%s&#39;&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;WARNING: O=
penSSL 1.1.0, AWS-LC and LibreSSL &lt; 3.6.0 do not &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;support --tls-cert=
-profile, ignoring user-set profile: &#39;%s&#39;&quot;,</span><br><span>  =
           profile);</span><br><span>     }</span><br><span> #endif /* if O=
PENSSL_VERSION_NUMBER &gt; 0x10100000L */</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=
=3Demail">change 1579</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74841d3611c62d3c59fc839bc73=
a0c83ce025262 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1579 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--QuM2+NFQXhE=--

