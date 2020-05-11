References: <20200510140017.16837-1-a@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <79d5ce3f-9070-8ceb-eb0e-c91664bcf12b@...2080...>
Date: Mon, 11 May 2020 14:20:42 +0200
MIME-Version: 1.0
In-Reply-To: <20200510140017.16837-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Jz4fRRMU7HfBGmQ1wNDA1NuqdEK29yKfR"
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt-v2: fix testing of inline key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jz4fRRMU7HfBGmQ1wNDA1NuqdEK29yKfR
Content-Type: multipart/mixed; boundary="jRzGUlxMxdldvkh8BlyNQOazsZZWnT8AA";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Antonio Quartulli <a@...2181...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <79d5ce3f-9070-8ceb-eb0e-c91664bcf12b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt-v2: fix testing of inline key
References: <20200510140017.16837-1-a@...2181...>
In-Reply-To: <20200510140017.16837-1-a@...2181...>

--jRzGUlxMxdldvkh8BlyNQOazsZZWnT8AA
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 10/05/2020 16:00, Antonio Quartulli wrote:
> The inline logic was recently changed by commit
> ("convert *_inline attributes to bool"), however the code testing a
> newly created tls-crypt-v2 client key was not adapted.
>=20
> Adapt tls-crypt-v2 test routine by properly signaling when the passed
> key is inlined or not.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/tls_crypt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
> index 484d4d46..a3894d66 100644
> --- a/src/openvpn/tls_crypt.c
> +++ b/src/openvpn/tls_crypt.c
> @@ -697,14 +697,14 @@ tls_crypt_v2_write_client_key_file(const char *file=
name,
>          goto cleanup;
>      }
>=20=20
> -    const char *client_filename =3D filename;
> -    const char *client_inline =3D NULL;
> +    const char *client_file =3D filename;
> +    bool client_inline =3D false;
>=20=20
>      if (!filename || streq(filename, ""))
>      {
>          printf("%s\n", BPTR(&client_key_pem));
> -        client_filename =3D INLINE_FILE_TAG;
> -        client_inline =3D (const char *)BPTR(&client_key_pem);
> +        client_file =3D (const char *)BPTR(&client_key_pem);
> +        client_inline =3D true;
>      }
>      else if (!buffer_write_file(filename, &client_key_pem))
>      {
> @@ -717,7 +717,7 @@ tls_crypt_v2_write_client_key_file(const char *filena=
me,
>      struct buffer test_wrapped_client_key;
>      msg(D_GENKEY, "Testing client-side key loading...");
>      tls_crypt_v2_init_client_key(&test_client_key, &test_wrapped_client_=
key,
> -                                 client_filename, client_inline);
> +                                 client_file, client_inline);
>      free_key_ctx_bi(&test_client_key);
>=20=20
>      /* Sanity check: unwrap and load client key (as "server") */
>=20

This looks good.

Without this patch, generating tls-crypt-v2-client keys fails.

--------------------------------------------------------------
$ ./src/openvpn/openvpn --tls-crypt-v2 tv2-srv --genkey tls-crypt-v2-client
-----BEGIN OpenVPN tls-crypt-v2 client key-----
OCvS/y1ZC/jDJ6wSkVMITJ7t5kI4XRLRikUP8TTukOtXlLHVwVbkL5Sw7cO+ChAf
RcngI8Zzglk2u3fYmlsfU9W6aBouUeBxjixPamA0Yr4xg15eb30HZU2i6YPkJVIL
iiSU+IlfR694fSEWM/j/+Yy3dOid6/kqUpw6Py5wpGuwMJ2ZKBYq+OQhwQ+HBZvF
ftYMJ1W21wx4hWiNT4EyqlC/WYJJFsOpW67eLHQ6L61tMxrQBdSEMTfrP0vlC8lj
anQMIfaDg7RHVq4oiXiTvrA7EgVJi0dra3DND/OXrtk5SyiDfJ1V2VuQ8fs6IoYf
PHXXGuWYCAfBT+0A/ZQ9Agc1jtvRbyYJxkebCid5xCOV8sDSEBCP/PivP+Mysysk
3kptpJQhJx4FHf65xxvVdxio9VW2fyw5NawYdX1XFtVzro486f++8q32Ma8HtD4V
ZCy39QdjK5SzNXKO3Q1Vun3IVtrCA6TMfoyHMkTYcnWkr0a4t47u9tefIJmcwmF5
iBMvKGoEQqjM+Xll9Vqi1FmW35JaQXz9gE8YXi+CC2vB3jrW07W9Xg+m9E6qhxv7
x3wTWRvHDeGaCJlQOO3QVClQMcsryLmBe7Dev8ido54JEAGVHkf0kfC/7E+yFgDq
PMFg99QKQph2HlLS8NOUg5RTgRGkg0VWj+paaOQ7Vej77io9M/1yR4TtyDxovfgN
AZFUlRNuCd7sGHDmwHKA0giaAgvfDpCodQEr
-----END OpenVPN tls-crypt-v2 client key-----

Mon May 11 14:16:24 2020 crypto_pem_decode: PEM decode failed
Mon May 11 14:16:24 2020 ERROR: OpenVPN tls-crypt-v2 client key pem decode =
failed
Mon May 11 14:16:24 2020 ERROR: invalid tls-crypt-v2 client key format
Mon May 11 14:16:24 2020 Exiting due to fatal error
--------------------------------------------------------------

With this patch, the error messages below the generated key is gone.  And
since the code changes are not surprising, this is good to go.


Acked-by: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--jRzGUlxMxdldvkh8BlyNQOazsZZWnT8AA--

--Jz4fRRMU7HfBGmQ1wNDA1NuqdEK29yKfR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeuUMfAAoJEIbPlEyWcf3yE3QP/3yX7EA8rCpqfr8cd0PpojDo
OCLlEEPSTzTE7x9n8oOyr7EsCiDD1R17kvbcrFhcpUEPqPGUY81KIlYwJTxwbtVa
Eq2vlXKycw8InL/ZQR84G7VCu/dpNj2rSdb9sA1r7KgFnEFYmEBMskSSQxVBHAqR
KU04mMPkAOhJMkkO2tLwcIWyb4KMrV6UrC77gEKxwyQpUBEikPmreXXJS4lnatd8
+jfmNDUQAd+Cg8hhAqMZtv+J3barwM8qtqi8D4D21mESVTbQ25PDRmkF8fUWpyHI
6746I1LPmZ2/h/5yihueMNIt3mKPnNHqOBi5N5N6A4wP/f2jRmSpJ5wzXefpocEu
JXCpY3deyoEe5rnkgYkjxdBlCTsU2L4hzBiEtlWvD2fzOTAScvkV2ngjTD6rerkm
5rd1eBz8EpJQ3yURev0Niv9EcMFuyD8bXXO4Zexfu7gGqfmX/PVoGtMSA8Nv4kET
4WWkr7bpIkDQ8KT9O6N9xLwBpHaWobAoCkMHKDfYbBcSIWQskEtrYHF9eG0aaLXE
lrJGHdVogeRcQ8ycbTl9zCbCW9tf1w0y2n4E8SL7/q5F+h9WSluuZIFmBJErjhMl
S6w/JwI4odiH/VohcaZzAQG+64H/DA54OyqgbwGwkDK56kotGZdcr1rKPkPUDF3r
thm2bPtk0PkYwLPoEwtK
=vpG5
-----END PGP SIGNATURE-----

--Jz4fRRMU7HfBGmQ1wNDA1NuqdEK29yKfR--

