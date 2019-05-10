From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 May 2019 14:11:12 +0200
Message-Id: <20190510121114.30468-6-arne@...1227...>
In-Reply-To: <20190510121114.30468-1-arne@...1227...>
References: <20190510121114.30468-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 5/7] Implement a permanent session id in
 auth-token
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
Cc: Arne Schwabe <arne@...515...>

From: Arne Schwabe <arne@...515...>

This allows an external authentication method
(e.g. management interface) to track the connection and distinguish a
reconnection from multiple connections.

Addtionally this now also checks to workaround a problem with
OpenVPN 3 core that sometimes uses a username hint from the config
instead of using an empty username if the token would be valid
with an empty username. Accepting such token can be only done
explicitly when the external-auth keyword to auth-gen-token is present.

Patch V2: Add Empty variants to work around behaviour in openvpn 3
Patch V3: document the behaviour of external-auth better in the man page,
          rename 'auth' parameter to 'external-auth'
---
 doc/openvpn.8            |  37 +++++++++-
 src/openvpn/auth_token.c | 145 ++++++++++++++++++++++++++++++++++++---
 src/openvpn/auth_token.h |  15 +++-
 src/openvpn/init.c       |   1 +
 src/openvpn/manage.c     |   4 +-
 src/openvpn/options.c    |  14 +++-
 src/openvpn/options.h    |   4 +-
 src/openvpn/ssl_common.h |  12 +++-
 src/openvpn/ssl_verify.c |  67 ++++++++++++------
 9 files changed, 260 insertions(+), 39 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 0ae617a3..8c16a272 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3710,7 +3710,7 @@ For a sample script that performs PAM authentication, see
 in the OpenVPN source distribution.
 .\"*********************************************************
 .TP
-.B \-\-auth\-gen\-token [lifetime]
+.B \-\-auth\-gen\-token [lifetime] [auth]
 After successful user/password authentication, the OpenVPN
 server will with this option generate a temporary
 authentication token and push that to client.  On the following
@@ -3733,6 +3733,41 @@ This feature is useful for environments which is configured
 to use One Time Passwords (OTP) as part of the user/password
 authentications and that authentication mechanism does not
 implement any auth\-token support.
+
+When the external-auth keyword is present the normal authentication
+method will always be called even if auth-token succeeds. Normally other
+authentications method are skipped if auth-token verification suceeds or
+fails.
+
+This option postpones this decision to the external authentication methods
+and check the validity of the account and do other checks.
+
+In this mode the environment will have a session_id variable
+that hold the session id from auth-gen-token. Also a environment
+variable session_state is present. This variable tells whether the
+auth-token has succeeded or not. It can have the following values:
+
+ - Initial:                    No token from client.
+ - Authenticated:              Token is valid and not expired
+ - Expired:                    Token is valid but has expired
+ - Invalid                     Token is invalid (failed HMAC or wrong length)
+ - AuthenticatedEmptyUser/ExpiredEmptyUser
+   The token is not valid with the username send from the client
+   but would be valid (or expired) if we assume an empty username was used
+   instead. These two cases are a workaround for behaviour in OpenVPN3. If
+   this workaround is not needed these two cases should be handled in the
+   same way as Invalid.
+
+.B Warning:
+Use this feature only if you want your authentication method called on
+every verification. Since the external authentication is called it needs
+to also indicate a success or failure of the authentication. It is strongly
+recommended to return an authentication failure in the case of the
+Invalid/Expired auth-token with the external-auth option unless the client
+could authenticate in another acceptable way (e.g. client certificate),
+otherwise returning success will lead to authentication bypass (as does
+returning success on a wrong password from a script).
+
 .\"*********************************************************
 .TP
 .B \-\-auth\-gen\-token\-secret [file]
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index dc8d68f6..f28008d3 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -18,9 +18,13 @@
 
 const char *auth_token_pem_name = "OpenVPN auth-token server key";
 
+#define AUTH_TOKEN_SESSION_ID_LEN 12
+#if AUTH_TOKEN_SESSION_ID_LEN % 3
+#error AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3
+#endif
 
 /* Size of the data of the token (not b64 encoded and without prefix) */
-#define TOKEN_DATA_LEN (2 * sizeof(int64_t) + 32)
+#define TOKEN_DATA_LEN (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + 32)
 
 static struct key_type
 auth_token_kt(void)
@@ -42,6 +46,85 @@ auth_token_kt(void)
 }
 
 
+void
+add_session_token_env(struct tls_session *session, struct tls_multi *multi,
+                      const struct user_pass *up)
+{
+    if (!multi->opt.auth_token_generate)
+    {
+        return;
+    }
+
+
+    const char *state;
+
+    if (!is_auth_token(up->password))
+    {
+        state = "Initial";
+    }
+    else if (multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
+    {
+        switch (multi->auth_token_state_flags & (AUTH_TOKEN_VALID_EMPTYUSER|AUTH_TOKEN_EXPIRED))
+        {
+            case 0:
+                state = "Authenticated";
+                break;
+
+            case AUTH_TOKEN_EXPIRED:
+                state = "Expired";
+                break;
+
+            case AUTH_TOKEN_VALID_EMPTYUSER:
+                state = "AuthenticatedEmptyUser";
+                break;
+
+            case AUTH_TOKEN_VALID_EMPTYUSER | AUTH_TOKEN_EXPIRED:
+                state = "ExpiredEmptyUser";
+                break;
+
+            default:
+                /* Silence compiler warning, all four possible combinations are covered */
+                ASSERT(0);
+        }
+    }
+    else
+    {
+        state = "Invalid";
+    }
+
+    setenv_str(session->opt->es, "session_state", state);
+
+    /* We had a valid session id before */
+    const char *session_id_source;
+    if (multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK
+        &!(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
+    {
+        session_id_source = up->password;
+    }
+    else
+    {
+        /*
+         * No session before, generate a new session token for the new session
+         */
+        if (!multi->auth_token)
+        {
+            generate_auth_token(up, multi);
+        }
+        session_id_source = multi->auth_token;
+    }
+    /*
+     * In the auth-token the auth token is already base64 encoded
+     * and being a multiple of 4 ensure that it a multiple of bytes
+     * in the encoding
+     */
+
+    char session_id[AUTH_TOKEN_SESSION_ID_LEN*2] = {0};
+    memcpy(session_id, session_id_source + sizeof(SESSION_ID_PREFIX),
+           AUTH_TOKEN_SESSION_ID_LEN*8/6);
+
+    setenv_str(session->opt->es, "session_id", session_id);
+}
+
 void
 auth_token_write_server_key_file(const char *filename)
 {
@@ -85,6 +168,8 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
     hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
     ASSERT(hmac_ctx_size(ctx) == 256/8);
 
+    uint8_t sessid[AUTH_TOKEN_SESSION_ID_LEN];
+
     if (multi->auth_token)
     {
         /* Just enough space to fit 8 bytes+ 1 extra to decode a non padded
@@ -97,27 +182,58 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
          * reuse the same session id and timestamp and null terminate it at
          * for base64 decode it only decodes the session id part of it
          */
-        char *old_tsamp_initial = multi->auth_token + strlen(SESSION_ID_PREFIX);
+        char *old_sessid = multi->auth_token + strlen(SESSION_ID_PREFIX);
+        char *old_tsamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;
 
         old_tsamp_initial[12] = '\0';
         ASSERT(openvpn_base64_decode(old_tsamp_initial, old_tstamp_decode, 9) == 9);
         initial_timestamp = *((uint64_t *)(old_tstamp_decode));
 
+        old_tsamp_initial[0] = '\0';
+        ASSERT(openvpn_base64_decode(old_sessid, sessid, AUTH_TOKEN_SESSION_ID_LEN)==AUTH_TOKEN_SESSION_ID_LEN);
+
+
         /* free the auth-token, we will replace it with a new one */
         free(multi->auth_token);
     }
+    else if (!rand_bytes(sessid, AUTH_TOKEN_SESSION_ID_LEN))
+    {
+        msg( M_FATAL, "Failed to get enough randomness for "
+             "authentication token");
+    }
+
+    /* Calculate the HMAC */
+    /* We enforce up->username to be \0 terminated in ssl.c.. Allowing username
+     * with \0 in them is asking for troubles in so many ways anyway that we
+     * ignore that corner case here
+     */
     uint8_t hmac_output[256/8];
 
     hmac_ctx_reset(ctx);
-    hmac_ctx_update(ctx, (uint8_t *) up->username, (int)strlen(up->username));
+
+    /*
+     * If the token was only valid for the empty user, also generate
+     * a new token with the empty username since we do not want to loose
+     * the information that the username cannot be trusted
+     */
+    if (multi->auth_token_state_flags & AUTH_TOKEN_VALID_EMPTYUSER)
+    {
+        hmac_ctx_update(ctx, (const uint8_t *) "", 0);
+    }
+    else
+    {
+        hmac_ctx_update(ctx, (uint8_t *) up->username, (int) strlen(up->username));
+    }
+    hmac_ctx_update(ctx, sessid, AUTH_TOKEN_SESSION_ID_LEN);
     hmac_ctx_update(ctx, (uint8_t *) &initial_timestamp, sizeof(initial_timestamp));
     hmac_ctx_update(ctx, (uint8_t *) &timestamp, sizeof(timestamp));
     hmac_ctx_final(ctx, hmac_output);
 
     /* Construct the unencoded session token */
     struct buffer token = alloc_buf_gc(
-        2*sizeof(uint64_t)  + 256/8, &gc);
+        2*sizeof(uint64_t) + AUTH_TOKEN_SESSION_ID_LEN + 256/8, &gc);
 
+    ASSERT(buf_write(&token, sessid, sizeof(sessid)));
     ASSERT(buf_write(&token, &initial_timestamp, sizeof(initial_timestamp)));
     ASSERT(buf_write(&token, &timestamp, sizeof(timestamp)));
     ASSERT(buf_write(&token, hmac_output, sizeof(hmac_output)));
@@ -136,12 +252,13 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
 
     multi->auth_token = strdup((char *)BPTR(&session_token));
 
-    dmsg(D_SHOW_KEYS, "Generated token for client: %s",
-         multi->auth_token);
+    dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)",
+         multi->auth_token, up->username);
 
     gc_free(&gc);
 }
 
+
 static bool
 check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, const char *username)
 {
@@ -169,9 +286,11 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
     uint8_t b64decoded[USER_PASS_LEN];
     int decoded_len = openvpn_base64_decode(up->password + strlen(SESSION_ID_PREFIX),
                                             b64decoded, USER_PASS_LEN);
-    /* Ensure that the decoded data is at least the size of the
-     * timestamp + hmac */
 
+    /*
+     * Ensure that the decoded data is the size of the
+     * timestamp + hmac + session id
+     */
     if (decoded_len != TOKEN_DATA_LEN)
     {
         msg(M_WARN, "ERROR: --auth-token wrong size (%d!=%d)",
@@ -181,8 +300,8 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
 
     unsigned int ret = 0;
 
-
-    const uint8_t *tstamp_initial = b64decoded;
+    const uint8_t *sessid = b64decoded;
+    const uint8_t *tstamp_initial = sessid + AUTH_TOKEN_SESSION_ID_LEN;
     const uint8_t *tstamp = tstamp_initial + sizeof(int64_t);
 
     uint64_t timestamp = ntohll(*((uint64_t *) (tstamp)));
@@ -193,6 +312,11 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
     {
         ret |= AUTH_TOKEN_HMAC_OK;
     }
+    else if (check_hmac_token(ctx, b64decoded, ""))
+    {
+        ret |= AUTH_TOKEN_HMAC_OK;
+        ret |= AUTH_TOKEN_VALID_EMPTYUSER;
+    }
     else
     {
         msg(M_WARN, "--auth-token-gen: HMAC on token from client failed (%s)",
@@ -235,7 +359,6 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
     {
         msg(M_INFO, "--auth-token-gen: auth-token from client expired");
     }
-
     return ret;
 }
 
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 600ac29f..c10afde9 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -34,7 +34,8 @@
  *
  * Format of the auth-token (before base64 encode)
  *
- * uint64 timestamp (4 bytes)|uint64 timestamp (4 bytes)|sha256-hmac(32 bytes)
+ * session id(12 bytes)|uint64 timestamp (4 bytes)|
+ * uint64 timestamp (4 bytes)|sha256-hmac(32 bytes)
  *
  * The first timestamp is the time the token was initially created and is used to
  * determine the maximum renewable time of the token. We always include this even
@@ -44,6 +45,10 @@
  * to determine if this token has been renewed in the acceptable time range
  * (2 * renogiation timeout)
  *
+ * The session is a random string of 12 byte (or 16 in base64) that is not used by
+ * OpenVPN itself but kept intact so that external logging/managment can track the
+ * session multiple reconnects/servers
+ *
  * The hmac is calculated over the username contactinated with the
  * raw auth-token bytes to include authentication of the username in the token
  *
@@ -82,6 +87,14 @@ auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
 void auth_token_write_server_key_file(const char *filename);
 
 
+/**
+ * Put the session id, and auth token status into the environment
+ * if auth-token is enabled
+ *
+ */
+void add_session_token_env(struct tls_session *session, struct tls_multi *multi,
+                           const struct user_pass *up);
+
 /**
  * Wipes the authentication token out of the memory, frees and cleans up
  * related buffers and flags
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1732312f..a3cc1f37 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2873,6 +2873,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.auth_user_pass_file = options->auth_user_pass_file;
     to.auth_token_generate = options->auth_token_generate;
     to.auth_token_lifetime = options->auth_token_lifetime;
+    to.auth_token_call_auth = options->auth_token_call_auth;
     to.auth_token_key = c->c1.ks.auth_token_key;
 #endif
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2d86dad4..1d97c2b6 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2736,7 +2736,9 @@ env_filter_match(const char *env_str, const int env_filter_level)
         "ifconfig_pool_netmask=",
         "time_duration=",
         "bytes_sent=",
-        "bytes_received="
+        "bytes_received=",
+        "session_id=",
+        "session_state="
     };
 
     if (env_filter_level == 0)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3dac1e7a..9993063a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6766,11 +6766,23 @@ add_option(struct options *options,
                         &options->auth_user_pass_verify_script,
                         p[1], "auth-user-pass-verify", true);
     }
-    else if (streq(p[0], "auth-gen-token"))
+    else if (streq(p[0], "auth-gen-token") && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->auth_token_generate = true;
         options->auth_token_lifetime = p[1] ? positive_atoi(p[1]) : 0;
+        if (p[2])
+        {
+            if (streq(p[2], "external-auth"))
+            {
+                options->auth_token_call_auth = true;
+            }
+            else
+            {
+                msg(msglevel, "Invalid argument to auth-gen_token: %s", p[2]);
+            }
+        }
+
     }
     else if (streq(p[0], "auth-gen-token-secret") && p[1] && (!p[2]
                                                               || (p[2] && streq(p[1], INLINE_FILE_TAG))))
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index cad5be81..4b3883e6 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -469,7 +469,9 @@ struct options
     const char *auth_user_pass_verify_script;
     bool auth_user_pass_verify_script_via_file;
     bool auth_token_generate;
-    unsigned int auth_token_lifetime;
+    bool auth_token_gen_secret_file;
+    bool auth_token_call_auth;
+    int auth_token_lifetime;
     const char *auth_token_secret_file;
     const char *auth_token_secret_file_inline;
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index ff8ffacc..8cdb7dce 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -310,6 +310,7 @@ struct tls_options
     bool auth_token_generate;   /**< Generate auth-tokens on successful
                                  * user/pass auth,seet via
                                  * options->auth_token_generate. */
+    bool auth_token_call_auth; /**< always call normal authentication */
     unsigned int auth_token_lifetime;
 
     struct key_ctx auth_token_key;
@@ -469,7 +470,6 @@ struct tls_session
  */
 #define KEY_SCAN_SIZE 3
 
-
 /**
  * Security parameter state for a single VPN tunnel.
  * @ingroup control_processor
@@ -552,9 +552,17 @@ struct tls_multi
     /**< Auth-token sent from client has valid hmac */
 #define  AUTH_TOKEN_EXPIRED              (1<<1)
     /**< Auth-token sent from client has expired */
-#endif
+#define  AUTH_TOKEN_VALID_EMPTYUSER      (1<<2)
+    /**<
+     * Auth-token is only valid for an empty username
+     * and not the username actually supplied from the client
+     *
+     * OpenVPN 3 clients sometimes the empty username with a
+     * username hint from their config.
+     */
     int auth_token_state_flags;
     /**< The state of the auth-token sent from the client last time */
+#endif
 
     /* For P_DATA_V2 */
     uint32_t peer_id;
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index b392b0ac..6535ad8d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1052,7 +1052,8 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
  * Verify the user name and password using a script
  */
 static bool
-verify_user_pass_script(struct tls_session *session, const struct user_pass *up)
+verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
+                        const struct user_pass *up)
 {
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
@@ -1101,6 +1102,9 @@ verify_user_pass_script(struct tls_session *session, const struct user_pass *up)
         /* setenv client real IP address */
         setenv_untrusted(session);
 
+        /* add auth-token environment */
+        add_session_token_env(session, multi, up);
+
         /* format command line */
         argv_parse_cmd(&argv, session->opt->auth_user_pass_verify_script);
         argv_printf_cat(&argv, "%s", tmp_file);
@@ -1134,7 +1138,8 @@ done:
  * Verify the username and password using a plugin
  */
 static int
-verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up)
+verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
+                        const struct user_pass *up)
 {
     int retval = OPENVPN_PLUGIN_FUNC_ERROR;
 #ifdef PLUGIN_DEF_AUTH
@@ -1154,6 +1159,8 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up)
         /* setenv client real IP address */
         setenv_untrusted(session);
 
+        /* add auth-token environment */
+        add_session_token_env(session, multi, up);
 #ifdef PLUGIN_DEF_AUTH
         /* generate filename for deferred auth control file */
         if (!key_state_gen_auth_control_file(ks, session->opt))
@@ -1197,7 +1204,9 @@ cleanup:
 #define KMDA_DEF     3
 
 static int
-verify_user_pass_management(struct tls_session *session, const struct user_pass *up)
+verify_user_pass_management(struct tls_session *session,
+                            struct tls_multi* multi,
+                            const struct user_pass *up)
 {
     int retval = KMDA_ERROR;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
@@ -1215,6 +1224,11 @@ verify_user_pass_management(struct tls_session *session, const struct user_pass
         /* setenv client real IP address */
         setenv_untrusted(session);
 
+        /*
+         * if we are using auth-gen-token, send also the session id of auth gen token to
+         * allow the management to figure out if it is a new session or a continued one
+         */
+        add_session_token_env(session, multi, up);
         if (management)
         {
             management_notify_client_needing_auth(management, ks->mda_key_id, session->opt->mda_context, session->opt->es);
@@ -1272,17 +1286,25 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
      */
     if (session->opt->auth_token_generate && is_auth_token(up->password))
     {
-        multi->auth_token_state_flags = verify_auth_token(up, multi,session);
-        if (multi->auth_token_state_flags == AUTH_TOKEN_HMAC_OK)
+        multi->auth_token_state_flags = verify_auth_token(up, multi, session);
+        if (session->opt->auth_token_call_auth)
+        {
+            /*
+             * we do not care about the result here because it is
+             * the responsibility of the external authentication to
+             * decide what to do with the result
+             */
+        }
+        else if (multi->auth_token_state_flags == AUTH_TOKEN_HMAC_OK)
         {
             /*
-             * We do not want the EXPIRED flag here so check
+             * We do not want the EXPIRED or EMPTY USER flags here so check
              * for equality with AUTH_TOKEN_HMAC_OK
              */
             msg(M_WARN, "TLS: Username/auth-token authentication "
-                "succeeded for username '%s'",
+                        "succeeded for username '%s'",
                 up->username);
-            skip_auth = true;
+              skip_auth = true;
         }
         else
         {
@@ -1293,31 +1315,34 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
             return;
         }
     }
+    /* call plugin(s) and/or script */
     if (!skip_auth)
     {
-
-        /* call plugin(s) and/or script */
 #ifdef MANAGEMENT_DEF_AUTH
-        if (man_def_auth == KMDA_DEF)
+        if (man_def_auth==KMDA_DEF)
         {
-            man_def_auth = verify_user_pass_management(session, up);
+            man_def_auth = verify_user_pass_management(session, multi, up);
         }
 #endif
         if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
         {
-            s1 = verify_user_pass_plugin(session, up);
+            s1 = verify_user_pass_plugin(session, multi, up);
         }
+
         if (session->opt->auth_user_pass_verify_script)
         {
-            s2 = verify_user_pass_script(session, up);
+            s2 = verify_user_pass_script(session, multi, up);
         }
+    }
 
-        /* check sizing of username if it will become our common name */
-        if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && strlen(up->username) > TLS_USERNAME_LEN)
-        {
-            msg(D_TLS_ERRORS, "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters", TLS_USERNAME_LEN);
-            s1 = OPENVPN_PLUGIN_FUNC_ERROR;
-        }
+    /* check sizing of username if it will become our common name */
+    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) &&
+         strlen(up->username)>TLS_USERNAME_LEN)
+    {
+        msg(D_TLS_ERRORS,
+                "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters",
+                TLS_USERNAME_LEN);
+        s1 = OPENVPN_PLUGIN_FUNC_ERROR;
     }
     /* auth succeeded? */
     if ((s1 == OPENVPN_PLUGIN_FUNC_SUCCESS
@@ -1357,7 +1382,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
              * the initial timestamp and session id can be extracted from it
              */
             if (multi->auth_token && (multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
-                   && !(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
+                && !(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
             {
                 multi->auth_token = strdup(up->password);
             }
-- 
2.21.0


