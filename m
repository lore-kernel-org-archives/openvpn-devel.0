References: <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
 <20181007223035.21179-1-steffan@...1856...>
 <20181007223035.21179-2-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9b927c56-b850-b019-2385-2e9e199389b0@...2181...>
Date: Mon, 8 Oct 2018 17:18:32 +0800
MIME-Version: 1.0
In-Reply-To: <20181007223035.21179-2-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pftnZ9UkdgcFELsydavcUZMicZF8X2RNZ"
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] List ChaCha20-Poly1305 as stream
 cipher
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pftnZ9UkdgcFELsydavcUZMicZF8X2RNZ
Content-Type: multipart/mixed; boundary="JuTuhLlpWaV2QIjcAiXPT3NDMIKXMy1Oy";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <9b927c56-b850-b019-2385-2e9e199389b0@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] List ChaCha20-Poly1305 as stream
 cipher
References: <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
 <20181007223035.21179-1-steffan@...1856...>
 <20181007223035.21179-2-steffan@...1856...>
In-Reply-To: <20181007223035.21179-2-steffan@...1856...>

--JuTuhLlpWaV2QIjcAiXPT3NDMIKXMy1Oy
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

see below:

On 08/10/18 06:30, Steffan Karger wrote:
[CUT]
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index 0c39eccc..54ac1893 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -140,26 +140,6 @@ const cipher_name_pair cipher_name_translation_table=
[] =3D {
>  const size_t cipher_name_translation_table_count =3D
>      sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translat=
ion_table);
>=20=20
> -static void
> -print_cipher(const cipher_kt_t *info)
> -{
> -    if (info && (cipher_kt_mode_cbc(info)
> -#ifdef HAVE_AEAD_CIPHER_MODES
> -                 || cipher_kt_mode_aead(info)
> -#endif
> -                 ))
> -    {
> -        const char *ssl_only =3D cipher_kt_mode_cbc(info) ?
> -                               "" : ", TLS client/server mode only";
> -        const char *var_key_size =3D info->flags & MBEDTLS_CIPHER_VARIAB=
LE_KEY_LEN ?
> -                                   " by default" : "";
> -
> -        printf("%s  (%d bit key%s, %d bit block%s)\n",
> -               cipher_kt_name(info), cipher_kt_key_size(info) * 8, var_k=
ey_size,
> -               cipher_kt_block_size(info) * 8, ssl_only);
> -    }
> -}
> -
>  void
>  show_available_ciphers(void)
>  {
> @@ -175,7 +155,8 @@ show_available_ciphers(void)
>      while (*ciphers !=3D 0)
>      {
>          const cipher_kt_t *info =3D mbedtls_cipher_info_from_type(*ciphe=
rs);
> -        if (info && !cipher_kt_insecure(info))
> +        if (info && !cipher_kt_insecure(info)
> +            && (cipher_kt_mode_aead(info) || cipher_kt_mode_cbc(info)))
>          {
>              print_cipher(info);

apparently crypto.h is not included:

crypto_mbedtls.c: In function =E2=80=98show_available_ciphers=E2=80=99:
crypto_mbedtls.c:161:13: warning: implicit declaration of function
=E2=80=98print_cipher=E2=80=99; did you mean =E2=80=98print_argv=E2=80=99? =
[-Wimplicit-function-declaration]
             print_cipher(info);
             ^~~~~~~~~~~~

When compiling with OpenSSL I couldn't see any warning.


Cheers,

--=20
Antonio Quartulli


--JuTuhLlpWaV2QIjcAiXPT3NDMIKXMy1Oy--

--pftnZ9UkdgcFELsydavcUZMicZF8X2RNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu7IOgACgkQ9FVsWUWD
Dm21xw/8Cc+Yshr6xYPg0hXfDjJbjZBiEZU4+vcMKAWROp9VmoDO+0rE005e/oBc
hzbpMzdObFlAp+AnY+Ur2jYbHy4u9uDcbAqSnqq6elMzQfIQXgLz2M3cn+iiVnoa
DCjwSl2IZXgvp/rvR6Wi+5OidKAsARQluuAd1jR7QDpAbiLX43HoHdf9PpFMZzfy
/Sd6vfi/v6N/835qJtODnvJybcpl8uKh5Ckq1k8yVpdgr1/OECQSHjNpjcEZUx+/
CU/sAKq2t3rJT+OG7vqgoQ4Q2nker3WVRLruvDB3zMCTtsXlaaeHYlChN/3q/29U
GdmfR2/6/OWoj/2UO9E+PaFIqJCL8/k+P9wRWuxSjM03aljovEbwyClm4xtzW/do
HlCQZm2KfDrhgvMRpwNSe5hFLeIkSXpOee0tBzn+B2wPDdf315lL/kS8H/cZzC12
Xr31Xmt2sm0FGspZP22tcVViIfX3+zBy48dgpa62w0vBMdjK/tIX+GlUzfUDhdwn
1PID1Jn2SWQvHa/zdc4ikanjHGTxp0MdHZ2FpzhH9rAMNltCOHyKbf1ZkiELSDAH
JVgjDvbnxt+9hDGshMT/z6J+SxBw7AoJZ3qLYs+xTkpKqSHMCtcj8XPGTlsvJNQe
TDnWvvCJgPNI8dL98Qpn34WPp2gZCErb5+zw0eO0L1JiM4zf/Ok=
=Ykb/
-----END PGP SIGNATURE-----

--pftnZ9UkdgcFELsydavcUZMicZF8X2RNZ--

