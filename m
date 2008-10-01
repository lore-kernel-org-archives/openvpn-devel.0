Message-Id: <48E34A1F.7D5B.00BC.0@...1133...>
Date: Wed, 01 Oct 2008 09:59:59 +0200
From: "Svein Hansen" <Svein.Hansen@...1133...>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=__Part0128A7EF.0__="
Subject: [Openvpn-devel] Req: UAC in Vista and updated prebuilds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part0128A7EF.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi
 
Two requests:
 
1:  Prebuilt openvpn for RC12 (and upcoming releases)
I want to include my own configuration files in the installer.
Can someone upload to: https://secure.openvpn.net/devel/ when a new
release/bugfix is released?
Please...
 
2: Add support for UAC(if:enabled) in Vista: Set "RUNASADMIN" for the
GUI in the installer.
(When connecting to OpenVPN in Vista I need admin-rights to set
routes.)
I have included some code in the openvpn.nsi, but i don't know if this
is the best way to solve the problem. 
 
; tap-64bit:
 
  DetailPrint "We are running on a 64-bit system."
  SetRegView 64
  WriteRegStr HKLM "Software\Microsoft\Windows
NT\CurrentVersion\AppCompatFlags\Layers"
"$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADMIN"
  SetRegView 32
 
  SetOutPath "$INSTDIR\bin"
 
  File "${GEN}\tapinstall\amd64\tapinstall.exe"
 
  SetOutPath "$INSTDIR\driver"
 
  File "${GEN}\driver\amd64\OemWin2k.inf"
  File "${GEN}\driver\amd64\${PRODUCT_TAP_ID}.cat"
  File "${GEN}\driver\amd64\${TAPDRV}"
 
goto tapend
 
tap-32bit:
 
  DetailPrint "We are running on a 32-bit system."
  WriteRegStr HKLM "Software\Microsoft\Windows
NT\CurrentVersion\AppCompatFlags\Layers"
"$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADMIN"
 
  SetOutPath "$INSTDIR\bin"
  File "${GEN}\tapinstall\i386\tapinstall.exe"
 
  SetOutPath "$INSTDIR\driver"
  File "${GEN}\driver\i386\OemWin2k.inf"
  File "${GEN}\driver\i386\${PRODUCT_TAP_ID}.cat"
  File "${GEN}\driver\i386\${TAPDRV}"
 
  tapend:
 
This works on both 32- and 64-bit Vista
(I can't see that this would cause problems for XP)
So my question is: 
Can this be included in the source?
 
Svein Hansen

--=__Part0128A7EF.0__=
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<META content=3D"MSHTML 6.00.6001.18099" name=3DGENERATOR></HEAD>
<BODY style=3D"MARGIN: 4px 4px 1px; FONT: 10pt Segoe UI">
<DIV>Hi</DIV>
<DIV>&nbsp;</DIV>
<DIV>Two requests:</DIV>
<DIV>&nbsp;</DIV>
<DIV>1:&nbsp; Prebuilt openvpn for RC12 (and upcoming releases)</DIV>
<DIV>I want to include my own configuration files in the installer.</DIV>
<DIV>Can someone upload to: <A href=3D"https://secure.openvpn.net/devel/">h=
ttps://secure.openvpn.net/devel/</A>&nbsp;when a new release/bugfix is rele=
ased?</DIV>
<DIV>Please...</DIV>
<DIV>&nbsp;</DIV>
<DIV>2: Add support for UAC(if:enabled)&nbsp;in Vista: Set "RUNASADMIN" for=
 the&nbsp;GUI in the installer.</DIV>
<DIV>(When connecting to OpenVPN in Vista I need admin-rights to set routes=
.)</DIV>
<DIV>I have&nbsp;included some code in the openvpn.nsi, but i don't know if=
 this is&nbsp;the best way to&nbsp;solve the problem.&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>; tap-64bit:</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; DetailPrint "We are running on a 64-bit system."<BR>&nbsp; SetR=
egView 64<BR>&nbsp; WriteRegStr HKLM "Software\Microsoft\Windows NT\Current=
Version\AppCompatFlags\Layers" "$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASA=
DMIN"<BR>&nbsp; SetRegView 32</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; SetOutPath "$INSTDIR\bin"</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; File "${GEN}\tapinstall\amd64\tapinstall.exe"</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; SetOutPath "$INSTDIR\driver"</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; File "${GEN}\driver\amd64\OemWin2k.inf"<BR>&nbsp; File "${GEN}\=
driver\amd64\${PRODUCT_TAP_ID}.cat"<BR>&nbsp; File "${GEN}\driver\amd64\${T=
APDRV}"</DIV>
<DIV>&nbsp;</DIV>
<DIV>goto tapend</DIV>
<DIV>&nbsp;</DIV>
<DIV>tap-32bit:</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; DetailPrint "We are running on a 32-bit system."<BR>&nbsp; Writ=
eRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\L=
ayers" "$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADMIN"</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; SetOutPath "$INSTDIR\bin"<BR>&nbsp; File "${GEN}\tapinstall\i38=
6\tapinstall.exe"</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; SetOutPath "$INSTDIR\driver"<BR>&nbsp; File "${GEN}\driver\i386=
\OemWin2k.inf"<BR>&nbsp; File "${GEN}\driver\i386\${PRODUCT_TAP_ID}.cat"<BR=
>&nbsp; File "${GEN}\driver\i386\${TAPDRV}"</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; tapend:</DIV>
<DIV>&nbsp;</DIV>
<DIV>This works on both 32- and 64-bit Vista</DIV>
<DIV>(I can't see that this would&nbsp;cause problems for XP)</DIV>
<DIV>So my question is: </DIV>
<DIV>Can this be included in the source?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Svein Hansen</DIV></BODY></HTML>

--=__Part0128A7EF.0__=--

