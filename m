From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 11 Oct 2019 12:03:45 +0300
Message-Id: <1570784625-8837-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Visual Studio: make it easier to build with
 VS
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

This changes default path to openvpn dependencies, so that
openvpn-build and openvpn projects can be cloned from the same
folder:

  c:\Users\Administrator\Projects>git clone git@...1714...:OpenVPN/openvpn-build.git
  c:\Users\Administrator\Projects>git clone git@...1714...:OpenVPN/openvpn.git

This also removes the necessity of copying openvpn-build\msvc\image
to %USERPROFILE%.

To use Visual Studio, clone both projects, install dependencies
(VS2017 Community with SDK 10.0.17143, Strawberry Perl) and run:

  c:\Users\Administrator\Projects\openvpn-build\msvc\build.bat

Then just open solution file:

  c:\Users\Administrator\Projects\openvpn\openvpn.sln

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/compat/PropertySheet.props | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/compat/PropertySheet.props b/src/compat/PropertySheet.props
index 4cad994..fdded31 100644
--- a/src/compat/PropertySheet.props
+++ b/src/compat/PropertySheet.props
@@ -3,7 +3,7 @@
   <ImportGroup Label="PropertySheets" />
   <PropertyGroup Label="UserMacros">
     <SOURCEBASE>$(SolutionDir)</SOURCEBASE>
-    <OPENVPN_DEPROOT>$(SOURCEBASE)\..\..\image</OPENVPN_DEPROOT>
+    <OPENVPN_DEPROOT>$(SOURCEBASE)\..\openvpn-build\msvc\image</OPENVPN_DEPROOT>
     <OPENSSL_HOME>$(OPENVPN_DEPROOT)</OPENSSL_HOME>
     <TAP_WINDOWS_HOME>$(OPENVPN_DEPROOT)</TAP_WINDOWS_HOME>
     <LZO_HOME>$(OPENVPN_DEPROOT)</LZO_HOME>
-- 
2.7.4


