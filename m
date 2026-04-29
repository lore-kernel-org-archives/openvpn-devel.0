From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Apr 2026 13:18:58 +0000
In-Reply-To: <gerrit.1777390515000.I933227aa4bc4f05b58d0e754b4330da807504d01@...2715...>
References: <gerrit.1777390515000.I933227aa4bc4f05b58d0e754b4330da807504d01@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <afd7887b572ba4ad9c70e17bee305150bb7878ff-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="trKCfWLKN2Y="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: uddr <yura.uddr@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--trKCfWLKN2Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
42?usp=3Demail )

Change subject: GHA: Add caching for vcpkg builds
......................................................................

GHA: Add caching for vcpkg builds

The nice automatic caching was removed last year,
so go back to manual caching of the binary cache
dir.

While here, also update vcpkg to latest master.

Change-Id: I933227aa4bc4f05b58d0e754b4330da807504d01
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1642
Message-Id: <20260429093938.23601-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
775.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M renovate.json
2 files changed, 40 insertions(+), 8 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I933227aa4bc4f05b58d0e754b4330da807504d01
Gerrit-Change-Number: 1642
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--trKCfWLKN2Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1642?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: Add caching for vcpkg builds<br><br>The nic=
e automatic caching was removed last year,<br>so go back to manual caching =
of the binary cache<br>dir.<br><br>While here, also update vcpkg to latest =
master.<br><br>Change-Id: I933227aa4bc4f05b58d0e754b4330da807504d01<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Da=
rnobyt &lt;yura.uddr@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.ne=
t/c/openvpn/+/1642<br>Message-Id: &lt;20260429093938.23601-1-gert@...2132...=
.&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...290...=
net/msg36775.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M .github/workflows/build.yaml<br>M renovate.json<br>2 files change=
d, 40 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 895f469..b530fcc 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -42,14 +42,23 @@</span><br><span>       VCPKG_DEFAULT_TRI=
PLET: ${{ matrix.vcpkg_triplet }}</span><br><span>       VCPKG_ROOT: ${{ gi=
thub.workspace }}/vcpkg</span><br><span>       VCPKG_INSTALLED_DIR: ${{ git=
hub.workspace }}/vcpkg/installed</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 031=
f4afe03be385aee354f15be6e6b1fe57497c7</span><br><span>     steps:</span><br=
><span>       - name: Checkout OpenVPN</span><br><span>         uses: actio=
ns/checkout@...2998... # v6.0.2</span><br><span>       - uses: lukka/get-cm=
ake@...3028... # v4.3.2</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-      - name: Install vcpkg</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      - name: Setup vcpkg</span><br><span>         uses: lukka/ru=
n-vcpkg@...3029... # v11.6</span><br><span>         with:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: e5a1490e140=
9d175932ef6014519e9ae149ddb7c</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Set up vcpkg=
 binary cache</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  uses: actions/cache@...3024... # v5.0.5</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        with:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          key: android-${=
{ matrix.abi }}-vcpkg-binary-cache-${{ env.VCPKG_GIT_COMMIT_ID }}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+          restore-keys: |</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            android-${{=
 matrix.abi }}-vcpkg-binary-cache-</span><br><span>       - name: Install d=
ependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg install opens=
sl lz4 cmocka</span><br><span>       - name: configure OpenVPN with cmake</=
span><br><span>@@ -70,10 +79,12 @@</span><br><span>         arch: [x86, x64=
]</span><br><span>         build: [Release, Debug]</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    name: &quot;gcc-mingw - =
${{ matrix.arch }} - ${{matrix.build }} - OSSL&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    name: &quot;gcc-mingw - ${{ matrix.ar=
ch }} - ${{ matrix.build }} - OSSL&quot;</span><br><span>     runs-on: ubun=
tu-24.04</span><br><span>     env:</span><br><span>       VCPKG_ROOT: ${{ g=
ithub.workspace }}/vcpkg</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 031f4afe03b=
e385aee354f15be6e6b1fe57497c7</span><br><span>     steps:</span><br><span> =
      - name: Install dependencies</span><br><span>         run: sudo apt u=
pdate &amp;&amp; sudo apt install -y mingw-w64 unzip build-essential wget p=
ython3-docutils man2html-base</span><br><span>@@ -81,12 +92,21 @@</span><br=
><span>         uses: actions/checkout@...2998... # v6.0.2</span><br><span>=
 </span><br><span>       - uses: lukka/get-cmake@...3028... # v4.3.2</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: Restore from c=
ache and install vcpkg</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      - name: Setup vcpkg</span><br><span>         uses: lukka/run-vcpkg=
@...3029... # v11.6</span><br><span>         with:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: e5a1490e1409d17593=
2ef6014519e9ae149ddb7c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}</span><br><sp=
an>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Set =
up vcpkg binary cache</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uses: actions/cache@...3024... # v5.0.5</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        with:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE =
}}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          key: mi=
ngw-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/mingw/vcpkg=
.json&#39;) }}-${{ env.VCPKG_GIT_COMMIT_ID }}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+          restore-keys: |</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mingw-${{ matrix.arch }}-vcpk=
g-binary-cache-${{ hashFiles(&#39;**/mingw/vcpkg.json&#39;) }}-</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            mingw-${{ matrix.ar=
ch }}-vcpkg-binary-cache-</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>       - name: Run CMake with vcpkg.json manifest</s=
pan><br><span>         uses: lukka/run-cmake@...3030... # v10.9</span><br><=
span>         with:</span><br><span>@@ -262,6 +282,8 @@</span><br><span>   =
    name: &quot;msbuild - ${{ matrix.arch }} - openssl&quot;</span><br><spa=
n>       env:</span><br><span>         BUILD_CONFIGURATION: Release</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        VCPKG_BINARY_SOURCE=
S: clear;default,readwrite</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c=
7</span><br><span> </span><br><span>       runs-on: windows-2025</span><br>=
<span>       steps:</span><br><span>@@ -271,12 +293,22 @@</span><br><span> =
      - name: Install rst2html</span><br><span>         run: python -m pip =
install --upgrade pip docutils</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      - name: Restore artifacts, or setup vcpkg =
(do not install any package)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      - name: Setup vcpkg (do not install any package)</span><br><=
span>         uses: lukka/run-vcpkg@...3029... # v11.6</span><br><span>    =
     with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          v=
cpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: ${{ env.V=
CPKG_GIT_COMMIT_ID }}</span><br><span>           vcpkgJsonGlob: &#39;**/win=
dows/vcpkg.json&#39;</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      - name: Set up vcpkg binary cache</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache@...3036...=
.. # v5.0.5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          path=
: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          key: msvc-${{ matrix.arch }}-vcpkg-binary-cac=
he-${{ hashFiles(&#39;**/windows/vcpkg.json&#39;) }}-${{ env.VCPKG_GIT_COMM=
IT_ID }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          r=
estore-keys: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msvc-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/win=
dows/vcpkg.json&#39;) }}-</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msvc-${{ matrix.arch }}-vcpkg-binary-cache-</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>       - name: Run CMake with vcpkg=
.json manifest (NO TESTS)</span><br><span>         uses: lukka/run-cmake@...1186...=
.3030... # v10.9</span><br><span>         if: ${{ matrix.arch =3D=3D &#39;a=
rm64&#39; }}</span><br><span>diff --git a/renovate.json b/renovate.json</sp=
an><br><span>index 809ac3f..3bd0917 100644</span><br><span>--- a/renovate.j=
son</span><br><span>+++ b/renovate.json</span><br><span>@@ -27,7 +27,7 @@</=
span><br><span>                 &quot;/^\\.github/workflows/.+\\.ya?ml$/&qu=
ot;</span><br><span>             ],</span><br><span>             &quot;matc=
hStrings&quot;: [</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            &quot;vcpkgGitCommitId:\\s*(?&lt;currentDigest&gt;.*?)\\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &qu=
ot;VCPKG_GIT_COMMIT_ID:\\s*(?&lt;currentDigest&gt;.*?)\\n&quot;</span><br><=
span>             ],</span><br><span>             &quot;currentValueTemplat=
e&quot;: &quot;master&quot;,</span><br><span>             &quot;depNameTemp=
late&quot;: &quot;vcpkg&quot;,</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1642?usp=3Demail">c=
hange 1642</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1642?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I933227aa4bc4f05b58d0e754b43=
30da807504d01 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1642 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--trKCfWLKN2Y=--

