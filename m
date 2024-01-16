From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 16 Jan 2024 13:23:21 +0000
In-Reply-To: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
References: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <26585db60e6d7c84d7e4a6312927a8fdc35b60b8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KuvxJZgipzE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KuvxJZgipzE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/46=
9?usp=3Demail )

Change subject: Use mingw compile definition also to unit tests
......................................................................

Use mingw compile definition also to unit tests

Currently we only apply the defines for windows APIs and Unicode to
OpenVPN itself. We should rather treat the unit tests the same as
our main binary to reduce potential differences.

Change-Id: Ie5aa643ab6190262f7c8b9e614bedb398e85859b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240116131831.31217-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
019.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
1 file changed, 8 insertions(+), 5 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index bc46c27..6f370c3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -290,6 +290,13 @@

     endif ()

+    if (MINGW)
+        target_compile_definitions(${target} PRIVATE
+                -DWIN32_LEAN_AND_MEAN
+                -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINN=
T_VISTA
+        )
+    endif()
+
     # optional dependencies
     target_link_libraries(${target} PUBLIC
         $<TARGET_NAME_IF_EXISTS:PkgConfig::liblz4>
@@ -545,11 +552,7 @@

 add_library_deps(openvpn)

-if (MINGW)
-    target_compile_options(openvpn PRIVATE
-        -DWIN32_LEAN_AND_MEAN
-        -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
-        )
+if(MINGW)
     target_compile_options(openvpn PRIVATE -municode -UUNICODE)
     target_link_options(openvpn PRIVATE -municode)
 endif()

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie5aa643ab6190262f7c8b9e614bedb398e85859b
Gerrit-Change-Number: 469
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--KuvxJZgipzE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/469?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Use mingw compile definition also to unit test=
s<br><br>Currently we only apply the defines for windows APIs and Unicode t=
o<br>OpenVPN itself. We should rather treat the unit tests the same as<br>o=
ur main binary to reduce potential differences.<br><br>Change-Id: Ie5aa643a=
b6190262f7c8b9e614bedb398e85859b<br>Signed-off-by: Arne Schwabe &lt;arne@...1186...=
.1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Mes=
sage-Id: &lt;20240116131831.31217-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28019.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<=
br>1 file changed, 8 insertions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index bc46c=
27..6f370c3 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -290,6 +290,13 @@</span><br><span> </s=
pan><br><span>     endif ()</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (MINGW)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        target_compile_definitions(${target} PRIVATE</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                -DWIN=
32_LEAN_AND_MEAN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VI=
STA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    endif()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     # optional d=
ependencies</span><br><span>     target_link_libraries(${target} PUBLIC</sp=
an><br><span>         $&lt;TARGET_NAME_IF_EXISTS:PkgConfig::liblz4&gt;</spa=
n><br><span>@@ -545,11 +552,7 @@</span><br><span> </span><br><span> add_lib=
rary_deps(openvpn)</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-if (MINGW)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    target_compile_options(openvpn PRIVATE</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        -DWIN32_LEAN_AND_MEAN</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        -DNTDDI_VERSION=3DNTDDI_VISTA -D_W=
IN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if(MINGW)</span><br><span>     target_compile_options(openvpn PRIVATE -muni=
code -UUNICODE)</span><br><span>     target_link_options(openvpn PRIVATE -m=
unicode)</span><br><span> endif()</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail"=
>change 469</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie5aa643ab6190262f7c8b9e614b=
edb398e85859b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 469 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--KuvxJZgipzE=--

