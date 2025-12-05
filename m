From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 5 Dec 2025 16:11:04 +0000
In-Reply-To: <gerrit.1764946104000.Iffc114939cb37129057e9c4864fae9e09c3c7fe4@...2715...>
References: <gerrit.1764946104000.Iffc114939cb37129057e9c4864fae9e09c3c7fe4@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <352469bfcc8ede2d3d9d7fe3bb7a22bc493d33bb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YAmUzu91vuU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: CMake: For VS build,
 document what we're missing from /W3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YAmUzu91vuU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1417?usp=3Demail

to look at the new patch set (#2).


Change subject: CMake: For VS build, document what we're missing from /W3
......................................................................

CMake: For VS build, document what we're missing from /W3

Basically -Wconversion and -Wsign-compare, so as expected.

Github: #382
Change-Id: Iffc114939cb37129057e9c4864fae9e09c3c7fe4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
1 file changed, 4 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1417/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index b3142e4..906fa04 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -85,9 +85,12 @@
     if (USE_WERROR)
         add_compile_options(/WX)
     endif ()
+    # C4018: signed/unsigned mismatch
+    # C4244: conversion from 'type1' to 'type2', possible loss of data
+    # C4267: conversion from 'size_t' to 'type', possible loss of data
     add_compile_options(
         /MP
-        /W2
+        /W3 /wd4018 /wd4267 /wd4244
         /sdl
         /Qspectre
         /guard:cf

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1417?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iffc114939cb37129057e9c4864fae9e09c3c7fe4
Gerrit-Change-Number: 1417
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--YAmUzu91vuU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1417?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">CMake: For VS build, document what we&#39;re mis=
sing from /W3<br><br>Basically -Wconversion and -Wsign-compare, so as expec=
ted.<br><br>Github: #382<br>Change-Id: Iffc114939cb37129057e9c4864fae9e09c3=
c7fe4<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<b=
r>M CMakeLists.txt<br>1 file changed, 4 insertions(+), 1 deletion(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/17/1417/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span=
><br><span>index b3142e4..906fa04 100644</span><br><span>--- a/CMakeLists.t=
xt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -85,9 +85,12 @@<=
/span><br><span>     if (USE_WERROR)</span><br><span>         add_compile_o=
ptions(/WX)</span><br><span>     endif ()</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    # C4018: signed/unsigned mismatch</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    # C4244: conversion from &#39;t=
ype1&#39; to &#39;type2&#39;, possible loss of data</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # C4267: conversion from &#39;size_t&=
#39; to &#39;type&#39;, possible loss of data</span><br><span>     add_comp=
ile_options(</span><br><span>         /MP</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /W2</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /W3 /wd4018 /wd4267 /wd4244</span><br><span>         /s=
dl</span><br><span>         /Qspectre</span><br><span>         /guard:cf</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1417?usp=3Demail">change 1417</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1417?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iffc114939cb37129057e9c4864f=
ae9e09c3c7fe4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1417 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--YAmUzu91vuU=--

