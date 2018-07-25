From: Kevin Kane <kkane@...2393...>
Date: Wed, 25 Jul 2018 17:01:38 +0000
Message-ID: <BL0PR2101MB105861B81A70F8D2827526E4AB540@...2440...>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB105861B81A70F8D2827526E4AB540BL0PR2101MB1058_"
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] [openvpn-build] Install/uninstall dialer
 DLL as part of Windows installer operation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--_000_BL0PR2101MB105861B81A70F8D2827526E4AB540BL0PR2101MB1058_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From 30e851ffafcc9ad76928d796f9b18144c8d79040 Mon Sep 17 00:00:00 2001
From: Kevin Kane <kkane@...2393...>
Date: Fri, 13 Jul 2018 09:47:43 -0700
Subject: Install/uninstall dialer DLL as part of Windows installer operation

Signed-off-by: Kevin Kane <kkane@...2393...>
---
windows-nsis/openvpn.nsi | 4 ++++
1 file changed, 4 insertions(+)

diff --git a/windows-nsis/openvpn.nsi b/windows-nsis/openvpn.nsi
index e92904d..aff7cb3 100755
--- a/windows-nsis/openvpn.nsi
+++ b/windows-nsis/openvpn.nsi
@@ -1,6 +1,7 @@
; *************************************************************************=
***
; * Copyright (C) 2002-2010 OpenVPN Technologies, Inc.                     =
  *
; * Copyright (C)      2012 Alon Bar-Lev <alon.barlev@...277...>           =
  *
+; * Portions Copyright (C) 2018 Microsoft Corporation                     =
   *
; *  This program is free software; you can redistribute it and/or modify  =
  *
; *  it under the terms of the GNU General Public License version 2        =
  *
; *  as published by the Free Software Foundation.                         =
  *
@@ -443,8 +444,10 @@ Section /o "${PACKAGE_NAME} GUI" SecOpenVPNGUI

               ${If} ${RunningX64}
                                File "${OPENVPN_ROOT_X86_64}\bin\openvpn-gu=
i.exe"
+                             File "${OPENVPN_ROOT_X86_64}\bin\libopenvpndi=
aler-0.dll"
                ${Else}
                                File "${OPENVPN_ROOT_I686}\bin\openvpn-gui.=
exe"
+                             File "${OPENVPN_ROOT_I686}\bin\libopenvpndial=
er-0.dll"
                ${EndIf}

               ${If} ${SectionIsSelected} ${SecAddShortcutsWorkaround}
@@ -770,6 +773,7 @@ Section "Uninstall"
                ${EndIf}

               Delete "$INSTDIR\bin\openvpn-gui.exe"
+             Delete "$INSTDIR\bin\libopenvpndialer-0.dll"
                Delete "$DESKTOP\${PACKAGE_NAME} GUI.lnk"

               Delete "$INSTDIR\bin\openvpn.exe"
--
2.17.1.windows.2


--_000_BL0PR2101MB105861B81A70F8D2827526E4AB540BL0PR2101MB1058_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">From 30e851ffafcc9ad76928d796f9b18144c8d79040 Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: Kevin Kane &lt;kkane@...2393...&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">Date: Fri, 13 Jul 2018 09:47:43 -0700<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: Install/uninstall dialer DLL as part of Win=
dows installer operation<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Kevin Kane &lt;kkane@...2393...&gt;<o=
:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">windows-nsis/openvpn.nsi | 4 &#43;&#43;&#43;&#43;<o:=
p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 4 insertions(&#43;)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/windows-nsis/openvpn.nsi b/windows-nsis=
/openvpn.nsi<o:p></o:p></p>
<p class=3D"MsoNormal">index e92904d..aff7cb3 100755<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/windows-nsis/openvpn.nsi<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/windows-nsis/openvpn.nsi<o:p></o:p=
></p>
<p class=3D"MsoNormal">@@ -1,6 &#43;1,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">; **************************************************=
**************************<o:p></o:p></p>
<p class=3D"MsoNormal">; * Copyright (C) 2002-2010 OpenVPN Technologies, In=
c.&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<o:p></o:p></p>
<p class=3D"MsoNormal">; * Copyright (C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2012=
 Alon Bar-Lev &lt;alon.barlev@...277...&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;; * Portions Copyright (C) 2018 Microsoft Corpo=
ration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<o:p=
></o:p></p>
<p class=3D"MsoNormal">; *&nbsp; This program is free software; you can red=
istribute it and/or modify&nbsp;&nbsp;&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">; *&nbsp; it under the terms of the GNU General Publ=
ic License version 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*<o:p></o:p></p>
<p class=3D"MsoNormal">; *&nbsp; as published by the Free Software Foundati=
on.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -443,8 &#43;444,10 @@ Section /o &quot;${PACKAGE_=
NAME} GUI&quot; SecOpenVPNGUI<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${If} ${RunningX64}<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; File &quot;${OP=
ENVPN_ROOT_X86_64}\bin\openvpn-gui.exe&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; File &quot;${OPENVPN_ROOT_X8=
6_64}\bin\libopenvpndialer-0.dll&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${Else}<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; File &quot;${OP=
ENVPN_ROOT_I686}\bin\openvpn-gui.exe&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; File &quot;${OPENVPN_ROOT_I6=
86}\bin\libopenvpndialer-0.dll&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${EndIf}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${If} ${SectionIsSelected} ${SecAddShortcu=
tsWorkaround}<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -770,6 &#43;773,7 @@ Section &quot;Uninstall&quot=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${EndIf}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Delete &quot;$INSTDIR\bin\openvpn-gui.exe&=
quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Delete &quot;$INSTDIR\bin\libopenvpndialer-0.dll&=
quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Delete &quot;$DESKTOP\${PACKAGE_NAME=
} GUI.lnk&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Delete &quot;$INSTDIR\bin\openvpn.exe&quot=
;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1.windows.2<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BL0PR2101MB105861B81A70F8D2827526E4AB540BL0PR2101MB1058_--

