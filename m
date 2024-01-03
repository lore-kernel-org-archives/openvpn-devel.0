From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 3 Jan 2024 14:41:34 +0000
In-Reply-To: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
References: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <aaee621e1639787e33b365da8fa07ef1bada0714-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YsSRYPnT8sc="; charset=UTF-8
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

--YsSRYPnT8sc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
1 file changed, 8 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/469/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--YsSRYPnT8sc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Use mingw compile definition also to unit tes=
ts<br><br>Currently we only apply the defines for windows APIs and Unicode =
to<br>OpenVPN itself. We should rather treat the unit tests the same as<br>=
our main binary to reduce potential differences.<br><br>Change-Id: Ie5aa643=
ab6190262f7c8b9e614bedb398e85859b<br>Signed-off-by: Arne Schwabe &lt;arne@...220...=
..1227...&gt;<br>---<br>M CMakeLists.txt<br>1 file changed, 8 insertions(+)=
, 5 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/69/469/4</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt<=
/span><br><span>index bc46c27..6f370c3 100644</span><br><span>--- a/CMakeLi=
sts.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -290,6 +290=
,13 @@</span><br><span> </span><br><span>     endif ()</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (MINGW)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        target_compile_defi=
nitions(${target} PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                -DWIN32_LEAN_AND_MEAN</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                -DNTDDI_VERSION=3DNTDDI_VISTA -D_WI=
N32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    endif()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     # optional dependencies</span><br><span>     target_link_lib=
raries(${target} PUBLIC</span><br><span>         $&lt;TARGET_NAME_IF_EXISTS=
:PkgConfig::liblz4&gt;</span><br><span>@@ -545,11 +552,7 @@</span><br><span=
> </span><br><span> add_library_deps(openvpn)</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-if (MINGW)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    target_compile_options(openvpn PRIVATE<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        -DWIN32_LEAN_A=
ND_MEAN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        -DNTDD=
I_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+if(MINGW)</span><br><span>     target_compile_o=
ptions(openvpn PRIVATE -municode -UUNICODE)</span><br><span>     target_lin=
k_options(openvpn PRIVATE -municode)</span><br><span> endif()</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/469?usp=3Demail">change 469</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/469?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie5aa643ab6190262f7c8b9e614b=
edb398e85859b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 469 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--YsSRYPnT8sc=--

