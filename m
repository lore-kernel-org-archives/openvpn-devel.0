From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 22 Sep 2023 12:16:25 +0000
In-Reply-To: <gerrit.1695305263000.I30f4ea502a36eca155cbc79b89c0d18ee3419877@...2715...>
References: <gerrit.1695305263000.I30f4ea502a36eca155cbc79b89c0d18ee3419877@...2715...>
Reply-To: gert@...1296..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <e25f0f39627a7bd460aac3d62316d3ca20f24908-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RWb+Vud0Qrc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: CMake: fix
 HAVE_DAEMON detection on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RWb+Vud0Qrc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/36=
2?usp=3Demail )

Change subject: CMake: fix HAVE_DAEMON detection on Linux
......................................................................

CMake: fix HAVE_DAEMON detection on Linux

On Linux, daemon() is defined in unistd.h, not in
stdlib.h like in MacOS or FreeBSD.

Change-Id: I30f4ea502a36eca155cbc79b89c0d18ee3419877
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20230922103900.37205-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
058.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 454ef62..376a060 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -158,7 +158,7 @@
 check_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
 check_symbol_exists(basename libgen.h HAVE_BASENAME)
 check_symbol_exists(chsize io.h HAVE_CHSIZE)
-check_symbol_exists(daemon stdlib.h HAVE_DAEMON)
+check_symbol_exists(daemon "unistd.h;stdlib.h" HAVE_DAEMON)
 check_symbol_exists(dirname libgen.h HAVE_DIRNAME)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
 check_symbol_exists(mlockall sys/mman.h HAVE_MLOCKALL)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/362?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I30f4ea502a36eca155cbc79b89c0d18ee3419877
Gerrit-Change-Number: 362
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--RWb+Vud0Qrc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/362?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">CMake: fix HAVE_DAEMON detection on Linux<br><=
br>On Linux, daemon() is defined in unistd.h, not in<br>stdlib.h like in Ma=
cOS or FreeBSD.<br><br>Change-Id: I30f4ea502a36eca155cbc79b89c0d18ee3419877=
<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>Message-Id: &lt;20230922103900.37205-1-fran=
k@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg27058.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M CMakeLists.txt<br>1 file changed, 1 insertion(+), 1 de=
letion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 454ef=
62..376a060 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -158,7 +158,7 @@</span><br><span> chec=
k_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)</span><br><span>=
 check_symbol_exists(basename libgen.h HAVE_BASENAME)</span><br><span> chec=
k_symbol_exists(chsize io.h HAVE_CHSIZE)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-check_symbol_exists(daemon stdlib.h HAVE_DAEMON)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(daemon =
&quot;unistd.h;stdlib.h&quot; HAVE_DAEMON)</span><br><span> check_symbol_ex=
ists(dirname libgen.h HAVE_DIRNAME)</span><br><span> check_symbol_exists(ge=
trlimit sys/resource.h HAVE_GETRLIMIT)</span><br><span> check_symbol_exists=
(mlockall sys/mman.h HAVE_MLOCKALL)</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/362?usp=3Demai=
l">change 362</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/362?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I30f4ea502a36eca155cbc79b89c=
0d18ee3419877 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 362 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--RWb+Vud0Qrc=--

