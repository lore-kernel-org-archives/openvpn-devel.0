From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 13 Feb 2025 21:50:14 +0000
In-Reply-To: <gerrit.1739368444000.I29b68675143988c3304395d9d5ec62289cf519a7@...2715...>
References: <gerrit.1739368444000.I29b68675143988c3304395d9d5ec62289cf519a7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <3fb195667d324b3ef20a794304c9d0b0ccb8ebe2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xJpJVSo1VOY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Drop Ubuntu
 20.04 and other maintenance
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

--xJpJVSo1VOY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/89=
2?usp=3Demail )

Change subject: GHA: Drop Ubuntu 20.04 and other maintenance
......................................................................

GHA: Drop Ubuntu 20.04 and other maintenance

- Drop Ubuntu 20.04
  GHA runners will go away in April 2025
- Change ubuntu-latest to ubuntu-24.04
  to make sure we are not surprised by
  future changes.
- Update vcpkg digest to latest 33e9c99
- Update github actions to latest

Change-Id: I29b68675143988c3304395d9d5ec62289cf519a7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20250212215151.619-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
852.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 10 insertions(+), 40 deletions(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 3ebea79..8fd1325 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2845... # v4.5.0
+      - uses: actions/upload-artifact@...2860... # v4.6.0
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -54,7 +54,7 @@
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade
+          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -64,7 +64,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2845... # v4.5.0
+      - uses: actions/upload-artifact@...2860... # v4.6.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -72,7 +72,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2845... # v4.5.0
+      - uses: actions/upload-artifact@...2860... # v4.6.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -106,16 +106,12 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]
+        os: [ubuntu-22.04, ubuntu-24.04]
         sslpkg: [libmbedtls-dev]
         ssllib: [mbedtls]
         libname: [mbed TLS]

         include:
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
           - os: ubuntu-22.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 3.0.2
@@ -128,32 +124,6 @@
             ssllib: openssl
             pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
             extraconf: --enable-pkcs11
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
-            extraconf: "--enable-iproute2 --enable-pkcs11"
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--enable-async-push"
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--disable-management"
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--enable-small"
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--disable-lzo --disable-lz4"

     name: "gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.extraconf}=
}"
     env:
@@ -182,7 +152,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]
+        os: [ubuntu-22.04, ubuntu-24.04]
         ssllib: [mbedtls, openssl]

     name: "clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}"
@@ -268,7 +238,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2846... # v3.31.3
+      - uses: lukka/get-cmake@...2861... # v3.31.5

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -276,7 +246,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade
+          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -295,7 +265,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2845... # v4.5.0
+      - uses: actions/upload-artifact@...2860... # v4.6.0
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index cb70022..3381d8f 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -9,7 +9,7 @@
     # Running coverity requires the secrets.COVERITY_SCAN_TOKEN token
     # which is only available on the main repository
     if: github.repository_owner =3D=3D 'OpenVPN'
-    runs-on: ubuntu-latest
+    runs-on: ubuntu-24.04
     steps:
       - name: Check submission cache
         id: check_submit

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/892?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I29b68675143988c3304395d9d5ec62289cf519a7
Gerrit-Change-Number: 892
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--xJpJVSo1VOY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/892?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Drop Ubuntu 20.04 and other maintenance<b=
r><br>- Drop Ubuntu 20.04<br>  GHA runners will go away in April 2025<br>- =
Change ubuntu-latest to ubuntu-24.04<br>  to make sure we are not surprised=
 by<br>  future changes.<br>- Update vcpkg digest to latest 33e9c99<br>- Up=
date github actions to latest<br><br>Change-Id: I29b68675143988c3304395d9d5=
ec62289cf519a7<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>Message-Id: &lt=
;20250212215151.619-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg30852.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yaml<=
br>M .github/workflows/coverity-scan.yml<br>2 files changed, 10 insertions(=
+), 40 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 3ebea79..8fd1325 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -27,7 +27,7 @@</span><br><span>       - name: Show change=
s on standard output</span><br><span>         run: git diff</span><br><span=
>         working-directory: openvpn</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - uses: actions/upload-artifact@...2845... # v4.5.0</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/=
upload-artifact@...2860... # v4.6.0</span><br><span>         with:</span><b=
r><span>           name: uncrustify-changes.patch</span><br><span>         =
  path: &#39;openvpn/uncrustify-changes.patch&#39;</span><br><span>@@ -54,7=
 +54,7 @@</span><br><span>       - name: Restore from cache and install vcp=
kg</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span>=
<br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommi=
tId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span>           vc=
pkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><spa=
n>       - name: Run CMake with vcpkg.json manifest</span><br><span>@@ -64,=
7 +64,7 @@</span><br><span>           buildPreset: mingw-${{ matrix.arch }}=
</span><br><span>           buildPresetAdditionalArgs: &quot;[&#39;--config=
 Debug&#39;]&quot;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - uses: actions/upload-artifact@...2845... # v4.5.0</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/=
upload-artifact@...2860... # v4.6.0</span><br><span>         with:</span><b=
r><span>           name: openvpn-mingw-${{ matrix.arch }}</span><br><span> =
          path: |</span><br><span>@@ -72,7 +72,7 @@</span><br><span>       =
      ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dl=
l</span><br><span>             !${{ github.workspace }}/out/build/mingw/${{=
 matrix.arch }}/Debug/test_*.exe</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2864...=
.. # v4.5.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
uses: actions/upload-artifact@...2860... # v4.6.0</span><br><span>         =
with:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }}-tes=
ts</span><br><span>           path: |</span><br><span>@@ -106,16 +106,12 @@=
</span><br><span>     strategy:</span><br><span>       fail-fast: false</sp=
an><br><span>       matrix:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        os: [ubuntu-22.04, ubuntu-=
24.04]</span><br><span>         sslpkg: [libmbedtls-dev]</span><br><span>  =
       ssllib: [mbedtls]</span><br><span>         libname: [mbed TLS]</span=
><br><span> </span><br><span>         include:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-          - os: ubuntu-20.04</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            sslpkg: &quot;libssl-dev&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            libname: O=
penSSL 1.1.1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   ssllib: openssl</span><br><span>           - os: ubuntu-22.04</span><br>=
<span>             sslpkg: &quot;libssl-dev&quot;</span><br><span>         =
    libname: OpenSSL 3.0.2</span><br><span>@@ -128,32 +124,6 @@</span><br><=
span>             ssllib: openssl</span><br><span>             pkcs11pkg: &=
quot;libpkcs11-helper1-dev softhsm2 gnutls-bin&quot;</span><br><span>      =
       extraconf: --enable-pkcs11</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-          - os: ubuntu-20.04</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib: op=
enssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pkcs=
11pkg: &quot;libpkcs11-helper1-dev softhsm2 gnutls-bin&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            extraconf: &quot;--enabl=
e-iproute2 --enable-pkcs11&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-          - os: ubuntu-20.04</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib: ope=
nssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            extra=
conf: &quot;--enable-async-push&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-          - os: ubuntu-20.04</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.=
1.1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib=
: openssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
extraconf: &quot;--disable-management&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-          - os: ubuntu-20.04</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            libname: Open=
SSL 1.1.1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
ssllib: openssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      extraconf: &quot;--enable-small&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-          - os: ubuntu-20.04</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            libname: Open=
SSL 1.1.1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
ssllib: openssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      extraconf: &quot;--disable-lzo --disable-lz4&quot;</span><br><span> <=
/span><br><span>     name: &quot;gcc - ${{matrix.os}} - ${{matrix.libname}}=
 ${{matrix.extraconf}}&quot;</span><br><span>     env:</span><br><span>@@ -=
182,7 +152,7 @@</span><br><span>     strategy:</span><br><span>       fail-=
fast: false</span><br><span>       matrix:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        os: [ubuntu=
-22.04, ubuntu-24.04]</span><br><span>         ssllib: [mbedtls, openssl]</=
span><br><span> </span><br><span>     name: &quot;clang-asan - ${{matrix.os=
}} - ${{matrix.ssllib}}&quot;</span><br><span>@@ -268,7 +238,7 @@</span><br=
><span>       runs-on: windows-latest</span><br><span>       steps:</span><=
br><span>       - uses: actions/checkout@...2844... # v4.2.2</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2848...=
6... # v3.31.3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 - uses: lukka/get-cmake@...2861... # v3.31.5</span><br><span> </span><br><=
span>       - name: Install rst2html</span><br><span>         run: python -=
m pip install --upgrade pip docutils</span><br><span>@@ -276,7 +246,7 @@</s=
pan><br><span>       - name: Restore artifacts, or setup vcpkg (do not inst=
all any package)</span><br><span>         uses: lukka/run-vcpkg@...2815... =
# v11.5</span><br><span>         with:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a=
7f25956ade</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
 vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span=
>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span>=
 </span><br><span>       - name: Run CMake with vcpkg.json manifest (NO TES=
TS)</span><br><span>@@ -295,7 +265,7 @@</span><br><span>           testPres=
et: win-${{ matrix.arch }}-release</span><br><span>           testPresetAdd=
itionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/=
upload-artifact@...2845... # v4.5.0</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      - uses: actions/upload-artifact@...2860... # v4.6.0</=
span><br><span>         with:</span><br><span>           name: openvpn-msvc=
-${{ matrix.arch }}</span><br><span>           path: |</span><br><span>diff=
 --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-s=
can.yml</span><br><span>index cb70022..3381d8f 100644</span><br><span>--- a=
/.github/workflows/coverity-scan.yml</span><br><span>+++ b/.github/workflow=
s/coverity-scan.yml</span><br><span>@@ -9,7 +9,7 @@</span><br><span>     # =
Running coverity requires the secrets.COVERITY_SCAN_TOKEN token</span><br><=
span>     # which is only available on the main repository</span><br><span>=
     if: github.repository_owner =3D=3D &#39;OpenVPN&#39;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    runs-on: ubuntu-latest</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span>=
<br><span>     steps:</span><br><span>       - name: Check submission cache=
</span><br><span>         id: check_submit</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/892?usp=
=3Demail">change 892</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/892?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I29b68675143988c3304395d9d5e=
c62289cf519a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 892 </div>
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


--xJpJVSo1VOY=--

