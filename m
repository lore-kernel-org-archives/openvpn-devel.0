MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <7855235.EvfmKnZP6h@...1526...>
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...> <7855235.EvfmKnZP6h@...1526...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Wed, 29 Feb 2012 15:07:01 +0100
Message-ID: <CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Heiko,

Am 29. Februar 2012 13:18 schrieb Heiko Hund <heiko.hund@...1489...>:
> [...] There will be a new service, I called it
> interactive service. The GUI/client connects to a named pipe of that service.
> It passes the working directory, command line options and stdin input for
> openpvn to the service. The service impersonates the client, creates another
> named pipe and starts openvpn. Besides the stuff from the GUI it also passes
> to client end of the created pipe to openvpn. The GUI may now connect the the
> management interface. If openvpn needs to perform a privileged operation it
> request it through the named pipe that was passed by the interactive service.
> There's only a limited and well defined set of privileged operations that are
> serviced through the pipe. Currently only setting of IPv4 and IPv6 routes, but
> that will be extended to whatever makes sense e.g. ARP table flush is the next
> thing that will come.

Let's see whether I understood the design. After initial setup, the
GUI has a connection via the mgmt interface to OpenVPN and OpenVPN has
a connection via the "privilege interface" to the "interactive
service". OpenVPN basically runs in the same context as the GUI, i.e.
without permission to change the network configuration (change routes,
etc.). The "interactive service" runs in a context with permissions to
change the network configuration. Any privileged operations are
requested by OpenVPN via the "privilege interface" and performed by
the "interactive service". (There must be something missing, otherwise
I don't get why you call it "interactive service" ...?)

Why does the "interactive service" need to start OpenVPN? Why not let
the GUI start OpenVPN and let OpenVPN connect to the "interactive
service"? OTOH, if you're going to start OpenVPN as a service anyway,
it probably doesn't really make much of a difference. Although this
could mean that you can keep the GUI-facing side of OpenVPN identical
to what it is now... the "interactive service" would just be an
implementation detail of how openvpn performs its privileged
operations.

Does creating a tun/tap device belong to the operations that need
special privileges under windows? If so, this sounds a lot like an
interface that might also allow splitting off most of the system
specific code ... as in, this could also work on Android, no?

Cheers
Fabian

