From: Gert Doering <gert@...1296...>
Date: Sat, 16 Nov 2013 18:53:21 +0100
Message-Id: <1384624401-27943-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix IPv6 examples in t_client.rc-sample
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

IPv6 documentation prefix is 2001:db*8*:: (not :dba:), and the second
test stanza variables need to end in _2, of course...

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.rc-sample | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index dcb3e4a..6e66607 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -59,18 +59,18 @@ OPENVPN_BASE_P2P="..."
 RUN_TITLE_1="testing tun/udp/ipv4+ipv6"
 OPENVPN_CONF_1="$OPENVPN_BASE_P2MP --dev tun --proto udp --remote $REMOTE --port 51194"
 EXPECT_IFCONFIG4_1="10.100.50.6"
-EXPECT_IFCONFIG6_1="2001:dba:a050::1:0"
+EXPECT_IFCONFIG6_1="2001:db8:a050::1:0"
 PING4_HOSTS_1="10.100.50.1 10.100.0.1"
-PING6_HOSTS_1="2001:dba::1 2001:dba:a050::1"
+PING6_HOSTS_1="2001:db8::1 2001:db8:a050::1"
 
 # Test 2: TCP / p2mp tun
 #
 RUN_TITLE_2="testing tun/tcp/ipv4+ipv6"
 OPENVPN_CONF_2="$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMOTE --port 51194"
 EXPECT_IFCONFIG4_2="10.100.51.6"
-EXPECT_IFCONFIG6_2="2001:dba:a051::1:0"
+EXPECT_IFCONFIG6_2="2001:db8:a051::1:0"
 PING4_HOSTS_2="10.100.51.1 10.100.0.1"
-PING6_HOSTS_1="2001:dba::1 2001:dba:a051::1"
+PING6_HOSTS_2="2001:db8::1 2001:db8:a051::1"
 
 # Test 3: UDP / p2p tun
 # ...
-- 
1.8.1.5


