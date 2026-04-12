From: Gert Doering <gert@...1296...>
Date: Sun, 12 Apr 2026 14:53:50 +0200
Message-ID: <20260412125356.32261-1-gert@...1296...>
In-Reply-To: <gerrit.1772721382000.If797f3fe178fba3f43fb12898e5484bfb38f05c3@...2715...>
References: <gerrit.1772721382000.If797f3fe178fba3f43fb12898e5484bfb38f05c3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] Optimise iterating over all clients by
 remembering highest peer id
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

From: Arne Schwabe <arne@...1227...>

This keeps track of the highest peer id that is currently allocated to avoid
iterating over the empty tail of the m->instances array.

Change-Id: If797f3fe178fba3f43fb12898e5484bfb38f05c3
Signed-off-by: Arne Schwabe <arne@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1557
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1557
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9d4ea49..c03e821 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -601,6 +601,13 @@
         if (mi->context.c2.tls_multi->peer_id != MAX_PEER_ID)
         {
             m->instances[mi->context.c2.tls_multi->peer_id] = NULL;
+
+            /* Adjust the max_peerid as this might have been the highest
+             * peer id instance */
+            while (m->max_peerid > 0 && m->instances[m->max_peerid] == NULL)
+            {
+                m->max_peerid--;
+            }
         }
 
         schedule_remove_entry(m->schedule, (struct schedule_entry *)mi);
@@ -652,7 +659,7 @@
 {
     if (m->hash)
     {
-        for (int i = 0; i < m->max_clients; i++)
+        for (uint32_t i = 0; i <= m->max_peerid; i++)
         {
             struct multi_instance *mi = m->instances[i];
             if (mi)
@@ -1326,7 +1333,7 @@
         {
             int count = 0;
 
-            for (int i = 0; i < m->max_clients; i++)
+            for (uint32_t i = 0; i <= m->max_peerid; i++)
             {
                 struct multi_instance *mi = m->instances[i];
                 if (mi && mi != new_mi && !mi->halt)
@@ -2885,7 +2892,7 @@
 #endif
         mb = mbuf_alloc_buf(buf);
 
-        for (int i = 0; i < m->max_clients; i++)
+        for (uint32_t i = 0; i <= m->max_peerid; i++)
         {
             struct multi_instance *mi = m->instances[i];
 
@@ -3794,7 +3801,7 @@
 multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
 {
     /* tell all clients to restart */
-    for (int i = 0; i < m->max_clients; i++)
+    for (uint32_t i = 0; i <= m->max_peerid; i++)
     {
         struct multi_instance *mi = m->instances[i];
         if (mi && !mi->halt && proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
@@ -3876,7 +3883,7 @@
     struct multi_context *m = (struct multi_context *)arg;
     int count = 0;
 
-    for (int i = 0; i < m->max_clients; i++)
+    for (uint32_t i = 0; i <= m->max_peerid; i++)
     {
         struct multi_instance *mi = m->instances[i];
         if (mi && !mi->halt)
@@ -3907,7 +3914,7 @@
     maddr.proto = proto;
     if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
     {
-        for (int i = 0; i < m->max_clients; i++)
+        for (uint32_t i = 0; i <= m->max_peerid; i++)
         {
             struct multi_instance *mi = m->instances[i];
             if (mi && !mi->halt && mroute_addr_equal(&maddr, &mi->real))
@@ -4100,8 +4107,14 @@
     }
 
     /* should not really end up here, since multi_create_instance returns null
-     * if amount of clients exceeds max_clients */
+     * if amount of clients exceeds max_clients and this method would then
+     * also not have been called */
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
+
+    if (mi->context.c2.tls_multi->peer_id > m->max_peerid)
+    {
+        m->max_peerid = mi->context.c2.tls_multi->peer_id;
+    }
 }
 
 #if defined(__GNUC__) || defined(__clang__)
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 498409d..4acb364 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -160,9 +160,12 @@
  */
 struct multi_context
 {
-    struct multi_instance **instances; /**< Array of multi_instances. An instance can be
+    struct multi_instance **instances; /**< Array of multi_instances with the size of
+                                        *  max_clients.  An instance can be
                                         * accessed using peer-id as an index. */
-
+    uint32_t max_peerid;               /**< highest currently allocated peer-id
+                                        * and maximum allocated/valid index in
+                                        * instances */
     struct hash *hash;                 /**< VPN tunnel instances indexed by real
                                         *   address of the remote peer. */
     struct hash *vhash;                /**< VPN tunnel instances indexed by
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 6456554..529cc39 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -317,7 +317,7 @@
 
     int count = 0;
 
-    for (int i = 0; i < m->max_clients; i++)
+    for (uint32_t i = 0; i <= m->max_peerid; i++)
     {
         struct multi_instance *curr_mi = m->instances[i];
 

