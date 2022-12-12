Message-ID: <b6c21ae8-536a-2c6f-07e6-d998102c646e@...2181...>
Date: Mon, 12 Dec 2022 21:53:36 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20221205164103.9190-1-kprovost@...2661...>
 <20221205164103.9190-2-kprovost@...2661...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20221205164103.9190-2-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Read DCO traffic stats from the
 kernel
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
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 05/12/2022 17:41, Kristof Provost via Openvpn-devel wrote:
[cut]
> +
> +int
> +dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
> +{
> +
> +    struct ifdrv drv;
> +    uint8_t buf[4096];
> +    nvlist_t *nvl;
> +    const nvlist_t *const *nvpeers;
> +    size_t npeers;
> +    int ret;
> +
> +    if (!dco || !dco->open)
> +    {
> +        return 0;
> +    }
> +
> +    CLEAR(drv);
> +    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
> +    drv.ifd_cmd = OVPN_GET_PEER_STATS;

What speaks against having a simple GET_PEER here which returns the full 
peer object with all possible attributes?

This way, if we want to retrieve another attribute in the future, this 
attribute will already be delivered by the same API, without the need to 
implement a new command each time.


Cheers,

-- 
Antonio Quartulli

