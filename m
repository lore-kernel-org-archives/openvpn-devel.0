From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 16 Jul 2025 14:08:30 +0000
References: <gerrit.1752674908000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <df667fd6525a1c412e3b81e1d38d4417dc8dd846-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SBOlxa/0iwA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SBOlxa/0iwA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1088?usp=3Demail

to review the following change.


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
---
M configure.ac
1 file changed, 8 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1088/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--SBOlxa/0iwA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1088?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">configure.ac: Remove use of PKCS11_HELPER_LIBS in mbedTLS ch=
ecks<br><br>This code was copied over and over since many years,<br>since c=
ommit 9a3f670248d6f519a399e65a7232e2196b5115db<br>(&quot;Fixed autoconf scr=
ipt to properly detect missing pkcs11<br>with polarssl&quot;). It is unclea=
r what exact purpose it<br>served back then but probably it is obsolete. It=
 is<br>definitely wrong since it means that you get<br>PKCS11_HELPER_LIBS e=
ven if you do not specify<br>--enable-pkcs11.<br><br>Change-Id: I317be5253d=
6563906dd3826421dc81f737beba76<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M configure.ac<br>1 file changed, 8 insertions(+=
), 12 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/88/1088/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</=
span><br><span>index 8fc48ba..66cb79b 100644</span><br><span>--- a/configur=
e.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -798,14 +798,6 @=
@</span><br><span> 		;;</span><br><span> esac</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-PKG_CHECK_MODULES(</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	[PKCS11_HELPER],</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	[libpkcs11-helper-1 &gt;=3D 1.11],</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	[have_pkcs11_helper=3D&qu=
ot;yes&quot;],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[]</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> if test &quot;$enable_dco&quot; !=3D &quot;no&=
quot;; then</span><br><span> 	enable_dco_arg=3D&quot;$enable_dco&quot;</spa=
n><br><span> 	if test &quot;${enable_iproute2}&quot; =3D &quot;yes&quot;; t=
hen</span><br><span>@@ -1014,13 +1006,12 @@</span><br><span> 				[mbedtls_s=
sl_init],</span><br><span> 				[MBEDTLS_LIBS=3D&quot;-lmbedtls -lmbedx509 -=
lmbedcrypto&quot;],</span><br><span> 				[AC_MSG_ERROR([Could not find mbed=
 TLS.])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				[${PKCS1=
1_HELPER_LIBS}]</span><br><span> 			)</span><br><span> 		fi</span><br><span=
> 	fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	CFLAGS=3D&quot;${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	LIBS=3D&quot;${MBEDT=
LS_LIBS} ${PKCS11_HELPER_LIBS} ${LIBS}&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	CFLAGS=3D&quot;${MBEDTLS_CFLAGS} ${CFLAGS}&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	LIBS=3D&quot;${MBED=
TLS_LIBS} ${LIBS}&quot;</span><br><span> </span><br><span> 	AC_MSG_CHECKING=
([mbedtls version])</span><br><span> 	AC_COMPILE_IFELSE(</span><br><span>@@=
 -1359,7 +1350,12 @@</span><br><span> </span><br><span> AM_CONDITIONAL([HAV=
E_SOFTHSM2], [false])</span><br><span> if test &quot;${enable_pkcs11}&quot;=
 =3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	test &quot;${have_pkcs11_helper}&quot; !=3D &quot;yes&quot; &amp;&amp=
; AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	PKG_CHECK_MODULES(</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+		[PKCS11_HELPER],</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+		[libpkcs11-helper-1 &gt;=3D 1=
.11],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[have_pkcs11=
_helper=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+		[AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])]<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	)</span><br><span> =
	OPTIONAL_PKCS11_HELPER_CFLAGS=3D&quot;${PKCS11_HELPER_CFLAGS}&quot;</span>=
<br><span> 	OPTIONAL_PKCS11_HELPER_LIBS=3D&quot;${PKCS11_HELPER_LIBS}&quot;=
</span><br><span> 	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1088?usp=3Demail">change 1088</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1088?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I317be5253d6563906dd3826421d=
c81f737beba76 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1088 </div>
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


--SBOlxa/0iwA=--

