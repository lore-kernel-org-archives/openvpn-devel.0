From: Kevin Kane <kkane@...2393...>
Date: Wed, 25 Jul 2018 19:51:03 +0000
Message-ID: <20180725195040.27560-1-kkane@...2393...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] [openvpn-build] Install/uninstall dialer
 DLL as part of Windows installer operation
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Signed-off-by: Kevin Kane <kkane@...2393...>
---
 windows-nsis/openvpn.nsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/windows-nsis/openvpn.nsi b/windows-nsis/openvpn.nsi
index e92904d..aff7cb3 100755
--- a/windows-nsis/openvpn.nsi
+++ b/windows-nsis/openvpn.nsi
@@ -1,6 +1,7 @@
 ; ************************************************************************=
****
 ; * Copyright (C) 2002-2010 OpenVPN Technologies, Inc.                    =
   *
 ; * Copyright (C)      2012 Alon Bar-Lev <alon.barlev@...277...>          =
   *
+; * Portions Copyright (C) 2018 Microsoft Corporation                     =
   *
 ; *  This program is free software; you can redistribute it and/or modify =
   *
 ; *  it under the terms of the GNU General Public License version 2       =
   *
 ; *  as published by the Free Software Foundation.                        =
   *
@@ -443,8 +444,10 @@ Section /o "${PACKAGE_NAME} GUI" SecOpenVPNGUI
=20
 	${If} ${RunningX64}
 		File "${OPENVPN_ROOT_X86_64}\bin\openvpn-gui.exe"
+		File "${OPENVPN_ROOT_X86_64}\bin\libopenvpndialer-0.dll"
 	${Else}
 		File "${OPENVPN_ROOT_I686}\bin\openvpn-gui.exe"
+		File "${OPENVPN_ROOT_I686}\bin\libopenvpndialer-0.dll"
 	${EndIf}
=20
 	${If} ${SectionIsSelected} ${SecAddShortcutsWorkaround}
@@ -770,6 +773,7 @@ Section "Uninstall"
 	${EndIf}
=20
 	Delete "$INSTDIR\bin\openvpn-gui.exe"
+	Delete "$INSTDIR\bin\libopenvpndialer-0.dll"
 	Delete "$DESKTOP\${PACKAGE_NAME} GUI.lnk"
=20
 	Delete "$INSTDIR\bin\openvpn.exe"
--=20
2.17.1.windows.2


