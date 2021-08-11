Date: Wed, 11 Aug 2021 18:55:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YRQA6duboZXtB9do@...1296...>
References: <20210810061644.20353-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zy1h72ZbROxAghB8"
Content-Disposition: inline
In-Reply-To: <20210810061644.20353-1-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH] Replace deprecated mbedtls DRBG update
 function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--zy1h72ZbROxAghB8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 10, 2021 at 08:16:44AM +0200, Max Fillinger wrote:
> The function mbedtls_ctr_drbg_update is deprecated as of mbedtls 2.16
> and is superseded by mbedtls_ctr_drbg_update_ret, which returns an error
> code. This commit replaces the call to the deprecated function with the
> new one and logs a warning in case of an error.
>=20
> For older versions of mbedtls, we add a compatibility function that runs
> mbedtls_ctr_drbg_update and returns 0.

For the record, this breaks 2.14.*1* - which does have this function,
and the static-vs-non-static prototyping causes a compile error.

So, followup patch needed.=20=20

2.14.0 does not have it, and from what I understand, 2.15.x does not
have it either.  But maybe we do not care for 2.15

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zy1h72ZbROxAghB8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhFADoAAoJEB2Cnv7KVigSDvIMAIM2CUfoj5pzZE1DCHEPG/+o
5QctGGrYkPbZI9nspkEWvl7I28RnHopDVw17iPdLy2HVI/f0meYEffBolPC0FswX
mUvOpcefR1yUJW/OM9vwBAJYjuN7+8/rRgM2FklkwahCsO/x7Lw73WjBPUdDVpL2
TOp2zJfy7jDDg1tmk+QXWnMRZm9groRG19oBlpm3aejDgT0erOWGnJen1Rf1EuCJ
5i5XCxBGWy0E2L2NohZIbD+mhG5JDsSfhjlGWW0xk5kKENJe+8JSJ2oBqTYFCuz9
ichqPdqATqhpNJz3sYWSnbxXNKV3RBAJPOGktNrE/qm4Vlhp7JOp8svvpKp1lKdK
Fy5L5dDWG6sd4Od1P6Fx9jNblqPaWqZMiOs9LZ/wYrCSOjs8wGZqu1WUSMHRuwj0
5OhANvcVoIpOEj3qVA4sVfLR3sSosKiU/72gTHzs8QiraajWGcmbbm0z9xS8ifsr
Rd4m2uMMFZayavSNpPujGksld+pGZ0sR2hcT+twbBw==
=Ug0+
-----END PGP SIGNATURE-----

--zy1h72ZbROxAghB8--

