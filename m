From: Steffan Karger <steffan@...1856...>
Date: Sat,  7 Mar 2015 17:23:11 +0100
Message-Id: <1425745391-8069-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Change float log message to include common
	name, if available.
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

Makes it a lot easier to see which client is floating.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/multi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4412491..b0f66ca 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2151,8 +2151,11 @@ void multi_process_float (struct multi_context* m, struct multi_instance* mi)
       multi_close_instance(m, ex_mi, false);
     }
 
-    msg (D_MULTI_MEDIUM, "peer %" PRIu32 " floated from %s to %s", mi->context.c2.tls_multi->peer_id,
-        mroute_addr_print (&mi->real, &gc), print_link_socket_actual (&m->top.c2.from, &gc));
+    msg (D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
+	mi->context.c2.tls_multi->peer_id,
+	tls_common_name (mi->context.c2.tls_multi, false),
+	mroute_addr_print (&mi->real, &gc),
+	print_link_socket_actual (&m->top.c2.from, &gc));
 
     ASSERT (hash_remove(m->hash, &mi->real));
     ASSERT (hash_remove(m->iter, &mi->real));
-- 
2.1.0


