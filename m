Message-ID: <558D8663.6000308@...1516...>
Date: Fri, 26 Jun 2015 19:05:39 +0200
From: Holger Kummert <Holger.Kummert@...1516...>
MIME-Version: 1.0
References: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
	<20150626073544.GT382@...1296...> <558D2D98.70905@...1516...>
	<20150626112401.GU382@...1296...>
In-Reply-To: <20150626112401.GU382@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Del ipv6 addr on close of linux tun
	interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Hello,

Am 26.06.2015 um 13:24 schrieb Gert Doering:
> And I actually *do* test for this in one of my t_client test runs... :-)
>
> openvpn --client ... --nobind --comp-lzo --verb 3 --dev tun3 --proto tcp6-client --remote conn-test-server.openvpn.org --port 51194 --server-poll-timeout 10
>
> ... and it "just works" - "ip -6 addr add ... dev tun3" on connect, nothing
> special on disconnect, and "no problems" (on Gentoo Linux, but "ip" should
> be sufficiently standard):
>
> Fri Jun 26 13:18:05 2015 /bin/ip -6 addr add fd00:abcd:194:1::100c/64 dev tun3
> Fri Jun 26 13:18:05 2015 /bin/ip -6 route add fd00:abcd:194::/48 dev tun3
> ...
> Fri Jun 26 13:18:46 2015 event_wait : Interrupted system call (code=4)
> Fri Jun 26 13:18:46 2015 /bin/ip route del 10.194.0.0/16
> Fri Jun 26 13:18:46 2015 /bin/ip route del 10.194.1.1/32
> Fri Jun 26 13:18:46 2015 delete_route_ipv6(fd00:abcd:194::/48)
> Fri Jun 26 13:18:46 2015 /bin/ip -6 route del fd00:abcd:194::/48 dev tun3
> Fri Jun 26 13:18:46 2015 Closing TUN/TAP interface
> Fri Jun 26 13:18:46 2015 /bin/ip addr del dev tun3 local 10.194.1.54 peer 10.194.1.53
>
> So, what is different on your end?  Why is the tun<x> keeping its address?

This looks similar on my machine. But the difference comes when after
the disconnect a new connect is forced which failed on my site.


Holger

