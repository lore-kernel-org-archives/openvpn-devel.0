Subject: Re: [Openvpn-devel] QoS
From: Craig Knox <crg@...49...>
In-Reply-To: <200210302353.g9UNrne16921@...41...>
References: <200210302353.g9UNrne16921@...41...>
Mime-Version: 1.0
Message-Id: <E1873GQ-0002KE-00@...50...>
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
Date: Wed Oct 30 16:33:06 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Aaron Sethman <androsyn@...45...>, openvpn-devel@lists.sourceforge.net

> I think TOS pass-through would be a nice optional feature to add to OpenVPN.  I would be curious to know how this works for you, i.e. extracting the TOS from the TUN/TAP data and calling setsockopt before the encrypted packet gets written to the UDP port.

It does work. 
Some results are (the two ping test run at the same time with a couple
of large scp (TOS=0x08) copies going at the same time):

ping -Q 0x08 [otherside of tunnel]
------------------------------------------------------------------
10 packets transmitted, 10 received, 0% loss, time 9085ms
rtt min/avg/max/mdev = 1097.163/1282.668/2088.874/276.205 ms, pipe 2


ping -Q 0x10 [otherside of tunnel]
-----------------------------------------------------------------
10 packets transmitted, 10 received, 0% loss, time 9089ms
rtt min/avg/max/mdev = 45.979/97.734/138.788/26.672 ms


> Some caveats that immediately come to mind:
> 
> * Since OpenVPN does not assume a particular TUN encoding of IP traffic, this patch requires OpenVPN to assume an offset of the TOS bits.

My quick hack (3 lines) assumes it is only IPv4 (as it always is for
me), for other protocols such as IPv6 I wouldn't know how to handle it,
but you could always check the first 8bits are 0x45 before trying to
read the TOS field.

> * Does the TOS extract and set on the UDP socket with setsockopt work in all cases, such as when packets are fragmented, dropped, or retransmitted?

I don't think this matters.  When packets are fragmented they would get
the TOS of the original packet.
 
> * This process causes the TOS to be sent as plaintext, which could be undesirable from a security standpoint.

I can't think of any other way to get the same result.



