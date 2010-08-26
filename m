MIME-Version: 1.0
Date: Thu, 26 Aug 2010 10:56:56 -0700
Message-ID: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
From: Ansis Atteka <ansisatteka.dev@...277...>
Content-Type: multipart/alternative; boundary=000e0cd32f2456f151048ebdb90f
Subject: [Openvpn-devel] My results of OpenVPN Benchmarking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000e0cd32f2456f151048ebdb90f
Content-Type: text/plain; charset=ISO-8859-1

Hello

I have done some benchmarking of OpenVPN and wanted to share my numbers and
also ask some questions. Here is a table that shows how OpenVPN scales. I
ran up to 4 instances of OpenVPN servers simulatenously with different
ciphers:

ICMP test (MiByes/s)

*Cipher\OpenVPNs instances*

*1*

*2*

*3*

*4*

*BF-CBC*

35

65

84

96

*AES-128-CBC*

45

80

94

96(lower CPU)

*AES-256-CBC*

40

76

96

96(low CPU)


Total of 800 tunnels were established in each test. Each tunnel was utilized
with following ping command: "ping -I tunX -s 800 -i 0.003 <OpenVPN IP>".
Lower CPU indicates that CPU usage was lower than in other tests.

Deployment was as follows:

1. Server (Intel Xeon E5530 6GB of RAM with two 1GBit NICs; Ubuntu 10.04)
connected directly with two clients (without a switch, so that total
throughput could be 2Gbits)

2. Client1 (Q6600) runs half of the OpenVPN client instances

3. Client2 (Intel Xeon E5530) runs the other half of OpenVPN instances.


Questions:
1. Why single OpenVPN server instance never consumes more than 85% of a CPU
core in the System Monitor? Is this related to ep_pool() call that has a
minimum wait interval and OpenVPN does not do anything at that time?
2. During the ping test on the server I observed that incoming traffic (ping
requests) pushed out outgoing traffic (ping responses). The incoming and
outgoing traffic should be equal, but this does not hold true in a load
test. Any explanation why that happened? Maybe because ICMP is unreliable
protocol and datagrams(responses) were dropped?
3. Have anyone tried to run OpenVPN on a newer CPU that has AES-NI
instruction set (e.g. Xeon E56XX series)? I would like to know what would be
the bandwidth benefit when AES is chosen as the data Tunnel Cipher?
4. During a OpenVPN 1200 client bomb test I observed that OpenVPN stalled
with 100% CPU. In the openvpn log I saw that there are too many opened files
(output of "ls /proc/PID/fd | wc -l" showed that there were 1027 opened
files). The bad thing is that killing all those 1200 clients did not help
the OpenVPN server to recover and it remained in stall state. It looks like
a bug for me.



Are there any tools which are already developed and would help in
benchmarking multiple OpenVPN clients/servers?


Regards,
Ansis Atteka

--000e0cd32f2456f151048ebdb90f
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello<br><br>I have done some benchmarking of OpenVPN and wanted to share m=
y numbers and also ask some questions. Here is a table that shows how OpenV=
PN scales. I ran up to 4 instances of OpenVPN servers simulatenously with d=
ifferent ciphers:<br>
<br><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8=
"><meta name=3D"ProgId" content=3D"Word.Document"><meta name=3D"Generator" =
content=3D"Microsoft Word 12"><meta name=3D"Originator" content=3D"Microsof=
t Word 12"><link rel=3D"File-List" href=3D"file:///C:%5CDOCUME%7E1%5CANSIS%=
7E1.ATT%5CLOCALS%7E1%5CTemp%5Cmsohtmlclip1%5C01%5Cclip_filelist.xml"><link =
rel=3D"themeData" href=3D"file:///C:%5CDOCUME%7E1%5CANSIS%7E1.ATT%5CLOCALS%=
7E1%5CTemp%5Cmsohtmlclip1%5C01%5Cclip_themedata.thmx"><link rel=3D"colorSch=
emeMapping" href=3D"file:///C:%5CDOCUME%7E1%5CANSIS%7E1.ATT%5CLOCALS%7E1%5C=
Temp%5Cmsohtmlclip1%5C01%5Cclip_colorschememapping.xml"><style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1610611985 1107304683 0 0 159 0;}
@font-face
	{font-family:Cambria;
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1610611985 1073741899 0 0 159 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-1610611985 1073750139 0 0 159 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:0in;
	line-height:115%;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
h3
	{mso-style-priority:9;
	mso-style-qformat:yes;
	mso-style-link:"Heading 3 Char";
	mso-style-next:Normal;
	margin-top:10.0pt;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:0in;
	margin-bottom:.0001pt;
	line-height:115%;
	mso-pagination:widow-orphan lines-together;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:11.0pt;
	font-family:"Cambria","serif";
	mso-ascii-font-family:Cambria;
	mso-ascii-theme-font:major-latin;
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:major-fareast;
	mso-hansi-font-family:Cambria;
	mso-hansi-theme-font:major-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:major-bidi;
	color:#4F81BD;
	mso-themecolor:accent1;}
span.Heading3Char
	{mso-style-name:"Heading 3 Char";
	mso-style-priority:9;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-link:"Heading 3";
	font-family:"Cambria","serif";
	mso-ascii-font-family:Cambria;
	mso-ascii-theme-font:major-latin;
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:major-fareast;
	mso-hansi-font-family:Cambria;
	mso-hansi-theme-font:major-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:major-bidi;
	color:#4F81BD;
	mso-themecolor:accent1;
	font-weight:bold;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
.MsoPapDefault
	{mso-style-type:export-only;
	margin-bottom:10.0pt;
	line-height:115%;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>

<h3>ICMP test (MiByes/s)<br></h3>

<table class=3D"MsoTableGrid" style=3D"border: medium none ; border-collaps=
e: collapse;" border=3D"1" cellpadding=3D"0" cellspacing=3D"0">
 <tbody><tr style=3D"">
  <td style=3D"border: 1pt solid black; padding: 0in 5.4pt; width: 87.65pt;=
" valign=3D"top" width=3D"117">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;"><b style=3D"">Cipher\OpenVPNs instances</b></p>
  </td>
  <td style=3D"border-style: solid solid solid none; border-color: black bl=
ack black -moz-use-text-color; border-width: 1pt 1pt 1pt medium; padding: 0=
in 5.4pt; width: 112.25pt;" valign=3D"top" width=3D"150">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;"><b style=3D"">1</b></p>
  </td>
  <td style=3D"border-style: solid solid solid none; border-color: black bl=
ack black -moz-use-text-color; border-width: 1pt 1pt 1pt medium; padding: 0=
in 5.4pt; width: 80.15pt;" valign=3D"top" width=3D"107">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;"><b style=3D"">2</b></p>
  </td>
  <td style=3D"border-style: solid solid solid none; border-color: black bl=
ack black -moz-use-text-color; border-width: 1pt 1pt 1pt medium; padding: 0=
in 5.4pt; width: 93.05pt;" valign=3D"top" width=3D"124">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;"><b style=3D"">3</b></p>
  </td>
  <td style=3D"border-style: solid solid solid none; border-color: black bl=
ack black -moz-use-text-color; border-width: 1pt 1pt 1pt medium; padding: 0=
in 5.4pt; width: 93.05pt;" valign=3D"top" width=3D"124">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;"><b style=3D"">4</b></p>
  </td>
 </tr>
 <tr style=3D"">
  <td style=3D"border-style: none solid solid; border-color: -moz-use-text-=
color black black; border-width: medium 1pt 1pt; padding: 0in 5.4pt; width:=
 87.65pt;" valign=3D"top" width=3D"117">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;"><b style=3D"">BF-CBC</b></p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 112.25pt;" valign=3D"top" width=3D"150">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">35</p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 80.15pt;" valign=3D"top" width=3D"107">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">65</p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 93.05pt;" valign=3D"top" width=3D"124">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">84</p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 93.05pt;" valign=3D"top" width=3D"124">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">96</p>
  </td>
 </tr>
 <tr style=3D"">
  <td style=3D"border-style: none solid solid; border-color: -moz-use-text-=
color black black; border-width: medium 1pt 1pt; padding: 0in 5.4pt; width:=
 87.65pt;" valign=3D"top" width=3D"117">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;"><b style=3D"">AES-128-CBC</b></p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 112.25pt;" valign=3D"top" width=3D"150">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">45</p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 80.15pt;" valign=3D"top" width=3D"107">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">80</p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 93.05pt;" valign=3D"top" width=3D"124">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">94</p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 93.05pt;" valign=3D"top" width=3D"124">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">96(lower CPU)</p>
  </td>
 </tr>
 <tr style=3D"">
  <td style=3D"border-style: none solid solid; border-color: -moz-use-text-=
color black black; border-width: medium 1pt 1pt; padding: 0in 5.4pt; width:=
 87.65pt;" valign=3D"top" width=3D"117">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;"><b style=3D"">AES-256-CBC</b></p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 112.25pt;" valign=3D"top" width=3D"150">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">40</p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 80.15pt;" valign=3D"top" width=3D"107">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">76</p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 93.05pt;" valign=3D"top" width=3D"124">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">96</p>
  </td>
  <td style=3D"border-style: none solid solid none; border-color: -moz-use-=
text-color black black -moz-use-text-color; border-width: medium 1pt 1pt me=
dium; padding: 0in 5.4pt; width: 93.05pt;" valign=3D"top" width=3D"124">
  <p class=3D"MsoNormal" style=3D"margin-bottom: 0.0001pt; line-height: nor=
mal;">96(low CPU)</p>
  </td>
 </tr>
</tbody></table>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Total of 800 tunnels =
were established in each test. Each tunnel was utilized with following ping=
 command: &quot;ping -I tunX -s 800 -i 0.003 &lt;OpenVPN IP&gt;&quot;. Lowe=
r CPU indicates that CPU usage was lower than in other tests.</p>
<p class=3D"MsoNormal">Deployment was as follows:</p><p class=3D"MsoNormal"=
>1. Server (Intel Xeon E5530 6GB of RAM with two 1GBit NICs; Ubuntu 10.04) =
connected directly with two clients (without a switch, so that total throug=
hput could be 2Gbits)<br>
</p><p class=3D"MsoNormal">2. Client1 (Q6600) runs half of the OpenVPN clie=
nt instances</p><p class=3D"MsoNormal">3. Client2 (Intel Xeon E5530) runs t=
he other half of OpenVPN instances.</p><p class=3D"MsoNormal"><br></p><p cl=
ass=3D"MsoNormal">
Questions:<br></p>

1. Why single OpenVPN server instance never consumes more than 85% of a CPU=
 core in the System Monitor? Is this related to ep_pool() call that has a m=
inimum wait interval and OpenVPN does not do anything at that time?<br>
2. During the ping test on the server I observed that incoming traffic (pin=
g requests) pushed out outgoing traffic (ping responses). The incoming and =
outgoing traffic should be equal, but this does not hold true in a load tes=
t. Any explanation why that happened? Maybe because ICMP is unreliable prot=
ocol and datagrams(responses) were dropped?<br>
3. Have anyone tried to run OpenVPN on a newer CPU that has AES-NI instruct=
ion set (e.g. Xeon E56XX series)? I would like to know what would be the ba=
ndwidth benefit when AES is chosen as the data Tunnel Cipher?<br>4. During =
a OpenVPN 1200 client bomb test I observed that OpenVPN stalled with 100% C=
PU. In the openvpn log I saw that there are too many opened files (output o=
f &quot;ls /proc/PID/fd | wc -l&quot; showed that there were 1027 opened fi=
les). The bad thing is that killing all those 1200 clients did not help the=
 OpenVPN server to recover and it remained in stall state. It looks like a =
bug for me.<br>
<br><br><br>Are there any tools which are already developed and would help =
in benchmarking multiple OpenVPN clients/servers? <br><br><br>Regards,<br>A=
nsis Atteka<br>

--000e0cd32f2456f151048ebdb90f--

