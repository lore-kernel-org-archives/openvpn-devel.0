Message-ID: <4F55E3EF.2070709@...515...>
Date: Tue, 06 Mar 2012 12:16:15 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-8-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-8-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 07/52] cleanup: crypto_openssl.c: remove
 support for pre-openssl-0.9.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> autoconf rejecting this anyway:
> ---
> AC_MSG_CHECKING([that OpenSSL Library is at least version 0.9.6])
> <snip>
> AC_MSG_ERROR([OpenSSL crypto Library is too old.])
> ---
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  crypto_openssl.c |   49 -------------------------------------------------
>  1 files changed, 0 insertions(+), 49 deletions(-)
>
> diff --git a/crypto_openssl.c b/crypto_openssl.c
> index 0a41b39..e5e1122 100644
> --- a/crypto_openssl.c
> +++ b/crypto_openssl.c
> @@ -78,47 +78,6 @@
>=20=20
>  #endif
>=20=20
> -#if SSLEAY_VERSION_NUMBER < 0x00906000
> -
> -#undef EVP_CIPHER_mode
> -#define EVP_CIPHER_mode(x) 1
> -#define EVP_CIPHER_CTX_mode(x) 1
> -#define EVP_CIPHER_flags(x) 0
> -
> -#define EVP_CIPH_CBC_MODE 1
> -#define EVP_CIPH_CFB_MODE 0
> -#define EVP_CIPH_OFB_MODE 0
> -#define EVP_CIPH_VARIABLE_LENGTH 0
> -
> -#define OPENSSL_malloc(x) malloc(x)
> -#define OPENSSL_free(x) free(x)
> -
> -static inline int
> -EVP_CipherInit_ov (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, uint8_t =
*key, uint8_t *iv, int enc)
> -{
> -  EVP_CipherInit (ctx, type, key, iv, enc);
> -  return 1;
> -}
> -
> -static inline int
> -EVP_CipherUpdate_ov (EVP_CIPHER_CTX *ctx, uint8_t *out, int *outl, uint8=
_t *in, int inl)
> -{
> -  EVP_CipherUpdate (ctx, out, outl, in, inl);
> -  return 1;
> -}
> -
> -static inline bool
> -cipher_ok (const char* name)
> -{
> -  const int i =3D strlen (name) - 4;
> -  if (i >=3D 0)
> -    return !strcmp (name + i, "-CBC");
> -  else
> -    return false;
> -}
> -
> -#else
> -
>  static inline int
>  EVP_CipherInit_ov (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, uint8_t =
*key, uint8_t *iv, int enc)
>  {
> @@ -137,14 +96,6 @@ cipher_ok (const char* name)
>    return true;
>  }
>=20=20
> -#endif
> -
> -#if SSLEAY_VERSION_NUMBER < 0x0090581f
> -
> -#undef DES_check_key_parity
> -#define DES_check_key_parity(x) 1
> -#endif /* SSLEAY_VERSION_NUMBER < 0x0090581f */
> -
>  #ifndef EVP_CIPHER_name
>  #define EVP_CIPHER_name(e)		OBJ_nid2sn(EVP_CIPHER_nid(e))
>  #endif
It has been agreed earlier that OpenSSL 0.9.6 will not be supported
anymore. ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


