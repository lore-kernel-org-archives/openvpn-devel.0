Date: Tue, 29 Jul 2025 12:14:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aIie75VOFQiLMdUe@...1296...>
References: <20250728104234.29797-1-gert@...1296...>
 <202507281100.56SB09aF047714@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0aUoOA4Lez2wh954"
Content-Disposition: inline
In-Reply-To: <202507281100.56SB09aF047714@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re:
 unit_tests/plugins/auth-pam: fix stdint.h related build error on fedora 42
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--0aUoOA4Lez2wh954
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(uh, forgot to send this - push has been done yesterday already)

On Mon, Jul 28, 2025 at 01:00:09PM +0200, Gert Doering wrote:
> It seems this would also affect feodora-42 on amd64, we just missed on
> the "updates that bring in the breaking change" - but now we are prepared=
 ;-)
>=20
> Patch has been applied to the master branch.
>=20
> commit 035d47e6d80996a4cde8af1b35f9ba40b676c825
> Author: Gert Doering
> Date:   Mon Jul 28 12:42:29 2025 +0200

Frank has pointed out that this is the sort of maintenance fixes we=20
do want in release/2.6 as well, so here we go...   tested via GHA and
local fedora42/arm64 VM

commit 5c968a361fba7362306fcd977acdff52ccb4c884 (release/2.6)
Author: Gert Doering <gert@...1296...>
Date:   Mon Jul 28 12:42:29 2025 +0200

    unit_tests/plugins/auth-pam: fix stdint.h related build error on fedora=
 42

gert
-=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0aUoOA4Lez2wh954
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoiJ7vAAoJEB2Cnv7KVigSk2cMAK7inoHyia6tOICJWNX5HIMo
9Z9x/q2QYMOHFA6AZmze4Mzvozr36Rp36qbfMeyURaEeTbo3ll2R1C8KJ6Y29k6f
9ilX6s9tf/S/jrQ4fS2pnndXUo+v56X0TG5dxaiOv9rK34g2fARzJdMaU9BLk5Tn
ei/1qcL0FEavab8rr5xguvmtcuJTDXTAQrVDcB3Ue8WW4f3YvQncw9SpRLC8F20/
2YvFRuwSaK3N8AMb3OmV79RgTIRV3FHWkVeEH6X2XhL9qjBxdy8cRwxp5fY5PqQA
bmyAWbn3NcrB1NuHFFOYJryI6zac5DX5CEeMZyM7ITKmXQX6tPFwU8gFw0zxl1DC
pZZKwGDEZsvN4agWflD49qwBwqI2Y+2EmQlk60gmiGeZ3r0rdxooe9IACOr8n9Q4
diIlk4+g6BbY/GUDUZQMRq/XRAAm6OILYtPU9Oi/MiN7Pc9gDGO5V3aU3YhAQdlB
5AVjl4KA+zK2+1mDpND8zmx+tUtWXodTBFwOjVLN8g==
=xMHd
-----END PGP SIGNATURE-----

--0aUoOA4Lez2wh954--

