Content-Type: multipart/mixed; boundary="===============0625606467546621333=="
MIME-Version: 1.0
From: Kuhr Stefan <S.Kuhr@...2139...>
Date: Wed, 18 May 2016 09:05:11 +0000
Message-ID: <9D542DA272786745B160AD8534D3D3F641BCF060@...2140...>
MIME-Version: 1.0
Subject: [Openvpn-devel] New NDIS6 drivers in 2.3.11?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--===============0625606467546621333==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_9D542DA272786745B160AD8534D3D3F641BCF060MBX1Srv_"

--_000_9D542DA272786745B160AD8534D3D3F641BCF060MBX1Srv_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I have posted a question in the "Community Project Server Administration In=
stallation Help" forum about the updated ndis6 drivers in openvpn 2.3.11 fo=
r windows. I was advised to subscribe to the developer mailing list and ask=
 there again, so here goes my inquiry from https://forums.openvpn.net/viewt=
opic.php?f=3D5&t=3D21728:


I noticed, that the NDIS6 drivers in the Windows Port of OpenVPN 2.3.11 (re=
leased this week) have been silently updated without notice in the changelo=
g, albeit with the same driver version. It seems to me like there is now an=
other signature on the driver package using the sha256 digest that has been=
 created using an ev certificate. Is there anything else that has changed i=
n the drivers except for the things I have observed? If there is no other c=
hange, what was the reasoning for the driver update? The older drivers from=
 2.3.10 have been timestamped way before the release of Windows 10, so the =
new requirement for ev certificates for drivers in windows 10 cannot be the=
 reason, they will continue to run fine, because timestamping occurred befo=
re the ship date of windows 10. At least this is my understanding of the ne=
w ev cert enforcement in windows 10: If created before windows 10 rtm ship =
date, drivers will work.

Any official comment from the openvpn dev team?

Kind regards,

--
Stefan Kuhr


--_000_9D542DA272786745B160AD8534D3D3F641BCF060MBX1Srv_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
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
<p class=3D"MsoNormal">Hello everyone, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have posted a question in the &quot;Community Proj=
ect Server Administration Installation Help&quot; forum about the updated n=
dis6 drivers in openvpn 2.3.11 for windows. I was advised to subscribe to t=
he developer mailing list and ask there again,
 so here goes my inquiry from https://forums.openvpn.net/viewtopic.php?f=3D=
5&amp;t=3D21728:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I noticed, that the NDIS6 drivers in the Windows Por=
t of OpenVPN 2.3.11 (released this week) have been silently updated without=
 notice in the changelog, albeit with the same driver version. It seems to =
me like there is now another signature
 on the driver package using the sha256 digest that has been created using =
an ev certificate. Is there anything else that has changed in the drivers e=
xcept for the things I have observed? If there is no other change, what was=
 the reasoning for the driver update?
 The older drivers from 2.3.10 have been timestamped way before the release=
 of Windows 10, so the new requirement for ev certificates for drivers in w=
indows 10 cannot be the reason, they will continue to run fine, because tim=
estamping occurred before the ship
 date of windows 10. At least this is my understanding of the new ev cert e=
nforcement in windows 10: If created before windows 10 rtm ship date, drive=
rs will work.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any official comment from the openvpn dev team?<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Kind regards,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">Stefan Kuhr<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_9D542DA272786745B160AD8534D3D3F641BCF060MBX1Srv_--

--===============0625606467546621333==
Content-Type: multipart/alternative;
	boundary="===============5723913023958902440=="
MIME-Version: 1.0
Content-Disposition: inline

--===============5723913023958902440==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

_______________________________________________
ads-tec GmbH
Sitz: 72622 N=C3=BCrtingen
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
_______________________________________________=

--===============5723913023958902440==
MIME-Version: 1.0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>_______________________________________________<br>
ads-tec GmbH<br>
Sitz: 72622 N=C3=BCrtingen<br>
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
_______________________________________________</p>=

--===============5723913023958902440==--

--===============0625606467546621333==--

