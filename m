From: Simon Rozman <simon@...2293...>
Date: Fri, 8 Nov 2019 15:53:29 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10BDA4A11E@...2294...>
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-2-git-send-email-lstipakov@...277...>
In-Reply-To: <1573148729-27339-2-git-send-email-lstipakov@...277...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_005F_01D59655.0B03E990"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] Visual Studio: upgrade project
 files to VS2019
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

------=_NextPart_000_005F_01D59655.0B03E990
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Acked-by: Simon Rozman <simon@...2293...>

Note, the OpenSSL and other dependencies should also be built using the same
version of MSVC.

Best regards,
Simon

-----Original Message-----
From: Lev Stipakov [mailto:lstipakov@...277...] 
Sent: Thursday, November 7, 2019 6:45 PM
To: openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>
Subject: [Openvpn-devel] [PATCH v2 1/7] Visual Studio: upgrade project files
to VS2019

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
-
<WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup
Condition="'$(Configuration)|$(Platform)'=='Release|Win32'"
Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'"
Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'"
Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'"
Label="Configuration">
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
-
<WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup
Condition="'$(Configuration)|$(Platform)'=='Release|Win32'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'"
Label="Configuration">
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
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj
b/src/openvpnmsica/openvpnmsica.vcxproj
index 5f1d699..afa4fae 100644
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ b/src/openvpnmsica/openvpnmsica.vcxproj
@@ -31,32 +31,32 @@
     <ProjectGuid>{D41AA9D6-B818-476E-992E-0E16EB86BEE2}</ProjectGuid>
     <Keyword>Win32Proj</Keyword>
     <RootNamespace>openvpnmsica</RootNamespace>
-
<WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'"
Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'"
Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'"
Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup
Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'"
Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
@@ -64,14 +64,14 @@
   <PropertyGroup
Condition="'$(Configuration)|$(Platform)'=='Release|Win32'"
Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'"
Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
diff --git a/src/openvpnserv/openvpnserv.vcxproj
b/src/openvpnserv/openvpnserv.vcxproj
index 7407757..7061b7b 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -22,30 +22,30 @@
     <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
     <RootNamespace>openvpnserv</RootNamespace>
     <Keyword>Win32Proj</Keyword>
-
<WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup
Condition="'$(Configuration)|$(Platform)'=='Release|Win32'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'"
Label="Configuration">
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
-
<WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup
Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
@@ -64,14 +64,14 @@
   <PropertyGroup
Condition="'$(Configuration)|$(Platform)'=='Release|Win32'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'"
Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>false</UseDebugLibraries>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
-- 
2.7.4



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

------=_NextPart_000_005F_01D59655.0B03E990
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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

------=_NextPart_000_005F_01D59655.0B03E990--

