References: <20200401215052.3489613-1-wgh@...2548...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <79cc0c02-63cf-d668-e71b-1e4343228567@...1227...>
Date: Thu, 2 Apr 2020 00:28:48 +0200
MIME-Version: 1.0
In-Reply-To: <20200401215052.3489613-1-wgh@...2548...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D3ixJOY0bJaGOTe9xkmIsLSKEbRkPGIGM"
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: Fix --crl-verify not loading
 multiple CRLs in one file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: wgh@...2548..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D3ixJOY0bJaGOTe9xkmIsLSKEbRkPGIGM
Content-Type: multipart/mixed; boundary="iC7ifuuIUKTRgM80QhV7hGxRC9hY0zS6q"

--iC7ifuuIUKTRgM80QhV7hGxRC9hY0zS6q
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 01.04.20 um 23:50 schrieb wgh@...2548...:
> From: Maxim Plotnikov <wgh@...2548...>
>=20
> Lack of this led people accepting multiple CAs to use capath,
> which already supports multiple CRLs. But capath mode itself
> is somewhat ugly: you have to create new file/symlink every time
> CRL is updated, and there's no good way to clean them up without
> restarting OpenVPN, since any gap in the sequence would cause it
> to lose sync[1].
>=20
> mbedtls crypto backends already loads multiple CRLs as is, so
> it doesn't need this fix.
>=20
> The patch also includes some logging changes which I think are useful.

Feature-ACK but some changes to the code required.

>  {
> -    X509_CRL *crl =3D NULL;
> +    int i =3D 0;

We can use C99 style definition. The init on top is just because we just
to have C89 style

>      BIO *in =3D NULL;
>=20=20
>      X509_STORE *store =3D SSL_CTX_get_cert_store(ssl_ctx->ctx);
> @@ -1079,21 +1079,38 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *s=
sl_ctx, const char *crl_file,
>          goto end;
>      }
>=20=20
> -    crl =3D PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
> -    if (crl =3D=3D NULL)
> -    {
> -        msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
> -        goto end;
> -    }
> +    for (i =3D 0;; i++) {

This for loop is a bit odd. Also the use of goto with this kind of for
loop is not the best to understand. Also since i is not really an index,
I would prefer a better named variable like num_crls_loaded or something
similar.


> +        X509_CRL *crl =3D PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
> +        if (crl =3D=3D NULL)
> +        {
> +            unsigned long err =3D ERR_get_error();

I think we should use ERR_peek_error here, so we do not drop the error
message if the error is something else.

> +            char buf[256];
> +
> +            if (ERR_GET_REASON(err) =3D=3D PEM_R_NO_START_LINE && i > 0)=
 {

flip condition if (i > 0 && err =3D=3D ...) sounds more logical to me

> +                // PEM_R_NO_START_LINE can be considered equivalent to E=
OF.
> +                //
> +                // A file without any CRLs should still be considered an=
 error,
> +                // though. Hence i > 0.

Style: OpenVPN does not use C99/C++ style comments.

Also comment does not match what the code does. This is just a warning
and not an error.

> +                goto end;
> +            }
>=20=20
> -    if (!X509_STORE_add_crl(store, crl))
> -    {
> -        msg(M_WARN, "CRL: cannot add %s to store", crl_file);
> -        goto end;
> +            ERR_error_string_n(err, buf, sizeof(buf));
> +

> +            msg(M_WARN, "CRL: cannot read CRL from file %s: %s", crl_fil=
e, buf);

Use crypto_msg that handles the openssl error stack printing.

> +            goto end;
> +        }
> +
> +        if (!X509_STORE_add_crl(store, crl))
> +        {
> +            msg(M_WARN, "CRL: cannot add %s to store", crl_file);

Same here.

> +            X509_CRL_free(crl);
> +            goto end;
> +        }
> +        X509_CRL_free(crl);
>      }
>=20=20
>  end:
> -    X509_CRL_free(crl);
> +    msg(M_INFO, "CRL: loaded %d CRLs from file %s", i, crl_file);
>      BIO_free(in);
>  }
>=20=20
>=20



--iC7ifuuIUKTRgM80QhV7hGxRC9hY0zS6q--

--D3ixJOY0bJaGOTe9xkmIsLSKEbRkPGIGM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6FFaAACgkQFRhsZwKx
RFQcqg/9HnB65vpR/hTj9WsvO6uPDGI1SaqHSvcjfSvY3WRVB8eeWnObltO2W7Mj
0xOdoJz9zheHSie6nMSsv8SrV5CZMOueMgX1zatoJp2dcnt86BAdgU04SOGrXOyb
ftlXxmYeY7lMmjqZgSJaWFrxLM/NjdXQoNZDMpVtZo74Sb29TnxDlrw1xd1VKmVb
G44yIEW4359umo9kQQsNANIoPFayd3GbR9VVjgMGOR3dk5IDRIEIRBAfu5gkGIOZ
pybAyjxDXmzKsYIBd1pGUkz7ssXF9vGcCYaj907Gm/nEtrRlUX664hSZkt1fx03n
8yaVfynJ5e1V1ILWSK4q5sVCg6GS/pwKYXze1BdwQw2asT3MZs5gwknNFjorZg+b
/dLr10PQkdYylv4ofIiZ1HcD2aobiBiZAuez1LcYALHSRELIweA5osbEU18owZQ5
AZBqrC2OXUX4nR3cwRKey9iTlOpDnpjJ4g0lh1QkS/7MrQP0ndjaaGRnjUJr1Nq6
r89Mn4zNOhVdAmeLhHCnlyUyp9fxDaIRWjON0t4jbagiqXHW9IkoY7wDEqc0yLtR
lIbP0Ao7usJedTJaQgfEpROLVv7ne3RWtu88OwSiL+IQ7l5iiFjlHPy2+bfA7FAZ
ywqlabWVsJpJK80jU1ny/hsCCtYOREdG+xZAJ3aJtGt9+z79eSM=
=5m+i
-----END PGP SIGNATURE-----

--D3ixJOY0bJaGOTe9xkmIsLSKEbRkPGIGM--

