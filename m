Message-Id: <F2EA8431-350C-475E-8BAC-D36811AEDEE9@...1198...>
From: Andy Sykes <a.sykes@...1198...>
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Mon, 23 Feb 2009 18:33:44 +0000
Subject: [Openvpn-devel] Possible bug in Mac OS X openvpn port with
	redirect-gateway
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi list,

I'm using OpenVPN 2.1_rc15 on Mac OS X 10.5.6.

Server is at a.b.c.218, subnet mask is a.b.c.192/255.255.255.224.  
Router for subnet is at a.b.c.222. This is a public IP range,  
firewalled from the 'net (not that it should make any difference).

Server is pushing:
route-gateway a.b.c.222
redirect-gateway def1

On the client, a route gets set up correctly through the client's  
normal gateway to the server at a.b.c.218.

The default route does not get set up correctly - it points a.b.c.218  
rather than 128.40.186.222, and it sets it up on the local interface  
(en1 - wireless adapter in this case) rather than tap0. Attempting to  
ping any network apart from the one directly connected to tap0 (a.b.c. 
192/27) gives "Network unreachable".

Manually deleting the broken route, and adding one to a.b.c.222  
through tap0 makes everything work (all traffic traverses the VPN  
succesfully), but I can't set this up using an OpenVPN configuration  
file.

With identical configuration files, and the same server, but a Windows  
client, everything works fine - the route to the OpenVPN server is set  
up correctly, and the default route is specified as a.b.c.218 through  
tap0. Pings reach any network, and all traffic traverses the VPN.  
[Aside - bit confused here - shouldn't route-gateway push the default  
route to a.b.c.222?]

Am I looking at a bug here, or a PEBCAK error?

Cheers,
Andy.

