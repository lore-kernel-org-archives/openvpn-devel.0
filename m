From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 25 Dec 2024 17:15:14 +0000
References: <gerrit.1735146911000.I350fd615ed8474d34392a057a5f8bded78173949@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <59b20daee30f48b3b71c1a299e838b7c9bb3652a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LvIaN14jN60="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LvIaN14jN60=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/846?usp=3Demail

to review the following change.


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
1 file changed, 3 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/846/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 61f0cc5..65fdbc7 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -74,7 +74,6 @@
         /MP
         /W2
         /sdl
-        /Qspectre
         /guard:cf
         /FC
         /ZH:SHA_256
@@ -107,9 +106,9 @@
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
@@ -339,7 +338,7 @@

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--LvIaN14jN60=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/846?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Ensure that Python3 is available<br><br>Use the more standard=
 cmake find_package to search for Python3 and make it required. This also p=
rovides<br>a better error message than &quot;version.cmake&quot; not found =
when python3 is missing.<br><br>Change-Id: I350fd615ed8474d34392a057a5f8bde=
d78173949<br>---<br>M CMakeLists.txt<br>1 file changed, 3 insertions(+), 4 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/46/846/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</spa=
n><br><span>index 61f0cc5..65fdbc7 100644</span><br><span>--- a/CMakeLists.=
txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -74,7 +74,6 @@<=
/span><br><span>         /MP</span><br><span>         /W2</span><br><span> =
        /sdl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
Qspectre</span><br><span>         /guard:cf</span><br><span>         /FC</s=
pan><br><span>         /ZH:SHA_256</span><br><span>@@ -107,9 +106,9 @@</spa=
n><br><span>     endif ()</span><br><span> endif ()</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-find_program(PYTHON NAMES p=
ython3 python)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_=
package(Python3 REQUIRED COMPONENTS Interpreter)</span><br><span> execute_p=
rocess(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    COMMAND ${=
PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-version.m4.py ${CMA=
KE_CURRENT_SOURCE_DIR}/version.m4</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}=
/contrib/cmake/parse-version.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4</=
span><br><span>     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}</span><br=
><span>     )</span><br><span> include(${CMAKE_CURRENT_BINARY_DIR}/version.=
cmake)</span><br><span>@@ -339,7 +338,7 @@</span><br><span> </span><br><spa=
n> add_custom_command(</span><br><span>     OUTPUT always_rebuild config-ve=
rsion.h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    COMMAND ${=
PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-version.py</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    COMMAND ${Python3_EXECUTAB=
LE} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-version.py</span><br><spa=
n>     )</span><br><span> set(HAVE_CONFIG_VERSION_H YES)</span><br><span> <=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/846?usp=3Demail">change 846</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/846?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I350fd615ed8474d34392a057a5f=
8bded78173949 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 846 </div>
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


--LvIaN14jN60=--

