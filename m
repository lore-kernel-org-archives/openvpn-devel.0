Message-ID: <4F57A80E.60405@...1698...>
Date: Wed, 07 Mar 2012 22:25:18 +0400
From: Sergey Matveychuk <sem@...1698...>
MIME-Version: 1.0
Subject: [Openvpn-devel] why so big default mtu size?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello.

I did not set any mtu* options and get that:
Control Channel MTU parms [ L:1589 D:166 EF:66 EB:0 ET:0 EL:0 ]
Data Channel MTU parms [ L:1589 D:1450 EF:57 EB:4 ET:32 EL:0 ]
Local Options String: 'V4,dev-type tap,link-mtu 1589,tun-mtu 1532,proto 
UDPv4,cipher AES-128-CBC,auth SHA1,keysize 128,tls-auth,key-method 
2,tls-server'

It looks bad.
Looking in code I see default tun-mtu is 1500, tun-mtu-extra is 32 and 
link-mtu is tun-mtu+all overhead. Could you explain it please?

