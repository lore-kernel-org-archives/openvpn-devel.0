From: Aaron Sethman <androsyn@...45...>
Subject: Re: [Openvpn-devel] QoS
In-Reply-To: <E1867SL-0005ML-00@...50...>
Message-ID: <Pine.LNX.4.44.0210290254160.4558-100000@...48...>
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
Date: Tue Oct 29 00:04:03 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Craig Knox <crg@...49...>
Cc: openvpn-devel@lists.sourceforge.net

On 28 Oct 2002, Craig Knox wrote:

> Hi there,
>    I use QoS routing and it works great except over openvpn/tun device.
>
>    Correct me if I am wrong but I think this is because the packets are
> encapsulated within a UDP packet with no regard to what the original
> packets TOS field was, so once it reaches a "real" device it is just
> treated as bulk even it was suppose to be for example minimum-delay.
>
>    Is there anyway the TOS of the UDP packet could be set the match its
> payload's TOS?
One of the problems I can see with this is that you give some information
away about the payload, mind you not much, but you are regardless.  I
guess if you really wanted to do this, one could modify openvpn to look at
the IP headers directly inside of openvpn and get the TOS off of the
packet and then use setsockopt() to set it for the outgoing packet.  It
might not seem pretty, but it'll work.  Let me know if you want me to hack
up a patch for you to do this.

Regards,

Aaron


