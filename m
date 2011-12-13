From: David Sommerseth <davids@...1347...>
Date: Tue, 13 Dec 2011 18:14:00 +0100
Message-Id: <1323796440-15966-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Only warn about non-tackled IPv6 packets
	once
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

When using OpenVPN 2.2 on clients and server with Windows based
clients, it will try to push IPv6 packets through the tunnel.  This
causes the server log to be filled up with log entries like this:

 Wed Jun 29 22:12:51 2011 username/1.2.3.4:56990 Need IPv6 code in mroute_extract_addr_from_packet

This patch modifies this message to state that IPv6 packets are not
tackled in tun mode, and prints it only once.

Trac: 147
Signed-off-by: David Sommerseth <davids@...1347...>
---
 mroute.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/mroute.c b/mroute.c
index 3debd80..1b3488f 100644
--- a/mroute.c
+++ b/mroute.c
@@ -131,6 +131,8 @@ mroute_extract_addr_ipv4 (struct mroute_addr *src,
 			  const struct buffer *buf)
 {
   unsigned int ret = 0;
+  static bool ipv6warned = false;
+
   if (BLEN (buf) >= 1)
     {
       switch (OPENVPN_IPH_GET_VER (*BPTR(buf)))
@@ -156,7 +158,10 @@ mroute_extract_addr_ipv4 (struct mroute_addr *src,
 	  break;
 	case 6:
 	  {
-	    msg (M_WARN, "Need IPv6 code in mroute_extract_addr_from_packet"); 
+            if( !ipv6warned ) {
+              msg (M_WARN, "IPv6 in tun mode is not supported in OpenVPN 2.2");
+              ipv6warned = true;
+            }
 	    break;
 	  }
 	}
-- 
1.7.4.4


