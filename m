References: <cover.1487368114.git.logout@...260...>
	<8e6d66e3a9a40abb3d7c99c48ba59bad1037d0ef.1487368114.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <a712429a-10f6-2951-4e71-c9f197fb0c01@...1856...>
Date: Wed, 22 Feb 2017 21:36:32 +0100
MIME-Version: 1.0
In-Reply-To: <8e6d66e3a9a40abb3d7c99c48ba59bad1037d0ef.1487368114.git.logout@...260...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fUTSPnCvndxB4FoB0GgvVrCk7Bf2QkWBM"
Subject: Re: [Openvpn-devel] [RFC PATCH v1 02/15] OpenSSL: don't use direct
 access to the internal of X509_STORE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fUTSPnCvndxB4FoB0GgvVrCk7Bf2QkWBM
Content-Type: multipart/mixed; boundary="0IJtaBtB5vX2CT6UXHxskfNIJTx17wsxj";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <a712429a-10f6-2951-4e71-c9f197fb0c01@...1856...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 02/15] OpenSSL: don't use direct
	access to the internal of X509_STORE
References: <cover.1487368114.git.logout@...260...>
	<8e6d66e3a9a40abb3d7c99c48ba59bad1037d0ef.1487368114.git.logout@...260...>
In-Reply-To: <8e6d66e3a9a40abb3d7c99c48ba59bad1037d0ef.1487368114.git.logout@...260...>

--0IJtaBtB5vX2CT6UXHxskfNIJTx17wsxj
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 17-02-17 23:00, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
>=20
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including X509_STORE. We have to use the defined functions
> to do so.
>=20
> Compatibility with OpenSSL 1.0 is kept by defining the corresponding
> functions when they are not found in the library.
>=20
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  configure.ac                     |  1 +
>  src/openvpn/openssl_compat.h     | 15 +++++++++++++++
>  src/openvpn/ssl_openssl.c        |  7 ++++---
>  src/openvpn/ssl_verify_openssl.c |  6 ++++--
>  4 files changed, 24 insertions(+), 5 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 5fe5d6046ceafa2b577296af772c347ac2ad8039..415128c9f8687a53e4a73419f=
3048d07f66b70cc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -902,6 +902,7 @@ if test "${enable_crypto}" =3D "yes" -a "${with_crypt=
o_library}" =3D "openssl"; then
>  		[ \
>  			SSL_CTX_get_default_passwd_cb \
>  			SSL_CTX_get_default_passwd_cb_userdata \
> +			X509_STORE_get0_objects \
>  		],
>  		,
>  		[]
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 59bad9ff24d10b358419d345181a0e2e52a0c662..016008bc1705a41ee0ee09fec=
fc0b16b282cede3 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -42,6 +42,7 @@
>  #endif
>=20=20
>  #include <openssl/ssl.h>
> +#include <openssl/x509.h>
>=20=20
>  #if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA)
>  /**
> @@ -71,4 +72,18 @@ SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)
>  }
>  #endif
>=20=20
> +#if !defined(HAVE_X509_STORE_GET0_OBJECTS)
> +/**
> + * Fetch the X509 object stack from the X509 store
> + *
> + * @param store              X509 object store
> + * @return                   the X509 object stack
> + */
> +static inline STACK_OF(X509_OBJECT) *
> +X509_STORE_get0_objects(X509_STORE *store)
> +{
> +    return store ? store->objs : NULL;
> +}
> +#endif
> +
>  #endif /* OPENSSL_COMPAT_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 39e92f8cdae52d54d0ad95a9362e4e0e1b2289f4..e57de43a748c89ff58ea00aba=
de0b1c317013258 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -900,13 +900,14 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl=
_ctx, const char *crl_file,
>      /* Always start with a cleared CRL list, for that we
>       * we need to manually find the CRL object from the stack
>       * and remove it */
> -    for (int i =3D 0; i < sk_X509_OBJECT_num(store->objs); i++)
> +    STACK_OF(X509_OBJECT) *objs =3D X509_STORE_get0_objects(store);
> +    for (int i =3D 0; i < sk_X509_OBJECT_num(objs); i++)
>      {
> -        X509_OBJECT *obj =3D sk_X509_OBJECT_value(store->objs, i);
> +        X509_OBJECT *obj =3D sk_X509_OBJECT_value(objs, i);
>          ASSERT(obj);
>          if (obj->type =3D=3D X509_LU_CRL)
>          {
> -            sk_X509_OBJECT_delete(store->objs, i);
> +            sk_X509_OBJECT_delete(objs, i);
>              X509_OBJECT_free_contents(obj);
>              OPENSSL_free(obj);
>          }
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index 274e2bbf96b6c943ce628eab143f8c76e1c47103..fabbb0c370b123f54ce4a1eaf=
5f9650b440f47f8 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -43,6 +43,7 @@
>  #include "ssl_openssl.h"
>  #include "ssl_verify.h"
>  #include "ssl_verify_backend.h"
> +#include "openssl_compat.h"
>=20=20
>  #include <openssl/x509v3.h>
>  #include <openssl/err.h>
> @@ -715,9 +716,10 @@ tls_verify_crl_missing(const struct tls_options *opt)
>          crypto_msg(M_FATAL, "Cannot get certificate store");
>      }
>=20=20
> -    for (int i =3D 0; i < sk_X509_OBJECT_num(store->objs); i++)
> +    STACK_OF(X509_OBJECT) *objs =3D X509_STORE_get0_objects(store);
> +    for (int i =3D 0; i < sk_X509_OBJECT_num(objs); i++)
>      {
> -        X509_OBJECT *obj =3D sk_X509_OBJECT_value(store->objs, i);
> +        X509_OBJECT *obj =3D sk_X509_OBJECT_value(objs, i);
>          ASSERT(obj);
>          if (obj->type =3D=3D X509_LU_CRL)
>          {
>=20

ACK

-Steffan


--0IJtaBtB5vX2CT6UXHxskfNIJTx17wsxj--

--fUTSPnCvndxB4FoB0GgvVrCk7Bf2QkWBM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYrfZQAAoJEJgCyj0AftKIhKkIANHP1GKiLhhJpFPPaViHbwlA
yV6Ym9YCAHm+vYM2oDwIbFlyPTkYOwvx9apRc4OWy9EvfYUX0LbZIVJijhR2PnFI
EHkxxKuF3ny/MQnTtBSn30VKITU0mhAOAA7HwJ3OvVuZBiYVBd/gDnXLfwisTlq/
374R6pFkDC54T/emHflLy0BQFtKqekFPxCI1rUWsAvldRvCUvchvb3ipKKJsNFx+
rTFSDr8gsQrFKvBpF/WXJG4u1Dzg+Yt9X3lzYREm3Fk49gNWYinxJrd0oKJIN8/u
8npwE0xGwfyF110cLWHXjhlyONYd7fd4WHXe8ZUrcvi3MSLKSiWl42mDrExRkzk=
=eaL3
-----END PGP SIGNATURE-----

--fUTSPnCvndxB4FoB0GgvVrCk7Bf2QkWBM--

