From: Neil Brown <neilb@...253...>
MIME-Version: 1.0
Message-ID: <17058.12751.717811.713051@...253...>
Subject: Re: [Openvpn-devel] Google summer of code
In-Reply-To: message from James Yonan on Saturday June 4
References: <42A1824B.8010106@...277...>
	<200506041313.28415.ov_devel@...300...>
	<17057.37958.521555.388927@...253...>
	<Pine.LNX.4.58.0506041241180.16160@...41...>
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
Date: Sat Jun  4 15:58:26 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Daniel Lehmann <ov_devel@...300...>, openvpn-devel@lists.sourceforge.net

On Saturday June 4, jim@...41... wrote:
> 
> On Sat, 4 Jun 2005, Neil Brown wrote:
> > A "real" tun driver (by which I assume you mean one that support
> > point-to-point addressing) isn't needed to avoid "losing" 2 addresses
> > per client.
> > What is needed is for openvpn to understand that a multi-client
> > configuration is much more like a subnet than like a bunch of
> > point-to-point links.
> 
> Right, but isn't that the point of supporting either tun or tap -- so that
> people can choose which model (point-to-point or network/netmask) they 
> prefer?

That wasn't the impression I got.
I thought the point of supporting either tun or tap was so that people
could choose between layer-3 (only IP) or layer-2 (any ethernet based
protocol).
I choose layer-3 (tun) because I only want IP, and because OpenVPN will
verify the source IP address for packets arriving from clients.  I
value that.

To me, the difference between choosing point-to-point or
network/netmask is related to how may instances you have
communicating.

If you have just two (traditional "--mode p2p" at both ends) then
point-to-point makes perfect sense whether using tun or tap.
If you have more, then it seems that network/netmask makes much more
sense.  (I wouldn't say that no-one in their right mind would use ptp,
only that n/n would be the dominant usage).

> 
> > I had a patch about 12 months ago that did that using a command
> >    devtype subnet
> > which James didn't like (or maybe, he felt cautious about it and I
> > didn't have the time to push it then).
> 
> I did comment on that patch at the time -- I'm assuming that you're 
> referring to the patch which would set a tun interface with 
> network/netmask rather than point-to-point parameters?

The patch did a little more than that, but yes.  Your comment was that
it would add yet another set of cases that would need testing.   As I
wasn't doing the testing, it was hard to argue with this.

> 
> It seems to me that setting a tun interface with a network/netmask is 
> functionally equivalent to setting point-to-point semantics then adding a 
> route -- which is exactly what the current code does.
> 
> The advantage of the current approach is that it works on all platforms
> because it doesn't require that the tun driver support a netmask
> parameter.

No disagreement here.

> 
> We also now have the --ifconfig-pool-linear option which comes close to
> constructing a tun-based VPN with network/netmask semantics, for the most
> part hiding the point-to-point semantics of the component tun
> interfaces.

Yep.... only:
              NOTE:  This option is incompatible with Windows clients.
which makes it somewhat irrelevant in an heterogeneous network.

> 
> > The idea is that instead of treating every interface as a
> > point-to-point interface, with 2 addresses (one of which is wasted),
> > you assign a subnet to the VPN and each interface has an address on
> > that subnet.
> 
> --ifconfig-pool-linear doesn't waste any addresses.
but isn't currently relevant. :-(
> 
> > The main change to the OpenVPN protocol is that when "ifconfig" is
> > "pushed" to the client, it pushes an address and a subnetmask, instead
> > of two addresses.  (It already does this for dev==tap, so it isn't a
> > big deal).

This is my key point.  The client needs to be told the subnet mask.
As you suggest, this can be done by pushing a route. 
So how about this:
   In WIN32, instead of requiring that the two ifconfig addresses
   be part of a .252 subnet (verify_255_255_255_252), you also allow
   them if they are both in the network/netmask of some route which
   has been requested (or pulled) and has the second address as the
   'gateway'.    The netmask of this route then becomes the netmask of
   the interface.

You could then come up with a modification of the --server directive
which used --ifconfig-pool-linear and pushed the appropriate route.
This would, I think, provide exactly what is desired.

NeilBrown

