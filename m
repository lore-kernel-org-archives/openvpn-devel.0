From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 28 Apr 2026 15:35:19 +0000
References: <gerrit.1777390515000.I43851d96c28af0ebcf0c6beab21659e68919d0c6@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5b1e101a0302162816f231949540876ad8ea72dc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6xcIpEgVI8Q="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Maintenance
 Update April 2026
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

--6xcIpEgVI8Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1641?usp=3Demail

to review the following change.


Change subject: GHA: Maintenance Update April 2026
......................................................................

GHA: Maintenance Update April 2026

- Updates GHA actions
- Switch clang-format job to archive: false supported
  in new actions/upload-artifact version. This way the
  file is not encapsulated in a zip
- Drop macos-14 builds. This runner is considered
  deprecated and will be removed later this year.

Change-Id: I43851d96c28af0ebcf0c6beab21659e68919d0c6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
M .github/workflows/doxygen.yml
3 files changed, 20 insertions(+), 20 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1641/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index e4cb799..895f469 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -19,9 +19,9 @@
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
         run: git diff --output=3Dformat-changes.patch
-      - uses: actions/upload-artifact@...2978... # v6.0.0
+      - uses: actions/upload-artifact@...3031... # v7.0.1
         with:
-          name: format-changes.patch
+          archive: false
           path: format-changes.patch
       - name: Set job status
         run: test ! -s format-changes.patch
@@ -45,9 +45,9 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2
-      - uses: lukka/get-cmake@...2999... # v4.2.3
+      - uses: lukka/get-cmake@...3028... # v4.3.2
       - name: Install vcpkg
-        uses: lukka/run-vcpkg@...2815... # v11.5
+        uses: lukka/run-vcpkg@...3029... # v11.6
         with:
           vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
       - name: Install dependencies
@@ -80,21 +80,21 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2

-      - uses: lukka/get-cmake@...2999... # v4.2.3
+      - uses: lukka/get-cmake@...3028... # v4.3.2
       - name: Restore from cache and install vcpkg
-        uses: lukka/run-vcpkg@...2815... # v11.5
+        uses: lukka/run-vcpkg@...3029... # v11.6
         with:
           vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2816... # v10.8
+        uses: lukka/run-cmake@...3030... # v10.9
         with:
           configurePreset: mingw-${{ matrix.arch }}
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config ${{ matrix.build }}']"

-      - uses: actions/upload-artifact@...2978... # v6.0.0
+      - uses: actions/upload-artifact@...3031... # v7.0.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}
           path: |
@@ -102,7 +102,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
${{ matrix.build }}/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**=
/${{ matrix.build }}/test_*.exe

-      - uses: actions/upload-artifact@...2978... # v6.0.0
+      - uses: actions/upload-artifact@...3031... # v7.0.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: |
@@ -124,7 +124,7 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2980... # v7.0.0
+        uses: actions/download-artifact@...3032... # v8.0.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: unittests
@@ -211,7 +211,7 @@
       matrix:
         ssllib: [openssl@...1554..., libressl]
         build: [normal, asan]
-        os: [macos-14, macos-15, macos-26]
+        os: [macos-15, macos-26]
         include:
           - build: asan
             cflags: "-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1"
@@ -266,26 +266,26 @@
       runs-on: windows-2025
       steps:
       - uses: actions/checkout@...2998... # v6.0.2
-      - uses: lukka/get-cmake@...2999... # v4.2.3
+      - uses: lukka/get-cmake@...3028... # v4.3.2

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils

       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
-        uses: lukka/run-vcpkg@...2815... # v11.5
+        uses: lukka/run-vcpkg@...3029... # v11.6
         with:
           vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
-        uses: lukka/run-cmake@...2816... # v10.8
+        uses: lukka/run-cmake@...3030... # v10.9
         if: ${{ matrix.arch =3D=3D 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release

       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2816... # v10.8
+        uses: lukka/run-cmake@...3030... # v10.9
         if: ${{ matrix.arch !=3D 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
@@ -293,7 +293,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2978... # v6.0.0
+      - uses: actions/upload-artifact@...3031... # v7.0.1
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index 5554c4d..1eec1ed 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...3000... # v5.0.3
+        uses: actions/cache/restore@...3024... # v5.0.5
         with:
           path: |
             cov-int
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...3000... # v5.0.3
+        uses: actions/cache/save@...3024... # v5.0.5
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index b28dd70..30988b5 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -35,7 +35,7 @@
           touch doc/doxygen/html/.nojekyll
       - name: Upload static files as artifact
         id: deployment
-        uses: actions/upload-pages-artifact@...2930... # v4.0.0
+        uses: actions/upload-pages-artifact@...3033... # v5
         with:
           path: doxygen/doc/doxygen/html/

@@ -51,4 +51,4 @@
     steps:
       - name: Deploy to GitHub Pages
         id: deployment
-        uses: actions/deploy-pages@...2873... # v4.0.5
+        uses: actions/deploy-pages@...3034... # v5

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1641?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43851d96c28af0ebcf0c6beab21659e68919d0c6
Gerrit-Change-Number: 1641
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--6xcIpEgVI8Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1641?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">GHA: Maintenance Update April 2026<br><br>-=
 Updates GHA actions<br>- Switch clang-format job to archive: false support=
ed<br>  in new actions/upload-artifact version. This way the<br>  file is n=
ot encapsulated in a zip<br>- Drop macos-14 builds. This runner is consider=
ed<br>  deprecated and will be removed later this year.<br><br>Change-Id: I=
43851d96c28af0ebcf0c6beab21659e68919d0c6<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>M .g=
ithub/workflows/coverity-scan.yml<br>M .github/workflows/doxygen.yml<br>3 f=
iles changed, 20 insertions(+), 20 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1641/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yam=
l</span><br><span>index e4cb799..895f469 100644</span><br><span>--- a/.gith=
ub/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml<=
/span><br><span>@@ -19,9 +19,9 @@</span><br><span>         run: pre-commit =
run -a --show-diff-on-failure || true</span><br><span>       - name: Check =
for changes</span><br><span>         run: git diff --output=3Dformat-change=
s.patch</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: =
actions/upload-artifact@...2978... # v6.0.0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...3031... # =
v7.0.1</span><br><span>         with:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-          name: format-changes.patch</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          archive: false</span><br><span>=
           path: format-changes.patch</span><br><span>       - name: Set jo=
b status</span><br><span>         run: test ! -s format-changes.patch</span=
><br><span>@@ -45,9 +45,9 @@</span><br><span>     steps:</span><br><span>  =
     - name: Checkout OpenVPN</span><br><span>         uses: actions/checko=
ut@...2998... # v6.0.2</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      - uses: lukka/get-cmake@...2999... # v4.2.3</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...3028... # v=
4.3.2</span><br><span>       - name: Install vcpkg</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        uses: lukka/run-vcpkg@...2815... # v11=
.5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: luk=
ka/run-vcpkg@...3029... # v11.6</span><br><span>         with:</span><br><s=
pan>           vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c</=
span><br><span>       - name: Install dependencies</span><br><span>@@ -80,2=
1 +80,21 @@</span><br><span>       - name: Checkout OpenVPN</span><br><span=
>         uses: actions/checkout@...2998... # v6.0.2</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cm=
ake@...2999... # v4.2.3</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      - uses: lukka/get-cmake@...3028... # v4.3.2</span><br><span>     =
  - name: Restore from cache and install vcpkg</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        uses: lukka/run-vcpkg@...2815... # v11.5</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/r=
un-vcpkg@...3029... # v11.6</span><br><span>         with:</span><br><span>=
           vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c</span=
><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><b=
r><span> </span><br><span>       - name: Run CMake with vcpkg.json manifest=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/r=
un-cmake@...2816... # v10.8</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: lukka/run-cmake@...3030... # v10.9</span><br><span>  =
       with:</span><br><span>           configurePreset: mingw-${{ matrix.a=
rch }}</span><br><span>           buildPreset: mingw-${{ matrix.arch }}</sp=
an><br><span>           buildPresetAdditionalArgs: &quot;[&#39;--config ${{=
 matrix.build }}&#39;]&quot;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2978... #=
 v6.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses=
: actions/upload-artifact@...3031... # v7.0.1</span><br><span>         with=
:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }}-${{ mat=
rix.build }}</span><br><span>           path: |</span><br><span>@@ -102,7 +=
102,7 @@</span><br><span>             ${{ github.workspace }}/out/build/min=
gw/${{ matrix.arch }}/**/${{ matrix.build }}/*.dll</span><br><span>        =
     !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ mat=
rix.build }}/test_*.exe</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2978... # v6.0=
.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: act=
ions/upload-artifact@...3031... # v7.0.1</span><br><span>         with:</sp=
an><br><span>           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.b=
uild }}-tests</span><br><span>           path: |</span><br><span>@@ -124,7 =
+124,7 @@</span><br><span>       - name: Checkout OpenVPN</span><br><span> =
        uses: actions/checkout@...2998... # v6.0.2</span><br><span>       -=
 name: Retrieve mingw unittest</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uses: actions/download-artifact@...2980... # v7.0.0</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/down=
load-artifact@...3032... # v8.0.1</span><br><span>         with:</span><br>=
<span>           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}=
-tests</span><br><span>           path: unittests</span><br><span>@@ -211,7=
 +211,7 @@</span><br><span>       matrix:</span><br><span>         ssllib: =
[openssl@...1554..., libressl]</span><br><span>         build: [normal, asa=
n]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: [macos-=
14, macos-15, macos-26]</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        os: [macos-15, macos-26]</span><br><span>         include:</spa=
n><br><span>           - build: asan</span><br><span>             cflags: &=
quot;-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall  -fno-optim=
ize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointe=
r -g -O1&quot;</span><br><span>@@ -266,26 +266,26 @@</span><br><span>      =
 runs-on: windows-2025</span><br><span>       steps:</span><br><span>      =
 - uses: actions/checkout@...2998... # v6.0.2</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2999... # v4.2.3</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/g=
et-cmake@...3028... # v4.3.2</span><br><span> </span><br><span>       - nam=
e: Install rst2html</span><br><span>         run: python -m pip install --u=
pgrade pip docutils</span><br><span> </span><br><span>       - name: Restor=
e artifacts, or setup vcpkg (do not install any package)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-vcpkg@...2815...=
 # v11.5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        use=
s: lukka/run-vcpkg@...3029... # v11.6</span><br><span>         with:</span>=
<br><span>           vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149d=
db7c</span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#=
39;</span><br><span> </span><br><span>       - name: Run CMake with vcpkg.j=
son manifest (NO TESTS)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        uses: lukka/run-cmake@...2816... # v10.8</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@...3030... # v=
10.9</span><br><span>         if: ${{ matrix.arch =3D=3D &#39;arm64&#39; }}=
</span><br><span>         with:</span><br><span>           configurePreset:=
 win-${{ matrix.arch }}-release</span><br><span>           buildPreset: win=
-${{ matrix.arch }}-release</span><br><span> </span><br><span>       - name=
: Run CMake with vcpkg.json manifest</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        uses: lukka/run-cmake@...2816... # v10.8</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@...220...=
..3030... # v10.9</span><br><span>         if: ${{ matrix.arch !=3D &#39;ar=
m64&#39; }}</span><br><span>         with:</span><br><span>           confi=
gurePreset: win-${{ matrix.arch }}-release</span><br><span>@@ -293,7 +293,7=
 @@</span><br><span>           testPreset: win-${{ matrix.arch }}-release</=
span><br><span>           testPresetAdditionalArgs: &quot;[&#39;--output-on=
-failure&#39;]&quot;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-      - uses: actions/upload-artifact@...2978... # v6.0.0<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: action=
s/upload-artifact@...3031... # v7.0.1</span><br><span>         with:</span>=
<br><span>           name: openvpn-msvc-${{ matrix.arch }}</span><br><span>=
           path: |</span><br><span>diff --git a/.github/workflows/coverity-=
scan.yml b/.github/workflows/coverity-scan.yml</span><br><span>index 5554c4=
d..1eec1ed 100644</span><br><span>--- a/.github/workflows/coverity-scan.yml=
</span><br><span>+++ b/.github/workflows/coverity-scan.yml</span><br><span>=
@@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><span>       - name=
: Check submission cache</span><br><span>         id: check_submit</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/re=
store@...3000... # v5.0.3</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uses: actions/cache/restore@...3024... # v5.0.5</span><br><sp=
an>         with:</span><br><span>           path: |</span><br><span>      =
       cov-int</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </span><b=
r><span>       - name: Cache submission</span><br><span>         if: steps.=
check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        uses: actions/cache/save@...3000... # =
v5.0.3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses:=
 actions/cache/save@...3024... # v5.0.5</span><br><span>         with:</spa=
n><br><span>           path: |</span><br><span>             cov-int</span><=
br><span>diff --git a/.github/workflows/doxygen.yml b/.github/workflows/dox=
ygen.yml</span><br><span>index b28dd70..30988b5 100644</span><br><span>--- =
a/.github/workflows/doxygen.yml</span><br><span>+++ b/.github/workflows/dox=
ygen.yml</span><br><span>@@ -35,7 +35,7 @@</span><br><span>           touch=
 doc/doxygen/html/.nojekyll</span><br><span>       - name: Upload static fi=
les as artifact</span><br><span>         id: deployment</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/upload-pages-artifa=
ct@...2930... # v4.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        uses: actions/upload-pages-artifact@...3033... # v5</span><br><s=
pan>         with:</span><br><span>           path: doxygen/doc/doxygen/htm=
l/</span><br><span> </span><br><span>@@ -51,4 +51,4 @@</span><br><span>    =
 steps:</span><br><span>       - name: Deploy to GitHub Pages</span><br><sp=
an>         id: deployment</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uses: actions/deploy-pages@...2873... # v4.0.5</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/deploy-pages@=
...3034... # v5</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1641?usp=3Demail">change 1641</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1641?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43851d96c28af0ebcf0c6beab21=
659e68919d0c6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1641 </div>
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

--6xcIpEgVI8Q=--

