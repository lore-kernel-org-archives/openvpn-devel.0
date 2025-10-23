From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 23 Oct 2025 09:56:04 +0000
In-Reply-To: <gerrit.1761151453000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
References: <gerrit.1761151453000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <19ac9f045dc72c1baa4f968b59f1c66a3b4930a3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LDGdSUlpdqE="; charset=UTF-8
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

--LDGdSUlpdqE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Demail

to look at the new patch set (#3).


Change subject: Do not try to use the encrypt-then-mac ciphers from OpenSSL=
 3.6.0
......................................................................

Do not try to use the encrypt-then-mac ciphers from OpenSSL 3.6.0

These ciphers claim to be CBC but since they are also include an HMAC
are more a mix of AEAD and CBC. Nevertheless, we do not support these
and also have no (good) reason to support them.

This patch defines the flag if the SSL library does not define the flag
to also work when the SSL library is upgraded after OpenVPN has been compil=
ed.

Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
M src/openvpn/openssl_compat.h
2 files changed, 7 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1294/3

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 7688add..f596b8c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -789,7 +789,8 @@
 #ifdef EVP_CIPH_FLAG_CTS
                    && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_CTS)
 #endif
-                   && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPH=
ER));
+                   && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPH=
ER)
+                   && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_ENC_THEN_=
MAC));
     EVP_CIPHER_free(cipher);
     return ret;
 }
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index e3e7cf8..fb3c9b1 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -211,4 +211,9 @@
 #endif
 #endif

+/* Introduced in OpenSSL 3.6.0 */
+#ifndef EVP_CIPH_FLAG_ENC_THEN_MAC
+#define EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000000
+#endif
+
 #endif /* OPENSSL_COMPAT_H_ */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d
Gerrit-Change-Number: 1294
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--LDGdSUlpdqE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Do not try to use the encrypt-then-mac ciphers from=
 OpenSSL 3.6.0<br><br>These ciphers claim to be CBC but since they are also=
 include an HMAC<br>are more a mix of AEAD and CBC. Nevertheless, we do not=
 support these<br>and also have no (good) reason to support them.<br><br>Th=
is patch defines the flag if the SSL library does not define the flag<br>to=
 also work when the SSL library is upgraded after OpenVPN has been compiled=
.<br><br>Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d<br>Signed-off=
-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto_op=
enssl.c<br>M src/openvpn/openssl_compat.h<br>2 files changed, 7 insertions(=
+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/94/1294/3</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/c=
rypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index 7688ad=
d..f596b8c 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c</span>=
<br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -789,7 +789=
,8 @@</span><br><span> #ifdef EVP_CIPH_FLAG_CTS</span><br><span>           =
         &amp;&amp; !(EVP_CIPHER_flags(cipher) &amp; EVP_CIPH_FLAG_CTS)</sp=
an><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                  &amp;&amp; !(EVP_CIPHER_flags(cipher) &amp; EVP_CIPH_FLAG=
_AEAD_CIPHER));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
               &amp;&amp; !(EVP_CIPHER_flags(cipher) &amp; EVP_CIPH_FLAG_AE=
AD_CIPHER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
          &amp;&amp; !(EVP_CIPHER_flags(cipher) &amp; EVP_CIPH_FLAG_ENC_THE=
N_MAC));</span><br><span>     EVP_CIPHER_free(cipher);</span><br><span>    =
 return ret;</span><br><span> }</span><br><span>diff --git a/src/openvpn/op=
enssl_compat.h b/src/openvpn/openssl_compat.h</span><br><span>index e3e7cf8=
..fb3c9b1 100644</span><br><span>--- a/src/openvpn/openssl_compat.h</span><=
br><span>+++ b/src/openvpn/openssl_compat.h</span><br><span>@@ -211,4 +211,=
9 @@</span><br><span> #endif</span><br><span> #endif</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Introduced in OpenSSL=
 3.6.0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef EV=
P_CIPH_FLAG_ENC_THEN_MAC</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000000</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> #endif /* OPENSSL_COMPAT_H_ */</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1294?usp=3Demail">change 1294</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1294?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafe3c94b952cd3fbecf6f3d0581=
6e5859f425e7d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1294 </div>
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

--LDGdSUlpdqE=--

