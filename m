From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 16 Jan 2024 13:23:19 +0000
In-Reply-To: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
References: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <26585db60e6d7c84d7e4a6312927a8fdc35b60b8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HM3xcksQomg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HM3xcksQomg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/469/5

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
Gerrit-MessageType: newpatchset

--HM3xcksQomg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
469?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Use mingw compile definition also to unit tes=
ts<br><br>Currently we only apply the defines for windows APIs and Unicode =
to<br>OpenVPN itself. We should rather treat the unit tests the same as<br>=
our main binary to reduce potential differences.<br><br>Change-Id: Ie5aa643=
ab6190262f7c8b9e614bedb398e85859b<br>Signed-off-by: Arne Schwabe &lt;arne@...220...=
..1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Me=
ssage-Id: &lt;20240116131831.31217-1-gert@...1296...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28019.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt=
<br>1 file changed, 8 insertions(+), 5 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/69/469/5</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index bc46c27..6f370c3 1=
00644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists=
.txt</span><br><span>@@ -290,6 +290,13 @@</span><br><span> </span><br><span=
>     endif ()</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (MINGW)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        target_compile_definitions(${target} PRIVATE</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                -DWIN32_LEAN_AND_M=
EAN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
-DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    endif()</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     # optional dependencies</=
span><br><span>     target_link_libraries(${target} PUBLIC</span><br><span>=
         $&lt;TARGET_NAME_IF_EXISTS:PkgConfig::liblz4&gt;</span><br><span>@=
@ -545,11 +552,7 @@</span><br><span> </span><br><span> add_library_deps(ope=
nvpn)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-if (MINGW)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    targe=
t_compile_options(openvpn PRIVATE</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        -DWIN32_LEAN_AND_MEAN</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D=
_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if(MINGW)</sp=
an><br><span>     target_compile_options(openvpn PRIVATE -municode -UUNICOD=
E)</span><br><span>     target_link_options(openvpn PRIVATE -municode)</spa=
n><br><span> endif()</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail">change 469</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/469?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--HM3xcksQomg=--

