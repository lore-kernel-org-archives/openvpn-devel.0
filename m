Message-ID: <01c101c225f3$932d10c0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Default MTU
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Sun Jul  7 13:18:01 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

What should the default MTU be?

Right now the default UDP MTU is 1500 if you use --ifconfig, which is
probably too high, because as Matthias Andree pointed out, 1500 + IP header
size is greater than 1500 and will cause fragmentation on ethernet networks
where the MTU is 1500.

1450 might make more sense because that leaves ample space for the IP
header, forming a total packet size of less than 1500.

Then again there are arguments for even lower values, 1350 or 1300 to allow
multiple levels of encapsulation such as PPPoE, IP, ethernet, etc.

It would also be possible to set the MTU automatically through some sort of
initial or ongoing handshake that does secure pings of various packet sizes
with the Don't Fragment bit set to determine the optimal MTU for the path
(i.e. Secure Path MTU Discovery).

With OpenVPN however, there are some complications to the automatic Path MTU
discovery approach:

(1) Static, pre-shared key mode is stateless and handshake-free, so there
isn't really an existing context in which PMTU discovery could be
implemented.

(2) Path MTU discovery could work in TLS mode, however every time the the
MTU changes, the tun or tap device would need to be re-ifconfiged -- this
might also involve closing and reopening the tun device which would fail if
root privileges have been dropped.

(3) Path MTU discovery in a secure application such as a VPN must itself be
secure to protect against DoS attacks, so the standard garden-variety PMTU
approaches that depend on return ICMP packets probably won't work securely
or reliably.

So at this point a static default is certainly the simpler way to go, but
any changes to the static default should be carefully considered since they
would introduce backward incompatibility issues.

Comments?

James



