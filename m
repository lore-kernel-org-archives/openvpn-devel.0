From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 4 Apr 2025 11:08:33 +0000
In-Reply-To: <gerrit.1743589873000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
References: <gerrit.1743589873000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ab0259b65a8d7ef269ffe3abb3abc60b77524aec-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DYFHmFl4j8c="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, plaisthos <arne-openvpn@...1227...>

--DYFHmFl4j8c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/93=
1?usp=3Demail )

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
Gerrit-MessageType: merged

--DYFHmFl4j8c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/931?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Dependency and Actions update April 2025 =
(2.6)<br><br>- Update all actions to latest releases.<br>- Update vcpkg com=
mit to latest master.<br><br>Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d=
99902c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acke=
d-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20250=
331153309.77901-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com=
/openvpn-devel@lists.sourceforge.net/msg31290.html<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Acked-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>(cherry picked from commit 0ffa7b57fdfb2658ae326baea0871ccca2c01b7=
d)<br>Message-Id: &lt;20250402154409.12205-1-gert@...1296...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31330.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .githu=
b/workflows/build.yaml<br>M .github/workflows/coverity-scan.yml<br>2 files =
changed, 10 insertions(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 37ac6ec..22b7aca 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -27,7 +27,7 @@</span><br><span>       - name: Show change=
s on standard output</span><br><span>         run: git diff</span><br><span=
>         working-directory: openvpn</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - uses: actions/upload-artifact@...2860... # v4.6.0</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/=
upload-artifact@...2868... # v4.6.2</span><br><span>         with:</span><b=
r><span>           name: uncrustify-changes.patch</span><br><span>         =
  path: &#39;openvpn/uncrustify-changes.patch&#39;</span><br><span>@@ -55,7=
 +55,7 @@</span><br><span>       - name: Restore from cache and install vcp=
kg</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span>=
<br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommi=
tId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span>           vc=
pkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><spa=
n>       - name: Run CMake with vcpkg.json manifest</span><br><span>@@ -65,=
7 +65,7 @@</span><br><span>           buildPreset: mingw-${{ matrix.arch }}=
</span><br><span>           buildPresetAdditionalArgs: &quot;[&#39;--config=
 Debug&#39;]&quot;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - uses: actions/upload-artifact@...2860... # v4.6.0</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/=
upload-artifact@...2868... # v4.6.2</span><br><span>         with:</span><b=
r><span>           name: openvpn-mingw-${{ matrix.arch }}</span><br><span> =
          path: |</span><br><span>@@ -73,7 +73,7 @@</span><br><span>       =
      ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dl=
l</span><br><span>             !${{ github.workspace }}/out/build/mingw/${{=
 matrix.arch }}/Debug/test_*.exe</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@...2879...=
.. # v4.6.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
uses: actions/upload-artifact@...2868... # v4.6.2</span><br><span>         =
with:</span><br><span>           name: openvpn-mingw-${{ matrix.arch }}-tes=
ts</span><br><span>           path: |</span><br><span>@@ -92,7 +92,7 @@</sp=
an><br><span>     name: &quot;mingw unittest ${{ matrix.test }} - ${{ matri=
x.arch }} - OSSL&quot;</span><br><span>     steps:</span><br><span>       -=
 name: Retrieve mingw unittest</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uses: actions/download-artifact@...2817... # v4.1.8</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/down=
load-artifact@...2869... # v4.2.1</span><br><span>         with:</span><br>=
<span>           name: openvpn-mingw-${{ matrix.arch }}-tests</span><br><sp=
an>           path: unittests</span><br><span>@@ -227,7 +227,7 @@</span><br=
><span>       runs-on: windows-latest</span><br><span>       steps:</span><=
br><span>       - uses: actions/checkout@...2844... # v4.2.2</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2880...=
1... # v3.31.5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span> </span><br><=
span>       - name: Install rst2html</span><br><span>         run: python -=
m pip install --upgrade pip docutils</span><br><span>@@ -235,7 +235,7 @@</s=
pan><br><span>       - name: Restore artifacts, or setup vcpkg (do not inst=
all any package)</span><br><span>         uses: lukka/run-vcpkg@...2815... =
# v11.5</span><br><span>         with:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e1523=
5f62f893d4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
 vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span=
>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span>=
 </span><br><span>       - name: Run CMake with vcpkg.json manifest (NO TES=
TS)</span><br><span>@@ -254,7 +254,7 @@</span><br><span>           testPres=
et: win-${{ matrix.arch }}-release</span><br><span>           testPresetAdd=
itionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/=
upload-artifact@...2860... # v4.6.0</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      - uses: actions/upload-artifact@...2868... # v4.6.2</=
span><br><span>         with:</span><br><span>           name: openvpn-msvc=
-${{ matrix.arch }}</span><br><span>           path: |</span><br><span>diff=
 --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-s=
can.yml</span><br><span>index b5e1920..7998632d6 100644</span><br><span>---=
 a/.github/workflows/coverity-scan.yml</span><br><span>+++ b/.github/workfl=
ows/coverity-scan.yml</span><br><span>@@ -13,7 +13,7 @@</span><br><span>   =
  steps:</span><br><span>       - name: Check submission cache</span><br><s=
pan>         id: check_submit</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        uses: actions/cache/restore@...2691...</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/restore@...1665...=
871... # v4.2.3</span><br><span>         with:</span><br><span>           p=
ath: |</span><br><span>             cov-int</span><br><span>@@ -65,7 +65,7 =
@@</span><br><span> </span><br><span>       - name: Cache submission</span>=
<br><span>         if: steps.check_submit.outputs.cache-hit !=3D &#39;true&=
#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: act=
ions/cache/save@...2691...</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        uses: actions/cache/save@...2871... # v4.2.3</span><br><span=
>         with:</span><br><span>           path: |</span><br><span>        =
     cov-int</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/931?usp=3Demail">change 931</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/931?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--DYFHmFl4j8c=--

