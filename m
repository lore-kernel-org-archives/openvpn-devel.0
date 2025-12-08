From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 21:38:40 +0000
In-Reply-To: <gerrit.1765213173000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
References: <gerrit.1765213173000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <49eb1d8f53492f2446fbca33aa80a3d073663177-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IIbFF1D3EYw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IIbFF1D3EYw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1422?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1422
(cherry picked from commit c829f57096cb6951aa4698eff388aeebf9310334)
Message-Id: <20251208194151.17419-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
911.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
1 file changed, 14 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1422/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692
Gerrit-Change-Number: 1422
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IIbFF1D3EYw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1422?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">configure: Try to use pkg-config to=
 detect mbedTLS<br><br>mbedTLS does not seem to have pkg-config support on =
e.g.<br>Debian/Ubuntu, so we definitely need to keep the<br>fallback check =
as well.<br><br>Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy D=
arnobyt &lt;yura.uddr@...277...&gt;<br>Message-Id: &lt;20240906160510.76387=
-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg29090.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit=
 URL: https://gerrit.openvpn.net/c/openvpn/+/1422<br>(cherry picked from co=
mmit c829f57096cb6951aa4698eff388aeebf9310334)<br>Message-Id: &lt;202512081=
94151.17419-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg34911.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M configure.ac<br>1 file changed, 14 in=
sertions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/22/1422/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/con=
figure.ac b/configure.ac</span><br><span>index bf252c9..307329d 100644</spa=
n><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br=
><span>@@ -1010,14 +1010,21 @@</span><br><span> </span><br><span> 	if test =
-z &quot;${MBEDTLS_CFLAGS}&quot; -a -z &quot;${MBEDTLS_LIBS}&quot;; then</s=
pan><br><span> 		# if the user did not explicitly specify flags, try to aut=
odetect</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		LIBS=3D&quot=
;${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-		AC_CHECK_LIB(</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-			[mbedtls],</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-			[mbedtls_ssl_init],</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-			[MBEDTLS_LIBS=3D&quot;-lmbedtls -lmbedx509 -lmbedcrypto&qu=
ot;],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[AC_MSG_ERROR=
([Could not find mbed TLS.])],</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-			[${PKCS11_HELPER_LIBS}]</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+		PKG_CHECK_MODULES([MBEDTLS],</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+			[mbedtls &gt;=3D 2.0.0 mbedx509 &gt;=3D 2.0.0=
 mbedcrypto &gt;=3D 2.0.0],</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+			[have_mbedtls=3D&quot;yes&quot;],</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+			[LIBS=3D&quot;${LIBS} -lmbedtls -lmbedx509 -lmb=
edcrypto&quot;]</span><br><span> 		)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+		# mbedtls might not have pkgconfig integration, so try m=
anually</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    if test &quot;${have_mbedtls}&quot; !=3D &quot;yes&quot;; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+			AC_CHECK_LIB(</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+				[mbedtls],</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+				[mbedtls_ssl_init],</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+				[MBEDTLS_LIBS=3D&quot;-lmbed=
tls -lmbedx509 -lmbedcrypto&quot;],</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+				[AC_MSG_ERROR([Could not find mbed TLS.])],</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+				[${PKCS11_HELPER_LIBS}]</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+			)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+		fi</span><br><span> 	fi</span><br><s=
pan> </span><br><span> 	CFLAGS=3D&quot;${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CF=
LAGS} ${CFLAGS}&quot;</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1422?usp=3Demail">change 142=
2</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1422?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d0da76018e874cda5dbab9202a=
2b817ad5e4692 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1422 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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

</body></html>=

--IIbFF1D3EYw=--

