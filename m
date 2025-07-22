From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 22 Jul 2025 16:28:47 +0000
In-Reply-To: <gerrit.1752061641000.I46177b0614ad8b167a421c50d3cc8e7da4054e42@...2715...>
References: <gerrit.1752061641000.I46177b0614ad8b167a421c50d3cc8e7da4054e42@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <9e91463b8623436c49f8cb7dc159f1e0d42866e7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Eh145Hieobk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: GHA: Update
 dependencies July 2025 (2.6)
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

--Eh145Hieobk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
80?usp=3Demail )

Change subject: GHA: Update dependencies July 2025 (2.6)
......................................................................

GHA: Update dependencies July 2025 (2.6)

Pin dependencies
chore(deps): update lukka/get-cmake action to v4
chore(deps): update vcpkg digest to f33cc49

Change-Id: I46177b0614ad8b167a421c50d3cc8e7da4054e42
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20250722102810.85915-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
243.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M .github/workflows/coverity-scan.yml
2 files changed, 6 insertions(+), 6 deletions(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 22b7aca..65d5fd4 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -51,11 +51,11 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2

-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2897... # v4.0.3
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -92,7 +92,7 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2869... # v4.2.1
+        uses: actions/download-artifact@...2894... # v4.3.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -227,7 +227,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2897... # v4.0.3

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -235,7 +235,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index 7998632d6..1a9e5a3 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -25,7 +25,7 @@

       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2844... # v4

       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit !=3D 'true'

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1080?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I46177b0614ad8b167a421c50d3cc8e7da4054e42
Gerrit-Change-Number: 1080
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Eh145Hieobk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1080?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">GHA: Update dependencies July 2025 (2.6)<br><=
br>Pin dependencies<br>chore(deps): update lukka/get-cmake action to v4<br>=
chore(deps): update vcpkg digest to f33cc49<br><br>Change-Id: I46177b0614ad=
8b167a421c50d3cc8e7da4054e42<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>M=
essage-Id: &lt;20250722102810.85915-1-frank@...2641...&gt;<br>URL: https://=
www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32243.html<br>S=
igned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/work=
flows/build.yaml<br>M .github/workflows/coverity-scan.yml<br>2 files change=
d, 6 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 22b7aca..65d5fd4 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -51,11 +51,11 @@</span><br><span>       - name: Checkout =
OpenVPN</span><br><span>         uses: actions/checkout@...2844... # v4.2.2=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2897... # v4.0=
.3</span><br><span>       - name: Restore from cache and install vcpkg</spa=
n><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><sp=
an>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
      vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: f3=
3cc491c85a7d643c5ab6da1667c1458e6d7abf</span><br><span>           vcpkgJson=
Glob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>     =
  - name: Run CMake with vcpkg.json manifest</span><br><span>@@ -92,7 +92,7=
 @@</span><br><span>     name: &quot;mingw unittest ${{ matrix.test }} - ${=
{ matrix.arch }} - OSSL&quot;</span><br><span>     steps:</span><br><span> =
      - name: Retrieve mingw unittest</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uses: actions/download-artifact@...2869... # v4.2.1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actio=
ns/download-artifact@...2894... # v4.3.0</span><br><span>         with:</sp=
an><br><span>           name: openvpn-mingw-${{ matrix.arch }}-tests</span>=
<br><span>           path: unittests</span><br><span>@@ -227,7 +227,7 @@</s=
pan><br><span>       runs-on: windows-latest</span><br><span>       steps:<=
/span><br><span>       - uses: actions/checkout@...2844... # v4.2.2</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake=
@...2870... # v3.31.6</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      - uses: lukka/get-cmake@...2897... # v4.0.3</span><br><span> </span=
><br><span>       - name: Install rst2html</span><br><span>         run: py=
thon -m pip install --upgrade pip docutils</span><br><span>@@ -235,7 +235,7=
 @@</span><br><span>       - name: Restore artifacts, or setup vcpkg (do no=
t install any package)</span><br><span>         uses: lukka/run-vcpkg@...2825...=
15... # v11.5</span><br><span>         with:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f46=
3dc0341ac0ee6fa4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
       vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf</span><br=
><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br>=
<span> </span><br><span>       - name: Run CMake with vcpkg.json manifest (=
NO TESTS)</span><br><span>diff --git a/.github/workflows/coverity-scan.yml =
b/.github/workflows/coverity-scan.yml</span><br><span>index 7998632d6..1a9e=
5a3 100644</span><br><span>--- a/.github/workflows/coverity-scan.yml</span>=
<br><span>+++ b/.github/workflows/coverity-scan.yml</span><br><span>@@ -25,=
7 +25,7 @@</span><br><span> </span><br><span>       - name: Checkout OpenVP=
N</span><br><span>         if: steps.check_submit.outputs.cache-hit !=3D &#=
39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
ses: actions/checkout@...2691...</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uses: actions/checkout@...2844... # v4</span><br><span=
> </span><br><span>       - name: Download Coverity Build Tool</span><br><s=
pan>         if: steps.check_submit.outputs.cache-hit !=3D &#39;true&#39;</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1080?usp=3Demail">change 1080</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1080?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I46177b0614ad8b167a421c50d3c=
c8e7da4054e42 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1080 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Eh145Hieobk=--

