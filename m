From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 5 Jan 2024 13:49:27 +0000
In-Reply-To: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
References: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296..., a@...2181...
Message-ID: <15c4510d1dcec6cc80c80c99890113e11d0bbce4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="96G+UkislvA="; charset=UTF-8
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

--96G+UkislvA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex.

Hello cron2, flichtenheld, ordex,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail

to look at the new patch set (#5).


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
evelopment package and pkg-config (/usr/bin/pkg-config) installed? Must be =
version 3.4.0 or newer for DCO

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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/465/5

diff --git a/configure.ac b/configure.ac
index f420612..3ad9f14 100644
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
+	if test "${pkg_config_required}" =3D "yes"; then
+		AC_MSG_ERROR([pkg-config is required])
+	fi
+	pkg_config_found=3D"(not found)"
+else
+	pkg_config_found=3D"(${PKG_CONFIG})"
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--96G+UkislvA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Make it more explicit and visible when pkg-config is not found<br><br=
>Users seem to struggle to read the full error message. This adds an<br>ind=
ication if pkg-config is actually found to the warning/error message<br>tha=
t use pkg-config.<br><br>On platforms that do not require pkg-config and fo=
r optional libraries,<br>the existence of pkg-config is mentioned as part o=
f the error/warning message.<br><br>When found:<br><br>    configure: error=
: libnl-genl-3.0 package not found or too old. Is the development package a=
nd pkg-config (/usr/bin/pkg-config) installed? Must be version 3.4.0 or new=
er for DCO<br><br>not found:<br><br>    configure: error: libnl-genl-3.0 pa=
ckage not found or too old. Is the development package and pkg-config (not =
found) installed? Must be version 3.4.0 or newer for DCO<br><br>On platform=
s where pkg-config is required (only Linux at the moment),<br>configure wil=
l abort when not detecting pkg-config:<br><br>checking for pkg-config... no=
<br>configure: error: pkg-config is required<br><br>Change-Id: Iebaa35a23e2=
17a4cd7739af229cbfc08a3d8854a<br>Signed-off-by: Arne Schwabe &lt;arne@...1711...=
27...&gt;<br>---<br>M configure.ac<br>1 file changed, 17 insertions(+), 5 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/65/465/5</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span><br=
><span>index f420612..3ad9f14 100644</span><br><span>--- a/configure.ac</sp=
an><br><span>+++ b/configure.ac</span><br><span>@@ -323,6 +323,7 @@</span><=
br><span> 		AM_CONDITIONAL([TARGET_LINUX], [true])</span><br><span> 		AC_DE=
FINE_UNQUOTED([TARGET_PREFIX], [&quot;L&quot;], [Target prefix])</span><br>=
<span> 		have_sitnl=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+		pkg_config_required=3D&quot;yes&quot;</span><br><span> =
		;;</span><br><span> 	*-*-solaris*)</span><br><span> 		AC_DEFINE([TARGET_S=
OLARIS], [1], [Are we running on Solaris?])</span><br><span>@@ -376,6 +377,=
16 @@</span><br><span> AM_CONDITIONAL([CROSS_COMPILING], test &quot;${cross=
_compiling}&quot; =3D &quot;yes&quot;)</span><br><span> </span><br><span> P=
KG_PROG_PKG_CONFIG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 Add variable to print if pkg-config is found or not. Users often miss that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test &quot;${PKG=
_CONFIG}&quot; =3D &quot;&quot;; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	if test &quot;${pkg_config_required}&quot; =3D &quot;yes=
&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_MS=
G_ERROR([pkg-config is required])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	p=
kg_config_found=3D&quot;(not found)&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	pkg_config_found=3D&quot;(${PKG_CONFIG})&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> AC_PROG_CPP</span><br><span> AC_PROG_IN=
STALL</span><br><span> AC_PROG_LN_S</span><br><span>@@ -810,7 +821,7 @@</sp=
an><br><span> 					  [libnl-genl-3.0 &gt;=3D 3.4.0],</span><br><span> 					=
  [have_libnl=3D&quot;yes&quot;],</span><br><span> 					  [</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-					   AC_MSG_ERROR([libnl-genl-3.0 =
package not found or too old. Is the development package and pkg-config ins=
talled? Must be version 3.4.0 or newer for DCO])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+					   AC_MSG_ERROR([libnl-genl-3.0 package n=
ot found or too old. Is the development package and pkg-config ${pkg_config=
_found} installed? Must be version 3.4.0 or newer for DCO])</span><br><span=
> 					  ]</span><br><span> 				)</span><br><span> 				CFLAGS=3D&quot;${CFL=
AGS} ${LIBNL_GENL_CFLAGS}&quot;</span><br><span>@@ -854,10 +865,11 @@</span=
><br><span> dnl</span><br><span> case &quot;$host&quot; in</span><br><span>=
 	*-*-linux*)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		# We=
 require pkg-config</span><br><span> 		PKG_CHECK_MODULES([LIBCAPNG],</span>=
<br><span> 				  [libcap-ng],</span><br><span> 				  [],</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-				  [AC_MSG_ERROR([libcap-ng package n=
ot found. Is the development package and pkg-config installed?])]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+				  [AC_MSG_ERROR([libcap-n=
g package not found. Is the development package and pkg-config ${pkg_config=
_found} installed?])]</span><br><span> 		)</span><br><span> 		AC_CHECK_HEAD=
ER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])])</span><br><span=
> </span><br><span>@@ -878,7 +890,7 @@</span><br><span> 			[OPENSSL],</span=
><br><span> 			[openssl &gt;=3D 1.0.2],</span><br><span> 			[have_openssl=
=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
		[] # If this fails, we will do another test next</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+			[AC_MSG_WARN([OpenSSL not found by pkg-co=
nfig ${pkg_config_found}])] # If this fails, we will do another test next</=
span><br><span> 		)</span><br><span> 		OPENSSL_LIBS=3D${OPENSSL_LIBS:--lssl=
 -lcrypto}</span><br><span> 	fi</span><br><span>@@ -1083,7 +1095,7 @@</span=
><br><span> 			[WOLFSSL],</span><br><span> 			[wolfssl],</span><br><span> 	=
		[],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[AC_MSG_ERROR=
([Could not find wolfSSL.])]</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+			[AC_MSG_ERROR([Could not find wolfSSL using pkg-config ${pkg_co=
nfig_found}])]</span><br><span> 		)</span><br><span> 		PKG_CHECK_VAR(</span=
><br><span> 			[WOLFSSL_INCLUDEDIR],</span><br><span>@@ -1508,7 +1520,7 @@<=
/span><br><span> PKG_CHECK_MODULES(</span><br><span> 	[CMOCKA], [cmocka],</=
span><br><span> 	[have_cmocka=3D&quot;yes&quot;],</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	[AC_MSG_WARN([cmocka.pc not found on the syste=
m.  Unit tests disabled])]</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	[AC_MSG_WARN([cmocka.pc not found on the system using pkg-config ${=
pkg_config_found}.  Unit tests disabled])]</span><br><span> )</span><br><sp=
an> AM_CONDITIONAL([ENABLE_UNITTESTS], [test &quot;${enable_unit_tests}&quo=
t; =3D &quot;yes&quot; -a &quot;${have_cmocka}&quot; =3D &quot;yes&quot; ])=
</span><br><span> AC_SUBST([ENABLE_UNITTESTS])</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465=
?usp=3Demail">change 465</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iebaa35a23e217a4cd7739af229c=
bfc08a3d8854a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 465 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--96G+UkislvA=--

