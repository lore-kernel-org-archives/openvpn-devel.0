From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 20 Jan 2020 12:37:01 +0200
Message-Id: <20200120103701.913-1-lstipakov@...277...>
In-Reply-To: <20200120082841.633-1-lstipakov@...277...>
References: <20200120082841.633-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: add missing include
 directory
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
but didn't add include directory to msvc project file
nor mingw makefile.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v2: modify also Makefile.am

 src/openvpnserv/Makefile.am         | 3 ++-
 src/openvpnserv/openvpnserv.vcxproj | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index f8d3319c..00acee31 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -25,7 +25,8 @@ sbin_PROGRAMS = openvpnserv
 openvpnserv_CFLAGS = \
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
+	-D_WIN32_WINNT=_WIN32_WINNT_VISTA \
+	$(OPTIONAL_CRYPTO_CFLAGS)
 openvpnserv_LDADD = -ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 -lshlwapi -lnetapi32 -lws2_32 -lntdll
 endif
 
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


