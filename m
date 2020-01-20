From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 20 Jan 2020 10:28:41 +0200
Message-Id: <20200120082841.633-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] msvc: add missing include directory
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

Commit ab27c9f added inclusion of openssl header
but didn't add include directory to msvc project file.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnserv/openvpnserv.vcxproj | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index c5a34b87..f2eb805f 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -72,7 +72,7 @@
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;$(OPENSSL_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
     <ResourceCompile />
@@ -83,7 +83,7 @@
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;$(OPENSSL_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
     <ResourceCompile />
@@ -94,7 +94,7 @@
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;$(OPENSSL_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
     <ResourceCompile />
@@ -105,7 +105,7 @@
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;$(OPENSSL_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
     <ResourceCompile />
-- 
2.17.1


