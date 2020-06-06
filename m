Date: Sat, 6 Jun 2020 16:11:39 +0200 (CEST)
Message-Id: <202006061411.056EBdEo023105@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200601200624.14765-1-a@...2181...>
References: <20200601200624.14765-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: pool: allow to configure an
 IPv6-only ifconfig-pool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Reviewed again ("stare at code").   Most of the changes are really
"straightforward", as soon as done :-) - make all the IPv4 stuff in
the pool handling conditional, make IPv6 "stand on its own", plus
fiddling with minimum sizes (if both protocols are "on", the more
limited pool limits the size of the other protocol).

There still is *one* "pool" structure, but its IPv4 and IPv6 parts
are now fully independent, except for the common size limitation -
and that is fine, as there is currently no logic to tell openvpn
"oh, this client only gets a v4 pool address", or "and v6 comes from
that *other* pool".  Maybe some day, but that's a different patchset.

One thing we actually might spend some more thought on is this one:

        pool->ipv6.size = ipv6_netbits > 112
                          ? (1 << (128 - ipv6_netbits)) - base
                          : IFCONFIG_POOL_MAX;

which, I think, will not do the right thing for

  ifconfig-ipv6-pool 2001:db8::f000/112

(it will come up with "65536", but the actual max size should be
4096, ::f000 to :ffff) - so it should be ">= 112" there.

But... even for a larger pool, if the base address is sufficiently silly,
this will still not do what we intended to - 2001:db8::ffff:f000/96 will 
still overrun after 4096 clients, not having space for IFCONFIG_POOL_MAX.

Since this is no worse than today for silly configs, and better than
today for /113.../128, it makes sense to merge as it is, but we need
to revisit this.

(Note: when I say "overrun", it's not a "the pool structure will overrun
and OpenVPN will segfault" overrun, it's just "we hand out pool addresses
that are not part of the specified subnet" - which OpenVPN has always done,
if the pool was specified in a silly-enough way, but Antonio and I decided 
to fix this now by reducing the pool size according to the base address,
so the last address handed out is always "$net:ffff" - with the correct 
number of "f", of course)


Tested on the t_server setup with "no pools at all" (-> crash in v4) 
and "only v6 pool".  

Passed t_client tests, of course, but since no client-related code paths 
are touched, this was just extra double-checking.

Your patch has been applied to the master branch.

commit 452113155e791fdf6091de0422391ff62bda2ac9
Author: Antonio Quartulli
Date:   Mon Jun 1 22:06:24 2020 +0200

     pool: allow to configure an IPv6-only ifconfig-pool

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200601200624.14765-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19957.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


