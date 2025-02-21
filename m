Date: Fri, 21 Feb 2025 12:58:39 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Z7hqbzqBZG1EC6jR@...2685...>
References: <CAAWBBYOr-ZKmr3754DqzkssCr04C=n75C4bOihN04nx-4-xVvw@...278...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Rafael Gava <gava100@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, Feb 20, 2025 at 04:48:27PM -0300, Rafael Gava wrote:
> I believe this feature will be beneficial for many OpenVPN users, improving
> automation and simplifying VPN gateway configurations. Please find the
> patch inline for review and feedback.
> 

Thanks for your submission. Some general notes about the patch.
(Not a review of the actual change but more about the format of
submission)

> ----
> From fbc7045d652b5f11e2aa043aa2af9ca14f36b604 Mon Sep 17 00:00:00 2001
> From: Rafael Gava <gava100@...277...>
> Date: Thu, 20 Feb 2025 19:19:39 +0000
> Subject: [PATCH] Added the localhost token to the client-nat network option,
>  enabling the application to dynamically use the client IP provided by the
>  server.

The subject line should be concise and make sense on its own. The rest
of the commit message should be the longer description. You can achieve this
by adding an empty line after the first one.

> Signed-off-by: Rafael Gava <gava100@...277...>
> ---
>  src/openvpn/clinat.c  | 47 +++++++++++++++++++++++++++++++++++++++----
>  src/openvpn/clinat.h  |  3 +++
>  src/openvpn/init.c    |  2 ++
>  src/openvpn/options.c |  1 +
>  4 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> index 2d3b359f..1c79b20d 100644
> --- a/src/openvpn/clinat.c
> +++ b/src/openvpn/clinat.c
> @@ -127,12 +127,19 @@ add_client_nat_to_option_list(struct
> client_nat_option_list *dest,
>          return;
>      }
> 
> -    e.network = getaddr(0, network, 0, &ok, NULL);
> -    if (!ok)
> +    if (network && !strcmp(network, "localhost"))
>      {
> -        msg(msglevel, "client-nat: bad network: %s", network);
> -        return;
> +        msg (M_INFO, "*** client-nat localhost detected...");
> +        e.network = 0xFFFFFFFF;
> +    } else {

This is not in line with our usual formatting. We always format
like this

}
else
{

There is an uncrustify config in dev-tools/uncrustify.conf that can
help to check the formatting. Or you submit the patch in Github or
Gerrit which can do automated checks of the formatting.

> +        e.network = getaddr(0, network, 0, &ok, NULL);
> +        if (!ok)
> +        {
> +            msg(msglevel, "client-nat: bad network: %s", network);
> +            return;
> +        }
>      }
> +
>      e.netmask = getaddr(0, netmask, 0, &ok, NULL);
>      if (!ok)
>      {
> @@ -274,3 +281,35 @@ client_nat_transform(const struct
> client_nat_option_list *list,
>          }
>      }
>  }
> +
> +/*
> +* Replaces the localhost token with the IP received from OpenVPN
> +*/
> +bool
> +update_localhost_nat(struct client_nat_option_list *dest, in_addr_t
> local_ip)
> +{
> +    int i;
> +    bool ret = false;
> +
> +    if (!dest) {
> +        return ret;
> +    }
> +
> +    for (i=0; i <= dest->n; i++)
> +    {
> +        struct client_nat_entry *nat_entry = &dest->entries[i];
> +        if (nat_entry && nat_entry->network == 0xFFFFFFFF)
> +        {
> +            struct in_addr addr;
> +
> +            nat_entry->network = ntohl(local_ip);
> +            addr.s_addr = nat_entry->network;
> +            char *dot_ip = inet_ntoa(addr);
> +
> +            msg (M_INFO, "CNAT - Updating NAT table from localhost to:
> %s", dot_ip);
> +            ret = true;
> +        }
> +    }
> +
> +    return ret;
> +}
> diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
> index 94141f51..06afa3b4 100644
> --- a/src/openvpn/clinat.h
> +++ b/src/openvpn/clinat.h
> @@ -64,4 +64,7 @@ void client_nat_transform(const struct
> client_nat_option_list *list,
>                            struct buffer *ipbuf,
>                            const int direction);
> 
> +bool update_localhost_nat(struct client_nat_option_list *dest, in_addr_t
> local_ip);
> +
> +
>  #endif /* if !defined(CLINAT_H) */
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b57e5f8a..dadc10dc 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2052,6 +2052,8 @@ do_open_tun(struct context *c, int *error_flags)
>              *error_flags |= (status ? 0 : ISC_ROUTE_ERRORS);
>          }
> 
> +        update_localhost_nat(c->options.client_nat, c->c1.tuntap->local);
> +
>          ret = true;
>          static_context = c;
>      }
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 6b2dfa58..f7161931 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -254,6 +254,7 @@ static const char usage_message[] =
>      "                   (Server) Instead of forwarding IPv6 packets send\n"
>      "                   ICMPv6 host unreachable packets to the client.\n"
>      "--client-nat snat|dnat network netmask alias : on client add 1-to-1
> NAT rule.\n"
> +    "                  set the network to 'localhost' to use the client ip
> received from the server.\n"

Please also include an update to the documentation in
doc/man-sections/client-options.rst

>      "--push-peer-info : (client only) push client info to server.\n"
>      "--setenv name value : Set a custom environmental variable to pass to
> script.\n"
>      "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to
> allow\n"
> -- 
> 2.39.5

Regards,
-- 
  Frank Lichtenheld

