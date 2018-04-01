Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <20180401183928.GH69387@...1296...>
Date: Sun, 1 Apr 2018 12:21:53 -0700
Message-Id: <9FAA40DB-C459-47AF-92B3-B02FD769886E@...277...>
References: <20180401063058.23913-1-gert@...1296...>
 <CAKuzo_gRyd++KVmH=iGALbz0kjPiXLhK6DkAGA0Uu0mcV6RG8A@...278...>
 <20180401153422.GE69387@...1296...>
 <CAEsd45QQ-j=R9mWDuKkpvwgFMnFY4sSUdoZtYodKxxio8iR+6w@...278...>
 <BC0A595E-A0E3-4355-BAB3-37E9FA75DD37@...277...>
 <20180401183928.GH69387@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Depreciate IPv4-related options.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "Jonathan K. Bullard" <jkbullard@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Ok, I=E2=80=99ll only discard the irate part  ;-]

I had not considered the extra work and code required to maintain both vers=
ions. But I get it now. Here is the unfortunate position this puts us in:

We use OpenVPN for connection from 1000=E2=80=99s of devices located at cus=
tomer facilities back to us. These devices/software have a lifespan of grea=
ter than 10 years and most are extremely expensive (not easily replaced). S=
o a large quantity are incapable of ipv6 (and frankly many customer facilit=
y networks are not fully functional with ipv6). Also some of the devices/so=
ftware at our end that interface with those legacy customer devices are als=
o not ipv6 capable.=20

So if OpenVPN lost ipv4 support anytime soon, we would be in a world of hur=
t.  There is much more detail about all this, but I wanted to keep this a s=
hort email.=20

Thanks for listening.=20

Marvin

> On Apr 1, 2018, at 11:39 AM, Gert Doering <gert@...1296...> wrote:
>=20
> Hi,
>=20
>> On Sun, Apr 01, 2018 at 11:19:57AM -0700, Marvin Adeff wrote:
>> Think of us poor mail list lurkers. Practically gave this one a heart at=
tack!  Not having seen that private reply, I hope that means I can discard =
the long-ass (and quite irate) reply I was working on?
>=20
> Please share!
>=20
>> (Sent from an ipv4 address)
>=20
> Whatever journey OpenVPN takes, the Internet as a whole will need to=20
> either finish the move to IPv6, or give up and return to IPv4-only -
> running dual-stack is just too expensive in the long run.  Like, twice
> the amount of code needed for routing, address parsing, firewalling, ...
>=20
> gert
> --=20
> "If was one thing all people took for granted, was conviction that if you=
=20
> feed honest figures into a computer, honest figures come out. Never doubt=
ed=20
> it myself till I met a computer with a sense of humor."
>                             Robert A. Heinlein, The Moon is a Harsh Mistr=
ess
>=20
> Gert Doering - Munich, Germany                             gert@...1296...

