References: <CABJvA8nQoZbdjYrfMvR+bt5xPXOT4a-O3gkE99t0JWC2OjEyNQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <fd539e67-4669-1530-14d0-0aee530e3ce6@...2080...>
Date: Wed, 24 Feb 2021 22:09:58 +0100
MIME-Version: 1.0
In-Reply-To: <CABJvA8nQoZbdjYrfMvR+bt5xPXOT4a-O3gkE99t0JWC2OjEyNQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cykJ32DfufvRoMVvm3UAimGJmfhhOfIG2"
Subject: Re: [Openvpn-devel] [Patch] Add argument from openvpn2 to be
 ignored in openvpn3 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: romain loutrel <un.romain.loutrel@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cykJ32DfufvRoMVvm3UAimGJmfhhOfIG2
Content-Type: multipart/mixed; boundary="7VgTCSH983KE5hZA8WEqtKjY8sha6XJdG";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: romain loutrel <un.romain.loutrel@...277...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fd539e67-4669-1530-14d0-0aee530e3ce6@...2080...>
Subject: Re: [Openvpn-devel] [Patch] Add argument from openvpn2 to be ignored
 in openvpn3 client
References: <CABJvA8nQoZbdjYrfMvR+bt5xPXOT4a-O3gkE99t0JWC2OjEyNQ@...278...>
In-Reply-To: <CABJvA8nQoZbdjYrfMvR+bt5xPXOT4a-O3gkE99t0JWC2OjEyNQ@...278...>

--7VgTCSH983KE5hZA8WEqtKjY8sha6XJdG
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 13/02/2021 21:25, romain loutrel wrote:
> Hi I created today the bug ticket:
> https://github.com/OpenVPN/openvpn3-linux/issues/36
>=20
> I have a patch to fix the problem (accept but ignore old parameters
> from openvpn2 in openvpn3)
>=20
> I hope I made everything correctly.
>=20
Thanks a lot for your patch.  It has been applied to git master and will
be part of the next release.


commit b1a270062e3d35dcf73f57340bd85fcb3d84b4cc
Author: Romain Loutrel <un.romain.loutrel@...277...>
Date:   Sat Feb 13 21:25:43 2021 +0100

     python: Add --mute, --route-delay and --route-method to ignored options
=20=20=20=20=20
     These options are not used nor supported by OpenVPN 3 Core library nor
     OpenVPN 3 Linux.  The logging is handled very differently from
     OpenVPN 2.x, so the --mute option does not serve any purpose.
=20=20=20=20=20
     The --route-delay and --route-method options are typically used on
     Windows to switch how routes are configured and delay the setup so the
     TUN/TAP interface has managed to be initialized first.  This is not
     needed on OpenVPN 3 Linux, as the openvpn3-service-netcfg service takes
     care of all of this and doing things in the right order and time.
=20=20=20=20=20
     Since all of these three options does not break any configuration, they
     will just be ignored instead of being handled as an error.
=20=20=20=20=20
     Signed-off-by: Romain Loutrel <un.romain.loutrel@...277...>
     Signed-off-by: David Sommerseth <davids@...515...>

<https://github.com/OpenVPN/openvpn3-linux/commit/b1a270062e3d35dcf73f57340=
bd85fcb3d84b4cc>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--7VgTCSH983KE5hZA8WEqtKjY8sha6XJdG--

--cykJ32DfufvRoMVvm3UAimGJmfhhOfIG2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmA2wKYACgkQhs+UTJZx
/fIaOQ//bqbh0wXiX6PkbRkLXrJdF98fsU9HzLTqC0UO6XnCYK600pKr71JWDnz3
lRyR8jMWhAw+SeXt2zGypn5p31dDGCrx3xq7cVBVieyx8XGMNvSXh5Xv2bVMccQD
78lDQmyhraF1roT1Gs24oIvpezrwfHjA8Q6d/X5sTglkLL6C4TPWUgC6nYgVvhss
c6j3fdu4eL2LdHf0UVlX6Uam8gh31AOz2rU0S00snNye4RJGHkBwlWr9DWxWmFAT
RjHJ8ByAJSzMfJWUR/ymEmWgUzp2Fg0BjWc676QJQOpqpUBD7WX9byz24jS9mSLq
fyGnSFHClp2aiAJ0yoI6DRQr9d6kgSSs50uJnX9jL+IMAPgLq3vfc4TBdmVE2e+o
7/iXBJ26BGl+9T20kQAhhuuH1NVTlgpsHhed7ouTioJ5IkzdFhsGv3JqpUpDh6gh
PZJtRuIshSVxXHPQu37THkbamKBjMBbsCyluCzUXAgyadOYfkkGV7bKXNNomL9HB
RQ8QJL6WanWRgRa2B5mwdhN849RewP99V1BP2VweroU2TmHrbKKdsRl8iTstz58z
rIhjrttSmyyRZhaGtPD1rjBeIyo7471m0CINndSwU/riLpGCqHLwFgLQBpGeA2bm
qeTitv977dgfIsb+xg+yYTBdU0hj84Im5ZoAAWhpxYBJOrNzZfM=
=A3G4
-----END PGP SIGNATURE-----

--cykJ32DfufvRoMVvm3UAimGJmfhhOfIG2--

