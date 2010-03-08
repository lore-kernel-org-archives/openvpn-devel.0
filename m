Message-ID: <20100308165048.19002.qmail@...1287...>
Date: Mon, 8 Mar 2010 17:50:48 +0100
From: Peter Stuge <peter@...1287...>
References: <4B9515FF.6000704@...41...> <1268064888.17518.1@...1207...>
MIME-Version: 1.0
In-Reply-To: <1268064888.17518.1@...1207...>
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
To: openvpn-devel@lists.sourceforge.net

Karl O. Pinc wrote:
> > I'm hoping that we can make "route-gateway dhcp" work on Unix
> > platforms as well.  I'm thinking there are two possible ways we
> > could do this:

Network interface configuration is highly distribution specific.


> A) dhclient
> 
> B) dhclient.conf
> 
> C) dhclient
> 
> D) dhcptl or omapi or .. omshell
..
> This would be tied to the ISC implementation, but probably nobody
> cares.

I know of at least four DHCP clients and I avoid dhclient as much as
possible. It would be a tremendous mistake to tie OpenVPN to any one
DHCP client IMO.


What most if not all distributions have in common, or could have in
common, is that a script configures the network interface. Sometimes
it's called ifup, other times it's /etc/init.d/net.tap0, yet other
times it's something else.

I suggest instead relying on a generic configuration script to do
interface configuration when the VPN comes up.

I believe that's actually what most distributions do already.


//Peter

