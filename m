From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 9 Jul 2025 11:47:00 +0000
References: <gerrit.1752061618000.I6122225cc12c4f299a2a48db24bc7379ac6c5921@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b0d82f7dc9a086232ab22cd28aef244dd8fd477a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EHh01AxrV04="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Dependency
 updates July 2025
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

--EHh01AxrV04=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1079?usp=3Demail

to review the following change.


Change subject: GHA: Dependency updates July 2025
......................................................................

GHA: Dependency updates July 2025

chore(deps): update dependency aws/aws-lc to v1.55.0
chore(deps): update lukka/get-cmake action to v4.0.3
chore(deps): update vcpkg digest to f33cc49

Change-Id: I6122225cc12c4f299a2a48db24bc7379ac6c5921
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 8 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1079/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d4fdc9d..f02a182 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -54,11 +54,11 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2893... # v4.0.1
+      - uses: lukka/get-cmake@...2897... # v4.0.3
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -88,11 +88,11 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2

-      - uses: lukka/get-cmake@...2893... # v4.0.1
+      - uses: lukka/get-cmake@...2897... # v4.0.3
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -276,7 +276,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2893... # v4.0.1
+      - uses: lukka/get-cmake@...2897... # v4.0.3

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -284,7 +284,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -471,8 +471,8 @@
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.51.2
-      - uses: lukka/get-cmake@...2893... # v4.0.1
+          ref: v1.55.0
+      - uses: lukka/get-cmake@...2897... # v4.0.3
       - name: "AWS-LC: build"
         run: |
           mkdir build

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1079?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6122225cc12c4f299a2a48db24bc7379ac6c5921
Gerrit-Change-Number: 1079
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--EHh01AxrV04=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1079?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">GHA: Dependency updates July 2025<br><br>chore(deps): update=
 dependency aws/aws-lc to v1.55.0<br>chore(deps): update lukka/get-cmake ac=
tion to v4.0.3<br>chore(deps): update vcpkg digest to f33cc49<br><br>Change=
-Id: I6122225cc12c4f299a2a48db24bc7379ac6c5921<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>---<br>M .github/workflows/build.yaml<b=
r>1 file changed, 8 insertions(+), 8 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/79/1079/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br=
><span>index d4fdc9d..f02a182 100644</span><br><span>--- a/.github/workflow=
s/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><=
span>@@ -54,11 +54,11 @@</span><br><span>     steps:</span><br><span>      =
 - name: Checkout OpenVPN</span><br><span>         uses: actions/checkout@...220...=
..2844... # v4.2.2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   - uses: lukka/get-cmake@...2893... # v4.0.1</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2897... # v4.0.=
3</span><br><span>       - name: Install vcpkg</span><br><span>         use=
s: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: =
b12aa38a44a29bd8461404f2514e4c7cf00e1fc5</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da16=
67c1458e6d7abf</span><br><span>       - name: Install dependencies</span><b=
r><span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span>=
<br><span>       - name: configure OpenVPN with cmake</span><br><span>@@ -8=
8,11 +88,11 @@</span><br><span>       - name: Checkout OpenVPN</span><br><s=
pan>         uses: actions/checkout@...2844... # v4.2.2</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get=
-cmake@...2893... # v4.0.1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      - uses: lukka/get-cmake@...2897... # v4.0.3</span><br><span>  =
     - name: Restore from cache and install vcpkg</span><br><span>         =
uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitI=
d: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6d=
a1667c1458e6d7abf</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/v=
cpkg.json&#39;</span><br><span> </span><br><span>       - name: Run CMake w=
ith vcpkg.json manifest</span><br><span>@@ -276,7 +276,7 @@</span><br><span=
>       runs-on: windows-latest</span><br><span>       steps:</span><br><sp=
an>       - uses: actions/checkout@...2844... # v4.2.2</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2893... #=
 v4.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses=
: lukka/get-cmake@...2897... # v4.0.3</span><br><span> </span><br><span>   =
    - name: Install rst2html</span><br><span>         run: python -m pip in=
stall --upgrade pip docutils</span><br><span>@@ -284,7 +284,7 @@</span><br>=
<span>       - name: Restore artifacts, or setup vcpkg (do not install any =
package)</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5<=
/span><br><span>         with:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1f=
c5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGi=
tCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf</span><br><span>       =
    vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </span>=
<br><span>       - name: Run CMake with vcpkg.json manifest (NO TESTS)</spa=
n><br><span>@@ -471,8 +471,8 @@</span><br><span>           path: aws-lc</sp=
an><br><span>           # versioning=3Dsemver-coerced</span><br><span>     =
      repository: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-          ref: v1.51.2</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-      - uses: lukka/get-cmake@...2893... # v4.0.1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          ref: v1.55.0</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...1665...=
897... # v4.0.3</span><br><span>       - name: &quot;AWS-LC: build&quot;</s=
pan><br><span>         run: |</span><br><span>           mkdir build</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1079?usp=3Demail">change 1079</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1079?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6122225cc12c4f299a2a48db24b=
c7379ac6c5921 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1079 </div>
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


--EHh01AxrV04=--

