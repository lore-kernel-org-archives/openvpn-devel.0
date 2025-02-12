From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 12 Feb 2025 13:54:07 +0000
References: <gerrit.1739368444000.I29b68675143988c3304395d9d5ec62289cf519a7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <21341a60c4b914edff1d72da05ce8e2249748fab-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Toq+JEJfTB4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Toq+JEJfTB4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/892?usp=3Demail

to review the following change.


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
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 10 insertions(+), 40 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/892/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Toq+JEJfTB4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/892?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Drop Ubuntu 20.04 and other maintenance<br><br>- Drop Ub=
untu 20.04<br>  GHA runners will go away in April 2025<br>- Change ubuntu-l=
atest to ubuntu-24.04<br>  to make sure we are not surprised by<br>  future=
 changes.<br>- Update vcpkg digest to latest 33e9c99<br>- Update github act=
ions to latest<br><br>Change-Id: I29b68675143988c3304395d9d5ec62289cf519a7<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .g=
ithub/workflows/build.yaml<br>M .github/workflows/coverity-scan.yml<br>2 fi=
les changed, 10 insertions(+), 40 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/92/892/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.g=
ithub/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span>i=
ndex 3ebea79..8fd1325 100644</span><br><span>--- a/.github/workflows/build.=
yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ =
-27,7 +27,7 @@</span><br><span>       - name: Show changes on standard outp=
ut</span><br><span>         run: git diff</span><br><span>         working-=
directory: openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   - uses: actions/upload-artifact@...2845... # v4.5.0</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...1186...=
.2860... # v4.6.0</span><br><span>         with:</span><br><span>          =
 name: uncrustify-changes.patch</span><br><span>           path: &#39;openv=
pn/uncrustify-changes.patch&#39;</span><br><span>@@ -54,7 +54,7 @@</span><b=
r><span>       - name: Restore from cache and install vcpkg</span><br><span=
>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>        =
 with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkg=
GitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 33e9c99208736=
b713cabe4490e15235f62f893d4</span><br><span>           vcpkgJsonGlob: &#39;=
**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>       - name: R=
un CMake with vcpkg.json manifest</span><br><span>@@ -64,7 +64,7 @@</span><=
br><span>           buildPreset: mingw-${{ matrix.arch }}</span><br><span> =
          buildPresetAdditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   - uses: actions/upload-artifact@...2845... # v4.5.0</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...1186...=
.2860... # v4.6.0</span><br><span>         with:</span><br><span>          =
 name: openvpn-mingw-${{ matrix.arch }}</span><br><span>           path: |<=
/span><br><span>@@ -72,7 +72,7 @@</span><br><span>             ${{ github.w=
orkspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br><span>=
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      - uses: actions/upload-artifact@...2845... # v4.5.0</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/uplo=
ad-artifact@...2860... # v4.6.0</span><br><span>         with:</span><br><s=
pan>           name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span=
>           path: |</span><br><span>@@ -106,16 +106,12 @@</span><br><span> =
    strategy:</span><br><span>       fail-fast: false</span><br><span>     =
  matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: =
[ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        os: [ubuntu-22.04, ubuntu-24.04]</span><br><=
span>         sslpkg: [libmbedtls-dev]</span><br><span>         ssllib: [mb=
edtls]</span><br><span>         libname: [mbed TLS]</span><br><span> </span=
><br><span>         include:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-          - os: ubuntu-20.04</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib: openssl=
</span><br><span>           - os: ubuntu-22.04</span><br><span>            =
 sslpkg: &quot;libssl-dev&quot;</span><br><span>             libname: OpenS=
SL 3.0.2</span><br><span>@@ -128,32 +124,6 @@</span><br><span>             =
ssllib: openssl</span><br><span>             pkcs11pkg: &quot;libpkcs11-hel=
per1-dev softhsm2 gnutls-bin&quot;</span><br><span>             extraconf: =
--enable-pkcs11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
    - os: ubuntu-20.04</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            sslpkg: &quot;libssl-dev&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            ssllib: openssl</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            pkcs11pkg: &quot;libpk=
cs11-helper1-dev softhsm2 gnutls-bin&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            extraconf: &quot;--enable-iproute2 --enabl=
e-pkcs11&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
   - os: ubuntu-20.04</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            sslpkg: &quot;libssl-dev&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            ssllib: openssl</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            extraconf: &quot;--enab=
le-async-push&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
        - os: ubuntu-20.04</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            sslpkg: &quot;libssl-dev&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            ssllib: openssl</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            extraconf: &quot;-=
-disable-management&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-          - os: ubuntu-20.04</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib: openssl</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            extraconf: &=
quot;--enable-small&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-          - os: ubuntu-20.04</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            sslpkg: &quot;libssl-dev&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            libname: OpenSSL 1.1.1</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            ssllib: openssl</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            extraconf: &=
quot;--disable-lzo --disable-lz4&quot;</span><br><span> </span><br><span>  =
   name: &quot;gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.extraco=
nf}}&quot;</span><br><span>     env:</span><br><span>@@ -182,7 +152,7 @@</s=
pan><br><span>     strategy:</span><br><span>       fail-fast: false</span>=
<br><span>       matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        os: [ubuntu-22.04, ubuntu-24.=
04]</span><br><span>         ssllib: [mbedtls, openssl]</span><br><span> </=
span><br><span>     name: &quot;clang-asan - ${{matrix.os}} - ${{matrix.ssl=
lib}}&quot;</span><br><span>@@ -268,7 +238,7 @@</span><br><span>       runs=
-on: windows-latest</span><br><span>       steps:</span><br><span>       - =
uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2846... # v3.31.3</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get=
-cmake@...2861... # v3.31.5</span><br><span> </span><br><span>       - name=
: Install rst2html</span><br><span>         run: python -m pip install --up=
grade pip docutils</span><br><span>@@ -276,7 +246,7 @@</span><br><span>    =
   - name: Restore artifacts, or setup vcpkg (do not install any package)</=
span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br>=
<span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
         vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId:=
 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span>           vcpkgJ=
sonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </span><br><span>=
       - name: Run CMake with vcpkg.json manifest (NO TESTS)</span><br><spa=
n>@@ -295,7 +265,7 @@</span><br><span>           testPreset: win-${{ matrix=
.arch }}-release</span><br><span>           testPresetAdditionalArgs: &quot=
;[&#39;--output-on-failure&#39;]&quot;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...1186...=
.2845... # v4.5.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - uses: actions/upload-artifact@...2860... # v4.6.0</span><br><span>   =
      with:</span><br><span>           name: openvpn-msvc-${{ matrix.arch }=
}</span><br><span>           path: |</span><br><span>diff --git a/.github/w=
orkflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml</span><br>=
<span>index cb70022..3381d8f 100644</span><br><span>--- a/.github/workflows=
/coverity-scan.yml</span><br><span>+++ b/.github/workflows/coverity-scan.ym=
l</span><br><span>@@ -9,7 +9,7 @@</span><br><span>     # Running coverity r=
equires the secrets.COVERITY_SCAN_TOKEN token</span><br><span>     # which =
is only available on the main repository</span><br><span>     if: github.re=
pository_owner =3D=3D &#39;OpenVPN&#39;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    runs-on: ubuntu-latest</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><span>     ste=
ps:</span><br><span>       - name: Check submission cache</span><br><span> =
        id: check_submit</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/892?usp=3Demail">change 8=
92</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/892?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I29b68675143988c3304395d9d5e=
c62289cf519a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 892 </div>
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


--Toq+JEJfTB4=--

