From: Arne Schwabe <arne@...1227...>
Date: Wed, 30 Nov 2022 17:57:05 +0100
Message-Id: <20221130165705.159610-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Introduce connection state for reconnecting
 peer in p2p
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

We introduce this state to make the reconnecting of a client more obvious and
what is called again instead of making it implicit. The new state
CAS_RECONNECT_PENDING is between CAS_WAITING_OPTIONS_IMPORT and
CAS_CONNECT_DONE as we need to redo some of the steps of the connection
setup, so this new state is going a "half step" back in the state machine.

We also do no longer generate data channel keys for untrusted session. This
is done for clarity but also to allow them being generated after the session
has become actually active.

These changes allow a reconnect in p2p mode with DCO to work as the initial
reconnect working.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c    | 19 +++++++++++++----
 src/openvpn/init.c       |  6 ++++++
 src/openvpn/ssl.c        | 46 +++++++++++++++++++++++-----------------
 src/openvpn/ssl.h        |  1 +
 src/openvpn/ssl_common.h |  5 +++++
 5 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 3b5b04074..37340aef5 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -174,7 +174,14 @@ check_tls(struct context *c)
         const int tmp_status = tls_multi_process
                                    (c->c2.tls_multi, &c->c2.to_link, &c->c2.to_link_addr,
                                    get_link_socket_info(c), &wakeup);
-        if (tmp_status == TLSMP_ACTIVE)
+
+        if (tmp_status == TLSMP_RECONNECT)
+        {
+            event_timeout_init(&c->c2.wait_for_connect, 1, now);
+            reset_coarse_timers(c);
+        }
+
+        if (tmp_status == TLSMP_ACTIVE || tmp_status == TLSMP_RECONNECT)
         {
             update_time();
             interval_action(&c->c2.tmp_int);
@@ -196,9 +203,15 @@ check_tls(struct context *c)
 
     interval_schedule_wakeup(&c->c2.tmp_int, &wakeup);
 
-    /* Our current code has no good hooks in the TLS machinery to update
+    /*
+     * Our current code has no good hooks in the TLS machinery to update
      * DCO keys. So we check the key status after the whole TLS machinery
      * has been completed and potentially update them
+     *
+     * We have a hidden state transition from secondary to primary key based
+     * on ks->auth_deferred_expire that DCO needs to check that the normal
+     * TLS state engine does not check. So we call the \c check_dco_key_status
+     * function even if tmp_status does not indicate that something has changed.
      */
     check_dco_key_status(c);
 
@@ -302,7 +315,6 @@ check_push_request(struct context *c)
 static void
 check_connection_established(struct context *c)
 {
-
     if (connection_established(c))
     {
         /* if --pull was specified, send a push request to server */
@@ -337,7 +349,6 @@ check_connection_established(struct context *c)
 
         event_timeout_clear(&c->c2.wait_for_connect);
     }
-
 }
 
 bool
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0e4769775..5f4b0543c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2219,7 +2219,13 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
                 }
             }
         }
+    }
 
+    /* This pats needs to be run in p2p mode (wihout pull) when the client
+     * reconnects to setup various things (like DCO and NCP cipher) that
+     * might have changed from the previous client. */
+    if (!c->c2.do_up_ran || (c->c2.tls_multi && c->c2.tls_multi->multi_state == CAS_RECONNECT_PENDING))
+    {
         if (c->mode == MODE_POINT_TO_POINT)
         {
             /* ovpn-dco requires adding the peer now, before any option can be set,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 818100c23..9e5480528 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3249,29 +3249,29 @@ tls_multi_process(struct tls_multi *multi,
 
     if (multi->multi_state >= CAS_CONNECT_DONE)
     {
-        for (int i = 0; i < TM_SIZE; ++i)
-        {
-            struct tls_session *session = &multi->session[i];
-            struct key_state *ks = &session->key[KS_PRIMARY];
+        /* Only generate keys for the TM_ACTIVE session. We defer generating
+         * keys for TM_UNTRUSTED until we actually trust it.
+         * For TM_LAME_DUCK it makes no sense to generate new keys. */
+        struct tls_session *session = &multi->session[TM_ACTIVE];
+        struct key_state *ks = &session->key[KS_PRIMARY];
 
-            if (ks->state == S_ACTIVE && ks->authenticated == KS_AUTH_TRUE)
+        if (ks->state == S_ACTIVE && ks->authenticated == KS_AUTH_TRUE)
+        {
+            /* Session is now fully authenticated.
+            * tls_session_generate_data_channel_keys will move ks->state
+            * from S_ACTIVE to S_GENERATED_KEYS */
+            if (!tls_session_generate_data_channel_keys(multi, session))
             {
-                /* Session is now fully authenticated.
-                * tls_session_generate_data_channel_keys will move ks->state
-                * from S_ACTIVE to S_GENERATED_KEYS */
-                if (!tls_session_generate_data_channel_keys(multi, session))
-                {
-                    msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
-                    ks->authenticated = KS_AUTH_FALSE;
-                    ks->state = S_ERROR;
-                }
+                msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
+                ks->authenticated = KS_AUTH_FALSE;
+                ks->state = S_ERROR;
+            }
 
-                /* Update auth token on the client if needed on renegotiation
-                 * (key id !=0) */
-                if (session->key[KS_PRIMARY].key_id != 0)
-                {
-                    resend_auth_token_renegotiation(multi, session);
-                }
+            /* Update auth token on the client if needed on renegotiation
+             * (key id !=0) */
+            if (session->key[KS_PRIMARY].key_id != 0)
+            {
+                resend_auth_token_renegotiation(multi, session);
             }
         }
     }
@@ -3304,6 +3304,12 @@ tls_multi_process(struct tls_multi *multi,
         move_session(multi, TM_ACTIVE, TM_UNTRUSTED, true);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: untrusted session promoted to %strusted",
             tas == TLS_AUTHENTICATION_SUCCEEDED ? "" : "semi-");
+
+        if (multi->multi_state == CAS_CONNECT_DONE)
+        {
+            multi->multi_state = CAS_RECONNECT_PENDING;
+            active = TLSMP_RECONNECT;
+        }
     }
 
     /*
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 646ec581a..55c672d44 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -212,6 +212,7 @@ void tls_multi_free(struct tls_multi *multi, bool clear);
 #define TLSMP_INACTIVE 0
 #define TLSMP_ACTIVE   1
 #define TLSMP_KILL     2
+#define TLSMP_RECONNECT 3
 
 /*
  * Called by the top-level event loop.
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e967970dd..0b5ad4c5f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -551,7 +551,12 @@ enum multi_status {
     CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded but another is still pending */
     CAS_FAILED,                     /**< Option import failed or explicitly denied the client */
     CAS_WAITING_OPTIONS_IMPORT,     /**< client with pull or p2p waiting for first time options import */
+    CAS_RECONNECT_PENDING,          /**< session has already successful established (CAS_CONNECT_DONE)
+                                     * but has a reconnect and needs to redo some initialisation, this state is
+                                     * similar CAS_WAITING_OPTIONS_IMPORT but skips a few things. The normal connection
+                                     * skips this step. */
     CAS_CONNECT_DONE,
+
 };
 
 
-- 
2.37.1 (Apple Git-137.1)


