From: "Richard Francis" <rfransix@...164...>
Date: Tue, 11 Oct 2011 22:39:57 -0500
Message-ID: <000001cc8890$9d6d35b0$d847a110$@net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01CC8866.B4972DB0"
Content-Language: en-us
Subject: [Openvpn-devel] VPN Connects but can't route to destinations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01CC8866.B4972DB0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

 

Hi,

 

I've configured an openvpn TAP-Win32 Adapter V9 with an ip address of
12.0.0.2, subnet mask of 255.0.0.0, DHCP of 12.0.0.0, and DNS of 10.0.0.222.

 

After I connect, I can only ping 10.0.0.222, nothing else on the 10.x.x.x
network.

 

And to get to .222, I had to, route add 10.0.0.0 MASK 255.0.0.0 12.0.0.2
METRIC 30 to get there.

 

What am I missing?

 

Thank you very much.

 

Richard

 


------=_NextPart_000_0001_01CC8866.B4972DB0
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
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
	{mso-style-type:export-only;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><o:p>&nbsp;</o:p=
></p><p class=3DMsoNormal>Hi,<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp=
;</o:p></p><p class=3DMsoNormal>I&#8217;ve configured an openvpn TAP-Win32 =
Adapter V9 with an ip address of 12.0.0.2, subnet mask of 255.0.0.0, DHCP o=
f 12.0.0.0, and DNS of 10.0.0.222.<o:p></o:p></p><p class=3DMsoNormal><o:p>=
&nbsp;</o:p></p><p class=3DMsoNormal>After I connect, I can only ping 10.0.=
0.222, nothing else on the 10.x.x.x network.<o:p></o:p></p><p class=3DMsoNo=
rmal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>And to get to .222, I had to=
, route add 10.0.0.0 MASK 255.0.0.0 12.0.0.2 METRIC 30 to get there.<o:p></=
o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>What=
 am I missing?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p c=
lass=3DMsoNormal>Thank you very much.<o:p></o:p></p><p class=3DMsoNormal><o=
:p>&nbsp;</o:p></p><p class=3DMsoNormal><span style=3D'color:#1F497D'>Richa=
rd</span><span style=3D'color:#1F497D'><o:p></o:p></span></p><p class=3DMso=
Normal><o:p>&nbsp;</o:p></p></div></body></html>=

------=_NextPart_000_0001_01CC8866.B4972DB0--


