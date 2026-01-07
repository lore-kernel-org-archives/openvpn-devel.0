From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 7 Jan 2026 14:30:49 +0000
References: <gerrit.1767796244000.I637cc37f82d96a7d15738cc39523664777714e97@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d2716a1c0c3cbb73f06caa516d3277e0f48eb71d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1XOX/+Q4PH0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Maintenance
 update January 2026
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

--1XOX/+Q4PH0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1455?usp=3Demail

to review the following change.


Change subject: GHA: Maintenance update January 2026
......................................................................

GHA: Maintenance update January 2026

Includes the following renovate changes:
- chore(deps): update dependency aws/aws-lc to v1.66.2
- Update lukka/get-cmake action to v4.2.1
- chore(deps): update github actions
- chore(deps): update vcpkg digest to eeb00f1

Change-Id: I637cc37f82d96a7d15738cc39523664777714e97
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
M .github/workflows/doxygen.yml
3 files changed, 31 insertions(+), 31 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1455/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 11c2d65..d1322c7 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -14,12 +14,12 @@
           sudo apt update && sudo apt install -y python3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: Run clang-format
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
         run: git diff --output=3Dformat-changes.patch
-      - uses: actions/upload-artifact@...2956... # v5.0.0
+      - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: format-changes.patch
           path: format-changes.patch
@@ -44,12 +44,12 @@
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
-      - uses: lukka/get-cmake@...2957... # v4.1.2
+        uses: actions/checkout@...2977... # v6.0.1
+      - uses: lukka/get-cmake@...2979... # v4.2.1
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -78,13 +78,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-=
essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1

-      - uses: lukka/get-cmake@...2957... # v4.1.2
+      - uses: lukka/get-cmake@...2979... # v4.2.1
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -94,7 +94,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config ${{ matrix.build }}']"

-      - uses: actions/upload-artifact@...2956... # v5.0.0
+      - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}
           path: |
@@ -102,7 +102,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
${{ matrix.build }}/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${=
{ matrix.build }}/test_*.exe

-      - uses: actions/upload-artifact@...2956... # v5.0.0
+      - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: |
@@ -122,9 +122,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ ma=
trix.build }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2958... # v6.0.0
+        uses: actions/download-artifact@...2980... # v7.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: unittests
@@ -161,7 +161,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -191,7 +191,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang =
libcmocka-dev python3-docutils libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -231,7 +231,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libto=
ol automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -263,8 +263,8 @@

       runs-on: windows-2025
       steps:
-      - uses: actions/checkout@...2955... # v5.0.1
-      - uses: lukka/get-cmake@...2957... # v4.1.2
+      - uses: actions/checkout@...2977... # v6.0.1
+      - uses: lukka/get-cmake@...2979... # v4.2.1

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -272,7 +272,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -291,7 +291,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2956... # v5.0.0
+      - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -331,7 +331,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
         with:
           path: libressl
           # versioning=3Dsemver-coerced
@@ -354,7 +354,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -395,7 +395,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
         with:
           path: mbedtls
           submodules: true
@@ -409,7 +409,7 @@
         run: sudo make install DESTDIR=3D/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -454,13 +454,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y gcc golang make liblzo=
2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev p=
ython3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf=
 pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "AWS-LC: checkout"
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
         with:
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.64.0
-      - uses: lukka/get-cmake@...2957... # v4.1.2
+          ref: v1.66.2
+      - uses: lukka/get-cmake@...2979... # v4.2.1
       - name: "AWS-LC: build"
         run: |
           mkdir build
@@ -469,7 +469,7 @@
           ninja install
         working-directory: aws-lc
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure with AWS-LC
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index fa18115..f329482 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2959... # v4.3.0
+        uses: actions/cache/restore@...2981... # v5.0.1
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@

       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1

       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2959... # v4.3.0
+        uses: actions/cache/save@...2981... # v5.0.1
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index 0828dd0..b510dc8 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -11,7 +11,7 @@
     runs-on: ubuntu-24.04
     if: ${{ github.repository_owner =3D=3D 'openvpn' || github.event_name =
=3D=3D 'workflow_dispatch' }}
     steps:
-      - uses: actions/checkout@...2955... # v5.0.1
+      - uses: actions/checkout@...2977... # v6.0.1
         with:
           path: openvpn


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1455?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I637cc37f82d96a7d15738cc39523664777714e97
Gerrit-Change-Number: 1455
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--1XOX/+Q4PH0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1455?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">GHA: Maintenance update January 2026<br><br=
>Includes the following renovate changes:<br>- chore(deps): update dependen=
cy aws/aws-lc to v1.66.2<br>- Update lukka/get-cmake action to v4.2.1<br>- =
chore(deps): update github actions<br>- chore(deps): update vcpkg digest to=
 eeb00f1<br><br>Change-Id: I637cc37f82d96a7d15738cc39523664777714e97<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .github/=
workflows/build.yaml<br>M .github/workflows/coverity-scan.yml<br>M .github/=
workflows/doxygen.yml<br>3 files changed, 31 insertions(+), 31 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/55/1455/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b=
/.github/workflows/build.yaml</span><br><span>index 11c2d65..d1322c7 100644=
</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.=
github/workflows/build.yaml</span><br><span>@@ -14,12 +14,12 @@</span><br><=
span>           sudo apt update &amp;&amp; sudo apt install -y python3-pip<=
/span><br><span>           pip3 install pre-commit</span><br><span>       -=
 name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        uses: actions/checkout@...2955... # v5.0.1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2977...=
 # v6.0.1</span><br><span>       - name: Run clang-format</span><br><span> =
        run: pre-commit run -a --show-diff-on-failure || true</span><br><sp=
an>       - name: Check for changes</span><br><span>         run: git diff =
--output=3Dformat-changes.patch</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      - uses: actions/upload-artifact@...2956... # v5.0.0</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/uploa=
d-artifact@...2978... # v6.0.0</span><br><span>         with:</span><br><sp=
an>           name: format-changes.patch</span><br><span>           path: f=
ormat-changes.patch</span><br><span>@@ -44,12 +44,12 @@</span><br><span>   =
    VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed</span><br>=
<span>     steps:</span><br><span>       - name: Checkout OpenVPN</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@=
...2955... # v5.0.1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    - uses: lukka/get-cmake@...2957... # v4.1.2</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2977... # v6.=
0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lu=
kka/get-cmake@...2979... # v4.2.1</span><br><span>       - name: Install vc=
pkg</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span=
><br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitComm=
itId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e</span><br><span>       - nam=
e: Install dependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg i=
nstall openssl lz4 cmocka</span><br><span>       - name: configure OpenVPN =
with cmake</span><br><span>@@ -78,13 +78,13 @@</span><br><span>       - nam=
e: Install dependencies</span><br><span>         run: sudo apt update &amp;=
&amp; sudo apt install -y mingw-w64 unzip build-essential wget python3-docu=
tils man2html-base</span><br><span>       - name: Checkout OpenVPN</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout=
@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        uses: actions/checkout@...2977... # v6.0.1</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cma=
ke@...2957... # v4.1.2</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      - uses: lukka/get-cmake@...2979... # v4.2.1</span><br><span>      =
 - name: Restore from cache and install vcpkg</span><br><span>         uses=
: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 3=
bbc2809d3625cb83a0d7cbd413bd6ad769d46d4</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93e=
ec77921b3146e</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg=
.json&#39;</span><br><span> </span><br><span>       - name: Run CMake with =
vcpkg.json manifest</span><br><span>@@ -94,7 +94,7 @@</span><br><span>     =
      buildPreset: mingw-${{ matrix.arch }}</span><br><span>           buil=
dPresetAdditionalArgs: &quot;[&#39;--config ${{ matrix.build }}&#39;]&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   - uses: actions/upload-artifact@...2956... # v5.0.0</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...1186...=
.2978... # v6.0.0</span><br><span>         with:</span><br><span>          =
 name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}</span><br><span=
>           path: |</span><br><span>@@ -102,7 +102,7 @@</span><br><span>   =
          ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{=
 matrix.build }}/*.dll</span><br><span>             !${{ github.workspace }=
}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - use=
s: actions/upload-artifact@...2956... # v5.0.0</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2978...=
 # v6.0.0</span><br><span>         with:</span><br><span>           name: o=
penvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests</span><br><span> =
          path: |</span><br><span>@@ -122,9 +122,9 @@</span><br><span>     =
name: &quot;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ ma=
trix.build }} - OSSL&quot;</span><br><span>     steps:</span><br><span>    =
   - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uses: actions/checkout@...2955... # v5.0.1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2982...=
... # v6.0.1</span><br><span>       - name: Retrieve mingw unittest</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/downloa=
d-artifact@...2958... # v6.0.0</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uses: actions/download-artifact@...2980... # v7.0.0</spa=
n><br><span>         with:</span><br><span>           name: openvpn-mingw-$=
{{ matrix.arch }}-${{ matrix.build }}-tests</span><br><span>           path=
: unittests</span><br><span>@@ -161,7 +161,7 @@</span><br><span>       - na=
me: Install dependencies</span><br><span>         run: sudo apt update &amp=
;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-de=
v libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils l=
ibtool automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>       - na=
me: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2977... # v=
6.0.1</span><br><span>       - name: autoconf</span><br><span>         run:=
 autoreconf -fvi</span><br><span>       - name: configure</span><br><span>@=
@ -191,7 +191,7 @@</span><br><span>       - name: Install dependencies</spa=
n><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y li=
blzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc=
-dev man2html clang libcmocka-dev python3-docutils libtool automake autocon=
f</span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2955... # v5.=
0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: ac=
tions/checkout@...2977... # v6.0.1</span><br><span>       - name: autoconf<=
/span><br><span>         run: autoreconf -fvi</span><br><span>       - name=
: configure</span><br><span>@@ -231,7 +231,7 @@</span><br><span>       - na=
me: Install dependencies</span><br><span>         run: brew install ${{matr=
ix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf</span><br><sp=
an>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        uses: actions/checkout@...2955... # v5.0.1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@=
...2977... # v6.0.1</span><br><span>       - name: Set environment</span><b=
r><span>         run: |</span><br><span>           cat &gt;&gt;$GITHUB_ENV =
&lt;&lt;EOF;</span><br><span>@@ -263,8 +263,8 @@</span><br><span> </span><b=
r><span>       runs-on: windows-2025</span><br><span>       steps:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout=
@...2955... # v5.0.1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     - uses: lukka/get-cmake@...2957... # v4.1.2</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      - uses: actions/checkout@...2977... # v6=
.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: l=
ukka/get-cmake@...2979... # v4.2.1</span><br><span> </span><br><span>      =
 - name: Install rst2html</span><br><span>         run: python -m pip insta=
ll --upgrade pip docutils</span><br><span>@@ -272,7 +272,7 @@</span><br><sp=
an>       - name: Restore artifacts, or setup vcpkg (do not install any pac=
kage)</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</sp=
an><br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCo=
mmitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e</span><br><span>          =
 vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </span><br=
><span>       - name: Run CMake with vcpkg.json manifest (NO TESTS)</span><=
br><span>@@ -291,7 +291,7 @@</span><br><span>           testPreset: win-${{=
 matrix.arch }}-release</span><br><span>           testPresetAdditionalArgs=
: &quot;[&#39;--output-on-failure&#39;]&quot;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-arti=
fact@...2956... # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      - uses: actions/upload-artifact@...2978... # v6.0.0</span><br><s=
pan>         with:</span><br><span>           name: openvpn-msvc-${{ matrix=
.arch }}</span><br><span>           path: |</span><br><span>@@ -331,7 +331,=
7 @@</span><br><span>       - name: Install dependencies</span><br><span>  =
       run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libp=
am0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-doc=
utils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</=
span><br><span>       - name: &quot;libressl: checkout&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2924...=
55... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uses: actions/checkout@...2977... # v6.0.1</span><br><span>         with=
:</span><br><span>           path: libressl</span><br><span>           # ve=
rsioning=3Dsemver-coerced</span><br><span>@@ -354,7 +354,7 @@</span><br><sp=
an>       - name: &quot;ldconfig&quot;</span><br><span>         run: sudo l=
dconfig</span><br><span>       - name: Checkout OpenVPN</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2955...=
 # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@...2977... # v6.0.1</span><br><span>       - name: aut=
oconf</span><br><span>         run: autoreconf -fvi</span><br><span>       =
- name: configure</span><br><span>@@ -395,7 +395,7 @@</span><br><span>     =
  - name: Install dependencies</span><br><span>         run: sudo apt updat=
e &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-=
libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 pytho=
n3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl=
-3-dev</span><br><span>       - name: &quot;mbedtls: checkout&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkou=
t@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uses: actions/checkout@...2977... # v6.0.1</span><br><span>      =
   with:</span><br><span>           path: mbedtls</span><br><span>         =
  submodules: true</span><br><span>@@ -409,7 +409,7 @@</span><br><span>    =
     run: sudo make install DESTDIR=3D/usr</span><br><span>         working=
-directory: mbedtls</span><br><span>       - name: Checkout OpenVPN</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkou=
t@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uses: actions/checkout@...2977... # v6.0.1</span><br><span>      =
 - name: autoconf</span><br><span>         run: autoreconf -fvi</span><br><=
span>       - name: configure</span><br><span>@@ -454,13 +454,13 @@</span><=
br><span>       - name: Install dependencies</span><br><span>         run: =
sudo apt update &amp;&amp; sudo apt install -y gcc golang make liblzo2-dev =
libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3=
-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-c=
onfig libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;A=
WS-LC: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2977... # =
v6.0.1</span><br><span>         with:</span><br><span>           path: aws-=
lc</span><br><span>           # versioning=3Dsemver-coerced</span><br><span=
>           repository: aws/aws-lc</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-          ref: v1.64.0</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-      - uses: lukka/get-cmake@...2957... # v4.1.2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+          ref: v1.66.2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmak=
e@...2979... # v4.2.1</span><br><span>       - name: &quot;AWS-LC: build&qu=
ot;</span><br><span>         run: |</span><br><span>           mkdir build<=
/span><br><span>@@ -469,7 +469,7 @@</span><br><span>           ninja instal=
l</span><br><span>         working-directory: aws-lc</span><br><span>      =
 - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uses: actions/checkout@...2955... # v5.0.1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2983...=
. # v6.0.1</span><br><span>       - name: autoconf</span><br><span>        =
 run: autoreconf -fvi</span><br><span>       - name: configure with AWS-LC<=
/span><br><span>diff --git a/.github/workflows/coverity-scan.yml b/.github/=
workflows/coverity-scan.yml</span><br><span>index fa18115..f329482 100644</=
span><br><span>--- a/.github/workflows/coverity-scan.yml</span><br><span>++=
+ b/.github/workflows/coverity-scan.yml</span><br><span>@@ -13,7 +13,7 @@</=
span><br><span>     steps:</span><br><span>       - name: Check submission =
cache</span><br><span>         id: check_submit</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        uses: actions/cache/restore@...2959... # =
v4.3.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses:=
 actions/cache/restore@...2981... # v5.0.1</span><br><span>         with:</=
span><br><span>           path: |</span><br><span>             cov-int</spa=
n><br><span>@@ -25,7 +25,7 @@</span><br><span> </span><br><span>       - na=
me: Checkout OpenVPN</span><br><span>         if: steps.check_submit.output=
s.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        uses: actions/checkout@...2955... # v5.0.1</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...493...=
2977... # v6.0.1</span><br><span> </span><br><span>       - name: Download =
Coverity Build Tool</span><br><span>         if: steps.check_submit.outputs=
.cache-hit !=3D &#39;true&#39;</span><br><span>@@ -65,7 +65,7 @@</span><br>=
<span> </span><br><span>       - name: Cache submission</span><br><span>   =
      if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/sa=
ve@...2959... # v4.3.0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        uses: actions/cache/save@...2981... # v5.0.1</span><br><span>   =
      with:</span><br><span>           path: |</span><br><span>            =
 cov-int</span><br><span>diff --git a/.github/workflows/doxygen.yml b/.gith=
ub/workflows/doxygen.yml</span><br><span>index 0828dd0..b510dc8 100644</spa=
n><br><span>--- a/.github/workflows/doxygen.yml</span><br><span>+++ b/.gith=
ub/workflows/doxygen.yml</span><br><span>@@ -11,7 +11,7 @@</span><br><span>=
     runs-on: ubuntu-24.04</span><br><span>     if: ${{ github.repository_o=
wner =3D=3D &#39;openvpn&#39; || github.event_name =3D=3D &#39;workflow_dis=
patch&#39; }}</span><br><span>     steps:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      - uses: actions/checkout@...2955... # v5.0.1</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/ch=
eckout@...2977... # v6.0.1</span><br><span>         with:</span><br><span> =
          path: openvpn</span><br><span> </span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1455?usp=
=3Demail">change 1455</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1455?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I637cc37f82d96a7d15738cc3952=
3664777714e97 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1455 </div>
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

--1XOX/+Q4PH0=--

