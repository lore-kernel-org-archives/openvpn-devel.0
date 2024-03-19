From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 19 Mar 2024 17:20:24 +0000
In-Reply-To: <gerrit.1710522333000.I1ad6a0b1323ce0872f4a3299c5a9f18a982e0126@...2715...>
References: <gerrit.1710522333000.I1ad6a0b1323ce0872f4a3299c5a9f18a982e0126@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e0d46d888946ade9215f0cc5e575654c7b9a64c4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O2v6eR6bjUI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--O2v6eR6bjUI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/544?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: GHA: general update March 2024
......................................................................

GHA: general update March 2024

- Update to Node 20 versions of actions to avoid warnings
- Update to current vcpkg
- Update mbedTLS and LibreSSL to latest releases

Change-Id: I1ad6a0b1323ce0872f4a3299c5a9f18a982e0126
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240319154456.2967716-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
422.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 23 insertions(+), 23 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/544/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--O2v6eR6bjUI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/544?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: general update March 2024<br><br>- Update t=
o Node 20 versions of actions to avoid warnings<br>- Update to current vcpk=
g<br>- Update mbedTLS and LibreSSL to latest releases<br><br>Change-Id: I1a=
d6a0b1323ce0872f4a3299c5a9f18a982e0126<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1830...=
...&gt;<br>Message-Id: &lt;20240319154456.2967716-1-frank@...2641...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg2=
8422.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M .github/workflows/build.yaml<br>M .github/workflows/coverity-scan.yml<br>=
2 files changed, 23 insertions(+), 23 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/44/544/2</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br><s=
pan>index bc937e5..f771f5a 100644</span><br><span>--- a/.github/workflows/b=
uild.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><spa=
n>@@ -13,7 +13,7 @@</span><br><span>       - name: Install dependencies</sp=
an><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y u=
ncrustify</span><br><span>       - name: Checkout OpenVPN</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2796...=
..</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: act=
ions/checkout@...2691...</span><br><span>         with:</span><br><span>   =
        path: openvpn</span><br><span>       - name: Show uncrustify versio=
n</span><br><span>@@ -27,7 +27,7 @@</span><br><span>       - name: Show cha=
nges on standard output</span><br><span>         run: git diff</span><br><s=
pan>         working-directory: openvpn</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2689...</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload=
-artifact@...2691...</span><br><span>         with:</span><br><span>       =
    name: uncrustify-changes.patch</span><br><span>           path: &#39;op=
envpn/uncrustify-changes.patch&#39;</span><br><span>@@ -49,12 +49,12 @@</sp=
an><br><span>       - name: Install dependencies</span><br><span>         r=
un: sudo apt update &amp;&amp; sudo apt install -y mingw-w64 unzip cmake ni=
nja-build build-essential wget python3-docutils man2html-base</span><br><sp=
an>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        uses: actions/checkout@...2689...</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2797...=
.</span><br><span> </span><br><span>       - name: Restore from cache and i=
nstall vcpkg</span><br><span>         uses: lukka/run-vcpkg@...2735...</spa=
n><br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-          vcpkgGitCommitId: &#39;1ba9a2591f15af5900f2ce2b3e2bf31771e3a=
c48&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          v=
cpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e</span><br><span> =
          vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </s=
pan><br><span>       - name: Run CMake with vcpkg.json manifest</span><br><=
span>@@ -64,7 +64,7 @@</span><br><span>           buildPreset: mingw-${{ ma=
trix.arch }}</span><br><span>           buildPresetAdditionalArgs: &quot;[&=
#39;--config Debug&#39;]&quot;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2689...=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actio=
ns/upload-artifact@...2691...</span><br><span>         with:</span><br><spa=
n>           name: openvpn-mingw-${{ matrix.arch }}</span><br><span>       =
    path: |</span><br><span>@@ -72,7 +72,7 @@</span><br><span>             =
${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</spa=
n><br><span>             !${{ github.workspace }}/out/build/mingw/${{ matri=
x.arch }}/Debug/test_*.exe</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2689...</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/u=
pload-artifact@...2691...</span><br><span>         with:</span><br><span>  =
         name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>     =
      path: |</span><br><span>@@ -91,9 +91,9 @@</span><br><span>     name: =
&quot;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</=
span><br><span>     steps:</span><br><span>       - name: Checkout OpenVPN<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/=
checkout@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/checkout@...2691...</span><br><span>       - name: Re=
trieve mingw unittest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/download-artifact@...2689...</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uses: actions/download-artifact@...1665...=
691...</span><br><span>         with:</span><br><span>           name: open=
vpn-mingw-${{ matrix.arch }}-tests</span><br><span>           path: unittes=
ts</span><br><span>@@ -159,7 +159,7 @@</span><br><span>       - name: Insta=
ll dependencies</span><br><span>         run: sudo apt update &amp;&amp; su=
do apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-g=
enl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool au=
tomake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>       - name: Check=
out OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        us=
es: actions/checkout@...2689...</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        uses: actions/checkout@...2691...</span><br><span>     =
  - name: autoconf</span><br><span>         run: autoreconf -fvi</span><br>=
<span>       - name: configure</span><br><span>@@ -186,7 +186,7 @@</span><b=
r><span>       - name: Install dependencies</span><br><span>         run: s=
udo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev libl=
z4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmoc=
ka-dev python3-docutils libtool automake autoconf libmbedtls-dev</span><br>=
<span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/checkout@...2689...</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2798...=
1...</span><br><span>       - name: autoconf</span><br><span>         run: =
autoreconf -fvi</span><br><span>       - name: configure</span><br><span>@@=
 -235,7 +235,7 @@</span><br><span>       - name: Install dependencies</span=
><br><span>         run: brew install openssl@...2560... openssl@...1554...=
 lzo lz4 man2html cmocka libtool automake autoconf libressl</span><br><span=
>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        uses: actions/checkout@...2689...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2691...=
</span><br><span>       - name: autoconf</span><br><span>         run: auto=
reconf -fvi</span><br><span>       - name: configure</span><br><span>@@ -25=
7,7 +257,7 @@</span><br><span> </span><br><span>       runs-on: windows-lat=
est</span><br><span>       steps:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      - uses: actions/checkout@...2689...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@...2691...=
</span><br><span>       - uses: lukka/get-cmake@...2729...</span><br><span>=
 </span><br><span>       - name: Install rst2html</span><br><span>@@ -266,7=
 +266,7 @@</span><br><span>       - name: Restore artifacts, or setup vcpkg=
 (do not install any package)</span><br><span>         uses: lukka/run-vcpk=
g@...2735...</span><br><span>         with:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-          vcpkgGitCommitId: &#39;1ba9a2591f15af5900f2=
ce2b3e2bf31771e3ac48&#39;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e<=
/span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</=
span><br><span> </span><br><span>       - name: Run CMake with vcpkg.json m=
anifest (NO TESTS)</span><br><span>@@ -285,7 +285,7 @@</span><br><span>    =
       testPreset: win-${{ matrix.arch }}-release</span><br><span>         =
  testPresetAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      -=
 uses: actions/upload-artifact@...2689...</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2691...</spa=
n><br><span>         with:</span><br><span>           name: openvpn-msvc-${=
{ matrix.arch }}</span><br><span>           path: |</span><br><span>@@ -325=
,11 +325,11 @@</span><br><span>       - name: Install dependencies</span><b=
r><span>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo=
2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev p=
ython3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-ge=
nl-3-dev</span><br><span>       - name: &quot;libressl: checkout&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/chec=
kout@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uses: actions/checkout@...2691...</span><br><span>         with:</span>=
<br><span>           path: libressl</span><br><span>           repository: =
libressl/portable</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
      ref: v3.8.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
        ref: v3.8.3</span><br><span>       - name: &quot;libressl: autogen.=
sh&quot;</span><br><span>         run: ./autogen.sh</span><br><span>       =
  working-directory: libressl</span><br><span>@@ -345,7 +345,7 @@</span><br=
><span>       - name: &quot;ldconfig&quot;</span><br><span>         run: su=
do ldconfig</span><br><span>       - name: Checkout OpenVPN</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2794...=
9...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: a=
ctions/checkout@...2691...</span><br><span>       - name: autoconf</span><b=
r><span>         run: autoreconf -fvi</span><br><span>       - name: config=
ure</span><br><span>@@ -384,11 +384,11 @@</span><br><span>       - name: In=
stall dependencies</span><br><span>         run: sudo apt update &amp;&amp;=
 sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man=
2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschem=
a libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span=
><br><span>       - name: &quot;mbedtls: checkout&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2689...=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/checkout@...2691...</span><br><span>         with:</span><br><span>     =
      path: mbedtls</span><br><span>           repository: Mbed-TLS/mbedtls=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v3.5.0=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: v3.5=
.2</span><br><span>       - name: &quot;mbedtls: make no_test&quot;</span><=
br><span>         run: make -j3 no_test SHARED=3D1</span><br><span>        =
 working-directory: mbedtls</span><br><span>@@ -396,7 +396,7 @@</span><br><=
span>         run: sudo make install DESTDIR=3D/usr</span><br><span>       =
  working-directory: mbedtls</span><br><span>       - name: Checkout OpenVP=
N</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/checkout@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uses: actions/checkout@...2691...</span><br><span>       - name: =
autoconf</span><br><span>         run: autoreconf -fvi</span><br><span>    =
   - name: configure</span><br><span>diff --git a/.github/workflows/coverit=
y-scan.yml b/.github/workflows/coverity-scan.yml</span><br><span>index c107=
933..e289746 100644</span><br><span>--- a/.github/workflows/coverity-scan.y=
ml</span><br><span>+++ b/.github/workflows/coverity-scan.yml</span><br><spa=
n>@@ -10,7 +10,7 @@</span><br><span>     steps:</span><br><span>       - na=
me: Check submission cache</span><br><span>         id: check_submit</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/=
restore@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       uses: actions/cache/restore@...2691...</span><br><span>         with=
:</span><br><span>           path: |</span><br><span>             cov-int</=
span><br><span>@@ -22,7 +22,7 @@</span><br><span> </span><br><span>       -=
 name: Checkout OpenVPN</span><br><span>         if: steps.check_submit.out=
puts.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        uses: actions/checkout@...2689...</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2797...=
.</span><br><span> </span><br><span>       - name: Download Coverity Build =
Tool</span><br><span>         if: steps.check_submit.outputs.cache-hit !=3D=
 &#39;true&#39;</span><br><span>@@ -62,7 +62,7 @@</span><br><span> </span><=
br><span>       - name: Cache submission</span><br><span>         if: steps=
.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/save@...2689...=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/cache/save@...2691...</span><br><span>         with:</span><br><span>   =
        path: |</span><br><span>             cov-int</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/544?usp=3Demail">change 544</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/544?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ad6a0b1323ce0872f4a3299c5a=
9f18a982e0126 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 544 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--O2v6eR6bjUI=--

