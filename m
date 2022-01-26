Date: Wed, 26 Jan 2022 14:30:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YfFM6Sw1F0sy9PBO@...1296...>
References: <20220125025128.2117-3-selva.nair@...277...>
 <202201261326.20QDQkif058192@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XGQwWiclnRn43DBd"
Content-Disposition: inline
In-Reply-To: <202201261326.20QDQkif058192@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Support PSS signing using
 pkcs11-helper >= 1.28
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--XGQwWiclnRn43DBd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 26, 2022 at 02:26:46PM +0100, Gert Doering wrote:
> I'm not claiming to understand any of this... so I have test compiled
> on Linux/3.0.1, and also bumped my MinGW test rig to pkcs11-helper 1.28
> (though only 1.1.1 yet).  So maybe I tested something useful, or maybe
> not... but at least these combinations still compile fine :-)
>=20
> Your patch has been applied to the master branch.

Oops.  I did not look closely enough, saw "Arne ACKed 1/3 and 2/3,
and this one is complex, compiles fine, and Arne also sent something
in reply" but it turns out it was not an ACK but concerns.

(*If* it breaks, it will break for very cases unknown today, so it's not
as bad as this sounds, but still, meh)

Sorry.

Selva, can you send a followup patch if you share Arne's concerns here?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XGQwWiclnRn43DBd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh8UzpAAoJEB2Cnv7KVigS6iML/3JRF9gygrj1FVfewt2Nc1QY
kHYyfVqq4tQEqYgbOqcXz541LJzmYXD+uf+yWnwjDE3znIai7nJqsM3QG8qvY3yC
XGkLpJ8e8xrMOg56jn4Zrj2yAIgEs89nEMF5y0Hd6DgA3J6s1WWggGljmUMKldbC
ijYTvjF85h7qihpbr4RKwS42uegshcK1tmzG26dTRCE7y7Z85JaJNgwMyMCEkJHR
6johkHcGI+LJTbV0VLLanG+r9Ftm0NlslbpujeeTT1rj0g70TMXB0BaY7HCSjxp8
eSErmgM+NEVcMFP00Nk1RayaH1gyTnTg8Kq7/ScfZJCCf6sqdzrgQiSvaA/IXQqj
QipZ6GxNc/SGdALnmIL7uKz2P8gk+EgMGU1jH4aVKKsZxZQkUZTUF5zL9AsxWUbn
HXJr1eUMavkNxZMVIXkbbFt28bEHELPk5JHcIaIEFGKbRqSHV3jB/a2kKVJMHHiK
pklnC+mZCNHUKD2YxSjdrY13DE+ZLz0SWReZ1Jr+Gw==
=Ycnp
-----END PGP SIGNATURE-----

--XGQwWiclnRn43DBd--

