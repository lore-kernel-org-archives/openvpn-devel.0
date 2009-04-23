Date: Thu, 23 Apr 2009 17:00:05 -0500
From: "Karl O. Pinc" <kop@...1206...>
Message-Id: <1240524005l.15511l.0l@...1207...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Ud7iVEARGTzmuM6r/goG"
Subject: [Openvpn-devel] Patches to improve interactions between OpenVPN GUI
 and the installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-Ud7iVEARGTzmuM6r/goG
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Attached are 2 patches to install-win32/openvpn.nsi
to improve how the win32 installer interactions with OpenVPN GUI.

I noticed that if OpenVPN GUI is running when
you run the (un)installer the GUI binary does
not get removed/replaced.  This is un-good.

openvpn.nsi.kill.patch fixes this problem
by killing any running OpenVPN GUIs and children
before the (un)installer does its work.

openvpn.nsi.startgui.patch extends the installer
so there is an option to start OpenVPN GUI
as the installer completes.  It is to be applied
on top of the first patch.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

--=-Ud7iVEARGTzmuM6r/goG
Content-Type: text/x-patch; charset=us-ascii; name=openvpn.nsi.killer.patch
Content-Disposition: attachment; filename=openvpn.nsi.killer.patch
Content-Transfer-Encoding: quoted-printable

--- openvpn.nsi	2009-04-11 16:25:34.000000000 -0500
+++ openvpn.nsi.killer	2009-04-23 13:28:16.000000000 -0500
@@ -273,6 +273,13 @@
   nsExec::ExecToLog '"$INSTDIR\bin\${PRODUCT_UNIX_NAME}serv.exe" -remove'
   Pop $R0 # return value/error/timeout
=20
+!ifdef USE_GUI
+  ; Stop OpenVPN GUI if currently running
+  DetailPrint "Stop running OpenVPN GUI (if exists) and child tasks"
+  nsExec::ExecToLog 'taskkill /F /FI "IMAGENAME eq openvpn-gui-*" /IM * /T=
'
+  Pop $R0 # return value/error/timeout
+!endif
+
 !ifdef USE_XGUI
   DetailPrint "Previous XML Service REMOVE (if exists)"
   nsExec::ExecToLog '"$INSTDIR\bin\${XGUI_XMLSERV}" -remove'
@@ -751,6 +758,13 @@
   nsExec::ExecToLog '"$INSTDIR\bin\${PRODUCT_UNIX_NAME}serv.exe" -remove'
   Pop $R0 # return value/error/timeout
=20
+!ifdef USE_GUI
+  ; Stop OpenVPN GUI if currently running
+  DetailPrint "Stop running OpenVPN GUI (if exists) and child tasks"
+  nsExec::ExecToLog 'taskkill /F /FI "IMAGENAME eq openvpn-gui-*" /IM * /T=
'
+  Pop $R0 # return value/error/timeout
+!endif
+
   Sleep 3000
=20
   DetailPrint "TAP REMOVE"


--=-Ud7iVEARGTzmuM6r/goG
Content-Type: text/x-patch; charset=us-ascii; name=openvpn.nsi.startgui.patch
Content-Disposition: attachment; filename=openvpn.nsi.startgui.patch
Content-Transfer-Encoding: quoted-printable

--- openvpn.nsi	2009-04-23 13:28:16.000000000 -0500
+++ openvpn.nsi.startgui	2009-04-23 16:08:00.000000000 -0500
@@ -66,6 +66,12 @@
 !define XGUI_AJAX_GUI_NAME       "${PRODUCT_NAME} Ajax GUI"
 !define XGUI_TRANSITION_GUI_NAME "${PRODUCT_NAME} Transitional GUI"
=20
+; Keep whether OpenVPN GUI should be run after install.
+!ifdef USE_GUI
+Var RunOpenVPNGUI
+Var InstOpenVPNGUI
+!endif
+
 ;--------------------------------
 ;Configuration
=20
@@ -132,6 +138,7 @@
=20
 !ifdef USE_GUI
   LangString DESC_SecOpenVPNGUI ${LANG_ENGLISH} "Install ${PRODUCT_NAME} G=
UI by Mathias Sundman"
+  LangString DESC_SecStartOpenVPNGUI ${LANG_ENGLISH} "Run ${PRODUCT_NAME} =
GUI when installation completes."
 !endif
=20
 !ifdef USE_XGUI
@@ -213,57 +220,9 @@
 ;--------------------------------
 ;Installer Sections
=20
-Function .onInit
-  ClearErrors
-
-# Verify that user has admin privs
-  UserInfo::GetName
-  IfErrors ok
-  Pop $R0
-  UserInfo::GetAccountType
-  Pop $R1
-  StrCmp $R1 "Admin" ok
-    Messagebox MB_OK "Administrator privileges required to install ${PRODU=
CT_NAME} [$R0/$R1]"
-    Abort
-  ok:
-
-# Delete previous start menu
-  RMDir /r $SMPROGRAMS\${PRODUCT_NAME}
-
-# Check windows version
-  Call GetWindowsVersion
-  Pop $1
-  StrCmp $1 "2000" goodwinver
-  StrCmp $1 "XP" goodwinver
-  StrCmp $1 "2003" goodwinver
-  StrCmp $1 "VISTA" goodwinver
-
-  Messagebox MB_OK "Sorry, ${PRODUCT_NAME} does not currently support Wind=
ows $1"
-  Abort
-
-goodwinver:
-  System::Call "kernel32::GetCurrentProcess() i .s"
-  System::Call "kernel32::IsWow64Process(i s, *i .r0)"
-  IntCmp $0 0 init32bits
-
-  ; we are running on 64-bit windows
-  StrCmp $1 "VISTA" vista64bummer
-
-#  Messagebox MB_OK "Sorry, ${PRODUCT_NAME} doesn't currently support 64-b=
it Windows."
-#  Abort
-
-vista64bummer:
-
-#  Messagebox MB_OK "Sorry, ${PRODUCT_NAME} doesn't currently support 64-b=
it Vista because Microsoft doesn't allow the installation of 64 bit unsigne=
d drivers."
-#  Abort
-
-init32bits:
-
-FunctionEnd
-
 !define SF_SELECTED 1
+!define SF_RO 16
=20
-;--------------------
 ;Pre-install section
=20
 Section -pre
@@ -308,6 +267,10 @@
   File "${BIN}\${OPENVPN_GUI}"
=20
 SectionEnd
+
+Section "Start ${PRODUCT_NAME} GUI now" SecStartOpenVPNGUI
+SectionEnd
+
 !endif
=20
 !ifdef USE_XGUI
@@ -702,6 +665,14 @@
   WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${=
PRODUCT_NAME}" "DisplayIcon" "$INSTDIR\${PRODUCT_ICON}"
   WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${=
PRODUCT_NAME}" "DisplayVersion" "${VERSION}"
=20
+  ; Run the OpenVPN GUI
+  SectionGetFlags ${SecStartOpenVPNGUI} $R0
+  IntOp $R0 $R0 & ${SF_SELECTED}
+  IntCmp $R0 ${SF_SELECTED} "" nostartovpngui nostartovpngui
+  DetailPrint "Run the OpenVPN GUI"
+  Exec '"$INSTDIR\bin\${OPENVPN_GUI}"'
+ nostartovpngui:
+
   ; Advise a reboot
   ;Messagebox MB_OK "IMPORTANT: Rebooting the system is advised in order t=
o finalize TAP driver installation/upgrade (this is an informational messag=
e only, pressing OK will not reboot)."
=20
@@ -714,6 +685,7 @@
   !insertmacro MUI_DESCRIPTION_TEXT ${SecOpenVPNUserSpace} $(DESC_SecOpenV=
PNUserSpace)
   !ifdef USE_GUI
     !insertmacro MUI_DESCRIPTION_TEXT ${SecOpenVPNGUI} $(DESC_SecOpenVPNGU=
I)
+    !insertmacro MUI_DESCRIPTION_TEXT ${SecStartOpenVPNGUI} $(DESC_SecStar=
tOpenVPNGUI)
   !endif
   !ifdef USE_XGUI
     !insertmacro MUI_DESCRIPTION_TEXT ${SecOpenVPNXGUI} $(DESC_SecOpenVPNX=
GUI)
@@ -878,3 +850,118 @@
   ;Messagebox MB_OK "IMPORTANT: If you intend on reinstalling ${PRODUCT_NA=
ME} after this uninstall, and you are running Win2K, you are strongly urged=
 to reboot before reinstalling (this is an informational message only, pres=
sing OK will not reboot)."
=20
 SectionEnd
+
+;--------------------
+; Functions
+
+Function .onInit
+  ClearErrors
+
+# Verify that user has admin privs
+  UserInfo::GetName
+  IfErrors ok
+  Pop $R0
+  UserInfo::GetAccountType
+  Pop $R1
+  StrCmp $R1 "Admin" ok
+    Messagebox MB_OK "Administrator privileges required to install ${PRODU=
CT_NAME} [$R0/$R1]"
+    Abort
+  ok:
+
+# Delete previous start menu
+  RMDir /r $SMPROGRAMS\${PRODUCT_NAME}
+
+!ifdef USE_GUI
+  Push $R0
+# Save whether OpenVPN GUI is installed
+  SectionGetFlags ${SecOpenVPNGUI} $R0
+  IntOp $InstOpenVPNGUI $R0 & ${SF_SELECTED}
+# Save whether OpenVPN GUI should be run
+  SectionGetFlags ${SecStartOpenVPNGUI} $R0
+  IntOp $RunOpenVPNGUI $R0 & ${SF_SELECTED}
+  Pop $R0
+!endif
+
+# Check windows version
+  Call GetWindowsVersion
+  Pop $1
+  StrCmp $1 "2000" goodwinver
+  StrCmp $1 "XP" goodwinver
+  StrCmp $1 "2003" goodwinver
+  StrCmp $1 "VISTA" goodwinver
+
+  Messagebox MB_OK "Sorry, ${PRODUCT_NAME} does not currently support Wind=
ows $1"
+  Abort
+
+goodwinver:
+  System::Call "kernel32::GetCurrentProcess() i .s"
+  System::Call "kernel32::IsWow64Process(i s, *i .r0)"
+  IntCmp $0 0 init32bits
+
+  ; we are running on 64-bit windows
+  StrCmp $1 "VISTA" vista64bummer
+
+#  Messagebox MB_OK "Sorry, ${PRODUCT_NAME} doesn't currently support 64-b=
it Windows."
+#  Abort
+
+vista64bummer:
+
+#  Messagebox MB_OK "Sorry, ${PRODUCT_NAME} doesn't currently support 64-b=
it Vista because Microsoft doesn't allow the installation of 64 bit unsigne=
d drivers."
+#  Abort
+
+init32bits:
+
+FunctionEnd
+
+!ifdef USE_GUI
+Function .onSelChange
+  # Save registers
+  Push $R0
+  Push $R1
+
+  # The OpenVPN GUI can't be started if it's not installed.
+
+  SectionGetFlags ${SecOpenVPNGUI} $R0
+  IntOp $R0 $R0 & ${SF_SELECTED}
+  IntCmp $R0 $InstOpenVPNGUI nochange "" ""
+  # The gui install state changed.
+  # Save state
+  Push $R0
+  Pop $InstOpenVPNGUI
+
+  SectionGetFlags ${SecStartOpenVPNGUI} $R0
+
+  IntCmp $InstOpenVPNGUI ${SF_SELECTED} "" disablestart disablestart
+  # OpenVPN GUI is to be installed.
+
+  # Make SecStartOpenVPNGUI writable
+  IntOp $R1 ${SF_RO} ~
+  IntOp $R0 $R1 & ${SF_RO}
+
+  # Restore state of SecStartOpenVPN GUI
+  IntOp $R1 ${SF_SELECTED} ~
+  IntOp $R0 $R0 & $R1
+  IntOp $R0 $R0 | $RunOpenVPNGUI
+
+  Goto disableend
+ disablestart:
+  # OpenVPN GUI is not to be installed.
+  # Save whether it should be started.
+  IntOp $RunOpenVPNGUI $R0 & ${SF_SELECTED}
+
+  # Don't start what we don't install.
+  IntOp $R1 ${SF_SELECTED} ~
+  IntOp $R0 $R0 & $R1
+
+  # Make the SecStartOpenVPNGUI read-only
+  IntOp $R0 $R0 | ${SF_RO}
+ disableend:
+
+  SectionSetFlags ${SecStartOpenVPNGUI} $R0
+
+ nochange:
+  # Restore registers
+  Pop $R1
+  Pop $R0
+FunctionEnd
+!endif


--=-Ud7iVEARGTzmuM6r/goG--

