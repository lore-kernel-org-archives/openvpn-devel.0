Message-ID: <20110312214852.30212.qmail@...1287...>
Date: Sat, 12 Mar 2011 22:48:52 +0100
From: Peter Stuge <peter@...1287...>
References: <20110308185252.301d0a1d@...1451...>
	<20110309084745.GN9835@...1296...>
	<20110309085656.18e0e796@...1451...> <20110311122309.1292c1dd@...1451...>
	<4D7A7455.4070805@...1114...>
	<20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
	<AANLkTikhb8vVs_joR20NEjPyGy=W+4i2rEdVdVrpmYGA@...278...>
MIME-Version: 1.0
In-Reply-To: <AANLkTikhb8vVs_joR20NEjPyGy=W+4i2rEdVdVrpmYGA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
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

Joe Patterson wrote:
> I'm actually kind of curious what reasons there would be that
> listening to 0.0.0.0 would be undesireable.
..
> if you want to have different configurations bound to different
> interfaces,

Exactly.


> while I could possibly see having one configuration for Internet
> users connecting inbound via VPN and maybe internal wireless users
> using a different configuration because they understandably don't
> trust WPA... it's a stretch.

Not really. I've implemented this on a customer site with a fairly
complex network split into different subnets, but with a single
router box that also handled multiple VPNs.


> And I'm pretty sure that if you start one openvpn process listening
> on a specific IP, then another listening on 0.0.0.0, it'll still
> work, and the second instance will effectively be listening on
> every *other* IP from the first.

You'll need to do some more socket programming. :) It will not work.
Ports are first come first serve. Only one process can bind to a port
at a time. Multicast is the exception, but then the sender must also
be using the multicast as destination.


> I'm all for adding flexibility, but this really seems like a solution
> to a problem for which there's hardly ever *not* a better work-around.

I actually think the proposed patch is a workaround, and that driving
a configuration change into openvpn from the system components which
are in charge of the network reconfiguration in the first place is
the only actual solution.


//Peter

