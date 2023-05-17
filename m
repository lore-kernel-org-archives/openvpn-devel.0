Message-ID: <a362a6e5-c80b-1473-d503-4e51befd22ee@...2181...>
Date: Wed, 17 May 2023 22:47:29 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230517200143.216-1-chipitsine@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230517200143.216-1-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
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
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 17/05/2023 22:01, Ilya Shipitsin wrote:
> malloc was not checked against NULL, I was able
> to get core dump in case of failure
> 
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
>   src/openvpn/dco_freebsd.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
> index 1111abeb..adbd1120 100644
> --- a/src/openvpn/dco_freebsd.c
> +++ b/src/openvpn/dco_freebsd.c
> @@ -594,6 +594,11 @@ dco_available(int msglevel)
>       }
>   
>       buf = malloc(ifcr.ifcr_total * IFNAMSIZ);
> +    if (buf == NULL)

as style guideline, we wanted to go for if (!A) rather than if (A == 
NULL). Although I am not sure if the whole codebase was cleaned up yet 
or not.

Cheers,

> +    {
> +        close(fd);
> +        return false;
> +    }
>   
>       ifcr.ifcr_count = ifcr.ifcr_total;
>       ifcr.ifcr_buffer = buf;

-- 
Antonio Quartulli

