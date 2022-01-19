Message-ID: <4288b719-a9fb-8ffe-c3c5-208f8a35bb95@...1227...>
Date: Wed, 19 Jan 2022 14:52:24 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220119113446.17691-1-openvpn@...2080...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220119113446.17691-1-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: Fix OPENSSL_FIPS enabled builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Am 19.01.22 um 12:34 schrieb David Sommerseth:
> From: David Sommerseth <davids@...515...>
> 
> On Fedora and RHEL/CentOS, the standard OpenSSL library has the FIPS
> module enabled by default.  This revealed some incompatible code with
> the added DCO support.
> 
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>   src/openvpn/crypto.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 5626e2b6..0415f59d 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -34,6 +34,7 @@
>   #include "error.h"
>   #include "integer.h"
>   #include "platform.h"
> +#include "openssl_compat.h"
>   
>   #include "memdbg.h"
>   
> @@ -1704,6 +1705,8 @@ print_cipher(const char *ciphername)
>           printf(", TLS client/server mode only");
>       }
>   #ifdef OPENSSL_FIPS
> +    evp_cipher_type *cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
> +

EVP_CIPHER_fetch without EVP_CIPHER_free

Arne

