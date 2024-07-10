From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 10 Jul 2024 13:57:09 +0000
References: <gerrit.1720619824000.I7927a572611b7c1dc0b522fd6cdf05fd222a852d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <93a0b05c76fa2aa87d9e032b33efa953055208af-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DfcI9a4HH8w="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DfcI9a4HH8w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/674?usp=3Demail

to review the following change.


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
---
M configure.ac
1 file changed, 6 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/674/1

diff --git a/configure.ac b/configure.ac
index dcc46e2..3e7c0be 100644
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
@@ -959,7 +958,7 @@
 		[AC_MSG_ERROR([OpenSSL check for AES-256-GCM support failed])]
 	)

-	# All supported OpenSSL version (>=3D 1.1.0)
+	# All supported OpenSSL versions (>=3D 1.1.0)
 	# have this feature
 	have_export_keying_material=3D"yes"

@@ -1059,9 +1058,8 @@

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
@@ -1252,7 +1250,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--DfcI9a4HH8w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/674?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">configure: Review use of standard AC macros<br><br>- Increase=
 required version to 2.60 since that is documented<br>  minimum version for=
 AC_USE_SYSTEM_EXTENSIONS<br>- Remove obsolete macros AC_C_CONST and AC_C_V=
OLATILE. They<br>  are noops on every compiler we support.<br>- Add explici=
t call to AC_PROG_CC. We get this implictly as<br>  dependency of other mac=
ros, but it is nicer to have it<br>  explicitely as well.<br>- A few typo a=
nd whitespace fixes.<br><br>Change-Id: I7927a572611b7c1dc0b522fd6cdf05fd222=
a852d<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<b=
r>M configure.ac<br>1 file changed, 6 insertions(+), 8 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/674/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/configure.ac b/configure.ac</span><br><span>index dcc46e=
2..3e7c0be 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/=
configure.ac</span><br><span>@@ -23,7 +23,7 @@</span><br><span> </span><br>=
<span> dnl Process this file with autoconf to produce a configure script.</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_PR=
EREQ(2.59)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_PREREQ=
(2.60)</span><br><span> </span><br><span> m4_include(version.m4)</span><br>=
<span> AC_INIT([PRODUCT_NAME], [PRODUCT_VERSION], [PRODUCT_BUGREPORT], [PRO=
DUCT_TARNAME])</span><br><span>@@ -387,6 +387,7 @@</span><br><span> 	pkg_co=
nfig_found=3D&quot;(${PKG_CONFIG})&quot;</span><br><span> fi</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_PROG_CC</span=
><br><span> AC_PROG_CPP</span><br><span> AC_PROG_INSTALL</span><br><span> A=
C_PROG_LN_S</span><br><span>@@ -443,9 +444,7 @@</span><br><span> 	]</span><=
br><span> )</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-AC_C_CONST</span><br><span> AC_C_INLINE</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-AC_C_VOLATILE</span><br><span> AC_TYPE_OFF_T</spa=
n><br><span> AC_TYPE_PID_T</span><br><span> AC_TYPE_SIZE_T</span><br><span>=
@@ -959,7 +958,7 @@</span><br><span> 		[AC_MSG_ERROR([OpenSSL check for AES=
-256-GCM support failed])]</span><br><span> 	)</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	# All supported OpenSSL version=
 (&gt;=3D 1.1.0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	# =
All supported OpenSSL versions (&gt;=3D 1.1.0)</span><br><span> 	# have thi=
s feature</span><br><span> 	have_export_keying_material=3D&quot;yes&quot;</=
span><br><span> </span><br><span>@@ -1059,9 +1058,8 @@</span><br><span> </s=
pan><br><span> elif test &quot;${with_crypto_library}&quot; =3D &quot;wolfs=
sl&quot;; then</span><br><span> 	AC_ARG_VAR([WOLFSSL_CFLAGS], [C compiler f=
lags for wolfssl. The include directory should</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-								  contain the regular wolfSSL header files=
 but also the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-								=
  wolfSSL OpenSSL header files. Ex: -I/usr/local/include</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-								  -I/usr/local/include/wolfssl])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ contain the regula=
r wolfSSL header files but also the wolfSSL OpenSSL header files.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ Ex: -I/usr/local/include -I/=
usr/local/include/wolfssl])</span><br><span> 	AC_ARG_VAR([WOLFSSL_LIBS], [l=
inker flags for wolfssl])</span><br><span> </span><br><span> 	saved_CFLAGS=
=3D&quot;${CFLAGS}&quot;</span><br><span>@@ -1252,7 +1250,7 @@</span><br><s=
pan>                       [PKG_CHECK_MODULES([libsystemd], [libsystemd-dae=
mon])]</span><br><span>                       )</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    PKG_CHECK_EXISTS( [libsyste=
md &gt; 216],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PK=
G_CHECK_EXISTS([libsystemd &gt; 216],</span><br><span>                     =
 [AC_DEFINE([SYSTEMD_NEWER_THAN_216], [1],</span><br><span>                =
            [systemd is newer than v216])]</span><br><span>                =
     )</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/674?usp=3Demail">change 674</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/674?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7927a572611b7c1dc0b522fd6cd=
f05fd222a852d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 674 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--DfcI9a4HH8w=--

