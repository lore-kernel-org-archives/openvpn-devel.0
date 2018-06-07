From: Simon Rozman <simon@...2293...>
Date: Thu, 7 Jun 2018 13:50:41 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10872BAB2E@...2294...>
Content-Language: en-US
Content-Type: multipart/signed; micalg=2.16.840.1.101.3.4.2.1;
 protocol="application/x-pkcs7-signature";
 boundary="----=_NextPart_000_005C_01D3FE77.48FCB280"
MIME-Version: 1.0
Subject: [Openvpn-devel] TAP-Windows MSI packages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_005C_01D3FE77.48FCB280
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_005D_01D3FE77.48FCB280"

------=_NextPart_001_005D_01D3FE77.48FCB280
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi!

 

Finally, I have some MSI material to share with community. My playground is
at https://github.com/rozmansi/tap-windows6.

 

It proved a lot more work than I estimated back in Karlsruhe. The core
problem was driver install and TAP interface creation within the MSI
package. Well actually, the core problem was lack of my time.

 

 

1. tapctl.exe

 

Anyway, a tapctl.exe utility was developed (msi/src/tapctl). It is a command
line utility to manage TAP interfaces. It is not a snap-in replacement for
devcon/tapinstall - it is GPLv2 licenced and was designed from ground up
especially for OpenVPN.

 

Main features of tapctl.exe are:

*	Creation of (named) TAP interfaces - being able to set the name of
the TAP interface to be created allows automation. The "Local Area
Connection 2", "Ethernet 2" and random names like that just don't.
*	Removal of individual network interfaces (by name or GUID)
*	Network interface listing
*	It does not install or update TAP driver. The TAP driver must be
installed by other means. It only manipulates (TAP) network interfaces.

 

The network interface management source is located in separate tap.h/.c
files suitable to be reused in OpenVPN project itself (imagine --mktun on
Windows). That's why I chose C language in the end - though I would prefer
C++. I remember David had an idea at our lunch discussion to be nice to be
able to reuse the code in OpenVPN.

 

For the time being, there is no "remove all TAP interfaces" function. If
people will miss it, I can add it.

 

 

2. Driver installation

 

The TAP driver installation/upgrade is handled by WiX. WiX already provides
MSI custom actions for this task and that functionality was reused. Since
the driver will need to be build on Windows anyway, I'll leave TAP-Windows6
MSI packaging to WiX. Note that OpenVPN itself will have quite simple setup
in comparison and should allow us to use msitools for packaging.

 

The MSI package also installs OpenVPN Inc.'s certificate before installing
the driver. This avoids the trust prompt on driver install and is important
when installing MSI package using GPO or some other unattended mean
deployment.

 

 

3. Initial TAP interface installation

 

Rather than using tapctl.exe to create the initial TAP interface on first
install, an MSI custom action DLL was developed (msi/src/tapca). It
features:

 

*	Existing TAP interface enumeration on initialization
*	A custom MSI table is used to list the TAP interfaces to create on
install and delete on uninstall. This allows IT admins to author MSI with
own set of TAP interfaces to install.
*	A complete set of execute/rollback/commit functionality is
implemented, allowing complete rollback on install failure.

 

By default, the MSI packages are authored to install a single TAP interface
named "OpenVPN" if there are no existing TAP interfaces on computer: fresh
installs will create "OpenVPN" TAP interface, upgrades will leave TAP
interfaces intact.

 

 

4. The MSI packages

 

The MSI packages are built using WiX Toolset. They provide simple UI (no
EULA nagging). They detect the previous setup of TAP-Windows6 (including the
NSIS one) and reuse the installation folder. The NSIS leftover files and
registry data is cleaned. As mention before, the MSI setup installs/updates
TAP driver and install "OpenVPN" TAP interface on first install. When any
TAP interface exists (even from NSIS installs) it will skip creation of
"OpenVPN" interface.

 

There is one MSI file for each platform. ARM and ARM64 platforms are ready
but commented for the time being - waiting for ARM64 driver support (Jon
Kunkee patch), WiX support for ARM64 platform, somebody actually having an
ARM64 Windows 10 device to test etc.

 

 

5. Building

 

The building how-to is described in msi/README.rst. Meanwhile, I have
published binaries for testing at
https://github.com/rozmansi/tap-windows6/releases/tag/9.21.2-1. Remember:
this is TAP driver and TAP network interface installation MSI only.

 

 

6. TODO

 

*	Thoroughly test upgrading (use old TAP drivers to make MSI packages
for past versions)
*	Prepare self-extracting EXE installer to contain all MSI packages
and a bootstrapper to launch msiexec /i with the platform-specific MSI
*	Integrate into tap-windows6 build process - discuss options to
revise building process (Jon Kunkee proposals) 
*	Prepare MSI packages for OpenVPN

 

 

Best regards,

Simon

 


------=_NextPart_001_005D_01D3FE77.48FCB280
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
p.Code, li.Code, div.Code
	{mso-style-name:Code;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Courier New";
	mso-fareast-language:EN-US;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:199706724;
	mso-list-type:hybrid;
	mso-list-template-ids:-1195222022 1432012382 69468163 69468165 69468161 69=
468163 69468165 69468161 69468163 69468165;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1567299448;
	mso-list-type:hybrid;
	mso-list-template-ids:-224737100 69468175 69468185 69468187 69468175 69468=
185 69468187 69468175 69468185 69468187;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DSL link=3D"#0563C1" v=
link=3D"#954F72"><div class=3DWordSection1><p class=3DMsoNormal><span lang=
=3DEN-GB>Hi!<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><=
o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>Finally,=
 I have some MSI material to share with community. My playground is at <a h=
ref=3D"https://github.com/rozmansi/tap-windows6">https://github.com/rozmans=
i/tap-windows6</a>.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3D=
EN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>I=
t proved a lot more work than I estimated back in Karlsruhe. The core probl=
em was driver install and TAP interface creation within the MSI package. We=
ll actually, the core problem was lack of my time.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoN=
ormal><span lang=3DEN-GB>1. tapctl.exe<o:p></o:p></span></p><p class=3DMsoN=
ormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><=
span lang=3DEN-GB>Anyway, a tapctl.exe utility was developed (msi/src/tapct=
l). It is a command line utility to manage TAP interfaces. It is not a snap=
-in replacement for devcon/tapinstall &#8211; it is GPLv2 licenced and was =
designed from ground up especially for OpenVPN.<o:p></o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-GB>Main features of tapctl.exe are:<o:p></o:p></spa=
n></p><ul style=3D'margin-top:0cm' type=3Ddisc><li class=3DMsoListParagraph=
 style=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-GB>Creat=
ion of (named) TAP interfaces &#8211; being able to set the name of the TAP=
 interface to be created allows automation. The &quot;Local Area Connection=
 2&quot;, &quot;Ethernet 2&quot; and random names like that just don't.<o:p=
></o:p></span></li><li class=3DMsoListParagraph style=3D'margin-left:0cm;ms=
o-list:l0 level1 lfo1'><span lang=3DEN-GB>Removal of individual network int=
erfaces (by name or GUID)<o:p></o:p></span></li><li class=3DMsoListParagrap=
h style=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-GB>Netw=
ork interface listing<o:p></o:p></span></li><li class=3DMsoListParagraph st=
yle=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-GB>It does =
not install or update TAP driver. The TAP driver must be installed by other=
 means. It only manipulates (TAP) network interfaces.<o:p></o:p></span></li=
></ul><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-GB>The network interface management sou=
rce is located in separate tap.h/.c files suitable to be reused in OpenVPN =
project itself (imagine --mktun on Windows). That's why I chose C language =
in the end &#8211; though I would prefer C++. I remember David had an idea =
at our lunch discussion to be nice to be able to reuse the code in OpenVPN.=
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</=
o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>For the time being, =
there is no &quot;remove all TAP interfaces&quot; function. If people will =
miss it, I can add it.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-G=
B><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>2. Dr=
iver installation<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN=
-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>The=
 TAP driver installation/upgrade is handled by WiX. WiX already provides MS=
I custom actions for this task and that functionality was reused. Since the=
 driver will need to be build on Windows anyway, I'll leave TAP-Windows6 MS=
I packaging to WiX. Note that OpenVPN itself will have quite simple setup i=
n comparison and should allow us to use msitools for packaging.<o:p></o:p><=
/span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span><=
/p><p class=3DMsoNormal><span lang=3DEN-GB>The MSI package also installs Op=
enVPN Inc.'s certificate before installing the driver. This avoids the trus=
t prompt on driver install and is important when installing MSI package usi=
ng GPO or some other unattended mean deployment.<o:p></o:p></span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNorma=
l><span lang=3DEN-GB>3. Initial TAP interface installation<o:p></o:p></span=
></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-GB>Rather than using tapctl.exe to creat=
e the initial TAP interface on first install, an MSI custom action DLL was =
developed (msi/src/tapca). It features:<o:p></o:p></span></p><p class=3DMso=
Normal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><ul style=3D'margin-t=
op:0cm' type=3Ddisc><li class=3DMsoListParagraph style=3D'margin-left:0cm;m=
so-list:l0 level1 lfo1'><span lang=3DEN-GB>Existing TAP interface enumerati=
on on initialization<o:p></o:p></span></li><li class=3DMsoListParagraph sty=
le=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-GB>A custom =
MSI table is used to list the TAP interfaces to create on install and delet=
e on uninstall. This allows IT admins to author MSI with own set of TAP int=
erfaces to install.<o:p></o:p></span></li><li class=3DMsoListParagraph styl=
e=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-GB>A complete=
 set of execute/rollback/commit functionality is implemented, allowing comp=
lete rollback on install failure.<o:p></o:p></span></li></ul><p class=3DMso=
Normal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal>=
<span lang=3DEN-GB>By default, the MSI packages are authored to install a s=
ingle TAP interface named &quot;OpenVPN&quot; if there are no existing TAP =
interfaces on computer: fresh installs will create &quot;OpenVPN&quot; TAP =
interface, upgrades will leave TAP interfaces intact.<o:p></o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p clas=
s=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMso=
Normal><span lang=3DEN-GB>4. The MSI packages<o:p></o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoN=
ormal><span lang=3DEN-GB>The MSI packages are built using WiX Toolset. They=
 provide simple UI (no EULA nagging). They detect the previous setup of TAP=
-Windows6 (including the NSIS one) and reuse the installation folder. The N=
SIS leftover files and registry data is cleaned. As mention before, the MSI=
 setup installs/updates TAP driver and install &quot;OpenVPN&quot; TAP inte=
rface on first install. When any TAP interface exists (even from NSIS insta=
lls) it will skip creation of &quot;OpenVPN&quot; interface.<o:p></o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-GB>There is one MSI file for each plat=
form. ARM and ARM64 platforms are ready but commented for the time being &#=
8211; waiting for ARM64 driver support (Jon Kunkee patch), WiX support for =
ARM64 platform, somebody actually having an ARM64 Windows 10 device to test=
 etc.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nb=
sp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:=
p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>5. Building<o:p></o:p>=
</span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span>=
</p><p class=3DMsoNormal><span lang=3DEN-GB>The building how-to is describe=
d in msi/README.rst. Meanwhile, I have published binaries for testing at <a=
 href=3D"https://github.com/rozmansi/tap-windows6/releases/tag/9.21.2-1">ht=
tps://github.com/rozmansi/tap-windows6/releases/tag/9.21.2-1</a>. Remember:=
 this is TAP driver and TAP network interface installation MSI only.<o:p></=
o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></s=
pan></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p=
><p class=3DMsoNormal><span lang=3DEN-GB>6. TODO<o:p></o:p></span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><ul style=3D=
'margin-top:0cm' type=3Ddisc><li class=3DMsoListParagraph style=3D'margin-l=
eft:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-GB>Thoroughly test upgradi=
ng (use old TAP drivers to make MSI packages for past versions)<o:p></o:p><=
/span></li><li class=3DMsoListParagraph style=3D'margin-left:0cm;mso-list:l=
0 level1 lfo1'><span lang=3DEN-GB>Prepare self-extracting EXE installer to =
contain all MSI packages and a bootstrapper to launch msiexec /i with the p=
latform-specific MSI<o:p></o:p></span></li><li class=3DMsoListParagraph sty=
le=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-GB>Integrate=
 into tap-windows6 build process &#8211; discuss options to revise building=
 process (Jon Kunkee proposals) <o:p></o:p></span></li><li class=3DMsoListP=
aragraph style=3D'margin-left:0cm;mso-list:l0 level1 lfo1'><span lang=3DEN-=
GB>Prepare MSI packages for OpenVPN<o:p></o:p></span></li></ul><p class=3DM=
soNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNorma=
l><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-GB>Best regards,<o:p></o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-GB>Simon<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3D=
EN-GB><o:p>&nbsp;</o:p></span></p></div></body></html>=

------=_NextPart_001_005D_01D3FE77.48FCB280--

------=_NextPart_000_005C_01D3FE77.48FCB280
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AwMwJzAlBggrBgEFBQcCARYZaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3BzLzAIBgYEAIswAQIwGAYI
KwYBBQUHAQMEDDAKMAgGBgQAjkYBATAaBgNVHREEEzARgQ9zaW1vbkByb3ptYW4uc2kwge4GA1Ud
HwSB5jCB4zBWoFSgUqRQME4xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJzdGF0ZS1pbnN0aXR1dGlv
bnMxETAPBgNVBAsTCHNpZ2VuLWNhMQ8wDQYDVQQDEwZDUkw0NTUwgYiggYWggYKGV2xkYXA6Ly94
NTAwLmdvdi5zaS9vdT1zaWdlbi1jYSxvPXN0YXRlLWluc3RpdHV0aW9ucyxjPXNpP2NlcnRpZmlj
YXRlUmV2b2NhdGlvbkxpc3Q/YmFzZYYnaHR0cDovL3d3dy5zaWdlbi1jYS5zaS9jcmwvc2lnZW4t
Y2EuY3JsMCsGA1UdEAQkMCKADzIwMTYwMjE5MTc1NDQxWoEPMjAyMTAyMTkyMTM4MTVaMB8GA1Ud
IwQYMBaAFHF7igYfMQVVq2ASd0cgHgOIGOyJMB0GA1UdDgQWBBS7/7AHyQYI0e8GOPmwTc1ZTNw5
lzAJBgNVHRMEAjAAMBkGCSqGSIb2fQdBAAQMMAobBFY4LjEDAgOoMA0GCSqGSIb3DQEBBQUAA4IB
AQBBUL4KG1Z1oBIIdKIZs9yJxnJg/LfEPVvzNH8+CCqegq0D6k48Doo72oVEiskjqggdbUGj30uA
H8PjCD5kLGVoDwh5a2atQ3qQzaYA/lj2Js2f4fdXNn60vRp7XzbGsQdwYYecIrKzO5x6XVAIRb+T
HZNjXL3VX6vOozwBQv/+dx1P9H/rMUn7d8ci7v4PeqShbWbWwi6ez19cZvSKSkz/lWf4tj8QbA0n
WeUBlk3Bx6/TRda7kwXzcFExt+ROGt0YJjbZCN3kd7swcRvRT6gEi9L6n1XLghwPSYhzZjaL5fXv
I11JuSoQCy13XWBkq35Moo4iY19wanS1W6UM8Yq0MIIF5TCCBE2gAwIBAgINAKZovVEAAAAAVx3Q
6DANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJTSTEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3Zl
bmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAUBgNVBAMTDVNJLVRSVVNUIFJvb3QwHhcN
MTYwNTI0MTE1ODI3WhcNMjEwNjI3MjIwMDAwWjA9MQswCQYDVQQGEwJzaTEbMBkGA1UEChMSc3Rh
dGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALDlZbLArGSW8ogbs+2e5ALGTyuIzi6KUYB1rxBb8ss4ZpuiDm00R5alkhGv9jVH
onciDM4WiGKq00luGLwuRNi+xp7CGhmsQY78MAcC8sZq1FsjAO9BNNikc2PfIpIzhAGljfODXPq4
1Ho13+z4bQ/gTO2tnDp9htalCJS+fXoRH/6FP1RaiGOHnKWxp07Nt0Rzr8+KSWsf483XSU1aKxfm
XHazu3K5byfSm4kViN8QX3YhAWrHFTEK0ZxY+CgWBW3ZTtmh1wcgy0smiU2Ssqe6lujjWI8inAGW
WsT3MU0LSbXheGHiVBgGu55UNH4MPuvutYAf3RaEHWg4Zmdz+JECAwEAAaOCAkMwggI/MBIGA1Ud
EwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDoGA1UdIAQzMDEwLwYEVR0gADAnMCUGCCsG
AQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9jcHMvMGkGCCsGAQUFBwEBBF0wWzA2BggrBgEF
BQcwAoYqaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3J0L3NpLXRydXN0LXJvb3QuY3J0MCEGCCsGAQUF
BzABhhVodHRwOi8vb2NzcC5jYS5nb3Yuc2kwHQYDVR0OBBYEFHF7igYfMQVVq2ASd0cgHgOIGOyJ
MIIBPAYDVR0fBIIBMzCCAS8wgbeggbSggbGGKmh0dHA6Ly93d3cuY2EuZ292LnNpL2NybC9zaS10
cnVzdC1yb290LmNybIaBgmxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSS1UUlVTVCUyMFJvb3Qsb3Jn
YW5pemF0aW9uSWRlbnRpZmllcj1WQVRTSS0xNzY1OTk1NyxvPVJlcHVibGlrYSUyMFNsb3Zlbmlq
YSxjPVNJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Qwc6BxoG+kbTBrMQswCQYDVQQGEwJTSTEc
MBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAU
BgNVBAMTDVNJLVRSVVNUIFJvb3QxDTALBgNVBAMTBENSTDEwEwYDVR0jBAwwCoAITKPDaF4IAmMw
DQYJKoZIhvcNAQELBQADggGBAHuvNSPhY4qcirWJkTwkqaOPqOSV06J/ZepFQfUEJ87TlrGjp4XR
5FLktTAEY/7R4Sgeb2K8OWEl/Koc1BbH6+uyZYvfa+WnnJEWeWOmyPy/vooO7eZyOVvaORxurWOL
CCVDW2wBkbtUoKZaUyzgP+ZPPGRV8GFlbZLCzGmArMGXJXe8t/XNiJDLehGqSWT49NYjyYQdIgI+
qi9W+A6BSUQ9jsMdYJqKhXQcosfH51sc6gZVxTKMr3PsItsa8XFiNazECAAFr0ms7HB6zb8QvHRF
eBGk/CLrW4VkZEBN/JtuyhvgktQ2BvuGtauEvHZQAYpMSh35D7pwtavRMpmhaAsQb4yPqhIMcztw
RqsKPBhWoaFEVZ+Vn3wxap5h/oAhocifNzkWJTNWjxnoPM2eNz2uWFJsgsNhlwteUvnq7+bKTNte
SKWKr6pI+GUsZhmCh5URpUnqUanp0Uie0MD9f3tiOLOp711sNb0xwi+VdDuDB37IddOIsfhPBood
wpoFrTGCAyEwggMdAgEBMEUwPTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0
aW9uczERMA8GA1UECxMIc2lnZW4tY2ECBDtKDS4wDQYJYIZIAWUDBAIBBQCgggGtMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDYwNzEzNTA0MFowLwYJKoZIhvcN
AQkEMSIEIClJaN2bSKA2jtmZmRN/PJpuxiZCblpoFrevBZxqfeRpMFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAcGBSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBAJ0MUkuxQ2oWKO5AACQHlT8c
CWp11sq2hCUtGAQfZt1AH7qL2j/7FTj+qW/oMuwjcFaO6REJ1p1qwNAllVvM59M0Ln0lf8vdQW6T
v8SGkkUzxbbzcTIvifcVlEaDIhbpTRnfW1ZsRVJS4Fmtj5KGlSv0j3zkWcxNJ7T+wrMxE33yooia
ZNNlEqr6HyREA5Tg1vLnW27mpptc90ncN40Xjyer93bUGgFaziCdFieI8yOb9yYt2PNdYwIpHWEh
vm92zeoi0pAh411wZ/U4eOeoRSmbX/Lvto2jvMjaN5yUCRBJyr6Or3wU6xeaQkV/MjtHJuxwy6am
fcSnY6oUML+vaFIAAAAAAAA=

------=_NextPart_000_005C_01D3FE77.48FCB280--

