References: <1492699272.18647.3.camel@...2264...>
	<1493853048.30207.1.camel@...2264...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <4f72f2c8-6cf3-275e-d89b-921b0320395e@...1856...>
Date: Sun, 7 May 2017 17:53:36 +0200
MIME-Version: 1.0
In-Reply-To: <1493853048.30207.1.camel@...2264...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="96xpa6t9oMwrEoPOaPEuxnrHMrB5B3nc7"
Subject: Re: [Openvpn-devel] [PATCH] Fix extract_x509_field_ssl for external
 objects, v2
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
--96xpa6t9oMwrEoPOaPEuxnrHMrB5B3nc7
Content-Type: multipart/mixed; boundary="hTV4XnBE0JEjXl4Jw09GovPwuQjrxI2Qh";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <4f72f2c8-6cf3-275e-d89b-921b0320395e@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix extract_x509_field_ssl for external
	objects, v2
References: <1492699272.18647.3.camel@...2264...>
	<1493853048.30207.1.camel@...2264...>
In-Reply-To: <1493853048.30207.1.camel@...2264...>

--hTV4XnBE0JEjXl4Jw09GovPwuQjrxI2Qh
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 04-05-17 01:10, Hristo Venev wrote:
> Only fields known to OpenSSL have a NID. OBJ_txt2obj allows specifying
> fields by numeric OID.
>=20
> Signed-off-by: Hristo Venev <hristo@...2264...>
> ---
>  src/openvpn/ssl_verify_openssl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index 87f71f21..b6867c65 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -191,16 +191,24 @@ extract_x509_field_ssl(X509_NAME *x509, const char =
*field_name, char *out,
>      X509_NAME_ENTRY *x509ne =3D 0;
>      ASN1_STRING *asn1 =3D 0;
>      unsigned char *buf =3D NULL;
> -    int nid =3D OBJ_txt2nid(field_name);
> +    ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);
> +
> +    if (field_name_obj =3D=3D NULL)
> +    {
> +        msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", field_name=
);
> +        return FAILURE;
> +    }
>=20=20
>      ASSERT(size > 0);
>      *out =3D '\0';
>      do
>      {
>          lastpos =3D tmp;
> -        tmp =3D X509_NAME_get_index_by_NID(x509, nid, lastpos);
> +        tmp =3D X509_NAME_get_index_by_OBJ(x509, field_name_obj, lastpos=
);
>      } while (tmp > -1);
>=20=20
> +    ASN1_OBJECT_free(field_name_obj);
> +
>      /* Nothing found */
>      if (lastpos =3D=3D -1)
>      {
>=20

Thanks for following up.  ACK.

-Steffan


--hTV4XnBE0JEjXl4Jw09GovPwuQjrxI2Qh--

--96xpa6t9oMwrEoPOaPEuxnrHMrB5B3nc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZD0MJAAoJEJgCyj0AftKItSoIAJF/iRMOs/OS4YGb7LbUDCgH
gkAU3qKllSdYzhY1K32Bp0nwVXSyHHMeSWKzrw+ahCkyPSnK/3kem35obyluGbBL
/ECukV0tZck+vg//AHHxU+1N8o91hvWffLtH7H2fxnpShHIELKovInVDgES8PB2V
Ep8/h10y8ARjQXYPHUZcqJTSZ4mGFlrkdDgSTx0EFfN9BpmehrSyMCV9VTKwmnfz
84AaSc6aWKJIiOLSLZbGcdRMg4a/XzXQ3rxTlzM/ewSewUst9Df7pJMVR0XhQSVV
nMJOWXHQhbLjvjI2BLcZWnMKGzdRPbu4ZH5BSnYu2N8Y0XN9o3jqgYSKDusPCuU=
=5TKV
-----END PGP SIGNATURE-----

--96xpa6t9oMwrEoPOaPEuxnrHMrB5B3nc7--

