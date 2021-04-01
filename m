From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:35 +0200
Message-Id: <20210401131337.3684-13-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 12/14] Extract multi_assign_peer_id into its
 own function
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

This makes multi_get_create_instance_udp a bit shorter and better
structured and also prepares this method to be called from the
mutlti TCP context with DCO which will also need to assign unique peer
ids to instances.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mudp.c  | 20 +-------------------
 src/openvpn/multi.c | 21 +++++++++++++++++++++
 src/openvpn/multi.h | 10 ++++++++++
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 90e32a8ec..9225d42de 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -103,27 +103,9 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
                     mi = multi_create_instance(m, &real);
                     if (mi)
                     {
-                        int i;
-
                         hash_add_fast(hash, bucket, &mi->real, hv, mi);
                         mi->did_real_hash = true;
-
-                        /* max_clients must be less then max peer-id value */
-                        ASSERT(m->max_clients < MAX_PEER_ID);
-
-                        for (i = 0; i < m->max_clients; ++i)
-                        {
-                            if (!m->instances[i])
-                            {
-                                mi->context.c2.tls_multi->peer_id = i;
-                                m->instances[i] = mi;
-                                break;
-                            }
-                        }
-
-                        /* should not really end up here, since multi_create_instance returns null
-                         * if amount of clients exceeds max_clients */
-                        ASSERT(i < m->max_clients);
+                        multi_assign_peer_id(m, mi);
                     }
                 }
                 else
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 071bd5b61..d4c5304cb 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4016,6 +4016,27 @@ init_management_callback_multi(struct multi_context *m)
 #endif /* ifdef ENABLE_MANAGEMENT */
 }
 
+void multi_assign_peer_id(struct multi_context *m, struct multi_instance *mi)
+{
+    /* max_clients must be less then max peer-id value */
+    ASSERT(m->max_clients < MAX_PEER_ID);
+
+    for (int i = 0; i < m->max_clients; ++i)
+    {
+        if (!m->instances[i])
+        {
+            mi->context.c2.tls_multi->peer_id = i;
+            m->instances[i] = mi;
+            break;
+        }
+    }
+
+    /* should not really end up here, since multi_create_instance returns null
+     * if amount of clients exceeds max_clients */
+    ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
+}
+
+
 /*
  * Top level event loop.
  */
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index b7078b711..9d771f537 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -676,5 +676,15 @@ multi_set_pending(struct multi_context *m, struct multi_instance *mi)
 {
     m->pending = mi;
 }
+/**
+ * Assigns a peer-id to a a client and adds the instance to the
+ * the instances array of the \c multi_context structure.
+ *
+ * @param m            - The single \c multi_context structure.
+ * @param mi           - The \c multi_instance of the VPN tunnel to be
+ *                       postprocessed.
+ */
+void multi_assign_peer_id(struct multi_context *m, struct multi_instance *mi);
+
 
 #endif /* MULTI_H */
-- 
2.30.1


