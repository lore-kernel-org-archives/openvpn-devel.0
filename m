From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Google summer of code
In-Reply-To: <17059.38652.752241.266113@...253...>
Message-ID: <Pine.LNX.4.58.0506051833460.16160@...41...>
References: <42A1824B.8010106@...277...> <200506041313.28415.ov_devel@...300...>
 <17057.37958.521555.388927@...253...> <Pine.LNX.4.58.0506041241180.16160@...41...>
 <17058.12751.717811.713051@...253...> <Pine.LNX.4.58.0506051459060.16160@...41...>
 <17059.38652.752241.266113@...253...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Jun  6 01:06:18 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Neil Brown <neilb@...253...>
Cc: Daniel Lehmann <ov_devel@...300...>, openvpn-devel@lists.sourceforge.net

On Mon, 6 Jun 2005, Neil Brown wrote:

> On Sunday June 5, jim@...41... wrote:
> > 
> > I don't think it's possible for the current TAP-Win32 driver to do OSI 
> > Layer 3 with a network/netmask setting.  This gets back to the same reason 
> > why --ifconfig-pool-linear doesn't work on Windows:  The TAP-Win32 driver 
> > is a TAP driver from the perspective of the kernel.  The point-to-point 
> > Layer 3 capability is provided by glue code in the driver which makes a 
> > /30 subnet appear to be two point-to-point endpoints.  But it doesn't 
> > change the fact that the driver is a TAP driver and will be treated as an 
> > 802.3 network interface by the Windows kernel.
> > 
> > This means that if you set your TAP driver properties to 192.168.0.0/24 
> > and you try to ping 192.168.0.66, the network stack will send out an ARP 
> > to find out the MAC address of 192.168.0.66, because we are operating on 
> > OSI Layer 2.  While, you might say, why not answer the ARP virtually, so 
> > that point-to-point Layer 3 semantics are operating under the hood.  Well 
> > that's exactly what the tun emulation mode in the current TAP-Win32 driver 
> > does.  And this is where the /30 subnet limitation comes from.
> 
> Why is there a /30 limitation?
> I cannot see that a /24 subnet could not work just as easily.
> 
> I see from tapdrvr.c that currently the auto-arp-response will only
> respond to arp requests for one particular address.  But I cannot see
> why it couldn't trivially be changed to work for any address.
> i.e. if an arp request appears on the interface for any address (other
> than the address of the interface), then respond with a reply giving
> the same virtual MAC address.
> Surely with would allow the TAP-Win32 driver to act line a tun driver
> with a subnet mask.
> 
> And this is, in my mind, the goal.  
> I don't want the TAP-Win32 drive to act like a true point-to-point
> interface (I can see that that is non-trivial).  I just want win32 to
> have a tun-like interface onto a subnet.  That subnet being the subnet
> that OpenVPN is managing.

I think it's an interesting idea -- essentially you would be implementing
proxy ARP in the TAP driver over the entire VPN subnet. It's not true
point-to-point semantics, but if the VPN subnet is well contained, it
comes closer than the current approach and doesn't suffer from the IP
address lossage that comes from using one /30 subnet per client.

James

