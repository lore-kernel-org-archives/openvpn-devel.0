From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 17 Sep 2019 15:44:47 +0300
Message-Id: <1568724293-5069-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/7] Visual Studio: upgrade project files to
 VS2019
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

From: Lev Stipakov <lev@...515...>

This set of patches adds support of wintun kernel driver (https://www.wintun.net) to OpenVPN.

While wintun is in beta, it performs significantly faster comparison to tap-windows6.

Here are some performance numbers (download bandwidth):

Server - community openvpn2

mingw, tap-windows6   - 340Mbit/s
mingw, wintun         - 675Mbit/s
VS2019, tap-windows6  - 425Mbit/s
VS2019, wintun        - 750Mbit/s

Server - propietary openvpn3 with kernel acceleration (in development)

mingw, tap-windows6   - 360Mbit/s
mingw, wintun         - 840Mbit/s
VS2019, tap-windows6  - 430Mbit/s
VS2019, wintun        - 1,14Gbit/s

And for the reference
openvpn3 test client, VS2019, wintun - 1,71Gbit/s

Some observations from those numbers:

    * wintun performs more than twice faster comparison to tap-windows6 agains community server (750Mbit/s vs 340Mbit/s)
    * Visual Studio provides noticeable performance boost (up to 25%)
        * we should build Windows clients with VS, not with mingw
    * There's room for improvement in openvpn2, since under best conditions openvpn3 performs 50% faster

Steps to try out new client:

    * Install Wintun driver
        * since driver is not signed, you need to enable test mode to install unsigned driver
            * run in administrative command prompt:
              bcdedit /set testsigning on
            * restart
        * download and unpack https://staging.openvpn.net/openvpn2/wintun-0.6-unsigned.zip to C:\Temp\wintun (for example)
        * if you have OpenVPN GUI client installed, run under administrative command prompt:
          c:\Program Files\TAP-Windows\bin>tapinstall.exe install c:\Temp\wintun\wintun.inf wintun
        * alternatively you can install driver via windows device manager -> action ->add legacy hardware -> install manually ->
          point to wintun.inf in C:\Temp\wintun

    * Install openvpn client with wintun support
        * download and unpack https://staging.openvpn.net/openvpn2/openvpn2-wintun-support.zip to C:\Temp\openvpn (for example)
        * if you use OpenVPN GUI, copy all files from C:\Temp\openvpn to C:\Program Files\OpenVPN\bin. Don't forget to 
          stop OpenVPN Interactive Service before copying and start it back afterwards (net stop/start OpenVPNServiceInteractive in admin command prompt)

    * Connect to VPN from command line
        * run from administrative command prompt
          c:\Temp\openvpn>openvpn.exe --config client.ovpn --windows-driver wintun
        * you should see something around these lines in log
          Tue Sep 17 15:09:58 2019 us=296000 interactive service msg_channel=0
          Tue Sep 17 15:09:58 2019 us=312000 open_tun
          Tue Sep 17 15:09:58 2019 us=312000 Wintun device [Lähiverkkoyhteys] opened: \\?\ROOT#NET#0004#{cac88484-7515-4c03-82e6-71a87abac361}
          Tue Sep 17 15:09:58 2019 us=312000 do_ifconfig, ipv4=1, ipv6=0
          Tue Sep 17 15:09:59 2019 us=312000 NETSH: C:\Windows\system32\netsh.exe interface ip set address Lähiverkkoyhteys static 10.8.0.2 255.255.255.0
          Tue Sep 17 15:10:00 2019 us=406000 NETSH: C:\Windows\system32\netsh.exe interface ip delete dns Lähiverkkoyhteys all
          Tue Sep 17 15:10:01 2019 us=484000 NETSH: C:\Windows\system32\netsh.exe interface ip set dns Lähiverkkoyhteys static 10.8.0.1
          Tue Sep 17 15:10:14 2019 us=578000 NETSH: C:\Windows\system32\netsh.exe interface ip delete wins Lähiverkkoyhteys all
          Tue Sep 17 15:10:19 2019 us=296000 TEST ROUTES: 0/0 succeeded len=0 ret=1 a=0 u/d=up
          Tue Sep 17 15:10:19 2019 us=296000 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
          Tue Sep 17 15:10:19 2019 us=296000 Initialization Sequence Completed
        * congratulations!

    * Connect to VPN from OpenVPN GUI
        * right click on tray icon -> profile name -> Edit Config
        * add "windows-driver wintun" to profile, save and close
        * right click on tray icon -> profile name -> Connect
        * you should see something around these lines in log
          Tue Sep 17 15:15:46 2019 interactive service msg_channel=676
          Tue Sep 17 15:15:46 2019 open_tun
          Tue Sep 17 15:15:46 2019 Wintun device [Lähiverkkoyhteys] opened: \\?\ROOT#NET#0004#{cac88484-7515-4c03-82e6-71a87abac361}
          Tue Sep 17 15:15:46 2019 Ring buffers registered via service
          Tue Sep 17 15:15:46 2019 do_ifconfig, ipv4=1, ipv6=0
          Tue Sep 17 15:15:46 2019 MANAGEMENT: >STATE:1568722546,ASSIGN_IP,,10.8.0.2,,,,
          Tue Sep 17 15:15:46 2019 Setting IPv4 dns servers on 'Lähiverkkoyhteys' (if_index = 3) using service
          Tue Sep 17 15:15:46 2019 IPv4 dns servers set using service
          Tue Sep 17 15:15:51 2019 TEST ROUTES: 0/0 succeeded len=0 ret=1 a=0 u/d=up
          Tue Sep 17 15:15:51 2019 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
          Tue Sep 17 15:15:51 2019 Initialization Sequence Completed
        * congratulations!

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
index 92d7e32..3422b64 100644
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
@@ -299,4 +299,4 @@
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


