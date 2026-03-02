From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 2 Mar 2026 21:46:56 +0000
In-Reply-To: <gerrit.1771348259000.I4536e06b082ae17baba1490246244b5923063c93@...2715...>
References: <gerrit.1771348259000.I4536e06b082ae17baba1490246244b5923063c93@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <16e3c42a9f5e17a7f6aa01ddcbcc9409eb57fee2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7BeZY1l3gyc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Maintenance
 update February 2026
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

--7BeZY1l3gyc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1540?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: GHA: Maintenance update February 2026
......................................................................

GHA: Maintenance update February 2026

Switch libressl and mbedTLS 4 builds to Ubuntu 24.04.

Includes the following renovate changes:
- chore(deps): update dependency aws/aws-lc to v1.67.0
- chore(deps): update github actions
- chore(deps): update vcpkg digest to e5a1490

Change-Id: I4536e06b082ae17baba1490246244b5923063c93
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1540
Message-Id: <20260302152510.11918-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
813.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
M .github/workflows/doxygen.yml
3 files changed, 29 insertions(+), 29 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1540/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 7d1574c..b213192 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -14,7 +14,7 @@
           sudo apt update && sudo apt install -y python3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: Run clang-format
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
@@ -44,12 +44,12 @@
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
-      - uses: lukka/get-cmake@...2979... # v4.2.1
+        uses: actions/checkout@...2998... # v6.0.2
+      - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
+          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -78,13 +78,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-=
essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2

-      - uses: lukka/get-cmake@...2979... # v4.2.1
+      - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
+          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -122,7 +122,7 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ ma=
trix.build }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@...2980... # v7.0.0
         with:
@@ -163,7 +163,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -193,7 +193,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang =
libcmocka-dev python3-docutils libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -233,7 +233,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libto=
ol automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -265,8 +265,8 @@

       runs-on: windows-2025
       steps:
-      - uses: actions/checkout@...2977... # v6.0.1
-      - uses: lukka/get-cmake@...2979... # v4.2.1
+      - uses: actions/checkout@...2998... # v6.0.2
+      - uses: lukka/get-cmake@...2999... # v4.2.3

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -274,7 +274,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
+          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -307,7 +307,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-22.04]
+        os: [ubuntu-24.04]
         ssllib: [libressl]
         build: [ normal, asan ]
         configureflags: ["--with-openssl-engine=3Dno"]
@@ -333,7 +333,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
         with:
           path: libressl
           # versioning=3Dsemver-coerced
@@ -356,7 +356,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -372,7 +372,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-22.04]
+        os: [ubuntu-24.04]
         ssllib: [mbedtls4]
         build: [ normal, asan ]
         include:
@@ -397,14 +397,14 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
         with:
           path: mbedtls
           submodules: recursive
           # versioning=3Dsemver-coerced
           repository: Mbed-TLS/mbedtls
           ref: v4.0.0
-      - uses: lukka/get-cmake@...2927... # v4.1.1
+      - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "mbedtls: cmake"
         run: cmake -B build
         working-directory: mbedtls
@@ -415,7 +415,7 @@
         run: sudo cmake --install build --prefix /usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -460,13 +460,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y gcc golang make liblzo=
2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev p=
ython3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf=
 pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "AWS-LC: checkout"
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
         with:
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.66.2
-      - uses: lukka/get-cmake@...2979... # v4.2.1
+          ref: v1.67.0
+      - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "AWS-LC: build"
         run: |
           mkdir build
@@ -475,7 +475,7 @@
           ninja install
         working-directory: aws-lc
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure with AWS-LC
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index f329482..5554c4d 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2981... # v5.0.1
+        uses: actions/cache/restore@...3000... # v5.0.3
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@

       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2

       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2981... # v5.0.1
+        uses: actions/cache/save@...3000... # v5.0.3
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index b510dc8..b28dd70 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -11,7 +11,7 @@
     runs-on: ubuntu-24.04
     if: ${{ github.repository_owner =3D=3D 'openvpn' || github.event_name =
=3D=3D 'workflow_dispatch' }}
     steps:
-      - uses: actions/checkout@...2977... # v6.0.1
+      - uses: actions/checkout@...2998... # v6.0.2
         with:
           path: openvpn


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1540?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4536e06b082ae17baba1490246244b5923063c93
Gerrit-Change-Number: 1540
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7BeZY1l3gyc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1540?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">GHA: Maintenance update Februar=
y 2026<br><br>Switch libressl and mbedTLS 4 builds to Ubuntu 24.04.<br><br>=
Includes the following renovate changes:<br>- chore(deps): update dependenc=
y aws/aws-lc to v1.67.0<br>- chore(deps): update github actions<br>- chore(=
deps): update vcpkg digest to e5a1490<br><br>Change-Id: I4536e06b082ae17bab=
a1490246244b5923063c93<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerri=
t URL: https://gerrit.openvpn.net/c/openvpn/+/1540<br>Message-Id: &lt;20260=
302152510.11918-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg35813.html<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>M=
 .github/workflows/coverity-scan.yml<br>M .github/workflows/doxygen.yml<br>=
3 files changed, 29 insertions(+), 29 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1540/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/build=
.yaml</span><br><span>index 7d1574c..b213192 100644</span><br><span>--- a/.=
github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.y=
aml</span><br><span>@@ -14,7 +14,7 @@</span><br><span>           sudo apt u=
pdate &amp;&amp; sudo apt install -y python3-pip</span><br><span>          =
 pip3 install pre-commit</span><br><span>       - name: Checkout OpenVPN</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/ch=
eckout@...2977... # v6.0.1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/checkout@...2998... # v6.0.2</span><br><span> =
      - name: Run clang-format</span><br><span>         run: pre-commit run=
 -a --show-diff-on-failure || true</span><br><span>       - name: Check for=
 changes</span><br><span>@@ -44,12 +44,12 @@</span><br><span>       VCPKG_I=
NSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed</span><br><span>     =
steps:</span><br><span>       - name: Checkout OpenVPN</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2977... =
# v6.0.1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses:=
 lukka/get-cmake@...2979... # v4.2.1</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        uses: actions/checkout@...2998... # v6.0.2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cma=
ke@...2999... # v4.2.3</span><br><span>       - name: Install vcpkg</span><=
br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>=
         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
   vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: e5a14=
90e1409d175932ef6014519e9ae149ddb7c</span><br><span>       - name: Install =
dependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg install open=
ssl lz4 cmocka</span><br><span>       - name: configure OpenVPN with cmake<=
/span><br><span>@@ -78,13 +78,13 @@</span><br><span>       - name: Install =
dependencies</span><br><span>         run: sudo apt update &amp;&amp; sudo =
apt install -y mingw-w64 unzip build-essential wget python3-docutils man2ht=
ml-base</span><br><span>       - name: Checkout OpenVPN</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2977...=
 # v6.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@...2998... # v6.0.2</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...3005...=
.. # v4.2.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
uses: lukka/get-cmake@...2999... # v4.2.3</span><br><span>       - name: Re=
store from cache and install vcpkg</span><br><span>         uses: lukka/run=
-vcpkg@...2815... # v11.5</span><br><span>         with:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 6d332a018c43=
3fad20822ff4b536e4ccdc3413bd</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb=
7c</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;<=
/span><br><span> </span><br><span>       - name: Run CMake with vcpkg.json =
manifest</span><br><span>@@ -122,7 +122,7 @@</span><br><span>     name: &qu=
ot;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ matrix.buil=
d }} - OSSL&quot;</span><br><span>     steps:</span><br><span>       - name=
: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     uses: actions/checkout@...2977... # v6.0.1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2998... # v6.=
0.2</span><br><span>       - name: Retrieve mingw unittest</span><br><span>=
         uses: actions/download-artifact@...2980... # v7.0.0</span><br><spa=
n>         with:</span><br><span>@@ -163,7 +163,7 @@</span><br><span>      =
 - name: Install dependencies</span><br><span>         run: sudo apt update=
 &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-=
ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docut=
ils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>      =
 - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uses: actions/checkout@...2977... # v6.0.1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...3006...=
. # v6.0.2</span><br><span>       - name: autoconf</span><br><span>        =
 run: autoreconf -fvi</span><br><span>       - name: configure</span><br><s=
pan>@@ -193,7 +193,7 @@</span><br><span>       - name: Install dependencies=
</span><br><span>         run: sudo apt update &amp;&amp; sudo apt install =
-y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux=
-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake au=
toconf</span><br><span>       - name: Checkout OpenVPN</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2977... =
# v6.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        use=
s: actions/checkout@...2998... # v6.0.2</span><br><span>       - name: auto=
conf</span><br><span>         run: autoreconf -fvi</span><br><span>       -=
 name: configure</span><br><span>@@ -233,7 +233,7 @@</span><br><span>      =
 - name: Install dependencies</span><br><span>         run: brew install ${=
{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf</span><b=
r><span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        uses: actions/checkout@...2977... # v6.0.1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/chec=
kout@...2998... # v6.0.2</span><br><span>       - name: Set environment</sp=
an><br><span>         run: |</span><br><span>           cat &gt;&gt;$GITHUB=
_ENV &lt;&lt;EOF;</span><br><span>@@ -265,8 +265,8 @@</span><br><span> </sp=
an><br><span>       runs-on: windows-2025</span><br><span>       steps:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/che=
ckout@...2977... # v6.0.1</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-      - uses: lukka/get-cmake@...2979... # v4.2.1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@...2998...=
 # v6.0.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - us=
es: lukka/get-cmake@...2999... # v4.2.3</span><br><span> </span><br><span> =
      - name: Install rst2html</span><br><span>         run: python -m pip =
install --upgrade pip docutils</span><br><span>@@ -274,7 +274,7 @@</span><b=
r><span>       - name: Restore artifacts, or setup vcpkg (do not install an=
y package)</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.=
5</span><br><span>         with:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc34=
13bd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkg=
GitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c</span><br><span>     =
      vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </spa=
n><br><span>       - name: Run CMake with vcpkg.json manifest (NO TESTS)</s=
pan><br><span>@@ -307,7 +307,7 @@</span><br><span>     strategy:</span><br>=
<span>       fail-fast: false</span><br><span>       matrix:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        os: [ubuntu-22.04]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        os: [ubuntu-24.04]</s=
pan><br><span>         ssllib: [libressl]</span><br><span>         build: [=
 normal, asan ]</span><br><span>         configureflags: [&quot;--with-open=
ssl-engine=3Dno&quot;]</span><br><span>@@ -333,7 +333,7 @@</span><br><span>=
       - name: Install dependencies</span><br><span>         run: sudo apt =
update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev l=
inux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automak=
e autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span>      =
 - name: &quot;libressl: checkout&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        uses: actions/checkout@...2977... # v6.0.1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/chec=
kout@...2998... # v6.0.2</span><br><span>         with:</span><br><span>   =
        path: libressl</span><br><span>           # versioning=3Dsemver-coe=
rced</span><br><span>@@ -356,7 +356,7 @@</span><br><span>       - name: &qu=
ot;ldconfig&quot;</span><br><span>         run: sudo ldconfig</span><br><sp=
an>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        uses: actions/checkout@...2977... # v6.0.1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@=
...2998... # v6.0.2</span><br><span>       - name: autoconf</span><br><span=
>         run: autoreconf -fvi</span><br><span>       - name: configure</sp=
an><br><span>@@ -372,7 +372,7 @@</span><br><span>     strategy:</span><br><=
span>       fail-fast: false</span><br><span>       matrix:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        os: [ubuntu-22.04]</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        os: [ubuntu-24.04]</sp=
an><br><span>         ssllib: [mbedtls4]</span><br><span>         build: [ =
normal, asan ]</span><br><span>         include:</span><br><span>@@ -397,14=
 +397,14 @@</span><br><span>       - name: Install dependencies</span><br><=
span>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-d=
ev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev pyth=
on3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pk=
g-config libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quo=
t;mbedtls: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uses: actions/checkout@...2977... # v6.0.1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...3006...=
. # v6.0.2</span><br><span>         with:</span><br><span>           path: =
mbedtls</span><br><span>           submodules: recursive</span><br><span>  =
         # versioning=3Dsemver-coerced</span><br><span>           repositor=
y: Mbed-TLS/mbedtls</span><br><span>           ref: v4.0.0</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2939...=
.. # v4.1.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
uses: lukka/get-cmake@...2999... # v4.2.3</span><br><span>       - name: &q=
uot;mbedtls: cmake&quot;</span><br><span>         run: cmake -B build</span=
><br><span>         working-directory: mbedtls</span><br><span>@@ -415,7 +4=
15,7 @@</span><br><span>         run: sudo cmake --install build --prefix /=
usr</span><br><span>         working-directory: mbedtls</span><br><span>   =
    - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        uses: actions/checkout@...2977... # v6.0.1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...3007...=
8... # v6.0.2</span><br><span>       - name: autoconf</span><br><span>     =
    run: autoreconf -fvi</span><br><span>       - name: configure</span><br=
><span>@@ -460,13 +460,13 @@</span><br><span>       - name: Install depende=
ncies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt ins=
tall -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev =
man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonsc=
hema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</s=
pan><br><span>       - name: &quot;AWS-LC: checkout&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...3008...=
.. # v6.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
uses: actions/checkout@...2998... # v6.0.2</span><br><span>         with:</=
span><br><span>           path: aws-lc</span><br><span>           # version=
ing=3Dsemver-coerced</span><br><span>           repository: aws/aws-lc</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v1.66.2</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-c=
make@...2979... # v4.2.1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+          ref: v1.67.0</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      - uses: lukka/get-cmake@...2999... # v4.2.3</span><br><span> =
      - name: &quot;AWS-LC: build&quot;</span><br><span>         run: |</sp=
an><br><span>           mkdir build</span><br><span>@@ -475,7 +475,7 @@</sp=
an><br><span>           ninja install</span><br><span>         working-dire=
ctory: aws-lc</span><br><span>       - name: Checkout OpenVPN</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...1665...=
977... # v6.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uses: actions/checkout@...2998... # v6.0.2</span><br><span>       - nam=
e: autoconf</span><br><span>         run: autoreconf -fvi</span><br><span> =
      - name: configure with AWS-LC</span><br><span>diff --git a/.github/wo=
rkflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml</span><br><=
span>index f329482..5554c4d 100644</span><br><span>--- a/.github/workflows/=
coverity-scan.yml</span><br><span>+++ b/.github/workflows/coverity-scan.yml=
</span><br><span>@@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><s=
pan>       - name: Check submission cache</span><br><span>         id: chec=
k_submit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses:=
 actions/cache/restore@...2981... # v5.0.1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uses: actions/cache/restore@...3000... # v5.=
0.3</span><br><span>         with:</span><br><span>           path: |</span=
><br><span>             cov-int</span><br><span>@@ -25,7 +25,7 @@</span><br=
><span> </span><br><span>       - name: Checkout OpenVPN</span><br><span>  =
       if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkou=
t@...2977... # v6.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uses: actions/checkout@...2998... # v6.0.2</span><br><span> </spa=
n><br><span>       - name: Download Coverity Build Tool</span><br><span>   =
      if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><b=
r><span>@@ -65,7 +65,7 @@</span><br><span> </span><br><span>       - name: =
Cache submission</span><br><span>         if: steps.check_submit.outputs.ca=
che-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uses: actions/cache/save@...2981... # v5.0.1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/save@...493...=
3000... # v5.0.3</span><br><span>         with:</span><br><span>           =
path: |</span><br><span>             cov-int</span><br><span>diff --git a/.=
github/workflows/doxygen.yml b/.github/workflows/doxygen.yml</span><br><spa=
n>index b510dc8..b28dd70 100644</span><br><span>--- a/.github/workflows/dox=
ygen.yml</span><br><span>+++ b/.github/workflows/doxygen.yml</span><br><spa=
n>@@ -11,7 +11,7 @@</span><br><span>     runs-on: ubuntu-24.04</span><br><s=
pan>     if: ${{ github.repository_owner =3D=3D &#39;openvpn&#39; || github=
.event_name =3D=3D &#39;workflow_dispatch&#39; }}</span><br><span>     step=
s:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actio=
ns/checkout@...2977... # v6.0.1</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      - uses: actions/checkout@...2998... # v6.0.2</span><br><s=
pan>         with:</span><br><span>           path: openvpn</span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1540?usp=3Demail">change 1540</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1540?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4536e06b082ae17baba14902462=
44b5923063c93 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1540 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--7BeZY1l3gyc=--

