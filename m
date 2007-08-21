Message-ID: <46CB1563.2080706@...41...>
Date: Tue, 21 Aug 2007 10:40:03 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <C0170D0AF1277849A4B4518034F855DD0328177D@...916...>
In-Reply-To: <C0170D0AF1277849A4B4518034F855DD0328177D@...916...>
Subject: Re: [Openvpn-devel] Multi Cache TTL Usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Harris, Jeff" <JeffH@...925...>
Cc: openvpn-devel@lists.sourceforge.net

Harris, Jeff wrote:
> Does anyone know the effect of lowering the MULTI_CACHE_ROUTE_TTL
> constant in multi.h from 60 seconds to say 10?  Will it cause extra
> network traffic or anything if the routes are purged more often?
>
> I am trying to work around an issue I'm seeing with spikes in the number
> of multi_instance objects.  I have 125 connected clients and after a
> number of restarts of all the clients, the number of multi_instance
> objects on my server spikes to over 600 leading to an eventual
> exhaustion of memory.  I am using keep-alive settings of 5 second pings
> and 30 seconds of inactivity.
>
> Lowering the value to 30 seems to hold off the spikes for a bit.  With a
> value of 10 I have not seen the spikes.
>
> Any help would be appreciated.
>
>   

OpenVPN caches routes in a hash table for efficiency, so that it doesn't 
need to iterate through the whole routing table in order to find a 
match.  The problem appears to be that cache entries may prolong the 
life of a marked-for-delete multi-instance object by holding references 
to it until the cache entry expires.  So timing out the cached routes 
earlier appears to be a good solution, and will not increase network 
traffic.

James


