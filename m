From: Simon Rozman <simon@...2293...>
Date: Wed, 9 Aug 2017 19:46:57 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10806D643C@...2294...>
References: <99D61A626FDA8A4B90A270669121BE10806D5BC3@...2294...>
 <CAKuzo_gmn-B6=4Vho9OwUENzqT0C5ibNZghOY-9B1cpTGRE42Q@...278...>
In-Reply-To: <CAKuzo_gmn-B6=4Vho9OwUENzqT0C5ibNZghOY-9B1cpTGRE42Q@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_0014_01D31159.05E14FD0"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OVPN Interactive Service for non-admin users
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_0014_01D31159.05E14FD0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0015_01D31159.05E14FD0"

------=_NextPart_001_0015_01D31159.05E14FD0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Selva,

Is there any specific reason, why Interactive Service is so paranoid, knowi=
ng that it launches openvpn.exe and all external scripts as the interactive=
 user anyway?

The service does privileged operations so some admin has to bless a user to=
 allow certain options when launching openvpn.exe. In other words, options =
allowed in user editable configs are restricted unless the user is in a des=
ignated group.

=20=20

I don't quite agree. OpenVPN needs elevation to set up connection because i=
t runs in user space. IPsec VPN doesn't require elevation for the very same=
 task since it runs in kernel space.

=20

Therefore, elevation for OpenVPN is required for technical reasons, not sec=
urity. Thus, an explicit blessing from the admin is an exaggeration.

 I have a work-around for this paradox in my sleeve: the eduVPN setup shall=
 create an "eduVPN" subfolder in the "C:\Program Files\OpenVPN\config" fold=
er, and grant all users desirable permissions*: a sort of public spool fold=
er.

Setting up such a folder requires admin rights. If your installer has admin=
 rights, just add all users to "OpenVPN Administrators" group or set the re=
gistry key ovpn_admin_group to "Users"

=20=20

The installer will require admin rights of course. Here we agree installing=
 software (VPN especially) needs an admin approval.

=20

Thank you for your excellent advice. I haven't thought of that before. Howe=
ver, I will not follow it for the following reason=E2=80=A6

=20

eduVPN will not claim OpenVPN for all by itself. It will install it when mi=
ssing, but will leave everything to its defaults. We would still like to le=
ave the user an option to make use of OpenVPN for other purposes. Tweaking =
registry is not a step in this direction.

 But that would open the OpenVPN Interactive Service to any user and applic=
ation. This is why we would like your opinion first.

Yes the service will then launch openvpn with arbitrary configs as any user=
, but that is what you want isn't it?

=20

True, I want that indeed. I was just trying to find the official way of doi=
ng it only to learn it's against OpenVPN team's principles. :(

=20

Well, I'll do it anyway. And I suggest you take it as a compliment: the Ope=
nVPN is great for its flexibility so people can and will use it in a millio=
n of bizarre ways. :)

=20

Best regards,

Simon


------=_NextPart_001_0015_01D31159.05E14FD0
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
p.m-3887839519535789151msolistparagraph, li.m-3887839519535789151msolistpar=
agraph, div.m-3887839519535789151msolistparagraph
	{mso-style-name:m_-3887839519535789151msolistparagraph;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
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
	{mso-list-id:1173715068;
	mso-list-type:hybrid;
	mso-list-template-ids:-417539578 69468175 69468185 69468187 69468175 69468=
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
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'fon=
t-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'>Hi Selva,<o=
:p></o:p></span></p><div><div><div><blockquote style=3D'border:none;border-=
left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin=
-right:0cm'><div><div><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto=
;mso-margin-bottom-alt:auto;margin-left:23.85pt'><span lang=3DEN-GB>Is ther=
e any specific reason, why Interactive Service is so paranoid, knowing that=
 it launches openvpn.exe and all external scripts as the interactive user a=
nyway?</span><o:p></o:p></p></div></div></blockquote><div><p class=3DMsoNor=
mal style=3D'margin-left:23.85pt'>The service does privileged operations so=
 some admin has to bless a user to allow certain options when launching ope=
nvpn.exe. In other words, options allowed in user editable configs are rest=
ricted unless the user is in a designated group.<o:p></o:p></p></div><div><=
p class=3DMsoNormal>&nbsp;&nbsp;<o:p></o:p></p><p class=3DMsoNormal><span l=
ang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";co=
lor:#1F497D'>I don't quite agree. OpenVPN needs elevation to set up connect=
ion because it runs in user space. IPsec VPN doesn't require elevation for =
the very same task since it runs in kernel space.<o:p></o:p></span></p><p c=
lass=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"=
Calibri","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Cali=
bri","sans-serif";color:#1F497D'>Therefore, elevation for OpenVPN is requir=
ed for technical reasons, not security. Thus, an explicit blessing from the=
 admin is an exaggeration.<o:p></o:p></span></p></div><blockquote style=3D'=
border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margi=
n-left:4.8pt;margin-right:0cm'><div><div><p class=3DMsoNormal style=3D'mso-=
margin-top-alt:auto;mso-margin-bottom-alt:auto'><span lang=3DEN-GB>&nbsp;I =
have a work-around for this paradox in my sleeve: the eduVPN setup shall cr=
eate an &quot;eduVPN&quot; subfolder in the &quot;C:\Program Files\OpenVPN\=
config&quot; folder, and grant all users desirable permissions*: a sort of =
public spool folder.</span><o:p></o:p></p></div></div></blockquote><div><p =
class=3DMsoNormal>Setting up such a folder requires admin rights. If your i=
nstaller has admin rights, just add all users to &quot;OpenVPN Administrato=
rs&quot; group or set the registry key ovpn_admin_group to &quot;Users&quot=
;<o:p></o:p></p></div><div><p class=3DMsoNormal>&nbsp;&nbsp;<o:p></o:p></p>=
<p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-fami=
ly:"Calibri","sans-serif";color:#1F497D'>The installer will require admin r=
ights of course. Here we agree installing software (VPN especially) needs a=
n admin approval.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN=
-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F4=
97D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB st=
yle=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'>T=
hank you for your excellent advice. I haven't thought of that before. Howev=
er, I will not follow it for the following reason=E2=80=A6<o:p></o:p></span=
></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font=
-family:"Calibri","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-famil=
y:"Calibri","sans-serif";color:#1F497D'>eduVPN will not claim OpenVPN for a=
ll by itself. It will install it when missing, but will leave everything to=
 its defaults. We would still like to leave the user an option to make use =
of OpenVPN for other purposes. Tweaking registry is not a step in this dire=
ction.<o:p></o:p></span></p></div><blockquote style=3D'border:none;border-l=
eft:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-=
right:0cm'><div><div><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;=
mso-margin-bottom-alt:auto'><span lang=3DEN-GB>&nbsp;But that would open th=
e OpenVPN Interactive Service to any user and application. This is why we w=
ould like your opinion first.</span><o:p></o:p></p></div></div></blockquote=
><div><p class=3DMsoNormal>Yes the service will then launch openvpn with ar=
bitrary configs as any user, but that is what you want isn't it?<span style=
=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'><o:p=
></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:11.0pt;font=
-family:"Calibri","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:11.0pt;font-famil=
y:"Calibri","sans-serif";color:#1F497D'>True, I want that indeed. I was jus=
t trying to find the official way of doing it only to learn it's against Op=
enVPN team's principles. :(<o:p></o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";=
color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color=
:#1F497D'>Well, I'll do it anyway. And I suggest you take it as a complimen=
t: the OpenVPN is great for its flexibility so people can and will use it i=
n a million of bizarre ways. :)<o:p></o:p></span></p><p class=3DMsoNormal><=
span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-ser=
if";color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span l=
ang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";co=
lor:#1F497D'>Best regards,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";c=
olor:#1F497D'>Simon<o:p></o:p></span></p></div></div></div></div></div></bo=
dy></html>=

------=_NextPart_001_0015_01D31159.05E14FD0--

------=_NextPart_000_0014_01D31159.05E14FD0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
QY50mNsAAAAAAAA=

------=_NextPart_000_0014_01D31159.05E14FD0--

