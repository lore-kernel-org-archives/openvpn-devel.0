References: <1514952123-26616-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <8edb6cb2-d9fd-b961-4170-464d6ae60813@...1435...>
Date: Wed, 3 Jan 2018 09:10:41 +0100
MIME-Version: 1.0
In-Reply-To: <1514952123-26616-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Return NULL if GetAdaptersInfo fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 03-01-18 05:02, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - Currently a pointer to potentially uninitialized IP_ADAPTER_INFO
>   struct is returned on error causing ill-defined behaviour.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> 
> There have been some reports of unexpected failure in GetAdaptersInfo.
> When and why that happens is still unclear but this bug could explain
> why the process goes into a tailspin in such occasions.
> 
>  src/openvpn/tun.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 25831ce..6e16348 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4178,15 +4178,12 @@ get_adapter_info_list(struct gc_arena *gc)
>      else
>      {
>          pi = (PIP_ADAPTER_INFO) gc_malloc(size, false, gc);
> -        if ((status = GetAdaptersInfo(pi, &size)) == NO_ERROR)
> -        {
> -            return pi;
> -        }
> -        else
> +        if ((status = GetAdaptersInfo(pi, &size)) != NO_ERROR)
>          {
>              msg(M_INFO, "GetAdaptersInfo #2 failed (status=%u) : %s",
>                  (unsigned int)status,
>                  strerror_win32(status, gc));
> +            pi = NULL;
>          }
>      }
>      return pi;
> 

Less lines, *and* less bugs.  Very good.

Acked-by: Steffan Karger <steffan.karger@...1435...>

-Steffan

