From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 20:01:18 +0000
In-Reply-To: <gerrit.1744115087000.Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd@...2715...>
References: <gerrit.1744115087000.Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2de302ae5fe061f83ddbd13e1b5539d8fd320bdd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Se2VYQOvCvs="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Use CMake 4.0
 and apply required fixes
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

--Se2VYQOvCvs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/934?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


Change subject: GHA: Use CMake 4.0 and apply required fixes
......................................................................

GHA: Use CMake 4.0 and apply required fixes

- update vcpkg reference to 856505bb76
  This includes a general work-around for the CMake 4.0
  compat. See commit
  a1aebfa9d5eae7cf493e0a706b43915d687bb860.
- update lukka/get-cmake action to v4
- update dependency aws/aws-lc to v1.49.1

Change-Id: Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20250409131148.18147-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
399.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 8 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/934/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 2df495c..0f5e617 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -54,11 +54,11 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2881... # v4.0.0
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -88,11 +88,11 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2

-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2881... # v4.0.0
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -276,7 +276,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2881... # v4.0.0

       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -284,7 +284,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -471,8 +471,8 @@
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.42.0
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+          ref: v1.49.1
+      - uses: lukka/get-cmake@...2881... # v4.0.0
       - name: "AWS-LC: build"
         run: |
           mkdir build

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/934?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd
Gerrit-Change-Number: 934
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Se2VYQOvCvs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/934?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by uddr</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">GHA: Use CMake 4.0 and apply required fixes<br><br>- =
update vcpkg reference to 856505bb76<br>  This includes a general work-arou=
nd for the CMake 4.0<br>  compat. See commit<br>  a1aebfa9d5eae7cf493e0a706=
b43915d687bb860.<br>- update lukka/get-cmake action to v4<br>- update depen=
dency aws/aws-lc to v1.49.1<br><br>Change-Id: Ibabb4aa80d7786614dbd6b76bd4c=
d096f217acfd<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>Message-Id: &lt;2=
0250409131148.18147-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg31399.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yaml<=
br>1 file changed, 8 insertions(+), 8 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/34/934/2</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br><s=
pan>index 2df495c..0f5e617 100644</span><br><span>--- a/.github/workflows/b=
uild.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><spa=
n>@@ -54,11 +54,11 @@</span><br><span>     steps:</span><br><span>       - =
name: Checkout OpenVPN</span><br><span>         uses: actions/checkout@...1665...=
844... # v4.2.2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
- uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2881... # v4.0.0<=
/span><br><span>       - name: Install vcpkg</span><br><span>         uses:=
 lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: ac=
d5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441=
f59a058d3687</span><br><span>       - name: Install dependencies</span><br>=
<span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><b=
r><span>       - name: configure OpenVPN with cmake</span><br><span>@@ -88,=
11 +88,11 @@</span><br><span>       - name: Checkout OpenVPN</span><br><spa=
n>         uses: actions/checkout@...2844... # v4.2.2</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-c=
make@...2870... # v3.31.6</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      - uses: lukka/get-cmake@...2881... # v4.0.0</span><br><span>   =
    - name: Restore from cache and install vcpkg</span><br><span>         u=
ses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId=
: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 856505bb767458c99d8e3c3e=
d441f59a058d3687</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vc=
pkg.json&#39;</span><br><span> </span><br><span>       - name: Run CMake wi=
th vcpkg.json manifest</span><br><span>@@ -276,7 +276,7 @@</span><br><span>=
       runs-on: windows-latest</span><br><span>       steps:</span><br><spa=
n>       - uses: actions/checkout@...2844... # v4.2.2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2870... # =
v3.31.6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses=
: lukka/get-cmake@...2881... # v4.0.0</span><br><span> </span><br><span>   =
    - name: Install rst2html</span><br><span>         run: python -m pip in=
stall --upgrade pip docutils</span><br><span>@@ -284,7 +284,7 @@</span><br>=
<span>       - name: Restore artifacts, or setup vcpkg (do not install any =
package)</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5<=
/span><br><span>         with:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6f=
a4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGi=
tCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687</span><br><span>       =
    vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br><span> </span>=
<br><span>       - name: Run CMake with vcpkg.json manifest (NO TESTS)</spa=
n><br><span>@@ -471,8 +471,8 @@</span><br><span>           path: aws-lc</sp=
an><br><span>           # versioning=3Dsemver-coerced</span><br><span>     =
      repository: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-          ref: v1.42.0</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-      - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+          ref: v1.49.1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...493...=
2881... # v4.0.0</span><br><span>       - name: &quot;AWS-LC: build&quot;</=
span><br><span>         run: |</span><br><span>           mkdir build</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/934?usp=3Demail">change 934</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/934?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibabb4aa80d7786614dbd6b76bd4=
cd096f217acfd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 934 </div>
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


--Se2VYQOvCvs=--

