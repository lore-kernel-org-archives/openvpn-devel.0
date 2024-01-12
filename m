From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 12 Jan 2024 12:43:22 +0000
In-Reply-To: <gerrit.1704979923000.Ic19f859c3aca8b30aa51b12dcb906a6e7e735019@...2715...>
References: <gerrit.1704979923000.Ic19f859c3aca8b30aa51b12dcb906a6e7e735019@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7fe210802557152c826b3da6c157a0d43f7678a1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JW/yfOUCno0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: CMakeLists.txt:
 Don't fail on missing compile_commands.json
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

--JW/yfOUCno0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/495?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: CMakeLists.txt: Don't fail on missing compile_commands.json
......................................................................

CMakeLists.txt: Don't fail on missing compile_commands.json

Commit

    855030f3 ("cmake: create and link compile_commands.json file")

added creation of compile commands file and a symbolic link to it.

There a two issues:

 - CMAKE_EXPORT_COMPILE_COMMANDS works only on Ninja and Makefile
generators and doesn't produce anything on MSVC.

 - creating symlink on Windows by default requires an elevated prompt,
which is not normally the case (but it turned out is the case for GHA).
Without elevated prompt this fails the build.

Fix by make symlink creation non-fatal by providing variable
to store result.

Change-Id: Ic19f859c3aca8b30aa51b12dcb906a6e7e735019
Signed-off-by: Lev Stipakov <lev@...515...>
---
M CMakeLists.txt
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/495/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index bc46c27..5c6fff0 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -45,7 +45,7 @@
 # Create machine readable compile commands
 set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
 file(CREATE_LINK ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json
-                 ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json SYMBOLI=
C)
+                 ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json RESULT =
COMPILE_COMMANDS_CREATED SYMBOLIC)

 # AddressSanitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TYPE=
=3Dasan to build with ASAN
 set(CMAKE_C_FLAGS_ASAN

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/495?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic19f859c3aca8b30aa51b12dcb906a6e7e735019
Gerrit-Change-Number: 495
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--JW/yfOUCno0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/495?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">CMakeLists.txt: Don&#39;t fail on missing com=
pile_commands.json<br><br>Commit<br><br>    855030f3 (&quot;cmake: create a=
nd link compile_commands.json file&quot;)<br><br>added creation of compile =
commands file and a symbolic link to it.<br><br>There a two issues:<br><br>=
 - CMAKE_EXPORT_COMPILE_COMMANDS works only on Ninja and Makefile<br>genera=
tors and doesn&#39;t produce anything on MSVC.<br><br> - creating symlink o=
n Windows by default requires an elevated prompt,<br>which is not normally =
the case (but it turned out is the case for GHA).<br>Without elevated promp=
t this fails the build.<br><br>Fix by make symlink creation non-fatal by pr=
oviding variable<br>to store result.<br><br>Change-Id: Ic19f859c3aca8b30aa5=
1b12dcb906a6e7e735019<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<=
br>---<br>M CMakeLists.txt<br>1 file changed, 1 insertion(+), 1 deletion(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/=
495/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>=
index bc46c27..5c6fff0 100644</span><br><span>--- a/CMakeLists.txt</span><b=
r><span>+++ b/CMakeLists.txt</span><br><span>@@ -45,7 +45,7 @@</span><br><s=
pan> # Create machine readable compile commands</span><br><span> set(CMAKE_=
EXPORT_COMPILE_COMMANDS 1)</span><br><span> file(CREATE_LINK ${CMAKE_CURREN=
T_BINARY_DIR}/compile_commands.json</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                 ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands=
.json SYMBOLIC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
             ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json RESULT COMPI=
LE_COMMANDS_CREATED SYMBOLIC)</span><br><span> </span><br><span> # AddressS=
anitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TYPE=3Dasan to b=
uild with ASAN</span><br><span> set(CMAKE_C_FLAGS_ASAN</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/495?usp=3Demail">change 495</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/495?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic19f859c3aca8b30aa51b12dcb9=
06a6e7e735019 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 495 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JW/yfOUCno0=--

