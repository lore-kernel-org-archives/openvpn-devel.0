References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-10-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b3302c9e-24b3-2380-05e1-94fa9c809b3d@...2181...>
Date: Fri, 15 Jun 2018 15:51:54 +0800
MIME-Version: 1.0
In-Reply-To: <1512734870-17133-10-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w2kPOIWqQa3SJp14lwuV2Xd609gJzh8fY"
Subject: Re: [Openvpn-devel] [PATCH 09/10] Move execve/run_script helper
 functions to run_command.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w2kPOIWqQa3SJp14lwuV2Xd609gJzh8fY
Content-Type: multipart/mixed; boundary="ahczVzmfPXbGDoWrQQ29UwyNOdF0Q3pf6";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b3302c9e-24b3-2380-05e1-94fa9c809b3d@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 09/10] Move execve/run_script helper
 functions to run_command.c
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-10-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-10-git-send-email-steffan.karger@...1435...>

--ahczVzmfPXbGDoWrQQ29UwyNOdF0Q3pf6
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/12/17 20:07, Steffan Karger wrote:
> From: Steffan Karger <steffan@...1856...>
>=20
> To avoid having to include misc.c - which is a dependency mess - in the
> tls-crypt unit tests, move the command execution helper functions to a new
> run_command.c module.
>=20
> While at it, abstract away the script_security global variable.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

I can't apply this patch without having applied the tls-crypt-v2 patches
first, however I strongly believe that this patch should come before
those. Like the those about PEM_encode/decode and and platform_file_*.

This would ensure that the tls-crypt unit-test, once introduced, will
have all the required pieces to work right away (bisect will benefit
from this too).

I also see that here you are removing the script_security variable that
you had declared in your first patch (in the crypt unit-test).

How about re-arranging this patch (maybe by making it the first patch in
the set) so that you don't need to do and undo the same code?

Does it make sense?

Cheers,



--=20
Antonio Quartulli


--ahczVzmfPXbGDoWrQQ29UwyNOdF0Q3pf6--

--w2kPOIWqQa3SJp14lwuV2Xd609gJzh8fY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsjcBoACgkQB6U8WA7y
zXTz2Q//dZmYBvJpK0QZKqa3dlU2kNEgOpUnXf9Cqs2tNsQQbGCXi0jqNVR4UikT
W8k6xsJuPEVrqD0Zco/MoMpZo9ohTBys+pnqpazsZImBu6n6imW564mhGf5kBF+k
Roj2HfsJ1690Kn09U5bh/COw9G7puDLKip7pR8R1VD+EK75FDSCGDCgVxg+MfJ3n
ye5Q4ZuwV/04NKZzqjNw9mcoS2T2Z1Tdppgnecpbzi4CPBrLCnhOet6H7AuaHke1
3gvJJtcnRlcX9Tiwlmbr4/+IPXOtGI0Ez679BIYOO77gvGHNpffdoFQor5UcEOau
g68umwOC08bfY9C5nU2vwyhY3TovQaZ4u1acC1oYc305+2QXgjhMK1m5bVQuxwdU
LDs9GZprBfHFoQXV3hXKzzCnzBs9P5n/6D5m6+poSLA41PzGRFMUmThsdOHae05j
pnuqrvk+3VZZtAIXXht2QwIhJiz/GkbWBA4y8Tuo6Bj/c5BGcjIbwXKkFytwXqeb
81wVTEc8gDt2jCpHeVxoYuHAroegS0TvWTC2U9qyFRQ2nxJN9gn/HVu3VDeJKbLC
ddcLnEXlQMmM8HJp80WQ80CdosS5vX5wibLZ0oBqp692OBvzbBBuXtbL5Z4XYJaQ
FmfbtMrmsh8SBkhJOMaNkHuXF7UrnbV2Lp89HqAdG6fTQpbWy0Y=
=sXbt
-----END PGP SIGNATURE-----

--w2kPOIWqQa3SJp14lwuV2Xd609gJzh8fY--

