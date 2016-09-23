From: "Vossi, Totti" <totti.vossi@...2164...>
Date: Fri, 23 Sep 2016 08:41:18 +0000
Message-ID: <d13137ad6aa449baacb323f88d1c1542@...2168...>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_d13137ad6aa449baacb323f88d1c1542helex02FIFSecurecom_"
MIME-Version: 1.0
Subject: [Openvpn-devel] About Microsoft DirectAccess and OpenVPN
	concurrency problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_d13137ad6aa449baacb323f88d1c1542helex02FIFSecurecom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

in our VPN product for Windows we have logic which monitors for changes in =
active "normal" network interface and restarts OpenVPN in case IP changes i=
n existing interfaces or new ones are added while VPN is on. Restart is don=
e because otherwise those updated interfaces would bypass the VPN. Also we =
are trying to ignore all virtual, loopback and P2P interfaces. This seems a=
 bit brittle solution. Latest problems are caused by Microsoft DirectAccess=
 interface which we didn't have in the ignore list and its IP seems to chan=
ge always when VPN is enabled causing loop like -> enable VPN -> get Direct=
Access (IPHTTPS) IP change -> stop VPN -> enable VPN -> get get DirectAcces=
s (IPHTTPS) IP change -> etc.

I am new developer in this area but I heard from previous guys involved in =
the project that it might be better to have solution at OpenVPN side. Is th=
ere already some work done or being done for handling this "updated interfa=
ces bypass VPN" problem?

BR,
Totti Vossi

--_000_d13137ad6aa449baacb323f88d1c1542helex02FIFSecurecom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 2.0cm 70.85pt 2.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"FI" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">in our VPN product for Windows =
we have logic which monitors for changes in active &#8220;normal&#8221; net=
work interface and restarts OpenVPN in case IP changes in existing interfac=
es or new ones are added while VPN is on. Restart
 is done because otherwise those updated interfaces would bypass the VPN. A=
lso we are trying to ignore all virtual, loopback and P2P interfaces. This =
seems a bit brittle solution. Latest problems are caused by Microsoft Direc=
tAccess interface which we didn&#8217;t
 have in the ignore list and its IP seems to change always when VPN is enab=
led causing loop like -&gt; enable VPN -&gt; get DirectAccess (IPHTTPS) IP =
change -&gt; stop VPN -&gt; enable VPN -&gt; get get DirectAccess (IPHTTPS)=
 IP change -&gt; etc.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am new developer in this area=
 but I heard from previous guys involved in the project that it might be be=
tter to have solution at OpenVPN side. Is there already some work done or b=
eing done for handling this &#8220;updated
 interfaces bypass VPN&#8221; problem? <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">BR,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Totti Vossi<o:p></o:p></span></=
p>
</div>
</body>
</html>

--_000_d13137ad6aa449baacb323f88d1c1542helex02FIFSecurecom_--

