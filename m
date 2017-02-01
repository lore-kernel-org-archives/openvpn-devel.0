Date: Wed, 1 Feb 2017 16:33:55 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170201083355.GT12187@...2182...>
References: <20170131182241.10590-1-a@...2181...>
	<CAKuzo_h69pmh=+jG=xPdprDSPLxR0Z9QhBnD_eM5bh1PUYsKYw@...278...>
	<20170201030455.GN12187@...2182...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <20170201030455.GN12187@...2182...>
Subject: Re: [Openvpn-devel] [PATCH] reload HTTP proxy credentials when
 moving to the next connection profile
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 01, 2017 at 11:04:55AM +0800, Antonio Quartulli wrote:
> > That said, there is one issue with this approach. Looks like SIGUSR1
> > restarts will now always prompt for proxy password, which is not proper.
>=20
> Right! Thanks for pointing this out!

Actually I'd like to understand the expected behaviour: if SIGUSR1 is issue=
d,
openvpn should re-read the file containing the HTTP proxy credentials, but,=
 if
stdin was specified, it should not ask the user for user/pass again ?

So in case of stdin the only way to re-enter the user/pass is to restart
openvpn?

What's your opinion on this?

--=20
Antonio Quartulli

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYkZ1wAAoJEJ6F1zG2JyOs05kQAINYXlloq0SpOVG6koKzUrE0
0WpRYZzedoMGjSSoNjLbgPk4vIPKSFfdrxT5TGh60zBAwNJelsWUHJ6MvIS+qA7H
yza2czJ5M50xCg264kr9yCAtrPihzRh2Hkk9uIK+xjMFX56388CIC9TDyVdcQcB4
58Dn7IELl0w0bircduVyvPfrT92201Av9PyJ9L5V1ycoh3t4dnTBCiPSzOrljrtZ
kqr3PEcN4oPBSumTYB9B0/V+6Lk2Eo8O9jiD55SF+QiLmqQe5S3fGXzPPlJOuIYw
xU4LZbjoKQWquNNzGTQkfu/s8EPrCwZKgUtBAvYSeQKXIo9uvRNL4txfQSlUGUhU
TBwdK4LLE5orc0y9Hng1HH99kjr4bDIN/trIhhFruCiaFRVWSurSMVX64J1at30P
kxVl4rLwQ67h8zGqH47ch32mpDrm8YGFO3ChTjSOUN//uKlwxOqnhlIGQ7npclMk
Ph8JOTzq2ubq3UDPYmHayhvaS47UrmfiDfYhUE3PR5m7xNYVnVOCUbbTz0h5a3Oe
GkPK6aE+NiiBzfIg0ZooU/LTE4e3Eu0PAFd1NUEVWFdb1wq2wjgWHwZ1HyIF/hbr
gToij1oBXAVhmlMyo1+G4u0wljt0eo0sOMi99vsQM4wArb0Jy/6L4zHkN5PNMGEJ
pBcwrqfCGnN0lZZ2CNeD
=95vE
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--

