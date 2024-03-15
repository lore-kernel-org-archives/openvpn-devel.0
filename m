From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 15 Mar 2024 17:05:35 +0000
References: <gerrit.1710522333000.I1ad6a0b1323ce0872f4a3299c5a9f18a982e0126@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f26ff1dc597ac33a532103a2aebb7c5ff742d983-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6QAvaFyLbQY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: general update
 March 2024
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

--6QAvaFyLbQY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/544?usp=3Demail

to review the following change.


Change subject: GHA: general update March 2024
......................................................................

GHA: general update March 2024

- Update to Node 20 versions of actions to avoid warnings
- Update to current vcpkg
- Update mbedTLS and LibreSSL to latest releases

Change-Id: I1ad6a0b1323ce0872f4a3299c5a9f18a982e0126
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 23 insertions(+), 23 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/544/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index bc937e5..f771f5a 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -13,7 +13,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
         with:
           path: openvpn
       - name: Show uncrustify version
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2691...
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -49,12 +49,12 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake =
ninja-build build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...

       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2735...
         with:
-          vcpkgGitCommitId: '1ba9a2591f15af5900f2ce2b3e2bf31771e3ac48'
+          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -64,7 +64,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2691...
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -72,7 +72,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2691...
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -91,9 +91,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2689...
+        uses: actions/download-artifact@...2691...
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -159,7 +159,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -186,7 +186,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang =
libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -235,7 +235,7 @@
       - name: Install dependencies
         run: brew install openssl@...2560... openssl@...1554... lzo lz4 ma=
n2html cmocka libtool automake autoconf libressl
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -257,7 +257,7 @@

       runs-on: windows-latest
       steps:
-      - uses: actions/checkout@...2689...
+      - uses: actions/checkout@...2691...
       - uses: lukka/get-cmake@...2729...

       - name: Install rst2html
@@ -266,7 +266,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2735...
         with:
-          vcpkgGitCommitId: '1ba9a2591f15af5900f2ce2b3e2bf31771e3ac48'
+          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -285,7 +285,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2691...
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -325,11 +325,11 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
         with:
           path: libressl
           repository: libressl/portable
-          ref: v3.8.2
+          ref: v3.8.3
       - name: "libressl: autogen.sh"
         run: ./autogen.sh
         working-directory: libressl
@@ -345,7 +345,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -384,11 +384,11 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
         with:
           path: mbedtls
           repository: Mbed-TLS/mbedtls
-          ref: v3.5.0
+          ref: v3.5.2
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=3D1
         working-directory: mbedtls
@@ -396,7 +396,7 @@
         run: sudo make install DESTDIR=3D/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index c107933..e289746 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -10,7 +10,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2689...
+        uses: actions/cache/restore@...2691...
         with:
           path: |
             cov-int
@@ -22,7 +22,7 @@

       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...

       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
@@ -62,7 +62,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2689...
+        uses: actions/cache/save@...2691...
         with:
           path: |
             cov-int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/544?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1ad6a0b1323ce0872f4a3299c5a9f18a982e0126
Gerrit-Change-Number: 544
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--6QAvaFyLbQY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/544?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: general update March 2024<br><br>- Update to Node 20 ver=
sions of actions to avoid warnings<br>- Update to current vcpkg<br>- Update=
 mbedTLS and LibreSSL to latest releases<br><br>Change-Id: I1ad6a0b1323ce08=
72f4a3299c5a9f18a982e0126<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>M .github/workflows=
/coverity-scan.yml<br>2 files changed, 23 insertions(+), 23 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/544=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/bu=
ild.yaml</span><br><span>index bc937e5..f771f5a 100644</span><br><span>--- =
a/.github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/buil=
d.yaml</span><br><span>@@ -13,7 +13,7 @@</span><br><span>       - name: Ins=
tall dependencies</span><br><span>         run: sudo apt update &amp;&amp; =
sudo apt install -y uncrustify</span><br><span>       - name: Checkout Open=
VPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: acti=
ons/checkout@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uses: actions/checkout@...2691...</span><br><span>         with=
:</span><br><span>           path: openvpn</span><br><span>       - name: S=
how uncrustify version</span><br><span>@@ -27,7 +27,7 @@</span><br><span>  =
     - name: Show changes on standard output</span><br><span>         run: =
git diff</span><br><span>         working-directory: openvpn</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifac=
t@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      -=
 uses: actions/upload-artifact@...2691...</span><br><span>         with:</s=
pan><br><span>           name: uncrustify-changes.patch</span><br><span>   =
        path: &#39;openvpn/uncrustify-changes.patch&#39;</span><br><span>@@=
 -49,12 +49,12 @@</span><br><span>       - name: Install dependencies</span=
><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y min=
gw-w64 unzip cmake ninja-build build-essential wget python3-docutils man2ht=
ml-base</span><br><span>       - name: Checkout OpenVPN</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2689...=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/checkout@...2691...</span><br><span> </span><br><span>       - name: Res=
tore from cache and install vcpkg</span><br><span>         uses: lukka/run-=
vcpkg@...2735...</span><br><span>         with:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: &#39;1ba9a2591f15af59=
00f2ce2b3e2bf31771e3ac48&#39;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b=
08e</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;=
</span><br><span> </span><br><span>       - name: Run CMake with vcpkg.json=
 manifest</span><br><span>@@ -64,7 +64,7 @@</span><br><span>           buil=
dPreset: mingw-${{ matrix.arch }}</span><br><span>           buildPresetAdd=
itionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/uploa=
d-artifact@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      - uses: actions/upload-artifact@...2691...</span><br><span>        =
 with:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }}</s=
pan><br><span>           path: |</span><br><span>@@ -72,7 +72,7 @@</span><b=
r><span>             ${{ github.workspace }}/out/build/mingw/${{ matrix.arc=
h }}/Debug/*.dll</span><br><span>             !${{ github.workspace }}/out/=
build/mingw/${{ matrix.arch }}/Debug/test_*.exe</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-ar=
tifact@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - uses: actions/upload-artifact@...2691...</span><br><span>         wit=
h:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }}-tests<=
/span><br><span>           path: |</span><br><span>@@ -91,9 +91,9 @@</span>=
<br><span>     name: &quot;mingw unittest ${{ matrix.test }} - ${{ matrix.a=
rch }} - OSSL&quot;</span><br><span>     steps:</span><br><span>       - na=
me: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       uses: actions/checkout@...2689...</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        uses: actions/checkout@...2691...</span><br><s=
pan>       - name: Retrieve mingw unittest</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: actions/download-artifact@...2689...</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/d=
ownload-artifact@...2691...</span><br><span>         with:</span><br><span>=
           name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>   =
        path: unittests</span><br><span>@@ -159,7 +159,7 @@</span><br><span=
>       - name: Install dependencies</span><br><span>         run: sudo apt=
 update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev =
libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python=
3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span=
>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        uses: actions/checkout@...2689...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2691...=
</span><br><span>       - name: autoconf</span><br><span>         run: auto=
reconf -fvi</span><br><span>       - name: configure</span><br><span>@@ -18=
6,7 +186,7 @@</span><br><span>       - name: Install dependencies</span><br=
><span>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2=
-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev =
man2html clang libcmocka-dev python3-docutils libtool automake autoconf lib=
mbedtls-dev</span><br><span>       - name: Checkout OpenVPN</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2794...=
9...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: a=
ctions/checkout@...2691...</span><br><span>       - name: autoconf</span><b=
r><span>         run: autoreconf -fvi</span><br><span>       - name: config=
ure</span><br><span>@@ -235,7 +235,7 @@</span><br><span>       - name: Inst=
all dependencies</span><br><span>         run: brew install openssl@...2795...=
... openssl@...1554... lzo lz4 man2html cmocka libtool automake autoconf li=
bressl</span><br><span>       - name: Checkout OpenVPN</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2689...<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: action=
s/checkout@...2691...</span><br><span>       - name: autoconf</span><br><sp=
an>         run: autoreconf -fvi</span><br><span>       - name: configure</=
span><br><span>@@ -257,7 +257,7 @@</span><br><span> </span><br><span>      =
 runs-on: windows-latest</span><br><span>       steps:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@...2689...<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: action=
s/checkout@...2691...</span><br><span>       - uses: lukka/get-cmake@...2788...=
9...</span><br><span> </span><br><span>       - name: Install rst2html</spa=
n><br><span>@@ -266,7 +266,7 @@</span><br><span>       - name: Restore arti=
facts, or setup vcpkg (do not install any package)</span><br><span>        =
 uses: lukka/run-vcpkg@...2735...</span><br><span>         with:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: &#39=
;1ba9a2591f15af5900f2ce2b3e2bf31771e3ac48&#39;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 8d3649ba34aab36914dd=
d897958599aa0a91b08e</span><br><span>           vcpkgJsonGlob: &#39;**/wind=
ows/vcpkg.json&#39;</span><br><span> </span><br><span>       - name: Run CM=
ake with vcpkg.json manifest (NO TESTS)</span><br><span>@@ -285,7 +285,7 @@=
</span><br><span>           testPreset: win-${{ matrix.arch }}-release</spa=
n><br><span>           testPresetAdditionalArgs: &quot;[&#39;--output-on-fa=
ilure&#39;]&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-      - uses: actions/upload-artifact@...2689...</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-art=
ifact@...2691...</span><br><span>         with:</span><br><span>           =
name: openvpn-msvc-${{ matrix.arch }}</span><br><span>           path: |</s=
pan><br><span>@@ -325,11 +325,11 @@</span><br><span>       - name: Install =
dependencies</span><br><span>         run: sudo apt update &amp;&amp; sudo =
apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html =
clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config l=
ibcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;libressl=
: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   uses: actions/checkout@...2689...</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        uses: actions/checkout@...2691...</span><br><span>=
         with:</span><br><span>           path: libressl</span><br><span>  =
         repository: libressl/portable</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-          ref: v3.8.2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+          ref: v3.8.3</span><br><span>       - name: &qu=
ot;libressl: autogen.sh&quot;</span><br><span>         run: ./autogen.sh</s=
pan><br><span>         working-directory: libressl</span><br><span>@@ -345,=
7 +345,7 @@</span><br><span>       - name: &quot;ldconfig&quot;</span><br><=
span>         run: sudo ldconfig</span><br><span>       - name: Checkout Op=
enVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: ac=
tions/checkout@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uses: actions/checkout@...2691...</span><br><span>       - na=
me: autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>=
       - name: configure</span><br><span>@@ -384,11 +384,11 @@</span><br><s=
pan>       - name: Install dependencies</span><br><span>         run: sudo =
apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-d=
ev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jin=
ja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev l=
ibnl-genl-3-dev</span><br><span>       - name: &quot;mbedtls: checkout&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/checkout@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uses: actions/checkout@...2691...</span><br><span>         with:<=
/span><br><span>           path: mbedtls</span><br><span>           reposit=
ory: Mbed-TLS/mbedtls</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
          ref: v3.5.0</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+          ref: v3.5.2</span><br><span>       - name: &quot;mbedtls: make =
no_test&quot;</span><br><span>         run: make -j3 no_test SHARED=3D1</sp=
an><br><span>         working-directory: mbedtls</span><br><span>@@ -396,7 =
+396,7 @@</span><br><span>         run: sudo make install DESTDIR=3D/usr</s=
pan><br><span>         working-directory: mbedtls</span><br><span>       - =
name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        uses: actions/checkout@...2689...</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uses: actions/checkout@...2691...</span><br>=
<span>       - name: autoconf</span><br><span>         run: autoreconf -fvi=
</span><br><span>       - name: configure</span><br><span>diff --git a/.git=
hub/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml</span=
><br><span>index c107933..e289746 100644</span><br><span>--- a/.github/work=
flows/coverity-scan.yml</span><br><span>+++ b/.github/workflows/coverity-sc=
an.yml</span><br><span>@@ -10,7 +10,7 @@</span><br><span>     steps:</span>=
<br><span>       - name: Check submission cache</span><br><span>         id=
: check_submit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 uses: actions/cache/restore@...2689...</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        uses: actions/cache/restore@...2691...</span><b=
r><span>         with:</span><br><span>           path: |</span><br><span> =
            cov-int</span><br><span>@@ -22,7 +22,7 @@</span><br><span> </sp=
an><br><span>       - name: Checkout OpenVPN</span><br><span>         if: s=
teps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2689...=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/checkout@...2691...</span><br><span> </span><br><span>       - name: Dow=
nload Coverity Build Tool</span><br><span>         if: steps.check_submit.o=
utputs.cache-hit !=3D &#39;true&#39;</span><br><span>@@ -62,7 +62,7 @@</spa=
n><br><span> </span><br><span>       - name: Cache submission</span><br><sp=
an>         if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/ca=
che/save@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/cache/save@...2691...</span><br><span>         with:<=
/span><br><span>           path: |</span><br><span>             cov-int</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/544?usp=3Demail">change 544</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/544?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ad6a0b1323ce0872f4a3299c5a=
9f18a982e0126 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 544 </div>
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


--6QAvaFyLbQY=--

