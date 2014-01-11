Message-ID: <52D1408B.6070902@...1227...>
Date: Sat, 11 Jan 2014 14:00:59 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...>
	<52CFFAF4.8050306@...1227...>	<52CFFDA4.4060601@...1790...>
	<52D07F70.8030609@...1227...> <52D08946.6010906@...1790...>
	<52D08AC6.7080808@...1227...> <52D08C75.8020903@...1790...>
In-Reply-To: <52D08C75.8020903@...1790...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tore Anderson <tore@...1790...>, openvpn-devel@lists.sourceforge.net

Am 11.01.14 01:12, schrieb Tore Anderson:
> * Arne Schwabe
>
>> Listening on multiple sockets not yet implemented. But a server having
>> proto udp6 should get IPv6 mapped IPv4 clients working. What is
>> happening/not working for you?
> "multihome" doesn't work, the OpenVPN server responds from its primary
> IPv4 address (the one the OS selects as the default source for routing
> towards the client), rather than the IPv4 address it was contacted on.
>
> So the initial two packets look like this:
>
> 01:07:47.896447 IP 84.209.244.191.38878 > 87.238.35.253.1194: UDP, length=
 14
> 01:07:47.897423 IP 87.238.35.145.1194 > 84.209.244.191.38878: UDP, length=
 26
>
> The client (84.209.244.191) expects the response packet to come from the
> address it contacted as --remote (87.238.35.253), but instead the server
> responds from 87.238.35.145 which is its primary address. Doesn't work,
> after some retransmissions and reconnect attempts the client gives up.
>
> The server logs the following:
>
> Jan 11 01:07:47 greed ovpn-server[10222]: ::ffff:84.209.244.191 TLS: Init=
ial packet from [AF_INET6]::ffff:84.209.244.191:38878 (via 2a02:c0:1001:100=
::253%eth0), sid=3D98e4314f 9ea08578
>
> I find the "via 2a02:c0:1001:100::253%eth0" part interesting, as that's
> not even the primary IPv6 address of the interface.
>
>
Yeah. We are probably out of luck at this point without implemting a
socket for v4 and a socket for v6. If the operating system does not give
us a valid incoming interface/ip combination, we cannot fix that later.

Arne


