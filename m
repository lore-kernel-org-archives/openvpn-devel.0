References: <20191116102835.22883-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2ce5e07d-ac3d-4034-c2e1-56a00cb332bc@...2080...>
Date: Fri, 27 Mar 2020 16:24:00 +0100
MIME-Version: 1.0
In-Reply-To: <20191116102835.22883-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SAdizZhCZrHpkcFJe5uLS0Ng0TGAgrZVG"
Subject: Re: [Openvpn-devel] [PATCH] Reformat all source files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SAdizZhCZrHpkcFJe5uLS0Ng0TGAgrZVG
Content-Type: multipart/mixed; boundary="GLUllJBMI2XFwVqbF8cVFNeg4aAkKkoAD";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2ce5e07d-ac3d-4034-c2e1-56a00cb332bc@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Reformat all source files
References: <20191116102835.22883-1-arne@...1227...>
In-Reply-To: <20191116102835.22883-1-arne@...1227...>

--GLUllJBMI2XFwVqbF8cVFNeg4aAkKkoAD
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 16/11/2019 11:28, Arne Schwabe wrote:
> Over time some patches slipped in that were not 100% complient to uncrust=
ify
> This rerun fixes those issues
>=20
> This run used Uncrustify-0.69.0_f
> ---
>  src/openvpn/buffer.c              |  2 +-
>  src/openvpn/crypto.h              |  2 +-
>  src/openvpn/networking.h          |  4 +--
>  src/openvpn/networking_iproute2.c | 14 ++++++++
>  src/openvpn/networking_sitnl.h    |  2 +-
>  src/openvpn/openvpn.h             |  2 +-
>  src/openvpn/options.c             |  8 +++--
>  src/openvpn/options.h             |  4 +--
>  src/openvpn/proto.h               |  2 +-
>  src/openvpn/push.c                | 20 ++++++------
>  src/openvpn/route.c               |  2 +-
>  src/openvpn/socket.h              | 54 +++++++++++++++----------------
>  src/openvpn/ssl.c                 |  6 ++--
>  src/openvpn/ssl.h                 |  1 +
>  src/openvpn/ssl_openssl.c         | 10 +++---
>  src/openvpn/ssl_verify.c          | 18 +++++------
>  src/openvpn/ssl_verify.h          |  3 +-
>  src/openvpn/tun.c                 | 20 ++++++------
>  src/openvpn/vlan.c                |  4 +--
>  19 files changed, 99 insertions(+), 79 deletions(-)
>=20


Only done quick code review and RHEL-7 build.  Changes looks reasonable and=
 is
by far closer to what I would expect our coding style to look like.

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--GLUllJBMI2XFwVqbF8cVFNeg4aAkKkoAD--

--SAdizZhCZrHpkcFJe5uLS0Ng0TGAgrZVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJefhqQAAoJEIbPlEyWcf3y0SIP+gLfx0SEUQE4x2aIvpICaqMN
Y5jcR2oDAzKcyoV9P6/anGC3ljH/OWcbI3LG/ltsCnm21dmIxWhszecwMUAYljLb
ZnRqvTfyht/U0pZl18CsWgoLt8naFb/n8j+CDhb/NTItIcIB5axB0SnZIZnTMV28
aVHtFB10HWFXYmVGJNR5ZbxpUTVm4sFB1EyXMICOgLd4Mk/jo05XFvmD8eUfR1Xk
yT2QFTSDvp1EzY6D6b4H2ShnIPnOeMNT6h+dDUNTaXG2se/VQ2dRp5OFmgqbCDfg
GXCUr30iddtvlC0k3VRTCsOu1YGahHdcd3wpy10r1E9MtR7hKuCQow8T6o12oU+U
wUPcVgy3wnyWtnNgoJRVEquRgvll133+CXhEgWt/VRdKjRWBkgDY1h+uCjYAfwCp
/WEA98FcwBEvGxTjTjKsrFtAGSVDzBBP8kyFFic69dR2jFGhAn36sD/n7r3q1Wf1
n+G4vTLuUazbALqjyMgFg36EKGNQGU5ybeJSmHQ61UNkLegfoysqzf3fVAfYmTVJ
c4FSgKDrVdUeGB2gvoF6xxf1eS5lr9JYONDBsmG+HIN2UQmD8d65BioeNsbBqvTs
kPpQ1Xiy2tK1pebw/Zr/JptX//i+D5OBDnOpwwbeCBEvHIf2nfAqhU8nLrQHaV0g
hw28qoem/5IM6ZtOk6Tm
=6JiW
-----END PGP SIGNATURE-----

--SAdizZhCZrHpkcFJe5uLS0Ng0TGAgrZVG--

