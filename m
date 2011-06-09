Message-ID: <4DF0FEC8.4040105@...1465...>
Date: Thu, 09 Jun 2011 21:11:36 +0400
From: Sergey Matveychuk <sem@...1465...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Why no ipv6 support for tap?
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

Hi.

It's really weird that I can't set up IPv6 address for tap interface. 
server-ipv6 turns a tun mode, ifconfig-ipv6 suppose p2p interface and 
even 'push route-ipv6' misticaly discards because of some flag 
(tt->ipv6) has been unset.

Looking on added ipv6 support I have only one question but many times 
"why? why? why?".

