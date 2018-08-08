References: <4ff9b515-b65c-ddb4-30e5-03660cd9f245@...2181...>
 <1533542553-7383-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <24a63b72-cdb2-0a9b-34f4-2d7a775520c7@...2181...>
Date: Wed, 8 Aug 2018 13:24:04 +0800
MIME-Version: 1.0
In-Reply-To: <1533542553-7383-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9jJnB7UAmTy0iAN4Egr92IVNBwgTZGsSu"
Subject: Re: [Openvpn-devel] [PATCH v5 1/7] Introduce buffer_write_file()
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
--9jJnB7UAmTy0iAN4Egr92IVNBwgTZGsSu
Content-Type: multipart/mixed; boundary="U03LP8tZxfOwOXtP8Ifu0QvnpZn3OBFaD";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <24a63b72-cdb2-0a9b-34f4-2d7a775520c7@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v5 1/7] Introduce buffer_write_file()
References: <4ff9b515-b65c-ddb4-30e5-03660cd9f245@...2181...>
 <1533542553-7383-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1533542553-7383-1-git-send-email-steffan.karger@...1435...>

--U03LP8tZxfOwOXtP8Ifu0QvnpZn3OBFaD
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/08/18 16:02, Steffan Karger wrote:
> Rewrite buf_write_string_file to buffer_write_file, which is simpler to
> use and can deal with not-null-terminated strings.  Mostly implemented so
> this can be easily reused for tls-crypt-v2 (client) key files.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

All looks good now! Thanks!

Acked-by: Antonio Quartulli <antonio@...515...>
Tested-by: Antonio Quartulli <antonio@...515...>

Key generation (success and failure) and basic connection work as expected.
'make check' performed on various platforms, but no buildbot test has
been executed.

Cheers,

--=20
Antonio Quartulli


--U03LP8tZxfOwOXtP8Ifu0QvnpZn3OBFaD--

--9jJnB7UAmTy0iAN4Egr92IVNBwgTZGsSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltqfnQACgkQB6U8WA7y
zXSDBw//V+AgfxxGoq6ptof36dJiGepyLNhxd7W2FCjD1o97JxtFoV3rAuvRwLAf
RYjihDOf+Q4wJm6ihVljMKOJCxdY94xTKWs1+bKRPDDAfJDUvpvhJx2CUC976XLo
8RHA+vAtaBvNeeDyVNRCiGgXzW/tUru6eS+eJFoHdkmVgdLVDROHw2pOfGOlR909
epBbBLKyC6XBcz0USudRqm13/YmQQ/2JpHR32keQf1Ku9Ud+qLWDNaAH2ubJACEZ
gjtKCcqMdxIikyCpIGew9zQC5UnHIDhMLJgH+b/Zfoo/Qo7di0xxNl+4EQDQyDJV
6X7FbbpIyo2Dg1iS2V6543D90VCGmDqsttwoyTC6pEQlKnNXF6E/XuHe4/WpRVs8
2mE/93P9GENW6HifQZNuJ4mRXv3AjwM8ks7RRBCiPlgZww4peBtKvTI5SRhi6iiE
IpEfQPDw0k6GSIA2kfr2KGzagGfLNeY+6WrQpAIZbTu9PQ31mzOubDkqrMR/O9b6
/5JrOpohTfGF0Ik2s33AV0pFpCbQrIJfSU9dfWvL/rvYYxq0+hSy/gXiXLLCLVp7
wePX9CJe7y6osQtVCv4/MH+Td32ZhW08m0d34jVNhbizWwmjsNJZaqu9bZ4FoW9Q
wG7OWS9a3LBOk3T6L4fNwSCVf44b7M3uOgFLV/WoSx01Mt/gTVU=
=cm5D
-----END PGP SIGNATURE-----

--9jJnB7UAmTy0iAN4Egr92IVNBwgTZGsSu--

