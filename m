From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 23 Oct 2025 15:50:51 +0000
In-Reply-To: <gerrit.1761218398000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
References: <gerrit.1761218398000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a9dcdb452f702e323b61b4a882ac8e5d60520d6f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X+07Hp0b+qQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X+07Hp0b+qQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1295?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Do not try to use the encrypt-then-mac ciphers from OpenSSL=
 3.6.0
......................................................................

Do not try to use the encrypt-then-mac ciphers from OpenSSL 3.6.0

These ciphers claim to be CBC but since they are also include an HMAC
are more a mix of AEAD and CBC. Nevertheless, we do not support these
and also have no (good) reason to support them.

Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1295
Message-Id: <20251023153514.18691-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
849.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_openssl.c
M src/openvpn/openssl_compat.h
2 files changed, 7 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1295/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d
Gerrit-Change-Number: 1295
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X+07Hp0b+qQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1295?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Do not try to use the encrypt-then-=
mac ciphers from OpenSSL 3.6.0<br><br>These ciphers claim to be CBC but sin=
ce they are also include an HMAC<br>are more a mix of AEAD and CBC. Neverth=
eless, we do not support these<br>and also have no (good) reason to support=
 them.<br><br>Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d<br>Signe=
d-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &l=
t;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+=
/1295<br>Message-Id: &lt;20251023153514.18691-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33849.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src=
/openvpn/crypto_openssl.c<br>M src/openvpn/openssl_compat.h<br>2 files chan=
ged, 7 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/95/1295/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br=
><span>index 331af99..280389c 100644</span><br><span>--- a/src/openvpn/cryp=
to_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><=
span>@@ -798,7 +798,8 @@</span><br><span> #ifdef EVP_CIPH_FLAG_CTS</span><b=
r><span>                           &amp;&amp; !(EVP_CIPHER_flags(cipher) &a=
mp; EVP_CIPH_FLAG_CTS)</span><br><span> #endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                          &amp;&amp; !(EVP_CIPHER_=
flags(cipher) &amp; EVP_CIPH_FLAG_AEAD_CIPHER));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                          &amp;&amp; !(EVP_CIP=
HER_flags(cipher) &amp; EVP_CIPH_FLAG_AEAD_CIPHER)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                          &amp;&amp; !(EVP_C=
IPHER_flags(cipher) &amp; EVP_CIPH_FLAG_ENC_THEN_MAC));</span><br><span>   =
  EVP_CIPHER_free(cipher);</span><br><span>     return ret;</span><br><span=
> }</span><br><span>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn=
/openssl_compat.h</span><br><span>index c9fa719..03ece13 100644</span><br><=
span>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/o=
penssl_compat.h</span><br><span>@@ -817,4 +817,9 @@</span><br><span> </span=
><br><span> #endif /* OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Introduce=
d in OpenSSL 3.6.0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifndef EVP_CIPH_FLAG_ENC_THEN_MAC</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000000</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OPENSSL_COMPAT_H_=
 */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1295?usp=3Demail">change 1295</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1295?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafe3c94b952cd3fbecf6f3d0581=
6e5859f425e7d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1295 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--X+07Hp0b+qQ=--

