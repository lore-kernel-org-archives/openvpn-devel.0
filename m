Message-Id: <200210302353.g9UNrne16921@...41...>
Subject: Re: [Openvpn-devel] QoS
From: "James Yonan" <jim@...41...>
In-Reply-To: <E186UxK-0007eG-00@...50...>
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
Date: Wed Oct 30 15:55:06 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Craig Knox <crg@...49...>, Aaron Sethman <androsyn@...45...>
Cc: openvpn-devel@lists.sourceforge.net

Craig Knox <crg@...49...> said:

> Hi,
> 
> > One of the problems I can see with this is that you give some information
> > away about the payload, mind you not much, but you are regardless.
> 
> That is true - but for me its either give away TOS or have things become
> unresponsive.
> 
> >  I
> > guess if you really wanted to do this, one could modify openvpn to look at
> > the IP headers directly inside of openvpn and get the TOS off of the
> > packet and then use setsockopt() to set it for the outgoing packet.  It
> > might not seem pretty, but it'll work.  Let me know if you want me to hack
> > up a patch for you to do this.
> 
> Cheers - Think I've manage to make the changes by getting the TOS field
> of the incoming packet and setting it on the udp packet - in that it
> seems to work.

I think TOS pass-through would be a nice optional feature to add to OpenVPN.  I would be curious to know how this works for you, i.e. extracting the TOS from the TUN/TAP data and calling setsockopt before the encrypted packet gets written to the UDP port.

Some caveats that immediately come to mind:

* Since OpenVPN does not assume a particular TUN encoding of IP traffic, this patch requires OpenVPN to assume an offset of the TOS bits.

* Does the TOS extract and set on the UDP socket with setsockopt work in all cases, such as when packets are fragmented, dropped, or retransmitted?

* This process causes the TOS to be sent as plaintext, which could be undesirable from a security standpoint.

James


