From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 31 Oct 2024 13:29:16 +0000
References: <gerrit.1730381354000.I91f68317450c3c0d69be2c489276739211ccb422@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ec2545cdfde5117c3999fb61347de511e9f95133-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wLniMmoMbFo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: General update
 November 2024
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

--wLniMmoMbFo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/789?usp=3Demail

to review the following change.


Change subject: GHA: General update November 2024
......................................................................

GHA: General update November 2024

Contains the following renovate updates:

- Update dependency libressl/portable to v4
- Update dependency Mbed-TLS/mbedtls to v3.6.2
- Update mingw ubuntu runner to v24
  - Do NOT update the uncrustify runner since newer uncrustify
    is not usable with the current config
- Update vcpkg digest to b505fa7

Additionally change the action reference pinning
to consistently refer to the tags instead of the branches.

Change-Id: I91f68317450c3c0d69be2c489276739211ccb422
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 24 insertions(+), 24 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/789/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 3958ef0..bb13ab3 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -13,7 +13,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7
         with:
           path: openvpn
       - name: Show uncrustify version
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2814... # v4.4.0
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -42,19 +42,19 @@
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
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7

       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
+          vcpkgGitCommitId: b505fa789fd96eb5496a2e42c651c169e8460d27
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -64,7 +64,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2814... # v4.4.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -72,7 +72,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2814... # v4.4.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -91,9 +91,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2817... # v4
+        uses: actions/download-artifact@...2817... # v4.1.8
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -165,7 +165,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -195,7 +195,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang =
libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -235,7 +235,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libto=
ol automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -267,7 +267,7 @@

       runs-on: windows-latest
       steps:
-      - uses: actions/checkout@...2813... # v4
+      - uses: actions/checkout@...2813... # v4.1.7
       - uses: lukka/get-cmake@...2818... # v3.30.3

       - name: Install rst2html
@@ -276,7 +276,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
+          vcpkgGitCommitId: b505fa789fd96eb5496a2e42c651c169e8460d27
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -295,7 +295,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2814... # v4.4.0
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -335,12 +335,12 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7
         with:
           path: libressl
           # versioning=3Dsemver-coerced
           repository: libressl/portable
-          ref: v3.8.3
+          ref: v4.0.0
       - name: "libressl: autogen.sh"
         run: ./autogen.sh
         working-directory: libressl
@@ -356,7 +356,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -397,13 +397,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7
         with:
           path: mbedtls
           submodules: true
           # versioning=3Dsemver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.1
+          ref: v3.6.2
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=3D1
         working-directory: mbedtls
@@ -411,7 +411,7 @@
         run: sudo make install DESTDIR=3D/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index 16c979d..999fd29 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2819... # v4
+        uses: actions/cache/restore@...2819... # v4.0.2
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@

       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2813... # v4.1.7

       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2819... # v4
+        uses: actions/cache/save@...2819... # v4.0.2
         with:
           path: |
             cov-int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/789?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I91f68317450c3c0d69be2c489276739211ccb422
Gerrit-Change-Number: 789
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--wLniMmoMbFo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/789?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: General update November 2024<br><br>Contains the followi=
ng renovate updates:<br><br>- Update dependency libressl/portable to v4<br>=
- Update dependency Mbed-TLS/mbedtls to v3.6.2<br>- Update mingw ubuntu run=
ner to v24<br>  - Do NOT update the uncrustify runner since newer uncrustif=
y<br>    is not usable with the current config<br>- Update vcpkg digest to =
b505fa7<br><br>Additionally change the action reference pinning<br>to consi=
stently refer to the tags instead of the branches.<br><br>Change-Id: I91f68=
317450c3c0d69be2c489276739211ccb422<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>M .github=
/workflows/coverity-scan.yml<br>2 files changed, 24 insertions(+), 24 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/89/789/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/wo=
rkflows/build.yaml</span><br><span>index 3958ef0..bb13ab3 100644</span><br>=
<span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/work=
flows/build.yaml</span><br><span>@@ -13,7 +13,7 @@</span><br><span>       -=
 name: Install dependencies</span><br><span>         run: sudo apt update &=
amp;&amp; sudo apt install -y uncrustify</span><br><span>       - name: Che=
ckout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
uses: actions/checkout@...2813... # v4</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        uses: actions/checkout@...2813... # v4.1.7</span=
><br><span>         with:</span><br><span>           path: openvpn</span><b=
r><span>       - name: Show uncrustify version</span><br><span>@@ -27,7 +27=
,7 @@</span><br><span>       - name: Show changes on standard output</span>=
<br><span>         run: git diff</span><br><span>         working-directory=
: openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses=
: actions/upload-artifact@...2814... # v4</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2814... # v4=
.4.0</span><br><span>         with:</span><br><span>           name: uncrus=
tify-changes.patch</span><br><span>           path: &#39;openvpn/uncrustify=
-changes.patch&#39;</span><br><span>@@ -42,19 +42,19 @@</span><br><span>   =
      arch: [x86, x64]</span><br><span> </span><br><span>     name: &quot;g=
cc-mingw - ${{ matrix.arch }} - OSSL&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    runs-on: ubuntu-22.04</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><span>     e=
nv:</span><br><span>       VCPKG_ROOT: ${{ github.workspace }}/vcpkg</span>=
<br><span>     steps:</span><br><span>       - name: Install dependencies</=
span><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y=
 mingw-w64 unzip cmake ninja-build build-essential wget python3-docutils ma=
n2html-base</span><br><span>       - name: Checkout OpenVPN</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2829...=
3... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@...2813... # v4.1.7</span><br><span> </span><br><span>=
       - name: Restore from cache and install vcpkg</span><br><span>       =
  uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommi=
tId: 8d3649ba34aab36914ddd897958599aa0a91b08e</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: b505fa789fd96eb5496a2=
e42c651c169e8460d27</span><br><span>           vcpkgJsonGlob: &#39;**/mingw=
/vcpkg.json&#39;</span><br><span> </span><br><span>       - name: Run CMake=
 with vcpkg.json manifest</span><br><span>@@ -64,7 +64,7 @@</span><br><span=
>           buildPreset: mingw-${{ matrix.arch }}</span><br><span>         =
  buildPresetAdditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - use=
s: actions/upload-artifact@...2814... # v4</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2814... # v=
4.4.0</span><br><span>         with:</span><br><span>           name: openv=
pn-mingw-${{ matrix.arch }}</span><br><span>           path: |</span><br><s=
pan>@@ -72,7 +72,7 @@</span><br><span>             ${{ github.workspace }}/=
out/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br><span>            =
 !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.e=
xe</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     - uses: actions/upload-artifact@...2814... # v4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...493...=
2814... # v4.4.0</span><br><span>         with:</span><br><span>           =
name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>           pat=
h: |</span><br><span>@@ -91,9 +91,9 @@</span><br><span>     name: &quot;min=
gw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</span><br>=
<span>     steps:</span><br><span>       - name: Checkout OpenVPN</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@=
...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uses: actions/checkout@...2813... # v4.1.7</span><br><span>       - nam=
e: Retrieve mingw unittest</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uses: actions/download-artifact@...2817... # v4</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/download-art=
ifact@...2817... # v4.1.8</span><br><span>         with:</span><br><span>  =
         name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>     =
      path: unittests</span><br><span>@@ -165,7 +165,7 @@</span><br><span> =
      - name: Install dependencies</span><br><span>         run: sudo apt u=
pdate &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev li=
bcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-=
docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span> =
      - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uses: actions/checkout@...2813... # v4</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2820...=
.. # v4.1.7</span><br><span>       - name: autoconf</span><br><span>       =
  run: autoreconf -fvi</span><br><span>       - name: configure</span><br><=
span>@@ -195,7 +195,7 @@</span><br><span>       - name: Install dependencie=
s</span><br><span>         run: sudo apt update &amp;&amp; sudo apt install=
 -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linu=
x-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake a=
utoconf libmbedtls-dev</span><br><span>       - name: Checkout OpenVPN</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/chec=
kout@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        uses: actions/checkout@...2813... # v4.1.7</span><br><span>       =
- name: autoconf</span><br><span>         run: autoreconf -fvi</span><br><s=
pan>       - name: configure</span><br><span>@@ -235,7 +235,7 @@</span><br>=
<span>       - name: Install dependencies</span><br><span>         run: bre=
w install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoc=
onf</span><br><span>       - name: Checkout OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2813... #=
 v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: ac=
tions/checkout@...2813... # v4.1.7</span><br><span>       - name: Set envir=
onment</span><br><span>         run: |</span><br><span>           cat &gt;&=
gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -267,7 +267,7 @@</span><br><=
span> </span><br><span>       runs-on: windows-latest</span><br><span>     =
  steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses:=
 actions/checkout@...2813... # v4</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      - uses: actions/checkout@...2813... # v4.1.7</span><br>=
<span>       - uses: lukka/get-cmake@...2818... # v3.30.3</span><br><span> =
</span><br><span>       - name: Install rst2html</span><br><span>@@ -276,7 =
+276,7 @@</span><br><span>       - name: Restore artifacts, or setup vcpkg =
(do not install any package)</span><br><span>         uses: lukka/run-vcpkg=
@...2815... # v11.5</span><br><span>         with:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 8d3649ba34aab36914=
ddd897958599aa0a91b08e</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          vcpkgGitCommitId: b505fa789fd96eb5496a2e42c651c169e8460d27</sp=
an><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</spa=
n><br><span> </span><br><span>       - name: Run CMake with vcpkg.json mani=
fest (NO TESTS)</span><br><span>@@ -295,7 +295,7 @@</span><br><span>       =
    testPreset: win-${{ matrix.arch }}-release</span><br><span>           t=
estPresetAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - us=
es: actions/upload-artifact@...2814... # v4</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2814... # =
v4.4.0</span><br><span>         with:</span><br><span>           name: open=
vpn-msvc-${{ matrix.arch }}</span><br><span>           path: |</span><br><s=
pan>@@ -335,12 +335,12 @@</span><br><span>       - name: Install dependenci=
es</span><br><span>         run: sudo apt update &amp;&amp; sudo apt instal=
l -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libc=
mocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-d=
ev libnl-genl-3-dev</span><br><span>       - name: &quot;libressl: checkout=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: a=
ctions/checkout@...2813... # v4</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        uses: actions/checkout@...2813... # v4.1.7</span><br><s=
pan>         with:</span><br><span>           path: libressl</span><br><spa=
n>           # versioning=3Dsemver-coerced</span><br><span>           repos=
itory: libressl/portable</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          ref: v3.8.3</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+          ref: v4.0.0</span><br><span>       - name: &quot;libressl: a=
utogen.sh&quot;</span><br><span>         run: ./autogen.sh</span><br><span>=
         working-directory: libressl</span><br><span>@@ -356,7 +356,7 @@</s=
pan><br><span>       - name: &quot;ldconfig&quot;</span><br><span>         =
run: sudo ldconfig</span><br><span>       - name: Checkout OpenVPN</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout=
@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     uses: actions/checkout@...2813... # v4.1.7</span><br><span>       - na=
me: autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>=
       - name: configure</span><br><span>@@ -397,13 +397,13 @@</span><br><s=
pan>       - name: Install dependencies</span><br><span>         run: sudo =
apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-d=
ev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jin=
ja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev l=
ibnl-genl-3-dev</span><br><span>       - name: &quot;mbedtls: checkout&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/checkout@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/checkout@...2813... # v4.1.7</span><br><span> =
        with:</span><br><span>           path: mbedtls</span><br><span>    =
       submodules: true</span><br><span>           # versioning=3Dsemver-co=
erced</span><br><span>           repository: Mbed-TLS/mbedtls</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          ref: v3.6.1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          ref: v3.6.2</span><br><=
span>       - name: &quot;mbedtls: make no_test&quot;</span><br><span>     =
    run: make -j3 no_test SHARED=3D1</span><br><span>         working-direc=
tory: mbedtls</span><br><span>@@ -411,7 +411,7 @@</span><br><span>         =
run: sudo make install DESTDIR=3D/usr</span><br><span>         working-dire=
ctory: mbedtls</span><br><span>       - name: Checkout OpenVPN</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...493...=
2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/checkout@...2813... # v4.1.7</span><br><span>       - name: =
autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>    =
   - name: configure</span><br><span>diff --git a/.github/workflows/coverit=
y-scan.yml b/.github/workflows/coverity-scan.yml</span><br><span>index 16c9=
79d..999fd29 100644</span><br><span>--- a/.github/workflows/coverity-scan.y=
ml</span><br><span>+++ b/.github/workflows/coverity-scan.yml</span><br><spa=
n>@@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><span>       - na=
me: Check submission cache</span><br><span>         id: check_submit</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/=
restore@...2819... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uses: actions/cache/restore@...2819... # v4.0.2</span><br><span=
>         with:</span><br><span>           path: |</span><br><span>        =
     cov-int</span><br><span>@@ -25,7 +25,7 @@</span><br><span> </span><br>=
<span>       - name: Checkout OpenVPN</span><br><span>         if: steps.ch=
eck_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2813... # v4</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/checkout@...2813... # v4.1.7</span><br><span> </span><br><span>       - na=
me: Download Coverity Build Tool</span><br><span>         if: steps.check_s=
ubmit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span>@@ -65,7 +65,7 =
@@</span><br><span> </span><br><span>       - name: Cache submission</span>=
<br><span>         if: steps.check_submit.outputs.cache-hit !=3D &#39;true&=
#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: act=
ions/cache/save@...2819... # v4</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        uses: actions/cache/save@...2819... # v4.0.2</span><br>=
<span>         with:</span><br><span>           path: |</span><br><span>   =
          cov-int</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/789?usp=3Demail">change 789</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/789?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I91f68317450c3c0d69be2c48927=
6739211ccb422 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 789 </div>
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


--wLniMmoMbFo=--

