Date: Wed, 6 Nov 2019 15:28:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191106142830.GI40538@...1296...>
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
 <20191103204613.GE40538@...1296...>
 <CAGnHSE=LcwX6hxHM2sdpWRP6cKyQiuhtc4ZUG2H1rdu-CNHOqQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z8Ydz/NZAVzoOg+6"
Content-Disposition: inline
In-Reply-To: <CAGnHSE=LcwX6hxHM2sdpWRP6cKyQiuhtc4ZUG2H1rdu-CNHOqQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Yan <tom.ty89@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--z8Ydz/NZAVzoOg+6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 04, 2019 at 05:10:12AM +0800, Tom Yan wrote:
> So in master, when net_addr_v4_add is called in tun.c, which
> net_addr_v4_add (networking_iproute2.c or networking_sitnl.c) is
> actually used depends on how openvpn is built, right?

Right.  It's either "default options" (-> sitnl.c) or "--with-iproute2"
(->networking_iproute2.c).

2.4 has "ifconfig or iproute2"
2.5 has "direct interface to netlink" (sitnl) or "iproute2"

> I think the `if (broadcast)` condition in the one of
> networking_sitnl.c needs to be changed to `if (broadcast && prefixlen
> < 31)` as well.=20

I think this is more something the caller needs to decide "do I want to
set a broadcast address or not" (so, if /31, set broadcast =3D NULL).

OTOH, I'm still waiting for someone to tell me why we'd want to set
a broadcast address in the first place :-) - Antonio, you know the
kernel side better.  Why would anyone explicitly configure the standard
broadcast address ("all-ones in the host part of the relevant subnet")?

> Also it seems that net_addr_v4_add is called wrongly
> in tun.c with `&tt->remote_netmask` instead of `&tt->broadcast` as the
> last argument.

I tend to agree with you here.

Antonio, yours :-)  (though I ACKed it) - tun.c, line 1092.

We do mix up "remote" and "netmask" in the shared "remote_netmask"
variable, but "broadcast" is independent of that...  and OpenVPN
actually tells us so, in the "topology subnet" case...

   net_addr_v4_add: 10.194.6.2/24 brd 255.255.255.0 dev tun1

Linux seems to accept this, but it has no further consequences ("all
my tests pass")...

$ ip addr show dev tun1
520: tun1: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc pfifo_f=
ast state UNKNOWN group default qlen 100
    link/none=20
    inet 10.194.6.2/24 brd 255.255.255.0 scope global tun1
       valid_lft forever preferred_lft forever

... but it's still not correct.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--z8Ydz/NZAVzoOg+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdwtiMAAoJEB2Cnv7KVigS7yQMAKc+SXcCmdsqc69suKpTRnij
pErSG4z3YBH2rhemsRnLXVTQ+mqAR9StJp6l5wgF4FJTUFNpxMwBPy2aVs8o/NtC
hW0+0mZBgWXnsxiOpOKfRlbPrxtEcYfVYsKvSTTt+giw5T73HGSe0/A/up1j55Vx
KmxJuXNlBkxzK4GjUdzYWw9yk+RmQBIopRMEIUSGgi11aMA8JytATsUVM4eikVTf
EenI4K5yFvkf1Cp0DtA0QwRZmiH+RoakEnxz6kB4Mmo4XSfWhgmUojfm4wHb6KTf
bRBjSWI7/kX6ylk0rcXUeQVcF8+XPbwayfZhvKeogtNeeJldPGKqsq195d+UXfDs
fsLUyZhUgOLappur+6KXGnYkz5whpmOlbXZ8dwIODcPUcgU9WaWjfRuYlGp1IAcB
Szzg2I22jVq+cJfmKr1jS7aP59ADgUzZlgye57P/0RYEUvWmYgTByJ9m3TT1O7b4
RZA7lNC0qaokJwOTKgBGV1RAUSHdz5Xm5jADWDUEog==
=rtpN
-----END PGP SIGNATURE-----

--z8Ydz/NZAVzoOg+6--

