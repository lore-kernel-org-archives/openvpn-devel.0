From: Arne Schwabe <arne@...1227...>
Date: Sun,  2 May 2021 00:35:45 +0200
Message-Id: <20210501223545.3669495-1-arne@...1227...>
In-Reply-To: <20210422151724.2132573-1-arne@...1227...>
References: <20210422151724.2132573-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add connection_established as state in
 tls_multi->context_auth
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

the socket_info->connection_establish is set through
link_socket_set_outgoing_addr when we reach FULL_SYNC. This patch
introduces a new state in context_auth that replaces the
connection_established state for TLS connections. This make the state
machine easier to understand.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c    |  6 +++---
 src/openvpn/forward.h    | 13 ++++++++++++-
 src/openvpn/multi.c      | 15 ++++++++-------
 src/openvpn/occ.c        |  2 +-
 src/openvpn/openvpn.h    |  4 +++-
 src/openvpn/push.c       |  2 +-
 src/openvpn/ssl.c        | 37 +++++++++++++++++++++++++++----------
 src/openvpn/ssl_common.h | 12 +++++++++---
 8 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index df96d0480..6f2b83e7e 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -280,7 +280,7 @@ void
 check_connection_established(struct context *c)
 {
 
-    if (CONNECTION_ESTABLISHED(c))
+    if (connection_established(c))
     {
         /* if --pull was specified, send a push request to server */
         if (c->c2.tls_multi && c->options.pull)
@@ -536,7 +536,7 @@ encrypt_sign(struct context *c, bool comp_frag)
      * has not yet succeeded. In non-TLS tls_multi mode is not defined
      * and we always pass packets.
      */
-    if (c->c2.tls_multi && c->c2.tls_multi->multi_state != CAS_SUCCEEDED)
+    if (c->c2.tls_multi && c->c2.tls_multi->multi_state < CAS_CONNECT_DONE)
     {
         c->c2.buf.len = 0;
     }
@@ -971,7 +971,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
          * has not yet succeeded. In non-TLS mode tls_multi is not defined
          * and we always pass packets.
          */
-        if (c->c2.tls_multi && c->c2.tls_multi->multi_state != CAS_SUCCEEDED)
+        if (c->c2.tls_multi && c->c2.tls_multi->multi_state < CAS_CONNECT_DONE)
         {
             c->c2.buf.len = 0;
         }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 2a67c1445..3461e6422 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -445,6 +445,17 @@ io_wait(struct context *c, const unsigned int flags)
     }
 }
 
-#define CONNECTION_ESTABLISHED(c) (get_link_socket_info(c)->connection_established)
+static inline bool
+connection_established(struct context *c)
+{
+    if (c->c2.tls_multi)
+    {
+        return c->c2.tls_multi->multi_state >= CAS_CONNECT_DONE;
+    }
+    else
+    {
+        return get_link_socket_info(c)->connection_established;
+    }
+}
 
 #endif /* FORWARD_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 32e2821d3..666456da9 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -674,7 +674,8 @@ multi_close_instance(struct multi_context *m,
 #ifdef ENABLE_MANAGEMENT
     set_cc_config(mi, NULL);
 #endif
-    if (mi->context.c2.tls_multi->multi_state == CAS_SUCCEEDED)
+
+    if (mi->context.c2.tls_multi->multi_state >= CAS_CONNECT_DONE)
     {
         multi_client_disconnect_script(mi);
     }
@@ -775,7 +776,7 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
         goto err;
     }
 
-    mi->context.c2.tls_multi->multi_state = CAS_PENDING;
+    mi->context.c2.tls_multi->multi_state = CAS_NOT_CONNECTED;
 
     if (hash_n_elements(m->hash) >= m->max_clients)
     {
@@ -2407,7 +2408,7 @@ multi_client_connect_late_setup(struct multi_context *m,
     mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
 
     /* set context-level authentication flag */
-    mi->context.c2.tls_multi->multi_state = CAS_SUCCEEDED;
+    mi->context.c2.tls_multi->multi_state = CAS_CONNECT_DONE;
 
     /* authentication complete, calculate dynamic client specific options */
     if (!multi_client_set_protocol_options(&mi->context))
@@ -2650,9 +2651,9 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 
             case CC_RET_DEFERRED:
                 /*
-                 * we already set client_connect_status to DEFERRED_RESULT or
+                 * we already set multi_status to DEFERRED_RESULT or
                  * DEFERRED_NO_RESULT. We just return
-                 * from the function as having client_connect_status
+                 * from the function as having multi_status
                  */
                 return;
 
@@ -3004,8 +3005,8 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
         {
             /* connection is "established" when SSL/TLS key negotiation succeeds
              * and (if specified) auth user/pass succeeds */
-            if (is_cas_pending(mi->context.c2.tls_multi->multi_state)
-                && CONNECTION_ESTABLISHED(&mi->context))
+
+            if (is_cas_pending(mi->context.c2.tls_multi->multi_state))
             {
                 multi_connection_established(m, mi);
             }
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 3ff351aa0..c169838e1 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -185,7 +185,7 @@ check_send_occ_req_dowork(struct context *c)
 void
 check_send_occ_load_test_dowork(struct context *c)
 {
-    if (CONNECTION_ESTABLISHED(c))
+    if (connection_established(c))
     {
         const struct mtu_load_test *entry;
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index a15ff08d1..84ffcd77b 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -206,7 +206,7 @@ struct context_1
 
 
 static inline bool
-is_cas_pending(enum client_connect_status cas)
+is_cas_pending(enum multi_status cas)
 {
     return cas == CAS_PENDING || cas == CAS_PENDING_DEFERRED
            || cas == CAS_PENDING_DEFERRED_PARTIAL;
@@ -247,6 +247,8 @@ struct context_2
 
     struct link_socket *link_socket;     /* socket used for TCP/UDP connection to remote */
     bool link_socket_owned;
+
+    /** This variable is used instead link_socket->info for P2MP UDP childs */
     struct link_socket_info *link_socket_info;
     const struct link_socket *accept_from; /* possibly do accept() on a parent link_socket */
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index cea782fe5..fcafc5003 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -862,7 +862,7 @@ process_incoming_push_request(struct context *c)
         send_auth_failed(c, client_reason);
         ret = PUSH_MSG_AUTH_FAILURE;
     }
-    else if (c->c2.tls_multi->multi_state == CAS_SUCCEEDED)
+    else if (c->c2.tls_multi->multi_state >= CAS_CONNECT_DONE)
     {
         time_t now;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b37f64b99..7d66cf565 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2381,19 +2381,21 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
      * If we're a p2mp server to allow NCP, the first key
      * generation is postponed until after the connect script finished and the
      * NCP options can be processed. Since that always happens at after connect
-     * script options are available the CAS_SUCCEEDED status is identical to
-     * NCP options are processed and we have no extra state for NCP finished.
+     * script options are available the CAS_CONNECT_DONE status is identical to
+     * NCP options are processed and do not wait for NCP being finished.
      */
-    if (session->opt->server && (session->opt->mode != MODE_SERVER
-            || multi->multi_state == CAS_SUCCEEDED))
+    if (ks->authenticated > KS_AUTH_FALSE && session->opt->mode == MODE_SERVER
+        && (multi->multi_state >= CAS_CONNECT_DONE || ks->key_id > 0))
     {
-        if (ks->authenticated > KS_AUTH_FALSE)
+        /* if key_id >= 1, is a renegotiation, so we use the already established
+         * parameters and do not need to delay anything. */
+
+        /* key-id == 0 and multi_state >= CAS_CONNECT_DONE is a special case of
+         * the server reusing the session of a reconnecting client. */
+        if (!tls_session_generate_data_channel_keys(session))
         {
-            if (!tls_session_generate_data_channel_keys(session))
-            {
-                msg(D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
-                goto error;
-            }
+            msg(D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
+            goto error;
         }
     }
 
@@ -2801,6 +2803,21 @@ tls_process(struct tls_multi *multi,
                 /* Set outgoing address for data channel packets */
                 link_socket_set_outgoing_addr(to_link_socket_info, &ks->remote_addr, session->common_name, session->opt->es);
 
+                /* Check if we need to advance the tls_multi state machine */
+                if (multi->multi_state == CAS_NOT_CONNECTED)
+                {
+                    if (session->opt->mode == MODE_SERVER)
+                    {
+                        /* On a server we continue with running connect scripts next */
+                        multi->multi_state = CAS_PENDING;
+                    }
+                    else
+                    {
+                        /* Skip the connect script related states */
+                        multi->multi_state = CAS_CONNECT_DONE;
+                    }
+                }
+
                 /* Flush any payload packets that were buffered before our state transitioned to S_ACTIVE */
                 flush_payload_buffer(ks);
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index ba13e8209..9c923f2a6 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -496,12 +496,18 @@ struct tls_session
 /* client authentication state, CAS_SUCCEEDED must be 0 since
  * non multi code path still checks this variable but does not initialise it
  * so the code depends on zero initialisation */
-enum client_connect_status {
-    CAS_SUCCEEDED=0,
+
+/* CAS_NOT_CONNECTED is the initial state for every context. When the *first*
+ * tls_session reaches S_ACTIVE, this state machine moves to CAS_PENDING (server)
+ * or CAS_CONNECT_DONE (client/p2p) as clients skip the stages associated with
+ * connect scripts/plugins */
+enum multi_status {
+    CAS_NOT_CONNECTED,
     CAS_PENDING,
     CAS_PENDING_DEFERRED,
     CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded, no result yet*/
     CAS_FAILED,
+    CAS_CONNECT_DONE,
 };
 
 
@@ -540,7 +546,7 @@ struct tls_multi
 
     int n_sessions;             /**< Number of sessions negotiated thus
                                  *   far. */
-    enum client_connect_status multi_state;
+    enum multi_status multi_state;
 
     /*
      * Number of errors.
-- 
2.31.1


