From: "James Yonan" <jim@...41...>
Message-ID: <twig.1076185995.51691@...41...>
In-Reply-To: <200402071929.i17JTKIk012344@...167...>
Subject: [Openvpn-devel] --redirect-gateway, was: Re: [Openvpn-users] Use at hotels
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
Date: Sat Feb  7 12:34:23 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tuc at the Beach House <tuc@...166...>, jim@...41...
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Tuc at the Beach House <tuc@...166...> said:

> Hi,
> 
>        --redirect-gateway
>               Automatically  execute routing commands to cause all outgoing IP
>               traffic to be redirected over the  VPN.   Currently  implemented
>               only on Linux and Windows.

Ah, yes, that's a problem.

The --redirect-gateway implementation needs to be able to get the IP address
of the current default gateway.  Unfortunately the standard Berkeley sockets
API doesn't give us a portable way of doing this.  Anyone know how to do this
on FreeBSD?

Having said that, all is not lost.  If you know your gateway address and you
know your DHCP server address (and if they are both relatively static), you
can write an --up script with route commands to do this.

James


