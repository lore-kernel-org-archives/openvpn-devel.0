Message-Id: <200304241742.h3OHg1131300@...41...>
Subject: Re: [Openvpn-devel] TCP-over-TCP (was: Multi-channel VPN)
From: "James Yonan" <jim@...41...>
In-Reply-To: <Pine.LNX.4.50.0304231914210.2917-100000@...48...>
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
Date: Thu Apr 24 10:43:10 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Aaron Sethman <androsyn@...45...>, Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

Aaron Sethman <androsyn@...45...> said:

> 
> 
> On Wed, 23 Apr 2003, Matthias Andree wrote:
> 
> > On Wed, 23 Apr 2003, James Yonan wrote:
> >
> > > I wonder if one could build a better tcp-over-tcp by doing some intelligent
> > > packet filtering on the higher level tcp connection, such as filtering out
> > > retransmits and fudging return ACKs -- essentially removing those
elements of
> > > the TCP protocol which are designed to make TCP work over an unreliable
link.
> >
> > I wonder if that's necessary. Tunnelling through TCP is inherently
> > reliable no matter what you send, so TCP-nested-in-TCP is just overkill.
> > Cheating the OS doesn't help. Maybe some LD_PRELOAD library that turns
> > stream sockets into dgram sockets for connections that use the tunnel is
> > sufficient. However, this doesn't actually apply to openvpn because
> > openvpn does TCP-over-UDP.
> 
> I think you've got it backwards.  I think James is talking about the layer
> that openvpn is tunnelling over.  Basically fiddling with it to keep that
> layer from doing a lot of the reliabilitiy stuff.  To be honest I'm not
> sure its possible without using raw sockets and constructing your own TCP
> packets.  Even then though, I don't think that would work for some
> people's needs like being able to shove it through an SSL proxy or
> something like that.

Actually, I was thinking more about the situation where people are forced to
tunnel IP over TCP, for whatever reason, when UDP is not an option.  Since IP
is designed to transit over an unreliable physical layer, when you tunnel it
over TCP (a la vpnd or IP over ssh) you end up with this problem:

http://sites.inka.de/sites/bigred/devel/tcp-tcp.html (see Stacking TCPs)

The key issue here is that when you tunnel IP over TCP, that will usually mean
TCP over TCP.  And this tends to break TCP's retransmission algorithm.  As the
article above states: "The upper layer will queue up more retransmissions
faster than the lower layer can process them".

So my idea is why not filter out the upper layer TCP retransmissions, and
synthesize the return ACKs so that the upper TCP layer doesn't begin the
exponential backing off of the retransmit timer that eventually will stall the
connection?  This process would essentially strip the upper layer TCP of its
reliability function, since now the lower TCP layer will provide that
function.  This is not difficult to implement, since to OpenVPN, the upper
layer protocols are all simply byte streams flowing over the TUN pipe.  They
can be filtered without resorting to raw sockets or any other such potentially
unportable constructs.

Using raw sockets would be another potential method -- instead of removing the
reliability function from the upper layer TCP layer, remove it from the lower
layer.  This would require a sort of fake-TCP implementation in user-space
with the reliability function stripped out.  On first glance, this seems to be
a more complicated approach because you would need to implement a lot of the
TCP protocol in user space, and you would need to depend on the OS supporting
raw sockets.  The approach outlined in the previous paragraph doesn't need raw
sockets, and it doesn't need to reimplement TCP.  It only needs to examine the
byte stream of IP packets flowing over the TUN device, filter out TCP
retransmits, and synthesize return TCP ACKs.

Each method tries to stabilize TCP-over-TCP by eliminating a redundant
reliability layer.  Both of these methods, while somewhat ugly, would
eliminate a big part of the robustness issue of IP over TCP, for those who
lack IP over UDP as an option.

James


