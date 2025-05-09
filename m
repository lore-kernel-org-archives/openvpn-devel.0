From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 9 May 2025 16:23:47 +0000
References: <gerrit.1746807825000.I515f96c99f92ba144b60e8504cee74915de3efa3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <99f1c66fbaf3078ccc29e986e0a6e705c899078f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qWqQvcaxOUw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Dependency and
 Actions update May 2025
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

--qWqQvcaxOUw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1001?usp=3Demail

to review the following change.


Change subject: GHA: Dependency and Actions update May 2025
......................................................................

GHA: Dependency and Actions update May 2025

chore(deps): update dependency aws/aws-lc to v1.51.2
chore(deps): update github actions
chore(deps): update dependency libressl/portable to v4.1.0
chore(config): migrate config renovate.json
chore(deps): update vcpkg digest to b12aa38

Change-Id: I515f96c99f92ba144b60e8504cee74915de3efa3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M renovate.json
2 files changed, 22 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1001/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 0f5e617..d4fdc9d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -54,11 +54,11 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2881... # v4.0.0
+      - uses: lukka/get-cmake@...2893... # v4.0.1
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
+          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -88,11 +88,11 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2

-      - uses: lukka/get-cmake@...2881... # v4.0.0
+      - uses: lukka/get-cmake@...2893... # v4.0.1
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
+          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -131,7 +131,7 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2869... # v4.2.1
+        uses: actions/download-artifact@...2894... # v4.3.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -276,7 +276,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2881... # v4.0.0
+      - uses: lukka/get-cmake@...2893... # v4.0.1

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -284,7 +284,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
+          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -348,7 +348,7 @@
           path: libressl
           # versioning=3Dsemver-coerced
           repository: libressl/portable
-          ref: v4.0.0
+          ref: v4.1.0
       - name: "libressl: autogen.sh"
         env:
           LIBRESSL_GIT_OPTIONS: "--no-single-branch"
@@ -471,8 +471,8 @@
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.49.1
-      - uses: lukka/get-cmake@...2881... # v4.0.0
+          ref: v1.51.2
+      - uses: lukka/get-cmake@...2893... # v4.0.1
       - name: "AWS-LC: build"
         run: |
           mkdir build
diff --git a/renovate.json b/renovate.json
index 1e69955..d0f319d 100644
--- a/renovate.json
+++ b/renovate.json
@@ -23,8 +23,12 @@
     "customManagers": [
         {
             "customType": "regex",
-            "fileMatch": ["^\\.github/workflows/.+\\.ya?ml$"],
-            "matchStrings": ["vcpkgGitCommitId:\\s*(?<currentDigest>.*?)\\=
n"],
+            "managerFilePatterns": [
+                "/^\\.github/workflows/.+\\.ya?ml$/"
+            ],
+            "matchStrings": [
+                "vcpkgGitCommitId:\\s*(?<currentDigest>.*?)\\n"
+            ],
             "currentValueTemplate": "master",
             "depNameTemplate": "vcpkg",
             "packageNameTemplate": "https://github.com/microsoft/vcpkg",
@@ -32,8 +36,12 @@
         },
         {
             "customType": "regex",
-            "fileMatch": ["^\\.github/workflows/.+\\.ya?ml$"],
-            "matchStrings": ["versioning=3D(?<versioning>.*?)\\n\\s*reposi=
tory:\\s*(?<depName>.*?)\\n\\s*ref:\\s*(?<currentValue>.*?)\\n"],
+            "managerFilePatterns": [
+                "/^\\.github/workflows/.+\\.ya?ml$/"
+            ],
+            "matchStrings": [
+                "versioning=3D(?<versioning>.*?)\\n\\s*repository:\\s*(?<d=
epName>.*?)\\n\\s*ref:\\s*(?<currentValue>.*?)\\n"
+            ],
             "datasourceTemplate": "github-tags"
         }
     ]

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1001?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I515f96c99f92ba144b60e8504cee74915de3efa3
Gerrit-Change-Number: 1001
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--qWqQvcaxOUw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1001?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">GHA: Dependency and Actions update May 2025<br><br>chore(dep=
s): update dependency aws/aws-lc to v1.51.2<br>chore(deps): update github a=
ctions<br>chore(deps): update dependency libressl/portable to v4.1.0<br>cho=
re(config): migrate config renovate.json<br>chore(deps): update vcpkg diges=
t to b12aa38<br><br>Change-Id: I515f96c99f92ba144b60e8504cee74915de3efa3<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .git=
hub/workflows/build.yaml<br>M renovate.json<br>2 files changed, 22 insertio=
ns(+), 14 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/01/1001/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.y=
aml b/.github/workflows/build.yaml</span><br><span>index 0f5e617..d4fdc9d 1=
00644</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>++=
+ b/.github/workflows/build.yaml</span><br><span>@@ -54,11 +54,11 @@</span>=
<br><span>     steps:</span><br><span>       - name: Checkout OpenVPN</span=
><br><span>         uses: actions/checkout@...2844... # v4.2.2</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...1665...=
881... # v4.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  - uses: lukka/get-cmake@...2893... # v4.0.1</span><br><span>       - name=
: Install vcpkg</span><br><span>         uses: lukka/run-vcpkg@...2815... #=
 v11.5</span><br><span>         with:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59=
a058d3687</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5</span><br><span>=
       - name: Install dependencies</span><br><span>         run: ${VCPKG_R=
OOT}/vcpkg install openssl lz4 cmocka</span><br><span>       - name: config=
ure OpenVPN with cmake</span><br><span>@@ -88,11 +88,11 @@</span><br><span>=
       - name: Checkout OpenVPN</span><br><span>         uses: actions/chec=
kout@...2844... # v4.2.2</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2881... # v4.0.0</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-=
cmake@...2893... # v4.0.1</span><br><span>       - name: Restore from cache=
 and install vcpkg</span><br><span>         uses: lukka/run-vcpkg@...2895...=
. # v11.5</span><br><span>         with:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441=
f59a058d3687</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
   vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5</span><br><sp=
an>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span>=
 </span><br><span>       - name: Run CMake with vcpkg.json manifest</span><=
br><span>@@ -131,7 +131,7 @@</span><br><span>       - name: Checkout OpenVP=
N</span><br><span>         uses: actions/checkout@...2844... # v4.2.2</span=
><br><span>       - name: Retrieve mingw unittest</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        uses: actions/download-artifact@...2874...=
... # v4.2.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/download-artifact@...2894... # v4.3.0</span><br><span>      =
   with:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }}-=
tests</span><br><span>           path: unittests</span><br><span>@@ -276,7 =
+276,7 @@</span><br><span>       runs-on: windows-latest</span><br><span>  =
     steps:</span><br><span>       - uses: actions/checkout@...2844... # v4=
.2.2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: luk=
ka/get-cmake@...2881... # v4.0.0</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      - uses: lukka/get-cmake@...2893... # v4.0.1</span><br><s=
pan> </span><br><span>       - name: Install rst2html</span><br><span>     =
    run: python -m pip install --upgrade pip docutils</span><br><span>@@ -2=
84,7 +284,7 @@</span><br><span>       - name: Restore artifacts, or setup v=
cpkg (do not install any package)</span><br><span>         uses: lukka/run-=
vcpkg@...2815... # v11.5</span><br><span>         with:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: 856505bb76745=
8c99d8e3c3ed441f59a058d3687</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc=
5</span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;=
</span><br><span> </span><br><span>       - name: Run CMake with vcpkg.json=
 manifest (NO TESTS)</span><br><span>@@ -348,7 +348,7 @@</span><br><span>  =
         path: libressl</span><br><span>           # versioning=3Dsemver-co=
erced</span><br><span>           repository: libressl/portable</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-          ref: v4.0.0</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+          ref: v4.1.0</span><br>=
<span>       - name: &quot;libressl: autogen.sh&quot;</span><br><span>     =
    env:</span><br><span>           LIBRESSL_GIT_OPTIONS: &quot;--no-single=
-branch&quot;</span><br><span>@@ -471,8 +471,8 @@</span><br><span>         =
  path: aws-lc</span><br><span>           # versioning=3Dsemver-coerced</sp=
an><br><span>           repository: aws/aws-lc</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-          ref: v1.49.1</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2881... # v4.0.0=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: v1.5=
1.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lu=
kka/get-cmake@...2893... # v4.0.1</span><br><span>       - name: &quot;AWS-=
LC: build&quot;</span><br><span>         run: |</span><br><span>           =
mkdir build</span><br><span>diff --git a/renovate.json b/renovate.json</spa=
n><br><span>index 1e69955..d0f319d 100644</span><br><span>--- a/renovate.js=
on</span><br><span>+++ b/renovate.json</span><br><span>@@ -23,8 +23,12 @@</=
span><br><span>     &quot;customManagers&quot;: [</span><br><span>         =
{</span><br><span>             &quot;customType&quot;: &quot;regex&quot;,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;fileM=
atch&quot;: [&quot;^\\.github/workflows/.+\\.ya?ml$&quot;],</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            &quot;matchStrings&quot;:=
 [&quot;vcpkgGitCommitId:\\s*(?&lt;currentDigest&gt;.*?)\\n&quot;],</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;managerFi=
lePatterns&quot;: [</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot;/^\\.github/workflows/.+\\.ya?ml$/&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            ],</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;matchStrings&quot;:=
 [</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &=
quot;vcpkgGitCommitId:\\s*(?&lt;currentDigest&gt;.*?)\\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            ],</span><br><span> =
            &quot;currentValueTemplate&quot;: &quot;master&quot;,</span><br=
><span>             &quot;depNameTemplate&quot;: &quot;vcpkg&quot;,</span><=
br><span>             &quot;packageNameTemplate&quot;: &quot;https://github=
.com/microsoft/vcpkg&quot;,</span><br><span>@@ -32,8 +36,12 @@</span><br><s=
pan>         },</span><br><span>         {</span><br><span>             &qu=
ot;customType&quot;: &quot;regex&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            &quot;fileMatch&quot;: [&quot;^\\.github/work=
flows/.+\\.ya?ml$&quot;],</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            &quot;matchStrings&quot;: [&quot;versioning=3D(?&lt;version=
ing&gt;.*?)\\n\\s*repository:\\s*(?&lt;depName&gt;.*?)\\n\\s*ref:\\s*(?&lt;=
currentValue&gt;.*?)\\n&quot;],</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;managerFilePatterns&quot;: [</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                &quot;/^\\.github/wo=
rkflows/.+\\.ya?ml$/&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ],</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;matchStrings&quot;: [</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                &quot;versioning=3D(?&lt;versioning&g=
t;.*?)\\n\\s*repository:\\s*(?&lt;depName&gt;.*?)\\n\\s*ref:\\s*(?&lt;curre=
ntValue&gt;.*?)\\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ],</span><br><span>             &quot;datasourceTemplate&q=
uot;: &quot;github-tags&quot;</span><br><span>         }</span><br><span>  =
   ]</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1001?usp=3Demail">change 1001</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1001?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I515f96c99f92ba144b60e8504ce=
e74915de3efa3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1001 </div>
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


--qWqQvcaxOUw=--

