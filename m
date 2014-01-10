Message-ID: <52CFFDA4.4060601@...1790...>
Date: Fri, 10 Jan 2014 15:03:16 +0100
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
In-Reply-To: <52CFFAF4.8050306@...1227...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

* Arne Schwabe

> That is very weird. I would expect it to fail for both cases in the same
> way. The codepath should trigger the same ASSERT(0) in both cases (or
> work in both). Can you forward a copy of your server configuration to
> me? Then I will try to reproduce that problem.

Sure thing, here:

proto udp6
multihome
port 1194
server 192.0.2.0 255.255.255.0
server-ipv6 2001:db8::/112
dh /usr/share/doc/openvpn/examples/sample-keys/dh1024.pem
ca /usr/share/doc/openvpn/examples/sample-keys/ca.crt
cert /usr/share/doc/openvpn/examples/sample-keys/server.crt
key /usr/share/doc/openvpn/examples/sample-keys/server.key

push "route 10.20.30.0 255.255.255.0"
push "route-ipv6 2001:db8:1::/64"

push "dhcp-option DNS 10.20.30.40"

dev tun
verb 3
keepalive 10 120
user nobody
group nogroup

comp-lzo
persist-key
persist-tun
duplicate-cn

Tore

