From: "James Yonan" <jim@...41...>
Message-ID: <twig.1067463490.56118@...41...>
In-Reply-To: <1067453558.12713.238.camel@...125...>
Subject: [Openvpn-devel] Re: OpenVPN --resolv-retry and --chroot problem
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
Date: Wed Oct 29 13:39:11 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Teemu Kiviniemi <teemuki@...124...>, openvpn-devel@lists.sourceforge.net
Cc: James Yonan <jim@...41...>

Teemu Kiviniemi <teemuki@...124...> said:

> Hi,
> 
> OpenVPN 1.5beta12 and the CVS version have a problem when --resolv-retry
> and --chroot are used at the same time. In chroot environment,
> gethostbyname() can't resolve the remote IP address:
> 
> Wed Oct 29 17:19:17 2003 13: RESOLVE: Cannot resolve host address:
> somehost.somedomain: [unknown h_errno value]
> 
> This problem occurs with Debian Woody. I think it's related to the Glibc
> dynamic loader. If the name resolver libraries aren't loaded before
> OpenVPN enters the chroot jail, OpenVPN can't do any DNS queries. If
> gethostbyname() is run before entering chroot(), the resolver libraries
> are loaded and everything works as it should.
> 
> I changed link_socket_init_phase1() in socket.c to resolve the remote
> host even if resolve_retry_seconds is set. That way, gethostbyname() is
> run before chroot(). I don't know if that's the right way to do it, but
> it fixes the problem for me.
> 
> The patch for 1.5 beta12 and the CVS version is available at:
> http://iki.fi/teemuki/openvpn/openvpn-resolvfix.diff

Teemu,

The DNS name resolution code for --remote is somewhat delicate -- for example,
the phase1 code cannot block because it's called before daemonization.

I would rather see this fix accomplished by adding some kind of dummy call
early on in the initialization sequence to trigger the dynamic load of the DNS
library -- but which doesn't touch the functionality of the current DNS name
resolution code.

James


