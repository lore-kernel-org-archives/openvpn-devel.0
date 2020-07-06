From: Arne Schwabe <arne@...1227...>
Date: Mon,  6 Jul 2020 18:35:16 +0200
Message-Id: <20200706163516.11390-2-arne@...1227...>
In-Reply-To: <20200706163516.11390-1-arne@...1227...>
References: <20200706163516.11390-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/2] merge key_state->authenticated and
 key_state->auth_deferred
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

Both are tightly coupled often both are checked at the same time.
Merging them into one state makes the code simpler and also brings
us closer in the direction of a state machine

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c        | 29 ++++++++++++-----------------
 src/openvpn/ssl_common.h |  9 +++++++--
 src/openvpn/ssl_verify.c | 27 ++++++++++++++-------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1cf8e44f..9df7552d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1930,7 +1930,7 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
     const struct session_id *server_sid = !session->opt->server ?
                                           &ks->session_id_remote : &session->session_id;
 
-    if (!ks->authenticated)
+    if (ks->authenticated == KS_AUTH_FALSE)
     {
         msg(D_TLS_ERRORS, "TLS Error: key_state not authenticated");
         goto cleanup;
@@ -2466,7 +2466,7 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
     if (session->opt->server && !(session->opt->ncp_enabled
                                   && session->opt->mode == MODE_SERVER && ks->key_id <= 0))
     {
-        if (ks->authenticated)
+        if (ks->authenticated != KS_AUTH_FALSE)
         {
             if (!tls_session_generate_data_channel_keys(session))
             {
@@ -2536,7 +2536,7 @@ key_method_1_read(struct buffer *buf, struct tls_session *session)
                  &session->opt->key_type, OPENVPN_OP_DECRYPT,
                  "Data Channel Decrypt");
     secure_memzero(&key, sizeof(key));
-    ks->authenticated = true;
+    ks->authenticated = KS_AUTH_TRUE;
     return true;
 
 error:
@@ -2594,7 +2594,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
         goto error;
     }
 
-    ks->authenticated = false;
+    ks->authenticated = KS_AUTH_FALSE;
 
     /* always extract username + password fields from buf, even if not
      * authenticating for it, because otherwise we can't get at the
@@ -2652,14 +2652,14 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
                 "TLS Error: Certificate verification failed (key-method 2)");
             goto error;
         }
-        ks->authenticated = true;
+        ks->authenticated = KS_AUTH_TRUE;
     }
 
     /* clear username and password from memory */
     secure_memzero(up, sizeof(*up));
 
     /* Perform final authentication checks */
-    if (ks->authenticated)
+    if (ks->authenticated != KS_AUTH_FALSE)
     {
         verify_final_auth_checks(multi, session);
     }
@@ -2673,7 +2673,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
         if (session->opt->ssl_flags & SSLF_OPT_VERIFY)
         {
             msg(D_TLS_ERRORS, "Option inconsistency warnings triggering disconnect due to --opt-verify");
-            ks->authenticated = false;
+            ks->authenticated = KS_AUTH_FALSE;
         }
     }
 #endif
@@ -2684,13 +2684,14 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
      * Call OPENVPN_PLUGIN_TLS_FINAL plugin if defined, for final
      * veto opportunity over authentication decision.
      */
-    if (ks->authenticated && plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
+    if ((ks->authenticated != KS_AUTH_FALSE)
+        && plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
     {
         key_state_export_keying_material(&ks->ks_ssl, session);
 
         if (plugin_call(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
-            ks->authenticated = false;
+            ks->authenticated = KS_AUTH_FALSE;
         }
 
         setenv_del(session->opt->es, "exported_keying_material");
@@ -3394,10 +3395,7 @@ tls_pre_decrypt(struct tls_multi *multi,
                  */
                 if (DECRYPT_KEY_ENABLED(multi, ks)
                     && key_id == ks->key_id
-                    && ks->authenticated
-#ifdef ENABLE_DEF_AUTH
-                    && !ks->auth_deferred
-#endif
+                    && (ks->authenticated == KS_AUTH_TRUE)
                     && (floated || link_socket_actual_match(from, &ks->remote_addr)))
                 {
                     if (!ks->crypto_options.key_ctx_bi.initialized)
@@ -3946,11 +3944,8 @@ tls_pre_encrypt(struct tls_multi *multi,
         {
             struct key_state *ks = multi->key_scan[i];
             if (ks->state >= S_ACTIVE
-                && ks->authenticated
+                && (ks->authenticated == KS_AUTH_TRUE)
                 && ks->crypto_options.key_ctx_bi.initialized
-#ifdef ENABLE_DEF_AUTH
-                && !ks->auth_deferred
-#endif
                 )
             {
                 if (!ks_select)
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index fe523362..fdf589b5 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -127,6 +127,12 @@ struct key_source2 {
     struct key_source server;   /**< Random provided by server. */
 };
 
+enum ks_auth_state {
+  KS_AUTH_FALSE,
+  KS_AUTH_TRUE,
+  KS_AUTH_DEFERRED
+};
+
 /**
  * Security parameter state of one TLS and data channel %key session.
  * @ingroup control_processor
@@ -185,12 +191,11 @@ struct key_state
     /*
      * If bad username/password, TLS connection will come up but 'authenticated' will be false.
      */
-    bool authenticated;
+    enum ks_auth_state authenticated;
     time_t auth_deferred_expire;
 
 #ifdef ENABLE_DEF_AUTH
     /* If auth_deferred is true, authentication is being deferred */
-    bool auth_deferred;
 #ifdef MANAGEMENT_DEF_AUTH
     unsigned int mda_key_id;
     unsigned int mda_status;
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 68c39c6f..e28f1f3a 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -78,7 +78,7 @@ tls_deauthenticate(struct tls_multi *multi)
         {
             for (int j = 0; j < KS_SIZE; ++j)
             {
-                multi->session[i].key[j].authenticated = false;
+                multi->session[i].key[j].authenticated = KS_AUTH_FALSE;
             }
         }
     }
@@ -950,7 +950,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
             if (DECRYPT_KEY_ENABLED(multi, ks))
             {
                 active = true;
-                if (ks->authenticated)
+                if (ks->authenticated != KS_AUTH_FALSE)
                 {
 #ifdef ENABLE_DEF_AUTH
                     unsigned int s1 = ACF_DISABLED;
@@ -967,7 +967,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
                         case ACF_SUCCEEDED:
                         case ACF_DISABLED:
                             success = true;
-                            ks->auth_deferred = false;
+                            ks->authenticated = KS_AUTH_TRUE;
                             break;
 
                         case ACF_UNDEFINED:
@@ -978,7 +978,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
                             break;
 
                         case ACF_FAILED:
-                            ks->authenticated = false;
+                            ks->authenticated = KS_AUTH_FALSE;
                             break;
 
                         default:
@@ -1308,7 +1308,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         else
         {
             wipe_auth_token(multi);
-            ks->authenticated = false;
+            ks->authenticated = KS_AUTH_FALSE;
             msg(M_WARN, "TLS: Username/auth-token authentication "
                 "failed for username '%s'", up->username);
             return;
@@ -1354,17 +1354,17 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
 #endif
         && tls_lock_username(multi, up->username))
     {
-        ks->authenticated = true;
+        ks->authenticated = KS_AUTH_TRUE;
 #ifdef PLUGIN_DEF_AUTH
         if (s1 == OPENVPN_PLUGIN_FUNC_DEFERRED)
         {
-            ks->auth_deferred = true;
+            ks->authenticated = KS_AUTH_DEFERRED;
         }
 #endif
 #ifdef MANAGEMENT_DEF_AUTH
         if (man_def_auth != KMDA_UNDEF)
         {
-            ks->auth_deferred = true;
+            ks->authenticated = KS_AUTH_DEFERRED;
         }
 #endif
         if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
@@ -1416,7 +1416,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         }
 #ifdef ENABLE_DEF_AUTH
         msg(D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
-            ks->auth_deferred ? "deferred" : "succeeded",
+            (ks->authenticated == KS_AUTH_DEFERRED) ? "deferred" : "succeeded",
             up->username,
             (session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
 #else
@@ -1428,6 +1428,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     }
     else
     {
+        ks->authenticated = KS_AUTH_FALSE;
         msg(D_TLS_ERRORS, "TLS Auth Error: Auth Username/Password verification failed for peer");
     }
 }
@@ -1444,7 +1445,7 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
     }
 
     /* Don't allow the CN to change once it's been locked */
-    if (ks->authenticated && multi->locked_cn)
+    if (ks->authenticated != KS_AUTH_FALSE && multi->locked_cn)
     {
         const char *cn = session->common_name;
         if (cn && strcmp(cn, multi->locked_cn))
@@ -1460,7 +1461,7 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
     }
 
     /* Don't allow the cert hashes to change once they have been locked */
-    if (ks->authenticated && multi->locked_cert_hash_set)
+    if (ks->authenticated != KS_AUTH_FALSE && multi->locked_cert_hash_set)
     {
         const struct cert_hash_set *chs = session->cert_hash_set;
         if (chs && !cert_hash_compare(chs, multi->locked_cert_hash_set))
@@ -1474,7 +1475,7 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
     }
 
     /* verify --client-config-dir based authentication */
-    if (ks->authenticated && session->opt->client_config_dir_exclusive)
+    if (ks->authenticated != KS_AUTH_FALSE && session->opt->client_config_dir_exclusive)
     {
         struct gc_arena gc = gc_new();
 
@@ -1483,7 +1484,7 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
                                              cn, &gc);
         if (!cn || !strcmp(cn, CCD_DEFAULT) || !platform_test_file(path))
         {
-            ks->authenticated = false;
+            ks->authenticated = KS_AUTH_FALSE;
             wipe_auth_token(multi);
             msg(D_TLS_ERRORS, "TLS Auth Error: --client-config-dir authentication failed for common name '%s' file='%s'",
                 session->common_name,
-- 
2.26.2


