From: Simon Rozman <simon@...2293...>
Date: Tue, 12 Jun 2018 11:06:43 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10895D42FF@...2294...>
References: <99D61A626FDA8A4B90A270669121BE10872BAB2E@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10872BAB2E@...2294...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_0020_01D4024E.35199280"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] TAP-Windows MSI packages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>, "openvpn-devel
 (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_0020_01D4024E.35199280
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0021_01D4024E.35199280"

------=_NextPart_001_0021_01D4024E.35199280
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

After testing the MSI updating (installing newer MSI package over the
previous one), I have found out that WiX driver installation custom action
uninstalls the previous driver in RemoveExistingProducts pass, which
effectively removes all existing TAP interfaces. Though it installs the new
driver later on, the damage has been done.

 

This means me going back to the drawing board inventing our own MSI custom
action to install the driver and hopefully update seamlessly.

 

Best regards,

Simon

 

From: Simon Rozman <simon@...2293...> 
Sent: Thursday, June 7, 2018 3:51 PM
To: openvpn-devel (openvpn-devel@lists.sourceforge.net)
<openvpn-devel@lists.sourceforge.net>
Subject: [Openvpn-devel] TAP-Windows MSI packages

 

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

 


------=_NextPart_001_0021_01D4024E.35199280
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.Code, li.Code, div.Code
	{mso-style-name:Code;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Courier New";
	mso-fareast-language:EN-US;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
	{mso-list-id:1289312920;
	mso-list-template-ids:-1478433924;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2
	{mso-list-id:1348412041;
	mso-list-template-ids:1040247304;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3
	{mso-list-id:1641306305;
	mso-list-template-ids:1778157260;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
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
=3Den-SI>Hi,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3Den-SI><=
o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3Den-SI>After te=
sting the MSI updating (installing newer MSI package over the previous one)=
, I have found out that WiX driver installation custom action uninstalls th=
e previous driver in RemoveExistingProducts pass, which effectively removes=
 all existing TAP interfaces. Though it installs the new driver later on, t=
he damage has been done.<o:p></o:p></span></p><p class=3DMsoNormal><span la=
ng=3Den-SI><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3Den=
-SI>This means me going back to the drawing board inventing our own MSI cus=
tom action to install the driver and hopefully update seamlessly.<o:p></o:p=
></span></p><p class=3DMsoNormal><span lang=3Den-SI><o:p>&nbsp;</o:p></span=
></p><p class=3DMsoNormal><span lang=3Den-SI>Best regards,<o:p></o:p></span=
></p><p class=3DMsoNormal><span lang=3Den-SI>Simon<o:p></o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><div style=3D'border:none;border-lef=
t:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'border:non=
e;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoN=
ormal><b><span lang=3DEN-US style=3D'mso-fareast-language:SL'>From:</span><=
/b><span lang=3DEN-US style=3D'mso-fareast-language:SL'> Simon Rozman &lt;s=
imon@...2293...&gt; <br><b>Sent:</b> Thursday, June 7, 2018 3:51 PM<br><b>T=
o:</b> openvpn-devel (openvpn-devel@lists.sourceforge.net) &lt;openvpn-deve=
l@lists.sourceforge.net&gt;<br><b>Subject:</b> [Openvpn-devel] TAP-Windows =
MSI packages<o:p></o:p></span></p></div></div><p class=3DMsoNormal><o:p>&nb=
sp;</o:p></p><p class=3DMsoNormal><span lang=3DEN-GB>Hi!<o:p></o:p></span><=
/p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p c=
lass=3DMsoNormal><span lang=3DEN-GB>Finally, I have some MSI material to sh=
are with community. My playground is at <a href=3D"https://github.com/rozma=
nsi/tap-windows6">https://github.com/rozmansi/tap-windows6</a>.<o:p></o:p><=
/span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span><=
/p><p class=3DMsoNormal><span lang=3DEN-GB>It proved a lot more work than I=
 estimated back in Karlsruhe. The core problem was driver install and TAP i=
nterface creation within the MSI package. Well actually, the core problem w=
as lack of my time.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3D=
EN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><=
o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>1. tapct=
l.exe<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nb=
sp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>Anyway, a tapct=
l.exe utility was developed (msi/src/tapctl). It is a command line utility =
to manage TAP interfaces. It is not a snap-in replacement for devcon/tapins=
tall &#8211; it is GPLv2 licenced and was designed from ground up especiall=
y for OpenVPN.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB=
><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>Main f=
eatures of tapctl.exe are:<o:p></o:p></span></p><ul style=3D'margin-top:0cm=
' type=3Ddisc><li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo3'><span=
 lang=3DEN-GB>Creation of (named) TAP interfaces &#8211; being able to set =
the name of the TAP interface to be created allows automation. The &quot;Lo=
cal Area Connection 2&quot;, &quot;Ethernet 2&quot; and random names like t=
hat just don't.<o:p></o:p></span></li><li class=3DMsoNormal style=3D'mso-li=
st:l0 level1 lfo3'><span lang=3DEN-GB>Removal of individual network interfa=
ces (by name or GUID)<o:p></o:p></span></li><li class=3DMsoNormal style=3D'=
mso-list:l0 level1 lfo3'><span lang=3DEN-GB>Network interface listing<o:p><=
/o:p></span></li><li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo3'><s=
pan lang=3DEN-GB>It does not install or update TAP driver. The TAP driver m=
ust be installed by other means. It only manipulates (TAP) network interfac=
es.<o:p></o:p></span></li></ul><p class=3DMsoNormal><span lang=3DEN-GB><o:p=
>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>The network=
 interface management source is located in separate tap.h/.c files suitable=
 to be reused in OpenVPN project itself (imagine --mktun on Windows). That'=
s why I chose C language in the end &#8211; though I would prefer C++. I re=
member David had an idea at our lunch discussion to be nice to be able to r=
euse the code in OpenVPN.<o:p></o:p></span></p><p class=3DMsoNormal><span l=
ang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DE=
N-GB>For the time being, there is no &quot;remove all TAP interfaces&quot; =
function. If people will miss it, I can add it.<o:p></o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal=
><span lang=3DEN-GB>2. Driver installation<o:p></o:p></span></p><p class=3D=
MsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNorm=
al><span lang=3DEN-GB>The TAP driver installation/upgrade is handled by WiX=
. WiX already provides MSI custom actions for this task and that functional=
ity was reused. Since the driver will need to be build on Windows anyway, I=
'll leave TAP-Windows6 MSI packaging to WiX. Note that OpenVPN itself will =
have quite simple setup in comparison and should allow us to use msitools f=
or packaging.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>=
<o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>The MSI=
 package also installs OpenVPN Inc.'s certificate before installing the dri=
ver. This avoids the trust prompt on driver install and is important when i=
nstalling MSI package using GPO or some other unattended mean deployment.<o=
:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:=
p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></spa=
n></p><p class=3DMsoNormal><span lang=3DEN-GB>3. Initial TAP interface inst=
allation<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>=
&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>Rather than =
using tapctl.exe to create the initial TAP interface on first install, an M=
SI custom action DLL was developed (msi/src/tapca). It features:<o:p></o:p>=
</span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span>=
</p><ul style=3D'margin-top:0cm' type=3Ddisc><li class=3DMsoNormal style=3D=
'mso-list:l0 level1 lfo3'><span lang=3DEN-GB>Existing TAP interface enumera=
tion on initialization<o:p></o:p></span></li><li class=3DMsoNormal style=3D=
'mso-list:l0 level1 lfo3'><span lang=3DEN-GB>A custom MSI table is used to =
list the TAP interfaces to create on install and delete on uninstall. This =
allows IT admins to author MSI with own set of TAP interfaces to install.<o=
:p></o:p></span></li><li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo3=
'><span lang=3DEN-GB>A complete set of execute/rollback/commit functionalit=
y is implemented, allowing complete rollback on install failure.<o:p></o:p>=
</span></li></ul><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p><=
/span></p><p class=3DMsoNormal><span lang=3DEN-GB>By default, the MSI packa=
ges are authored to install a single TAP interface named &quot;OpenVPN&quot=
; if there are no existing TAP interfaces on computer: fresh installs will =
create &quot;OpenVPN&quot; TAP interface, upgrades will leave TAP interface=
s intact.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p=
>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;=
</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>4. The MSI package=
s<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;<=
/o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>The MSI packages ar=
e built using WiX Toolset. They provide simple UI (no EULA nagging). They d=
etect the previous setup of TAP-Windows6 (including the NSIS one) and reuse=
 the installation folder. The NSIS leftover files and registry data is clea=
ned. As mention before, the MSI setup installs/updates TAP driver and insta=
ll &quot;OpenVPN&quot; TAP interface on first install. When any TAP interfa=
ce exists (even from NSIS installs) it will skip creation of &quot;OpenVPN&=
quot; interface.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-=
GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>Ther=
e is one MSI file for each platform. ARM and ARM64 platforms are ready but =
commented for the time being &#8211; waiting for ARM64 driver support (Jon =
Kunkee patch), WiX support for ARM64 platform, somebody actually having an =
ARM64 Windows 10 device to test etc.<o:p></o:p></span></p><p class=3DMsoNor=
mal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><sp=
an lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB>5. Building<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-G=
B>The building how-to is described in msi/README.rst. Meanwhile, I have pub=
lished binaries for testing at <a href=3D"https://github.com/rozmansi/tap-w=
indows6/releases/tag/9.21.2-1">https://github.com/rozmansi/tap-windows6/rel=
eases/tag/9.21.2-1</a>. Remember: this is TAP driver and TAP network interf=
ace installation MSI only.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3D=
EN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>6=
. TODO<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&n=
bsp;</o:p></span></p><ul style=3D'margin-top:0cm' type=3Ddisc><li class=3DM=
soNormal style=3D'mso-list:l0 level1 lfo3'><span lang=3DEN-GB>Thoroughly te=
st upgrading (use old TAP drivers to make MSI packages for past versions)<o=
:p></o:p></span></li><li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo3=
'><span lang=3DEN-GB>Prepare self-extracting EXE installer to contain all M=
SI packages and a bootstrapper to launch msiexec /i with the platform-speci=
fic MSI<o:p></o:p></span></li><li class=3DMsoNormal style=3D'mso-list:l0 le=
vel1 lfo3'><span lang=3DEN-GB>Integrate into tap-windows6 build process &#8=
211; discuss options to revise building process (Jon Kunkee proposals) <o:p=
></o:p></span></li><li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo3'>=
<span lang=3DEN-GB>Prepare MSI packages for OpenVPN<o:p></o:p></span></li><=
/ul><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-GB>Best regards,<o:p></o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-GB>Simon<o:p></o:p></span></p><p class=3DMsoNo=
rmal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p></div></div></body></ht=
ml>=

------=_NextPart_001_0021_01D4024E.35199280--

------=_NextPart_000_0020_01D4024E.35199280
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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

------=_NextPart_000_0020_01D4024E.35199280--

