From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 9 Nov 2023 11:37:20 +0000
In-Reply-To: <gerrit.1697649588000.I3ca6965799b23d542ababc3e38880317cb46a3ac@...2715...>
References: <gerrit.1697649588000.I3ca6965799b23d542ababc3e38880317cb46a3ac@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4491f67ce17b365a72a3278104ddf0ba1c8a687e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6N9ooTBBLGg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6N9ooTBBLGg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/37=
4?usp=3Demail )

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
Gerrit-MessageType: merged

--6N9ooTBBLGg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/374?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove CMake custom compiler flags for RELEASE=
 and DEBUG build<br><br>This overwrites the default that cmake automaticall=
y sets. In the<br>case of debug builds, this breaks debugging as -O1 alread=
y optimises<br>many variables away.<br><br>Change-Id: I3ca6965799b23d542aba=
bc3e38880317cb46a3ac<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>Message-Id: &lt;20231107141755.30559-1-frank@...2641...&gt;<br>URL: ht=
tps://www.mail-archive.com/search?l=3Dmid&amp;q=3D20231107141755.30559-1-fr=
ank@...2641...<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>--=
-<br>M CMakeLists.txt<br>1 file changed, 0 insertions(+), 4 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 376a0=
60..d21c9bd 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -79,10 +79,6 @@</span><br><span>      =
   add_link_options(&quot;$&lt;$&lt;CONFIG:Release&gt;:/CETCOMPAT&gt;&quot;=
)</span><br><span>     endif()</span><br><span> else ()</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_C_FLAGS_RELEASE &quot;-O2&q=
uot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_CX=
X_FLAGS_RELEASE &quot;-O2&quot;)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    set(CMAKE_C_FLAGS_DEBUG &quot;-g -O1&quot;)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_CXX_FLAGS_DEBUG &quot;-g=
 -O1&quot;)</span><br><span>     add_compile_options(-Wall -Wuninitialized)=
</span><br><span>     check_c_compiler_flag(-Wno-stringop-truncation NoStri=
ngOpTruncation)</span><br><span> </span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/374?usp=3Demail"=
>change 374</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/374?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--6N9ooTBBLGg=--

