Message-ID: <50F02B4E.3000200@...515...>
Date: Fri, 11 Jan 2013 17:10:06 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060908020400080402050401"
Subject: [Openvpn-devel] Fix to Trac ticket #249 (openvpn-build subproject)
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
--------------060908020400080402050401
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi all,

I took a stab at fixing Trac ticket #249:

<https://community.openvpn.net/openvpn/ticket/249>

The fix does not seem to cause any regressions if using the interactive
installation method. Silent installation has not been tested yet. Links
to new installers are here (build 002):

<https://community.openvpn.net/openvpn/ticket/249#comment:2>

Please test the installers and/or comment on the patch. It was aped from
the suggestion given by the bug reporter which seemed to make sense.

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------060908020400080402050401
Content-Type: text/x-patch;
 name="0002-Fix-to-Trac-ticket-249.patch"
Content-Disposition: attachment; filename="0002-Fix-to-Trac-ticket-249.patch"
Content-Transfer-Encoding: quoted-printable

From 209acaca040b14917b40ffd5314cde79efe8dd7c Mon Sep 17 00:00:00 2001
From: Samuli Sepp=C3=A4nen <samuli@...515...>
Date: Fri, 11 Jan 2013 15:00:24 +0200
Subject: [PATCH 2/3] Fix to Trac ticket #249

---
 windows-nsis/openvpn.nsi |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/windows-nsis/openvpn.nsi b/windows-nsis/openvpn.nsi
index afc382f..13543f6 100755
--- a/windows-nsis/openvpn.nsi
+++ b/windows-nsis/openvpn.nsi
@@ -35,6 +35,9 @@ ShowUninstDetails show
 ;Remember install folder
 InstallDirRegKey HKLM "SOFTWARE\${PACKAGE_NAME}" ""
=20
+; This is required for silent installations to work
+InstallDir "$PROGRAMFILES\${PACKAGE_NAME}"
+
 ;--------------------------------
 ;Modern UI Configuration
=20
@@ -384,13 +387,12 @@ Function .onInit
=20
 	!insertmacro MULTIUSER_INIT
 	SetShellVarContext all
-
-	${If} "${ARCH}" =3D=3D "x86_64"
-		SetRegView 64
-		StrCpy $INSTDIR "$PROGRAMFILES64\${PACKAGE_NAME}"
-	${Else}
-		StrCpy $INSTDIR "$PROGRAMFILES\${PACKAGE_NAME}"
-	${EndIf}
+   =20
+    ${If} "${ARCH}" =3D=3D "x86_64"
+        SetRegView 64
+        StrCmp $INSTDIR "$PROGRAMFILES\${PACKAGE_NAME}" 0 +2
+        StrCpy $INSTDIR "$PROGRAMFILES64\${PACKAGE_NAME}"
+    ${EndIf}
=20
 	# Delete previous start menu
 	RMDir /r "$SMPROGRAMS\${PACKAGE_NAME}"
--=20
1.7.9.5


--------------060908020400080402050401--

