Message-Id: <200304242204.h3OM4P131899@...41...>
Subject: Re: [Openvpn-devel] TCP-over-TCP (was: Multi-channel VPN)
From: "James Yonan" <jim@...41...>
In-Reply-To: <Pine.LNX.4.50.0304241421470.26650-100000@...48...>
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
Date: Thu Apr 24 15:05:10 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Aaron Sethman <androsyn@...45...>, James Yonan <jim@...41...>
Cc: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Aaron Sethman <androsyn@...45...> said:

> 
> On Thu, 24 Apr 2003, James Yonan wrote:
> > Actually, I was thinking more about the situation where people are forced to
> > tunnel IP over TCP, for whatever reason, when UDP is not an option.  Since IP
> > is designed to transit over an unreliable physical layer, when you tunnel it
> > over TCP (a la vpnd or IP over ssh) you end up with this problem:
> >
> > http://sites.inka.de/sites/bigred/devel/tcp-tcp.html (see Stacking TCPs)
> I've read the paper many times, heh ;)
> 
> >
> > The key issue here is that when you tunnel IP over TCP, that will usually mean
> > TCP over TCP.  And this tends to break TCP's retransmission algorithm.  As the
> > article above states: "The upper layer will queue up more retransmissions
> > faster than the lower layer can process them".
> >
> > So my idea is why not filter out the upper layer TCP retransmissions, and
> > synthesize the return ACKs so that the upper TCP layer doesn't begin the
> > exponential backing off of the retransmit timer that eventually will stall the
> > connection?  This process would essentially strip the upper layer TCP of its
> > reliability function, since now the lower TCP layer will provide that
> > function.  This is not difficult to implement, since to OpenVPN, the upper
> > layer protocols are all simply byte streams flowing over the TUN pipe.  They
> > can be filtered without resorting to raw sockets or any other such potentially
> > unportable constructs.
> What if you end up filtering out necessary retransmissions that occur
> elsewhere on the path.  Consider the situation of one end being a router
> and passing packets out to the rest of the world, and openvpn is being
> used to brige an insecure link like say an 802.11b network.  Personally I
> think mucking with this could be dangerous.

That's a good point.  Once you synthesize an ACK to avoid retransmission over
the TCP-tunnel segment of the path, you are guaranteeing to the sender that
the packet has been received at the destination.  This means you would need to
do some accounting of TCP sequence numbers at both ends of the tunnel, so that
you could differentiate retransmits caused by local congestion on the
TCP-tunnel from retransmits occurring due to lossage elsewhere on the path. 
The more you look at it, the uglier it gets.

What you need is a kind of TCP mode that strips out the reliability function.
 Of course we have it, it's called UDP ;)

James


