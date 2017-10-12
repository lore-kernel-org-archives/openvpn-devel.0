From: Simon Rozman <simon@...2293...>
Date: Thu, 12 Oct 2017 08:15:42 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10857E4773@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <67ed8854-4290-468e-9773-2bdde5cd8909@...2080...>
 <99D61A626FDA8A4B90A270669121BE10857E33EE@...2294...>
 <CAKuzo_i2gtJ9YS09mhmf4Y1T0SDiJ=0HHpyW72XFowbOfNJ3CA@...278...>
 <99D61A626FDA8A4B90A270669121BE10857E3A4B@...2294...>
 <CAKuzo_hhqgT23+rcdpdbOH74zYg6QvdcV4_ymo18VbuL+WkvFQ@...278...>
In-Reply-To: <CAKuzo_hhqgT23+rcdpdbOH74zYg6QvdcV4_ymo18VbuL+WkvFQ@...278...>
Content-Language: en-US
Content-Type: multipart/signed; micalg=2.16.840.1.101.3.4.2.1;
 protocol="application/x-pkcs7-signature";
 boundary="----=_NextPart_000_0054_01D34343.0F44BFF0"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 01/13] snwprintf() => _snwprintf()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_0054_01D34343.0F44BFF0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0055_01D34343.0F44BFF0"

------=_NextPart_001_0055_01D34343.0F44BFF0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,



Thank you for your feedback.



Based on it, I have sent a new patch "[PATCH] Uniform snwprintf() across MinGW 
and MSVC compilers", that supersedes this one.



Best regards,

Simon



From: Selva [mailto:selva.nair@...277...]
Sent: Wednesday, October 11, 2017 4:32 PM
To: Simon Rozman
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH 01/13] snwprintf() => _snwprintf()



Hi



On Wed, Oct 11, 2017 at 10:03 AM, Simon Rozman <simon@...2293...> wrote:

Hi,



I agree migration towards ISO-C's snwprintf() is better.



Just to be sure, ISO-C is 'swprintf' not 'snwprintf'. In spite of 'n' misisng 
from that name, it takes the buffer size argument and nul terminates even if 
output is truncated.


------=_NextPart_001_0055_01D34343.0F44BFF0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dutf-8"><meta name=3DGenerator content=3D"Microsoft=
 Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
code
	{mso-style-priority:99;
	font-family:"Courier New";}
p.MsoQuote, li.MsoQuote, div.MsoQuote
	{mso-style-priority:29;
	mso-style-link:"Quote Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Calibri","sans-serif";
	font-style:italic;}
span.QuoteChar
	{mso-style-name:"Quote Char";
	mso-style-priority:29;
	mso-style-link:Quote;
	font-family:"Calibri","sans-serif";
	font-style:italic;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DSL link=3Dblue vlink=
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-GB=
 style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D=
'>Hi,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D=
'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'><o:p>&n=
bsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-=
size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'>Thank you for=
 your feedback.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-G=
B style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB styl=
e=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'>Bas=
ed on it, I have sent a new patch &quot;[PATCH] Uniform snwprintf() across =
MinGW and MSVC compilers&quot;, that supersedes this one.<o:p></o:p></span>=
</p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-=
family:"Calibri","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family=
:"Calibri","sans-serif";color:#1F497D'>Best regards,<o:p></o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-famil=
y:"Calibri","sans-serif";color:#1F497D'>Simon<o:p></o:p></span></p><p class=
=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri","sans-se=
rif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><div style=3D'border:none;b=
order-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'b=
order:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p cla=
ss=3DMsoNormal><b><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:=
"Tahoma","sans-serif"'>From:</span></b><span lang=3DEN-US style=3D'font-siz=
e:10.0pt;font-family:"Tahoma","sans-serif"'> Selva [mailto:selva.nair@...1664...=
7...] <br><b>Sent:</b> Wednesday, October 11, 2017 4:32 PM<br><b>To:</b> Si=
mon Rozman<br><b>Cc:</b> openvpn-devel@lists.sourceforge.net<br><b>Subject:=
</b> Re: [Openvpn-devel] [PATCH 01/13] snwprintf() =3D&gt; _snwprintf()<o:p=
></o:p></span></p></div></div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><di=
v><p class=3DMsoNormal>Hi<o:p></o:p></p><div><p class=3DMsoNormal><o:p>&nbs=
p;</o:p></p><div><p class=3DMsoNormal>On Wed, Oct 11, 2017 at 10:03 AM, Sim=
on Rozman &lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...220...=
..2293...</a>&gt; wrote:<o:p></o:p></p><div><div><p class=3DMsoNormal style=
=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><span lang=3DEN-GB =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'=
>Hi,</span><o:p></o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:=
auto;mso-margin-bottom-alt:auto'><span lang=3DEN-GB style=3D'font-size:11.0=
pt;font-family:"Calibri","sans-serif";color:#1F497D'>&nbsp;</span><o:p></o:=
p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bott=
om-alt:auto'><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Cali=
bri","sans-serif";color:#1F497D'>I agree migration towards ISO-C's snwprint=
f() is better.</span><o:p></o:p></p></div></div><div><p class=3DMsoNormal><=
o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>Just to be sure, ISO-C =
is 'swprintf' not 'snwprintf'. In spite of 'n' misisng from that name, it t=
akes the buffer size argument and nul terminates even if output is truncate=
d.<o:p></o:p></p></div></div></div></div></div></div></body></html>=

------=_NextPart_001_0055_01D34343.0F44BFF0--

------=_NextPart_000_0054_01D34343.0F44BFF0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
R4f6pkgAAAAAAAA=

------=_NextPart_000_0054_01D34343.0F44BFF0--

