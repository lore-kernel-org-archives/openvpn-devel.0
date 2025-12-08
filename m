From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 21:38:46 +0000
In-Reply-To: <gerrit.1765213173000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
References: <gerrit.1765213173000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c0ed8bb50079138cae38352f21f9c8e65b58c832-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xGKbDw2DcYA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: configure.ac:
 Remove use of PKCS11_HELPER_LIBS in mbedTLS checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, plaisthos <arne-openvpn@...1227...>

--xGKbDw2DcYA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
23?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1423
(cherry picked from commit ed690d1d58792f70b86b75b00c09df2ad96babca)
Message-Id: <20251208194242.17520-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
913.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
1 file changed, 8 insertions(+), 12 deletions(-)




diff --git a/configure.ac b/configure.ac
index 307329d..e77fd47 100644
--- a/configure.ac
+++ b/configure.ac
@@ -801,14 +801,6 @@
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
@@ -1022,13 +1014,12 @@
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
@@ -1399,7 +1390,12 @@
 fi

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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1423?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I317be5253d6563906dd3826421dc81f737beba76
Gerrit-Change-Number: 1423
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xGKbDw2DcYA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1423?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">configure.ac: Remove use of PKCS11_HELPER_LIBS i=
n mbedTLS checks<br><br>This code was copied over and over since many years=
,<br>since commit 9a3f670248d6f519a399e65a7232e2196b5115db<br>(&quot;Fixed =
autoconf script to properly detect missing pkcs11<br>with polarssl&quot;). =
It is unclear what exact purpose it<br>served back then but probably it is =
obsolete. It is<br>definitely wrong since it means that you get<br>PKCS11_H=
ELPER_LIBS even if you do not specify<br>--enable-pkcs11.<br><br>Change-Id:=
 I317be5253d6563906dd3826421dc81f737beba76<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...493...=
1227...&gt;<br>Message-Id: &lt;20250716151857.385959-1-frank@...2641...&gt;=
<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg32187.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acke=
d-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.op=
envpn.net/c/openvpn/+/1423<br>(cherry picked from commit ed690d1d58792f70b8=
6b75b00c09df2ad96babca)<br>Message-Id: &lt;20251208194242.17520-1-gert@...1386...=
296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg34913.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M configure.ac<br>1 file changed, 8 insertions(+), 12 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 307329d..=
e77fd47 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -801,14 +801,6 @@</span><br><span> 		;;</span>=
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
able_iproute2}&quot; =3D &quot;yes&quot;; then</span><br><span>@@ -1022,13 =
+1014,12 @@</span><br><span> 				[mbedtls_ssl_init],</span><br><span> 				[=
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
span> 	AC_COMPILE_IFELSE(</span><br><span>@@ -1399,7 +1390,12 @@</span><br>=
<span> fi</span><br><span> </span><br><span> if test &quot;${enable_pkcs11}=
&quot; =3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	test &quot;${have_pkcs11_helper}&quot; !=3D &quot;yes&quot; &am=
p;&amp; AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	PKG_CHECK_MODULES(</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+		[PKCS11_HELPER],</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+		[libpkcs11-helper-1 &gt=
;=3D 1.11],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[have_=
pkcs11_helper=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+		[AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missi=
ng])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	)</span><br><=
span> 	OPTIONAL_PKCS11_HELPER_CFLAGS=3D&quot;${PKCS11_HELPER_CFLAGS}&quot;<=
/span><br><span> 	OPTIONAL_PKCS11_HELPER_LIBS=3D&quot;${PKCS11_HELPER_LIBS}=
&quot;</span><br><span> 	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1423?usp=3Demail">change 1423</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1423?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I317be5253d6563906dd3826421d=
c81f737beba76 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1423 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--xGKbDw2DcYA=--

