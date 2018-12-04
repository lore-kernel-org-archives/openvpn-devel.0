Date: Tue, 4 Dec 2018 21:30:09 +0100 (CET)
Message-Id: <201812042030.wB4KU9lD053222@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181203164818.15756-1-arne@...1227...>
References: <20181203164818.15756-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared at the code (long and hard, especially the changes to udp_checksum()
- which is a welcome generalization).  Looks all reasonable.  One of the
changes was uncrustify wrapping the call to process_ip_header() - which
looked ugly before, and looks ugly afterwards, but that's not your fault.

What I like quite a lot is that this patch does not auto-add an IPv6 
default route - it looked like a "why, we could do this automatically?"
initially, but is coming handy if you want more selective blocking.

Tested with tun on linux, and tap on FreeBSD.  Works nicely (*).

Stared at the synthesized ICMPv6 packet with tcpdump and wireshark, and
both tools tell me "the packet is good" ;-)

I have test compiled for Windows (mingw).  Builds fine.  Have not 
actually run the resulting binary, but given that the changes are 
fully platform independent, I expect no issues here.


Server mode --block-ipv6 doesn't work correctly for me, though  (but I've 
decided to move this towards a separate patch as it isn't blocking client 
side functionality and not breaking "normal" operation).

I run a "standard tun server" on linux, with --server, and --block-ipv6.

The server assigns a v6 address to the client, the client sends a packet
into the tunnel:

21:15:47.179356 IP6 2001:608:3:814::1000 > 2001:608::2: ICMP6, echo request, seq 1, length 64

.. and I can see it come out of the server's tun interface towards linux:

21:15:47.192493 IP6 2001:608:3:814::1000 > 2001:608::2: ICMP6, echo request, seq 1, length 64

.. the target hosts answers, and the answer is routed into the server's
tun interface:

21:15:47.192993 IP6 2001:608::2 > 2001:608:3:814::1000: ICMP6, echo reply, seq 1, length 64

.. and then the server tells the remote IPv6 host that "no, my client is
not there"

21:15:47.193030 IP6 2001:608:3:814::2 > 2001:608::2: ICMP6, destination unreachable, unreachable route 2001:608:3:814::1000, length 112

.. but no ICMPv6 packet is ever sent towards the client.  Looks like the
multi.c code is somewhat confused about directions...  without block-ipv6
on the server, things work normally...

21:20:28.961067 IP6 2001:608:3:814::1000 > 2001:608::2: ICMP6, echo request, seq 1, length 64
21:20:28.961568 IP6 2001:608::2 > 2001:608:3:814::1000: ICMP6, echo reply, seq 1, length 64
21:20:29.963421 IP6 2001:608:3:814::1000 > 2001:608::2: ICMP6, echo request, seq 2, length 64
21:20:29.963933 IP6 2001:608::2 > 2001:608:3:814::1000: ICMP6, echo reply, seq 2, length 64



Tap mode might need a bit of tweaking as well - it does work, but it
blocks ND packets, instead of "user payload" (TCP SYN)...

21:22:23.923360 IP6 fd00:abcd:194:4::1007 > ff02::1:ff00:1: ICMP6, neighbor solicitation, who has fd00:abcd:194:4::1, length 32
21:22:23.923375 IP6 fd00:abcd:194:4::1 > fd00:abcd:194:4::1007: ICMP6, destination unreachable, unreachable route ff02::1:ff00:1, length 80

.. so you do not get back a "fast fail" on the payload, but it fails 
after ND timeout...

traceroute6 to fd00:abcd:194:4::1 (fd00:abcd:194:4::1) from fd00:abcd:194:4::1007, 64 hops max, 12 byte packets
 1  fd00:abcd:194:4::1007 (fd00:abcd:194:4::1007)  3058.434 ms !A  3038.031 ms !A  3055.928 ms !A

.. so while it works, it's not as nice as it could be - maybe we should
multicast packets (destination ff02::) just pass through in tap mode, so
a ND relationship with the remote can be established?  If I install a
manual ND entry, I get the proper "quick fail from the right source":

21:27:38.686757 IP6 fd00:abcd:194:4::1007.29319 > fd00:abcd:194:4::1.33437: UDP, length 12
21:27:38.686765 IP6 fd00:abcd:194:4::1 > fd00:abcd:194:4::1007: ICMP6, destination unreachable, unreachable route fd00:abcd:194:4::1, length 68

traceroute6 to fd00:abcd:194:4::1 (fd00:abcd:194:4::1) from fd00:abcd:194:4::1007, 64 hops max, 12 byte packets
 1  fd00:abcd:194:4::1 (fd00:abcd:194:4::1)  0.113 ms !N  0.072 ms !N  0.057 ms !N

$ telnet fd00:abcd:194:4::1 22
Trying fd00:abcd:194:4::1...
telnet: connect to address fd00:abcd:194:4::1: No route to host
telnet: Unable to connect to remote host


Anyway.  Room for improvement :-)

Your patch has been applied to the master branch.

commit e11d2d14a9ef5311f791a9a614ab367c6f50ff11 (master)
Author: Arne Schwabe
Date:   Mon Dec 3 17:48:18 2018 +0100

     Implement block-ipv6

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181203164818.15756-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17977.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


