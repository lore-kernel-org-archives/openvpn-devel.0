MIME-Version: 1.0
References: <20221205164103.9190-1-kprovost@...2661...>
 <20221205164103.9190-2-kprovost@...2661...>
In-Reply-To: <20221205164103.9190-2-kprovost@...2661...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 12 Dec 2022 14:34:10 +0200
Message-ID: <CAGyAFMW_pYqUKXttVQFzeRD-PAapHznauqbgfnettcwerkNyhQ@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Kristof Provost <kprovost@...2661...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

This is good - I need an API to get stats to make openvpn-gui show
those (via the management interface).

I am not too much into FreeBSD parts, but

> +    hash_iterator_init(m->hash, &hi);
> +
> +    while ((he = hash_iterator_next(&hi)))
> +    {
> +        struct multi_instance *mi = (struct multi_instance *) he->value;
> +
> +        if (mi->context.c2.tls_multi->peer_id != peerid)
> +            continue;

Shouldn't we use m->instances[peerid] instead of iterating over m->hash?

from multi.h:

struct multi_context {
    struct multi_instance **instances;  /**< Array of multi_instances.
An instance can be
                                         * accessed using peer-id as
an index. */
-- 
-Lev

