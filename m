References: <20190228185128.43982-1-gert@...1296...>
 <20190608075622.11589-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6dce2777-2784-2db4-ec59-b1c49e3951ee@...2181...>
Date: Sat, 8 Jun 2019 19:51:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190608075622.11589-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KPFVCLCACRXnOA9RLA0VtXTLSog6qQRLU"
Subject: Re: [Openvpn-devel] [PATCH v2] Copy one byte less in strncpynt()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KPFVCLCACRXnOA9RLA0VtXTLSog6qQRLU
Content-Type: multipart/mixed; boundary="fXV0b1edvGZEXzaDvZspbbTQpeS98iec6";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <6dce2777-2784-2db4-ec59-b1c49e3951ee@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] Copy one byte less in strncpynt()
References: <20190228185128.43982-1-gert@...1296...>
 <20190608075622.11589-1-gert@...1296...>
In-Reply-To: <20190608075622.11589-1-gert@...1296...>

--fXV0b1edvGZEXzaDvZspbbTQpeS98iec6
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/06/2019 09:56, Gert Doering wrote:
> While the existing code is not wrong and will never cause an overflow,
> it will copy (on a too-long source string) "maxlen" bytes to dest, and
> then overwrite the last byte just copied with "0" - which causes a
> warning in gcc 9 about filling the target buffer "up to the end,
> with no room for a trailing 0 anymore".
>=20
> Reducing the maximum bytes-to-be-copied to "maxlen -1", because the
> last byte will be stamped with 0 anyway.
>=20
> v2: do not ASSERT() on "maxlen =3D=3D 0", but move the strncpy() call ins=
ide
> the if() clause - so "just do nothing" on maxlen =3D=3D 0, as before.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/buffer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index a4fe6f9b..e8b83a5e 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -347,9 +347,9 @@ buf_set_read(struct buffer *buf, const uint8_t *data,=
 int size)
>  static inline void
>  strncpynt(char *dest, const char *src, size_t maxlen)
>  {
> -    strncpy(dest, src, maxlen);
>      if (maxlen > 0)
>      {
> +	strncpy(dest, src, maxlen-1);

can you add spaces around the '-' when you commit this change?
(basically like the line below)

>          dest[maxlen - 1] =3D 0;
>      }
>  }
>=20

Acked-by: Antonio Quartulli <a@...2181...>

--=20
Antonio Quartulli


--fXV0b1edvGZEXzaDvZspbbTQpeS98iec6--

--KPFVCLCACRXnOA9RLA0VtXTLSog6qQRLU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlz79b0ACgkQ9FVsWUWD
Dm2z4g/+JC0pszp7XECEP+5wuDaSzm+PlqgazRv4I1ji6W4g5Iv0S+TmkZ0oGUaf
6ZCW2Bu9CIjSbYE8B9xLzhk/wREhJeFaECEyQ1Px83FrAo5IuGe5kVNNl6oUAFpK
6OCDg0gJmLvLG/9JUpLtY6UtclaGqkeQJK93PlHVn8zF2tysk4RQbP2LcNrglFvJ
63PRaqq8qAqiQtPF6Du9k9uKpP2WXUQu9DHQ0EpRb5SZszKovyvkg3eDTb0UsAYd
ZaCxbJroobjLOLki4VEhcnF+EEStnDkrBGYgbO8Ojk0m6iUwRYOeoC27yX2PjaWb
fLv/ecaIqbyDT1G37r1e9yH/tBf5E7qPpbuteYU/nTskzPlIX7X3jIxZbeSKzE8I
ykc4YEqUNx/Axo51/eIY3d+WXHM2JMN23hIwOiq1h6oIzEKNTGdjl24zuXoy4uHa
G0fLNo0tyTVlkkyg0GiItW2lS57NRmk2lAXu/yLtLC4cTEDAlK7LzqRMHZ40DlGb
GpgsxgvPu+/2AAeO6XN9BnZ/KHpyzDLvRP2hiWwp6iV6J6fHv3TBCtmcPUwnsBbY
15GqDaJfGmZCQ9neF5Qijm9QoHvqKcwit2Up4xrM7i04dIBQAKtq0AnAgRlEXetF
n4d+ZjJ6U3DhbXui0RYgdEhiboMbK85mOcznXz4BzXczXHVF3K8=
=ILxj
-----END PGP SIGNATURE-----

--KPFVCLCACRXnOA9RLA0VtXTLSog6qQRLU--

