Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180413155517.895-1-simon@...2293...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <25b6f37f-483f-82b7-f7e3-99806800a191@...2080...>
Date: Fri, 13 Apr 2018 18:36:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180413155517.895-1-simon@...2293...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Change quoted to angled form when
 #including external .h files
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
To: Simon Rozman <simon@...2293...>, openvpn-devel@lists.sourceforge.net


On 13/04/18 17:55, Simon Rozman wrote:
> ---
>  src/openvpn/comp-lz4.c | 2 +-
>  src/openvpn/lzo.h      | 8 ++++----
>  src/openvpn/memdbg.h   | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
> index f2916bdd..f52fdbfb 100644
> --- a/src/openvpn/comp-lz4.c
> +++ b/src/openvpn/comp-lz4.c
> @@ -35,7 +35,7 @@
>  #if defined(NEED_COMPAT_LZ4)
>  #include "compat-lz4.h"
>  #else
> -#include "lz4.h"
> +#include <lz4.h>
>  #endif

May I ask what the rationale is for this change?


-- 
kind regards,

David Sommerseth
OpenVPN Inc


