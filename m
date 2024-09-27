From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 27 Sep 2024 09:58:44 +0000
In-Reply-To: <gerrit.1727349719000.I92dfbc3a0cc347a51892600bf02b501295ce612b@...2715...>
References: <gerrit.1727349719000.I92dfbc3a0cc347a51892600bf02b501295ce612b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <da17ff494650090d3082bcfe404272ddf61fe200-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sioMSCH9gdk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Pin dependencies
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

--sioMSCH9gdk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/77=
3?usp=3Demail )

Change subject: GHA: Pin dependencies
......................................................................

GHA: Pin dependencies

Done by renovate. Updates will also be handled by
renovate.

This makes the builds slightly more deterministic and
removes some potential supply-chain attack vectors.

GitHub: #610

Change-Id: I92dfbc3a0cc347a51892600bf02b501295ce612b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20240927093205.22981-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
461.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 25 insertions(+), 25 deletions(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 361d457..1bc250d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -13,7 +13,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4
         with:
           path: openvpn
       - name: Show uncrustify version
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2691...
+      - uses: actions/upload-artifact@...2814... # v4
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -49,22 +49,22 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake =
ninja-build build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4

       - name: Restore from cache and install vcpkg
-        uses: lukka/run-vcpkg@...2807...
+        uses: lukka/run-vcpkg@...2815... # v11.5
         with:
           vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2808...
+        uses: lukka/run-cmake@...2816... # v10.8
         with:
           configurePreset: mingw-${{ matrix.arch }}
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2691...
+      - uses: actions/upload-artifact@...2814... # v4
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -72,7 +72,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2691...
+      - uses: actions/upload-artifact@...2814... # v4
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -91,9 +91,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2691...
+        uses: actions/download-artifact@...2817... # v4
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -165,7 +165,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmo=
cka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -195,7 +195,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang =
libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -256,7 +256,7 @@
       - name: Install dependencies
         run: brew install openssl@...2560... openssl@...1554... lzo lz4 ma=
n2html cmocka libtool automake autoconf libressl
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -280,27 +280,27 @@

       runs-on: windows-latest
       steps:
-      - uses: actions/checkout@...2691...
-      - uses: lukka/get-cmake@...2809...
+      - uses: actions/checkout@...2813... # v4
+      - uses: lukka/get-cmake@...2818... # v3.30.3

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils

       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
-        uses: lukka/run-vcpkg@...2807...
+        uses: lukka/run-vcpkg@...2815... # v11.5
         with:
           vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
-        uses: lukka/run-cmake@...2808...
+        uses: lukka/run-cmake@...2816... # v10.8
         if: ${{ matrix.arch =3D=3D 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release

       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2808...
+        uses: lukka/run-cmake@...2816... # v10.8
         if: ${{ matrix.arch !=3D 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
@@ -308,7 +308,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2691...
+      - uses: actions/upload-artifact@...2814... # v4
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -348,7 +348,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4
         with:
           path: libressl
           # versioning=3Dsemver-coerced
@@ -369,7 +369,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -410,7 +410,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4
         with:
           path: mbedtls
           submodules: true
@@ -424,7 +424,7 @@
         run: sudo make install DESTDIR=3D/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index 37b8102..16c979d 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2691...
+        uses: actions/cache/restore@...2819... # v4
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@

       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2813... # v4

       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2691...
+        uses: actions/cache/save@...2819... # v4
         with:
           path: |
             cov-int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/773?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I92dfbc3a0cc347a51892600bf02b501295ce612b
Gerrit-Change-Number: 773
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--sioMSCH9gdk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/773?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Pin dependencies<br><br>Done by renovate.=
 Updates will also be handled by<br>renovate.<br><br>This makes the builds =
slightly more deterministic and<br>removes some potential supply-chain atta=
ck vectors.<br><br>GitHub: #610<br><br>Change-Id: I92dfbc3a0cc347a51892600b=
f02b501295ce612b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>Message-Id: &=
lt;20240927093205.22981-1-frank@...2641...&gt;<br>URL: https://www.mail-arc=
hive.com/openvpn-devel@lists.sourceforge.net/msg29461.html<br>Signed-off-by=
: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.=
yaml<br>M .github/workflows/coverity-scan.yml<br>2 files changed, 25 insert=
ions(+), 25 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 361d457..1bc250d 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -13,7 +13,7 @@</span><br><span>       - name: Install dep=
endencies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt=
 install -y uncrustify</span><br><span>       - name: Checkout OpenVPN</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/chec=
kout@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uses: actions/checkout@...2813... # v4</span><br><span>         with:</=
span><br><span>           path: openvpn</span><br><span>       - name: Show=
 uncrustify version</span><br><span>@@ -27,7 +27,7 @@</span><br><span>     =
  - name: Show changes on standard output</span><br><span>         run: git=
 diff</span><br><span>         working-directory: openvpn</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...220...=
..2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - us=
es: actions/upload-artifact@...2814... # v4</span><br><span>         with:<=
/span><br><span>           name: uncrustify-changes.patch</span><br><span> =
          path: &#39;openvpn/uncrustify-changes.patch&#39;</span><br><span>=
@@ -49,22 +49,22 @@</span><br><span>       - name: Install dependencies</sp=
an><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y m=
ingw-w64 unzip cmake ninja-build build-essential wget python3-docutils man2=
html-base</span><br><span>       - name: Checkout OpenVPN</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2824...=
..</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: act=
ions/checkout@...2813... # v4</span><br><span> </span><br><span>       - na=
me: Restore from cache and install vcpkg</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        uses: lukka/run-vcpkg@...2807...</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2825...=
15... # v11.5</span><br><span>         with:</span><br><span>           vcp=
kgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e</span><br><span>   =
        vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </spa=
n><br><span>       - name: Run CMake with vcpkg.json manifest</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@...2825...=
08...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: =
lukka/run-cmake@...2816... # v10.8</span><br><span>         with:</span><br=
><span>           configurePreset: mingw-${{ matrix.arch }}</span><br><span=
>           buildPreset: mingw-${{ matrix.arch }}</span><br><span>         =
  buildPresetAdditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - use=
s: actions/upload-artifact@...2691...</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      - uses: actions/upload-artifact@...2814... # v4</sp=
an><br><span>         with:</span><br><span>           name: openvpn-mingw-=
${{ matrix.arch }}</span><br><span>           path: |</span><br><span>@@ -7=
2,7 +72,7 @@</span><br><span>             ${{ github.workspace }}/out/build=
/mingw/${{ matrix.arch }}/Debug/*.dll</span><br><span>             !${{ git=
hub.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - us=
es: actions/upload-artifact@...2691...</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      - uses: actions/upload-artifact@...2814... # v4</s=
pan><br><span>         with:</span><br><span>           name: openvpn-mingw=
-${{ matrix.arch }}-tests</span><br><span>           path: |</span><br><spa=
n>@@ -91,9 +91,9 @@</span><br><span>     name: &quot;mingw unittest ${{ mat=
rix.test }} - ${{ matrix.arch }} - OSSL&quot;</span><br><span>     steps:</=
span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checko=
ut@...2813... # v4</span><br><span>       - name: Retrieve mingw unittest</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/d=
ownload-artifact@...2691...</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: actions/download-artifact@...2817... # v4</span><br><=
span>         with:</span><br><span>           name: openvpn-mingw-${{ matr=
ix.arch }}-tests</span><br><span>           path: unittests</span><br><span=
>@@ -165,7 +165,7 @@</span><br><span>       - name: Install dependencies</s=
pan><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y =
liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-li=
bc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${=
SSLPKG} ${PKCS11PKG}</span><br><span>       - name: Checkout OpenVPN</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checko=
ut@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  uses: actions/checkout@...2813... # v4</span><br><span>       - name: aut=
oconf</span><br><span>         run: autoreconf -fvi</span><br><span>       =
- name: configure</span><br><span>@@ -195,7 +195,7 @@</span><br><span>     =
  - name: Install dependencies</span><br><span>         run: sudo apt updat=
e &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap=
-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python=
3-docutils libtool automake autoconf libmbedtls-dev</span><br><span>       =
- name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        uses: actions/checkout@...2691...</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2813... # v4</sp=
an><br><span>       - name: autoconf</span><br><span>         run: autoreco=
nf -fvi</span><br><span>       - name: configure</span><br><span>@@ -256,7 =
+256,7 @@</span><br><span>       - name: Install dependencies</span><br><sp=
an>         run: brew install openssl@...2560... openssl@...1554... lzo lz4=
 man2html cmocka libtool automake autoconf libressl</span><br><span>       =
- name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        uses: actions/checkout@...2691...</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2813... # v4</sp=
an><br><span>       - name: autoconf</span><br><span>         run: autoreco=
nf -fvi</span><br><span>       - name: configure</span><br><span>@@ -280,27=
 +280,27 @@</span><br><span> </span><br><span>       runs-on: windows-lates=
t</span><br><span>       steps:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      - uses: actions/checkout@...2691...</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2809...</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/=
checkout@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      - uses: lukka/get-cmake@...2818... # v3.30.3</span><br><span> </=
span><br><span>       - name: Install rst2html</span><br><span>         run=
: python -m pip install --upgrade pip docutils</span><br><span> </span><br>=
<span>       - name: Restore artifacts, or setup vcpkg (do not install any =
package)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses:=
 lukka/run-vcpkg@...2807...</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>  =
       with:</span><br><span>           vcpkgGitCommitId: 8d3649ba34aab3691=
4ddd897958599aa0a91b08e</span><br><span>           vcpkgJsonGlob: &#39;**/w=
indows/vcpkg.json&#39;</span><br><span> </span><br><span>       - name: Run=
 CMake with vcpkg.json manifest (NO TESTS)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@...2808...</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@...493...=
2816... # v10.8</span><br><span>         if: ${{ matrix.arch =3D=3D &#39;ar=
m64&#39; }}</span><br><span>         with:</span><br><span>           confi=
gurePreset: win-${{ matrix.arch }}-release</span><br><span>           build=
Preset: win-${{ matrix.arch }}-release</span><br><span> </span><br><span>  =
     - name: Run CMake with vcpkg.json manifest</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@...2808...</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-cmak=
e@...2816... # v10.8</span><br><span>         if: ${{ matrix.arch !=3D &#39=
;arm64&#39; }}</span><br><span>         with:</span><br><span>           co=
nfigurePreset: win-${{ matrix.arch }}-release</span><br><span>@@ -308,7 +30=
8,7 @@</span><br><span>           testPreset: win-${{ matrix.arch }}-releas=
e</span><br><span>           testPresetAdditionalArgs: &quot;[&#39;--output=
-on-failure&#39;]&quot;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2691...</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/uplo=
ad-artifact@...2814... # v4</span><br><span>         with:</span><br><span>=
           name: openvpn-msvc-${{ matrix.arch }}</span><br><span>          =
 path: |</span><br><span>@@ -348,7 +348,7 @@</span><br><span>       - name:=
 Install dependencies</span><br><span>         run: sudo apt update &amp;&a=
mp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev =
man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg=
-config libcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot=
;libressl: checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uses: actions/checkout@...2691...</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2813... # v4</s=
pan><br><span>         with:</span><br><span>           path: libressl</spa=
n><br><span>           # versioning=3Dsemver-coerced</span><br><span>@@ -36=
9,7 +369,7 @@</span><br><span>       - name: &quot;ldconfig&quot;</span><br=
><span>         run: sudo ldconfig</span><br><span>       - name: Checkout =
OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: =
actions/checkout@...2691...</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        uses: actions/checkout@...2813... # v4</span><br><span>    =
   - name: autoconf</span><br><span>         run: autoreconf -fvi</span><br=
><span>       - name: configure</span><br><span>@@ -410,7 +410,7 @@</span><=
br><span>       - name: Install dependencies</span><br><span>         run: =
sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev lib=
lz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python=
3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-=
dev libnl-genl-3-dev</span><br><span>       - name: &quot;mbedtls: checkout=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: a=
ctions/checkout@...2691...</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/checkout@...2813... # v4</span><br><span>     =
    with:</span><br><span>           path: mbedtls</span><br><span>        =
   submodules: true</span><br><span>@@ -424,7 +424,7 @@</span><br><span>   =
      run: sudo make install DESTDIR=3D/usr</span><br><span>         workin=
g-directory: mbedtls</span><br><span>       - name: Checkout OpenVPN</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checko=
ut@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  uses: actions/checkout@...2813... # v4</span><br><span>       - name: aut=
oconf</span><br><span>         run: autoreconf -fvi</span><br><span>       =
- name: configure</span><br><span>diff --git a/.github/workflows/coverity-s=
can.yml b/.github/workflows/coverity-scan.yml</span><br><span>index 37b8102=
..16c979d 100644</span><br><span>--- a/.github/workflows/coverity-scan.yml<=
/span><br><span>+++ b/.github/workflows/coverity-scan.yml</span><br><span>@=
@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><span>       - name:=
 Check submission cache</span><br><span>         id: check_submit</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/res=
tore@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uses: actions/cache/restore@...2819... # v4</span><br><span>         wi=
th:</span><br><span>           path: |</span><br><span>             cov-int=
</span><br><span>@@ -25,7 +25,7 @@</span><br><span> </span><br><span>      =
 - name: Checkout OpenVPN</span><br><span>         if: steps.check_submit.o=
utputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        uses: actions/checkout@...2691...</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2823...=
... # v4</span><br><span> </span><br><span>       - name: Download Coverity=
 Build Tool</span><br><span>         if: steps.check_submit.outputs.cache-h=
it !=3D &#39;true&#39;</span><br><span>@@ -65,7 +65,7 @@</span><br><span> <=
/span><br><span>       - name: Cache submission</span><br><span>         if=
: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/save@...2375...=
91...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: =
actions/cache/save@...2819... # v4</span><br><span>         with:</span><br=
><span>           path: |</span><br><span>             cov-int</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/773?usp=3Demail">change 773</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/773?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I92dfbc3a0cc347a51892600bf02=
b501295ce612b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 773 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--sioMSCH9gdk=--

