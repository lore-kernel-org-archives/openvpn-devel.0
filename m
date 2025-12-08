From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 14:41:47 +0000
In-Reply-To: <gerrit.1764946104000.Iffc114939cb37129057e9c4864fae9e09c3c7fe4@...2715...>
References: <gerrit.1764946104000.Iffc114939cb37129057e9c4864fae9e09c3c7fe4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <28878e5485a49b770387d74c9eba3518e175ac2e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7+JXaY2nhos="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: CMake: For VS build,
 switch from /W2 to /W3
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

--7+JXaY2nhos=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1417?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: CMake: For VS build, switch from /W2 to /W3
......................................................................

CMake: For VS build, switch from /W2 to /W3

But exclude the added checks that currently have failures
so that we can keep /WX enabled.
Basically this excludes -Wconversion and -Wsign-compare,
as expected from our GCC/Clang flags.

Github: #382
Change-Id: Iffc114939cb37129057e9c4864fae9e09c3c7fe4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1417
Message-Id: <20251208113636.9650-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
876.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
1 file changed, 4 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1417/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7+JXaY2nhos=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1417?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">CMake: For VS build, switch from /W=
2 to /W3<br><br>But exclude the added checks that currently have failures<b=
r>so that we can keep /WX enabled.<br>Basically this excludes -Wconversion =
and -Wsign-compare,<br>as expected from our GCC/Clang flags.<br><br>Github:=
 #382<br>Change-Id: Iffc114939cb37129057e9c4864fae9e09c3c7fe4<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &=
lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/=
+/1417<br>Message-Id: &lt;20251208113636.9650-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34876.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMa=
keLists.txt<br>1 file changed, 4 insertions(+), 1 deletion(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
17/1417/4</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><s=
pan>index b3142e4..906fa04 100644</span><br><span>--- a/CMakeLists.txt</spa=
n><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -85,9 +85,12 @@</span><=
br><span>     if (USE_WERROR)</span><br><span>         add_compile_options(=
/WX)</span><br><span>     endif ()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    # C4018: signed/unsigned mismatch</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # C4244: conversion from &#39;type1&#=
39; to &#39;type2&#39;, possible loss of data</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    # C4267: conversion from &#39;size_t&#39; to =
&#39;type&#39;, possible loss of data</span><br><span>     add_compile_opti=
ons(</span><br><span>         /MP</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        /W2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /W3 /wd4018 /wd4267 /wd4244</span><br><span>         /sdl</span=
><br><span>         /Qspectre</span><br><span>         /guard:cf</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1417?usp=3Demail">change 1417</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1417?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iffc114939cb37129057e9c4864f=
ae9e09c3c7fe4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1417 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--7+JXaY2nhos=--

