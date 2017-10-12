From: Simon Rozman <simon@...2293...>
Date: Thu, 12 Oct 2017 11:16:33 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10857E61C4@...2294...>
References: <99D61A626FDA8A4B90A270669121BE10857D3DCD@...2294...>
 <CAFHpkQGZuQUZBqPmsZkBDx1CPiG5KmKKi1Kn_pL9JqwiiQcOaA@...278...>
In-Reply-To: <CAFHpkQGZuQUZBqPmsZkBDx1CPiG5KmKKi1Kn_pL9JqwiiQcOaA@...278...>
Content-Language: en-US
Content-Type: multipart/signed; micalg=2.16.840.1.101.3.4.2.1;
 protocol="application/x-pkcs7-signature";
 boundary="----=_NextPart_000_00B8_01D3435C.52A65100"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpnserv building under MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_00B8_01D3435C.52A65100
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_00B9_01D3435C.52A65100"

------=_NextPart_001_00B9_01D3435C.52A65100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I have fixed msvc-*.bat files in the project root too now. So now IDE can b=
e launched from command line, as well as MSVC building works from command l=
ine now. I see you have forked OpenVPN repository on GitHub and applied my =
patches, so you might be interested in this one too. Let me know.

=20

Otherwise, I am curious about OpenVPN dev-team preferences now.

=20

1.       Should I post all MSVC-specific file changes as a one single large=
 patch? (.sln/.vcxproj/.bat files, without .h/.c)

2.       Should I continue posting MSVC specific project & batch file in sm=
all steps?

=20

I don't want to make too much confusion here and/or risk some or all of my =
work to get overlooked or rejected.

=20

Best regards,

Simon

=20

From: =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD [=
mailto:chipitsine@...277...]=20
Sent: Tuesday, October 10, 2017 3:10 PM
To: Simon Rozman
Cc: openvpn-devel (openvpn-devel@lists.sourceforge.net)
Subject: Re: [Openvpn-devel] openvpnserv building under MSVC

=20

wow.

did you try to build it on App Veyor ? (I tried, no success)

=20

2017-10-10 17:22 GMT+05:00 Simon Rozman <simon@...2293...>:

Hi!

It's me again - author of the eduVPN client for Windows. This time I have a
new problem. And, a solution I'd like to share with OpenVPN community.

I am considering bundling openvpn.exe, openvpnserv.exe, and standard TAP
drivers with eduVPN client to allow some degree of independence from stock
OpenVPN installations.

However, our version of openvpnserv.exe should have some modifications
(different named pipe, different registry key) to avoid collision with stock
OpenVPN installation. But that's our long term goal.

Unfortunately, maintaining a mingw build environment for our own OpenVPN
binaries is an overkill. Therefore, in the first stage, I have updated the
Microsoft Visual Studio C++ project files to be able to compile
openvpnserv.exe again:
- Project files were updated to Microsoft Visual Studio C++ 2017 Community
Edition.
- Some minor updates were made to .h/.c files to compile using MSVC again.
- Support for x64 platform was added.
- All MSVC warnings were addressed and fixed.

Can I deliver the patches for above?

Best regards,
Simon Rozman

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

=20


------=_NextPart_001_00B9_01D3435C.52A65100
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
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
/* List Definitions */
@list l0
	{mso-list-id:1112168947;
	mso-list-type:hybrid;
	mso-list-template-ids:1299206738 69468175 69468185 69468187 69468175 69468=
185 69468187 69468175 69468185 69468187;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
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
size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'>I have fixed =
msvc-*.bat files in the project root too now. So now IDE can be launched fr=
om command line, as well as MSVC building works from command line now. I se=
e you have forked OpenVPN repository on GitHub and applied my patches, so y=
ou might be interested in this one too. Let me know.<o:p></o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-famil=
y:"Calibri","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><p clas=
s=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Cal=
ibri","sans-serif";color:#1F497D'>Otherwise, I am curious about OpenVPN dev=
-team preferences now.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color=
:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoListParagraph style=3D'=
text-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if !supportLists]><span lan=
g=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";colo=
r:#1F497D'><span style=3D'mso-list:Ignore'>1.<span style=3D'font:7.0pt "Tim=
es New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><!=
[endif]><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";color:#1F497D'>Should I post all MSVC-specific file changes as=
 a one single large patch? (.sln/.vcxproj/.bat files, without .h/.c)<o:p></=
o:p></span></p><p class=3DMsoListParagraph style=3D'text-indent:-18.0pt;mso=
-list:l0 level1 lfo1'><![if !supportLists]><span lang=3DEN-GB style=3D'font=
-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'><span style=
=3D'mso-list:Ignore'>2.<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span lang=3DE=
N-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F=
497D'>Should I continue posting MSVC specific project &amp; batch file in s=
mall steps?<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB st=
yle=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'><=
o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D=
'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'>I don't=
 want to make too much confusion here and/or risk some or all of my work to=
 get overlooked or rejected.<o:p></o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif"=
;color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color=
:#1F497D'>Best regards,<o:p></o:p></span></p><p class=3DMsoNormal><span lan=
g=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";colo=
r:#1F497D'>Simon<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-=
GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F49=
7D'><o:p>&nbsp;</o:p></span></p><div style=3D'border:none;border-left:solid=
 blue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'border:none;borde=
r-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><=
b><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Tahoma","sans-s=
erif"'>From:</span></b><span lang=3DEN-US style=3D'font-size:10.0pt;font-fa=
mily:"Tahoma","sans-serif"'> =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD [mailto:chipitsine@...277...] <br><b>Sent:</b> Tuesda=
y, October 10, 2017 3:10 PM<br><b>To:</b> Simon Rozman<br><b>Cc:</b> openvp=
n-devel (openvpn-devel@lists.sourceforge.net)<br><b>Subject:</b> Re: [Openv=
pn-devel] openvpnserv building under MSVC<o:p></o:p></span></p></div></div>=
<p class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><div><p class=3DMsoNormal st=
yle=3D'margin-bottom:12.0pt'>wow.<o:p></o:p></p></div><p class=3DMsoNormal>=
did you try to build it on App Veyor ? (I tried, no success)<o:p></o:p></p>=
</div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><p class=3DMsoNor=
mal>2017-10-10 17:22 GMT+05:00 Simon Rozman &lt;<a href=3D"mailto:simon@...493...=
2293..." target=3D"_blank">simon@...2293...</a>&gt;:<o:p></o:p></p><p class=
=3DMsoNormal style=3D'margin-bottom:12.0pt'>Hi!<br><br>It's me again - auth=
or of the eduVPN client for Windows. This time I have a<br>new problem. And=
, a solution I'd like to share with OpenVPN community.<br><br>I am consider=
ing bundling openvpn.exe, openvpnserv.exe, and standard TAP<br>drivers with=
 eduVPN client to allow some degree of independence from stock<br>OpenVPN i=
nstallations.<br><br>However, our version of openvpnserv.exe should have so=
me modifications<br>(different named pipe, different registry key) to avoid=
 collision with stock<br>OpenVPN installation. But that's our long term goa=
l.<br><br>Unfortunately, maintaining a mingw build environment for our own =
OpenVPN<br>binaries is an overkill. Therefore, in the first stage, I have u=
pdated the<br>Microsoft Visual Studio C++ project files to be able to compi=
le<br>openvpnserv.exe again:<br>- Project files were updated to Microsoft V=
isual Studio C++ 2017 Community<br>Edition.<br>- Some minor updates were ma=
de to .h/.c files to compile using MSVC again.<br>- Support for x64 platfor=
m was added.<br>- All MSVC warnings were addressed and fixed.<br><br>Can I =
deliver the patches for above?<br><br>Best regards,<br>Simon Rozman<br><br>=
---------------------------------------------------------------------------=
---<br>Check out the vibrant tech community on one of the world's most<br>e=
ngaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" targ=
et=3D"_blank">http://sdm.link/slashdot</a><br>_____________________________=
__________________<br>Openvpn-devel mailing list<br><a href=3D"mailto:Openv=
pn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a><br>=
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><o:p></o:p></p></div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></div=
></div></body></html>=

------=_NextPart_001_00B9_01D3435C.52A65100--

------=_NextPart_000_00B8_01D3435C.52A65100
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
wv/6sW0AAAAAAAA=

------=_NextPart_000_00B8_01D3435C.52A65100--

