From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 28 Feb 2025 20:41:14 +0000
In-Reply-To: <gerrit.1739196465000.I3922714972fffb3d7b1592f882d09c1fe1137241@...2715...>
References: <gerrit.1739196465000.I3922714972fffb3d7b1592f882d09c1fe1137241@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9161736c24bc68293a6890b84e4384885e97cb4c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WcqU9nKOTB0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Publish Doxygen
 documentation to Github Pages
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

--WcqU9nKOTB0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/887?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


Change subject: GHA: Publish Doxygen documentation to Github Pages
......................................................................

GHA: Publish Doxygen documentation to Github Pages

To make it more easily available to everyone.

Change-Id: I3922714972fffb3d7b1592f882d09c1fe1137241
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20250228170045.321832-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
989.html
Signed-off-by: Gert Doering <gert@...1296...>
---
A .github/workflows/doxygen.yml
1 file changed, 53 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/887/2

diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
new file mode 100644
index 0000000..f1ece70
--- /dev/null
+++ b/.github/workflows/doxygen.yml
@@ -0,0 +1,53 @@
+name: Deploy Doxygen documentation to Pages
+on:
+  push:
+    branches: ["master"]
+  workflow_dispatch:
+concurrency:
+  group: "pages"
+  cancel-in-progress: false
+jobs:
+  build:
+    runs-on: ubuntu-24.04
+    steps:
+      - uses: actions/checkout@...2844... # v4.2.2
+        with:
+          path: openvpn
+
+      - name: Install dependencies
+        run: |
+          sudo apt update
+          sudo apt install -y --no-install-recommends \
+            build-essential doxygen graphviz \
+            liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3=
-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automak=
e autoconf libssl-dev
+
+      - name: Build Doxygen documentation
+        id: build
+        run: |
+          cd openvpn
+          autoreconf -f -i
+          cd ..
+          mkdir doxygen
+          cd doxygen
+          ../openvpn/configure
+          make doxygen
+          touch doc/doxygen/html/.nojekyll
+      - name: Upload static files as artifact
+        id: deployment
+        uses: actions/upload-pages-artifact@...2858...
+        with:
+          path: doxygen/doc/doxygen/html/
+
+  deploy:
+    needs: build
+    permissions:
+      pages: write      # to deploy to Pages
+      id-token: write   # to verify the deployment originates from an appr=
opriate source
+    environment:
+      name: github-pages
+      url: ${{ steps.deployment.outputs.page_url }}
+    runs-on: ubuntu-24.04
+    steps:
+      - name: Deploy to GitHub Pages
+        id: deployment
+        uses: actions/deploy-pages@...2859...

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/887?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3922714972fffb3d7b1592f882d09c1fe1137241
Gerrit-Change-Number: 887
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--WcqU9nKOTB0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/887?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by uddr</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">GHA: Publish Doxygen documentation to Github Pages<br=
><br>To make it more easily available to everyone.<br><br>Change-Id: I39227=
14972fffb3d7b1592f882d09c1fe1137241<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...277...&g=
t;<br>Message-Id: &lt;20250228170045.321832-1-frank@...2641...&gt;<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30989.h=
tml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>A .git=
hub/workflows/doxygen.yml<br>1 file changed, 53 insertions(+), 0 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/8=
7/887/2</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/.github/workflows/doxygen.yml b/.github/workfl=
ows/doxygen.yml</span><br><span>new file mode 100644</span><br><span>index =
0000000..f1ece70</span><br><span>--- /dev/null</span><br><span>+++ b/.githu=
b/workflows/doxygen.yml</span><br><span>@@ -0,0 +1,53 @@</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+name: Deploy Doxygen documentation to =
Pages</span><br><span style=3D"color: hsl(120, 100%, 40%);">+on:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  push:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    branches: [&quot;master&quot;]</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  workflow_dispatch:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+concurrency:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  group: &quot;pages&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  cancel-in-progress: fal=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+jobs:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  build:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    steps:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@...2844... # =
v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        with:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          path: ope=
nvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      - name: Install dependencies=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: |</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+          sudo apt updat=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          sudo apt=
 install -y --no-install-recommends \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            build-essential doxygen graphviz \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            liblzo2-dev libpam=
0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html li=
bcmocka-dev python3-docutils libtool automake autoconf libssl-dev</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      - name: Build Doxygen documentation</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        id: build</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          cd openvpn</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+          autoreconf -f -i</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          cd ..</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+          mkdir doxygen</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          cd doxygen</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+          ../openvpn/con=
figure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          mak=
e doxygen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
touch doc/doxygen/html/.nojekyll</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      - name: Upload static files as artifact</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        id: deployment</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/upload-page=
s-artifact@...2858...</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      path: doxygen/doc/doxygen/html/</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 deploy:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    needs: =
build</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    permission=
s:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      pages: writ=
e      # to deploy to Pages</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      id-token: write   # to verify the deployment originates from =
an appropriate source</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    environment:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     name: github-pages</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      url: ${{ steps.deployment.outputs.page_url }}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    steps:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - name: Deploy to GitHub Pages</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        id: deployment</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/deploy-pages@...2859...</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/887?usp=3Demail">change 8=
87</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/887?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3922714972fffb3d7b1592f882d=
09c1fe1137241 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 887 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--WcqU9nKOTB0=--

