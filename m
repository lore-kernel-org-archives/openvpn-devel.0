References: <1538820128-27086-1-git-send-email-lstipakov@...277...>
 <1540904039-2129-1-git-send-email-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4864a5a9-7816-6347-9a82-1e2432321562@...2181...>
Date: Fri, 26 Mar 2021 00:26:21 +0100
MIME-Version: 1.0
In-Reply-To: <1540904039-2129-1-git-send-email-lstipakov@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4] Improve "recursive routing" warning
 message
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 30/10/2018 13:53, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> This patch provides additional information, such as
> source address/port and destination address/port, to a
> "recursive routing" warning message. It also mentiones
> possible workaround.
> 
> Trac #843
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> v4:
>  - remove unneeded format specifier for const string
> 
> v3:
>  - factor out ports extraction code into own function
>  to avoid code duplication
>  - better commit message
> 
> v2:
>  - print protocol, source/dest addresses and ports
>  - mention "--allow-recursive-routing"
>  - add possible usecase to manpage
> 
>  doc/openvpn.8         |  4 ++-
>  src/openvpn/forward.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 93 insertions(+), 9 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 94b5cc4..fb9eb84 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -4090,7 +4090,9 @@ notifications unless this option is enabled.
>  .TP
>  .B \-\-allow\-recursive\-routing
>  When this option is set, OpenVPN will not drop incoming tun packets
> -with same destination as host.
> +with same destination as host. Could be useful when packets sent by openvpn
> +itself are not subject to the routing tables that would move packets
> +into the tunnel.
>  .\"*********************************************************
>  .SS Data Channel Encryption Options:
>  These options are meaningful for both Static & TLS\-negotiated key modes
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index f8faa81..e96c546 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1291,10 +1291,42 @@ read_incoming_tun(struct context *c)
>      perf_pop();
>  }
>  
> +/*
> + * Extracts sport and dport from packet, used
> + * in recursive routing warning.
> + */
> +static void
> +extract_sport_dport(const struct buffer *buf, uint8_t protocol, int offset_to_payload, int packet_len, uint16_t *sport, uint16_t *dport)
> +{
> +    /* whole packet? */
> +    if (BLEN(buf) == packet_len)
> +    {
> +        const uint8_t *payload = BPTR(buf) + offset_to_payload;
> +
> +        if (protocol == OPENVPN_IPPROTO_UDP)
> +        {
> +            const struct openvpn_udphdr *udp = (const struct openvpn_udphdr *)payload;
> +            *sport = ntohs(udp->source);
> +            *dport = ntohs(udp->dest);
> +        }
> +        else if (protocol == OPENVPN_IPPROTO_TCP)
> +        {
> +            const struct openvpn_tcphdr *tcp = (const struct openvpn_tcphdr *)payload;
> +            *sport = ntohs(tcp->source);
> +            *dport = ntohs(tcp->dest);
> +        }
> +    }
> +    else
> +    {
> +        *sport = 0;
> +        *dport = 0;
> +    }
> +}
> +
>  /**
>   * Drops UDP packets which OS decided to route via tun.
>   *
> - * On Windows and OS X when netwotk adapter is disabled or
> + * On Windows and OS X when network adapter is disabled or
>   * disconnected, platform starts to use tun as external interface.
>   * When packet is sent to tun, it comes to openvpn, encapsulated
>   * and sent to routing table, which sends it again to tun.
> @@ -1306,6 +1338,11 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)
>      struct openvpn_sockaddr tun_sa;
>      int ip_hdr_offset = 0;
>  
> +    uint32_t saddr, daddr;
> +    struct in6_addr saddr6, daddr6;
> +    uint16_t sport, dport;
> +    uint8_t protocol;
> +
>      if (c->c2.to_link_addr == NULL) /* no remote addr known */
>      {
>          return;
> @@ -1320,7 +1357,7 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)
>          const struct openvpn_iphdr *pip;
>  
>          /* make sure we got whole IP header */
> -        if (BLEN(buf) < ((int) sizeof(struct openvpn_iphdr) + ip_hdr_offset))
> +        if (BLEN(buf) < ((int)sizeof(struct openvpn_iphdr) + ip_hdr_offset))
>          {
>              return;
>          }
> @@ -1331,12 +1368,21 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)
>              return;
>          }
>  
> -        pip = (struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);
> +        pip = (const struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);
>  
> -        /* drop packets with same dest addr as gateway */
> +        /* drop packets with the same dest addr as gateway */
>          if (tun_sa.addr.in4.sin_addr.s_addr == pip->daddr)
>          {
>              drop = true;
> +
> +            /* collect information for warning message */
> +
> +            saddr = ntohl(pip->saddr);
> +            daddr = ntohl(pip->daddr);
> +            protocol = pip->protocol;
> +
> +            extract_sport_dport(buf, protocol, ip_hdr_offset + sizeof(struct openvpn_iphdr),
> +                                ip_hdr_offset + (int)(ntohs(pip->tot_len)), &sport, &dport);

In the 3rd don-t we need to also add sizeof(struct openvpn_iphdr)?
Or is it included in pip->tot_len?

>          }
>      }
>      else if (proto_ver == 6)
> @@ -1344,7 +1390,7 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)
>          const struct openvpn_ipv6hdr *pip6;
>  
>          /* make sure we got whole IPv6 header */
> -        if (BLEN(buf) < ((int) sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset))
> +        if (BLEN(buf) < ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset))
>          {
>              return;
>          }
> @@ -1355,22 +1401,58 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)
>              return;
>          }
>  
> -        /* drop packets with same dest addr as gateway */
> +        /* drop packets with the same dest addr as gateway */
>          pip6 = (struct openvpn_ipv6hdr *) (BPTR(buf) + ip_hdr_offset);
>          if (IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->daddr))
>          {
>              drop = true;
> +
> +            /* collect information for warning message */
> +
> +            saddr6 = pip6->saddr;
> +            daddr6 = pip6->daddr;
> +            protocol = pip6->nexthdr;
> +
> +            extract_sport_dport(buf, protocol, ip_hdr_offset + sizeof(struct openvpn_ipv6hdr),
> +                                (int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset + (int)ntohs(pip6->payload_len),
> +                                &sport, &dport);
>          }
>      }
>  
>      if (drop)
>      {
>          struct gc_arena gc = gc_new();
> +        struct buffer addrs_buf = alloc_buf_gc(128, &gc);
>  
> +        /* drop packet */
>          c->c2.buf.len = 0;
>  
> -        msg(D_LOW, "Recursive routing detected, drop tun packet to %s",
> -            print_link_socket_actual(c->c2.to_link_addr, &gc));
> +        if (protocol == OPENVPN_IPPROTO_UDP)
> +        {
> +            buf_printf(&addrs_buf, "UDP");
> +        }
> +        else if (protocol == OPENVPN_IPPROTO_TCP)
> +        {
> +            buf_printf(&addrs_buf, "TCP");
> +        }
> +        else
> +        {
> +            buf_printf(&addrs_buf, "%d", protocol);
> +        }
> +
> +        if (proto_ver == 4)
> +        {
> +            buf_printf(&addrs_buf, " %s:%d -> %s:%d",
> +                       print_in_addr_t(saddr, 0, &gc), sport,
> +                       print_in_addr_t(daddr, 0, &gc), dport);
> +        } else if (proto_ver == 6)
> +        {
> +            buf_printf(&addrs_buf, " %s:%d -> %s:%d",
> +                       print_in6_addr(saddr6, 0, &gc), sport,
> +                       print_in6_addr(daddr6, 0, &gc), dport);
> +        }
> +
> +        msg(D_LOW, "Recursive routing detected, drop packet %s. Fix your routing or consider using --allow-recursive-routing option.", BSTR(&addrs_buf));

I would add "if you know what you are doing", otherwisethe average Joe
will think that he can just add "--allow-recursive-routing" to his
config and the problem is fixed.


Regards,

>          gc_free(&gc);
>      }
>  }
> 

-- 
Antonio Quartulli

