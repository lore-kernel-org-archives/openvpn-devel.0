References: <20201004223614.12429-1-themiron@...2010...>
 <20201115220857.9307-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <026bd62f-af6d-7dfe-2ba5-ffc4a751858d@...1227...>
Date: Mon, 23 Nov 2020 14:13:01 +0100
MIME-Version: 1.0
In-Reply-To: <20201115220857.9307-1-themiron@...2010...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v9] Add DNS SRV remote host discovery
 support
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
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

Am 15.11.20 um 23:08 schrieb Vladislav Grishenko:
> DNS SRV remote host discovery allows to have multiple OpenVPN servers for
> a single domain w/o explicit profile enumeration, to move services from
> host to host with little fuss, and to designate hosts as primary servers
> for a service and others as backups.
> Feature has been asked several times already, should be useful in case of
> substantial number of clients & servers deployed.
> 
> Patch introduces "--remote-srv domain [service] [proto]" option.
> The "service" and "proto" arguments are optional. Client will try
> to resolve DNS SRV record "_service._proto.domain" and use returned
> DNS SRV records as remote server list ordered by server selection
> mechanism defined in RFC2782 (https://tools.ietf.org/html/rfc2782):
> 
>     A client MUST attempt to contact the target host with the
>     lowest-numbered priority field value it can reach, target hosts
>     with the same priority SHOULD be tried in an order defined by the
>     weight field.
>     The weight field specifies a relative weight for entries with the
>     same priority. Larger weights SHOULD be given a proportionately
>     higher probability of being selected.
>     Domain administrators SHOULD use Weight 0 when there isn't any
>     server selection to do. In the presence of records containing
>     weights greater than 0, records with Weight 0 SHOULD have a very
>     small chance of being selected.
> 
> Note: OpenVPN server selection mechanism implementation indeed will
> give records with weight of zero a very small chance of being selected
> first, but never skip them.
> 
> Example: instead of multiple --remote in order, now it's possible to
> specify just one --remote-srv and configure DNS SRV records:
> 
>     remote-srv example.net
> 
>     name                 prio weight port target
>     $ORIGIN example.net.
>     _openvpn._udp IN SRV 10   60     1194 server1.example.net.
>     _openvpn._udp IN SRV 10   40     1194 server2.example.net.
>     _openvpn._udp IN SRV 10   0      1194 server3.example.net.
>     _openvpn._tcp IN SRV 20   0       443 server4.example.net.
> 
> For "--remote-srv example.net" following will happen in order:
> 1. The client will first try to resolve "_openvpn._udp.example.net"
>    and "_openvpn._tcp.example.net".
> 2. Records "server1.example.net:1194", "server2.example.net:1194"
>    and "server3.example.net:1194" will be selected before record
>    "server4.example.net:443" as their priority 10 is smaller than 20.
> 3. Records "server1.example.net:1194", "server2.example.net:1194"
>    and "server3.example.net:1194" will be randomly selected with
>    weight probability: first will be either "server1.example.net:1194"
>    with 60% probability or "server2.example.net:1194" with 40% or
>    "server3.example.net:1194" with almost zero probability.
> 4. If "server1.example.net:1194" was selected, the second record will
>    be either "server2.example.net:1194" with almost 100% probability
>    or "server3.example.net:1194" with almost 0%.
> 5. If "server2.example.net:1194" was selected, the third record will
>    be the only last record of priority 10 - "server3.example.net:1194".
> 6. Record "server4.example.net:443" will be the last one selected as
>    the only record with priority 20.
> 7. Each of the resulting "target:port" remote hosts will be resolved
>    and accessed if its protocol has no conflict with the rest of the
>    OpenVPN options.
> 
>   If DNS SRV name can't be resolved or no valid records were returned,
>   client will move on to the next connection entry.
> 
> v9:
>     add get_cached_srv_entry() for servinfo vs addrinfo cache split
>     add check for mixed --remote and --remote-srv
>     add doxygen dns srv functions comments
>     use query_servinfo() for both unix and windows
>     fix undefined NS_MAXMSG issue on macOS
>     fix man
> 
>

Acked-By: Arne Schwabe<arne@...1227...>

This addresses the concerns that I had with the last version.

Arne

