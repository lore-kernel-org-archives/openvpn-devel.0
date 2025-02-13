From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 13 Feb 2025 16:12:53 +0000
In-Reply-To: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
References: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1161b7d1a239a58939a43d52feeeb47f9092a149-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LkQ+Qtk6M5U="; charset=UTF-8
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

--LkQ+Qtk6M5U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail

to look at the new patch set (#2).


Change subject: Add android build to Github Actions
......................................................................

Add android build to Github Actions

Change-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae94944
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
1 file changed, 31 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/896/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 3ebea79..9022e23 100644
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
+          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--LkQ+Qtk6M5U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Add android build to Github Actions<br><br>Change-Id: Ieb787a040f9eaf=
34d9d16996af1d63d7eae94944<br>Signed-off-by: Arne Schwabe &lt;arne@...2639...=
..&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 31 inser=
tions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/96/896/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.=
yaml b/.github/workflows/build.yaml</span><br><span>index 3ebea79..9022e23 =
100644</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>+=
++ b/.github/workflows/build.yaml</span><br><span>@@ -35,6 +35,37 @@</span>=
<br><span>         run: test ! -s uncrustify-changes.patch</span><br><span>=
         working-directory: openvpn</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  android:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    strategy:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      fail-fast: false</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      matrix:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        abi: [ arm64-v8a ]</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        include:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          - abi: arm64-v8a</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            vcpkg_triplet: arm64-android</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    name: &quot;Andro=
id - ${{ matrix.abi }}&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    # Github images already setup NDK with ANDROID_NDK_ROOT pointi=
ng to the root</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #=
 of the SDK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    env:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_DEFAULT=
_TRIPLET: ${{ matrix.vcpkg_triplet }}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      VCPKG_ROOT: ${{ github.workspace }}/vcpkg</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_INSTALLED_DIR: ${=
{ github.workspace }}/vcpkg/installed</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    steps:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      - name: Checkout OpenVPN</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        uses: actions/checkout@...2844... # v4.2.2</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Install vc=
pkg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: lu=
kka/run-vcpkg@...2815... # v11.5</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        with:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Insta=
ll dependencies</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      - name: configure OpenVPN with cm=
ake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: cma=
ke -S . -B openvpn-build -DUNSUPPORTED_BUILDS=3Dyes -DCMAKE_SYSTEM_NAME=3DA=
ndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet=
 }} -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DCMAKE_ANDROID_ARCH_ABI=
=3D${{ matrix.abi }} -DENABLE_LZO=3Dfalse</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      - name: Build OpenVPN Android binary with cmake=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: cmake =
--build openvpn-build</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
   mingw:</span><br><span>     strategy:</span><br><span>       fail-fast: =
false</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail">change 896</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/896?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieb787a040f9eaf34d9d16996af1=
d63d7eae94944 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 896 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--LkQ+Qtk6M5U=--

