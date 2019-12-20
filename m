Date: Fri, 20 Dec 2019 14:49:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191220134919.GL74723@...1296...>
References: <20191219223917.1614-1-simon@...2293...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lG9v85r552aFjg4G"
Content-Disposition: inline
In-Reply-To: <20191219223917.1614-1-simon@...2293...>
Subject: Re: [Openvpn-devel] [PATCH 1/7] tun.c: make Windows device lookup
 functions more general
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

--lG9v85r552aFjg4G
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 19, 2019 at 11:39:11PM +0100, Simon Rozman wrote:
> Since the introduction of Wintun, not all network devices in Windows are
> TAP-Windows6. Rather than returning a simple true/false answer, a couple
> of functions were reworked to return a corresponding struct tap_reg *
> or NULL instead.
>=20
> As it would make the code `tr =3D is_tap_win(...)` a bit awkward those
> functions (both static) were renamed to better reflect their nature.

For the sake of the archives:  Simon and Lev discussed these patches
on IRC today, came up with proposed changes, and Simon will send a new
"v2" series of all of them - so even if they have an ACK, I won't
apply them just yet.

Just to avoid confusion.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--lG9v85r552aFjg4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJd/NFfAAoJEB2Cnv7KVigStPwL/jV7le+i7183bSBaS9dO6WbA
YFkrq242IMlOo6RdQoHgSXlkpbjNMfJ4iXAzmYX0j/rMUfIqb4v8afT2MmPir6xB
h3eg9Xxdghe8jhvNlPbIxwm7DiZfUzbM62mrrQ6TS8ih4PEcOIcCDB3IkY7g5SuJ
OUDQUXffehq+ykcQZ72WGkpa+X4bO0fgFyfq7TW5lNaaw3FbPKdLKkYYFsf0qUtI
XoWLxhCT8c+EIeD2WLG10cJqzzWNa9HdGVgYfzTvZShv205xOJXAVJadvHHxDUnO
FPmxOnEHfREbzGogMval/PiEk2eBbnt4FeiLMDG9MzBBAMNXDChbNbn9ItCPP8Qu
SJLOAoyF1nCg6U/RMhc835+SrLK/WDNQiAZT1fYgizRcS4f/GA00uGYoQuVsiVjS
MTQrIvyDZ1JM6ccZqKXn8YJ3mZhtW9wP30jAqABdBwrlZdRQ89N4ItvxIKg5ySuf
Y4YciclpK+2/4C9qojZrQx4HmPh2o98lYYx3y05Xfg==
=JiUy
-----END PGP SIGNATURE-----

--lG9v85r552aFjg4G--

