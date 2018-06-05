Date: Tue, 5 Jun 2018 20:52:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180605185232.GQ57262@...1296...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1X+6QtwRodzgDPAC"
Content-Disposition: inline
In-Reply-To: <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1X+6QtwRodzgDPAC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 06, 2018 at 12:22:31AM +0800, Antonio Quartulli wrote:
> Why is it !ipv6 by default in the first place?
>=20
> I'd rather keep default behaviours as they are now, to avoid messing up
> the user experience.
>=20
> However, I also understand that if there is no IPv4 and gateway-redirect
> is specified, then the user wants a default route for IPv6.
>=20
> Maybe we should keep the current behaviour as it is (!ipv6 by default)
> but print a warning when only ifconfig-ipv6 is provided?

I think for compatibility with existing configs, "redirect-gateway" with
no extra arguments (or just the old ones, "def1" etc.) should be "ipv4",
as it is today.

If there is no IPv4 address configured, redirect-gateway (ipv4) should
log a notice ("NOTICE: --redirect-gateway without the 'ipv6' flag will
handle IPv4 only.  No IPv4 on tunnel, so not redirecting anything" or
something like that).


Eventually we might want to change it to do

 --redirect-gateway "with no IPv* flags" =3D IPv4+IPv6
 --redirect-gateway ipv4 (def1|local|...) =3D "only IPv4"
 --redirect-gateway ipv6 =3D "only IPv6"


What we have today ("unless there is a !ipv4, it's always ipv4") is=20
historic due to "the ipv6 code was expected to change as little of the
existing behaviour as possible".  We can be a bit more daring nowadays :)


We might also merge Arne's block-ipv6 patch some day :-) - and add=20
the corresponding block-ipv4 functionality.

> > [ Selva ]
> > May be there are more such nuances -- this patch will need some thoroug
> > testing before being ready for review.

Yes, definitely.  There will be interesting surprises.  I'm not sure we
can catch everything before review/merging, though... but I'll try my
best ;-)

> >> Of course we'll also need to check if typical consumers of the managem=
ent
> >> interface explode if you're not giving an IPv4 address to them...
> >>
> >> Selva, Jonathan, how will our GUI and Tunnelblick handle that?
> >=20
> > Windows GUI uses configured IPs only for logging and display so I
> > don't think it will complain, let alone explode. If any changes are
> > needed, likely to be minimal. We have to just keep the format of
> > reporting configured IPs unchanged even if some elements may be blank.

When Antonio sends the v2, I'll do a windows build and see what happens.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1X+6QtwRodzgDPAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbFtvvAAoJEB2Cnv7KVigSdwIMAKpuOTmWiV725+ZHP+zJfyKx
QqrGCl3R6irfsxf8ds45d9TiXMaYXK8qH6qLdwhpaJRc5l6q5J4LDRFS/qYGx6vf
1N1FmmWtNhgGMrCX2W7MM1crfMwIuzA63fVFi598Z5724DBJB+HlNIgIe0f/5gau
HIgFWzp2YwEjRbiKXVXdHY4vvsvNM15+eTIsVyJTxduLxl5+9ruWGSfCK4IPj4qG
CBN5kJGSVoc1t1qG18j5776K4hbNXZWRl/IbdV85VQSxFiWIASu1Zi8uQeKtrVrK
0tEGCKr43XgZ2m8MZUG6Q2yckartC2K4XfCR5e07XfEuY/YNIBXVVR1a6QFjUMXp
9x4Z7LOcF2RxcavMeNEws1PYMobHO8BLSxlWUJVspGnLYJ6Gkflqo58dk1gRbbBu
5w/2CaSWBDWhlMIcLpEeh2KLDBqhOSxz0sUqPQVdtWPKW/INc7yCdYUtoyxigcEM
OI9dOU+TVdcwtX/GgNxeHQvDpdstMT5OFwG26734GA==
=dGmn
-----END PGP SIGNATURE-----

--1X+6QtwRodzgDPAC--

