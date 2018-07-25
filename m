From: Kevin Kane <kkane@...2393...>
Date: Wed, 25 Jul 2018 17:01:37 +0000
Message-ID: <BL0PR2101MB1058B54974E36CD4C13895D8AB540@...2440...>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB1058B54974E36CD4C13895D8AB540BL0PR2101MB1058_"
MIME-Version: 1.0
Subject: [Openvpn-devel] Incoming: patches for the dialer feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--_000_BL0PR2101MB1058B54974E36CD4C13895D8AB540BL0PR2101MB1058_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok, I've gotten clearance to contribute the dialer feature from Microsoft's=
 OpenVPN fork back upstream. As previously discussed, this feature isn't pr=
oduction-ready because the integration I did was quick and dirty - it mainl=
y just sends commands to a running OpenVPN-GUI process in the same way as t=
he context menu already does, with some fragile logic to locate the running=
 OpenVPN process.

That being said, the spelunking I did to hook up the plumbing with the Wind=
ows shell may prove useful in the future for something more fleshed out, an=
d so I'm offering this up in case you'd all like to do something more invol=
ved with it.

Since all these patches should be applied across the three repos all at onc=
e, I'm sending all of them to this list in separate e-mail instead of doing=
 pull requests for projects that allow that.

--_000_BL0PR2101MB1058B54974E36CD4C13895D8AB540BL0PR2101MB1058_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Ok, I&#8217;ve gotten clearance to contribute the di=
aler feature from Microsoft&#8217;s OpenVPN fork back upstream. As previous=
ly discussed, this feature isn&#8217;t production-ready because the integra=
tion I did was quick and dirty &#8211; it mainly just sends
 commands to a running OpenVPN-GUI process in the same way as the context m=
enu already does, with some fragile logic to locate the running OpenVPN pro=
cess.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">That being said, the spelunking I did to hook up the=
 plumbing with the Windows shell may prove useful in the future for somethi=
ng more fleshed out, and so I&#8217;m offering this up in case you&#8217;d =
all like to do something more involved with it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Since all these patches should be applied across the=
 three repos all at once, I&#8217;m sending all of them to this list in sep=
arate e-mail instead of doing pull requests for projects that allow that.<o=
:p></o:p></p>
</div>
</body>
</html>

--_000_BL0PR2101MB1058B54974E36CD4C13895D8AB540BL0PR2101MB1058_--

