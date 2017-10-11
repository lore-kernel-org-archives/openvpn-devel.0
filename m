From: Simon Rozman <simon@...2293...>
Date: Wed, 11 Oct 2017 13:57:03 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10857E3A0D@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-5-simon@...2293...>
 <CAKuzo_iQtWLganoH3n39hASRThrqmpHYh8ec=STm9yxeeROGYg@...278...>
In-Reply-To: <CAKuzo_iQtWLganoH3n39hASRThrqmpHYh8ec=STm9yxeeROGYg@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_0000_01D342A9.941114D0"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 05/13] Function prototypes are declared
 as "typedef <return type> (<calling convention> *type_name)(<arguments>)"
 in MSVC.
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

------=_NextPart_000_0000_01D342A9.941114D0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0001_01D342A9.941114D0"

------=_NextPart_001_0001_01D342A9.941114D0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,



I shall happily rewrite the code to remove those declarations. However, I'll 
need to check MSDN on a case-by-case basis to replace only API calls that are 
standard from Vista on.



Do you still maintain 2.3 branch for Windows XP? You do know, that replacing 
GetProcAddr() with statically linked Vista+ API calls would break 
compatibility with Windows XP.



Best regards,

Simon



From: Selva [mailto:selva.nair@...277...]
Sent: Wednesday, October 11, 2017 3:21 PM
To: Simon Rozman
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH 05/13] Function prototypes are declared as 
"typedef <return type> (<calling convention> *type_name)(<arguments>)" in 
MSVC.



Hi,



Thanks for these patches.



On Tue, Oct 10, 2017 at 7:11 PM, <simon@...2293...> wrote:

From: Simon Rozman <simon@...2293...>

Note: NETIOAPI_API is defined as:
#define NETIOAPI_API NETIO_STATUS NETIOAPI_API_
#define NETIOAPI_API_ WINAPI

I am not sure whether interactive.c will compile using mingw with this patch. 
If not:
1. We can introduce some
   #ifdef _MSC_VER
   #else
   #endif
2. Since NTDDI_VERSION=NTDDI_VISTA, most of the dynamic API loading by 
GetProcAddress() could be simplified to statically linked API calls, avoiding 
function prototype declarations altogether. I suggest we do this anyway to 
clean-up the code in the future.



Yes, those declarations and run-time lookup were slated for removal but 
somehow never happened. Its a good idea to get rid of those -- no point in 
tweaking them to suit MSVC.



IIRC, at least the versions of mingw that I use (gcc 4.9.3 or later) will 
build with those stripped but I can test again if you replace this patch with 
one removing those declarations.



Selva


------=_NextPart_001_0001_01D342A9.941114D0
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
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
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:SL;}
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
size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'>I shall happi=
ly rewrite the code to remove those declarations. However, I'll need to che=
ck MSDN on a case-by-case basis to replace only API calls that are standard=
 from Vista on.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-G=
B style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB styl=
e=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'>Do =
you still maintain 2.3 branch for Windows XP? You do know, that replacing G=
etProcAddr() with statically linked Vista+ API calls would break compatibil=
ity with Windows XP.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color=
:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-=
GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F49=
7D'>Best regards,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN=
-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F4=
97D'>Simon<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB sty=
le=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'><o=
:p>&nbsp;</o:p></span></p><div style=3D'border:none;border-left:solid blue =
1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'border:none;border-top:=
solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><spa=
n lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'=
>From:</span></b><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"=
Tahoma","sans-serif"'> Selva [mailto:selva.nair@...277...] <br><b>Sent:</b>=
 Wednesday, October 11, 2017 3:21 PM<br><b>To:</b> Simon Rozman<br><b>Cc:</=
b> openvpn-devel@lists.sourceforge.net<br><b>Subject:</b> Re: [Openvpn-deve=
l] [PATCH 05/13] Function prototypes are declared as &quot;typedef &lt;retu=
rn type&gt; (&lt;calling convention&gt; *type_name)(&lt;arguments&gt;)&quot=
; in MSVC.<o:p></o:p></span></p></div></div><p class=3DMsoNormal><o:p>&nbsp=
;</o:p></p><div><p class=3DMsoNormal>Hi,<o:p></o:p></p><div><div><p class=
=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>Thanks fo=
r these patches.<o:p></o:p></p></div><div><p class=3DMsoNormal><o:p>&nbsp;<=
/o:p></p><div><p class=3DMsoNormal>On Tue, Oct 10, 2017 at 7:11 PM, &lt;<a =
href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&gt;=
 wrote:<o:p></o:p></p><p class=3DMsoNormal>From: Simon Rozman &lt;<a href=
=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&gt;<br>=
<br>Note: NETIOAPI_API is defined as:<br>#define NETIOAPI_API NETIO_STATUS =
NETIOAPI_API_<br>#define NETIOAPI_API_ WINAPI<br><br>I am not sure whether =
interactive.c will compile using mingw with this patch. If not:<br>1. We ca=
n introduce some<br>&nbsp; &nbsp;#ifdef _MSC_VER<br>&nbsp; &nbsp;#else<br>&=
nbsp; &nbsp;#endif<br>2. Since NTDDI_VERSION=3DNTDDI_VISTA, most of the dyn=
amic API loading by GetProcAddress() could be simplified to statically link=
ed API calls, avoiding function prototype declarations altogether. I sugges=
t we do this anyway to clean-up the code in the future.<o:p></o:p></p><div>=
<p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>Y=
es, those declarations and run-time lookup were slated for removal but some=
how never happened. Its a good idea to get rid of those -- no point in twea=
king them to suit MSVC. &nbsp;<o:p></o:p></p></div><div><p class=3DMsoNorma=
l><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>IIRC, at least the v=
ersions of mingw that I use (gcc 4.9.3 or later) will build with those stri=
pped but I can test again if you replace this patch with one removing those=
 declarations.<o:p></o:p></p></div><div><p class=3DMsoNormal><o:p>&nbsp;</o=
:p></p></div><div><p class=3DMsoNormal>Selva<o:p></o:p></p></div></div></di=
v></div></div></div></div></body></html>=

------=_NextPart_001_0001_01D342A9.941114D0--

------=_NextPart_000_0000_01D342A9.941114D0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
Z5OzDEYAAAAAAAA=

------=_NextPart_000_0000_01D342A9.941114D0--

