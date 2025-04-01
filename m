From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 1 Apr 2025 18:01:01 +0000
In-Reply-To: <gerrit.1743525501000.Ief11d5d7ccae084c863b50054d4e97c71f57d6f0@...2715...>
References: <gerrit.1743525501000.Ief11d5d7ccae084c863b50054d4e97c71f57d6f0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5658e78c843bb3a77410067037af66ee41ed22ea-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0gF3cutOztQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0gF3cutOztQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/92=
9?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250401170420.29808-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
299.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 5 insertions(+), 2 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--0gF3cutOztQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/929?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Pin version of CMake for all builds<br><b=
r>Turns out that &quot;apt install cmake&quot; is useless since<br>Github i=
nstalls also CMake but not as a package. So<br>make sure we control which C=
Make we get and not<br>Github.<br><br>Switch to get-cmake action (which als=
o installs ninja)<br>and remove the installation via apt.<br><br>Change-Id:=
 Ief11d5d7ccae084c863b50054d4e97c71f57d6f0<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Message-Id: &lt;20250401170420.29808-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31299.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .gith=
ub/workflows/build.yaml<br>1 file changed, 5 insertions(+), 2 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index b1af7ec..617b866 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -54,6 +54,7 @@</span><br><span>     steps:</span><br><spa=
n>       - name: Checkout OpenVPN</span><br><span>         uses: actions/ch=
eckout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span> =
      - name: Install vcpkg</span><br><span>         uses: lukka/run-vcpkg@=
...2815... # v11.5</span><br><span>         with:</span><br><span>@@ -78,10=
 +79,11 @@</span><br><span>       VCPKG_ROOT: ${{ github.workspace }}/vcpkg=
</span><br><span>     steps:</span><br><span>       - name: Install depende=
ncies</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: sud=
o apt update &amp;&amp; sudo apt install -y mingw-w64 unzip cmake ninja-bui=
ld build-essential wget python3-docutils man2html-base</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        run: sudo apt update &amp;&amp; =
sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils m=
an2html-base</span><br><span>       - name: Checkout OpenVPN</span><br><spa=
n>         uses: actions/checkout@...2844... # v4.2.2</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get=
-cmake@...2870... # v3.31.6</span><br><span>       - name: Restore from cac=
he and install vcpkg</span><br><span>         uses: lukka/run-vcpkg@...2876...=
... # v11.5</span><br><span>         with:</span><br><span>@@ -457,13 +459,=
14 @@</span><br><span> </span><br><span>     steps:</span><br><span>       =
- name: Install dependencies</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        run: sudo apt update &amp;&amp; sudo apt install -y cmake gc=
c ninja-build golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-de=
v man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-json=
schema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: sudo ap=
t update &amp;&amp; sudo apt install -y gcc golang make liblzo2-dev libpam0=
g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docuti=
ls python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config l=
ibcap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;AWS-LC: =
checkout&quot;</span><br><span>         uses: actions/checkout@...2844... #=
 v4.2.2</span><br><span>         with:</span><br><span>           path: aws=
-lc</span><br><span>           repository: aws/aws-lc</span><br><span>     =
      ref: v1.42.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span>       - =
name: &quot;AWS-LC: build&quot;</span><br><span>         run: |</span><br><=
span>           mkdir build</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/929?usp=3Demail">chang=
e 929</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/929?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief11d5d7ccae084c863b50054d4=
e97c71f57d6f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 929 </div>
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


--0gF3cutOztQ=--

