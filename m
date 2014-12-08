From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  8 Dec 2014 19:06:02 +0200
Message-Id: <1418058362-13480-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Add the peer-id to the output of the status
	command
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

This adds peer-id to the status output which might help analyze floating
logs. This will change the output of status in the same way commit
662ce6acc065bddf6490b3494725b8b3987b7def did.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/multi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 538f4f1..b7785c1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -815,8 +815,8 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 	   */
 	  status_printf (so, "TITLE%c%s", sep, title_string);
 	  status_printf (so, "TIME%c%s%c%u", sep, time_string (now, 0, false, &gc_top), sep, (unsigned int)now);
-	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID",
-			 sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
+	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID",
+			 sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
 	  hash_iterator_init (m->hash, &hi);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
@@ -827,10 +827,11 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 		{
 		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c%s%c" counter_format "%c" counter_format "%c%s%c%u%c%s%c"
 #ifdef MANAGEMENT_DEF_AUTH
-				 "%lu",
+				 "%lu"
 #else
-				 "",
+				 ""
 #endif
+				 "%c%"PRIu32,
 				 sep, tls_common_name (mi->context.c2.tls_multi, false),
 				 sep, mroute_addr_print (&mi->real, &gc),
 				 sep, print_in_addr_t (mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc),
@@ -841,10 +842,11 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 				 sep, (unsigned int)mi->created,
 				 sep, tls_username (mi->context.c2.tls_multi, false),
 #ifdef MANAGEMENT_DEF_AUTH
-				 sep, mi->context.c2.mda_context.cid);
+				 sep, mi->context.c2.mda_context.cid,
 #else
-				 sep);
+				 sep,
 #endif
+				 sep, mi->context.c2.tls_multi ? mi->context.c2.tls_multi->peer_id : UINT32_MAX);
 		}
 	      gc_free (&gc);
 	    }
-- 
1.9.1


