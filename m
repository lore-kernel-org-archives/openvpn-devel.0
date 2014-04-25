From: Gert Doering <gert@...1296...>
Date: Fri, 25 Apr 2014 21:19:15 +0200
Message-Id: <1398453555-19706-1-git-send-email-gert@...1296...>
In-Reply-To: <1398452943-18426-1-git-send-email-gert@...1296...>
References: <1398452943-18426-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Rewrite manpage section about --multihome
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

Part of the information was confusing, part was outdated, and part was
just not making sense.  Pointed out in trac#348.

Also add note about Linux IPv4-mapped issues as per trac#306.

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8 | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index ae3a4e0..29bfda3 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2343,18 +2343,22 @@ is NOT specified.
 .\"*********************************************************
 .TP
 .B \-\-multihome
-Configure a multi-homed UDP server.  This option can be used when
-OpenVPN has been configured to listen on all interfaces, and will
-attempt to bind client sessions to the interface on which packets
-are being received, so that outgoing packets will be sent out
-of the same interface.  Note that this option is only relevant for
-UDP servers and currently is only implemented on Linux.
-
-Note: clients connecting to a
-.B \-\-multihome
-server should always use the
-.B \-\-nobind
-option.
+Configure a multi-homed UDP server.  This option needs to be used when
+a server has more than one IP address (e.g. multiple interfaces, or
+secondary IP addresses), and is not using
+.B \-\-local 
+to force binding to one specific address only.  This option will 
+add some extra lookups to the packet path to ensure that the UDP reply 
+packets are always sent from the address that the client is 
+talking to. This is not supported on all platforms, and it adds more
+processing, so it's not enabled by default.
+
+Note: this option is only relevant for UDP servers.
+
+Note 2: if you do an IPv6+IPv4 dual-stack bind on a Linux machine with 
+multiple IPv4 address, connections to IPv4 addresses will not work 
+right on kernels before 3.14, due to missing kernel support for the 
+IPv4-mapped case.
 .\"*********************************************************
 .TP
 .B \-\-echo [parms...]
-- 
1.8.3.2


