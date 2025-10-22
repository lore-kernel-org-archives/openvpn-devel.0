From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 22 Oct 2025 16:44:15 +0000
References: <gerrit.1761151453000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <eeb11e65c48bccee5d98b850de12852823ce1b82-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hpH1jaA4vJg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not try to use
 the encrypt-then-mac ciphers from OpenSSL 3.6.0
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

--hpH1jaA4vJg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Demail

to review the following change.


Change subject: Do not try to use the encrypt-then-mac ciphers from OpenSSL=
 3.6.0
......................................................................

Do not try to use the encrypt-then-mac ciphers from OpenSSL 3.6.0

These ciphers claim to be CBC but since they are also include an HMAC
are more a mix of AEAD and CBC. Nevertheless, we do not support these
and also have no (good) reason to support them.

Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 5 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1294/1

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 7688add..04aefa2 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -789,7 +789,11 @@
 #ifdef EVP_CIPH_FLAG_CTS
                    && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_CTS)
 #endif
-                   && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPH=
ER));
+                   && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPH=
ER)
+#ifdef EVP_CIPH_FLAG_ENC_THEN_MAC
+                   && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_ENC_THEN_=
MAC)
+#endif
+               );
     EVP_CIPHER_free(cipher);
     return ret;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d
Gerrit-Change-Number: 1294
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--hpH1jaA4vJg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Do not try to use the encrypt-then-mac ciph=
ers from OpenSSL 3.6.0<br><br>These ciphers claim to be CBC but since they =
are also include an HMAC<br>are more a mix of AEAD and CBC. Nevertheless, w=
e do not support these<br>and also have no (good) reason to support them.<b=
r><br>Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d<br>Signed-off-by=
: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto_opens=
sl.c<br>1 file changed, 5 insertions(+), 1 deletion(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1294=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_o=
penssl.c</span><br><span>index 7688add..04aefa2 100644</span><br><span>--- =
a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_ope=
nssl.c</span><br><span>@@ -789,7 +789,11 @@</span><br><span> #ifdef EVP_CIP=
H_FLAG_CTS</span><br><span>                    &amp;&amp; !(EVP_CIPHER_flag=
s(cipher) &amp; EVP_CIPH_FLAG_CTS)</span><br><span> #endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                   &amp;&amp; !(EVP_CI=
PHER_flags(cipher) &amp; EVP_CIPH_FLAG_AEAD_CIPHER));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   &amp;&amp; !(EVP_CIPHE=
R_flags(cipher) &amp; EVP_CIPH_FLAG_AEAD_CIPHER)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifdef EVP_CIPH_FLAG_ENC_THEN_MAC</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                   &amp;&amp; !(=
EVP_CIPHER_flags(cipher) &amp; EVP_CIPH_FLAG_ENC_THEN_MAC)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+               );</span><br><span>     EVP_CIPHER=
_free(cipher);</span><br><span>     return ret;</span><br><span> }</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1294?usp=3Demail">change 1294</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1294?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafe3c94b952cd3fbecf6f3d0581=
6e5859f425e7d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1294 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--hpH1jaA4vJg=--

