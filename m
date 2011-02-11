From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:35 +0200
Message-Id: <1297436985-18991-3-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 03/13] Moved TAP-driver version info to
	version.m4. Cleaned up win/settings.in.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Previously parts of TAP-driver version information were stored in
win/settings.in. This patch moves all of it to version.m4. This patch also
cleans up and adds comments to win/settings.in
---
 version.m4      |    5 ++++-
 win/settings.in |   25 +++++++++----------------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/version.m4 b/version.m4
index 794a4a8..475a82f 100644
--- a/version.m4
+++ b/version.m4
@@ -1,6 +1,9 @@
 dnl define the OpenVPN version
-define(PRODUCT_VERSION,[2.2-beta5])
+define(PRODUCT_VERSION,[2.2-rc])
 dnl define the TAP version
 define(PRODUCT_TAP_ID,[tap0901])
 define(PRODUCT_TAP_WIN32_MIN_MAJOR,[9])
 define(PRODUCT_TAP_WIN32_MIN_MINOR,[1])
+define(PRODUCT_TAP_RELDATE,[04/19/2010])
+define(PRODUCT_TAP_DEVICE_DESCRIPTION,[TAP-Win32 Adapter V9])
+define(PRODUCT_TAP_PROVIDER,[TAP-Win32 Provider V9])
diff --git a/win/settings.in b/win/settings.in
index f8eeb20..c349752 100644
--- a/win/settings.in
+++ b/win/settings.in
@@ -1,39 +1,32 @@
 # Version numbers, settings, and dependencies
 # for Windows OpenVPN installer.
+#
+# Note that some variables are parsed by wb.py from version.m4 and are not 
+# stored in this file. This is done to allow using the old and new Windows build 
+# systems side-by-side
 
 # Branding
 !define PRODUCT_NAME      "OpenVPN"
 !define PRODUCT_UNIX_NAME "openvpn"
 !define PRODUCT_FILE_EXT  "ovpn"
 
-# Allow --askpass and --auth-user-pass passwords to be read from a file
-;!define ENABLE_PASSWORD_SAVE
-
-# Include the OpenVPN GUI exe in the installer.
-# May be undefined.
+# Include the OpenVPN GUI exe in the installer. Comment out USE_GUI to disable.
+!define USE_GUI
 !define OPENVPN_GUI_DIR "../openvpn-gui"
 !define OPENVPN_GUI     "openvpn-gui-1.0.3.exe"
 
 # Prebuilt libraries.  DMALLOC is optional.
 !define OPENSSL_DIR	  "../openssl"
 !define LZO_DIR		  "../lzo"
+!define PKCS11_HELPER_DIR "../pkcs11-helper"
 
 # write output files here
 !define DIST   "dist"
 
-# tapinstall.exe source code.
-# Not needed if DRVBINSRC is defined
-# (or if using pre-built mode).
+# tapinstall.exe (a.k.a. devcon.exe) source code. Not needed if DRVBINSRC is 
+# defined (or if using pre-built mode).
 !define TISRC	"../tapinstall"
 
-# TAP Adapter parameters.  Note that PRODUCT_TAP_ID is
-# defined in version.m4.
-!define PRODUCT_TAP_DEVICE_DESCRIPTION  "TAP-Win32 Adapter V9"
-!define PRODUCT_TAP_PROVIDER            "TAP-Win32 Provider V9"
-!define PRODUCT_TAP_MAJOR_VER           9
-!define PRODUCT_TAP_MINOR_VER           7
-!define PRODUCT_TAP_RELDATE             "04/19/2010"
-
 # TAP adapter icon -- visible=0x81 or hidden=0x89
 !define PRODUCT_TAP_CHARACTERISTICS     0x81
 
-- 
1.6.3.3


