From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0501212021010.17863@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Problem with --route-method exe and --redirect-gateway
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
Date: Fri Jan 21 11:39:05 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Sven-Erik Fraenell <sven-erik.fraenell@...341...>

Just because someone reported about problems with route additions via 
IPAPI when using PPP or PPPoE adapters the other day, one of my users 
reported the same problem to me today. I'll try to reproduce it on my 
computer later to night, so we can get to the bottom with that problem.

While thoubleshouting that problem, I switched to --route-method exe, but 
found another problem!

I would call it bug in Windows route.exe rather than in OpenVPN. The 
problem is that when using --redirect-gateway def1, and disconnecting, 
OpenVPN executes the command:

ROUTE DELETE 0.0.0.0 MASK 128.0.0.0

The problem is that route.exe deletes both the 0.0.0.0/1, AND the real 
0.0.0.0/0 route, regardless if the MASK option is used or not.

I double MS will fix this, so I think we need to work around this.

I can see two solutions:

1) Re-add the old default gw, like we do when not using the def1 
parameter.

2) Also specify the gateway parameter on the route delete cmd. This causes 
route.exe only to delete the correct route.

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail

