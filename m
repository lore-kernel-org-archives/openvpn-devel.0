From: =?iso-8859-2?Q?Kosztyu_Andr=E1s?= <kosztyua@...1229...>
Date: Mon, 5 Oct 2009 21:37:49 +0200
Message-ID: <002101ca45f3$536cf720$fa46e560$@hu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0022_01CA4604.16F5C720"
Content-Language: hu
Subject: [Openvpn-devel] openvpn + utf8 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0022_01CA4604.16F5C720
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

Hi,

Does openvpn support utf8 encoding (unicode?) for usernames and passwords?

I could not find anything about it, only a very old mail
(http://openvpn.net/archive/openvpn-devel/2006-04/msg00044.html)

 

I've been using 2.1 rc18 as server for months now without any trouble, but
now i got a report that special character passwords are not working. 

The authentication is done by a simple bash script. Added a line to this
script to check if it gets the passwords with wrong charset or gets it at
all (echo $username:$password:TEST >> /var/log/openvpn/test) but it shows
nothing for the password. 

 

Thanks,

Andras


------=_NextPart_000_0022_01CA4604.16F5C720
Content-Type: text/html; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-2">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DHU link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal>Does openvpn support utf8 encoding (unicode?) for user=
names
and passwords?<o:p></o:p></p>

<p class=3DMsoNormal>I could not find anything about it, only a very old ma=
il (<a
href=3D"http://openvpn.net/archive/openvpn-devel/2006-04/msg00044.html">htt=
p://openvpn.net/archive/openvpn-devel/2006-04/msg00044.html</a>)<o:p></o:p>=
</p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;ve been using 2.1 rc18 as server for months now
without any trouble, but now i got a report that special character passwords
are not working. <o:p></o:p></p>

<p class=3DMsoNormal>The authentication is done by a simple bash script. Ad=
ded a
line to this script to check if it gets the passwords with wrong charset or
gets it at all (echo $username:$password:TEST &gt;&gt; /var/log/openvpn/tes=
t)
but it shows nothing for the password. <o:p></o:p></p>

<p class=3DMsoNormal>=A0<o:p></o:p></p>

<p class=3DMsoNormal>Thanks,<o:p></o:p></p>

<p class=3DMsoNormal>Andras<o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0022_01CA4604.16F5C720--


