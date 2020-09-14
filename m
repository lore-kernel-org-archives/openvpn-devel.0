References: <20200911115916.16117-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e53ed74d-d1c0-c76a-3622-da00e00cfb8b@...2181...>
Date: Mon, 14 Sep 2020 10:56:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200911115916.16117-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] If IPv6 pool specification sets pool
 start to ::0 address, increment.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 11/09/2020 13:59, Gert Doering wrote:
> index 1f74ac57..2814ff46 100644
> --- a/src/openvpn/pool.c
> +++ b/src/openvpn/pool.c
> @@ -224,6 +224,21 @@ ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t start,
>          }
>  
>          pool->ipv6.base = ipv6_base;
> +
> +        /* if a pool starts at ::0, that first IPv6 address is not usable
> +         * first clients (subnet anycast address).  Start with 1, then.
> +         * NOTE: this will also fire for something like
> +         *    ifconfig-ipv6-pool 2001:db8:0:1:1234::0/64
> +         * as we only look at the rightmost 32 bits.  So be it...
> +         */
> +        if (base == 0)

why not memcmp'ing ipv6.base with in6addr_any (defined in netinet/in.h)?
This way you get rid of the first NOTE (unless this header is linux
specific..).

Regards,

-- 
Antonio Quartulli

