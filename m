From: =?iso-8859-2?Q?Kosztyu_Andr=E1s?= <kosztyua@...1229...>
Date: Tue, 23 Jun 2009 15:43:19 +0200
Message-ID: <009a01c9f408$9259bc80$b70d3580$@hu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_009B_01C9F419.55E28C80"
Content-Language: hu
Subject: [Openvpn-devel] bug? wrong CN in client-disconnect with
	username-as-common-name
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

------=_NextPart_000_009B_01C9F419.55E28C80
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

Hi,

A few days ago I've set up an openvpn server on my server with mysql backend
based on auth-user-pass-verify, client-connect, client-disconnect. Both
client-connect and client-disconnect works has a main purpuse of setting
iptables rules for forwarding each connection to a public ip, taken from an
ip_pool table. Also, each connection is registered in a table called active.
When the client disconnects, it deletes from active, deletes the iptables
rule and logs everything... 

The authentication and every record is indexed by the common name (which is
the username, not the cert name, so username-as-common-name on ).. so if i
add a row in the "active" table with client-connect and then look for it
with client-disconnect, it is based on the common name.

So, now about the problem: some of the time (about 1 every 5 disconnect) the
$common_name variable shows the cert name and not the username, thus making
it impossible to find in active table, leaving many false iptables rules and
funny logs like:

username           1245682814        80.99.12.202      79.172.201.189
10.0.0.2                CONNECT

certname            1245685700        80.99.12.202
10.0.0.2                DISCONNECT

 

Is this a bug or did i make a mistake? 

 

[asrael@...1230... openvpn]$ openvpn --version

OpenVPN 2.1_rc18 x86_64-unknown-linux-gnu [SSL] [LZO2] [EPOLL] built on Jun
21 2009

[asrael@...1230... openvpn]$ uname -a

Linux vpn1.xxx.hu 2.6.29.4-167.fc11.x86_64 #1 SMP Wed May 27 17:27:08 EDT
2009 x86_64 x86_64 x86_64 GNU/Linux 

 

Thank you,

Andras Kosztyu


------=_NextPart_000_009B_01C9F419.55E28C80
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

<p class=3DMsoNormal>A few days ago I&#8217;ve set up an openvpn server on =
my
server with mysql backend based on auth-user-pass-verify, client-connect,
client-disconnect. Both client-connect and client-disconnect works has a ma=
in
purpuse of setting iptables rules for forwarding each connection to a public
ip, taken from an ip_pool table. Also, each connection is registered in a t=
able
called active. When the client disconnects, it deletes from active, deletes=
 the
iptables rule and logs everything... <o:p></o:p></p>

<p class=3DMsoNormal>The authentication and every record is indexed by the =
common
name (which is the username, not the cert name, so <span style=3D'color:bla=
ck'>username-as-common-name
on</span> ).. so if i add a row in the &#8222;active&#8221; table with
client-connect and then look for it with client-disconnect, it is based on =
the
common name.<o:p></o:p></p>

<p class=3DMsoNormal>So, now about the problem: some of the time (about 1 e=
very 5
disconnect) the $common_name variable shows the cert name and not the usern=
ame,
thus making it impossible to find in active table, leaving many false iptab=
les
rules and funny logs like:<o:p></o:p></p>

<p class=3DMsoNormal>username=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1245682814=A0=
=A0=A0=A0=A0=A0=A0 80.99.12.202=A0=A0=A0=A0=A0 79.172.201.189=A0 =A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10.0.0.2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 CONNECT<o:p></o:p></p>

<p class=3DMsoNormal>certname=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1245685700=
=A0=A0=A0=A0=A0=A0=A0 80.99.12.202=A0=A0=A0=A0=A0  =A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10.0.0.2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 DISCONNECT<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Is this a bug or did i make a mistake? <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>[asrael@...1230... openvpn]$ openvpn --version<o:p></o=
:p></p>

<p class=3DMsoNormal>OpenVPN 2.1_rc18 x86_64-unknown-linux-gnu [SSL] [LZO2]
[EPOLL] built on Jun 21 2009<o:p></o:p></p>

<p class=3DMsoNormal>[asrael@...1230... openvpn]$ uname -a<o:p></o:p></p>

<p class=3DMsoNormal>Linux vpn1.xxx.hu 2.6.29.4-167.fc11.x86_64 #1 SMP Wed =
May 27
17:27:08 EDT 2009 x86_64 x86_64 x86_64 GNU/Linux <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thank you,<o:p></o:p></p>

<p class=3DMsoNormal>Andras Kosztyu<o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_009B_01C9F419.55E28C80--


