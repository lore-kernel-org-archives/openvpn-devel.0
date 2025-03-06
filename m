From: Gert Doering <gert@...1296...>
Date: Thu,  6 Mar 2025 11:13:39 +0100
Message-ID: <20250306101339.12985-1-gert@...1296...>
In-Reply-To: <gerrit.1737719138000.Iff12c4dbac84a814612aa8b5b89224be08bb9058@...2715...>
References: <gerrit.1737719138000.Iff12c4dbac84a814612aa8b5b89224be08bb9058@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] Rename occurences of 'struct
 link_socket' from 'ls' to 'sock'
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

From: Gianmarco De Gregori <gianmarco@...2726...>

This commit renames all instances of 'struct link_socket'
from the abbreviation 'ls' to the more descriptive 'sock'
making it clearer that the variables represent
socket-related structures.

No functional changes have been introduced.

Change-Id: Iff12c4dbac84a814612aa8b5b89224be08bb9058
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/874
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c21474a..1be205b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4946,12 +4946,12 @@
 void
 inherit_context_child(struct context *dest,
                       const struct context *src,
-                      struct link_socket *ls)
+                      struct link_socket *sock)
 {
     CLEAR(*dest);
 
     /* proto_is_dgram will ASSERT(0) if proto is invalid */
-    dest->mode = proto_is_dgram(ls->info.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;
+    dest->mode = proto_is_dgram(sock->info.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;
 
     dest->gc = gc_new();
 
@@ -4977,7 +4977,7 @@
 
     /* options */
     dest->options = src->options;
-    dest->options.ce.proto = ls->info.proto;
+    dest->options.ce.proto = sock->info.proto;
     options_detach(&dest->options);
 
     dest->c2.event_set = src->c2.event_set;
@@ -4988,7 +4988,7 @@
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from = ls;
+        dest->c2.accept_from = sock;
     }
 
 #ifdef ENABLE_PLUGIN
@@ -5015,11 +5015,11 @@
         ALLOC_ARRAY_GC(dest->c2.link_sockets, struct link_socket *, 1, &dest->gc);
 
         /* inherit parent link_socket and tuntap */
-        dest->c2.link_sockets[0] = ls;
+        dest->c2.link_sockets[0] = sock;
 
         ALLOC_ARRAY_GC(dest->c2.link_socket_infos, struct link_socket_info *, 1, &dest->gc);
         ALLOC_OBJ_GC(dest->c2.link_socket_infos[0], struct link_socket_info, &dest->gc);
-        *dest->c2.link_socket_infos[0] = ls->info;
+        *dest->c2.link_socket_infos[0] = sock->info;
 
         /* locally override some link_socket_info fields */
         dest->c2.link_socket_infos[0]->lsa = &dest->c1.link_socket_addrs[0];
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 11c32ac..50b38e3 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -96,7 +96,7 @@
 
 void inherit_context_child(struct context *dest,
                            const struct context *src,
-                           struct link_socket *ls);
+                           struct link_socket *sock);
 
 void inherit_context_top(struct context *dest,
                          const struct context *src);
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 0d409b6..1d62ea6 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -47,16 +47,16 @@
 };
 
 struct multi_instance *
-multi_create_instance_tcp(struct multi_context *m, struct link_socket *ls)
+multi_create_instance_tcp(struct multi_context *m, struct link_socket *sock)
 {
     struct gc_arena gc = gc_new();
     struct multi_instance *mi = NULL;
     struct hash *hash = m->hash;
 
-    mi = multi_create_instance(m, NULL, ls);
+    mi = multi_create_instance(m, NULL, sock);
     if (mi)
     {
-        mi->real.proto = ls->info.proto;
+        mi->real.proto = sock->info.proto;
         struct hash_element *he;
         const uint32_t hv = hash_value(hash, &mi->real);
         struct hash_bucket *bucket = hash_bucket(hash, hv);
@@ -140,10 +140,10 @@
 void
 multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_instance *mi)
 {
-    struct link_socket *ls = mi->context.c2.link_sockets[0];
-    if (ls && mi->socket_set_called)
+    struct link_socket *sock = mi->context.c2.link_sockets[0];
+    if (sock && mi->socket_set_called)
     {
-        event_del(multi_io->es, socket_event_handle(ls));
+        event_del(multi_io->es, socket_event_handle(sock));
         mi->socket_set_called = false;
     }
     multi_io->n_esr = 0;
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 9de5203..7f95529 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -44,7 +44,7 @@
 
 bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags);
 
-struct multi_instance *multi_create_instance_tcp(struct multi_context *m, struct link_socket *ls);
+struct multi_instance *multi_create_instance_tcp(struct multi_context *m, struct link_socket *sock);
 
 void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_instance *mi);
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index c0344b1..54dfc72 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -188,14 +188,14 @@
 
 struct multi_instance *
 multi_get_create_instance_udp(struct multi_context *m, bool *floated,
-                              struct link_socket *ls)
+                              struct link_socket *sock)
 {
     struct gc_arena gc = gc_new();
     struct mroute_addr real = {0};
     struct multi_instance *mi = NULL;
     struct hash *hash = m->hash;
-    real.proto = ls->info.proto;
-    m->hmac_reply_ls = ls;
+    real.proto = sock->info.proto;
+    m->hmac_reply_ls = sock;
 
     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
@@ -261,7 +261,7 @@
                      * connect-freq but not against connect-freq-initial */
                     reflect_filter_rate_limit_decrease(m->initial_rate_limiter);
 
-                    mi = multi_create_instance(m, &real, ls);
+                    mi = multi_create_instance(m, &real, sock);
                     if (mi)
                     {
                         hash_add_fast(hash, bucket, &mi->real, hv, mi);
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 357b684..37752e1 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -33,7 +33,7 @@
 
 unsigned int p2mp_iow_flags(const struct multi_context *m);
 
-void multi_process_io_udp(struct multi_context *m, struct link_socket *ls);
+void multi_process_io_udp(struct multi_context *m, struct link_socket *sock);
 /**************************************************************************/
 /**
  * Get, and if necessary create, the multi_instance associated with a
@@ -47,13 +47,13 @@
  * successful, returns the newly created instance.
  *
  * @param m           - The single multi_context structure.
- * @param ls          - Listening socket where this instance is connecting to
+ * @param sock        - Listening socket where this instance is connecting to
  *
  * @return A pointer to a multi_instance if one already existed for the
  *     packet's source address or if one was a newly created successfully.
  *      NULL if one did not yet exist and a new one was not created.
  */
 struct multi_instance *multi_get_create_instance_udp(struct multi_context *m, bool *floated,
-                                                     struct link_socket *ls);
+                                                     struct link_socket *sock);
 
 #endif /* ifndef MUDP_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 07258be..85a1712 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -751,7 +751,7 @@
  */
 struct multi_instance *
 multi_create_instance(struct multi_context *m, const struct mroute_addr *real,
-                      struct link_socket *ls)
+                      struct link_socket *sock)
 {
     struct gc_arena gc = gc_new();
     struct multi_instance *mi;
@@ -774,7 +774,7 @@
         generate_prefix(mi);
     }
 
-    inherit_context_child(&mi->context, &m->top, ls);
+    inherit_context_child(&mi->context, &m->top, sock);
     if (IS_SIG(&mi->context))
     {
         goto err;
@@ -3139,7 +3139,7 @@
 
 void
 multi_process_float(struct multi_context *m, struct multi_instance *mi,
-                    struct link_socket *ls)
+                    struct link_socket *sock)
 {
     struct mroute_addr real = {0};
     struct hash *hash = m->hash;
@@ -3195,7 +3195,7 @@
     mi->context.c2.to_link_addr = &mi->context.c2.from;
 
     /* inherit parent link_socket and link_socket_info */
-    mi->context.c2.link_sockets[0] = ls;
+    mi->context.c2.link_sockets[0] = sock;
     mi->context.c2.link_socket_infos[0]->lsa->actual = m->top.c2.from;
 
     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);
@@ -3346,7 +3346,7 @@
  */
 bool
 multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance,
-                            const unsigned int mpp_flags, struct link_socket *ls)
+                            const unsigned int mpp_flags, struct link_socket *sock)
 {
     struct gc_arena gc = gc_new();
 
@@ -3367,7 +3367,7 @@
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP -> TUN [%d]\n", BLEN(&m->top.c2.buf));
 #endif
-        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, ls));
+        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, sock));
     }
     else
     {
@@ -3401,14 +3401,14 @@
             /* decrypt in instance context */
 
             perf_push(PERF_PROC_IN_LINK);
-            lsi = &ls->info;
+            lsi = &sock->info;
             orig_buf = c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
                 /* nonzero length means that we have a valid, decrypted packed */
                 if (floated && c->c2.buf.len > 0)
                 {
-                    multi_process_float(m, m->pending, ls);
+                    multi_process_float(m, m->pending, sock);
                 }
 
                 process_incoming_link_part2(c, lsi, orig_buf);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 4104706..e14ad60 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -272,7 +272,7 @@
 void multi_top_free(struct multi_context *m);
 
 struct multi_instance *multi_create_instance(struct multi_context *m, const struct mroute_addr *real,
-                                             struct link_socket *ls);
+                                             struct link_socket *sock);
 
 void multi_close_instance(struct multi_context *m, struct multi_instance *mi, bool shutdown);
 
@@ -287,7 +287,7 @@
  * updates hashtables in multi_context.
  */
 void multi_process_float(struct multi_context *m, struct multi_instance *mi,
-                         struct link_socket *ls);
+                         struct link_socket *sock);
 
 #define MPP_PRE_SELECT             (1<<0)
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
@@ -352,10 +352,10 @@
  *                       when using TCP transport. Otherwise NULL, as is
  *                       the case when using UDP transport.
  * @param mpp_flags    - Fast I/O optimization flags.
- * @param ls           - Socket where the packet was received.
+ * @param sock         - Socket where the packet was received.
  */
 bool multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags,
-                                 struct link_socket *ls);
+                                 struct link_socket *sock);
 
 
 /**

