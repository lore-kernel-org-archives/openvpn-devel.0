From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20030422191429.GD9395@...33...>
References: <200304180553.h3I5r7106802@...41...> <Pine.LNX.4.50.0304191852180.26901-100000@...48...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.50.0304191852180.26901-100000@...48...>
Subject: [Openvpn-devel] TCP-over-TCP (was: Multi-channel VPN)
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
Date: Tue Apr 22 12:15:45 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sat, 19 Apr 2003, Aaron Sethman wrote:

> I'm not necessarly sure it belongs in OpenVPN, but then again, I can see
> the advantages to automatically failover to other links.  Perhaps
> abstracting things out in the code a bit that it would be possible to have
> multiple methods of sending data out to the world, perhaps even non-ip
> methods.  Or even implementing something as tunnelling over TCP(I do know
> the reasons why you don't want to do this, but in some cases you don't
> have a choice, and are willing to eat the performance loss).

TCP-over-TCP tunnelling isn't necessarily a performance loss, but it
also exhibits excessive retransmit behaviour -- which isn't too bad if
you have congested links and need to take a bigger share than the others
;-) I've always found vpnd (tcp-over-tcp) to be more stable than vtund
(over udp in my configurations) across congested links, but I haven't
compared vpnd to openvpn. (And I've found vtund to be fragile, a single
ping -f into a tunnel usually let the tunnel collapse on Linux. OpenVPN
is solid in these circumstances.)

-- 
Matthias Andree

