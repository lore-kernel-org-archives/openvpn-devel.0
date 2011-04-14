From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Thu, 14 Apr 2011 17:41:23 +0300
Message-Id: <1302792083-9066-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH] Removed Win2k from supported platforms list
	in INSTALL and win/openvpn.nsi
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

---
 INSTALL         |    4 ++--
 win/openvpn.nsi |    4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index 7af6426..ab0d671 100644
--- a/INSTALL
+++ b/INSTALL
@@ -42,7 +42,7 @@ SUPPORTED PLATFORMS:
   (4) Mac OS X Darwin
   (5) FreeBSD
   (6) NetBSD
-  (7) Windows (Win 2K and higher)
+  (7) Windows (WinXP and higher)
 
 SUPPORTED PROCESSOR ARCHITECTURES:
    In general, OpenVPN is word size and endian independent, so
@@ -280,7 +280,7 @@ TUN/TAP Driver Configuration:
   needs to be manually copied to /kernel/drv/sparcv9/ and then a 
   reconfiguration reboot. (boot -r).
 
-* Windows 2000/XP/2003/Vista
+* Windows XP/2003/Vista
 
   See domake-win for building instructions.
   See INSTALL-win32.txt for usage info.
diff --git a/win/openvpn.nsi b/win/openvpn.nsi
index 12226d5..bad1ef4 100755
--- a/win/openvpn.nsi
+++ b/win/openvpn.nsi
@@ -76,7 +76,7 @@ SetCompressor lzma
 
   Name "${PRODUCT_NAME} ${VERSION} ${TITLE_LABEL}"
 
-  !define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of ${PRODUCT_NAME}, an Open Source VPN package by James Yonan.\r\n\r\nNote that the Windows version of ${PRODUCT_NAME} will only run on Win 2000, XP, or higher.\r\n\r\n\r\n"
+  !define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of ${PRODUCT_NAME}, an Open Source VPN package by James Yonan.\r\n\r\nNote that the Windows version of ${PRODUCT_NAME} only runs on XP, or higher.\r\n\r\n\r\n"
 
   !define MUI_COMPONENTSPAGE_TEXT_TOP "Select the components to install/upgrade.  Stop any ${PRODUCT_NAME} processes or the ${PRODUCT_NAME} service if it is running.  All DLLs are installed locally."
 
@@ -812,6 +812,4 @@ Section "Uninstall"
   DeleteRegKey HKCU "Software\${PRODUCT_NAME}"
   DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
 
-  ;Messagebox MB_OK "IMPORTANT: If you intend on reinstalling ${PRODUCT_NAME} after this uninstall, and you are running Win2K, you are strongly urged to reboot before reinstalling (this is an informational message only, pressing OK will not reboot)."
-
 SectionEnd
-- 
1.6.3.3


