References: <1491815755-17637-1-git-send-email-steffan.karger@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
Date: Wed, 12 Apr 2017 01:53:35 +0200
MIME-Version: 1.0
In-Reply-To: <1491815755-17637-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="srN3hvWGk57r01PTQmXIPc5mi1ek1AjF5"
Subject: Re: [Openvpn-devel] [PATCH] Add --tls-cert-profile option for
 mbedtls builds
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--srN3hvWGk57r01PTQmXIPc5mi1ek1AjF5
Content-Type: multipart/mixed; boundary="bbBGBWKFhV9iAfU4i3FmbSufclDLScjsh";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add --tls-cert-profile option for mbedtls
	builds
References: <1491815755-17637-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1491815755-17637-1-git-send-email-steffan.karger@...1435...>

--bbBGBWKFhV9iAfU4i3FmbSufclDLScjsh
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 10/04/17 11:15, Steffan Karger wrote:
> This allows the user to specify what certificate crypto algorithms to
> support.  The supported profiles are 'preferred' (default), 'legacy' and
> 'suiteb', as discussed in <84590a17-1c48-9df2-c48e-4160750b2e33@...1783...=
.>
> (https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg1421=
4.html).
>=20
> This only implements the feature for mbed TLS builds, because for mbed it
> is both more easy to implement and the most relevant because mbed TLS 2+
> is by default somewhat restrictive by requiring 2048-bit+ for RSA keys.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/options.c     |  8 ++++++++
>  src/openvpn/options.h     |  1 +
>  src/openvpn/ssl.c         |  3 +++
>  src/openvpn/ssl_backend.h | 10 ++++++++++
>  src/openvpn/ssl_mbedtls.c | 51 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/openvpn/ssl_mbedtls.h |  1 +
>  src/openvpn/ssl_openssl.c |  6 ++++++
>  7 files changed, 80 insertions(+)
>=20
[...snip...]
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index ba8dadf..1fcee72 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
[...snip...]
>  void
> +tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
> +{
> +    if (0 =3D=3D strcmp(profile, "preferred"))

While you do say in the docs that profile MAY NOT be NULL, this will
cause a SEGV if it happens.  Wouldn't it be better better to either
report an error or ASSERT() if profile =3D=3D NULL?

> +    {
> +        ctx->cert_profile =3D openvpn_x509_crt_profile_preferred;
> +    }
> +    else if (0 =3D=3D strcmp(profile, "legacy"))
> +    {
> +        ctx->cert_profile =3D openvpn_x509_crt_profile_legacy;
> +    }
> +    else if (0 =3D=3D strcmp(profile, "suiteb"))
> +    {
> +        ctx->cert_profile =3D openvpn_x509_crt_profile_suiteb;
> +    }
> +    else
> +    {
> +        msg (M_FATAL, "ERROR: Invalid cert profile: %s", profile);
> +    }
> +}
[...snip...]
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -384,6 +384,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, c=
onst char *ciphers)
>  }
>=20=20
>  void
> +tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
> +{
> +    msg (M_WARN, "WARNING: --tls-cert-profile not supported for OpenSSL"=
);
> +}
> +

While I do understand the use of M_WARN here.  Wouldn't it be better to
use M__NONFATAL and make it more a like an "INFO" log line instead.
--tls-cert-profile is a brand new feature, where certificate profiles
are not (yet?) implemented for OpenSSL.  So that's strictly not a
warning of more critical aspects.  But it is however important to
highlight it.

Otherwise, I think this makes sense.  It would be good to have something
similar for OpenSSL too, to be feature complete against mbed TLS.

It seems usage() is lacking details about --tls-cert-profile for the
--help screen.

I have reviewed this by also comparing the implementation to what's done
in OpenVPN 3 [1].  The profile declaration and enabling it seems to be
very much aligned.  (on a side note, I have already added a default
profile for "legacy" in Fedora, as many users complained about OpenVPN
breaking on Fedora 26 and newer, which also looks fairly recognisable to
what is done here).

I will run some real tests tomorrow.  But quick smoke testing looks good.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--bbBGBWKFhV9iAfU4i3FmbSufclDLScjsh--

--srN3hvWGk57r01PTQmXIPc5mi1ek1AjF5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY7Wx/AAoJEIbPlEyWcf3yOucP/3vIyk2nzuqvFMCGOCZnI/vF
P35QfZ7VCuYj713JCuvzVgOg4lA/3QTUxTTpVP4/W9BQeKiwKn18ZVvB9CHzwZYj
LstZZQuLlzVOOG1t0U8C4PRa1QB/MyQKm4S1CCot5F8PPFN/RjDMSVKP2Z1rv4SB
YR7AgjmNyAC66kaz0PyPb06PXVUJ1tBCC5i790UvnxG1OR2VQkBGqxkIj8wSrC/B
aBBXq8gye9Ym9106lgwFGB3nfqqLfERN505TEa+7qiD5m+cBAqx++ydfnKMw04dm
08DxjUQlr/Y2BV1qZBbcROoAe4GQoKW7q9P8l37qtJ+D1mx951RcyP3gcVeiXRjy
/3nSM+CoxmIp6M/UdWEGkH64+jYzPfG31Jc246WRODzwmQ4L774DKi1mnbjZuziK
sQ64AudoGS+zZ+PGGgjkrAIhCRGsTdt33M5gtZ46ZkmDAyE+pRff4UdlKInNZt7Q
UFUom5KYISQtFQOnoSdluouJBGVJyl/2NpBPNdDIXms1bb3CBTkXuh4SqkFAcl1H
MT91VL+mqe0ez4MGO5tplxx/lmRDvg8bc9Wp8KKcVBvdZVFw0VS9fhthCJYR9dE3
oQGCS/4YthQscDZ2B0ZgXyk2Lgt0q9G9njVX8V9APpK9Ih3iYP0TCq09esUlwkrU
kXQJ/F7RBu00o+k1hLlN
=YaBk
-----END PGP SIGNATURE-----

--srN3hvWGk57r01PTQmXIPc5mi1ek1AjF5--

