From: Simon Rozman <simon@...2293...>
Date: Tue, 16 Oct 2018 12:26:23 +0200
Message-Id: <20181016102627.18676-1-simon@...2293...>
In-Reply-To: <20181010192337.6984-1-simon@...2293...>
References: <20181010192337.6984-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/5] Set output name to libopenvpnmsica.dll
 in MSVC builds too
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

On MinGW builds, the Libtool produces libopenvpnmsica.dll. The MSVC
properties were updated to match this.
---
 src/openvpnmsica/openvpnmsica.props        | 4 +++-
 src/openvpnmsica/openvpnmsica_resources.rc | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.props b/src/openvpnmsica/openvpnmsica.props
index 0e31bc4f..fa408296 100644
--- a/src/openvpnmsica/openvpnmsica.props
+++ b/src/openvpnmsica/openvpnmsica.props
@@ -2,7 +2,9 @@
 <Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ImportGroup Label="PropertySheets" />
   <PropertyGroup Label="UserMacros" />
-  <PropertyGroup />
+  <PropertyGroup>
+    <TargetName>lib$(ProjectName)</TargetName>
+  </PropertyGroup>
   <ItemDefinitionGroup>
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnmsica_resources.rc
index ce60b4a1..9e8069f4 100644
--- a/src/openvpnmsica/openvpnmsica_resources.rc
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -50,7 +50,7 @@ BEGIN
             VALUE "FileVersion", PACKAGE_VERSION ".0"
             VALUE "InternalName", "OpenVPN"
             VALUE "LegalCopyright", "Copyright © The OpenVPN Project" 
-            VALUE "OriginalFilename", "openvpnmsica.dll"
+            VALUE "OriginalFilename", "libopenvpnmsica.dll"
             VALUE "ProductName", "OpenVPN"
             VALUE "ProductVersion", PACKAGE_VERSION ".0"
         END
-- 
2.19.0.windows.1


