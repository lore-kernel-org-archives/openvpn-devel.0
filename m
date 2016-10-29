From: debbie10t <debbie10t@...277...>
Message-ID: <a76fef6e-6cc6-0878-4cf6-293d84b4edd3@...277...>
Date: Sat, 29 Oct 2016 22:55:52 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] dhcp-option DNS IPv6 server address for windows
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

currently, openvpn does not accept an IPv6 dhcp-option DNS server address.

See:
https://forums.openvpn.net/viewtopic.php?f=23&t=22705

I also tested this on Win10 client and got the same error:
Options error: dhcp-option parameter DNS '12fc:1918::10:8:0:101' must be 
an IP address

So pushing this is ok but once pulled is rejected.

 From IRC openvpn-devel:

cron2 | there is no way to transmit IPv6 DNS information via IPv4 DHCP, 
and our current DHCP stuff is IPv4-DHCP

cron2 | this is not an openvpn limitation but an IPv4 DHCP limitation - 
we would have to implement an IPv6 DHCP server, which we currently do 
not have

dazo | slypknot: could you mail d12fk and selva regarding this and get 
their opinion? they're kind of driving the windows part 


Regards

