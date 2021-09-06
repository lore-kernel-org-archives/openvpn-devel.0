References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-8-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <702455e2-1b77-9d4d-dbab-3ab6c42ab0a1@...1227...>
Date: Mon, 6 Sep 2021 15:25:03 +0200
MIME-Version: 1.0
In-Reply-To: <20210904095629.6273-8-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 7/7] add message about changing default
 values
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 04.09.21 um 11:56 schrieb Antonio Quartulli:
> With OpenVPN 2.6 there are a number of default settings that are changing
> to more modern and safer values.
> 
> Some users may not be aware of that and may experience problematic
> behaviours, especially when connecting to older peers.
> 
> Add warning at startup to notify users about the change.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/options.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 6f6eb73d..26eac836 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3278,6 +3278,12 @@ options_postprocess_mutate(struct options *o)
>       * when using --pull
>       */
>      pre_connect_save(o);
> +
> +    /* Give a general warning at the end of initialisation that defaults
> +     * have changed */
> +    msg(M_WARN, "Note that modernisation of defaults in OpenVPN 2.6 limits "
> +                "compatibility with old versions. See Changes.rst and "
> +                "--compat-mode in the manual for details.");
>  }
>  
>  /*
> 


Acked-By: Arne Schwabe <arne@...1227...>

