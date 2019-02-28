References: <20190228185128.43982-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d175c96c-a3c4-9949-08f9-c22e0541bbb0@...2181...>
Date: Thu, 28 Feb 2019 20:30:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190228185128.43982-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sbw8pa4CpZK9RXHQPBMWPf2MuKbMr0LaT"
Subject: Re: [Openvpn-devel] [PATCH] Copy one byte less in strncpynt()
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sbw8pa4CpZK9RXHQPBMWPf2MuKbMr0LaT
Content-Type: multipart/mixed; boundary="cJbarYUMHmHEC1Bcb0CXzb9CHjFNA0LuU";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <d175c96c-a3c4-9949-08f9-c22e0541bbb0@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Copy one byte less in strncpynt()
References: <20190228185128.43982-1-gert@...1296...>
In-Reply-To: <20190228185128.43982-1-gert@...1296...>

--cJbarYUMHmHEC1Bcb0CXzb9CHjFNA0LuU
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/02/2019 19:51, Gert Doering wrote:
> While the existing code is not wrong and will never cause an overflow,
> it will copy (on a too-long source string) "maxlen" bytes to dest, and
> then overwrite the last byte just copied with "0" - which causes a
> warning in gcc 9 about filling the target buffer "up to the end,
> with no room for a trailing 0 anymore".
>=20
> Reducing the maximum bytes-to-be-copied to "maxlen -1", because the
> last byte will be stamped with 0 anyway.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/buffer.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index a4fe6f9b..52de5a2b 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -347,7 +347,8 @@ buf_set_read(struct buffer *buf, const uint8_t *data,=
 int size)
>  static inline void
>  strncpynt(char *dest, const char *src, size_t maxlen)
>  {
> -    strncpy(dest, src, maxlen);
> +    ASSERT(maxlen>0);
> +    strncpy(dest, src, maxlen-1);
>      if (maxlen > 0)

This if condition makes me think that this function is allowed to be
invoked with maxlen =3D=3D 0. However you are now introducing an ASSERT()
which would stop the execution in that case.

Either the ASSERT() is right, and then the if condition should be
removed, or the ASSERT() is wrong and should not be introduced.

>      {
>          dest[maxlen - 1] =3D 0;
>=20

Other than that the change makes sense.

Regards,


--=20
Antonio Quartulli


--cJbarYUMHmHEC1Bcb0CXzb9CHjFNA0LuU--

--sbw8pa4CpZK9RXHQPBMWPf2MuKbMr0LaT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlx4NsgACgkQ9FVsWUWD
Dm31IA/9GjkyWlucxm222dPEbPe5zM+41V1jUuCKJwO/Rwpu/RAs0pim7CNYftJt
Jarvup/ZXGyDNxP3NxRRcH+ynAcg1v1XtO79XBm6RU6D1b70HqAP2NU2yQvLT8TE
uuNfFZDmQnfwekEq8dGrDQXiQcDTZkCiGVg+0KydO2duF8+kMNAU9PgQF8q4XvHT
fCNIsNy86rljhKGjCd4DIJzXVDO+CiIljmuPrsI2o6ZFGmSF602YwwU/D2gHnw9W
OhWUhO8XTsRRnZOjp4OXTRuBMZhT8/lAP0pc/T+fdGoRhP8UveaBK01aH54RW8x1
JNRsJylL/XqmA9DtAexd5nBV9WhfF6wGpS8pFcroSImLZxvRW93ZDHaw2TC40nea
I93mWZN0Ikx59NFURGeyjhIHC5Wi/YiaqWAcnKZk1HKdfqiEL14aErgOnUAOJpsW
UdtCc7LfxF9d0wmtfiILKJ+pDyfz1ypdQ9iWkeHtKyFVIsZPZxKMoftOIQM4FS5C
+KQzgiH5j12pArQ79Xzufbizej1eKblTFk8v1h95fFVm4U7Cl55BlgoiTY3IP9nc
xcKgO1phsMnWuVBsN/rEJDBgAPAd9YSYhYhrLWdQCDjbxaUocseHBznWCceGOh1L
mYOYSoSsll1anZ2eqmulsrTHHnFPXLBOxyOnTrjTFlZj1si/IT4=
=2tPG
-----END PGP SIGNATURE-----

--sbw8pa4CpZK9RXHQPBMWPf2MuKbMr0LaT--

