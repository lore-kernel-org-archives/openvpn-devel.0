From: "Morris, Russell" <rmorris@...1315...>
Date: Thu, 17 Sep 2015 17:41:48 +0000
Message-ID: <SN1PR08MB1391F3211A76023391BBB5FFB95A0@...2065...>
References: <SN1PR08MB13914E4EC23A602C38DBBA94B95A0@...2065...>
	<55FAEE58.9020202@...1400...>
	<SN1PR08MB13910492A84C58EFEBC8F662B95A0@...2065...>
	<55FAF40C.7050108@...1227...>
In-Reply-To: <55FAF40C.7050108@...1227...>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR08MB1391F3211A76023391BBB5FFB95A0SN1PR08MB1391namp_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Hold Release / Proxy Sequence
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_SN1PR08MB1391F3211A76023391BBB5FFB95A0SN1PR08MB1391namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Will dig into this one further ... :). I admit, lots of options (a good thi=
ng!), I wasn't aware of this one (and with a brief look, a bit confused yet=
, but I'll dig).

Thanks!!!

... Russell



From: Arne Schwabe [mailto:arne@...1227...]
Sent: Thursday, September 17, 2015 12:11 PM
To: Morris, Russell <rmorris@...1315...>; openvpn-devel@...1223...=
et
Subject: Re: [Openvpn-devel] Hold Release / Proxy Sequence


Am 17.09.15 um 17:52 schrieb Morris, Russell:
Hi,

Nope ... :). I don't want to - only because the proxy changes, depending wi=
n where I am. So I detect and set it (i.e. it's dynamic), but if I'm too sl=
ow ... :(.


Either you do managment-query-proxy or you set http-proxy in your config fi=
le. Even applications using the management interface do it this way. manage=
ment-query-proxy is designed exactly for your usecase.

Arne

--_000_SN1PR08MB1391F3211A76023391BBB5FFB95A0SN1PR08MB1391namp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:1.0pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Will dig into this one further &#8230;
</span><span style=3D"font-size:11.0pt;font-family:Wingdings;color:#1F497D"=
>J</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sa=
ns-serif;color:#1F497D">. I admit, lots of options (a good thing!), I wasn&=
#8217;t aware of this one (and with a brief look, a
 bit confused yet, but I&#8217;ll dig).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Thanks!!!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">&#8230; Russell<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">From=
:</span></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif;color:windowtext"> Arne Schwabe [mailto:arne@...1227...]
<br>
<b>Sent:</b> Thursday, September 17, 2015 12:11 PM<br>
<b>To:</b> Morris, Russell &lt;rmorris@...1315...&gt;; openvpn-devel@...1199...=
sourceforge.net<br>
<b>Subject:</b> Re: [Openvpn-devel] Hold Release / Proxy Sequence<o:p></o:p=
></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0in;margin-right:0in;mar=
gin-bottom:12.0pt;margin-left:.5in">
<o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Am 17.09.15 um 17:52 schr=
ieb Morris, Russell:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Hi,</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">&nbsp;</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Nope &#823=
0;
</span><span style=3D"font-size:11.0pt;font-family:Wingdings;color:#1F497D"=
>J</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sa=
ns-serif;color:#1F497D">. I don&#8217;t want to &#8211; only because the pr=
oxy changes, depending win where I am. So I detect and set
 it (i.e. it&#8217;s dynamic), but if I&#8217;m too slow &#8230; </span><sp=
an style=3D"font-size:11.0pt;font-family:Wingdings;color:#1F497D">L</span><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:#1F497D">.</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">&nbsp;</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Either you do managment-q=
uery-proxy or you set http-proxy in your config file. Even applications usi=
ng the management interface do it this way. management-query-proxy is desig=
ned exactly for your usecase.<br>
<br>
Arne<o:p></o:p></p>
</div>
</body>
</html>

--_000_SN1PR08MB1391F3211A76023391BBB5FFB95A0SN1PR08MB1391namp_--

