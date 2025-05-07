From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 7 May 2025 12:35:19 +0000
In-Reply-To: <gerrit.1746615872000.I2551edfaaf5107649398a3fa1db2009ee8644671@...2715...>
References: <gerrit.1746615872000.I2551edfaaf5107649398a3fa1db2009ee8644671@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7050be758d77d7e6adc09690716bb94f584cdabc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FBc5sPI6YSc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: CMake: Make sure to
 treat UNIT_TEST_SOURCEDIR as path
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

--FBc5sPI6YSc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/981?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: CMake: Make sure to treat UNIT_TEST_SOURCEDIR as path
......................................................................

CMake: Make sure to treat UNIT_TEST_SOURCEDIR as path

This makes sure that it is properly normalized, and
on Windows seems to prevent CMake from using back
slashes which would break the build due to "unknown escape
sequence" errors.

Change-Id: I2551edfaaf5107649398a3fa1db2009ee8644671
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250507121226.13824-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
587.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/981/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index a8fb64b..6687b56 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -679,11 +679,11 @@
     endif ()

     foreach (test_name ${unit_tests})
+        cmake_path(SET _UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/un=
it_tests/openvpn)
         # test_networking needs special environment
         if (NOT ${test_name} STREQUAL "test_networking")
             add_test(${test_name} ${test_name})
             # for compat with autotools make check
-            set(_UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_test=
s/openvpn)
             set_tests_properties(${test_name} PROPERTIES
                 ENVIRONMENT "srcdir=3D${_UT_SOURCE_DIR}")
         endif ()
@@ -703,7 +703,7 @@

         # for compat with IDEs like Clion that ignore the tests properties
         # for the environment variable srcdir when running tests as fallba=
ck
-        target_compile_definitions(${test_name} PRIVATE "-DUNIT_TEST_SOURC=
EDIR=3D\"${CMAKE_SOURCE_DIR}/tests/unit_tests/openvpn\"")
+        target_compile_definitions(${test_name} PRIVATE "UNIT_TEST_SOURCED=
IR=3D\"${_UT_SOURCE_DIR}\"")

         if (NOT ${test_name} STREQUAL "test_buffer")
             target_sources(${test_name} PRIVATE

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/981?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2551edfaaf5107649398a3fa1db2009ee8644671
Gerrit-Change-Number: 981
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--FBc5sPI6YSc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/981?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">CMake: Make sure to treat UNIT_TEST_SOURCEDIR as=
 path<br><br>This makes sure that it is properly normalized, and<br>on Wind=
ows seems to prevent CMake from using back<br>slashes which would break the=
 build due to &quot;unknown escape<br>sequence&quot; errors.<br><br>Change-=
Id: I2551edfaaf5107649398a3fa1db2009ee8644671<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@=
...1227...&gt;<br>Message-Id: &lt;20250507121226.13824-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg31587.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M CMakeLists.txt<br>1 file changed, 2 insertions(+), 2 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/981/=
2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>inde=
x a8fb64b..6687b56 100644</span><br><span>--- a/CMakeLists.txt</span><br><s=
pan>+++ b/CMakeLists.txt</span><br><span>@@ -679,11 +679,11 @@</span><br><s=
pan>     endif ()</span><br><span> </span><br><span>     foreach (test_name=
 ${unit_tests})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmake_path(SET _UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_te=
sts/openvpn)</span><br><span>         # test_networking needs special envir=
onment</span><br><span>         if (NOT ${test_name} STREQUAL &quot;test_ne=
tworking&quot;)</span><br><span>             add_test(${test_name} ${test_n=
ame})</span><br><span>             # for compat with autotools make check</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            set(_UT_SOU=
RCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_tests/openvpn)</span><br><sp=
an>             set_tests_properties(${test_name} PROPERTIES</span><br><spa=
n>                 ENVIRONMENT &quot;srcdir=3D${_UT_SOURCE_DIR}&quot;)</spa=
n><br><span>         endif ()</span><br><span>@@ -703,7 +703,7 @@</span><br=
><span> </span><br><span>         # for compat with IDEs like Clion that ig=
nore the tests properties</span><br><span>         # for the environment va=
riable srcdir when running tests as fallback</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        target_compile_definitions(${test_name} PRIV=
ATE &quot;-DUNIT_TEST_SOURCEDIR=3D\&quot;${CMAKE_SOURCE_DIR}/tests/unit_tes=
ts/openvpn\&quot;&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        target_compile_definitions(${test_name} PRIVATE &quot;UNIT_TES=
T_SOURCEDIR=3D\&quot;${_UT_SOURCE_DIR}\&quot;&quot;)</span><br><span> </spa=
n><br><span>         if (NOT ${test_name} STREQUAL &quot;test_buffer&quot;)=
</span><br><span>             target_sources(${test_name} PRIVATE</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/981?usp=3Demail">change 981</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/9=
81?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2551edfaaf5107649398a3fa1db=
2009ee8644671 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 981 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FBc5sPI6YSc=--

