From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 27 Jun 2024 16:53:11 +0000
References: <gerrit.1719507190000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <869e7a84d0034d95718c1cd9b1454753bc8118b2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6tGpGIf/QB4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Try to
 use pkg-config to detect mbedTLS
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

--6tGpGIf/QB4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/671?usp=3Demail

to review the following change.


Change subject: configure: Try to use pkg-config to detect mbedTLS
......................................................................

configure: Try to use pkg-config to detect mbedTLS

mbedTLS does not seem to have pkg-config support on e.g.
Debian/Ubuntu, so we definitely need to keep the
fallback check as well.

Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M configure.ac
1 file changed, 14 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/671/1

diff --git a/configure.ac b/configure.ac
index 555c97e..b2d27cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1000,14 +1000,21 @@

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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/671?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692
Gerrit-Change-Number: 671
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--6tGpGIf/QB4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/671?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">configure: Try to use pkg-config to detect mbedTLS<br><br>mbe=
dTLS does not seem to have pkg-config support on e.g.<br>Debian/Ubuntu, so =
we definitely need to keep the<br>fallback check as well.<br><br>Change-Id:=
 I5d0da76018e874cda5dbab9202a2b817ad5e4692<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>---<br>M configure.ac<br>1 file changed, 14=
 insertions(+), 7 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/71/671/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/configure.ac b/con=
figure.ac</span><br><span>index 555c97e..b2d27cd 100644</span><br><span>---=
 a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -1000=
,14 +1000,21 @@</span><br><span> </span><br><span> 	if test -z &quot;${MBED=
TLS_CFLAGS}&quot; -a -z &quot;${MBEDTLS_LIBS}&quot;; then</span><br><span> =
		# if the user did not explicitly specify flags, try to autodetect</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-		LIBS=3D&quot;${LIBS} -lmbed=
tls -lmbedx509 -lmbedcrypto&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-		AC_CHECK_LIB(</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-			[mbedtls],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		=
	[mbedtls_ssl_init],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
		[MBEDTLS_LIBS=3D&quot;-lmbedtls -lmbedx509 -lmbedcrypto&quot;],</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-			[AC_MSG_ERROR([Could not fin=
d mbed TLS.])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[${=
PKCS11_HELPER_LIBS}]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+		PKG_CHECK_MODULES([MBEDTLS],</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+			[mbedtls &gt;=3D 2.0.0 mbedx509 &gt;=3D 2.0.0 mbedcrypto &gt=
;=3D 2.0.0],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[hav=
e_mbedtls=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+			[LIBS=3D&quot;${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto&quot;]=
</span><br><span> 		)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+		# mbedtls might not have pkgconfig integration, so try manually</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                if test &qu=
ot;${have_mbedtls}&quot; !=3D &quot;yes&quot;; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+			AC_CHECK_LIB(</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+				[mbedtls],</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+				[mbedtls_ssl_init],</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+				[MBEDTLS_LIBS=3D&quot;-lmbedtls -lmbedx50=
9 -lmbedcrypto&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+				[AC_MSG_ERROR([Could not find mbed TLS.])],</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+				[${PKCS11_HELPER_LIBS}]</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+			)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+		fi</span><br><span> 	fi</span><br><span> </span><=
br><span> 	CFLAGS=3D&quot;${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAG=
S}&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/671?usp=3Demail">change 671</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/671?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d0da76018e874cda5dbab9202a=
2b817ad5e4692 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 671 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--6tGpGIf/QB4=--

