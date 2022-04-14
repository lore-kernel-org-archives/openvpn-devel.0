Sender: yuanx3@...2645...
From: "yuanxun" <yuanx3@...2645...>
Date: Thu, 14 Apr 2022 18:03:57 +0800
Message-ID: <000201d84fe6$fa5b7600$ef126200$@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0003_01D8502A.087EB600"
Content-Language: zh-cn
Subject: [Openvpn-devel] a problem with openvpn
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

------=_NextPart_000_0003_01D8502A.087EB600
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Recently found a problem with openvpn

 

environment:

Linux version 5.4.0-100-generic (buildd@...2671...) (gcc version 9.3.0
(Ubuntu 9.3.0-17ubuntu1~20.04))

OpenVPN 2.6_git [git:dco/a503c91735538f21] x86_64-pc-linux-gnu [SSL
(OpenSSL)] [LZO] [EPOLL] [MH/PKTINFO] [AEAD] [DCO]

 

When the Windows client is disconnected, the management interface "status"
is used on the server, and the connected client will not exit immediately.


------=_NextPart_000_0003_01D8502A.087EB600
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
tion'><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US>Rec=
ently found a problem with openvpn<o:p></o:p></span></p><p class=3DMsoNorma=
l><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-US>environment:<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Linux version 5.4.0-100-generic (buildd@...2671...) (gcc versi=
on 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04))<o:p></o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-US>OpenVPN 2.6_git [git:dco/a503c91735538f21] x86_6=
4-pc-linux-gnu [SSL (OpenSSL)] [LZO] [EPOLL] [MH/PKTINFO] [AEAD] [DCO]<o:p>=
</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p><=
/span></p><p class=3DMsoNormal><span lang=3DEN-US>When the Windows client i=
s disconnected, the management interface &#8220;status&#8221; is used on th=
e server, and the connected client will not exit immediately.<o:p></o:p></s=
pan></p></div></body></html>=

------=_NextPart_000_0003_01D8502A.087EB600--


