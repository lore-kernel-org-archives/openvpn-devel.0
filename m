Subject: Re: [Openvpn-devel] QoS
From: Craig Knox <crg@...49...>
In-Reply-To: <Pine.LNX.4.44.0210290254160.4558-100000@...48...>
References: <Pine.LNX.4.44.0210290254160.4558-100000@...48...>
Mime-Version: 1.0
Message-Id: <E186UxK-0007eG-00@...50...>
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
Date: Tue Oct 29 03:55:03 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Aaron Sethman <androsyn@...45...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> One of the problems I can see with this is that you give some information
> away about the payload, mind you not much, but you are regardless.

That is true - but for me its either give away TOS or have things become
unresponsive.

>  I
> guess if you really wanted to do this, one could modify openvpn to look at
> the IP headers directly inside of openvpn and get the TOS off of the
> packet and then use setsockopt() to set it for the outgoing packet.  It
> might not seem pretty, but it'll work.  Let me know if you want me to hack
> up a patch for you to do this.

Cheers - Think I've manage to make the changes by getting the TOS field
of the incoming packet and setting it on the udp packet - in that it
seems to work.






