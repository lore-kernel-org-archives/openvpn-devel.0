From: selva.nair@...277...
Date: Tue, 24 Apr 2018 22:25:20 -0400
Message-Id: <1524623120-23498-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH tap-windows6] Have the driver version
 display as major.minor.revision.build
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

From: Selva Nair <selva.nair@...277...>

The driver version (taken from the INF) and the file version of
tap0901.sys file (from its resource) will now display like
9.22.1.601.

The driver details tab will continue to show the text form of
the version as "major.minor.revision (major/minor)".
Eg., "9.22.1 (9/22)"

Signed-off-by: Selva Nair <selva.nair@...277...>
---

Not sure this should be submitted as a PR  or like this..

An image showing the version is here
https://user-images.githubusercontent.com/3981391/39222715-29500c5a-480c-11e8-823a-73328baf69dd.PNG
But I would like to test again using a properly signed version 

 src/OemVista.inf.in | 2 +-
 src/config.h.in     | 2 ++
 src/resource.rc     | 2 +-
 version.m4          | 4 ++--
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/OemVista.inf.in b/src/OemVista.inf.in
index 004ed62..26152f5 100644
--- a/src/OemVista.inf.in
+++ b/src/OemVista.inf.in
@@ -55,7 +55,7 @@
 
 ; This version number should match the version
 ; number given in SOURCES.
-   DriverVer=@PRODUCT_TAP_WIN_RELDATE@,@PRODUCT_TAP_WIN_MAJOR@...1678...@PRODUCT_TAP_WIN_MINOR@
+   DriverVer=@PRODUCT_TAP_WIN_RELDATE@,@PRODUCT_TAP_WIN_MAJOR@...220...@PRODUCT_TAP_WIN_MINOR@...220...@PRODUCT_TAP_WIN_REVISION@...220...@PRODUCT_TAP_WIN_BUILD@
 
 [Strings]
    DeviceDescription = "@PRODUCT_TAP_WIN_DEVICE_DESCRIPTION@"
diff --git a/src/config.h.in b/src/config.h.in
index 322afa8..c013348 100644
--- a/src/config.h.in
+++ b/src/config.h.in
@@ -7,3 +7,5 @@
 #define PRODUCT_TAP_WIN_PROVIDER		"@PRODUCT_TAP_WIN_PROVIDER@"
 #define PRODUCT_TAP_WIN_DEVICE_DESCRIPTION	"@PRODUCT_TAP_WIN_DEVICE_DESCRIPTION@"
 #define PRODUCT_TAP_WIN_RELDATE		"@PRODUCT_TAP_WIN_RELDATE@"
+#define PRODUCT_TAP_WIN_REVISION	@PRODUCT_TAP_WIN_REVISION@
+#define PRODUCT_TAP_WIN_BUILD		@PRODUCT_TAP_WIN_BUILD@
diff --git a/src/resource.rc b/src/resource.rc
index 3c40d03..229e437 100644
--- a/src/resource.rc
+++ b/src/resource.rc
@@ -44,7 +44,7 @@
 
 
 #define VER_PRODUCTNAME_STR         VER_FILEDESCRIPTION_STR
-#define VER_PRODUCTVERSION	    PRODUCT_TAP_WIN_MAJOR,00,00,PRODUCT_TAP_WIN_MINOR
+#define VER_PRODUCTVERSION	    PRODUCT_TAP_WIN_MAJOR,PRODUCT_TAP_WIN_MINOR,PRODUCT_TAP_WIN_REVISION,PRODUCT_TAP_WIN_BUILD
 
 #define XSTR(s) STR(s)
 #define STR(s) #s
diff --git a/version.m4 b/version.m4
index 1d7f92e..955b418 100644
--- a/version.m4
+++ b/version.m4
@@ -2,7 +2,7 @@ dnl define the TAP version
 define([PRODUCT_NAME], [TAP-Windows])
 define([PRODUCT_PUBLISHER], [OpenVPN Technologies, Inc.])
 define([PRODUCT_VERSION], [9.22.1])
-define([PRODUCT_VERSION_RESOURCE], [9,0,0,22])
+define([PRODUCT_VERSION_RESOURCE], [9,22,1,601])
 define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
 define([PRODUCT_TAP_WIN_MAJOR], [9])
 define([PRODUCT_TAP_WIN_MINOR], [22])
@@ -11,4 +11,4 @@ define([PRODUCT_TAP_WIN_BUILD], [601])
 define([PRODUCT_TAP_WIN_PROVIDER], [TAP-Windows Provider V9])
 define([PRODUCT_TAP_WIN_CHARACTERISTICS], [0x81])
 define([PRODUCT_TAP_WIN_DEVICE_DESCRIPTION], [TAP-Windows Adapter V9])
-define([PRODUCT_TAP_WIN_RELDATE], [04/15/2018])
+define([PRODUCT_TAP_WIN_RELDATE], [04/24/2018])
-- 
2.6.2


