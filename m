From: Simon Rozman <simon@...2293...>
Date: Mon,  8 Oct 2018 11:45:59 +0200
Message-Id: <20181008094600.10164-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] msvc: Unify Unicode/MultiByte string
 setting across all cfg|plat
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

The openvpnserv.vcxproj source code is Windows API Unicode compliant
with only Debug|x64 set to Unicode, while other cfg|plat pairs were set
to MultiByte.
---
 src/openvpnserv/openvpnserv.vcxproj | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index 9098920e..4edcf851 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -27,19 +27,19 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
+    <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
+    <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
+    <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
-- 
2.19.0.windows.1


