Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <20180401193456.GI69387@...1296...>
Date: Sun, 1 Apr 2018 19:12:26 -0700
Message-Id: <8EB0586C-A6D5-48D8-AC4A-35A0836F3197@...277...>
References: <20180401063058.23913-1-gert@...1296...>
 <CAKuzo_gRyd++KVmH=iGALbz0kjPiXLhK6DkAGA0Uu0mcV6RG8A@...278...>
 <20180401153422.GE69387@...1296...>
 <CAEsd45QQ-j=R9mWDuKkpvwgFMnFY4sSUdoZtYodKxxio8iR+6w@...278...>
 <BC0A595E-A0E3-4355-BAB3-37E9FA75DD37@...277...>
 <20180401183928.GH69387@...1296...>
 <9FAA40DB-C459-47AF-92B3-B02FD769886E@...277...>
 <20180401193456.GI69387@...1296...>
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

Gert,

Without invalidating the reason for your frustration, I am breathing a sigh=
 of relief.

As a complete aside, in some ways ipv4 is actually more useful to me in my =
work. In a private network I can tell where in the network the traffic is c=
oming from. Even on the internet I can tell country, ISP etc. Very useful f=
or security ACLs etc. Unless I=E2=80=99m completely mistaken, I don=E2=80=
=99t believe this is easily done in ipv6.=20

BTW, a big thank-you to you and all the devs in the OpenVPN project!

Marvin

> On Apr 1, 2018, at 12:34 PM, Gert Doering <gert@...1296...> wrote:
>=20
> Hi,
>=20
>> On Sun, Apr 01, 2018 at 12:21:53PM -0700, Marvin Adeff wrote:
>> I had not considered the extra work and code required to maintain both v=
ersions. But I get it now. Here is the unfortunate position this puts us in:
> [..]
>=20
> Well, that part of my e-mail was a bit of frustration speaking - I've
> been advocating IPv6 for over 20 years now, and while large parts of
> the access networks are offering IPv6 now, other parts are still being
> *built* with IPv4 only, or stubbornly stick to IPv4 only...  thus, double
> work everywhere, not only in OpenVPN, seemingly for a lifetime.
>=20
>> So if OpenVPN lost ipv4 support anytime soon, we would be in a world of =
hurt.
>=20
> As far as OpenVPN is concerned, I am not aware of any plans to remove=20
> IPv4 support.
>=20
> The extra code adds some maintenance and testing effort, but since this
> is all in place now (especially the test setups with "connect over IPv4
> or IPv6" and "send IPv4 and IPv6 packets through the test VPN") it would
> be more work to rip out IPv4 now... :-)
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

