From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] QoS
In-Reply-To: <200210302353.g9UNrne16921@...41...>
Message-ID: <Pine.LNX.4.44.0210301858330.7992-100000@...48...>
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
Date: Wed Oct 30 16:06:02 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: Craig Knox <crg@...49...>, openvpn-devel@lists.sourceforge.net


On Wed, 30 Oct 2002, James Yonan wrote:
>
> Some caveats that immediately come to mind:
>
> * Since OpenVPN does not assume a particular TUN encoding of IP traffic, this patch requires OpenVPN to assume an offset of the TOS bits.
Well if you end up looking at the ip header by using struct iphdr, you'd
be able to determine the version of IP packet whether it was 4 or 6, then
from there you'd need to use either struct iphdr or struct ipv6hdr,
respectively.  This would be very similiar to the IPv6 detection stuff I
had to do to get ipv6 tunnelling to work with Linux.
 >
> * Does the TOS extract and set on the UDP socket with setsockopt work in all cases, such as when packets are fragmented, dropped, or retransmitted?
TOS is independent of the protocol riding on top of it as it is strictly
done on the IP level.

The thing to consider is, depending on the OS, setting the TOS to certain
levels might require root privledges.

Aaron


