Message-ID: <1AC345EACB034D778AC18983907FB492@...1205...>
From: "M. G." <mg1984@...1204...>
Date: Mon, 23 Mar 2009 01:14:09 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0013_01C9AB54.AB31A5D0"
Subject: [Openvpn-devel] Get server to listen for TCP and UDP connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

Dies ist eine mehrteilige Nachricht im MIME-Format.

------=_NextPart_000_0013_01C9AB54.AB31A5D0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I recently changed my VPN-tunnel from TCP to UDP for the sake of better per=
formance. It generally works very well but I noticed that I can't connect t=
o my server from some networks when using UDP, e.g. at work. This may be an=
 issue with the NAT/firewall configuration which I have no influence on.
Since I am connecting from random locations where I don't know beforehand i=
f a UDP connection will succeed, I'm now kind of worried that it'll get a g=
ame of luck if a connection succeeds from a specific location.=20

So far my story, now to the question:=20
What is the reason that OpenVPN doesn't have an option to listen for TCP AN=
D UDP connections simultaneously? Is it a technical problem that I cannot s=
ee, or am I simply the only one who thinks this would be a nice feature?

I know I could run two server instances on different tun devices but I thin=
k it'd be much nicer (and resource-friendly) if I could just put "proto udp=
 tcp-server" (or whatever) into the config file and be flexible with my con=
nections to the server.

Thanks,
Mario=

------=_NextPart_000_0013_01C9AB54.AB31A5D0
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3Dtext/html;charset=3Diso-8859-1>
<META content=3D"MSHTML 6.00.6000.16809" name=3DGENERATOR></HEAD>
<BODY id=3DMailContainerBody=20
style=3D"PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-TOP: 15px" leftMa=
rgin=3D0=20
topMargin=3D0 CanvasTabStop=3D"true" name=3D"Compose message area">
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I recently changed my VPN-tunnel from TCP =
to UDP=20
for the sake of better performance. It generally works very well but I noti=
ced=20
that I can't connect to my server from some networks when using UDP, e.g. a=
t=20
work. This may be an issue with the NAT/firewall configuration which I have=
 no=20
influence on.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Since I am connecting from random location=
s where I=20
don't know beforehand if a UDP connection will succeed, I'm now kind of wor=
ried=20
that it'll get a game of luck if a connection succeeds from a specific loca=
tion.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So far my story, now to the question: </FO=
NT></DIV>
<DIV><FONT face=3DArial size=3D2>What is the reason that OpenVPN doesn't ha=
ve an=20
option to listen for TCP AND UDP connections simultaneously? Is it a techni=
cal=20
problem that I cannot see, or&nbsp;am I simply the only one who thinks this=
=20
would be a nice feature?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I know I could run two server instances on=
=20
different tun devices but I think it'd be much nicer (and resource-friendly=
) if=20
I could just put "proto udp tcp-server" (or whatever) into the config file =
and=20
be flexible with my connections to the server.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Mario</FONT></DIV></FONT></DIV></BODY></HT=
ML>

------=_NextPart_000_0013_01C9AB54.AB31A5D0--


