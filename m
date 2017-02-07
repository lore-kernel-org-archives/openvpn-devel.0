Date: Tue, 7 Feb 2017 12:14:51 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170207041451.GA11922@...2182...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Olivier W <olivierw.ml@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, Feb 06, 2017 at 08:18:01PM +0100, Olivier W wrote:
> Should be compatible with all versions of OpenSSL and LibreSSL.
> Similar to what is done in curl:
> https://github.com/curl/curl/blob/028391df5d84d9fae3433afdee9261d56590035=
5/lib/vtls/openssl.c#L603-L619
>=20
> Error while compiling was:
> "ssl_openssl.c:512:30: error: no member named 'cert' in 'struct ssl_ctx_s=
t'
> ssl.cert =3D ctx->ctx->cert;
> ~ ^
> 1 error generated.
> *** Error code 1"
> ---
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 8266595..a889332 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -508,10 +508,13 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx
> *ctx, const char *curve_name
>          const EC_GROUP *ecgrp =3D NULL;
>          EVP_PKEY *pkey =3D NULL;
>=20
> -        /* Little hack to get private key ref from SSL_CTX, yay OpenSSL.=
.. */
> -        SSL ssl;
> -        ssl.cert =3D ctx->ctx->cert;
> -        pkey =3D SSL_get_privatekey(&ssl);
> +        SSL *ssl =3D SSL_new(ctx->ctx);
> +        if (!ssl)
> +        {
> +            crypto_msg(M_FATAL, "SSL_new failed");
> +        }
> +        pkey =3D SSL_get_privatekey(ssl);
> +        SSL_free(ssl);

I have a question (sorry if I couldn't check myself): did you check that
SSL_get_privatekey() and SSL_free() won't crash when ssl is NULL ?

Cheers,


--=20
Antonio Quartulli

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYmUm4AAoJEJ6F1zG2JyOsG10P/24hzOBcy1Bd9cIO/8XpzIUS
z5dDvXJ0Q9I+0cI9bzCkP+soRDyK+6trINsaBWzM+XeXP9vLtssVoPNg3AIap5zf
jqkfEmpEoK1a4t59EoakoBBtZ0oHCeUqbSzo5IkdysZST6lz6uzTsPIcqlkwDLOl
PFozfTnozlzPWLP4P9ea3wltoM8D0iYOaGb8qzi0m81LkPa/l/jxgK/xXNaqxlxq
PwtGm5DhWfdw8aanx742I7hKm6/csWkUJUzkzPPShYrRxa+ILehQuBy0Ufw0a27p
g3PJ5gi5kuwVvMPaAF6XfzVEYL3A9pMoQRT/wGCWi6Ap1QqHJq/v9ZJLxO9jCGsz
QSRRe6kpFSQXAaaNEf9O4hSbI9XfFacUIZ2INliXPmfqxgf/I8Q7GHc562SJ+XJq
AJXlk7ALEe2FAzP7c7zUpWcplNPlOy3LyWedLZdvIjd00meCgx6C0J1b0ye78pq1
3Epcxmak/kefaqMxsS1b+RCBvMQ0YhCqICMnSyZcF1twdtp22a2tf+H29CDq8sgF
Hl669IzjlP21htdwrto6g+H6ZEYqspFb0Bep84cMjEeoqJxS0n/ctLbK4I+V8nqJ
HWjBv0vzyHe9M7Zd9tW3BH8kcEOpDK6U37I5HI4RcsPridOAjx7+KV2R6tx1n/+Z
zlGZ72U7GEUoRNDjRKiv
=v+a+
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

