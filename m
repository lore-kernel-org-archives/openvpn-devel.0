From: "Fish Wang" <fish.thss@...277...>
References: <1450055187-17397-1-git-send-email-fish.thss@...277...>
	<1450056335-18444-1-git-send-email-fish.thss@...277...>
	<CAKuzo_jwN79GhubM4Dgp4=dnZwJVvTiEMEzUp4k-FWBqQ2dwPA@...278...>
In-Reply-To: <CAKuzo_jwN79GhubM4Dgp4=dnZwJVvTiEMEzUp4k-FWBqQ2dwPA@...278...>
Date: Mon, 14 Dec 2015 09:12:39 -0800
Message-ID: <01c501d13692$a42af9a0$ec80ece0$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01C6_01D1364F.960855E0"
Content-Language: zh-cn
Subject: Re: [Openvpn-devel] [PATCH] Make "block-outside-dns" option
	platform agnostic
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

------=_NextPart_000_01C6_01D1364F.960855E0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I see, let me add that file to Makefile.am. My modified build system does n=
ot create the dist tarball :-(

=20

Best,

Fish

=20

From: Selva Nair [mailto:selva.nair@...277...]=20
Sent: Monday, December 14, 2015 9:01 AM
To: Fish <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [PATCH] Make "block-outside-dns" option platform agnostic

=20

Hi,

On Sun, Dec 13, 2015 at 8:25 PM, Fish <fish.thss@...277... <mailto:fish.ths=
s@...277...> > wrote:

Make the "block-outside-dns" option agnostic of Windows versions by dynamic=
ally
loading WFP-related functions. Cross-compiled on Linux and tested on Windows
XP/10.
---
 src/openvpn/Makefile.am |   2 +-
 src/openvpn/init.c      |   4 -
 src/openvpn/options.c   |  17 ++-
 src/openvpn/win32.c     | 114 ++++++++-------
 src/openvpn/win32.h     |   1 +
 src/openvpn/win32_wfp.h | 359 ++++++++++++++++++++++++++++++++++++++++++++=
++++

=20

Looks good, including the attribution to the right mingw upstream..

But won't build, as the new header (win32_wfp.h) is not added to=20
src/openvpn/Makefile.am --- without that it wont get into the=20
dist tarball etc..

Next time please append a version number to the mail header:=20
something like [PATCH v2] would do. I'm getting confused with=20
too many versions :)

=20

Thanks,

Selva

=20

=20


------=_NextPart_000_01C6_01D1364F.960855E0
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
'>I see, let me add that file to Makefile.am. My modified build system does=
 not create the dist tarball :-(<o:p></o:p></span></p><p class=3DMsoNormal>=
<span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",sans-ser=
if;color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span la=
ng=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",sans-serif;color=
:#1F497D'>Best,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-U=
S style=3D'font-size:10.5pt;font-family:"Calibri",sans-serif;color:#1F497D'=
>Fish<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D=
'font-size:10.5pt;font-family:"Calibri",sans-serif;color:#1F497D'><o:p>&nbs=
p;</o:p></span></p><p class=3DMsoNormal><b><span lang=3DEN-US style=3D'font=
-size:11.0pt;font-family:"Calibri",sans-serif'>From:</span></b><span lang=
=3DEN-US style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'> Selva=
 Nair [mailto:selva.nair@...277...] <br><b>Sent:</b> Monday, December 14, 2=
015 9:01 AM<br><b>To:</b> Fish &lt;fish.thss@...277...&gt;<br><b>Cc:</b> op=
envpn-devel@lists.sourceforge.net<br><b>Subject:</b> Re: [PATCH] Make &quot=
;block-outside-dns&quot; option platform agnostic<o:p></o:p></span></p><p c=
lass=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><div><div><=
p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span lang=3DEN-US>Hi,<o=
:p></o:p></span></p></div><div><div><p class=3DMsoNormal><span lang=3DEN-US=
>On Sun, Dec 13, 2015 at 8:25 PM, Fish &lt;<a href=3D"mailto:fish.thss@...1665...=
77..." target=3D"_blank">fish.thss@...277...</a>&gt; wrote:<o:p></o:p></spa=
n></p><blockquote style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padd=
ing:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm'><p class=3DMsoNor=
mal><span lang=3DEN-US>Make the &quot;block-outside-dns&quot; option agnost=
ic of Windows versions by dynamically<br>loading WFP-related functions. Cro=
ss-compiled on Linux and tested on Windows<br>XP/10.<br>---<br>&nbsp;src/op=
envpn/Makefile.am |&nbsp; &nbsp;2 +-<br>&nbsp;src/openvpn/init.c&nbsp; &nbs=
p; &nbsp; |&nbsp; &nbsp;4 -<br>&nbsp;src/openvpn/options.c&nbsp; &nbsp;|&nb=
sp; 17 ++-<br>&nbsp;src/openvpn/win32.c&nbsp; &nbsp; &nbsp;| 114 ++++++++--=
-----<br>&nbsp;src/openvpn/win32.h&nbsp; &nbsp; &nbsp;|&nbsp; &nbsp;1 +<br>=
&nbsp;src/openvpn/win32_wfp.h | 359 +++++++++++++++++++++++++++++++++++++++=
+++++++++<o:p></o:p></span></p></blockquote></div><p class=3DMsoNormal><spa=
n lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div><div><p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt'><span lang=3DEN-US>Looks good, including the=
 attribution to the right mingw upstream..<o:p></o:p></span></p></div><div>=
<p class=3DMsoNormal><span lang=3DEN-US>But won't build, as the new header =
(win32_wfp.h) is not added to <br>src/openvpn/Makefile.am --- without that =
it wont get into the <br>dist tarball etc..<br><br>Next time please append =
a version number to the mail header: <br>something like [PATCH v2] would do=
. I'm getting confused with <br>too many versions :)<o:p></o:p></span></p><=
/div><div><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span><=
/p></div><div><p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span lan=
g=3DEN-US>Thanks,<o:p></o:p></span></p></div><div><p class=3DMsoNormal><spa=
n lang=3DEN-US>Selva<o:p></o:p></span></p></div><div><p class=3DMsoNormal><=
span lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div><div><p class=3DMsoNorm=
al><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></div></div></body>=
</html>=

------=_NextPart_000_01C6_01D1364F.960855E0--


