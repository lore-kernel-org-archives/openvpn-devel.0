Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA2C25.36702293"
Date: Wed, 2 Sep 2009 16:29:26 -0700
Message-ID: <1C795E2FCD154E46979DDDD5374B5ABE024D96F6@...1261...>
From: "John Cullison" <jcullison@...1260...>
Subject: Re: [Openvpn-devel] Losing connectivity when OpenVPN cannot
	establish tunnel under Windows
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

------_=_NextPart_001_01CA2C25.36702293
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

We are using OpenVPN to build up and tear down connections on-the-fly in
a service of our own.  In particular, we have certain routers which are
running a Debian distribution on one end, and client side, the users are
running Windows, where our service runs (not only do we need to be able
to run OpenVPN instances, but we also have to manipulate the routing
tables, so we need administrative access, which is why we use a service,
as not all of our users run with admin privileges).

=20

With OpenVPN 2.0.9, I was noticing on my Vista dev system that
occasionally I'd lose all Internet access - access to anything outside
my own subnet.  I was able to pin this down to the use of OpenVPN
causing some problems when I would attempt to open a tunnel to a router
for which I had already recently opened and closed a tunnel.  Or so I
thought.

=20

I switched to 2.1_rc19 to see if the problem had been addressed, and it
seemingly had.  I noticed today, however, that I had lost Internet
connectivity once more upon attempting to create a tunnel - only this
time (or perhaps, I was looking more closely this time?) it was when I
was attempting to create a tunnel to a router that was not online.
Ipconfig /renew restores the network, and sure enough, attempting to
establish that tunnel again, when nothing is on the other side, is
causing my networking to die the second time I attempt to establish the
tunnel.  Windows seems to be forgetting about its default gateway or
something, as I can't go anywhere outside the local subnet.  I've also
tested our program on Windows XP installation (separate computer
entirely) and the same problem occurred: second attempt to establish
OpenVPN tunnel to a non-existent router results in loss of connectivity
beyond the local subnet.

=20

Has anyone heard of anything like this?

=20

As I'm a complete newb when it comes to the OpenVPN source, does anyone
have any suggestions for where I might start looking to address this?

=20

OpenVPN output:

=20

Wed Sep 02 13:57:48 2009 OpenVPN 2.1_rc19 i686-pc-mingw32 [SSL] [LZO2]
[PKCS11] built on Jul 16 2009

Wed Sep 02 13:57:48 2009 WARNING: No server certificate verification
method has been enabled.  See http://openvpn.net/howto.html#mitm for
more info.

Wed Sep 02 13:57:48 2009 NOTE: OpenVPN 2.1 requires '--script-security
2' or higher to call user-defined scripts or executables

Wed Sep 02 13:57:48 2009 Control Channel MTU parms [ L:1541 D:138 EF:38
EB:0 ET:0 EL:0 ]

Wed Sep 02 13:57:48 2009 Data Channel MTU parms [ L:1541 D:1450 EF:41
EB:4 ET:0 EL:0 ]

Wed Sep 02 13:57:48 2009 Local Options hash (VER=3DV4): '3514370b'

Wed Sep 02 13:57:48 2009 Expected Remote Options hash (VER=3DV4):
'239669a8'

Wed Sep 02 13:57:48 2009 Socket Buffers: R=3D[8192->8192] S=3D[8192->8192]

Wed Sep 02 13:57:48 2009 UDPv4 link local: [undef]

Wed Sep 02 13:57:48 2009 UDPv4 link remote: 192.168.1.49:15003

Wed Sep 02 13:58:14 2009 TCP/UDP: Closing socket

Wed Sep 02 13:58:14 2009 SIGTERM[hard,] received, process exiting

=20

Wed Sep 02 13:58:35 2009 OpenVPN 2.1_rc19 i686-pc-mingw32 [SSL] [LZO2]
[PKCS11] built on Jul 16 2009

Wed Sep 02 13:58:35 2009 WARNING: No server certificate verification
method has been enabled.  See http://openvpn.net/howto.html#mitm for
more info.

Wed Sep 02 13:58:35 2009 NOTE: OpenVPN 2.1 requires '--script-security
2' or higher to call user-defined scripts or executables

Wed Sep 02 13:58:35 2009 Control Channel MTU parms [ L:1541 D:138 EF:38
EB:0 ET:0 EL:0 ]

Wed Sep 02 13:58:35 2009 Data Channel MTU parms [ L:1541 D:1450 EF:41
EB:4 ET:0 EL:0 ]

Wed Sep 02 13:58:35 2009 Local Options hash (VER=3DV4): '3514370b'

Wed Sep 02 13:58:35 2009 Expected Remote Options hash (VER=3DV4):
'239669a8'

Wed Sep 02 13:58:35 2009 Socket Buffers: R=3D[8192->8192] S=3D[8192->8192]

Wed Sep 02 13:58:35 2009 UDPv4 link local: [undef]

Wed Sep 02 13:58:35 2009 UDPv4 link remote: 192.168.1.49:15003

Wed Sep 02 13:59:01 2009 TCP/UDP: Closing socket

Wed Sep 02 13:59:01 2009 SIGTERM[hard,] received, process exiting

=20

After this 2nd attempt, just prior to the penultimate line, my IM
software lost connection (the first obvious symptom).  Takes a /renew to
bring it back up.

=20

The arguments I am passing to OpenVPN are:

=20

--client --dev tun --proto udp --pull --resolv-retry infinite --nobind
--persist-key --persist-tun --tun-mtu 1500 --verb 3 --keepalive 10 120
--mute 20 --float --remote 192.168.1.49 15003 --ca
"C:\Users\jcullison\AppData\Local\Temp\tmp3F43.tmp" --cert
"C:\Users\jcullison\AppData\Local\Temp\tmp3F42.tmp" --key
"C:\Users\jcullison\AppData\Local\Temp\tmp3F31.tmp"

=20

(The names of the certificate files change each time.)

=20

Since there is no instance of OpenVPN running on the target router at
.49, I don't believe its command line, if it were running, matters.

=20

Regards,
John Cullison
Software Engineer

Industrial Defender - Cyber Risk Protection
<http://www.industrialdefender.com/>=20=20

jcullison@...1260...
425-951-3567
FAX: 425-487-2288

Industrial Defender, Inc.
21312 30th Drive SE, Suite 102=20
Bothell, Washington USA 98021 21312=20

(c)Copyright 2009 Industrial Defender Inc. owns copyright content of
this document and all attachments unless otherwise indicated. All rights
reserved. Users of Industrial Defender Inc. software and tools
associated with the software such as sales & marketing collateral,
presentations, user manuals, training documentation etc. may not
republish nor reproduce in whole or in part the information, in any form
or by any means, in any manner whatsoever without the prior written
permission of Industrial Defender Inc., and any such unauthorized use
constitutes copyright infringement. An acknowledgment of the source must
be included whenever Industrial Defender Inc. material is copied or
published. If you require further information on a permitted use or
license to reproduce or republish any material, address your inquiry to
Industrial Defender Inc. 16 Chestnut Street, Suite 300, Foxborough,
Massachusetts, 02035. Any infringement of Industrial Defender Inc.
rights will result in appropriate legal action. Industrial Defender Inc.
disclaims any and all liability for any consequences which may result
from any unauthorized reproduction or use of this Work whatsoever.
www.industrialdefender.com <http://www.industrialdefender.com/>=20=20

=20

=20


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email=20
______________________________________________________________________=

------_=_NextPart_001_01CA2C25.36702293
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:p=3D"urn:schemas-m=
icrosoft-com:office:powerpoint" xmlns:a=3D"urn:schemas-microsoft-com:office=
:access" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:s=3D"=
uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:rs=3D"urn:schemas-microsof=
t-com:rowset" xmlns:z=3D"#RowsetSchema" xmlns:b=3D"urn:schemas-microsoft-co=
m:office:publisher" xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadshee=
t" xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" xmlns=
:odc=3D"urn:schemas-microsoft-com:office:odc" xmlns:oa=3D"urn:schemas-micro=
soft-com:office:activation" xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:rtc=3D"http://m=
icrosoft.com/officenet/conferencing" xmlns:D=3D"DAV:" xmlns:Repl=3D"http://=
schemas.microsoft.com/repl/" xmlns:mt=3D"http://schemas.microsoft.com/share=
point/soap/meetings/" xmlns:x2=3D"http://schemas.microsoft.com/office/excel=
/2003/xml" xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" xmlns:ois=
=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" xmlns:dir=3D"http://=
schemas.microsoft.com/sharepoint/soap/directory/" xmlns:ds=3D"http://www.w3=
.org/2000/09/xmldsig#" xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint=
/dsp" xmlns:udc=3D"http://schemas.microsoft.com/data/udc" xmlns:xsd=3D"http=
://www.w3.org/2001/XMLSchema" xmlns:sub=3D"http://schemas.microsoft.com/sha=
repoint/soap/2002/1/alerts/" xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#"=
 xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" xmlns:sps=3D"http://=
schemas.microsoft.com/sharepoint/soap/" xmlns:xsi=3D"http://www.w3.org/2001=
/XMLSchema-instance" xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/so=
ap" xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" xmlns:udc=
p2p=3D"http://schemas.microsoft.com/data/udc/parttopart" xmlns:wf=3D"http:/=
/schemas.microsoft.com/sharepoint/soap/workflow/" xmlns:dsss=3D"http://sche=
mas.microsoft.com/office/2006/digsig-setup" xmlns:dssi=3D"http://schemas.mi=
crosoft.com/office/2006/digsig" xmlns:mdssi=3D"http://schemas.openxmlformat=
s.org/package/2006/digital-signature" xmlns:mver=3D"http://schemas.openxmlf=
ormats.org/markup-compatibility/2006" xmlns:m=3D"http://schemas.microsoft.c=
om/office/2004/12/omml" xmlns:mrels=3D"http://schemas.openxmlformats.org/pa=
ckage/2006/relationships" xmlns:spwp=3D"http://microsoft.com/sharepoint/web=
partpages" xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/20=
06/types" xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/200=
6/messages" xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/Sli=
deLibrary/" xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortal=
Server/PublishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" xmlns:=
st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
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
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>We are using OpenVPN to build up and tear down connect=
ions
on-the-fly in a service of our own.&nbsp; In particular, we have certain
routers which are running a Debian distribution on one end, and client side,
the users are running Windows, where our service runs (not only do we need =
to
be able to run OpenVPN instances, but we also have to manipulate the routing
tables, so we need administrative access, which is why we use a service, as=
 not
all of our users run with admin privileges).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>With OpenVPN 2.0.9, I was noticing on my Vista dev sys=
tem
that occasionally I&#8217;d lose all Internet access &#8211; access to anyt=
hing outside my
own subnet.&nbsp; I was able to pin this down to the use of OpenVPN causing
some problems when I would attempt to open a tunnel to a router for which I=
 had
already recently opened and closed a tunnel.&nbsp; Or so I thought.<o:p></o=
:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I switched to 2.1_rc19 to see if the problem had been
addressed, and it seemingly had.&nbsp; I noticed today, however, that I had
lost Internet connectivity once more upon attempting to create a tunnel &#8=
211; only
this time (or perhaps, I was looking more closely this time?) it was when I=
 was
attempting to create a tunnel to a router that was not online. &nbsp;Ipconf=
ig
/renew restores the network, and sure enough, attempting to establish that
tunnel again, when nothing is on the other side, is causing my networking to
die the second time I attempt to establish the tunnel.&nbsp; Windows seems =
to
be forgetting about its default gateway or something, as I can&#8217;t go a=
nywhere
outside the local subnet.&nbsp; I&#8217;ve also tested our program on Windo=
ws XP
installation (separate computer entirely) and the same problem occurred: se=
cond
attempt to establish OpenVPN tunnel to a non-existent router results in los=
s of
connectivity beyond the local subnet.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Has anyone heard of anything like this?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>As I&#8217;m a complete newb when it comes to the Open=
VPN source,
does anyone have any suggestions for where I might start looking to address
this?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>OpenVPN output:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 OpenVPN 2.1_rc19 i686-pc-ming=
w32
[SSL] [LZO2] [PKCS11] built on Jul 16 2009<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 WARNING: No server certificate
verification method has been enabled.&nbsp; See
http://openvpn.net/howto.html#mitm for more info.<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 NOTE: OpenVPN 2.1 requires
'--script-security 2' or higher to call user-defined scripts or executables=
<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 Control Channel MTU parms [ L=
:1541
D:138 EF:38 EB:0 ET:0 EL:0 ]<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 Data Channel MTU parms [ L:15=
41
D:1450 EF:41 EB:4 ET:0 EL:0 ]<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 Local Options hash (VER=3DV4):
'3514370b'<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 Expected Remote Options hash
(VER=3DV4): '239669a8'<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 Socket Buffers: R=3D[8192-&gt=
;8192]
S=3D[8192-&gt;8192]<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 UDPv4 link local: [undef]<o:p=
></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:57:48 2009 UDPv4 link remote:
192.168.1.49:15003<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:14 2009 TCP/UDP: Closing socket<o:p><=
/o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:14 2009 SIGTERM[hard,] received, proc=
ess
exiting<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 OpenVPN 2.1_rc19 i686-pc-ming=
w32
[SSL] [LZO2] [PKCS11] built on Jul 16 2009<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 WARNING: No server certificate
verification method has been enabled.&nbsp; See
http://openvpn.net/howto.html#mitm for more info.<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 NOTE: OpenVPN 2.1 requires
'--script-security 2' or higher to call user-defined scripts or executables=
<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 Control Channel MTU parms [ L=
:1541
D:138 EF:38 EB:0 ET:0 EL:0 ]<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 Data Channel MTU parms [ L:15=
41
D:1450 EF:41 EB:4 ET:0 EL:0 ]<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 Local Options hash (VER=3DV4):
'3514370b'<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 Expected Remote Options hash
(VER=3DV4): '239669a8'<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 Socket Buffers: R=3D[8192-&gt=
;8192]
S=3D[8192-&gt;8192]<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 UDPv4 link local: [undef]<o:p=
></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:58:35 2009 UDPv4 link remote:
192.168.1.49:15003<o:p></o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:59:01 2009 TCP/UDP: Closing socket<o:p><=
/o:p></p>

<p class=3DMsoNormal>Wed Sep 02 13:59:01 2009 SIGTERM[hard,] received, proc=
ess
exiting<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>After this 2<sup>nd</sup> attempt, just prior to the
penultimate line, my IM software lost connection (the first obvious
symptom).&nbsp; Takes a /renew to bring it back up.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The arguments I am passing to OpenVPN are:<o:p></o:p><=
/p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>--client --dev tun --proto udp --pull --resolv-retry
infinite --nobind --persist-key --persist-tun --tun-mtu 1500 --verb 3
--keepalive 10 120 --mute 20 --float --remote 192.168.1.49 15003 --ca
&quot;C:\Users\jcullison\AppData\Local\Temp\tmp3F43.tmp&quot; --cert
&quot;C:\Users\jcullison\AppData\Local\Temp\tmp3F42.tmp&quot; --key
&quot;C:\Users\jcullison\AppData\Local\Temp\tmp3F31.tmp&quot;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>(The names of the certificate files change each time.)=
<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Since there is no instance of OpenVPN running on the t=
arget
router at .49, I don&#8217;t believe its command line, if it were running, =
matters.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<table class=3DMsoNormalTable border=3D0 cellspacing=3D7 cellpadding=3D0 wi=
dth=3D600
 style=3D'width:6.25in;background:white'>
 <tr>
  <td width=3D"45%" style=3D'width:45.0%;padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-family:"Arial","=
sans-serif"'>Regards,<br>
  John Cullison<br>
  Software Engineer<o:p></o:p></span></p>
  </td>
  <td style=3D'padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><span style=3D'font-family:"Arial","sans-serif"'><a
  href=3D"http://www.industrialdefender.com/">Industrial Defender - Cyber R=
isk
  Protection</a> <o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=3D"45%" style=3D'width:45.0%;padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-family:"Arial","=
sans-serif"'>jcullison@...1260...<br>
  425-951-3567<br>
  FAX: 425-487-2288<o:p></o:p></span></p>
  </td>
  <td style=3D'padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-family:"Arial","=
sans-serif"'>Industrial
  Defender, Inc.<br>
  21312 30th Drive SE, Suite 102 <br>
  Bothell, Washington USA 98021 21312 <o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td colspan=3D2 style=3D'padding:0in 0in 0in 0in'>
  <p class=3DMsoNormal><span style=3D'font-size:6.0pt;font-family:"Arial","=
sans-serif"'>&copy;Copyright
  2009 Industrial Defender Inc. owns copyright content of this document and=
 all
  attachments unless otherwise indicated. All rights reserved. Users of
  Industrial Defender Inc. software and tools associated with the software =
such
  as sales &amp; marketing collateral, presentations, user manuals, training
  documentation etc. may not republish nor reproduce in whole or in part the
  information, in any form or by any means, in any manner whatsoever without
  the prior written permission of Industrial Defender Inc., and any such
  unauthorized use constitutes copyright infringement. An acknowledgment of=
 the
  source must be included whenever Industrial Defender Inc. material is cop=
ied
  or published. If you require further information on a permitted use or
  license to reproduce or republish any material, address your inquiry to
  Industrial Defender Inc. 16 Chestnut Street, Suite 300, Foxborough,
  Massachusetts, 02035. Any infringement of Industrial Defender Inc. rights
  will result in appropriate legal action. Industrial Defender Inc. disclai=
ms
  any and all liability for any consequences which may result from any
  unauthorized reproduction or use of this Work whatsoever. <a
  href=3D"http://www.industrialdefender.com/" target=3D"_blank">www.industr=
ialdefender.com</a>
  <o:p></o:p></span></p>
  </td>
 </tr>
</table>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>


<BR>
______________________________________________________________________<BR>
This email has been scanned by the MessageLabs Email Security System.<BR>
For more information please visit http://www.messagelabs.com/email <BR>
______________________________________________________________________<BR>
</body>

</html>

------_=_NextPart_001_01CA2C25.36702293--

