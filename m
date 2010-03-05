From: Stefan Monnier <monnier@...1268...>
Date: Fri, 05 Mar 2010 16:17:12 -0500
Message-ID: <jwvwrxq1nk3.fsf-monnier+gmane.network.openvpn.devel@...1269...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<4B8BB647.2020804@...1114...>
	<23627cf8.610acd4b.4b8bc540.d2023@...1309...>
	<eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
	<7cd17813.52db77fa.4b901800.4e59d@...1309...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] Openvpn 2.1.1 bad tcp performance but good
	pingwhen -l 1472 (with packet size = MTU)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

> because i really believe in open source software I've decided to check
> all sorts of configurations to check problems with tcp tunneling.

This makes it sound like OpenVPN's performance is lower than some
comparable non-Free software.
Have you actually compared OpenVPN's performance to some other
TCP-tunnel solution?  That would be instructive since it may point to
ways to improve the TCP support.

I know in general OpenVPN discourages the use of TCP tunnels and for
good reasons, but the support for TCP tunnels is also one of the
strengths of OpenVPN, making it usable even with the most
uncooperative firewalls.


        Stefan


