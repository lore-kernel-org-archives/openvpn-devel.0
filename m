From: "Fish Wang" <fish.thss@...277...>
References: <CADCH5Ogh2ROBNti_hmBUBcQYBz4SuHJo_-cii14_E6aj9jmj-A@...278...>
	<1449794790-45430-1-git-send-email-fish.thss@...277...>
	<CAKuzo_ikg1My8wt2nbycosHvOwKhrRQPO18hjdgqDreCMDbeoQ@...278...>
In-Reply-To: <CAKuzo_ikg1My8wt2nbycosHvOwKhrRQPO18hjdgqDreCMDbeoQ@...278...>
Date: Sun, 13 Dec 2015 16:20:03 -0800
Message-ID: <014001d13605$2dec6ae0$89c540a0$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0141_01D135C2.1FC9C720"
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

------=_NextPart_000_0141_01D135C2.1FC9C720
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

=20

A minor suggestion: All those prototypes taken from mingw (32 or -w64?)=20
may be better placed in new header file to be included only from win32.c --=
=20
-- preferably with a license matching the source (PD or ZPL?).  Makes
win32.c less cluttered as well.

=20

Will do. However, I=E2=80=99m by no means a license expert. Based on Licens=
ing Terms page on MinGW=E2=80=99s website ([1], win32api), I believe the co=
de I stripped out of MinGW should be fine as long as a copy of the notice a=
nd its license [2] is included. Please correct me if I=E2=80=99m wrong.

=20

Best,

Fish

=20

[1] http://www.mingw.org/license

[2] http://sourceforge.net/p/mingw/mingw-org-wsl/ci/21762bb4a1bd0c88c38eead=
03f59e8d994349e83/tree/LICENSE

=20

From: Selva Nair [mailto:selva.nair@...277...]=20
Sent: Sunday, December 13, 2015 1:14 PM
To: Fish <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform =
agnostic

=20

Hi,

On Thu, Dec 10, 2015 at 7:46 PM, Fish <fish.thss@...277... <mailto:fish.ths=
s@...277...> > wrote:

Based on release/2.3 branch and ValdikSS's v9 patch, this patch is
cross-compiled on Linux and tested on Windows XP/10. The VC project file is
left untouched - you might want to add rpcrt4.lib to compile and link it un=
der
MSVC.

=20

Builds on 2.3 out of the box (i.e., target  WINXP).

The implementation looks fine, and works on win7 and 10, but I've=20
no XP machines for the crucial test.

A minor suggestion: All those prototypes taken from mingw (32 or -w64?)=20
may be better placed in new header file to be included only from win32.c --=
=20
-- preferably with a license matching the source (PD or ZPL?).  Makes
win32.c less cluttered as well.=20

I'm not familiar with the policy of OpenVPN on license-related=20
matters, though.

=20

Selva


------=_NextPart_000_0141_01D135C2.1FC9C720
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
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
'>Hi all,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US styl=
e=3D'font-size:10.5pt;font-family:"Calibri",sans-serif;color:#1F497D'><o:p>=
&nbsp;</o:p></span></p><p class=3DMsoNormal style=3D'margin-left:12.0pt;mso=
-para-margin-left:1.0gd'><span lang=3DEN-US style=3D'font-size:10.5pt;font-=
family:"Calibri",sans-serif;color:#1F497D'>A minor suggestion: All those pr=
ototypes taken from mingw (32 or -w64?) <br>may be better placed in new hea=
der file to be included only from win32.c -- <br>-- preferably with a licen=
se matching the source (PD or ZPL?).&nbsp; Makes<br>win32.c less cluttered =
as well.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=
=3D'font-size:10.5pt;font-family:"Calibri",sans-serif;color:#1F497D'><o:p>&=
nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font=
-size:10.5pt;font-family:"Calibri",sans-serif;color:#1F497D'>Will do. Howev=
er, I=E2=80=99m by no means a license expert. Based on Licensing Terms page=
 on MinGW=E2=80=99s website ([1], win32api), I believe the code I stripped =
out of MinGW should be fine as long as a copy of the notice and its license=
 [2] is included. Please correct me if I=E2=80=99m wrong.<o:p></o:p></span>=
</p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.5pt;font-=
family:"Calibri",sans-serif;color:#1F497D'><o:p>&nbsp;</o:p></span></p><p c=
lass=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"=
Calibri",sans-serif;color:#1F497D'>Best,<o:p></o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",=
sans-serif;color:#1F497D'>Fish<o:p></o:p></span></p><p class=3DMsoNormal><s=
pan lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",sans-serif=
;color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",sans-serif;color:#=
1F497D'>[1] http://www.mingw.org/license<o:p></o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",=
sans-serif;color:#1F497D'>[2] http://sourceforge.net/p/mingw/mingw-org-wsl/=
ci/21762bb4a1bd0c88c38eead03f59e8d994349e83/tree/LICENSE<o:p></o:p></span><=
/p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.5pt;font-f=
amily:"Calibri",sans-serif;color:#1F497D'><o:p>&nbsp;</o:p></span></p><p cl=
ass=3DMsoNormal><b><span lang=3DEN-US style=3D'font-size:11.0pt;font-family=
:"Calibri",sans-serif'>From:</span></b><span lang=3DEN-US style=3D'font-siz=
e:11.0pt;font-family:"Calibri",sans-serif'> Selva Nair [mailto:selva.nair@...220...=
..277...] <br><b>Sent:</b> Sunday, December 13, 2015 1:14 PM<br><b>To:</b> =
Fish &lt;fish.thss@...277...&gt;<br><b>Cc:</b> openvpn-devel@...1357...=
rge.net<br><b>Subject:</b> Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS =
leak fix platform agnostic<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><div><div><p class=3DMsoNormal sty=
le=3D'margin-bottom:12.0pt'><span lang=3DEN-US>Hi,<o:p></o:p></span></p></d=
iv><div><div><p class=3DMsoNormal><span lang=3DEN-US>On Thu, Dec 10, 2015 a=
t 7:46 PM, Fish &lt;<a href=3D"mailto:fish.thss@...277..." target=3D"_blank=
">fish.thss@...277...</a>&gt; wrote:<o:p></o:p></span></p><blockquote style=
=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;m=
argin-left:4.8pt;margin-right:0cm'><div><p class=3DMsoNormal><span lang=3DE=
N-US>Based on release/2.3 branch and ValdikSS's v9 patch, this patch is<br>=
cross-compiled on Linux and tested on Windows XP/10. The VC project file is=
<br>left untouched - you might want to add rpcrt4.lib to compile and link i=
t under<br>MSVC.<o:p></o:p></span></p></div></blockquote></div><p class=3DM=
soNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div><div><p class=
=3DMsoNormal><span lang=3DEN-US>Builds on 2.3 out of the box (i.e., target&=
nbsp; WINXP).<o:p></o:p></span></p></div><div><p class=3DMsoNormal style=3D=
'margin-bottom:12.0pt'><span lang=3DEN-US>The implementation looks fine, an=
d works on win7 and 10, but I've <br>no XP machines for the crucial test.<o=
:p></o:p></span></p></div><div><p class=3DMsoNormal><span lang=3DEN-US>A mi=
nor suggestion: All those prototypes taken from mingw (32 or -w64?) <br>may=
 be better placed in new header file to be included only from win32.c -- <b=
r>-- preferably with a license matching the source (PD or ZPL?).&nbsp; Make=
s<br>win32.c less cluttered as well. <br><br>I'm not familiar with the poli=
cy of OpenVPN on license-related <br>matters, though.<o:p></o:p></span></p>=
</div><div><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span>=
</p></div><div><p class=3DMsoNormal><span lang=3DEN-US>Selva<o:p></o:p></sp=
an></p></div></div></div></body></html>=

------=_NextPart_000_0141_01D135C2.1FC9C720--


