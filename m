From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 3 Jan 2024 15:23:38 +0000
In-Reply-To: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
References: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <c5968940a6dd82e48f4202382a435fae7caef109-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yGzb3DpJvi8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make it more
 explicit and visible when pkg-config is not found
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yGzb3DpJvi8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review-1 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Make it more explicit and visible when pkg-config is not fo=
und
......................................................................

Make it more explicit and visible when pkg-config is not found

Users seem to struggle to read the full error message. This adds an
indication if pkg-config is actually found to the warning/error message
that use pkg-config.

On platforms that do not require pkg-config and for optional libraries,
the existence of pkg-config is mentioned as part of the error/warning messa=
ge.

When found:

    configure: error: libnl-genl-3.0 package not found or too old. Is the d=
evelopment package and pkg-config (using /usr/bin/pkg-config) installed? Mu=
st be version 3.4.0 or newer for DCO

not found:

    configure: error: libnl-genl-3.0 package not found or too old. Is the d=
evelopment package and pkg-config (not found) installed? Must be version 3.=
4.0 or newer for DCO

On platforms where pkg-config is required (only Linux at the moment),
configure will abort when not detecting pkg-config:

checking for pkg-config... no
configure: error: pkg-config is required

Change-Id: Iebaa35a23e217a4cd7739af229cbfc08a3d8854a
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M configure.ac
1 file changed, 17 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/465/3

diff --git a/configure.ac b/configure.ac
index f420612..f009fe2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -323,6 +323,7 @@
 		AM_CONDITIONAL([TARGET_LINUX], [true])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["L"], [Target prefix])
 		have_sitnl=3D"yes"
+		pkg_config_required=3D"yes"
 		;;
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
@@ -376,6 +377,16 @@
 AM_CONDITIONAL([CROSS_COMPILING], test "${cross_compiling}" =3D "yes")

 PKG_PROG_PKG_CONFIG
+# Add variable to print if pkg-config is found or not. Users often miss th=
at
+if test "${PKG_CONFIG}" =3D ""; then
+    if test "${pkg_config_required}" =3D "yes"; then
+        AC_MSG_ERROR([pkg-config is required])
+    fi
+	pkg_config_found=3D"(not found)"
+else
+	pkg_config_found=3D"(using ${PKG_CONFIG})"
+fi
+
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S
@@ -810,7 +821,7 @@
 					  [libnl-genl-3.0 >=3D 3.4.0],
 					  [have_libnl=3D"yes"],
 					  [
-					   AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the =
development package and pkg-config installed? Must be version 3.4.0 or newe=
r for DCO])
+					   AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the =
development package and pkg-config ${pkg_config_found} installed? Must be v=
ersion 3.4.0 or newer for DCO])
 					  ]
 				)
 				CFLAGS=3D"${CFLAGS} ${LIBNL_GENL_CFLAGS}"
@@ -854,10 +865,11 @@
 dnl
 case "$host" in
 	*-*-linux*)
+		# We require pkg-config
 		PKG_CHECK_MODULES([LIBCAPNG],
 				  [libcap-ng],
 				  [],
-				  [AC_MSG_ERROR([libcap-ng package not found. Is the development packa=
ge and pkg-config installed?])]
+				  [AC_MSG_ERROR([libcap-ng package not found. Is the development packa=
ge and pkg-config ${pkg_config_found} installed?])]
 		)
 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])])

@@ -878,7 +890,7 @@
 			[OPENSSL],
 			[openssl >=3D 1.0.2],
 			[have_openssl=3D"yes"],
-			[] # If this fails, we will do another test next
+			[AC_MSG_WARN([OpenSSL not found by pkg-config ${pkg_config_found}])] # =
If this fails, we will do another test next
 		)
 		OPENSSL_LIBS=3D${OPENSSL_LIBS:--lssl -lcrypto}
 	fi
@@ -1083,7 +1095,7 @@
 			[WOLFSSL],
 			[wolfssl],
 			[],
-			[AC_MSG_ERROR([Could not find wolfSSL.])]
+			[AC_MSG_ERROR([Could not find wolfSSL using pkg-config ${pkg_config_fou=
nd}])]
 		)
 		PKG_CHECK_VAR(
 			[WOLFSSL_INCLUDEDIR],
@@ -1508,7 +1520,7 @@
 PKG_CHECK_MODULES(
 	[CMOCKA], [cmocka],
 	[have_cmocka=3D"yes"],
-	[AC_MSG_WARN([cmocka.pc not found on the system.  Unit tests disabled])]
+	[AC_MSG_WARN([cmocka.pc not found on the system using pkg-config ${pkg_co=
nfig_found}.  Unit tests disabled])]
 )
 AM_CONDITIONAL([ENABLE_UNITTESTS], [test "${enable_unit_tests}" =3D "yes" =
-a "${have_cmocka}" =3D "yes" ])
 AC_SUBST([ENABLE_UNITTESTS])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iebaa35a23e217a4cd7739af229cbfc08a3d8854a
Gerrit-Change-Number: 465
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--yGzb3DpJvi8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review-1 by cron2</p><p>The change is n=
o longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisfi=
ed now.</p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Make it more explicit and visible when pkg-config is not found<br><=
br>Users seem to struggle to read the full error message. This adds an<br>i=
ndication if pkg-config is actually found to the warning/error message<br>t=
hat use pkg-config.<br><br>On platforms that do not require pkg-config and =
for optional libraries,<br>the existence of pkg-config is mentioned as part=
 of the error/warning message.<br><br>When found:<br><br>    configure: err=
or: libnl-genl-3.0 package not found or too old. Is the development package=
 and pkg-config (using /usr/bin/pkg-config) installed? Must be version 3.4.=
0 or newer for DCO<br><br>not found:<br><br>    configure: error: libnl-gen=
l-3.0 package not found or too old. Is the development package and pkg-conf=
ig (not found) installed? Must be version 3.4.0 or newer for DCO<br><br>On =
platforms where pkg-config is required (only Linux at the moment),<br>confi=
gure will abort when not detecting pkg-config:<br><br>checking for pkg-conf=
ig... no<br>configure: error: pkg-config is required<br><br>Change-Id: Ieba=
a35a23e217a4cd7739af229cbfc08a3d8854a<br>Signed-off-by: Arne Schwabe &lt;ar=
ne@...1227...&gt;<br>---<br>M configure.ac<br>1 file changed, 17 insertions=
(+), 5 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/65/465/3</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</=
span><br><span>index f420612..f009fe2 100644</span><br><span>--- a/configur=
e.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -323,6 +323,7 @@=
</span><br><span> 		AM_CONDITIONAL([TARGET_LINUX], [true])</span><br><span>=
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], [&quot;L&quot;], [Target prefix])</s=
pan><br><span> 		have_sitnl=3D&quot;yes&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+		pkg_config_required=3D&quot;yes&quot;</span><br=
><span> 		;;</span><br><span> 	*-*-solaris*)</span><br><span> 		AC_DEFINE([=
TARGET_SOLARIS], [1], [Are we running on Solaris?])</span><br><span>@@ -376=
,6 +377,16 @@</span><br><span> AM_CONDITIONAL([CROSS_COMPILING], test &quot=
;${cross_compiling}&quot; =3D &quot;yes&quot;)</span><br><span> </span><br>=
<span> PKG_PROG_PKG_CONFIG</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# Add variable to print if pkg-config is found or not. Users often m=
iss that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test &qu=
ot;${PKG_CONFIG}&quot; =3D &quot;&quot;; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if test &quot;${pkg_config_required}&quot; =
=3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        AC_MSG_ERROR([pkg-config is required])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	pkg_config_found=3D&quot;(not found)&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	pkg_config_found=3D&quot;(using ${PKG_CONFIG=
})&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> AC_PROG_CP=
P</span><br><span> AC_PROG_INSTALL</span><br><span> AC_PROG_LN_S</span><br>=
<span>@@ -810,7 +821,7 @@</span><br><span> 					  [libnl-genl-3.0 &gt;=3D 3=
.4.0],</span><br><span> 					  [have_libnl=3D&quot;yes&quot;],</span><br><s=
pan> 					  [</span><br><span style=3D"color: hsl(0, 100%, 40%);">-					   =
AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the developme=
nt package and pkg-config installed? Must be version 3.4.0 or newer for DCO=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+					   AC_MSG_ER=
ROR([libnl-genl-3.0 package not found or too old. Is the development packag=
e and pkg-config ${pkg_config_found} installed? Must be version 3.4.0 or ne=
wer for DCO])</span><br><span> 					  ]</span><br><span> 				)</span><br><s=
pan> 				CFLAGS=3D&quot;${CFLAGS} ${LIBNL_GENL_CFLAGS}&quot;</span><br><spa=
n>@@ -854,10 +865,11 @@</span><br><span> dnl</span><br><span> case &quot;$h=
ost&quot; in</span><br><span> 	*-*-linux*)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+		# We require pkg-config</span><br><span> 		PKG_CHE=
CK_MODULES([LIBCAPNG],</span><br><span> 				  [libcap-ng],</span><br><span>=
 				  [],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				  [AC_M=
SG_ERROR([libcap-ng package not found. Is the development package and pkg-c=
onfig installed?])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
				  [AC_MSG_ERROR([libcap-ng package not found. Is the development packag=
e and pkg-config ${pkg_config_found} installed?])]</span><br><span> 		)</sp=
an><br><span> 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h n=
ot found!])])</span><br><span> </span><br><span>@@ -878,7 +890,7 @@</span><=
br><span> 			[OPENSSL],</span><br><span> 			[openssl &gt;=3D 1.0.2],</span>=
<br><span> 			[have_openssl=3D&quot;yes&quot;],</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-			[] # If this fails, we will do another test ne=
xt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[AC_MSG_WARN([=
OpenSSL not found by pkg-config ${pkg_config_found}])] # If this fails, we =
will do another test next</span><br><span> 		)</span><br><span> 		OPENSSL_L=
IBS=3D${OPENSSL_LIBS:--lssl -lcrypto}</span><br><span> 	fi</span><br><span>=
@@ -1083,7 +1095,7 @@</span><br><span> 			[WOLFSSL],</span><br><span> 			[w=
olfssl],</span><br><span> 			[],</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-			[AC_MSG_ERROR([Could not find wolfSSL.])]</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+			[AC_MSG_ERROR([Could not find wolfSS=
L using pkg-config ${pkg_config_found}])]</span><br><span> 		)</span><br><s=
pan> 		PKG_CHECK_VAR(</span><br><span> 			[WOLFSSL_INCLUDEDIR],</span><br><=
span>@@ -1508,7 +1520,7 @@</span><br><span> PKG_CHECK_MODULES(</span><br><s=
pan> 	[CMOCKA], [cmocka],</span><br><span> 	[have_cmocka=3D&quot;yes&quot;]=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_MSG_WARN([cmock=
a.pc not found on the system.  Unit tests disabled])]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	[AC_MSG_WARN([cmocka.pc not found on the=
 system using pkg-config ${pkg_config_found}.  Unit tests disabled])]</span=
><br><span> )</span><br><span> AM_CONDITIONAL([ENABLE_UNITTESTS], [test &qu=
ot;${enable_unit_tests}&quot; =3D &quot;yes&quot; -a &quot;${have_cmocka}&q=
uot; =3D &quot;yes&quot; ])</span><br><span> AC_SUBST([ENABLE_UNITTESTS])</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/465?usp=3Demail">change 465</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/465?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iebaa35a23e217a4cd7739af229c=
bfc08a3d8854a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 465 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--yGzb3DpJvi8=--

