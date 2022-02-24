Sender: yuanx3@...2645...
From: "yuanxun" <yuanx3@...2645...>
Date: Thu, 24 Feb 2022 16:57:33 +0800
Message-ID: <000901d8295c$91ac0710$b5041530$@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_000A_01D8299F.9FD3DAF0"
Content-Language: zh-cn
Subject: [Openvpn-devel]  openvpn user concurrency
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

------=_NextPart_000_000A_01D8299F.9FD3DAF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello!

Considering a metric when using openvpn, what is the user concurrency limit
for a single service process?

Is the concurrency limited by the number of max-clients, or is there a
limit?

 

I haven't figured out how to test it, has anyone done this test?


------=_NextPart_000_000A_01D8299F.9FD3DAF0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:\7B49\7EBF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Microsoft YaHei UI";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@\7B49\7EBF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@Microsoft YaHei UI";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:\7B49\7EBF;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:\7B49\7EBF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:\7B49\7EBF;}
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
tion'><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US>Hel=
lo!<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'f=
ont-family:"Microsoft YaHei UI",sans-serif;color:black'>Considering a metri=
c when using openvpn, what is the user concurrency limit for a single servi=
ce process?<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US st=
yle=3D'font-family:"Microsoft YaHei UI",sans-serif;color:black'>Is the conc=
urrency limited by the number of max-clients, or is there a limit?<o:p></o:=
p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"=
Microsoft YaHei UI",sans-serif;color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"Microsoft YaHei =
UI",sans-serif;color:black'>I haven't figured out how to test it, has anyon=
e done this test?</span><span lang=3DEN-US><o:p></o:p></span></p></div></bo=
dy></html>=

------=_NextPart_000_000A_01D8299F.9FD3DAF0--


