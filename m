From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 27 Sep 2024 09:58:42 +0000
In-Reply-To: <gerrit.1727349719000.I92dfbc3a0cc347a51892600bf02b501295ce612b@...2715...>
References: <gerrit.1727349719000.I92dfbc3a0cc347a51892600bf02b501295ce612b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <da17ff494650090d3082bcfe404272ddf61fe200-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vou+O8M6Uus="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Pin dependencies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, uddr <yura.uddr@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Vou+O8M6Uus=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/773?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/773/2

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
Gerrit-MessageType: newpatchset

--Vou+O8M6Uus=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/773?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by uddr</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">GHA: Pin dependencies<br><br>Done by renovate. Update=
s will also be handled by<br>renovate.<br><br>This makes the builds slightl=
y more deterministic and<br>removes some potential supply-chain attack vect=
ors.<br><br>GitHub: #610<br><br>Change-Id: I92dfbc3a0cc347a51892600bf02b501=
295ce612b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>A=
cked-by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>Message-Id: &lt;2024=
0927093205.22981-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.co=
m/openvpn-devel@lists.sourceforge.net/msg29461.html<br>Signed-off-by: Gert =
Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yaml<br=
>M .github/workflows/coverity-scan.yml<br>2 files changed, 25 insertions(+)=
, 25 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/73/773/2</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/=
.github/workflows/build.yaml</span><br><span>index 361d457..1bc250d 100644<=
/span><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.g=
ithub/workflows/build.yaml</span><br><span>@@ -13,7 +13,7 @@</span><br><spa=
n>       - name: Install dependencies</span><br><span>         run: sudo ap=
t update &amp;&amp; sudo apt install -y uncrustify</span><br><span>       -=
 name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        uses: actions/checkout@...2691...</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uses: actions/checkout@...2813... # v4</spa=
n><br><span>         with:</span><br><span>           path: openvpn</span><=
br><span>       - name: Show uncrustify version</span><br><span>@@ -27,7 +2=
7,7 @@</span><br><span>       - name: Show changes on standard output</span=
><br><span>         run: git diff</span><br><span>         working-director=
y: openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - use=
s: actions/upload-artifact@...2691...</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      - uses: actions/upload-artifact@...2814... # v4</sp=
an><br><span>         with:</span><br><span>           name: uncrustify-cha=
nges.patch</span><br><span>           path: &#39;openvpn/uncrustify-changes=
.patch&#39;</span><br><span>@@ -49,22 +49,22 @@</span><br><span>       - na=
me: Install dependencies</span><br><span>         run: sudo apt update &amp=
;&amp; sudo apt install -y mingw-w64 unzip cmake ninja-build build-essentia=
l wget python3-docutils man2html-base</span><br><span>       - name: Checko=
ut OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        use=
s: actions/checkout@...2691...</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uses: actions/checkout@...2813... # v4</span><br><span> =
</span><br><span>       - name: Restore from cache and install vcpkg</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-vcpk=
g@...2807...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</s=
pan><br><span>           vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa=
0a91b08e</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json=
&#39;</span><br><span> </span><br><span>       - name: Run CMake with vcpkg=
.json manifest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 uses: lukka/run-cmake@...2808...</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        uses: lukka/run-cmake@...2816... # v10.8</span><br><s=
pan>         with:</span><br><span>           configurePreset: mingw-${{ ma=
trix.arch }}</span><br><span>           buildPreset: mingw-${{ matrix.arch =
}}</span><br><span>           buildPresetAdditionalArgs: &quot;[&#39;--conf=
ig Debug&#39;]&quot;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-      - uses: actions/upload-artifact@...2691...</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-=
artifact@...2814... # v4</span><br><span>         with:</span><br><span>   =
        name: openvpn-mingw-${{ matrix.arch }}</span><br><span>           p=
ath: |</span><br><span>@@ -72,7 +72,7 @@</span><br><span>             ${{ g=
ithub.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br=
><span>             !${{ github.workspace }}/out/build/mingw/${{ matrix.arc=
h }}/Debug/test_*.exe</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2691...</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload=
-artifact@...2814... # v4</span><br><span>         with:</span><br><span>  =
         name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>     =
      path: |</span><br><span>@@ -91,9 +91,9 @@</span><br><span>     name: =
&quot;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</=
span><br><span>     steps:</span><br><span>       - name: Checkout OpenVPN<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/=
checkout@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/checkout@...2813... # v4</span><br><span>       - nam=
e: Retrieve mingw unittest</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        uses: actions/download-artifact@...2691...</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        uses: actions/download-artifact=
@...2817... # v4</span><br><span>         with:</span><br><span>           =
name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>           pat=
h: unittests</span><br><span>@@ -165,7 +165,7 @@</span><br><span>       - n=
ame: Install dependencies</span><br><span>         run: sudo apt update &am=
p;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-d=
ev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils =
libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>       - n=
ame: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@...2691...</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        uses: actions/checkout@...2813... # v4</span>=
<br><span>       - name: autoconf</span><br><span>         run: autoreconf =
-fvi</span><br><span>       - name: configure</span><br><span>@@ -195,7 +19=
5,7 @@</span><br><span>       - name: Install dependencies</span><br><span>=
         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev li=
bpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2htm=
l clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls=
-dev</span><br><span>       - name: Checkout OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/checkout@...2813... # v4</span><br><span>       - name: autoconf</span><br=
><span>         run: autoreconf -fvi</span><br><span>       - name: configu=
re</span><br><span>@@ -256,7 +256,7 @@</span><br><span>       - name: Insta=
ll dependencies</span><br><span>         run: brew install openssl@...2821...=
.. openssl@...1554... lzo lz4 man2html cmocka libtool automake autoconf lib=
ressl</span><br><span>       - name: Checkout OpenVPN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions=
/checkout@...2813... # v4</span><br><span>       - name: autoconf</span><br=
><span>         run: autoreconf -fvi</span><br><span>       - name: configu=
re</span><br><span>@@ -280,27 +280,27 @@</span><br><span> </span><br><span>=
       runs-on: windows-latest</span><br><span>       steps:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@...2375...=
91...</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lu=
kka/get-cmake@...2809...</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      - uses: actions/checkout@...2813... # v4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2818... =
# v3.30.3</span><br><span> </span><br><span>       - name: Install rst2html=
</span><br><span>         run: python -m pip install --upgrade pip docutils=
</span><br><span> </span><br><span>       - name: Restore artifacts, or set=
up vcpkg (do not install any package)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: lukka/run-vcpkg@...2807...</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2822...=
.. # v11.5</span><br><span>         with:</span><br><span>           vcpkgG=
itCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e</span><br><span>      =
     vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </span=
><br><span>       - name: Run CMake with vcpkg.json manifest (NO TESTS)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-c=
make@...2808...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uses: lukka/run-cmake@...2816... # v10.8</span><br><span>         if: $=
{{ matrix.arch =3D=3D &#39;arm64&#39; }}</span><br><span>         with:</sp=
an><br><span>           configurePreset: win-${{ matrix.arch }}-release</sp=
an><br><span>           buildPreset: win-${{ matrix.arch }}-release</span><=
br><span> </span><br><span>       - name: Run CMake with vcpkg.json manifes=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/=
run-cmake@...2808...</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        uses: lukka/run-cmake@...2816... # v10.8</span><br><span>         =
if: ${{ matrix.arch !=3D &#39;arm64&#39; }}</span><br><span>         with:<=
/span><br><span>           configurePreset: win-${{ matrix.arch }}-release<=
/span><br><span>@@ -308,7 +308,7 @@</span><br><span>           testPreset: =
win-${{ matrix.arch }}-release</span><br><span>           testPresetAdditio=
nalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/uplo=
ad-artifact@...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      - uses: actions/upload-artifact@...2814... # v4</span><br><span>  =
       with:</span><br><span>           name: openvpn-msvc-${{ matrix.arch =
}}</span><br><span>           path: |</span><br><span>@@ -348,7 +348,7 @@</=
span><br><span>       - name: Install dependencies</span><br><span>        =
 run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><=
br><span>       - name: &quot;libressl: checkout&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2691...<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: action=
s/checkout@...2813... # v4</span><br><span>         with:</span><br><span> =
          path: libressl</span><br><span>           # versioning=3Dsemver-c=
oerced</span><br><span>@@ -369,7 +369,7 @@</span><br><span>       - name: &=
quot;ldconfig&quot;</span><br><span>         run: sudo ldconfig</span><br><=
span>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        uses: actions/checkout@...2691...</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2823...=
... # v4</span><br><span>       - name: autoconf</span><br><span>         r=
un: autoreconf -fvi</span><br><span>       - name: configure</span><br><spa=
n>@@ -410,7 +410,7 @@</span><br><span>       - name: Install dependencies</=
span><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y=
 liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmock=
a-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake a=
utoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span>       - =
name: &quot;mbedtls: checkout&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        uses: actions/checkout@...2691...</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2820...=
.. # v4</span><br><span>         with:</span><br><span>           path: mbe=
dtls</span><br><span>           submodules: true</span><br><span>@@ -424,7 =
+424,7 @@</span><br><span>         run: sudo make install DESTDIR=3D/usr</s=
pan><br><span>         working-directory: mbedtls</span><br><span>       - =
name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        uses: actions/checkout@...2691...</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uses: actions/checkout@...2813... # v4</span=
><br><span>       - name: autoconf</span><br><span>         run: autoreconf=
 -fvi</span><br><span>       - name: configure</span><br><span>diff --git a=
/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml<=
/span><br><span>index 37b8102..16c979d 100644</span><br><span>--- a/.github=
/workflows/coverity-scan.yml</span><br><span>+++ b/.github/workflows/coveri=
ty-scan.yml</span><br><span>@@ -13,7 +13,7 @@</span><br><span>     steps:</=
span><br><span>       - name: Check submission cache</span><br><span>      =
   id: check_submit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      uses: actions/cache/restore@...2691...</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        uses: actions/cache/restore@...2819... # v=
4</span><br><span>         with:</span><br><span>           path: |</span><=
br><span>             cov-int</span><br><span>@@ -25,7 +25,7 @@</span><br><=
span> </span><br><span>       - name: Checkout OpenVPN</span><br><span>    =
     if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@=
...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
ses: actions/checkout@...2813... # v4</span><br><span> </span><br><span>   =
    - name: Download Coverity Build Tool</span><br><span>         if: steps=
.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span>@@ -65,=
7 +65,7 @@</span><br><span> </span><br><span>       - name: Cache submissio=
n</span><br><span>         if: steps.check_submit.outputs.cache-hit !=3D &#=
39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
ses: actions/cache/save@...2691...</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uses: actions/cache/save@...2819... # v4</span><br><=
span>         with:</span><br><span>           path: |</span><br><span>    =
         cov-int</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/773?usp=3Demail">change 773</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/773?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Vou+O8M6Uus=--

