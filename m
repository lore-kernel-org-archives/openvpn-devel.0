From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 13:51:16 +0000
References: <gerrit.1763560274000.Ifd63130832e3bf20bf9816887e218ae73e2f5cd1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f3c99ce9ce937188262cfdbf541a19169064c8a3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y/ynVfSP1og="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Maintenance
 update November 2025
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

--y/ynVfSP1og=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1381?usp=3Demail

to review the following change.


Change subject: GHA: Maintenance update November 2025
......................................................................

GHA: Maintenance update November 2025

Includes the following renovate changes:
- chore(deps): update dependency mbed-tls/mbedtls to v3.6.5
- chore(deps): update vcpkg digest to 3bbc280
- chore(deps): update dependency libressl/portable to v4.2.1
- chore(deps): update github actions
- chore(deps): update dependency aws/aws-lc to v1.64.0
- chore(deps): update github actions

Additionally, drop macos-13 since the
worker is deprecated.

Change-Id: Ifd63130832e3bf20bf9816887e218ae73e2f5cd1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
M .github/workflows/doxygen.yml
3 files changed, 34 insertions(+), 34 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1381/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index e068f58..96d2292 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -14,12 +14,12 @@
           sudo apt update && sudo apt install -y python3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: Run clang-format
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
         run: git diff --output=3Dformat-changes.patch
-      - uses: actions/upload-artifact@...2868... # v4.6.2
+      - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
           name: format-changes.patch
           path: format-changes.patch
@@ -44,12 +44,12 @@
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
-      - uses: lukka/get-cmake@...2927... # v4.1.1
+        uses: actions/checkout@...2955... # v5.0.1
+      - uses: lukka/get-cmake@...2957... # v4.1.2
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee
+          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -77,13 +77,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-=
essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1

-      - uses: lukka/get-cmake@...2927... # v4.1.1
+      - uses: lukka/get-cmake@...2957... # v4.1.2
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee
+          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -93,7 +93,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2868... # v4.6.2
+      - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -101,7 +101,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
Debug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2868... # v4.6.2
+      - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -120,9 +120,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2928... # v5.0.0
+        uses: actions/download-artifact@...2958... # v6.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -164,7 +164,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -194,7 +194,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang =
libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -212,7 +212,7 @@
       matrix:
         ssllib: [openssl@...2560..., openssl@...1554..., libressl]
         build: [normal, asan]
-        os: [macos-13, macos-14, macos-15]
+        os: [macos-14, macos-15]
         include:
           - build: asan
             cflags: "-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1"
@@ -234,7 +234,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libto=
ol automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -266,8 +266,8 @@

       runs-on: windows-2025
       steps:
-      - uses: actions/checkout@...2926... # v5.0.0
-      - uses: lukka/get-cmake@...2927... # v4.1.1
+      - uses: actions/checkout@...2955... # v5.0.1
+      - uses: lukka/get-cmake@...2957... # v4.1.2

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -275,7 +275,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee
+          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -294,7 +294,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2868... # v4.6.2
+      - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -334,12 +334,12 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
         with:
           path: libressl
           # versioning=3Dsemver-coerced
           repository: libressl/portable
-          ref: v4.1.0
+          ref: v4.2.1
       - name: "libressl: autogen.sh"
         env:
           LIBRESSL_GIT_OPTIONS: "--no-single-branch"
@@ -357,7 +357,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -398,13 +398,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
         with:
           path: mbedtls
           submodules: true
           # versioning=3Dsemver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.4
+          ref: v3.6.5
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=3D1
         working-directory: mbedtls
@@ -412,7 +412,7 @@
         run: sudo make install DESTDIR=3D/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -457,13 +457,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y gcc golang make liblzo=
2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev p=
ython3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf=
 pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "AWS-LC: checkout"
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
         with:
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.61.3
-      - uses: lukka/get-cmake@...2927... # v4.1.1
+          ref: v1.64.0
+      - uses: lukka/get-cmake@...2957... # v4.1.2
       - name: "AWS-LC: build"
         run: |
           mkdir build
@@ -472,7 +472,7 @@
           ninja install
         working-directory: aws-lc
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure with AWS-LC
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index e90aa2e..fa18115 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2929... # v4.2.4
+        uses: actions/cache/restore@...2959... # v4.3.0
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@

       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1

       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2929... # v4.2.4
+        uses: actions/cache/save@...2959... # v4.3.0
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index eaa7e4c..0828dd0 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -11,7 +11,7 @@
     runs-on: ubuntu-24.04
     if: ${{ github.repository_owner =3D=3D 'openvpn' || github.event_name =
=3D=3D 'workflow_dispatch' }}
     steps:
-      - uses: actions/checkout@...2926... # v5.0.0
+      - uses: actions/checkout@...2955... # v5.0.1
         with:
           path: openvpn


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1381?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd63130832e3bf20bf9816887e218ae73e2f5cd1
Gerrit-Change-Number: 1381
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--y/ynVfSP1og=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1381?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">GHA: Maintenance update November 2025<br><b=
r>Includes the following renovate changes:<br>- chore(deps): update depende=
ncy mbed-tls/mbedtls to v3.6.5<br>- chore(deps): update vcpkg digest to 3bb=
c280<br>- chore(deps): update dependency libressl/portable to v4.2.1<br>- c=
hore(deps): update github actions<br>- chore(deps): update dependency aws/a=
ws-lc to v1.64.0<br>- chore(deps): update github actions<br><br>Additionall=
y, drop macos-13 since the<br>worker is deprecated.<br><br>Change-Id: Ifd63=
130832e3bf20bf9816887e218ae73e2f5cd1<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>M .githu=
b/workflows/coverity-scan.yml<br>M .github/workflows/doxygen.yml<br>3 files=
 changed, 34 insertions(+), 34 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1381/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</s=
pan><br><span>index e068f58..96d2292 100644</span><br><span>--- a/.github/w=
orkflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</spa=
n><br><span>@@ -14,12 +14,12 @@</span><br><span>           sudo apt update =
&amp;&amp; sudo apt install -y python3-pip</span><br><span>           pip3 =
install pre-commit</span><br><span>       - name: Checkout OpenVPN</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout=
@...2926... # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        uses: actions/checkout@...2955... # v5.0.1</span><br><span>       =
- name: Run clang-format</span><br><span>         run: pre-commit run -a --=
show-diff-on-failure || true</span><br><span>       - name: Check for chang=
es</span><br><span>         run: git diff --output=3Dformat-changes.patch</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/u=
pload-artifact@...2868... # v4.6.2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      - uses: actions/upload-artifact@...2956... # v5.0.0</s=
pan><br><span>         with:</span><br><span>           name: format-change=
s.patch</span><br><span>           path: format-changes.patch</span><br><sp=
an>@@ -44,12 +44,12 @@</span><br><span>       VCPKG_INSTALLED_DIR: ${{ gith=
ub.workspace }}/vcpkg/installed</span><br><span>     steps:</span><br><span=
>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        uses: actions/checkout@...2926... # v5.0.0</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2924...=
27... # v4.1.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2957... # v4.1.2=
</span><br><span>       - name: Install vcpkg</span><br><span>         uses=
: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 9=
c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413=
bd6ad769d46d4</span><br><span>       - name: Install dependencies</span><br=
><span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><=
br><span>       - name: configure OpenVPN with cmake</span><br><span>@@ -77=
,13 +77,13 @@</span><br><span>       - name: Install dependencies</span><br=
><span>         run: sudo apt update &amp;&amp; sudo apt install -y mingw-w=
64 unzip build-essential wget python3-docutils man2html-base</span><br><spa=
n>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        uses: actions/checkout@...2926... # v5.0.0</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...220...=
..2955... # v5.0.1</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - uses: lukka/get-cmake@...2927... # v4.1.1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@=
...2957... # v4.1.2</span><br><span>       - name: Restore from cache and i=
nstall vcpkg</span><br><span>         uses: lukka/run-vcpkg@...2815... # v1=
1.5</span><br><span>         with:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f=
7ddeee</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcp=
kgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4</span><br><span>   =
        vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </spa=
n><br><span>       - name: Run CMake with vcpkg.json manifest</span><br><sp=
an>@@ -93,7 +93,7 @@</span><br><span>           buildPreset: mingw-${{ matr=
ix.arch }}</span><br><span>           buildPresetAdditionalArgs: &quot;[&#3=
9;--config Debug&#39;]&quot;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2868... #=
 v4.6.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses=
: actions/upload-artifact@...2956... # v5.0.0</span><br><span>         with=
:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }}</span><=
br><span>           path: |</span><br><span>@@ -101,7 +101,7 @@</span><br><=
span>             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }=
}/**/Debug/*.dll</span><br><span>             !${{ github.workspace }}/out/=
build/mingw/${{ matrix.arch }}/Debug/test_*.exe</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-ar=
tifact@...2868... # v4.6.2</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      - uses: actions/upload-artifact@...2956... # v5.0.0</span><br>=
<span>         with:</span><br><span>           name: openvpn-mingw-${{ mat=
rix.arch }}-tests</span><br><span>           path: |</span><br><span>@@ -12=
0,9 +120,9 @@</span><br><span>     name: &quot;mingw unittest ${{ matrix.te=
st }} - ${{ matrix.arch }} - OSSL&quot;</span><br><span>     steps:</span><=
br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        uses: actions/checkout@...2926... # v5.0.0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/che=
ckout@...2955... # v5.0.1</span><br><span>       - name: Retrieve mingw uni=
ttest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: ac=
tions/download-artifact@...2928... # v5.0.0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uses: actions/download-artifact@...2958... =
# v6.0.0</span><br><span>         with:</span><br><span>           name: op=
envpn-mingw-${{ matrix.arch }}-tests</span><br><span>           path: unitt=
ests</span><br><span>@@ -164,7 +164,7 @@</span><br><span>       - name: Ins=
tall dependencies</span><br><span>         run: sudo apt update &amp;&amp; =
sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl=
-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool =
automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>       - name: Che=
ckout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
uses: actions/checkout@...2926... # v5.0.0</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uses: actions/checkout@...2955... # v5.0.1</=
span><br><span>       - name: autoconf</span><br><span>         run: autore=
conf -fvi</span><br><span>       - name: configure</span><br><span>@@ -194,=
7 +194,7 @@</span><br><span>       - name: Install dependencies</span><br><=
span>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-d=
ev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev ma=
n2html clang libcmocka-dev python3-docutils libtool automake autoconf libmb=
edtls-dev</span><br><span>       - name: Checkout OpenVPN</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2960...=
.. # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
uses: actions/checkout@...2955... # v5.0.1</span><br><span>       - name: a=
utoconf</span><br><span>         run: autoreconf -fvi</span><br><span>     =
  - name: configure</span><br><span>@@ -212,7 +212,7 @@</span><br><span>   =
    matrix:</span><br><span>         ssllib: [openssl@...2560..., openssl@...220...=
..1554..., libressl]</span><br><span>         build: [normal, asan]</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        os: [macos-13, macos-=
14, macos-15]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  os: [macos-14, macos-15]</span><br><span>         include:</span><br><spa=
n>           - build: asan</span><br><span>             cflags: &quot;-fsan=
itize=3Daddress,undefined -fno-sanitize-recover=3Dall  -fno-optimize-siblin=
g-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&q=
uot;</span><br><span>@@ -234,7 +234,7 @@</span><br><span>       - name: Ins=
tall dependencies</span><br><span>         run: brew install ${{matrix.ssll=
ib}} lzo lz4 man2html cmocka libtool automake autoconf</span><br><span>    =
   - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uses: actions/checkout@...2926... # v5.0.0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2961...=
... # v5.0.1</span><br><span>       - name: Set environment</span><br><span=
>         run: |</span><br><span>           cat &gt;&gt;$GITHUB_ENV &lt;&lt=
;EOF;</span><br><span>@@ -266,8 +266,8 @@</span><br><span> </span><br><span=
>       runs-on: windows-2025</span><br><span>       steps:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@...2932...=
6... # v5.0.0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - =
uses: lukka/get-cmake@...2927... # v4.1.1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      - uses: actions/checkout@...2955... # v5.0.1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/ge=
t-cmake@...2957... # v4.1.2</span><br><span> </span><br><span>       - name=
: Install rst2html</span><br><span>         run: python -m pip install --up=
grade pip docutils</span><br><span>@@ -275,7 +275,7 @@</span><br><span>    =
   - name: Restore artifacts, or setup vcpkg (do not install any package)</=
span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br>=
<span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
         vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId:=
 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4</span><br><span>           vcpkgJ=
sonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </span><br><span>=
       - name: Run CMake with vcpkg.json manifest (NO TESTS)</span><br><spa=
n>@@ -294,7 +294,7 @@</span><br><span>           testPreset: win-${{ matrix=
.arch }}-release</span><br><span>           testPresetAdditionalArgs: &quot=
;[&#39;--output-on-failure&#39;]&quot;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...1186...=
.2868... # v4.6.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - uses: actions/upload-artifact@...2956... # v5.0.0</span><br><span>   =
      with:</span><br><span>           name: openvpn-msvc-${{ matrix.arch }=
}</span><br><span>           path: |</span><br><span>@@ -334,12 +334,12 @@<=
/span><br><span>       - name: Install dependencies</span><br><span>       =
  run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-=
dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils=
 libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span>=
<br><span>       - name: &quot;libressl: checkout&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2926...=
 # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@...2955... # v5.0.1</span><br><span>         with:</sp=
an><br><span>           path: libressl</span><br><span>           # version=
ing=3Dsemver-coerced</span><br><span>           repository: libressl/portab=
le</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v4.1=
.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: v4=
.2.1</span><br><span>       - name: &quot;libressl: autogen.sh&quot;</span>=
<br><span>         env:</span><br><span>           LIBRESSL_GIT_OPTIONS: &q=
uot;--no-single-branch&quot;</span><br><span>@@ -357,7 +357,7 @@</span><br>=
<span>       - name: &quot;ldconfig&quot;</span><br><span>         run: sud=
o ldconfig</span><br><span>       - name: Checkout OpenVPN</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2931...=
... # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/checkout@...2955... # v5.0.1</span><br><span>       - name: =
autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>    =
   - name: configure</span><br><span>@@ -398,13 +398,13 @@</span><br><span>=
       - name: Install dependencies</span><br><span>         run: sudo apt =
update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev l=
inux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 =
python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl=
-genl-3-dev</span><br><span>       - name: &quot;mbedtls: checkout&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/ch=
eckout@...2926... # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/checkout@...2955... # v5.0.1</span><br><span> =
        with:</span><br><span>           path: mbedtls</span><br><span>    =
       submodules: true</span><br><span>           # versioning=3Dsemver-co=
erced</span><br><span>           repository: Mbed-TLS/mbedtls</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          ref: v3.6.4</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          ref: v3.6.5</span><br><=
span>       - name: &quot;mbedtls: make no_test&quot;</span><br><span>     =
    run: make -j3 no_test SHARED=3D1</span><br><span>         working-direc=
tory: mbedtls</span><br><span>@@ -412,7 +412,7 @@</span><br><span>         =
run: sudo make install DESTDIR=3D/usr</span><br><span>         working-dire=
ctory: mbedtls</span><br><span>       - name: Checkout OpenVPN</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...493...=
2926... # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     uses: actions/checkout@...2955... # v5.0.1</span><br><span>       - na=
me: autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>=
       - name: configure</span><br><span>@@ -457,13 +457,13 @@</span><br><s=
pan>       - name: Install dependencies</span><br><span>         run: sudo =
apt update &amp;&amp; sudo apt install -y gcc golang make liblzo2-dev libpa=
m0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docu=
tils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config=
 libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;AWS-LC=
: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   uses: actions/checkout@...2926... # v5.0.0</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2955... # v5.0.=
1</span><br><span>         with:</span><br><span>           path: aws-lc</s=
pan><br><span>           # versioning=3Dsemver-coerced</span><br><span>    =
       repository: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-          ref: v1.61.3</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      - uses: lukka/get-cmake@...2927... # v4.1.1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+          ref: v1.64.0</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...493...=
2957... # v4.1.2</span><br><span>       - name: &quot;AWS-LC: build&quot;</=
span><br><span>         run: |</span><br><span>           mkdir build</span=
><br><span>@@ -472,7 +472,7 @@</span><br><span>           ninja install</sp=
an><br><span>         working-directory: aws-lc</span><br><span>       - na=
me: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       uses: actions/checkout@...2926... # v5.0.0</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2955... # v=
5.0.1</span><br><span>       - name: autoconf</span><br><span>         run:=
 autoreconf -fvi</span><br><span>       - name: configure with AWS-LC</span=
><br><span>diff --git a/.github/workflows/coverity-scan.yml b/.github/workf=
lows/coverity-scan.yml</span><br><span>index e90aa2e..fa18115 100644</span>=
<br><span>--- a/.github/workflows/coverity-scan.yml</span><br><span>+++ b/.=
github/workflows/coverity-scan.yml</span><br><span>@@ -13,7 +13,7 @@</span>=
<br><span>     steps:</span><br><span>       - name: Check submission cache=
</span><br><span>         id: check_submit</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: actions/cache/restore@...2929... # v4.2.=
4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: acti=
ons/cache/restore@...2959... # v4.3.0</span><br><span>         with:</span>=
<br><span>           path: |</span><br><span>             cov-int</span><br=
><span>@@ -25,7 +25,7 @@</span><br><span> </span><br><span>       - name: C=
heckout OpenVPN</span><br><span>         if: steps.check_submit.outputs.cac=
he-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uses: actions/checkout@...2926... # v5.0.0</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2962...=
.. # v5.0.1</span><br><span> </span><br><span>       - name: Download Cover=
ity Build Tool</span><br><span>         if: steps.check_submit.outputs.cach=
e-hit !=3D &#39;true&#39;</span><br><span>@@ -65,7 +65,7 @@</span><br><span=
> </span><br><span>       - name: Cache submission</span><br><span>        =
 if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/save@...1186...=
.2929... # v4.2.4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      uses: actions/cache/save@...2959... # v4.3.0</span><br><span>        =
 with:</span><br><span>           path: |</span><br><span>             cov-=
int</span><br><span>diff --git a/.github/workflows/doxygen.yml b/.github/wo=
rkflows/doxygen.yml</span><br><span>index eaa7e4c..0828dd0 100644</span><br=
><span>--- a/.github/workflows/doxygen.yml</span><br><span>+++ b/.github/wo=
rkflows/doxygen.yml</span><br><span>@@ -11,7 +11,7 @@</span><br><span>     =
runs-on: ubuntu-24.04</span><br><span>     if: ${{ github.repository_owner =
=3D=3D &#39;openvpn&#39; || github.event_name =3D=3D &#39;workflow_dispatch=
&#39; }}</span><br><span>     steps:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - uses: actions/checkout@...2926... # v5.0.0</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkou=
t@...2955... # v5.0.1</span><br><span>         with:</span><br><span>      =
     path: openvpn</span><br><span> </span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1381?usp=3Dem=
ail">change 1381</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1381?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd63130832e3bf20bf9816887e2=
18ae73e2f5cd1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1381 </div>
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

--y/ynVfSP1og=--

