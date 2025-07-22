From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 22 Jul 2025 16:15:57 +0000
In-Reply-To: <gerrit.1752061618000.I6122225cc12c4f299a2a48db24bc7379ac6c5921@...2715...>
References: <gerrit.1752061618000.I6122225cc12c4f299a2a48db24bc7379ac6c5921@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a6b6479bce340c5380cddaed7cab1fe402b0981f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0jaX2TVUlgs="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0jaX2TVUlgs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1079?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


Change subject: GHA: Dependency updates July 2025
......................................................................

GHA: Dependency updates July 2025

chore(deps): update dependency aws/aws-lc to v1.55.0
chore(deps): update lukka/get-cmake action to v4.0.3
chore(deps): update vcpkg digest to f33cc49
chore(deps): update dependency mbed-tls/mbedtls to v3.6.4

Change-Id: I6122225cc12c4f299a2a48db24bc7379ac6c5921
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20250722102718.85403-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
242.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 9 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1079/6

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d4fdc9d..bd5895b 100644
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
@@ -413,7 +413,7 @@
           submodules: true
           # versioning=3Dsemver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.3
+          ref: v3.6.4
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=3D1
         working-directory: mbedtls
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
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--0jaX2TVUlgs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1079?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by uddr</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">GHA: Dependency updates July 2025<br><br>chore(deps):=
 update dependency aws/aws-lc to v1.55.0<br>chore(deps): update lukka/get-c=
make action to v4.0.3<br>chore(deps): update vcpkg digest to f33cc49<br>cho=
re(deps): update dependency mbed-tls/mbedtls to v3.6.4<br><br>Change-Id: I6=
122225cc12c4f299a2a48db24bc7379ac6c5921<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...1354...=
..&gt;<br>Message-Id: &lt;20250722102718.85403-1-frank@...2641...&gt;<br>UR=
L: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3224=
2.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .=
github/workflows/build.yaml<br>1 file changed, 9 insertions(+), 9 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
79/1079/6</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/workf=
lows/build.yaml</span><br><span>index d4fdc9d..bd5895b 100644</span><br><sp=
an>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/workflo=
ws/build.yaml</span><br><span>@@ -54,11 +54,11 @@</span><br><span>     step=
s:</span><br><span>       - name: Checkout OpenVPN</span><br><span>        =
 uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2893... # v4.0.1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get=
-cmake@...2897... # v4.0.3</span><br><span>       - name: Install vcpkg</sp=
an><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><s=
pan>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
       vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: f=
33cc491c85a7d643c5ab6da1667c1458e6d7abf</span><br><span>       - name: Inst=
all dependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg install =
openssl lz4 cmocka</span><br><span>       - name: configure OpenVPN with cm=
ake</span><br><span>@@ -88,11 +88,11 @@</span><br><span>       - name: Chec=
kout OpenVPN</span><br><span>         uses: actions/checkout@...2844... # v=
4.2.2</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-      - uses: lukka/get-cmake@...2893... # v4.0.1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2897... =
# v4.0.3</span><br><span>       - name: Restore from cache and install vcpk=
g</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><=
br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommit=
Id: f33cc491c85a7d643c5ab6da1667c1458e6d7abf</span><br><span>           vcp=
kgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span=
>       - name: Run CMake with vcpkg.json manifest</span><br><span>@@ -276,=
7 +276,7 @@</span><br><span>       runs-on: windows-latest</span><br><span>=
       steps:</span><br><span>       - uses: actions/checkout@...2844... # =
v4.2.2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: l=
ukka/get-cmake@...2893... # v4.0.1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      - uses: lukka/get-cmake@...2897... # v4.0.3</span><br>=
<span> </span><br><span>       - name: Install rst2html</span><br><span>   =
      run: python -m pip install --upgrade pip docutils</span><br><span>@@ =
-284,7 +284,7 @@</span><br><span>       - name: Restore artifacts, or setup=
 vcpkg (do not install any package)</span><br><span>         uses: lukka/ru=
n-vcpkg@...2815... # v11.5</span><br><span>         with:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: b12aa38a44a=
29bd8461404f2514e4c7cf00e1fc5</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7=
abf</span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#3=
9;</span><br><span> </span><br><span>       - name: Run CMake with vcpkg.js=
on manifest (NO TESTS)</span><br><span>@@ -413,7 +413,7 @@</span><br><span>=
           submodules: true</span><br><span>           # versioning=3Dsemve=
r-coerced</span><br><span>           repository: Mbed-TLS/mbedtls</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v3.6.3</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+          ref: v3.6.4</span><=
br><span>       - name: &quot;mbedtls: make no_test&quot;</span><br><span> =
        run: make -j3 no_test SHARED=3D1</span><br><span>         working-d=
irectory: mbedtls</span><br><span>@@ -471,8 +471,8 @@</span><br><span>     =
      path: aws-lc</span><br><span>           # versioning=3Dsemver-coerced=
</span><br><span>           repository: aws/aws-lc</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-          ref: v1.51.2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2893... # =
v4.0.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref=
: v1.55.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - us=
es: lukka/get-cmake@...2897... # v4.0.3</span><br><span>       - name: &quo=
t;AWS-LC: build&quot;</span><br><span>         run: |</span><br><span>     =
      mkdir build</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1079?usp=3Demail">change 1079</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1079?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6122225cc12c4f299a2a48db24b=
c7379ac6c5921 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1079 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0jaX2TVUlgs=--

