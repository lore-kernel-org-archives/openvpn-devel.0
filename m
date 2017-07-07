MIME-Version: 1.0
In-Reply-To: <1499355218-21120-1-git-send-email-arne@...1227...>
References: <1499355218-21120-1-git-send-email-arne@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 7 Jul 2017 14:11:05 -0400
Message-ID: <CAEsd45TcQP9BDxyV+k+UXJUoZ7ZNoLGZuAq03C=6=gTBv-=Dfg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Implement block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi.

I have one small nit-pick.

On Thu, Jul 6, 2017 at 11:33 AM, Arne Schwabe <arne@...1227...> wrote:
> This can be used to redirect all IPv6 traffic to the tun interface, effectively black holing the IPv6 traffic. Without ICMPv6 error messages this will result in timeouts when the server does not send error codes.
> block-ipv6 allows client side only blocking on all platforms that OpenVPN supports IPv6. On Android it is only way to do sensible IPv6 blocking on Android < 5.0 and broken devices (Samsung).

[snip]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 505c5b2e..04505251 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -226,6 +226,8 @@ static const char usage_message[] =
>      "                  Add 'bypass-dns' flag to similarly bypass tunnel for DNS.\n"
>      "--redirect-private [flags]: Like --redirect-gateway, but omit actually changing\n"
>      "                  the default gateway.  Useful when pushing private subnets.\n"
> +    "--block-ipv6     : (client only) Instead sending IPv6 to the server generate\n"
> +    "                   ICMPv6 host unreachable messages.\n"
>      "--client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT rule.\n"
>  #ifdef ENABLE_PUSH_PEER_INFO
>      "--push-peer-info : (client only) push client info to server.\n"
> @@ -2083,6 +2085,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>          msg(M_USAGE, "--lladdr can only be used in --dev tap mode");
>      }
>
> +    if (options->block_ipv6 && !options->ifconfig_ipv6_remote)
> +    {
> +        msg(M_USAGE, "--block-ipv6 needs a valid --ifconfig-ipv6 configuration");
> +    }
> +
>      /*
>       * Sanity check on MTU parameters
>       */
> @@ -2241,6 +2248,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>          msg(M_USAGE, "TCP server mode allows at most one --remote address");
>      }
>
> +
>  #if P2MP_SERVER
>
>      /*
> @@ -6346,6 +6354,11 @@ add_option(struct options *options,
>  #endif
>          options->routes->flags |= RG_ENABLE;
>      }
> +    else if (streq(p[0], "block-ipv6"))
> +    {
> +        VERIFY_PERMISSION(OPT_P_ROUTE);
> +        options->block_ipv6 = true;
> +    }
>      else if (streq(p[0], "remote-random-hostname") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);

This (8th line from the end):

 +    else if (streq(p[0], "block-ipv6"))

should be:

 +    else if (streq(p[0], "block-ipv6") && !p[1])

So "block-ipv6 abc" will be detected as an error.

Best regards,

Jon

