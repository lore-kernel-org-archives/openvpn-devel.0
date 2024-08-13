From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 13 Aug 2024 12:04:44 +0000
In-Reply-To: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
References: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4b123f9ac428d011588d02d0ac324f1d331cb082-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oHZUpviwjMA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oHZUpviwjMA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/724?usp=3Demail

to look at the new patch set (#3).


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
---
M configure.ac
M src/openvpn/Makefile.am
2 files changed, 17 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/724/3

diff --git a/configure.ac b/configure.ac
index 9ce826c..5c44822 100644
--- a/configure.ac
+++ b/configure.ac
@@ -824,8 +824,8 @@
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
@@ -865,7 +865,6 @@
 dnl
 case "$host" in
 	*-*-linux*)
-		# We require pkg-config
 		PKG_CHECK_MODULES([LIBCAPNG],
 				  [libcap-ng],
 				  [],
@@ -873,8 +872,8 @@
 		)
 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])])

-		CFLAGS=3D"${CFLAGS} ${LIBCAPNG_CFLAGS}"
-		LIBS=3D"${LIBS} ${LIBCAPNG_LIBS}"
+		OPTIONAL_LIBCAPNG_CFLAGS=3D"${LIBCAPNG_CFLAGS}"
+		OPTIONAL_LIBCAPNG_LIBS=3D"${LIBCAPNG_LIBS}"
 		AC_DEFINE(HAVE_LIBCAPNG, 1, [Enable libcap-ng support])
 	;;
 esac
@@ -1414,7 +1413,7 @@

 # When testing a compiler option, we add -Werror to force
 # an error when the option is unsupported. This is not
-# required for gcc, but some compilers such as clang needs it.
+# required for gcc, but some compilers such as clang need it.
 AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
     old_cflags=3D"$CFLAGS"
     CFLAGS=3D"$1 -Werror $CFLAGS"
@@ -1490,6 +1489,10 @@
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
@@ -1534,10 +1537,11 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--oHZUpviwjMA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/724?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">configure: Handle libnl-genl and libcap-ng consistent with other l=
ibs<br><br>Do not communicate any of the flags via the global<br>CFLAGS and=
 LIBS, so that users are not confused when<br>overriding them on the comman=
d line.<br><br>Github: closes OpenVPN/openvpn#586<br>Change-Id: I39a6f58b11=
b922f5dbd3e55a5bc8574eda8a83fe<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M configure.ac<br>M src/openvpn/Makefile.am<br>2=
 files changed, 17 insertions(+), 9 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/24/724/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
configure.ac b/configure.ac</span><br><span>index 9ce826c..5c44822 100644</=
span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span>=
<br><span>@@ -824,8 +824,8 @@</span><br><span> 					   AC_MSG_ERROR([libnl-=
genl-3.0 package not found or too old. Is the development package and pkg-c=
onfig ${pkg_config_found} installed? Must be version 3.4.0 or newer for DCO=
])</span><br><span> 					  ]</span><br><span> 				)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-				CFLAGS=3D&quot;${CFLAGS} ${LIBNL_GENL_C=
FLAGS}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				LIBS=
=3D&quot;${LIBS} ${LIBNL_GENL_LIBS}&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+				OPTIONAL_LIBNL_GENL_CFLAGS=3D&quot;${LIBNL_GENL_C=
FLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				OPT=
IONAL_LIBNL_GENL_LIBS=3D&quot;${LIBNL_GENL_LIBS}&quot;</span><br><span> </s=
pan><br><span> 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel off=
load])</span><br><span> 				AC_MSG_NOTICE([Enabled ovpn-dco support for Lin=
ux])</span><br><span>@@ -865,7 +865,6 @@</span><br><span> dnl</span><br><sp=
an> case &quot;$host&quot; in</span><br><span> 	*-*-linux*)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-		# We require pkg-config</span><br><=
span> 		PKG_CHECK_MODULES([LIBCAPNG],</span><br><span> 				  [libcap-ng],</=
span><br><span> 				  [],</span><br><span>@@ -873,8 +872,8 @@</span><br><sp=
an> 		)</span><br><span> 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sy=
s/prctl.h not found!])])</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-		CFLAGS=3D&quot;${CFLAGS} ${LIBCAPNG_CFLAGS}&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-		LIBS=3D&quot;${LIBS} $=
{LIBCAPNG_LIBS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+		OPTIONAL_LIBCAPNG_CFLAGS=3D&quot;${LIBCAPNG_CFLAGS}&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+		OPTIONAL_LIBCAPNG_LIBS=3D&quot;=
${LIBCAPNG_LIBS}&quot;</span><br><span> 		AC_DEFINE(HAVE_LIBCAPNG, 1, [Enab=
le libcap-ng support])</span><br><span> 	;;</span><br><span> esac</span><br=
><span>@@ -1414,7 +1413,7 @@</span><br><span> </span><br><span> # When test=
ing a compiler option, we add -Werror to force</span><br><span> # an error =
when the option is unsupported. This is not</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-# required for gcc, but some compilers such as clang =
needs it.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# required=
 for gcc, but some compilers such as clang need it.</span><br><span> AC_DEF=
UN([ACL_CHECK_ADD_COMPILE_FLAGS], [</span><br><span>     old_cflags=3D&quot=
;$CFLAGS&quot;</span><br><span>     CFLAGS=3D&quot;$1 -Werror $CFLAGS&quot;=
</span><br><span>@@ -1490,6 +1489,10 @@</span><br><span> AC_SUBST([OPTIONAL=
_SELINUX_LIBS])</span><br><span> AC_SUBST([OPTIONAL_CRYPTO_CFLAGS])</span><=
br><span> AC_SUBST([OPTIONAL_CRYPTO_LIBS])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+AC_SUBST([OPTIONAL_LIBCAPNG_CFLAGS])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+AC_SUBST([OPTIONAL_LIBCAPNG_LIBS])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_SUBST([OPTIONAL_L=
IBNL_GENL_CFLAGS])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+A=
C_SUBST([OPTIONAL_LIBNL_GENL_LIBS])</span><br><span> AC_SUBST([OPTIONAL_LZO=
_CFLAGS])</span><br><span> AC_SUBST([OPTIONAL_LZO_LIBS])</span><br><span> A=
C_SUBST([OPTIONAL_LZ4_CFLAGS])</span><br><span>@@ -1534,10 +1537,11 @@</spa=
n><br><span> AM_CONDITIONAL([ENABLE_UNITTESTS], [test &quot;${enable_unit_t=
ests}&quot; =3D &quot;yes&quot; -a &quot;${have_cmocka}&quot; =3D &quot;yes=
&quot; ])</span><br><span> AC_SUBST([ENABLE_UNITTESTS])</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_LDFLAGS=3D&quot;${=
OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS}&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+TEST_LDFLAGS=3D&quot;${OPTIONAL_CRYP=
TO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_LDFLAGS=3D&quot;${=
TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}&quot;</span><br><span> TEST_LDFLA=
GS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_CFLAGS=3D&quot;${OPTION=
AL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS}&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-TEST_CFLAGS=3D&quot;${TEST_CFLAGS} ${OPT=
IONAL_LZO_CFLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+TEST_CFLAGS=3D&quot;${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_=
CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+TEST_CFLAGS=3D&quot;${TEST_CFLAGS} ${OPTIONAL_LIBNL_G=
ENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}&quot;</span><br><span> TEST_CFLAGS=3D&qu=
ot;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}&quot;</span><br=
><span> </span><br><span> AC_SUBST([TEST_LDFLAGS])</span><br><span>diff --g=
it a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>inde=
x 56cce9d..3784a98 100644</span><br><span>--- a/src/openvpn/Makefile.am</sp=
an><br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -24,6 +24,8 @=
@</span><br><span> AM_CFLAGS =3D \</span><br><span> 	$(TAP_CFLAGS) \</span>=
<br><span> 	$(OPTIONAL_CRYPTO_CFLAGS) \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	$(OPTIONAL_LIBCAPNG_CFLAGS) \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(OPTIONAL_LIBNL_GENL_CFLAGS) \</span><br><=
span> 	$(OPTIONAL_LZO_CFLAGS) \</span><br><span> 	$(OPTIONAL_LZ4_CFLAGS) \<=
/span><br><span> 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \</span><br><span>@@ -14=
7,6 +149,8 @@</span><br><span> openvpn_LDADD =3D \</span><br><span> 	$(top_=
builddir)/src/compat/libcompat.la \</span><br><span> 	$(SOCKETS_LIBS) \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(OPTIONAL_LIBCAPNG_LI=
BS) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(OPTIONAL_LI=
BNL_GENL_LIBS) \</span><br><span> 	$(OPTIONAL_LZO_LIBS) \</span><br><span> =
	$(OPTIONAL_LZ4_LIBS) \</span><br><span> 	$(OPTIONAL_PKCS11_HELPER_LIBS) \<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/724?usp=3Demail">change 724</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/724?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39a6f58b11b922f5dbd3e55a5bc=
8574eda8a83fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 724 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--oHZUpviwjMA=--

