From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 16 Jul 2025 16:26:20 +0000
In-Reply-To: <gerrit.1752674908000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
References: <gerrit.1752674908000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5bb2b78f0400a72ae74c4d47d01a9425143e0f09-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0yypvlBx8E4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure.ac: Remove
 use of PKCS11_HELPER_LIBS in mbedTLS checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0yypvlBx8E4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
88?usp=3Demail )

Change subject: configure.ac: Remove use of PKCS11_HELPER_LIBS in mbedTLS c=
hecks
......................................................................

configure.ac: Remove use of PKCS11_HELPER_LIBS in mbedTLS checks

This code was copied over and over since many years,
since commit 9a3f670248d6f519a399e65a7232e2196b5115db
("Fixed autoconf script to properly detect missing pkcs11
with polarssl"). It is unclear what exact purpose it
served back then but probably it is obsolete. It is
definitely wrong since it means that you get
PKCS11_HELPER_LIBS even if you do not specify
--enable-pkcs11.

Change-Id: I317be5253d6563906dd3826421dc81f737beba76
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250716151857.385959-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
187.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
1 file changed, 8 insertions(+), 12 deletions(-)




diff --git a/configure.ac b/configure.ac
index 8fc48ba..66cb79b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -798,14 +798,6 @@
 		;;
 esac

-PKG_CHECK_MODULES(
-	[PKCS11_HELPER],
-	[libpkcs11-helper-1 >=3D 1.11],
-	[have_pkcs11_helper=3D"yes"],
-	[]
-)
-
-
 if test "$enable_dco" !=3D "no"; then
 	enable_dco_arg=3D"$enable_dco"
 	if test "${enable_iproute2}" =3D "yes"; then
@@ -1014,13 +1006,12 @@
 				[mbedtls_ssl_init],
 				[MBEDTLS_LIBS=3D"-lmbedtls -lmbedx509 -lmbedcrypto"],
 				[AC_MSG_ERROR([Could not find mbed TLS.])],
-				[${PKCS11_HELPER_LIBS}]
 			)
 		fi
 	fi

-	CFLAGS=3D"${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}"
-	LIBS=3D"${MBEDTLS_LIBS} ${PKCS11_HELPER_LIBS} ${LIBS}"
+	CFLAGS=3D"${MBEDTLS_CFLAGS} ${CFLAGS}"
+	LIBS=3D"${MBEDTLS_LIBS} ${LIBS}"

 	AC_MSG_CHECKING([mbedtls version])
 	AC_COMPILE_IFELSE(
@@ -1359,7 +1350,12 @@

 AM_CONDITIONAL([HAVE_SOFTHSM2], [false])
 if test "${enable_pkcs11}" =3D "yes"; then
-	test "${have_pkcs11_helper}" !=3D "yes" && AC_MSG_ERROR([PKCS11 enabled b=
ut libpkcs11-helper is missing])
+	PKG_CHECK_MODULES(
+		[PKCS11_HELPER],
+		[libpkcs11-helper-1 >=3D 1.11],
+		[have_pkcs11_helper=3D"yes"],
+		[AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])]
+	)
 	OPTIONAL_PKCS11_HELPER_CFLAGS=3D"${PKCS11_HELPER_CFLAGS}"
 	OPTIONAL_PKCS11_HELPER_LIBS=3D"${PKCS11_HELPER_LIBS}"
 	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1088?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I317be5253d6563906dd3826421dc81f737beba76
Gerrit-Change-Number: 1088
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--0yypvlBx8E4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1088?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">configure.ac: Remove use of PKCS11_HELPER_LIB=
S in mbedTLS checks<br><br>This code was copied over and over since many ye=
ars,<br>since commit 9a3f670248d6f519a399e65a7232e2196b5115db<br>(&quot;Fix=
ed autoconf script to properly detect missing pkcs11<br>with polarssl&quot;=
). It is unclear what exact purpose it<br>served back then but probably it =
is obsolete. It is<br>definitely wrong since it means that you get<br>PKCS1=
1_HELPER_LIBS even if you do not specify<br>--enable-pkcs11.<br><br>Change-=
Id: I317be5253d6563906dd3826421dc81f737beba76<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@=
...1227...&gt;<br>Message-Id: &lt;20250716151857.385959-1-frank@...2641...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg32187.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M configure.ac<br>1 file changed, 8 insertions(+), 12 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 8fc48ba..=
66cb79b 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -798,14 +798,6 @@</span><br><span> 		;;</span>=
<br><span> esac</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-PKG_CHECK_MODULES(</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	[PKCS11_HELPER],</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	[libpkcs11-helper-1 &gt;=3D 1.11],</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	[have_pkcs11_helper=3D&quot;yes&quot;],</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	[]</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> if =
test &quot;$enable_dco&quot; !=3D &quot;no&quot;; then</span><br><span> 	en=
able_dco_arg=3D&quot;$enable_dco&quot;</span><br><span> 	if test &quot;${en=
able_iproute2}&quot; =3D &quot;yes&quot;; then</span><br><span>@@ -1014,13 =
+1006,12 @@</span><br><span> 				[mbedtls_ssl_init],</span><br><span> 				[=
MBEDTLS_LIBS=3D&quot;-lmbedtls -lmbedx509 -lmbedcrypto&quot;],</span><br><s=
pan> 				[AC_MSG_ERROR([Could not find mbed TLS.])],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-				[${PKCS11_HELPER_LIBS}]</span><br><span=
> 			)</span><br><span> 		fi</span><br><span> 	fi</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	CFLAGS=3D&quot;${MBEDTLS_CFL=
AGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	LIBS=3D&quot;${MBEDTLS_LIBS} ${PKCS11_HELPER_LIBS} =
${LIBS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CFLAG=
S=3D&quot;${MBEDTLS_CFLAGS} ${CFLAGS}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	LIBS=3D&quot;${MBEDTLS_LIBS} ${LIBS}&quot;</span><=
br><span> </span><br><span> 	AC_MSG_CHECKING([mbedtls version])</span><br><=
span> 	AC_COMPILE_IFELSE(</span><br><span>@@ -1359,7 +1350,12 @@</span><br>=
<span> </span><br><span> AM_CONDITIONAL([HAVE_SOFTHSM2], [false])</span><br=
><span> if test &quot;${enable_pkcs11}&quot; =3D &quot;yes&quot;; then</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	test &quot;${have_pkcs11_=
helper}&quot; !=3D &quot;yes&quot; &amp;&amp; AC_MSG_ERROR([PKCS11 enabled =
but libpkcs11-helper is missing])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	PKG_CHECK_MODULES(</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+		[PKCS11_HELPER],</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+		[libpkcs11-helper-1 &gt;=3D 1.11],</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+		[have_pkcs11_helper=3D&quot;yes&quot;],</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_MSG_ERROR([PKCS11=
 enabled but libpkcs11-helper is missing])]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	)</span><br><span> 	OPTIONAL_PKCS11_HELPER_CFLAGS=
=3D&quot;${PKCS11_HELPER_CFLAGS}&quot;</span><br><span> 	OPTIONAL_PKCS11_HE=
LPER_LIBS=3D&quot;${PKCS11_HELPER_LIBS}&quot;</span><br><span> 	AC_DEFINE([=
ENABLE_PKCS11], [1], [Enable PKCS11])</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1088?usp=3De=
mail">change 1088</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1088?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I317be5253d6563906dd3826421d=
c81f737beba76 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1088 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--0yypvlBx8E4=--

