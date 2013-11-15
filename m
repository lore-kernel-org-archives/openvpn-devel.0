From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 15 Nov 2013 15:53:39 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90151F0BB9C7@...1436...>
References: <CAK6ywbLVtSgRZEt4N+02fz+vQ0GNp==5KdsbqWtZ+fgUzrZq+g@...278...>
In-Reply-To: <CAK6ywbLVtSgRZEt4N+02fz+vQ0GNp==5KdsbqWtZ+fgUzrZq+g@...278...>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_1CED409804E2164C8104F9E623B08B90151F0BB9C7FOXDFT02FOXlo_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] tls_ctx_load_ca: Improve certificate error
 messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Nicholas Hall <ngharo@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_1CED409804E2164C8104F9E623B08B90151F0BB9C7FOXDFT02FOXlo_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

A little late, but ACK from me.

-Steffan

From: Nicholas Hall [mailto:ngharo@...277...]
Sent: donderdag 22 augustus 2013 21:57
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] tls_ctx_load_ca: Improve certificate error messages

From https://github.com/OpenVPN/openvpn/pull/4 (I am not the patch author)

If a CA certificate file includes intermediate certificates, and any
of them fail to verify, the current code will file with "Cannot load
CA certificate file". Instead, generate a more specific error message
identifying the specific sub-certificate(s) which did not validate.

I make no claim that I really understand the OpenVPN code, but here's the s=
cenario that led to this patch:

I was using the "pile of certificates" handed to me by StartSSL, and one of=
 them was expired, but unnecessary to the verification chain. So when I tri=
ed to verify using openssl, it worked fine, but OpenVPN complained with a n=
ot-very-helpful "Cannot load CA certificate file." The following patch was =
what I ended up doing to figure out what was going wrong.

I have the suspicion that there are more complex procedures for submitting =
a patch that I don't know about, but I figured I'd start like this to see i=
f the change was interesting enough to you for me to pursue it further.

--_000_1CED409804E2164C8104F9E623B08B90151F0BB9C7FOXDFT02FOXlo_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DNL link=3Dblue vlink=
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-GB=
 style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D=
'>A little late, but ACK from me.<o:p></o:p></span></p><p class=3DMsoNormal=
><span lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-s=
erif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";=
color:#1F497D'>-Steffan<o:p></o:p></span></p><p class=3DMsoNormal><span lan=
g=3DEN-GB style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";colo=
r:#1F497D'><o:p>&nbsp;</o:p></span></p><div style=3D'border:none;border-lef=
t:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'border:non=
e;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoN=
ormal><b><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Tahoma",=
"sans-serif"'>From:</span></b><span lang=3DEN-US style=3D'font-size:10.0pt;=
font-family:"Tahoma","sans-serif"'> Nicholas Hall [mailto:ngharo@...277...]=
 <br><b>Sent:</b> donderdag 22 augustus 2013 21:57<br><b>To:</b> openvpn-de=
vel@lists.sourceforge.net<br><b>Subject:</b> [Openvpn-devel] tls_ctx_load_c=
a: Improve certificate error messages<o:p></o:p></span></p></div></div><p c=
lass=3DMsoNormal><o:p>&nbsp;</o:p></p><div><p class=3DMsoNormal>From&nbsp;<=
a href=3D"https://github.com/OpenVPN/openvpn/pull/4">https://github.com/Ope=
nVPN/openvpn/pull/4</a> (I am not the patch author)<o:p></o:p></p><div><p c=
lass=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><div><p class=3DMsoNormal>=
If a CA certificate file includes intermediate certificates, and any<o:p></=
o:p></p></div><div><p class=3DMsoNormal>of them fail to verify, the current=
 code will file with &quot;Cannot load<o:p></o:p></p></div><div><p class=3D=
MsoNormal>CA certificate file&quot;. Instead, generate a more specific erro=
r message<o:p></o:p></p></div><div><p class=3DMsoNormal>identifying the spe=
cific sub-certificate(s) which did not validate.<o:p></o:p></p></div><div><=
p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>I =
make no claim that I really understand the OpenVPN code, but here's the sce=
nario that led to this patch:<o:p></o:p></p></div><div><p class=3DMsoNormal=
><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>I was using the &quot=
;pile of certificates&quot; handed to me by StartSSL, and one of them was e=
xpired, but unnecessary to the verification chain. So when I tried to verif=
y using openssl, it worked fine, but OpenVPN complained with a not-very-hel=
pful &quot;Cannot load CA certificate file.&quot; The following patch was w=
hat I ended up doing to figure out what was going wrong.<o:p></o:p></p></di=
v><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoN=
ormal>I have the suspicion that there are more complex procedures for submi=
tting a patch that I don't know about, but I figured I'd start like this to=
 see if the change was interesting enough to you for me to pursue it furthe=
r.<o:p></o:p></p></div></div></div></div></div></body></html>=

--_000_1CED409804E2164C8104F9E623B08B90151F0BB9C7FOXDFT02FOXlo_--

