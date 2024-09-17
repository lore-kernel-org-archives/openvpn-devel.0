From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 13:37:29 +0000
In-Reply-To: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
References: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <10fdc50c04a60c2ec5e43f748dce1b9bc53bc954-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FUw5tR1NHwA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Handle
 libnl-genl and libcap-ng consistent with other libs
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

--FUw5tR1NHwA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/72=
4?usp=3Demail )

Change subject: configure: Handle libnl-genl and libcap-ng consistent with =
other libs
......................................................................

configure: Handle libnl-genl and libcap-ng consistent with other libs

Do not communicate any of the flags via the global
CFLAGS and LIBS, so that users are not confused when
overriding them on the command line.

Github: closes OpenVPN/openvpn#586
Change-Id: I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240917133253.19616-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
282.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
M src/openvpn/Makefile.am
2 files changed, 17 insertions(+), 9 deletions(-)




diff --git a/configure.ac b/configure.ac
index 9bc15c8..5d7d0fc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -802,8 +802,8 @@
 					   AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the =
development package and pkg-config ${pkg_config_found} installed? Must be v=
ersion 3.4.0 or newer for DCO])
 					  ]
 				)
-				CFLAGS=3D"${CFLAGS} ${LIBNL_GENL_CFLAGS}"
-				LIBS=3D"${LIBS} ${LIBNL_GENL_LIBS}"
+				OPTIONAL_LIBNL_GENL_CFLAGS=3D"${LIBNL_GENL_CFLAGS}"
+				OPTIONAL_LIBNL_GENL_LIBS=3D"${LIBNL_GENL_LIBS}"

 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
 				AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
@@ -843,7 +843,6 @@
 dnl
 case "$host" in
 	*-*-linux*)
-		# We require pkg-config
 		PKG_CHECK_MODULES([LIBCAPNG],
 				  [libcap-ng],
 				  [],
@@ -851,8 +850,8 @@
 		)
 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])])

-		CFLAGS=3D"${CFLAGS} ${LIBCAPNG_CFLAGS}"
-		LIBS=3D"${LIBS} ${LIBCAPNG_LIBS}"
+		OPTIONAL_LIBCAPNG_CFLAGS=3D"${LIBCAPNG_CFLAGS}"
+		OPTIONAL_LIBCAPNG_LIBS=3D"${LIBCAPNG_LIBS}"
 		AC_DEFINE(HAVE_LIBCAPNG, 1, [Enable libcap-ng support])
 	;;
 esac
@@ -1401,7 +1400,7 @@

 # When testing a compiler option, we add -Werror to force
 # an error when the option is unsupported. This is not
-# required for gcc, but some compilers such as clang needs it.
+# required for gcc, but some compilers such as clang need it.
 AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
     old_cflags=3D"$CFLAGS"
     CFLAGS=3D"$1 -Werror $CFLAGS"
@@ -1477,6 +1476,10 @@
 AC_SUBST([OPTIONAL_SELINUX_LIBS])
 AC_SUBST([OPTIONAL_CRYPTO_CFLAGS])
 AC_SUBST([OPTIONAL_CRYPTO_LIBS])
+AC_SUBST([OPTIONAL_LIBCAPNG_CFLAGS])
+AC_SUBST([OPTIONAL_LIBCAPNG_LIBS])
+AC_SUBST([OPTIONAL_LIBNL_GENL_CFLAGS])
+AC_SUBST([OPTIONAL_LIBNL_GENL_LIBS])
 AC_SUBST([OPTIONAL_LZO_CFLAGS])
 AC_SUBST([OPTIONAL_LZO_LIBS])
 AC_SUBST([OPTIONAL_LZ4_CFLAGS])
@@ -1521,10 +1524,11 @@
 AM_CONDITIONAL([ENABLE_UNITTESTS], [test "${enable_unit_tests}" =3D "yes" =
-a "${have_cmocka}" =3D "yes" ])
 AC_SUBST([ENABLE_UNITTESTS])

-TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS}"
+TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${O=
PTIONAL_LIBCAPNG_LIBS}"
+TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}"
 TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}"
-TEST_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS}"
-TEST_CFLAGS=3D"${TEST_CFLAGS} ${OPTIONAL_LZO_CFLAGS}"
+TEST_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} =
${OPTIONAL_LIBCAPNG_CFLAGS}"
+TEST_CFLAGS=3D"${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO=
_CFLAGS}"
 TEST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}"

 AC_SUBST([TEST_LDFLAGS])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 56cce9d..3784a98 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -24,6 +24,8 @@
 AM_CFLAGS =3D \
 	$(TAP_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
+	$(OPTIONAL_LIBCAPNG_CFLAGS) \
+	$(OPTIONAL_LIBNL_GENL_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_LZ4_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
@@ -147,6 +149,8 @@
 openvpn_LDADD =3D \
 	$(top_builddir)/src/compat/libcompat.la \
 	$(SOCKETS_LIBS) \
+	$(OPTIONAL_LIBCAPNG_LIBS) \
+	$(OPTIONAL_LIBNL_GENL_LIBS) \
 	$(OPTIONAL_LZO_LIBS) \
 	$(OPTIONAL_LZ4_LIBS) \
 	$(OPTIONAL_PKCS11_HELPER_LIBS) \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/724?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe
Gerrit-Change-Number: 724
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--FUw5tR1NHwA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/724?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">configure: Handle libnl-genl and libcap-ng con=
sistent with other libs<br><br>Do not communicate any of the flags via the =
global<br>CFLAGS and LIBS, so that users are not confused when<br>overridin=
g them on the command line.<br><br>Github: closes OpenVPN/openvpn#586<br>Ch=
ange-Id: I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>Message-Id: &lt;20240917133253.19616-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
29282.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M configure.ac<br>M src/openvpn/Makefile.am<br>2 files changed, 17 inserti=
ons(+), 9 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 9bc15c8..=
5d7d0fc 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -802,8 +802,8 @@</span><br><span> 					   AC_M=
SG_ERROR([libnl-genl-3.0 package not found or too old. Is the development p=
ackage and pkg-config ${pkg_config_found} installed? Must be version 3.4.0 =
or newer for DCO])</span><br><span> 					  ]</span><br><span> 				)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-				CFLAGS=3D&quot;${CFLAGS} =
${LIBNL_GENL_CFLAGS}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-				LIBS=3D&quot;${LIBS} ${LIBNL_GENL_LIBS}&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+				OPTIONAL_LIBNL_GENL_CFLAGS=3D&quot;$=
{LIBNL_GENL_CFLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+				OPTIONAL_LIBNL_GENL_LIBS=3D&quot;${LIBNL_GENL_LIBS}&quot;</span><=
br><span> </span><br><span> 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared dat=
a channel offload])</span><br><span> 				AC_MSG_NOTICE([Enabled ovpn-dco su=
pport for Linux])</span><br><span>@@ -843,7 +843,6 @@</span><br><span> dnl<=
/span><br><span> case &quot;$host&quot; in</span><br><span> 	*-*-linux*)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-		# We require pkg-confi=
g</span><br><span> 		PKG_CHECK_MODULES([LIBCAPNG],</span><br><span> 				  [=
libcap-ng],</span><br><span> 				  [],</span><br><span>@@ -851,8 +850,8 @@<=
/span><br><span> 		)</span><br><span> 		AC_CHECK_HEADER([sys/prctl.h],,[AC_=
MSG_ERROR([sys/prctl.h not found!])])</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-		CFLAGS=3D&quot;${CFLAGS} ${LIBCAPNG_CFL=
AGS}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		LIBS=3D&q=
uot;${LIBS} ${LIBCAPNG_LIBS}&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+		OPTIONAL_LIBCAPNG_CFLAGS=3D&quot;${LIBCAPNG_CFLAGS}&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+		OPTIONAL_LIBCAPNG_=
LIBS=3D&quot;${LIBCAPNG_LIBS}&quot;</span><br><span> 		AC_DEFINE(HAVE_LIBCA=
PNG, 1, [Enable libcap-ng support])</span><br><span> 	;;</span><br><span> e=
sac</span><br><span>@@ -1401,7 +1400,7 @@</span><br><span> </span><br><span=
> # When testing a compiler option, we add -Werror to force</span><br><span=
> # an error when the option is unsupported. This is not</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# required for gcc, but some compilers s=
uch as clang needs it.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# required for gcc, but some compilers such as clang need it.</span><br>=
<span> AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [</span><br><span>     old_c=
flags=3D&quot;$CFLAGS&quot;</span><br><span>     CFLAGS=3D&quot;$1 -Werror =
$CFLAGS&quot;</span><br><span>@@ -1477,6 +1476,10 @@</span><br><span> AC_SU=
BST([OPTIONAL_SELINUX_LIBS])</span><br><span> AC_SUBST([OPTIONAL_CRYPTO_CFL=
AGS])</span><br><span> AC_SUBST([OPTIONAL_CRYPTO_LIBS])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+AC_SUBST([OPTIONAL_LIBCAPNG_CFLAGS])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_SUBST([OPTIONAL_LIB=
CAPNG_LIBS])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_SUBS=
T([OPTIONAL_LIBNL_GENL_CFLAGS])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+AC_SUBST([OPTIONAL_LIBNL_GENL_LIBS])</span><br><span> AC_SUBST(=
[OPTIONAL_LZO_CFLAGS])</span><br><span> AC_SUBST([OPTIONAL_LZO_LIBS])</span=
><br><span> AC_SUBST([OPTIONAL_LZ4_CFLAGS])</span><br><span>@@ -1521,10 +15=
24,11 @@</span><br><span> AM_CONDITIONAL([ENABLE_UNITTESTS], [test &quot;${=
enable_unit_tests}&quot; =3D &quot;yes&quot; -a &quot;${have_cmocka}&quot; =
=3D &quot;yes&quot; ])</span><br><span> AC_SUBST([ENABLE_UNITTESTS])</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_LDFLA=
GS=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS}&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_LDFLAGS=3D&quot;${=
OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LI=
BS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_LDFLA=
GS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}&quot;</span><br><spa=
n> TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_CFLAGS=3D&=
quot;${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS}&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_CFLAGS=3D&quot;${TEST_=
CFLAGS} ${OPTIONAL_LZO_CFLAGS}&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+TEST_CFLAGS=3D&quot;${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_P=
KCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+TEST_CFLAGS=3D&quot;${TEST_CFLAGS} ${OPT=
IONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}&quot;</span><br><span> TEST=
_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}&qu=
ot;</span><br><span> </span><br><span> AC_SUBST([TEST_LDFLAGS])</span><br><=
span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><=
br><span>index 56cce9d..3784a98 100644</span><br><span>--- a/src/openvpn/Ma=
kefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ =
-24,6 +24,8 @@</span><br><span> AM_CFLAGS =3D \</span><br><span> 	$(TAP_CFL=
AGS) \</span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS) \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(OPTIONAL_LIBCAPNG_CFLAGS) \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(OPTIONAL_LIBNL_GENL_CFLAGS)=
 \</span><br><span> 	$(OPTIONAL_LZO_CFLAGS) \</span><br><span> 	$(OPTIONAL_=
LZ4_CFLAGS) \</span><br><span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</span><b=
r><span>@@ -147,6 +149,8 @@</span><br><span> openvpn_LDADD =3D \</span><br>=
<span> 	$(top_builddir)/src/compat/libcompat.la \</span><br><span> 	$(SOCKE=
TS_LIBS) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(OPTION=
AL_LIBCAPNG_LIBS) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	$(OPTIONAL_LIBNL_GENL_LIBS) \</span><br><span> 	$(OPTIONAL_LZO_LIBS) \</sp=
an><br><span> 	$(OPTIONAL_LZ4_LIBS) \</span><br><span> 	$(OPTIONAL_PKCS11_H=
ELPER_LIBS) \</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/724?usp=3Demail">change 724</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/724?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39a6f58b11b922f5dbd3e55a5bc=
8574eda8a83fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 724 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--FUw5tR1NHwA=--

