References: <1494154878-18403-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bfbabfcb-6b0f-5cc7-41f5-23da19bb9051@...2080...>
Date: Mon, 8 May 2017 16:54:22 +0200
MIME-Version: 1.0
In-Reply-To: <1494154878-18403-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d7WovGLA5Kf9sNIXhhF6Hpdm4D1cLfrta"
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak in x509_verify_cert_ku()
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d7WovGLA5Kf9sNIXhhF6Hpdm4D1cLfrta
Content-Type: multipart/mixed; boundary="2U5ulb3iONdX4GgKTpF9GWaJtTg4aQQbV";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <bfbabfcb-6b0f-5cc7-41f5-23da19bb9051@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak in x509_verify_cert_ku()
References: <1494154878-18403-1-git-send-email-steffan@...1856...>
In-Reply-To: <1494154878-18403-1-git-send-email-steffan@...1856...>

--2U5ulb3iONdX4GgKTpF9GWaJtTg4aQQbV
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/05/17 13:01, Steffan Karger wrote:
> If keyUsage was only required to be present, but no specific value was
> required, we would omit to free the extracted string.  This happens as of
> 2.4.1, if --remote-cert-tls is used.  In that case we leak a bit of
> memory on each TLS (re)negotiation.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  Changes.rst                      | 9 +++++++++
>  src/openvpn/ssl_verify_openssl.c | 1 +
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/Changes.rst b/Changes.rst
> index c1583b3..3dba7e0 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -318,3 +318,12 @@ Version 2.4.1
>    ``--remote-cert-tls`` uses the far more common keyUsage and extendedKe=
yUsage
>    extension instead.  Make sure your certificates carry these to be able=
 to
>    use ``--remote-cert-tls``.
> +
> +
> +Version 2.4.2
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Bugfixes
> +--------
> +- Fix memory leak introduced in 2.4.1: if --remote-cert-tls is used, we =
leaked
> +  some memory on each TLS (re)negotiation.
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index 54eadbd..337729c 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -599,6 +599,7 @@ x509_verify_cert_ku(X509 *x509, const unsigned *const=
 expected_ku,
>      if (expected_ku[0] =3D=3D OPENVPN_KU_REQUIRED)
>      {
>          /* Extension required, value checked by TLS library */
> +        ASN1_BIT_STRING_free(ku);
>          return SUCCESS;
>      }
>=20=20

Just some nit-pick from me.  Below is a larger fragment of this function
(I've done some word-wrapping to make it slim enough for the mail).

--------------------------------------------------------------------
result_t
x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku,
                    int expected_len)
{
    ASN1_BIT_STRING *ku =3D X509_get_ext_d2i(x509, NID_key_usage,
                                           NULL, NULL);

    if (ku =3D=3D NULL)
    {
        msg(D_TLS_ERRORS, "Certificate does not have key "
                           "usage extension");
        return FAILURE;
    }

    if (expected_ku[0] =3D=3D OPENVPN_KU_REQUIRED)
    {
        /* Extension required, value checked by TLS library */
        ASN1_BIT_STRING_free(ku);   /** new line **/
        return SUCCESS;
    }

    unsigned nku =3D 0;
    for (size_t i =3D 0; i < 8; i++)
--------------------------------------------------------------------

Wouldn't it make more sense to rather move the
`if (expected_ku[0] =3D=3D OPENVPN_KU_REQUIRED)` block above the
`ASN1_BIT_STRING *ku` declaration?   Like this:


--------------------------------------------------------------------
result_t
x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku,
                    int expected_len)
{
    if (expected_ku[0] =3D=3D OPENVPN_KU_REQUIRED)
    {
        /* Extension required, value checked by TLS library */
        return SUCCESS;
    }

    ASN1_BIT_STRING *ku =3D X509_get_ext_d2i(x509, NID_key_usage,
                                           NULL, NULL);
    if (ku =3D=3D NULL)
    {
        msg(D_TLS_ERRORS, "Certificate does not have key "
                           "usage extension");
        return FAILURE;
    }

    unsigned nku =3D 0;
    for (size_t i =3D 0; i < 8; i++)
--------------------------------------------------------------------

Or is the implicit check that ku !=3D NULL important when checking
OPENVPN_KU_REQUIRED ?

Except of that, it looks fine and I'm willing to ACK it.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--2U5ulb3iONdX4GgKTpF9GWaJtTg4aQQbV--

--d7WovGLA5Kf9sNIXhhF6Hpdm4D1cLfrta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEIaeAAoJEIbPlEyWcf3yH38P/3a36kuz1+TbUhyy1NAr4UNc
eIZzGmJl15w3oCYGSd51DQPf1nSc55wjp2snIWbPengWe4qxdeqFJUKHn/OYd6fX
iPIRCsTl9x1K3zzS0eXN/4Fbse0djFT4ZjpYtEYRlIZ5nNdx3Xqa4B2x4nEYO9gu
f2f72dKbTkFE609+Sbo07PvP+SSlVH511gpdeXqIh//j9RQck6wnQTePae+yHqmJ
UTb73I/HZTYYANdrio0udj01/Nz5JSbWEQsnmBkpb8Fb9lerp143mbTh1PmR2TyW
r5xEFTqZqDNge1pZlmkfqXKNZw+/QYU8gFLEETHssU9/8ww4TIvXr3gTyGZtUsx1
A/fbg4FZMz4JT21O4ANkAz631UfGaP9sX+Mr4uwvjdpovZmuu99mZB44GEzkekuP
swYbU7Y2f4vC7gI8H+rqXMhtgRS6Kg0Sk4ibHH5NY+BT6DnEjhrpj31qNbtc/qYE
3igJM7923HrCqBTl1TEQErqEwvKfcr7s/93tNFWeDDmZhgO2BvfQ7Q3y3VlhgLHR
2SMI1LxCRi5dwgLNkTy5L80hxXYE6AlOYvL92tw4a3TfBjLoBTapQu27Mgenna/j
rfAHn6aTfhH8of8Rb6AJBWwxpmaEM+WbnCNllKXO4wqQJ6QEvtVmNF+2FVnjN5ZR
1Y8S/o7RNdLma7JChAuR
=VVEw
-----END PGP SIGNATURE-----

--d7WovGLA5Kf9sNIXhhF6Hpdm4D1cLfrta--

