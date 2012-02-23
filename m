Message-ID: <4F4601A5.3080203@...1549...>
Date: Thu, 23 Feb 2012 10:06:45 +0100
From: Freek Dijkstra <public@...1549...>
MIME-Version: 1.0
References: <4F438CF2.1060305@...515...>
In-Reply-To: <4F438CF2.1060305@...515...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 preview 1
	installer now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn developers <openvpn-devel@lists.sourceforge.net>

Reporting that
http://build.openvpn.net/downloads/releases/openvpn-2.3-alpha1.tar.gz
compiles and runs fine for me.

(after I manully installed lzo manually)

Running Mac OS 10.7.2:
% uname -mrsv
Darwin 11.3.0 Darwin Kernel Version 11.3.0: Thu Jan 12 18:47:41 PST
2012; root:xnu-1699.24.23~1/RELEASE_X86_64 x86_64


The only comment I have is some confusing messages on the command line.
The first time I ran

% openvpn --config config.conf
it failed with:

NOTE: explicit support for IPv6 tun devices is not provided for this OS
Cannot allocate TUN/TAP dev dynamically

It turns out I just forgot to run openvpn as root, and the first message
seems incorrect (IPv6 does seem to work fine, see below):

% sudo openvpn --config config.conf
...
NOTE: explicit support for IPv6 tun devices is not provided for this OS
TUN/TAP device /dev/tun0 opened
...


My recommendation is to:

1. Remove the "NOTE: explicit support for IPv6 tun devices is not
provided for this OS"

2. If possible, add a message about the cause to the "Cannot allocate
TUN/TAP dev dynamically" message (e.g. "permission denied" or "no tun
interface available" ,...)

Regards,
Freek Dijkstra


Indeed IPv6 seems to work:

...
do_ifconfig, tt->ipv6=1, tt->did_ifconfig_ipv6_setup=1
/sbin/ifconfig tun0 inet6 2001:610:767:1975::4/64
add_route_ipv6(2001:610:767:fd::/64 -> 2001:610:767:1975::1 metric 0)
dev tun0
...

% route get -inet6 2001:610:767:fd::70
   route to: 2001:610:767:fd::70
destination: 2001:610:767:fd::
       mask: ffff:ffff:ffff:ffff::
  interface: tun0

And:
% ping6 2001:610:767:fd::70
PING6(56=40+8+8 bytes) 2001:610:767:1975::4 --> 2001:610:767:fd::70
16 bytes from 2001:610:767:fd::70, icmp_seq=0 hlim=63 time=7.678 ms
16 bytes from 2001:610:767:fd::70, icmp_seq=1 hlim=63 time=5.728 ms
16 bytes from 2001:610:767:fd::70, icmp_seq=2 hlim=63 time=4.167 ms
--- 2001:610:767:fd::70 ping6 statistics ---
3 packets transmitted, 3 packets received, 0.0% packet loss


