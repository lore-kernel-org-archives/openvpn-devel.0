From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 8 Sep 2024 12:25:01 +0000
In-Reply-To: <gerrit.1719507190000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
References: <gerrit.1719507190000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <dfe423863174cf6dd65b62c003e23112f0ac556e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X6UqbROo/Yw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: uddr <yura.uddr@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X6UqbROo/Yw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/67=
1?usp=3Demail )

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
---
M configure.ac
1 file changed, 14 insertions(+), 7 deletions(-)




diff --git a/configure.ac b/configure.ac
index ea0da1f..9e569bf 100644
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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--X6UqbROo/Yw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/671?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">configure: Try to use pkg-config to detect mbe=
dTLS<br><br>mbedTLS does not seem to have pkg-config support on e.g.<br>Deb=
ian/Ubuntu, so we definitely need to keep the<br>fallback check as well.<br=
><br>Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt &lt=
;yura.uddr@...277...&gt;<br>Message-Id: &lt;20240906160510.76387-1-frank@...1186...=
.2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg29090.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M configure.ac<br>1 file changed, 14 insertions(+), 7 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index ea0da1f..=
9e569bf 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -1000,14 +1000,21 @@</span><br><span> </span><=
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
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/671?usp=
=3Demail">change 671</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/671?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d0da76018e874cda5dbab9202a=
2b817ad5e4692 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 671 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--X6UqbROo/Yw=--

