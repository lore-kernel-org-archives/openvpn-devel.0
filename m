References: <20200414185214.1863-1-juliusz@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c33a84b3-b10a-a8c2-d46a-3ee2d296f7f1@...1227...>
Date: Wed, 15 Apr 2020 11:31:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200414185214.1863-1-juliusz@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8NTwB9VSReKbXwDcEsVkof4u9b5xOVrR5"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8NTwB9VSReKbXwDcEsVkof4u9b5xOVrR5
Content-Type: multipart/mixed; boundary="RQeEfbUrb4xuhy7bKAlOSxSF3J8ykCp8W"

--RQeEfbUrb4xuhy7bKAlOSxSF3J8ykCp8W
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 14.04.20 um 20:52 schrieb Juliusz Sosinowicz:
> This patch adds support for wolfSSL in OpenVPN. Support is added by using=
 wolfSSL's OpenSSL compatibility layer. Function calls are left unchanged a=
nd instead the OpenSSL includes point to wolfSSL headers and OpenVPN is lin=
ked against the wolfSSL library.
>=20
> As requested by OpenVPN maintainers, this patch does not include wolfssl/=
options.h on its own. By defining the macro EXTERNAL_OPTS_OPENVPN in the co=
nfigure script wolfSSL will include wolfssl/options.h on its own (change ad=
ded in https://github.com/wolfSSL/wolfssl/pull/2825). The patch adds an opt=
ion '--disable-wolfssl-options-h' in case the user would like to supply the=
ir own settings file for wolfSSL.
>=20

Thanks the patch is lot less intrusive then the last version. We will
have to discuss in our meeting under what condition we want to include
the patch. We might add a note or statement that the WolfSSL support in
OpenVPN is mainly developed and tested by WolfSSL itself or something
along these lines.

> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 453cb20a..73da5fa7 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -428,7 +428,7 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffe=
r work,
>      tag_ptr =3D BPTR(buf);
>      ASSERT(buf_advance(buf, tag_size));
>      dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_si=
ze, 0, &gc));
> -#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x1000104=
0L
> +#if (defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x100010=
40L) || defined(ENABLE_CRYPTO_WOLFSSL)
>      /* OpenSSL <=3D 1.0.1c bug requires set tag before processing cipher=
text */
>      if (!EVP_CIPHER_CTX_ctrl(ctx->cipher, EVP_CTRL_GCM_SET_TAG, tag_size=
, tag_ptr))
>      {

Are you sure that WolfSSL requires a workaround for old OpenSSL version
before 1.0.1d?

Arne


--RQeEfbUrb4xuhy7bKAlOSxSF3J8ykCp8W--

--8NTwB9VSReKbXwDcEsVkof4u9b5xOVrR5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6W1HgACgkQFRhsZwKx
RFRMEBAAokl5ISuceV7S+bomLzia3naz1E+PR+jAzfFMcq2AbsgInpc5/qJ0FoJQ
2bDw64ApJYA0LOYW+1JneaJCjZlagamR5AVw9Syuvc05jfcYw42TTr86yUUJCNYB
AIMJeAYftMaCZTULcLrKw9HN53vyYDzuSfkVs3EWshHxYkMEDUVB7dUr2dRZpAql
x0ngX5mh4VV2w3qZK0cOqaqefst4oiJR458QiyqyOsQYfTSq1lOZ4CxHxLBqUshD
8rD7hZZqz1OEMH6Eo02Ik/d0S6U0FndTJyznFTs9c2LQUEppnO0Aj1zAPvDEZLmN
JxEvZ/LY4+6hw9tz9dzigRs2rNwcWqn+t08aT33Nx/r9y7JemeQsOdWBQLFpql/2
GsoRD0HiP4eOL+ZgOe0rJhcPqLcpk/ynZlJ9rgFwd9RW5hVPEClceA+deqsl59wf
OxgQ1OcWcTjJW/6wP5V7fpzwM8VRjUTJYw99J3aSP5CEIAJR+DOyS69Q2+xi8zc4
uhcgEO+zH5j82T1UYZ7QLgWurRSGhAUNUnKhnYsORH40H3iOHS5/V8MplxP4i00z
37EicEE34axQ5Y1OglvYAvkBw3d/J4A1mKnDxdpR+wFD+Y/XKTRtNqvfl3oOjp00
Mx1Sq4yUSBqy4zLRowTw1goQ+4hEOqnd5k0E/qOPSl+/8TpbRPg=
=JP+M
-----END PGP SIGNATURE-----

--8NTwB9VSReKbXwDcEsVkof4u9b5xOVrR5--

