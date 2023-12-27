From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 27 Dec 2023 10:50:41 +0000
References: <gerrit.1703674237000.Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <64c2cb669b336602b2102ee9ac8951c26bac536f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mfPZ6r2PNk8="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mfPZ6r2PNk8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail

to review the following change.


Change subject: GHA: increase verbosity for make check
......................................................................

GHA: increase verbosity for make check

Make sure we get to see the test-suite.log on
failure.

Change-Id: Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 5 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/485/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--mfPZ6r2PNk8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: increase verbosity for make check<br><br>Make sure we ge=
t to see the test-suite.log on<br>failure.<br><br>Change-Id: Ie44a4b750605c=
4cc3ac1f75e1fa5ab85804ffa71<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 5=
 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/85/485/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/=
build.yaml b/.github/workflows/build.yaml</span><br><span>index 4393f5c..51=
100c3 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br><=
span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -163,7 +163,7 @@=
</span><br><span>       - name: make all</span><br><span>         run: make=
 -j3</span><br><span>       - name: make check</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        run: make check</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        run: make check VERBOSE=3D1</span><br>=
<span> </span><br><span>   ubuntu-clang-asan:</span><br><span>     strategy=
:</span><br><span>@@ -190,7 +190,7 @@</span><br><span>       - name: make a=
ll</span><br><span>         run: make -j3</span><br><span>       - name: ma=
ke check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: =
make check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
un: make check VERBOSE=3D1</span><br><span> </span><br><span>   macos:</spa=
n><br><span>     strategy:</span><br><span>@@ -239,7 +239,7 @@</span><br><s=
pan>       - name: make all</span><br><span>         run: make -j4</span><b=
r><span>       - name: make check</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        run: make check</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        run: make check VERBOSE=3D1</span><br><span> </span=
><br><span>   msvc:</span><br><span>       strategy:</span><br><span>@@ -34=
8,7 +348,7 @@</span><br><span>       - name: make all</span><br><span>     =
    run: make -j3</span><br><span>       - name: make check</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        run: make check</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        run: make check VERBOSE=
=3D1</span><br><span> </span><br><span>   mbedtls3:</span><br><span>     st=
rategy:</span><br><span>@@ -399,4 +399,4 @@</span><br><span>       - name: =
make all</span><br><span>         run: make -j3</span><br><span>       - na=
me: make check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 run: make check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     run: make check VERBOSE=3D1</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail">=
change 485</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie44a4b750605c4cc3ac1f75e1fa=
5ab85804ffa71 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 485 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--mfPZ6r2PNk8=--

