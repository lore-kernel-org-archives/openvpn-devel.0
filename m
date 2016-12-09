MIME-Version: 1.0
In-Reply-To: <1481274455-657-1-git-send-email-mkroken@...277...>
References: <1481274455-657-1-git-send-email-mkroken@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 9 Dec 2016 14:36:23 +0100
Message-ID: <CAA1AbxJ6AQKMeVp1XH4VTJw+uNak-EG7-PSCnVs2mTWhM_wRJg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: include correct
 net/net_sockets header according to version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Magnus Kroken <mkroken@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 9 December 2016 at 10:07, Magnus Kroken <mkroken@...277...> wrote:
> <mbedtls/net.h> is deprecated as of mbedTLS 2.4.0, it is renamed
> <mbedtls/net_sockets.h>. OpenVPN will fail to build with
> mbedTLS 2.4.0 with MBEDTLS_DEPRECATED_REMOVED defined.
>
> Check MBEDTLS_VERSION_NUMBER, and include net.h for < 2.4.0 and
> net_sockets.h for >= 2.4.0.
>
> Signed-off-by: Magnus Kroken <mkroken@...277...>
> ---
> Tested, builing with both mbedTLS 2.3.0 and 2.4.0 with
> MBEDTLS_DEPRECATED_REMOVED is successful.
>
> This patch is as much to document the issue as a suggested patch.
> I don't know if MBEDTLS_DEPRECATED_REMOVED is considered a
> distro/package maintainers problem or something to fix with
> an #if, so I won't be sad if it isn't accepted.
>
>  src/openvpn/ssl_mbedtls.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 11ee65b..985a39f 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -51,11 +51,17 @@
>  #include "ssl_verify_mbedtls.h"
>  #include <mbedtls/debug.h>
>  #include <mbedtls/error.h>
> -#include <mbedtls/net.h>
> +#include <mbedtls/version.h>
> +
> +#if MBEDTLS_VERSION_NUMBER >= 0x02040000
> +    #include <mbedtls/net_sockets.h>
> +#else
> +    #include <mbedtls/net.h>
> +#endif
> +
>  #include <mbedtls/oid.h>
>  #include <mbedtls/pem.h>
>  #include <mbedtls/sha256.h>
> -#include <mbedtls/version.h>
>
>  void
>  tls_init_lib()
> --
> 2.1.4

Looks good, passes tests. ACK.

We might remove the indenting of the preprocessor statements, but if
not, this will be fixed soon by The Great Reformatting anyway.

-Steffan

