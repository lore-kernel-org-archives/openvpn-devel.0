References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-6-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <872b8e78-e392-a7f7-ca32-b73c6de2ddf0@...2181...>
Date: Tue, 14 Jul 2020 11:55:39 +0200
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-6-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 06/14] client-connect: Refactor
 client-connect handling to calling a bunch of hooks in a loop
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 11/07/2020 11:36, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
> 
> This patch changes the calling of the client-connect functions into an array
> of hooks and a block of code that calls them in a loop.
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch V5: Rebase on master.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c | 43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 9bb52ef7..83848fdc 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2241,6 +2241,10 @@ cc_check_return(int *cc_succeeded_count,
>      }
>  }
>  
> +typedef enum client_connect_return (*multi_client_connect_handler)
> +    (struct multi_context *m, struct multi_instance *mi,
> +     unsigned int *option_types_found);
> +

how about something like this:

2519 typedef enum client_connect_return
2520 (*multi_client_connect_handler)(struct multi_context *m,
2521                                 struct multi_instance *mi,
2522                                 unsigned int *option_types_found);
2523

I find it easier to read (just my opinion)


>  /*
>   * Called as soon as the SSL/TLS connection is authenticated.
>   *
> @@ -2268,7 +2272,17 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>      {
>          return;
>      }
> -    unsigned int option_types_found = 0;
> +
> +        multi_client_connect_handler handlers[] = {
> +            multi_client_connect_source_ccd,
> +            multi_client_connect_call_plugin_v1,
> +            multi_client_connect_call_plugin_v2,
> +            multi_client_connect_call_script,
> +            multi_client_connect_mda,
> +            NULL
> +        };
> +
> +        unsigned int option_types_found = 0;

something is wrong in the indentation of the chunk above: too many spaces.

>  
>      int cc_succeeded = true; /* client connect script status */
>      int cc_succeeded_count = 0;
> @@ -2276,32 +2290,9 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>  
>      multi_client_connect_early_setup(m, mi);
>  
> -    ret = multi_client_connect_source_ccd(m, mi, &option_types_found);
> -    cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
> -
> -    if (cc_succeeded)
> -    {
> -        ret = multi_client_connect_call_plugin_v1(m, mi, &option_types_found);
> -        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
> -    }
> -
> -    if (cc_succeeded)
> -    {
> -        ret = multi_client_connect_call_plugin_v2(m, mi, &option_types_found);
> -        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
> -    }
> -
> -
> -    if (cc_succeeded)
> +    for (int i = 0; cc_succeeded && handlers[i]; i++)
>      {
> -        ret = multi_client_connect_call_script(m, mi, &option_types_found);
> -        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
> -    }
> -
> -    if (cc_succeeded)
> -    {
> -
> -        ret = multi_client_connect_mda(m, mi, &option_types_found);
> +        ret = handlers[i](m, mi, &option_types_found);
>          cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
>      }
>  
> 


Except for the indentation issue, the rest looks good. This patch simply
makes the handlers invocation more generic and part of a loop.

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

