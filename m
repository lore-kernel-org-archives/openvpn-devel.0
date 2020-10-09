References: <20201009144755.39719-1-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <d2e3bc49-d025-e40d-acec-b9c040cd7fb6@...1227...>
Date: Fri, 9 Oct 2020 17:38:08 +0200
MIME-Version: 1.0
In-Reply-To: <20201009144755.39719-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bwV8F4eic2MbfW3Y6iUByf1M9D6jnKSp9"
Subject: Re: [Openvpn-devel] [PATCH] Simplify key material exporter backend
 API
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
--bwV8F4eic2MbfW3Y6iUByf1M9D6jnKSp9
Content-Type: multipart/mixed; boundary="kIDLMPfeAYKYKbZiz5PMSsatwwN3o34f2"

--kIDLMPfeAYKYKbZiz5PMSsatwwN3o34f2
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.10.20 um 16:47 schrieb Steffan Karger:
> Just pass pointer and length, instead of a gc and return (possibly)
> allocated memory. Saves us some gc instantiations and memcpy()s. Exact
> same functionality, 19 lines less code.
>=20
> (Didn't want to delay the TLS EKM reviews for this, so submitted as a
> patch afterwards.)
>=20
Acked-By: Arne Schwabe <arne@...1227...>


--kIDLMPfeAYKYKbZiz5PMSsatwwN3o34f2--

--bwV8F4eic2MbfW3Y6iUByf1M9D6jnKSp9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl+Ag+AACgkQFRhsZwKx
RFQLBhAApOOP0o0M2ZEYjUb/g53xue0jcUhvoO/udUcIaO/hH9Ax6dBdnUMY58oH
dR/z95/FlQ7lpfEzLGE/7eALLx8L9pe2KKAqHTiEDdmsdPhN0akqRq5CRVj9ARDt
8R8xIt/4yTSoKSQpBikyjzZVAZD75mg5VrVPASIpcp39nS2Zz2O5MIp9Dr3uU6gM
rYa185vwkjP0+kf5zJsUUKahy1E9M5FbmqL+P0Wj1ykIpoqirSr55JqHP9dv11+i
1QvoyquuRrQ+dKAzvswJeM5Rb7RxhM9VKz8IlEkG6W8SowlG0BfZqE9iBchwmka8
Jey3dlo5cAzo0OHLHHfqJtYMDcibRkUFsVWMkal/ETj8BVp6U/2+3o8uDIgJlNip
K1YZVhfcc/D/mbcOE+NciekIVU/OrwzQqICX4XLvIm/x28YIFfphHlfEfGv2ezfr
fWABDpj9U/L0qsVk6IBfC5QnNWfc37G4Y06qQrpuI9Pe9bX6QtXEd2jtgy3XpkRC
62O32QyJ36KLfMl5MxpCjFVKToIrtZKZ6lufHME/ebJNee2cJI1CMR517BGa9Um2
pw83sB4wgxxt1qRIX5RDlgTZWvpeJEBxFmmiK8WQnxLMfUZeXp3W0CcvN936Y9P0
Pa1Tt6EcOjqrGg0zIPjDWK8rfyvcEPVpxM7WD0CBkZWWT4X1G3Y=
=q71o
-----END PGP SIGNATURE-----

--bwV8F4eic2MbfW3Y6iUByf1M9D6jnKSp9--

