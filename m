Message-ID: <4A2A50AE.30805@...1164...>
Date: Sat, 06 Jun 2009 13:19:10 +0200
From: Emrah KAVUN <eka@...1164...>
MIME-Version: 1.0
References: <16130.65.118.50.246.1232730850.squirrel@...1166...>	<24624.65.118.50.246.1244149998.squirrel@...1166...>	<1244174393l.6685l.3l@...1207...>
	<31530.65.118.50.246.1244212489.squirrel@...1166...>
In-Reply-To: <31530.65.118.50.246.1244212489.squirrel@...1166...>
Subject: [Openvpn-devel] How to route without splitting the network into a
	/30?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: openvpn-devel@lists.sourceforge.net

Hello guys,

I would like to route with OpenVPN with public IPs. My setup works fine
now, however every client get a dedicated /30 network segment instead of
the /28 allowed. This of course means that I waste too many IPs as every
client get its own gateway, and so on.
I don't want to use Tap for this.


Here is my config:
plugin /usr/lib/openvpn/openvpn-auth-pam.so login
local x.x.3.100
port 1194
proto udp
dev tun
ca ca.crt
cert x-vpn.crt
key x-vpn.key
dh dh1024.pem

server x.x.2.16 255.255.255.240

push "route x.x.2.0 255.255.255.0"
#push "route x.x.3.100 255.255.255.248"

push "redirect-gateway def1"
push "dhcp-option DNS x.x.2.3"
push "dhcp-option DOMAIN ekanet.net"
push "dhcp-option ROUTERS x.x.3.97"
#client-config-dir ccd
#route 10.0.0.0 255.255.255.0

client-to-client
duplicate-cn

keepalive 10 120

comp-lzo

user openvpn
group openvpn

persist-key
persist-tun
verb 1
username-as-common-name
tmp-dir /dev/shm
client-cert-not-required



Thanks in advance.

Best regards,
Emrah

