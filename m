From: Arne Schwabe <arne@...1227...>
Date: Mon,  5 Jul 2021 15:34:14 +0200
Message-Id: <20210705133414.3102815-1-arne@...1227...>
In-Reply-To: <20210520151148.2565578-6-arne@...1227...>
References: <20210520151148.2565578-6-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 6/9] Introduce S_GENERATED_KEYS state and
 generate keys only when authenticated
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

Since generating data channel keys does not happen when we have reach the
S_ACTIVE/S_GOT_KEY state anymore like it used to be before NCP, the
state that data channel keys deserves its own state in the TLS session
state machine.

The changes done by this commit are rather intrusive since they
move the key generation to a completely different place and also
rely on the state machine to decide if keys should be
generated rather than on the complicated conditions that were
implemented in the key_method_2_write/read methods.

A (intended) side effect of this change is that sessions that
are still in deferred state (ks->authenticated == KS_DEFERRED)
will not have data channel keys generated. This avoids corner
cases where a not fully authenticated sessions might leak data.

Signed-off-by: Arne Schwabe <arne@...1227...>

Patch v2: rebased

Patch v3: fix crash in non TLS mode

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.h    |  2 +-
 src/openvpn/init.c       |  4 ++
 src/openvpn/ssl.c        | 89 +++++++++++++++++-----------------------
 src/openvpn/ssl.h        | 10 +++++
 src/openvpn/ssl_common.h |  9 +++-
 5 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index c9d9de7a4..2fb67e04c 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -416,7 +416,7 @@ connection_established(struct context *c)
 {
     if (c->c2.tls_multi)
     {
-        return c->c2.tls_multi->multi_state >= CAS_CONNECT_DONE;
+        return c->c2.tls_multi->multi_state >= CAS_WAITING_OPTIONS_IMPORT;
     }
     else
     {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1c674a243..3d4ba6226 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2202,6 +2202,10 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
         }
 
         c->c2.do_up_ran = true;
+        if (c->c2.tls_multi)
+        {
+            c->c2.tls_multi->multi_state = CAS_CONNECT_DONE;
+        }
     }
     return true;
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index fbe431436..592b2b893 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -788,6 +788,9 @@ state_name(int state)
         case S_ERROR:
             return "S_ERROR";
 
+        case S_GENERATED_KEYS:
+            return "S_GENERATED_KEYS";
+
         default:
             return "S_???";
     }
@@ -1840,13 +1843,13 @@ key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)
  * This erases the source material used to generate the data channel keys, and
  * can thus be called only once per session.
  */
-static bool
+bool
 tls_session_generate_data_channel_keys(struct tls_session *session)
 {
     bool ret = false;
     struct key_state *ks = &session->key[KS_PRIMARY];   /* primary key */
 
-    if (ks->authenticated == KS_AUTH_FALSE)
+    if (ks->authenticated <= KS_AUTH_FALSE)
     {
         msg(D_TLS_ERRORS, "TLS Error: key_state not authenticated");
         goto cleanup;
@@ -1862,6 +1865,9 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
     tls_limit_reneg_bytes(session->opt->key_type.cipher,
                           &session->opt->renegotiate_bytes);
 
+    /* set the state of the keys for the session to generated */
+    ks->state = S_GENERATED_KEYS;
+
     ret = true;
 cleanup:
     secure_memzero(ks->key_src, sizeof(*ks->key_src));
@@ -2375,31 +2381,6 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
         goto error;
     }
 
-    /*
-     * Generate tunnel keys if we're a TLS server.
-     *
-     * If we're a p2mp server to allow NCP, the first key
-     * generation is postponed until after the connect script finished and the
-     * NCP options can be processed. Since that always happens at after connect
-     * script options are available the CAS_CONNECT_DONE status is identical to
-     * NCP options are processed and do not wait for NCP being finished.
-     */
-    if (ks->authenticated > KS_AUTH_FALSE && session->opt->server
-        && ((session->opt->mode == MODE_SERVER && multi->multi_state >= CAS_CONNECT_DONE)
-            || (session->opt->mode == MODE_POINT_TO_POINT && !session->opt->pull)))
-    {
-        /* if key_id >= 1, is a renegotiation, so we use the already established
-         * parameters and do not need to delay anything. */
-
-        /* key-id == 0 and multi_state >= CAS_CONNECT_DONE is a special case of
-         * the server reusing the session of a reconnecting client. */
-        if (!tls_session_generate_data_channel_keys(session))
-        {
-            msg(D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
-            goto error;
-        }
-    }
-
     return true;
 
 error:
@@ -2599,21 +2580,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
 
         setenv_del(session->opt->es, "exported_keying_material");
     }
-
-    /*
-     * Generate tunnel keys if we're a client.
-     * If --pull is enabled, the first key generation is postponed until after the
-     * pull/push, so we can process pushed cipher directives.
-     */
-    if (!session->opt->server && (!session->opt->pull || ks->key_id > 0))
-    {
-        if (!tls_session_generate_data_channel_keys(session))
-        {
-            msg(D_TLS_ERRORS, "TLS Error: client generate_key_expansion failed");
-            goto error;
-        }
-    }
-
+    
     gc_free(&gc);
     return true;
 
@@ -2815,7 +2782,7 @@ tls_process(struct tls_multi *multi,
                     else
                     {
                         /* Skip the connect script related states */
-                        multi->multi_state = CAS_CONNECT_DONE;
+                        multi->multi_state = CAS_WAITING_OPTIONS_IMPORT;
                     }
                 }
 
@@ -3138,6 +3105,27 @@ tls_multi_process(struct tls_multi *multi,
 
     /* If we have successfully authenticated and are still waiting for the authentication to finish
      * move the state machine for the multi context forward */
+
+    if (multi->multi_state >= CAS_CONNECT_DONE)
+    {
+        for (int i = 0; i < TM_SIZE; ++i)
+        {
+            struct tls_session *session = &multi->session[i];
+            struct key_state *ks = &session->key[KS_PRIMARY];
+
+            if (ks->state == S_ACTIVE && ks->authenticated == KS_AUTH_TRUE)
+            {
+                /* This will ks->state from S_ACTIVE to S_GENERATED_KEYS */
+                if (!tls_session_generate_data_channel_keys(session))
+                {
+                    msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
+                    ks->authenticated = KS_AUTH_FALSE;
+                    ks->state = S_ERROR;
+                }
+            }
+        }
+    }
+
     if (multi->multi_state == CAS_WAITING_AUTH && tas == TLS_AUTHENTICATION_SUCCEEDED)
     {
         multi->multi_state = CAS_PENDING;
@@ -3246,11 +3234,10 @@ handle_data_channel_packet(struct tls_multi *multi,
          * passive side is the server which only listens for the connections, the
          * active side is the client which initiates connections).
          */
-        if (TLS_AUTHENTICATED(multi, ks)
-            && key_id == ks->key_id
-            && (ks->authenticated == KS_AUTH_TRUE)
+        if (ks->state >= S_GENERATED_KEYS  && key_id == ks->key_id
             && (floated || link_socket_actual_match(from, &ks->remote_addr)))
         {
+            ASSERT(ks->authenticated == KS_AUTH_TRUE);
             if (!ks->crypto_options.key_ctx_bi.initialized)
             {
                 msg(D_MULTI_DROPPED,
@@ -3572,8 +3559,7 @@ tls_pre_decrypt(struct tls_multi *multi,
         /*
          * Remote is requesting a key renegotiation
          */
-        if (op == P_CONTROL_SOFT_RESET_V1
-            && TLS_AUTHENTICATED(multi, ks))
+        if (op == P_CONTROL_SOFT_RESET_V1 && TLS_AUTHENTICATED(multi, ks))
         {
             if (!read_control_auth(buf, &session->tls_wrap, from,
                                    session->opt))
@@ -3834,10 +3820,11 @@ struct key_state *tls_select_encryption_key(struct tls_multi *multi)
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks = get_key_scan(multi, i);
-        if (ks->state >= S_ACTIVE
-            && ks->authenticated == KS_AUTH_TRUE
-            && ks->crypto_options.key_ctx_bi.initialized)
+        if (ks->state >= S_GENERATED_KEYS)
         {
+            ASSERT(ks->authenticated == KS_AUTH_TRUE);
+            ASSERT(ks->crypto_options.key_ctx_bi.initialized);
+
             if (!ks_select)
             {
                 ks_select = ks;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 933e0559a..58b39466b 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -612,4 +612,14 @@ show_available_tls_ciphers(const char *cipher_list,
                            const char *cipher_list_tls13,
                            const char *tls_cert_profile);
 
+
+/**
+ * Generate data channel keys for the supplied TLS session.
+ *
+ * This erases the source material used to generate the data channel keys, and
+ * can thus be called only once per session.
+ */
+bool
+tls_session_generate_data_channel_keys(struct tls_session *session);
+
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 6bfb40679..43d6276be 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -64,7 +64,8 @@
  *      material.
  *   -# \c S_GOT_KEY, have received remote part of \c key_source2 random
  *      material.
- *   -# \c S_ACTIVE, normal operation
+ *   -# \c S_ACTIVE, control channel successfully established
+ *   -# \c S_GENERATED_KEYS, the
  *
  * Servers follow the same order, except for \c S_SENT_KEY and \c
  * S_GOT_KEY being reversed, because the server first receives the
@@ -92,7 +93,10 @@
 #define S_ACTIVE          6     /**< Operational \c key_state state
                                  *   immediately after negotiation has
                                  *   completed while still within the
-                                 *   handshake window. */
+                                 *   handshake window, deferred auth, client
+                                 *   connect and can still
+                                 *   be pending. */
+#define S_GENERATED_KEYS  7     /**< The data channel keys have been generated */
 /* Note that earlier versions also had a S_OP_NORMAL state that was
  * virtually identical with S_ACTIVE and the code still assumes everything
  * >= S_ACTIVE to be fully operational */
@@ -516,6 +520,7 @@ enum multi_status {
     CAS_PENDING_DEFERRED,
     CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded, no result yet*/
     CAS_FAILED,
+    CAS_WAITING_OPTIONS_IMPORT,     /**< client with pull or p2p waiting for first time options import */
     CAS_CONNECT_DONE,
 };
 
-- 
2.32.0


