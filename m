From: Steffan Karger <steffan@...1856...>
Date: Tue,  8 Nov 2016 21:07:43 +0100
Message-Id: <1478635663-5837-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix missing return value checks in
	multi_process_float()
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

Fix the missing return value checks on hash_remove() and hash_add() by
replacing the calls with an single hash_add() call with the replace
parameters set to true so that is can't fail.  Then just ASSERT() that
this is indeed the case.

This also replaces the other add/remove combinations with a single
add-replace, because that should be slightly faster (and this is in the
'hot path').

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/multi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 93a554d..a834e94 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2320,9 +2320,6 @@ void multi_process_float (struct multi_context* m, struct multi_instance* mi)
 	mroute_addr_print (&mi->real, &gc),
 	print_link_socket_actual (&m->top.c2.from, &gc));
 
-    ASSERT (hash_remove(m->hash, &mi->real));
-    ASSERT (hash_remove(m->iter, &mi->real));
-
     /* change external network address of the remote peer */
     mi->real = real;
     generate_prefix (mi);
@@ -2336,12 +2333,11 @@ void multi_process_float (struct multi_context* m, struct multi_instance* mi)
 
     tls_update_remote_addr (mi->context.c2.tls_multi, &mi->context.c2.from);
 
-    ASSERT (hash_add (m->hash, &mi->real, mi, false));
-    ASSERT (hash_add (m->iter, &mi->real, mi, false));
+    ASSERT (hash_add (m->hash, &mi->real, mi, true));
+    ASSERT (hash_add (m->iter, &mi->real, mi, true));
 
 #ifdef MANAGEMENT_DEF_AUTH
-    hash_remove (m->cid_hash, &mi->context.c2.mda_context.cid);
-    hash_add (m->cid_hash, &mi->context.c2.mda_context.cid, mi, false);
+    ASSERT (hash_add (m->cid_hash, &mi->context.c2.mda_context.cid, mi, true));
 #endif
 
 done:
-- 
2.7.4


