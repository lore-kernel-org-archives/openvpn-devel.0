From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] TCP-over-TCP (was: Multi-channel VPN)
In-Reply-To: <200304241742.h3OHg1131300@...41...>
Message-ID: <Pine.LNX.4.50.0304241421470.26650-100000@...48...>
References: <200304241742.h3OHg1131300@...41...>
MIME-Version: 1.0
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
Date: Thu Apr 24 11:31:10 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

On Thu, 24 Apr 2003, James Yonan wrote:
> Actually, I was thinking more about the situation where people are forced to
> tunnel IP over TCP, for whatever reason, when UDP is not an option.  Since IP
> is designed to transit over an unreliable physical layer, when you tunnel it
> over TCP (a la vpnd or IP over ssh) you end up with this problem:
>
> http://sites.inka.de/sites/bigred/devel/tcp-tcp.html (see Stacking TCPs)
I've read the paper many times, heh ;)

>
> The key issue here is that when you tunnel IP over TCP, that will usually mean
> TCP over TCP.  And this tends to break TCP's retransmission algorithm.  As the
> article above states: "The upper layer will queue up more retransmissions
> faster than the lower layer can process them".
>
> So my idea is why not filter out the upper layer TCP retransmissions, and
> synthesize the return ACKs so that the upper TCP layer doesn't begin the
> exponential backing off of the retransmit timer that eventually will stall the
> connection?  This process would essentially strip the upper layer TCP of its
> reliability function, since now the lower TCP layer will provide that
> function.  This is not difficult to implement, since to OpenVPN, the upper
> layer protocols are all simply byte streams flowing over the TUN pipe.  They
> can be filtered without resorting to raw sockets or any other such potentially
> unportable constructs.
What if you end up filtering out necessary retransmissions that occur
elsewhere on the path.  Consider the situation of one end being a router
and passing packets out to the rest of the world, and openvpn is being
used to brige an insecure link like say an 802.11b network.  Personally I
think mucking with this could be dangerous.

> Using raw sockets would be another potential method -- instead of removing the
> reliability function from the upper layer TCP layer, remove it from the lower
> layer.  This would require a sort of fake-TCP implementation in user-space
> with the reliability function stripped out.  On first glance, this seems to be
> a more complicated approach because you would need to implement a lot of the
> TCP protocol in user space, and you would need to depend on the OS supporting
> raw sockets.  The approach outlined in the previous paragraph doesn't need raw
> sockets, and it doesn't need to reimplement TCP.  It only needs to examine the
> byte stream of IP packets flowing over the TUN device, filter out TCP
> retransmits, and synthesize return TCP ACKs.
This is what I was thinking, however this is a really big pain in the rear
too.

> Each method tries to stabilize TCP-over-TCP by eliminating a redundant
> reliability layer.  Both of these methods, while somewhat ugly, would
> eliminate a big part of the robustness issue of IP over TCP, for those who
> lack IP over UDP as an option.

Or you could just tell users that you are to expect degraded performance
in this case and use UDP if possible.  But *if* you are stuck, and have no
other options, this will work, but it'll suck too.

I'm wondering if there are some socket options one could set to twiddle
the TCP stack into playing slightly nicer.  I doubt it, because you've
still got the issue of other systems not playing nice with it.


-Aaron

