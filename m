Message-ID: <006001c21e03$e9004780$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <1024902829.1463.9.camel@...2...> <Pine.LNX.4.44.0206241311040.32473-100000@...21...> <20020627171625.F6806@...27...>
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
Date: Thu Jun 27 10:55:41 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Patrice DUMAS - DOCT <dumas@...26...>, openvpn-devel@lists.sourceforge.net

Hi Patrice,

Some comments inline...


> Hi,
>
> I don't know if my idea are really pertinent pertinent, I haven't deeply
read
> the code nor have a lot of experience, but here they are.
>
> > As far as ports are concerned, I am thinking that a forking server
> > implementation of OpenVPN would listen for incoming connections on a
fixed
> > port, but then switch over to a dynamic port to finalize initialization
of
> > the session.
>
> I have read in the libc info page that udp didn't provide listen/accept.
> Thus it seems to me that moving to another port would imply telling back
> the client the new port. Am I wrong ?

OpenVPN already supports (by --float) replying to a remote peer using a
different port that what the peer is expecting.  I think a forking server
would need to allocate a dynamic return port.

>
> > (1) How do you fork on new clients without opening yourself up to DoS
> > attacks?  In order to be secure, the server would need to statelessly
> > authenticate the initial packet before forking.  Tricky, because SSL/TLS
>
> Why is it required to fork upon first packet reception ?

Not required, but if you don't it becomes more complicated to deal with
multiple incoming sessions at the same time.

> > requires a multi-packet exchange to authenticate.
>
> I think there are 2 distinct possible Dos possible:
> 1) an attacker may connect many times, to get the server to fork, and open
a
> lot of ports
> 2) the tls authentication takes time and requires multi packets exchange.
Thus
> an attacker may try a lot of tls authentications to use server resources.
> This point may be mitigated by the --tls-auth trick, but in case it is
not,
> the combination with forking may lead to a lot of resources used.

--tls-auth is an effective DoS blocker in a 2-way OpenVPN session because we
use an incrementing  timestamp and sequence number to prevent replay
attacks.  If a DoS attacker eavesdrops on the wire and copies a bona-fide
packet sequence from a connecting client to generate a packet storm, the
packets would be immediately discarded because of the replay protection
memory (once the peer receives an initial packet).  This feature would need
to be adapted to a client-server model because multiple clients would be
connecting and might not have perfectly synchronized clocks.  For example,
if one client connected whose clock was 20 minutes ahead, then other clients
(with accurate clocks) would get locked out for 20 minutes because
the --tls-auth replay code would see backtracking timestamps.  One way to
fix this would be to persist the replay state (i.e. last timestamp/sequence
number received) for each potential client on disk.  But that adds another
layer of complexity and would require the management of a large number of
secondary keys (i.e. the --tls-auth passphrase).

>
> For 1), I can see 2 possible solutions.
>
> The first would be to fork only after the tls authentication has been
done.
> In that case there are 2 possibilities:
> * do tls authentications sequentially. The design could be simple, but the
> clients would have to wait for the completion of the tls athentication.
> * do tls authentications in parallell. It may be possible to have more
> than one tls_multi object, each one associated with a thread (or multiple
> calls in case there is no thread). The gain may no be consequent because
> crypto is cpu intensive and not io intensive, and all the clients could
> end up waiting approximately the same time.
>
> The second would be to put a limit on the nuber of forked child engaged in
> tls authentication which haven't succeded yet. This would imply having a
> possibility of communication between childs and the server process, to
> notice when the tls auth is done.

The problem here is that a DoS attacker could easily lock up the
pre-authenticated session quota, and then those authentication slots would
be tied up for --hand-window seconds (60 seconds by default), until the TLS
authentication layer times out.

> > (2) How does the server know which return routes to set up for the
client,
> > without requiring an --up script on the server for every client that
might
> > connect?  The client could send its routes to the server as part of the
> > initial authentication exchange, but there would need to be verification
> > machinery to ensure that that client could not attack the server by
> > sending it malformed routes.
>
> Is it a different problem than with an unknown ip address allowed to
connect
> to a single port ?

Well I think the more general problem is one of specifying the server side
configuration for a large number of potential clients that might connect.
The configuration includes --ifconfig endpoints, return routes to client,
and keys (if run in static key mode).  If the server dynamically configures
the ifconfig endpoints from an address pool, then it would need to
communicate those addresses back to the client so that it could do the
ifconfig on its end.

Scalability is another issue.  There are some good ideas in the open source
world for reducing the number of tunnels in an n-way network. tinc for
example will use broadcasts and MAC address discovery over a tap (virtual
ethernet) tunnel to deduce the destination of the packets, and allow one tap
tunnel to connect to n peers.

> Does somebody know about an udp server forking and using different ports,
with
> code available, of course ;-).
>
> I may be wrong, but I think that it is not common because in the classical
> udp servers all the datagramms carry an identifier, or just need a
response
> and no long term association. Thus there is no need of forking. In the
> openvpn case, there is a need of multi packet exchange during tls auth and
> afterwards a long term tunnel is established.
>
> Pat

Best Regards,
James



