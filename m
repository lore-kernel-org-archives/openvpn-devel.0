From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 23 Oct 2025 11:20:00 +0000
References: <gerrit.1761218398000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1998de8c8fe98084639ba7332643497be72e4501-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YlnTCB11+lA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Do not try to
 use the encrypt-then-mac ciphers from OpenSSL 3.6.0
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

--YlnTCB11+lA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1295?usp=3Demail

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
M src/openvpn/openssl_compat.h
2 files changed, 7 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1295/1

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 331af99..280389c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -798,7 +798,8 @@
 #ifdef EVP_CIPH_FLAG_CTS
                           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_CT=
S)
 #endif
-                          && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AE=
AD_CIPHER));
+                          && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AE=
AD_CIPHER)
+                          && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_EN=
C_THEN_MAC));
     EVP_CIPHER_free(cipher);
     return ret;
 }
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index c9fa719..03ece13 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -817,4 +817,9 @@

 #endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */

+/* Introduced in OpenSSL 3.6.0 */
+#ifndef EVP_CIPH_FLAG_ENC_THEN_MAC
+#define EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000000
+#endif
+
 #endif /* OPENSSL_COMPAT_H_ */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1295?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d
Gerrit-Change-Number: 1295
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--YlnTCB11+lA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1295?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Do not try to use the encrypt-then-mac ciph=
ers from OpenSSL 3.6.0<br><br>These ciphers claim to be CBC but since they =
are also include an HMAC<br>are more a mix of AEAD and CBC. Nevertheless, w=
e do not support these<br>and also have no (good) reason to support them.<b=
r><br>Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d<br>Signed-off-by=
: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto_opens=
sl.c<br>M src/openvpn/openssl_compat.h<br>2 files changed, 7 insertions(+),=
 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/95/1295/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cryp=
to_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index 331af99..=
280389c 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c</span><br=
><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -798,7 +798,8 =
@@</span><br><span> #ifdef EVP_CIPH_FLAG_CTS</span><br><span>              =
             &amp;&amp; !(EVP_CIPHER_flags(cipher) &amp; EVP_CIPH_FLAG_CTS)=
</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                          &amp;&amp; !(EVP_CIPHER_flags(cipher) &amp; EV=
P_CIPH_FLAG_AEAD_CIPHER));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                          &amp;&amp; !(EVP_CIPHER_flags(cipher) &amp=
; EVP_CIPH_FLAG_AEAD_CIPHER)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                          &amp;&amp; !(EVP_CIPHER_flags(cipher) &a=
mp; EVP_CIPH_FLAG_ENC_THEN_MAC));</span><br><span>     EVP_CIPHER_free(ciph=
er);</span><br><span>     return ret;</span><br><span> }</span><br><span>di=
ff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h</spa=
n><br><span>index c9fa719..03ece13 100644</span><br><span>--- a/src/openvpn=
/openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl_compat.h</span>=
<br><span>@@ -817,4 +817,9 @@</span><br><span> </span><br><span> #endif /* =
OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Introduced in OpenSSL 3.6.0 */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef EVP_CIPH_FLA=
G_ENC_THEN_MAC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000000</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #endif /* OPENSSL_COMPAT_H_ */</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1295?usp=3Demail">change 1295</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1295?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafe3c94b952cd3fbecf6f3d0581=
6e5859f425e7d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1295 </div>
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

--YlnTCB11+lA=--

