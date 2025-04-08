From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 8 Apr 2025 12:24:49 +0000
References: <gerrit.1744115087000.Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <07657304d74386c8f4fcca56063da318035eb7e7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TE6/F4T0xHw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TE6/F4T0xHw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/934?usp=3Demail

to review the following change.


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
---
M .github/workflows/build.yaml
1 file changed, 8 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/934/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--TE6/F4T0xHw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/934?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Use CMake 4.0 and apply required fixes<br><br>- update v=
cpkg reference to 856505bb76<br>  This includes a general work-around for t=
he CMake 4.0<br>  compat. See commit<br>  a1aebfa9d5eae7cf493e0a706b43915d6=
87bb860.<br>- update lukka/get-cmake action to v4<br>- update dependency aw=
s/aws-lc to v1.49.1<br><br>Change-Id: Ibabb4aa80d7786614dbd6b76bd4cd096f217=
acfd<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br=
>M .github/workflows/build.yaml<br>1 file changed, 8 insertions(+), 8 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/34/934/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/wo=
rkflows/build.yaml</span><br><span>index 2df495c..0f5e617 100644</span><br>=
<span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/work=
flows/build.yaml</span><br><span>@@ -54,11 +54,11 @@</span><br><span>     s=
teps:</span><br><span>       - name: Checkout OpenVPN</span><br><span>     =
    uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2870... # v3.31.6=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka=
/get-cmake@...2881... # v4.0.0</span><br><span>       - name: Install vcpkg=
</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><b=
r><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitI=
d: 856505bb767458c99d8e3c3ed441f59a058d3687</span><br><span>       - name: =
Install dependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg inst=
all openssl lz4 cmocka</span><br><span>       - name: configure OpenVPN wit=
h cmake</span><br><span>@@ -88,11 +88,11 @@</span><br><span>       - name: =
Checkout OpenVPN</span><br><span>         uses: actions/checkout@...2844...=
 # v4.2.2</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2882...=
.. # v4.0.0</span><br><span>       - name: Restore from cache and install v=
cpkg</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</spa=
n><br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCom=
mitId: 856505bb767458c99d8e3c3ed441f59a058d3687</span><br><span>           =
vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><s=
pan>       - name: Run CMake with vcpkg.json manifest</span><br><span>@@ -2=
76,7 +276,7 @@</span><br><span>       runs-on: windows-latest</span><br><sp=
an>       steps:</span><br><span>       - uses: actions/checkout@...2844...=
 # v4.2.2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses=
: lukka/get-cmake@...2870... # v3.31.6</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      - uses: lukka/get-cmake@...2881... # v4.0.0</span>=
<br><span> </span><br><span>       - name: Install rst2html</span><br><span=
>         run: python -m pip install --upgrade pip docutils</span><br><span=
>@@ -284,7 +284,7 @@</span><br><span>       - name: Restore artifacts, or s=
etup vcpkg (do not install any package)</span><br><span>         uses: lukk=
a/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: acd5bba=
5aac8b6573b5f6f463dc0341ac0ee6fa4</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a0=
58d3687</span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.jso=
n&#39;</span><br><span> </span><br><span>       - name: Run CMake with vcpk=
g.json manifest (NO TESTS)</span><br><span>@@ -471,8 +471,8 @@</span><br><s=
pan>           path: aws-lc</span><br><span>           # versioning=3Dsemve=
r-coerced</span><br><span>           repository: aws/aws-lc</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-          ref: v1.42.0</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@...2883...=
0... # v3.31.6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
     ref: v1.49.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - uses: lukka/get-cmake@...2881... # v4.0.0</span><br><span>       - na=
me: &quot;AWS-LC: build&quot;</span><br><span>         run: |</span><br><sp=
an>           mkdir build</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/934?usp=3Demail">change =
934</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/934?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibabb4aa80d7786614dbd6b76bd4=
cd096f217acfd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 934 </div>
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


--TE6/F4T0xHw=--

