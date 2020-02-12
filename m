References: <NaAsPRnb2g-raEjxjv15C_odADru2NIyXCs5wvZO609b_-4IqW2Do2sVbBull-FE9myUOZ7lNV6gdAx7MGugGUOBbdYOFO8AsoFHu35BIs8=@protonmail.com>
From: Arne Schwabe <arne@...1227...>
Message-ID: <64a78361-8b16-a924-99f4-fec954a78412@...1227...>
Date: Wed, 12 Feb 2020 15:39:02 +0100
MIME-Version: 1.0
In-Reply-To: <NaAsPRnb2g-raEjxjv15C_odADru2NIyXCs5wvZO609b_-4IqW2Do2sVbBull-FE9myUOZ7lNV6gdAx7MGugGUOBbdYOFO8AsoFHu35BIs8=@protonmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2mMulGCfIM6eHt8gsylRu2snLqgSZZ7oj"
Subject: Re: [Openvpn-devel] [PATCH] openssl: alternative names support for
 --verify-x509-name CN checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mateusz Markowicz <poniekad@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2mMulGCfIM6eHt8gsylRu2snLqgSZZ7oj
Content-Type: multipart/mixed; boundary="zsOrV6b05f6gPjjJjBhHoMwI27u58IKY3"

--zsOrV6b05f6gPjjJjBhHoMwI27u58IKY3
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.02.20 um 18:59 schrieb Mateusz Markowicz via Openvpn-devel:
> when using "--verify-x509-name [hostname] name" hostname will now be
> accepted
> also when matched against one of the X509v3 Subject Alternative Name IP
> or DNS
> entries (instead of just Subject's CN).
>=20
> see also:=C2=A0https://github.com/OpenVPN/openvpn/pull/136/
>=20
> Signed-off-by:=C2=A0Mateusz Markowicz <poniekad@...2282...
> <mailto:poniekad@...2282...>>


If this should have a chance of being included it needs to cover mbed
TLS as well.


Also documentation in the man page is missing.

> ---
> src/openvpn/options.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 +++
> src/openvpn/ssl_verify.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 18 +++++++++++---
> src/openvpn/ssl_verify.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 1 +
> src/openvpn/ssl_verify_backend.h |=C2=A0 7 ++++++
> src/openvpn/ssl_verify_mbedtls.c | 11 +++++++++
> src/openvpn/ssl_verify_openssl.c | 42 ++++++++++++++++++++++++++++++++
> 6 files changed, 80 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 173a1eea..438dfff0 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -8144,6 +8144,10 @@ add_option(struct options *options,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 type =3D VERIFY_X509_SUBJECT_RDN_PREFIX;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else =
if (streq(p[2], "subject-alt-name"))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 type =3D VERIFY_X509_SAN;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 msg(msglevel, "unknown X.509 name type: %s", p[2]);
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 65188d23..6480b5eb 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -390,15 +390,27 @@ verify_peer_cert(const struct tls_options *opt,
> openvpn_x509_cert_t *peer_cert,
> =C2=A0=C2=A0=C2=A0=C2=A0 /* verify X509 name or username against --verify=
-x509-[user]name */
> =C2=A0=C2=A0=C2=A0=C2=A0 if (opt->verify_x509_type !=3D VERIFY_X509_NONE)
> =C2=A0=C2=A0=C2=A0=C2=A0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ( (opt->verify_x509_type =
=3D=3D VERIFY_X509_SUBJECT_DN
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool match;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (opt->verify_x509_type =3D=
=3D VERIFY_X509_SAN)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool =
have_alt_names;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match=
 =3D x509v3_is_host_in_alternative_names(peer_cert,
> opt->verify_x509_name, &have_alt_names)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || (!have_alt_names &&
> strcmp(opt->verify_x509_name, common_name) =3D=3D 0);

I know that this technically correct C but setting a variable in the
first part of via & and then using it in the second part feels like not
good style. I would rather like too a bit more verbose and less clever
code that is easier to understand.


> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match=
 =3D (opt->verify_x509_type =3D=3D VERIFY_X509_SUBJECT_DN
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 && strcmp(opt->verify_x509_name, subject) =3D=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 || (opt->verify_x509_type =3D=3D VERIFY_X509_SUBJECT_RDN
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && strcmp(opt->verify_x509_name, common_name=
) =3D=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 || (opt->verify_x509_type =3D=3D VERIFY_X509_SUBJECT_RDN_PREFIX
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && strncmp(opt->verify_x509_name, common_nam=
e,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 strlen(opt->verify_x509_name)) =3D=3D 0) )
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 strlen(opt->verify_x509_name)) =3D=3D 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (match)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg(D=
_HANDSHAKE, "VERIFY X509NAME OK: %s", subject);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg(D=
_HANDSHAKE, "VERIFY X509NAME OK: %s",
> opt->verify_x509_name);

This changes the log message. If you want to verify that the cert prefix
with OVPN-client or something you don't get to see what certificate you
accepted anymore. If you want to log opt->verify_x509_name that needs to
be in addition.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
> index c54b89a6..1295e76b 100644
> --- a/src/openvpn/ssl_verify.h
> +++ b/src/openvpn/ssl_verify.h
> @@ -64,6 +64,7 @@ struct cert_hash_set {
> #define VERIFY_X509_SUBJECT_DN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1
> #define VERIFY_X509_SUBJECT_RDN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 2
> #define VERIFY_X509_SUBJECT_RDN_PREFIX=C2=A0 3
> +#define VERIFY_X509_SAN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>=20
> #define TLS_AUTHENTICATION_SUCCEEDED=C2=A0 0
> #define TLS_AUTHENTICATION_FAILED=C2=A0=C2=A0=C2=A0=C2=A0 1
> diff --git a/src/openvpn/ssl_verify_backend.h
> b/src/openvpn/ssl_verify_backend.h
> index d6b31bfa..927a5a29 100644
> --- a/src/openvpn/ssl_verify_backend.h
> +++ b/src/openvpn/ssl_verify_backend.h
> @@ -268,4 +268,11 @@ result_t x509_write_pem(FILE *peercert_file,
> openvpn_x509_cert_t *peercert);
> =C2=A0 */
> bool tls_verify_crl_missing(const struct tls_options *opt);
>=20
> +/**
> + * Return true iff {host} was found in {cert} Subject Alternative Names
> DNS or IP entries.
> + * If {has_alt_names} !=3D NULL it'll return true iff Subject Alternative
> Names were defined
> + * for {cert}.
> + */
> +bool x509v3_is_host_in_alternative_names(openvpn_x509_cert_t *cert,
> const char *host, bool *has_alt_names);
> +
> #endif /* SSL_VERIFY_BACKEND_H_ */
> diff --git a/src/openvpn/ssl_verify_mbedtls.c
> b/src/openvpn/ssl_verify_mbedtls.c
> index fd31bbbd..2f2e04be 100644
> --- a/src/openvpn/ssl_verify_mbedtls.c
> +++ b/src/openvpn/ssl_verify_mbedtls.c
> @@ -245,6 +245,17 @@ x509_get_subject(mbedtls_x509_crt *cert, struct
> gc_arena *gc)
> =C2=A0=C2=A0=C2=A0=C2=A0 return subject;
> }
>=20
> +bool
> +x509v3_is_host_in_alternative_names(mbedtls_x509_crt *cert, const char
> *host, bool *has_alt_names)
> +{
> +=C2=A0=C2=A0=C2=A0 msg(M_WARN, "Missing support for subject alternative =
names in
> mbedtls.");
> +=C2=A0=C2=A0=C2=A0 if (has_alt_names !=3D NULL)
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *has_alt_names =3D false;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 return false;
> +}


*has_alt_names =3D (has_alt_names !=3D NULL);





--zsOrV6b05f6gPjjJjBhHoMwI27u58IKY3--

--2mMulGCfIM6eHt8gsylRu2snLqgSZZ7oj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5EDgYACgkQFRhsZwKx
RFTDMhAAqEEmTfDtw1o8a2XFlMSVufsTF5C+034kpJFk60ms9AirqEAvjoLxbkb3
TczyE3tPQdLXz146KidC8X0MGzTcQuWgartK8Q+JDBHiSO/oN4C1+RNjjG3I1+Lz
Qpg3/OKsl2arX43TmNl7XlJswOUdYRm8vOtIs1B60f3WycOuoeJjECawF3si8pSN
TvRunQ2MDIv2ZfpzVqa/wv2sQoDFH9KQFbT471cHMIBUUBJtADZ36RGGycs0lsaD
pQON2KbGiS4DezsAJDOfs7ifFak8bKavf372pBsX/ZricnAPHZmhKqvdPxBD+j8b
3s3v9IA/xL+jpJTcLh6EbctVJFv+kGetNJW+mqHYIfBZ0MGtRTnUc9agqSHobbHm
nKlRM19sogThRDzYB+R9ULpM+gReT/1WkKWdjKDfd2u1shnmk1mj8qe7x1eSivnB
dhbBb+LQQwMF7DJ73BaRo7IunItNXd6rURa6YNyhGt3reHwk1VZ6PRzcPXILpJ+M
6HlfkBUGThF5VNmFU1z+tn/IbGpAvAelJs9uL+swuYvEnv9eLEL4gVBwM//hjdY6
RJAXcDp3rV4wQ6qQPMjNPXHy2+ZfDkDQA+wzg/FtNWjS7UL1SJBJJQ/HKHChIElC
7CBGe4xetCr6njH0REdWrLyNrr64RnPW+1Ztxh3OS5X+IOH3Izw=
=CLCx
-----END PGP SIGNATURE-----

--2mMulGCfIM6eHt8gsylRu2snLqgSZZ7oj--

