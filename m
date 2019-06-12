From: "Dan Haim" <negativeiq@...277...>
Date: Thu, 13 Jun 2019 00:21:48 +0300
Message-ID: <011b01d52164$d8d48430$8a7d8c90$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_011C_01D5217D.FE242D30"
Content-Language: he
Subject: [Openvpn-devel] Win-ARM64 POC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.

------=_NextPart_000_011C_01D5217D.FE242D30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

I've just managed to compile a Windows on ARM64 port of OpenVPN. If you
happen to have a Windows on ARM laptop (ARM64, not the old RT) I'd like to
hear from you and help test things out. I've uploaded it here for the time
being -

https://www79.zippyshare.com/v/e8nKxDm9/file.html

 

Obviously it's only partial, there's no installer and no GUI but otherwise
seems to work. If you have a decent VPN connection I'd appreciate if you
could run a speed test because hopefully running out of the x86 emulator
should increase performance and therefore bandwidth, problem is my current
router is a bit slow so it'd be the bottleneck anyway (so I currently have
no way of testing). It should also help conserve battery power.

With that being said I had to compile the OpenSSL libraries with no-asm so
it may impair performance a little bit (I used OpenSSL v1.0.2s, which
doesn't officially support the platform and required multiple makefile hacks
to compile, v1.1.x may be better).

 

Overall I needed to mess with a lot of compiler settings, mainly for OpenSSL
and also a bit for OpenVPN itself but didn't change any actual code. The
whole project took about ~5 hours.

 

I would like again to ask for feedback from other owners of such laptops,
especially how this build compares to the x86 version in terms of speed and
battery usage. Also I'd like to inquire what would it take to wrap it in a
decent installer and whether an eventual official release can be considered.

 

 

Sorry for the long message

Cheers,

Dan.


------=_NextPart_000_011C_01D5217D.FE242D30
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
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
	text-align:right;
	direction:rtl;
	unicode-bidi:embed;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal style=3D'text-al=
ign:left;direction:ltr;unicode-bidi:embed'>Hello,<o:p></o:p></p><p class=3D=
MsoNormal style=3D'text-align:left;direction:ltr;unicode-bidi:embed'>I've j=
ust managed to compile a Windows on ARM64 port of OpenVPN. If you happen to=
 have a Windows on ARM laptop (ARM64, not the old RT) I'd like to hear from=
 you and help test things out. I've uploaded it here for the time being &#8=
211;<o:p></o:p></p><p class=3DMsoNormal style=3D'text-align:left;direction:=
ltr;unicode-bidi:embed'><a href=3D"https://www79.zippyshare.com/v/e8nKxDm9/=
file.html" target=3D"_blank">https://www79.zippyshare.com/v/e8nKxDm9/file.h=
tml</a><o:p></o:p></p><p class=3DMsoNormal style=3D'text-align:left;directi=
on:ltr;unicode-bidi:embed'><o:p>&nbsp;</o:p></p><p class=3DMsoNormal style=
=3D'text-align:left;direction:ltr;unicode-bidi:embed'>Obviously it's only p=
artial, there's no installer and no GUI but otherwise seems to work. If you=
 have a decent VPN connection I'd appreciate if you could run a speed test =
because hopefully running out of the x86 emulator should increase performan=
ce and therefore bandwidth, problem is my current router is a bit slow so i=
t'd be the bottleneck anyway (so I currently have no way of testing). It sh=
ould also help conserve battery power.<o:p></o:p></p><p class=3DMsoNormal s=
tyle=3D'text-align:left;direction:ltr;unicode-bidi:embed'>With that being s=
aid I had to compile the OpenSSL libraries with no-asm so it may impair per=
formance a little bit (I used OpenSSL v1.0.2s, which doesn't officially sup=
port the platform and required multiple makefile hacks to compile, v1.1.x m=
ay be better).<o:p></o:p></p><p class=3DMsoNormal style=3D'text-align:left;=
direction:ltr;unicode-bidi:embed'><o:p>&nbsp;</o:p></p><p class=3DMsoNormal=
 style=3D'text-align:left;direction:ltr;unicode-bidi:embed'>Overall I neede=
d to mess with a lot of compiler settings, mainly for OpenSSL and also a bi=
t for OpenVPN itself but didn't change any actual code. The whole project t=
ook about ~5 hours.<o:p></o:p></p><p class=3DMsoNormal style=3D'text-align:=
left;direction:ltr;unicode-bidi:embed'><o:p>&nbsp;</o:p></p><p class=3DMsoN=
ormal style=3D'text-align:left;direction:ltr;unicode-bidi:embed'>I would li=
ke again to ask for feedback from other owners of such laptops, especially =
how this build compares to the x86 version in terms of speed and battery us=
age. Also I'd like to inquire what would it take to wrap it in a decent ins=
taller and whether an eventual official release can be considered.<o:p></o:=
p></p><p class=3DMsoNormal style=3D'text-align:left;direction:ltr;unicode-b=
idi:embed'><o:p>&nbsp;</o:p></p><p class=3DMsoNormal style=3D'text-align:le=
ft;direction:ltr;unicode-bidi:embed'><o:p>&nbsp;</o:p></p><p class=3DMsoNor=
mal style=3D'text-align:left;direction:ltr;unicode-bidi:embed'>Sorry for th=
e long message<o:p></o:p></p><p class=3DMsoNormal style=3D'text-align:left;=
direction:ltr;unicode-bidi:embed'>Cheers,<o:p></o:p></p><p class=3DMsoNorma=
l style=3D'text-align:left;direction:ltr;unicode-bidi:embed'>Dan.<span lang=
=3DHE dir=3DRTL style=3D'font-family:"Arial","sans-serif"'><o:p></o:p></spa=
n></p></div></body></html>=

------=_NextPart_000_011C_01D5217D.FE242D30--


