From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 7 Jan 2026 21:33:18 +0000
In-Reply-To: <gerrit.1767796244000.I637cc37f82d96a7d15738cc39523664777714e97@...2715...>
References: <gerrit.1767796244000.I637cc37f82d96a7d15738cc39523664777714e97@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <251c784c6845fad04179ae0212c23859b40fa74d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vmgyrLXVIA8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: uddr <yura.uddr@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vmgyrLXVIA8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
55?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I637cc37f82d96a7d15738cc39523664777714e97
Gerrit-Change-Number: 1455
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vmgyrLXVIA8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1455?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: Maintenance update January 2026<br><br>Incl=
udes the following renovate changes:<br>- chore(deps): update dependency aw=
s/aws-lc to v1.66.2<br>- Update lukka/get-cmake action to v4.2.1<br>- chore=
(deps): update github actions<br>- chore(deps): update vcpkg digest to eeb0=
0f1<br><br>Change-Id: I637cc37f82d96a7d15738cc39523664777714e97<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnob=
yt &lt;yura.uddr@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/=
openvpn/+/1455<br>Message-Id: &lt;20260107173402.5614-1-gert@...1296...&gt;=
<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg35175.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<=
br>M .github/workflows/build.yaml<br>M .github/workflows/coverity-scan.yml<=
br>M .github/workflows/doxygen.yml<br>3 files changed, 31 insertions(+), 31=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 11c2d65..d1322c7 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -14,12 +14,12 @@</span><br><span>           sudo apt upda=
te &amp;&amp; sudo apt install -y python3-pip</span><br><span>           pi=
p3 install pre-commit</span><br><span>       - name: Checkout OpenVPN</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/check=
out@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uses: actions/checkout@...2977... # v6.0.1</span><br><span>    =
   - name: Run clang-format</span><br><span>         run: pre-commit run -a=
 --show-diff-on-failure || true</span><br><span>       - name: Check for ch=
anges</span><br><span>         run: git diff --output=3Dformat-changes.patc=
h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: action=
s/upload-artifact@...2956... # v5.0.0</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      - uses: actions/upload-artifact@...2978... # v6.0.0=
</span><br><span>         with:</span><br><span>           name: format-cha=
nges.patch</span><br><span>           path: format-changes.patch</span><br>=
<span>@@ -44,12 +44,12 @@</span><br><span>       VCPKG_INSTALLED_DIR: ${{ g=
ithub.workspace }}/vcpkg/installed</span><br><span>     steps:</span><br><s=
pan>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        uses: actions/checkout@...2955... # v5.0.1</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...1186...=
.2957... # v4.1.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      uses: actions/checkout@...2977... # v6.0.1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2979... # v4.=
2.1</span><br><span>       - name: Install vcpkg</span><br><span>         u=
ses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId=
: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee=
93eec77921b3146e</span><br><span>       - name: Install dependencies</span>=
<br><span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</spa=
n><br><span>       - name: configure OpenVPN with cmake</span><br><span>@@ =
-78,13 +78,13 @@</span><br><span>       - name: Install dependencies</span>=
<br><span>         run: sudo apt update &amp;&amp; sudo apt install -y ming=
w-w64 unzip build-essential wget python3-docutils man2html-base</span><br><=
span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        uses: actions/checkout@...2955... # v5.0.1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkou=
t@...2977... # v6.0.1</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2957... # v4.1.2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cma=
ke@...2979... # v4.2.1</span><br><span>       - name: Restore from cache an=
d install vcpkg</span><br><span>         uses: lukka/run-vcpkg@...2815... #=
 v11.5</span><br><span>         with:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6a=
d769d46d4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e</span><br><span>=
           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </=
span><br><span>       - name: Run CMake with vcpkg.json manifest</span><br>=
<span>@@ -94,7 +94,7 @@</span><br><span>           buildPreset: mingw-${{ m=
atrix.arch }}</span><br><span>           buildPresetAdditionalArgs: &quot;[=
&#39;--config ${{ matrix.build }}&#39;]&quot;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-arti=
fact@...2956... # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      - uses: actions/upload-artifact@...2978... # v6.0.0</span><br><s=
pan>         with:</span><br><span>           name: openvpn-mingw-${{ matri=
x.arch }}-${{ matrix.build }}</span><br><span>           path: |</span><br>=
<span>@@ -102,7 +102,7 @@</span><br><span>             ${{ github.workspace=
 }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.dll</span><=
br><span>             !${{ github.workspace }}/out/build/mingw/${{ matrix.a=
rch }}/${{ matrix.build }}/test_*.exe</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...493...=
2956... # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   - uses: actions/upload-artifact@...2978... # v6.0.0</span><br><span>    =
     with:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }=
}-${{ matrix.build }}-tests</span><br><span>           path: |</span><br><s=
pan>@@ -122,9 +122,9 @@</span><br><span>     name: &quot;mingw unittest ${{=
 matrix.test }} - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL&quot;</sp=
an><br><span>     steps:</span><br><span>       - name: Checkout OpenVPN</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/ch=
eckout@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/checkout@...2977... # v6.0.1</span><br><span> =
      - name: Retrieve mingw unittest</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/download-artifact@...2958... # v6.0.0=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/download-artifact@...2980... # v7.0.0</span><br><span>         with:</sp=
an><br><span>           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.b=
uild }}-tests</span><br><span>           path: unittests</span><br><span>@@=
 -161,7 +161,7 @@</span><br><span>       - name: Install dependencies</span=
><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y lib=
lzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-=
dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSL=
PKG} ${PKCS11PKG}</span><br><span>       - name: Checkout OpenVPN</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@=
...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/checkout@...2977... # v6.0.1</span><br><span>       -=
 name: autoconf</span><br><span>         run: autoreconf -fvi</span><br><sp=
an>       - name: configure</span><br><span>@@ -191,7 +191,7 @@</span><br><=
span>       - name: Install dependencies</span><br><span>         run: sudo=
 apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-=
dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-=
dev python3-docutils libtool automake autoconf</span><br><span>       - nam=
e: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2977... # v6=
.0.1</span><br><span>       - name: autoconf</span><br><span>         run: =
autoreconf -fvi</span><br><span>       - name: configure</span><br><span>@@=
 -231,7 +231,7 @@</span><br><span>       - name: Install dependencies</span=
><br><span>         run: brew install ${{matrix.ssllib}} lzo lz4 man2html c=
mocka libtool automake autoconf</span><br><span>       - name: Checkout Ope=
nVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: act=
ions/checkout@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        uses: actions/checkout@...2977... # v6.0.1</span><br>=
<span>       - name: Set environment</span><br><span>         run: |</span>=
<br><span>           cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@=
@ -263,8 +263,8 @@</span><br><span> </span><br><span>       runs-on: window=
s-2025</span><br><span>       steps:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - uses: actions/checkout@...2955... # v5.0.1</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...220...=
..2957... # v4.1.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     - uses: actions/checkout@...2977... # v6.0.1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2979... # v4=
.2.1</span><br><span> </span><br><span>       - name: Install rst2html</spa=
n><br><span>         run: python -m pip install --upgrade pip docutils</spa=
n><br><span>@@ -272,7 +272,7 @@</span><br><span>       - name: Restore arti=
facts, or setup vcpkg (do not install any package)</span><br><span>        =
 uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommit=
Id: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1=
ee93eec77921b3146e</span><br><span>           vcpkgJsonGlob: &#39;**/window=
s/vcpkg.json&#39;</span><br><span> </span><br><span>       - name: Run CMak=
e with vcpkg.json manifest (NO TESTS)</span><br><span>@@ -291,7 +291,7 @@</=
span><br><span>           testPreset: win-${{ matrix.arch }}-release</span>=
<br><span>           testPresetAdditionalArgs: &quot;[&#39;--output-on-fail=
ure&#39;]&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      - uses: actions/upload-artifact@...2956... # v5.0.0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upl=
oad-artifact@...2978... # v6.0.0</span><br><span>         with:</span><br><=
span>           name: openvpn-msvc-${{ matrix.arch }}</span><br><span>     =
      path: |</span><br><span>@@ -331,7 +331,7 @@</span><br><span>       - =
name: Install dependencies</span><br><span>         run: sudo apt update &a=
mp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc=
-dev man2html clang libcmocka-dev python3-docutils libtool automake autocon=
f pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: =
&quot;libressl: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uses: actions/checkout@...2955... # v5.0.1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...1665...=
977... # v6.0.1</span><br><span>         with:</span><br><span>           p=
ath: libressl</span><br><span>           # versioning=3Dsemver-coerced</spa=
n><br><span>@@ -354,7 +354,7 @@</span><br><span>       - name: &quot;ldconf=
ig&quot;</span><br><span>         run: sudo ldconfig</span><br><span>      =
 - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uses: actions/checkout@...2955... # v5.0.1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2983...=
. # v6.0.1</span><br><span>       - name: autoconf</span><br><span>        =
 run: autoreconf -fvi</span><br><span>       - name: configure</span><br><s=
pan>@@ -395,7 +395,7 @@</span><br><span>       - name: Install dependencies=
</span><br><span>         run: sudo apt update &amp;&amp; sudo apt install =
-y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmo=
cka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake=
 autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span>       =
- name: &quot;mbedtls: checkout&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/checkout@...2955... # v5.0.1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checko=
ut@...2977... # v6.0.1</span><br><span>         with:</span><br><span>     =
      path: mbedtls</span><br><span>           submodules: true</span><br><=
span>@@ -409,7 +409,7 @@</span><br><span>         run: sudo make install DE=
STDIR=3D/usr</span><br><span>         working-directory: mbedtls</span><br>=
<span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/checkout@...2955... # v5.0.1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checko=
ut@...2977... # v6.0.1</span><br><span>       - name: autoconf</span><br><s=
pan>         run: autoreconf -fvi</span><br><span>       - name: configure<=
/span><br><span>@@ -454,13 +454,13 @@</span><br><span>       - name: Instal=
l dependencies</span><br><span>         run: sudo apt update &amp;&amp; sud=
o apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-=
libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 pytho=
n3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl=
-3-dev</span><br><span>       - name: &quot;AWS-LC: checkout&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout=
@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        uses: actions/checkout@...2977... # v6.0.1</span><br><span>       =
  with:</span><br><span>           path: aws-lc</span><br><span>           =
# versioning=3Dsemver-coerced</span><br><span>           repository: aws/aw=
s-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v1=
.64.0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lu=
kka/get-cmake@...2957... # v4.1.2</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+          ref: v1.66.2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      - uses: lukka/get-cmake@...2979... # v4.2.1</span><b=
r><span>       - name: &quot;AWS-LC: build&quot;</span><br><span>         r=
un: |</span><br><span>           mkdir build</span><br><span>@@ -469,7 +469=
,7 @@</span><br><span>           ninja install</span><br><span>         wor=
king-directory: aws-lc</span><br><span>       - name: Checkout OpenVPN</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/chec=
kout@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        uses: actions/checkout@...2977... # v6.0.1</span><br><span>   =
    - name: autoconf</span><br><span>         run: autoreconf -fvi</span><b=
r><span>       - name: configure with AWS-LC</span><br><span>diff --git a/.=
github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml</s=
pan><br><span>index fa18115..f329482 100644</span><br><span>--- a/.github/w=
orkflows/coverity-scan.yml</span><br><span>+++ b/.github/workflows/coverity=
-scan.yml</span><br><span>@@ -13,7 +13,7 @@</span><br><span>     steps:</sp=
an><br><span>       - name: Check submission cache</span><br><span>        =
 id: check_submit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    uses: actions/cache/restore@...2959... # v4.3.0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/restore@...2924...=
81... # v5.0.1</span><br><span>         with:</span><br><span>           pa=
th: |</span><br><span>             cov-int</span><br><span>@@ -25,7 +25,7 @=
@</span><br><span> </span><br><span>       - name: Checkout OpenVPN</span><=
br><span>         if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#=
39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: acti=
ons/checkout@...2955... # v5.0.1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uses: actions/checkout@...2977... # v6.0.1</span><br><=
span> </span><br><span>       - name: Download Coverity Build Tool</span><b=
r><span>         if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#3=
9;</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </span><br><span>    =
   - name: Cache submission</span><br><span>         if: steps.check_submit=
.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        uses: actions/cache/save@...2959... # v4.3.0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cac=
he/save@...2981... # v5.0.1</span><br><span>         with:</span><br><span>=
           path: |</span><br><span>             cov-int</span><br><span>dif=
f --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml</sp=
an><br><span>index 0828dd0..b510dc8 100644</span><br><span>--- a/.github/wo=
rkflows/doxygen.yml</span><br><span>+++ b/.github/workflows/doxygen.yml</sp=
an><br><span>@@ -11,7 +11,7 @@</span><br><span>     runs-on: ubuntu-24.04</=
span><br><span>     if: ${{ github.repository_owner =3D=3D &#39;openvpn&#39=
; || github.event_name =3D=3D &#39;workflow_dispatch&#39; }}</span><br><spa=
n>     steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - =
uses: actions/checkout@...2955... # v5.0.1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      - uses: actions/checkout@...2977... # v6.0.1</=
span><br><span>         with:</span><br><span>           path: openvpn</spa=
n><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1455?usp=3Demail">change 1455</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1455?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--vmgyrLXVIA8=--

