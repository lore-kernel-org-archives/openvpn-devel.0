Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C76BBF.8F17C72F"
Date: Wed, 21 Mar 2007 14:44:38 +0100
Message-ID: <B216E7A91F67B6429E3ACF162402A02D570A74@...1006...>
References: <B216E7A91F67B6429E3ACF162402A02D066CFE@...1006...>
From: "David Balazic" <David.Balazic@...1005...>
Subject: Re: [Openvpn-devel] Bug with setting client gateway on reconnect ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C76BBF.8F17C72F
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi!
=20
I got bit by this bug again. Should I try the 2.1 beta ?
Are there any newer build than the OpenVPN 2.1_beta7 on openvpn.se ?
=20
Regards,
David
=20
PS: Is http://openvpn.net/ down ?
=20

________________________________

From: openvpn-devel-bounces@lists.sourceforge.net on behalf of David Balazic
Sent: Tue 27-Feb-07 12:01
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] Bug with setting client gateway on reconnect ?


Hi!
=20
After a network failure, OpenVPN client reconnects to the server, but fails=
 to set up the default route.
An USR1 signal then makes it reconnect properly (not visible in the logs be=
low).
Note that the server IP is resolved just fine (how else could it then conne=
ct?)
=20
Regards,
David
=20
server : OpenVPN  2.0.8  on OpenWRT
client : OpenVPN 2.0.9 on Windows 2003
=20
timeline :
09:47 establish connection for the first time , OK
10:43 network disconnect
10:44 network is back, reconnect OK, but gateway not set
=20

Client log (I replaced real server IP with 99.88.77.66 and FQHN with my.ope=
nvpn.server.example.org):
=20
Tue Feb 27 09:47:21 2007 OpenVPN 2.0.9 Win32-MinGW [SSL] [LZO] built on Oct=
  1 2006
Tue Feb 27 09:47:21 2007 IMPORTANT: OpenVPN's default port number is now 11=
94, based on an official port number assignment by IANA.  OpenVPN 2.0-beta1=
6 and earlier used 5000 as the default port.
Tue Feb 27 09:47:21 2007 ******* WARNING *******: null cipher specified, no=
 encryption will be used
Tue Feb 27 09:47:21 2007 TAP-WIN32 device [Local Area Connection 2] opened:=
 \\.\Global\{DED0C8F4-E03C-45AA-B64A-C128A7737FA5}.tap <file://./Global/%7B=
DED0C8F4-E03C-45AA-B64A-C128A7737FA5%7D.tap>=20
Tue Feb 27 09:47:21 2007 Notified TAP-Win32 driver to set a DHCP IP/netmask=
 of 10.4.0.2/255.255.255.252 on interface {DED0C8F4-E03C-45AA-B64A-C128A773=
7FA5} [DHCP-serv: 10.4.0.1, lease-time: 31536000]
Tue Feb 27 09:47:21 2007 Successful ARP Flush on interface [2] {DED0C8F4-E0=
3C-45AA-B64A-C128A7737FA5}
Tue Feb 27 09:47:21 2007 UDPv4 link local (bound): [undef]:1194
Tue Feb 27 09:47:21 2007 UDPv4 link remote: 99.88.77.66:4500
Tue Feb 27 09:47:25 2007 Peer Connection Initiated with 99.88.77.66:4500
Tue Feb 27 09:47:26 2007 Initialization Sequence Completed
Tue Feb 27 10:43:54 2007 Inactivity timeout (--ping-restart), restarting
Tue Feb 27 10:43:54 2007 SIGUSR1[soft,ping-restart] received, process resta=
rting
Tue Feb 27 10:43:56 2007 IMPORTANT: OpenVPN's default port number is now 11=
94, based on an official port number assignment by IANA.  OpenVPN 2.0-beta1=
6 and earlier used 5000 as the default port.
Tue Feb 27 10:43:56 2007 ******* WARNING *******: null cipher specified, no=
 encryption will be used
Tue Feb 27 10:44:08 2007 RESOLVE: Cannot resolve host address: my.openvpn.s=
erver.example.org: [NO_DATA] The requested name is valid but does not have =
an IP address.
Tue Feb 27 10:44:08 2007 TAP-WIN32 device [Local Area Connection 2] opened:=
 \\.\Global\{DED0C8F4-E03C-45AA-B64A-C128A7737FA5}.tap <file://./Global/%7B=
DED0C8F4-E03C-45AA-B64A-C128A7737FA5%7D.tap>=20
Tue Feb 27 10:44:08 2007 Notified TAP-Win32 driver to set a DHCP IP/netmask=
 of 10.4.0.2/255.255.255.252 on interface {DED0C8F4-E03C-45AA-B64A-C128A773=
7FA5} [DHCP-serv: 10.4.0.1, lease-time: 31536000]
Tue Feb 27 10:44:08 2007 Successful ARP Flush on interface [2] {DED0C8F4-E0=
3C-45AA-B64A-C128A7737FA5}
Tue Feb 27 10:44:08 2007 UDPv4 link local (bound): [undef]:1194
Tue Feb 27 10:44:08 2007 UDPv4 link remote: 99.88.77.66:4500
Tue Feb 27 10:44:16 2007 Peer Connection Initiated with 99.88.77.66:4500
Tue Feb 27 10:44:17 2007 NOTE: unable to redirect default gateway -- Cannot=
 obtain current remote host address
Tue Feb 27 10:44:17 2007 Initialization Sequence Completed
=20
server log (I replaced real client IP with 1.2.3.4):
=20
Feb 27 09:46:47 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:58887
Feb 27 09:46:47 (none) kern.notice openvpn[7411]: Initialization Sequence C=
ompleted
Feb 27 09:47:33 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:58905
Feb 27 09:48:15 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:58923
Feb 27 09:49:03 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:58940
Feb 27 09:49:45 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:58954
Feb 27 09:50:33 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:58968
Feb 27 09:51:13 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:58980
Feb 27 09:52:02 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:58995
Feb 27 09:53:45 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59026
Feb 27 09:54:43 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59045
Feb 27 09:55:24 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59060
Feb 27 09:56:04 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59075
Feb 27 09:56:45 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59085
Feb 27 09:58:27 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59129
Feb 27 09:59:18 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59158
Feb 27 09:59:59 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59171
Feb 27 10:02:22 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59216
Feb 27 10:03:02 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59233
Feb 27 10:03:43 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59246
Feb 27 10:04:24 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59260
Feb 27 10:05:15 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59282
Feb 27 10:09:30 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59364
Feb 27 10:10:11 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59381
Feb 27 10:43:19 (none) kern.notice openvpn[7411]: Inactivity timeout (--pin=
g-restart), restarting
Feb 27 10:43:19 (none) kern.notice openvpn[7411]: SIGUSR1[soft,ping-restart=
] received, process restarting
Feb 27 10:43:21 (none) kern.notice openvpn[7411]: Re-using pre-shared stati=
c key
Feb 27 10:43:21 (none) kern.notice openvpn[7411]: Preserving previous TUN/T=
AP instance: tun2
Feb 27 10:43:21 (none) kern.notice openvpn[7411]: UDPv4 link local (bound):=
 [undef]:4500
Feb 27 10:43:21 (none) kern.notice openvpn[7411]: UDPv4 link remote: [undef]
Feb 27 10:43:34 (none) kern.notice openvpn[7411]: Peer Connection Initiated=
 with 1.2.3.4:59381
Feb 27 10:43:35 (none) kern.notice openvpn[7411]: Initialization Sequence C=
ompleted

client config :
=20
remote my.openvpn.server.example.org 4500
dev tun1
ifconfig 10.4.0.2 10.4.0.1
route-gateway 10.4.0.1
redirect-gateway def1
ping 10
ping-restart 60
verb 1
mute 5
cipher none
secret key 0

server config :
=20
    port 4500
    dev tun2
    ifconfig 10.4.0.1 10.4.0.2
    secret /etc/openvpn/key_1 1
    ping 10
    ping-restart 60
    ping-timer-rem
    verb 1
    mute 5
    cipher none
    persist-key
    persist-tun
    user nobody
    group nogroup


------_=_NextPart_001_01C76BBF.8F17C72F
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">
<META content=3D"MSHTML 6.00.2800.1589" name=3DGENERATOR></HEAD>
<BODY>
<DIV id=3DidOWAReplyText3799 dir=3Dltr>
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hi!</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2></FONT>&nbsp;</D=
IV>
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>I got bit by thi=
s bug again. Should I try the 2.1 beta ?</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Are there any newer build than t=
he <STRONG><FONT face=3D"Times New Roman" size=3D3>OpenVPN 2.1_beta7 on ope=
nvpn.se ?</FONT></STRONG></FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>David</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>PS: Is </FONT><FONT face=3DArial=
 size=3D2><A href=3D"http://openvpn.net/">http://openvpn.net/</A>&nbsp;down=
 ?</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV>
<DIV dir=3Dltr><BR>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> openvpn-devel-bounces@...1011...=
eforge.net on behalf of David Balazic<BR><B>Sent:</B> Tue 27-Feb-07 12:01<B=
R><B>To:</B> openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> [Openvp=
n-devel] Bug with setting client gateway on reconnect ?<BR></FONT><BR></DIV>
<DIV dir=3Dltr>
<DIV><FONT face=3DArial color=3D#000000 size=3D2>Hi!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>After a network failure, OpenVPN client re=
connects to the server, but fails to set up the default route.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>An USR1 signal then makes it reconnect pro=
perly (not visible in the logs below).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Note that the server IP is resolved just f=
ine (how else could it then connect?)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>David</FONT></DIV>
<DIV><FONT face=3DArial color=3D#000000 size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#000000 size=3D2>server : OpenVPN&nbsp; 2.0=
.8&nbsp; on OpenWRT<BR>client : OpenVPN 2.0.9 on Windows 2003</FONT></DIV><=
FONT face=3DArial color=3D#000000 size=3D2>
<DIV>&nbsp;</DIV>
<DIV>timeline :<BR>09:47 establish connection for the first time , OK<BR>10=
:43 network disconnect<BR>10:44 network is back, reconnect OK, but gateway =
not set</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR>Client log (I replaced real server IP with 99.88.77.66 and&nbsp;FQ=
HN with my.openvpn.server.example.org):</DIV>
<DIV>&nbsp;</DIV>
<DIV>Tue Feb 27 09:47:21 2007 OpenVPN 2.0.9 Win32-MinGW [SSL] [LZO] built o=
n Oct&nbsp; 1 2006<BR>Tue Feb 27 09:47:21 2007 IMPORTANT: OpenVPN's default=
 port number is now 1194, based on an official port number assignment by IA=
NA.&nbsp; OpenVPN 2.0-beta16 and earlier used 5000 as the default port.<BR>=
Tue Feb 27 09:47:21 2007 ******* WARNING *******: null cipher specified, no=
 encryption will be used<BR>Tue Feb 27 09:47:21 2007 TAP-WIN32 device [Loca=
l Area Connection 2] opened: <A href=3D"file://./Global/%7BDED0C8F4-E03C-45=
AA-B64A-C128A7737FA5%7D.tap">\\.\Global\{DED0C8F4-E03C-45AA-B64A-C128A7737F=
A5}.tap</A><BR>Tue Feb 27 09:47:21 2007 Notified TAP-Win32 driver to set a =
DHCP IP/netmask of 10.4.0.2/255.255.255.252 on interface {DED0C8F4-E03C-45A=
A-B64A-C128A7737FA5} [DHCP-serv: 10.4.0.1, lease-time: 31536000]<BR>Tue Feb=
 27 09:47:21 2007 Successful ARP Flush on interface [2] {DED0C8F4-E03C-45AA=
-B64A-C128A7737FA5}<BR>Tue Feb 27 09:47:21 2007 UDPv4 link local (bound): [=
undef]:1194<BR>Tue Feb 27 09:47:21 2007 UDPv4 link remote: 99.88.77.66:4500=
<BR>Tue Feb 27 09:47:25 2007 Peer Connection Initiated with 99.88.77.66:450=
0<BR>Tue Feb 27 09:47:26 2007 Initialization Sequence Completed<BR>Tue Feb =
27 10:43:54 2007 Inactivity timeout (--ping-restart), restarting<BR>Tue Feb=
 27 10:43:54 2007 SIGUSR1[soft,ping-restart] received, process restarting<B=
R>Tue Feb 27 10:43:56 2007 IMPORTANT: OpenVPN's default port number is now =
1194, based on an official port number assignment by IANA.&nbsp; OpenVPN 2.=
0-beta16 and earlier used 5000 as the default port.<BR>Tue Feb 27 10:43:56 =
2007 ******* WARNING *******: null cipher specified, no encryption will be =
used<BR>Tue Feb 27 10:44:08 2007 RESOLVE: Cannot resolve host address: my.o=
penvpn.server.example.org: [NO_DATA] The requested name is valid but does n=
ot have an IP address.<BR>Tue Feb 27 10:44:08 2007 TAP-WIN32 device [Local =
Area Connection 2] opened: <A href=3D"file://./Global/%7BDED0C8F4-E03C-45AA=
-B64A-C128A7737FA5%7D.tap">\\.\Global\{DED0C8F4-E03C-45AA-B64A-C128A7737FA5=
}.tap</A><BR>Tue Feb 27 10:44:08 2007 Notified TAP-Win32 driver to set a DH=
CP IP/netmask of 10.4.0.2/255.255.255.252 on interface {DED0C8F4-E03C-45AA-=
B64A-C128A7737FA5} [DHCP-serv: 10.4.0.1, lease-time: 31536000]<BR>Tue Feb 2=
7 10:44:08 2007 Successful ARP Flush on interface [2] {DED0C8F4-E03C-45AA-B=
64A-C128A7737FA5}<BR>Tue Feb 27 10:44:08 2007 UDPv4 link local (bound): [un=
def]:1194<BR>Tue Feb 27 10:44:08 2007 UDPv4 link remote: 99.88.77.66:4500<B=
R>Tue Feb 27 10:44:16 2007 Peer Connection Initiated with 99.88.77.66:4500<=
BR>Tue Feb 27 10:44:17 2007 NOTE: unable to redirect default gateway -- Can=
not obtain current remote host address<BR>Tue Feb 27 10:44:17 2007 Initiali=
zation Sequence Completed</DIV>
<DIV>&nbsp;</DIV>
<DIV>server log (I replaced real client IP with 1.2.3.4):</DIV>
<DIV>&nbsp;</DIV>
<DIV>Feb 27 09:46:47 (none) kern.notice openvpn[7411]: Peer Connection Init=
iated with 1.2.3.4:58887<BR>Feb 27 09:46:47 (none) kern.notice openvpn[7411=
]: Initialization Sequence Completed<BR>Feb 27 09:47:33 (none) kern.notice =
openvpn[7411]: Peer Connection Initiated with 1.2.3.4:58905<BR>Feb 27 09:48=
:15 (none) kern.notice openvpn[7411]: Peer Connection Initiated with 1.2.3.=
4:58923<BR>Feb 27 09:49:03 (none) kern.notice openvpn[7411]: Peer Connectio=
n Initiated with 1.2.3.4:58940<BR>Feb 27 09:49:45 (none) kern.notice openvp=
n[7411]: Peer Connection Initiated with 1.2.3.4:58954<BR>Feb 27 09:50:33 (n=
one) kern.notice openvpn[7411]: Peer Connection Initiated with 1.2.3.4:5896=
8<BR>Feb 27 09:51:13 (none) kern.notice openvpn[7411]: Peer Connection Init=
iated with 1.2.3.4:58980<BR>Feb 27 09:52:02 (none) kern.notice openvpn[7411=
]: Peer Connection Initiated with 1.2.3.4:58995<BR>Feb 27 09:53:45 (none) k=
ern.notice openvpn[7411]: Peer Connection Initiated with 1.2.3.4:59026<BR>F=
eb 27 09:54:43 (none) kern.notice openvpn[7411]: Peer Connection Initiated =
with 1.2.3.4:59045<BR>Feb 27 09:55:24 (none) kern.notice openvpn[7411]: Pee=
r Connection Initiated with 1.2.3.4:59060<BR>Feb 27 09:56:04 (none) kern.no=
tice openvpn[7411]: Peer Connection Initiated with 1.2.3.4:59075<BR>Feb 27 =
09:56:45 (none) kern.notice openvpn[7411]: Peer Connection Initiated with 1=
.2.3.4:59085<BR>Feb 27 09:58:27 (none) kern.notice openvpn[7411]: Peer Conn=
ection Initiated with 1.2.3.4:59129<BR>Feb 27 09:59:18 (none) kern.notice o=
penvpn[7411]: Peer Connection Initiated with 1.2.3.4:59158<BR>Feb 27 09:59:=
59 (none) kern.notice openvpn[7411]: Peer Connection Initiated with 1.2.3.4=
:59171<BR>Feb 27 10:02:22 (none) kern.notice openvpn[7411]: Peer Connection=
 Initiated with 1.2.3.4:59216<BR>Feb 27 10:03:02 (none) kern.notice openvpn=
[7411]: Peer Connection Initiated with 1.2.3.4:59233<BR>Feb 27 10:03:43 (no=
ne) kern.notice openvpn[7411]: Peer Connection Initiated with 1.2.3.4:59246=
<BR>Feb 27 10:04:24 (none) kern.notice openvpn[7411]: Peer Connection Initi=
ated with 1.2.3.4:59260<BR>Feb 27 10:05:15 (none) kern.notice openvpn[7411]=
: Peer Connection Initiated with 1.2.3.4:59282<BR>Feb 27 10:09:30 (none) ke=
rn.notice openvpn[7411]: Peer Connection Initiated with 1.2.3.4:59364<BR>Fe=
b 27 10:10:11 (none) kern.notice openvpn[7411]: Peer Connection Initiated w=
ith 1.2.3.4:59381<BR>Feb 27 10:43:19 (none) kern.notice openvpn[7411]: Inac=
tivity timeout (--ping-restart), restarting<BR>Feb 27 10:43:19 (none) kern.=
notice openvpn[7411]: SIGUSR1[soft,ping-restart] received, process restarti=
ng<BR>Feb 27 10:43:21 (none) kern.notice openvpn[7411]: Re-using pre-shared=
 static key<BR>Feb 27 10:43:21 (none) kern.notice openvpn[7411]: Preserving=
 previous TUN/TAP instance: tun2<BR>Feb 27 10:43:21 (none) kern.notice open=
vpn[7411]: UDPv4 link local (bound): [undef]:4500<BR>Feb 27 10:43:21 (none)=
 kern.notice openvpn[7411]: UDPv4 link remote: [undef]<BR>Feb 27 10:43:34 (=
none) kern.notice openvpn[7411]: Peer Connection Initiated with 1.2.3.4:593=
81<BR>Feb 27 10:43:35 (none) kern.notice openvpn[7411]: Initialization Sequ=
ence Completed</DIV>
<DIV><BR>client config :</DIV>
<DIV>&nbsp;</DIV>
<DIV>remote my.openvpn.server.example.org 4500<BR>dev tun1<BR>ifconfig 10.4=
.0.2 10.4.0.1<BR>route-gateway 10.4.0.1<BR>redirect-gateway def1<BR>ping 10=
<BR>ping-restart 60<BR>verb 1<BR>mute 5<BR>cipher none<BR>secret key 0</DIV>
<DIV><BR>server config :</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; port 4500<BR>&nbsp;&nbsp;&nbsp; dev tun2<BR>&nbsp;&=
nbsp;&nbsp; ifconfig 10.4.0.1 10.4.0.2<BR>&nbsp;&nbsp;&nbsp; secret /etc/op=
envpn/key_1 1<BR>&nbsp;&nbsp;&nbsp; ping 10<BR>&nbsp;&nbsp;&nbsp; ping-rest=
art 60<BR>&nbsp;&nbsp;&nbsp; ping-timer-rem<BR>&nbsp;&nbsp;&nbsp; verb 1<BR=
>&nbsp;&nbsp;&nbsp; mute 5<BR>&nbsp;&nbsp;&nbsp; cipher none<BR>&nbsp;&nbsp=
;&nbsp; persist-key<BR>&nbsp;&nbsp;&nbsp; persist-tun<BR>&nbsp;&nbsp;&nbsp;=
 user nobody<BR>&nbsp;&nbsp;&nbsp; group nogroup<BR></FONT></DIV></DIV></BO=
DY></HTML>=

------_=_NextPart_001_01C76BBF.8F17C72F--

