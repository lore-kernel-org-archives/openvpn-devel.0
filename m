From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 21:38:43 +0000
In-Reply-To: <gerrit.1765213173000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
References: <gerrit.1765213173000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <49eb1d8f53492f2446fbca33aa80a3d073663177-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3ox8KozNft0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, uddr <yura.uddr@...277...>

--3ox8KozNft0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
22?usp=3Demail )

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

Gerrit-MessageType: merged
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

--3ox8KozNft0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1422?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">configure: Try to use pkg-config to detect mbedT=
LS<br><br>mbedTLS does not seem to have pkg-config support on e.g.<br>Debia=
n/Ubuntu, so we definitely need to keep the<br>fallback check as well.<br><=
br>Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt &lt;y=
ura.uddr@...277...&gt;<br>Message-Id: &lt;20240906160510.76387-1-frank@...1665...=
641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg29090.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:/=
/gerrit.openvpn.net/c/openvpn/+/1422<br>(cherry picked from commit c829f570=
96cb6951aa4698eff388aeebf9310334)<br>Message-Id: &lt;20251208194151.17419-1=
-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg34911.html<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M configure.ac<br>1 file changed, 14 insertions(+), =
7 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index bf252c9..=
307329d 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -1010,14 +1010,21 @@</span><br><span> </span><=
br><span> 	if test -z &quot;${MBEDTLS_CFLAGS}&quot; -a -z &quot;${MBEDTLS_L=
IBS}&quot;; then</span><br><span> 		# if the user did not explicitly specif=
y flags, try to autodetect</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-		LIBS=3D&quot;${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-		AC_CHECK_LIB(</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-			[mbedtls],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-			[mbedtls_ssl_init],</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-			[MBEDTLS_LIBS=3D&quot;-lmbedtls -lmbedx=
509 -lmbedcrypto&quot;],</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-			[AC_MSG_ERROR([Could not find mbed TLS.])],</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-			[${PKCS11_HELPER_LIBS}]</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+		PKG_CHECK_MODULES([MBEDTLS],</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+			[mbedtls &gt;=3D 2.0.0 mbe=
dx509 &gt;=3D 2.0.0 mbedcrypto &gt;=3D 2.0.0],</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+			[have_mbedtls=3D&quot;yes&quot;],</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+			[LIBS=3D&quot;${LIBS} -lmbed=
tls -lmbedx509 -lmbedcrypto&quot;]</span><br><span> 		)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+		# mbedtls might not have pkgconfig in=
tegration, so try manually</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                if test &quot;${have_mbedtls}&quot; !=3D &quot;yes&q=
uot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			AC_CHE=
CK_LIB(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				[mbedtls=
],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				[mbedtls_ssl_=
init],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				[MBEDTLS_=
LIBS=3D&quot;-lmbedtls -lmbedx509 -lmbedcrypto&quot;],</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+				[AC_MSG_ERROR([Could not find mbed T=
LS.])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				[${PKCS1=
1_HELPER_LIBS}]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		fi</span><br><spa=
n> 	fi</span><br><span> </span><br><span> 	CFLAGS=3D&quot;${MBEDTLS_CFLAGS}=
 ${PKCS11_HELPER_CFLAGS} ${CFLAGS}&quot;</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1422?usp=
=3Demail">change 1422</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1422?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--3ox8KozNft0=--

