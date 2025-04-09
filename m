From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 20:01:21 +0000
In-Reply-To: <gerrit.1744115087000.Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd@...2715...>
References: <gerrit.1744115087000.Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <2de302ae5fe061f83ddbd13e1b5539d8fd320bdd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pF1oltfbuio="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: uddr <yura.uddr@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pF1oltfbuio=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/93=
4?usp=3Demail )

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

--=20
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
Gerrit-MessageType: merged

--pF1oltfbuio=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/934?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Use CMake 4.0 and apply required fixes<br=
><br>- update vcpkg reference to 856505bb76<br>  This includes a general wo=
rk-around for the CMake 4.0<br>  compat. See commit<br>  a1aebfa9d5eae7cf49=
3e0a706b43915d687bb860.<br>- update lukka/get-cmake action to v4<br>- updat=
e dependency aws/aws-lc to v1.49.1<br><br>Change-Id: Ibabb4aa80d7786614dbd6=
b76bd4cd096f217acfd<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>Message-Id=
: &lt;20250409131148.18147-1-gert@...1296...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg31399.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/buil=
d.yaml<br>1 file changed, 8 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 2df495c..0f5e617 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -54,11 +54,11 @@</span><br><span>     steps:</span><br><s=
pan>       - name: Checkout OpenVPN</span><br><span>         uses: actions/=
checkout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2884...=
... # v4.0.0</span><br><span>       - name: Install vcpkg</span><br><span> =
        uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         w=
ith:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGi=
tCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 856505bb76745=
8c99d8e3c3ed441f59a058d3687</span><br><span>       - name: Install dependen=
cies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 =
cmocka</span><br><span>       - name: configure OpenVPN with cmake</span><b=
r><span>@@ -88,11 +88,11 @@</span><br><span>       - name: Checkout OpenVPN=
</span><br><span>         uses: actions/checkout@...2844... # v4.2.2</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - us=
es: lukka/get-cmake@...2870... # v3.31.6</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2881... # v4.0.0</spa=
n><br><span>       - name: Restore from cache and install vcpkg</span><br><=
span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>    =
     with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          v=
cpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 856505bb7=
67458c99d8e3c3ed441f59a058d3687</span><br><span>           vcpkgJsonGlob: &=
#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>       - nam=
e: Run CMake with vcpkg.json manifest</span><br><span>@@ -276,7 +276,7 @@</=
span><br><span>       runs-on: windows-latest</span><br><span>       steps:=
</span><br><span>       - uses: actions/checkout@...2844... # v4.2.2</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmak=
e@...2870... # v3.31.6</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      - uses: lukka/get-cmake@...2881... # v4.0.0</span><br><span> </spa=
n><br><span>       - name: Install rst2html</span><br><span>         run: p=
ython -m pip install --upgrade pip docutils</span><br><span>@@ -284,7 +284,=
7 @@</span><br><span>       - name: Restore artifacts, or setup vcpkg (do n=
ot install any package)</span><br><span>         uses: lukka/run-vcpkg@...1665...=
815... # v11.5</span><br><span>         with:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f4=
63dc0341ac0ee6fa4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
        vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687</span><b=
r><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</span><br=
><span> </span><br><span>       - name: Run CMake with vcpkg.json manifest =
(NO TESTS)</span><br><span>@@ -471,8 +471,8 @@</span><br><span>           p=
ath: aws-lc</span><br><span>           # versioning=3Dsemver-coerced</span>=
<br><span>           repository: aws/aws-lc</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-          ref: v1.42.0</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2870... # v3.31.6</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: v1.49.=
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukk=
a/get-cmake@...2881... # v4.0.0</span><br><span>       - name: &quot;AWS-LC=
: build&quot;</span><br><span>         run: |</span><br><span>           mk=
dir build</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/934?usp=3Demail">change 934</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/934?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--pF1oltfbuio=--

