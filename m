Date: Fri, 6 Jan 2023 21:19:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7iCSAacZKc++0bW@...1296...>
References: <20230105022718.1641751-1-selva.nair@...277...>
 <CAGyAFMVpquzshk7k9TfBTwTFKRNxBVkunn79TnBd2gpaoZSQwQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="v3L8IqgUNhvR5f/f"
Content-Disposition: inline
In-Reply-To: <CAGyAFMVpquzshk7k9TfBTwTFKRNxBVkunn79TnBd2gpaoZSQwQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Use IPAPI for setting ipv6 routes
 when iservice not available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

--v3L8IqgUNhvR5f/f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 06, 2023 at 03:44:24PM +0200, Lev Stipakov wrote:
> Compiled and slightly tested - pinged server's tunnel IPv6 address.

Do we call "route" for connect networks on Windows?  We do on some
of the platforms, but for those where we do not, this is not a good
test for "route add" functionality - as tunnel IP + subnet gets=20
setup via the "ifconfig-ipv6" part (implicit route for connected net).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--v3L8IqgUNhvR5f/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjuIJIAAoJEB2Cnv7KVigSgU0MAIMrHyWsiS4Is3H8VY0J1sSr
wxSpY7iZLN2UtiR0D8Wm6qotvIHsp2j2YIsgEhEo/tQOqsEMahvN2tKc7V5rD4uG
NKabg2J40CRe38jKzBh+vTFhEIx3SugaCI8bHH0lLYe0YxLRCnIcR8YiF1zgfErB
Y/2LQlD8me9R6W2bIpROv49fN7lHpfjaSMHP9EcI+dweG8SEtHGa1VDPuxkmsOmw
OI8KQ2itEQAc/tgEbMB3BSE1iaJLKv+aPOeXmCl0wxOCSE39sxWCAuCjDZ15SaIm
3PZGw7tevM8HoJ5ykOdUx+sICOpNQdKQp3EOZO+ak0v6BC5I+CvrT8m9+dPQepOs
P/4JdKYBaXZE/1oV7WEVJM/Wq0vfNP+0RTgDfFMiD3JiM1v2j33mmfLyxwCshUi/
3eaAIyQTW+rp3//Tf0nF7fc6Qb5mc2PlPgMUh4hFCShLwPLG1ltVa7AxxE6NMYWG
28BKDrB4/KrP2TFb1Qi993c6/jN0SZtzRKUE5XbHCA==
=KdQx
-----END PGP SIGNATURE-----

--v3L8IqgUNhvR5f/f--

