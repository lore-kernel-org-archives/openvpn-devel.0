From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 16:19:26 +0000
In-Reply-To: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
References: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b4c26c37f366d81a5cf62a40b81c1b94642eeaf2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+rLTRd43h5g="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add android build to
 Github Actions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+rLTRd43h5g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add android build to Github Actions
......................................................................

Add android build to Github Actions

Change-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae94944
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250214160634.6670-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
900.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 31 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/896/5

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 8fd1325..b1af7ec 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -35,6 +35,37 @@
         run: test ! -s uncrustify-changes.patch
         working-directory: openvpn

+  android:
+    strategy:
+      fail-fast: false
+      matrix:
+        abi: [ arm64-v8a ]
+        include:
+          - abi: arm64-v8a
+            vcpkg_triplet: arm64-android
+    runs-on: ubuntu-24.04
+    name: "Android - ${{ matrix.abi }}"
+    # Github images already setup NDK with ANDROID_NDK_ROOT pointing to th=
e root
+    # of the SDK
+    env:
+      VCPKG_DEFAULT_TRIPLET: ${{ matrix.vcpkg_triplet }}
+      VCPKG_ROOT: ${{ github.workspace }}/vcpkg
+      VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
+    steps:
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2844... # v4.2.2
+      - name: Install vcpkg
+        uses: lukka/run-vcpkg@...2815... # v11.5
+        with:
+          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+      - name: Install dependencies
+        run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
+      - name: configure OpenVPN with cmake
+        run: cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes -DCMAK=
E_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ mat=
rix.vcpkg_triplet }} -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DCMAKE=
_ANDROID_ARCH_ABI=3D${{ matrix.abi }} -DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno
+      - name: Build OpenVPN Android binary with cmake
+        run: cmake --build openvpn-build
+
+
   mingw:
     strategy:
       fail-fast: false

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae94944
Gerrit-Change-Number: 896
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--+rLTRd43h5g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
896?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add android build to Github Actions<br><br>Ch=
ange-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae94944<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>Message-Id: &lt;20250214160634.6670-1-gert@...1296...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3=
0900.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M .github/workflows/build.yaml<br>1 file changed, 31 insertions(+), 0 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/96/896/5</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/wo=
rkflows/build.yaml</span><br><span>index 8fd1325..b1af7ec 100644</span><br>=
<span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/work=
flows/build.yaml</span><br><span>@@ -35,6 +35,37 @@</span><br><span>       =
  run: test ! -s uncrustify-changes.patch</span><br><span>         working-=
directory: openvpn</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  android:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    strategy:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      fail-fast: false</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      matrix:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       abi: [ arm64-v8a ]</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        include:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          - abi: arm64-v8a</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            vcpkg_triplet: arm64-android</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    name: &quot;Android - ${{ matrix.a=
bi }}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Gi=
thub images already setup NDK with ANDROID_NDK_ROOT pointing to the root</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    # of the SDK</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    env:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_DEFAULT_TRIPLET: ${{ mat=
rix.vcpkg_triplet }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      VCPKG_ROOT: ${{ github.workspace }}/vcpkg</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      VCPKG_INSTALLED_DIR: ${{ github.workspac=
e }}/vcpkg/installed</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    steps:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
name: Checkout OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        uses: actions/checkout@...2844... # v4.2.2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - name: Install vcpkg</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...493...=
2815... # v11.5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      - name: Install dependencies</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: ${VCPKG_=
ROOT}/vcpkg install openssl lz4 cmocka</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      - name: configure OpenVPN with cmake</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        run: cmake -S . -B openvp=
n-build -DUNSUPPORTED_BUILDS=3Dyes -DCMAKE_SYSTEM_NAME=3DAndroid -DOPENSSL_=
ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} -DENABLE_PKCS=
11=3Dfalse -DBUILD_TESTING=3Dtrue -DCMAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi=
 }} -DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      - name: Build OpenVPN Android binary with cmak=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: cmake=
 --build openvpn-build</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>   mingw:</span><br><span>     strategy:</span><br><span>       fail-fast:=
 false</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail">change 896</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/896?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieb787a040f9eaf34d9d16996af1=
d63d7eae94944 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 896 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+rLTRd43h5g=--

