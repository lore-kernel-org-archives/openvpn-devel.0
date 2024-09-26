From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 26 Sep 2024 11:22:02 +0000
References: <gerrit.1727349719000.I92dfbc3a0cc347a51892600bf02b501295ce612b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4567ca1543a3a33e63ac5264eb64974503beaa9b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M6g17L1FWFc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Pin dependencies
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

--M6g17L1FWFc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/773?usp=3Demail

to review the following change.


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
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 25 insertions(+), 25 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/773/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--M6g17L1FWFc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/773?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Pin dependencies<br><br>Done by renovate. Updates will a=
lso be handled by<br>renovate.<br><br>This makes the builds slightly more d=
eterministic and<br>removes some potential supply-chain attack vectors.<br>=
<br>GitHub: #610<br><br>Change-Id: I92dfbc3a0cc347a51892600bf02b501295ce612=
b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M =
.github/workflows/build.yaml<br>M .github/workflows/coverity-scan.yml<br>2 =
files changed, 25 insertions(+), 25 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/73/773/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span=
>index 361d457..1bc250d 100644</span><br><span>--- a/.github/workflows/buil=
d.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@=
@ -13,7 +13,7 @@</span><br><span>       - name: Install dependencies</span>=
<br><span>         run: sudo apt update &amp;&amp; sudo apt install -y uncr=
ustify</span><br><span>       - name: Checkout OpenVPN</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: action=
s/checkout@...2813... # v4</span><br><span>         with:</span><br><span> =
          path: openvpn</span><br><span>       - name: Show uncrustify vers=
ion</span><br><span>@@ -27,7 +27,7 @@</span><br><span>       - name: Show c=
hanges on standard output</span><br><span>         run: git diff</span><br>=
<span>         working-directory: openvpn</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2691...</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/uplo=
ad-artifact@...2814... # v4</span><br><span>         with:</span><br><span>=
           name: uncrustify-changes.patch</span><br><span>           path: =
&#39;openvpn/uncrustify-changes.patch&#39;</span><br><span>@@ -49,22 +49,22=
 @@</span><br><span>       - name: Install dependencies</span><br><span>   =
      run: sudo apt update &amp;&amp; sudo apt install -y mingw-w64 unzip c=
make ninja-build build-essential wget python3-docutils man2html-base</span>=
<br><span>       - name: Checkout OpenVPN</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...1186...=
.2813... # v4</span><br><span> </span><br><span>       - name: Restore from=
 cache and install vcpkg</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        uses: lukka/run-vcpkg@...2807...</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2815... # v11.5</s=
pan><br><span>         with:</span><br><span>           vcpkgGitCommitId: 8=
d3649ba34aab36914ddd897958599aa0a91b08e</span><br><span>           vcpkgJso=
nGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>    =
   - name: Run CMake with vcpkg.json manifest</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@...2808...</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@=
...2816... # v10.8</span><br><span>         with:</span><br><span>         =
  configurePreset: mingw-${{ matrix.arch }}</span><br><span>           buil=
dPreset: mingw-${{ matrix.arch }}</span><br><span>           buildPresetAdd=
itionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/uploa=
d-artifact@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      - uses: actions/upload-artifact@...2814... # v4</span><br><span>   =
      with:</span><br><span>           name: openvpn-mingw-${{ matrix.arch =
}}</span><br><span>           path: |</span><br><span>@@ -72,7 +72,7 @@</sp=
an><br><span>             ${{ github.workspace }}/out/build/mingw/${{ matri=
x.arch }}/Debug/*.dll</span><br><span>             !${{ github.workspace }}=
/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/uplo=
ad-artifact@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      - uses: actions/upload-artifact@...2814... # v4</span><br><span>  =
       with:</span><br><span>           name: openvpn-mingw-${{ matrix.arch=
 }}-tests</span><br><span>           path: |</span><br><span>@@ -91,9 +91,9=
 @@</span><br><span>     name: &quot;mingw unittest ${{ matrix.test }} - ${=
{ matrix.arch }} - OSSL&quot;</span><br><span>     steps:</span><br><span> =
      - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uses: actions/checkout@...2691...</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2813... # =
v4</span><br><span>       - name: Retrieve mingw unittest</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uses: actions/download-artifact=
@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
uses: actions/download-artifact@...2817... # v4</span><br><span>         wi=
th:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }}-tests=
</span><br><span>           path: unittests</span><br><span>@@ -165,7 +165,=
7 @@</span><br><span>       - name: Install dependencies</span><br><span>  =
       run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libp=
am0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html =
libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11=
PKG}</span><br><span>       - name: Checkout OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/checkout@...2813... # v4</span><br><span>       - name: autoconf</span><br=
><span>         run: autoreconf -fvi</span><br><span>       - name: configu=
re</span><br><span>@@ -195,7 +195,7 @@</span><br><span>       - name: Insta=
ll dependencies</span><br><span>         run: sudo apt update &amp;&amp; su=
do apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-g=
enl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libt=
ool automake autoconf libmbedtls-dev</span><br><span>       - name: Checkou=
t OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses=
: actions/checkout@...2691...</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        uses: actions/checkout@...2813... # v4</span><br><span>  =
     - name: autoconf</span><br><span>         run: autoreconf -fvi</span><=
br><span>       - name: configure</span><br><span>@@ -256,7 +256,7 @@</span=
><br><span>       - name: Install dependencies</span><br><span>         run=
: brew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmock=
a libtool automake autoconf libressl</span><br><span>       - name: Checkou=
t OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses=
: actions/checkout@...2691...</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        uses: actions/checkout@...2813... # v4</span><br><span>  =
     - name: autoconf</span><br><span>         run: autoreconf -fvi</span><=
br><span>       - name: configure</span><br><span>@@ -280,27 +280,27 @@</sp=
an><br><span> </span><br><span>       runs-on: windows-latest</span><br><sp=
an>       steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 - uses: actions/checkout@...2691...</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - uses: lukka/get-cmake@...2809...</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@...2820...=
.. # v4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses=
: lukka/get-cmake@...2818... # v3.30.3</span><br><span> </span><br><span>  =
     - name: Install rst2html</span><br><span>         run: python -m pip i=
nstall --upgrade pip docutils</span><br><span> </span><br><span>       - na=
me: Restore artifacts, or setup vcpkg (do not install any package)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-vcpkg@=
...2807...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
ses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</spa=
n><br><span>           vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a=
91b08e</span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json=
&#39;</span><br><span> </span><br><span>       - name: Run CMake with vcpkg=
.json manifest (NO TESTS)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        uses: lukka/run-cmake@...2808...</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@...2816... # v10.8</=
span><br><span>         if: ${{ matrix.arch =3D=3D &#39;arm64&#39; }}</span=
><br><span>         with:</span><br><span>           configurePreset: win-$=
{{ matrix.arch }}-release</span><br><span>           buildPreset: win-${{ m=
atrix.arch }}-release</span><br><span> </span><br><span>       - name: Run =
CMake with vcpkg.json manifest</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uses: lukka/run-cmake@...2808...</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@...2816... # v1=
0.8</span><br><span>         if: ${{ matrix.arch !=3D &#39;arm64&#39; }}</s=
pan><br><span>         with:</span><br><span>           configurePreset: wi=
n-${{ matrix.arch }}-release</span><br><span>@@ -308,7 +308,7 @@</span><br>=
<span>           testPreset: win-${{ matrix.arch }}-release</span><br><span=
>           testPresetAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]=
&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      - uses: actions/upload-artifact@...2691...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...493...=
2814... # v4</span><br><span>         with:</span><br><span>           name=
: openvpn-msvc-${{ matrix.arch }}</span><br><span>           path: |</span>=
<br><span>@@ -348,7 +348,7 @@</span><br><span>       - name: Install depend=
encies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt in=
stall -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang =
libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-=
ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;libressl: chec=
kout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        use=
s: actions/checkout@...2691...</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uses: actions/checkout@...2813... # v4</span><br><span> =
        with:</span><br><span>           path: libressl</span><br><span>   =
        # versioning=3Dsemver-coerced</span><br><span>@@ -369,7 +369,7 @@</=
span><br><span>       - name: &quot;ldconfig&quot;</span><br><span>        =
 run: sudo ldconfig</span><br><span>       - name: Checkout OpenVPN</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkou=
t@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/checkout@...2813... # v4</span><br><span>       - name: auto=
conf</span><br><span>         run: autoreconf -fvi</span><br><span>       -=
 name: configure</span><br><span>@@ -410,7 +410,7 @@</span><br><span>      =
 - name: Install dependencies</span><br><span>         run: sudo apt update=
 &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-l=
ibc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python=
3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-=
3-dev</span><br><span>       - name: &quot;mbedtls: checkout&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout=
@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
uses: actions/checkout@...2813... # v4</span><br><span>         with:</span=
><br><span>           path: mbedtls</span><br><span>           submodules: =
true</span><br><span>@@ -424,7 +424,7 @@</span><br><span>         run: sudo=
 make install DESTDIR=3D/usr</span><br><span>         working-directory: mb=
edtls</span><br><span>       - name: Checkout OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/checkout@...2813... # v4</span><br><span>       - name: autoconf</span><br=
><span>         run: autoreconf -fvi</span><br><span>       - name: configu=
re</span><br><span>diff --git a/.github/workflows/coverity-scan.yml b/.gith=
ub/workflows/coverity-scan.yml</span><br><span>index 37b8102..16c979d 10064=
4</span><br><span>--- a/.github/workflows/coverity-scan.yml</span><br><span=
>+++ b/.github/workflows/coverity-scan.yml</span><br><span>@@ -13,7 +13,7 @=
@</span><br><span>     steps:</span><br><span>       - name: Check submissi=
on cache</span><br><span>         id: check_submit</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        uses: actions/cache/restore@...2691...=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/cache/restore@...2819... # v4</span><br><span>         with:</span><br><=
span>           path: |</span><br><span>             cov-int</span><br><spa=
n>@@ -25,7 +25,7 @@</span><br><span> </span><br><span>       - name: Checko=
ut OpenVPN</span><br><span>         if: steps.check_submit.outputs.cache-hi=
t !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@...2691...</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        uses: actions/checkout@...2813... # v4</span>=
<br><span> </span><br><span>       - name: Download Coverity Build Tool</sp=
an><br><span>         if: steps.check_submit.outputs.cache-hit !=3D &#39;tr=
ue&#39;</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </span><br><span=
>       - name: Cache submission</span><br><span>         if: steps.check_s=
ubmit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        uses: actions/cache/save@...2691...</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/s=
ave@...2819... # v4</span><br><span>         with:</span><br><span>        =
   path: |</span><br><span>             cov-int</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/77=
3?usp=3Demail">change 773</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/773?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I92dfbc3a0cc347a51892600bf02=
b501295ce612b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 773 </div>
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


--M6g17L1FWFc=--

