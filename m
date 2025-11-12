From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 10:38:00 +0000
In-Reply-To: <gerrit.1762462761000.I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b@...2715...>
References: <gerrit.1762462761000.I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <08d51eb205cf544a7cc89947c0cf226eb654ba2d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Nl8147IHd78="; charset=UTF-8
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
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Nl8147IHd78=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1354?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


Change subject: win: remove checks for PATHCCH_ENSURE_TRAILING_SLASH
......................................................................

win: remove checks for PATHCCH_ENSURE_TRAILING_SLASH

Since the define is no longer used, remove configuration-time checks if
it exists, and also code dealing with situations where it doesn't.

Change-Id: I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1354
Message-Id: <20251112092216.22703-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
335.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/validate.c
3 files changed, 0 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1354/6

diff --git a/configure.ac b/configure.ac
index f6e4b6d..44c7b65 100644
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
index 2dcfe1a..b3189b7 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b
Gerrit-Change-Number: 1354
Gerrit-PatchSet: 6
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Nl8147IHd78=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1354?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by stipa</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">win: remove checks for PATHCCH_ENSU=
RE_TRAILING_SLASH<br><br>Since the define is no longer used, remove configu=
ration-time checks if<br>it exists, and also code dealing with situations w=
here it doesn&#39;t.<br><br>Change-Id: I50f189048ef1a624e6ac84b71d7b22fcbbc=
3ab6b<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Le=
v Stipakov &lt;lstipakov@...277...&gt;<br>Gerrit URL: https://gerrit.openvp=
n.net/c/openvpn/+/1354<br>Message-Id: &lt;20251112092216.22703-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg34335.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M configure.ac<br>M src/openvpnserv/CMakeLists.txt<br>M src/ope=
nvpnserv/validate.c<br>3 files changed, 0 insertions(+), 18 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/54/1354/6</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span=
><br><span>index f6e4b6d..44c7b65 100644</span><br><span>--- a/configure.ac=
</span><br><span>+++ b/configure.ac</span><br><span>@@ -1383,17 +1383,6 @@<=
/span><br><span> 	fi</span><br><span> fi</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-if test &quot;${WIN32}&quot; =3D=3D &q=
uot;yes&quot;; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	A=
C_CHECK_DECLS(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[PATH=
CCH_ENSURE_TRAILING_SLASH],</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-		[AC_DEFINE([HAVE_PATHCCH_ENSURE_TRAILING_SLASH], [1], [PATHCCH_ENSU=
RE_TRAILING_SLASH is defined])],</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-		,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[[</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-			#include &lt;pathcch.=
h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		]]</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> # When testing a compiler option, we add -Werror to f=
orce</span><br><span> # an error when the option is unsupported. This is no=
t</span><br><span> # required for gcc, but some compilers such as clang nee=
d it.</span><br><span>diff --git a/src/openvpnserv/CMakeLists.txt b/src/ope=
nvpnserv/CMakeLists.txt</span><br><span>index a92ee08..2c8f310 100644</span=
><br><span>--- a/src/openvpnserv/CMakeLists.txt</span><br><span>+++ b/src/o=
penvpnserv/CMakeLists.txt</span><br><span>@@ -8,9 +8,6 @@</span><br><span> =
</span><br><span> include(CheckSymbolExists)</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# Some old versions of mingw does =
not have PATHCCH_OPTIONS enums -- add a check</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH p=
athcch.h HAVE_PATHCCH_ENSURE_TRAILING_SLASH)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> set(MC_GEN_DIR ${CMAKE_CURRENT_BIN=
ARY_DIR}/mc)</span><br><span> </span><br><span> target_include_directories(=
openvpnserv PRIVATE</span><br><span>diff --git a/src/openvpnserv/validate.c=
 b/src/openvpnserv/validate.c</span><br><span>index 2dcfe1a..b3189b7 100644=
</span><br><span>--- a/src/openvpnserv/validate.c</span><br><span>+++ b/src=
/openvpnserv/validate.c</span><br><span>@@ -27,10 +27,6 @@</span><br><span>=
 #include &lt;pathcch.h&gt;</span><br><span> #include &lt;lm.h&gt;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef HAVE=
_PATHCCH_ENSURE_TRAILING_SLASH</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define PATHCCH_ENSURE_TRAILING_SLASH 0x20</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static const WCHAR *white_list[] =3D {</=
span><br><span>     L&quot;auth-retry&quot;,</span><br><span>     L&quot;co=
nfig&quot;,</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1354?usp=3Demail">change 1354</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1354?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I50f189048ef1a624e6ac84b71d7=
b22fcbbc3ab6b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1354 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Nl8147IHd78=--

