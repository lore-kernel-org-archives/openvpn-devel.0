From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 21:38:40 +0000
In-Reply-To: <gerrit.1765213173000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
References: <gerrit.1765213173000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c0ed8bb50079138cae38352f21f9c8e65b58c832-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IADk/8J/BoI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IADk/8J/BoI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1423?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1423/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I317be5253d6563906dd3826421dc81f737beba76
Gerrit-Change-Number: 1423
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IADk/8J/BoI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1423?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">configure.ac: Remove use of PKCS11_=
HELPER_LIBS in mbedTLS checks<br><br>This code was copied over and over sin=
ce many years,<br>since commit 9a3f670248d6f519a399e65a7232e2196b5115db<br>=
(&quot;Fixed autoconf script to properly detect missing pkcs11<br>with pola=
rssl&quot;). It is unclear what exact purpose it<br>served back then but pr=
obably it is obsolete. It is<br>definitely wrong since it means that you ge=
t<br>PKCS11_HELPER_LIBS even if you do not specify<br>--enable-pkcs11.<br><=
br>Change-Id: I317be5253d6563906dd3826421dc81f737beba76<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arn=
e-openvpn@...1227...&gt;<br>Message-Id: &lt;20250716151857.385959-1-frank@...220...=
..2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg32187.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: http=
s://gerrit.openvpn.net/c/openvpn/+/1423<br>(cherry picked from commit ed690=
d1d58792f70b86b75b00c09df2ad96babca)<br>Message-Id: &lt;20251208194242.1752=
0-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg34913.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>---<br>M configure.ac<br>1 file changed, 8 insertions(+)=
, 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/23/1423/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/configure.ac =
b/configure.ac</span><br><span>index 307329d..e77fd47 100644</span><br><spa=
n>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ =
-801,14 +801,6 @@</span><br><span> 		;;</span><br><span> esac</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-PKG_CHECK_MODULES=
(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[PKCS11_HELPER],</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	[libpkcs11-helper-1 &gt=
;=3D 1.11],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[have_pkc=
s11_helper=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	[]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> if test &quot;$enable_dco&quot; =
!=3D &quot;no&quot;; then</span><br><span> 	enable_dco_arg=3D&quot;$enable_=
dco&quot;</span><br><span> 	if test &quot;${enable_iproute2}&quot; =3D &quo=
t;yes&quot;; then</span><br><span>@@ -1022,13 +1014,12 @@</span><br><span> =
				[mbedtls_ssl_init],</span><br><span> 				[MBEDTLS_LIBS=3D&quot;-lmbedtl=
s -lmbedx509 -lmbedcrypto&quot;],</span><br><span> 				[AC_MSG_ERROR([Could=
 not find mbed TLS.])],</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-				[${PKCS11_HELPER_LIBS}]</span><br><span> 			)</span><br><span> 		fi</=
span><br><span> 	fi</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	CFLAGS=3D&quot;${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CFLAGS} $=
{CFLAGS}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	LIBS=
=3D&quot;${MBEDTLS_LIBS} ${PKCS11_HELPER_LIBS} ${LIBS}&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	CFLAGS=3D&quot;${MBEDTLS_CFLAGS} =
${CFLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	LIB=
S=3D&quot;${MBEDTLS_LIBS} ${LIBS}&quot;</span><br><span> </span><br><span> =
	AC_MSG_CHECKING([mbedtls version])</span><br><span> 	AC_COMPILE_IFELSE(</s=
pan><br><span>@@ -1399,7 +1390,12 @@</span><br><span> fi</span><br><span> <=
/span><br><span> if test &quot;${enable_pkcs11}&quot; =3D &quot;yes&quot;; =
then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	test &quot;${hav=
e_pkcs11_helper}&quot; !=3D &quot;yes&quot; &amp;&amp; AC_MSG_ERROR([PKCS11=
 enabled but libpkcs11-helper is missing])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	PKG_CHECK_MODULES(</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+		[PKCS11_HELPER],</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+		[libpkcs11-helper-1 &gt;=3D 1.11],</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+		[have_pkcs11_helper=3D&quot;yes&qu=
ot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_MSG_ERRO=
R([PKCS11 enabled but libpkcs11-helper is missing])]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	)</span><br><span> 	OPTIONAL_PKCS11_HELP=
ER_CFLAGS=3D&quot;${PKCS11_HELPER_CFLAGS}&quot;</span><br><span> 	OPTIONAL_=
PKCS11_HELPER_LIBS=3D&quot;${PKCS11_HELPER_LIBS}&quot;</span><br><span> 	AC=
_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/142=
3?usp=3Demail">change 1423</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1423?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--IADk/8J/BoI=--

