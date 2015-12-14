From: "Fish Wang" <fish.thss@...277...>
References: <CADCH5Ogh2ROBNti_hmBUBcQYBz4SuHJo_-cii14_E6aj9jmj-A@...278...>
	<1449794790-45430-1-git-send-email-fish.thss@...277...>
	<CAKuzo_ikg1My8wt2nbycosHvOwKhrRQPO18hjdgqDreCMDbeoQ@...278...>
	<014001d13605$2dec6ae0$89c540a0$@gmail.com>
	<CAKuzo_imF4mU8Qp9j_MtnKXS4VTP983htXyXQ9E_ZbOn7KsZaw@...278...>
In-Reply-To: <CAKuzo_imF4mU8Qp9j_MtnKXS4VTP983htXyXQ9E_ZbOn7KsZaw@...278...>
Date: Sun, 13 Dec 2015 17:20:43 -0800
Message-ID: <015d01d1360d$a7c93070$f75b9150$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_015E_01D135CA.99A665A0"
Content-Language: zh-cn
Subject: Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform
	agnostic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'Selva Nair' <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.

------=_NextPart_000_015E_01D135CA.99A665A0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

You are absolutely right, the code I grabbed is indeed from mingw-w64, not =
MinGW. Let me send out another patch with mingw-w64=E2=80=99s disclaimer so=
on. I=E2=80=99ll see what core people says about this patch.

=20

Thanks!

=20

Best,

Fish

=20

From: Selva Nair [mailto:selva.nair@...277...]=20
Sent: Sunday, December 13, 2015 5:09 PM
To: Fish Wang <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform =
agnostic

=20

Hi,

On Sun, Dec 13, 2015 at 7:20 PM, Fish Wang <fish.thss@...277... <mailto:fis=
h.thss@...277...> > wrote:

Will do. However, I=E2=80=99m by no means a license expert. Based on Licens=
ing Terms page on MinGW=E2=80=99s website ([1], win32api), I believe the co=
de I stripped out of MinGW should be fine as long as a copy of the notice a=
nd its license [2] is included. Please correct me if I=E2=80=99m wrong.


I thought those headers are from the mingw-w64 (a different code base
from mingw32)..=20

Anyway, I did not mean to imply any licensing issues with extracting=20
parts from mingw32 or mingw-w64 --- both have permissive licenses=20
so there is no clash. However, some GPL projects have clear guidelines=20
of how to incorporate code from other licenses.=20

Personally I prefer to keep public domain code (and minor edits to it)=20
in a  separate file which clearly indicates its in PD with the original=20
notice so that one wouldn't slap on a GPL header on it later. While=20
some projects want all their additions to be GPL keeping the original=20
in PD etc..(Fro example, see various practices disscussed in=20=20
https://www.softwarefreedom.org/resources/2007/gpl-non-gpl-collaboration.pd=
f).

Better wait for a core developer to comment on this..

Selva


------=_NextPart_000_015E_01D135CA.99A665A0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dutf-8"><meta name=3DGenerator content=3D"Microsoft=
 Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:=E5=AE=8B=E4=BD=93;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=E5=AE=8B=E4=BD=93";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:=E5=AE=8B=E4=BD=93;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-=
US style=3D'font-size:10.5pt;font-family:"Calibri",sans-serif;color:#1F497D=
'>You are absolutely right, the code I grabbed is indeed from mingw-w64, no=
t MinGW. Let me send out another patch with mingw-w64=E2=80=99s disclaimer =
soon. I=E2=80=99ll see what core people says about this patch.<o:p></o:p></=
span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.5pt;=
font-family:"Calibri",sans-serif;color:#1F497D'><o:p>&nbsp;</o:p></span></p=
><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.5pt;font-fam=
ily:"Calibri",sans-serif;color:#1F497D'>Thanks!<o:p></o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Ca=
libri",sans-serif;color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMso=
Normal><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",s=
ans-serif;color:#1F497D'>Best,<o:p></o:p></span></p><p class=3DMsoNormal><s=
pan lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",sans-serif=
;color:#1F497D'>Fish<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",sans-serif;color:#=
1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><b><span lang=3DEN=
-US style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>From:</span=
></b><span lang=3DEN-US style=3D'font-size:11.0pt;font-family:"Calibri",san=
s-serif'> Selva Nair [mailto:selva.nair@...277...] <br><b>Sent:</b> Sunday,=
 December 13, 2015 5:09 PM<br><b>To:</b> Fish Wang &lt;fish.thss@...277...&=
gt;<br><b>Cc:</b> openvpn-devel@lists.sourceforge.net<br><b>Subject:</b> Re=
: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform agnostic<o:=
p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p=
></span></p><div><div><p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><=
span lang=3DEN-US>Hi,<o:p></o:p></span></p></div><div><div><p class=3DMsoNo=
rmal><span lang=3DEN-US>On Sun, Dec 13, 2015 at 7:20 PM, Fish Wang &lt;<a h=
ref=3D"mailto:fish.thss@...277..." target=3D"_blank">fish.thss@...277...</a=
>&gt; wrote:<o:p></o:p></span></p><blockquote style=3D'border:none;border-l=
eft:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-=
right:0cm'><p class=3DMsoNormal><span lang=3DEN-US>Will do. However, I=E2=
=80=99m by no means a license expert. Based on Licensing Terms page on MinG=
W=E2=80=99s website ([1], win32api), I believe the code I stripped out of M=
inGW should be fine as long as a copy of the notice and its license [2] is =
included. Please correct me if I=E2=80=99m wrong.<o:p></o:p></span></p></bl=
ockquote></div><p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span la=
ng=3DEN-US><br>I thought those headers are from the mingw-w64 (a different =
code base<br>from mingw32).. <br><br>Anyway, I did not mean to imply any li=
censing issues with extracting <br>parts from mingw32 or mingw-w64 --- both=
 have permissive licenses <br>so there is no clash. However, some GPL proje=
cts have clear guidelines <br>of how to incorporate code from other license=
s. <br><br>Personally I prefer to keep public domain code (and minor edits =
to it) <br>in a&nbsp; separate file which clearly indicates its in PD with =
the original <br>notice so that one wouldn't slap on a GPL header on it lat=
er. While <br>some projects want all their additions to be GPL keeping the =
original <br>in PD etc..(Fro example, see various practices disscussed in&n=
bsp; <br><a href=3D"https://www.softwarefreedom.org/resources/2007/gpl-non-=
gpl-collaboration.pdf" target=3D"_blank">https://www.softwarefreedom.org/re=
sources/2007/gpl-non-gpl-collaboration.pdf</a>).<o:p></o:p></span></p></div=
><div><p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span lang=3DEN-U=
S>Better wait for a core developer to comment on this..<o:p></o:p></span></=
p></div><div><p class=3DMsoNormal><span lang=3DEN-US>Selva<o:p></o:p></span=
></p></div></div></div></body></html>=

------=_NextPart_000_015E_01D135CA.99A665A0--


