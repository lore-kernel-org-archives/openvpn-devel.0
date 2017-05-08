References: <1494154878-18403-1-git-send-email-steffan@...1856...>
	<bfbabfcb-6b0f-5cc7-41f5-23da19bb9051@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <7fbb1933-c607-b62b-bf69-de60deceae19@...1435...>
Date: Mon, 8 May 2017 17:36:51 +0200
MIME-Version: 1.0
In-Reply-To: <bfbabfcb-6b0f-5cc7-41f5-23da19bb9051@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FBIKufKbr1bcnSdRcViT1huplp4c4WOnD"
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak in x509_verify_cert_ku()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--FBIKufKbr1bcnSdRcViT1huplp4c4WOnD
Content-Type: multipart/mixed; boundary="o8KrJ25vn1BUmNVhkIGnOT7bjrOqTNBh4";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <7fbb1933-c607-b62b-bf69-de60deceae19@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak in x509_verify_cert_ku()
References: <1494154878-18403-1-git-send-email-steffan@...1856...>
	<bfbabfcb-6b0f-5cc7-41f5-23da19bb9051@...2080...>
In-Reply-To: <bfbabfcb-6b0f-5cc7-41f5-23da19bb9051@...2080...>

--o8KrJ25vn1BUmNVhkIGnOT7bjrOqTNBh4
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08-05-17 16:54, David Sommerseth wrote:
> On 07/05/17 13:01, Steffan Karger wrote:
> --------------------------------------------------------------------
> result_t
> x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku,
>                     int expected_len)
> {
>     ASN1_BIT_STRING *ku =3D X509_get_ext_d2i(x509, NID_key_usage,
>                                            NULL, NULL);
>=20
>     if (ku =3D=3D NULL)
>     {
>         msg(D_TLS_ERRORS, "Certificate does not have key "
>                            "usage extension");
>         return FAILURE;
>     }
>=20
>     if (expected_ku[0] =3D=3D OPENVPN_KU_REQUIRED)
>     {
>         /* Extension required, value checked by TLS library */
>         ASN1_BIT_STRING_free(ku);   /** new line **/
>         return SUCCESS;
>     }
>=20
>     unsigned nku =3D 0;
>     for (size_t i =3D 0; i < 8; i++)
> --------------------------------------------------------------------
>=20
> Wouldn't it make more sense to rather move the
> `if (expected_ku[0] =3D=3D OPENVPN_KU_REQUIRED)` block above the
> `ASN1_BIT_STRING *ku` declaration?   Like this:
>=20
>=20
> --------------------------------------------------------------------
> result_t
> x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku,
>                     int expected_len)
> {
>     if (expected_ku[0] =3D=3D OPENVPN_KU_REQUIRED)
>     {
>         /* Extension required, value checked by TLS library */
>         return SUCCESS;
>     }
>=20
>     ASN1_BIT_STRING *ku =3D X509_get_ext_d2i(x509, NID_key_usage,
>                                            NULL, NULL);
>     if (ku =3D=3D NULL)
>     {
>         msg(D_TLS_ERRORS, "Certificate does not have key "
>                            "usage extension");
>         return FAILURE;
>     }
>=20
>     unsigned nku =3D 0;
>     for (size_t i =3D 0; i < 8; i++)
> --------------------------------------------------------------------
>=20
> Or is the implicit check that ku !=3D NULL important when checking
> OPENVPN_KU_REQUIRED ?

Exactly.  OPENVPN_KU_REQUIRED means that we need *some* ku, so we need
to first get ku, and error out if it's NULL.  At the location in my
patch, we know that it's non-null, so it's good.

-Steffan


--o8KrJ25vn1BUmNVhkIGnOT7bjrOqTNBh4--

--FBIKufKbr1bcnSdRcViT1huplp4c4WOnD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZEJCXAAoJEEEwndWOY1w50/AIAIvdy1DzmpaXbik1BuciCddr
0D2XXgoZZnu+6dJIukv/NzTlXzVZJ9yKrBGMm7GrEitMFZzn6r06zRC+LyhfbFua
1d1jKx0wGSe91bKJMAglJ1Us0APxl6LOujM2wTm1GPhQU+OOxUKPOrD62QU0uCiO
DDh4wUSztbew1zM++uzp4Rr6S+yAc7YNrwcVqA3VOM9PJcmYy5fkpbFpQgl5uQRC
/P5JSy2h7w8P5SPSJebsETEe4ApzRbFcgXhQluqJoHZptFz4PqKqQDIarL5FghAI
oCnDd8gZ3gxNqrPX7plq1efIl9BljZ1x5TmDsRse8sW7+k0m1KWWr6+80YDrqTE=
=JKIL
-----END PGP SIGNATURE-----

--FBIKufKbr1bcnSdRcViT1huplp4c4WOnD--

