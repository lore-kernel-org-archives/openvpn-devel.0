From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 5 Jul 2011 13:37:22 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B901269D8E391@...1436...>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_1CED409804E2164C8104F9E623B08B901269D8E391FOXDFT02FOXlo_"
MIME-Version: 1.0
Subject: [Openvpn-devel] PolarSSL patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_1CED409804E2164C8104F9E623B08B901269D8E391FOXDFT02FOXlo_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

During last week's meeting we decided to temporarily create a github tree f=
or OpenVPN. It can be found at https://github.com/andj/openvpn-ssl-refactor=
ing . The version found there is now ready for testing, and will (hopefully=
) be included in the 2.3 alpha versions.

Could interested parties please have a look and provide me with feedback (t=
hrough IRC/e-mail?).

Thanks!

Adriaan de Jong

PS. Note that due to limitations in PolarSSL, it is still missing a number =
of features:

 * PKCS#12 file support
 * --capath support - Loading certificate authorities from a directory
 * Windows CryptoAPI support
 * Management external key support
 * X.509 alternative username fields (must be "CN")

Plugin/Script features:

 * X.509 Serial number is in hex, not decimal as with OpenSSL
 * X.509 subject line has a different format than the OpenSSL subject line
 * X.509 certificate export does not work
 * X.509 certificate tracking

Fox-IT    ...for a more secure society
I www.fox-it.com<http://www.fox-it.com/>



--_000_1CED409804E2164C8104F9E623B08B901269D8E391FOXDFT02FOXlo_
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
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
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
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi everyone,<o:p><=
/o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><sp=
an lang=3DEN-GB>During last week&#8217;s meeting we decided to temporarily =
create a github tree for OpenVPN. It can be found at <a href=3D"https://git=
hub.com/andj/openvpn-ssl-refactoring">https://github.com/andj/openvpn-ssl-r=
efactoring</a> . The version found there is now ready for testing, and will=
 (hopefully) be included in the 2.3 alpha versions.<o:p></o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-GB>Could interested parties please have a look=
 and provide me with feedback (through IRC/e-mail?). <o:p></o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p clas=
s=3DMsoNormal><span lang=3DEN-GB>Thanks!<o:p></o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal=
><span lang=3DEN-GB>Adriaan de Jong<o:p></o:p></span></p><p class=3DMsoNorm=
al><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-GB>PS. Note that due to limitations in PolarSSL, it is still mi=
ssing a number of features:<o:p></o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-GB style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;* PKCS#1=
2 file support<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB=
 style=3D'font-size:10.0pt'>&nbsp;* --capath support - Loading certificate =
authorities from a directory<o:p></o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;* Windows CryptoAPI support=
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font=
-size:10.0pt'>&nbsp;* Management external key support<o:p></o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt'>&nbsp;* =
X.509 alternative username fields (must be &quot;CN&quot;)<o:p></o:p></span=
></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt'><o:=
p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'f=
ont-size:10.0pt'>Plugin/Script features:<o:p></o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-GB style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0pt'>&=
nbsp;* X.509 Serial number is in hex, not decimal as with OpenSSL<o:p></o:p=
></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:10.0=
pt'>&nbsp;* X.509 subject line has a different format than the OpenSSL subj=
ect line<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=
=3D'font-size:10.0pt'>&nbsp;* X.509 certificate export does not work<o:p></=
o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'font-size:1=
0.0pt'>&nbsp;* X.509 certificate tracking<o:p></o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-GB><o:p>&nbsp;</o:p></span></p><p class=3DMsoNorma=
l><b><span lang=3DEN-US style=3D'font-size:9.0pt;font-family:"Verdana","san=
s-serif";color:navy'>Fox-IT</span></b><span lang=3DEN-US style=3D'font-size=
:9.0pt;font-family:"Verdana","sans-serif";color:navy'>&nbsp;&nbsp;&nbsp;&nb=
sp;<i>...for a more secure society</i> <o:p></o:p></span></p><p class=3DMso=
Normal><span lang=3DEN-US style=3D'font-size:8.0pt;font-family:"Verdana","s=
ans-serif";color:#1F497D'>I <a href=3D"http://www.fox-it.com/"><span style=
=3D'color:blue'>www.fox-it.com</span></a><br><br></span><span lang=3DEN-US =
style=3D'color:#1F497D'><o:p></o:p></span></p><p class=3DMsoNormal><span la=
ng=3DEN-GB><o:p>&nbsp;</o:p></span></p></div></body></html>=

--_000_1CED409804E2164C8104F9E623B08B901269D8E391FOXDFT02FOXlo_--

