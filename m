From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Dec 2023 14:04:03 +0000
In-Reply-To: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
References: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <96e4da1db026da72a22134f3d53ec528caa75599-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5qAWX6m3whs="; charset=UTF-8
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

--5qAWX6m3whs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/465/2

diff --git a/configure.ac b/configure.ac
index 54f79ab..a80de7f 100644
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
+	pkg_config_found=3D"(using ${PKG_CONFIG})"
+fi
+
+
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S
@@ -816,7 +824,7 @@
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
@@ -860,10 +868,11 @@
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

@@ -884,7 +893,7 @@
 			[OPENSSL],
 			[openssl >=3D 1.0.2],
 			[have_openssl=3D"yes"],
-			[] # If this fails, we will do another test next
+			[AC_MSG_WARN([OpenSSL not found by pkg-config ${pkg_config_found}])] # =
If this fails, we will do another test next
 		)
 		OPENSSL_LIBS=3D${OPENSSL_LIBS:--lssl -lcrypto}
 	fi
@@ -1089,7 +1098,7 @@
 			[WOLFSSL],
 			[wolfssl],
 			[],
-			[AC_MSG_ERROR([Could not find wolfSSL.])]
+			[AC_MSG_ERROR([Could not find wolfSSL using pkg-config ${pkg_config_fou=
nd}])]
 		)
 		PKG_CHECK_VAR(
 			[WOLFSSL_INCLUDEDIR],
@@ -1513,7 +1522,7 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--5qAWX6m3whs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Make it more explicit and visible when pkg-co=
nfig is not found<br><br>Users seem to struggle to read the full error mess=
age. This adds an<br>indication if pkg-config is actually found to the warn=
ing/error message<br>that use pkg-config.<br><br>When found:<br><br>    con=
figure: error: libnl-genl-3.0 package not found or too old. Is the developm=
ent package and pkg-config (using /usr/bin/pkg-config) installed? Must be v=
ersion 3.4.0 or newer for DCO<br><br>not found:<br><br>    configure: error=
: libnl-genl-3.0 package not found or too old. Is the development package a=
nd pkg-config (not found) installed? Must be version 3.4.0 or newer for DCO=
<br><br>Change-Id: Iebaa35a23e217a4cd7739af229cbfc08a3d8854a<br>Signed-off-=
by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M configure.ac<br>1 file=
 changed, 14 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/65/465/2</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/config=
ure.ac b/configure.ac</span><br><span>index 54f79ab..a80de7f 100644</span><=
br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><s=
pan>@@ -382,6 +382,14 @@</span><br><span> AM_CONDITIONAL([CROSS_COMPILING],=
 test &quot;${cross_compiling}&quot; =3D &quot;yes&quot;)</span><br><span> =
</span><br><span> PKG_PROG_PKG_CONFIG</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# Add variable to print if pkg-config is found or not. Us=
ers often miss that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if test &quot;${PKG_CONFIG}&quot; =3D &quot;&quot;; then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	pkg_config_found=3D&quot;(not found)&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	pkg_config_found=3D&quot;(us=
ing ${PKG_CONFIG})&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> AC_PROG_CPP</=
span><br><span> AC_PROG_INSTALL</span><br><span> AC_PROG_LN_S</span><br><sp=
an>@@ -816,7 +824,7 @@</span><br><span> 					  [libnl-genl-3.0 &gt;=3D 3.4.=
0],</span><br><span> 					  [have_libnl=3D&quot;yes&quot;],</span><br><span=
> 					  [</span><br><span style=3D"color: hsl(0, 100%, 40%);">-					   AC_=
MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development =
package and pkg-config installed? Must be version 3.4.0 or newer for DCO])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+					   AC_MSG_ERROR=
([libnl-genl-3.0 package not found or too old. Is the development package a=
nd pkg-config ${pkg_config_found} installed? Must be version 3.4.0 or newer=
 for DCO])</span><br><span> 					  ]</span><br><span> 				)</span><br><span=
> 				CFLAGS=3D&quot;${CFLAGS} ${LIBNL_GENL_CFLAGS}&quot;</span><br><span>@=
@ -860,10 +868,11 @@</span><br><span> dnl</span><br><span> case &quot;$host=
&quot; in</span><br><span> 	*-*-linux*)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+		# We require pkg-config</span><br><span> 		PKG_CHECK_=
MODULES([LIBCAPNG],</span><br><span> 				  [libcap-ng],</span><br><span> 		=
		  [],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-				  [AC_MSG_=
ERROR([libcap-ng package not found. Is the development package and pkg-conf=
ig installed?])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			=
	  [AC_MSG_ERROR([libcap-ng package not found. Is the development package a=
nd pkg-config ${pkg_config_found} installed?])]</span><br><span> 		)</span>=
<br><span> 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not =
found!])])</span><br><span> </span><br><span>@@ -884,7 +893,7 @@</span><br>=
<span> 			[OPENSSL],</span><br><span> 			[openssl &gt;=3D 1.0.2],</span><br=
><span> 			[have_openssl=3D&quot;yes&quot;],</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-			[] # If this fails, we will do another test next<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[AC_MSG_WARN([Ope=
nSSL not found by pkg-config ${pkg_config_found}])] # If this fails, we wil=
l do another test next</span><br><span> 		)</span><br><span> 		OPENSSL_LIBS=
=3D${OPENSSL_LIBS:--lssl -lcrypto}</span><br><span> 	fi</span><br><span>@@ =
-1089,7 +1098,7 @@</span><br><span> 			[WOLFSSL],</span><br><span> 			[wolf=
ssl],</span><br><span> 			[],</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-			[AC_MSG_ERROR([Could not find wolfSSL.])]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+			[AC_MSG_ERROR([Could not find wolfSSL =
using pkg-config ${pkg_config_found}])]</span><br><span> 		)</span><br><spa=
n> 		PKG_CHECK_VAR(</span><br><span> 			[WOLFSSL_INCLUDEDIR],</span><br><sp=
an>@@ -1513,7 +1522,7 @@</span><br><span> PKG_CHECK_MODULES(</span><br><spa=
n> 	[CMOCKA], [cmocka],</span><br><span> 	[have_cmocka=3D&quot;yes&quot;],<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_MSG_WARN([cmocka.=
pc not found on the system.  Unit tests disabled])]</span><br><span style=
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
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5qAWX6m3whs=--

