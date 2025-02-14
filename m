From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 11:19:09 +0000
In-Reply-To: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
References: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a1c78637e4f95c5fd980308f8c90aa7f72cc7dc6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DLimgZ34sAA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DLimgZ34sAA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Add android build to Github Actions
......................................................................

Add android build to Github Actions

Change-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae94944
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
1 file changed, 31 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/896/3

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 8fd1325..ce0fb74 100644
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
_ANDROID_ARCH_ABI=3D${{ matrix.abi }} -DENABLE_LZO=3Dfalse
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--DLimgZ34sAA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add android build to Github Actions<br><br>Ch=
ange-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae94944<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>---<br>M .github/workflows/build.yaml<br>=
1 file changed, 31 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/96/896/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span=
>index 8fd1325..ce0fb74 100644</span><br><span>--- a/.github/workflows/buil=
d.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@=
@ -35,6 +35,37 @@</span><br><span>         run: test ! -s uncrustify-change=
s.patch</span><br><span>         working-directory: openvpn</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  android:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    strategy:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      fail-fast: false</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      matrix:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        abi: [ arm64-v8a ]</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        include:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+          - abi: arm64-v8a</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            vcpkg_triple=
t: arm64-android</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 runs-on: ubuntu-24.04</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    name: &quot;Android - ${{ matrix.abi }}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # Github images already setup NDK wit=
h ANDROID_NDK_ROOT pointing to the root</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    # of the SDK</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    env:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      VCPKG_DEFAULT_TRIPLET: ${{ matrix.vcpkg_triplet }}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_ROOT: ${{ github.wor=
kspace }}/vcpkg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    steps:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - name: Checkout OpenVPN</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout=
@...2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      - name: Install vcpkg</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        with:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 33e9c99208736=
b713cabe4490e15235f62f893d4</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      - name: Install dependencies</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        run: ${VCPKG_ROOT}/vcpkg install openssl lz4=
 cmocka</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name=
: configure OpenVPN with cmake</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        run: cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3D=
yes -DCMAKE_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DI=
R}/${{ matrix.vcpkg_triplet }} -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtr=
ue -DCMAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi }} -DENABLE_LZO=3Dfalse</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Build OpenVP=
N Android binary with cmake</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        run: cmake --build openvpn-build</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>   mingw:</span><br><span>     strategy:</span><=
br><span>       fail-fast: false</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail">=
change 896</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieb787a040f9eaf34d9d16996af1=
d63d7eae94944 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 896 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--DLimgZ34sAA=--

