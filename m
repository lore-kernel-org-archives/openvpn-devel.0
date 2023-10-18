From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 17:19:50 +0000
References: <gerrit.1697649588000.I3ca6965799b23d542ababc3e38880317cb46a3ac@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0bc90bdbc1a9a0780e5ddf06670978476c609522-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+rPFKl0kmrw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+rPFKl0kmrw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/374?usp=3Demail

to review the following change.


Change subject: Remove CMake custom compiler flags for RELEASE and DEBUG bu=
ild
......................................................................

Remove CMake custom compiler flags for RELEASE and DEBUG build

This overwrites the default that cmake automatically sets. In the
case of debug builds, this breaks debugging as -O1 already optimises
many variables away.

Change-Id: I3ca6965799b23d542ababc3e38880317cb46a3ac
---
M CMakeLists.txt
1 file changed, 0 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/374/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--+rPFKl0kmrw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/374?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove CMake custom compiler flags for RELEASE and DEBUG buil=
d<br><br>This overwrites the default that cmake automatically sets. In the<=
br>case of debug builds, this breaks debugging as -O1 already optimises<br>=
many variables away.<br><br>Change-Id: I3ca6965799b23d542ababc3e38880317cb4=
6a3ac<br>---<br>M CMakeLists.txt<br>1 file changed, 0 insertions(+), 4 dele=
tions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/74/374/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><b=
r><span>index 376a060..d21c9bd 100644</span><br><span>--- a/CMakeLists.txt<=
/span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -79,10 +79,6 @@</sp=
an><br><span>         add_link_options(&quot;$&lt;$&lt;CONFIG:Release&gt;:/=
CETCOMPAT&gt;&quot;)</span><br><span>     endif()</span><br><span> else ()<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_C_FLAGS_=
RELEASE &quot;-O2&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    set(CMAKE_CXX_FLAGS_RELEASE &quot;-O2&quot;)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_C_FLAGS_DEBUG &quot;-g -O1&qu=
ot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_CXX=
_FLAGS_DEBUG &quot;-g -O1&quot;)</span><br><span>     add_compile_options(-=
Wall -Wuninitialized)</span><br><span>     check_c_compiler_flag(-Wno-strin=
gop-truncation NoStringOpTruncation)</span><br><span> </span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/374?usp=3Demail">change 374</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/374?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3ca6965799b23d542ababc3e388=
80317cb46a3ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 374 </div>
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


--+rPFKl0kmrw=--

