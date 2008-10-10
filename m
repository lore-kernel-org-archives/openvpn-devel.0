Message-ID: <48EF3258.6020604@...1123...>
Date: Fri, 10 Oct 2008 12:45:44 +0200
From: Peter Rabbitson <rabbit+list@...1123...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Bind on secondary windows address - bug or general
	limitation?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I have a windows 2003 server, running as an openvpn _client_  with the
following setup:

Ethernet adapter Local Area Connection 7:

   Connection-specific DNS Suffix  . :
   IP Address. . . . . . . . . . . . : 208.xx.xx.224
   Subnet Mask . . . . . . . . . . . : 255.255.255.128
   IP Address. . . . . . . . . . . . : 208.xx.xx.223
   Subnet Mask . . . . . . . . . . . : 255.255.255.128
   Default Gateway . . . . . . . . . : 208.xx.xx.129

I want to let the vpn server to talk to this client over the tunnel, so
I am trying to get the client to connect to the server via the .224
address (so I can set a tunneled route for the .223 one). I however can
not get it to work.

I specified 'local 208.xx.xx.224' and the connection logs properly say:
Fri Oct 10 05:34:23 2008 us=324594 UDPv4 link local: 208.xx.xx.224
Fri Oct 10 05:34:23 2008 us=324613 UDPv4 link remote: ss.ss.ss.ss:1194

Yet the server receives packets from .223. Wireshark also shows packets
being directly sent with a .223 source address. Same happens if I try to
use the windows utility:

pingpath -i 208.xx.xx.224 <remote host>. Both wireshark and the remote
hos see icmp packets labeled from .223

Is this a known issue with windows, and are there any know workarounds?
Or the second IP is useless to me on this platform?

Thank you

