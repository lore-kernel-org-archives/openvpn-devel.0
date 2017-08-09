From: Simon Rozman <simon@...2293...>
Date: Wed, 9 Aug 2017 14:31:58 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10806D5BC3@...2294...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_002E_01D3112D.055E8F40"
MIME-Version: 1.0
Subject: [Openvpn-devel] OVPN Interactive Service for non-admin users
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_002E_01D3112D.055E8F40
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_002F_01D3112D.055E8F40"

------=_NextPart_001_002F_01D3112D.055E8F40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi!

 

I am developing an eduVPN client for Windows. Imagine the eduVPN client as a
custom OpenVPN GUI. The client uses openvpn.exe for connecting, the
configuration file is provided by eduVPN server once user authenticates
using OAuth. User running the eduVPN client is not an administrator.
Elevation is out of the question.

 

I would like to use the Interactive Service to start openvpn.exe, but I have
some problems:

 

1.       The configuration file is dynamically downloaded by the eduVPN
client and stored somewhere user can write (user's temporary folder for
example). But the Interactive Service was specifically programmed to allow
configurations from "C:\Program Files\OpenVPN\config" folder only. But user
running eduVPN client can't write to this folder.

2.       Interactive Service can launch openvpn.exe using any configuration
file if user is a member of the "OpenVPN Administrators" group. Then, I
would need to add all users of the computer to that group, again requiring
elevation.

 

Is there any specific reason, why Interactive Service is so paranoid,
knowing that it launches openvpn.exe and all external scripts as the
interactive user anyway?

 

I have a work-around for this paradox in my sleeve: the eduVPN setup shall
create an "eduVPN" subfolder in the "C:\Program Files\OpenVPN\config"
folder, and grant all users desirable permissions*: a sort of public spool
folder.

 

But that would open the OpenVPN Interactive Service to any user and
application. This is why we would like your opinion first.

 

Best regards,

Simon Rozman

Amebis, d. o. o., Kamnik

 

* By desirable permissions I mean: SYSTEM/Administrators = full access,
Users = create new files, CREATOR OWNER = R/W)

 


------=_NextPart_001_002F_01D3112D.055E8F40
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
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
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
p.MsoQuote, li.MsoQuote, div.MsoQuote
	{mso-style-priority:29;
	mso-style-link:"Quote Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;
	font-style:italic;}
span.QuoteChar
	{mso-style-name:"Quote Char";
	mso-style-priority:29;
	mso-style-link:Quote;
	font-family:"Calibri","sans-serif";
	font-style:italic;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1139805312;
	mso-list-type:hybrid;
	mso-list-template-ids:905196816 69468175 69468185 69468187 69468175 694681=
85 69468187 69468175 69468185 69468187;}
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
>Hi!<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbs=
p;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>I am developing =
an eduVPN client for Windows. Imagine the eduVPN client as a custom OpenVPN=
 GUI. The client uses openvpn.exe for connecting, the configuration file is=
 provided by eduVPN server once user authenticates using OAuth. User runnin=
g the eduVPN client is not an administrator. Elevation is out of the questi=
on.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp=
;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>I would like to u=
se the Interactive Service to start openvpn.exe, but I have some problems:<=
o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o=
:p></span></p><p class=3DMsoListParagraph style=3D'text-indent:-18.0pt;mso-=
list:l0 level1 lfo1'><![if !supportLists]><span lang=3DEN-GB><span style=3D=
'mso-list:Ignore'>1.<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span lang=3DEN-G=
B>The configuration file is dynamically downloaded by the eduVPN client and=
 stored somewhere user can write (user's temporary folder for example). But=
 the Interactive Service was specifically programmed to allow configuration=
s from &quot;C:\Program Files\OpenVPN\config&quot; folder only. But user ru=
nning eduVPN client can't write to this folder.<o:p></o:p></span></p><p cla=
ss=3DMsoListParagraph style=3D'text-indent:-18.0pt;mso-list:l0 level1 lfo1'=
><![if !supportLists]><span lang=3DEN-GB><span style=3D'mso-list:Ignore'>2.=
<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; </span></span></span><![endif]><span lang=3DEN-GB>Interactive Servic=
e can launch openvpn.exe using any configuration file if user is a member o=
f the &quot;OpenVPN Administrators&quot; group. Then, I would need to add a=
ll users of the computer to that group, again requiring elevation.<o:p></o:=
p></span></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></spa=
n></p><p class=3DMsoNormal><span lang=3DEN-GB>Is there any specific reason,=
 why Interactive Service is so paranoid, knowing that it launches openvpn.e=
xe and all external scripts as the interactive user anyway?<o:p></o:p></spa=
n></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-GB>I have a work-around for this parado=
x in my sleeve: the eduVPN setup shall create an &quot;eduVPN&quot; subfold=
er in the &quot;C:\Program Files\OpenVPN\config&quot; folder, and grant all=
 users desirable permissions*: a sort of public spool folder.<o:p></o:p></s=
pan></p><p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p=
><p class=3DMsoNormal><span lang=3DEN-GB>But that would open the OpenVPN In=
teractive Service to any user and application. This is why we would like yo=
ur opinion first.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN=
-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>Bes=
t regards,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>Sim=
on Rozman<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB>Ameb=
is, d. o. o., Kamnik<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-G=
B>* By desirable permissions I mean: SYSTEM/Administrators =3D full access,=
 Users =3D create new files, CREATOR OWNER =3D R/W)<o:p></o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p></div></b=
ody></html>=

------=_NextPart_001_002F_01D3112D.055E8F40--

------=_NextPart_000_002E_01D3112D.055E8F40
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
9KRBpyUAAAAAAAA=

------=_NextPart_000_002E_01D3112D.055E8F40--

