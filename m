Message-ID: <4B9515FF.6000704@...41...>
Date: Mon, 08 Mar 2010 08:21:35 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

OpenVPN 2.1 has a relatively recent feature that allows a TAP-based 
OpenVPN session to be established where the client gets its IP address 
assignment and other attributes from the server-side DHCP server.

The feature is enabled by the "route-gateway dhcp" directive on the client.

It's a pretty cool feature because it allows you to set up a TAP-based 
VPN server without configuring IP addresses, routes, etc. because you 
can simply leverage on the existing server-side DHCP server 
configuration.  When a client connects to the VPN, it gets an IP address 
assignment just as if it were physically "plugged into" the server-side LAN.

The problem is that "route-gateway dhcp" only works on platforms where 
the TAP driver negotiates a DHCP client handshake.  Currently, only 
Windows support this out-of-the-box (Windows supports it not because of 
any special code in the Windows TAP driver, but because the Windows DHCP 
client automatically binds to TAP adapter instances when they transition 
to the "up" state).

I'm hoping that we can make "route-gateway dhcp" work on Unix platforms 
as well.  I'm thinking there are two possible ways we could do this:

(1) Simple method: Trigger a DHCP client bind on TAP interfaces when 
they are instantiated.  (This is what Windows does automatically)

(2) Complex method: Write code in OpenVPN to simulate a DHCP client, 
then translate the settings received in the DHCP reply to OpenVPN 
push-style directives (such as ifconfig, route, etc.) as if they had 
been pushed by the OpenVPN server.

It would be great if someone wanted to volunteer to work on this.  I'm 
hoping that Mac and Linux could be supported via the Simple method.

James

