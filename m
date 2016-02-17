References: <5052BCEE4D2D42CBABE65B18A5C7C795@...2089...>
	<56C194ED.9030508@...515...>
	<CAFHpkQFV7wgy01o2hH+3kAGR79HiNaNKWXNpWPOLZMdvGxb29Q@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56C4A43C.5010100@...515...>
Date: Wed, 17 Feb 2016 18:47:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFV7wgy01o2hH+3kAGR79HiNaNKWXNpWPOLZMdvGxb29Q@...278...>
Subject: Re: [Openvpn-devel] Micro-sha-ft
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

We just got an EV certificate token thingy, which certainly does not=20
have SHA-1. The problem is that the token makes it impossible to safely=20
automate the signing process. So basically we have to turn off automated=20
signing in openvpn-build and just sign the files we absolutely have to.=20
This probably boils down to

openvpn-installer-*.exe
tap-windows6 drivers
tap-windows6 installer

It would be nice to sign openvpn-gui, but then openvpn-build would have=20
to fetch a pre-built and signed openvpn-gui.exe instead of building and=20
signing it itself.

According to Microsoft documentation[*] we _could_ continue using non-EV=20
certs (+ automated signing) for non-driver code, but that would probably=20
mean paying for two certificates. I'll ask around to see if this is=20
indeed the case.

I'm not entirely sure all this "increases security" which Microsoft=20
claims to be the goal of EV certs. Currently we sign every single=20
library and binary we distribute (including OpenSSL, LZO, etc) already,=20
and soon we can only sign a subset.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[*]=20
<https://msdn.microsoft.com/en-us/library/windows/hardware/hh801887%28v=3Dv=
s.85%29.aspx>

> we sign our software here. actually it works like SHA-2 sign + SHA-1
> timestamp.
> we use "signtool" for that. I'll have a look how to do that with openvpn
> release system
>
> 2016-02-15 14:05 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>>:
>
>
>
>
>     > I presume you are aware but just in case
>     > microsoft no more SHA1 authenticode
>     >
>     >https://forums.openvpn.net/topic20987.html
>
>     Hi,
>
>     This was not entirely unexpected. I'll try to get this fixed this week
>     and then release new installers. I suppose Microsoft has finally fixed
>     Windows 7 so that it can handle SHA-2.
>
>     Thanks!
>
>     --
>     Samuli Sepp=C3=A4nen
>     Community Manager
>     OpenVPN Technologies, Inc
>
>     irc freenode net: mattock
>
>     ---------------------------------------------------------------------=
---------
>     Site24x7 APM Insight: Get Deep Visibility into Application Performance
>     APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
>     Monitor end-to-end web transactions and take corrective actions now
>     Troubleshoot faster and improve end-user experience. Signup Now!
>     http://pubads.g.doubleclick.net/gampad/clk?id=3D272487151&iu=3D/4140
>     _______________________________________________
>     Openvpn-devel mailing list
>     Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>



