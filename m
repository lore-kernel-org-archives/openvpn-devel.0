From: "Harsha V. Madhyastha" <harsha@...338...>
Message-ID: <Pine.LNX.4.58L.0505161403020.6501@...339...>
MIME-Version: 1.0
Subject: [Openvpn-devel] What happens to raw IP packets written to the TUN device?
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
Date: Mon May 16 19:16:18 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I haven't yet got a response for this on the users list and so, am 
forwarding it to the devel list.

Hope someone out here knows the answer to this.

Thanks!
Harsha

----------------------------------------------------------------------------
University of Washington  |  http://www.cs.washington.edu/homes/harsha/
harsha@...338...  |  http://harshaandsports.blogspot.com/
----------------------------------------------------------------------------

---------- Forwarded message ----------
Date: Mon, 16 May 2005 00:17:21 -0700 (PDT)
From: Harsha V. Madhyastha <harsha@...338...>
To: openvpn-users@lists.sourceforge.net
Subject: What happens to raw IP packets written to the TUN device?

Hi everyone,

I had written about this problem to the list a couple of months back and 
hadn't received any relevant response. So, I am presenting the same 
problem in a different light now. Hopefully one of you will be able to 
help me out.

The basic question is as follows. Suppose I open a WIN32 HANDLE on the 
TUN/TAP device and then write a raw packet inclusive of IP header to it 
(the packet is destined to destination D), is it reasonable to expect 
that the packet will be sent out to D via the normal eth0 interface? 
(assuming the routing table is such that packets to destination D should 
be routed to eth0). Similarly, on Linux, if I open a file descriptor on 
/dev/net/tun and write a raw packet to it, will it be forwarded to the 
eth0 interface?

One of the responses to my previous email had suggested that I did not 
have forwarding enabled, and as suggested, I executed on Linux
"echo 1 > /proc/sys/net/ipv4/ip_forward"
and also, added "iptables -A FORWARD -j ACCEPT", but that did not help.

The main point of confusion is that when I write raw packets with local IP 
address as the destination address, the packet gets forwarded to the 
appropriate application, but when I write raw packets destined to other 
addresses, the packet just disappears! So, I am beginning to doubt whether 
the TUN interface is meant to be such that raw packets will get forwarded 
to the appropriate interface. Please note that I am using the TUN/TAP 
device installed by OpenVPN on Windows XP and I'm using the standard 
/dev/net/tun device on Linux, and the same problem is seen on both.

Please let me know if you need more details to understand the problem. I 
would be glad to divulge as much information as you need. I hope one of 
you will respond to my call for help!

Thanks!
Harsha

----------------------------------------------------------------------------
University of Washington  |  http://www.cs.washington.edu/homes/harsha/
harsha@...338...  |  http://harshaandsports.blogspot.com/
----------------------------------------------------------------------------

