From: Davide Brini <dave_br@...1278...>
Date: Fri, 28 Jan 2011 09:51:40 +0000
References: <4D4208C9.6000206@...1449...>
In-Reply-To: <4D4208C9.6000206@...1449...>
MIME-Version: 1.0
Message-Id: <201101280951.40901.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] udp6 source-address wrong with
	more than one ipv6-address on server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

On Friday 28 Jan 2011 00:07:37 Stefan Hellermann wrote:

> I have a problem with proto udp6  (tun inside). My Openvpn-server should
> be reachable on multiple IPv6-addresses over UDP6. The packets arrive at
> the correct IP, but Openvpn answers them on a default ip, not on the one
> where the packet arrived. With proto tcp6-server it works.
> 
> I know that UDP is stateless, but you can get the destination ip out of
> the recived packet and use it as a source ip for sending packets. This
> should somehow work with IPV6_PKTINFO on the socket (man 7 ipv6 on linux).
> 
> I have more than one IPv6-address because my tunnel broker for IPv6 is
> not 100% stable, so I use multiple tunnels to different endpoints.
> 
> My openvpn-Version: openvpn-201102.tar.gz from here:
> ftp://ftp.secure-computing.net/pub/FreeBSD/ports/openvpn-devel/
> 
> Can anyone help me? Do I have to configure something? I have already
> thought about DNAT all other IPs to the working default IP ... but IPv6
> DNAT isn't implemented on this machine.
> And running as many openvpn-instances as there are IPv4 and IPv6
> addresses is to problematic as the addresses go up and down.

Are you using the "multihome" option in the server configuration? As far as I 
can tell, using "multihome" uses the PKTINFO information to source UDP replies 
from the correct IP address; however, while it does work for IPv4, I don't 
know if that functionality has been ported to IPv6 already. I'm CC-ing the 
devel list as well.

-- 
D.

