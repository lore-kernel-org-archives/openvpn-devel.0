From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Mar 2026 14:43:39 +0000
In-Reply-To: <gerrit.1773754326000.I74841d3611c62d3c59fc839bc73a0c83ce025262@...2715...>
References: <gerrit.1773754326000.I74841d3611c62d3c59fc839bc73a0c83ce025262@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ceffeb59c00e6bf76fa5c42d088f862026bdca2f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZpGrDZm4eZw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZpGrDZm4eZw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
1 file changed, 5 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1579/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--ZpGrDZm4eZw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Do not support tls_ctx_set_c=
ert_profile on AWS-LC<br><br>SSL_CTX_set_security_level does nothing on AWS=
-LC and gives a deprecated<br>warning on compile. It is better to give the =
user a warning than to<br>effectively silently ignore it as well.<br><br>Ch=
ange-Id: I74841d3611c62d3c59fc839bc73a0c83ce025262<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 f=
ile changed, 5 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1579/2</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><=
br><span>index 48cbaa8..a26663a 100644</span><br><span>--- a/src/openvpn/ss=
l_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span=
>@@ -518,8 +518,9 @@</span><br><span> void</span><br><span> tls_ctx_set_cer=
t_profile(struct tls_root_ctx *ctx, const char *profile)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_N=
UMBER &gt; 0x10100000L \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NU=
MBER &gt; 0x3060000fL)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L                             =
               \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER &=
gt; 0x3060000fL) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &amp;&amp; !defined(OPENSSL_IS_AWSLC)</span><br><span>     /* OpenSSL do=
es not have certificate profiles, but a complex set of</span><br><span>    =
  * callbacks that we could try to implement to achieve something similar.<=
/span><br><span>      * For now, use OpenSSL&#39;s security levels to achie=
ve similar (but not equal)</span><br><span>@@ -549,8 +550,8 @@</span><br><s=
pan>     if (profile)</span><br><span>     {</span><br><span>         msg(M=
_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &qu=
ot;WARNING: OpenSSL 1.1.0 and LibreSSL do not support &quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            &quot;--tls-cert-profile=
, ignoring user-set profile: &#39;%s&#39;&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;WARNING: OpenSSL 1.1.0, AWS-=
LC and LibreSSL &lt; 3.6.0 do not &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;support --tls-cert-profile, ignoring=
 user-set profile: &#39;%s&#39;&quot;,</span><br><span>             profile=
);</span><br><span>     }</span><br><span> #endif /* if OPENSSL_VERSION_NUM=
BER &gt; 0x10100000L */</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail">change 1=
579</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74841d3611c62d3c59fc839bc73=
a0c83ce025262 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1579 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--ZpGrDZm4eZw=--

