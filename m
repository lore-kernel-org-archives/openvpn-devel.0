From: Simon Rozman <simon@...2293...>
Date: Tue, 16 Oct 2018 12:26:25 +0200
Message-Id: <20181016102627.18676-3-simon@...2293...>
In-Reply-To: <20181016102627.18676-1-simon@...2293...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5] Define _WIN32_WINNT=_WIN32_WINNT_VISTA
 in MSVC
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

This makes MSVC and MinGW build environments more alike.
---
 src/openvpnmsica/openvpnmsica.props | 1 +
 src/tapctl/tapctl.props             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpnmsica/openvpnmsica.props b/src/openvpnmsica/openvpnmsica.props
index fa408296..074635d0 100644
--- a/src/openvpnmsica/openvpnmsica.props
+++ b/src/openvpnmsica/openvpnmsica.props
@@ -8,6 +8,7 @@
   <ItemDefinitionGroup>
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_WIN32_WINNT=_WIN32_WINNT_VISTA;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
     <Link>
       <SubSystem>Windows</SubSystem>
diff --git a/src/tapctl/tapctl.props b/src/tapctl/tapctl.props
index 152954ed..0257b9ff 100644
--- a/src/tapctl/tapctl.props
+++ b/src/tapctl/tapctl.props
@@ -7,7 +7,7 @@
   </PropertyGroup>
   <ItemDefinitionGroup>
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CONSOLE;_WIN32_WINNT=_WIN32_WINNT_VISTA;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <Link>
-- 
2.19.0.windows.1


