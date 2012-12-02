From: Gert Doering <gert@...1296...>
Date: Sun,  2 Dec 2012 22:11:11 +0100
Message-Id: <1354482672-16136-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] Implement --mssfix handling for IPv6 packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

in the next mail you'll find a patch to extend the existing --mssfix
code to handle IPv6 packets as well.

The actual mssfix implementation is only about half the change, but I
took the liberty to rename process_ipv4_header() to process_ip_header(),
and (after discussion on IRC) the PIPV4_MSSFIX flag to PIP_MSSFIX - to
make it obvious that this is no longer "IPv4 only".

The code has been tested on our corporate VPN server for 3 days now,
and did what advertised - adjusted MSS; not breaking anything else.  It
does fix the connectivity problems one of my users had - sitting behind a
router with broken PMTU handling *and* broken IPv4 fragment handling,
which killed IPv6 SSH-Sessions (all crypted, not compressible) quite
reliably.

Testing this is a bit tricky - the t_client framework won't cover it
(as it doesn't do TCP payload tests yet), so to actually *see* the
change you either need to have a broken network wrt IPv4 PMTU/fragment
handling before, or look at TCP SYN / SYN ACK packets with wireshark.

Anyway, I believe it's ready for inclusion in RC2, and should most 
definitely be in 2.3-RELEASE (as we'll see more users with broken
networks then).

gert


