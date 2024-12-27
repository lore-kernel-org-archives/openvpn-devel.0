From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 14:11:34 +0000
In-Reply-To: <gerrit.1730381354000.I91f68317450c3c0d69be2c489276739211ccb422@...2715...>
References: <gerrit.1730381354000.I91f68317450c3c0d69be2c489276739211ccb422@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <daf9615075305775732904e1ba5a00503108fc1a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tGMw4fkodiY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: General update
 December 2024
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

--tGMw4fkodiY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/789?usp=3Demail

to look at the new patch set (#2).


Change subject: GHA: General update December 2024
......................................................................

GHA: General update December 2024

Contains the following renovate updates:

- Update dependency libressl/portable to v4
  - Requires setting LIBRESSL_GIT_OPTIONS
    since the default is --depth=3D8 which is
    unusable for checking out tags.
- Update dependency Mbed-TLS/mbedtls to v3.6.2
- Update mingw ubuntu runner to v24
  - Do NOT update the uncrustify runner since newer uncrustify
    is not usable with the current config
- Update vcpkg digest to 80d54ff
- Update github actions

Additionally change the action reference pinning
to consistently refer to the tags instead of the branches.

Change-Id: I91f68317450c3c0d69be2c489276739211ccb422
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 27 insertions(+), 25 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/789/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 767de0b..90d5202 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -13,7 +13,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
         with:
           path: openvpn
       - name: Show uncrustify version
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2845... # v4.5.0
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
+        uses: actions/checkout@...2844... # v4.2.2

       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
+          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -64,7 +64,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2845... # v4.5.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -72,7 +72,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2845... # v4.5.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -91,9 +91,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
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
+        uses: actions/checkout@...2844... # v4.2.2
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
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -235,7 +235,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libto=
ol automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -267,8 +267,8 @@

       runs-on: windows-latest
       steps:
-      - uses: actions/checkout@...2813... # v4
-      - uses: lukka/get-cmake@...2818... # v3.30.3
+      - uses: actions/checkout@...2844... # v4.2.2
+      - uses: lukka/get-cmake@...2846... # v3.31.3

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -276,7 +276,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
+          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -295,7 +295,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2845... # v4.5.0
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -335,13 +335,15 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
         with:
           path: libressl
           # versioning=3Dsemver-coerced
           repository: libressl/portable
-          ref: v3.8.3
+          ref: v4.0.0
       - name: "libressl: autogen.sh"
+        env:
+          LIBRESSL_GIT_OPTIONS: "--no-single-branch"
         run: ./autogen.sh
         working-directory: libressl
       - name: "libressl: configure"
@@ -356,7 +358,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -397,13 +399,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
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
@@ -411,7 +413,7 @@
         run: sudo make install DESTDIR=3D/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index 16c979d..cb70022 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2819... # v4
+        uses: actions/cache/restore@...2847... # v4.2.0
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@

       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2

       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2819... # v4
+        uses: actions/cache/save@...2847... # v4.2.0
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--tGMw4fkodiY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/789?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">GHA: General update December 2024<br><br>Contains the following re=
novate updates:<br><br>- Update dependency libressl/portable to v4<br>  - R=
equires setting LIBRESSL_GIT_OPTIONS<br>    since the default is --depth=3D=
8 which is<br>    unusable for checking out tags.<br>- Update dependency Mb=
ed-TLS/mbedtls to v3.6.2<br>- Update mingw ubuntu runner to v24<br>  - Do N=
OT update the uncrustify runner since newer uncrustify<br>    is not usable=
 with the current config<br>- Update vcpkg digest to 80d54ff<br>- Update gi=
thub actions<br><br>Additionally change the action reference pinning<br>to =
consistently refer to the tags instead of the branches.<br><br>Change-Id: I=
91f68317450c3c0d69be2c489276739211ccb422<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>M .g=
ithub/workflows/coverity-scan.yml<br>2 files changed, 27 insertions(+), 25 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/89/789/2</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.gith=
ub/workflows/build.yaml</span><br><span>index 767de0b..90d5202 100644</span=
><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github=
/workflows/build.yaml</span><br><span>@@ -13,7 +13,7 @@</span><br><span>   =
    - name: Install dependencies</span><br><span>         run: sudo apt upd=
ate &amp;&amp; sudo apt install -y uncrustify</span><br><span>       - name=
: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     uses: actions/checkout@...2813... # v4</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uses: actions/checkout@...2844... # v4.2.2<=
/span><br><span>         with:</span><br><span>           path: openvpn</sp=
an><br><span>       - name: Show uncrustify version</span><br><span>@@ -27,=
7 +27,7 @@</span><br><span>       - name: Show changes on standard output</=
span><br><span>         run: git diff</span><br><span>         working-dire=
ctory: openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      -=
 uses: actions/upload-artifact@...2814... # v4</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2845...=
 # v4.5.0</span><br><span>         with:</span><br><span>           name: u=
ncrustify-changes.patch</span><br><span>           path: &#39;openvpn/uncru=
stify-changes.patch&#39;</span><br><span>@@ -42,19 +42,19 @@</span><br><spa=
n>         arch: [x86, x64]</span><br><span> </span><br><span>     name: &q=
uot;gcc-mingw - ${{ matrix.arch }} - OSSL&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    runs-on: ubuntu-22.04</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><span=
>     env:</span><br><span>       VCPKG_ROOT: ${{ github.workspace }}/vcpkg=
</span><br><span>     steps:</span><br><span>       - name: Install depende=
ncies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt ins=
tall -y mingw-w64 unzip cmake ninja-build build-essential wget python3-docu=
tils man2html-base</span><br><span>       - name: Checkout OpenVPN</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout=
@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     uses: actions/checkout@...2844... # v4.2.2</span><br><span> </span><br=
><span>       - name: Restore from cache and install vcpkg</span><br><span>=
         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         =
with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgG=
itCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 80d54ff62d528=
339c626a6fbc3489a7f25956ade</span><br><span>           vcpkgJsonGlob: &#39;=
**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>       - name: R=
un CMake with vcpkg.json manifest</span><br><span>@@ -64,7 +64,7 @@</span><=
br><span>           buildPreset: mingw-${{ matrix.arch }}</span><br><span> =
          buildPresetAdditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   - uses: actions/upload-artifact@...2814... # v4</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2848...=
5... # v4.5.0</span><br><span>         with:</span><br><span>           nam=
e: openvpn-mingw-${{ matrix.arch }}</span><br><span>           path: |</spa=
n><br><span>@@ -72,7 +72,7 @@</span><br><span>             ${{ github.works=
pace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br><span>    =
         !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/=
test_*.exe</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      - uses: actions/upload-artifact@...2814... # v4</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artif=
act@...2845... # v4.5.0</span><br><span>         with:</span><br><span>    =
       name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>       =
    path: |</span><br><span>@@ -91,9 +91,9 @@</span><br><span>     name: &q=
uot;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</sp=
an><br><span>     steps:</span><br><span>       - name: Checkout OpenVPN</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/ch=
eckout@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        uses: actions/checkout@...2844... # v4.2.2</span><br><span>     =
  - name: Retrieve mingw unittest</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        uses: actions/download-artifact@...2817... # v4</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/downl=
oad-artifact@...2817... # v4.1.8</span><br><span>         with:</span><br><=
span>           name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><spa=
n>           path: unittests</span><br><span>@@ -165,7 +165,7 @@</span><br>=
<span>       - name: Install dependencies</span><br><span>         run: sud=
o apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4=
-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev p=
ython3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br>=
<span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/checkout@...2813... # v4</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...220...=
..2844... # v4.2.2</span><br><span>       - name: autoconf</span><br><span>=
         run: autoreconf -fvi</span><br><span>       - name: configure</spa=
n><br><span>@@ -195,7 +195,7 @@</span><br><span>       - name: Install depe=
ndencies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt =
install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-d=
ev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool aut=
omake autoconf libmbedtls-dev</span><br><span>       - name: Checkout OpenV=
PN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actio=
ns/checkout@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: actions/checkout@...2844... # v4.2.2</span><br><span>=
       - name: autoconf</span><br><span>         run: autoreconf -fvi</span=
><br><span>       - name: configure</span><br><span>@@ -235,7 +235,7 @@</sp=
an><br><span>       - name: Install dependencies</span><br><span>         r=
un: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automak=
e autoconf</span><br><span>       - name: Checkout OpenVPN</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2823...=
... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        use=
s: actions/checkout@...2844... # v4.2.2</span><br><span>       - name: Set =
environment</span><br><span>         run: |</span><br><span>           cat =
&gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -267,8 +267,8 @@</span>=
<br><span> </span><br><span>       runs-on: windows-latest</span><br><span>=
       steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - =
uses: actions/checkout@...2813... # v4</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-      - uses: lukka/get-cmake@...2818... # v3.30.3</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/check=
out@...2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      - uses: lukka/get-cmake@...2846... # v3.31.3</span><br><span> </s=
pan><br><span>       - name: Install rst2html</span><br><span>         run:=
 python -m pip install --upgrade pip docutils</span><br><span>@@ -276,7 +27=
6,7 @@</span><br><span>       - name: Restore artifacts, or setup vcpkg (do=
 not install any package)</span><br><span>         uses: lukka/run-vcpkg@...1186...=
.2815... # v11.5</span><br><span>         with:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 8d3649ba34aab36914ddd=
897958599aa0a91b08e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade</span>=
<br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><=
br><span> </span><br><span>       - name: Run CMake with vcpkg.json manifes=
t (NO TESTS)</span><br><span>@@ -295,7 +295,7 @@</span><br><span>          =
 testPreset: win-${{ matrix.arch }}-release</span><br><span>           test=
PresetAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses:=
 actions/upload-artifact@...2814... # v4</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2845... # v4.=
5.0</span><br><span>         with:</span><br><span>           name: openvpn=
-msvc-${{ matrix.arch }}</span><br><span>           path: |</span><br><span=
>@@ -335,13 +335,15 @@</span><br><span>       - name: Install dependencies<=
/span><br><span>         run: sudo apt update &amp;&amp; sudo apt install -=
y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmoc=
ka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev =
libnl-genl-3-dev</span><br><span>       - name: &quot;libressl: checkout&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: acti=
ons/checkout@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        uses: actions/checkout@...2844... # v4.2.2</span><br><span=
>         with:</span><br><span>           path: libressl</span><br><span> =
          # versioning=3Dsemver-coerced</span><br><span>           reposito=
ry: libressl/portable</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
          ref: v3.8.3</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+          ref: v4.0.0</span><br><span>       - name: &quot;libressl: auto=
gen.sh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 env:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          LIBR=
ESSL_GIT_OPTIONS: &quot;--no-single-branch&quot;</span><br><span>         r=
un: ./autogen.sh</span><br><span>         working-directory: libressl</span=
><br><span>       - name: &quot;libressl: configure&quot;</span><br><span>@=
@ -356,7 +358,7 @@</span><br><span>       - name: &quot;ldconfig&quot;</spa=
n><br><span>         run: sudo ldconfig</span><br><span>       - name: Chec=
kout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
ses: actions/checkout@...2813... # v4</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        uses: actions/checkout@...2844... # v4.2.2</span>=
<br><span>       - name: autoconf</span><br><span>         run: autoreconf =
-fvi</span><br><span>       - name: configure</span><br><span>@@ -397,13 +3=
99,13 @@</span><br><span>       - name: Install dependencies</span><br><spa=
n>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev =
libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3=
-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-c=
onfig libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;m=
bedtls: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        uses: actions/checkout@...2813... # v4</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2844... # v4.=
2.2</span><br><span>         with:</span><br><span>           path: mbedtls=
</span><br><span>           submodules: true</span><br><span>           # v=
ersioning=3Dsemver-coerced</span><br><span>           repository: Mbed-TLS/=
mbedtls</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref:=
 v3.6.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          re=
f: v3.6.2</span><br><span>       - name: &quot;mbedtls: make no_test&quot;<=
/span><br><span>         run: make -j3 no_test SHARED=3D1</span><br><span> =
        working-directory: mbedtls</span><br><span>@@ -411,7 +413,7 @@</spa=
n><br><span>         run: sudo make install DESTDIR=3D/usr</span><br><span>=
         working-directory: mbedtls</span><br><span>       - name: Checkout=
 OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses:=
 actions/checkout@...2813... # v4</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        uses: actions/checkout@...2844... # v4.2.2</span><br>=
<span>       - name: autoconf</span><br><span>         run: autoreconf -fvi=
</span><br><span>       - name: configure</span><br><span>diff --git a/.git=
hub/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml</span=
><br><span>index 16c979d..cb70022 100644</span><br><span>--- a/.github/work=
flows/coverity-scan.yml</span><br><span>+++ b/.github/workflows/coverity-sc=
an.yml</span><br><span>@@ -13,7 +13,7 @@</span><br><span>     steps:</span>=
<br><span>       - name: Check submission cache</span><br><span>         id=
: check_submit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 uses: actions/cache/restore@...2819... # v4</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/cache/restore@...2847... # v=
4.2.0</span><br><span>         with:</span><br><span>           path: |</sp=
an><br><span>             cov-int</span><br><span>@@ -25,7 +25,7 @@</span><=
br><span> </span><br><span>       - name: Checkout OpenVPN</span><br><span>=
         if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/check=
out@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/checkout@...2844... # v4.2.2</span><br><span> </span>=
<br><span>       - name: Download Coverity Build Tool</span><br><span>     =
    if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br>=
<span>@@ -65,7 +65,7 @@</span><br><span> </span><br><span>       - name: Ca=
che submission</span><br><span>         if: steps.check_submit.outputs.cach=
e-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uses: actions/cache/save@...2819... # v4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/save@...2849...=
.. # v4.2.0</span><br><span>         with:</span><br><span>           path:=
 |</span><br><span>             cov-int</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/789?usp=3D=
email">change 789</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/789?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I91f68317450c3c0d69be2c48927=
6739211ccb422 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 789 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--tGMw4fkodiY=--

