Message-ID: <056901c23231$11cfc2d0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <Pine.LNX.4.33.0207231003040.5299-100000@...23...>
Subject: Re: [Openvpn-devel] Multiple VPN connections on the same port
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
Date: Tue Jul 23 03:09:03 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: sampo.nurmentaus@...22...
Cc: Michael Grigoriev <mag@...34...>, openvpn-devel@lists.sourceforge.net

Hi Sampo,

> I have been busy writing a forking server
> addon to openvpn.

Cool... Does each potential connecting client need a separate config file,
or does the server use a common client template and then keep track of
things like dynamic ports, dynamic endpoint addresses, etc?

> In openvpn.c I have separated the processing of
> parameters from main() to a new function and
> moved main to another file to allow me to
> link against different main() functions.
>
> One that implements normal peer2peer vpn
> and two others that produces forkin' server
> and client.
>
> These use a simple UDP protocol to agree a
> port to use, after which server forks do
> some handshaking with client and then
> calls openvpn() funcition from openvpn.c

Are you sure there needs to be a new protocol to do this?

Suppose the master server listens on a particular port, reads the initial
datagram from a connecting client, verifies the integrity of the datagram
using a --tls-auth variant, allocates a dynamic port, forks a new server
process, and continues in its event loop.

When the forked process finishes up the TLS authentication, it can take the
Common Name from the client certificate and use it to determine the
appropriate config profile to use (containing ifconfig addresses, route
statements, etc.)

Or the handshaking could be done by passing a configuration string in the
TLS payload, similar to the string now built by options_string().

> This way I have been able to keep
> those well tested procedures and protocol
> of openvpn untouched.
>
> I still have some questions unsolved like
> DoS protection, dropping root priviledges
> and how to handel SIGUSR1 and SIGHUP.

Maybe keep track of all children, so when the master process gets a signal,
it dispatches it to each child process, then to itself.

> I hope I can overcome these and mail
> you a patch.
>
>
>
>
> Sampo
>
>
>
> > Hi Michael,
> >
> > Right now OpenVPN doesn't support a forking-server model on a single
port,
> > it's strictly peer-to-peer with an OpenVPN process instantiated at both
ends
> > of the connection, and each connection on a unique port.
> >
> > There has been some recent discussions about a forking-server
implementation
> > on this list -- see the "add a server feature to openvpn to share udp
> > ports?" thread in the openvpn-devel archives.
> >
> > I think the simplest way to do this would be something like:
> >
> > (1) Add a --forking-server flag that causes the main OpenVPN event loop
to
> > fork a new process for each initial datagram received from a client.
> > (2) The newly forked server process switches to a dynamic port before
> > responding back to the connecting client.  This is quite a bit simpler
and
> > more efficient than trying to run all clients over the same UDP port.
> > (3) OpenVPN already has code (see the implementation of --float) that
will
> > adapt to the new port number returned by the response to initial
datagram
> > sent from server to client.  I have also confirmed that this type of UDP
> > port switch is recognized by both Linux and Cisco stateful firewalls.
> >
> > There are a some complications that would need to be handled:
> >
> > (1) You would need to protect against DoS attacks that flood the server
with
> > fork requests.  Possibly some variation of --tls-auth that would
> > authenticate the initial packet before the fork call.
> >
> > (2) If a client connects, gets disconnected, then connects again, you
would
> > need to make sure that the old server process gets killed before a new
> > server process is forked.
> >
> > Unfortunately I'm pretty busy right now with my day job, so I may not
get to
> > this for a while.  If you want to take a shot at some kind of
> > implementation, I will do my best to answer your questions.
> >
> > Best Regards,
> > James
> >
> > ----- Original Message -----
> > From: "Michael Grigoriev" <mag@...34...>
> > To: <openvpn-devel@lists.sourceforge.net>
> > Sent: Monday, July 22, 2002 6:53 PM
> > Subject: [Openvpn-devel] Multiple VPN connections on the same port
> >
> >
> > > Hi,
> > >
> > > Firstly I'd like to thank you a prompt responce to my last question -
> > > it was most helpful.
> > >
> > > Now I am looking into the posibility of setting up a VPN server that
> > > will accept incoming VPN connections from some number of clients. (I
do
> > > realize that client/server only really applies to TLS-mode, by client
I
> > > really just mean the machine that will initialize the connection, the
> > > one that will be started with --remote)  However I am not sure how to
> > > best implement this since I don't know the number of clients in
> > > advance, so I can't really have a port assigned to each client.
Instead
> > > I would like to have all clients to connect to the server on the same
> > > port. I did not however find a way to do so with OpenVPN. When I tried
> > > to have to have two clients connect to the same server, they just kept
> > > periodically knocking each other off with error messages of the sort:
> > > 105: TLS Error: Unroutable control packet received from
> > > 192.168.xx.xx:7000 (si=3 op=P_CONTROL_SOFT_RESET_V1)
> > > So I guess my question is, is it supposed to work? The man page says
> > > that you "should" have all the connections use a different port, which
> > > would imply that it is possible to do the opposite, but I was not able
> > > to get it to work....
> > > If it is not possible, as far as I understand it should not be too
hard
> > > to implement... We could have the server start out bound to the
> > > listening port, but not connected, and when we get an incoming
> > > connection from some ip, we fork and call connect in the child, so
that
> > > in the future all packets from that ip would go to that process.
Right?
> > >
> > > Would this work? Is there a better way to accomplish this?
> > >
> > > --
> > > Thanks in advance,
> > > mag
> > >
> > >
> > >
> > > -------------------------------------------------------
> > > This sf.net email is sponsored by:ThinkGeek
> > > Welcome to geek heaven.
> > > http://thinkgeek.com/sf
> > > _______________________________________________
> > > Openvpn-devel mailing list
> > > Openvpn-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> > >
> >
> >
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>



