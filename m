From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] TCP-over-TCP (was: Multi-channel VPN)
In-Reply-To: <20030423083854.GB4080@...33...>
Message-ID: <Pine.LNX.4.50.0304231914210.2917-100000@...48...>
References: <20030422191429.GD9395@...33...>
 <200304230114.h3N1Eh112247@...41...> <20030423083854.GB4080@...33...>
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
Date: Wed Apr 23 16:32:01 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net


On Wed, 23 Apr 2003, Matthias Andree wrote:

> On Wed, 23 Apr 2003, James Yonan wrote:
>
> > I wonder if one could build a better tcp-over-tcp by doing some intelligent
> > packet filtering on the higher level tcp connection, such as filtering out
> > retransmits and fudging return ACKs -- essentially removing those elements of
> > the TCP protocol which are designed to make TCP work over an unreliable link.
>
> I wonder if that's necessary. Tunnelling through TCP is inherently
> reliable no matter what you send, so TCP-nested-in-TCP is just overkill.
> Cheating the OS doesn't help. Maybe some LD_PRELOAD library that turns
> stream sockets into dgram sockets for connections that use the tunnel is
> sufficient. However, this doesn't actually apply to openvpn because
> openvpn does TCP-over-UDP.

I think you've got it backwards.  I think James is talking about the layer
that openvpn is tunnelling over.  Basically fiddling with it to keep that
layer from doing a lot of the reliabilitiy stuff.  To be honest I'm not
sure its possible without using raw sockets and constructing your own TCP
packets.  Even then though, I don't think that would work for some
people's needs like being able to shove it through an SSL proxy or
something like that.

Aaron

