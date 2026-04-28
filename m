From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 28 Apr 2026 15:35:19 +0000
References: <gerrit.1777390515000.I933227aa4bc4f05b58d0e754b4330da807504d01@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d99ce6bbdb8e62179a6f3cd0dc6162eeacd061d8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xn2F3anYaKI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Add caching for
 vcpkg builds
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

--Xn2F3anYaKI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1642?usp=3Demail

to review the following change.


Change subject: GHA: Add caching for vcpkg builds
......................................................................

GHA: Add caching for vcpkg builds

The nice automatic caching was removed last year,
so go back to manual caching of the binary cache
dir.

While here, also update vcpkg to latest master.

Change-Id: I933227aa4bc4f05b58d0e754b4330da807504d01
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M renovate.json
2 files changed, 40 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1642/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 895f469..b530fcc 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -42,14 +42,23 @@
       VCPKG_DEFAULT_TRIPLET: ${{ matrix.vcpkg_triplet }}
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
+      VCPKG_BINARY_SOURCES: clear;default,readwrite
+      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2
       - uses: lukka/get-cmake@...3028... # v4.3.2
-      - name: Install vcpkg
+      - name: Setup vcpkg
         uses: lukka/run-vcpkg@...3029... # v11.6
         with:
-          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}
+      - name: Set up vcpkg binary cache
+        uses: actions/cache@...3024... # v5.0.5
+        with:
+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
+          key: android-${{ matrix.abi }}-vcpkg-binary-cache-${{ env.VCPKG_=
GIT_COMMIT_ID }}
+          restore-keys: |
+            android-${{ matrix.abi }}-vcpkg-binary-cache-
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -70,10 +79,12 @@
         arch: [x86, x64]
         build: [Release, Debug]

-    name: "gcc-mingw - ${{ matrix.arch }} - ${{matrix.build }} - OSSL"
+    name: "gcc-mingw - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
     runs-on: ubuntu-24.04
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
+      VCPKG_BINARY_SOURCES: clear;default,readwrite
+      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-=
essential wget python3-docutils man2html-base
@@ -81,12 +92,21 @@
         uses: actions/checkout@...2998... # v6.0.2

       - uses: lukka/get-cmake@...3028... # v4.3.2
-      - name: Restore from cache and install vcpkg
+      - name: Setup vcpkg
         uses: lukka/run-vcpkg@...3029... # v11.6
         with:
-          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

+      - name: Set up vcpkg binary cache
+        uses: actions/cache@...3024... # v5.0.5
+        with:
+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
+          key: mingw-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('=
**/mingw/vcpkg.json') }}-${{ env.VCPKG_GIT_COMMIT_ID }}
+          restore-keys: |
+            mingw-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/=
mingw/vcpkg.json') }}-
+            mingw-${{ matrix.arch }}-vcpkg-binary-cache-
+
       - name: Run CMake with vcpkg.json manifest
         uses: lukka/run-cmake@...3030... # v10.9
         with:
@@ -262,6 +282,8 @@
       name: "msbuild - ${{ matrix.arch }} - openssl"
       env:
         BUILD_CONFIGURATION: Release
+        VCPKG_BINARY_SOURCES: clear;default,readwrite
+        VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7

       runs-on: windows-2025
       steps:
@@ -271,12 +293,22 @@
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils

-      - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
+      - name: Setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...3029... # v11.6
         with:
-          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}
           vcpkgJsonGlob: '**/windows/vcpkg.json'

+      - name: Set up vcpkg binary cache
+        uses: actions/cache@...3024... # v5.0.5
+        with:
+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
+          key: msvc-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('*=
*/windows/vcpkg.json') }}-${{ env.VCPKG_GIT_COMMIT_ID }}
+          restore-keys: |
+            msvc-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/w=
indows/vcpkg.json') }}-
+            msvc-${{ matrix.arch }}-vcpkg-binary-cache-
+
+
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
         uses: lukka/run-cmake@...3030... # v10.9
         if: ${{ matrix.arch =3D=3D 'arm64' }}
diff --git a/renovate.json b/renovate.json
index 809ac3f..3bd0917 100644
--- a/renovate.json
+++ b/renovate.json
@@ -27,7 +27,7 @@
                 "/^\\.github/workflows/.+\\.ya?ml$/"
             ],
             "matchStrings": [
-                "vcpkgGitCommitId:\\s*(?<currentDigest>.*?)\\n"
+                "VCPKG_GIT_COMMIT_ID:\\s*(?<currentDigest>.*?)\\n"
             ],
             "currentValueTemplate": "master",
             "depNameTemplate": "vcpkg",

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1642?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I933227aa4bc4f05b58d0e754b4330da807504d01
Gerrit-Change-Number: 1642
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Xn2F3anYaKI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1642?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">GHA: Add caching for vcpkg builds<br><br>Th=
e nice automatic caching was removed last year,<br>so go back to manual cac=
hing of the binary cache<br>dir.<br><br>While here, also update vcpkg to la=
test master.<br><br>Change-Id: I933227aa4bc4f05b58d0e754b4330da807504d01<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .git=
hub/workflows/build.yaml<br>M renovate.json<br>2 files changed, 40 insertio=
ns(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/42/1642/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/w=
orkflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index 89=
5f469..b530fcc 100644</span><br><span>--- a/.github/workflows/build.yaml</s=
pan><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -42,14 =
+42,23 @@</span><br><span>       VCPKG_DEFAULT_TRIPLET: ${{ matrix.vcpkg_tr=
iplet }}</span><br><span>       VCPKG_ROOT: ${{ github.workspace }}/vcpkg</=
span><br><span>       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/in=
stalled</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_=
BINARY_SOURCES: clear;default,readwrite</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e=
6b1fe57497c7</span><br><span>     steps:</span><br><span>       - name: Che=
ckout OpenVPN</span><br><span>         uses: actions/checkout@...2998... # =
v6.0.2</span><br><span>       - uses: lukka/get-cmake@...3028... # v4.3.2</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: Install v=
cpkg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: S=
etup vcpkg</span><br><span>         uses: lukka/run-vcpkg@...3029... # v11.=
6</span><br><span>         with:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149d=
db7c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkg=
GitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      - name: Set up vcpkg binary cache</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache@...493...=
3024... # v5.0.5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
 path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+          key: android-${{ matrix.abi }}-vcpkg-bin=
ary-cache-${{ env.VCPKG_GIT_COMMIT_ID }}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          restore-keys: |</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            android-${{ matrix.abi }}-vcpkg-bina=
ry-cache-</span><br><span>       - name: Install dependencies</span><br><sp=
an>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><br><=
span>       - name: configure OpenVPN with cmake</span><br><span>@@ -70,10 =
+79,12 @@</span><br><span>         arch: [x86, x64]</span><br><span>       =
  build: [Release, Debug]</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    name: &quot;gcc-mingw - ${{ matrix.arch }} - ${{m=
atrix.build }} - OSSL&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    name: &quot;gcc-mingw - ${{ matrix.arch }} - ${{ matrix.build }=
} - OSSL&quot;</span><br><span>     runs-on: ubuntu-24.04</span><br><span> =
    env:</span><br><span>       VCPKG_ROOT: ${{ github.workspace }}/vcpkg</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_BINARY_SO=
URCES: clear;default,readwrite</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe5749=
7c7</span><br><span>     steps:</span><br><span>       - name: Install depe=
ndencies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt =
install -y mingw-w64 unzip build-essential wget python3-docutils man2html-b=
ase</span><br><span>@@ -81,12 +92,21 @@</span><br><span>         uses: acti=
ons/checkout@...2998... # v6.0.2</span><br><span> </span><br><span>       -=
 uses: lukka/get-cmake@...3028... # v4.3.2</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      - name: Restore from cache and install vcpkg</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Setup vcp=
kg</span><br><span>         uses: lukka/run-vcpkg@...3029... # v11.6</span>=
<br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommi=
tId: ${{ env.VCPKG_GIT_COMMIT_ID }}</span><br><span>           vcpkgJsonGlo=
b: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      - name: Set up vcpkg binary cache</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/ca=
che@...3024... # v5.0.5</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
        path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          key: mingw-${{ matrix.arch }}-v=
cpkg-binary-cache-${{ hashFiles(&#39;**/mingw/vcpkg.json&#39;) }}-${{ env.V=
CPKG_GIT_COMMIT_ID }}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+          restore-keys: |</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            mingw-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFil=
es(&#39;**/mingw/vcpkg.json&#39;) }}-</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            mingw-${{ matrix.arch }}-vcpkg-binary-cache-<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
    - name: Run CMake with vcpkg.json manifest</span><br><span>         use=
s: lukka/run-cmake@...3030... # v10.9</span><br><span>         with:</span>=
<br><span>@@ -262,6 +282,8 @@</span><br><span>       name: &quot;msbuild - =
${{ matrix.arch }} - openssl&quot;</span><br><span>       env:</span><br><s=
pan>         BUILD_CONFIGURATION: Release</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        VCPKG_BINARY_SOURCES: clear;default,readwrite=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VCPKG_GIT_C=
OMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7</span><br><span> </span>=
<br><span>       runs-on: windows-2025</span><br><span>       steps:</span>=
<br><span>@@ -271,12 +293,22 @@</span><br><span>       - name: Install rst2=
html</span><br><span>         run: python -m pip install --upgrade pip docu=
tils</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Set=
up vcpkg (do not install any package)</span><br><span>         uses: lukka/=
run-vcpkg@...3029... # v11.6</span><br><span>         with:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: e5a1490e1=
409d175932ef6014519e9ae149ddb7c</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}</spa=
n><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+      -=
 name: Set up vcpkg binary cache</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uses: actions/cache@...3024... # v5.0.5</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        with:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+          path: ${{ env.VCPKG_DEFAULT_BI=
NARY_CACHE }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
    key: msvc-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/w=
indows/vcpkg.json&#39;) }}-${{ env.VCPKG_GIT_COMMIT_ID }}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          restore-keys: |</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msvc-${{ matrix.arc=
h }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/windows/vcpkg.json&#39;) }}-<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msvc-${{=
 matrix.arch }}-vcpkg-binary-cache-</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>       - name: Run CMake with vcpkg.json manifest (NO TESTS)<=
/span><br><span>         uses: lukka/run-cmake@...3030... # v10.9</span><br=
><span>         if: ${{ matrix.arch =3D=3D &#39;arm64&#39; }}</span><br><sp=
an>diff --git a/renovate.json b/renovate.json</span><br><span>index 809ac3f=
..3bd0917 100644</span><br><span>--- a/renovate.json</span><br><span>+++ b/=
renovate.json</span><br><span>@@ -27,7 +27,7 @@</span><br><span>           =
      &quot;/^\\.github/workflows/.+\\.ya?ml$/&quot;</span><br><span>      =
       ],</span><br><span>             &quot;matchStrings&quot;: [</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;vcpkgGit=
CommitId:\\s*(?&lt;currentDigest&gt;.*?)\\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                &quot;VCPKG_GIT_COMMIT_ID:\\s=
*(?&lt;currentDigest&gt;.*?)\\n&quot;</span><br><span>             ],</span=
><br><span>             &quot;currentValueTemplate&quot;: &quot;master&quot=
;,</span><br><span>             &quot;depNameTemplate&quot;: &quot;vcpkg&qu=
ot;,</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1642?usp=3Demail">change 1642</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1642?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I933227aa4bc4f05b58d0e754b43=
30da807504d01 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1642 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Xn2F3anYaKI=--

