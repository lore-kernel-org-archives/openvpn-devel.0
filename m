Message-ID: <52494c60-a2e8-2e49-ac29-26ae091c3fc0@...1227...>
Date: Thu, 20 Oct 2022 14:10:31 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220917214756.23630-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220917214756.23630-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Implement the --passtos option for IPv6
 packets and sockets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: "Vittorio Gambaletta (VittGam)" <github@...2696...>

> +
> +/*
> + * Extract TOS bits. Assumes that ipbuf is a valid IPv6 packet.
> + */
> +static inline void
> +link_socket_extract_tos_v6(struct link_socket *ls, const struct buffer *ipbuf)
> +{
> +    if (!ls || !ipbuf)
> +    {
> +        return;
> +    }
> +
> +    struct openvpn_ipv6hdr *ip6h = (struct openvpn_ipv6hdr *)BPTR(ipbuf);
> +    ls->ptos = ((ip6h->version_prio & 0x0F) << 4) | (ip6h->flow_lbl[0] >> 4);
> +    ls->ptos_defined = true;
>   }

This looks a bit strange and my test also fails (see below).


Unfortunately, while the patch looks simple enough, I have to NACK it. 
The patch does not handle v4 payload to v6 transport in a good way. I 
used ping -z 12. It ends up as DSCP 0x0c in the IPv4 payload (as 
expected) but ends up as DSCP: 0x00 and flow label 0x90200 in the IPv6 
transport packet.

Arne

