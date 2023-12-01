From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 1 Dec 2023 13:12:16 +0000
References: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f1de9d2ba3fd1a9234a7b42adbd04aa044926bc2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/BMRh6YWYHg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/BMRh6YWYHg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail

to review the following change.


Change subject: Make it more explicit and visible when pkg-config is not fo=
und
......................................................................

Make it more explicit and visible when pkg-config is not found

Users seem to struggle to read the full error message. This adds an
indication if pkg-config is actually found to the warning/error message
that use pkg-config.

When found:

    configure: error: libnl-genl-3.0 package not found or too old. Is the d=
evelopment package and pkg-config (using /usr/bin/pkg-config) installed? Mu=
st be version 3.4.0 or newer for DCO

not found:

    configure: error: libnl-genl-3.0 package not found or too old. Is the d=
evelopment package and pkg-config (not found) installed? Must be version 3.=
4.0 or newer for DCO

Change-Id: Iebaa35a23e217a4cd7739af229cbfc08a3d8854a
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M configure.ac
1 file changed, 14 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/465/1

diff --git a/configure.ac b/configure.ac
index 84eaad6..2e3cbee 100644
--- a/configure.ac
+++ b/configure.ac
@@ -382,6 +382,14 @@
 AM_CONDITIONAL([CROSS_COMPILING], test "${cross_compiling}" =3D "yes")

 PKG_PROG_PKG_CONFIG
+# Add variable to print if pkg-config is found or not. Users often miss th=
at
+if test "${PKG_CONFIG}" =3D ""; then
+	pkg_config_found=3D"(not found)"
+else
+    pkg_config_found=3D"(using ${PKG_CONFIG})"
+fi
+
+
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S
@@ -818,7 +826,7 @@
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
@@ -862,10 +870,11 @@
 dnl
 case "$host" in
 	*-*-linux*)
+	    # We require pkg-config
 		PKG_CHECK_MODULES([LIBCAPNG],
 				  [libcap-ng],
 				  [],
-				  [AC_MSG_ERROR([libcap-ng package not found. Is the development packa=
ge and pkg-config installed?])]
+				  [AC_MSG_ERROR([libcap-ng package not found. Is the development packa=
ge and pkg-config ${pkg_config_found} installed?])]
 		)
 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])])

@@ -886,7 +895,7 @@
 			[OPENSSL],
 			[openssl >=3D 1.0.2],
 			[have_openssl=3D"yes"],
-			[] # If this fails, we will do another test next
+			[AC_MSG_WARN([OpenSSL not found by pkg-config ${pkg_config_found}])] # =
If this fails, we will do another test next
 		)
 		OPENSSL_LIBS=3D${OPENSSL_LIBS:--lssl -lcrypto}
 	fi
@@ -1091,7 +1100,7 @@
 			[WOLFSSL],
 			[wolfssl],
 			[],
-			[AC_MSG_ERROR([Could not find wolfSSL.])]
+			[AC_MSG_ERROR([Could not find wolfSSL using pkg-config ${pkg_config_fou=
nd}])]
 		)
 		PKG_CHECK_VAR(
 			[WOLFSSL_INCLUDEDIR],
@@ -1515,7 +1524,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--/BMRh6YWYHg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Make it more explicit and visible when pkg-config is not foun=
d<br><br>Users seem to struggle to read the full error message. This adds a=
n<br>indication if pkg-config is actually found to the warning/error messag=
e<br>that use pkg-config.<br><br>When found:<br><br>    configure: error: l=
ibnl-genl-3.0 package not found or too old. Is the development package and =
pkg-config (using /usr/bin/pkg-config) installed? Must be version 3.4.0 or =
newer for DCO<br><br>not found:<br><br>    configure: error: libnl-genl-3.0=
 package not found or too old. Is the development package and pkg-config (n=
ot found) installed? Must be version 3.4.0 or newer for DCO<br><br>Change-I=
d: Iebaa35a23e217a4cd7739af229cbfc08a3d8854a<br>Signed-off-by: Arne Schwabe=
 &lt;arne@...1227...&gt;<br>---<br>M configure.ac<br>1 file changed, 14 ins=
ertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/65/465/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/configure.ac b/configu=
re.ac</span><br><span>index 84eaad6..2e3cbee 100644</span><br><span>--- a/c=
onfigure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -382,6 +3=
82,14 @@</span><br><span> AM_CONDITIONAL([CROSS_COMPILING], test &quot;${cr=
oss_compiling}&quot; =3D &quot;yes&quot;)</span><br><span> </span><br><span=
> PKG_PROG_PKG_CONFIG</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# Add variable to print if pkg-config is found or not. Users often miss t=
hat</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test &quot;${=
PKG_CONFIG}&quot; =3D &quot;&quot;; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	pkg_config_found=3D&quot;(not found)&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    pkg_config_found=3D&quot;(using ${PKG_CON=
FIG})&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> AC_PROG_CPP</span><br><spa=
n> AC_PROG_INSTALL</span><br><span> AC_PROG_LN_S</span><br><span>@@ -818,7 =
+826,7 @@</span><br><span> 					  [libnl-genl-3.0 &gt;=3D 3.4.0],</span><br=
><span> 					  [have_libnl=3D&quot;yes&quot;],</span><br><span> 					  [</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-					   AC_MSG_ERROR([li=
bnl-genl-3.0 package not found or too old. Is the development package and p=
kg-config installed? Must be version 3.4.0 or newer for DCO])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+					   AC_MSG_ERROR([libnl-genl-=
3.0 package not found or too old. Is the development package and pkg-config=
 ${pkg_config_found} installed? Must be version 3.4.0 or newer for DCO])</s=
pan><br><span> 					  ]</span><br><span> 				)</span><br><span> 				CFLAGS=
=3D&quot;${CFLAGS} ${LIBNL_GENL_CFLAGS}&quot;</span><br><span>@@ -862,10 +8=
70,11 @@</span><br><span> dnl</span><br><span> case &quot;$host&quot; in</s=
pan><br><span> 	*-*-linux*)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	    # We require pkg-config</span><br><span> 		PKG_CHECK_MODULES([=
LIBCAPNG],</span><br><span> 				  [libcap-ng],</span><br><span> 				  [],</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-				  [AC_MSG_ERROR([li=
bcap-ng package not found. Is the development package and pkg-config instal=
led?])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				  [AC_MS=
G_ERROR([libcap-ng package not found. Is the development package and pkg-co=
nfig ${pkg_config_found} installed?])]</span><br><span> 		)</span><br><span=
> 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])]=
)</span><br><span> </span><br><span>@@ -886,7 +895,7 @@</span><br><span> 		=
	[OPENSSL],</span><br><span> 			[openssl &gt;=3D 1.0.2],</span><br><span> 	=
		[have_openssl=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-			[] # If this fails, we will do another test next</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+			[AC_MSG_WARN([OpenSSL not =
found by pkg-config ${pkg_config_found}])] # If this fails, we will do anot=
her test next</span><br><span> 		)</span><br><span> 		OPENSSL_LIBS=3D${OPEN=
SSL_LIBS:--lssl -lcrypto}</span><br><span> 	fi</span><br><span>@@ -1091,7 +=
1100,7 @@</span><br><span> 			[WOLFSSL],</span><br><span> 			[wolfssl],</sp=
an><br><span> 			[],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
		[AC_MSG_ERROR([Could not find wolfSSL.])]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+			[AC_MSG_ERROR([Could not find wolfSSL using pkg-=
config ${pkg_config_found}])]</span><br><span> 		)</span><br><span> 		PKG_C=
HECK_VAR(</span><br><span> 			[WOLFSSL_INCLUDEDIR],</span><br><span>@@ -151=
5,7 +1524,7 @@</span><br><span> PKG_CHECK_MODULES(</span><br><span> 	[CMOCK=
A], [cmocka],</span><br><span> 	[have_cmocka=3D&quot;yes&quot;],</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	[AC_MSG_WARN([cmocka.pc not fou=
nd on the system.  Unit tests disabled])]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	[AC_MSG_WARN([cmocka.pc not found on the system usin=
g pkg-config ${pkg_config_found}.  Unit tests disabled])]</span><br><span> =
)</span><br><span> AM_CONDITIONAL([ENABLE_UNITTESTS], [test &quot;${enable_=
unit_tests}&quot; =3D &quot;yes&quot; -a &quot;${have_cmocka}&quot; =3D &qu=
ot;yes&quot; ])</span><br><span> AC_SUBST([ENABLE_UNITTESTS])</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/465?usp=3Demail">change 465</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iebaa35a23e217a4cd7739af229c=
bfc08a3d8854a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 465 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--/BMRh6YWYHg=--

