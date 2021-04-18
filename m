References: <20210415230545.22317-1-themiron@...2010...>
 <20210416120708.1532-1-themiron@...2010...>
 <20210416120708.1532-2-themiron@...2010...>
 <20210418141537.GA976@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c139c4dc-6a42-b501-c1ce-de53c4caf19d@...2181...>
Date: Sun, 18 Apr 2021 16:55:23 +0200
MIME-Version: 1.0
In-Reply-To: <20210418141537.GA976@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 2/2] Add basic support for multipath
 gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net



On 18/04/2021 16:15, Gert Doering wrote:
> Hi,
> 
> On Fri, Apr 16, 2021 at 05:07:08PM +0500, Vladislav Grishenko wrote:
>> Load balancing setup over multiple upstreams may include multipath
>> gateway route, which is not not supported by OpenVPN.
>> Let's add basic support for that for selecting best route for zero
>> destination address - use any one of nexthop addresses as a gateway,
>> weights are not handled.
> 
> What happens with the current code when we encounter such a situation?
> 
> I assume it will "just not work" and find no gateway address?

Yeah, nexthops groups are just not parsed. So if the default GW is
configured this way, it will not be found.

This said, it's very likely the main routing table will have a classic
default route most of the time.

Still, we want to handle nexthop groups somehow.

Cheers,


-- 
Antonio Quartulli

