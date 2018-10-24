MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <82cf3c7a-f738-2821-f294-1cd954a0b491@...277...>
 <51044224-1010-87b3-3f6b-6deac5fbd88b@...515...>
In-Reply-To: <51044224-1010-87b3-3f6b-6deac5fbd88b@...515...>
From: Rostyslav Maryliak <rostyslav.maryliak@...2454...>
Date: Thu, 25 Oct 2018 00:12:38 +0300
Message-ID: <CADkMwqRb0cSRrzctP090nZ_qGxRrSmSSmMqtQT_mbCxjPx2rpQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000005275840578fff498"
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
To: samuli@...515...
Cc: tincanteksup@...277..., openvpn-devel@lists.sourceforge.net

--0000000000005275840578fff498
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear tincanteksup,

Yes, Samuli is correct. It is impossible to install the older version of
TAP adapter (NDIS 5) on Windows Server 2016

On Wed, Oct 24, 2018 at 3:20 PM Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:

> Hi,
>
> If I recall correctly, NDIS 5 support was dropped in Windows 8 or early
> Windows 10. Tap-windows uses NDIS 5, so it almost certainly does not
> work on Windows Server 2016.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
>
> Il 24/10/18 15:09, tincanteksup ha scritto:
> > Hi,
> >
> > a completely different approach ..
> >
> > On the Forum somebody claimed that the old Tap Adaptor works better
> > than the new one on W2012r2.
> >
> > https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D27288#p81973
> >
> > Could you test that ?
> >
> > Thanks
> > tct
> >
> >
> > On 03/10/2018 16:15, Rostyslav Maryliak wrote:
> >> Dear OpenVPN developers,
> >>
> >> I've faced a very strange issue with slow outbound network speed from
> >> Windows Server 2016 Standard server via the OpenVPN tunnel.
> >> OpenVPN server is Windows Server 2012 R2, client is Windows Server 201=
6.
> >> The inbound network speed for Windows Server 2016 is great.
> >> But the outbound network speed is nearly 30-40 kbps. I've got the same
> >> results using several tests: iperf testings, file download via SMB,
> >> Web-based downloading (using HTTP) etc.
> >>
> >> The tunnels is getting up and it works greatly, but only in one
> >> direction -
> >> from Windows Server 2012 R2 to Windows Server 2016.
> >> I've been using such server-client configurations setup for several
> years
> >> with Windows Server 2012 R2 servers and I've never faced such issue
> >> before.
> >> At first I thought that our ISP has some network limitations, but it
> >> turned
> >> out that the same tests shows great network speed results using the
> >> public
> >> IP addresses in both directions.
> >> The issue only occurs inside the VPN tunnel. I've spent 3 days tryng to
> >> figure it out, but failed. I've installed all latest Windows updates,
> >> reinstalled OpenVPN, tried to switch from UDP to TCP,
> >> played with performance settings in configs (link-mtu, sndbuf, rcvbuf
> >> etc)
> >> but still no luck. I've tested the same setup between two Windows Serv=
er
> >> 2012 R2 servers and it works greatly in both directions.
> >> Then I've tested it with another Windows Server 2016 Standard server
> >> (different server and different ISP) and it showed the same awful
> results
> >> in outbound direction.
> >> When I've set the same OpenVPN tunnel between two Windows Server 2016
> >> Standard servers I've got the same poor network speed in both
> directions.
> >>
> >> I believe that the issue is somehow related only to the Windows Server
> >> 2016
> >> version and I am more than confident that it depends on server's TCP
> >> stack
> >> settings.
> >> I've noticed that Windows Server 2016 has a congestion control provider
> >> setting set to "default", while previous versions of Windows has this
> >> setting set to "none".
> >>
> >> I've created a topic on OpenVPN Support Forum and it was suggested to
> >> post
> >> my issue to you and reference the thread.
> >>
> >> You can reference to the
> >> https://forums.openvpn.net/viewtopic.php?f=3D6&t=3D27173 for config fi=
les
> and
> >> additional information.
> >>
> >> Have you faced a similar issue before? Can you provide any hint how can
> I
> >> resolve the issue? What did I missed?
> >> I would be very grateful for any help. Thank you in advance.
> >>
> >>
> >>
> >>
> >> _______________________________________________
> >> Openvpn-devel mailing list
> >> Openvpn-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >>
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


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

--0000000000005275840578fff498
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,helvetica,sans-serif">Dear=C2=A0tincanteksup,</div><div clas=
s=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></=
div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif">Yes, Samuli is correct. It is impossible to install the older versio=
n of TAP adapter (NDIS 5) on Windows Server 2016</div></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Oct 24, 2018 at 3:20 PM Samu=
li Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515...">samuli@...515...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
If I recall correctly, NDIS 5 support was dropped in Windows 8 or early<br>
Windows 10. Tap-windows uses NDIS 5, so it almost certainly does not<br>
work on Windows Server 2016.<br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
<br>
<br>
Il 24/10/18 15:09, tincanteksup ha scritto:<br>
&gt; Hi,<br>
&gt; <br>
&gt; a completely different approach ..<br>
&gt; <br>
&gt; On the Forum somebody claimed that the old Tap Adaptor works better<br>
&gt; than the new one on W2012r2.<br>
&gt; <br>
&gt; <a href=3D"https://forums.openvpn.net/viewtopic.php?f=3D6&amp;t=3D2728=
8#p81973" rel=3D"noreferrer" target=3D"_blank">https://forums.openvpn.net/v=
iewtopic.php?f=3D6&amp;t=3D27288#p81973</a><br>
&gt; <br>
&gt; Could you test that ?<br>
&gt; <br>
&gt; Thanks<br>
&gt; tct<br>
&gt; <br>
&gt; <br>
&gt; On 03/10/2018 16:15, Rostyslav Maryliak wrote:<br>
&gt;&gt; Dear OpenVPN developers,<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ve faced a very strange issue with slow outbound network spe=
ed from<br>
&gt;&gt; Windows Server 2016 Standard server via the OpenVPN tunnel.<br>
&gt;&gt; OpenVPN server is Windows Server 2012 R2, client is Windows Server=
 2016.<br>
&gt;&gt; The inbound network speed for Windows Server 2016 is great.<br>
&gt;&gt; But the outbound network speed is nearly 30-40 kbps. I&#39;ve got =
the same<br>
&gt;&gt; results using several tests: iperf testings, file download via SMB=
,<br>
&gt;&gt; Web-based downloading (using HTTP) etc.<br>
&gt;&gt;<br>
&gt;&gt; The tunnels is getting up and it works greatly, but only in one<br>
&gt;&gt; direction -<br>
&gt;&gt; from Windows Server 2012 R2 to Windows Server 2016.<br>
&gt;&gt; I&#39;ve been using such server-client configurations setup for se=
veral years<br>
&gt;&gt; with Windows Server 2012 R2 servers and I&#39;ve never faced such =
issue<br>
&gt;&gt; before.<br>
&gt;&gt; At first I thought that our ISP has some network limitations, but =
it<br>
&gt;&gt; turned<br>
&gt;&gt; out that the same tests shows great network speed results using th=
e<br>
&gt;&gt; public<br>
&gt;&gt; IP addresses in both directions.<br>
&gt;&gt; The issue only occurs inside the VPN tunnel. I&#39;ve spent 3 days=
 tryng to<br>
&gt;&gt; figure it out, but failed. I&#39;ve installed all latest Windows u=
pdates,<br>
&gt;&gt; reinstalled OpenVPN, tried to switch from UDP to TCP,<br>
&gt;&gt; played with performance settings in configs (link-mtu, sndbuf, rcv=
buf<br>
&gt;&gt; etc)<br>
&gt;&gt; but still no luck. I&#39;ve tested the same setup between two Wind=
ows Server<br>
&gt;&gt; 2012 R2 servers and it works greatly in both directions.<br>
&gt;&gt; Then I&#39;ve tested it with another Windows Server 2016 Standard =
server<br>
&gt;&gt; (different server and different ISP) and it showed the same awful =
results<br>
&gt;&gt; in outbound direction.<br>
&gt;&gt; When I&#39;ve set the same OpenVPN tunnel between two Windows Serv=
er 2016<br>
&gt;&gt; Standard servers I&#39;ve got the same poor network speed in both =
directions.<br>
&gt;&gt;<br>
&gt;&gt; I believe that the issue is somehow related only to the Windows Se=
rver<br>
&gt;&gt; 2016<br>
&gt;&gt; version and I am more than confident that it depends on server&#39=
;s TCP<br>
&gt;&gt; stack<br>
&gt;&gt; settings.<br>
&gt;&gt; I&#39;ve noticed that Windows Server 2016 has a congestion control=
 provider<br>
&gt;&gt; setting set to &quot;default&quot;, while previous versions of Win=
dows has this<br>
&gt;&gt; setting set to &quot;none&quot;.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ve created a topic on OpenVPN Support Forum and it was sugge=
sted to<br>
&gt;&gt; post<br>
&gt;&gt; my issue to you and reference the thread.<br>
&gt;&gt;<br>
&gt;&gt; You can reference to the<br>
&gt;&gt; <a href=3D"https://forums.openvpn.net/viewtopic.php?f=3D6&amp;t=3D=
27173" rel=3D"noreferrer" target=3D"_blank">https://forums.openvpn.net/view=
topic.php?f=3D6&amp;t=3D27173</a> for config files and<br>
&gt;&gt; additional information.<br>
&gt;&gt;<br>
&gt;&gt; Have you faced a similar issue before? Can you provide any hint ho=
w can I<br>
&gt;&gt; resolve the issue? What did I missed?<br>
&gt;&gt; I would be very grateful for any help. Thank you in advance.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Openvpn-devel mailing list<br>
&gt;&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_=
blank">Openvpn-devel@lists.sourceforge.net</a><br>
&gt;&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-de=
vel" rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lis=
ts/listinfo/openvpn-devel</a><br>
&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/l=
istinfo/openvpn-devel</a><br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><p st=
yle=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Calibri,sans-seri=
f"><span style=3D"font-size:12pt;color:rgb(89,89,89)">Best regards,</span><=
/p><p style=3D"margin:0in 0in 0.0001pt;font-family:Calibri,sans-serif"><fon=
t color=3D"#595959"><span style=3D"font-size:16px"><b>Rostyslav Maryliak</b=
></span></font></p><p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-=
family:Calibri,sans-serif"><span style=3D"font-size:12pt;color:rgb(89,89,89=
)">System Administrator</span></p><p style=3D"margin:0in 0in 0.0001pt;font-=
size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:12pt;col=
or:rgb(89,89,89)">=C2=A0</span></p><p style=3D"margin:0in 0in 0.0001pt;font=
-size:11pt;font-family:Calibri,sans-serif"><b><span style=3D"font-size:12pt=
;color:rgb(35,176,24)">iDeals=E2=84=A2 Solutions Group</span></b><span styl=
e=3D"font-size:12pt;color:rgb(89,89,89)">|=C2=A0<a href=3D"tel:%2B%2038%280=
93%29575-35-16" value=3D"+380935753516" style=3D"color:rgb(17,85,204)" targ=
et=3D"_blank">+ 38(073)437-72-51</a>=C2=A0| Skype: rostyslav.maryliak.ideal=
s|</span><span style=3D"color:rgb(31,73,125)">=C2=A0</span><u><span style=
=3D"font-size:12pt;color:rgb(35,176,24)"><a href=3D"mailto:dmitry.zaporozhc=
henko@...2454..." style=3D"color:rgb(17,85,204)" target=3D"_blank"><span st=
yle=3D"color:rgb(5,99,193)">rostyslav.maryliak@...2454...</span></a></span>=
</u><u><span style=3D"color:rgb(35,176,24)">=C2=A0</span></u><span style=3D=
"font-size:12pt;color:rgb(89,89,89)">|</span><span style=3D"font-size:12pt;=
color:rgb(35,176,24)">=C2=A0</span><span lang=3D"RU" style=3D"font-size:12p=
t;color:rgb(35,176,24)"><a href=3D"http://www.idealscorp.com/" style=3D"col=
or:rgb(17,85,204)" target=3D"_blank"><span lang=3D"EN-US" style=3D"color:rg=
b(35,176,24)">www.idealsvdr.com</span></a></span></p></div></div></div></di=
v></div></div></div></div>

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

--0000000000005275840578fff498--

