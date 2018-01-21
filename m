MIME-Version: 1.0
In-Reply-To: <1516196949-29752-1-git-send-email-arne@...1227...>
References: <1516191454-29034-1-git-send-email-arne@...1227...>
 <1516196949-29752-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 21 Jan 2018 11:13:59 -0500
Message-ID: <CAKuzo_i5n6oSRgXKNgPV0H33TiKvxODMcq2+krh-Yg1=Jzp5rw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Treat dhcp-option DNS6 and DNS
 identical
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

All good but for some minor glitches:

extra whitespace:

Applying: Treat dhcp-option DNS6 and DNS identical
/home/selva/openvpn/.git/rebase-apply/patch:83: trailing whitespace.
            }
/home/selva/openvpn/.git/rebase-apply/patch:84: trailing whitespace.
            else
warning: 2 lines add whitespace errors.

On Wed, Jan 17, 2018 at 8:49 AM, Arne Schwabe <arne@...1227...> wrote:
> OpenVPN3 accepts both IPv4 and IPv6 with option-dhcp DNS but throws
> an error for option-dhcp DNS6.
>
> This patch makes OpenVPN2 accept IPv4/IPv6 for both DNS and DNS6
>
> Patch V2: Put IPv6 parsing logic into own function similar as for for IPv4 DNS
> ---
>  doc/openvpn.8         |  8 ++------
>  src/openvpn/options.c | 38 ++++++++++++++++++++++++--------------
>  2 files changed, 26 insertions(+), 20 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 43bbc217..f9ccbb30 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5886,14 +5886,10 @@ across the VPN.
>  Set Connection\-specific DNS Suffix.
>
>  .B DNS addr \-\-
> -Set primary domain name server IPv4 address.  Repeat
> +Set primary domain name server IPv4 or IPv6 address.  Repeat
>  this option to set secondary DNS server addresses.
>
> -.B DNS6 addr \-\-
> -Set primary domain name server IPv6 address.  Repeat
> -this option to set secondary DNS server IPv6 addresses.
> -
> -Note: currently this is handled using netsh (the
> +Note: DNS IPv6 server are currently handled using netsh (the

server -> servers
while at it, may be change "handled" to "set" ? (the poor original is my fault).

>  existing DHCP code can only do IPv4 DHCP, and that protocol only
>  permits IPv4 addresses anywhere).  The option will be put into the
>  environment, so an

Silently removing any reference to DNS6 in docs is good while we
continue to accept DNS6 as an alias.

Could you please also edit the '--dhcp-option type' description in
usage_message[] string?

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 7c6528bc..d67044fc 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1228,6 +1228,20 @@ show_tuntap_options(const struct tuntap_options *o)
>
>  #if defined(_WIN32) || defined(TARGET_ANDROID)
>  static void
> +dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *len, int msglevel)
> +{
> +    struct in6_addr addr;
> +    if (*len >= N_DHCP_ADDR)
> +    {
> +        msg(msglevel, "--dhcp-option DNS: maximum of %d IPv6 dns servers can be specified",
> +            N_DHCP_ADDR);
> +    }
> +    else if (get_ipv6_addr(parm, &addr, NULL, msglevel))
> +    {
> +        dns6_list[(*len)++] = addr;
> +    }
> +}
> +static void
>  dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *array, int *len, int msglevel)
>  {
>      if (*len >= N_DHCP_ADDR)
> @@ -7088,6 +7102,7 @@ add_option(struct options *options,
>      {
>          struct tuntap_options *o = &options->tuntap_options;
>          VERIFY_PERMISSION(OPT_P_IPWIN32);
> +        bool ipv6dns = false;
>
>          if (streq(p[1], "DOMAIN") && p[2])
>          {
> @@ -7108,22 +7123,17 @@ add_option(struct options *options,
>              }
>              o->netbios_node_type = t;
>          }
> -        else if (streq(p[1], "DNS") && p[2])
> +        else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
>          {
> -            dhcp_option_address_parse("DNS", p[2], o->dns, &o->dns_len, msglevel);
> -        }
> -        else if (streq(p[1], "DNS6") && p[2] && ipv6_addr_safe(p[2]))
> -        {
> -            struct in6_addr addr;
> -            foreign_option(options, p, 3, es);
> -            if (o->dns6_len >= N_DHCP_ADDR)
> +            if (strstr(p[2], ":"))
>              {
> -                msg(msglevel, "--dhcp-option DNS6: maximum of %d dns servers can be specified",
> -                    N_DHCP_ADDR);
> -            }
> -            else if (get_ipv6_addr(p[2], &addr, NULL, msglevel))
> +                ipv6dns=true;
> +                foreign_option(options, p, 3, es);
> +                dhcp_option_dns6_parse(p[2], o->dns6, &o->dns6_len, msglevel);
> +            }
> +            else
>              {
> -                o->dns6[o->dns6_len++] = addr;
> +                dhcp_option_address_parse("DNS", p[2], o->dns, &o->dns_len, msglevel);
>              }
>          }
>          else if (streq(p[1], "WINS") && p[2])
> @@ -7151,7 +7161,7 @@ add_option(struct options *options,
>          /* flag that we have options to give to the TAP driver's DHCPv4 server
>           *  - skipped for "DNS6", as that's not a DHCPv4 option
>           */
> -        if (!streq(p[1], "DNS6"))
> +        if (!ipv6dns)
>          {
>              o->dhcp_options = true;
>          }

Looks good and works well otherwise.

Selva

