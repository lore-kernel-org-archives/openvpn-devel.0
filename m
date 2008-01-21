Message-ID: <66d0f4170801211029h1a94f0bbgfd494e94354906cb@...278...>
Date: Mon, 21 Jan 2008 19:29:02 +0100
From: triton <silentmove@...277...>
In-Reply-To: <479474C2.5090308@...1028...>
MIME-Version: 1.0
References: <93661e2e0710270421s36c345b4o8b3b94a95b4ed0e6@...278...>
	<479474C2.5090308@...1028...>
Subject: Re: [Openvpn-devel] multi-homed udp-based OpenVPN Server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

> > > we tried to use OpenVPN Server on two-nic (both are internet-connected)
> > > server.
> > > udp packets always go out on default gateway, even if they came from
> > > another nic.

> In the meantime, i thought about using --float on the clients. This should
> work.

I run in the same situation and tried to work around the problem by
using the "local" configuration option in order to force the OpenVPN
process to bind on each outgoing interface instead of the default
wildcard bind.

This way, OpenVPN UDP packets are replied on the interface they came
from. Unfortunately, for two outgoing interfaces this means having two
separate OpenVPN instances running.
If your requirement is just high availability rather than load
balancing, combining the mentioned setup with heartbeat works just
fine.

However, i was not able to SNAT outgoing connections to their
respective interface address by using iproute/iptables and connection
marks. But the trick using a dummy interface and bind OpenVPN to it
like Till Maas suggested looks promising.

regards,
Robert

