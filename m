From: Neil Brown <neilb@...253...>
MIME-Version: 1.0
Message-ID: <17057.37958.521555.388927@...253...>
Subject: Re: [Openvpn-devel] Google summer of code
In-Reply-To: message from Daniel Lehmann on Saturday June 4
References: <42A1824B.8010106@...277...>
	<200506041313.28415.ov_devel@...300...>
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
Date: Sat Jun  4 04:46:09 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Daniel Lehmann <ov_devel@...300...>
Cc: openvpn-devel@lists.sourceforge.net

On Saturday June 4, ov_devel@...300... wrote:
> 
> I think, a real tun driver for Windows is a killer feature. This would make 
> large heterogenous VPN setups much easier, because you could provide your 
> clients a layer-3 VPN without "losing" 2 addresses per client.
> 

A "real" tun driver (by which I assume you mean one that support
point-to-point addressing) isn't needed to avoid "losing" 2 addresses
per client.
What is needed is for openvpn to understand that a multi-client
configuration is much more like a subnet than like a bunch of
point-to-point links.

I had a patch about 12 months ago that did that using a command
   devtype subnet
which James didn't like (or maybe, he felt cautious about it and I
didn't have the time to push it then).

The idea is that instead of treating every interface as a
point-to-point interface, with 2 addresses (one of which is wasted),
you assign a subnet to the VPN and each interface has an address on
that subnet.

The main change to the OpenVPN protocol is that when "ifconfig" is
"pushed" to the client, it pushes an address and a subnetmask, instead
of two addresses.  (It already does this for dev==tap, so it isn't a
big deal).

"tun" devices on Linux (or other unixes) are point-to-point and don't
have a subnet mask, but that isn't a big deal at all.  To make it
work, set the remote address to anything in the subnet (it really
doesn't matter what) and create a route to the subnet, with an
appropriate subnet mask, which has the remote end of the pointopoint
as the destination.  It then all simply works.

I can resurrect that patch if anyone is interested.


See http://openvpn.net/archive/openvpn-devel/2004-07/msg00056.html and
related messages.

NeilBrown


