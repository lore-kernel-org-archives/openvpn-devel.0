From: Kuhr Stefan <S.Kuhr@...2139...>
Date: Fri, 25 Aug 2017 12:01:11 +0000
Message-ID: <9D542DA272786745B160AD8534D3D3F66CA88A57@...2140...>
Content-Language: de-DE
Content-Type: multipart/alternative;
 boundary="_000_9D542DA272786745B160AD8534D3D3F66CA88A57MBX1Srv_"
MIME-Version: 1.0
Subject: [Openvpn-devel] State of OpenVPN3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_9D542DA272786745B160AD8534D3D3F66CA88A57MBX1Srv_
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

we are currently using the Windows openvpn client version 2.3.11 with our p=
roduct. Our product uses the TAP adapter functionality and relies on the in=
teroperation between openvpn.exe and the windows certificate store, as we u=
se Smartcards for client authentication.

I just discovered the OpenVPN3 project on GitHub and it looks like an ideal=
 solution to me that allows better integration of openvpn in the collateral=
 software stack that we ship as part of our product than the out-of-process=
 approach we currently use with openvpn.exe.

So what is the state of openvpn3, does it work with TAP adapters or is it T=
UN-only? Does it have integration with the windows certificate store? Is it=
 on-par with the 2.x development branch and under active development? It wo=
uldn't make sense for us to use OpenVPN3 if it lags behind the 2.x versions=
 with respect to security fixes for instance. There still doesn't seem to b=
e a stable/release branch for the OpenVPN3 project on GitHub, so is OpenVPN=
3 ready for prime-time with respect to client functionality or is this some=
 sort of alpha or beta status software?

Any help appreciated,

i.A. Stefan Kuhr

Software-Entwicklungsingenieur

Hardware Entwicklung
Hardware Development

ads-tec GmbH
Heinrich-Hertz-Str. 1
72622 N=FCrtingen
Germany

Tel.:    +49 7022 2522-2427
Fax:    +49 7022 2522-405
E-Mail: s.kuhr@...2139...
Web:    www.ads-tec.de

_______________________________________________
ads-tec GmbH
Sitz: 72622 N=FCrtingen
Registergericht Stuttgart HRB 224527

Geschaeftsfuehrer:
Dipl.-Ing. Thomas Speidel
_______________________________________________
Diese E-Mail enthaelt vertrauliche und/oder rechtlich
geschuetzte Informationen. Wenn Sie nicht der richtige
Adressat sind oder diese E-Mail irrtuemlich erhalten
haben, informieren Sie bitte sofort den Absender und=20
vernichten Sie diese E-Mail. Das unerlaubte Kopieren,
jegliche anderweitige Verwendung sowie die unbefugte
Weitergabe dieser Mail sind nicht gestattet.
_______________________________________________

This e-mail may contain confidential and/or privileged
information. If you are not the intended recipient (or have
received this e-mail in error) please notify the sender
immediately and destroy this e-mail. Any unauthorized
copying, disclosure, distribution or other use of the
material or parts thereof are strictly forbidden.
_______________________________________________

--_000_9D542DA272786745B160AD8534D3D3F66CA88A57MBX1Srv_
MIME-Version: 1.0
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
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
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello everyone,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">we are currently using the Windows openvpn client ve=
rsion 2.3.11 with our product. Our product uses the TAP adapter functionali=
ty and relies on the interoperation between openvpn.exe and the windows cer=
tificate store, as we use Smartcards
 for client authentication. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I just discovered the OpenVPN3 project on GitHub and=
 it looks like an ideal solution to me that allows better integration of op=
envpn in the collateral software stack that we ship as part of our product =
than the out-of-process approach we
 currently use with openvpn.exe.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So what is the state of openvpn3, does it work with =
TAP adapters or is it TUN-only? Does it have integration with the windows c=
ertificate store? Is it on-par with the 2.x development branch and under ac=
tive development? It wouldn&#8217;t make
 sense for us to use OpenVPN3 if it lags behind the 2.x versions with respe=
ct to security fixes for instance. There still doesn&#8217;t seem to be a s=
table/release branch for the OpenVPN3 project on GitHub, so is OpenVPN3 rea=
dy for prime-time with respect to client
 functionality or is this some sort of alpha or beta status software?<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any help appreciated,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">i.A. Stefan Kuhr<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE"><o:p>&nbsp;</o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">Software-Entwickl=
ungsingenieur
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE"><o:p>&nbsp;</o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">Hardware Entwickl=
ung
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">Hardware Developm=
ent<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE"><o:p>&nbsp;</o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">ads-tec GmbH<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">Heinrich-Hertz-St=
r. 1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">72622 N=FCrtingen=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">Germany&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE"><o:p>&nbsp;</o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">Tel.:&nbsp;&nbsp;=
&nbsp; &#43;49 7022 2522-2427<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">Fax:&nbsp;&nbsp;&=
nbsp; &#43;49 7022 2522-405<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">E-Mail: s.kuhr@...1186...=
.2139...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;mso-fareast-language:DE">Web:&nbsp;&nbsp;&=
nbsp; www.ads-tec.de<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p>_______________________________________________<br>
ads-tec GmbH<br>
Sitz: 72622 N=FCrtingen<br>
Registergericht Stuttgart HRB 224527</p>

<p>Geschaeftsfuehrer:<br>
Dipl.-Ing. Thomas Speidel<br>
_______________________________________________<br>
Diese E-Mail enthaelt vertrauliche und/oder rechtlich<br>
geschuetzte Informationen. Wenn Sie nicht der richtige<br>
Adressat sind oder diese E-Mail irrtuemlich erhalten<br>
haben, informieren Sie bitte sofort den Absender und <br>
vernichten Sie diese E-Mail. Das unerlaubte Kopieren,<br>
jegliche anderweitige Verwendung sowie die unbefugte<br>
Weitergabe dieser Mail sind nicht gestattet.<br>
_______________________________________________</p>

<p>This e-mail may contain confidential and/or privileged<br>
information. If you are not the intended recipient (or have<br>
received this e-mail in error) please notify the sender<br>
immediately and destroy this e-mail. Any unauthorized<br>
copying, disclosure, distribution or other use of the<br>
material or parts thereof are strictly forbidden.<br>
_______________________________________________</p></body>
</html>

--_000_9D542DA272786745B160AD8534D3D3F66CA88A57MBX1Srv_--


