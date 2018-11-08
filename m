From: Jon Kunkee <jkunkee@...2393...>
Date: Thu, 8 Nov 2018 22:47:00 +0000
Message-ID: <DM5PR2101MB1112DE9F641FDBD3AB358469B0C50@...2412...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-3-simon@...2293...>
In-Reply-To: <20181016102627.18676-3-simon@...2293...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/5] Define
 _WIN32_WINNT=_WIN32_WINNT_VISTA in MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

LGTM, Samuli.

-----Original Message-----
From: Simon Rozman <simon@...2293...>=20
Sent: Tuesday, October 16, 2018 3:26 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH 3/5] Define _WIN32_WINNT=3D_WIN32_WINNT_VIS=
TA in MSVC

This makes MSVC and MinGW build environments more alike.
---
 src/openvpnmsica/openvpnmsica.props | 1 +
 src/tapctl/tapctl.props             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpnmsica/openvpnmsica.props b/src/openvpnmsica/openvpn=
msica.props
index fa408296..074635d0 100644
--- a/src/openvpnmsica/openvpnmsica.props
+++ b/src/openvpnmsica/openvpnmsica.props
@@ -8,6 +8,7 @@
   <ItemDefinitionGroup>
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;=
%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_WIN32_WINNT=3D_WIN32_WINNT_VISTA;%(Preproc=
essorDefinitions)</PreprocessorDefinitions>
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
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Prepro=
cessorDefinitions>
+      <PreprocessorDefinitions>_CONSOLE;_WIN32_WINNT=3D_WIN32_WINNT_VISTA;=
%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;=
%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <Link>
--=20
2.19.0.windows.1



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.so=
urceforge.net%2Flists%2Flistinfo%2Fopenvpn-devel&amp;data=3D02%7C01%7Cjkunk=
ee%40microsoft.com%7Cd4c1e876c17c480297d208d63351eb3e%7C72f988bf86f141af91a=
b2d7cd011db47%7C1%7C0%7C636752824279734760&amp;sdata=3DVNabZb0XFntX44P8XdBZ=
dXbEkFUTr3md02hzQ%2Bto0Yo%3D&amp;reserved=3D0

