From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] TCP-over-TCP (was: Multi-channel VPN)
Message-ID: <20030423083854.GB4080@...33...>
References: <20030422191429.GD9395@...33...> <200304230114.h3N1Eh112247@...41...>
Mime-Version: 1.0
In-Reply-To: <200304230114.h3N1Eh112247@...41...>
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
Date: Wed Apr 23 01:40:09 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 23 Apr 2003, James Yonan wrote:

> I wonder if one could build a better tcp-over-tcp by doing some intelligent
> packet filtering on the higher level tcp connection, such as filtering out
> retransmits and fudging return ACKs -- essentially removing those elements of
> the TCP protocol which are designed to make TCP work over an unreliable link.

I wonder if that's necessary. Tunnelling through TCP is inherently
reliable no matter what you send, so TCP-nested-in-TCP is just overkill.
Cheating the OS doesn't help. Maybe some LD_PRELOAD library that turns
stream sockets into dgram sockets for connections that use the tunnel is
sufficient. However, this doesn't actually apply to openvpn because
openvpn does TCP-over-UDP.

-- 
Matthias Andree

