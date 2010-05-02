Message-ID: <4BDDF2C0.2070001@...360...>
Date: Sun, 02 May 2010 23:46:40 +0200
From: reg9009 <reg9009@...360...>
MIME-Version: 1.0
Subject: [Openvpn-devel] dynamic iroute behaviour / volunteers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi list,

sorry, I lost my previous post explaining our initial problem with 
dynaamic route propagation via BGP, so I can't keep my thread. I had a 
look at the iroute code and here's my suggestion for a complete dynamic 
routing behaviour without the need for restarting the VPN in case of 
routing changes or networks added behind VPN endpoints:

Our problem is that we have to manually add networks to iroute to get 
them work over two hops via route propagation (OSPF, BGP, etc.). I'll 
try to outline my solution in logical code. It should at least work for 
unix like systems:

Listen for kernel routing events via rtnetlink...

switch (routing change happens) {
     route added or changed:
         if (gateway is an IP assigned to a OpenVPN client) {
             add network to iroute table
         }else {
             discard
         }
     route deleted:
         if (deleted_network was in iroute table) {
             remove route from iroute table
         } else {
             discard
         }
}

This would keep iroute behaviour, but enable dynamic routing to work 
without restarting VPN links (and manually change ccd files for 
clients). Did I get this right and would it be possible to implement?

Regards,
Sebastian



