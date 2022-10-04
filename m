Message-ID: <a5eb6634-9b51-a214-68d3-08c1ca5a22aa@...2181...>
Date: Tue, 4 Oct 2022 17:01:41 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221004145142.19091-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20221004145142.19091-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] use boolean '||' to join two bools,
 not bitwise '|'
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 04/10/2022 16:51, Gert Doering wrote:
> FreeBSD 14 clang complains about this:

and it is right.

> 
> init.c:3530:13: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
>              platform_group_get(c->options.groupname, &c0->platform_state_group)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> init.c:3530:13: note: cast one or both operands to int to silence this warning
> 1 warning generated.
> 
> .. so do what it wants us to do.
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 03416844..c88c0915 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -3528,7 +3528,7 @@ do_init_first_time(struct context *c)
>           /* get user and/or group that we want to setuid/setgid to */
>           c0->uid_gid_specified =
>               platform_group_get(c->options.groupname, &c0->platform_state_group)
> -            |platform_user_get(c->options.username, &c0->platform_state_user);
> +            || platform_user_get(c->options.username, &c0->platform_state_user);
>   
>           /* perform postponed chdir if --daemon */
>           if (c->did_we_daemonize && c->options.cd_dir == NULL)

-- 
Antonio Quartulli

