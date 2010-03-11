Date: Thu, 11 Mar 2010 09:04:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100311080423.GH25238@...1296...>
References: <4B9515FF.6000704@...41...>
	<20100308174321.GA25238@...1296...>
	<4B966A98.4000206@...41...> <hn97qa$8l0$1@...1312...>
Mime-Version: 1.0
In-Reply-To: <hn97qa$8l0$1@...1312...>
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
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
To: Timothy Baldwin <T.E.Baldwin99@...1053...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Wed, Mar 10, 2010 at 10:52:00PM +0000, Timothy Baldwin wrote:
> James Yonan wrote:
> 
> > Implementing a DHCP client within OpenVPN tends to make this a more
> > self-contained problem.
> 
> But what about IPv6, tunnels and DHCP prefix delegation? 

IPv6 is a separate issue.  The current IPv6 payload patch supports 
"IPv6 ifconfig pool" and ccd/-based static IPv6 assignment on the server
side (pushing "ifconfig-ipv6" to the client), or static configuration 
on client and server side.

The configuration of IPv6 on the interface is done with the distribution-
specific methods (ifconfig, ip -6 addr, netsh, ...)

IPv6 prefix delegation is something OpenVPN currently doesn't do at all -
neither with a server-based configuration, nor with DHCP PD.

For TAP interfaces (what this discussion was about for IPv4), DHCP PD
could be made to work without assistance from OpenVPN - because OpenVPN
only sees ethernet frames anyway.  For TUN interfaces, OpenVPN would need
to understand DHCP PD and act as a DHCP relay router - otherwise, OpenVPN
wouldn't know how to install the necessary iroute6 towards the client
that has been delegated a prefix.  But this is all "future plans" - first,
get the current IPv6 payload stuff tested well enough that it can get
integrated in the next beta :-)

> Invoking the distribution auto-configuration/ scripts makes more sense.

It doesn't.  For the same reasons as with IPv4.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

