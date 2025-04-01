From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 1 Apr 2025 18:00:59 +0000
In-Reply-To: <gerrit.1743422979000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
References: <gerrit.1743422979000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cc1b7a551f8e72bb5f868baf6e4d462b8e31453d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SXa6UDsYZJA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SXa6UDsYZJA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/926?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250331153309.77901-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
290.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
M .github/workflows/doxygen.yml
3 files changed, 20 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/926/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 617b866..5e8e15d 100644
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
@@ -58,11 +58,16 @@
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

@@ -87,7 +92,7 @@
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -97,7 +102,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -105,7 +110,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -126,7 +131,7 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2817... # v4.1.8
+        uses: actions/download-artifact@...2869... # v4.2.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -271,7 +276,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2861... # v3.31.5
+      - uses: lukka/get-cmake@...2870... # v3.31.6

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -279,7 +284,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -298,7 +303,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -408,7 +413,7 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--SXa6UDsYZJA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/926?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: Dependency and Actions update April 2025<br=
><br>- Fix Android build with newer vcpkg<br>  Need to sync CMAKE_SYSTEM_VE=
RSION with vcpkg.<br>- Update mbedTLS v3 builds to latest release.<br>  Dep=
ends on commit<br>  4897c522948c8cdb82c0325ee08f6907cfc16f57<br>- Update al=
l actions to latest releases.<br><br>Change-Id: Ie9bffcc487f53a3a8ae6e59b79=
e654360d99902c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &=
lt;20250331153309.77901-1-frank@...2641...&gt;<br>URL: https://www.mail-arc=
hive.com/openvpn-devel@lists.sourceforge.net/msg31290.html<br>Signed-off-by=
: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.=
yaml<br>M .github/workflows/coverity-scan.yml<br>M .github/workflows/doxyge=
n.yml<br>3 files changed, 20 insertions(+), 15 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/926/2</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</spa=
n><br><span>index 617b866..5e8e15d 100644</span><br><span>--- a/.github/wor=
kflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span>=
<br><span>@@ -27,7 +27,7 @@</span><br><span>       - name: Show changes on =
standard output</span><br><span>         run: git diff</span><br><span>    =
     working-directory: openvpn</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      - uses: actions/upload-artifact@...2860... # v4.6.0</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/uploa=
d-artifact@...2868... # v4.6.2</span><br><span>         with:</span><br><sp=
an>           name: uncrustify-changes.patch</span><br><span>           pat=
h: &#39;openvpn/uncrustify-changes.patch&#39;</span><br><span>@@ -58,11 +58=
,16 @@</span><br><span>       - name: Install vcpkg</span><br><span>       =
  uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommi=
tId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6=
f463dc0341ac0ee6fa4</span><br><span>       - name: Install dependencies</sp=
an><br><span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</=
span><br><span>       - name: configure OpenVPN with cmake</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        run: cmake -S . -B openvpn-bui=
ld -DUNSUPPORTED_BUILDS=3Dyes -DCMAKE_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_=
DIR=3D${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} -DENABLE_PKCS11=3D=
false -DBUILD_TESTING=3Dtrue -DCMAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi }} -=
DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        run: |</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+          cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3Dy=
es \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            -DC=
MAKE_SYSTEM_NAME=3DAndroid -DCMAKE_SYSTEM_VERSION=3D28 \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            -DCMAKE_ANDROID_ARCH_ABI=
=3D${{ matrix.abi }} \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg=
_triplet }} \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DENABLE_LZO=3Dfalse -=
DUSE_WERROR=3Dno</span><br><span>       - name: Build OpenVPN Android binar=
y with cmake</span><br><span>         run: cmake --build openvpn-build</spa=
n><br><span> </span><br><span>@@ -87,7 +92,7 @@</span><br><span>       - na=
me: Restore from cache and install vcpkg</span><br><span>         uses: luk=
ka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 33e9c9=
9208736b713cabe4490e15235f62f893d4</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341a=
c0ee6fa4</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json=
&#39;</span><br><span> </span><br><span>       - name: Run CMake with vcpkg=
.json manifest</span><br><span>@@ -97,7 +102,7 @@</span><br><span>         =
  buildPreset: mingw-${{ matrix.arch }}</span><br><span>           buildPre=
setAdditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions=
/upload-artifact@...2860... # v4.6.0</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      - uses: actions/upload-artifact@...2868... # v4.6.2<=
/span><br><span>         with:</span><br><span>           name: openvpn-min=
gw-${{ matrix.arch }}</span><br><span>           path: |</span><br><span>@@=
 -105,7 +110,7 @@</span><br><span>             ${{ github.workspace }}/out/=
build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br><span>             !${=
{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 - uses: actions/upload-artifact@...2860... # v4.6.0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...493...=
2868... # v4.6.2</span><br><span>         with:</span><br><span>           =
name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>           pat=
h: |</span><br><span>@@ -126,7 +131,7 @@</span><br><span>       - name: Che=
ckout OpenVPN</span><br><span>         uses: actions/checkout@...2844... # =
v4.2.2</span><br><span>       - name: Retrieve mingw unittest</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/download-arti=
fact@...2817... # v4.1.8</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        uses: actions/download-artifact@...2869... # v4.2.1</span><br>=
<span>         with:</span><br><span>           name: openvpn-mingw-${{ mat=
rix.arch }}-tests</span><br><span>           path: unittests</span><br><spa=
n>@@ -271,7 +276,7 @@</span><br><span>       runs-on: windows-latest</span>=
<br><span>       steps:</span><br><span>       - uses: actions/checkout@...493...=
2844... # v4.2.2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 - uses: lukka/get-cmake@...2861... # v3.31.5</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2870... # v3.31.=
6</span><br><span> </span><br><span>       - name: Install rst2html</span><=
br><span>         run: python -m pip install --upgrade pip docutils</span><=
br><span>@@ -279,7 +284,7 @@</span><br><span>       - name: Restore artifac=
ts, or setup vcpkg (do not install any package)</span><br><span>         us=
es: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId:=
 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463=
dc0341ac0ee6fa4</span><br><span>           vcpkgJsonGlob: &#39;**/windows/v=
cpkg.json&#39;</span><br><span> </span><br><span>       - name: Run CMake w=
ith vcpkg.json manifest (NO TESTS)</span><br><span>@@ -298,7 +303,7 @@</spa=
n><br><span>           testPreset: win-${{ matrix.arch }}-release</span><br=
><span>           testPresetAdditionalArgs: &quot;[&#39;--output-on-failure=
&#39;]&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      - uses: actions/upload-artifact@...2860... # v4.6.0</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload=
-artifact@...2868... # v4.6.2</span><br><span>         with:</span><br><spa=
n>           name: openvpn-msvc-${{ matrix.arch }}</span><br><span>        =
   path: |</span><br><span>@@ -408,7 +413,7 @@</span><br><span>           s=
ubmodules: true</span><br><span>           # versioning=3Dsemver-coerced</s=
pan><br><span>           repository: Mbed-TLS/mbedtls</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-          ref: v3.6.2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          ref: v3.6.3</span><br><span>   =
    - name: &quot;mbedtls: make no_test&quot;</span><br><span>         run:=
 make -j3 no_test SHARED=3D1</span><br><span>         working-directory: mb=
edtls</span><br><span>diff --git a/.github/workflows/coverity-scan.yml b/.g=
ithub/workflows/coverity-scan.yml</span><br><span>index 3381d8f..222c57e 10=
0644</span><br><span>--- a/.github/workflows/coverity-scan.yml</span><br><s=
pan>+++ b/.github/workflows/coverity-scan.yml</span><br><span>@@ -13,7 +13,=
7 @@</span><br><span>     steps:</span><br><span>       - name: Check submi=
ssion cache</span><br><span>         id: check_submit</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/restore@...2877...=
... # v4.2.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/cache/restore@...2871... # v4.2.3</span><br><span>         w=
ith:</span><br><span>           path: |</span><br><span>             cov-in=
t</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </span><br><span>     =
  - name: Cache submission</span><br><span>         if: steps.check_submit.=
outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/cache/save@...2847... # v4.2.0</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cach=
e/save@...2871... # v4.2.3</span><br><span>         with:</span><br><span> =
          path: |</span><br><span>             cov-int</span><br><span>diff=
 --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml</spa=
n><br><span>index f1ece70..ffd1b82 100644</span><br><span>--- a/.github/wor=
kflows/doxygen.yml</span><br><span>+++ b/.github/workflows/doxygen.yml</spa=
n><br><span>@@ -34,7 +34,7 @@</span><br><span>           touch doc/doxygen/=
html/.nojekyll</span><br><span>       - name: Upload static files as artifa=
ct</span><br><span>         id: deployment</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: actions/upload-pages-artifact@...2858...=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/upload-pages-artifact@...2872... # v3.0.1</span><br><span>         with:=
</span><br><span>           path: doxygen/doc/doxygen/html/</span><br><span=
> </span><br><span>@@ -50,4 +50,4 @@</span><br><span>     steps:</span><br>=
<span>       - name: Deploy to GitHub Pages</span><br><span>         id: de=
ployment</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses:=
 actions/deploy-pages@...2859...</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uses: actions/deploy-pages@...2873... # v4.0.5</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/926?usp=3Demail">change 926</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/926?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie9bffcc487f53a3a8ae6e59b79e=
654360d99902c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 926 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--SXa6UDsYZJA=--

