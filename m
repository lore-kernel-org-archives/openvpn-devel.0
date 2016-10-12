MIME-Version: 1.0
In-Reply-To: <026a4dab-8aac-7edb-4f58-4fbacfe56795@...1227...>
References: <20160916161354.GM78279@...1296...>
	<1476263591-12401-1-git-send-email-arne@...1227...>
	<CAEsd45Tkkmbp=qbgVZxAt-U3hkLBQemOxDGRjTucLCoJPM+bTg@...278...>
	<026a4dab-8aac-7edb-4f58-4fbacfe56795@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 12 Oct 2016 08:53:02 -0400
Message-ID: <CAEsd45QhH3=xo-0A3QZe0eqp4gBM7T9WOvJ0Bu4+GFKJbRrtUg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thanks, Arne. Sorry if I wasn't a clear as I should have been.

On Wed, Oct 12, 2016 at 8:08 AM, Arne Schwabe <arne@...1227...> wrote:
>
> Am 12.10.16 um 13:17 schrieb Jonathan K. Bullard:
> > Hi.
> >
> > On Wed, Oct 12, 2016 at 5:13 AM, Arne Schwabe <arne@...1227...> wrote:
> >> This option was useful when Ipv6 tun support was
> >> non standard and was an internal/user specified flag
> >> that tracked the Ipv6 capability of the tun device.
> >>
> >> All supported OS support IPv6. Also tun-ipv6 is
> >> pushable by the remote so not putting tun-ipv6
> >> does not forbid ipv6 addresses.
> > How will this patch affect a VPN on a system that has IPv6 disabled?
> >
> >
> Short version: Fail as miserable as before.

Connections don't fail in the situation I describe (IPv6 disabled at
the OS level). At least not when there are no IPv6 options enabled in
the OpenVPN configuration or pushed from the server, which is the
setup that many VPN service providers use.


> You might think that leaving out tun-ipv6 might fix your
> problem but tun-ipv6 is a pushable option and the server-ipv6 macro will
> push it, so you end up with tun-ipv6 without having it in the client config.

The problem was not that the server was pushing tun-ipv6 (the
configurations and server pushes did not have any IPv6 references).
The problem was that the OS prefers IPv6 over IPv4 when both were
available. So the OS was sending out IPv6 packets, which caused
information leakage. The solution was not leaving out the tun-ipv6
option, but disabling IPv6 in the OS.

What I should have asked is: with this patch will an OpenVPN client
still send out IPv4 packets if there are no IPv6 options specified or
pulled from the server?

If yes, the connection will succeed. If no, then disabling IPv6 in the
OS will cause failed connections. (Unless with IPv6 disabled the OS
translates IPv6 packets to IPv4 and sends them, which seems unlikely
to me.)

