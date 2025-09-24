From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 12:42:37 +0000
References: <gerrit.1758717755000.I6725b55c9e7bf5410bde09659131590d40bfee4d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5cc00b6e369684a8600e58f5e83609305a274b77-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s6Wvl0Mzrc0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Dependency
 updates September 2025
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

--s6Wvl0Mzrc0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1211?usp=3Demail

to review the following change.


Change subject: GHA: Dependency updates September 2025
......................................................................

GHA: Dependency updates September 2025

chore(deps): update dependency aws/aws-lc to v1.61.3
chore(deps): update vcpkg digest to 9c5c2a0
chore(deps): update github actions

Change-Id: I6725b55c9e7bf5410bde09659131590d40bfee4d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
M .github/workflows/doxygen.yml
3 files changed, 28 insertions(+), 28 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1211/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index a306670..1cef154 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -14,7 +14,7 @@
           sudo apt update && sudo apt install -y python3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
       - name: Run clang-format
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
@@ -44,12 +44,12 @@
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2897... # v4.0.3
+        uses: actions/checkout@...2926... # v5.0.0
+      - uses: lukka/get-cmake@...2927... # v4.1.1
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
+          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -77,13 +77,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-=
essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0

-      - uses: lukka/get-cmake@...2897... # v4.0.3
+      - uses: lukka/get-cmake@...2927... # v4.1.1
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
+          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -120,9 +120,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2894... # v4.3.0
+        uses: actions/download-artifact@...2928... # v5.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -164,7 +164,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -194,7 +194,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang =
libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -234,7 +234,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libto=
ol automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -266,8 +266,8 @@

       runs-on: windows-2025
       steps:
-      - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2897... # v4.0.3
+      - uses: actions/checkout@...2926... # v5.0.0
+      - uses: lukka/get-cmake@...2927... # v4.1.1

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -275,7 +275,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
+          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -334,7 +334,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
         with:
           path: libressl
           # versioning=3Dsemver-coerced
@@ -357,7 +357,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -398,7 +398,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
         with:
           path: mbedtls
           submodules: true
@@ -412,7 +412,7 @@
         run: sudo make install DESTDIR=3D/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
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
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
         with:
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.55.0
-      - uses: lukka/get-cmake@...2897... # v4.0.3
+          ref: v1.61.3
+      - uses: lukka/get-cmake@...2927... # v4.1.1
       - name: "AWS-LC: build"
         run: |
           mkdir build
@@ -472,7 +472,7 @@
           ninja install
         working-directory: aws-lc
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0
       - name: autoconf
         run: autoreconf -fvi
       - name: configure with AWS-LC
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index 222c57e..e90aa2e 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2871... # v4.2.3
+        uses: actions/cache/restore@...2929... # v4.2.4
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@

       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2844... # v4.2.2
+        uses: actions/checkout@...2926... # v5.0.0

       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2871... # v4.2.3
+        uses: actions/cache/save@...2929... # v4.2.4
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index 751258a..eaa7e4c 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -11,7 +11,7 @@
     runs-on: ubuntu-24.04
     if: ${{ github.repository_owner =3D=3D 'openvpn' || github.event_name =
=3D=3D 'workflow_dispatch' }}
     steps:
-      - uses: actions/checkout@...2844... # v4.2.2
+      - uses: actions/checkout@...2926... # v5.0.0
         with:
           path: openvpn

@@ -35,7 +35,7 @@
           touch doc/doxygen/html/.nojekyll
       - name: Upload static files as artifact
         id: deployment
-        uses: actions/upload-pages-artifact@...2872... # v3.0.1
+        uses: actions/upload-pages-artifact@...2930... # v4.0.0
         with:
           path: doxygen/doc/doxygen/html/
=20

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1211?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6725b55c9e7bf5410bde09659131590d40bfee4d
Gerrit-Change-Number: 1211
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--s6Wvl0Mzrc0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1211?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">GHA: Dependency updates September 2025<br><br>chore(deps): u=
pdate dependency aws/aws-lc to v1.61.3<br>chore(deps): update vcpkg digest =
to 9c5c2a0<br>chore(deps): update github actions<br><br>Change-Id: I6725b55=
c9e7bf5410bde09659131590d40bfee4d<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>M .github/w=
orkflows/coverity-scan.yml<br>M .github/workflows/doxygen.yml<br>3 files ch=
anged, 28 insertions(+), 28 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/11/1211/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github=
/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index =
a306670..1cef154 100644</span><br><span>--- a/.github/workflows/build.yaml<=
/span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -14,7=
 +14,7 @@</span><br><span>           sudo apt update &amp;&amp; sudo apt in=
stall -y python3-pip</span><br><span>           pip3 install pre-commit</sp=
an><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844... # v4.2.2</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/checkout@...2926... # v5.0.0</span><br><span>       - name: Run clang-form=
at</span><br><span>         run: pre-commit run -a --show-diff-on-failure |=
| true</span><br><span>       - name: Check for changes</span><br><span>@@ =
-44,12 +44,12 @@</span><br><span>       VCPKG_INSTALLED_DIR: ${{ github.wor=
kspace }}/vcpkg/installed</span><br><span>     steps:</span><br><span>     =
  - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uses: actions/checkout@...2844... # v4.2.2</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2897... =
# v4.0.3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        use=
s: actions/checkout@...2926... # v5.0.0</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2927... # v4.1.1</span=
><br><span>       - name: Install vcpkg</span><br><span>         uses: lukk=
a/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: f33cc49=
1c85a7d643c5ab6da1667c1458e6d7abf</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6=
f7ddeee</span><br><span>       - name: Install dependencies</span><br><span=
>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><br><sp=
an>       - name: configure OpenVPN with cmake</span><br><span>@@ -77,13 +7=
7,13 @@</span><br><span>       - name: Install dependencies</span><br><span=
>         run: sudo apt update &amp;&amp; sudo apt install -y mingw-w64 unz=
ip build-essential wget python3-docutils man2html-base</span><br><span>    =
   - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uses: actions/checkout@...2844... # v4.2.2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2931...=
... # v5.0.0</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      - uses: lukka/get-cmake@...2897... # v4.0.3</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2932...=
7... # v4.1.1</span><br><span>       - name: Restore from cache and install=
 vcpkg</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</s=
pan><br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitC=
ommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee</span><br><span>         =
  vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br>=
<span>       - name: Run CMake with vcpkg.json manifest</span><br><span>@@ =
-120,9 +120,9 @@</span><br><span>     name: &quot;mingw unittest ${{ matrix=
.test }} - ${{ matrix.arch }} - OSSL&quot;</span><br><span>     steps:</spa=
n><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844... # v4.2.2</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/=
checkout@...2926... # v5.0.0</span><br><span>       - name: Retrieve mingw =
unittest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses:=
 actions/download-artifact@...2894... # v4.3.0</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uses: actions/download-artifact@...2933...=
.. # v5.0.0</span><br><span>         with:</span><br><span>           name:=
 openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>           path: un=
ittests</span><br><span>@@ -164,7 +164,7 @@</span><br><span>       - name: =
Install dependencies</span><br><span>         run: sudo apt update &amp;&am=
p; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev li=
bnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libto=
ol automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>       - name: =
Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2926... # v5.0.=
0</span><br><span>       - name: autoconf</span><br><span>         run: aut=
oreconf -fvi</span><br><span>       - name: configure</span><br><span>@@ -1=
94,7 +194,7 @@</span><br><span>       - name: Install dependencies</span><b=
r><span>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo=
2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev=
 man2html clang libcmocka-dev python3-docutils libtool automake autoconf li=
bmbedtls-dev</span><br><span>       - name: Checkout OpenVPN</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2825...=
44... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uses: actions/checkout@...2926... # v5.0.0</span><br><span>       - name=
: autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>  =
     - name: configure</span><br><span>@@ -234,7 +234,7 @@</span><br><span>=
       - name: Install dependencies</span><br><span>         run: brew inst=
all ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf</s=
pan><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844... # v4.2.2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: action=
s/checkout@...2926... # v5.0.0</span><br><span>       - name: Set environme=
nt</span><br><span>         run: |</span><br><span>           cat &gt;&gt;$=
GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -266,8 +266,8 @@</span><br><span=
> </span><br><span>       runs-on: windows-2025</span><br><span>       step=
s:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actio=
ns/checkout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      - uses: lukka/get-cmake@...2897... # v4.0.3</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@...1665...=
926... # v5.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  - uses: lukka/get-cmake@...2927... # v4.1.1</span><br><span> </span><br><=
span>       - name: Install rst2html</span><br><span>         run: python -=
m pip install --upgrade pip docutils</span><br><span>@@ -275,7 +275,7 @@</s=
pan><br><span>       - name: Restore artifacts, or setup vcpkg (do not inst=
all any package)</span><br><span>         uses: lukka/run-vcpkg@...2815... =
# v11.5</span><br><span>         with:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1=
458e6d7abf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
 vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee</span><br><span=
>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span>=
 </span><br><span>       - name: Run CMake with vcpkg.json manifest (NO TES=
TS)</span><br><span>@@ -334,7 +334,7 @@</span><br><span>       - name: Inst=
all dependencies</span><br><span>         run: sudo apt update &amp;&amp; s=
udo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2h=
tml clang libcmocka-dev python3-docutils libtool automake autoconf pkg-conf=
ig libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;libr=
essl: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2926... # v=
5.0.0</span><br><span>         with:</span><br><span>           path: libre=
ssl</span><br><span>           # versioning=3Dsemver-coerced</span><br><spa=
n>@@ -357,7 +357,7 @@</span><br><span>       - name: &quot;ldconfig&quot;</=
span><br><span>         run: sudo ldconfig</span><br><span>       - name: C=
heckout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2926... # v5.0.0=
</span><br><span>       - name: autoconf</span><br><span>         run: auto=
reconf -fvi</span><br><span>       - name: configure</span><br><span>@@ -39=
8,7 +398,7 @@</span><br><span>       - name: Install dependencies</span><br=
><span>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2=
-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev py=
thon3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf =
pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &q=
uot;mbedtls: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uses: actions/checkout@...2844... # v4.2.2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2931...=
... # v5.0.0</span><br><span>         with:</span><br><span>           path=
: mbedtls</span><br><span>           submodules: true</span><br><span>@@ -4=
12,7 +412,7 @@</span><br><span>         run: sudo make install DESTDIR=3D/u=
sr</span><br><span>         working-directory: mbedtls</span><br><span>    =
   - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uses: actions/checkout@...2844... # v4.2.2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2931...=
... # v5.0.0</span><br><span>       - name: autoconf</span><br><span>      =
   run: autoreconf -fvi</span><br><span>       - name: configure</span><br>=
<span>@@ -457,13 +457,13 @@</span><br><span>       - name: Install dependen=
cies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt inst=
all -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev m=
an2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonsch=
ema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</sp=
an><br><span>       - name: &quot;AWS-LC: checkout&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2934...=
. # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
ses: actions/checkout@...2926... # v5.0.0</span><br><span>         with:</s=
pan><br><span>           path: aws-lc</span><br><span>           # versioni=
ng=3Dsemver-coerced</span><br><span>           repository: aws/aws-lc</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v1.55.0</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cm=
ake@...2897... # v4.0.3</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+          ref: v1.61.3</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      - uses: lukka/get-cmake@...2927... # v4.1.1</span><br><span>  =
     - name: &quot;AWS-LC: build&quot;</span><br><span>         run: |</spa=
n><br><span>           mkdir build</span><br><span>@@ -472,7 +472,7 @@</spa=
n><br><span>           ninja install</span><br><span>         working-direc=
tory: aws-lc</span><br><span>       - name: Checkout OpenVPN</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2825...=
44... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uses: actions/checkout@...2926... # v5.0.0</span><br><span>       - name=
: autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>  =
     - name: configure with AWS-LC</span><br><span>diff --git a/.github/wor=
kflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml</span><br><s=
pan>index 222c57e..e90aa2e 100644</span><br><span>--- a/.github/workflows/c=
overity-scan.yml</span><br><span>+++ b/.github/workflows/coverity-scan.yml<=
/span><br><span>@@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><sp=
an>       - name: Check submission cache</span><br><span>         id: check=
_submit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: =
actions/cache/restore@...2871... # v4.2.3</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        uses: actions/cache/restore@...2929... # v4.2=
.4</span><br><span>         with:</span><br><span>           path: |</span>=
<br><span>             cov-int</span><br><span>@@ -25,7 +25,7 @@</span><br>=
<span> </span><br><span>       - name: Checkout OpenVPN</span><br><span>   =
      if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout=
@...2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        uses: actions/checkout@...2926... # v5.0.0</span><br><span> </span=
><br><span>       - name: Download Coverity Build Tool</span><br><span>    =
     if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br=
><span>@@ -65,7 +65,7 @@</span><br><span> </span><br><span>       - name: C=
ache submission</span><br><span>         if: steps.check_submit.outputs.cac=
he-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uses: actions/cache/save@...2871... # v4.2.3</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/save@...1665...=
929... # v4.2.4</span><br><span>         with:</span><br><span>           p=
ath: |</span><br><span>             cov-int</span><br><span>diff --git a/.g=
ithub/workflows/doxygen.yml b/.github/workflows/doxygen.yml</span><br><span=
>index 751258a..eaa7e4c 100644</span><br><span>--- a/.github/workflows/doxy=
gen.yml</span><br><span>+++ b/.github/workflows/doxygen.yml</span><br><span=
>@@ -11,7 +11,7 @@</span><br><span>     runs-on: ubuntu-24.04</span><br><sp=
an>     if: ${{ github.repository_owner =3D=3D &#39;openvpn&#39; || github.=
event_name =3D=3D &#39;workflow_dispatch&#39; }}</span><br><span>     steps=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: action=
s/checkout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      - uses: actions/checkout@...2926... # v5.0.0</span><br><sp=
an>         with:</span><br><span>           path: openvpn</span><br><span>=
 </span><br><span>@@ -35,7 +35,7 @@</span><br><span>           touch doc/do=
xygen/html/.nojekyll</span><br><span>       - name: Upload static files as =
artifact</span><br><span>         id: deployment</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uses: actions/upload-pages-artifact@...1665...=
872... # v3.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uses: actions/upload-pages-artifact@...2930... # v4.0.0</span><br><span=
>         with:</span><br><span>           path: doxygen/doc/doxygen/html/<=
/span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1211?usp=3Demail">change 1211</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1211?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6725b55c9e7bf5410bde0965913=
1590d40bfee4d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1211 </div>
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


--s6Wvl0Mzrc0=--

