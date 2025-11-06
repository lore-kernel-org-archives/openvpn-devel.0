From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 6 Nov 2025 20:59:29 +0000
References: <gerrit.1762462761000.I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <eb412a23cd39feec1c65721e6fa3fdf24bd2ae4a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xVTd3Bmsokc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win: remove checks
 for PATHCCH_ENSURE_TRAILING_SLASH
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xVTd3Bmsokc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1354?usp=3Demail

to review the following change.


Change subject: win: remove checks for PATHCCH_ENSURE_TRAILING_SLASH
......................................................................

win: remove checks for PATHCCH_ENSURE_TRAILING_SLASH

Since the define is no longer used, remove configuration-time checks if
it exists, and also code dealing with situations where it doesn't.

Change-Id: I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M configure.ac
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/validate.c
3 files changed, 0 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1354/1

diff --git a/configure.ac b/configure.ac
index 3117e13..8f3c01d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1383,17 +1383,6 @@
 	fi
 fi

-if test "${WIN32}" =3D=3D "yes"; then
-	AC_CHECK_DECLS(
-		[PATHCCH_ENSURE_TRAILING_SLASH],
-		[AC_DEFINE([HAVE_PATHCCH_ENSURE_TRAILING_SLASH], [1], [PATHCCH_ENSURE_TR=
AILING_SLASH is defined])],
-		,
-		[[
-			#include <pathcch.h>
-		]]
-	)
-fi
-
 # When testing a compiler option, we add -Werror to force
 # an error when the option is unsupported. This is not
 # required for gcc, but some compilers such as clang need it.
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index a92ee08..2c8f310 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -8,9 +8,6 @@

 include(CheckSymbolExists)

-# Some old versions of mingw does not have PATHCCH_OPTIONS enums -- add a =
check
-check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_E=
NSURE_TRAILING_SLASH)
-
 set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)

 target_include_directories(openvpnserv PRIVATE
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 4eb3141..b674058 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -27,10 +27,6 @@
 #include <pathcch.h>
 #include <lm.h>

-#ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH
-#define PATHCCH_ENSURE_TRAILING_SLASH 0x20
-#endif
-
 static const WCHAR *white_list[] =3D {
     L"auth-retry",
     L"config",

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1354?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b
Gerrit-Change-Number: 1354
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--xVTd3Bmsokc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1354?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">win: remove checks for PATHCCH_ENSURE_TRAIL=
ING_SLASH<br><br>Since the define is no longer used, remove configuration-t=
ime checks if<br>it exists, and also code dealing with situations where it =
doesn&#39;t.<br><br>Change-Id: I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b<br=
>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M configure.a=
c<br>M src/openvpnserv/CMakeLists.txt<br>M src/openvpnserv/validate.c<br>3 =
files changed, 0 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1354/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/configure.ac b/configure.ac</span><br><span>index 3117e13.=
.8f3c01d 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/co=
nfigure.ac</span><br><span>@@ -1383,17 +1383,6 @@</span><br><span> 	fi</spa=
n><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-if test &quot;${WIN32}&quot; =3D=3D &quot;yes&quot;; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_DECLS(</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		[PATHCCH_ENSURE_TRAILING_SLASH=
],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[AC_DEFINE([HAVE_=
PATHCCH_ENSURE_TRAILING_SLASH], [1], [PATHCCH_ENSURE_TRAILING_SLASH is defi=
ned])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		[[</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-			#include &lt;pathcch.h&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-		]]</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # W=
hen testing a compiler option, we add -Werror to force</span><br><span> # a=
n error when the option is unsupported. This is not</span><br><span> # requ=
ired for gcc, but some compilers such as clang need it.</span><br><span>dif=
f --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt</=
span><br><span>index a92ee08..2c8f310 100644</span><br><span>--- a/src/open=
vpnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnserv/CMakeLists.txt=
</span><br><span>@@ -8,9 +8,6 @@</span><br><span> </span><br><span> include=
(CheckSymbolExists)</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# Some old versions of mingw does not have PATHCCH_OPTIONS =
enums -- add a check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
heck_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_ENS=
URE_TRAILING_SLASH)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)</span><br><s=
pan> </span><br><span> target_include_directories(openvpnserv PRIVATE</span=
><br><span>diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/valida=
te.c</span><br><span>index 4eb3141..b674058 100644</span><br><span>--- a/sr=
c/openvpnserv/validate.c</span><br><span>+++ b/src/openvpnserv/validate.c</=
span><br><span>@@ -27,10 +27,6 @@</span><br><span> #include &lt;pathcch.h&g=
t;</span><br><span> #include &lt;lm.h&gt;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifndef HAVE_PATHCCH_ENSURE_TRAILING_=
SLASH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PATHCCH_=
ENSURE_TRAILING_SLASH 0x20</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> static const WCHAR *white_list[] =3D {</span><br><span>     L&quot;=
auth-retry&quot;,</span><br><span>     L&quot;config&quot;,</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1354?usp=3Demail">change 1354</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1354?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I50f189048ef1a624e6ac84b71d7=
b22fcbbc3ab6b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1354 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--xVTd3Bmsokc=--

