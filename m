Message-ID: <033701c22128$de3cf320$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <Pine.LNX.4.33.0207011050250.5299-100000@...23...>
Subject: Re: [Openvpn-devel] add a server feature to openvpn to share udp ports ?
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Mon Jul  1 10:57:40 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: sampo.nurmentaus@...22...
Cc: openvpn-devel@lists.sourceforge.net

> Hi James,
>
> I do agree that forking and using a new port is a good solution due to
> it's simplicity. And fork cost ain't much for normal traffic since it's
> done only once per tunnel opening.
>
> There could also be a limit for the speed new childs are forked. Since it
> does not matter if it takes a while to creat a new tunnel, one could set a
> limit that new connection is accepted only after previous hand shaking is
> finished. This would reduce the possibility of a DoS attack.

I would suggest that the first version allows one new connection once every
n seconds, where n is a parameter.

Later versions might have a more sophisticated form of --tls-auth to do the
same.

> After client and server have exchanged the port information and server has
> forked both could sent a few dummy packets to the new port at the other
> end to allow the statefull firewalls in both ends to notice the
> connection. Don't know how well this would work but think that it is worth
> trying.

This might work with the existing --ping option which does the same for
current OpenVPN peer-to-peer sessions.

James

>
>
> Sampo
>
>
> > >
> > > Is different ports for every client really needed?
> > > Ain't there a way to use same port for everyone,
> > > like those udp based networked games do?
> > >
> > > Parent process could use recvfrom to read the socket
> > > and then pass the packet on to the correct child
> > > via an unix socket. Even better if there are some
> > > authentication information in the packets them self,
> > > but I don't see ip based packet delivery as a problem
> > > since every packet should be identified any way by
> > > the child process.
> > >
> > > I think that using a single port is more simple for firewalls.
> >
> > This works in principle, though you have the added inefficiency of the
> > context switch from parent to child, since the parent must now ID
> > and dispatch all incoming packets to the child over the unix socket.
> >
> > Also, identifying the packets by source IP address & port could be a bit
> > tricky if you have more than one tunnel between the same two hosts.
> >
> > I think forking children on a new port would be the easiest to
implement,
> > the most efficient, and arguably the most robust, since the child
> > functionality is already perfectly encapsulated by OpenVPN as it exists
> > right now.
> >
> > Of course this method would use more ports and might create firewall
> > complications.
>
>
>
>
> > >
> > >
> > > > >
> > > > > > (1) How do you fork on new clients without opening yourself up
to DoS
> > > > > > attacks?  In order to be secure, the server would need to
statelessly
> > > > > > authenticate the initial packet before forking.  Tricky, because
SSL/TLS
> > > > >
> > > > > Why is it required to fork upon first packet reception ?
> > > >
> > > > Not required, but if you don't it becomes more complicated to deal
with
> > > > multiple incoming sessions at the same time.
> > >
> > >
> > > Maybe using a pool of preforked threads would be nice.
> > > There is some example code for this in Richard Stevens
> > > Unix Network Programmin
> >
> > Preforked threads are great for a server such as a web server that must
> > deal with a high frequency of incoming, short-term sessions, but I think
a
> > VPN server will have more latitude in this area because the frequency of
> > connection requests will be lower and the session duration will be
> > larger.
> >
> > My concern is more along the lines of how to design the system so that a
> > minimum amount of resources is expended in identifying and discarding
DoS
> > datagrams.
> >
> > And if we have to wait for TLS authentication to fail on a DoS session,
> > the CPU cycles used by the SSL/TLS authentication code will probably
dwarf
> > the fork cost.
> >
> > >
> > > > a
> > > > > lot of ports
> > > > > 2) the tls authentication takes time and requires multi packets
exchange.
> > > > Thus
> > > > > an attacker may try a lot of tls authentications to use server
resources.
> > > > > This point may be mitigated by the --tls-auth trick, but in case
it is
> > > > not,
> > > > > the combination with forking may lead to a lot of resources used.
> > > >
> > > > --tls-auth is an effective DoS blocker in a 2-way OpenVPN session
because we
> > > > use an incrementing  timestamp and sequence number to prevent replay
> > > > attacks.  If a DoS attacker eavesdrops on the wire and copies a
bona-fide
> > > > packet sequence from a connecting client to generate a packet storm,
the
> > > > packets would be immediately discarded because of the replay
protection
> > > > memory (once the peer receives an initial packet).  This feature
would need
> > > > to be adapted to a client-server model because multiple clients
would be
> > > > connecting and might not have perfectly synchronized clocks.  For
example,
> > > > if one client connected whose clock was 20 minutes ahead, then other
clients
> > > > (with accurate clocks) would get locked out for 20 minutes because
> > > > the --tls-auth replay code would see backtracking timestamps.  One
way to
> > > > fix this would be to persist the replay state (i.e. last
timestamp/sequence
> > > > number received) for each potential client on disk.  But that adds
another
> > > > layer of complexity and would require the management of a large
number of
> > > > secondary keys (i.e. the --tls-auth passphrase).
> > >
> > > Would it be possible to use a logical clock? Like Lamport's logical
> > > clock algorithm. I has a quite simple idea, but of course
> > > it requires carefull design to avoid any DoSes. I implemented
> > > it for one of my school projects and it was not very difficult.
> >
> > I did look at the Lamport Clock algorithm but I'm not sure we can use it
> > to make an n-way --tls-auth.  Because suppose that a new client is
> > connecting.  The Lamport timestamp on its session-initiating datagram
will
> > be stale until it gets a a response from the server.  But our goal is to
> > construct the session-initiating datagram so that it has enough
> > information (without requiring any multi-packet handshake) to allow a
fast
> > valid or DoS classification.
> >
> > >
> > > > > > initial authentication exchange, but there would need to be
verification
> > > > > > machinery to ensure that that client could not attack the server
by
> > > > > > sending it malformed routes.
> > > > >
> > > > > Is it a different problem than with an unknown ip address allowed
to
> > > > connect
> > > > > to a single port ?
> > > >
> > > > Well I think the more general problem is one of specifying the
server side
> > > > configuration for a large number of potential clients that might
connect.
> > > > The configuration includes --ifconfig endpoints, return routes to
client,
> > > > and keys (if run in static key mode).  If the server dynamically
configures
> > > > the ifconfig endpoints from an address pool, then it would need to
> > > > communicate those addresses back to the client so that it could do
the
> > > > ifconfig on its end.
> > >
> > > Preconfigured addresses and routes for eatch client are usefull since
> > > connecting to a client from server side requires the address to be
> > > static. I see this as one advance of vpns in addition to security,
> > > one can connect clients behind dynamic ip addresses.
> > > In basic case there could be a config file with client IDs,
> > > routes etc. I could also code a database support for the
> > > server since that would be cool for managin clients allowed
> > > to connect.
> >
> > I would like to see the dynamic client-server features implemented as a
> > module that would instantiate OpenVPN's core peer-to-peer code for each
> > new session.  It would also be nice if we could do it without changing
the
> > protocol or making too many changes to the core peer-to-peer code which
is
> > nicely stable and robust right now.
> >
> > >
> > > > Scalability is another issue.  There are some good ideas in the open
source
> > > > world for reducing the number of tunnels in an n-way network. tinc
for
> > > > example will use broadcasts and MAC address discovery over a tap
(virtual
> > > > ethernet) tunnel to deduce the destination of the packets, and allow
one tap
> > > > tunnel to connect to n peers.
> > >
> > > What stops servers from connecting to another servers forming a
> > > hierarcy of nodes? This makes it possible to reduce number of
> > > clients per server. Of course this also requires the servers to
> > > be able to exchange routing information, but that does not have
> > > to be taken care by openvpn.
> >
> > It's nice if the OS can take care of routing.  But if we leave routing
up
> > to the OS (as we do now), then the VPN must deal with potentially a
> > large number of tun or tap devices in an n-way network, and scalability
> > could become an issue.
> >
> > > Best regards,
> > > Sampo Nurmentaus
> > >
> >
> > Thanks,
> > James
> >
> >
> >
>


