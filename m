From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 26 Sep 2025 17:02:25 +0000
In-Reply-To: <gerrit.1758717755000.I6725b55c9e7bf5410bde09659131590d40bfee4d@...2715...>
References: <gerrit.1758717755000.I6725b55c9e7bf5410bde09659131590d40bfee4d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a173c72139d11cabd1b6c8c911485eb6a3192189-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NTQ6IenXtNs="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NTQ6IenXtNs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1211?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


Change subject: GHA: Dependency updates September 2025
......................................................................

GHA: Dependency updates September 2025

chore(deps): update dependency aws/aws-lc to v1.61.3
chore(deps): update vcpkg digest to 9c5c2a0
chore(deps): update github actions

Change-Id: I6725b55c9e7bf5410bde09659131590d40bfee4d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1211
Message-Id: <20250926115415.158817-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
220.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
M .github/workflows/doxygen.yml
3 files changed, 28 insertions(+), 28 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1211/2

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


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1211?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6725b55c9e7bf5410bde09659131590d40bfee4d
Gerrit-Change-Number: 1211
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--NTQ6IenXtNs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1211?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by uddr</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">GHA: Dependency updates September 2025<br><br>chore(d=
eps): update dependency aws/aws-lc to v1.61.3<br>chore(deps): update vcpkg =
digest to 9c5c2a0<br>chore(deps): update github actions<br><br>Change-Id: I=
6725b55c9e7bf5410bde09659131590d40bfee4d<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...1482...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1211<br>Messa=
ge-Id: &lt;20250926115415.158817-1-frank@...2641...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33220.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflo=
ws/build.yaml<br>M .github/workflows/coverity-scan.yml<br>M .github/workflo=
ws/doxygen.yml<br>3 files changed, 28 insertions(+), 28 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1211/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/build=
.yaml</span><br><span>index a306670..1cef154 100644</span><br><span>--- a/.=
github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.y=
aml</span><br><span>@@ -14,7 +14,7 @@</span><br><span>           sudo apt u=
pdate &amp;&amp; sudo apt install -y python3-pip</span><br><span>          =
 pip3 install pre-commit</span><br><span>       - name: Checkout OpenVPN</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/ch=
eckout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/checkout@...2926... # v5.0.0</span><br><span> =
      - name: Run clang-format</span><br><span>         run: pre-commit run=
 -a --show-diff-on-failure || true</span><br><span>       - name: Check for=
 changes</span><br><span>@@ -44,12 +44,12 @@</span><br><span>       VCPKG_I=
NSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed</span><br><span>     =
steps:</span><br><span>       - name: Checkout OpenVPN</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844... =
# v4.2.2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses:=
 lukka/get-cmake@...2897... # v4.0.3</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        uses: actions/checkout@...2926... # v5.0.0</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cma=
ke@...2927... # v4.1.1</span><br><span>       - name: Install vcpkg</span><=
br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>=
         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
   vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 9c5c2=
a0ab75aff5bcd08142525f6ff7f6f7ddeee</span><br><span>       - name: Install =
dependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg install open=
ssl lz4 cmocka</span><br><span>       - name: configure OpenVPN with cmake<=
/span><br><span>@@ -77,13 +77,13 @@</span><br><span>       - name: Install =
dependencies</span><br><span>         run: sudo apt update &amp;&amp; sudo =
apt install -y mingw-w64 unzip build-essential wget python3-docutils man2ht=
ml-base</span><br><span>       - name: Checkout OpenVPN</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844...=
 # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@...2926... # v5.0.0</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2898...=
.. # v4.0.3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
uses: lukka/get-cmake@...2927... # v4.1.1</span><br><span>       - name: Re=
store from cache and install vcpkg</span><br><span>         uses: lukka/run=
-vcpkg@...2815... # v11.5</span><br><span>         with:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: f33cc491c85a=
7d643c5ab6da1667c1458e6d7abf</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7dde=
ee</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;<=
/span><br><span> </span><br><span>       - name: Run CMake with vcpkg.json =
manifest</span><br><span>@@ -120,9 +120,9 @@</span><br><span>     name: &qu=
ot;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</spa=
n><br><span>     steps:</span><br><span>       - name: Checkout OpenVPN</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/che=
ckout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uses: actions/checkout@...2926... # v5.0.0</span><br><span>  =
     - name: Retrieve mingw unittest</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        uses: actions/download-artifact@...2894... # v4.3.0<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: action=
s/download-artifact@...2928... # v5.0.0</span><br><span>         with:</spa=
n><br><span>           name: openvpn-mingw-${{ matrix.arch }}-tests</span><=
br><span>           path: unittests</span><br><span>@@ -164,7 +164,7 @@</sp=
an><br><span>       - name: Install dependencies</span><br><span>         r=
un: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev=
 liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmock=
a-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</sp=
an><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844... # v4.2.2</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/checkout@...2926... # v5.0.0</span><br><span>       - name: autoconf</span=
><br><span>         run: autoreconf -fvi</span><br><span>       - name: con=
figure</span><br><span>@@ -194,7 +194,7 @@</span><br><span>       - name: I=
nstall dependencies</span><br><span>         run: sudo apt update &amp;&amp=
; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev lib=
nl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf libmbedtls-dev</span><br><span>       - name: Che=
ckout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uses: actions/checkout@...2926... # v5.0.0</=
span><br><span>       - name: autoconf</span><br><span>         run: autore=
conf -fvi</span><br><span>       - name: configure</span><br><span>@@ -234,=
7 +234,7 @@</span><br><span>       - name: Install dependencies</span><br><=
span>         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka =
libtool automake autoconf</span><br><span>       - name: Checkout OpenVPN</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/c=
heckout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: actions/checkout@...2926... # v5.0.0</span><br><span>=
       - name: Set environment</span><br><span>         run: |</span><br><s=
pan>           cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -266=
,8 +266,8 @@</span><br><span> </span><br><span>       runs-on: windows-2025=
</span><br><span>       steps:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      - uses: actions/checkout@...2844... # v4.2.2</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2938...=
... # v4.0.3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      -=
 uses: actions/checkout@...2926... # v5.0.0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2927... # v4.1.1</=
span><br><span> </span><br><span>       - name: Install rst2html</span><br>=
<span>         run: python -m pip install --upgrade pip docutils</span><br>=
<span>@@ -275,7 +275,7 @@</span><br><span>       - name: Restore artifacts,=
 or setup vcpkg (do not install any package)</span><br><span>         uses:=
 lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: f3=
3cc491c85a7d643c5ab6da1667c1458e6d7abf</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6=
ff7f6f7ddeee</span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpk=
g.json&#39;</span><br><span> </span><br><span>       - name: Run CMake with=
 vcpkg.json manifest (NO TESTS)</span><br><span>@@ -334,7 +334,7 @@</span><=
br><span>       - name: Install dependencies</span><br><span>         run: =
sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev lib=
lz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtoo=
l automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><sp=
an>       - name: &quot;libressl: checkout&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844... # v4.2=
.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: act=
ions/checkout@...2926... # v5.0.0</span><br><span>         with:</span><br>=
<span>           path: libressl</span><br><span>           # versioning=3Ds=
emver-coerced</span><br><span>@@ -357,7 +357,7 @@</span><br><span>       - =
name: &quot;ldconfig&quot;</span><br><span>         run: sudo ldconfig</spa=
n><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844... # v4.2.2</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/=
checkout@...2926... # v5.0.0</span><br><span>       - name: autoconf</span>=
<br><span>         run: autoreconf -fvi</span><br><span>       - name: conf=
igure</span><br><span>@@ -398,7 +398,7 @@</span><br><span>       - name: In=
stall dependencies</span><br><span>         run: sudo apt update &amp;&amp;=
 sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man=
2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschem=
a libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span=
><br><span>       - name: &quot;mbedtls: checkout&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844...=
 # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@...2926... # v5.0.0</span><br><span>         with:</sp=
an><br><span>           path: mbedtls</span><br><span>           submodules=
: true</span><br><span>@@ -412,7 +412,7 @@</span><br><span>         run: su=
do make install DESTDIR=3D/usr</span><br><span>         working-directory: =
mbedtls</span><br><span>       - name: Checkout OpenVPN</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2844...=
 # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@...2926... # v5.0.0</span><br><span>       - name: aut=
oconf</span><br><span>         run: autoreconf -fvi</span><br><span>       =
- name: configure</span><br><span>@@ -457,13 +457,13 @@</span><br><span>   =
    - name: Install dependencies</span><br><span>         run: sudo apt upd=
ate &amp;&amp; sudo apt install -y gcc golang make liblzo2-dev libpam0g-dev=
 liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils py=
thon3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap=
-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;AWS-LC: check=
out&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses=
: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        uses: actions/checkout@...2926... # v5.0.0</span=
><br><span>         with:</span><br><span>           path: aws-lc</span><br=
><span>           # versioning=3Dsemver-coerced</span><br><span>           =
repository: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-          ref: v1.55.0</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-      - uses: lukka/get-cmake@...2897... # v4.0.3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          ref: v1.61.3</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2939...=
.. # v4.1.1</span><br><span>       - name: &quot;AWS-LC: build&quot;</span>=
<br><span>         run: |</span><br><span>           mkdir build</span><br>=
<span>@@ -472,7 +472,7 @@</span><br><span>           ninja install</span><b=
r><span>         working-directory: aws-lc</span><br><span>       - name: C=
heckout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2926... # v5.0.0=
</span><br><span>       - name: autoconf</span><br><span>         run: auto=
reconf -fvi</span><br><span>       - name: configure with AWS-LC</span><br>=
<span>diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/=
coverity-scan.yml</span><br><span>index 222c57e..e90aa2e 100644</span><br><=
span>--- a/.github/workflows/coverity-scan.yml</span><br><span>+++ b/.githu=
b/workflows/coverity-scan.yml</span><br><span>@@ -13,7 +13,7 @@</span><br><=
span>     steps:</span><br><span>       - name: Check submission cache</spa=
n><br><span>         id: check_submit</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/cache/restore@...2871... # v4.2.3</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/c=
ache/restore@...2929... # v4.2.4</span><br><span>         with:</span><br><=
span>           path: |</span><br><span>             cov-int</span><br><spa=
n>@@ -25,7 +25,7 @@</span><br><span> </span><br><span>       - name: Checko=
ut OpenVPN</span><br><span>         if: steps.check_submit.outputs.cache-hi=
t !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2926... # =
v5.0.0</span><br><span> </span><br><span>       - name: Download Coverity B=
uild Tool</span><br><span>         if: steps.check_submit.outputs.cache-hit=
 !=3D &#39;true&#39;</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </s=
pan><br><span>       - name: Cache submission</span><br><span>         if: =
steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/save@...2940...=
... # v4.2.3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/cache/save@...2929... # v4.2.4</span><br><span>         with=
:</span><br><span>           path: |</span><br><span>             cov-int</=
span><br><span>diff --git a/.github/workflows/doxygen.yml b/.github/workflo=
ws/doxygen.yml</span><br><span>index 751258a..eaa7e4c 100644</span><br><spa=
n>--- a/.github/workflows/doxygen.yml</span><br><span>+++ b/.github/workflo=
ws/doxygen.yml</span><br><span>@@ -11,7 +11,7 @@</span><br><span>     runs-=
on: ubuntu-24.04</span><br><span>     if: ${{ github.repository_owner =3D=
=3D &#39;openvpn&#39; || github.event_name =3D=3D &#39;workflow_dispatch&#3=
9; }}</span><br><span>     steps:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      - uses: actions/checkout@...2844... # v4.2.2</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@...220...=
..2926... # v5.0.0</span><br><span>         with:</span><br><span>         =
  path: openvpn</span><br><span> </span><br><span>@@ -35,7 +35,7 @@</span><=
br><span>           touch doc/doxygen/html/.nojekyll</span><br><span>      =
 - name: Upload static files as artifact</span><br><span>         id: deplo=
yment</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: ac=
tions/upload-pages-artifact@...2872... # v3.0.1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/upload-pages-artifact@...493...=
2930... # v4.0.0</span><br><span>         with:</span><br><span>           =
path: doxygen/doc/doxygen/html/</span><br><span> </span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1211?usp=3Demail">change 1211</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1211?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6725b55c9e7bf5410bde0965913=
1590d40bfee4d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1211 </div>
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


--NTQ6IenXtNs=--

