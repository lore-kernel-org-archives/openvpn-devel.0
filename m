From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  5 May 2022 13:38:38 +0300
Message-Id: <20220505103838.122-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH release/2.5] vcpkg: switch to manifest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Add vcpkg manifest file which lists
dependencies and enable manifest usage in
project file.

This simplifies build process by eliminating
separate "vcpkg install" step to install dependencies.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml | 15 ++++++---------
 .gitignore                   |  1 +
 src/openvpn/openvpn.vcxproj  |  9 +++++++++
 src/openvpn/vcpkg.json       | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 9 deletions(-)
 create mode 100644 src/openvpn/vcpkg.json

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index dbb05739..c1215cef 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -268,19 +268,16 @@ jobs:
       - name: Install rst2html
         run: python -m pip install --upgrade pip rst2html
 
-      - name: Restore artifacts, or run vcpkg, build and cache artifacts
-        uses: lukka/run-vcpkg@...2638...
+      - name: Restore artifacts, or setup vcpkg (do not install any package)
+        uses: lukka/run-vcpkg@...2637...
         with:
-          vcpkgGitCommitId: 'a69b65229b3956b7f45abd81671b7330114bcaad'
-          vcpkgArguments: 'openssl lz4 lzo pkcs11-helper tap-windows6'
-          vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
-          cleanAfterBuild: false
+          vcpkgGitCommitId: '4b766c1cd17205e1b768c4fadfd5f867c1d0510e'
 
-      - name: Build
+      - name: Run MSBuild consuming vcpkg.json
         working-directory: ${{env.GITHUB_WORKSPACE}}
         run: |
-          vcpkg integrate install
-          msbuild /m /p:Configuration=${{env.BUILD_CONFIGURATION}} /p:Platform="${{ matrix.plat }}" .
+            vcpkg integrate install
+            msbuild /m /p:Configuration=${{env.BUILD_CONFIGURATION}} /p:Platform="${{ matrix.plat }}" .
 
       - name: Archive artifacts
         uses: actions/upload-artifact@...2620...
diff --git a/.gitignore b/.gitignore
index 178076ed..7335154f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,7 @@ m4/ltoptions.m4
 m4/ltsugar.m4
 m4/ltversion.m4
 m4/lt~obsolete.m4
+vcpkg_installed
 
 version.sh
 msvc-env-local.bat
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 05c63b03..7f09249b 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -124,26 +124,35 @@
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg">
+    <VcpkgEnableManifest>true</VcpkgEnableManifest>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
diff --git a/src/openvpn/vcpkg.json b/src/openvpn/vcpkg.json
new file mode 100644
index 00000000..a5509736
--- /dev/null
+++ b/src/openvpn/vcpkg.json
@@ -0,0 +1,18 @@
+{
+  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scripts/vcpkg.schema.json",
+  "name": "openvpn",
+  "version": "2.5",
+  "dependencies": [
+    "openssl",
+    "tap-windows6",
+    "lzo",
+    "pkcs11-helper"
+  ],
+  "builtin-baseline": "4b766c1cd17205e1b768c4fadfd5f867c1d0510e",
+  "overrides": [
+    {
+      "name": "openssl",
+      "version-string": "1.1.1n"
+    }
+  ]
+}
-- 
2.23.0.windows.1


