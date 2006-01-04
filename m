From: UMEZAWA Takeshi <umezawa@...528...>
Message-Id: <20060104171034.2187.UMEZAWA@...528...>
MIME-Version: 1.0
Subject: [Openvpn-devel] feature request: "tcp-nodelay" option
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
Date: Wed Jan  4 00:25:07 2006
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello, all.

It would be nice if we can set TCP_NODELAY socket option for tunnel
connection when OpenVPN uses TCP transport, in order to achieve smaller
latency rather than higher throughput.

I think that it is not a good way to set this option in
create_socket_tcp() (in socket.c), because it also set the option for
management connection...

--------------------------------------------------------------------
UMEZAWA Takeshi (FAMILY Given) <umezawa@...528...>
Internet Initiative Japan Inc.
PGP fingerprint = E9B1 4E6F 5E5F 6487 B93D  3FC6 1ACF C167 9D68 3E90


