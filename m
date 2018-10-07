From: Antonio Quartulli <a@...2181...>
References: <20181007073413.9778-1-steffan@...1856...>
 <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
Message-ID: <ea9f52d6-537d-31a8-b5e5-2bb05884aa9b@...2181...>
Date: Sun, 7 Oct 2018 22:18:46 +0800
MIME-Version: 1.0
In-Reply-To: <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l92uensOuYzcNLwejLFeQ3G5qf23NB8ba"
Subject: Re: [Openvpn-devel] [PATCH] Add support for CHACHA20-POLY1305 in
 the data channel
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
--l92uensOuYzcNLwejLFeQ3G5qf23NB8ba
Content-Type: multipart/mixed; boundary="NWXZQ3dgfcaqet6ld9KcilvTopxGLRPKf";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ea9f52d6-537d-31a8-b5e5-2bb05884aa9b@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for CHACHA20-POLY1305 in the
 data channel
References: <20181007073413.9778-1-steffan@...1856...>
 <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
In-Reply-To: <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>

--NWXZQ3dgfcaqet6ld9KcilvTopxGLRPKf
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/10/18 21:28, Antonio Quartulli wrote:
> Hi,
>=20
> On 07/10/18 15:34, Steffan Karger wrote:
>> We explicitly only supported GCM as a valid AEAD mode, change that to al=
so
>> allow ChaCha20-Poly1305 as an AEAD cipher.  That works nicely with our n=
ew
>> (GCM) data channel format, because is has the same 96-bit IV.
>                                      ^^ it
>=20
>>
>> Note that we need some tricks to not treat the cipher as insecure, becau=
se
>> we used to only look at the block size of a cipher to determine if find a
>> cipher insecure.  But ChaCha20-Poly1305 is a stream cipher, which essent=
ially
>> has a 'block size' of 1 byte and is reported as such.  So, special-case =
this
>> cipher to be in the list of secure ciphers.
>=20
> I am so excited we are finally including ChaCha20-Poly1305 support! :)
> Thanks!
>=20
>>
>> Signed-off-by: Steffan Karger <steffan@...1856...>
>> ---
>>  Changes.rst                  | 10 ++++++++++
>>  src/openvpn/crypto.c         |  2 +-
>>  src/openvpn/crypto_backend.h |  5 +++++
>>  src/openvpn/crypto_mbedtls.c | 21 ++++++++++++++++++---
>>  src/openvpn/crypto_openssl.c | 33 ++++++++++++++++++++++++++++-----
>>  src/openvpn/ssl.c            |  2 +-
>>  6 files changed, 63 insertions(+), 10 deletions(-)
>>
>> diff --git a/Changes.rst b/Changes.rst
>> index a6090cf5..70ce2e10 100644
>> --- a/Changes.rst
>> +++ b/Changes.rst
>> @@ -1,3 +1,13 @@
>> +Overview of changes in 2.5
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> +
>> +New features
>> +------------
>> +ChaCha20-Poly1305 cipher support
>> +    Added support for using the ChaCha20-Poly1305 cipher in the OpenVPN=
 data
>> +    channel.
>> +
>> +
>>  Overview of changes in 2.4
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>=20=20
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index c8d95f3b..6d34acd7 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -841,7 +841,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *=
key,
>>          dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=3D%d iv_size=3D%d",
>>               prefix, cipher_kt_block_size(kt->cipher),
>>               cipher_kt_iv_size(kt->cipher));
>> -        if (cipher_kt_block_size(kt->cipher) < 128/8)
>> +        if (cipher_kt_insecure(kt->cipher))
>>          {
>>              msg(M_WARN, "WARNING: INSECURE cipher with block size less =
than 128"
>>                  " bit (%d bit).  This allows attacks like SWEET32.  Mit=
igate by "
>> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
>> index f917c8d7..38b2c175 100644
>> --- a/src/openvpn/crypto_backend.h
>> +++ b/src/openvpn/crypto_backend.h
>> @@ -284,6 +284,11 @@ int cipher_kt_block_size(const cipher_kt_t *cipher_=
kt);
>>   */
>>  int cipher_kt_tag_size(const cipher_kt_t *cipher_kt);
>>=20=20
>> +/**
>> + * Returns true if we consider this cipher to be insecure.
>> + */
>> +bool cipher_kt_insecure(const cipher_kt_t *cipher);
>> +
>>  /**
>>   * Returns the mode that the cipher runs in.
>>   *
>> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
>> index 82f4e574..a5a096b1 100644
>> --- a/src/openvpn/crypto_mbedtls.c
>> +++ b/src/openvpn/crypto_mbedtls.c
>> @@ -51,6 +51,7 @@
>>  #include <mbedtls/cipher.h>
>>  #include <mbedtls/havege.h>
>>  #include <mbedtls/pem.h>
>> +#include <mbedtls/version.h>
>>=20=20
>>  #include <mbedtls/entropy.h>
>>=20=20
>> @@ -175,7 +176,7 @@ show_available_ciphers(void)
>>      while (*ciphers !=3D 0)
>>      {
>>          const cipher_kt_t *info =3D mbedtls_cipher_info_from_type(*ciph=
ers);
>> -        if (info && cipher_kt_block_size(info) >=3D 128/8)
>> +        if (info && !cipher_kt_insecure(info))
>>          {
>>              print_cipher(info);
>>          }
>> @@ -188,7 +189,7 @@ show_available_ciphers(void)
>>      while (*ciphers !=3D 0)
>>      {
>>          const cipher_kt_t *info =3D mbedtls_cipher_info_from_type(*ciph=
ers);
>> -        if (info && cipher_kt_block_size(info) < 128/8)
>> +        if (info && cipher_kt_insecure(info))
>>          {
>>              print_cipher(info);
>>          }
>> @@ -550,6 +551,16 @@ cipher_kt_tag_size(const mbedtls_cipher_info_t *cip=
her_kt)
>>      return 0;
>>  }
>>=20=20
>> +bool
>> +cipher_kt_insecure(const mbedtls_cipher_info_t *cipher_kt)
>> +{
>> +    return !(cipher_kt_block_size(cipher_kt) >=3D 128/8
>=20
> Since you are touching the line above (you moved it), please put spaces
> around '/'.
>=20
>> +#if defined(MBEDTLS_CHACHAPOLY_C) && (MBEDTLS_VERSION_NUMBER >=3D 0x020=
C0000)
>=20
> Why do we need the dual condition? Isn't MBEDTLS_CHACHAPOLY_C enough to
> know mbedTLS has what we need? Or you feel like we have to demand a
> specific mbedTLS version when using ChaCha20?
>=20
>> +             || cipher_kt->type =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305
>> +#endif
>> +             );
>> +}
>> +
>>  int
>>  cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
>>  {
>> @@ -573,7 +584,11 @@ cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
>>  bool
>>  cipher_kt_mode_aead(const cipher_kt_t *cipher)
>>  {
>> -    return cipher && cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM;
>> +    return cipher && (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM
>> +#if defined(MBEDTLS_CHACHAPOLY_C) && (MBEDTLS_VERSION_NUMBER >=3D 0x020=
C0000)
>=20
> ditto
>=20
>> +                      || cipher_kt_mode(cipher) =3D=3D MBEDTLS_MODE_CHA=
CHAPOLY
>> +#endif
>> +                      );
>>  }
>>=20=20
>>=20=20
>> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
>> index 9ec2048d..0004be9e 100644
>> --- a/src/openvpn/crypto_openssl.c
>> +++ b/src/openvpn/crypto_openssl.c
>> @@ -245,6 +245,7 @@ const cipher_name_pair cipher_name_translation_table=
[] =3D {
>>      { "AES-128-GCM", "id-aes128-GCM" },
>>      { "AES-192-GCM", "id-aes192-GCM" },
>>      { "AES-256-GCM", "id-aes256-GCM" },
>> +    { "CHACHA20-POLY1305", "ChaCha20-Poly1305" },
>>  };
>>  const size_t cipher_name_translation_table_count =3D
>>      sizeof(cipher_name_translation_table) / sizeof(*cipher_name_transla=
tion_table);
>> @@ -321,7 +322,7 @@ show_available_ciphers(void)
>>      qsort(cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_c=
mp);
>>=20=20
>>      for (i =3D 0; i < num_ciphers; i++) {
>> -        if (cipher_kt_block_size(cipher_list[i]) >=3D 128/8)
>> +        if (!cipher_kt_insecure(cipher_list[i]))
>>          {
>>              print_cipher(cipher_list[i]);
>>          }
>> @@ -330,7 +331,7 @@ show_available_ciphers(void)
>>      printf("\nThe following ciphers have a block size of less than 128 =
bits, \n"
>>             "and are therefore deprecated.  Do not use unless you have t=
o.\n\n");
>>      for (i =3D 0; i < num_ciphers; i++) {
>> -        if (cipher_kt_block_size(cipher_list[i]) < 128/8)
>> +        if (cipher_kt_insecure(cipher_list[i]))
>>          {
>>              print_cipher(cipher_list[i]);
>>          }
>> @@ -686,6 +687,16 @@ cipher_kt_tag_size(const EVP_CIPHER *cipher_kt)
>>      }
>>  }
>>=20=20
>> +bool
>> +cipher_kt_insecure(const EVP_CIPHER *cipher)
>> +{
>> +    return !(cipher_kt_block_size(cipher) >=3D 128/8
>> +#ifdef NID_chacha20_poly1305
>> +             || EVP_CIPHER_nid(cipher) =3D=3D NID_chacha20_poly1305
>> +#endif
>> +            );
>> +}
>> +
>>  int
>>  cipher_kt_mode(const EVP_CIPHER *cipher_kt)
>>  {
>> @@ -720,10 +731,22 @@ bool
>>  cipher_kt_mode_aead(const cipher_kt_t *cipher)
>>  {
>>  #ifdef HAVE_AEAD_CIPHER_MODES
>> -    return cipher && (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM);
>> -#else
>> -    return false;
>> +    if (cipher)
>> +    {
>> +        switch (EVP_CIPHER_nid(cipher))
>> +        {
>> +        case NID_aes_128_gcm:
>> +        case NID_aes_192_gcm:
>> +        case NID_aes_256_gcm:
>> +#ifdef NID_chacha20_poly1305
>> +        case NID_chacha20_poly1305:
>>  #endif
>> +            return true;
>> +        }
>> +    }
>> +#endif
>> +
>> +    return false;
>>  }
>>=20=20
>>  /*
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 4257c33d..315303b0 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -294,7 +294,7 @@ tls_get_cipher_name_pair(const char *cipher_name, si=
ze_t len)
>>  static void
>>  tls_limit_reneg_bytes(const cipher_kt_t *cipher, int *reneg_bytes)
>>  {
>> -    if (cipher && (cipher_kt_block_size(cipher) < 128/8))
>> +    if (cipher && cipher_kt_insecure(cipher))
>>      {
>>          if (*reneg_bytes =3D=3D -1) /* Not user-specified */
>>          {
>>
>=20
> The code looks good and I like having a opaque function now doing the
> "cipher security check" in one place only.
>=20

It also just works as expected:

Sun Oct  7 22:14:48 2018 us=3D264551 127.0.0.1 Outgoing Data Channel:
Cipher 'CHACHA20-POLY1305' initialized with 256 bit key
Sun Oct  7 22:14:48 2018 us=3D264557 127.0.0.1 Incoming Data Channel:
Cipher 'CHACHA20-POLY1305' initialized with 256 bit key
Sun Oct  7 22:14:48 2018 us=3D264676 127.0.0.1 Control Channel: TLSv1.2,
cipher TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA256, 2048 bit key

Tested between a VM and my laptop.
Data inside the tunnel was flowing as expected.

Cheers,

--=20
Antonio Quartulli


--NWXZQ3dgfcaqet6ld9KcilvTopxGLRPKf--

--l92uensOuYzcNLwejLFeQ3G5qf23NB8ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu6FccACgkQ9FVsWUWD
Dm3WSQ/9GVsbTI8sgw7pPKzN0Nn+UzXPIWgO7X6YDwlCP4z4uzklY65MwiFv2UI2
EFqqoZjtUjp1anJS5KJE3Fth+DQsYxecuD1SnEHBcUkQAPK8uNP/8cdh/65fdNfU
WWcpAXtQ6m/jubocjXogh8TlfejvgxnDNYBD2a2w4uRRsIpssoRHv2tplJtQ/OKI
J4C/4ji0iCMkYEfItmXnjI+5QPYq5sLuaKadsI4Vrnty1BcV1NnsxTiXkuVcrb5E
heBW+q5KDZrQ9zv9HsSczZM6lkwMdZEfY4duhAzzsq3i3yvkBM5NlXc64bRmGOdx
4dFFv7EmIZwF8tvkEyyfVZn8UgFUnfJJsn34IJ03ZqhedWC4jVaWlI1CLM0TlFo3
E4WivcxQjJiJwjDCtbGLHcjOLl3EovrOjQdkGhmyG4xNztkFMJ5TNuw6TN7bQXvQ
NddOdHF7kOzvmtLXywpXOBZPUiWiE797ICOTULdTgGGx9BCq6RRx+M0Ho3lo0Q9C
XSXYcGHAZtCiSYrIu2KGvCqdpvfXrnbVwTidm1YrUh1dPEaOlg88QjnwvuGBUxYq
XfcRbo4ZwZ4eohCRQaD8AVi3cFBdzlm5i9W7U4cKY6gucWQLTGq4KxyDhuCuLmJ0
soXW24YkVc68OK/pJq6ActOF/vWUF06m5VX1vF8OyR/STSoS18g=
=MXPO
-----END PGP SIGNATURE-----

--l92uensOuYzcNLwejLFeQ3G5qf23NB8ba--

