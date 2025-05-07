From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 7 May 2025 12:35:22 +0000
In-Reply-To: <gerrit.1746615872000.I2551edfaaf5107649398a3fa1db2009ee8644671@...2715...>
References: <gerrit.1746615872000.I2551edfaaf5107649398a3fa1db2009ee8644671@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7050be758d77d7e6adc09690716bb94f584cdabc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dQkRvzc2pfo="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dQkRvzc2pfo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/98=
1?usp=3Demail )

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
Gerrit-MessageType: merged

--dQkRvzc2pfo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/981?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">CMake: Make sure to treat UNIT_TEST_SOURCEDIR =
as path<br><br>This makes sure that it is properly normalized, and<br>on Wi=
ndows seems to prevent CMake from using back<br>slashes which would break t=
he build due to &quot;unknown escape<br>sequence&quot; errors.<br><br>Chang=
e-Id: I2551edfaaf5107649398a3fa1db2009ee8644671<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvp=
n@...1227...&gt;<br>Message-Id: &lt;20250507121226.13824-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg31587.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M CMakeLists.txt<br>1 file changed, 2 insertions(+), 2 deletions(-)<b=
r><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index a8fb6=
4b..6687b56 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -679,11 +679,11 @@</span><br><span>   =
  endif ()</span><br><span> </span><br><span>     foreach (test_name ${unit=
_tests})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cma=
ke_path(SET _UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_tests/ope=
nvpn)</span><br><span>         # test_networking needs special environment<=
/span><br><span>         if (NOT ${test_name} STREQUAL &quot;test_networkin=
g&quot;)</span><br><span>             add_test(${test_name} ${test_name})</=
span><br><span>             # for compat with autotools make check</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            set(_UT_SOURCE_DIR=
 ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_tests/openvpn)</span><br><span>    =
         set_tests_properties(${test_name} PROPERTIES</span><br><span>     =
            ENVIRONMENT &quot;srcdir=3D${_UT_SOURCE_DIR}&quot;)</span><br><=
span>         endif ()</span><br><span>@@ -703,7 +703,7 @@</span><br><span>=
 </span><br><span>         # for compat with IDEs like Clion that ignore th=
e tests properties</span><br><span>         # for the environment variable =
srcdir when running tests as fallback</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        target_compile_definitions(${test_name} PRIVATE &qu=
ot;-DUNIT_TEST_SOURCEDIR=3D\&quot;${CMAKE_SOURCE_DIR}/tests/unit_tests/open=
vpn\&quot;&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      target_compile_definitions(${test_name} PRIVATE &quot;UNIT_TEST_SOURC=
EDIR=3D\&quot;${_UT_SOURCE_DIR}\&quot;&quot;)</span><br><span> </span><br><=
span>         if (NOT ${test_name} STREQUAL &quot;test_buffer&quot;)</span>=
<br><span>             target_sources(${test_name} PRIVATE</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/981?usp=3Demail">change 981</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/981?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--dQkRvzc2pfo=--

