Message-ID: <057d01c23286$4c391110$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <Pine.LNX.4.33.0207231816150.5299-100000@...23...>
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
Date: Tue Jul 23 13:19:06 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: sampo.nurmentaus@...22...
Cc: openvpn-devel@lists.sourceforge.net

> > Hi Sampo,
> >
> > > I have been busy writing a forking server
> > > addon to openvpn.

Will forking server only work for TLS mode?

> >
> > Cool... Does each potential connecting client need a separate config
file,
> > or does the server use a common client template and then keep track of
> > things like dynamic ports, dynamic endpoint addresses, etc?
>
> No they don't. I just use normal config files/command line and use
> --remote as server addres in the client.
>
> I just got it running. Still with out dynamic ip address assigment
> and proper signal handling in parent process. And there ain't
> anykind of DoS protection yet.

One way to do DoS protection would be to augment --tls-auth with persistent
anti-replay protection by saving the Session ID (struct session_id) and
reject any Session ID that was seen before.

>
> Lack of dynamic addresses still limits it to a single connection
> but a pool of addresses should not be too hard to implement.
>
> There are also need for a few new options like the range
> of ports/addresses used.
>
> Ofcourse there should also be an ability to define
> addresses to each client. I haven't decided how to
> do that yet.
>
>
>
> > > In openvpn.c I have separated the processing of
> > > parameters from main() to a new function and
> > > moved main to another file to allow me to
> > > link against different main() functions.
> > >
> > > One that implements normal peer2peer vpn
> > > and two others that produces forkin' server
> > > and client.
> > >
> > > These use a simple UDP protocol to agree a
> > > port to use, after which server forks do
> > > some handshaking with client and then
> > > calls openvpn() funcition from openvpn.c
> >
> > Are you sure there needs to be a new protocol to do this?
>
>
> No, I am not. But found it easy to implement in this manner.
>
> > Suppose the master server listens on a particular port, reads the
initial
> > datagram from a connecting client, verifies the integrity of the
datagram
> > using a --tls-auth variant, allocates a dynamic port, forks a new server
> > process, and continues in its event loop.
>
> It really sounds reasonable. I also though of some kind
> of message authentication before fork.  --tls-auth
> sounds good since it is quite light-weight.
>
> > When the forked process finishes up the TLS authentication, it can take
the
> > Common Name from the client certificate and use it to determine the
> > appropriate config profile to use (containing ifconfig addresses, route
> > statements, etc.)
> >
> > Or the handshaking could be done by passing a configuration string in
the
> > TLS payload, similar to the string now built by options_string().
>
> At the moment I do some handshaking in dynamically allocated
> port before calling openvpn(). Mayby I could add the exchange of
> address info here, since I don't think it needs to be
> transferred over a secure channel.

Actually the temporary keys + options_string() get passed over the secure
TLS channel, so you could add further handshaking options and they would be
secure.

>
> > > This way I have been able to keep
> > > those well tested procedures and protocol
> > > of openvpn untouched.
> > >
> > > I still have some questions unsolved like
> > > DoS protection, dropping root priviledges
> > > and how to handel SIGUSR1 and SIGHUP.

It would be cool if we could get the forking server to work with dropping
root privs.

One of the goals of dropping privs is that no datagram is ever read from the
network with root privs.

It would be great if we could preserve this behavior.

Otherwise the split privileges model of the new openssh would be a
possibility, but it's more complex.

> >
> > Maybe keep track of all children, so when the master process gets a
signal,
> > it dispatches it to each child process, then to itself.
>
> Sounds good to me. I am going to keep track of childs anyway
> to maintain address/port pool.
>
>
> Trying to explain things to someone,
> amazingly helps to figure out those things for one self!
> I got a bunch of new ideas while writing this.
>
>
> Got to go home now or I will sit coding here until
> midnight :-)
>
>
>
> Sampo
>

James



