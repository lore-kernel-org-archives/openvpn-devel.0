References: <1355733093.65651.YahooMailNeo@...1779...>
	<50CEDEA3.7040408@...1114...>
Message-ID: <1355752871.55418.YahooMailNeo@...1767...>
Date: Mon, 17 Dec 2012 06:01:11 -0800 (PST)
From: ehsan enayati <ehsan_en85@...109...>
In-Reply-To: <50CEDEA3.7040408@...1114...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-613093590-1345799768-1355752871=:55418"
Subject: Re: [Openvpn-devel] multiple OpenVPN instances on a single tun
Reply-To: ehsan enayati <ehsan_en85@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

---613093590-1345799768-1355752871=:55418
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for your replies. I just checked OpenVPN access server and saw that =
in "server network setting" and in protocol selection you can select Multi-=
Daemon mode. I thinks that's what exactly I need. Is it implemented via tun=
 + routing?




________________________________
 From: David Sommerseth <openvpn.list@...1114...>
To: openvpn-devel@lists.sourceforge.net=20
Sent: Monday, December 17, 2012 12:28 PM
Subject: Re: [Openvpn-devel] multiple OpenVPN instances on a single tun
=20
On 17/12/12 09:31, ehsan enayati wrote:
> Hi,
> I need to run multiple instances of OpenVPN server on just one tun
> device driver (say tun0) all on same subnets. I tried editing the
> open_tun function in tun.c file, first instance goes well and creates
> tun0 but when the second one comes along it cannot use tun0 and I get
> the error "ioctl(TUNSETIFF): Device or resource busy". I really need
> this functionality. Please give me some hints.

It is not possible to do what you try to do.=A0 Only one application can
bind to a tun or tap socket.=A0 It's basically the same issue if you try
to have more applications bind and listen to, say port 80, at the same
time.=A0 It's impossible.=A0 And it's restricted by the OS.

If you need OpenVPN instances to be on the same subnet, you can use TAP
and bridge tap0 and tap1 together.=A0 *But* I 'd rather recommend to use
tun devices, have them on separate subnets and do the rest with routing.
Using tun + routing is by far the cleanest and easiest configuration
setups.=A0 It also gives the lowest traffic overhead and least headache
while debugging the configuration when it fails.


--=20
kind regards,

David Sommerseth


---------------------------------------------------------------------------=
---
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel=

---613093590-1345799768-1355752871=:55418
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ar=
ial, helvetica, sans-serif;font-size:14pt">Thanks for your replies. I just =
checked OpenVPN access server and saw that in "server network setting" and =
in protocol selection you can select Multi-Daemon mode. I thinks that's wha=
t exactly I need. Is it implemented via tun + routing?<br><br><br><div styl=
e=3D"font-family: arial, helvetica, sans-serif; font-size: 14pt;"> <div sty=
le=3D"font-family: times new roman, new york, times, serif; font-size: 12pt=
;"> <div dir=3D"ltr"> <font face=3D"Arial" size=3D"2"> <hr size=3D"1">  <b>=
<span style=3D"font-weight:bold;">From:</span></b> David Sommerseth &lt;ope=
nvpn.list@...1114...&gt;<br> <b><span style=3D"font-weight: bold;">To:</spa=
n></b> openvpn-devel@lists.sourceforge.net <br> <b><span style=3D"font-weig=
ht: bold;">Sent:</span></b> Monday, December 17, 2012 12:28 PM<br> <b><span=
 style=3D"font-weight: bold;">Subject:</span></b> Re: [Openvpn-devel] multi=
ple
 OpenVPN instances on a single tun<br> </font> </div> <br>
On 17/12/12 09:31, ehsan enayati wrote:<br>&gt; Hi,<br>&gt; I need to run m=
ultiple instances of OpenVPN server on just one tun<br>&gt; device driver (=
say tun0) all on same subnets. I tried editing the<br>&gt; open_tun functio=
n in tun.c file, first instance goes well and creates<br>&gt; tun0 but when=
 the second one comes along it cannot use tun0 and I get<br>&gt; the error =
"ioctl(TUNSETIFF): Device or resource busy". I really need<br>&gt; this fun=
ctionality. Please give me some hints.<br><br>It is not possible to do what=
 you try to do.&nbsp; Only one application can<br>bind to a tun or tap sock=
et.&nbsp; It's basically the same issue if you try<br>to have more applicat=
ions bind and listen to, say port 80, at the same<br>time.&nbsp; It's impos=
sible.&nbsp; And it's restricted by the OS.<br><br>If you need OpenVPN inst=
ances to be on the same subnet, you can use TAP<br>and bridge tap0 and tap1=
 together.&nbsp; *But* I 'd rather recommend to use<br>tun devices,
 have them on separate subnets and do the rest with routing.<br> Using tun =
+ routing is by far the cleanest and easiest configuration<br>setups.&nbsp;=
 It also gives the lowest traffic overhead and least headache<br>while debu=
gging the configuration when it fails.<br><br><br>-- <br>kind regards,<br><=
br>David Sommerseth<br><br><br>--------------------------------------------=
----------------------------------<br>LogMeIn Rescue: Anywhere, Anytime Rem=
ote support for IT. Free Trial<br>Remotely access PCs and mobile devices an=
d provide instant support<br>Improve your efficiency, and focus on deliveri=
ng more value-add services<br>Discover what IT Professionals Know. Rescue d=
elivers<br><a href=3D"http://p.sf.net/sfu/logmein_12329d2d" target=3D"_blan=
k">http://p.sf.net/sfu/logmein_12329d2d</a><br>____________________________=
___________________<br>Openvpn-devel mailing list<br><a ymailto=3D"mailto:O=
penvpn-devel@lists.sourceforge.net"
 href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1466...=
urceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listinf=
o/openvpn-devel" target=3D"_blank">https://lists.sourceforge.net/lists/list=
info/openvpn-devel</a><br><br><br> </div> </div>  </div></body></html>=

---613093590-1345799768-1355752871=:55418--

