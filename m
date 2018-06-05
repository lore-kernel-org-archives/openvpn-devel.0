References: <20180605090421.9746-1-a@...2181...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <9ea3b5ec-4bad-f9bf-29a6-533ecb237027@...277...>
Date: Tue, 5 Jun 2018 13:05:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180605090421.9746-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 0/5] Allow IPv6-only tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I have applied these 5 patches to master on ubuntu 18.04LTS
The resulting binary gave server+client ipv6 *only* tunnel
over ipv4 network.  100% success

Using only: --server-ipv6 12fc:1918::10:186:0:0/112

I am sure buildbot runs more extensive tests than my single test
but I would be happy to ACK this if i could work out how to.

Thanks


On 05/06/18 10:04, Antonio Quartulli wrote:
> This patchset allows clients and servers to work with a
> tunnel configured with IPv6 only.
> 
> Patches 2 and 3 are mere cosmetic changes and could be merged
> regardless of the rest (note that 3 depends on 2).
> 
> With this change a server can be configured by using only the
> '--server-ipv6' directive.
> This will result in clients receiving only 'ifconfig-ipv6'
> setting in their push-reply (and no IPv4 at all).
> 
> Given that different components required changes in order
> to achieve this goal, the patchset has been organized as follows:
> - patch 1 alters the tun logic (client & server side)
> - patch 4 alters the ifconfig-pool logic (server side)
> - patch 5 alters the server config logic (server side)
> 
> 
> Although I have tested the patchset with different configurations
> and with our buildbots, such change would definitely benefit
> from a broader testing campaign (even before being merged).
> 
> 
> Cheers,
> 
> Trac: #208
> 
> Antonio Quartulli (5):
>    tun: ensure interface can be configured with IPv6 only
>    pool: restyle ipv4/ipv6 members to improve readability
>    pool: convert pool 'type' to enum
>    pool: allow to configure an IPv6-only ifconfig-pool
>    make server capable of starting with an IPv6-only tunnel
> 
>   src/openvpn/helper.c |   8 +-
>   src/openvpn/multi.c  |  10 +-
>   src/openvpn/pool.c   | 179 ++++++++++++++--------
>   src/openvpn/pool.h   |  31 ++--
>   src/openvpn/tun.c    | 357 +++++++++++++++++++------------------------
>   5 files changed, 308 insertions(+), 277 deletions(-)
> 

