From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 8 Sep 2024 12:12:01 +0000
In-Reply-To: <gerrit.1723151372000.I06253be7ed783e3bf30e7df1d6da8ca888016711@...2715...>
References: <gerrit.1723151372000.I06253be7ed783e3bf30e7df1d6da8ca888016711@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <71aa3bb9bd93de25e147291e1f9084e2154111c9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="04G8DzIX7sA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Configure
 Renovate
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

--04G8DzIX7sA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/72=
2?usp=3Demail )

Change subject: GHA: Configure Renovate
......................................................................

GHA: Configure Renovate

Maintain GitHub actions and other version references
in GHA.

Switch some GHA references from branch versions to
tag version so the pinning works correctly.

Change-Id: I06253be7ed783e3bf30e7df1d6da8ca888016711
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20240906151243.69549-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
087.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
A renovate.json
2 files changed, 48 insertions(+), 6 deletions(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 6e361d5..6207c95 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -52,13 +52,13 @@
         uses: actions/checkout@...2691...

       - name: Restore from cache and install vcpkg
-        uses: lukka/run-vcpkg@...2735...
+        uses: lukka/run-vcpkg@...2807...
         with:
           vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2637...
+        uses: lukka/run-cmake@...2808...
         with:
           configurePreset: mingw-${{ matrix.arch }}
           buildPreset: mingw-${{ matrix.arch }}
@@ -274,26 +274,26 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2691...
-      - uses: lukka/get-cmake@...2729...
+      - uses: lukka/get-cmake@...2809...

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils

       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
-        uses: lukka/run-vcpkg@...2735...
+        uses: lukka/run-vcpkg@...2807...
         with:
           vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
-        uses: lukka/run-cmake@...2637...
+        uses: lukka/run-cmake@...2808...
         if: ${{ matrix.arch =3D=3D 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release

       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2637...
+        uses: lukka/run-cmake@...2808...
         if: ${{ matrix.arch !=3D 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
@@ -344,6 +344,7 @@
         uses: actions/checkout@...2691...
         with:
           path: libressl
+          # versioning=3Dsemver-coerced
           repository: libressl/portable
           ref: v3.8.3
       - name: "libressl: autogen.sh"
@@ -403,6 +404,7 @@
         uses: actions/checkout@...2691...
         with:
           path: mbedtls
+          # versioning=3Dsemver-coerced
           repository: Mbed-TLS/mbedtls
           ref: v3.5.2
       - name: "mbedtls: make no_test"
diff --git a/renovate.json b/renovate.json
new file mode 100644
index 0000000..1e69955
--- /dev/null
+++ b/renovate.json
@@ -0,0 +1,40 @@
+{
+    "$schema": "https://docs.renovatebot.com/renovate-schema.json",
+    "packageRules": [
+        {
+            "matchDepTypes": [
+                "action"
+            ],
+            "groupName": "github actions",
+            "pinDigests": true,
+            "extends": [
+                "schedule:monthly"
+            ]
+        },
+        {
+            "matchDepNames": [
+                "vcpkg"
+            ],
+            "extends": [
+                "schedule:monthly"
+            ]
+        }
+    ],
+    "customManagers": [
+        {
+            "customType": "regex",
+            "fileMatch": ["^\\.github/workflows/.+\\.ya?ml$"],
+            "matchStrings": ["vcpkgGitCommitId:\\s*(?<currentDigest>.*?)\\=
n"],
+            "currentValueTemplate": "master",
+            "depNameTemplate": "vcpkg",
+            "packageNameTemplate": "https://github.com/microsoft/vcpkg",
+            "datasourceTemplate": "git-refs"
+        },
+        {
+            "customType": "regex",
+            "fileMatch": ["^\\.github/workflows/.+\\.ya?ml$"],
+            "matchStrings": ["versioning=3D(?<versioning>.*?)\\n\\s*reposi=
tory:\\s*(?<depName>.*?)\\n\\s*ref:\\s*(?<currentValue>.*?)\\n"],
+            "datasourceTemplate": "github-tags"
+        }
+    ]
+}

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/722?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I06253be7ed783e3bf30e7df1d6da8ca888016711
Gerrit-Change-Number: 722
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--04G8DzIX7sA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/722?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Configure Renovate<br><br>Maintain GitHub=
 actions and other version references<br>in GHA.<br><br>Switch some GHA ref=
erences from branch versions to<br>tag version so the pinning works correct=
ly.<br><br>Change-Id: I06253be7ed783e3bf30e7df1d6da8ca888016711<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnob=
yt &lt;yura.uddr@...277...&gt;<br>Message-Id: &lt;20240906151243.69549-1-fr=
ank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg29087.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M .github/workflows/build.yaml<br>A renovate.json<br>2=
 files changed, 48 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 6e361d5..6207c95 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -52,13 +52,13 @@</span><br><span>         uses: actions/c=
heckout@...2691...</span><br><span> </span><br><span>       - name: Restore=
 from cache and install vcpkg</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        uses: lukka/run-vcpkg@...2735...</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2807...</span=
><br><span>         with:</span><br><span>           vcpkgGitCommitId: 8d36=
49ba34aab36914ddd897958599aa0a91b08e</span><br><span>           vcpkgJsonGl=
ob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>       =
- name: Run CMake with vcpkg.json manifest</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@...2637...</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@...493...=
2808...</span><br><span>         with:</span><br><span>           configure=
Preset: mingw-${{ matrix.arch }}</span><br><span>           buildPreset: mi=
ngw-${{ matrix.arch }}</span><br><span>@@ -274,26 +274,26 @@</span><br><spa=
n>       runs-on: windows-latest</span><br><span>       steps:</span><br><s=
pan>       - uses: actions/checkout@...2691...</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2729...</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake=
@...2809...</span><br><span> </span><br><span>       - name: Install rst2ht=
ml</span><br><span>         run: python -m pip install --upgrade pip docuti=
ls</span><br><span> </span><br><span>       - name: Restore artifacts, or s=
etup vcpkg (do not install any package)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        uses: lukka/run-vcpkg@...2735...</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2811...=
7...</span><br><span>         with:</span><br><span>           vcpkgGitComm=
itId: 8d3649ba34aab36914ddd897958599aa0a91b08e</span><br><span>           v=
cpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </span><br><=
span>       - name: Run CMake with vcpkg.json manifest (NO TESTS)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@...220...=
..2637...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: lukka/run-cmake@...2808...</span><br><span>         if: ${{ matrix.arch=
 =3D=3D &#39;arm64&#39; }}</span><br><span>         with:</span><br><span> =
          configurePreset: win-${{ matrix.arch }}-release</span><br><span> =
          buildPreset: win-${{ matrix.arch }}-release</span><br><span> </sp=
an><br><span>       - name: Run CMake with vcpkg.json manifest</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@...1665...=
637...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses:=
 lukka/run-cmake@...2808...</span><br><span>         if: ${{ matrix.arch !=
=3D &#39;arm64&#39; }}</span><br><span>         with:</span><br><span>     =
      configurePreset: win-${{ matrix.arch }}-release</span><br><span>@@ -3=
44,6 +344,7 @@</span><br><span>         uses: actions/checkout@...2691...</=
span><br><span>         with:</span><br><span>           path: libressl</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          # versioning=
=3Dsemver-coerced</span><br><span>           repository: libressl/portable<=
/span><br><span>           ref: v3.8.3</span><br><span>       - name: &quot=
;libressl: autogen.sh&quot;</span><br><span>@@ -403,6 +404,7 @@</span><br><=
span>         uses: actions/checkout@...2691...</span><br><span>         wi=
th:</span><br><span>           path: mbedtls</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+          # versioning=3Dsemver-coerced</span><br>=
<span>           repository: Mbed-TLS/mbedtls</span><br><span>           re=
f: v3.5.2</span><br><span>       - name: &quot;mbedtls: make no_test&quot;<=
/span><br><span>diff --git a/renovate.json b/renovate.json</span><br><span>=
new file mode 100644</span><br><span>index 0000000..1e69955</span><br><span=
>--- /dev/null</span><br><span>+++ b/renovate.json</span><br><span>@@ -0,0 =
+1,40 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;$schema&quot;: &quo=
t;https://docs.renovatebot.com/renovate-schema.json&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;packageRules&quot;: [</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;matchDepTypes&qu=
ot;: [</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   &quot;action&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            ],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;groupName&quot;: &quot;github actions&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;pinDigests&quot;:=
 true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &=
quot;extends&quot;: [</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                &quot;schedule:monthly&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            ]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;matchDepNames&quot;: [</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                &quot;vcpkg&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            ],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;extends&quot;: [</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;sche=
dule:monthly&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ],</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;customManagers&quot;=
: [</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;customTy=
pe&quot;: &quot;regex&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot;fileMatch&quot;: [&quot;^\\.github/workflows/.+\=
\.ya?ml$&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;matchStrings&quot;: [&quot;vcpkgGitCommitId:\\s*(?&lt;curren=
tDigest&gt;.*?)\\n&quot;],</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;currentValueTemplate&quot;: &quot;master&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;depN=
ameTemplate&quot;: &quot;vcpkg&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;packageNameTemplate&quot;: &quot;https:=
//github.com/microsoft/vcpkg&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;datasourceTemplate&quot;: &quot;git-refs&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            &quot;customType&quot=
;: &quot;regex&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;fileMatch&quot;: [&quot;^\\.github/workflows/.+\\.ya?ml=
$&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &quot;matchStrings&quot;: [&quot;versioning=3D(?&lt;versioning&gt;.*?)\\n=
\\s*repository:\\s*(?&lt;depName&gt;.*?)\\n\\s*ref:\\s*(?&lt;currentValue&g=
t;.*?)\\n&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;datasourceTemplate&quot;: &quot;github-tags&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/722?usp=3Demail">change 72=
2</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/722?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I06253be7ed783e3bf30e7df1d6d=
a8ca888016711 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 722 </div>
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


--04G8DzIX7sA=--

