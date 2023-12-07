From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 7 Dec 2023 17:49:41 +0000
References: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <cf217b90dcef2dfad3e8d0d6646b10933606199c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9XHBNYDDQww="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use mingw compile
 definition also to unit tests
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

--9XHBNYDDQww=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail

to review the following change.


Change subject: Use mingw compile definition also to unit tests
......................................................................

Use mingw compile definition also to unit tests

Currently we only apply the defines for windows APIs and Unicode to
OpenVPN itself. We should rather treat the unit tests the same as
our main binary to reduce potential differences.

Change-Id: Ie5aa643ab6190262f7c8b9e614bedb398e85859b
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
1 file changed, 14 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/469/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 577bc5d..8c24cca 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -259,6 +259,15 @@

     endif ()

+    if (MINGW)
+        target_compile_options(${target} PRIVATE
+                -DWIN32_LEAN_AND_MEAN
+                -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINN=
T_VISTA
+        )
+        target_compile_options(${target} PRIVATE -municode -UUNICODE)
+        target_link_options(${target} PRIVATE -municode)
+    endif()
+
     # optional dependencies
     target_link_libraries(${target} PUBLIC
         $<TARGET_NAME_IF_EXISTS:PkgConfig::liblz4>
@@ -514,14 +523,6 @@

 add_library_deps(openvpn)

-if (MINGW)
-    target_compile_options(openvpn PRIVATE
-        -DWIN32_LEAN_AND_MEAN
-        -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
-        )
-    target_compile_options(openvpn PRIVATE -municode -UUNICODE)
-    target_link_options(openvpn PRIVATE -municode)
-endif()

 if (MSVC)
     # we have our own manifest
@@ -634,6 +635,11 @@

         target_include_directories(${test_name} PRIVATE src/openvpn)

+        if (MINGW)
+            # when compiling with -municode, mingw looks for wmain instead=
 of main
+            target_compile_definitions(${test_name} PRIVATE -Dmain=3Dwmain)
+        endif ()
+
         if (NOT ${test_name} STREQUAL "test_buffer")
             target_sources(${test_name} PRIVATE
                 src/openvpn/buffer.c

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie5aa643ab6190262f7c8b9e614bedb398e85859b
Gerrit-Change-Number: 469
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--9XHBNYDDQww=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Use mingw compile definition also to unit tests<br><br>Curren=
tly we only apply the defines for windows APIs and Unicode to<br>OpenVPN it=
self. We should rather treat the unit tests the same as<br>our main binary =
to reduce potential differences.<br><br>Change-Id: Ie5aa643ab6190262f7c8b9e=
614bedb398e85859b<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br=
>---<br>M CMakeLists.txt<br>1 file changed, 14 insertions(+), 8 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69=
/469/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span=
>index 577bc5d..8c24cca 100644</span><br><span>--- a/CMakeLists.txt</span><=
br><span>+++ b/CMakeLists.txt</span><br><span>@@ -259,6 +259,15 @@</span><b=
r><span> </span><br><span>     endif ()</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (MINGW)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        target_compile_options(${target} =
PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    -DWIN32_LEAN_AND_MEAN</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32=
_WINNT_VISTA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        target_co=
mpile_options(${target} PRIVATE -municode -UUNICODE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        target_link_options(${target} PRI=
VATE -municode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
endif()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     # optional dependencies</span><br><span>     target_link_librarie=
s(${target} PUBLIC</span><br><span>         $&lt;TARGET_NAME_IF_EXISTS:PkgC=
onfig::liblz4&gt;</span><br><span>@@ -514,14 +523,6 @@</span><br><span> </s=
pan><br><span> add_library_deps(openvpn)</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-if (MINGW)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    target_compile_options(openvpn PRIVATE</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        -DWIN32_LEAN_AND_MEA=
N</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        -DNTDDI_VERS=
ION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    target_compile_options(openvpn PRIVATE -municode -U=
UNICODE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    target_li=
nk_options(openvpn PRIVATE -municode)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-endif()</span><br><span> </span><br><span> if (MSVC)</span>=
<br><span>     # we have our own manifest</span><br><span>@@ -634,6 +635,11=
 @@</span><br><span> </span><br><span>         target_include_directories($=
{test_name} PRIVATE src/openvpn)</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (MINGW)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            # when compiling with -municode, =
mingw looks for wmain instead of main</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            target_compile_definitions(${test_name} PRIVA=
TE -Dmain=3Dwmain)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>         if (NOT ${test_name} STREQUAL &quot;test_buffer&quot;=
)</span><br><span>             target_sources(${test_name} PRIVATE</span><b=
r><span>                 src/openvpn/buffer.c</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/469?=
usp=3Demail">change 469</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie5aa643ab6190262f7c8b9e614b=
edb398e85859b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 469 </div>
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


--9XHBNYDDQww=--

