Message-Id: <200302222247.h1MMlsf13982@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] MTU
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Feb 22 14:49:06 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Matthias Andree <matthias.andree@...68...>

Recently I've been taking a new look at MTU issues.  It seems that some people
are having problems lately that are related to MTU or PMTU discovery.

I was trying to think up some ways to make OpenVPN's handling of MTU a bit
less opaque, more automatic, and also give more manual control to those who
know what they're doing.

I have some preliminary code in the CVS (under branch MTU_EXPERIMENTAL) that
adds an option (--mtu-disc) that gives manual control over whether path MTU
discovery is performed on the UDP link.  I also borrowed some code from
tracepath to print the discovered PMTU size on UDP read/write errors. 
Unfortunately, I'm not sure whether this code will work on non-Linux OSes. 
See mtu.c for more info.

I've also considered ways of making OpenVPN's MTU calculation more automatic
without relying on PMTU which is often broken due to over-restrictive
firewalls in the path that block ICMP messages.  PMTU also lacks DoS
resilience.  One way might be to do our own PMTU discovery by transmitting
various sized packets over the UDP channel and having the remote peer report
back on the largest packet it received.  One problem is that MTU size could
change during a session, necessitating a re-ifconfig of the TUN/TAP device,
which may not be possible on some platforms and breaks --user/--group nobody.
 This might be handled in a way similar to --ping-restart or SIGHUP/SIGUSR1,
where the openvpn daemon would essentially restart if the MTU size changed. 
This would be effective if path MTU changes are infrequent but still creates
problems when --user/--group nobody is used, since the openvpn daemon will
lack sufficient privilege to reopen and re-ifconfig the TUN/TAP device.

Comments?

James


