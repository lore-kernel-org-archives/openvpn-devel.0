From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] Fwd: RE: Multi-channel VPN
Message-ID: <20030418170704.GB1112@...30...>
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
Date: Sun Apr 20 02:24:11 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, Apr 18, 2003 at 05:53:07AM -0000, James Yonan wrote:
> I'm forwarding this discussion of an interesting feature request.  Namely,
> could (and should) OpenVPN have a channel bonding capability, where more than
> one UDP connection over different paths is used to connect two peers, and
> OpenVPN does channel bonding, load balancing, and failover among the
> connections?  Or does this function not belong in OpenVPN since it is
> functionally distinct from the role of network security and tunneling and
> could be implemented as a module or driver apart from OpenVPN?
> 


Hi all,

IMHO this feature would be out of OpenVPN's scope, just as QoS or
firewalling are. It'd add (talking from my ignorant-and-no-developer
point of view) lots of complexity, and we know complexity and bugs
travel in the same ship :)
This can be achieved in both Linux and FreeBSD, it's not easy but it's
possible.
Let each tool do its job, and only that.



-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@(agi.as|debian.org)        | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

