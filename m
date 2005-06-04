From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Google summer of code
In-Reply-To: <17057.37958.521555.388927@...253...>
Message-ID: <Pine.LNX.4.58.0506041241180.16160@...41...>
References: <42A1824B.8010106@...277...> <200506041313.28415.ov_devel@...300...>
 <17057.37958.521555.388927@...253...>
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
Date: Sat Jun  4 12:28:09 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Neil Brown <neilb@...253...>
Cc: Daniel Lehmann <ov_devel@...300...>, openvpn-devel@lists.sourceforge.net

On Sat, 4 Jun 2005, Neil Brown wrote:

> On Saturday June 4, ov_devel@...300... wrote:
> > 
> > I think, a real tun driver for Windows is a killer feature. This would make 
> > large heterogenous VPN setups much easier, because you could provide your 
> > clients a layer-3 VPN without "losing" 2 addresses per client.
> > 
> 
> A "real" tun driver (by which I assume you mean one that support
> point-to-point addressing) isn't needed to avoid "losing" 2 addresses
> per client.
> What is needed is for openvpn to understand that a multi-client
> configuration is much more like a subnet than like a bunch of
> point-to-point links.

Right, but isn't that the point of supporting either tun or tap -- so that
people can choose which model (point-to-point or network/netmask) they 
prefer?

> I had a patch about 12 months ago that did that using a command
>    devtype subnet
> which James didn't like (or maybe, he felt cautious about it and I
> didn't have the time to push it then).

I did comment on that patch at the time -- I'm assuming that you're 
referring to the patch which would set a tun interface with 
network/netmask rather than point-to-point parameters?

It seems to me that setting a tun interface with a network/netmask is 
functionally equivalent to setting point-to-point semantics then adding a 
route -- which is exactly what the current code does.

The advantage of the current approach is that it works on all platforms
because it doesn't require that the tun driver support a netmask
parameter.

We also now have the --ifconfig-pool-linear option which comes close to
constructing a tun-based VPN with network/netmask semantics, for the most
part hiding the point-to-point semantics of the component tun interfaces.

> The idea is that instead of treating every interface as a
> point-to-point interface, with 2 addresses (one of which is wasted),
> you assign a subnet to the VPN and each interface has an address on
> that subnet.

--ifconfig-pool-linear doesn't waste any addresses.

> The main change to the OpenVPN protocol is that when "ifconfig" is
> "pushed" to the client, it pushes an address and a subnetmask, instead
> of two addresses.  (It already does this for dev==tap, so it isn't a
> big deal).
> 
> "tun" devices on Linux (or other unixes) are point-to-point and don't
> have a subnet mask, but that isn't a big deal at all.  To make it
> work, set the remote address to anything in the subnet (it really
> doesn't matter what) and create a route to the subnet, with an
> appropriate subnet mask, which has the remote end of the pointopoint
> as the destination.  It then all simply works.

If you want to run a VPN with network/netmask semantics, you can already
do this two ways: use a tap-based interface, or use a tun interface with
--ifconfig-pool-linear and push a route for the subnet.

James


