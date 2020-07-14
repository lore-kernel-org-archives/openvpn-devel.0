References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-4-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c6de2742-aee4-b778-80c4-73c010ee47a0@...2181...>
Date: Tue, 14 Jul 2020 11:29:20 +0200
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 04/14] client-connect: Move
 multi_client_connect_setenv into early_setup
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 11/07/2020 11:36, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
> 
> This patch moves multi_client_connect_setenv into
> multi_client_connect_early_setup and makes sure that every client-connect
> handling function updates the virtual address selection.
> 
> Background: This unifies how the client-connect handling functions work.
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch V5: Rebase on master
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 35e0bd10..539ebfc0 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2150,6 +2150,12 @@ multi_client_connect_early_setup(struct multi_context *m,
>  
>      /* reset pool handle to null */
>      mi->vaddr_handle = -1;
> +
> +    /* do --client-connect setenvs */
> +    multi_select_virtual_addr(m, mi);
> +
> +    multi_client_connect_setenv(m, mi);
> +
>  }
>  
>  /**
> @@ -2195,6 +2201,13 @@ multi_client_connect_source_ccd(struct multi_context *m,
>                                    CLIENT_CONNECT_OPT_MASK,
>                                    option_types_found,
>                                    mi->context.c2.es);
> +            /*
> +             * Select a virtual address from either --ifconfig-push in
> +             * --client-config-dir file or --ifconfig-pool.
> +             */
> +            multi_select_virtual_addr(m, mi);
> +
> +            multi_client_connect_setenv(m, mi);
>          }
>          gc_free(&gc);
>      }


With this patch applied we are moving these 2 lines to:
- multi_client_connect_source_ccd()
- multi_client_connect_early_setup()

In multi_connection_established() we call the two aforementioned
functions one after the other. This means we are really executing the
select_virtual_addr() twice in a row. Am I wrong?

Maybe this gets fixed in a later patch, but are we sure we are not
breaking anything? If this double call gets rearranged in a later
patch...maybe it's better to merge these 2 patches? Bisect may become
quite ugly otherwise.

Cheers,


> @@ -2236,15 +2249,6 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>  
>      multi_client_connect_source_ccd(m, mi, &option_types_found);
>  
> -    /*
> -     * Select a virtual address from either --ifconfig-push in
> -     * --client-config-dir file or --ifconfig-pool.
> -     */
> -    multi_select_virtual_addr(m, mi);
> -
> -    /* do --client-connect setenvs */
> -    multi_client_connect_setenv(m, mi);
> -
>      multi_client_connect_call_plugin_v1(m, mi, &option_types_found,
>                                          &cc_succeeded,
>                                          &cc_succeeded_count);
> 

-- 
Antonio Quartulli

