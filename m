Date: Sat, 17 Jun 2006 15:21:51 +0200
From: richard lucassen <mailinglists@...673...>
Message-Id: <20060617152151.6ce2f63f.mailinglists@...673...>
Mime-Version: 1.0
Subject: [Openvpn-devel] ovpn server on udp with multiple gateways
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello list,

I tried to use an OpenVPN server listening on 1194/udp on a machine that
is having multiple gateways to the internet. I use policy routing.

eth1  1.1.1.2/29 (1.1.1.1 master def gw)
eth2  2.2.2.2/29 (2.2.2.1 gateway)
eth3  3.3.3.2/29 (3.3.3.1 gateway)

1.1.1.1 is the principal default gw. If I bind ovpn to 0.0.0.0, the
returnpackets will always have source address 1.1.1.2, even when making
a connection to 2.2.2.2 or 3.3.3.2.

I can of course use tcp instead of udp, but a tcp header is 12 bytes
larger that the udp one. And as I have a lot of Citrix traffic flowing
through the tunnel (which consists of a lot of small packets), I
want to reduce the tunnel overhead as maximum as possible.

Is there a (simple) way to let OpenVPN use the same source address to
which the connection was set up like in the following example?

- set up tunnel x.x.x.x to dst address 1.1.1.2
  return src address 1.1.1.2 to x.x.x.x
- set up tunnel x.x.x.x to dst address 2.2.2.2
  return src address 2.2.2.2 to x.x.x.x
- set up tunnel x.x.x.x to dst address 3.3.3.2
  return src address 3.3.3.2 to x.x.x.x

R.

-- 
___________________________________________________________________
It is better to remain silent and be thought a fool, than to speak
aloud and remove all doubt.

+------------------------------------------------------------------+
| Richard Lucassen, Utrecht                                        |
| Public key and email address:                                    |
| http://www.lucassen.org/mail-pubkey.html                         |
+------------------------------------------------------------------+

