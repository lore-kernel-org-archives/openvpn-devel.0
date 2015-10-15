From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 15 Oct 2015 13:39:28 +0300
Message-Id: <1444905568-3300-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Decrease log level for peer float message
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

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/mudp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 3aed3a0..9fa9f9e 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -79,7 +79,7 @@ multi_get_create_instance_udp (struct multi_context *m, bool *floated)
 	      {
 		/* reset prefix, since here we are not sure peer is the one it claims to be */
 		ungenerate_prefix(mi);
-		msg (D_MULTI_ERRORS, "Untrusted peer %" PRIu32 " wants to float to %s", peer_id,
+		msg (D_MULTI_MEDIUM, "Untrusted peer %" PRIu32 " wants to float to %s", peer_id,
 			mroute_addr_print (&real, &gc));
 	      }
 	    }
-- 
1.9.1


