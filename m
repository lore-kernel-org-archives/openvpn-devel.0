From: Sampo Nurmentaus <audiopoppi-13@...22...>
Reply-To: <sampo.nurmentaus@...22...>
Subject: Re: [Openvpn-devel] add a server feature to openvpn to share udp
 ports ?
In-Reply-To: <006001c21e03$e9004780$1000000a@...4...>
Message-ID: <Pine.LNX.4.33.0206281102090.5299-100000@...23...>
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
Date: Fri Jun 28 01:31:06 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...3...>
Cc: openvpn-devel@lists.sourceforge.net

Hello all,

> > Hi,
> >
> > I don't know if my idea are really pertinent pertinent, I haven't deeply
> read
> > the code nor have a lot of experience, but here they are.
> >
> > > As far as ports are concerned, I am thinking that a forking server
> > > implementation of OpenVPN would listen for incoming connections on a
> fixed
> > > port, but then switch over to a dynamic port to finalize initialization
> of
> > > the session.
> >
> > I have read in the libc info page that udp didn't provide listen/accept.
> > Thus it seems to me that moving to another port would imply telling back
> > the client the new port. Am I wrong ?
>
> OpenVPN already supports (by --float) replying to a remote peer using a
> different port that what the peer is expecting.  I think a forking server
> would need to allocate a dynamic return port.


Is different ports for every client really needed?
Ain't there a way to use same port for everyone,
like those udp based networked games do?

Parent process could use recvfrom to read the socket
and then pass the packet on to the correct child
via an unix socket. Even better if there are some
authentication information in the packets them self,
but I don't see ip based packet delivery as a problem
since every packet should be identified any way by
the child process.

I think that using a single port is more simple for firewalls.


> >
> > > (1) How do you fork on new clients without opening yourself up to DoS
> > > attacks?  In order to be secure, the server would need to statelessly
> > > authenticate the initial packet before forking.  Tricky, because SSL/TLS
> >
> > Why is it required to fork upon first packet reception ?
>
> Not required, but if you don't it becomes more complicated to deal with
> multiple incoming sessions at the same time.


Maybe using a pool of preforked threads would be nice.
There is some example code for this in Richard Stevens
Unix Network Programming

> a
> > lot of ports
> > 2) the tls authentication takes time and requires multi packets exchange.
> Thus
> > an attacker may try a lot of tls authentications to use server resources.
> > This point may be mitigated by the --tls-auth trick, but in case it is
> not,
> > the combination with forking may lead to a lot of resources used.
>
> --tls-auth is an effective DoS blocker in a 2-way OpenVPN session because we
> use an incrementing  timestamp and sequence number to prevent replay
> attacks.  If a DoS attacker eavesdrops on the wire and copies a bona-fide
> packet sequence from a connecting client to generate a packet storm, the
> packets would be immediately discarded because of the replay protection
> memory (once the peer receives an initial packet).  This feature would need
> to be adapted to a client-server model because multiple clients would be
> connecting and might not have perfectly synchronized clocks.  For example,
> if one client connected whose clock was 20 minutes ahead, then other clients
> (with accurate clocks) would get locked out for 20 minutes because
> the --tls-auth replay code would see backtracking timestamps.  One way to
> fix this would be to persist the replay state (i.e. last timestamp/sequence
> number received) for each potential client on disk.  But that adds another
> layer of complexity and would require the management of a large number of
> secondary keys (i.e. the --tls-auth passphrase).

Would it be possible to use a logical clock? Like Lamport's logical
clock algorithm. I has a quite simple idea, but of course
it requires carefull design to avoid any DoSes. I implemented
it for one of my school projects and it was not very difficult.

> > > initial authentication exchange, but there would need to be verification
> > > machinery to ensure that that client could not attack the server by
> > > sending it malformed routes.
> >
> > Is it a different problem than with an unknown ip address allowed to
> connect
> > to a single port ?
>
> Well I think the more general problem is one of specifying the server side
> configuration for a large number of potential clients that might connect.
> The configuration includes --ifconfig endpoints, return routes to client,
> and keys (if run in static key mode).  If the server dynamically configures
> the ifconfig endpoints from an address pool, then it would need to
> communicate those addresses back to the client so that it could do the
> ifconfig on its end.

Preconfigured addresses and routes for eatch client are usefull since
connecting to a client from server side requires the address to be
static. I see this as one advance of vpns in addition to security,
one can connect clients behind dynamic ip addresses.
In basic case there could be a config file with client IDs,
routes etc. I could also code a database support for the
server since that would be cool for managin clients allowed
to connect.

> Scalability is another issue.  There are some good ideas in the open source
> world for reducing the number of tunnels in an n-way network. tinc for
> example will use broadcasts and MAC address discovery over a tap (virtual
> ethernet) tunnel to deduce the destination of the packets, and allow one tap
> tunnel to connect to n peers.

What stops servers from connecting to another servers forming a
hierarcy of nodes? This makes it possible to reduce number of
clients per server. Of course this also requires the servers to
be able to exchange routing information, but that does not have
to be taken care by openvpn.



Best regards,
Sampo Nurmentaus


