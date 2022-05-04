Date: Wed, 4 May 2022 10:45:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YnI9MwyRIxiqZpWr@...1296...>
References: <20211029112407.2004234-1-arne@...1227...>
 <202111051603.1A5G3LIe086560@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="98SdiYdwlxuYUxv8"
Content-Disposition: inline
In-Reply-To: <202111051603.1A5G3LIe086560@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add insecure
 tls-cert-profile options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--98SdiYdwlxuYUxv8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 05, 2021 at 05:03:21PM +0100, Gert Doering wrote:
> (Client-side) tested with 1.1.1 and 3.0.0.
>=20
> Without options, my sha1 certificates still fail for the 3.0.0 build,
> and *with* "tls-cert-profile insecure" it works.
>=20
> Your patch has been applied to the master branch.
>=20
> commit 23efeb7a0bd9e0a6d997ae6e77e0e04170da3e67
> Author: Arne Schwabe
> Date:   Fri Oct 29 13:24:07 2021 +0200
>=20
>      Add insecure tls-cert-profile options

Based on the discussion on IRC (just now) I have applied this to 2.5
as well - Ubuntu 22.04 builds with OpenSSL 3.0.x, and without that patch,
existing user setups with sha1 certs will break and no option to work
around that.

commit 7b1b100557608db8a311d06f7578ceb7c4d33aa6 (HEAD -> release/2.5)
Author: Arne Schwabe <arne@...1227...>
Date:   Fri Oct 29 13:24:07 2021 +0200

    Add insecure tls-cert-profile options
    (cherry picked from commit 23efeb7a0bd9e0a6d997ae6e77e0e04170da3e67)


gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--98SdiYdwlxuYUxv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJicj0yAAoJEB2Cnv7KVigS9QIMAKOALYHvOaRmnroGT8iLepyl
twdhXfWvZdY0sYy2wvQe+KLIP0w/hwBBh8zwW+rTcx6sXFXYThnDhdTYVFriEtcg
YaQG02ujvwVCX3+FXcJma7ImT+d2lJ4+1xSO36ncyvZwQMcE61uBJ/UNL9PurAzL
Fy3DalSyTu/i4Rp1LouJZ3isJetp7mtQV1hfGnn4dRcDlnb+SHgAmhcKZSKKov6K
Z7OX7BbKJTATXlHU+li5wZwzN+gKi88SAZU+PEWUsPxjYex2ZJmQNUlMpREVcGNH
YMKq7KGdto55Vw1BtSKofce185sbx8qYvcE1QiazR9k1BSaH8Heb6snhx9drHgR9
DpdPgop1DLW+YiQDIKmmy8GKIR3Kl/RyVeauEN2+KYLpRqI8ySvJEz/jJyg5r+aF
gGjrgz1qnjCLvC6nb2r/bE1d4gBIHYO74qDx5dGtUbCVJmPdP6SdIpFvmpec4WnJ
8fDzwYTuvVjDZPvnp6Qb9A9i78fLTqQzk5zW0ZapEw==
=Iidh
-----END PGP SIGNATURE-----

--98SdiYdwlxuYUxv8--

