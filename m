References: <20201009203331.11779-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <16d3199d-dff2-74ce-586f-fdee8bda43d3@...1227...>
Date: Fri, 9 Oct 2020 23:58:41 +0200
MIME-Version: 1.0
In-Reply-To: <20201009203331.11779-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rBo0w4BZT8F3xQ4p5qNBeqEQc0MNy0KXJ"
Subject: Re: [Openvpn-devel] [PATCH] Fix compilation on pre-EKM mbedTLS
 libraries.
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
--rBo0w4BZT8F3xQ4p5qNBeqEQc0MNy0KXJ
Content-Type: multipart/mixed; boundary="sTPLHfnmgCpjOUl3vJnxUubNUoleefOVI"

--sTPLHfnmgCpjOUl3vJnxUubNUoleefOVI
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.10.20 um 22:33 schrieb Gert Doering:
> commit f0734e49956217 simplified key_state_export_keying_material(),
> changing the function prototype.  For older mbedTLS versions, there
> is "always fail" dummy function which was overlooked in that change.
>=20
> Fix prototype.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/ssl_mbedtls.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index bb5633b7..b100d03e 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -252,11 +252,10 @@ key_state_export_keying_material(struct tls_session=
 *session,
>      }
>  }
>  #else
> -unsigned char*
> +bool
>  key_state_export_keying_material(struct tls_session *session,
>                                   const char* label, size_t label_size,
> -                                 size_t ekm_size,
> -                                 struct gc_arena *gc)
> +                                 void *ekm, size_t ekm_size)
>  {
>      /* Dummy function to avoid ifdefs in the common code */
>      return NULL;
>=20

Well, if we fix, it we should fix all the way and not return NULL which
gets coerced to false.

Arne


--sTPLHfnmgCpjOUl3vJnxUubNUoleefOVI--

--rBo0w4BZT8F3xQ4p5qNBeqEQc0MNy0KXJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl+A3RIACgkQFRhsZwKx
RFRgCQ/9FkaqIUQZb+yo1QL5j/kuWpldn9pDIVLBnzRxnsgklK7W6yin1zx5veew
KIPYIysKjDAUOB/k8bbloEsqr/JRE6HXcA7G7APKI/H0bbrw3iG7gCVyk5vHI9n0
vKlip/8H1P0MnVs/zB0b3aVlXkZfjcODlJXOnAGFe/vmQAlqoCB6Du4vkrPZ5RoL
/3Cu81/kgrQunUVzl2rjIzzR+kTnxeNbW/PRfjCv/tQgUFnuMT4uCS4wpd4/2TJf
4ToTjJlWL0TS7/FCQVP0U20H41LbvM/ayqtBQJedz7KFsTWpnrvWseeqglPAfvxj
0aYUyJdju746Zadb6qvDkkvDWaF3A2VFEvEhJI1/wCw9E9gYzX2UVSHyfoSDSYka
KmJG8gz4GfZSBfF1OgrEykcgRv1klWvHL4A/rDLWtQGRcSAPCqjF/01d9xTnBko5
4L94Wstm9ZpXHJQa2oxLiJ0SkczQ5D4to9E0Rya0damNUk7cz9KmLqHt64KU/AfK
IQI7JEq30Mc9ezJo40coJwUXhefex+Lsn4drfUrErcueu6rf4hyRe3UbREer7IPb
YC+8h8ZueMo76iwYYYDl/2OkF2VDH9rxIaFPxBiYppFrBVH6iWGm9jGbXRv6PSO1
r5WkBmhiZMpDItExglTT3JUUzVWfAmbYOQp0ZQANd6DB+MaiqxA=
=ZNTi
-----END PGP SIGNATURE-----

--rBo0w4BZT8F3xQ4p5qNBeqEQc0MNy0KXJ--

