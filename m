Message-ID: <406A98DC.3060504@...177...>
From: Farkas Levente <lfarkas@...177...>
MIME-Version: 1.0
Subject: Re: [Openvpn-users] Re: [Openvpn-devel] OpenVPN 2.0 -- Project Update
 and Release Notes
References: <twig.1080688545.10218@...41...>, <twig.1080688545.10218@...41...> <twig.1080723806.29962@...41...>
In-Reply-To: <twig.1080723806.29962@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Mar 31 02:10:28 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> Farkas Levente <lfarkas@...177...> said:
> 
> 
>>first of all THANKS!
>>
>>James Yonan wrote:
>>
>>>* Add an internal routing capability to the OpenVPN server to allow
>>>client-to-client communication, without going through the tun interface on the
>>>server.
>>
>>why this is needed? ans what exactly this means?
> 
> 
> Basically OpenVPN 2.0 is a router.  It gets packets from a single tun
> interface and uses the destination address on the packet to determine which
> client to route it to.  So what should the router do if a packet comes from a
> client and has as its destination address another client?  Some people would
> want to block this capability and other would want to allow it.  If you block
> it, connecting clients can only see the central server's network.  If you
> allow it, one client could browse file shares on another client.

hmm, thanks I know what's the routing, but I ask this part:
"client-to-client communication, without going through the tun.."
                                  ^^^^^^^

>>>* Right now clients are allocated a single, dynamic IP address.  It would be
>>>nice if a connecting client could specify a full subnet to be tunneled.
>>
>>would be welcome!
> 
> 
> There are several problems with this that need to be solved (which I don't
> think are insurmountable):
> 
> (1) First of all, there are security implications in allowing a client to push
> a route onto a server, which would be necessary if a private subnet exists
> behind the client that you want to route.  Probably the server config file
> would need to specify special routes for various clients, based on the client
> common name.

yes, but it's possible in th 1.x (although all clients has it's own 
config file), but since I can use --ifconfig-pool (which is great) I 
don't know in advance which /30 subnet will be used by the clinet, so 
define static route is a bit problematic.

> (2) In general you want to run the VPN server with reduced privilege, to limit
> damage in the case that the server is somehow compromised.  But adding and
> removing routes requires privilege, unless all routes for every possible
> client are configured on server startup, before the privilege downgrade.

that's a good point:-(((

> (3) static routes tied to specific clients interferes with failover.  Suppose
> you have 2 machines running a VPN server, and for purposes of load balancing
> and failover, you want clients to be able to connect to either server.  Now
> once you start to have clients needing static routes, it means that the
> gateway on the server's network needs to understand that a given static route
> might need to point to either server A or server B, depending on which of the
> two servers the client is currently connected to.  So essentially, the server
> would need to be able to push routes onto the gateway.
> 
> Of course all of these problems go away if the client NATs its private subnet
> onto the remote VPN endpoint.  There would also be the possibility of having
> the server dynamically allocate a full netblock to the client and then have
> the client do one-to-one NAT between the static addresses on the subnet and
> the dynamically allocated VPN subnet.  Yet another possibility is simply to
> have each machine in the remote subnet have its own private tunnel to the VPN
> server.
> 
> So there's certainly a number of possible solutions, but no magic bullet that
> I can think of.

I see the problems.

>>># The server's virtual endpoints
>>>ifconfig 10.8.0.1 10.8.0.2
>>
>>this means this server has two enpoint in the server side?
> 
> 
> Not really.  The server's local VPN endpoint is 10.8.0.1.  This is the address
> which all clients will use to reach the server.  The 10.8.0.2 is really a
> pseudo-address which is not bound to anything.  You couldn't ping it for

than it'd be better to omit. it's just confusing!

> example.  However you can use it as a destination for routes which exist in
> the server's routing table.  When you do this, the packet will be routed to
> OpenVPN which will then use an internal routing algorithm to route it to the
> appropriate client.  The way to think about this in a non-confusing way is to
> treat the 10.8.0.2 as the "name" of the server's tun interface, so that when
> you want to route a subnet into server, you can use 10.8.0.2 as the destination.

aha, than two separete config option would be more intuitive (or it 
should have to be well documented).
in this case my first question getting cleaner. although I still thing 
that routing is better to do in the os (where it's tuned better) and 
somehow propagate openvpn's route table to the os's route tables.
do it two separate place can get confusing and may result fault.

-- 
   Levente                               "Si vis pacem para bellum!"


