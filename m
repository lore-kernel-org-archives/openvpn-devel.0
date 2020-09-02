Date: Wed, 2 Sep 2020 14:40:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200902124057.GJ75094@...1296...>
References: <22a91a88-9555-ef6a-2941-22adfc7f9788@...515...>
 <2545808.mvXUDI8C0e@...2258...> <20200901201428.GH75094@...1296...>
 <c379e529-63a4-c4a0-29e2-fcf4260cc32c@...75...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Yc07lwn3HUDqPfE2"
Content-Disposition: inline
In-Reply-To: <c379e529-63a4-c4a0-29e2-fcf4260cc32c@...75...>
Subject: Re: [Openvpn-devel] OpenVPN 2.5-beta3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas =?iso-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--Yc07lwn3HUDqPfE2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 02, 2020 at 10:03:11AM +0200, Thomas Sch=E4fer wrote:
> Am 01.09.20 um 22:14 schrieb Gert Doering:
> > On Tue, Sep 01, 2020 at 08:07:20PM +0200, Thomas Sch=E4fer wrote:
> >>>      - IPv4-only VPN
> >> Typo?
> >=20
> > We can do that!
>=20
> Is it new in 2.5?

The --block-ipv6 command is new.

> Asking again, just to understand the difference
>=20
>   "IPv6-only operation"
> I can remove all IPv4-related config

Correct.

> and
>=20
>   "IPv4-only VPN"
> means better protection to prevent IPv6-leaks in an intended IPv4-only=20
> operation mode

No, the point is "--block-ipv6", not "IPv4 only VPN".  OpenVPN could
always do "IPv4 only VPN" :-)

The scenario here is:

 - user has IPv4+IPv6 at home
 - user uses a VPN service from a VPN provider that only does IPv4
   ("IPv4-only VPN")
 - user accesses www.google.de -> packets go via IPv6, bypassing VPN

if you have that scenario, you can either get a better VPN provider, or
use --block-ipv6 with the IPv4-only VPN provider, to prevent leaking.

(And thanks for the test result)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Yc07lwn3HUDqPfE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfT5LYAAoJEB2Cnv7KVigSYK0L/3e8pEjQ2ExkkBqw2NhBAc4I
C0sKmGJ0/L8qnFEE4WyqFqJnwRrpqKN4twJPoBIUZSqg4VIOJGsP/tsS3XI6I3MJ
/z7/sh7mCYMt45crh6WFMInZ7x5dGjSVISxVXGlj5xsOTtKcCCLXX/9ouYb7YFZn
4IVfT9snIML1IIdYS6igygIJnBXMASHVbvDZhCQnkFzdQzx8ZWu9Tby6EYQKQG1r
S6r10+FYZqmOXjqg4Iw1RK0SfW3HrVFkIt65Y2y2B0BysRO38VW9ASGCEb0PsX0x
39SwGin+AhWMVsRvTRj80kmUbx0qiePBpjUfV5AJ4ss5MAHNyC4SCXmkHxhKqFfE
X+vl26fKT7GivmpbLYcYXSl3lXZZBm5Ln23vufsbL0dYnoGDpVhFs7ATaLjx8oy4
y+/klCGjOeaPh6rExCQngh/5Q1RTdANrbhGErykEC3adLjNsiAIEE0vE1AU73lmK
V7eJf+N/Z/3HJHbP9KrKucKhsaCFrcB1BNhFTOkvig==
=Ftz9
-----END PGP SIGNATURE-----

--Yc07lwn3HUDqPfE2--

