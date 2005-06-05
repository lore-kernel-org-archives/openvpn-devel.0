From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Google summer of code
In-Reply-To: <17058.12751.717811.713051@...253...>
Message-ID: <Pine.LNX.4.58.0506051459060.16160@...41...>
References: <42A1824B.8010106@...277...> <200506041313.28415.ov_devel@...300...>
 <17057.37958.521555.388927@...253...> <Pine.LNX.4.58.0506041241180.16160@...41...>
 <17058.12751.717811.713051@...253...>
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
Date: Sun Jun  5 14:40:17 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Neil Brown <neilb@...253...>
Cc: Daniel Lehmann <ov_devel@...300...>, openvpn-devel@lists.sourceforge.net

> > > The main change to the OpenVPN protocol is that when "ifconfig" is
> > > "pushed" to the client, it pushes an address and a subnetmask, instead
> > > of two addresses.  (It already does this for dev==tap, so it isn't a
> > > big deal).
> 
> This is my key point.  The client needs to be told the subnet mask.
> As you suggest, this can be done by pushing a route. 
> So how about this:
>    In WIN32, instead of requiring that the two ifconfig addresses
>    be part of a .252 subnet (verify_255_255_255_252), you also allow
>    them if they are both in the network/netmask of some route which
>    has been requested (or pulled) and has the second address as the
>    'gateway'.    The netmask of this route then becomes the netmask of
>    the interface.

I don't think it's possible for the current TAP-Win32 driver to do OSI 
Layer 3 with a network/netmask setting.  This gets back to the same reason 
why --ifconfig-pool-linear doesn't work on Windows:  The TAP-Win32 driver 
is a TAP driver from the perspective of the kernel.  The point-to-point 
Layer 3 capability is provided by glue code in the driver which makes a 
/30 subnet appear to be two point-to-point endpoints.  But it doesn't 
change the fact that the driver is a TAP driver and will be treated as an 
802.3 network interface by the Windows kernel.

This means that if you set your TAP driver properties to 192.168.0.0/24 
and you try to ping 192.168.0.66, the network stack will send out an ARP 
to find out the MAC address of 192.168.0.66, because we are operating on 
OSI Layer 2.  While, you might say, why not answer the ARP virtually, so 
that point-to-point Layer 3 semantics are operating under the hood.  Well 
that's exactly what the tun emulation mode in the current TAP-Win32 driver 
does.  And this is where the /30 subnet limitation comes from.

There was a thread on openvpn-users a while back where the limitation of
the TAP-Win32 driver with respect to true point-to-point usage was
discussed.  Right now it can't do true point-to-point.  The driver model 
itself would need to be changed, so that Windows would view it as a 
connection-oriented WAN device rather than an 802.3 Ethernet device.  
This would be a whole new device driver, it would need to be installed 
separately, and OpenVPN would lose the flexibility of being able to 
ioctl the device to programatically set the tun/tap mode.  Any volunteers?

James


