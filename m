References: <1544210258-8754-1-git-send-email-selva.nair@...277...>
 <1544210258-8754-2-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c66e66a4-f43d-3c75-0ab5-20b90cdd1f2b@...1227...>
Date: Wed, 23 Jan 2019 13:55:43 +0100
MIME-Version: 1.0
In-Reply-To: <1544210258-8754-2-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wYqFMNYWCmwhmRiAI0YxX1CsrGFRvRLtI"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Handle PSS padding in cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wYqFMNYWCmwhmRiAI0YxX1CsrGFRvRLtI
Content-Type: multipart/mixed; boundary="3yEIEw6b1nyULq63CElAULLJQWkLaaPur";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: selva.nair@...277...
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <c66e66a4-f43d-3c75-0ab5-20b90cdd1f2b@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Handle PSS padding in cryptoapicert
References: <1544210258-8754-1-git-send-email-selva.nair@...277...>
 <1544210258-8754-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1544210258-8754-2-git-send-email-selva.nair@...277...>

--3yEIEw6b1nyULq63CElAULLJQWkLaaPur
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 07.12.18 um 20:17 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
>=20
> For PSS padding, CNG requires the digest to be signed
> and the digest algorithm in use, which are not accessible
> via the rsa_sign and rsa_priv_enc callbacks of OpenSSL.
> This patch uses the EVP_KEY interface to hook to
> evp_pkey_sign callback if OpenSSL version is > 1.1.0.
>=20
> To test this code path, both the server and client should
> be built with OpenSSL 1.1.1 and use TLS version >=3D 1.2
>=20
> Tested on Windows 7 client against a Linux server.

Tested on Windows 10 1809 against a Linux server.

>=20=20
>  #include <openssl/ssl.h>
> +#include <openssl/evp.h>
>  #include <openssl/err.h>
>  #include <windows.h>
>  #include <wincrypt.h>
> @@ -105,6 +106,12 @@ static ERR_STRING_DATA CRYPTOAPI_str_functs[] =3D {
>  /* index for storing external data in EC_KEY: < 0 means uninitialized */
>  static int ec_data_idx =3D -1;
>=20=20
> +/* Global EVP_PKEY_METHOD used to override the sign operation */
> +static EVP_PKEY_METHOD *pmethod;
> +static int (*default_pkey_sign_init) (EVP_PKEY_CTX *ctx);
> +static int (*default_pkey_sign) (EVP_PKEY_CTX *ctx, unsigned char *sig,
> +                size_t *siglen, const unsigned char *tbs, size_t tbslen);
> +
>  typedef struct _CAPI_DATA {
>      const CERT_CONTEXT *cert_context;
>      HCRYPTPROV_OR_NCRYPT_KEY_HANDLE crypt_prov;
> @@ -318,28 +325,44 @@ rsa_pub_dec(int flen, const unsigned char *from, un=
signed char *to, RSA *rsa, in
>   * Sign the hash in 'from' using NCryptSignHash(). This requires an NCRY=
PT
>   * key handle in cd->crypt_prov. On return the signature is in 'to'. Ret=
urns
>   * the length of the signature or 0 on error.
> + * This is used only for RSA and padding should be BCRYPT_PAD_PKCS1 or
> + * BCRYPT_PAD_PSS.
>   * If the hash_algo is not NULL, PKCS #1 DigestInfo header gets added
> - * to 'from', else it is signed as is.
> - * For now we support only RSA and the padding is assumed to be PKCS1 v1=
.5
> + * to |from|, else it is signed as is. Use NULL for MD5 + SHA1 hash used
> + * in TLS 1.1 and earlier.
> + * In case of PSS padding, |saltlen| should specify the size of salt to =
use.
> + * If |to| is NULL returns the required buffer size.
>   */

If you modify the comments anyway, you might consider making them
documentation of the functions (start with /**). This is true for all
multiline comment and I don't comment further on it.


>=20=20
>      /* Unfortunately, there is no "CryptSign()" function in CryptoAPI, t=
hat would

Not 100% sure but I think for multiline comments the first line should
be just /* (empty)

> @@ -444,6 +469,7 @@ rsa_priv_enc(int flen, const unsigned char *from, uns=
igned char *to, RSA *rsa, i
>   * NCryptSignHash() is used to sign and it is instructed to add the
>   * the PKCS #1 DigestInfo header to |m| unless the hash algorithm is
>   * the MD5/SHA1 combination used in TLS 1.1 and earlier versions.
> + * OpenSSL exercises this callback only when padding is PKCS1 v1.5.
>   */

> +
> +    /* We intercept all sign requests, not just the one's for our key.
> +     * Check the key and call the saved OpenSSL method for unknown keys.
> +     */
> +    if (!pkey || !cd)
> +    {
> +        if (default_pkey_sign)
> +        {
> +           return default_pkey_sign(ctx, sig, siglen, tbs, tbslen);
> +        }
> +        else  /* This should not happen */
> +        {
> +            msg(M_FATAL, "cryptopaicert: Unknown key and no default sign=
 operation to fallback on");
> +            return -1;
> +        }
> +    }


> +        msg(M_NONFATAL, "cryptoapicert: could not determine the signatur=
e digest algorithm");
> +        RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
> +        return -1;
> +    }
> +
> +    if (tbslen !=3D (size_t) hashlen)

no space after cast

> +    {
> +        RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_INVALID_DIGEST_LENGTH);
> +        return -1;
> +    }
> +

> +
> +        if (saltlen < 0)
> +        {
> +            RSAerr(RSA_F_PKEY_RSA_SIGN, RSA_R_DATA_TOO_LARGE_FOR_KEY_SIZ=
E);
> +            return -1;
> +        }
> +        msg(D_LOW, "cryptoapicert: PSS padding using saltlen =3D %d", sa=
ltlen);
> +        EVP_MD_size(md);

This call here should not have side effect (unless md is nullptr) and
the result is not used.

> +    }
> +
> +    msg(D_LOW, "cryptoapicert: calling priv_enc_CNG with alg =3D %ls", a=
lg);
> +    *siglen =3D priv_enc_CNG(cd, alg, tbs, (int) tbslen, sig, *siglen,
> +                           cng_padding_type(padding), (DWORD) saltlen);
> +

Inconsistent casting, we should always use (cast)variable without space
I am told.


> +            /* Keep a copy of the default sign and sign_init methods */
> +
> +#if (OPENSSL_VERSION_NUMBER < 0x1010009fL)   /* > version 1.1.0i */
> +            /* The function signature is not const-correct in these vers=
ions */
> +            EVP_PKEY_meth_get_sign((EVP_PKEY_METHOD*)default_pmethod, &d=
efault_pkey_sign_init,

Style dictates a (EVP_PKEY_METHOD *)

Overall the code looks good. The overriding of the global RSA method is
a bit of a hack but I also do not have any better solution for this. It
might break using OpenSSL engines but that is a corner case that I would
not worry about here.

Apart from the minor issues this gets an ACK from me.

Arne


--3yEIEw6b1nyULq63CElAULLJQWkLaaPur--

--wYqFMNYWCmwhmRiAI0YxX1CsrGFRvRLtI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxIZFQACgkQFRhsZwKx
RFSBRg/+OrRXNaq/MfiVO7+iTKJH6ixk+LVG9LG32+vUE/ZFnifkutlZldEFIFjM
+/ZlW9VO0bEBOz6I866ACC01GFJdZm8HRMHNT+DQ2PDixLDfYKADo1qFoTli4T/a
7DQtKH/RbR/lHVorsRqf9jQ57x7YTdWTA3Tu1eQpmfF/JdeeDDxzU5mKPRs/p9Ia
n6f8cpZG4EbjCNCHo24wK1vEVwyeVKsiPqOmdKX+E+RoiZkB9ei6KaKivlIliK7Q
86dGCKZo+9cSdmedJAkqVAxTKjOJzA1QMjrUGdebsciyI65P+BNOD/wKDWskg8Cc
CqZeYhbMjCQsJjXzPSy/8+NALr/VeBEVEZIPItgxTwle6lOBQEu9fhgunxy1QVGH
nPNP7RNZKUzFqElIumOQOku5VfRgfYQsa6ANxUtPUBCdSNSD6yU2AKTbOyFw+8ET
DqFj+6y0i/6sR0xxregazXsfEARMhPhg0NcyFUmCRRhJkuQiyh2cZvYZ63fc90iq
EQxSQlDW9O5hpeHqdidtSQxX1exF2wHDVP6lSX+JRLGPwC87qIbr9Y72lWNZ88SJ
vJbKXqC7hQEWAo9RgLQ60YYqd9oYgrCzOaPN1j+HkiIsBkoiDJuRQwRaLWhW/ZHs
JvNkf57f5c/t/nPGPZDwa/voMlGwSf5WTCIp0lGtm9nIsOf2wdc=
=vKTG
-----END PGP SIGNATURE-----

--wYqFMNYWCmwhmRiAI0YxX1CsrGFRvRLtI--

