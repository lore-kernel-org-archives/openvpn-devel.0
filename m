From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 31 Mar 2025 12:09:42 +0000
References: <gerrit.1743422979000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d9df009c66721887d60bf724875b7d7e7dc84c6d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Br29M1Sn8K0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Dependency and
 Actions update April 2025
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

--Br29M1Sn8K0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/926?usp=3Demail

to review the following change.


Change subject: GHA: Dependency and Actions update April 2025
......................................................................

GHA: Dependency and Actions update April 2025

- Fix Android build with newer vcpkg
  Need to sync CMAKE_SYSTEM_VERSION with vcpkg.
- Update mbedTLS v3 builds to latest release.
  Depends on commit
  4897c522948c8cdb82c0325ee08f6907cfc16f57
- Update all actions to latest releases.

Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d99902c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
M .github/workflows/doxygen.yml
3 files changed, 20 insertions(+), 15 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/926/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b1af7ec..3fc44f5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -57,11 +57,16 @@
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
-        run: cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes -DCMAK=
E_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ mat=
rix.vcpkg_triplet }} -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DCMAKE=
_ANDROID_ARCH_ABI=3D${{ matrix.abi }} -DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno
+        run: |
+          cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes \
+            -DCMAKE_SYSTEM_NAME=3DAndroid -DCMAKE_SYSTEM_VERSION=3D28 \
+            -DCMAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi }} \
+            -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_t=
riplet }} \
+            -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DENABLE_LZO=3D=
false -DUSE_WERROR=3Dno
       - name: Build OpenVPN Android binary with cmake
         run: cmake --build openvpn-build

@@ -85,7 +90,7 @@
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -95,7 +100,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -103,7 +108,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -124,7 +129,7 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2817... # v4.1.8
+        uses: actions/download-artifact@...2869... # v4.2.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -269,7 +274,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2861... # v3.31.5
+      - uses: lukka/get-cmake@...2870... # v3.31.6

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -277,7 +282,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -296,7 +301,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -406,7 +411,7 @@
           submodules: true
           # versioning=3Dsemver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.2
+          ref: v3.6.3
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=3D1
         working-directory: mbedtls
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index 3381d8f..222c57e 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2847... # v4.2.0
+        uses: actions/cache/restore@...2871... # v4.2.3
         with:
           path: |
             cov-int
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2847... # v4.2.0
+        uses: actions/cache/save@...2871... # v4.2.3
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index f1ece70..ffd1b82 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -34,7 +34,7 @@
           touch doc/doxygen/html/.nojekyll
       - name: Upload static files as artifact
         id: deployment
-        uses: actions/upload-pages-artifact@...2858...
+        uses: actions/upload-pages-artifact@...2872... # v3.0.1
         with:
           path: doxygen/doc/doxygen/html/

@@ -50,4 +50,4 @@
     steps:
       - name: Deploy to GitHub Pages
         id: deployment
-        uses: actions/deploy-pages@...2859...
+        uses: actions/deploy-pages@...2873... # v4.0.5

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/926?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d99902c
Gerrit-Change-Number: 926
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Br29M1Sn8K0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/926?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Dependency and Actions update April 2025<br><br>- Fix An=
droid build with newer vcpkg<br>  Need to sync CMAKE_SYSTEM_VERSION with vc=
pkg.<br>- Update mbedTLS v3 builds to latest release.<br>  Depends on commi=
t<br>  4897c522948c8cdb82c0325ee08f6907cfc16f57<br>- Update all actions to =
latest releases.<br><br>Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d99902=
c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M =
.github/workflows/build.yaml<br>M .github/workflows/coverity-scan.yml<br>M =
.github/workflows/doxygen.yml<br>3 files changed, 20 insertions(+), 15 dele=
tions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/26/926/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/w=
orkflows/build.yaml</span><br><span>index b1af7ec..3fc44f5 100644</span><br=
><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/wor=
kflows/build.yaml</span><br><span>@@ -27,7 +27,7 @@</span><br><span>       =
- name: Show changes on standard output</span><br><span>         run: git d=
iff</span><br><span>         working-directory: openvpn</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...493...=
2860... # v4.6.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   - uses: actions/upload-artifact@...2868... # v4.6.2</span><br><span>    =
     with:</span><br><span>           name: uncrustify-changes.patch</span>=
<br><span>           path: &#39;openvpn/uncrustify-changes.patch&#39;</span=
><br><span>@@ -57,11 +57,16 @@</span><br><span>       - name: Install vcpkg=
</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><b=
r><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitI=
d: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span>       - name: =
Install dependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg inst=
all openssl lz4 cmocka</span><br><span>       - name: configure OpenVPN wit=
h cmake</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: c=
make -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes -DCMAKE_SYSTEM_NAME=
=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_tri=
plet }} -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DCMAKE_ANDROID_ARCH=
_ABI=3D${{ matrix.abi }} -DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+          cmake -S . -B openvpn-buil=
d -DUNSUPPORTED_BUILDS=3Dyes \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            -DCMAKE_SYSTEM_NAME=3DAndroid -DCMAKE_SYSTEM_VERSION=
=3D28 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
-DCMAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi }} \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALL=
ED_DIR}/${{ matrix.vcpkg_triplet }} \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtru=
e -DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno</span><br><span>       - name: Bui=
ld OpenVPN Android binary with cmake</span><br><span>         run: cmake --=
build openvpn-build</span><br><span> </span><br><span>@@ -85,7 +90,7 @@</sp=
an><br><span>       - name: Restore from cache and install vcpkg</span><br>=
<span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>   =
      with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: acd5bba5=
aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span>           vcpkgJsonGlob: =
&#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>       - na=
me: Run CMake with vcpkg.json manifest</span><br><span>@@ -95,7 +100,7 @@</=
span><br><span>           buildPreset: mingw-${{ matrix.arch }}</span><br><=
span>           buildPresetAdditionalArgs: &quot;[&#39;--config Debug&#39;]=
&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      - uses: actions/upload-artifact@...2860... # v4.6.0</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artif=
act@...2868... # v4.6.2</span><br><span>         with:</span><br><span>    =
       name: openvpn-mingw-${{ matrix.arch }}</span><br><span>           pa=
th: |</span><br><span>@@ -103,7 +108,7 @@</span><br><span>             ${{ =
github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><b=
r><span>             !${{ github.workspace }}/out/build/mingw/${{ matrix.ar=
ch }}/Debug/test_*.exe</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2860... # v4.6.=
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: acti=
ons/upload-artifact@...2868... # v4.6.2</span><br><span>         with:</spa=
n><br><span>           name: openvpn-mingw-${{ matrix.arch }}-tests</span><=
br><span>           path: |</span><br><span>@@ -124,7 +129,7 @@</span><br><=
span>       - name: Checkout OpenVPN</span><br><span>         uses: actions=
/checkout@...2844... # v4.2.2</span><br><span>       - name: Retrieve mingw=
 unittest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses=
: actions/download-artifact@...2817... # v4.1.8</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/download-artifact@...2874...=
... # v4.2.1</span><br><span>         with:</span><br><span>           name=
: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>           path: u=
nittests</span><br><span>@@ -269,7 +274,7 @@</span><br><span>       runs-on=
: windows-latest</span><br><span>       steps:</span><br><span>       - use=
s: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2861... # v3.31.5</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cm=
ake@...2870... # v3.31.6</span><br><span> </span><br><span>       - name: I=
nstall rst2html</span><br><span>         run: python -m pip install --upgra=
de pip docutils</span><br><span>@@ -277,7 +282,7 @@</span><br><span>       =
- name: Restore artifacts, or setup vcpkg (do not install any package)</spa=
n><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><sp=
an>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
      vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: ac=
d5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span>           vcpkgJson=
Glob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </span><br><span>   =
    - name: Run CMake with vcpkg.json manifest (NO TESTS)</span><br><span>@=
@ -296,7 +301,7 @@</span><br><span>           testPreset: win-${{ matrix.ar=
ch }}-release</span><br><span>           testPresetAdditionalArgs: &quot;[&=
#39;--output-on-failure&#39;]&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2825...=
60... # v4.6.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 - uses: actions/upload-artifact@...2868... # v4.6.2</span><br><span>      =
   with:</span><br><span>           name: openvpn-msvc-${{ matrix.arch }}</=
span><br><span>           path: |</span><br><span>@@ -406,7 +411,7 @@</span=
><br><span>           submodules: true</span><br><span>           # version=
ing=3Dsemver-coerced</span><br><span>           repository: Mbed-TLS/mbedtl=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v3.6.=
2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: v3.=
6.3</span><br><span>       - name: &quot;mbedtls: make no_test&quot;</span>=
<br><span>         run: make -j3 no_test SHARED=3D1</span><br><span>       =
  working-directory: mbedtls</span><br><span>diff --git a/.github/workflows=
/coverity-scan.yml b/.github/workflows/coverity-scan.yml</span><br><span>in=
dex 3381d8f..222c57e 100644</span><br><span>--- a/.github/workflows/coverit=
y-scan.yml</span><br><span>+++ b/.github/workflows/coverity-scan.yml</span>=
<br><span>@@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><span>   =
    - name: Check submission cache</span><br><span>         id: check_submi=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/cache/restore@...2847... # v4.2.0</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        uses: actions/cache/restore@...2871... # v4.2.3</sp=
an><br><span>         with:</span><br><span>           path: |</span><br><s=
pan>             cov-int</span><br><span>@@ -65,7 +65,7 @@</span><br><span>=
 </span><br><span>       - name: Cache submission</span><br><span>         =
if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/save@...493...=
2847... # v4.2.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     uses: actions/cache/save@...2871... # v4.2.3</span><br><span>         =
with:</span><br><span>           path: |</span><br><span>             cov-i=
nt</span><br><span>diff --git a/.github/workflows/doxygen.yml b/.github/wor=
kflows/doxygen.yml</span><br><span>index f1ece70..ffd1b82 100644</span><br>=
<span>--- a/.github/workflows/doxygen.yml</span><br><span>+++ b/.github/wor=
kflows/doxygen.yml</span><br><span>@@ -34,7 +34,7 @@</span><br><span>      =
     touch doc/doxygen/html/.nojekyll</span><br><span>       - name: Upload=
 static files as artifact</span><br><span>         id: deployment</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/upload-pa=
ges-artifact@...2858...</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uses: actions/upload-pages-artifact@...2872... # v3.0.1</span><=
br><span>         with:</span><br><span>           path: doxygen/doc/doxyge=
n/html/</span><br><span> </span><br><span>@@ -50,4 +50,4 @@</span><br><span=
>     steps:</span><br><span>       - name: Deploy to GitHub Pages</span><b=
r><span>         id: deployment</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        uses: actions/deploy-pages@...2859...</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        uses: actions/deploy-pages@...1665...=
873... # v4.0.5</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/926?usp=3Demail">change 926</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/926?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie9bffcc487f53a3a8ae6e59b79e=
654360d99902c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 926 </div>
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


--Br29M1Sn8K0=--

