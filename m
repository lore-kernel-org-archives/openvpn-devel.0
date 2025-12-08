From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 19:29:56 +0000
In-Reply-To: <gerrit.1765212547000.I9e1d935f617db9198ed5934b88c0fcdef61a8568@...2715...>
References: <gerrit.1765212547000.I9e1d935f617db9198ed5934b88c0fcdef61a8568@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <aedc7af1e654bf1cbcef60ace73a2bc11ac5384f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="08KPtNl4qtk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Add minGW
 Release build
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

--08KPtNl4qtk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1421?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: GHA: Add minGW Release build
......................................................................

GHA: Add minGW Release build

There are sometimes differences in the build results.

Change-Id: I9e1d935f617db9198ed5934b88c0fcdef61a8568
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1421
Message-Id: <20251208170937.5221-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
896.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 13 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1421/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index ea45740..ce730f6 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -68,8 +68,9 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
+        build: [Release, Debug]

-    name: "gcc-mingw - ${{ matrix.arch }} - OSSL"
+    name: "gcc-mingw - ${{ matrix.arch }} - ${{matrix.build }} - OSSL"
     runs-on: ubuntu-24.04
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
@@ -91,22 +92,22 @@
         with:
           configurePreset: mingw-${{ matrix.arch }}
           buildPreset: mingw-${{ matrix.arch }}
-          buildPresetAdditionalArgs: "['--config Debug']"
+          buildPresetAdditionalArgs: "['--config ${{ matrix.build }}']"

       - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
-          name: openvpn-mingw-${{ matrix.arch }}
+          name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}
           path: |
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
Debug/*.exe
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
Debug/*.dll
-            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
${{ matrix.build }}/*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
${{ matrix.build }}/*.dll
+            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${=
{ matrix.build }}/test_*.exe

       - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
-          name: openvpn-mingw-${{ matrix.arch }}-tests
+          name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: |
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/test_*.exe
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{=
 matrix.build }}/test_*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{=
 matrix.build }}/*.dll

   mingw-unittest:
     needs: [ mingw ]
@@ -115,16 +116,17 @@
       matrix:
         arch: [x86, x64]
         test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_=
parse, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
+        build: [Release, Debug]

     runs-on: windows-2025
-    name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
+    name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ ma=
trix.build }} - OSSL"
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2955... # v5.0.1
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@...2958... # v6.0.0
         with:
-          name: openvpn-mingw-${{ matrix.arch }}-tests
+          name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: unittests
       - name: Run ${{ matrix.test }} unit test
         run: ./unittests/test_${{ matrix.test }}.exe

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1421?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e1d935f617db9198ed5934b88c0fcdef61a8568
Gerrit-Change-Number: 1421
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--08KPtNl4qtk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1421?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">GHA: Add minGW Release build<br><br=
>There are sometimes differences in the build results.<br><br>Change-Id: I9=
e1d935f617db9198ed5934b88c0fcdef61a8568<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1421<br>Message-Id: =
&lt;20251208170937.5221-1-gert@...1296...&gt;<br>URL: https://www.mail-arch=
ive.com/openvpn-devel@lists.sourceforge.net/msg34896.html<br>Signed-off-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.y=
aml<br>1 file changed, 13 insertions(+), 11 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/14=
21/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/=
build.yaml</span><br><span>index ea45740..ce730f6 100644</span><br><span>--=
- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/bu=
ild.yaml</span><br><span>@@ -68,8 +68,9 @@</span><br><span>       fail-fast=
: false</span><br><span>       matrix:</span><br><span>         arch: [x86,=
 x64]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        build:=
 [Release, Debug]</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    name: &quot;gcc-mingw - ${{ matrix.arch }} - OSSL&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    name: &quot;gcc-m=
ingw - ${{ matrix.arch }} - ${{matrix.build }} - OSSL&quot;</span><br><span=
>     runs-on: ubuntu-24.04</span><br><span>     env:</span><br><span>     =
  VCPKG_ROOT: ${{ github.workspace }}/vcpkg</span><br><span>@@ -91,22 +92,2=
2 @@</span><br><span>         with:</span><br><span>           configurePre=
set: mingw-${{ matrix.arch }}</span><br><span>           buildPreset: mingw=
-${{ matrix.arch }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
        buildPresetAdditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+          buildPreset=
AdditionalArgs: &quot;[&#39;--config ${{ matrix.build }}&#39;]&quot;</span>=
<br><span> </span><br><span>       - uses: actions/upload-artifact@...2973...=
.. # v5.0.0</span><br><span>         with:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-          name: openvpn-mingw-${{ matrix.arch }}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          name: openvpn-m=
ingw-${{ matrix.arch }}-${{ matrix.build }}</span><br><span>           path=
: |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ${{ gi=
thub.workspace }}/out/build/mingw/${{ matrix.arch }}/**/Debug/*.exe</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            ${{ github.worksp=
ace }}/out/build/mingw/${{ matrix.arch }}/**/Debug/*.dll</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            !${{ github.workspace }}/out=
/build/mingw/${{ matrix.arch }}/Debug/test_*.exe</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            ${{ github.workspace }}/out/build/=
mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.exe</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ${{ github.workspace }}/out/b=
uild/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.dll</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            !${{ github.workspace }}=
/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe</span><b=
r><span> </span><br><span>       - uses: actions/upload-artifact@...2956...=
 # v5.0.0</span><br><span>         with:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-          name: openvpn-mingw-${{ matrix.arch }}-tests</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+          name: openv=
pn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests</span><br><span>     =
      path: |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*=
.exe</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ${{ g=
ithub.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            ${{ github.worksp=
ace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            ${{ github=
.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/*.dll<=
/span><br><span> </span><br><span>   mingw-unittest:</span><br><span>     n=
eeds: [ mingw ]</span><br><span>@@ -115,16 +116,17 @@</span><br><span>     =
  matrix:</span><br><span>         arch: [x86, x64]</span><br><span>       =
  test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_parse, =
ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        build: [Release, Debug]</span=
><br><span> </span><br><span>     runs-on: windows-2025</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    name: &quot;mingw unittest ${{ matrix=
.test }} - ${{ matrix.arch }} - OSSL&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    name: &quot;mingw unittest ${{ matrix.test }} - =
${{ matrix.arch }} - ${{ matrix.build }} - OSSL&quot;</span><br><span>     =
steps:</span><br><span>       - name: Checkout OpenVPN</span><br><span>    =
     uses: actions/checkout@...2955... # v5.0.1</span><br><span>       - na=
me: Retrieve mingw unittest</span><br><span>         uses: actions/download=
-artifact@...2958... # v6.0.0</span><br><span>         with:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-          name: openvpn-mingw-${{ ma=
trix.arch }}-tests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
         name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests</=
span><br><span>           path: unittests</span><br><span>       - name: Ru=
n ${{ matrix.test }} unit test</span><br><span>         run: ./unittests/te=
st_${{ matrix.test }}.exe</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1421?usp=3Demail">change=
 1421</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1421?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e1d935f617db9198ed5934b88c=
0fcdef61a8568 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1421 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--08KPtNl4qtk=--

