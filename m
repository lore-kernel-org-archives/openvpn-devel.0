From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 15:32:47 +0000
In-Reply-To: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
References: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <bb4aa203676207fe8ce5a9d6577ebfdb67fba1b2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZjJTx3uc8UU="; charset=UTF-8
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

--ZjJTx3uc8UU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Add android build to Github Actions
......................................................................

Add android build to Github Actions

Change-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae94944
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
1 file changed, 31 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/896/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--ZjJTx3uc8UU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">Add android buil=
d to Github Actions<br><br>Change-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae9=
4944<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M .gi=
thub/workflows/build.yaml<br>1 file changed, 31 insertions(+), 0 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/9=
6/896/4</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/workflo=
ws/build.yaml</span><br><span>index 8fd1325..b1af7ec 100644</span><br><span=
>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/workflows=
/build.yaml</span><br><span>@@ -35,6 +35,37 @@</span><br><span>         run=
: test ! -s uncrustify-changes.patch</span><br><span>         working-direc=
tory: openvpn</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  android:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    strategy:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   fail-fast: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      matrix:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  abi: [ arm64-v8a ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        include:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
        - abi: arm64-v8a</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            vcpkg_triplet: arm64-android</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    name: &quot;Android - ${{ matrix.abi =
}}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Githu=
b images already setup NDK with ANDROID_NDK_ROOT pointing to the root</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    # of the SDK</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    env:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      VCPKG_DEFAULT_TRIPLET: ${{ matrix=
.vcpkg_triplet }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    VCPKG_ROOT: ${{ github.workspace }}/vcpkg</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      VCPKG_INSTALLED_DIR: ${{ github.workspace }=
}/vcpkg/installed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  steps:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - nam=
e: Checkout OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uses: actions/checkout@...2844... # v4.2.2</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      - name: Install vcpkg</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2829...=
5... # v11.5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcp=
kgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      - name: Install dependencies</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: ${VCPKG_ROO=
T}/vcpkg install openssl lz4 cmocka</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      - name: configure OpenVPN with cmake</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        run: cmake -S . -B openvpn-b=
uild -DUNSUPPORTED_BUILDS=3Dyes -DCMAKE_SYSTEM_NAME=3DAndroid -DOPENSSL_ROO=
T_DIR=3D${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} -DENABLE_PKCS11=
=3Dfalse -DBUILD_TESTING=3Dtrue -DCMAKE_ANDROID_ARCH_ABI=3D${{ matrix.abi }=
} -DENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      - name: Build OpenVPN Android binary with cmake<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: cmake -=
-build openvpn-build</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
  mingw:</span><br><span>     strategy:</span><br><span>       fail-fast: f=
alse</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/896?usp=3Demail">change 896</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/896?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieb787a040f9eaf34d9d16996af1=
d63d7eae94944 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 896 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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


--ZjJTx3uc8UU=--

