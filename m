Message-Id: <200304171114.h3HBE7121769@...41...>
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030417085657.GA5962@...33...>
Subject: [Openvpn-devel] Re: New beta available + progress update
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
Date: Thu Apr 17 04:16:24 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Matthias Andree <matthias.andree@...68...> said:

> > What the FRAGMENT_ENABLE code does is to add an extra 4 byte header to each
> > datagram that includes, among other things, feedback on the number of
> > datagrams received as well as the maximum datagram size received.  This
> > information can then be used by an OpenVPN peer to dynamically set the MTU
> > size as well as the datagram transmit rate independently of the OS and the
> > proper functioning of path MTU discovery.  Ultimately this code can make
> > OpenVPN more robust in situations where fragmentation is necessary (such as in
> > TAP-based bridged ethernets) when firewalls or routers in the path break PMTU
> > discovery.
> 
> How about compatibility? Does this need a FRAGMENT_ENABLEd OpenVPN on
> either side of the tunnel or will OpenVPN negotiate the fragment
> capability dynamically as well?

Negotiation of the fragment capability is similar to how other parameters are
negotiated, such as cipher algorithm, lzo compression, etc.  The option
(--mtu-dynamic) must be used on both ends of the connection.  In SSL mode,
both peers will complain if --mtu-dynamic is used on one end but not the
other.  In non-SSL mode, there is no negotiation, so each peer assumes that
the other is using compatible options.

> Does this FRAGMENT_ENABLE rely on SSL or
> will it work with preshared keys?

No, it doesn't rely on SSL or pre-shared keys.  It can work even on plaintext
tunnels.

I think the major issue still to be worked out is how to make it efficient. 
While I've written a simple heuristic (see fragment_adjust_mtu_bandwidth() in
fragment.c) that is a starting point for determining MTU and transmit throttle
levels based on feedback from the peer, I'm finding a big performance dropoff
once the fragmenting code kicks in.  A big reason for this is packet loss,
that can be seen if you run ftp over the tunnel.  When there is a one-to-one
correspondence between TUN/TAP packets and UDP datagrams (as there is in
non-FRAGMENT_ENABLE openvpn), then the TCP level does the heavy lifting in
terms of pushing packets at the optimal rate to avoid packet loss.  Once
openvpn starts doing its own fragmenting, then it also needs to take explicit
control over the transmit rate (as it can now do statically with --shaper).

A better alternative (orginally suggested by you) is to avoid fragmenting in
the first place by bouncing back ICMP_DEST_UNREACH/ICMP_FRAG_NEEDED to the TUN
device.  This won't work on TAP devices because the ethernet MTU is fixed at 1500.

Unfortunately (or fortunately depending on your perspective), my network
connections are not broken enough to benefit from the FRAGMENT_ENABLE stuff
just yet, so I can't really test it properly.

James


