Message-ID: <5302FAB1.9000509@...1790...>
Date: Tue, 18 Feb 2014 07:16:17 +0100
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...>
	<52CFFAF4.8050306@...1227...>	<52CFFDA4.4060601@...1790...>
	<52D07F70.8030609@...1227...>	<52D08946.6010906@...1790...>
	<20140119140416.GP226@...1296...>	<530262FB.7080206@...1790...>
	<20140217213435.GS16637@...1296...>
In-Reply-To: <20140217213435.GS16637@...1296...>
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

Hi Gert,

> Could you run my test program to see whether that gets it right?

It doesn't:

server$ mhome 
AF_INET6/IPV6_RECVPKTINFO enabled
setsockopt(IPV6_V6ONLY=0)
Socket bound to local address [AF_INET6][undef]:50001
--
CMSG_NXTHDR=(nil), level=41, type=50
IPV6_PKTINFO
read: fromlen=28, r_len=5
  from=[AF_INET6]::ffff:84.209.94.36:35711 (via ::ffff:87.238.35.254%eth0 [2])
control=0x7fff699af0a0, controllen=40, pkti6=0x7fff699af0b0, struct cmsghdr=16 bytes
--

server$ tcpdump -ni eth0 port 50001
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
07:11:26.375252 IP 84.209.94.36.35711 > 87.238.35.254.50001: UDP, length 5
07:11:26.376051 IP 87.238.35.145.50001 > 84.209.94.36.35711: UDP, length 5

client$ echo ping | nc -4u 87.238.35.254 50001

> For some platforms I also had to change the sending part (data structures,
> alignment, whatnot) and that has not yet been integrated into OpenVPN
> proper, and I think Linux was among them, at least for 64bit.

This is 64-bit Linux, yes:

server$ uname -a
Linux greed.fud.no 3.14.0-031400rc2-generic #201402092235 SMP Mon Feb 10 03:37:33 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Tore

