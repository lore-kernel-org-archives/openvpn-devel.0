From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] Fwd: RE: Multi-channel VPN
In-Reply-To: <200304180553.h3I5r7106802@...41...>
Message-ID: <Pine.LNX.4.50.0304191852180.26901-100000@...48...>
References: <200304180553.h3I5r7106802@...41...>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Apr 19 15:59:03 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 18 Apr 2003, James Yonan wrote:

> I'm forwarding this discussion of an interesting feature request.  Namely,
> could (and should) OpenVPN have a channel bonding capability, where more than
> one UDP connection over different paths is used to connect two peers, and
> OpenVPN does channel bonding, load balancing, and failover among the
> connections?  Or does this function not belong in OpenVPN since it is
> functionally distinct from the role of network security and tunneling and
> could be implemented as a module or driver apart from OpenVPN?

I'm not necessarly sure it belongs in OpenVPN, but then again, I can see
the advantages to automatically failover to other links.  Perhaps
abstracting things out in the code a bit that it would be possible to have
multiple methods of sending data out to the world, perhaps even non-ip
methods.  Or even implementing something as tunnelling over TCP(I do know
the reasons why you don't want to do this, but in some cases you don't
have a choice, and are willing to eat the performance loss).

Regards,

Aaron

