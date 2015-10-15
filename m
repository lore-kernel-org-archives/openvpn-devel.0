From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 15 Oct 2015 14:39:42 +0300
Message-Id: <1444909182-11785-1-git-send-email-lstipakov@...277...>
In-Reply-To: <60699f4eca75467393d238a6dfb55801@...2037...>
References: <60699f4eca75467393d238a6dfb55801@...2037...>
Subject: [Openvpn-devel] [PATCH] Refine float logging
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

v2:
 * Bump log level for attack attempt message
 * More clear message for float event

v1:
 * Decrease log level for peer float message

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/mudp.c  | 2 +-
 src/openvpn/multi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 3aed3a0..ce67206 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -79,7 +79,7 @@ multi_get_create_instance_udp (struct multi_context *m, bool *floated)
 	      {
 		/* reset prefix, since here we are not sure peer is the one it claims to be */
 		ungenerate_prefix(mi);
-		msg (D_MULTI_ERRORS, "Untrusted peer %" PRIu32 " wants to float to %s", peer_id,
+		msg (D_MULTI_MEDIUM, "Float requested for peer %" PRIu32 " to %s", peer_id,
 			mroute_addr_print (&real, &gc));
 	      }
 	    }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 05c36db..7c3aaac 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2286,7 +2286,7 @@ void multi_process_float (struct multi_context* m, struct multi_instance* mi)
       /* do not float if target address is taken by client with another cert */
       if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
 	{
-	  msg (D_MULTI_MEDIUM, "Disallow float to an address taken by another client %s",
+	  msg (D_MULTI_LOW, "Disallow float to an address taken by another client %s",
 	       multi_instance_string (ex_mi, false, &gc));
 
 	  mi->context.c2.buf.len = 0;
-- 
1.9.1


