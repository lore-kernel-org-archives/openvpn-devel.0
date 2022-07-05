From: Heiko Hund <heiko@...2662...>
Date: Tue, 05 Jul 2022 14:30:49 +0200
Message-ID: <9760205.XyttyQAm76@...2664...>
In-Reply-To: <20220624083809.23487-14-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-14-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 13/25] dco: implement dco support for
 p2p/client code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Freitag, 24. Juni 2022 10:37:57 CEST Antonio Quartulli wrote:
> +    /* These inet_pton conversion are fatal since options.c already
> implements 
> +     * checks to have only valid addresses when setting the
> options */ 
> +    if (c->options.ifconfig_ipv6_remote)
> +    {
> +        if (inet_pton(AF_INET6, c->options.ifconfig_ipv6_remote,
> &remote_ip6) != 1) +        {
> +            msg(M_FATAL,
> +                "DCO peer init: problem converting IPv6 ifconfig remote
> address %s to binary", +                c->options.ifconfig_ipv6_remote);
> +        }
> +        remote_addr6 = &remote_ip6;
> +    }

I'm undecided if these fatal errors are justified with respect to defensive 
programming or overly paranoid, because they will never appear.



