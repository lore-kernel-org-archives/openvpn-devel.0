From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 23 Oct 2025 15:46:32 +0000
In-Reply-To: <gerrit.1761151453000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
References: <gerrit.1761151453000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <54bffb623efb046b20b4f289ec3fa5a0b35496e8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="73hfn+7Tiqg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--73hfn+7Tiqg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1294
Message-Id: <20251023111138.25245-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
846.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_openssl.c
M src/openvpn/openssl_compat.h
2 files changed, 7 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1294/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--73hfn+7Tiqg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Do not try to use the encryp=
t-then-mac ciphers from OpenSSL 3.6.0<br><br>These ciphers claim to be CBC =
but since they are also include an HMAC<br>are more a mix of AEAD and CBC. =
Nevertheless, we do not support these<br>and also have no (good) reason to =
support them.<br><br>This patch defines the flag if the SSL library does no=
t define the flag<br>to also work when the SSL library is upgraded after Op=
enVPN has been compiled.<br><br>Change-Id: Iafe3c94b952cd3fbecf6f3d05816e58=
59f425e7d<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-b=
y: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit=
.openvpn.net/c/openvpn/+/1294<br>Message-Id: &lt;20251023111138.25245-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg33846.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/openssl_=
compat.h<br>2 files changed, 7 insertions(+), 1 deletion(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94=
/1294/4</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/cry=
pto_openssl.c</span><br><span>index 7688add..f596b8c 100644</span><br><span=
>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypt=
o_openssl.c</span><br><span>@@ -789,7 +789,8 @@</span><br><span> #ifdef EVP=
_CIPH_FLAG_CTS</span><br><span>                    &amp;&amp; !(EVP_CIPHER_=
flags(cipher) &amp; EVP_CIPH_FLAG_CTS)</span><br><span> #endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                   &amp;&amp; !(EV=
P_CIPHER_flags(cipher) &amp; EVP_CIPH_FLAG_AEAD_CIPHER));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                   &amp;&amp; !(EVP_C=
IPHER_flags(cipher) &amp; EVP_CIPH_FLAG_AEAD_CIPHER)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   &amp;&amp; !(EVP_CIPHE=
R_flags(cipher) &amp; EVP_CIPH_FLAG_ENC_THEN_MAC));</span><br><span>     EV=
P_CIPHER_free(cipher);</span><br><span>     return ret;</span><br><span> }<=
/span><br><span>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/ope=
nssl_compat.h</span><br><span>index e3e7cf8..fb3c9b1 100644</span><br><span=
>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/opens=
sl_compat.h</span><br><span>@@ -211,4 +211,9 @@</span><br><span> #endif</sp=
an><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Introduced in OpenSSL 3.6.0 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef EVP_CIPH_FLAG_ENC_THEN_MAC</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define EVP_CIPH_FLAG_ENC_=
THEN_MAC 0x10000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> #endif /* OPENSSL_COMPAT_H_ */</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Dema=
il">change 1294</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1294?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafe3c94b952cd3fbecf6f3d0581=
6e5859f425e7d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1294 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--73hfn+7Tiqg=--

