From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 13 Feb 2025 21:50:07 +0000
In-Reply-To: <gerrit.1739368474000.I29b68675143988c3304395d9d5ec62289cf519a7@...2715...>
References: <gerrit.1739368474000.I29b68675143988c3304395d9d5ec62289cf519a7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <bd8208c4a22a3ae309b43a37bc0d3ef17deb30cf-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pU9ls1wtBJM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: GHA: Drop
 Ubuntu 20.04 and other maintenance (2.6)
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

--pU9ls1wtBJM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/893?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


Change subject: GHA: Drop Ubuntu 20.04 and other maintenance (2.6)
......................................................................

GHA: Drop Ubuntu 20.04 and other maintenance (2.6)

- Drop Ubuntu 20.04
  GHA runners will go away in April 2025
- Change ubuntu-latest to ubuntu-24.04
  to make sure we are not surprised by
  future changes.
- Update vcpkg digest to latest 33e9c99
- Update github actions to latest

Backport changes:
Sync 2.6 GHA with master GHA by
- pinning action references
- adding Ubuntu 24.04 builds
- updating libressl
- updating ASAN builds to include
  "undefined" checker

Change-Id: I29b68675143988c3304395d9d5ec62289cf519a7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
(cherry picked from commit c26b2e2c5581ad4e14b737df9178a03d6403a5f7)
Message-Id: <20250212215232.998-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
851.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 45 insertions(+), 63 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/893/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d930197..5b1c797 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -13,7 +13,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2844... # v4.2.2
         with:
           path: openvpn
       - name: Show uncrustify version
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2691...
+      - uses: actions/upload-artifact@...2860... # v4.6.0
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -42,29 +42,29 @@
         arch: [x86, x64]

     name: "gcc-mingw - ${{ matrix.arch }} - OSSL"
-    runs-on: ubuntu-22.04
+    runs-on: ubuntu-24.04
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake =
ninja-build build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2844... # v4.2.2

       - name: Restore from cache and install vcpkg
-        uses: lukka/run-vcpkg@...2735...
+        uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
+          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2637...
+        uses: lukka/run-cmake@...2816... # v10.8
         with:
           configurePreset: mingw-${{ matrix.arch }}
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2691...
+      - uses: actions/upload-artifact@...2860... # v4.6.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -72,7 +72,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2691...
+      - uses: actions/upload-artifact@...2860... # v4.6.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -91,7 +91,7 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2691...
+        uses: actions/download-artifact@...2817... # v4.1.8
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -102,56 +102,35 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-20.04, ubuntu-22.04]
-        sslpkg: [libmbedtls-dev]
-        ssllib: [mbedtls]
-        libname: [mbed TLS]
-
         include:
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
+          - os: ubuntu-22.04
+            sslpkg: libmbedtls-dev
+            ssllib: mbedtls
+            libname: mbed TLS 2.28.0
           - os: ubuntu-22.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 3.0.2
             ssllib: openssl
-          - os: ubuntu-20.04
+            pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
+            extraconf: --enable-pkcs11
+          - os: ubuntu-24.04
             sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
+            libname: OpenSSL 3.0.13
             ssllib: openssl
-            extraconf: "--enable-iproute2"
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--enable-async-push"
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--disable-management"
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--enable-small"
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--disable-lzo --disable-lz4"
+            pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
+            extraconf: --enable-pkcs11

     name: "gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.extraconf}=
}"
     env:
       SSLPKG: "${{matrix.sslpkg}}"
+      PKCS11PKG: "${{matrix.pkcs11pkg}}"

     runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG}
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -165,7 +144,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-20.04]
+        os: [ubuntu-22.04, ubuntu-24.04]
         ssllib: [mbedtls, openssl]

     name: "clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}"
@@ -178,11 +157,11 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang =
libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: CFLAGS=3D"-fsanitize=3Daddress -fno-omit-frame-pointer -O2" C=
C=3Dclang ./configure --with-crypto-library=3D${{matrix.ssllib}}
+        run: CFLAGS=3D"-fsanitize=3Daddress,undefined -fno-sanitize-recove=
r=3Dall -fno-omit-frame-pointer -O2" CC=3Dclang ./configure --with-crypto-l=
ibrary=3D${{matrix.ssllib}}
       - name: make all
         run: make -j3
       - name: make check
@@ -197,8 +176,8 @@
         os: [macos-13, macos-14, macos-15]
         include:
           - build: asan
-            cflags: "-fsanitize=3Daddress -fno-optimize-sibling-calls -fsa=
nitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=3Daddress
+            cflags: "-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-=
omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall
             # Our build system ignores LDFLAGS for plugins
             configureflags: --disable-plugin-auth-pam  --disable-plugin-do=
wn-root
           - build: normal
@@ -216,7 +195,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libto=
ol automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2844... # v4.2.2
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -246,34 +225,35 @@

       runs-on: windows-latest
       steps:
-      - uses: actions/checkout@...2691...
-      - uses: lukka/get-cmake@...2729...
+      - uses: actions/checkout@...2844... # v4.2.2
+      - uses: lukka/get-cmake@...2861... # v3.31.5

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils

       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
-        uses: lukka/run-vcpkg@...2735...
+        uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
+          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
-        uses: lukka/run-cmake@...2637...
+        uses: lukka/run-cmake@...2816... # v10.8
         if: ${{ matrix.arch =3D=3D 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release

       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2637...
+        uses: lukka/run-cmake@...2816... # v10.8
         if: ${{ matrix.arch !=3D 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release
           testPreset: win-${{ matrix.arch }}-release
+          testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2691...
+      - uses: actions/upload-artifact@...2860... # v4.6.0
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -293,8 +273,8 @@
         configureflags: ["--with-openssl-engine=3Dno"]
         include:
           - build: asan
-            cflags: "-fsanitize=3Daddress -fno-optimize-sibling-calls -fsa=
nitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=3Daddress
+            cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall -fno=
-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-=
pointer -g -O1"
+            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall
             cc: clang
           - build: normal
             cflags: "-O2 -g"
@@ -313,12 +293,14 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2844... # v4.2.2
         with:
           path: libressl
           repository: libressl/portable
-          ref: v3.8.3
+          ref: v4.0.0
       - name: "libressl: autogen.sh"
+        env:
+          LIBRESSL_GIT_OPTIONS: "--no-single-branch"
         run: ./autogen.sh
         working-directory: libressl
       - name: "libressl: configure"
@@ -333,7 +315,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index 37b8102..b5e1920 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -9,7 +9,7 @@
     # Running coverity requires the secrets.COVERITY_SCAN_TOKEN token
     # which is only available on the main repository
     if: github.repository_owner =3D=3D 'OpenVPN'
-    runs-on: ubuntu-latest
+    runs-on: ubuntu-24.04
     steps:
       - name: Check submission cache
         id: check_submit

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/893?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I29b68675143988c3304395d9d5ec62289cf519a7
Gerrit-Change-Number: 893
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--pU9ls1wtBJM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/893?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by uddr</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">GHA: Drop Ubuntu 20.04 and other maintenance (2.6)<br=
><br>- Drop Ubuntu 20.04<br>  GHA runners will go away in April 2025<br>- C=
hange ubuntu-latest to ubuntu-24.04<br>  to make sure we are not surprised =
by<br>  future changes.<br>- Update vcpkg digest to latest 33e9c99<br>- Upd=
ate github actions to latest<br><br>Backport changes:<br>Sync 2.6 GHA with =
master GHA by<br>- pinning action references<br>- adding Ubuntu 24.04 build=
s<br>- updating libressl<br>- updating ASAN builds to include<br>  &quot;un=
defined&quot; checker<br><br>Change-Id: I29b68675143988c3304395d9d5ec62289c=
f519a7<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acke=
d-by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>(cherry picked from com=
mit c26b2e2c5581ad4e14b737df9178a03d6403a5f7)<br>Message-Id: &lt;2025021221=
5232.998-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg30851.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>M .githu=
b/workflows/coverity-scan.yml<br>2 files changed, 45 insertions(+), 63 dele=
tions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/93/893/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/w=
orkflows/build.yaml</span><br><span>index d930197..5b1c797 100644</span><br=
><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/wor=
kflows/build.yaml</span><br><span>@@ -13,7 +13,7 @@</span><br><span>       =
- name: Install dependencies</span><br><span>         run: sudo apt update =
&amp;&amp; sudo apt install -y uncrustify</span><br><span>       - name: Ch=
eckout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 uses: actions/checkout@...2691...</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uses: actions/checkout@...2844... # v4.2.2</span><br=
><span>         with:</span><br><span>           path: openvpn</span><br><s=
pan>       - name: Show uncrustify version</span><br><span>@@ -27,7 +27,7 @=
@</span><br><span>       - name: Show changes on standard output</span><br>=
<span>         run: git diff</span><br><span>         working-directory: op=
envpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: ac=
tions/upload-artifact@...2691...</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      - uses: actions/upload-artifact@...2860... # v4.6.0</spa=
n><br><span>         with:</span><br><span>           name: uncrustify-chan=
ges.patch</span><br><span>           path: &#39;openvpn/uncrustify-changes.=
patch&#39;</span><br><span>@@ -42,29 +42,29 @@</span><br><span>         arc=
h: [x86, x64]</span><br><span> </span><br><span>     name: &quot;gcc-mingw =
- ${{ matrix.arch }} - OSSL&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    runs-on: ubuntu-22.04</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><span>     env:</span=
><br><span>       VCPKG_ROOT: ${{ github.workspace }}/vcpkg</span><br><span=
>     steps:</span><br><span>       - name: Install dependencies</span><br>=
<span>         run: sudo apt update &amp;&amp; sudo apt install -y mingw-w6=
4 unzip cmake ninja-build build-essential wget python3-docutils man2html-ba=
se</span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/ch=
eckout@...2844... # v4.2.2</span><br><span> </span><br><span>       - name:=
 Restore from cache and install vcpkg</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: lukka/run-vcpkg@...2735...</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2822...=
.. # v11.5</span><br><span>         with:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958=
599aa0a91b08e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
    vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br><s=
pan>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span=
> </span><br><span>       - name: Run CMake with vcpkg.json manifest</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-cmak=
e@...2637...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: lukka/run-cmake@...2816... # v10.8</span><br><span>         with:</s=
pan><br><span>           configurePreset: mingw-${{ matrix.arch }}</span><b=
r><span>           buildPreset: mingw-${{ matrix.arch }}</span><br><span>  =
         buildPresetAdditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  - uses: actions/upload-artifact@...2691...</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2860... #=
 v4.6.0</span><br><span>         with:</span><br><span>           name: ope=
nvpn-mingw-${{ matrix.arch }}</span><br><span>           path: |</span><br>=
<span>@@ -72,7 +72,7 @@</span><br><span>             ${{ github.workspace }=
}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br><span>          =
   !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*=
.exe</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      - uses: actions/upload-artifact@...2691...</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2862...=
... # v4.6.0</span><br><span>         with:</span><br><span>           name=
: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>           path: |=
</span><br><span>@@ -91,7 +91,7 @@</span><br><span>     name: &quot;mingw u=
nittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</span><br><spa=
n>     steps:</span><br><span>       - name: Retrieve mingw unittest</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/downlo=
ad-artifact@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        uses: actions/download-artifact@...2817... # v4.1.8</span><br><s=
pan>         with:</span><br><span>           name: openvpn-mingw-${{ matri=
x.arch }}-tests</span><br><span>           path: unittests</span><br><span>=
@@ -102,56 +102,35 @@</span><br><span>     strategy:</span><br><span>      =
 fail-fast: false</span><br><span>       matrix:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        os: [ubuntu-20.04, ubuntu-22.04]</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        sslpkg: [libmbedtls-d=
ev]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssllib: [m=
bedtls]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        libnam=
e: [mbed TLS]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>         include:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-          - os: ubuntu-20.04</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib: openssl</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+          - os: ubunt=
u-22.04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
sslpkg: libmbedtls-dev</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            ssllib: mbedtls</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            libname: mbed TLS 2.28.0</span><br><span>           =
- os: ubuntu-22.04</span><br><span>             sslpkg: &quot;libssl-dev&qu=
ot;</span><br><span>             libname: OpenSSL 3.0.2</span><br><span>   =
          ssllib: openssl</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-          - os: ubuntu-20.04</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            pkcs11pkg: &quot;libpkcs11-helper1-dev softhsm2 gn=
utls-bin&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       extraconf: --enable-pkcs11</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+          - os: ubuntu-24.04</span><br><span>             ssl=
pkg: &quot;libssl-dev&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            libname: OpenSSL 1.1.1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            libname: OpenSSL 3.0.13</span><br><span>  =
           ssllib: openssl</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            extraconf: &quot;--enable-iproute2&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-          - os: ubuntu-20.04</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            sslpkg: &quot;libssl=
-dev&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 libname: OpenSSL 1.1.1</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            ssllib: openssl</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            extraconf: &quot;--enable-async-push&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-          - os: ubuntu-20.04</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            sslpkg: &quot;l=
ibssl-dev&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      libname: OpenSSL 1.1.1</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            ssllib: openssl</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            extraconf: &quot;--disable-management&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-          - os: ubuntu-20.04=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sslpkg: &=
quot;libssl-dev&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            libname: OpenSSL 1.1.1</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            ssllib: openssl</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            extraconf: &quot;--enable-small&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-          - os: ubuntu-20.04=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sslpkg: &=
quot;libssl-dev&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            libname: OpenSSL 1.1.1</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            ssllib: openssl</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            extraconf: &quot;--disable-lzo --disable-lz4=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            p=
kcs11pkg: &quot;libpkcs11-helper1-dev softhsm2 gnutls-bin&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            extraconf: --enable=
-pkcs11</span><br><span> </span><br><span>     name: &quot;gcc - ${{matrix.=
os}} - ${{matrix.libname}} ${{matrix.extraconf}}&quot;</span><br><span>    =
 env:</span><br><span>       SSLPKG: &quot;${{matrix.sslpkg}}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      PKCS11PKG: &quot;${{m=
atrix.pkcs11pkg}}&quot;</span><br><span> </span><br><span>     runs-on: ${{=
matrix.os}}</span><br><span>     steps:</span><br><span>       - name: Inst=
all dependencies</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g=
-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libc=
mocka-dev python3-docutils libtool automake autoconf ${SSLPKG}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        run: sudo apt update &am=
p;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-d=
ev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils =
libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>       - n=
ame: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@...2691...</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        uses: actions/checkout@...2844... # v4.2.2</s=
pan><br><span>       - name: autoconf</span><br><span>         run: autorec=
onf -fvi</span><br><span>       - name: configure</span><br><span>@@ -165,7=
 +144,7 @@</span><br><span>     strategy:</span><br><span>       fail-fast:=
 false</span><br><span>       matrix:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        os: [ubuntu-20.04]</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        os: [ubuntu-22.04, ubuntu-24.04]</span><br><=
span>         ssllib: [mbedtls, openssl]</span><br><span> </span><br><span>=
     name: &quot;clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}&quot;</sp=
an><br><span>@@ -178,11 +157,11 @@</span><br><span>       - name: Install d=
ependencies</span><br><span>         run: sudo apt update &amp;&amp; sudo a=
pt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-=
3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool =
automake autoconf libmbedtls-dev</span><br><span>       - name: Checkout Op=
enVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: ac=
tions/checkout@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uses: actions/checkout@...2844... # v4.2.2</span><br><span>  =
     - name: autoconf</span><br><span>         run: autoreconf -fvi</span><=
br><span>       - name: configure</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        run: CFLAGS=3D&quot;-fsanitize=3Daddress -fno-omit-fram=
e-pointer -O2&quot; CC=3Dclang ./configure --with-crypto-library=3D${{matri=
x.ssllib}}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
un: CFLAGS=3D&quot;-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Da=
ll -fno-omit-frame-pointer -O2&quot; CC=3Dclang ./configure --with-crypto-l=
ibrary=3D${{matrix.ssllib}}</span><br><span>       - name: make all</span><=
br><span>         run: make -j3</span><br><span>       - name: make check</=
span><br><span>@@ -197,8 +176,8 @@</span><br><span>         os: [macos-13, =
macos-14, macos-15]</span><br><span>         include:</span><br><span>     =
      - build: asan</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          cflags: &quot;-fsanitize=3Daddress -fno-optimize-sibling-calls -f=
sanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            ldflags: -fsani=
tize=3Daddress</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       cflags: &quot;-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-=
omit-frame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            ldflags: -fsanitize=3Daddress,undefined -fno-saniti=
ze-recover=3Dall</span><br><span>             # Our build system ignores LD=
FLAGS for plugins</span><br><span>             configureflags: --disable-pl=
ugin-auth-pam  --disable-plugin-down-root</span><br><span>           - buil=
d: normal</span><br><span>@@ -216,7 +195,7 @@</span><br><span>       - name=
: Install dependencies</span><br><span>         run: brew install ${{matrix=
.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf</span><br><span=
>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        uses: actions/checkout@...2691...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2844...=
 # v4.2.2</span><br><span>       - name: Set environment</span><br><span>  =
       run: |</span><br><span>           cat &gt;&gt;$GITHUB_ENV &lt;&lt;EO=
F;</span><br><span>@@ -246,34 +225,35 @@</span><br><span> </span><br><span>=
       runs-on: windows-latest</span><br><span>       steps:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@...2375...=
91...</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lu=
kka/get-cmake@...2729...</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      - uses: actions/checkout@...2844... # v4.2.2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2863...=
. # v3.31.5</span><br><span> </span><br><span>       - name: Install rst2ht=
ml</span><br><span>         run: python -m pip install --upgrade pip docuti=
ls</span><br><span> </span><br><span>       - name: Restore artifacts, or s=
etup vcpkg (do not install any package)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        uses: lukka/run-vcpkg@...2735...</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2829...=
5... # v11.5</span><br><span>         with:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 8d3649ba34aab36914ddd8979=
58599aa0a91b08e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br>=
<span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><=
span> </span><br><span>       - name: Run CMake with vcpkg.json manifest (N=
O TESTS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses:=
 lukka/run-cmake@...2637...</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: lukka/run-cmake@...2816... # v10.8</span><br><span>  =
       if: ${{ matrix.arch =3D=3D &#39;arm64&#39; }}</span><br><span>      =
   with:</span><br><span>           configurePreset: win-${{ matrix.arch }}=
-release</span><br><span>           buildPreset: win-${{ matrix.arch }}-rel=
ease</span><br><span> </span><br><span>       - name: Run CMake with vcpkg.=
json manifest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
uses: lukka/run-cmake@...2637...</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uses: lukka/run-cmake@...2816... # v10.8</span><br><sp=
an>         if: ${{ matrix.arch !=3D &#39;arm64&#39; }}</span><br><span>   =
      with:</span><br><span>           configurePreset: win-${{ matrix.arch=
 }}-release</span><br><span>           buildPreset: win-${{ matrix.arch }}-=
release</span><br><span>           testPreset: win-${{ matrix.arch }}-relea=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          testPre=
setAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: ac=
tions/upload-artifact@...2691...</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      - uses: actions/upload-artifact@...2860... # v4.6.0</spa=
n><br><span>         with:</span><br><span>           name: openvpn-msvc-${=
{ matrix.arch }}</span><br><span>           path: |</span><br><span>@@ -293=
,8 +273,8 @@</span><br><span>         configureflags: [&quot;--with-openssl=
-engine=3Dno&quot;]</span><br><span>         include:</span><br><span>     =
      - build: asan</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          cflags: &quot;-fsanitize=3Daddress -fno-optimize-sibling-calls -f=
sanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            ldflags: -fsani=
tize=3Daddress</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       cflags: &quot;-fsanitize=3Daddress -fno-sanitize-recover=3Dall -fno-=
optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-p=
ointer -g -O1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall</span=
><br><span>             cc: clang</span><br><span>           - build: norma=
l</span><br><span>             cflags: &quot;-O2 -g&quot;</span><br><span>@=
@ -313,12 +293,14 @@</span><br><span>       - name: Install dependencies</s=
pan><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y =
liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka=
-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev li=
bnl-genl-3-dev</span><br><span>       - name: &quot;libressl: checkout&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/checkout@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uses: actions/checkout@...2844... # v4.2.2</span><br><span>      =
   with:</span><br><span>           path: libressl</span><br><span>        =
   repository: libressl/portable</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-          ref: v3.8.3</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+          ref: v4.0.0</span><br><span>       - name: &quot;lib=
ressl: autogen.sh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        env:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
       LIBRESSL_GIT_OPTIONS: &quot;--no-single-branch&quot;</span><br><span=
>         run: ./autogen.sh</span><br><span>         working-directory: lib=
ressl</span><br><span>       - name: &quot;libressl: configure&quot;</span>=
<br><span>@@ -333,7 +315,7 @@</span><br><span>       - name: &quot;ldconfig=
&quot;</span><br><span>         run: sudo ldconfig</span><br><span>       -=
 name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        uses: actions/checkout@...2691...</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uses: actions/checkout@...2844... # v4.2.2<=
/span><br><span>       - name: autoconf</span><br><span>         run: autor=
econf -fvi</span><br><span>       - name: configure</span><br><span>diff --=
git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan=
.yml</span><br><span>index 37b8102..b5e1920 100644</span><br><span>--- a/.g=
ithub/workflows/coverity-scan.yml</span><br><span>+++ b/.github/workflows/c=
overity-scan.yml</span><br><span>@@ -9,7 +9,7 @@</span><br><span>     # Run=
ning coverity requires the secrets.COVERITY_SCAN_TOKEN token</span><br><spa=
n>     # which is only available on the main repository</span><br><span>   =
  if: github.repository_owner =3D=3D &#39;OpenVPN&#39;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-latest</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br=
><span>     steps:</span><br><span>       - name: Check submission cache</s=
pan><br><span>         id: check_submit</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/893?usp=3D=
email">change 893</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/893?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I29b68675143988c3304395d9d5e=
c62289cf519a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 893 </div>
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


--pU9ls1wtBJM=--

