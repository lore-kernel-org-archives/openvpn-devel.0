Message-ID: <4F333427.70808@...1388...>
Date: Thu, 09 Feb 2012 15:49:11 +1300
From: Michal Ludvig <mludvig@...1388...>
MIME-Version: 1.0
Subject: [Openvpn-devel] route-ipv6 parameters & route prefixes
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
To: openvpn-devel@lists.sourceforge.net

Hi guys

I'm used to pushing route options to the clients with explicit metrics. 
That works good for IPv4 with e.g.:
push "route 192.168.128.0 255.255.240.0 vpn_gateway 200"

However route-ipv6 doesn't accept the 'vpn_gateway' keyword and 
therefore I can't easily set a metric. I could indeed put the actual 
server IP in there but that's less flexible, partly because I have this 
routes section in a separate file included in multiple configs on the 
same machine.

Can we have 'route-ipv6' accepting the same keywords as 'route' for 
consistency? Please :)

BTW ideally, for even more consistency, modify 'route' (v4) to also 
accept "net/prefix" as well as the old-fashioned "net netmask". OpenVPN 
is one of the last programs where I still have to use netmasks instead 
of the more convenient prefixes. That'd be truly awesome :) (but not as 
important as the vpn_gateway support for route-ipv6 of course).

Thanks!

Michal

