From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Assertion failed at multi.c:1561
In-Reply-To: <djp9ut$8k5$1@...165...>
Message-ID: <Pine.LNX.4.58.0510271336200.8183@...41...>
References: <djp9ut$8k5$1@...165...>
MIME-Version: 1.0
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
Date: Thu Oct 27 12:54:43 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Gunter Ohrner <G.Ohrner@...484...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 27 Oct 2005, Gunter Ohrner wrote:

> Hi!
> 
> We're experiencing regular assertion failures and subsequent OpenVPN server
> crashes on one of our servers.
> 
> The assertion failure is always the same: 
> 
> ,----
> | Assertion failed at multi.c:1561
> | Exiting
> `----
> 
> The crash seems to leave openvpn's network device, tap0 in our case, in a
> state which blocks all processes subsequently trying to access to device.
> The crashes happen every few days and a restart of the server machine is
> needed.
> 
> Does anyone have any quick idea of this behaviour's cause? Unfortunately
> according to Google we're the only ones on Linux 2.6 with this crash. ;)
> 
> http://openvpn.net/archive/openvpn-users/2005-08/msg00011.html mentions a
> similar problem but running kernel 2.2.25 and no solution has been provided
> so far, a suggested patch did not fix the problem for the reporter.
> 
> ,----[ Some details about our setup ]
> | * Debian Sarge i386
> | * Kernel 2.6.12.6 32 Bit Opteron optimized
> | * Debian's 2.0-1sarge1 openvpn package
> | * Dual Opteron 246 2,0GHz
> `----
> 
> ,----[ OpenVPN configuration (excerpts) ]
> | * bind to single interface/port
> | * use udp
> | * use tap0
> | * PSK authentication
> `----
> 
> The server is also routing traffic and we do traffic limiting for some
> traffic (destination dependant, to comply with a leased link policy). This
> limiting is not done on the device on which the encrypted openvpn traffic
> leaves the machine but on an IMQ device before the incoming traffic enters
> tap0, so openvpn should not see anything from it.
> 
> Are there any further details needed to chase this bug, in whichever kind of 
> software we're using it may be?

This assertion usually occurs when the tun/tap device locks up and doesn't 
accept any write syscalls.

Can you try an earlier 2.6 kernel (or 2.4), and see if the problem goes
away?

I would lean towards thinking that this is a tun/tap driver issue, simply 
because I've never heard about it on anything other than the old 
unmaintained 2.2 driver, or in this case a very new kernel.

But having said that, I can't yet rule out that it's an OpenVPN bug.  I 
could certainly "fix" the assertion by making OpenVPN wait forever for the 
tun/tap device to accept output.  But then OpenVPN would simply hang, and 
you would have even less information to go on.

James


