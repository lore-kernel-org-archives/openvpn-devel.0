From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Fwd: RE: Multi-channel VPN
Message-ID: <20030418230543.GA31754@...33...>
References: <200304180553.h3I5r7106802@...41...>
Mime-Version: 1.0
In-Reply-To: <200304180553.h3I5r7106802@...41...>
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
Date: Fri Apr 18 16:06:07 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, 18 Apr 2003, James Yonan wrote:

> I'm forwarding this discussion of an interesting feature request.  Namely,
> could (and should) OpenVPN have a channel bonding capability, where more than
> one UDP connection over different paths is used to connect two peers, and
> OpenVPN does channel bonding, load balancing, and failover among the
> connections?  Or does this function not belong in OpenVPN since it is
> functionally distinct from the role of network security and tunneling and
> could be implemented as a module or driver apart from OpenVPN?

I wouldn't add multilink capabilities into OpenVPN itself unless it will
see a major improvement in security compared to bonding several OpenVPN
connections, and I'd rather see it separately. I could imagine OpenVPN
using a virtual device that has this multilink capability with failure
resilience, or I could imagine such multilink software operating several
OpenVPN tunnels. Either would likely be adequate. It gets simple if this
(de)multiplexer looked like a regular network interface to other
applications.

