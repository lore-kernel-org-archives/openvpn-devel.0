Message-Id: <200212271621.gBRGLof13611@...41...>
Subject: Re: [Openvpn-devel] Re: Multiple VPN connections on the same port
From: "James Yonan" <jim@...41...>
In-Reply-To: <Pine.LNX.4.33.0212271035410.9771-100000@...23...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Dec 27 08:23:03 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sampo.nurmentaus@...22..., Sampo Nurmentaus <audiopoppi-13@...22...>, James Yonan <jim@...41...>
Cc: ccmail321@...57..., openvpn-devel@lists.sourceforge.net

> Hello James,
> 
> That's good to hear,
> 
> There are some questions that I had to over come with
> my experimental forking server, like when does a forked
> process exit? Should we always use something line --inactive
> or --ping-exit? Or should there be a control command for closing
> the connection?

Good question, though nobody so far has complained that an openvpn session
cannot be closed remotely.  Most have been happy with --inactive & --ping-exit.

> I still mainly consentrated on using shared secret but how
> about managing client sertificates. Does openvpn understand
> sertificate revocation lists so that some sertificates
> can be bloked?

It's not supported right now, but would probably be easy to add.

> I think that there should also be some secure way in the protocol
> to pass the tunnel parameters to the other end
> so that both ends don't have to have all the configuration
> data available. For example, in our case embedded clients
> can tell the server the endpoint addresses so each of them
> can be reach trough a pre configured static ip.
> Or other way round, the server can pass the addresses to
> the client from a pool of addressess, when server
> is given the endpoint address ranges to use.

I think trying to do this in the openvpn protocol itself could be a bug
magnet, and would probably involve changing the protocol.  A better idea IMHO
would be to create a new server daemon which deals with negotiating the
configuration parameters, then this daemon instantiates a server openvpn
process.  This daemon would probably communicate via vanilla TLS, i.e. TLS
over a TCP connection.  In OpenVPN 1.3.2 this server daemon can be
inetd/xinetd, but without the feature that allows configuration information to
be provided by a single end of the connection (which must still be written).

We could develop and rework this daemon independently of openvpn, thereby
destabilizing neither the openvpn code nor the protocol during the development
and prototype stages.

Another complexity that comes from allowing a client to produce configuration
parameters for the server side as well is one of security.  To what extent
does the server trust the client to provide it, and how is this trust
controlled and configured?

> 
> Managing the parameters at the both end propably causes
> more problems due to config errors, than
> passing the parameters over the untrusted communication
> channel. :-)

I definitely wouldn't want to pass the parameters over an untrusted channel.

You might check out the archives for a patch that was posted last spring or
summer (autovpn?) for a script that does most of what I suggested above using
a shell script and ssh.

James

> 
> 
> SaBe
> 
> > Sampo,
> >
> > We've added some features to 1.3.2 and pre-1.3.3 code that are a step in the
> > direction of full forking server support.
> >
> > For example, 1.3.2 supports instantiation by inetd/xinetd.  xinetd has its own
> > DoS resistant features, and I added a new flag to the pre-1.3.3 code
> > (--replay-persist) in the CVS to do replay protection that is persistent
> > across sessions.
> >
> > The only thing we don't have yet is the ability to define an incoming
> > connection template which can be applied to more than one client.  Also,
> > allowing multiple tunnels to share the same UDP port is problematic, mostly
> > for efficiency reasons (since packets must be dispatched, it increases the
> > number of context switches per packet).
> >
> > James
> >
> > Sampo Nurmentaus <audiopoppi-13@...22...> said:
> >
> > >
> > >
> > > Hello,
> > >
> > > Sorry it took so long to reply, but I haven't read my work
> > > mail for a while due to all the exams.
> > >
> > > We have been using openvpn with this multiple connection
> > > hack of mine for a while with our embedded linux systems
> > > and it has been running fine. Still there is a lot of
> > > testing to do and it ain't finnished in any sense.
> > > For example, at the moment it is very sensitive to reply attacks.
> > >
> > > I have tried to make it as independent as possible from the
> > > openvon peer2peer version as possible. That's why I have
> > > used my own little protocol for handshaking and allocating
> > > a new UDP-port.
> > >
> > > If you are intrested in giving it a try I can mail the source
> > > for you.
> > >
> > > It still uses an old openvpn version but it should not
> > > be very difficult to merge with a newer version, haven't
> > > just got the time for that.
> > >
> > >
> > > Let me know if you wan't a tar-bal to try it out.
> > >
> > > Sampo
> > >
> > > > Hi,
> > > >
> > > > I am interested to know what is the update/status one above.
> > > > I see email thread  as:
> > > >
> > > > Hi Sampo,
> > > >
> > > >                                   > I have been busy writing a forking
server
> > > >                                   > addon to openvpn.
> > > >
> > > >                                   Cool... Does each potential connecting
> > client need a separate config file,
> > > >                                   or does the server use a common client
> > template and then keep track of
> > > >                                   things like dynamic ports, dynamic
> > endpoint addresses, etc?
> > > >
> > > >                                   > In openvpn.c I have separated the
> > processing of
> > > >                                   > parameters from main() to a new
> > function and
> > > >                                   > moved main to another file to
allow me to
> > > >                                   > link against different main()
functions.
> > > >                                   >
> > > >                                   > One that implements normal
peer2peer vpn
> > > >                                   > and two others that produces forkin'
> > server
> > > >                                   > and client.
> > > >                                   >
> > > >                                   > These use a simple UDP protocol to
agree a
> > > >                                   > port to use, after which server
forks do
> > > >                                   > some handshaking with client and then
> > > >                                   > calls openvpn() funcition from
openvpn.c
> > > >
> > > >                                   Are you sure there needs to be a new
> > protocol to do this?
> > > >
> > > >                                   Suppose the master server listens on a
> > particular port, reads the initial
> > > >                                   datagram from a connecting client,
> > verifies the integrity of the datagram
> > > >                                   using a --tls-auth variant, allocates a
> > dynamic port, forks a new server
> > > >                                   process, and continues in its event
loop.
> > > >
> > > >                                   When the forked process finishes up the
> > TLS authentication, it can take the
> > > >                                   Common Name from the client certificate
> > and use it to determine the
> > > >                                   appropriate config profile to use
> > (containing ifconfig addresses, route
> > > >                                   statements, etc.)
> > > >
> > > >                                   Or the handshaking could be done by
> > passing a configuration string in the
> > > >                                   TLS payload, similar to the string now
> > built by options_string().
> > > >
> > > >                                   > This way I have been able to keep
> > > >                                   > those well tested procedures and
protocol
> > > >                                   > of openvpn untouched.
> > > >                                   >
> > > >                                   > I still have some questions
unsolved like
> > > >                                   > DoS protection, dropping root
priviledges
> > > >                                   > and how to handel SIGUSR1 and SIGHUP.
> > > >
> > > >                                   Maybe keep track of all children, so
> > when the master process gets a signal,
> > > >                                   it dispatches it to each child process,
> > then to itself.
> > > >
> > > >                                   > I hope I can overcome these and mail
> > > >                                   > you a patch.
> > > >                                   >
> > > >                                   >
> > > >                                   >
> > > >                                   >
> > > >                                   > Sampo
> > > >                                   >
> > > >                                   >
> > > >                                   >
> > > >                                   > > Hi Michael,
> > > >                                   > >
> > > >                                   > > Right now OpenVPN doesn't support a
> > forking-server model on a single
> > > >                                   port,
> > > >                                   > > it's strictly peer-to-peer with an
> > OpenVPN process instantiated at both
> > > >                                   ends
> > > >                                   > > of the connection, and each
> > connection on a unique port.
> > > >                                   > >
> > > >                                   > > There has been some recent
> > discussions about a forking-server
> > > >                                   implementation
> > > >                                   > > on this list -- see the "add a
> > server feature to openvpn to share udp
> > > >                                   > > ports?" thread in the openvpn-devel
> > archives.
> > > >                                   > >
> > > >                                   > > I think the simplest way to do this
> > would be something like:
> > > >                                   > >
> > > >                                   > > (1) Add a --forking-server flag that
> > causes the main OpenVPN event loop
> > > >                                   to
> > > >                                   > > fork a new process for each initial
> > datagram received from a client.
> > > >                                   > > (2) The newly forked server process
> > switches to a dynamic port before
> > > >                                   > > responding back to the connecting
> > client.  This is quite a bit simpler
> > > >                                   and
> > > >                                   > > more efficient than trying to run
> > all clients over the same UDP port.
> > > >                                   > > (3) OpenVPN already has code (see
> > the implementation of --float) that
> > > >                                   will
> > > >                                   > > adapt to the new port number
> > returned by the response to initial
> > > >                                   datagram
> > > >                                   > > sent from server to client.  I have
> > also confirmed that this type of UDP
> > > >                                   > > port switch is recognized by both
> > Linux and Cisco stateful firewalls.
> > > >                                   > >
> > > >                                   > > There are a some complications that
> > would need to be handled:
> > > >                                   > >
> > > >                                   > > (1) You would need to protect
> > against DoS attacks that flood the server
> > > >                                   with
> > > >                                   > > fork requests.  Possibly some
> > variation of --tls-auth that would
> > > >                                   > > authenticate the initial packet
> > before the fork call.
> > > >                                   > >
> > > >                                   > > (2) If a client connects, gets
> > disconnected, then connects again, you
> > > >                                   would
> > > >                                   > > need to make sure that the old
> > server process gets killed before a new
> > > >                                   > > server process is forked.
> > > >                                   > >
> > > >                                   > > Unfortunately I'm pretty busy right
> > now with my day job, so I may not
> > > >                                   get to
> > > >                                   > > this for a while.  If you want to
> > take a shot at some kind of
> > > >                                   > > implementation, I will do my best to
> > answer your questions.
> > > >                                   > >
> > > >                                   > > Best Regards,
> > > >                                   > > James
> > > >                                   > >
> > > >                                   > > ----- Original Message -----
> > > >                                   > > From: "Michael Grigoriev"
<mag@...58...>
> > > >                                   > > To: <openvpn-devel@...59...>
> > > >                                   > > Sent: Monday, July 22, 2002 6:53 PM
> > > >                                   > > Subject: [Openvpn-devel] Multiple
> > VPN connections on the same port
> > > >                                   > >
> > > >
> > > > __________________________________________________________________
> > > > The NEW Netscape 7.0 browser is now available. Upgrade now!
> > http://channels.netscape.com/ns/browsers/download.jsp
> > > >
> > > > Get your own FREE, personal Netscape Mail account today at
> > http://webmail.netscape.com/
> > > >
> > > >
> > > > -------------------------------------------------------
> > > > This sf.net email is sponsored by:
> > > > With Great Power, Comes Great Responsibility
> > > > Learn to use your power at OSDN's High Performance Computing Channel
> > > > http://hpc.devchannel.org/
> > > > _______________________________________________
> > > > Openvpn-devel mailing list
> > > > Openvpn-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> > > >
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
> >
> 



-- 




