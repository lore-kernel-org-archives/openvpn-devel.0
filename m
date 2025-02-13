From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 13 Feb 2025 15:25:08 +0000
References: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <991534b17e0d7ea6815039e7bc17021d3e6e9d04-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RTavfT1DB3E="; charset=UTF-8
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

--RTavfT1DB3E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail

to review the following change.


Change subject: Add android build to Github Actions
......................................................................

Add android build to Github Actions

Change-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae94944
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
1 file changed, 24 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/896/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 3ebea79..0be5440 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -35,6 +35,30 @@
         run: test ! -s uncrustify-changes.patch
         working-directory: openvpn

+  android:
+    runs-on: ubuntu-24.04
+    name: "Android - arm64"
+    # Github images already setup NDK with ANDROID_NDK_ROOT pointing to th=
e root
+    # of the SDK
+    env:
+      VCPKG_DEFAULT_TRIPLET: arm64-android
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
E_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INSTALLED_DIR}/arm64-a=
ndroid -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DCMAKE_ANDROID_ARCH_=
ABI=3Darm64-v8a -DENABLE_LZO=3Dfalse
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--RTavfT1DB3E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add android build to Github Actions<br><br>Change-Id: Ieb787a=
040f9eaf34d9d16996af1d63d7eae94944<br>Signed-off-by: Arne Schwabe &lt;arne@=
...1227...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, =
24 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/96/896/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflow=
s/build.yaml b/.github/workflows/build.yaml</span><br><span>index 3ebea79..=
0be5440 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br=
><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -35,6 +35,30 @=
@</span><br><span>         run: test ! -s uncrustify-changes.patch</span><b=
r><span>         working-directory: openvpn</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  android:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    name: &quot;Android - arm64&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Github imag=
es already setup NDK with ANDROID_NDK_ROOT pointing to the root</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    # of the SDK</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    env:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      VCPKG_DEFAULT_TRIPLET: arm64-android</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_ROOT: ${{ =
github.workspace }}/vcpkg</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    steps:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      - name: Checkout OpenVPN<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: action=
s/checkout@...2844... # v4.2.2</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      - name: Install vcpkg</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2815... # v11.5</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        with:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 80d54=
ff62d528339c626a6fbc3489a7f25956ade</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      - name: Install dependencies</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        run: ${VCPKG_ROOT}/vcpkg install ope=
nssl lz4 cmocka</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  - name: configure OpenVPN with cmake</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        run: cmake -S . -B openvpn-build -DUNSUPPORTED_B=
UILDS=3Dyes -DCMAKE_SYSTEM_NAME=3DAndroid -DOPENSSL_ROOT_DIR=3D${VCPKG_INST=
ALLED_DIR}/arm64-android -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DC=
MAKE_ANDROID_ARCH_ABI=3Darm64-v8a -DENABLE_LZO=3Dfalse</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      - name: Build OpenVPN Android bina=
ry with cmake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  run: cmake --build openvpn-build</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>   mingw:</span><br><span>     strategy:</span><br><span>     =
  fail-fast: false</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/896?usp=3Demail">change 896</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/896?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieb787a040f9eaf34d9d16996af1=
d63d7eae94944 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 896 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--RTavfT1DB3E=--

