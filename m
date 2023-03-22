From: Antonio Quartulli <a@...2181...>
Date: Wed, 22 Mar 2023 20:27:33 +0100
Message-Id: <20230322192733.20295-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dco-freebsd: use m->instances[] instead
 of m->hash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>, Kristof Provost <kp@...1376...>

When retrieving the multi_instance of a specific peer,
there is no need to peform a linear search across the
whole m->hash list. We can directly access the needed
object via m->instances[peer-id] in constant time (and
just one line of code).

Adapt the dco-freebsd code to do so.

Cc: Kristof Provost <kp@...1376...>
Change-Id: I8d8af6f872146604a9710edf443db65df48ac3cb
Signed-off-by: Antonio Quartulli <a@...2181...>
---
NOTE: not tested because I have no FreeBSD environment

Changes from v1:
* added boundary check on peer-id

Changes from v2:
* use one check only instead of two
---
 src/openvpn/dco_freebsd.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 225b3cf8..54ec16ff 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -674,27 +674,18 @@ dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 static void
 dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
 {
-    struct hash_element *he;
-    struct hash_iterator hi;
 
-    hash_iterator_init(m->hash, &hi);
-
-    while ((he = hash_iterator_next(&hi)))
+    if (peer_id >= m->max_clients || !m->instances[peer_id])
     {
-        struct multi_instance *mi = (struct multi_instance *) he->value;
-
-        if (mi->context.c2.tls_multi->peer_id != peerid)
-        {
-            continue;
-        }
-
-        mi->context.c2.dco_read_bytes = nvlist_get_number(nvl, "in");
-        mi->context.c2.dco_write_bytes = nvlist_get_number(nvl, "out");
-
+        msg(M_WARN, "Cannot store DCO stats for peer %u",
+            peerid);
         return;
     }
 
-    msg(M_INFO, "Peer %d returned by kernel, but not found locally", peerid);
+    struct multi_instance *mi = m->instances[peer_id];
+
+    mi->context.c2.dco_read_bytes = nvlist_get_number(nvl, "in");
+    mi->context.c2.dco_write_bytes = nvlist_get_number(nvl, "out");
 }
 
 int
-- 
2.39.2


