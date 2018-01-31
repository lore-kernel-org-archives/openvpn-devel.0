MIME-Version: 1.0
In-Reply-To: <1517391662-21325-1-git-send-email-arne@...1227...>
References: <1516191454-29034-1-git-send-email-arne@...1227...>
 <1517391662-21325-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 31 Jan 2018 18:33:42 -0500
Message-ID: <CAKuzo_gK9QT2zMPOnZrvizkbanfHi2uJZO-wWVY7jdAUn7rokQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Treat dhcp-option DNS6 and DNS
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

On Wed, Jan 31, 2018 at 4:41 AM, Arne Schwabe <arne@...1227...> wrote:
> OpenVPN3 accepts both IPv4 and IPv6 with option-dhcp DNS but throws
> an error for option-dhcp DNS6.
>
> This patch makes OpenVPN2 accept IPv4/IPv6 for both DNS and DNS6
>
> Patch V2: Put IPv6 parsing logic into own function similar as for for IPv4 DNS
> ---
>  doc/openvpn.8         | 14 +++++---------
>  src/openvpn/options.c | 39 ++++++++++++++++++++++++---------------
>  2 files changed, 29 insertions(+), 24 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 43bbc217..d083b908 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5886,17 +5886,13 @@ across the VPN.
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
> -existing DHCP code can only do IPv4 DHCP, and that protocol only
> -permits IPv4 addresses anywhere).  The option will be put into the
> -environment, so an
> +Note: DNS IPv6 servers are currently set using netsh (the existing
> +DHCP code can only do IPv4 DHCP, and that protocol only permits IPv4
> +addresses anywhere).  The option will be put into the environment, so
> +an
>  .B \-\-up
>  script could act upon it if needed.
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 75def7b6..f405d8a2 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -705,8 +705,7 @@ static const char usage_message[] =
>      "                    which allow multiple addresses,\n"
>      "                    --dhcp-option must be repeated.\n"
>      "                    DOMAIN name : Set DNS suffix\n"
> -    "                    DNS addr    : Set domain name server address(es) (IPv4)\n"
> -    "                    DNS6 addr   : Set domain name server address(es) (IPv6)\n"
> +    "                    DNS addr    : Set domain name server address(es) (IPv4 and IPv6)\n"
>      "                    NTP         : Set NTP server address(es)\n"
>      "                    NBDD        : Set NBDD server address(es)\n"
>      "                    WINS addr   : Set WINS server address(es)\n"
> @@ -1228,6 +1227,20 @@ show_tuntap_options(const struct tuntap_options *o)
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
> @@ -7070,6 +7083,7 @@ add_option(struct options *options,
>      {
>          struct tuntap_options *o = &options->tuntap_options;
>          VERIFY_PERMISSION(OPT_P_IPWIN32);
> +        bool ipv6dns = false;
>
>          if (streq(p[1], "DOMAIN") && p[2])
>          {
> @@ -7090,22 +7104,17 @@ add_option(struct options *options,
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
> +                ipv6dns=true;
> +                foreign_option(options, p, 3, es);
> +                dhcp_option_dns6_parse(p[2], o->dns6, &o->dns6_len, msglevel);
>              }
> -            else if (get_ipv6_addr(p[2], &addr, NULL, msglevel))
> +            else
>              {
> -                o->dns6[o->dns6_len++] = addr;
> +                dhcp_option_address_parse("DNS", p[2], o->dns, &o->dns_len, msglevel);
>              }
>          }
>          else if (streq(p[1], "WINS") && p[2])
> @@ -7133,7 +7142,7 @@ add_option(struct options *options,
>          /* flag that we have options to give to the TAP driver's DHCPv4 server
>           *  - skipped for "DNS6", as that's not a DHCPv4 option
>           */
> -        if (!streq(p[1], "DNS6"))
> +        if (!ipv6dns)
>          {
>              o->dhcp_options = true;
>          }

Acked-by: Selva Nair <selva.nair@...277...>

