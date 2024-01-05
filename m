From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 5 Jan 2024 14:49:15 +0000
In-Reply-To: <gerrit.1703674237000.Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71@...2715...>
References: <gerrit.1703674237000.Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7ff7db7eb1c0509085f590d060a57f5f2e8cb0a7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xYlheKgXAt4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: increase
 verbosity for make check
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

--xYlheKgXAt4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: GHA: increase verbosity for make check
......................................................................

GHA: increase verbosity for make check

Make sure we get to see the test-suite.log on
failure.

Change-Id: Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240105142340.25735-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
943.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 5 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/485/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 4393f5c..51100c3 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -163,7 +163,7 @@
       - name: make all
         run: make -j3
       - name: make check
-        run: make check
+        run: make check VERBOSE=3D1

   ubuntu-clang-asan:
     strategy:
@@ -190,7 +190,7 @@
       - name: make all
         run: make -j3
       - name: make check
-        run: make check
+        run: make check VERBOSE=3D1

   macos:
     strategy:
@@ -239,7 +239,7 @@
       - name: make all
         run: make -j4
       - name: make check
-        run: make check
+        run: make check VERBOSE=3D1

   msvc:
       strategy:
@@ -348,7 +348,7 @@
       - name: make all
         run: make -j3
       - name: make check
-        run: make check
+        run: make check VERBOSE=3D1

   mbedtls3:
     strategy:
@@ -399,4 +399,4 @@
       - name: make all
         run: make -j3
       - name: make check
-        run: make check
+        run: make check VERBOSE=3D1

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71
Gerrit-Change-Number: 485
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--xYlheKgXAt4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/485?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: increase verbosity for make check<br><br>Ma=
ke sure we get to see the test-suite.log on<br>failure.<br><br>Change-Id: I=
e44a4b750605c4cc3ac1f75e1fa5ab85804ffa71<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1711...=
27...&gt;<br>Message-Id: &lt;20240105142340.25735-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
943.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 .github/workflows/build.yaml<br>1 file changed, 5 insertions(+), 5 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/85/485/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/work=
flows/build.yaml</span><br><span>index 4393f5c..51100c3 100644</span><br><s=
pan>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/workfl=
ows/build.yaml</span><br><span>@@ -163,7 +163,7 @@</span><br><span>       -=
 name: make all</span><br><span>         run: make -j3</span><br><span>    =
   - name: make check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        run: make check</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        run: make check VERBOSE=3D1</span><br><span> </span><br><span> =
  ubuntu-clang-asan:</span><br><span>     strategy:</span><br><span>@@ -190=
,7 +190,7 @@</span><br><span>       - name: make all</span><br><span>      =
   run: make -j3</span><br><span>       - name: make check</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        run: make check</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        run: make check VERBOSE=3D=
1</span><br><span> </span><br><span>   macos:</span><br><span>     strategy=
:</span><br><span>@@ -239,7 +239,7 @@</span><br><span>       - name: make a=
ll</span><br><span>         run: make -j4</span><br><span>       - name: ma=
ke check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: =
make check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
un: make check VERBOSE=3D1</span><br><span> </span><br><span>   msvc:</span=
><br><span>       strategy:</span><br><span>@@ -348,7 +348,7 @@</span><br><=
span>       - name: make all</span><br><span>         run: make -j3</span><=
br><span>       - name: make check</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        run: make check</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        run: make check VERBOSE=3D1</span><br><span> </spa=
n><br><span>   mbedtls3:</span><br><span>     strategy:</span><br><span>@@ =
-399,4 +399,4 @@</span><br><span>       - name: make all</span><br><span>  =
       run: make -j3</span><br><span>       - name: make check</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        run: make check</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        run: make check VERBOS=
E=3D1</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail">change 485</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/485?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie44a4b750605c4cc3ac1f75e1fa=
5ab85804ffa71 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 485 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--xYlheKgXAt4=--

