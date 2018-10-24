From: David Sommerseth <openvpn@...2080...>
References: <20181019155638.9498-1-davids@...515...>
 <20181019155638.9498-2-davids@...515...>
Reply-To: openvpn-devel@lists.sourceforge.net
Message-ID: <cac38cf0-a7d1-29a6-80bb-4d93bed2b033@...2080...>
Date: Wed, 24 Oct 2018 12:11:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181019155638.9498-2-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SM4RvuZdGE9raSJuPhWBs4MRhKvzmMqgA"
Subject: Re: [Openvpn-devel] [PATCH 1/4] re-implement argv_printf_*()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SM4RvuZdGE9raSJuPhWBs4MRhKvzmMqgA
Content-Type: multipart/mixed; boundary="2k4zMDQgo6GDgwXn8CSV5AxGSJ37I2tXi";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <cac38cf0-a7d1-29a6-80bb-4d93bed2b033@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] re-implement argv_printf_*()
References: <20181019155638.9498-1-davids@...515...>
 <20181019155638.9498-2-davids@...515...>
In-Reply-To: <20181019155638.9498-2-davids@...515...>

--2k4zMDQgo6GDgwXn8CSV5AxGSJ37I2tXi
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/10/18 17:56, David Sommerseth wrote:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> The previous implementation had the problem that it was not fully
> compatible with printf() and could only detect % format directives
> following a space character (0x20).
>=20
> It modifies the format string and inserts marks to separate groups
> before passing it to the regular printf in libc. The marks are
> later used to separate the output string into individual command
> line arguments.
>=20
> The choice of 0x1D as the argument delimiter is based on the
> assumption that no "regular" string passed to argv_printf_*() will
> ever have to contain that byte (and the fact that it actually is
> the ASCII "group separator" control character, which fits its
> purpose).
>=20
> This commit has been updated by David Sommerseth based on his feedback
> on the mailing list discussions earlier on.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/argv.c                   | 266 ++++++++++++---------------
>  src/openvpn/argv.h                   |   4 +-
>  src/openvpn/route.c                  |   8 +-
>  src/openvpn/tun.c                    |  24 +--
>  tests/unit_tests/openvpn/test_argv.c |  58 +++++-
>  5 files changed, 192 insertions(+), 168 deletions(-)

This is a rebase of [0,1] on top of git master 2b15c11716e0d.  I've added my
review suggestions directly to this commit, as can be found here [2].  The
doxygen suggestion is coming as the last patch in this patch-set.

[0] <https://patchwork.openvpn.net/patch/71/>
[1]
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15834.=
html>
[2]
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15868.=
html>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--2k4zMDQgo6GDgwXn8CSV5AxGSJ37I2tXi--

--SM4RvuZdGE9raSJuPhWBs4MRhKvzmMqgA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJb0EVqAAoJEIbPlEyWcf3yOr4QAIdga5cgiJIOGwVdQmgsVTeG
3+YDJwTiOvnVK2q+kaMaEIVVKR8E5wIlcsylZzmF4lYXDbZ+VY80BXFGYQ8Tes90
t45uFsNuRd5D7NuSCKXG7Ku3dS41qLFpXydGXFcVNXUf81nLO0duAaEw+BeyARKE
Lhra1m47wk3mda0LDJrME+ZQ5iAbB5Jm+aU4PrnMUHIMlVTNTpE21cmZ/o+eDweM
c9ib0bKStQpWr+OR2ZftDAUwjYHT6IAUfjbrYoa88n8SpAiaHUEA+oGGhgDp3J0D
MH0Esbeuj4M+kBsl1eiS4Sd1aMajd4yC1qLv5XC40ykSVN9+rKYumCkjKllMdgZj
UWbb84G+xrA9kMYM3UZNZAZqYxjEzKkHtfDl3hmn0MBHdM445gf83a6JIxwBjk27
mAmV1/cWDzY3sI4qAGh+gK4ubwUtPVFquVg8hE19/6HUxOmFTANZz/clIKEgpqcu
4dfa1jScfFIbmU0luKClGktaPAhrbuMT1h9nYh5cl4JbEa2UIhrbo1Bfj4r/IlXg
ApwbLTVlQZ15g1LRzR0KnvtSbhdwY63DGkiolWnKa4CISXeUCbVrPXx/cOeL8E0L
gW5Kx4b+z2w/6KsTquTrcf5gJDLo8HzoskyYLas/WfZPVafPDxS6MeIKtP4ttNqd
8qoJrEcaml4An6OlBD9A
=TjNP
-----END PGP SIGNATURE-----

--SM4RvuZdGE9raSJuPhWBs4MRhKvzmMqgA--

