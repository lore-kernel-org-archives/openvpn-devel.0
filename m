Message-Id: <200210041035.g94AZiY17345@...41...>
Subject: Re: [Openvpn-devel] tunnelling ipv6 on linux
From: "James Yonan" <jim@...41...>
In-Reply-To: <Pine.LNX.4.44.0209281822530.25366-100000@...48...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=openvpn-devel>
Date: Fri Oct  4 03:36:03 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Aaron Sethman <androsyn@...45...>, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Aaron,

I've incorporated your IPv6 over tun patch for Linux into the latest OpenVPN beta, and added some basic infrastructure code and a --tun-ipv6 option which enables the IPv6 over tun support.  The option makes a placeholder for all OSes to support IPv6 over tun that is off by default and does not break any existing usage.

Beta is available here and on CVS:

http://openvpn.sourceforge.net/beta/openvpn-1.3.1.6.tar.gz

My IPv6 testing capabilities are limited at this point, so please test.

Best Regards,
James

Aaron Sethman <androsyn@...45...> said:

> 
> 
> On Sat, 28 Sep 2002, James Yonan wrote:
> 
> > Aaron,
> >
> > Thanks for the patch, however I was not able to get it to work with IPv4 while talking between a 2.4.9 and 2.4.17 kernel, where both peers are running the patch.  The code compiles and runs, but pings don't go through.  Perhaps there is a minimum kernel version necessary for this to work?  Does the kernel need to be built with IPv6 support in order for this code to work with IPv4?
> Well, it shouldn't require any IPv6 support in the kernel to simply pass
> IPv4 packets.  I'll need to look at the tun driver in 2.4.9.  Both of my
> machines here are running 2.4.19.
> >
> > There is also the issue of breaking protocol compatibility by adding the ETH_P_IPV6/ETH_P_IP to the IP-over-tun packet encoding.  I would propose that:
> Well, it doesn't break the protocol at all, what ends up happening is, the
> kernel takes the tun_pi header and strips it off, so those headers never
> get sent on the wire.
> 
>  >
> > (1) We run-time conditionalize your patch on a --tun-ipv6 option.
> 
> >
> > (2) We compile-time (e.g. #ifdef bracket on HAVE_NETINET_IF_ETHER_H, ETH_P_IPV6, etc.) and/or run-time conditionalize so that usage of --tun-ipv6 produces a run-time error if ipv6 over tun is not supported.
> That sounds like a good idea.
> >
> > (3) We add --tun-ipv6 enabled/disabled state to the options_string function in options.h as a sanity check between peers.
> >
> > (4) We think about how to make --tun-ipv6 portable across the platforms which OpenVPN supports.  This may be better addressed at the tun driver level, to reduce the machine-specific ugliness in tun.c?
> Well, this one might be a bit more difficult if the tunnel driver doesn't
> support it, of course it might be worth the effort to submit patches to
> the respective OSes for this.
> 
> >
> > (5) We look into making an ipv6 option for the tunnel UDP channel and endpoints as well.
> This part shouldn't be much of a problem.
> 
> Regards,
> 
> Aaron
> 



-- 




