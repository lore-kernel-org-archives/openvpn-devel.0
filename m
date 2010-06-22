Message-ID: <20100622230327.11872.qmail@...1287...>
Date: Wed, 23 Jun 2010 01:03:27 +0200
From: Peter Stuge <peter@...1287...>
References: <AANLkTikEA95y8ojAyWAJoJmYbt_MZBT23dbi-IyAUa0Y@...278...>
	<4C20D014.7050802@...1147...>
MIME-Version: 1.0
In-Reply-To: <4C20D014.7050802@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Is it possible to
	access	Windows XP shares over port 445?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

Jan Just Keijser wrote:
> > So XP is refusing port 445 connections from OpenVPN adapter.
> 
> Maybe someone on the -devel list (CC'ed) knows more about the
> interaction between the tap-win32 adapter and the rest of the
> windows os?

This reminds me of my experience with pushing a DNS server address
as part of the VPN connection.

I was using a configuration where traffic to the DNS server always
needed to be routed. It was not directly reachable on any client
interface.

After the DHCP client for e.g. a LAN or wifi connection in Windows
has been configured with a DNS server, the DNS resolver would bind
to the underlying interface that was configured by DHCP.

Even if the OpenVPN server pushes another DNS server setting which is
applied to the system when bringing up the TAP adapter, the DNS
resolver was still "bound" to the underlying interface and DNS
lookups would now fail. (The new IP was firewalled to only be
reachable via VPN.)

(My solution was to make the DNS server always be on the same IP
network as the underlying interface.)

This seems to have nothing to do with incoming port 445 traffic, but
maybe something similar is going wrong?

You could try to stop and then start the service responsible for
listening on that port. I'm not quite sure which one it is though.

Stopping and starting the DNS resolver helped in my situation, but
wasn't an adequate fix.

At least it might provide you with some more information.


Kind regards

//Peter

