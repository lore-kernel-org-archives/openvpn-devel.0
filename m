Message-ID: <baac3422-1f0b-4587-bef6-0e23f8b6a296@...1227...>
Date: Fri, 21 Feb 2025 13:05:37 +0100
MIME-Version: 1.0
References: <CAAWBBYOr-ZKmr3754DqzkssCr04C=n75C4bOihN04nx-4-xVvw@...278...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAAWBBYOr-ZKmr3754DqzkssCr04C=n75C4bOihN04nx-4-xVvw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add 'localhost' token to client-nat
 network option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Rafael Gava <gava100@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 20.02.25 um 20:48 schrieb Rafael Gava:
> Dear OpenVPN Community,
> 
> I am submitting this patch to introduce a 'localhost' token to the 
> `client-nat` network option, allowing OpenVPN clients to dynamically use 
> the IP address provided by the server. This enhancement is particularly 
> useful in scenarios where OpenVPN is deployed as a VPN gateway bridging 
> a local network and a VPN tunnel.
> 
> Currently, the `client-nat` option requires a static client IP, which 
> limits its flexibility when dealing with dynamically assigned IP 
> addresses. By introducing a 'localhost' token, OpenVPN can automatically 
> substitute it with the current client-assigned IP address, streamlining 
> network configurations in dynamic environments.
> 
> Example:
> 
> client-nat snat localhost 255.255.255.255 172.19.80.17

I would assume that localhost here matches only 127.0.0.1. I would 
prefer something like assigned-ip or something that actually matches the 
real behaviour instead of reusing something that already has a pretty 
established meaning.

>=
> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> index 2d3b359f..1c79b20d 100644
> --- a/src/openvpn/clinat.c
> +++ b/src/openvpn/clinat.c
> @@ -127,12 +127,19 @@ add_client_nat_to_option_list(struct 
> client_nat_option_list *dest,
>           return;
>       }
> 
> -    e.network = getaddr(0, network, 0, &ok, NULL);
> -    if (!ok)
> +    if (network && !strcmp(network, "localhost"))
>       {
> -        msg(msglevel, "client-nat: bad network: %s", network);
> -        return;
> +        msg (M_INFO, "*** client-nat localhost detected...");

This looks like a left over debug message.

> +        e.network = 0xFFFFFFFF;
> +    } else {
> +        e.network = getaddr(0, network, 0, &ok, NULL);
> +        if (!ok)
> +        {
> +            msg(msglevel, "client-nat: bad network: %s", network);
> +            return;
> +        }
>       }
> +
>       e.netmask = getaddr(0, netmask, 0, &ok, NULL);
>       if (!ok)
>       {
> @@ -274,3 +281,35 @@ client_nat_transform(const struct 
> client_nat_option_list *list,
>           }
>       }
>   }
> +
> +/*
> +* Replaces the localhost token with the IP received from OpenVPN
> +*/
> +bool
> +update_localhost_nat(struct client_nat_option_list *dest, in_addr_t 
> local_ip)
> +{
> +    int i;
> +    bool ret = false;
> +
> +    if (!dest) {
> +        return ret;
> +    }
> +
> +    for (i=0; i <= dest->n; i++)
> +    {
> +        struct client_nat_entry *nat_entry = &dest->entries[i];
> +        if (nat_entry && nat_entry->network == 0xFFFFFFFF)
> +        {
> +            struct in_addr addr;
> +
> +            nat_entry->network = ntohl(local_ip);
> +            addr.s_addr = nat_entry->network;
> +            char *dot_ip = inet_ntoa(addr);
> +
> +            msg (M_INFO, "CNAT - Updating NAT table from localhost to: 
> %s", dot_ip);
> +            ret = true;
> +        }
> +    }
> +
> +    return ret;
> +}
> diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
> index 94141f51..06afa3b4 100644
> --- a/src/openvpn/clinat.h
> +++ b/src/openvpn/clinat.h
> @@ -64,4 +64,7 @@ void client_nat_transform(const struct 
> client_nat_option_list *list,
>                             struct buffer *ipbuf,
>                             const int direction);
> 
> +bool update_localhost_nat(struct client_nat_option_list *dest, 
> in_addr_t local_ip);
> +
> +
>   #endif /* if !defined(CLINAT_H) */
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b57e5f8a..dadc10dc 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2052,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)
>               *error_flags |= (status ? 0 : ISC_ROUTE_ERRORS);
>           }
> 
> +        update_localhost_nat(c->options.client_nat, c->c1.tuntap->local);
> +
>           ret = true;
>           static_context = c;
>       }
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 6b2dfa58..f7161931 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -254,6 +254,7 @@ static const char usage_message[] =
>       "                   (Server) Instead of forwarding IPv6 packets 
> send\n"
>       "                   ICMPv6 host unreachable packets to the client.\n"
>       "--client-nat snat|dnat network netmask alias : on client add 1- 
> to-1 NAT rule.\n"
> +    "                  set the network to 'localhost' to use the client 
> ip received from the server.\n"
>       "--push-peer-info : (client only) push client info to server.\n"
>       "--setenv name value : Set a custom environmental variable to pass 
> to script.\n"
>       "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking 
> to allow\n"


OpenVPN also needs to work in configuration that are pure p2p without 
--pull (or --client with is --tls-client +  --pull). Have you tested 
that it works in that configuration as well?

Arne



