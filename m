From: Juan Rodriguez Hervella <jrh@...176...>
MIME-Version: 1.0
Message-Id: <200403180948.33165.jrh@...176...>
Subject: [Openvpn-devel] Question regarding ....mmm...TAP and a ping that doesn't work
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Mar 18 00:49:06 2004
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

Hellooo...,

I'm testing openVPN using 2 FreeBSD machines, I use
TAP interfaces to relay ethernet frames from the LAN where
the openVPN server sits down to my client at home.

The server has 2 interfaces, the outer which I use in --remote,
and the inner which is the LAN I want to access at home.

The problem that I'm experiencing is that I'm not able to ping
the inner interface of the server from home.

Is this something I should expect ? I mean, 
Linux has the same problem ?

I'm wondering how this kind of encapsulation works, I think
(please correct me if I'm wrong) it should be like this:

1. The client's routing table decides that a packet must be sent 
through its TAP interface.
2. The TAP interface is read by openVPN (read() from TAP?),
which encapsulates the ethernet frame in TCP/UDP 
and sends it to the server.
3. The server desencapsulates the packet, and then inserts
the ethernet frame in the corresponding TAP device
(write() to TAP?)

Supposing the TAP and real-ethernet interface are bridged
on the server, what can be the reason I can not ping the 
real-interface leg ?

I think that it might be caused because the ARP request is sent off
through the inner interface and the server doesn't realize 
that he's got the answer, or in other words, the server doesn't listen
to its own ethernet broadcast packets ???
Does all this make sense ? Im quite lost :)

--
Sex without love is an empty experience, but, as empty experiences go,
it's one of the best.
		-- Woody Allen

