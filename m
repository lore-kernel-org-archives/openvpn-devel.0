From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Dec 2020 17:42:20 +0100
Message-Id: <20201215164221.5995-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/2] Move context_auth from context_2 to
 tls_multi
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

Some code currently is doing weird workarounds to figure out that side
as side effect from other variables in tls_multi.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c    |  4 ++--
 src/openvpn/multi.c      | 24 ++++++++++++------------
 src/openvpn/openvpn.h    | 14 --------------
 src/openvpn/push.c       |  6 +++---
 src/openvpn/ssl_common.h | 14 ++++++++++++++
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 67615a6b..3807536e 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -535,7 +535,7 @@ encrypt_sign(struct context *c, bool comp_frag)
      * Drop non-TLS outgoing packet if client-connect script/plugin
      * has not yet succeeded.
      */
-    if (c->c2.context_auth != CAS_SUCCEEDED)
+    if (c->c2.tls_multi->context_auth != CAS_SUCCEEDED)
     {
         c->c2.buf.len = 0;
     }
@@ -980,7 +980,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
          * Drop non-TLS packet if client-connect script/plugin and cipher selection
          * has not yet succeeded.
          */
-        if (c->c2.context_auth != CAS_SUCCEEDED)
+        if (c->c2.tls_multi && c->c2.tls_multi->context_auth != CAS_SUCCEEDED)
         {
             c->c2.buf.len = 0;
         }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index dd713049..821c750a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -675,7 +675,7 @@ multi_close_instance(struct multi_context *m,
 #ifdef ENABLE_MANAGEMENT
     set_cc_config(mi, NULL);
 #endif
-    if (mi->context.c2.context_auth == CAS_SUCCEEDED)
+    if (mi->context.c2.tls_multi->context_auth == CAS_SUCCEEDED)
     {
         multi_client_disconnect_script(mi);
     }
@@ -785,7 +785,7 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
         goto err;
     }
 
-    mi->context.c2.context_auth = CAS_PENDING;
+    mi->context.c2.tls_multi->context_auth = CAS_PENDING;
 
     if (hash_n_elements(m->hash) >= m->max_clients)
     {
@@ -2437,18 +2437,18 @@ multi_client_connect_late_setup(struct multi_context *m,
     mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
 
     /* set context-level authentication flag */
-    mi->context.c2.context_auth = CAS_SUCCEEDED;
+    mi->context.c2.tls_multi->context_auth = CAS_SUCCEEDED;
 
     /* authentication complete, calculate dynamic client specific options */
     if (!multi_client_set_protocol_options(&mi->context))
     {
-        mi->context.c2.context_auth = CAS_FAILED;
+        mi->context.c2.tls_multi->context_auth = CAS_FAILED;
     }
     /* Generate data channel keys only if setting protocol options
      * has not failed */
     else if (!multi_client_generate_tls_keys(&mi->context))
     {
-        mi->context.c2.context_auth = CAS_FAILED;
+        mi->context.c2.tls_multi->context_auth = CAS_FAILED;
     }
 
     /* send push reply if ready */
@@ -2596,7 +2596,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 
     /* We are only called for the CAS_PENDING_x states, so we
      * can ignore other states here */
-    bool from_deferred = (mi->context.c2.context_auth != CAS_PENDING);
+    bool from_deferred = (mi->context.c2.tls_multi->context_auth != CAS_PENDING);
 
     int *cur_handler_index = &mi->client_connect_defer_state.cur_handler_index;
     unsigned int *option_types_found =
@@ -2608,7 +2608,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         *cur_handler_index = 0;
         *option_types_found = 0;
         /* Initially we have no handler that has returned a result */
-        mi->context.c2.context_auth = CAS_PENDING_DEFERRED;
+        mi->context.c2.tls_multi->context_auth = CAS_PENDING_DEFERRED;
 
         multi_client_connect_early_setup(m, mi);
     }
@@ -2631,7 +2631,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
                  * Remember that we already had at least one handler
                  * returning a result should we go to into deferred state
                  */
-                mi->context.c2.context_auth = CAS_PENDING_DEFERRED_PARTIAL;
+                mi->context.c2.tls_multi->context_auth = CAS_PENDING_DEFERRED_PARTIAL;
                 break;
 
             case CC_RET_SKIPPED:
@@ -2683,12 +2683,12 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
     {
         /* run the disconnect script if we had a connect script that
          * did not fail */
-        if (mi->context.c2.context_auth == CAS_PENDING_DEFERRED_PARTIAL)
+        if (mi->context.c2.tls_multi->context_auth == CAS_PENDING_DEFERRED_PARTIAL)
         {
             multi_client_disconnect_script(mi);
         }
 
-        mi->context.c2.context_auth = CAS_FAILED;
+        mi->context.c2.tls_multi->context_auth = CAS_FAILED;
     }
 
     /* increment number of current authenticated clients */
@@ -2991,7 +2991,7 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
         {
             /* connection is "established" when SSL/TLS key negotiation succeeds
              * and (if specified) auth user/pass succeeds */
-            if (is_cas_pending(mi->context.c2.context_auth)
+            if (is_cas_pending(mi->context.c2.tls_multi->context_auth)
                 && CONNECTION_ESTABLISHED(&mi->context))
             {
                 multi_connection_established(m, mi);
@@ -3954,7 +3954,7 @@ management_client_auth(void *arg,
         {
             if (auth)
             {
-                if (is_cas_pending(mi->context.c2.context_auth))
+                if (is_cas_pending(mi->context.c2.tls_multi->context_auth))
                 {
                     set_cc_config(mi, cc_config);
                     cc_config_owned = false;
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 4ca89ba9..0a246d4f 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -211,17 +211,6 @@ struct context_1
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
@@ -458,9 +447,6 @@ struct context_2
     int push_ifconfig_ipv6_netbits;
     struct in6_addr push_ifconfig_ipv6_remote;
 
-
-    enum client_connect_status context_auth;
-
     struct event_timeout push_request_interval;
     int n_sent_push_requests;
     bool did_pre_pull_restore;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 26a6201f..25f96d6b 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -736,14 +736,14 @@ process_incoming_push_request(struct context *c)
 {
     int ret = PUSH_MSG_ERROR;
 
-    if ((c->c2.tls_multi && tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED)
-        || c->c2.context_auth == CAS_FAILED)
+    if (tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED
+        || c->c2.tls_multi->context_auth == CAS_FAILED)
     {
         const char *client_reason = tls_client_reason(c->c2.tls_multi);
         send_auth_failed(c, client_reason);
         ret = PUSH_MSG_AUTH_FAILURE;
     }
-    else if (c->c2.context_auth == CAS_SUCCEEDED)
+    else if (c->c2.tls_multi->context_auth == CAS_SUCCEEDED)
     {
         time_t now;
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f435089a..41d98198 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -480,6 +480,19 @@ struct tls_session
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
@@ -515,6 +528,7 @@ struct tls_multi
 
     int n_sessions;             /**< Number of sessions negotiated thus
                                  *   far. */
+    enum client_connect_status context_auth;
 
     /*
      * Number of errors.
-- 
2.26.2


