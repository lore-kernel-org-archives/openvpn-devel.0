References: <20170518191311.4769-1-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <90da18a4-16e9-a84e-2bb5-e4c536e9300c@...1856...>
Date: Sat, 20 May 2017 15:05:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170518191311.4769-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Remove erroneous limitation on max
 number of args for --plugin
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 18-05-17 21:13, Gert Doering wrote:
> Commit 3d6a4cded2 introduced a maximum limit of possible arguments
> for most options, to error out on config lines with too-many args.
> 
> Commit 82acf21634 extended the limit for "--plugin" to accept "one
> mandatory, one optional" argument.
> 
> Both are wrong - "--plugin" can accept an arbitrary number of arguments,
> but this is not directly obvious from options.c, one needs to check
> plugins.c / plugin_option_list_add() and misc.c / make_extended_arg_array()
> to see that.
> 
> Thus, remove the max limit for "--plugin" completely.
> 
> (Reported by SviMik on IRC)
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index f38abad..452087a 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -5152,7 +5152,7 @@ add_option(struct options *options,
>      }
>  #endif /* ifdef ENABLE_MANAGEMENT */
>  #ifdef ENABLE_PLUGIN
> -    else if (streq(p[0], "plugin") && p[1] && !p[3])
> +    else if (streq(p[0], "plugin") && p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_PLUGIN);
>          if (!options->plugin_list)
> 

ACK

-Steffan

