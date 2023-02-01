Date: Wed, 1 Feb 2023 13:01:49 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y9pUrSOwhvak4aYJ@...2685...>
References: <20230128223421.2207802-1-selva.nair@...277...>
 <20230128223421.2207802-4-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20230128223421.2207802-4-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] cryptoapi.c: remove pre
 OpenSSL-3.01 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

On Sat, Jan 28, 2023 at 05:34:20PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - Require xkey-provider (thus OpenSSL 3.01+) for --cryptoapicert
> 
> Note:
>   Ideally we should also make ENABLE_CRYPTOAPI conditional
>   on HAVE_XKEY_PROVIDER but that looks hard unless we can agree
>   to move HAVE_XKEY_PROVIDER to configure/config.h.
>   Or move ENABLE_CRYPTOAPI out of syshead.h ?
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/cryptoapi.c | 555 +---------------------------------------
>  src/openvpn/options.c   |   2 +-
>  2 files changed, 11 insertions(+), 546 deletions(-)
> 
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index e3c0bc99..6ff4fcb5 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -55,17 +55,17 @@
>  #include "xkey_common.h"
>  
>  #ifndef HAVE_XKEY_PROVIDER
> -/* index for storing external data in EC_KEY: < 0 means uninitialized */
> -static int ec_data_idx = -1;
>  
> -/* Global EVP_PKEY_METHOD used to override the sign operation */
> -static EVP_PKEY_METHOD *pmethod;
> -static int (*default_pkey_sign_init) (EVP_PKEY_CTX *ctx);
> -static int (*default_pkey_sign) (EVP_PKEY_CTX *ctx, unsigned char *sig,
> -                                 size_t *siglen, const unsigned char *tbs, size_t tbslen);
> -#else  /* ifndef HAVE_XKEY_PROVIDER */
> +int
> +SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
> +{
> +    msg(M_NONFATAL, "ERROR: cryptoapicert not supported in this version");

"in this version" sounds wrong to me. That might indicate to the user that
they need a newer or older version of OpenVPN. Maybe
"this binary was compiled without cryptoapicert support"?

Regards,
-- 
  Frank Lichtenheld

