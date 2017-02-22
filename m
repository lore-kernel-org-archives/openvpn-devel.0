References: <cover.1487368114.git.logout@...260...>
	<c849c9778d2b2faa4eb4d31367b37d993da5eb85.1487368114.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <8c051c32-ed80-5d6c-9370-0577d66abcee@...1856...>
Date: Wed, 22 Feb 2017 21:50:10 +0100
MIME-Version: 1.0
In-Reply-To: <c849c9778d2b2faa4eb4d31367b37d993da5eb85.1487368114.git.logout@...260...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xwvxsifrxrDeCtD00R5Gt9XVUrk1dwSgt"
Subject: Re: [Openvpn-devel] [RFC PATCH v1 03/15] OpenSSL: don't use direct
 access to the internal of X509_OBJECT
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
--xwvxsifrxrDeCtD00R5Gt9XVUrk1dwSgt
Content-Type: multipart/mixed; boundary="hRAXx39pon6xbrKWVhXetDps8XGhdAbwO";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <8c051c32-ed80-5d6c-9370-0577d66abcee@...1856...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 03/15] OpenSSL: don't use direct
	access to the internal of X509_OBJECT
References: <cover.1487368114.git.logout@...260...>
	<c849c9778d2b2faa4eb4d31367b37d993da5eb85.1487368114.git.logout@...260...>
In-Reply-To: <c849c9778d2b2faa4eb4d31367b37d993da5eb85.1487368114.git.logout@...260...>

--hRAXx39pon6xbrKWVhXetDps8XGhdAbwO
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 17-02-17 23:00, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
>=20
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including X509_OBJECT. We have to use the defined
> functions to do so.
>=20
> Compatibility with OpenSSL 1.0 is kept by defining the corresponding
> functions when they are not found in the library.
>=20
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  configure.ac                     |  2 ++
>  src/openvpn/openssl_compat.h     | 31 +++++++++++++++++++++++++++++++
>  src/openvpn/ssl_openssl.c        |  5 ++---
>  src/openvpn/ssl_verify_openssl.c |  2 +-
>  4 files changed, 36 insertions(+), 4 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 415128c9f8687a53e4a73419f3048d07f66b70cc..789ad08fbaa3b3fc4c95d2b7a=
22332c0a93aeab4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -903,6 +903,8 @@ if test "${enable_crypto}" =3D "yes" -a "${with_crypt=
o_library}" =3D "openssl"; then
>  			SSL_CTX_get_default_passwd_cb \
>  			SSL_CTX_get_default_passwd_cb_userdata \
>  			X509_STORE_get0_objects \
> +			X509_OBJECT_free \
> +			X509_OBJECT_get_type \
>  		],
>  		,
>  		[]
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 016008bc1705a41ee0ee09fecfc0b16b282cede3..458a6adbe2b3fcd5ea63dcea6=
596cc24315d463c 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -86,4 +86,35 @@ X509_STORE_get0_objects(X509_STORE *store)
>  }
>  #endif
>=20=20
> +#if !defined(HAVE_X509_OBJECT_FREE)
> +/**
> + * Destroy a X509 object
> + *
> + * @param obj                X509 object
> + */
> +static inline void
> +X509_OBJECT_free(X509_OBJECT *obj)
> +{
> +    if (obj)
> +    {
> +        X509_OBJECT_free_contents(obj);
> +        OPENSSL_free(obj);
> +    }
> +}
> +#endif
> +
> +#if !defined(HAVE_X509_OBJECT_GET_TYPE)
> +/**
> + * Get the type of an X509 object
> + *
> + * @param obj                X509 object
> + * @return                   The underlying object type
> + */
> +static inline int
> +X509_OBJECT_get_type(const X509_OBJECT *obj)
> +{
> +    return obj ? obj->type : X509_LU_FAIL;
> +}
> +#endif
> +
>  #endif /* OPENSSL_COMPAT_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index e57de43a748c89ff58ea00abade0b1c317013258..bf0f643f25439f71cbfe71bf5=
a7e8eb834b0f012 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -905,11 +905,10 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl=
_ctx, const char *crl_file,
>      {
>          X509_OBJECT *obj =3D sk_X509_OBJECT_value(objs, i);
>          ASSERT(obj);
> -        if (obj->type =3D=3D X509_LU_CRL)
> +        if (X509_OBJECT_get_type(obj) =3D=3D X509_LU_CRL)
>          {
>              sk_X509_OBJECT_delete(objs, i);
> -            X509_OBJECT_free_contents(obj);
> -            OPENSSL_free(obj);
> +            X509_OBJECT_free(obj);
>          }
>      }
>=20=20
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index fabbb0c370b123f54ce4a1eaf5f9650b440f47f8..07975248035b48121d1383b47=
f40a56042bc7380 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -721,7 +721,7 @@ tls_verify_crl_missing(const struct tls_options *opt)
>      {
>          X509_OBJECT *obj =3D sk_X509_OBJECT_value(objs, i);
>          ASSERT(obj);
> -        if (obj->type =3D=3D X509_LU_CRL)
> +        if (X509_OBJECT_get_type(obj) =3D=3D X509_LU_CRL)
>          {
>              return false;
>          }
>=20

ACK

-Steffan


--hRAXx39pon6xbrKWVhXetDps8XGhdAbwO--

--xwvxsifrxrDeCtD00R5Gt9XVUrk1dwSgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYrfmDAAoJEJgCyj0AftKIUJ8H/iZSst5V6UAdIOwwfFG5Thyn
B67irQQr9mX0YTvSwM/+DVT9NoZhsXwxF4ZHmZl6YYvVmsNDn0O52wSSavkMmvKp
zwF2soDoU3dGo/w3gptBGba82LiPAnKJc79h9FiW/of6+7Zr3ExqMMzPuZj4X4dx
emjBjKOic4eMWT3xpBQgqcTlT/+f/jDD9Wi/uRo09kHKLhjZRDvp1iD7e/hye3C3
/B8u00Ojmvz9cuRMVwVY1+uCZhRcIK/rGnucjXdXrvrPGrJIb47MDw7SOXY5czuR
FRsM0THPiq6JOCCSR6fqjRi8M+HS6EKau7VKFg/t1pTIJa0/Bx8FDf8pAYhpe+o=
=uN/u
-----END PGP SIGNATURE-----

--xwvxsifrxrDeCtD00R5Gt9XVUrk1dwSgt--

