From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 16:59:40 +0000
References: <gerrit.1765213173000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b4885436fa38e90e43fa9afd2216a56522867803-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XijyYJZ94r4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: configure: Try
 to use pkg-config to detect mbedTLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XijyYJZ94r4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, uddr.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1422?usp=3Demail

to review the following change.


Change subject: configure: Try to use pkg-config to detect mbedTLS
......................................................................

configure: Try to use pkg-config to detect mbedTLS

mbedTLS does not seem to have pkg-config support on e.g.
Debian/Ubuntu, so we definitely need to keep the
fallback check as well.

Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20240906160510.76387-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
090.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit c829f57096cb6951aa4698eff388aeebf9310334)
---
M configure.ac
1 file changed, 14 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1422/1

diff --git a/configure.ac b/configure.ac
index bf252c9..307329d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1010,14 +1010,21 @@

 	if test -z "${MBEDTLS_CFLAGS}" -a -z "${MBEDTLS_LIBS}"; then
 		# if the user did not explicitly specify flags, try to autodetect
-		LIBS=3D"${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto"
-		AC_CHECK_LIB(
-			[mbedtls],
-			[mbedtls_ssl_init],
-			[MBEDTLS_LIBS=3D"-lmbedtls -lmbedx509 -lmbedcrypto"],
-			[AC_MSG_ERROR([Could not find mbed TLS.])],
-			[${PKCS11_HELPER_LIBS}]
+		PKG_CHECK_MODULES([MBEDTLS],
+			[mbedtls >=3D 2.0.0 mbedx509 >=3D 2.0.0 mbedcrypto >=3D 2.0.0],
+			[have_mbedtls=3D"yes"],
+			[LIBS=3D"${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto"]
 		)
+		# mbedtls might not have pkgconfig integration, so try manually
+                if test "${have_mbedtls}" !=3D "yes"; then
+			AC_CHECK_LIB(
+				[mbedtls],
+				[mbedtls_ssl_init],
+				[MBEDTLS_LIBS=3D"-lmbedtls -lmbedx509 -lmbedcrypto"],
+				[AC_MSG_ERROR([Could not find mbed TLS.])],
+				[${PKCS11_HELPER_LIBS}]
+			)
+		fi
 	fi

 	CFLAGS=3D"${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1422?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692
Gerrit-Change-Number: 1422
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: uddr <yura.uddr@...277...>

--XijyYJZ94r4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, uddr. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1422?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">configure: Try to use pkg-config to detect =
mbedTLS<br><br>mbedTLS does not seem to have pkg-config support on e.g.<br>=
Debian/Ubuntu, so we definitely need to keep the<br>fallback check as well.=
<br><br>Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt =
&lt;yura.uddr@...277...&gt;<br>Message-Id: &lt;20240906160510.76387-1-frank=
@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg29090.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>(cherry picked from commit c829f57096cb6951aa4698eff388aeebf9310=
334)<br>---<br>M configure.ac<br>1 file changed, 14 insertions(+), 7 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/22/1422/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/configure.ac b/configure=
.ac</span><br><span>index bf252c9..307329d 100644</span><br><span>--- a/con=
figure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -1010,14 +1=
010,21 @@</span><br><span> </span><br><span> 	if test -z &quot;${MBEDTLS_CF=
LAGS}&quot; -a -z &quot;${MBEDTLS_LIBS}&quot;; then</span><br><span> 		# if=
 the user did not explicitly specify flags, try to autodetect</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-		LIBS=3D&quot;${LIBS} -lmbedtls -l=
mbedx509 -lmbedcrypto&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-		AC_CHECK_LIB(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
			[mbedtls],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[mbed=
tls_ssl_init],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[MBE=
DTLS_LIBS=3D&quot;-lmbedtls -lmbedx509 -lmbedcrypto&quot;],</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-			[AC_MSG_ERROR([Could not find mbed=
 TLS.])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[${PKCS11=
_HELPER_LIBS}]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		PKG=
_CHECK_MODULES([MBEDTLS],</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+			[mbedtls &gt;=3D 2.0.0 mbedx509 &gt;=3D 2.0.0 mbedcrypto &gt;=3D 2=
.0.0],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[have_mbed=
tls=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+			[LIBS=3D&quot;${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto&quot;]</span=
><br><span> 		)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		# =
mbedtls might not have pkgconfig integration, so try manually</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                if test &quot;${h=
ave_mbedtls}&quot; !=3D &quot;yes&quot;; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+			AC_CHECK_LIB(</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+				[mbedtls],</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+				[mbedtls_ssl_init],</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+				[MBEDTLS_LIBS=3D&quot;-lmbedtls -lmbedx509 -lmbed=
crypto&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				[=
AC_MSG_ERROR([Could not find mbed TLS.])],</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+				[${PKCS11_HELPER_LIBS}]</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+			)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+		fi</span><br><span> 	fi</span><br><span> </span><br><span=
> 	CFLAGS=3D&quot;${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}&quot;=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1422?usp=3Demail">change 1422</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1422?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d0da76018e874cda5dbab9202a=
2b817ad5e4692 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1422 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: uddr &lt;yura.uddr@...277...=
&gt; </div>

</body></html>=

--XijyYJZ94r4=--

