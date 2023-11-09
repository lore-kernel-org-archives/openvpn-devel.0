From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 9 Nov 2023 11:37:17 +0000
In-Reply-To: <gerrit.1697649588000.I3ca6965799b23d542ababc3e38880317cb46a3ac@...2715...>
References: <gerrit.1697649588000.I3ca6965799b23d542ababc3e38880317cb46a3ac@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4491f67ce17b365a72a3278104ddf0ba1c8a687e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rl/J1qr/NuQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove CMake custom
 compiler flags for RELEASE and DEBUG build
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

--Rl/J1qr/NuQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/374?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Remove CMake custom compiler flags for RELEASE and DEBUG bu=
ild
......................................................................

Remove CMake custom compiler flags for RELEASE and DEBUG build

This overwrites the default that cmake automatically sets. In the
case of debug builds, this breaks debugging as -O1 already optimises
many variables away.

Change-Id: I3ca6965799b23d542ababc3e38880317cb46a3ac
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231107141755.30559-1-frank@...2641...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20231107141755.30559-1=
-frank@...2641...
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
1 file changed, 0 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/374/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 376a060..d21c9bd 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -79,10 +79,6 @@
         add_link_options("$<$<CONFIG:Release>:/CETCOMPAT>")
     endif()
 else ()
-    set(CMAKE_C_FLAGS_RELEASE "-O2")
-    set(CMAKE_CXX_FLAGS_RELEASE "-O2")
-    set(CMAKE_C_FLAGS_DEBUG "-g -O1")
-    set(CMAKE_CXX_FLAGS_DEBUG "-g -O1")
     add_compile_options(-Wall -Wuninitialized)
     check_c_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/374?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3ca6965799b23d542ababc3e38880317cb46a3ac
Gerrit-Change-Number: 374
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Rl/J1qr/NuQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
374?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Remove CMake custom compiler flags for RELEAS=
E and DEBUG build<br><br>This overwrites the default that cmake automatical=
ly sets. In the<br>case of debug builds, this breaks debugging as -O1 alrea=
dy optimises<br>many variables away.<br><br>Change-Id: I3ca6965799b23d542ab=
abc3e38880317cb46a3ac<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>Message-Id: &lt;20231107141755.30559-1-frank@...2641...&gt;<br>URL: h=
ttps://www.mail-archive.com/search?l=3Dmid&amp;q=3D20231107141755.30559-1-f=
rank@...2641...<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M CMakeLists.txt<br>1 file changed, 0 insertions(+), 4 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/37=
4/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>in=
dex 376a060..d21c9bd 100644</span><br><span>--- a/CMakeLists.txt</span><br>=
<span>+++ b/CMakeLists.txt</span><br><span>@@ -79,10 +79,6 @@</span><br><sp=
an>         add_link_options(&quot;$&lt;$&lt;CONFIG:Release&gt;:/CETCOMPAT&=
gt;&quot;)</span><br><span>     endif()</span><br><span> else ()</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_C_FLAGS_RELEASE &q=
uot;-O2&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set=
(CMAKE_CXX_FLAGS_RELEASE &quot;-O2&quot;)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    set(CMAKE_C_FLAGS_DEBUG &quot;-g -O1&quot;)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_CXX_FLAGS_DEBUG=
 &quot;-g -O1&quot;)</span><br><span>     add_compile_options(-Wall -Wunini=
tialized)</span><br><span>     check_c_compiler_flag(-Wno-stringop-truncati=
on NoStringOpTruncation)</span><br><span> </span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/374?usp=
=3Demail">change 374</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/374?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3ca6965799b23d542ababc3e388=
80317cb46a3ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 374 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Rl/J1qr/NuQ=--

