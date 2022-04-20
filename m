Sender: yuanx3@...2645...
From: "yuanxun" <yuanx3@...2645...>
Date: Wed, 20 Apr 2022 16:18:55 +0800
Message-ID: <000001d8548f$4891c980$d9b55c80$@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0001_01D854D2.56B75370"
Content-Language: zh-cn
Subject: [Openvpn-devel]  :openvpn dco connection problem
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

------=_NextPart_000_0001_01D854D2.56B75370
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

I recently encountered a bug when using the openvpn dco branch. When the
client connection reaches max_cliants, I reconnect one of the clients, and
the client will fail to reconnect when it reaches the set number of
reconnections. At this time, the client state is Not connected, but on the
management interface, always online.

 

 


------=_NextPart_000_0001_01D854D2.56B75370
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:DengXian;}
/* Page Definitions */
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
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN link=3D"#0563C1=
" vlink=3D"#954F72" style=3D'word-wrap:break-word;text-justify-trim:punctua=
tion'><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US>Hi<=
o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>I recently enc=
ountered a bug when using the openvpn dco branch. When the client connectio=
n reaches max_cliants, I reconnect one of the clients, and the client will =
fail to reconnect when it reaches the set number of reconnections. At this =
time, the client state is Not connected, but on the management interface, a=
lways online.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>=
<o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&n=
bsp;</o:p></span></p></div></body></html>=

------=_NextPart_000_0001_01D854D2.56B75370--


