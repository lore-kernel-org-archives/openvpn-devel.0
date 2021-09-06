References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-4-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <763f51bf-3123-a67b-0913-a2d4de78382f@...1227...>
Date: Mon, 6 Sep 2021 15:23:27 +0200
MIME-Version: 1.0
In-Reply-To: <20210904095629.6273-4-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 3/7] reject compression by default
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
> With this change the value of '--allow-compression- is set to 'no'.
> Therefore compression is not enabled by default and cannot be enabled
> by the server either.
> 
> This change is in line with the current rend of not recommending

I think rend should be trend


>  /*
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 4d971a56..21c76a69 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3146,6 +3146,16 @@ need_compatibility_before(const struct options *o, int version)
>  static void
>  options_set_backwards_compatible_options(struct options *o)
>  {
> +    /* Compression is deprecated and we do not want to announce support for it
> +     * by default anymore, additionally DCO breaks with compression.
> +     *
> +     * Disable compression by default starting with 2.6.0 if no other
> +     * compression related option has been explicitly set */
> +    if (!comp_non_stub_enabled(&o->comp) && !need_compatibility_before(o, 20600)
> +        && (o->comp.flags == 0))
> +    {
> +        o->comp.flags = COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
> +    }
>  }
>  
>  static void
> @@ -7732,6 +7742,7 @@ add_option(struct options *options,
>          else if (streq(p[1], "asym"))
>          {
>              options->comp.flags &= ~COMP_F_ALLOW_COMPRESS;
> +            options->comp.flags |= COMP_F_ALLOW_ASYM;
>          }
>          else if (streq(p[1], "yes"))
>          {
> 

Acked-By: Arne Schwabe <arne@...1227...>

