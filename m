From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  7 Nov 2019 19:45:23 +0200
Message-Id: <1573148729-27339-2-git-send-email-lstipakov@...277...>
In-Reply-To: <1573148729-27339-1-git-send-email-lstipakov@...277...>
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2 1/7] Visual Studio: upgrade project files
 to VS2019
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
 src/compat/compat.vcxproj             | 12 ++++++------
 src/openvpn/openvpn.vcxproj           | 12 ++++++------
 src/openvpnmsica/openvpnmsica.vcxproj | 14 +++++++-------
 src/openvpnserv/openvpnserv.vcxproj   | 12 ++++++------
 src/tapctl/tapctl.vcxproj             | 14 +++++++-------
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index 111dacd..e388008 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -22,30 +22,30 @@
     <ProjectGuid>{4B2E2719-E661-45D7-9203-F6F456B22F19}</ProjectGuid>
     <RootNamespace>compat</RootNamespace>
     <Keyword>Win32Proj</Keyword>
-    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
@@ -115,4 +115,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 4ffff2b..e77f026 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -22,30 +22,30 @@
     <ProjectGuid>{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}</ProjectGuid>
     <RootNamespace>openvpn</RootNamespace>
     <Keyword>Win32Proj</Keyword>
-    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
@@ -301,4 +301,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj
index 5f1d699..afa4fae 100644
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ b/src/openvpnmsica/openvpnmsica.vcxproj
@@ -31,32 +31,32 @@
     <ProjectGuid>{D41AA9D6-B818-476E-992E-0E16EB86BEE2}</ProjectGuid>
     <Keyword>Win32Proj</Keyword>
     <RootNamespace>openvpnmsica</RootNamespace>
-    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
@@ -64,14 +64,14 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index 7407757..7061b7b 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -22,30 +22,30 @@
     <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
     <RootNamespace>openvpnserv</RootNamespace>
     <Keyword>Win32Proj</Keyword>
-    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
@@ -139,4 +139,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
index 5c1983b..1d593fc 100644
--- a/src/tapctl/tapctl.vcxproj
+++ b/src/tapctl/tapctl.vcxproj
@@ -31,32 +31,32 @@
     <ProjectGuid>{A06436E7-D576-490D-8BA0-0751D920334A}</ProjectGuid>
     <Keyword>Win32Proj</Keyword>
     <RootNamespace>tapctl</RootNamespace>
-    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
@@ -64,14 +64,14 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
-- 
2.7.4


