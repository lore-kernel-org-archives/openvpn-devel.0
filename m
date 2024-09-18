From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Sep 2024 21:00:56 +0000
In-Reply-To: <gerrit.1720619824000.I7927a572611b7c1dc0b522fd6cdf05fd222a852d@...2715...>
References: <gerrit.1720619824000.I7927a572611b7c1dc0b522fd6cdf05fd222a852d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <872f19daff5a61ebe366ddb5d52f388fcc93af50-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fkKL+G3bdvM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Review
 use of standard AC macros
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

--fkKL+G3bdvM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/674?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: configure: Review use of standard AC macros
......................................................................

configure: Review use of standard AC macros

- Increase required version to 2.60 since that is documented
  minimum version for AC_USE_SYSTEM_EXTENSIONS
- Remove obsolete macros AC_C_CONST and AC_C_VOLATILE. They
  are noops on every compiler we support.
- Add explicit call to AC_PROG_CC. We get this implictly as
  dependency of other macros, but it is nicer to have it
  explicitely as well.
- A few typo and whitespace fixes.

Change-Id: I7927a572611b7c1dc0b522fd6cdf05fd222a852d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240918204551.2530-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
321.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
1 file changed, 6 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/674/4

diff --git a/configure.ac b/configure.ac
index 5d7d0fc..0876a6a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,7 +23,7 @@

 dnl Process this file with autoconf to produce a configure script.

-AC_PREREQ(2.59)
+AC_PREREQ(2.60)

 m4_include(version.m4)
 AC_INIT([PRODUCT_NAME], [PRODUCT_VERSION], [PRODUCT_BUGREPORT], [PRODUCT_T=
ARNAME])
@@ -387,6 +387,7 @@
 	pkg_config_found=3D"(${PKG_CONFIG})"
 fi

+AC_PROG_CC
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S
@@ -443,9 +444,7 @@
 	]
 )

-AC_C_CONST
 AC_C_INLINE
-AC_C_VOLATILE
 AC_TYPE_OFF_T
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
@@ -958,7 +957,7 @@
 		[AC_MSG_ERROR([OpenSSL check for AES-256-GCM support failed])]
 	)

-	# All supported OpenSSL version (>=3D 1.1.0)
+	# All supported OpenSSL versions (>=3D 1.1.0)
 	# have this feature
 	have_export_keying_material=3D"yes"

@@ -1065,9 +1064,8 @@

 elif test "${with_crypto_library}" =3D "wolfssl"; then
 	AC_ARG_VAR([WOLFSSL_CFLAGS], [C compiler flags for wolfssl. The include d=
irectory should
-								  contain the regular wolfSSL header files but also the
-								  wolfSSL OpenSSL header files. Ex: -I/usr/local/include
-								  -I/usr/local/include/wolfssl])
+ contain the regular wolfSSL header files but also the wolfSSL OpenSSL hea=
der files.
+ Ex: -I/usr/local/include -I/usr/local/include/wolfssl])
 	AC_ARG_VAR([WOLFSSL_LIBS], [linker flags for wolfssl])

 	saved_CFLAGS=3D"${CFLAGS}"
@@ -1258,7 +1256,7 @@
                       [PKG_CHECK_MODULES([libsystemd], [libsystemd-daemon]=
)]
                       )

-    PKG_CHECK_EXISTS( [libsystemd > 216],
+    PKG_CHECK_EXISTS([libsystemd > 216],
                      [AC_DEFINE([SYSTEMD_NEWER_THAN_216], [1],
                            [systemd is newer than v216])]
                     )

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/674?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7927a572611b7c1dc0b522fd6cdf05fd222a852d
Gerrit-Change-Number: 674
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--fkKL+G3bdvM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/674?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">configure: Review use of standard AC macros<br><br>-=
 Increase required version to 2.60 since that is documented<br>  minimum ve=
rsion for AC_USE_SYSTEM_EXTENSIONS<br>- Remove obsolete macros AC_C_CONST a=
nd AC_C_VOLATILE. They<br>  are noops on every compiler we support.<br>- Ad=
d explicit call to AC_PROG_CC. We get this implictly as<br>  dependency of =
other macros, but it is nicer to have it<br>  explicitely as well.<br>- A f=
ew typo and whitespace fixes.<br><br>Change-Id: I7927a572611b7c1dc0b522fd6c=
df05fd222a852d<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240=
918204551.2530-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/o=
penvpn-devel@lists.sourceforge.net/msg29321.html<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M configure.ac<br>1 file changed, 6 =
insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/74/674/4</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/configure.ac b/conf=
igure.ac</span><br><span>index 5d7d0fc..0876a6a 100644</span><br><span>--- =
a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -23,7 =
+23,7 @@</span><br><span> </span><br><span> dnl Process this file with auto=
conf to produce a configure script.</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-AC_PREREQ(2.59)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+AC_PREREQ(2.60)</span><br><span> </span><br><sp=
an> m4_include(version.m4)</span><br><span> AC_INIT([PRODUCT_NAME], [PRODUC=
T_VERSION], [PRODUCT_BUGREPORT], [PRODUCT_TARNAME])</span><br><span>@@ -387=
,6 +387,7 @@</span><br><span> 	pkg_config_found=3D&quot;(${PKG_CONFIG})&quo=
t;</span><br><span> fi</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+AC_PROG_CC</span><br><span> AC_PROG_CPP</span><br><spa=
n> AC_PROG_INSTALL</span><br><span> AC_PROG_LN_S</span><br><span>@@ -443,9 =
+444,7 @@</span><br><span> 	]</span><br><span> )</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-AC_C_CONST</span><br><span> AC=
_C_INLINE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_C_VOLATIL=
E</span><br><span> AC_TYPE_OFF_T</span><br><span> AC_TYPE_PID_T</span><br><=
span> AC_TYPE_SIZE_T</span><br><span>@@ -958,7 +957,7 @@</span><br><span> 	=
	[AC_MSG_ERROR([OpenSSL check for AES-256-GCM support failed])]</span><br><=
span> 	)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	# All supported OpenSSL version (&gt;=3D 1.1.0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	# All supported OpenSSL versions (&gt;=
=3D 1.1.0)</span><br><span> 	# have this feature</span><br><span> 	have_exp=
ort_keying_material=3D&quot;yes&quot;</span><br><span> </span><br><span>@@ =
-1065,9 +1064,8 @@</span><br><span> </span><br><span> elif test &quot;${wit=
h_crypto_library}&quot; =3D &quot;wolfssl&quot;; then</span><br><span> 	AC_=
ARG_VAR([WOLFSSL_CFLAGS], [C compiler flags for wolfssl. The include direct=
ory should</span><br><span style=3D"color: hsl(0, 100%, 40%);">-								  c=
ontain the regular wolfSSL header files but also the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-								  wolfSSL OpenSSL header files. Ex:=
 -I/usr/local/include</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
								  -I/usr/local/include/wolfssl])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ contain the regular wolfSSL header files but also the=
 wolfSSL OpenSSL header files.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ Ex: -I/usr/local/include -I/usr/local/include/wolfssl])</span><=
br><span> 	AC_ARG_VAR([WOLFSSL_LIBS], [linker flags for wolfssl])</span><br=
><span> </span><br><span> 	saved_CFLAGS=3D&quot;${CFLAGS}&quot;</span><br><=
span>@@ -1258,7 +1256,7 @@</span><br><span>                       [PKG_CHEC=
K_MODULES([libsystemd], [libsystemd-daemon])]</span><br><span>             =
          )</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    PKG_CHECK_EXISTS( [libsystemd &gt; 216],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    PKG_CHECK_EXISTS([libsystemd &gt; 216=
],</span><br><span>                      [AC_DEFINE([SYSTEMD_NEWER_THAN_216=
], [1],</span><br><span>                            [systemd is newer than =
v216])]</span><br><span>                     )</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/674=
?usp=3Demail">change 674</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/674?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7927a572611b7c1dc0b522fd6cd=
f05fd222a852d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 674 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--fkKL+G3bdvM=--

