From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 16:49:11 +0000
References: <gerrit.1765212547000.I9e1d935f617db9198ed5934b88c0fcdef61a8568@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5001c42032e6a495806f8e03098935e5a5cdb2e1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J8Tzag+wZqA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--J8Tzag+wZqA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1421?usp=3Demail

to review the following change.


Change subject: GHA: Add minGW Release build
......................................................................

GHA: Add minGW Release build

There are sometimes differences in the build results.

Change-Id: I9e1d935f617db9198ed5934b88c0fcdef61a8568
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 13 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1421/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e1d935f617db9198ed5934b88c0fcdef61a8568
Gerrit-Change-Number: 1421
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--J8Tzag+wZqA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1421?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">GHA: Add minGW Release build<br><br>There a=
re sometimes differences in the build results.<br><br>Change-Id: I9e1d935f6=
17db9198ed5934b88c0fcdef61a8568<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file change=
d, 13 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/21/1421/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br=
><span>index ea45740..ce730f6 100644</span><br><span>--- a/.github/workflow=
s/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><=
span>@@ -68,8 +68,9 @@</span><br><span>       fail-fast: false</span><br><s=
pan>       matrix:</span><br><span>         arch: [x86, x64]</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        build: [Release, Debug]</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    na=
me: &quot;gcc-mingw - ${{ matrix.arch }} - OSSL&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    name: &quot;gcc-mingw - ${{ matrix.ar=
ch }} - ${{matrix.build }} - OSSL&quot;</span><br><span>     runs-on: ubunt=
u-24.04</span><br><span>     env:</span><br><span>       VCPKG_ROOT: ${{ gi=
thub.workspace }}/vcpkg</span><br><span>@@ -91,22 +92,22 @@</span><br><span=
>         with:</span><br><span>           configurePreset: mingw-${{ matri=
x.arch }}</span><br><span>           buildPreset: mingw-${{ matrix.arch }}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-          buildPresetA=
dditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          buildPresetAdditionalArgs: &quo=
t;[&#39;--config ${{ matrix.build }}&#39;]&quot;</span><br><span> </span><b=
r><span>       - uses: actions/upload-artifact@...2956... # v5.0.0</span><b=
r><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-          name: openvpn-mingw-${{ matrix.arch }}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+          name: openvpn-mingw-${{ matrix.arch=
 }}-${{ matrix.build }}</span><br><span>           path: |</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            ${{ github.workspace }}/ou=
t/build/mingw/${{ matrix.arch }}/**/Debug/*.exe</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            ${{ github.workspace }}/out/build/min=
gw/${{ matrix.arch }}/**/Debug/*.dll</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            !${{ github.workspace }}/out/build/mingw/${{ mat=
rix.arch }}/Debug/test_*.exe</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arc=
h }}/**/${{ matrix.build }}/*.exe</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            ${{ github.workspace }}/out/build/mingw/${{ matri=
x.arch }}/**/${{ matrix.build }}/*.dll</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            !${{ github.workspace }}/out/build/mingw/${{=
 matrix.arch }}/${{ matrix.build }}/test_*.exe</span><br><span> </span><br>=
<span>       - uses: actions/upload-artifact@...2956... # v5.0.0</span><br>=
<span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
         name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          name: openvpn-mingw-${{ matrix.=
arch }}-${{ matrix.build }}-tests</span><br><span>           path: |</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ${{ github.works=
pace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            ${{ github.workspace }}/o=
ut/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            ${{ github.workspace }}/out/build/min=
gw/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ${{ github.workspace }}/out/b=
uild/mingw/${{ matrix.arch }}/${{ matrix.build }}/*.dll</span><br><span> </=
span><br><span>   mingw-unittest:</span><br><span>     needs: [ mingw ]</sp=
an><br><span>@@ -115,16 +116,17 @@</span><br><span>       matrix:</span><br=
><span>         arch: [x86, x64]</span><br><span>         test: [argv, auth=
_token, buffer, cryptoapi, crypto, misc, options_parse, ncp, packet_id, pkt=
, provider, ssl, tls_crypt, user_pass]</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        build: [Release, Debug]</span><br><span> </span>=
<br><span>     runs-on: windows-2025</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    name: &quot;mingw unittest ${{ matrix.test }} - ${{ matr=
ix.arch }} - OSSL&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    name: &quot;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} =
- ${{ matrix.build }} - OSSL&quot;</span><br><span>     steps:</span><br><s=
pan>       - name: Checkout OpenVPN</span><br><span>         uses: actions/=
checkout@...2955... # v5.0.1</span><br><span>       - name: Retrieve mingw =
unittest</span><br><span>         uses: actions/download-artifact@...2972...=
. # v6.0.0</span><br><span>         with:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          name: openvpn-mingw-${{ matrix.arch }}-tests<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+          name: open=
vpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests</span><br><span>    =
       path: unittests</span><br><span>       - name: Run ${{ matrix.test }=
} unit test</span><br><span>         run: ./unittests/test_${{ matrix.test =
}}.exe</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1421?usp=3Demail">change 1421</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1421?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e1d935f617db9198ed5934b88c=
0fcdef61a8568 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1421 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--J8Tzag+wZqA=--

