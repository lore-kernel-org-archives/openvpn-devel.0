References: <1447246849-11602-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <572083C2.5010901@...1227...>
Date: Wed, 27 Apr 2016 12:17:54 +0300
MIME-Version: 1.0
In-Reply-To: <1447246849-11602-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix "implicit declaration" compiler
 warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Am 11.11.15 um 15:00 schrieb Lev Stipakov:
> Add missing "include" directive.
> 
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  src/openvpn/mtcp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
> index b27c5eb..9926d47 100644
> --- a/src/openvpn/mtcp.c
> +++ b/src/openvpn/mtcp.c
> @@ -37,6 +37,10 @@
>  
>  #include "memdbg.h"
>  
> +#ifdef HAVE_SYS_INOTIFY_H
> +#include <sys/inotify.h>
> +#endif
> +
>  /*
>   * TCP States
>   */
> 


ACK.



