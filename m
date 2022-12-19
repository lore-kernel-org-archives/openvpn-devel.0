Date: Mon, 19 Dec 2022 13:17:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6BWREoTzScGJNI+@greenie.muc.de>
References: <20221218195810.1216368-1-selva.nair@...277...>
 <d67c75a4-99cd-83b0-c227-3a01549a26fd@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+5marlt/DB44SDZ8"
Content-Disposition: inline
In-Reply-To: <d67c75a4-99cd-83b0-c227-3a01549a26fd@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Reduce default restart pause to 1 second
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

--+5marlt/DB44SDZ8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 19, 2022 at 01:12:32PM +0100, Arne Schwabe wrote:
> Am 18.12.22 um 20:58 schrieb selva.nair@...277...:
> > +--connect-retry n [max]
> >     Wait ``n`` seconds between connection attempts (default :code:`5`).
>=20
> you were close. but forgot to change the 5 in the next line to also say 1.

I can do that on the fly ("not a code change") if you agree to the
change otherwise - since Selva quoted you here... :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+5marlt/DB44SDZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjoFZEAAoJEB2Cnv7KVigSCqAL/3LwuQ2uIvO5QtpT56IVS4wD
3BZkePyvT9ouUpBD4i39Ulg9NlAWxGnZxiBG8gu+xqg2lSNhTiOgKjCl7BtVmxuX
u/CNGoqgwdBHg6inScbAADWn3Wzat9EWUE7bIn7xb8Y0wXOomw9OszIJ0iFHJ/zx
aw+dpK1l9vUagW4C0BInDv9jCvZd2qReIEsoxSBvuf+Fpj5o00eic+A0WvQCJf68
ihUHmeqsqHoMoXmWppzwkfNfQdC9Rw2QR6BD6PlwSViQRSk1lu2YqvA1wZ4eU2wZ
aYHq92GhKTMIovR2gHXKvxFWX9rc94Gml3bMkImmjXFTawBqqlO1lsN3Lx5W/VfH
rJvgaNCg4UczHUhdKFa2kO6dgM3zUc10vSJCDmJQjpHOgRMeMMz/+hCXl02QtG6D
GD+MS3YKltOLtOmT87SLqbP8Vkr8NijaBkJwLB75INX7mqu3HcT1lUPUVKlT5H3K
dl6QOu/Y7ZuG45DXPvPKq0j6mSGWkNBR1RztaTxELg==
=xjSi
-----END PGP SIGNATURE-----

--+5marlt/DB44SDZ8--

