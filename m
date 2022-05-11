Message-ID: <9e3f3b2c-460b-0bd5-57b3-a9ca103ff7ac@...1227...>
Date: Wed, 11 May 2022 11:16:16 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220222143514.3480-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220222143514.3480-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Implement --mtu-disc for IPv6 UDP
 sockets.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 22.02.22 um 15:35 schrieb Gert Doering:
> Commit 4225114b96 repaired "--mtu-disc yes" brokenness for IPv4 UDP sockets
> (caused by autoconf/ifdef issues).  This patch adds new functionality
> to do --mtu-disc for IPv6 sockets as well.
> 
> Half of it (setsockopt(IPV6_MTU_DISCOVER)) was already there, but
> receiving of detailed socket errors was missing the enablement of
> setsockopt(IPV6_RECVERR) and parsing of IPPROTO_IPV6/IPV6_RECVERR
> messages received.
> 
> With that, we now get (sending over a route with "mtu 1300"):
> 
> 2022-02-22 15:28:07 write UDPv6 [EMSGSIZE Path-MTU=1300]: Message too long (fd=3,code=90)
> 2022-02-22 15:28:07 Note adjusting 'mssfix 1400 mtu' to 'mssfix 1300 mtu' according to path MTU discovery
> 2022-02-22 15:28:07 Note adjusting 'fragment 1400 mtu' to 'fragment 1300 mtu' according to path MTU discovery

Looks simple enough.

Acked-By: Arne Schwabe <arne@...1227...>

Arne


