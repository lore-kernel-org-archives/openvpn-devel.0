From: Steffan Karger <steffan@...1856...>
Date: Sat, 19 Nov 2016 18:12:46 +0100
Message-Id: <1479575566-21198-1-git-send-email-steffan@...1856...>
In-Reply-To: <1479309879-6921-1-git-send-email-davids@...515...>
References: <1479309879-6921-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] multi_process_float: revert part of c14c4a9e
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

Commit c14c4a9e merged the hash_remove() and hash_add() calls in
multi_process_float(), but didn't notice that the hash key (mi->real) was
updated between these calls.  So we now try to remove the *new* address
instead of the *old* address from the hash table.  This leaks memory and
might break stuff when a different client floats to the old address/port of
this client.  Restore that.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/multi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8f3d34e..4fc8b02 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2317,6 +2317,10 @@ void multi_process_float (struct multi_context* m, struct multi_instance* mi)
 	mroute_addr_print (&mi->real, &gc),
 	print_link_socket_actual (&m->top.c2.from, &gc));
 
+    /* remove old address from hash table before changing address */
+    ASSERT (hash_remove (m->hash, &mi->real));
+    ASSERT (hash_remove (m->iter, &mi->real));
+
     /* change external network address of the remote peer */
     mi->real = real;
     generate_prefix (mi);
@@ -2330,8 +2334,8 @@ void multi_process_float (struct multi_context* m, struct multi_instance* mi)
 
     tls_update_remote_addr (mi->context.c2.tls_multi, &mi->context.c2.from);
 
-    ASSERT (hash_add (m->hash, &mi->real, mi, true));
-    ASSERT (hash_add (m->iter, &mi->real, mi, true));
+    ASSERT (hash_add (m->hash, &mi->real, mi, false));
+    ASSERT (hash_add (m->iter, &mi->real, mi, false));
 
 #ifdef MANAGEMENT_DEF_AUTH
     ASSERT (hash_add (m->cid_hash, &mi->context.c2.mda_context.cid, mi, true));
-- 
2.7.4


