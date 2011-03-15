From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Tue, 15 Mar 2011 16:36:41 +0200
Message-Id: <1300199801-4712-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixes to win/openvpn.nsi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Added support for generating installer with unsigned TAP drivers. Fixed Win=
dows
Vista/7 Start menu shortcut uninstall failure.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 win/openvpn.nsi |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/win/openvpn.nsi b/win/openvpn.nsi
index cbae21a..16837a1 100755
--- a/win/openvpn.nsi
+++ b/win/openvpn.nsi
@@ -7,6 +7,12 @@
=20
 ; OpenVPN install script for Windows, using NSIS
=20
+; Start menu entries don't get uninstalled properly on Windows Vista/7 unl=
ess we=20
+; explicitly state that the installer requires admin privileges. This is=20
+; caused by backwards compatibility tricks used on those platforms. For de=
tails,=20
+; see http://nsis.sourceforge.net/Shortcuts_removal_fails_on_Windows_Vista=
=20
+RequestExecutionLevel admin
+
 SetCompressor lzma
=20
 !include "MUI.nsh"
@@ -394,7 +400,9 @@ Section "TAP Virtual Ethernet Adapter" SecTAP
=20
   File "${GEN}\amd64\OemWin2k.inf"
   File "${GEN}\amd64\${TAPDRV}"
-  File "${GEN}\amd64\${PRODUCT_TAP_ID}.cat"
+
+  # Don't try to install TAP driver signature if it does not exist.
+  File /nonfatal "${GEN}\amd64\${PRODUCT_TAP_ID}.cat"
=20
 goto tapend
=20
@@ -408,7 +416,9 @@ tap-32bit:
   SetOutPath "$INSTDIR\driver"
   File "${GEN}\i386\OemWin2k.inf"
   File "${GEN}\i386\${TAPDRV}"
-  File "${GEN}\i386\${PRODUCT_TAP_ID}.cat"
+
+  # Don't try to install TAP driver signature if it does not exist.
+  File /nonfatal "${GEN}\i386\${PRODUCT_TAP_ID}.cat"
=20
   tapend:
=20
@@ -428,6 +438,8 @@ SectionEnd
=20
 Section "Add Shortcuts to Start Menu" SecAddShortcuts
=20
+  ; Required to handle shortcuts properly on Vista/7
+  SetShellVarContext all
   SetOverwrite on
   CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
   CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}\Documentation"
@@ -682,6 +694,9 @@ FunctionEnd
=20
 Section "Uninstall"
=20
+  ; Required to handle shortcuts properly on Vista/7
+  SetShellVarContext all
+
   ; Stop OpenVPN if currently running
=20
   DetailPrint "Service REMOVE"
--=20
1.6.3.3


