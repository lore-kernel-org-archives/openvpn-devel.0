References: <20200605112519.22714-1-arne@...1227...>
 <20200605112519.22714-2-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <54dd9f11-d015-b8ff-07bd-4e505d04e14f@...1856...>
Date: Thu, 11 Jun 2020 10:47:17 +0200
MIME-Version: 1.0
In-Reply-To: <20200605112519.22714-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/3] Make cipher_kt_get also accept
 OpenVPN config cipher name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 05-06-2020 13:25, Arne Schwabe wrote:
> Basically calls to cipher_kt_get were calling
> translate_cipher_name_from_openvpn. The only two exception were the
> (broken) unit test and tls-crypt that uses cipher_kt_get("AES-256-CTR")
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/crypto.c         | 2 +-
>  src/openvpn/crypto_backend.h | 3 ++-
>  src/openvpn/crypto_mbedtls.c | 1 +
>  src/openvpn/crypto_openssl.c | 1 +
>  src/openvpn/ssl_ncp.c        | 8 ++++----
>  5 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index ba1fc095..1ce98184 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -763,7 +763,7 @@ init_key_type(struct key_type *kt, const char *ciphername,
>      CLEAR(*kt);
>      if (strcmp(ciphername, "none") != 0)
>      {
> -        kt->cipher = cipher_kt_get(translate_cipher_name_from_openvpn(ciphername));
> +        kt->cipher = cipher_kt_get(ciphername);
>          if (!kt->cipher)
>          {
>              msg(M_FATAL, "Cipher %s not supported", ciphername);
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index d46cb63f..85cb084a 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -227,7 +227,8 @@ void cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
>   * initialise encryption/decryption.
>   *
>   * @param ciphername    Name of the cipher to retrieve parameters for (e.g.
> - *                      \c AES-128-CBC).
> + *                      \c AES-128-CBC). Will be translated to the library name
> + *                      from the openvpn config name if needed.
>   *
>   * @return              A statically allocated structure containing parameters
>   *                      for the given cipher, or NULL if no matching parameters
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index c8dcddc8..bb752557 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -465,6 +465,7 @@ cipher_kt_get(const char *ciphername)
>  
>      ASSERT(ciphername);
>  
> +    ciphername = translate_cipher_name_from_openvpn(ciphername);
>      cipher = mbedtls_cipher_info_from_string(ciphername);
>  
>      if (NULL == cipher)
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 13ab4859..bbaa5742 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -580,6 +580,7 @@ cipher_kt_get(const char *ciphername)
>  
>      ASSERT(ciphername);
>  
> +    ciphername = translate_cipher_name_from_openvpn(ciphername);
>      cipher = EVP_get_cipherbyname(ciphername);
>  
>      if (NULL == cipher)
> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> index 042b0ce0..ea1dc960 100644
> --- a/src/openvpn/ssl_ncp.c
> +++ b/src/openvpn/ssl_ncp.c
> @@ -103,12 +103,12 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
>      while (token)
>      {
>          /*
> -         * Going through a roundtrip by using translate_cipher_name_from_openvpn
> -         * and translate_cipher_name_to_openvpn also normalises the cipher name,
> +         * Going through a roundtrip by using cipher_kt_get/cipher_kt_name
> +         * (and translate_cipher_name_from_openvpn/
> +         * translate_cipher_name_to_openvpn) also normalises the cipher name,
>           * e.g. replacing AeS-128-gCm with AES-128-GCM
>           */
> -        const char *cipher_name = translate_cipher_name_from_openvpn(token);
> -        const cipher_kt_t *ktc = cipher_kt_get(cipher_name);
> +        const cipher_kt_t *ktc = cipher_kt_get(token);
>          if (!ktc)
>          {
>              msg(M_WARN, "Unsupported cipher in --ncp-ciphers: %s", token);
> 

This makes the cipher_kt_name and cipher_kt_get abstractions nicely
consistent. Code looks good, and passes my tests.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

