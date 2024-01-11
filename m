From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 11 Jan 2024 13:32:05 +0000
References: <gerrit.1704979923000.Ic19f859c3aca8b30aa51b12dcb906a6e7e735019@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <155c753fa722f116571290a8b0d7ca056d4da4e7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GFE5pCMrL3k="; charset=UTF-8
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

--GFE5pCMrL3k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/495?usp=3Demail

to review the following change.


Change subject: CMakeLists.txt: Don't fail on missing compile_commands.json
......................................................................

CMakeLists.txt: Don't fail on missing compile_commands.json

CMAKE_EXPORT_COMPILE_COMMANDS works only on Ninja and Makefile
generators and doesn't produce anything on MSVC.

Due to that, creating symlink for it fails for me.

Fix by make symlink creation non-fatal by providing variable
to store result.

Change-Id: Ic19f859c3aca8b30aa51b12dcb906a6e7e735019
Signed-off-by: Lev Stipakov <lev@...515...>
---
M CMakeLists.txt
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/495/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--GFE5pCMrL3k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/495?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">CMakeLists.txt: Don&#39;t fail on missing compile_commands.js=
on<br><br>CMAKE_EXPORT_COMPILE_COMMANDS works only on Ninja and Makefile<br=
>generators and doesn&#39;t produce anything on MSVC.<br><br>Due to that, c=
reating symlink for it fails for me.<br><br>Fix by make symlink creation no=
n-fatal by providing variable<br>to store result.<br><br>Change-Id: Ic19f85=
9c3aca8b30aa51b12dcb906a6e7e735019<br>Signed-off-by: Lev Stipakov &lt;lev@...220...=
..515...&gt;<br>---<br>M CMakeLists.txt<br>1 file changed, 1 insertion(+), =
1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/95/495/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</sp=
an><br><span>index bc46c27..5c6fff0 100644</span><br><span>--- a/CMakeLists=
.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -45,7 +45,7 @@=
</span><br><span> # Create machine readable compile commands</span><br><spa=
n> set(CMAKE_EXPORT_COMPILE_COMMANDS 1)</span><br><span> file(CREATE_LINK $=
{CMAKE_CURRENT_BINARY_DIR}/compile_commands.json</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                 ${CMAKE_CURRENT_SOURCE_DIR}/com=
pile_commands.json SYMBOLIC)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                 ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json=
 RESULT COMPILE_COMMANDS_CREATED SYMBOLIC)</span><br><span> </span><br><spa=
n> # AddressSanitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TYP=
E=3Dasan to build with ASAN</span><br><span> set(CMAKE_C_FLAGS_ASAN</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/495?usp=3Demail">change 495</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/495?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic19f859c3aca8b30aa51b12dcb9=
06a6e7e735019 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 495 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--GFE5pCMrL3k=--

