From: Antonio Quartulli <a@...2181...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-2-steffan@...1856...>
 <62dac7a4-3536-0f6f-1600-2d938428d3b5@...2181...>
Message-ID: <0b50abed-2aba-f92b-b45a-78137016b5dc@...2181...>
Date: Wed, 11 Jul 2018 10:19:17 +0800
MIME-Version: 1.0
In-Reply-To: <62dac7a4-3536-0f6f-1600-2d938428d3b5@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0uoQRGGRndw2Hfhk9Ji5SIc9f5zbGCnZw"
Subject: Re: [Openvpn-devel] [PATCH v2 2/9] Move execve/run_script helper
 functions to run_command.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0uoQRGGRndw2Hfhk9Ji5SIc9f5zbGCnZw
Content-Type: multipart/mixed; boundary="3CZxv4bL0Q6QZpAhNfnIGgOwDCa92XSXq";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <0b50abed-2aba-f92b-b45a-78137016b5dc@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/9] Move execve/run_script helper
 functions to run_command.c
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-2-steffan@...1856...>
 <62dac7a4-3536-0f6f-1600-2d938428d3b5@...2181...>
In-Reply-To: <62dac7a4-3536-0f6f-1600-2d938428d3b5@...2181...>

--3CZxv4bL0Q6QZpAhNfnIGgOwDCa92XSXq
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 11/07/18 10:01, Antonio Quartulli wrote:
> Other than that little nitpick, the patch looks good.
>=20
> Checked with "git show --color-moved" and I could verify that the code
> has only been moved (slightly adjusted to avoid long lines) and that the
> access to the security_script variable has been substituted with
> getter/setter functions.
>=20
> So, with or without the nitpick:
>=20
> Acked-by: Antonio Quartulli <a@...2181...>

Additionally, basic tests with --up and --down worked as expected. No
change in behaviour was noted.

Cheers,

--=20
Antonio Quartulli


--3CZxv4bL0Q6QZpAhNfnIGgOwDCa92XSXq--

--0uoQRGGRndw2Hfhk9Ji5SIc9f5zbGCnZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltFaSUACgkQB6U8WA7y
zXS0sQ//cTuwNmmq8DXcHr7mdMtext6DGjp7OVgj3dQfBMMbxq5z79JmbQKdIv8p
92LxtlSCwVzOpuhvfcKeHAuJyov7lY2i4vwujk0QxjjlZ9q03moIWc7B/G+I+Vq0
DyDsq9AfL9cNb3/KP0xTtr65TFXcFCpvcRBXKq8Rsbcb6/LB+FmFguVQOVChSq5f
iIctrCOQsW0CpzeqsIcK1ptKk61gGJzKjUTNP34VieqHwH32YIasaLTK87ozu0RP
glPVpMwuzW6Oqd8os8OA77OJ0+s/h16Lz0NF3/f327IzYon6iUDarKAhjgcTJlL8
WrDICHSwRF8al4I+mq7X9TY/M/siUz2KWOnd9QoefrLYE+OLlbaWdbob6sGoi7qP
c5Wrt/SLo2QwjIrjibtfMOUKTMVrbFVnJ5AoaQ5bKu/9VD8r/zs/1fAD83KPl9bL
bFTfGuYMK16tL0jh+RMmmgcnENgKtssjZduPxn3V5q36UqobVi6YXqEiIw2wCTyf
63MEwpkRrjfILlc5hbmKyRb5KkHizKFQ8rNK/jAtc3Zf6aPJNvMpLRV8ZfAs1opD
Zaq20LwLDs5Ak3Q/ABXQGFysTuNwewmmNFtNFeuJQ21qMGRc5qewSBxwjVJflEu7
5BgPjgKnRDCtFoP73ds1IG7/jPqEgL2YyahKGAXTYjmt778bXxA=
=yOXE
-----END PGP SIGNATURE-----

--0uoQRGGRndw2Hfhk9Ji5SIc9f5zbGCnZw--

