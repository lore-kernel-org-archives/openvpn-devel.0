From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 11:54:11 +0000
In-Reply-To: <gerrit.1735146911000.I350fd615ed8474d34392a057a5f8bded78173949@...2715...>
References: <gerrit.1735146911000.I350fd615ed8474d34392a057a5f8bded78173949@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <064a673f542abd422959d3c2db07fdcb4bde601e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="36bb3zSd8Ts="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--36bb3zSd8Ts=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/84=
6?usp=3Demail )

Change subject: Ensure that Python3 is available
......................................................................

Ensure that Python3 is available

Use the more standard cmake find_package to search for Python3 and make it =
required. This also provides
a better error message than "version.cmake" not found when python3 is missi=
ng.

Change-Id: I350fd615ed8474d34392a057a5f8bded78173949
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20241227112255.11992-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
232.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
1 file changed, 3 insertions(+), 3 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5b5b7ff..9ffcc89 100644
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--36bb3zSd8Ts=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/846?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Ensure that Python3 is available<br><br>Use th=
e more standard cmake find_package to search for Python3 and make it requir=
ed. This also provides<br>a better error message than &quot;version.cmake&q=
uot; not found when python3 is missing.<br><br>Change-Id: I350fd615ed8474d3=
4392a057a5f8bded78173949<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1186...=
.1227...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Messa=
ge-Id: &lt;20241227112255.11992-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg30232.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br=
>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 5b5b7=
ff..9ffcc89 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -107,9 +107,9 @@</span><br><span>     =
endif ()</span><br><span> endif ()</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-find_program(PYTHON NAMES python3 python)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_package(Python3 =
REQUIRED COMPONENTS Interpreter)</span><br><span> execute_process(</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    COMMAND ${PYTHON} ${CMAKE_=
CURRENT_SOURCE_DIR}/contrib/cmake/parse-version.m4.py ${CMAKE_CURRENT_SOURC=
E_DIR}/version.m4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/p=
arse-version.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4</span><br><span> =
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}</span><br><span>     )</s=
pan><br><span> include(${CMAKE_CURRENT_BINARY_DIR}/version.cmake)</span><br=
><span>@@ -339,7 +339,7 @@</span><br><span> </span><br><span> add_custom_co=
mmand(</span><br><span>     OUTPUT always_rebuild config-version.h</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    COMMAND ${PYTHON} ${CMAKE_=
CURRENT_SOURCE_DIR}/contrib/cmake/git-version.py</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURR=
ENT_SOURCE_DIR}/contrib/cmake/git-version.py</span><br><span>     )</span><=
br><span> set(HAVE_CONFIG_VERSION_H YES)</span><br><span> </span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/846?usp=3Demail">change 846</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/846?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I350fd615ed8474d34392a057a5f=
8bded78173949 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 846 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--36bb3zSd8Ts=--

