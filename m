From: =?UTF-8?Q?booyakasha?= <booyakasha@...1309...>
In-Reply-To: <4B8BB647.2020804@...1114...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<4B8BB647.2020804@...1114...>
Mime-Version: 1.0
Message-ID: <23627cf8.610acd4b.4b8bc540.d2023@...1309...>
Date: Mon, 01 Mar 2010 14:46:40 +0100
Subject: Re: [Openvpn-devel]
	=?utf-8?q?Openvpn_2=2E1=2E1_bad_tcp_performance_b?=
	=?utf-8?q?ut_good_pingwhen_-l_1472_=28with_packet_size_=3D_MTU=29?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


I spend much time on this problem and it is not simple question of configur=
ation to be=20
discussed on users forum. I've tried all sort combinations of MTU sizes fro=
m extremally small to very big all settings regarding MSS, RWIN, mssfix and=
 so on... I'm not accuseing anyone because of incompetency but many people =
disvovering this kind of problems was left without a help or told only to u=
se UDP protocol. When i switch to UDP everything works fine byt it is not a=
 solution. I understand problems with tunneling TCP traffic through TCP tun=
nel but it doesn't answer why it multiplies my ping 50 times. And why packe=
ts of exact size of MTU are transmitted flawless? Maybe there is a way to w=
rap all incomplete packet to match MTU size an push it faster? Of course yo=
u can always say that UDP is better but so weak performance of TCP is very =
hard to bare.

My config client and server is same i'm not using comp-lzo to exclude all e=
xternal factors. We are using Windows XP / Vista.

client
dev tun
proto tcp-client
remote ...
ca
cert=20
key=20
verb 5
route-method exe
route-delay 2
tun-mtu 1500

simple as it is.. and really it is not a problem of MTU or mss.

Best regards
Ucho






> Could this be related to this?
>=20
> <http://sites.inka.de/~bigred/devel/tcp-tcp.html>
>=20
> And in the moment you exceed the MTU size (1500) in your ping requests,
> you will produce more TCP packets.  You might even hit some issues with
> the Nagle algorithm as well? (have you tried with --socket-flags
> TCP_NODELAY ?) ... As you have a strict firewall policy, could it be
> that this causes some issues?
>=20
> Or it might be that you need some tuning on the --link-mtu, --tun-mtu or
> - --tun-mtu-extra?  Have you tried running an OpenVPN client with
> --mtu-test?
>=20
> Providing more information about your configuration and what you have
> tried so far would also be helpful, and not just a rather nasty
> accusation.  In many cases, what you complain about here are often
> connected to configuration issues.  Even though, TCP will never ever be
> as efficient as UDP.
>=20
> You also don't state if you are using TUN or TAP mode (again,
> configuration file would help), where TUN is known for having better
> performance and less overhead than TAP.
>=20
> So, to sum it up ... you don't provide much information for us to work
> on ... and to be frankly, this discussion sounds to more belong to the
> openvpn-users@lists.sourceforge.net list and not the development list,
> at this point.
>=20
>=20
> kind regards,
>=20
> David Sommerseth


