From: Gert Doering <gert@...1296...>
Date: Sat, 26 Apr 2014 13:30:54 +0200
Message-Id: <1398511854-3609-1-git-send-email-gert@...1296...>
In-Reply-To: <535B762A.8050200@...1790...>
References: <535B762A.8050200@...1790...>
Subject: [Openvpn-devel] [PATCH] More IPv6-related updates to the openvpn
	man page.
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

Point to correct kernel version for --multihome and IPv4-mapped
addresses (3.15, Tore Anderson).

Remove old reference to http://www.greenie.net/ from the IPv6 section,
as the code and documentation in here is more current than on that site.
Some more additions and clarifications.

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8 | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 29bfda3..8cddcec 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2357,8 +2357,9 @@ Note: this option is only relevant for UDP servers.
 
 Note 2: if you do an IPv6+IPv4 dual-stack bind on a Linux machine with 
 multiple IPv4 address, connections to IPv4 addresses will not work 
-right on kernels before 3.14, due to missing kernel support for the 
-IPv4-mapped case.
+right on kernels before 3.15, due to missing kernel support for the
+IPv4-mapped case (some distributions have ported this to earlier kernel
+versions, though).
 .\"*********************************************************
 .TP
 .B \-\-echo [parms...]
@@ -5471,9 +5472,11 @@ option can be used BEFORE this option to produce debugging information.
 .SS IPv6 Related Options
 .\"*********************************************************
 The following options exist to support IPv6 tunneling in peer-to-peer
-and client-server mode.  As of now, this is just very basic
-documentation of the IPv6-related options. More documentation can be
-found on http://www.greenie.net/ipv6/openvpn.html.
+and client-server mode.  All options are modeled after their IPv4
+counterparts, so more detailed explanations given there apply here
+as well (except for
+.B \-\-topology
+, which has no effect on IPv6).
 .TP
 .B --ifconfig-ipv6 ipv6addr/bits ipv6remote
 configure IPv6 address
@@ -5504,7 +5507,8 @@ pool starts at
 .B ipv6addr
 and increments by +1 for every new client (linear mode).  The
 .B /bits
-setting controls the size of the pool.
+setting controls the size of the pool.  Due to implementation details,
+the pool size must be between /64 and /112.
 .TP
 .B --ifconfig-ipv6-push ipv6addr/bits ipv6remote
 for ccd/ per-client static IPv6 interface configuration, see
-- 
1.8.3.2


