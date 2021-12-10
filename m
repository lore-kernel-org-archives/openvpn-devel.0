Date: Fri, 10 Dec 2021 18:18:18 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1661051432.854354.1639156698631@...2642...>
In-Reply-To: <20211207170211.3275837-16-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-16-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 15/21] Update fragment and mssfix
 related warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Acked-by: Frank Lichtenheld <frank@...2641...>

> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:02 geschrieben:
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 31ae250bc..4f08e560a 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -3183,12 +3183,17 @@ do_init_frame(struct context *c)
>  #endif
>  
>  #ifdef ENABLE_FRAGMENT
> -    if ((c->options.ce.mssfix || c->options.ce.fragment)
> -        && TUN_MTU_SIZE(&c->c2.frame_fragment) != ETHERNET_MTU)
> +    if (c->options.ce.fragment > 0 && c->options.ce.mssfix > c->options.ce.fragment)
>      {
> -        msg(M_WARN,
> -            "WARNING: normally if you use --mssfix and/or --fragment, you should also set --tun-mtu %d (currently it is %d)",
> -            ETHERNET_MTU, TUN_MTU_SIZE(&c->c2.frame_fragment));
> +        msg(M_WARN, "WARNING: if you use --mssfix and --fragment, you should "
> +                    "set --fragment (%d) larger than --mssfix (%d)",
> +                    c->options.ce.fragment, c->options.ce.mssfix);
> +    }
> +    if (c->options.ce.fragment > 0 && c->options.ce.mssfix > 0
> +        && c->options.ce.fragment_encap != c->options.ce.mssfix_encap)
> +    {
> +        msg(M_WARN, "WARNING: if you use --mssfix and --fragment, you should "
> +                    "use the mtu for both or none.");

"the mtu parameter"? Or do you actually mean "the mtu" here?

Regards,
--
Frank Lichtenheld

