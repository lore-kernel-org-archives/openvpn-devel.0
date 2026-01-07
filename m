From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 7 Jan 2026 21:33:15 +0000
In-Reply-To: <gerrit.1767796244000.I637cc37f82d96a7d15738cc39523664777714e97@...2715...>
References: <gerrit.1767796244000.I637cc37f82d96a7d15738cc39523664777714e97@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <251c784c6845fad04179ae0212c23859b40fa74d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gHFAHavWX+A="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gHFAHavWX+A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1455?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


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
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1455
Message-Id: <20260107173402.5614-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
175.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
M .github/workflows/doxygen.yml
3 files changed, 31 insertions(+), 31 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1455/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I637cc37f82d96a7d15738cc39523664777714e97
Gerrit-Change-Number: 1455
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gHFAHavWX+A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1455?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by uddr</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">GHA: Maintenance update January 2026=
<br><br>Includes the following renovate changes:<br>- chore(deps): update d=
ependency aws/aws-lc to v1.66.2<br>- Update lukka/get-cmake action to v4.2.=
1<br>- chore(deps): update github actions<br>- chore(deps): update vcpkg di=
gest to eeb00f1<br><br>Change-Id: I637cc37f82d96a7d15738cc39523664777714e97=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>Gerrit URL: https://gerrit.op=
envpn.net/c/openvpn/+/1455<br>Message-Id: &lt;20260107173402.5614-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg35175.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M .github/workflows/build.yaml<br>M .github/workflows/coveri=
ty-scan.yml<br>M .github/workflows/doxygen.yml<br>3 files changed, 31 inser=
tions(+), 31 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/55/1455/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.gith=
ub/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span>inde=
x 11c2d65..d1322c7 100644</span><br><span>--- a/.github/workflows/build.yam=
l</span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -14=
,12 +14,12 @@</span><br><span>           sudo apt update &amp;&amp; sudo ap=
t install -y python3-pip</span><br><span>           pip3 install pre-commit=
</span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2955... # v5.0=
.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: act=
ions/checkout@...2977... # v6.0.1</span><br><span>       - name: Run clang-=
format</span><br><span>         run: pre-commit run -a --show-diff-on-failu=
re || true</span><br><span>       - name: Check for changes</span><br><span=
>         run: git diff --output=3Dformat-changes.patch</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...493...=
2956... # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   - uses: actions/upload-artifact@...2978... # v6.0.0</span><br><span>    =
     with:</span><br><span>           name: format-changes.patch</span><br>=
<span>           path: format-changes.patch</span><br><span>@@ -44,12 +44,1=
2 @@</span><br><span>       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vc=
pkg/installed</span><br><span>     steps:</span><br><span>       - name: Ch=
eckout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2957... # v4.1.2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/c=
heckout@...2977... # v6.0.1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      - uses: lukka/get-cmake@...2979... # v4.2.1</span><br><span> =
      - name: Install vcpkg</span><br><span>         uses: lukka/run-vcpkg@=
...2815... # v11.5</span><br><span>         with:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 3bbc2809d3625cb83a0=
d7cbd413bd6ad769d46d4</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e</spa=
n><br><span>       - name: Install dependencies</span><br><span>         ru=
n: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><br><span>       - =
name: configure OpenVPN with cmake</span><br><span>@@ -78,13 +78,13 @@</spa=
n><br><span>       - name: Install dependencies</span><br><span>         ru=
n: sudo apt update &amp;&amp; sudo apt install -y mingw-w64 unzip build-ess=
ential wget python3-docutils man2html-base</span><br><span>       - name: C=
heckout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2977... # v6.0.1=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   - uses: lukka/get-cmake@...2957... # v4.1.2</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2979... # v4.2.=
1</span><br><span>       - name: Restore from cache and install vcpkg</span=
><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><spa=
n>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
     vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: eeb=
00f1ecba68f68fad6a1ee93eec77921b3146e</span><br><span>           vcpkgJsonG=
lob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>      =
 - name: Run CMake with vcpkg.json manifest</span><br><span>@@ -94,7 +94,7 =
@@</span><br><span>           buildPreset: mingw-${{ matrix.arch }}</span><=
br><span>           buildPresetAdditionalArgs: &quot;[&#39;--config ${{ mat=
rix.build }}&#39;]&quot;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2956... # v5.=
0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: ac=
tions/upload-artifact@...2978... # v6.0.0</span><br><span>         with:</s=
pan><br><span>           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.=
build }}</span><br><span>           path: |</span><br><span>@@ -102,7 +102,=
7 @@</span><br><span>             ${{ github.workspace }}/out/build/mingw/$=
{{ matrix.arch }}/**/${{ matrix.build }}/*.dll</span><br><span>            =
 !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.bui=
ld }}/test_*.exe</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      - uses: actions/upload-artifact@...2956... # v5.0.0</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/up=
load-artifact@...2978... # v6.0.0</span><br><span>         with:</span><br>=
<span>           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}=
-tests</span><br><span>           path: |</span><br><span>@@ -122,9 +122,9 =
@@</span><br><span>     name: &quot;mingw unittest ${{ matrix.test }} - ${{=
 matrix.arch }} - ${{ matrix.build }} - OSSL&quot;</span><br><span>     ste=
ps:</span><br><span>       - name: Checkout OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2955... #=
 v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses=
: actions/checkout@...2977... # v6.0.1</span><br><span>       - name: Retri=
eve mingw unittest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     uses: actions/download-artifact@...2958... # v6.0.0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/download-artifac=
t@...2980... # v7.0.0</span><br><span>         with:</span><br><span>      =
     name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests</span=
><br><span>           path: unittests</span><br><span>@@ -161,7 +161,7 @@</=
span><br><span>       - name: Install dependencies</span><br><span>        =
 run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</=
span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2955... # v5.0.1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/checkout@...2977... # v6.0.1</span><br><span>       - name: autoconf</sp=
an><br><span>         run: autoreconf -fvi</span><br><span>       - name: c=
onfigure</span><br><span>@@ -191,7 +191,7 @@</span><br><span>       - name:=
 Install dependencies</span><br><span>         run: sudo apt update &amp;&a=
mp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev l=
ibnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutil=
s libtool automake autoconf</span><br><span>       - name: Checkout OpenVPN=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions=
/checkout@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        uses: actions/checkout@...2977... # v6.0.1</span><br><spa=
n>       - name: autoconf</span><br><span>         run: autoreconf -fvi</sp=
an><br><span>       - name: configure</span><br><span>@@ -231,7 +231,7 @@</=
span><br><span>       - name: Install dependencies</span><br><span>        =
 run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool autom=
ake autoconf</span><br><span>       - name: Checkout OpenVPN</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2924...=
55... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uses: actions/checkout@...2977... # v6.0.1</span><br><span>       - name=
: Set environment</span><br><span>         run: |</span><br><span>         =
  cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -263,8 +263,8 @@<=
/span><br><span> </span><br><span>       runs-on: windows-2025</span><br><s=
pan>       steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  - uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2957... # v4.1.2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: action=
s/checkout@...2977... # v6.0.1</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      - uses: lukka/get-cmake@...2979... # v4.2.1</span><br><spa=
n> </span><br><span>       - name: Install rst2html</span><br><span>       =
  run: python -m pip install --upgrade pip docutils</span><br><span>@@ -272=
,7 +272,7 @@</span><br><span>       - name: Restore artifacts, or setup vcp=
kg (do not install any package)</span><br><span>         uses: lukka/run-vc=
pkg@...2815... # v11.5</span><br><span>         with:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 3bbc2809d3625cb=
83a0d7cbd413bd6ad769d46d4</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e<=
/span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</=
span><br><span> </span><br><span>       - name: Run CMake with vcpkg.json m=
anifest (NO TESTS)</span><br><span>@@ -291,7 +291,7 @@</span><br><span>    =
       testPreset: win-${{ matrix.arch }}-release</span><br><span>         =
  testPresetAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      -=
 uses: actions/upload-artifact@...2956... # v5.0.0</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2986...=
8... # v6.0.0</span><br><span>         with:</span><br><span>           nam=
e: openvpn-msvc-${{ matrix.arch }}</span><br><span>           path: |</span=
><br><span>@@ -331,7 +331,7 @@</span><br><span>       - name: Install depen=
dencies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt i=
nstall -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang=
 libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap=
-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;libressl: che=
ckout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        us=
es: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        uses: actions/checkout@...2977... # v6.0.1</sp=
an><br><span>         with:</span><br><span>           path: libressl</span=
><br><span>           # versioning=3Dsemver-coerced</span><br><span>@@ -354=
,7 +354,7 @@</span><br><span>       - name: &quot;ldconfig&quot;</span><br>=
<span>         run: sudo ldconfig</span><br><span>       - name: Checkout O=
penVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: a=
ctions/checkout@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        uses: actions/checkout@...2977... # v6.0.1</span><b=
r><span>       - name: autoconf</span><br><span>         run: autoreconf -f=
vi</span><br><span>       - name: configure</span><br><span>@@ -395,7 +395,=
7 @@</span><br><span>       - name: Install dependencies</span><br><span>  =
       run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libp=
am0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-doc=
utils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-confi=
g libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;mbedt=
ls: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2977... # v6.=
0.1</span><br><span>         with:</span><br><span>           path: mbedtls=
</span><br><span>           submodules: true</span><br><span>@@ -409,7 +409=
,7 @@</span><br><span>         run: sudo make install DESTDIR=3D/usr</span>=
<br><span>         working-directory: mbedtls</span><br><span>       - name=
: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2977... # v6.=
0.1</span><br><span>       - name: autoconf</span><br><span>         run: a=
utoreconf -fvi</span><br><span>       - name: configure</span><br><span>@@ =
-454,13 +454,13 @@</span><br><span>       - name: Install dependencies</spa=
n><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y gc=
c golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html c=
lang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libto=
ol automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><s=
pan>       - name: &quot;AWS-LC: checkout&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2955... # v5.0.=
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: acti=
ons/checkout@...2977... # v6.0.1</span><br><span>         with:</span><br><=
span>           path: aws-lc</span><br><span>           # versioning=3Dsemv=
er-coerced</span><br><span>           repository: aws/aws-lc</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-          ref: v1.64.0</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2924...=
57... # v4.1.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
     ref: v1.66.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - uses: lukka/get-cmake@...2979... # v4.2.1</span><br><span>       - na=
me: &quot;AWS-LC: build&quot;</span><br><span>         run: |</span><br><sp=
an>           mkdir build</span><br><span>@@ -469,7 +469,7 @@</span><br><sp=
an>           ninja install</span><br><span>         working-directory: aws=
-lc</span><br><span>       - name: Checkout OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2955... #=
 v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses=
: actions/checkout@...2977... # v6.0.1</span><br><span>       - name: autoc=
onf</span><br><span>         run: autoreconf -fvi</span><br><span>       - =
name: configure with AWS-LC</span><br><span>diff --git a/.github/workflows/=
coverity-scan.yml b/.github/workflows/coverity-scan.yml</span><br><span>ind=
ex fa18115..f329482 100644</span><br><span>--- a/.github/workflows/coverity=
-scan.yml</span><br><span>+++ b/.github/workflows/coverity-scan.yml</span><=
br><span>@@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><span>    =
   - name: Check submission cache</span><br><span>         id: check_submit=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions=
/cache/restore@...2959... # v4.3.0</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uses: actions/cache/restore@...2981... # v5.0.1</spa=
n><br><span>         with:</span><br><span>           path: |</span><br><sp=
an>             cov-int</span><br><span>@@ -25,7 +25,7 @@</span><br><span> =
</span><br><span>       - name: Checkout OpenVPN</span><br><span>         i=
f: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2967...=
5... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  uses: actions/checkout@...2977... # v6.0.1</span><br><span> </span><br><s=
pan>       - name: Download Coverity Build Tool</span><br><span>         if=
: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span>=
@@ -65,7 +65,7 @@</span><br><span> </span><br><span>       - name: Cache su=
bmission</span><br><span>         if: steps.check_submit.outputs.cache-hit =
!=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      uses: actions/cache/save@...2959... # v4.3.0</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uses: actions/cache/save@...2981... =
# v5.0.1</span><br><span>         with:</span><br><span>           path: |<=
/span><br><span>             cov-int</span><br><span>diff --git a/.github/w=
orkflows/doxygen.yml b/.github/workflows/doxygen.yml</span><br><span>index =
0828dd0..b510dc8 100644</span><br><span>--- a/.github/workflows/doxygen.yml=
</span><br><span>+++ b/.github/workflows/doxygen.yml</span><br><span>@@ -11=
,7 +11,7 @@</span><br><span>     runs-on: ubuntu-24.04</span><br><span>    =
 if: ${{ github.repository_owner =3D=3D &#39;openvpn&#39; || github.event_n=
ame =3D=3D &#39;workflow_dispatch&#39; }}</span><br><span>     steps:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/check=
out@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      - uses: actions/checkout@...2977... # v6.0.1</span><br><span>    =
     with:</span><br><span>           path: openvpn</span><br><span> </span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1455?usp=3Demail">change 1455</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1455?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I637cc37f82d96a7d15738cc3952=
3664777714e97 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1455 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--gHFAHavWX+A=--

