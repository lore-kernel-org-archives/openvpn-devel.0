Message-ID: <52D08946.6010906@...1790...>
Date: Sat, 11 Jan 2014 00:59:02 +0100
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...>
	<52CFFAF4.8050306@...1227...>	<52CFFDA4.4060601@...1790...>
	<52D07F70.8030609@...1227...>
In-Reply-To: <52D07F70.8030609@...1227...>
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

> Can you try the following one line patch? I will do a better cleanup
> patch later but this should fix the problem

Yep, this works. Thanks!

FWIW: Now I also got to test git master with what I wanted to in the
first place, namely to see whether or not all the nice dualstack changes
had also made "multihome" work for IPv4-mapped clients coming in to the
server on an udp6 socket (ticket #306). Unfortunately that's still
broken, and it seems that for a server process "proto udp" is still
IPv4-only. So it doesn't appear to be possible to get a functioning
dual-stacked UDP server (that has multiple addresses/interfaces) at the
moment.

Tore

