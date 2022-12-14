From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 14 Dec 2022 18:09:40 +0200
Message-Id: <20221214160940.153-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] msvc: upgrade to Visual Studio 2022
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

Signed-off-by: Lev Stipakov <lev@...515...>
---
 build/msvc/msvc-generate/msvc-generate.vcxproj | 12 ++++++------
 src/compat/compat.vcxproj                      | 12 ++++++------
 src/openvpn/openvpn.vcxproj                    | 12 ++++++------
 src/openvpnmsica/openvpnmsica.vcxproj          | 12 ++++++------
 src/openvpnserv/openvpnserv.vcxproj            | 12 ++++++------
 src/tapctl/tapctl.vcxproj                      | 12 ++++++------
 6 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/msvc-generate/msvc-generate.vcxproj
index eae94709..70d411e4 100644
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
@@ -35,27 +35,27 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index fe03a51a..9fcfd6c6 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -37,39 +37,39 @@
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 9b5e416f..13755dae 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -37,39 +37,39 @@
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>NotSet</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj
index bf384db6..c9154b37 100644
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ b/src/openvpnmsica/openvpnmsica.vcxproj
@@ -37,7 +37,7 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
     <SpectreMitigation>Spectre</SpectreMitigation>
@@ -45,21 +45,21 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
@@ -68,7 +68,7 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <SpectreMitigation>Spectre</SpectreMitigation>
@@ -76,7 +76,7 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <SpectreMitigation>Spectre</SpectreMitigation>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index d42e9642..db3a446d 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -37,39 +37,39 @@
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
index 0fc22d97..6311d7fd 100644
--- a/src/tapctl/tapctl.vcxproj
+++ b/src/tapctl/tapctl.vcxproj
@@ -37,7 +37,7 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
     <SpectreMitigation>Spectre</SpectreMitigation>
@@ -45,21 +45,21 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
@@ -68,7 +68,7 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <SpectreMitigation>Spectre</SpectreMitigation>
@@ -76,7 +76,7 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v142</PlatformToolset>
+    <PlatformToolset>v143</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <SpectreMitigation>Spectre</SpectreMitigation>
-- 
2.23.0.windows.1


