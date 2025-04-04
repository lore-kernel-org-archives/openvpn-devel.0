From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 4 Apr 2025 11:08:27 +0000
In-Reply-To: <gerrit.1743589873000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
References: <gerrit.1743589873000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ab0259b65a8d7ef269ffe3abb3abc60b77524aec-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Uvp4n0n5HRg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: GHA: Dependency
 and Actions update April 2025 (2.6)
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

--Uvp4n0n5HRg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/931?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: GHA: Dependency and Actions update April 2025 (2.6)
......................................................................

GHA: Dependency and Actions update April 2025 (2.6)

- Update all actions to latest releases.
- Update vcpkg commit to latest master.

Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d99902c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250331153309.77901-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
290.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
(cherry picked from commit 0ffa7b57fdfb2658ae326baea0871ccca2c01b7d)
Message-Id: <20250402154409.12205-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
330.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 10 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/931/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 37ac6ec..22b7aca 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -55,7 +55,7 @@
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -65,7 +65,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"

-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -73,7 +73,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -92,7 +92,7 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2817... # v4.1.8
+        uses: actions/download-artifact@...2869... # v4.2.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -227,7 +227,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2861... # v3.31.5
+      - uses: lukka/get-cmake@...2870... # v3.31.6

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -235,7 +235,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -254,7 +254,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"

-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index b5e1920..7998632d6 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2691...
+        uses: actions/cache/restore@...2871... # v4.2.3
         with:
           path: |
             cov-int
@@ -65,7 +65,7 @@

       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/cache/save@...2691...
+        uses: actions/cache/save@...2871... # v4.2.3
         with:
           path: |
             cov-int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/931?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d99902c
Gerrit-Change-Number: 931
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Uvp4n0n5HRg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/931?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">GHA: Dependency and Actions update April 2025 (2.6)<=
br><br>- Update all actions to latest releases.<br>- Update vcpkg commit to=
 latest master.<br><br>Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d99902c=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20250331153=
309.77901-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg31290.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<=
br>(cherry picked from commit 0ffa7b57fdfb2658ae326baea0871ccca2c01b7d)<br>=
Message-Id: &lt;20250402154409.12205-1-gert@...1296...&gt;<br>URL: https://=
www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31330.html<br>S=
igned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/work=
flows/build.yaml<br>M .github/workflows/coverity-scan.yml<br>2 files change=
d, 10 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/31/931/2</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/work=
flows/build.yaml b/.github/workflows/build.yaml</span><br><span>index 37ac6=
ec..22b7aca 100644</span><br><span>--- a/.github/workflows/build.yaml</span=
><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -27,7 +27,=
7 @@</span><br><span>       - name: Show changes on standard output</span><=
br><span>         run: git diff</span><br><span>         working-directory:=
 openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses:=
 actions/upload-artifact@...2860... # v4.6.0</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2868... #=
 v4.6.2</span><br><span>         with:</span><br><span>           name: unc=
rustify-changes.patch</span><br><span>           path: &#39;openvpn/uncrust=
ify-changes.patch&#39;</span><br><span>@@ -55,7 +55,7 @@</span><br><span>  =
     - name: Restore from cache and install vcpkg</span><br><span>         =
uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitI=
d: 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f4=
63dc0341ac0ee6fa4</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/v=
cpkg.json&#39;</span><br><span> </span><br><span>       - name: Run CMake w=
ith vcpkg.json manifest</span><br><span>@@ -65,7 +65,7 @@</span><br><span> =
          buildPreset: mingw-${{ matrix.arch }}</span><br><span>           =
buildPresetAdditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses:=
 actions/upload-artifact@...2860... # v4.6.0</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2868... #=
 v4.6.2</span><br><span>         with:</span><br><span>           name: ope=
nvpn-mingw-${{ matrix.arch }}</span><br><span>           path: |</span><br>=
<span>@@ -73,7 +73,7 @@</span><br><span>             ${{ github.workspace }=
}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br><span>          =
   !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*=
.exe</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      - uses: actions/upload-artifact@...2860... # v4.6.0</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifac=
t@...2868... # v4.6.2</span><br><span>         with:</span><br><span>      =
     name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>         =
  path: |</span><br><span>@@ -92,7 +92,7 @@</span><br><span>     name: &quo=
t;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</span=
><br><span>     steps:</span><br><span>       - name: Retrieve mingw unitte=
st</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actio=
ns/download-artifact@...2817... # v4.1.8</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        uses: actions/download-artifact@...2869... # v=
4.2.1</span><br><span>         with:</span><br><span>           name: openv=
pn-mingw-${{ matrix.arch }}-tests</span><br><span>           path: unittest=
s</span><br><span>@@ -227,7 +227,7 @@</span><br><span>       runs-on: windo=
ws-latest</span><br><span>       steps:</span><br><span>       - uses: acti=
ons/checkout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      - uses: lukka/get-cmake@...2861... # v3.31.5</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...493...=
2870... # v3.31.6</span><br><span> </span><br><span>       - name: Install =
rst2html</span><br><span>         run: python -m pip install --upgrade pip =
docutils</span><br><span>@@ -235,7 +235,7 @@</span><br><span>       - name:=
 Restore artifacts, or setup vcpkg (do not install any package)</span><br><=
span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>    =
     with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          v=
cpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: acd5bba5a=
ac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span>           vcpkgJsonGlob: &=
#39;**/windows/vcpkg.json&#39;</span><br><span> </span><br><span>       - n=
ame: Run CMake with vcpkg.json manifest (NO TESTS)</span><br><span>@@ -254,=
7 +254,7 @@</span><br><span>           testPreset: win-${{ matrix.arch }}-r=
elease</span><br><span>           testPresetAdditionalArgs: &quot;[&#39;--o=
utput-on-failure&#39;]&quot;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2860... #=
 v4.6.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses=
: actions/upload-artifact@...2868... # v4.6.2</span><br><span>         with=
:</span><br><span>           name: openvpn-msvc-${{ matrix.arch }}</span><b=
r><span>           path: |</span><br><span>diff --git a/.github/workflows/c=
overity-scan.yml b/.github/workflows/coverity-scan.yml</span><br><span>inde=
x b5e1920..7998632d6 100644</span><br><span>--- a/.github/workflows/coverit=
y-scan.yml</span><br><span>+++ b/.github/workflows/coverity-scan.yml</span>=
<br><span>@@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><span>   =
    - name: Check submission cache</span><br><span>         id: check_submi=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/cache/restore@...2691...</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/cache/restore@...2871... # v4.2.3</span><br><s=
pan>         with:</span><br><span>           path: |</span><br><span>     =
        cov-int</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </span><=
br><span>       - name: Cache submission</span><br><span>         if: steps=
.check_submit.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache/save@...2691...=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/cache/save@...2871... # v4.2.3</span><br><span>         with:</span><br>=
<span>           path: |</span><br><span>             cov-int</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/931?usp=3Demail">change 931</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/931?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie9bffcc487f53a3a8ae6e59b79e=
654360d99902c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 931 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Uvp4n0n5HRg=--

