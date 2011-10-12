From: "Richard Francis" <rfransix@...164...>
References: <000001cc8890$9d6d35b0$d847a110$@net>
	<CADKk8=uwCojh_xxuQMXGHNQNnFbFfWf0Tdp0wp9ikxHsu43vEQ@...278...>
In-Reply-To: <CADKk8=uwCojh_xxuQMXGHNQNnFbFfWf0Tdp0wp9ikxHsu43vEQ@...278...>
Date: Wed, 12 Oct 2011 10:40:41 -0500
Message-ID: <006a01cc88f5$4c96ad50$e5c407f0$@net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_006B_01CC88CB.63C0A550"
Content-Language: en-us
Subject: Re: [Openvpn-devel] VPN Connects but can't route to destinations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'anjini shukla' <anjinishukla@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_006B_01CC88CB.63C0A550
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Thanks for the reply. I resolved this by adding 2 routes, one to the vpn
gateway and one to my local network gateway. BAM. Working fine now.

 

Except for one thing.the OpenVPN connection terminates by other CISCO VPN
connection.I can only work with one VPN on the network (I have a standard
network-cable to hub to router to cable-modem to Internet setup). I may have
to figure out how to configure 2 routers to one modem.

 

PS: Subscribing to users list now.

 

Richard 

 

 

From: anjini shukla [mailto:anjinishukla@...277...] 
Sent: Tuesday, October 11, 2011 11:43 PM
To: Richard Francis
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] VPN Connects but can't route to destinations

 

You need to set up IP masquerading, it is simple for linux machines:

iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE

for windows you require to set up ICS which can be done using windows UI

On Tue, Oct 11, 2011 at 8:39 PM, Richard Francis <rfransix@...164...>
wrote:

 

Hi,

 

I've configured an openvpn TAP-Win32 Adapter V9 with an ip address of
12.0.0.2, subnet mask of 255.0.0.0, DHCP of 12.0.0.0, and DNS of 10.0.0.222.

 

After I connect, I can only ping 10.0.0.222, nothing else on the 10.x.x.x
network.

 

And to get to .222, I had to, route add 10.0.0.0 MASK 255.0.0.0 12.0.0.2
METRIC 30 to get there.

 

What am I missing?

 

Thank you very much.

 

Richard

 


----------------------------------------------------------------------------
--
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

 


------=_NextPart_000_006B_01CC88CB.63C0A550
Content-Type: text/html; charset="US-ASCII"
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
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.apple-style-span
	{mso-style-name:apple-style-span;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'f=
ont-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D'>Thanks fo=
r the reply. I resolved this by adding 2 routes, one to the vpn gateway and=
 one to my local network gateway. BAM. Working fine now.<o:p></o:p></span><=
/p><p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibr=
i","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNo=
rmal><span style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";col=
or:#1F497D'>Except for one thing&#8230;the OpenVPN connection terminates by=
 other CISCO VPN connection&#8230;I can only work with one VPN on the netwo=
rk (I have a standard network-cable to hub to router to cable-modem to Inte=
rnet setup). I may have to figure out how to configure 2 routers to one mod=
em.<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:11.0=
pt;font-family:"Calibri","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></spa=
n></p><p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Cal=
ibri","sans-serif";color:#1F497D'>PS: Subscribing to users list now.<o:p></=
o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-fa=
mily:"Calibri","sans-serif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><p c=
lass=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri","san=
s-serif";color:#1F497D'>Richard </span><span style=3D'font-size:11.0pt;font=
-family:"Calibri","sans-serif";color:#1F497D'><o:p></o:p></span></p><p clas=
s=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri","sans-s=
erif";color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span=
 style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497D=
'><o:p>&nbsp;</o:p></span></p><div style=3D'border:none;border-top:solid #B=
5C4DF 1.0pt;padding:3.0pt 0in 0in 0in'><p class=3DMsoNormal><b><span style=
=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span></b><sp=
an style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> anjini shu=
kla [mailto:anjinishukla@...277...] <br><b>Sent:</b> Tuesday, October 11, 2=
011 11:43 PM<br><b>To:</b> Richard Francis<br><b>Cc:</b> openvpn-devel@...1514...=
s.sourceforge.net<br><b>Subject:</b> Re: [Openvpn-devel] VPN Connects but c=
an't route to destinations<o:p></o:p></span></p></div><p class=3DMsoNormal>=
<o:p>&nbsp;</o:p></p><p class=3DMsoNormal>You need to set up IP&nbsp;masque=
rading, it is simple for linux machines:<o:p></o:p></p><div><p class=3DMsoN=
ormal><span class=3Dapple-style-span><span style=3D'font-size:10.0pt;font-f=
amily:"Arial","sans-serif";background:white'>iptables -t nat -I POSTROUTING=
 -o eth0 -j MASQUERADE</span></span><o:p></o:p></p></div><div><p class=3DMs=
oNormal style=3D'margin-bottom:12.0pt'><span style=3D'font-family:"Arial","=
sans-serif"'>for windows you require to set up ICS which can be done using =
windows UI</span><o:p></o:p></p><div><p class=3DMsoNormal>On Tue, Oct 11, 2=
011 at 8:39 PM, Richard Francis &lt;<a href=3D"mailto:rfransix@...164...">r=
fransix@...164...</a>&gt; wrote:<o:p></o:p></p><div><div><p class=3DMsoNorm=
al style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'>&nbsp;<o:p>=
</o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-=
bottom-alt:auto'>Hi,<o:p></o:p></p><p class=3DMsoNormal style=3D'mso-margin=
-top-alt:auto;mso-margin-bottom-alt:auto'>&nbsp;<o:p></o:p></p><p class=3DM=
soNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'>I&#82=
17;ve configured an openvpn TAP-Win32 Adapter V9 with an ip address of 12.0=
.0.2, subnet mask of 255.0.0.0, DHCP of 12.0.0.0, and DNS of 10.0.0.222.<o:=
p></o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margi=
n-bottom-alt:auto'>&nbsp;<o:p></o:p></p><p class=3DMsoNormal style=3D'mso-m=
argin-top-alt:auto;mso-margin-bottom-alt:auto'>After I connect, I can only =
ping 10.0.0.222, nothing else on the 10.x.x.x network.<o:p></o:p></p><p cla=
ss=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'=
>&nbsp;<o:p></o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto=
;mso-margin-bottom-alt:auto'>And to get to .222, I had to, route add 10.0.0=
.0 MASK 255.0.0.0 12.0.0.2 METRIC 30 to get there.<o:p></o:p></p><p class=
=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'>&=
nbsp;<o:p></o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;m=
so-margin-bottom-alt:auto'>What am I missing?<o:p></o:p></p><p class=3DMsoN=
ormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'>&nbsp;<o=
:p></o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-marg=
in-bottom-alt:auto'>Thank you very much.<o:p></o:p></p><p class=3DMsoNormal=
 style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'>&nbsp;<o:p></=
o:p></p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bo=
ttom-alt:auto'><span style=3D'color:#1F497D'>Richard</span><span style=3D'c=
olor:#888888'><o:p></o:p></span></p><p class=3DMsoNormal style=3D'mso-margi=
n-top-alt:auto;mso-margin-bottom-alt:auto'><span style=3D'color:#888888'>&n=
bsp;<o:p></o:p></span></p></div></div><p class=3DMsoNormal style=3D'margin-=
bottom:12.0pt'><br>--------------------------------------------------------=
----------------------<br>All the data continuously generated in your IT in=
frastructure contains a<br>definitive record of customers, application perf=
ormance, security<br>threats, fraudulent activity and more. Splunk takes th=
is data and makes<br>sense of it. Business sense. IT sense. Common sense.<b=
r><a href=3D"http://p.sf.net/sfu/splunk-d2d-oct" target=3D"_blank">http://p=
.sf.net/sfu/splunk-d2d-oct</a><br>_________________________________________=
______<br>Openvpn-devel mailing list<br><a href=3D"mailto:Openvpn-devel@...1484...=
ts.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a><br><a href=3D"h=
ttps://lists.sourceforge.net/lists/listinfo/openvpn-devel" target=3D"_blank=
">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><o:p></o:p>=
</p></div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></div></body></ht=
ml>=

------=_NextPart_000_006B_01CC88CB.63C0A550--


