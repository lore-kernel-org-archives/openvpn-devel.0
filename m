References: <20180622014905.21558-1-rosenp@...277...>
 <20180622021501.23037-1-rosenp@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <809950e8-c3e7-55e6-4347-9093d5108fd8@...1856...>
Date: Fri, 29 Jun 2018 13:48:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180622021501.23037-1-rosenp@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCHv2] openvpn: Add missing OpenSSL includes
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

On 22-06-18 04:15, Rosen Penev wrote:
> These get included when deprecated APIs are enabled. This is true on at
> least version 1.0.2 and 1.1.0.
> 
> Without deprecated APIs, OpenVPN fails to compile.
> 
> Signed-off-by: Rosen Penev <rosenp@...277...>
> ---
>  src/openvpn/ssl_openssl.c        | 9 +++++++++
>  src/openvpn/ssl_verify_openssl.c | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 527a600a..d9aec9bd 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -56,6 +56,15 @@
>  #include <openssl/pkcs12.h>
>  #include <openssl/x509.h>
>  #include <openssl/crypto.h>
> +#ifndef OPENSSL_NO_DH
> +#include <openssl/dh.h>
> +#endif
> +#ifndef OPENSSL_NO_DSA
> +#include <openssl/dsa.h>
> +#endif
> +#ifndef OPENSSL_NO_RSA
> +#include <openssl/rsa.h>
> +#endif
>  #ifndef OPENSSL_NO_EC
>  #include <openssl/ec.h>
>  #endif
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
> index 9b984751..82460ae7 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -46,6 +46,7 @@
>  
>  #include <openssl/x509v3.h>
>  #include <openssl/err.h>
> +#include <openssl/bn.h>
>  
>  int
>  verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
> 

Thanks for the patch.  I sent similar patches half a year ago, which are
awaiting review:

https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15934.html

and

https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15936.html

(DH, DSA, and RSA are not optional for OpenVPN, so the #ifndef's are not
needed.)

So: who's willing to review these?

-Steffan

