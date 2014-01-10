Message-ID: <52CFF667.7080600@...1790...>
Date: Fri, 10 Jan 2014 14:32:23 +0100
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
Subject: [Openvpn-devel] git master proto udp6+multihome is broken
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
To: openvpn-devel@lists.sourceforge.net

If I connect to an openvpn server using "proto udp6" and "multihome", it
instantly crashes with an assertion failure:

Jan 10 14:25:58 greed ovpn-server[9905]: 2a02:c0:100:0:9e8e:99ff:fed1:5243 TLS: Initial packet from [AF_INET6]2a02:c0:100:0:9e8e:99ff:fed1:5243:56277 (via 2a02:c0:1001:100::145%eth0), sid=31dd697b d84bd1bc
Jan 10 14:25:58 greed ovpn-server[9905]: 2a02:c0:100:0:9e8e:99ff:fed1:5243 Assertion failed at socket.c:2878
Jan 10 14:25:58 greed ovpn-server[9905]: 2a02:c0:100:0:9e8e:99ff:fed1:5243 Exiting due to fatal error

This works with openvpn 2.3.2 so it's a regression.

However it works to connect to the same server with the exact same
config if the client is using IPv4 (assuming you connect to the primary
IPv4 address, because multihome doesn't actually work in this case, cf.
ticket #306):

Jan 10 14:27:54 greed ovpn-server[10251]: ::ffff:87.238.42.150 TLS: Initial packet from [AF_INET6]::ffff:87.238.42.150:47707, sid=6b38f3f6 fa385236
Jan 10 14:27:54 greed ovpn-server[10251]: ::ffff:87.238.42.150 VERIFY OK: depth=1, C=KG, ST=NA, L=BISHKEK, O=OpenVPN-TEST, emailAddress=me@...430...
[...]

Tore

