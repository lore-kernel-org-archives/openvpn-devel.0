Message-ID: <530262FB.7080206@...1790...>
Date: Mon, 17 Feb 2014 20:28:59 +0100
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...>
	<52CFFAF4.8050306@...1227...>	<52CFFDA4.4060601@...1790...>
	<52D07F70.8030609@...1227...>	<52D08946.6010906@...1790...>
	<20140119140416.GP226@...1296...>
In-Reply-To: <20140119140416.GP226@...1296...>
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

> On Sat, Jan 11, 2014 at 12:59:02AM +0100, Tore Anderson wrote:
>> FWIW: Now I also got to test git master with what I wanted to in the
>> first place, namely to see whether or not all the nice dualstack changes
>> had also made "multihome" work for IPv4-mapped clients coming in to the
>> server on an udp6 socket (ticket #306). Unfortunately that's still
>> broken, and it seems that for a server process "proto udp" is still
>> IPv4-only. So it doesn't appear to be possible to get a functioning
>> dual-stacked UDP server (that has multiple addresses/interfaces) at the
>> moment.
> 
> FWIW, that seems to be a Linux oddity.

Now that has been fixed upstream (Linux 3.14), I tried again. Here I am
connecting from 84.209.94.36 to 87.238.35.254, which is a secondary
address on the server (87.238.35.145 is the primary). The OpenVPN
server logs:

::ffff:84.209.94.36 TLS: Initial packet from [AF_INET6]::ffff:84.209.94.36:39970 (via ::ffff:87.238.35.254%eth0), sid=a79ae4ef 7abb8215

So the Linux 3.14 fix seems to work, as OpenVPN now does see which IPv4
address the server was contacted on. Progress! However the VPN doesn't
come up, and tcpdump reveals why - OpenVPN is responding from the
primary address of the server rater than the one it was contacted on:

20:21:02.555667 IP 84.209.94.36.39970 > 87.238.35.254.1194: UDP, length 14
20:21:02.556719 IP 87.238.35.145.1194 > 84.209.94.36.39970: UDP, length 26

So we're closer, but not quite there yet unfortunately...

This happens both with today's git master and with 2.3.2. BTW Arne's
patch to socket.c that fixes the assert crash we originally discussed
still isn't included in git master, has it been forgotten about?

Tore

