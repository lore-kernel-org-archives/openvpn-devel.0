Subject: Re: [Openvpn-users] Re: [Openvpn-devel] OpenVPN 2.0 -- Project Update and Release Notes
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1080730209.200@...41...>
In-Reply-To: <406A98DC.3060504@...177...>
References: <twig.1080688545.10218@...41...>, <twig.1080688545.10218@...41...> <twig.1080723806.29962@...41...>, <twig.1080723806.29962@...41...>
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
Date: Wed Mar 31 02:51:34 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Farkas Levente <lfarkas@...177...>, openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Farkas Levente <lfarkas@...177...> said:

> > Basically OpenVPN 2.0 is a router.  It gets packets from a single tun
> > interface and uses the destination address on the packet to determine which
> > client to route it to.  So what should the router do if a packet comes from a
> > client and has as its destination address another client?  Some people would
> > want to block this capability and other would want to allow it.  If you block
> > it, connecting clients can only see the central server's network.  If you
> > allow it, one client could browse file shares on another client.
> 
> hmm, thanks I know what's the routing, but I ask this part:
> "client-to-client communication, without going through the tun.."
>                                   ^^^^^^^

It means that OpenVPN gets a packet from client A that is destined to client
B.  It is possible for OpenVPN to route this packet directly without actually
going through the tun interface.

However if OpenVPN ignores this fact and writes the packet to the tun device
(which will cause it to "appear" on the tun interface from the perspective of
the network stack), it might confuse the OS because you're giving it a packet
for which the system routing table is simply going to bounce the packet back
to the tun interface.  Some OSes might interpret this as a routing loop and
drop the packet.

> > (1) First of all, there are security implications in allowing a client to push
> > a route onto a server, which would be necessary if a private subnet exists
> > behind the client that you want to route.  Probably the server config file
> > would need to specify special routes for various clients, based on the client
> > common name.
> 
> yes, but it's possible in th 1.x (although all clients has it's own 
> config file), but since I can use --ifconfig-pool (which is great) I 
> don't know in advance which /30 subnet will be used by the clinet, so 
> define static route is a bit problematic.

Right, static routes and --ifconfig-pool don't really play well together.

> >>># The server's virtual endpoints
> >>>ifconfig 10.8.0.1 10.8.0.2
> >>
> >>this means this server has two enpoint in the server side?
> > 
> > 
> > Not really.  The server's local VPN endpoint is 10.8.0.1.  This is the address
> > which all clients will use to reach the server.  The 10.8.0.2 is really a
> > pseudo-address which is not bound to anything.  You couldn't ping it for
> 
> than it'd be better to omit. it's just confusing!

I agree that it's confusing.  But it accurately describes the necessary
ifconfig operation to configure the tun interface.

> > example.  However you can use it as a destination for routes which exist in
> > the server's routing table.  When you do this, the packet will be routed to
> > OpenVPN which will then use an internal routing algorithm to route it to the
> > appropriate client.  The way to think about this in a non-confusing way is to
> > treat the 10.8.0.2 as the "name" of the server's tun interface, so that when
> > you want to route a subnet into server, you can use 10.8.0.2 as the
destination.
> 
> aha, than two separete config option would be more intuitive (or it 
> should have to be well documented).
> in this case my first question getting cleaner. although I still thing 
> that routing is better to do in the os (where it's tuned better) and 
> somehow propagate openvpn's route table to the os's route tables.
> do it two separate place can get confusing and may result fault.

I absolutely agree that routing is better done in the OS.  However, the
problem is that if you are a VPN server with many clients and one tun/tap
interface, you are a router.  There's not really any way around that basic fact.

James


