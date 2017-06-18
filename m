References: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
	<20170612134330.20971-1-logout@...260...>
	<20170612134330.20971-6-logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <0d0c2075-1e0b-5a81-8303-efe0f93a7e4c@...1856...>
Date: Sun, 18 Jun 2017 12:20:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170612134330.20971-6-logout@...260...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 5/8] OpenSSL: don't use direct access to
 the internal of EVP_MD_CTX
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 12-06-17 15:43, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
> 
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including EVP_MD_CTX. We have to use the defined
> functions to do so.
> 
> Compatibility with OpenSSL 1.0 is kept by defining the corresponding
> functions when they are not found in the library.
> 
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  configure.ac                 |  3 ++
>  src/openvpn/crypto_backend.h | 14 ++++++++
>  src/openvpn/crypto_mbedtls.c | 12 +++++++
>  src/openvpn/crypto_openssl.c | 18 ++++++++--
>  src/openvpn/httpdigest.c     | 78 +++++++++++++++++++++++---------------------
>  src/openvpn/misc.c           | 14 ++++----
>  src/openvpn/openssl_compat.h | 50 ++++++++++++++++++++++++++++
>  src/openvpn/openvpn.h        |  2 +-
>  src/openvpn/push.c           | 11 ++++---
>  9 files changed, 150 insertions(+), 52 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 6eded4e6..6ac4e595 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -920,6 +920,9 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
>  
>  	AC_CHECK_FUNCS(
>  		[ \
> +			EVP_MD_CTX_new \
> +			EVP_MD_CTX_free \
> +			EVP_MD_CTX_reset \
>  			SSL_CTX_get_default_passwd_cb \
>  			SSL_CTX_get_default_passwd_cb_userdata \
>  			X509_get0_pubkey \
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 9b113d7b..8f03e2ba 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -508,6 +508,20 @@ int md_kt_size(const md_kt_t *kt);
>  int md_full(const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst);
>  
>  /*
> + * Allocate a new message digest context
> + *
> + * @return              a new zeroed MD context
> + */
> +md_ctx_t *md_ctx_new(void);
> +
> +/*
> + * Free an existing, non-null message digest context
> + *
> + * @param ctx           Message digest context
> + */
> +void md_ctx_free(md_ctx_t *ctx);
> +
> +/*
>   * Initialises the given message digest context.
>   *
>   * @param ctx           Message digest context
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index 942684ce..d6741523 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -766,6 +766,18 @@ md_full(const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst)
>      return 0 == mbedtls_md(kt, src, src_len, dst);
>  }
>  
> +mbedtls_md_context_t *
> +md_ctx_new(void)
> +{
> +    mbedtls_md_context_t *ctx;
> +    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);
> +    return ctx;
> +}
> +
> +void md_ctx_free(mbedtls_md_context_t *ctx)
> +{
> +    free(ctx);
> +}
>  
>  void
>  md_ctx_init(mbedtls_md_context_t *ctx, const mbedtls_md_info_t *kt)
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 881a2d13..fd599f40 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -42,6 +42,7 @@
>  #include "integer.h"
>  #include "crypto.h"
>  #include "crypto_backend.h"
> +#include "openssl_compat.h"
>  
>  #include <openssl/des.h>
>  #include <openssl/err.h>
> @@ -844,13 +845,24 @@ md_full(const EVP_MD *kt, const uint8_t *src, int src_len, uint8_t *dst)
>      return EVP_Digest(src, src_len, dst, &in_md_len, kt, NULL);
>  }
>  
> +EVP_MD_CTX *
> +md_ctx_new(void)
> +{
> +    EVP_MD_CTX *ctx = EVP_MD_CTX_new();
> +    check_malloc_return(ctx);
> +    return ctx;
> +}
> +
> +void md_ctx_free(EVP_MD_CTX *ctx)
> +{
> +    EVP_MD_CTX_free(ctx);
> +}
> +
>  void
>  md_ctx_init(EVP_MD_CTX *ctx, const EVP_MD *kt)
>  {
>      ASSERT(NULL != ctx && NULL != kt);
>  
> -    CLEAR(*ctx);
> -
>      EVP_MD_CTX_init(ctx);
>      EVP_DigestInit(ctx, kt);
>  }
> @@ -858,7 +870,7 @@ md_ctx_init(EVP_MD_CTX *ctx, const EVP_MD *kt)
>  void
>  md_ctx_cleanup(EVP_MD_CTX *ctx)
>  {
> -    EVP_MD_CTX_cleanup(ctx);
> +    EVP_MD_CTX_reset(ctx);
>  }
>  
>  int
> diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
> index ae4a638f..2a66d9b8 100644
> --- a/src/openvpn/httpdigest.c
> +++ b/src/openvpn/httpdigest.c
> @@ -81,27 +81,28 @@ DigestCalcHA1(
>      )
>  {
>      HASH HA1;
> -    md_ctx_t md5_ctx;
> +    md_ctx_t *md5_ctx = md_ctx_new();
>      const md_kt_t *md5_kt = md_kt_get("MD5");
>  
> -    md_ctx_init(&md5_ctx, md5_kt);
> -    md_ctx_update(&md5_ctx, (const uint8_t *) pszUserName, strlen(pszUserName));
> -    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> -    md_ctx_update(&md5_ctx, (const uint8_t *) pszRealm, strlen(pszRealm));
> -    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> -    md_ctx_update(&md5_ctx, (const uint8_t *) pszPassword, strlen(pszPassword));
> -    md_ctx_final(&md5_ctx, HA1);
> +    md_ctx_init(md5_ctx, md5_kt);
> +    md_ctx_update(md5_ctx, (const uint8_t *) pszUserName, strlen(pszUserName));
> +    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
> +    md_ctx_update(md5_ctx, (const uint8_t *) pszRealm, strlen(pszRealm));
> +    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
> +    md_ctx_update(md5_ctx, (const uint8_t *) pszPassword, strlen(pszPassword));
> +    md_ctx_final(md5_ctx, HA1);
>      if (pszAlg && strcasecmp(pszAlg, "md5-sess") == 0)
>      {
> -        md_ctx_init(&md5_ctx, md5_kt);
> -        md_ctx_update(&md5_ctx, HA1, HASHLEN);
> -        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> -        md_ctx_update(&md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
> -        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> -        md_ctx_update(&md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
> -        md_ctx_final(&md5_ctx, HA1);
> +        md_ctx_init(md5_ctx, md5_kt);
> +        md_ctx_update(md5_ctx, HA1, HASHLEN);
> +        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
> +        md_ctx_update(md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
> +        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
> +        md_ctx_update(md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
> +        md_ctx_final(md5_ctx, HA1);
>      }
> -    md_ctx_cleanup(&md5_ctx);
> +    md_ctx_cleanup(md5_ctx);
> +    md_ctx_free(md5_ctx);
>      CvtHex(HA1, SessionKey);
>  }
>  
> @@ -123,40 +124,41 @@ DigestCalcResponse(
>      HASH RespHash;
>      HASHHEX HA2Hex;
>  
> -    md_ctx_t md5_ctx;
> +    md_ctx_t *md5_ctx = md_ctx_new();
>      const md_kt_t *md5_kt = md_kt_get("MD5");
>  
>      /* calculate H(A2) */
> -    md_ctx_init(&md5_ctx, md5_kt);
> -    md_ctx_update(&md5_ctx, (const uint8_t *) pszMethod, strlen(pszMethod));
> -    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> -    md_ctx_update(&md5_ctx, (const uint8_t *) pszDigestUri, strlen(pszDigestUri));
> +    md_ctx_init(md5_ctx, md5_kt);
> +    md_ctx_update(md5_ctx, (const uint8_t *) pszMethod, strlen(pszMethod));
> +    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
> +    md_ctx_update(md5_ctx, (const uint8_t *) pszDigestUri, strlen(pszDigestUri));
>      if (strcasecmp(pszQop, "auth-int") == 0)
>      {
> -        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> -        md_ctx_update(&md5_ctx, HEntity, HASHHEXLEN);
> +        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
> +        md_ctx_update(md5_ctx, HEntity, HASHHEXLEN);
>      }
> -    md_ctx_final(&md5_ctx, HA2);
> +    md_ctx_final(md5_ctx, HA2);
>      CvtHex(HA2, HA2Hex);
>  
>      /* calculate response */
> -    md_ctx_init(&md5_ctx, md5_kt);
> -    md_ctx_update(&md5_ctx, HA1, HASHHEXLEN);
> -    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> -    md_ctx_update(&md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
> -    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> +    md_ctx_init(md5_ctx, md5_kt);
> +    md_ctx_update(md5_ctx, HA1, HASHHEXLEN);
> +    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
> +    md_ctx_update(md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
> +    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
>      if (*pszQop)
>      {
> -        md_ctx_update(&md5_ctx, (const uint8_t *) pszNonceCount, strlen(pszNonceCount));
> -        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> -        md_ctx_update(&md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
> -        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> -        md_ctx_update(&md5_ctx, (const uint8_t *) pszQop, strlen(pszQop));
> -        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
> +        md_ctx_update(md5_ctx, (const uint8_t *) pszNonceCount, strlen(pszNonceCount));
> +        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
> +        md_ctx_update(md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
> +        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
> +        md_ctx_update(md5_ctx, (const uint8_t *) pszQop, strlen(pszQop));
> +        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
>      }
> -    md_ctx_update(&md5_ctx, HA2Hex, HASHHEXLEN);
> -    md_ctx_final(&md5_ctx, RespHash);
> -    md_ctx_cleanup(&md5_ctx);
> +    md_ctx_update(md5_ctx, HA2Hex, HASHHEXLEN);
> +    md_ctx_final(md5_ctx, RespHash);
> +    md_ctx_cleanup(md5_ctx);
> +    md_ctx_free(md5_ctx);
>      CvtHex(RespHash, Response);
>  }
>  
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 68d06876..5a997750 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -1388,7 +1388,7 @@ get_user_pass_auto_userid(struct user_pass *up, const char *tag)
>      static const uint8_t hashprefix[] = "AUTO_USERID_DIGEST";
>  
>      const md_kt_t *md5_kt = md_kt_get("MD5");
> -    md_ctx_t ctx;
> +    md_ctx_t *ctx;
>  
>      CLEAR(*up);
>      buf_set_write(&buf, (uint8_t *)up->username, USER_PASS_LEN);
> @@ -1396,11 +1396,13 @@ get_user_pass_auto_userid(struct user_pass *up, const char *tag)
>      if (get_default_gateway_mac_addr(macaddr))
>      {
>          dmsg(D_AUTO_USERID, "GUPAU: macaddr=%s", format_hex_ex(macaddr, sizeof(macaddr), 0, 1, ":", &gc));
> -        md_ctx_init(&ctx, md5_kt);
> -        md_ctx_update(&ctx, hashprefix, sizeof(hashprefix) - 1);
> -        md_ctx_update(&ctx, macaddr, sizeof(macaddr));
> -        md_ctx_final(&ctx, digest);
> -        md_ctx_cleanup(&ctx)
> +        ctx = md_ctx_new();
> +        md_ctx_init(ctx, md5_kt);
> +        md_ctx_update(ctx, hashprefix, sizeof(hashprefix) - 1);
> +        md_ctx_update(ctx, macaddr, sizeof(macaddr));
> +        md_ctx_final(ctx, digest);
> +        md_ctx_cleanup(ctx);
> +        md_ctx_free(ctx);
>          buf_printf(&buf, "%s", format_hex_ex(digest, sizeof(digest), 0, 256, " ", &gc));
>      }
>      else

Hm, this code block doesn't even compile anymore since 2011 (commit
7fb0e07e removed get_default_gateway_mac_addr()).  I think this means we
should just remove everything inside #if AUTO_USERID.  But I'll pick
that up in a later patch - for this patch the changes look good.

> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 24efa0fd..b315bcb7 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -46,6 +46,56 @@
>  #include <openssl/ssl.h>
>  #include <openssl/x509.h>
>  
> +#include <openssl/des.h>
> +#include <openssl/err.h>
> +#include <openssl/evp.h>
> +#include <openssl/objects.h>
> +#include <openssl/rand.h>
> +#include <openssl/ssl.h>
> +

This looks like  a lot of includes, given the functions below.  Were
these missing from the previous commits?

> +#if !defined(HAVE_EVP_MD_CTX_RESET)
> +/**
> + * Reset a message digest context
> + *
> + * @param ctx                 The message digest context
> + * @return                    1 on success, 0 on error
> + */
> +static inline int
> +EVP_MD_CTX_reset(EVP_MD_CTX *ctx)
> +{
> +    EVP_MD_CTX_cleanup(ctx);
> +    return 1;
> +}
> +#endif
> +
> +#if !defined(HAVE_EVP_MD_CTX_FREE)
> +/**
> + * Free an existing message digest context
> + *
> + * @param ctx                 The message digest context
> + */
> +static inline void
> +EVP_MD_CTX_free(EVP_MD_CTX *ctx)
> +{
> +    free(ctx);
> +}
> +#endif
> +
> +#if !defined(HAVE_EVP_MD_CTX_NEW)
> +/**
> + * Allocate a new message digest object
> + *
> + * @return                    A zero'ed message digest object
> + */
> +static inline EVP_MD_CTX *
> +EVP_MD_CTX_new(void)
> +{
> +    EVP_MD_CTX *ctx = NULL;
> +    ALLOC_OBJ_CLEAR(ctx, EVP_MD_CTX);
> +    return ctx;
> +}
> +#endif
> +
>  #if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA)
>  /**
>   * Fetch the default password callback user data from the SSL context
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index f8682d17..21899bb9 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -473,7 +473,7 @@ struct context_2
>  
>      /* hash of pulled options, so we can compare when options change */
>      bool pulled_options_digest_init_done;
> -    md_ctx_t pulled_options_state;
> +    md_ctx_t *pulled_options_state;
>      struct sha256_digest pulled_options_digest;
>  
>      struct event_timeout scheduled_exit;
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index bcef0ef4..908b650f 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -724,7 +724,8 @@ process_incoming_push_msg(struct context *c,
>              struct buffer buf_orig = buf;
>              if (!c->c2.pulled_options_digest_init_done)
>              {
> -                md_ctx_init(&c->c2.pulled_options_state, md_kt_get("SHA256"));
> +                c->c2.pulled_options_state = md_ctx_new();
> +                md_ctx_init(c->c2.pulled_options_state, md_kt_get("SHA256"));
>                  c->c2.pulled_options_digest_init_done = true;
>              }
>              if (!c->c2.did_pre_pull_restore)
> @@ -738,14 +739,16 @@ process_incoming_push_msg(struct context *c,
>                                     option_types_found,
>                                     c->c2.es))
>              {
> -                push_update_digest(&c->c2.pulled_options_state, &buf_orig,
> +                push_update_digest(c->c2.pulled_options_state, &buf_orig,
>                                     &c->options);
>                  switch (c->options.push_continuation)
>                  {
>                      case 0:
>                      case 1:
> -                        md_ctx_final(&c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
> -                        md_ctx_cleanup(&c->c2.pulled_options_state);
> +                        md_ctx_final(c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
> +                        md_ctx_cleanup(c->c2.pulled_options_state);
> +                        md_ctx_free(c->c2.pulled_options_state);
> +                        c->c2.pulled_options_state = NULL;
>                          c->c2.pulled_options_digest_init_done = false;
>                          ret = PUSH_MSG_REPLY;
>                          break;
> 

Apart from the includes, the patch looks good and passes my tests.

I didn't test the auto_userid because it's broken anyway, and did not
test the http_proxy code because I don't have a test setup.  But the
changes look simple and sane enough to still ACK this patch.

So, if the includes are fixed, ACK to the patch.  I'll leave it up to
Gert whether a v9 is needed for that.

-Steffan

