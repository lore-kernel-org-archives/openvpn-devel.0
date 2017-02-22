References: <cover.1487368114.git.logout@...260...>
	<a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <a4fccc39-ba53-5e7f-4dbb-7ace3aafefc5@...1856...>
Date: Wed, 22 Feb 2017 21:27:30 +0100
MIME-Version: 1.0
In-Reply-To: <a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mS91iTqtHXjnMKbUqGSF1feG2wKjx6w8P"
Subject: Re: [Openvpn-devel] [RFC PATCH v1 01/15] OpenSSL: don't use direct
 access to the internal of SSL_CTX
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
--mS91iTqtHXjnMKbUqGSF1feG2wKjx6w8P
Content-Type: multipart/mixed; boundary="GoRP3gHdbSVpuLPhwfwRlPJwpke0BVbnl";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <a4fccc39-ba53-5e7f-4dbb-7ace3aafefc5@...1856...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 01/15] OpenSSL: don't use direct
	access to the internal of SSL_CTX
References: <cover.1487368114.git.logout@...260...>
	<a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
In-Reply-To: <a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>

--GoRP3gHdbSVpuLPhwfwRlPJwpke0BVbnl
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


On 17-02-17 23:00, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
>=20
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including SSL_CTX. We have to use the defined functions
> to do so.
>=20
> Compatibility with OpenSSL 1.0 is kept by defining the corresponding
> functions when they are not found in the library.
>=20
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  configure.ac                 |  9 ++++++
>  src/openvpn/openssl_compat.h | 74 ++++++++++++++++++++++++++++++++++++++=
++++++
>  src/openvpn/ssl_openssl.c    | 13 +++++---
>  3 files changed, 91 insertions(+), 5 deletions(-)
>  create mode 100644 src/openvpn/openssl_compat.h
>=20
> diff --git a/configure.ac b/configure.ac
> index b29f8b410dfb69bce1145c3bb4a1ba011f0636ec..5fe5d6046ceafa2b577296af7=
72c347ac2ad8039 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -898,6 +898,15 @@ if test "${enable_crypto}" =3D "yes" -a "${with_cryp=
to_library}" =3D "openssl"; then
>  		[have_crypto_aead_modes=3D"no"; break]
>  	)
>=20=20
> +	AC_CHECK_FUNCS(
> +		[ \
> +			SSL_CTX_get_default_passwd_cb \
> +			SSL_CTX_get_default_passwd_cb_userdata \
> +		],
> +		,
> +		[]
> +	)
> +
>  	CFLAGS=3D"${saved_CFLAGS}"
>  	LIBS=3D"${saved_LIBS}"
>=20=20
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..59bad9ff24d10b358419d3451=
81a0e2e52a0c662
> --- /dev/null
> +++ b/src/openvpn/openssl_compat.h
> @@ -0,0 +1,74 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single TCP/UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
> + *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program (see the file COPYING included with this
> + *  distribution); if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +/**
> + * @file OpenSSL compatibility stub
> + *
> + * This file provide compatibility stubs for the OpenSSL libraries
> + * prior to version 1.1. This version introduces many changes in the
> + * library interface, including the fact that various objects and
> + * structures are not fully opaque.
> + */
> +
> +#ifndef OPENSSL_COMPAT_H_
> +#define OPENSSL_COMPAT_H_
> +
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
> +
> +#include <openssl/ssl.h>
> +
> +#if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA)
> +/**
> + * Fetch the default password callback user data from the SSL context
> + *
> + * @param ctx                SSL context
> + * @return                   The password callback user data
> + */
> +static inline void *
> +SSL_CTX_get_default_passwd_cb_userdata(SSL_CTX *ctx)
> +{
> +    return ctx ? ctx->default_passwd_callback_userdata : NULL;
> +}
> +#endif
> +
> +#if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB)
> +/**
> + * Fetch the default password callback from the SSL context
> + *
> + * @param ctx                SSL context
> + * @return                   The password callback
> + */
> +static inline pem_password_cb *
> +SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)
> +{
> +    return ctx ? ctx->default_passwd_callback : NULL;
> +}
> +#endif
> +
> +#endif /* OPENSSL_COMPAT_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index abf69c91a60910e450ae6d2d49ea7e5b1cd3a535..39e92f8cdae52d54d0ad95a93=
62e4e0e1b2289f4 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -45,6 +45,7 @@
>  #include "ssl_backend.h"
>  #include "ssl_common.h"
>  #include "base64.h"
> +#include "openssl_compat.h"
>=20=20
>  #ifdef ENABLE_CRYPTOAPI
>  #include "cryptoapi.h"
> @@ -658,7 +659,8 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const c=
har *pkcs12_file,
>          {
>              for (i =3D 0; i < sk_X509_num(ca); i++)
>              {
> -                if (!X509_STORE_add_cert(ctx->ctx->cert_store,sk_X509_va=
lue(ca, i)))
> +                X509_STORE *cert_store =3D SSL_CTX_get_cert_store(ctx->c=
tx);
> +                if (!X509_STORE_add_cert(cert_store,sk_X509_value(ca, i)=
))
>                  {
>                      crypto_msg(M_FATAL,"Cannot add certificate to certif=
icate chain (X509_STORE_add_cert)");
>                  }
> @@ -760,8 +762,9 @@ tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *=
ctx,
>          goto end;
>      }
>=20=20
> -    x =3D PEM_read_bio_X509(in, NULL, ctx->ctx->default_passwd_callback,
> -                          ctx->ctx->default_passwd_callback_userdata);
> +    x =3D PEM_read_bio_X509(in, NULL,
> +                          SSL_CTX_get_default_passwd_cb(ctx->ctx),
> +                          SSL_CTX_get_default_passwd_cb_userdata(ctx->ct=
x));
>      if (x =3D=3D NULL)
>      {
>          SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_PEM_LIB);
> @@ -843,8 +846,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, cons=
t char *priv_key_file,
>      }
>=20=20
>      pkey =3D PEM_read_bio_PrivateKey(in, NULL,
> -                                   ssl_ctx->default_passwd_callback,
> -                                   ssl_ctx->default_passwd_callback_user=
data);
> +                                   SSL_CTX_get_default_passwd_cb(ctx->ct=
x),
> +                                   SSL_CTX_get_default_passwd_cb_userdat=
a(ctx->ctx));
>      if (!pkey)
>      {
>          goto end;
>=20

ACK

-Steffan


--GoRP3gHdbSVpuLPhwfwRlPJwpke0BVbnl--

--mS91iTqtHXjnMKbUqGSF1feG2wKjx6w8P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYrfQ4AAoJEJgCyj0AftKIN+8IAMQIxyTRwqUJO2HVlEJXb4BR
k3269OAJe7WEs5Ii8rJUJJBXE8/FpssvOCAtUCjV6Uf33nF/ua/X98h1Ljsk74q3
vIk0hlmsMLJw5LB72KOkv7S8V2NFooabtYctwcyeWn6B+1mUBpJ1b4YsVoxerb6k
r9Wz0qxRiKNE64sFlKllFI0r+Vio8ixB/TjPoAMwpNx39d6rOmbpw7It/FUiNYGa
13s3lZfUyMESZSPo3LEJPQy3GvBwQ+k4tuMWgKjzmVIS9k4OBU4QE8uB65GpYEd/
4Zz3euEtnI54O5uc2e+09GdwSwhDQC8zpvlh1zVEuaoO0zfUA1/xyEIBBhvskpI=
=8LJH
-----END PGP SIGNATURE-----

--mS91iTqtHXjnMKbUqGSF1feG2wKjx6w8P--

