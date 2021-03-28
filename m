From: Arne Schwabe <arne@...1227...>
Date: Sun, 28 Mar 2021 14:02:40 +0200
Message-Id: <20210328120241.27605-1-arne@...1227...>
In-Reply-To: <20201215164221.5995-1-arne@...1227...>
References: <20201215164221.5995-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 1/2] Move context_auth from context_2 to
 tls_multi and name it multi_state
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

context_2 and tls_multi have the same life cycle for TLS connections
but so this move does not affect behaviour of the variable.

OpenVPN TLS multi code has a grown a lot more complex and code that
handles multi objects needs to know the state that the object is in.
Since not all code has access to the context_2 struct, the code that
does not have access is often not checking the state directly but
checks other parts of multi that have been affected from a state
change.

This patch also renames it to multi_state as this variable represents t
he multi state machine status rather than just the state of the connect
authentication (more upcoming patches will move other states
into this variable).

Patch V2: also rename context_auth to multi_state, explain a bit why this
          change is done.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c    |  4 ++--
 src/openvpn/multi.c      | 26 +++++++++++++-------------
 src/openvpn/openvpn.h    | 14 --------------
 src/openvpn/push.c       |  6 +++---
 src/openvpn/ssl_common.h | 14 ++++++++++++++
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6f7a50048..e3890f395 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -544,7 +544,7 @@ encrypt_sign(struct context *c, bool comp_frag)
      * Drop non-TLS outgoing packet if client-connect script/plugin
      * has not yet succeeded.
      */
-    if (c->c2.context_auth != CAS_SUCCEEDED)
+    if (c->c2.tls_multi && c->c2.tls_multi->multi_state != CAS_SUCCEEDED)
     {
         c->c2.buf.len = 0;
     }
@@ -981,7 +981,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
          * Drop non-TLS packet if client-connect script/plugin and cipher selection
          * has not yet succeeded.
          */
-        if (c->c2.context_auth != CAS_SUCCEEDED)
+        if (c->c2.tls_multi && c->c2.tls_multi->multi_state != CAS_SUCCEEDED)
         {
             c->c2.buf.len = 0;
         }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f7e0f6805..d33f58299 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -676,7 +676,7 @@ multi_close_instance(struct multi_context *m,
 #ifdef ENABLE_MANAGEMENT
     set_cc_config(mi, NULL);
 #endif
-    if (mi->context.c2.context_auth == CAS_SUCCEEDED)
+    if (mi->context.c2.tls_multi->multi_state == CAS_SUCCEEDED)
     {
         multi_client_disconnect_script(mi);
     }
@@ -786,7 +786,7 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
         goto err;
     }
 
-    mi->context.c2.context_auth = CAS_PENDING;
+    mi->context.c2.tls_multi->multi_state = CAS_PENDING;
 
     if (hash_n_elements(m->hash) >= m->max_clients)
     {
@@ -2416,18 +2416,18 @@ multi_client_connect_late_setup(struct multi_context *m,
     mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
 
     /* set context-level authentication flag */
-    mi->context.c2.context_auth = CAS_SUCCEEDED;
+    mi->context.c2.tls_multi->multi_state = CAS_SUCCEEDED;
 
     /* authentication complete, calculate dynamic client specific options */
     if (!multi_client_set_protocol_options(&mi->context))
     {
-        mi->context.c2.context_auth = CAS_FAILED;
+        mi->context.c2.tls_multi->multi_state = CAS_FAILED;
     }
     /* Generate data channel keys only if setting protocol options
      * has not failed */
     else if (!multi_client_generate_tls_keys(&mi->context))
     {
-        mi->context.c2.context_auth = CAS_FAILED;
+        mi->context.c2.tls_multi->multi_state = CAS_FAILED;
     }
 
     /* send push reply if ready */
@@ -2575,7 +2575,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 
     /* We are only called for the CAS_PENDING_x states, so we
      * can ignore other states here */
-    bool from_deferred = (mi->context.c2.context_auth != CAS_PENDING);
+    bool from_deferred = (mi->context.c2.tls_multi->multi_state != CAS_PENDING);
 
     int *cur_handler_index = &mi->client_connect_defer_state.cur_handler_index;
     unsigned int *option_types_found =
@@ -2587,7 +2587,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         *cur_handler_index = 0;
         *option_types_found = 0;
         /* Initially we have no handler that has returned a result */
-        mi->context.c2.context_auth = CAS_PENDING_DEFERRED;
+        mi->context.c2.tls_multi->multi_state = CAS_PENDING_DEFERRED;
 
         multi_client_connect_early_setup(m, mi);
     }
@@ -2610,7 +2610,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
                  * Remember that we already had at least one handler
                  * returning a result should we go to into deferred state
                  */
-                mi->context.c2.context_auth = CAS_PENDING_DEFERRED_PARTIAL;
+                mi->context.c2.tls_multi->multi_state = CAS_PENDING_DEFERRED_PARTIAL;
                 break;
 
             case CC_RET_SKIPPED:
@@ -2662,12 +2662,12 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
     {
         /* run the disconnect script if we had a connect script that
          * did not fail */
-        if (mi->context.c2.context_auth == CAS_PENDING_DEFERRED_PARTIAL)
+        if (mi->context.c2.tls_multi->multi_state == CAS_PENDING_DEFERRED_PARTIAL)
         {
             multi_client_disconnect_script(mi);
         }
 
-        mi->context.c2.context_auth = CAS_FAILED;
+        mi->context.c2.tls_multi->multi_state = CAS_FAILED;
     }
 
     /* increment number of current authenticated clients */
@@ -2970,13 +2970,13 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
         {
             /* connection is "established" when SSL/TLS key negotiation succeeds
              * and (if specified) auth user/pass succeeds */
-            if (is_cas_pending(mi->context.c2.context_auth)
+            if (is_cas_pending(mi->context.c2.tls_multi->multi_state)
                 && CONNECTION_ESTABLISHED(&mi->context))
             {
                 multi_connection_established(m, mi);
             }
 #if defined(ENABLE_ASYNC_PUSH)
-            if (is_cas_pending(mi->context.c2.context_auth)
+            if (is_cas_pending(mi->context.c2.authenticated)
                 && mi->client_connect_defer_state.deferred_ret_file)
             {
                 add_inotify_file_watch(m, mi, m->top.c2.inotify_fd,
@@ -3936,7 +3936,7 @@ management_client_auth(void *arg,
         {
             if (auth)
             {
-                if (is_cas_pending(mi->context.c2.context_auth))
+                if (is_cas_pending(mi->context.c2.tls_multi->multi_state))
                 {
                     set_cc_config(mi, cc_config);
                     cc_config_owned = false;
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 3cef26381..d77ab223c 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -207,17 +207,6 @@ struct context_1
 };
 
 
-/* client authentication state, CAS_SUCCEEDED must be 0 since
- * non multi code path still checks this variable but does not initialise it
- * so the code depends on zero initialisation */
-enum client_connect_status {
-    CAS_SUCCEEDED=0,
-    CAS_PENDING,
-    CAS_PENDING_DEFERRED,
-    CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded, no result yet*/
-    CAS_FAILED,
-};
-
 static inline bool
 is_cas_pending(enum client_connect_status cas)
 {
@@ -454,9 +443,6 @@ struct context_2
     int push_ifconfig_ipv6_netbits;
     struct in6_addr push_ifconfig_ipv6_remote;
 
-
-    enum client_connect_status context_auth;
-
     struct event_timeout push_request_interval;
     time_t push_request_timeout;
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 18d7c1e00..b43ffa364 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -854,14 +854,14 @@ process_incoming_push_request(struct context *c)
 {
     int ret = PUSH_MSG_ERROR;
 
-    if ((c->c2.tls_multi && tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED)
-        || c->c2.context_auth == CAS_FAILED)
+    if (tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED
+        || c->c2.tls_multi->multi_state == CAS_FAILED)
     {
         const char *client_reason = tls_client_reason(c->c2.tls_multi);
         send_auth_failed(c, client_reason);
         ret = PUSH_MSG_AUTH_FAILURE;
     }
-    else if (c->c2.context_auth == CAS_SUCCEEDED)
+    else if (c->c2.tls_multi->multi_state == CAS_SUCCEEDED)
     {
         time_t now;
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 4e1ff6c84..ee8d80c0e 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -486,6 +486,19 @@ struct tls_session
  */
 #define KEY_SCAN_SIZE 3
 
+
+/* client authentication state, CAS_SUCCEEDED must be 0 since
+ * non multi code path still checks this variable but does not initialise it
+ * so the code depends on zero initialisation */
+enum client_connect_status {
+    CAS_SUCCEEDED=0,
+    CAS_PENDING,
+    CAS_PENDING_DEFERRED,
+    CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded, no result yet*/
+    CAS_FAILED,
+};
+
+
 /**
  * Security parameter state for a single VPN tunnel.
  * @ingroup control_processor
@@ -521,6 +534,7 @@ struct tls_multi
 
     int n_sessions;             /**< Number of sessions negotiated thus
                                  *   far. */
+    enum client_connect_status multi_state;
 
     /*
      * Number of errors.
-- 
2.30.1


