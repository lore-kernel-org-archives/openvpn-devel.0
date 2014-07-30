Message-ID: <53D8C0CB.6090905@...1926...>
Date: Wed, 30 Jul 2014 11:54:19 +0200
From: Julien Muchembled <jm@...1926...>
MIME-Version: 1.0
References: <1406654929-6079-1-git-send-email-jm@...1926...>
	<20140729185713.GX1118@...1296...>
	<53D803BE.1040500@...1926...>
	<20140729210527.GY1118@...1296...>
	<53D84749.6060601@...1926...>
	<20140730054253.GC1118@...1296...>
	<53D8BAEE.7030402@...1926...>
	<20140730093748.GH1118@...1296...>
In-Reply-To: <20140730093748.GH1118@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --mtu-disc option with IPv6
	transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Le 07/30/14 11:37, Gert Doering a =E9crit :
>> Although I didn't try all MTU-related options of OpenVPN, it seems to=20
>> ignore EMSGSIZE.=20
>=20
> Well, handling that error will not lead anywhere, as it just tells us
> "the packet got lost, because it was too big".

Maybe not such a good idea but could it somehow be translated to tun/tap in=
terface, like returning an ICMP packet ?

>> What I can say is by only adding '--mtu-disc yes' option, the MTU of the=
 tun/tap interface remains 1500 and does not change automatically to anythi=
ng else. If a packet is small enough for mtu=3D1500 but too big for the und=
erlying network, then it's simply dropped.
>=20
> We won't change the interface MTU (because on half the platforms, we can'=
t,
> or it won't have an effect), but OpenVPN is likely to fragment internally=
.=20=20
> So "--mtu-disc yes" would need to go along with "--fragment".

I've always been dubious about the efficiency of automatic fragmentation (w=
herever it happens) because it would often split each big packet into 1 big=
 (but little smaller) and 1 very small.

So I would leave a way for OpenVPN users to disable IP fragmentation (proba=
bly to do MTU discovery) but not automatically enable --fragment (which wou=
ld become totally useless since the MTU of the tun/tap is small enough).

