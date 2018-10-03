MIME-Version: 1.0
From: Rostyslav Maryliak <rostyslav.maryliak@...2454...>
Date: Wed, 3 Oct 2018 18:15:13 +0300
Message-ID: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
Content-Type: multipart/alternative; boundary="0000000000007ae7f6057754833f"
Subject: [Openvpn-devel] Slow outbound network speed for Windows Server 2016
 only via the OpenVPN tunnel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000007ae7f6057754833f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear OpenVPN developers,

I've faced a very strange issue with slow outbound network speed from
Windows Server 2016 Standard server via the OpenVPN tunnel.
OpenVPN server is Windows Server 2012 R2, client is Windows Server 2016.
The inbound network speed for Windows Server 2016 is great.
But the outbound network speed is nearly 30-40 kbps. I've got the same
results using several tests: iperf testings, file download via SMB,
Web-based downloading (using HTTP) etc.

The tunnels is getting up and it works greatly, but only in one direction -
from Windows Server 2012 R2 to Windows Server 2016.
I've been using such server-client configurations setup for several years
with Windows Server 2012 R2 servers and I've never faced such issue before.
At first I thought that our ISP has some network limitations, but it turned
out that the same tests shows great network speed results using the public
IP addresses in both directions.
The issue only occurs inside the VPN tunnel. I've spent 3 days tryng to
figure it out, but failed. I've installed all latest Windows updates,
reinstalled OpenVPN, tried to switch from UDP to TCP,
played with performance settings in configs (link-mtu, sndbuf, rcvbuf etc)
but still no luck. I've tested the same setup between two Windows Server
2012 R2 servers and it works greatly in both directions.
Then I've tested it with another Windows Server 2016 Standard server
(different server and different ISP) and it showed the same awful results
in outbound direction.
When I've set the same OpenVPN tunnel between two Windows Server 2016
Standard servers I've got the same poor network speed in both directions.

I believe that the issue is somehow related only to the Windows Server 2016
version and I am more than confident that it depends on server's TCP stack
settings.
I've noticed that Windows Server 2016 has a congestion control provider
setting set to "default", while previous versions of Windows has this
setting set to "none".

I've created a topic on OpenVPN Support Forum and it was suggested to post
my issue to you and reference the thread.

You can reference to the
https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D27173 for config files a=
nd
additional information.

Have you faced a similar issue before? Can you provide any hint how can I
resolve the issue? What did I missed?
I would be very grateful for any help. Thank you in advance.


--=20

Best regards,

*Rostyslav Maryliak*

System Administrator



*iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51 <%2B%2038%28093%29575=
-35-16> |
Skype: rostyslav.maryliak.ideals| *rostyslav.maryliak@...2454...
<dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
<http://www.idealscorp.com/>

--=20
CONFIDENTIALITY NOTE:
The information transmitted, including attachments,

is intended only for the person(s) or entity to which it is addressed and

may contain confidential and/or privileged material. Any review,

retransmission, dissemination or other use of, or taking of any action in

reliance upon this information by persons or entities other than the

intended recipient is prohibited. If you received this in error, please

contact the sender and destroy any copies of this information.

--0000000000007ae7f6057754833f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default"><font face=3D"arial=
, helvetica, sans-serif">Dear OpenVPN developers,</font></div><div class=3D=
"gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></font></di=
v><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">=
<div class=3D"gmail_default">I&#39;ve faced a very strange issue with slow =
outbound network speed from Windows Server 2016 Standard server via the Ope=
nVPN tunnel.</div><div class=3D"gmail_default">OpenVPN server is Windows Se=
rver 2012 R2, client is Windows Server 2016. The inbound network speed for =
Windows Server 2016 is great.</div><div class=3D"gmail_default">But the out=
bound network speed is nearly 30-40 kbps. I&#39;ve got the same results usi=
ng several tests: iperf testings, file download via SMB, Web-based download=
ing (using HTTP) etc.</div></font></div><div class=3D"gmail_default"><font =
face=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gmail_=
default"><font face=3D"arial, helvetica, sans-serif"><div class=3D"gmail_de=
fault">The tunnels is getting up and it works greatly, but only in one dire=
ction - from Windows Server 2012 R2 to Windows Server 2016.</div><div class=
=3D"gmail_default">I&#39;ve been using such server-client configurations se=
tup for several years with Windows Server 2012 R2 servers and I&#39;ve neve=
r faced such issue before.</div><div class=3D"gmail_default">At first I tho=
ught that our ISP has some network limitations, but it turned out that the =
same tests shows great network speed results using the public IP addresses =
in both directions.</div><div class=3D"gmail_default">The issue only occurs=
 inside the VPN tunnel. I&#39;ve spent 3 days tryng to figure it out, but f=
ailed. I&#39;ve installed all latest Windows updates, reinstalled OpenVPN, =
tried to switch from UDP to TCP,</div><div class=3D"gmail_default">played w=
ith performance settings in configs (link-mtu, sndbuf, rcvbuf etc) but stil=
l no luck. I&#39;ve tested the same setup between two Windows Server 2012 R=
2 servers and it works greatly in both directions.</div><div class=3D"gmail=
_default">Then I&#39;ve tested it with another Windows Server 2016 Standard=
 server (different server and different ISP) and it showed the same awful r=
esults in outbound direction.</div><div class=3D"gmail_default">When I&#39;=
ve set the same OpenVPN tunnel between two Windows Server 2016 Standard ser=
vers I&#39;ve got the same poor network speed in both directions.</div></fo=
nt></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-=
serif"><br></font></div><div class=3D"gmail_default"><font face=3D"arial, h=
elvetica, sans-serif"><div class=3D"gmail_default">I believe that the issue=
 is somehow related only to the Windows Server 2016 version and I am more t=
han confident that it depends on server&#39;s TCP stack settings.</div><div=
 class=3D"gmail_default">I&#39;ve noticed that Windows Server 2016 has a co=
ngestion control provider setting set to &quot;default&quot;, while previou=
s versions of Windows has this setting set to &quot;none&quot;.</div></font=
></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-se=
rif"><br></font></div><div class=3D"gmail_default"><font face=3D"arial, hel=
vetica, sans-serif">I&#39;ve created a topic on OpenVPN Support Forum and i=
t was suggested to post my issue to you and reference the thread.</font></d=
iv><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"=
><br></font></div><div class=3D"gmail_default"><font face=3D"arial, helveti=
ca, sans-serif">You can reference to the <a href=3D"https://forums.openvpn.=
net/viewtopic.php?f=3D6&amp;t=3D27173">https://forums.openvpn.net/viewtopic=
.php?f=3D6&amp;t=3D27173</a>=C2=A0for config files and additional informati=
on.</font><br clear=3D"all"></div><div><br></div><div><div class=3D"gmail_d=
efault" style=3D"font-family:arial,helvetica,sans-serif">Have you faced a s=
imilar issue before? Can you provide any hint how can I resolve the issue? =
What did I missed?</div><div class=3D"gmail_default" style=3D"font-family:a=
rial,helvetica,sans-serif">I would be very grateful for any help. Thank you=
 in advance.</div><br></div><div><br></div>-- <br><div dir=3D"ltr" class=3D=
"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"l=
tr"><div><div dir=3D"ltr"><p style=3D"margin:0in 0in 0.0001pt;font-size:11p=
t;font-family:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(8=
9,89,89)">Best regards,</span></p><p style=3D"margin:0in 0in 0.0001pt;font-=
family:Calibri,sans-serif"><font color=3D"#595959"><span style=3D"font-size=
:16px"><b>Rostyslav Maryliak</b></span></font></p><p style=3D"margin:0in 0i=
n 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=3D"fo=
nt-size:12pt;color:rgb(89,89,89)">System Administrator</span></p><p style=
=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">=
<span style=3D"font-size:12pt;color:rgb(89,89,89)">=C2=A0</span></p><p styl=
e=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"=
><b><span style=3D"font-size:12pt;color:rgb(35,176,24)">iDeals=E2=84=A2 Sol=
utions Group</span></b><span style=3D"font-size:12pt;color:rgb(89,89,89)">|=
=C2=A0<a href=3D"tel:%2B%2038%28093%29575-35-16" value=3D"+380935753516" st=
yle=3D"color:rgb(17,85,204)" target=3D"_blank">+ 38(073)437-72-51</a>=C2=A0=
| Skype: rostyslav.maryliak.ideals|</span><span style=3D"color:rgb(31,73,12=
5)">=C2=A0</span><u><span style=3D"font-size:12pt;color:rgb(35,176,24)"><a =
href=3D"mailto:dmitry.zaporozhchenko@...2454..." style=3D"color:rgb(17,85,2=
04)" target=3D"_blank"><span style=3D"color:rgb(5,99,193)">rostyslav.maryli=
ak@...2454...</span></a></span></u><u><span style=3D"color:rgb(35,176,24)">=
=C2=A0</span></u><span style=3D"font-size:12pt;color:rgb(89,89,89)">|</span=
><span style=3D"font-size:12pt;color:rgb(35,176,24)">=C2=A0</span><span lan=
g=3D"RU" style=3D"font-size:12pt;color:rgb(35,176,24)"><a href=3D"http://ww=
w.idealscorp.com/" style=3D"color:rgb(17,85,204)" target=3D"_blank"><span l=
ang=3D"EN-US" style=3D"color:rgb(35,176,24)">www.idealsvdr.com</span></a></=
span></p></div></div></div></div></div></div></div></div></div></div></div>=
</div></div></div>

<br>
<span style=3D"font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;fo=
nt-size:12pt"><font face=3D"Trebuchet" size=3D"2">CONFIDENTIALITY NOTE:
The information transmitted, including attachments,
is intended only for the person(s) or entity to which it is addressed and
may contain confidential and/or privileged material. Any review,
retransmission, dissemination or other use of, or taking of any action in
reliance upon this information by persons or entities other than the
intended recipient is prohibited. If you received this in error, please
contact the sender and destroy any copies of this information.</font></span=
>=

--0000000000007ae7f6057754833f--

