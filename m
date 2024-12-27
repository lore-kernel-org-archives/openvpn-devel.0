From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 01:10:23 +0000
In-Reply-To: <gerrit.1735146911000.I350fd615ed8474d34392a057a5f8bded78173949@...2715...>
References: <gerrit.1735146911000.I350fd615ed8474d34392a057a5f8bded78173949@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <5fa7e4da0e4c02e1966a48a14bba114aea99ab5a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GrP/UlMEXMg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Ensure that Python3
 is available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GrP/UlMEXMg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/846?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by stipa


Change subject: Ensure that Python3 is available
......................................................................

Ensure that Python3 is available

Use the more standard cmake find_package to search for Python3 and make it =
required. This also provides
a better error message than "version.cmake" not found when python3 is missi=
ng.

Change-Id: I350fd615ed8474d34392a057a5f8bded78173949
---
M CMakeLists.txt
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/846/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 61f0cc5..fc94a10 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -107,9 +107,9 @@
     endif ()
 endif ()

-find_program(PYTHON NAMES python3 python)
+find_package(Python3 REQUIRED COMPONENTS Interpreter)
 execute_process(
-    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-vers=
ion.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4
+    COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmak=
e/parse-version.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4
     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
     )
 include(${CMAKE_CURRENT_BINARY_DIR}/version.cmake)
@@ -339,7 +339,7 @@

 add_custom_command(
     OUTPUT always_rebuild config-version.h
-    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-versio=
n.py
+    COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmak=
e/git-version.py
     )
 set(HAVE_CONFIG_VERSION_H YES)


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/846?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I350fd615ed8474d34392a057a5f8bded78173949
Gerrit-Change-Number: 846
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--GrP/UlMEXMg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/846?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Ensure that Python3 is available<br><br>Use the more=
 standard cmake find_package to search for Python3 and make it required. Th=
is also provides<br>a better error message than &quot;version.cmake&quot; n=
ot found when python3 is missing.<br><br>Change-Id: I350fd615ed8474d34392a0=
57a5f8bded78173949<br>---<br>M CMakeLists.txt<br>1 file changed, 3 insertio=
ns(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/46/846/2</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists=
.txt</span><br><span>index 61f0cc5..fc94a10 100644</span><br><span>--- a/CM=
akeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -107,9=
 +107,9 @@</span><br><span>     endif ()</span><br><span> endif ()</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-find_program=
(PYTHON NAMES python3 python)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+find_package(Python3 REQUIRED COMPONENTS Interpreter)</span><br><=
span> execute_process(</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-vers=
ion.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURR=
ENT_SOURCE_DIR}/contrib/cmake/parse-version.m4.py ${CMAKE_CURRENT_SOURCE_DI=
R}/version.m4</span><br><span>     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY=
_DIR}</span><br><span>     )</span><br><span> include(${CMAKE_CURRENT_BINAR=
Y_DIR}/version.cmake)</span><br><span>@@ -339,7 +339,7 @@</span><br><span> =
</span><br><span> add_custom_command(</span><br><span>     OUTPUT always_re=
build config-version.h</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-versio=
n.py</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    COMMAND ${P=
ython3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-version.py=
</span><br><span>     )</span><br><span> set(HAVE_CONFIG_VERSION_H YES)</sp=
an><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/846?usp=3Demail">change 846</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/846?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I350fd615ed8474d34392a057a5f=
8bded78173949 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 846 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--GrP/UlMEXMg=--

