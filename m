From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 1 Apr 2025 16:38:23 +0000
References: <gerrit.1743525501000.Ief11d5d7ccae084c863b50054d4e97c71f57d6f0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <50683004da0c4da9868b906542e15ee786031758-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MYET9MSximA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Pin version of
 CMake for all builds
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

--MYET9MSximA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/929?usp=3Demail

to review the following change.


Change subject: GHA: Pin version of CMake for all builds
......................................................................

GHA: Pin version of CMake for all builds

Turns out that "apt install cmake" is useless since
Github installs also CMake but not as a package. So
make sure we control which CMake we get and not
Github.

Switch to get-cmake action (which also installs ninja)
and remove the installation via apt.

Change-Id: Ief11d5d7ccae084c863b50054d4e97c71f57d6f0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 5 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/929/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b1af7ec..617b866 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -54,6 +54,7 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
+      - uses: lukka/get-cmake@...2870... # v3.31.6
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
@@ -78,10 +79,11 @@
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake =
ninja-build build-essential wget python3-docutils man2html-base
+        run: sudo apt update && sudo apt install -y mingw-w64 unzip build-=
essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2

+      - uses: lukka/get-cmake@...2870... # v3.31.6
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
@@ -457,13 +459,14 @@

     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y cmake gcc ninja-build =
golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html cla=
ng libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool=
 automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+        run: sudo apt update && sudo apt install -y gcc golang make liblzo=
2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev p=
ython3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf=
 pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "AWS-LC: checkout"
         uses: actions/checkout@...2844... # v4.2.2
         with:
           path: aws-lc
           repository: aws/aws-lc
           ref: v1.42.0
+      - uses: lukka/get-cmake@...2870... # v3.31.6
       - name: "AWS-LC: build"
         run: |
           mkdir build

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/929?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ief11d5d7ccae084c863b50054d4e97c71f57d6f0
Gerrit-Change-Number: 929
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--MYET9MSximA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/929?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Pin version of CMake for all builds<br><br>Turns out tha=
t &quot;apt install cmake&quot; is useless since<br>Github installs also CM=
ake but not as a package. So<br>make sure we control which CMake we get and=
 not<br>Github.<br><br>Switch to get-cmake action (which also installs ninj=
a)<br>and remove the installation via apt.<br><br>Change-Id: Ief11d5d7ccae0=
84c863b50054d4e97c71f57d6f0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 5=
 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/29/929/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/=
build.yaml b/.github/workflows/build.yaml</span><br><span>index b1af7ec..61=
7b866 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br><=
span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -54,6 +54,7 @@</=
span><br><span>     steps:</span><br><span>       - name: Checkout OpenVPN<=
/span><br><span>         uses: actions/checkout@...2844... # v4.2.2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cma=
ke@...2870... # v3.31.6</span><br><span>       - name: Install vcpkg</span>=
<br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span=
>         with:</span><br><span>@@ -78,10 +79,11 @@</span><br><span>       =
VCPKG_ROOT: ${{ github.workspace }}/vcpkg</span><br><span>     steps:</span=
><br><span>       - name: Install dependencies</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        run: sudo apt update &amp;&amp; sudo apt i=
nstall -y mingw-w64 unzip cmake ninja-build build-essential wget python3-do=
cutils man2html-base</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        run: sudo apt update &amp;&amp; sudo apt install -y mingw-w64 unzi=
p build-essential wget python3-docutils man2html-base</span><br><span>     =
  - name: Checkout OpenVPN</span><br><span>         uses: actions/checkout@=
...2844... # v4.2.2</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      - uses: lukka/get-cmake@...2870... # v3.31.6</span>=
<br><span>       - name: Restore from cache and install vcpkg</span><br><sp=
an>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>      =
   with:</span><br><span>@@ -457,13 +459,14 @@</span><br><span> </span><br>=
<span>     steps:</span><br><span>       - name: Install dependencies</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: sudo apt updat=
e &amp;&amp; sudo apt install -y cmake gcc ninja-build golang make liblzo2-=
dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev pyt=
hon3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf p=
kg-config libcap-ng-dev libnl-genl-3-dev</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        run: sudo apt update &amp;&amp; sudo apt insta=
ll -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev ma=
n2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonsche=
ma libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</spa=
n><br><span>       - name: &quot;AWS-LC: checkout&quot;</span><br><span>   =
      uses: actions/checkout@...2844... # v4.2.2</span><br><span>         w=
ith:</span><br><span>           path: aws-lc</span><br><span>           rep=
ository: aws/aws-lc</span><br><span>           ref: v1.42.0</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2825...=
70... # v3.31.6</span><br><span>       - name: &quot;AWS-LC: build&quot;</s=
pan><br><span>         run: |</span><br><span>           mkdir build</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/929?usp=3Demail">change 929</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/929?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief11d5d7ccae084c863b50054d4=
e97c71f57d6f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 929 </div>
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


--MYET9MSximA=--

