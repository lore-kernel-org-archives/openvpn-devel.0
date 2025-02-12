From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 12 Feb 2025 13:54:36 +0000
References: <gerrit.1739368474000.I29b68675143988c3304395d9d5ec62289cf519a7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e14e8a8fd6f416c4d4bc33f63773d3023186ff6f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rlY/tTcbEjA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rlY/tTcbEjA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/893?usp=3Demail

to review the following change.


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
(cherry picked from commit c26b2e2c5581ad4e14b737df9178a03d6403a5f7)
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 45 insertions(+), 63 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/893/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--rlY/tTcbEjA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/893?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Drop Ubuntu 20.04 and other maintenance (2.6)<br><br>- D=
rop Ubuntu 20.04<br>  GHA runners will go away in April 2025<br>- Change ub=
untu-latest to ubuntu-24.04<br>  to make sure we are not surprised by<br>  =
future changes.<br>- Update vcpkg digest to latest 33e9c99<br>- Update gith=
ub actions to latest<br><br>Backport changes:<br>Sync 2.6 GHA with master G=
HA by<br>- pinning action references<br>- adding Ubuntu 24.04 builds<br>- u=
pdating libressl<br>- updating ASAN builds to include<br>  &quot;undefined&=
quot; checker<br><br>Change-Id: I29b68675143988c3304395d9d5ec62289cf519a7<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>(cherry pick=
ed from commit c26b2e2c5581ad4e14b737df9178a03d6403a5f7)<br>---<br>M .githu=
b/workflows/build.yaml<br>M .github/workflows/coverity-scan.yml<br>2 files =
changed, 45 insertions(+), 63 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/93/893/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.githu=
b/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index=
 d930197..5b1c797 100644</span><br><span>--- a/.github/workflows/build.yaml=
</span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -13,=
7 +13,7 @@</span><br><span>       - name: Install dependencies</span><br><s=
pan>         run: sudo apt update &amp;&amp; sudo apt install -y uncrustify=
</span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/chec=
kout@...2844... # v4.2.2</span><br><span>         with:</span><br><span>   =
        path: openvpn</span><br><span>       - name: Show uncrustify versio=
n</span><br><span>@@ -27,7 +27,7 @@</span><br><span>       - name: Show cha=
nges on standard output</span><br><span>         run: git diff</span><br><s=
pan>         working-directory: openvpn</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2691...</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload=
-artifact@...2860... # v4.6.0</span><br><span>         with:</span><br><spa=
n>           name: uncrustify-changes.patch</span><br><span>           path=
: &#39;openvpn/uncrustify-changes.patch&#39;</span><br><span>@@ -42,29 +42,=
29 @@</span><br><span>         arch: [x86, x64]</span><br><span> </span><br=
><span>     name: &quot;gcc-mingw - ${{ matrix.arch }} - OSSL&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-22.04</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.=
04</span><br><span>     env:</span><br><span>       VCPKG_ROOT: ${{ github.=
workspace }}/vcpkg</span><br><span>     steps:</span><br><span>       - nam=
e: Install dependencies</span><br><span>         run: sudo apt update &amp;=
&amp; sudo apt install -y mingw-w64 unzip cmake ninja-build build-essential=
 wget python3-docutils man2html-base</span><br><span>       - name: Checkou=
t OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses=
: actions/checkout@...2691...</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        uses: actions/checkout@...2844... # v4.2.2</span><br><spa=
n> </span><br><span>       - name: Restore from cache and install vcpkg</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-v=
cpkg@...2735...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCom=
mitId: 8d3649ba34aab36914ddd897958599aa0a91b08e</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 33e9c99208736b713ca=
be4490e15235f62f893d4</span><br><span>           vcpkgJsonGlob: &#39;**/min=
gw/vcpkg.json&#39;</span><br><span> </span><br><span>       - name: Run CMa=
ke with vcpkg.json manifest</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uses: lukka/run-cmake@...2637...</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@...2816... # v10.8=
</span><br><span>         with:</span><br><span>           configurePreset:=
 mingw-${{ matrix.arch }}</span><br><span>           buildPreset: mingw-${{=
 matrix.arch }}</span><br><span>           buildPresetAdditionalArgs: &quot=
;[&#39;--config Debug&#39;]&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2375...=
91...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: =
actions/upload-artifact@...2860... # v4.6.0</span><br><span>         with:<=
/span><br><span>           name: openvpn-mingw-${{ matrix.arch }}</span><br=
><span>           path: |</span><br><span>@@ -72,7 +72,7 @@</span><br><span=
>             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/*.dll</span><br><span>             !${{ github.workspace }}/out/build/m=
ingw/${{ matrix.arch }}/Debug/test_*.exe</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@=
...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - u=
ses: actions/upload-artifact@...2860... # v4.6.0</span><br><span>         w=
ith:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }}-test=
s</span><br><span>           path: |</span><br><span>@@ -91,7 +91,7 @@</spa=
n><br><span>     name: &quot;mingw unittest ${{ matrix.test }} - ${{ matrix=
.arch }} - OSSL&quot;</span><br><span>     steps:</span><br><span>       - =
name: Retrieve mingw unittest</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        uses: actions/download-artifact@...2691...</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/download-artif=
act@...2817... # v4.1.8</span><br><span>         with:</span><br><span>    =
       name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>       =
    path: unittests</span><br><span>@@ -102,56 +102,35 @@</span><br><span> =
    strategy:</span><br><span>       fail-fast: false</span><br><span>     =
  matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: =
[ubuntu-20.04, ubuntu-22.04]</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        sslpkg: [libmbedtls-dev]</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ssllib: [mbedtls]</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        libname: [mbed TLS]</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span>         include:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-          - os: ubuntu-20.04</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            sslpkg: &quot;l=
ibssl-dev&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      libname: OpenSSL 1.1.1</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            ssllib: openssl</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+          - os: ubuntu-22.04</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            sslpkg: libmbedtls-dev</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            ssllib: mbedtls</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            libname: mbed TL=
S 2.28.0</span><br><span>           - os: ubuntu-22.04</span><br><span>    =
         sslpkg: &quot;libssl-dev&quot;</span><br><span>             libnam=
e: OpenSSL 3.0.2</span><br><span>             ssllib: openssl</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          - os: ubuntu-20.04</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            pkcs11pkg: &qu=
ot;libpkcs11-helper1-dev softhsm2 gnutls-bin&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            extraconf: --enable-pkcs11</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          - os: ubuntu-24=
.04</span><br><span>             sslpkg: &quot;libssl-dev&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.=
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            libnam=
e: OpenSSL 3.0.13</span><br><span>             ssllib: openssl</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            extraconf: &quot;--ena=
ble-iproute2&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
       - os: ubuntu-20.04</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            sslpkg: &quot;libssl-dev&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            ssllib: openssl</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            extraconf: &quot;--=
enable-async-push&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-          - os: ubuntu-20.04</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib: openssl</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            extraconf: &=
quot;--disable-management&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-          - os: ubuntu-20.04</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib: open=
ssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            extrac=
onf: &quot;--enable-small&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-          - os: ubuntu-20.04</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib: open=
ssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            extrac=
onf: &quot;--disable-lzo --disable-lz4&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            pkcs11pkg: &quot;libpkcs11-helper1-dev=
 softhsm2 gnutls-bin&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            extraconf: --enable-pkcs11</span><br><span> </span><br><=
span>     name: &quot;gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.=
extraconf}}&quot;</span><br><span>     env:</span><br><span>       SSLPKG: =
&quot;${{matrix.sslpkg}}&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      PKCS11PKG: &quot;${{matrix.pkcs11pkg}}&quot;</span><br><sp=
an> </span><br><span>     runs-on: ${{matrix.os}}</span><br><span>     step=
s:</span><br><span>       - name: Install dependencies</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        run: sudo apt update &amp;&amp; su=
do apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-g=
enl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool au=
tomake autoconf ${SSLPKG}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-d=
ev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev ma=
n2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} $=
{PKCS11PKG}</span><br><span>       - name: Checkout OpenVPN</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2798...=
1...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: a=
ctions/checkout@...2844... # v4.2.2</span><br><span>       - name: autoconf=
</span><br><span>         run: autoreconf -fvi</span><br><span>       - nam=
e: configure</span><br><span>@@ -165,7 +144,7 @@</span><br><span>     strat=
egy:</span><br><span>       fail-fast: false</span><br><span>       matrix:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: [ubuntu-2=
0.04]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        os: [u=
buntu-22.04, ubuntu-24.04]</span><br><span>         ssllib: [mbedtls, opens=
sl]</span><br><span> </span><br><span>     name: &quot;clang-asan - ${{matr=
ix.os}} - ${{matrix.ssllib}}&quot;</span><br><span>@@ -178,11 +157,11 @@</s=
pan><br><span>       - name: Install dependencies</span><br><span>         =
run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-de=
v liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang l=
ibcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev</spa=
n><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@=
...2844... # v4.2.2</span><br><span>       - name: autoconf</span><br><span=
>         run: autoreconf -fvi</span><br><span>       - name: configure</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: CFLAGS=3D&qu=
ot;-fsanitize=3Daddress -fno-omit-frame-pointer -O2&quot; CC=3Dclang ./conf=
igure --with-crypto-library=3D${{matrix.ssllib}}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        run: CFLAGS=3D&quot;-fsanitize=3Daddre=
ss,undefined -fno-sanitize-recover=3Dall -fno-omit-frame-pointer -O2&quot; =
CC=3Dclang ./configure --with-crypto-library=3D${{matrix.ssllib}}</span><br=
><span>       - name: make all</span><br><span>         run: make -j3</span=
><br><span>       - name: make check</span><br><span>@@ -197,8 +176,8 @@</s=
pan><br><span>         os: [macos-13, macos-14, macos-15]</span><br><span> =
        include:</span><br><span>           - build: asan</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            cflags: &quot;-fsanitize=3D=
address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            ldflags: -fsanitize=3Daddress</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            cflags: &quot;-fsanitize=3Dad=
dress,undefined -fno-sanitize-recover=3Dall -fno-optimize-sibling-calls -fs=
anitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            ldflags: -fsan=
itize=3Daddress,undefined -fno-sanitize-recover=3Dall</span><br><span>     =
        # Our build system ignores LDFLAGS for plugins</span><br><span>    =
         configureflags: --disable-plugin-auth-pam  --disable-plugin-down-r=
oot</span><br><span>           - build: normal</span><br><span>@@ -216,7 +1=
95,7 @@</span><br><span>       - name: Install dependencies</span><br><span=
>         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libt=
ool automake autoconf</span><br><span>       - name: Checkout OpenVPN</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/check=
out@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uses: actions/checkout@...2844... # v4.2.2</span><br><span>       - name=
: Set environment</span><br><span>         run: |</span><br><span>         =
  cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -246,34 +225,35 @=
@</span><br><span> </span><br><span>       runs-on: windows-latest</span><b=
r><span>       steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
      - uses: actions/checkout@...2691...</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2729...</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@...493...=
2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   - uses: lukka/get-cmake@...2861... # v3.31.5</span><br><span> </span><br=
><span>       - name: Install rst2html</span><br><span>         run: python=
 -m pip install --upgrade pip docutils</span><br><span> </span><br><span>  =
     - name: Restore artifacts, or setup vcpkg (do not install any package)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/r=
un-vcpkg@...2735...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         w=
ith:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGi=
tCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 33e9c99208736=
b713cabe4490e15235f62f893d4</span><br><span>           vcpkgJsonGlob: &#39;=
**/windows/vcpkg.json&#39;</span><br><span> </span><br><span>       - name:=
 Run CMake with vcpkg.json manifest (NO TESTS)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@...2637...</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake=
@...2816... # v10.8</span><br><span>         if: ${{ matrix.arch =3D=3D &#3=
9;arm64&#39; }}</span><br><span>         with:</span><br><span>           c=
onfigurePreset: win-${{ matrix.arch }}-release</span><br><span>           b=
uildPreset: win-${{ matrix.arch }}-release</span><br><span> </span><br><spa=
n>       - name: Run CMake with vcpkg.json manifest</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@...2637...</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/ru=
n-cmake@...2816... # v10.8</span><br><span>         if: ${{ matrix.arch !=
=3D &#39;arm64&#39; }}</span><br><span>         with:</span><br><span>     =
      configurePreset: win-${{ matrix.arch }}-release</span><br><span>     =
      buildPreset: win-${{ matrix.arch }}-release</span><br><span>         =
  testPreset: win-${{ matrix.arch }}-release</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+          testPresetAdditionalArgs: &quot;[&#39;--=
output-on-failure&#39;]&quot;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2691...<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: action=
s/upload-artifact@...2860... # v4.6.0</span><br><span>         with:</span>=
<br><span>           name: openvpn-msvc-${{ matrix.arch }}</span><br><span>=
           path: |</span><br><span>@@ -293,8 +273,8 @@</span><br><span>    =
     configureflags: [&quot;--with-openssl-engine=3Dno&quot;]</span><br><sp=
an>         include:</span><br><span>           - build: asan</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            cflags: &quot;-fsanitiz=
e=3Daddress -fno-optimize-sibling-calls -fsanitize-address-use-after-scope =
-fno-omit-frame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            ldflags: -fsanitize=3Daddress</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            cflags: &quot;-fsanitize=
=3Daddress -fno-sanitize-recover=3Dall -fno-optimize-sibling-calls -fsaniti=
ze-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            ldflags: -fsanitize=
=3Daddress -fno-sanitize-recover=3Dall</span><br><span>             cc: cla=
ng</span><br><span>           - build: normal</span><br><span>             =
cflags: &quot;-O2 -g&quot;</span><br><span>@@ -313,12 +293,14 @@</span><br>=
<span>       - name: Install dependencies</span><br><span>         run: sud=
o apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4=
-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool a=
utomake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span>=
       - name: &quot;libressl: checkout&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkou=
t@...2844... # v4.2.2</span><br><span>         with:</span><br><span>      =
     path: libressl</span><br><span>           repository: libressl/portabl=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v3.8.=
3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: v4.=
0.0</span><br><span>       - name: &quot;libressl: autogen.sh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        env:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+          LIBRESSL_GIT_OPTIONS: &q=
uot;--no-single-branch&quot;</span><br><span>         run: ./autogen.sh</sp=
an><br><span>         working-directory: libressl</span><br><span>       - =
name: &quot;libressl: configure&quot;</span><br><span>@@ -333,7 +315,7 @@</=
span><br><span>       - name: &quot;ldconfig&quot;</span><br><span>        =
 run: sudo ldconfig</span><br><span>       - name: Checkout OpenVPN</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkou=
t@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/checkout@...2844... # v4.2.2</span><br><span>       - name: =
autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>    =
   - name: configure</span><br><span>diff --git a/.github/workflows/coverit=
y-scan.yml b/.github/workflows/coverity-scan.yml</span><br><span>index 37b8=
102..b5e1920 100644</span><br><span>--- a/.github/workflows/coverity-scan.y=
ml</span><br><span>+++ b/.github/workflows/coverity-scan.yml</span><br><spa=
n>@@ -9,7 +9,7 @@</span><br><span>     # Running coverity requires the secr=
ets.COVERITY_SCAN_TOKEN token</span><br><span>     # which is only availabl=
e on the main repository</span><br><span>     if: github.repository_owner =
=3D=3D &#39;OpenVPN&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    runs-on: ubuntu-latest</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    runs-on: ubuntu-24.04</span><br><span>     steps:</span><br><=
span>       - name: Check submission cache</span><br><span>         id: che=
ck_submit</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/893?usp=3Demail">change 893</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/893?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I29b68675143988c3304395d9d5e=
c62289cf519a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 893 </div>
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


--rlY/tTcbEjA=--

