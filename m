References: <20190618163435.26431-1-a@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <69264f75-94e0-e229-d76d-3dbc42e96bb4@...2080...>
Date: Thu, 20 Jun 2019 21:02:36 +0200
MIME-Version: 1.0
In-Reply-To: <20190618163435.26431-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="F71cltagWh3NVdNGdZspMa4biMArrtIRo"
Subject: Re: [Openvpn-devel] [PATCH v2] t_net.sh: fixes for the networking
 test script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F71cltagWh3NVdNGdZspMa4biMArrtIRo
Content-Type: multipart/mixed; boundary="7xxKatssvTaSfEXqdvVrJ0XDUiBqfyanw";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>
Message-ID: <69264f75-94e0-e229-d76d-3dbc42e96bb4@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] t_net.sh: fixes for the networking
 test script
References: <20190618163435.26431-1-a@...2181...>
In-Reply-To: <20190618163435.26431-1-a@...2181...>

--7xxKatssvTaSfEXqdvVrJ0XDUiBqfyanw
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 18/06/2019 18:34, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> 1) Building the networking unit-test when SITNL is not enabled does not
> make much sense right now.
> Make compilation dependent on having SITNL configured.
>=20
> 2) Remove some no-op mock_msg function calls.
>=20
> 3) Remove obsolete comment and declarations
>=20
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>=20
> Changes from v1:
> - get rid of LD_LIBRARY_PATH: consensus is to have cmocka installed
>   system-wide
>=20
>  tests/t_net.sh                             |  6 +-----
>  tests/unit_tests/openvpn/Makefile.am       |  2 ++
>  tests/unit_tests/openvpn/test_networking.c | 16 ----------------
>  3 files changed, 3 insertions(+), 21 deletions(-)


Only glared at the code changes, and it makes sense after some clarificatio=
ns
on IRC.

Acked-by: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--7xxKatssvTaSfEXqdvVrJ0XDUiBqfyanw--

--F71cltagWh3NVdNGdZspMa4biMArrtIRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdC9hNAAoJEIbPlEyWcf3yJUsQALB9RD0usiyBSwErXJMR+7cr
0N8Kv+7/mxC7PtSWue13wmuHnNuX0lR7HS8HN6Xf6syL7keGTUIXKF3BthJXqPmP
3LHJKQZjCHkJdvR0ZeX54VqDmc6iF3havxv/mtmpHOTeMn5s+r/DDSIP7v58KBMx
FpqC8FGDxTkdbbp7pEB6x08T4nDnUcMNvWGPFkAnGISghNn49GMVtRqmNKzi3JKJ
IoFZZMLJ8dOg/PvuliPGqmdFAA+8OyvJVAshZ18DIFPesiRhxJFrKD11wZF78zDP
QUnlJXcG/02nEJwh1B14mQpqHRN/Y6gL9ihmxReUEcdAfF+2jfIYCuBknr5W1CJV
hmszXh4Xm4Sg0HjWW6RnlcrTB1CpJwnQNb/USbicvhLBYpRI92/BOyIIgZC7QIP4
z4Du0Ik71ZMziZz1SabnMq4KE5lx2eC8Zi+X8IgQCgTVzxjWa+iwR5TGA3WHCOar
+hQ51m7Vidk+/h/FeRblb27vDwEH6Q+P17ai+/A3/vilzqYCbLrAKJpMo8iaAS7m
UbjJRvUUiu4OgxvE64GpIB0pZs7WPBuu6zzDyYISWeUzCk1m9D7rMVOSMZHsvctd
3mBJSNMAOO2ihQljUs4VhgC7gpWtvF5W6snsIyh3cyJ3sNlrzU8Gjk5ti819k2qt
PMY5fZItI8xp6/w9mTaG
=9yuw
-----END PGP SIGNATURE-----

--F71cltagWh3NVdNGdZspMa4biMArrtIRo--

