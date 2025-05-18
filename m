From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 18 May 2025 16:28:59 +0000
In-Reply-To: <gerrit.1746807825000.I515f96c99f92ba144b60e8504cee74915de3efa3@...2715...>
References: <gerrit.1746807825000.I515f96c99f92ba144b60e8504cee74915de3efa3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e4d94cb35df11a8da36838428165ba1e88885103-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JJ224Hb4SM0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JJ224Hb4SM0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1001?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


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
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20250518153724.8099-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
682.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M renovate.json
2 files changed, 22 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1001/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--JJ224Hb4SM0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1001?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by uddr</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">GHA: Dependency and Actions update May 2025<br><br>ch=
ore(deps): update dependency aws/aws-lc to v1.51.2<br>chore(deps): update g=
ithub actions<br>chore(deps): update dependency libressl/portable to v4.1.0=
<br>chore(config): migrate config renovate.json<br>chore(deps): update vcpk=
g digest to b12aa38<br><br>Change-Id: I515f96c99f92ba144b60e8504cee74915de3=
efa3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-=
by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>Message-Id: &lt;202505181=
53724.8099-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg31682.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>M reno=
vate.json<br>2 files changed, 22 insertions(+), 14 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1001/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 0f5e617..d4fdc9d 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -54,11 +54,11 @@</span><br><span>     steps:</span><br><s=
pan>       - name: Checkout OpenVPN</span><br><span>         uses: actions/=
checkout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      - uses: lukka/get-cmake@...2881... # v4.0.0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2896...=
.. # v4.0.1</span><br><span>       - name: Install vcpkg</span><br><span>  =
       uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         wi=
th:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGit=
CommitId: 856505bb767458c99d8e3c3ed441f59a058d3687</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: b12aa38a44a29bd8=
461404f2514e4c7cf00e1fc5</span><br><span>       - name: Install dependencie=
s</span><br><span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmo=
cka</span><br><span>       - name: configure OpenVPN with cmake</span><br><=
span>@@ -88,11 +88,11 @@</span><br><span>       - name: Checkout OpenVPN</s=
pan><br><span>         uses: actions/checkout@...2844... # v4.2.2</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses:=
 lukka/get-cmake@...2881... # v4.0.0</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      - uses: lukka/get-cmake@...2893... # v4.0.1</span><b=
r><span>       - name: Restore from cache and install vcpkg</span><br><span=
>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>        =
 with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkg=
GitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: b12aa38a44a29=
bd8461404f2514e4c7cf00e1fc5</span><br><span>           vcpkgJsonGlob: &#39;=
**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>       - name: R=
un CMake with vcpkg.json manifest</span><br><span>@@ -131,7 +131,7 @@</span=
><br><span>       - name: Checkout OpenVPN</span><br><span>         uses: a=
ctions/checkout@...2844... # v4.2.2</span><br><span>       - name: Retrieve=
 mingw unittest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  uses: actions/download-artifact@...2869... # v4.2.1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/download-artifact@...220...=
..2894... # v4.3.0</span><br><span>         with:</span><br><span>         =
  name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>           p=
ath: unittests</span><br><span>@@ -276,7 +276,7 @@</span><br><span>       r=
uns-on: windows-latest</span><br><span>       steps:</span><br><span>      =
 - uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2881... # v4.0.0</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/g=
et-cmake@...2893... # v4.0.1</span><br><span> </span><br><span>       - nam=
e: Install rst2html</span><br><span>         run: python -m pip install --u=
pgrade pip docutils</span><br><span>@@ -284,7 +284,7 @@</span><br><span>   =
    - name: Restore artifacts, or setup vcpkg (do not install any package)<=
/span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br=
><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId=
: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5</span><br><span>           vcpkg=
JsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </span><br><span=
>       - name: Run CMake with vcpkg.json manifest (NO TESTS)</span><br><sp=
an>@@ -348,7 +348,7 @@</span><br><span>           path: libressl</span><br>=
<span>           # versioning=3Dsemver-coerced</span><br><span>           r=
epository: libressl/portable</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-          ref: v4.0.0</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          ref: v4.1.0</span><br><span>       - name: &quot;libress=
l: autogen.sh&quot;</span><br><span>         env:</span><br><span>         =
  LIBRESSL_GIT_OPTIONS: &quot;--no-single-branch&quot;</span><br><span>@@ -=
471,8 +471,8 @@</span><br><span>           path: aws-lc</span><br><span>   =
        # versioning=3Dsemver-coerced</span><br><span>           repository=
: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
 ref: v1.49.1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - =
uses: lukka/get-cmake@...2881... # v4.0.0</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+          ref: v1.51.2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2893... # v4.0.1<=
/span><br><span>       - name: &quot;AWS-LC: build&quot;</span><br><span>  =
       run: |</span><br><span>           mkdir build</span><br><span>diff -=
-git a/renovate.json b/renovate.json</span><br><span>index 1e69955..d0f319d=
 100644</span><br><span>--- a/renovate.json</span><br><span>+++ b/renovate.=
json</span><br><span>@@ -23,8 +23,12 @@</span><br><span>     &quot;customMa=
nagers&quot;: [</span><br><span>         {</span><br><span>             &qu=
ot;customType&quot;: &quot;regex&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            &quot;fileMatch&quot;: [&quot;^\\.github/work=
flows/.+\\.ya?ml$&quot;],</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            &quot;matchStrings&quot;: [&quot;vcpkgGitCommitId:\\s*(?&lt=
;currentDigest&gt;.*?)\\n&quot;],</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &quot;managerFilePatterns&quot;: [</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                &quot;/^\\.github/=
workflows/.+\\.ya?ml$/&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            ],</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;matchStrings&quot;: [</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                &quot;vcpkgGitCommitId:\\s*(?&lt;cu=
rrentDigest&gt;.*?)\\n&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            ],</span><br><span>             &quot;currentValueTemp=
late&quot;: &quot;master&quot;,</span><br><span>             &quot;depNameT=
emplate&quot;: &quot;vcpkg&quot;,</span><br><span>             &quot;packag=
eNameTemplate&quot;: &quot;https://github.com/microsoft/vcpkg&quot;,</span>=
<br><span>@@ -32,8 +36,12 @@</span><br><span>         },</span><br><span>  =
       {</span><br><span>             &quot;customType&quot;: &quot;regex&q=
uot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quo=
t;fileMatch&quot;: [&quot;^\\.github/workflows/.+\\.ya?ml$&quot;],</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;matchStrings=
&quot;: [&quot;versioning=3D(?&lt;versioning&gt;.*?)\\n\\s*repository:\\s*(=
?&lt;depName&gt;.*?)\\n\\s*ref:\\s*(?&lt;currentValue&gt;.*?)\\n&quot;],</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;mana=
gerFilePatterns&quot;: [</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;/^\\.github/workflows/.+\\.ya?ml$/&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ],</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;matchStrings&q=
uot;: [</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    &quot;versioning=3D(?&lt;versioning&gt;.*?)\\n\\s*repository:\\s*(?&lt;=
depName&gt;.*?)\\n\\s*ref:\\s*(?&lt;currentValue&gt;.*?)\\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            ],</span><br><spa=
n>             &quot;datasourceTemplate&quot;: &quot;github-tags&quot;</spa=
n><br><span>         }</span><br><span>     ]</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1001=
?usp=3Demail">change 1001</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1001?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I515f96c99f92ba144b60e8504ce=
e74915de3efa3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1001 </div>
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


--JJ224Hb4SM0=--

