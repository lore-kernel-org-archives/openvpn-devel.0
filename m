From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 13 Mar 2026 11:49:55 +0100
Message-ID: <20260313104955.16748-1-frank@...2641...>
In-Reply-To: <gerrit.1772719451000.Ibf8865e451866e1fffc8dbc8ad5ecf6bc5577ce4@...2715...>
References: <gerrit.1772719451000.Ibf8865e451866e1fffc8dbc8ad5ecf6bc5577ce4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Remove multi_context->iter
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
Cc: Arne Schwabe <arne@...1227...>, Arne Schwabe <arne-openvpn@...1227...>

From: Arne Schwabe <arne@...1227...>

The multi_context->iter is basically a hash with only one bucket. This makes
m->iter a linear list. Instead of maintaining this extra list use
m->instances instead. This is a fixed sized continuous array, so iterating
over it should be very quick. When the number of connected clients
approaches max_clients, iterating over a static array should be faster than
a linked list, especially when considering cache locality.

Of the several places where m->iter is used only one is potentially on a
critical path: the usage of m->iter in multi_bcast.

However this performance difference would be only visible with a lightly
loaded server with very few clients. And even in this scenario I could
not manage to measure a difference.

Change-Id: Ibf8865e451866e1fffc8dbc8ad5ecf6bc5577ce4
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1556
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1556
This mail reflects revision 5 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 1625fd0..9d4ea49 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -300,14 +300,6 @@
     m->vhash = hash_init(t->options.virtual_hash_size, (uint32_t)get_random(),
                          mroute_addr_hash_function, mroute_addr_compare_function);
 
-    /*
-     * This hash table is a clone of m->hash but with a
-     * bucket size of one so that it can be used
-     * for fast iteration through the list.
-     */
-    m->iter = hash_init(1, (uint32_t)get_random(), mroute_addr_hash_function,
-                        mroute_addr_compare_function);
-
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash = hash_init(t->options.real_hash_size, 0, cid_hash_function, cid_compare_function);
 #endif
@@ -591,10 +583,6 @@
         {
             ASSERT(hash_remove(m->hash, &mi->real));
         }
-        if (mi->did_iter)
-        {
-            ASSERT(hash_remove(m->iter, &mi->real));
-        }
 #ifdef ENABLE_MANAGEMENT
         if (mi->did_cid_hash)
         {
@@ -664,23 +652,19 @@
 {
     if (m->hash)
     {
-        struct hash_iterator hi;
-        struct hash_element *he;
-
-        hash_iterator_init(m->iter, &hi);
-        while ((he = hash_iterator_next(&hi)))
+        for (int i = 0; i < m->max_clients; i++)
         {
-            struct multi_instance *mi = (struct multi_instance *)he->value;
-            mi->did_iter = false;
-            multi_close_instance(m, mi, true);
+            struct multi_instance *mi = m->instances[i];
+            if (mi)
+            {
+                multi_close_instance(m, mi, true);
+            }
         }
-        hash_iterator_free(&hi);
 
         multi_reap_all(m);
 
         hash_free(m->hash);
         hash_free(m->vhash);
-        hash_free(m->iter);
 #ifdef ENABLE_MANAGEMENT
         hash_free(m->cid_hash);
 #endif
@@ -760,14 +744,6 @@
         generate_prefix(mi);
     }
 
-    if (!hash_add(m->iter, &mi->real, mi, false))
-    {
-        msg(D_MULTI_LOW, "MULTI: unable to add real address [%s] to iterator hash table",
-            mroute_addr_print(&mi->real, &gc));
-        goto err;
-    }
-    mi->did_iter = true;
-
 #ifdef ENABLE_MANAGEMENT
     do
     {
@@ -1348,27 +1324,21 @@
         const char *new_cn = tls_common_name(new_mi->context.c2.tls_multi, true);
         if (new_cn)
         {
-            struct hash_iterator hi;
-            struct hash_element *he;
             int count = 0;
 
-            hash_iterator_init(m->iter, &hi);
-            while ((he = hash_iterator_next(&hi)))
+            for (int i = 0; i < m->max_clients; i++)
             {
-                struct multi_instance *mi = (struct multi_instance *)he->value;
-                if (mi != new_mi && !mi->halt)
+                struct multi_instance *mi = m->instances[i];
+                if (mi && mi != new_mi && !mi->halt)
                 {
                     const char *cn = tls_common_name(mi->context.c2.tls_multi, true);
                     if (cn && !strcmp(cn, new_cn))
                     {
-                        mi->did_iter = false;
                         multi_close_instance(m, mi, false);
-                        hash_iterator_delete_element(&hi);
                         ++count;
                     }
                 }
             }
-            hash_iterator_free(&hi);
 
             if (count)
             {
@@ -2906,9 +2876,6 @@
 multi_bcast(struct multi_context *m, const struct buffer *buf,
             const struct multi_instance *sender_instance, uint16_t vid)
 {
-    struct hash_iterator hi;
-    struct hash_element *he;
-    struct multi_instance *mi;
     struct mbuf_buffer *mb;
 
     if (BLEN(buf) > 0)
@@ -2917,12 +2884,12 @@
         printf("BCAST len=%d\n", BLEN(buf));
 #endif
         mb = mbuf_alloc_buf(buf);
-        hash_iterator_init(m->iter, &hi);
 
-        while ((he = hash_iterator_next(&hi)))
+        for (int i = 0; i < m->max_clients; i++)
         {
-            mi = (struct multi_instance *)he->value;
-            if (mi != sender_instance && !mi->halt)
+            struct multi_instance *mi = m->instances[i];
+
+            if (mi && mi != sender_instance && !mi->halt)
             {
                 if (vid != 0 && vid != mi->context.options.vlan_pvid)
                 {
@@ -2931,8 +2898,6 @@
                 multi_add_mbuf(m, mi, mb);
             }
         }
-
-        hash_iterator_free(&hi);
         mbuf_free_buf(mb);
     }
 }
@@ -3182,7 +3147,6 @@
 
     /* remove old address from hash table before changing address */
     ASSERT(hash_remove(m->hash, &mi->real));
-    ASSERT(hash_remove(m->iter, &mi->real));
 
     /* change external network address of the remote peer */
     mi->real = real;
@@ -3198,7 +3162,6 @@
     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);
 
     ASSERT(hash_add(m->hash, &mi->real, mi, false));
-    ASSERT(hash_add(m->iter, &mi->real, mi, false));
 
 #ifdef ENABLE_MANAGEMENT
     ASSERT(hash_add(m->cid_hash, &mi->context.c2.mda_context.cid, mi, true));
@@ -3830,22 +3793,17 @@
 static void
 multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
 {
-    struct hash_iterator hi;
-    struct hash_element *he;
-
     /* tell all clients to restart */
-    hash_iterator_init(m->iter, &hi);
-    while ((he = hash_iterator_next(&hi)))
+    for (int i = 0; i < m->max_clients; i++)
     {
-        struct multi_instance *mi = (struct multi_instance *)he->value;
-        if (!mi->halt && proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
+        struct multi_instance *mi = m->instances[i];
+        if (mi && !mi->halt && proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
         {
             send_control_channel_string(&mi->context, next_server ? "RESTART,[N]" : "RESTART",
                                         D_PUSH);
             multi_schedule_context_wakeup(m, mi);
         }
     }
-    hash_iterator_free(&hi);
 
     /* reschedule signal */
     ASSERT(!openvpn_gettimeofday(&m->deferred_shutdown_signal.wakeup, NULL));
@@ -3916,15 +3874,12 @@
 management_callback_kill_by_cn(void *arg, const char *del_cn)
 {
     struct multi_context *m = (struct multi_context *)arg;
-    struct hash_iterator hi;
-    struct hash_element *he;
     int count = 0;
 
-    hash_iterator_init(m->iter, &hi);
-    while ((he = hash_iterator_next(&hi)))
+    for (int i = 0; i < m->max_clients; i++)
     {
-        struct multi_instance *mi = (struct multi_instance *)he->value;
-        if (!mi->halt)
+        struct multi_instance *mi = m->instances[i];
+        if (mi && !mi->halt)
         {
             const char *cn = tls_common_name(mi->context.c2.tls_multi, false);
             if (cn && !strcmp(cn, del_cn))
@@ -3934,7 +3889,6 @@
             }
         }
     }
-    hash_iterator_free(&hi);
     return count;
 }
 
@@ -3942,8 +3896,6 @@
 management_callback_kill_by_addr(void *arg, const in_addr_t addr, const uint16_t port, const uint8_t proto)
 {
     struct multi_context *m = (struct multi_context *)arg;
-    struct hash_iterator hi;
-    struct hash_element *he;
     struct openvpn_sockaddr saddr;
     struct mroute_addr maddr;
     int count = 0;
@@ -3955,17 +3907,15 @@
     maddr.proto = proto;
     if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
     {
-        hash_iterator_init(m->iter, &hi);
-        while ((he = hash_iterator_next(&hi)))
+        for (int i = 0; i < m->max_clients; i++)
         {
-            struct multi_instance *mi = (struct multi_instance *)he->value;
-            if (!mi->halt && mroute_addr_equal(&maddr, &mi->real))
+            struct multi_instance *mi = m->instances[i];
+            if (mi && !mi->halt && mroute_addr_equal(&maddr, &mi->real))
             {
                 multi_signal_instance(m, mi, SIGTERM);
                 ++count;
             }
         }
-        hash_iterator_free(&hi);
     }
     return count;
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index c686e47..498409d 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -132,7 +132,6 @@
     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing */
 
     bool did_real_hash;
-    bool did_iter;
 #ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;
     struct buffer_list *cc_config;
@@ -168,9 +167,6 @@
                                         *   address of the remote peer. */
     struct hash *vhash;                /**< VPN tunnel instances indexed by
                                         *   virtual address of remote hosts. */
-    struct hash *iter;                 /**< VPN tunnel instances indexed by real
-                                        *   address of the remote peer, optimized
-                                        *   for iteration. */
     struct schedule *schedule;
     struct mbuf_set *mbuf;             /**< Set of buffers for passing data
                                         *   channel packets between VPN tunnel
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 51c7b5f..6456554 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -316,15 +316,12 @@
     }
 
     int count = 0;
-    struct hash_iterator hi;
-    const struct hash_element *he;
 
-    hash_iterator_init(m->iter, &hi);
-    while ((he = hash_iterator_next(&hi)))
+    for (int i = 0; i < m->max_clients; i++)
     {
-        struct multi_instance *curr_mi = he->value;
+        struct multi_instance *curr_mi = m->instances[i];
 
-        if (curr_mi->halt || !support_push_update(curr_mi))
+        if (!curr_mi || curr_mi->halt || !support_push_update(curr_mi))
         {
             continue;
         }
@@ -338,7 +335,6 @@
         count++;
     }
 
-    hash_iterator_free(&hi);
     buffer_list_free(msgs);
     gc_free(&gc);
     return count;

