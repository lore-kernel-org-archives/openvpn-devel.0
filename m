References: <1475613736-1529-1-git-send-email-lstipakov@...277...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <842a27b1-8ce3-db91-2c76-71cfc705e1eb@...1435...>
Date: Wed, 5 Oct 2016 14:04:02 +0200
MIME-Version: 1.0
In-Reply-To: <1475613736-1529-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2.3] Fix compilation in pedantic mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 04-10-16 22:42, Lev Stipakov wrote:
> Replace C++ style comments, which are not allowed in ISO C90 standard,
> with C style comments
> 
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  src/openvpn/crypto_openssl.c |  4 ++--
>  src/openvpn/ssl.c            |  2 +-
>  src/openvpn/ssl_openssl.c    | 36 ++++++++++++++++++------------------
>  src/plugins/auth-pam/utils.c |  2 +-
>  4 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 2180b1a..7b1ac6c 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -278,13 +278,13 @@ crypto_init_dmalloc (void)
>  
>  const char *
>  translate_cipher_name_from_openvpn (const char *cipher_name) {
> -  // OpenSSL doesn't require any translation
> +  /* OpenSSL doesn't require any translation */
>    return cipher_name;
>  }
>  
>  const char *
>  translate_cipher_name_to_openvpn (const char *cipher_name) {
> -  // OpenSSL doesn't require any translation
> +  /* OpenSSL doesn't require any translation */
>    return cipher_name;
>  }
>  
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 4de3354..33fd9dd 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -267,7 +267,7 @@ tls_get_cipher_name_pair (const char * cipher_name, size_t len) {
>        pair++;
>    }
>  
> -  // No entry found, return NULL
> +  /* No entry found, return NULL */
>    return NULL;
>  }
>  
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index a226aac..2d06da9 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -294,7 +294,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
>  
>    ASSERT(NULL != ctx);
>  
> -  // Translate IANA cipher suite names to OpenSSL names
> +  /* Translate IANA cipher suite names to OpenSSL names */
>    begin_of_cipher = end_of_cipher = 0;
>    for (; begin_of_cipher < strlen(ciphers); begin_of_cipher = end_of_cipher) {
>        end_of_cipher += strcspn(&ciphers[begin_of_cipher], ":");
> @@ -302,31 +302,31 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
>  
>        if (NULL == cipher_pair)
>          {
> -          // No translation found, use original
> -          current_cipher = &ciphers[begin_of_cipher];
> -          current_cipher_len = end_of_cipher - begin_of_cipher;
> -
> -          // Issue warning on missing translation
> -          // %.*s format specifier expects length of type int, so guarantee
> -          // that length is small enough and cast to int.
> -          msg (M_WARN, "No valid translation found for TLS cipher '%.*s'",
> -              (int) MIN(current_cipher_len, 256), current_cipher);
> +	  /* No translation found, use original */
> +	  current_cipher = &ciphers[begin_of_cipher];
> +	  current_cipher_len = end_of_cipher - begin_of_cipher;
> +
> +	  /* Issue warning on missing translation
> +	     %.*s format specifier expects length of type int, so guarantee
> +	     that length is small enough and cast to int. */
> +	  msg (M_WARN, "No valid translation found for TLS cipher '%.*s'",
> +	      (int) MIN(current_cipher_len, 256), current_cipher);
>          }
>        else
>  	{
> -	  // Use OpenSSL name
> -          current_cipher = cipher_pair->openssl_name;
> -          current_cipher_len = strlen(current_cipher);
> +	  /* Use OpenSSL name */
> +	  current_cipher = cipher_pair->openssl_name;
> +	  current_cipher_len = strlen(current_cipher);
>  
>  	  if (end_of_cipher - begin_of_cipher == current_cipher_len &&
>  	      0 == memcmp (&ciphers[begin_of_cipher], cipher_pair->openssl_name, end_of_cipher - begin_of_cipher))
>  	    {
> -	      // Non-IANA name used, show warning
> +	      /* Non-IANA name used, show warning */
>  	      msg (M_WARN, "Deprecated TLS cipher name '%s', please use IANA name '%s'", cipher_pair->openssl_name, cipher_pair->iana_name);
>  	    }
>  	}
>  
> -      // Make sure new cipher name fits in cipher string
> +      /* Make sure new cipher name fits in cipher string */
>        if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_cipher_len)
>  	{
>  	  msg (M_FATAL,
> @@ -334,7 +334,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
>  	      (int)sizeof(openssl_ciphers)-1);
>  	}
>  
> -      // Concatenate cipher name to OpenSSL cipher string
> +      /* Concatenate cipher name to OpenSSL cipher string */
>        memcpy(&openssl_ciphers[openssl_ciphers_len], current_cipher, current_cipher_len);
>        openssl_ciphers_len += current_cipher_len;
>        openssl_ciphers[openssl_ciphers_len] = ':';
> @@ -346,7 +346,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
>    if (openssl_ciphers_len > 0)
>      openssl_ciphers[openssl_ciphers_len-1] = '\0';
>  
> -  // Set OpenSSL cipher list
> +  /* Set OpenSSL cipher list */
>    if(!SSL_CTX_set_cipher_list(ctx->ctx, openssl_ciphers))
>      crypto_msg (M_FATAL, "Failed to set restricted TLS cipher list: %s", openssl_ciphers);
>  }
> @@ -1407,7 +1407,7 @@ show_available_tls_ciphers (const char *cipher_list)
>        pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
>  
>        if (NULL == pair) {
> -          // No translation found, print warning
> +          /* No translation found, print warning */
>  	  printf ("%s (No IANA name known to OpenVPN, use OpenSSL name.)\n", cipher_name);
>        } else {
>  	  printf ("%s\n", pair->iana_name);
> diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
> index 4f2bec1..e4643cd 100644
> --- a/src/plugins/auth-pam/utils.c
> +++ b/src/plugins/auth-pam/utils.c
> @@ -59,7 +59,7 @@ searchandreplace(const char *tosearch, const char *searchfor, const char *replac
>         return NULL;
>    }
>  
> -  // state: all parameters are valid
> +  /* state: all parameters are valid */
>  
>    const char *searching=tosearch;
>    char *scratch;

I do prefer

/* Some text
 * more text
 */

over

/* Some text
   more text */

but am not too religious about that.

So, ACK.

-Steffan


