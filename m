Message-ID: <52D11696.8040204@...1790...>
Date: Sat, 11 Jan 2014 11:01:58 +0100
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...> <52D07F70.8030609@...1227...>
	<52D08946.6010906@...1790...> <20140111094837.GJ226@...1296...>
In-Reply-To: <20140111094837.GJ226@...1296...>
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

* Gert Doering

> I *thought* that both proto udp and proto udp6 would create an IPv6 socket
> bound to :: with IPV6_V6ONLY set to 0 (= accepting IPv4 and IPv6 packets
> to any address).  Only "proto udp4" should listen to 0.0.0.0.

This is not how git master behaves for me. "proto udp" and "proto udp4"
both yield an IPv4-only socket (AF_INET):

tore@...1860...:~$ sudo lsof -i :1194
COMMAND   PID   USER   FD   TYPE   DEVICE SIZE/OFF NODE NAME
openvpn 31739 nobody    5u  IPv4 19461864      0t0  UDP *:openvpn

Only "proto udp6" yields an dual-stacked socket (AF_INET6 +
!IPV6_V6ONLY), but I cannot use this because "multihome" fails for IPv4
clients (which are the majority of my users).

tore@...1860...:~$ sudo lsof -i :1194
COMMAND   PID   USER   FD   TYPE   DEVICE SIZE/OFF NODE NAME
openvpn 32126 nobody    5u  IPv6 19464798      0t0  UDP *:openvpn

FWIW, "proto tcp-server" also yields an IPv4-only socket. "proto
tcp6-server" works (also for IPv4 clients).

> Now, --multihome is a different issue - I accept that this isn't working
> right in various scenarios, and we need to fix this.  But at least dual-
> stacked servers with "proto udp" are expected to work.

Per the above, I cannot see that it does... I can submit a separate bug
report about this if you wish. That said, I would be perfectly happy to
simply use "proto udp6" instead, IFF "multihome" had worked correctly.

Tore

