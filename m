Message-ID: <4D244044.9000204@...515...>
Date: Wed, 05 Jan 2011 11:56:20 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090804000102000600030001"
Subject: [Openvpn-devel] [PATCH 3/6] Added PKCS11_HELPER_DIR directive to
	win/settings.in
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090804000102000600030001
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------090804000102000600030001
Content-Type: text/x-patch;
	name="0003-Added-PKCS11_HELPER_DIR-directive-to-win-settings.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0003-Added-PKCS11_HELPER_DIR-directive-to-win-settings.in.pa";
	filename*1="tch"

From e46bee78a2d5bbdfc140bccad37c37344a32e604 Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Mon, 3 Jan 2011 16:08:37 +0200
Subject: [PATCH 3/6] Added PKCS11_HELPER_DIR directive to win/settings.in.

This variable is needed when NSI installer generation is integrated to the
Python-based build system.
---
 win/settings.in |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/win/settings.in b/win/settings.in
index f8eeb20..0dd3bfc 100644
--- a/win/settings.in
+++ b/win/settings.in
@@ -1,5 +1,9 @@
 # Version numbers, settings, and dependencies
 # for Windows OpenVPN installer.
+#
+# Note that some variables are parsed by wb.py from version.m4 and are not 
+# stored in this file. This is done to allow using the old and new Windows build 
+# systems side-by-side
 
 # Branding
 !define PRODUCT_NAME      "OpenVPN"
@@ -17,13 +21,13 @@
 # Prebuilt libraries.  DMALLOC is optional.
 !define OPENSSL_DIR	  "../openssl"
 !define LZO_DIR		  "../lzo"
+!define PKCS11_HELPER_DIR "../pkcs11-helper"
 
 # write output files here
 !define DIST   "dist"
 
-# tapinstall.exe source code.
-# Not needed if DRVBINSRC is defined
-# (or if using pre-built mode).
+# devcon.exe (a.k.a. tapinstall.exe) source code. Not needed if DRVBINSRC is 
+# defined (or if using pre-built mode).
 !define TISRC	"../tapinstall"
 
 # TAP Adapter parameters.  Note that PRODUCT_TAP_ID is
-- 
1.6.3.3


--------------090804000102000600030001--

