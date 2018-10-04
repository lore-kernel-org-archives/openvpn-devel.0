MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
In-Reply-To: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 4 Oct 2018 09:50:06 +0500
Message-ID: <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
Content-Type: multipart/alternative; boundary="00000000000037867f05775fe47f"
Subject: Re: [Openvpn-devel] Slow outbound network speed for Windows Server
 2016 only via the OpenVPN tunnel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: rostyslav.maryliak@...2454...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000037867f05775fe47f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

can you do some things and tell us your observation ?

starting with win2012 so called network profiles were introduced (Internet
/ Intranet / Datacenter)
those profiles are very different for tcp connection (if you observe
degradation in case of udp, most probably that is not related)


so, let's start

start powershell (I assume you are familiar)
call

Get-NetTCPConnection

pay attention to "AppliedSetting" column.
what's there  ?

we did observe strange things when win2012 classified some traffic as
"Internet" and appropriate tcp settings were applied.

is there some correlation in your case ?

=D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:45, Rostyslav Ma=
ryliak <
rostyslav.maryliak@...2454...>:

> Dear OpenVPN developers,
>
> I've faced a very strange issue with slow outbound network speed from
> Windows Server 2016 Standard server via the OpenVPN tunnel.
> OpenVPN server is Windows Server 2012 R2, client is Windows Server 2016.
> The inbound network speed for Windows Server 2016 is great.
> But the outbound network speed is nearly 30-40 kbps. I've got the same
> results using several tests: iperf testings, file download via SMB,
> Web-based downloading (using HTTP) etc.
>
> The tunnels is getting up and it works greatly, but only in one direction
> - from Windows Server 2012 R2 to Windows Server 2016.
> I've been using such server-client configurations setup for several years
> with Windows Server 2012 R2 servers and I've never faced such issue befor=
e.
> At first I thought that our ISP has some network limitations, but it
> turned out that the same tests shows great network speed results using the
> public IP addresses in both directions.
> The issue only occurs inside the VPN tunnel. I've spent 3 days tryng to
> figure it out, but failed. I've installed all latest Windows updates,
> reinstalled OpenVPN, tried to switch from UDP to TCP,
> played with performance settings in configs (link-mtu, sndbuf, rcvbuf etc)
> but still no luck. I've tested the same setup between two Windows Server
> 2012 R2 servers and it works greatly in both directions.
> Then I've tested it with another Windows Server 2016 Standard server
> (different server and different ISP) and it showed the same awful results
> in outbound direction.
> When I've set the same OpenVPN tunnel between two Windows Server 2016
> Standard servers I've got the same poor network speed in both directions.
>
> I believe that the issue is somehow related only to the Windows Server
> 2016 version and I am more than confident that it depends on server's TCP
> stack settings.
> I've noticed that Windows Server 2016 has a congestion control provider
> setting set to "default", while previous versions of Windows has this
> setting set to "none".
>
> I've created a topic on OpenVPN Support Forum and it was suggested to post
> my issue to you and reference the thread.
>
> You can reference to the
> https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D27173 for config files=
 and
> additional information.
>
> Have you faced a similar issue before? Can you provide any hint how can I
> resolve the issue? What did I missed?
> I would be very grateful for any help. Thank you in advance.
>
>
> --
>
> Best regards,
>
> *Rostyslav Maryliak*
>
> System Administrator
>
>
>
> *iDeals=E2=84=A2 Solutions Group*| + 38(073)437-72-51 <%2B%2038%28093%295=
75-35-16> |
> Skype: rostyslav.maryliak.ideals| *rostyslav.maryliak@...2454...
> <dmitry.zaporozhchenko@...2454...>* | www.idealsvdr.com
> <http://www.idealscorp.com/>
>
> CONFIDENTIALITY NOTE: The information transmitted, including attachments,
> is intended only for the person(s) or entity to which it is addressed and
> may contain confidential and/or privileged material. Any review,
> retransmission, dissemination or other use of, or taking of any action in
> reliance upon this information by persons or entities other than the
> intended recipient is prohibited. If you received this in error, please
> contact the sender and destroy any copies of this information.
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000037867f05775fe47f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>can you do some thing=
s and tell us your observation ?</div><div><br></div><div>starting with win=
2012 so called network profiles were introduced (Internet / Intranet / Data=
center)</div><div>those profiles are very different for tcp connection (if =
you observe degradation in case of udp, most probably that is not related)<=
/div><div><br></div><div><br></div><div>so, let&#39;s start</div><div><br><=
/div><div>start powershell (I assume you are familiar)</div><div>call</div>=
<div><br></div><div>Get-NetTCPConnection</div><div><br></div><div>pay atten=
tion to &quot;AppliedSetting&quot; column.</div><div>what&#39;s there=C2=A0=
 ?</div><div><br></div><div>we did observe strange things when win2012 clas=
sified some traffic as &quot;Internet&quot; and appropriate tcp settings we=
re applied.</div><div><br></div><div>is there some correlation in your case=
 ?<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">=D1=81=D1=
=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:45, Rostyslav Maryliak &l=
t;<a href=3D"mailto:rostyslav.maryliak@...2454...">rostyslav.maryliak@...2416...=
54...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-=
serif">Dear OpenVPN developers,</font></div><div class=3D"gmail_default"><f=
ont face=3D"arial, helvetica, sans-serif"><br></font></div><div class=3D"gm=
ail_default"><font face=3D"arial, helvetica, sans-serif"><div class=3D"gmai=
l_default">I&#39;ve faced a very strange issue with slow outbound network s=
peed from Windows Server 2016 Standard server via the OpenVPN tunnel.</div>=
<div class=3D"gmail_default">OpenVPN server is Windows Server 2012 R2, clie=
nt is Windows Server 2016. The inbound network speed for Windows Server 201=
6 is great.</div><div class=3D"gmail_default">But the outbound network spee=
d is nearly 30-40 kbps. I&#39;ve got the same results using several tests: =
iperf testings, file download via SMB, Web-based downloading (using HTTP) e=
tc.</div></font></div><div class=3D"gmail_default"><font face=3D"arial, hel=
vetica, sans-serif"><br></font></div><div class=3D"gmail_default"><font fac=
e=3D"arial, helvetica, sans-serif"><div class=3D"gmail_default">The tunnels=
 is getting up and it works greatly, but only in one direction - from Windo=
ws Server 2012 R2 to Windows Server 2016.</div><div class=3D"gmail_default"=
>I&#39;ve been using such server-client configurations setup for several ye=
ars with Windows Server 2012 R2 servers and I&#39;ve never faced such issue=
 before.</div><div class=3D"gmail_default">At first I thought that our ISP =
has some network limitations, but it turned out that the same tests shows g=
reat network speed results using the public IP addresses in both directions=
.</div><div class=3D"gmail_default">The issue only occurs inside the VPN tu=
nnel. I&#39;ve spent 3 days tryng to figure it out, but failed. I&#39;ve in=
stalled all latest Windows updates, reinstalled OpenVPN, tried to switch fr=
om UDP to TCP,</div><div class=3D"gmail_default">played with performance se=
ttings in configs (link-mtu, sndbuf, rcvbuf etc) but still no luck. I&#39;v=
e tested the same setup between two Windows Server 2012 R2 servers and it w=
orks greatly in both directions.</div><div class=3D"gmail_default">Then I&#=
39;ve tested it with another Windows Server 2016 Standard server (different=
 server and different ISP) and it showed the same awful results in outbound=
 direction.</div><div class=3D"gmail_default">When I&#39;ve set the same Op=
enVPN tunnel between two Windows Server 2016 Standard servers I&#39;ve got =
the same poor network speed in both directions.</div></font></div><div clas=
s=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></font>=
</div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-ser=
if"><div class=3D"gmail_default">I believe that the issue is somehow relate=
d only to the Windows Server 2016 version and I am more than confident that=
 it depends on server&#39;s TCP stack settings.</div><div class=3D"gmail_de=
fault">I&#39;ve noticed that Windows Server 2016 has a congestion control p=
rovider setting set to &quot;default&quot;, while previous versions of Wind=
ows has this setting set to &quot;none&quot;.</div></font></div><div class=
=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></font><=
/div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-seri=
f">I&#39;ve created a topic on OpenVPN Support Forum and it was suggested t=
o post my issue to you and reference the thread.</font></div><div class=3D"=
gmail_default"><font face=3D"arial, helvetica, sans-serif"><br></font></div=
><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">Y=
ou can reference to the <a href=3D"https://forums.openvpn.net/viewtopic.php=
?f=3D6&amp;t=3D27173" target=3D"_blank">https://forums.openvpn.net/viewtopi=
c.php?f=3D6&amp;t=3D27173</a>=C2=A0for config files and additional informat=
ion.</font><br clear=3D"all"></div><div><br></div><div><div class=3D"gmail_=
default" style=3D"font-family:arial,helvetica,sans-serif">Have you faced a =
similar issue before? Can you provide any hint how can I resolve the issue?=
 What did I missed?</div><div class=3D"gmail_default" style=3D"font-family:=
arial,helvetica,sans-serif">I would be very grateful for any help. Thank yo=
u in advance.</div><br></div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"m_-2729697033681776833gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><p style=3D"margin:0in=
 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span style=3D=
"font-size:12pt;color:rgb(89,89,89)">Best regards,</span></p><p style=3D"ma=
rgin:0in 0in 0.0001pt;font-family:Calibri,sans-serif"><font color=3D"#59595=
9"><span style=3D"font-size:16px"><b>Rostyslav Maryliak</b></span></font></=
p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sa=
ns-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)">System Adminis=
trator</span></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-fa=
mily:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89)"=
>=C2=A0</span></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif"><b><span style=3D"font-size:12pt;color:rgb(35,176=
,24)">iDeals=E2=84=A2 Solutions Group</span></b><span style=3D"font-size:12=
pt;color:rgb(89,89,89)">|=C2=A0<a href=3D"tel:%2B%2038%28093%29575-35-16" v=
alue=3D"+380935753516" style=3D"color:rgb(17,85,204)" target=3D"_blank">+ 3=
8(073)437-72-51</a>=C2=A0| Skype: rostyslav.maryliak.ideals|</span><span st=
yle=3D"color:rgb(31,73,125)">=C2=A0</span><u><span style=3D"font-size:12pt;=
color:rgb(35,176,24)"><a href=3D"mailto:dmitry.zaporozhchenko@...2454..." s=
tyle=3D"color:rgb(17,85,204)" target=3D"_blank"><span style=3D"color:rgb(5,=
99,193)">rostyslav.maryliak@...2454...</span></a></span></u><u><span style=
=3D"color:rgb(35,176,24)">=C2=A0</span></u><span style=3D"font-size:12pt;co=
lor:rgb(89,89,89)">|</span><span style=3D"font-size:12pt;color:rgb(35,176,2=
4)">=C2=A0</span><span lang=3D"RU" style=3D"font-size:12pt;color:rgb(35,176=
,24)"><a href=3D"http://www.idealscorp.com/" style=3D"color:rgb(17,85,204)"=
 target=3D"_blank"><span lang=3D"EN-US" style=3D"color:rgb(35,176,24)">www.=
idealsvdr.com</span></a></span></p></div></div></div></div></div></div></di=
v></div></div></div></div></div></div></div>

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
>_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--00000000000037867f05775fe47f--

