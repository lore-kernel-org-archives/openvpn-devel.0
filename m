From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 8 Dec 2010 15:31:38 +0100
Message-ID: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C61@...1436...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C58@...1436...>
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C58@...1436...>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C61FOXDFT02FOXloca_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Patch] PKCS #11 Uninitialised value Fix [4/8]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_004_BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C61FOXDFT02FOXloca_
Content-Type: multipart/alternative;
	boundary="_000_BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C61FOXDFT02FOXloca_"

--_000_BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C61FOXDFT02FOXloca_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

/whistle

From: Adriaan de Jong [mailto:dejong@...1435...]
Sent: woensdag 8 december 2010 15:22
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [Patch] PKCS #11 Uninitialised value Fix [4/8]

#4 in the series: small fix for an uninitialised value



--_000_BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C61FOXDFT02FOXloca_
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
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'col=
or:#1F497D'>/whistle<o:p></o:p></span></p><p class=3DMsoNormal><span style=
=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><div style=3D'border:none;bo=
rder-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt'><div><div style=3D'bo=
rder:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p clas=
s=3DMsoNormal><b><span lang=3DEN-US style=3D'font-size:10.0pt;font-family:"=
Tahoma","sans-serif"'>From:</span></b><span lang=3DEN-US style=3D'font-size=
:10.0pt;font-family:"Tahoma","sans-serif"'> Adriaan de Jong [mailto:dejong@=
...1435...] <br><b>Sent:</b> woensdag 8 december 2010 15:22<br><b>To:</b> o=
penvpn-devel@lists.sourceforge.net<br><b>Subject:</b> [Openvpn-devel] [Patc=
h] PKCS #11 Uninitialised value Fix [4/8]<o:p></o:p></span></p></div></div>=
<p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span lang=
=3DEN-US>#4 in the series: small fix for an uninitialised value<o:p></o:p><=
/span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'color:#1F497D'><=
o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nb=
sp;</o:p></span></p></div></div></body></html>=

--_000_BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C61FOXDFT02FOXloca_--

--_004_BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C61FOXDFT02FOXloca_
Content-Type: application/x-gzip; name="04_pkcs11_fix_unitinitialised.patch.gz"
Content-Description: 04_pkcs11_fix_unitinitialised.patch.gz
Content-Disposition: attachment;
	filename="04_pkcs11_fix_unitinitialised.patch.gz"; size=335;
	creation-date="Wed, 08 Dec 2010 15:31:28 GMT";
	modification-date="Tue, 07 Dec 2010 10:04:41 GMT"
Content-Transfer-Encoding: base64

H4sICKn4/UwAA3BrY3MxMV9maXhfdW5pdGluaXRpYWxpc2VkLnBhdGNoAF2NQW+CQBCFz+yvmGqa
SAC7IAJibDCtaQ+madSezbIMhWiXze5qYn99UdLW9jIv731vZvrw/AS8YuIdNRqQzPCK9OGVKRQG
8kkc8CgZRyUPY84TjjxkoziJgmQUsyCnjI5oUuaEFHVZgqf+bIDcce37Q048zwN2922tTXWAR+RA
A/DDdBylQQwB9Sk47aDEcRzIr9oH7Nox+DSlYRr61+0sAy/wI3cCTidZRsAaHJu6sBUadZoSaIP5
er1YbWBgmh2Km9nL23JpT4nXkkaiOEqx1UKqWpgSBlI1H9K4oOtPbH687ULvVsPlQM/t1Lvfsxz3
9vmHYz0sF/NV92Ermdbn2Pq1wwLLWmABMyjZXuM/KhrOeIUtNepwgeQLuDIolJ4BAAA=

--_004_BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C61FOXDFT02FOXloca_--

