From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 15:09:46 +0000
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8034c83b7e5c709f79b786d48346fa78e7fde4b6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p7DySUWHWss="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Add
 --enable-code-coverage
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

--p7DySUWHWss=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1592?usp=3Demail

to review the following change.


Change subject: configure: Add --enable-code-coverage
......................................................................

configure: Add --enable-code-coverage

Can be used like this
./configure --enable-code-coverage
make
make check
make code-coverage-capture

Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .gitignore
M Makefile.am
M configure.ac
M m4/ax_code_coverage.m4
M src/openvpn/Makefile.am
5 files changed, 24 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1592/1

diff --git a/.gitignore b/.gitignore
index 04523af..e25e591 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,7 @@
 *.[oa]
 *.l[oa]
+*.gcda
+*.gcno
 *.dll
 *.exe
 *.exe.*
@@ -18,6 +20,7 @@
 Makefile
 Makefile.in
 aclocal.m4
+aminclude_static.am
 autodefs.h
 autom4te.cache
 config.guess
diff --git a/Makefile.am b/Makefile.am
index 362ae96..4af5e7e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,6 +22,8 @@
 #  with this program; if not, see <https://www.gnu.org/licenses/>.
 #

+include $(top_srcdir)/aminclude_static.am
+
 ACLOCAL_AMFLAGS =3D -I m4

 MAINTAINERCLEANFILES =3D \
@@ -89,3 +91,7 @@

 doxygen:
 	$(MAKE) -C doc/doxygen doxygen
+
+CODE_COVERAGE_LCOV_SHOPTS=3D--config-file $(srcdir)/lcovrc
+clean-local: code-coverage-clean
+distclean-local: code-coverage-dist-clean
diff --git a/configure.ac b/configure.ac
index 5da877a..82d3bce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -59,6 +59,8 @@
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS

+AX_CODE_COVERAGE
+
 AC_ARG_ENABLE(
 	[lzo],
 	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support @<:@def=
ault=3Dyes@:>@])],
@@ -1255,6 +1257,11 @@
 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type])
 fi

+# If coverage is enabled remove -O arguments from CFLAGS
+if test "$enable_code_coverage" =3D "yes"; then
+   [CFLAGS=3D"`echo $CFLAGS | $SED -e 's/-O[s0-9]\\?//g'`"]
+fi
+
 if test "${enable_pedantic}" =3D "yes"; then
 	CFLAGS=3D"${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
@@ -1374,10 +1381,10 @@

 TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${O=
PTIONAL_LIBCAPNG_LIBS}"
 TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}"
-TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}"
+TEST_LDFLAGS=3D"${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE=
_COVERAGE_LIBS}"
 TEST_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} =
${OPTIONAL_LIBCAPNG_CFLAGS}"
 TEST_CFLAGS=3D"${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO=
_CFLAGS}"
-TEST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}"
+TEST_CFLAGS=3D"${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS} ${=
CODE_COVERAGE_CFLAGS}"

 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
diff --git a/m4/ax_code_coverage.m4 b/m4/ax_code_coverage.m4
index 216708a4..4a01ce6 100644
--- a/m4/ax_code_coverage.m4
+++ b/m4/ax_code_coverage.m4
@@ -232,13 +232,12 @@
 		AC_MSG_ERROR([Could not find genhtml from the lcov package])
 	])

-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=3D"-lgcov"], [CODE=
_COVERAGE_LIBS=3D""])
-
 	dnl Build the code coverage flags
 	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibility
 	CODE_COVERAGE_CPPFLAGS=3D"-DNDEBUG"
-	CODE_COVERAGE_CFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
-	CODE_COVERAGE_CXXFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
+	CODE_COVERAGE_CFLAGS=3D"-O0 -g --coverage"
+	CODE_COVERAGE_CXXFLAGS=3D"-O0 -g --coverage"
+	CODE_COVERAGE_LIBS=3D"--coverage"

 	AC_SUBST([CODE_COVERAGE_CPPFLAGS])
 	AC_SUBST([CODE_COVERAGE_CFLAGS])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ff8cc54..47a4926 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -31,9 +31,12 @@
 	$(OPTIONAL_SYSTEMD_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
+	$(CODE_COVERAGE_CFLAGS) \
 	-DPLUGIN_LIBDIR=3D\"${plugindir}\" \
 	-DDEFAULT_DNS_UPDOWN=3D\"${scriptdir}/dns-updown\"

+AM_LIBS =3D $(CODE_COVERAGE_LIBS)
+
 if WIN32
 # we want unicode entry point but not the macro
 AM_CFLAGS +=3D -municode -UUNICODE

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1592?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Gerrit-Change-Number: 1592
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--p7DySUWHWss=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1592?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">configure: Add --enable-code-coverage<br><b=
r>Can be used like this<br>./configure --enable-code-coverage<br>make<br>ma=
ke check<br>make code-coverage-capture<br><br>Change-Id: I79b2dc4a550b1c506=
8a45407976b0dfc2f765b33<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>---<br>M .gitignore<br>M Makefile.am<br>M configure.ac<br>M m4=
/ax_code_coverage.m4<br>M src/openvpn/Makefile.am<br>5 files changed, 24 in=
sertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/92/1592/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.gi=
tignore b/.gitignore</span><br><span>index 04523af..e25e591 100644</span><b=
r><span>--- a/.gitignore</span><br><span>+++ b/.gitignore</span><br><span>@=
@ -1,5 +1,7 @@</span><br><span> *.[oa]</span><br><span> *.l[oa]</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+*.gcda</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+*.gcno</span><br><span> *.dll</span><br><spa=
n> *.exe</span><br><span> *.exe.*</span><br><span>@@ -18,6 +20,7 @@</span><=
br><span> Makefile</span><br><span> Makefile.in</span><br><span> aclocal.m4=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+aminclude_static.am=
</span><br><span> autodefs.h</span><br><span> autom4te.cache</span><br><spa=
n> config.guess</span><br><span>diff --git a/Makefile.am b/Makefile.am</spa=
n><br><span>index 362ae96..4af5e7e 100644</span><br><span>--- a/Makefile.am=
</span><br><span>+++ b/Makefile.am</span><br><span>@@ -22,6 +22,8 @@</span>=
<br><span> #  with this program; if not, see &lt;https://www.gnu.org/licens=
es/&gt;.</span><br><span> #</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+include $(top_srcdir)/aminclude_static.am</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ACLOCAL_A=
MFLAGS =3D -I m4</span><br><span> </span><br><span> MAINTAINERCLEANFILES =
=3D \</span><br><span>@@ -89,3 +91,7 @@</span><br><span> </span><br><span> =
doxygen:</span><br><span> 	$(MAKE) -C doc/doxygen doxygen</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS=3D--config-file $(srcdir)/lcov=
rc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clean-local: code=
-coverage-clean</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dist=
clean-local: code-coverage-dist-clean</span><br><span>diff --git a/configur=
e.ac b/configure.ac</span><br><span>index 5da877a..82d3bce 100644</span><br=
><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><spa=
n>@@ -59,6 +59,8 @@</span><br><span> AC_CANONICAL_HOST</span><br><span> AC_=
USE_SYSTEM_EXTENSIONS</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+AX_CODE_COVERAGE</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> AC_ARG_ENABLE(</span><br><span> 	[lzo],<=
/span><br><span> 	[AS_HELP_STRING([--disable-lzo], [disable LZO compression=
 support @&lt;:@default=3Dyes@:&gt;@])],</span><br><span>@@ -1255,6 +1257,1=
1 @@</span><br><span> 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type=
])</span><br><span> fi</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# If coverage is enabled remove -O arguments from CFLA=
GS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test &quot;$en=
able_code_coverage&quot; =3D &quot;yes&quot;; then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+   [CFLAGS=3D&quot;`echo $CFLAGS | $SED -e &=
#39;s/-O[s0-9]\\?//g&#39;`&quot;]</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> if test &quot;${enable_pedantic}&quot; =3D &quot;yes&quot;; =
then</span><br><span> 	CFLAGS=3D&quot;${CFLAGS} -pedantic&quot;</span><br><=
span> 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])</span><br><span>@=
@ -1374,10 +1381,10 @@</span><br><span> </span><br><span> TEST_LDFLAGS=3D&q=
uot;${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCA=
PNG_LIBS}&quot;</span><br><span> TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPT=
IONAL_LIBNL_GENL_LIBS}&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-TEST_LDFLAGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_L=
IBS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_LDFL=
AGS=3D&quot;${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE_COVE=
RAGE_LIBS}&quot;</span><br><span> TEST_CFLAGS=3D&quot;${OPTIONAL_CRYPTO_CFL=
AGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}&quot;</sp=
an><br><span> TEST_CFLAGS=3D&quot;${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLA=
GS} ${OPTIONAL_LZO_CFLAGS}&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-TEST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CM=
OCKA_CFLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+T=
EST_CFLAGS=3D&quot;${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}=
 ${CODE_COVERAGE_CFLAGS}&quot;</span><br><span> </span><br><span> AC_SUBST(=
[TEST_LDFLAGS])</span><br><span> AC_SUBST([TEST_CFLAGS])</span><br><span>di=
ff --git a/m4/ax_code_coverage.m4 b/m4/ax_code_coverage.m4</span><br><span>=
index 216708a4..4a01ce6 100644</span><br><span>--- a/m4/ax_code_coverage.m4=
</span><br><span>+++ b/m4/ax_code_coverage.m4</span><br><span>@@ -232,13 +2=
32,12 @@</span><br><span> 		AC_MSG_ERROR([Could not find genhtml from the l=
cov package])</span><br><span> 	])</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_C=
OVERAGE_LIBS=3D&quot;-lgcov&quot;], [CODE_COVERAGE_LIBS=3D&quot;&quot;])</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> 	dnl B=
uild the code coverage flags</span><br><span> 	dnl Define CODE_COVERAGE_LDF=
LAGS for backwards compatibility</span><br><span> 	CODE_COVERAGE_CPPFLAGS=
=3D&quot;-DNDEBUG&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -g -fprofile-arcs -ftest-coverage&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	CODE_COVERAGE_CXXFLA=
GS=3D&quot;-O0 -g -fprofile-arcs -ftest-coverage&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CFLAGS=3D&quot;-O0 -g --c=
overage&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_=
COVERAGE_CXXFLAGS=3D&quot;-O0 -g --coverage&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_LIBS=3D&quot;--coverage&quot;<=
/span><br><span> </span><br><span> 	AC_SUBST([CODE_COVERAGE_CPPFLAGS])</spa=
n><br><span> 	AC_SUBST([CODE_COVERAGE_CFLAGS])</span><br><span>diff --git a=
/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index ff=
8cc54..47a4926 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><=
br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -31,9 +31,12 @@</=
span><br><span> 	$(OPTIONAL_SYSTEMD_CFLAGS) \</span><br><span> 	$(OPTIONAL_=
PKCS11_HELPER_CFLAGS) \</span><br><span> 	$(OPTIONAL_INOTIFY_CFLAGS) \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(CODE_COVERAGE_CFLAGS)=
 \</span><br><span> 	-DPLUGIN_LIBDIR=3D\&quot;${plugindir}\&quot; \</span><=
br><span> 	-DDEFAULT_DNS_UPDOWN=3D\&quot;${scriptdir}/dns-updown\&quot;</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_LI=
BS =3D $(CODE_COVERAGE_LIBS)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> if WIN32</span><br><span> # we want unicode entr=
y point but not the macro</span><br><span> AM_CFLAGS +=3D -municode -UUNICO=
DE</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1592?usp=3Demail">change 1592</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1592?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976=
b0dfc2f765b33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1592 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--p7DySUWHWss=--

