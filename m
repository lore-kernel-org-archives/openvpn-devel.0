References: <1535544286-29638-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f06dfdfa-1fb9-cd89-f73a-d0631d786ac9@...2181...>
Date: Thu, 30 Aug 2018 18:24:49 +0800
MIME-Version: 1.0
In-Reply-To: <1535544286-29638-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hYQ3Fk2XvZU2mHzd68NOJAOsgMvlB92FU"
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: print warning if random
 personalisation fails
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
--hYQ3Fk2XvZU2mHzd68NOJAOsgMvlB92FU
Content-Type: multipart/mixed; boundary="ebQPv2B4DBSU5ZmQXKkcufSzWgqq8KKa4";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f06dfdfa-1fb9-cd89-f73a-d0631d786ac9@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: print warning if random
 personalisation fails
References: <1535544286-29638-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1535544286-29638-1-git-send-email-steffan.karger@...1435...>

--ebQPv2B4DBSU5ZmQXKkcufSzWgqq8KKa4
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 29/08/18 20:04, Steffan Karger wrote:
> ... instead of when it doesn't fail.  Looks like 'someone' mixed up the
> mbedtls return style (0 means success) with the openvpn internal return
> style (true means success).
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Acked-by: Antonio Quartulli <a@...2181...>

I guess at some point we should also convert all these functions
returning int to bool, because the latter is the meaning we are giving
to the return value.


Cheers,

--=20
Antonio Quartulli


--ebQPv2B4DBSU5ZmQXKkcufSzWgqq8KKa4--

--hYQ3Fk2XvZU2mHzd68NOJAOsgMvlB92FU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAluHxfIACgkQB6U8WA7y
zXSCFw//VZp4NAQ/95/hEi1Vedit6SkXRWocfDO6XPXn3mMoDYqaF0jC5GhODKA3
wJuhPpEx5BuNDPUi000ER+0DtlAb46a8bIaZ6DfXB4yY+sc2zHo140UMvQ95vDtt
/zoKSQMhBT8B2HXBLIwW2gDolJzKbTS4hyE28D7MitPbC1kQva252PwRw/5h6nak
NbtGBq4tk1fYOhKJKzhJGk2AXZAo56yPa+Xd40puUCUMPs+G5Hhkow5uwE+Od2O4
qaMUS9xmg8ecz78XfpzoGUrYoLxT1wGuyOc6FkYwKeWNtdwdn8IvM9lNyBLbkQX3
GNOSfGJfYmIJ3hkGRw/TqRc2VlcaNM0UTxp7Ni9tsDyrS1Bp1TuW2OHFq9IFe/FS
0p5+J4uvv8N3u7K3QKJpn00Z4XvBkyKEVALeVlDqYMavbqModVOwFwFYJl8YwyTH
fQwrll5T58eapGfceybFYIrR8lNQqbiJk9tLQ5hdiHpgrJeP+7yceqva3ydbbbme
j8v1kXKJDXstsXW//18VADkCx4CKIjsEWzw3Js1L9vn19gStSRGk4suW+toSNyOT
gP6XfBaCtLKZb3z/3st4UQ3UHA87DUKn+QPeBRVp6sWxNU1IQrqGESISfEXpB1B3
9tB+Lev5NTZrayv8ua3caJ0Fakhi0ZRuMUh2Zt5wvWHAH8uQ+0w=
=OcR9
-----END PGP SIGNATURE-----

--hYQ3Fk2XvZU2mHzd68NOJAOsgMvlB92FU--

