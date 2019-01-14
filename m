From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Jan 2019 16:48:18 +0100
Message-Id: <20190114154819.6064-5-arne@...1227...>
In-Reply-To: <20190114154819.6064-1-arne@...1227...>
References: <20190114154819.6064-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 5/6] Implement a permanent session id in
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
---
 doc/openvpn.8            |  10 +++-
 src/openvpn/auth_token.c | 105 ++++++++++++++++++++++++++++++++-------
 src/openvpn/auth_token.h |  17 ++++++-
 src/openvpn/init.c       |   1 +
 src/openvpn/manage.c     |   4 +-
 src/openvpn/options.c    |  14 +++++-
 src/openvpn/options.h    |   3 +-
 src/openvpn/ssl_common.h |   1 +
 src/openvpn/ssl_verify.c |  78 ++++++++++++++++++-----------
 9 files changed, 180 insertions(+), 53 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7abcaf1e..671c0a01 100644
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
@@ -3730,6 +3730,14 @@ This feature is useful for environments which is configured
 to use One Time Passwords (OTP) as part of the user/password
 authentications and that authentication mechanism does not
 implement any auth\-token support.
+
+When the auth keyword is present the normal authentication
+method will be called even if auth-token succeeds. This allows
+the normal to still check the validity of the account and do other
+checks. The normal auth method can infer that the auth-token has been
+successful from the password starting with SESS_ID_
+(invalid auth-token fail early and the  normal authentication will not
+be called) and the presence of a 'session_id' environment variable.
 .\"*********************************************************
 .TP
 .B \-\-opt\-verify
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 5ba31042..03e661e6 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -17,6 +17,11 @@
 
 const char *auth_token_pem_name = "OpenVPN auth-token server key";
 
+#define AUTH_TOKEN_SESSION_ID_LEN 12
+#if AUTH_TOKEN_SESSION_ID_LEN % 3
+#error AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3
+#endif
+
 static struct key_type
 auth_token_kt(void)
 {
@@ -37,7 +42,47 @@ auth_token_kt(void)
 }
 
 
-void auth_token_write_server_key_file(const char *filename)
+
+void
+add_session_token_env(struct tls_session *session, struct tls_multi *multi,
+                      const struct user_pass *up)
+{
+    if (!multi->opt.auth_token_generate)
+    {
+        return;
+    }
+
+    /* If reach reach this point with a SESS_ID prefixed password
+     * we passed auth-token checks */
+    if (memcmp_constant_time(SESSION_ID_PREFIX, up->password,
+                             strlen(SESSION_ID_PREFIX))==0)
+    {
+        setenv_str(session->opt->es, "session_state", "Authenticated");
+        ASSERT(multi->auth_token);
+    }
+    else
+    {
+        setenv_str(session->opt->es, "session_state", "Initial");
+        /* Generate initial token to have it for the management interface */
+        if (!multi->auth_token)
+        {
+            generate_auth_token(up, multi);
+        }
+    }
+    /*
+     * In the auth-token the auth token is already base64 encoded
+     * and being a multiple of 4 ensure that it a multiple of bytes
+     * in the encoding
+     */
+    char session_id[AUTH_TOKEN_SESSION_ID_LEN*2] = {0};
+    memcpy(session_id, multi->auth_token + sizeof(SESSION_ID_PREFIX),
+           AUTH_TOKEN_SESSION_ID_LEN*8/6);
+
+    setenv_str(session->opt->es, "session_id", session_id);
+}
+
+void
+auth_token_write_server_key_file(const char *filename)
 {
     write_pem_key_file(filename, auth_token_pem_name);
 }
@@ -123,7 +168,7 @@ auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
 }
 
 void
-generate_auth_token(struct user_pass *up, struct tls_multi *multi)
+generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
 {
 
     struct gc_arena gc = gc_new();
@@ -134,6 +179,8 @@ generate_auth_token(struct user_pass *up, struct tls_multi *multi)
     hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
     ASSERT(hmac_ctx_size(ctx) == 256/8);
 
+    uint8_t sessid[AUTH_TOKEN_SESSION_ID_LEN];
+
     if (multi->auth_token)
     {
         /* Just enough space to fit 8 bytes+ 1 extra to decode a non padded
@@ -146,36 +193,54 @@ generate_auth_token(struct user_pass *up, struct tls_multi *multi)
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
     hmac_ctx_update(ctx, (uint8_t *) up->username, (int)strlen(up->username));
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
 
-    char* b64output;
+    char *b64output;
     openvpn_base64_encode(BPTR(&token), BLEN(&token), &b64output);
 
     struct buffer session_token = alloc_buf_gc(
-        strlen(SESSION_ID_PREFIX) + strlen (b64output) + 1, &gc);
+        strlen(SESSION_ID_PREFIX) + strlen(b64output) + 1, &gc);
 
     ASSERT(buf_write(&session_token, SESSION_ID_PREFIX, strlen(SESSION_ID_PREFIX)));
     ASSERT(buf_write(&session_token, b64output, (int)strlen(b64output)));
@@ -185,8 +250,8 @@ generate_auth_token(struct user_pass *up, struct tls_multi *multi)
 
     multi->auth_token = strdup((char *)BPTR(&session_token));
 
-    dmsg(D_SHOW_KEYS, "Generated token for client: %s",
-         multi->auth_token);
+    dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)",
+         multi->auth_token, up->username);
 
     gc_free(&gc);
 }
@@ -199,13 +264,14 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
      * Base64 is <= input and input is < USER_PASS_LEN, so using USER_PASS_LEN
      * is safe here but a bit overkill
      */
-    char b64decoded[USER_PASS_LEN];
+    uint8_t b64decoded[USER_PASS_LEN];
     int decoded_len = openvpn_base64_decode(up->password + strlen(SESSION_ID_PREFIX),
-                                    b64decoded, USER_PASS_LEN);
+                                            b64decoded, USER_PASS_LEN);
 
     /* Ensure that the decoded data is at least the size of the
      * timestamp + hmac */
-    int expected_len = 2 * sizeof(int64_t) + 32;
+
+    int expected_len = 2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + 32;
 
     if (decoded_len != expected_len)
     {
@@ -216,14 +282,15 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
     hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
     ASSERT(hmac_ctx_size(ctx) == 256/8);
 
-    hmac_ctx_reset(ctx);
-    hmac_ctx_update(ctx, (uint8_t *) up->username, strlen(up->username));
-    hmac_ctx_update(ctx, (uint8_t *) b64decoded, sizeof(int64_t));
-
     uint8_t hmac_output[256/8];
+
+    hmac_ctx_reset(ctx);
+    hmac_ctx_update(ctx, (uint8_t *) up->username, (int)strlen(up->username));
+    hmac_ctx_update(ctx, b64decoded, expected_len - 256/8);
     hmac_ctx_final(ctx, hmac_output);
 
-    const uint8_t *tstamp_initial = b64decoded;
+    const uint8_t *sessid = b64decoded;
+    const uint8_t *tstamp_initial = sessid + AUTH_TOKEN_SESSION_ID_LEN;
     const uint8_t *tstamp = tstamp_initial + sizeof(int64_t);
     const uint8_t *hmac = tstamp + sizeof(int64_t);
 
@@ -234,7 +301,8 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
 
     if (validhmac != 0)
     {
-        msg(M_WARN, "--auth-token-gen: HMAC on token from client failed");
+        msg(M_WARN, "--auth-token-gen: HMAC on token from client failed (%s), %s",
+            up->password, up->username);
         return false;
     }
 
@@ -285,7 +353,7 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
         /* If we accepted a token without prior session, i.e.
          * initial auth via token on new connection, we need
          * to store the auth-token in multi->auth_token, so
-         * the initial timestamp can be extracted from it
+         * the initial timestamp and session id can be extracted from it
          */
         if (!multi->auth_token)
         {
@@ -293,6 +361,7 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
         }
 
         generate_auth_token(up, multi);
+
         /* Auth token already sent to client, update auth-token */
         if (multi->auth_token_initial)
         {
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 0a75ea22..9f6a84ef 100644
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
@@ -44,13 +45,17 @@
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
  * we prepend the session id with SESS_ID_ before sending it to the client
  */
 void
-generate_auth_token(struct user_pass *up, struct tls_multi *multi);
+generate_auth_token(const struct user_pass *up, struct tls_multi *multi);
 
 /**
  * Verifies the auth token to be in the format that generate_auth_token
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
index 983b49e4..1bcd239c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2866,6 +2866,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
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
index 87632551..5f7263ac 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6768,11 +6768,23 @@ add_option(struct options *options,
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
+            if (streq(p[2], "auth"))
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
index 0e0217a1..79d5af14 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -460,7 +460,8 @@ struct options
     bool auth_user_pass_verify_script_via_file;
     bool auth_token_generate;
     bool auth_token_gen_secret_file;
-    unsigned int auth_token_lifetime;
+    bool auth_token_call_auth;
+    int auth_token_lifetime;
     const char *auth_token_secret_file;
     const char *auth_token_secret_file_inline;
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 0e18bf2f..2e4ee20c 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -310,6 +310,7 @@ struct tls_options
     bool auth_token_generate;   /**< Generate auth-tokens on successful
                                  * user/pass auth,seet via
                                  * options->auth_token_generate. */
+    bool auth_token_call_auth; /**< always call normal authentication */
     unsigned int auth_token_lifetime;
 
     struct key_ctx auth_token_key;
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index ac6ade4e..0a7147c8 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1051,7 +1051,8 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
  * Verify the user name and password using a script
  */
 static bool
-verify_user_pass_script(struct tls_session *session, const struct user_pass *up)
+verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
+                        const struct user_pass *up)
 {
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
@@ -1100,6 +1101,9 @@ verify_user_pass_script(struct tls_session *session, const struct user_pass *up)
         /* setenv client real IP address */
         setenv_untrusted(session);
 
+        /* add auth-token environment */
+        add_session_token_env(session, multi, up);
+
         /* format command line */
         argv_parse_cmd(&argv, session->opt->auth_user_pass_verify_script);
         argv_printf_cat(&argv, "%s", tmp_file);
@@ -1133,7 +1137,8 @@ done:
  * Verify the username and password using a plugin
  */
 static int
-verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up)
+verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
+                        const struct user_pass *up)
 {
     int retval = OPENVPN_PLUGIN_FUNC_ERROR;
 #ifdef PLUGIN_DEF_AUTH
@@ -1153,6 +1158,8 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up)
         /* setenv client real IP address */
         setenv_untrusted(session);
 
+        /* add auth-token environment */
+        add_session_token_env(session, multi, up);
 #ifdef PLUGIN_DEF_AUTH
         /* generate filename for deferred auth control file */
         if (!key_state_gen_auth_control_file(ks, session->opt))
@@ -1196,7 +1203,9 @@ cleanup:
 #define KMDA_DEF     3
 
 static int
-verify_user_pass_management(struct tls_session *session, const struct user_pass *up)
+verify_user_pass_management(struct tls_session *session,
+                            struct tls_multi* multi,
+                            const struct user_pass *up)
 {
     int retval = KMDA_ERROR;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
@@ -1214,6 +1223,11 @@ verify_user_pass_management(struct tls_session *session, const struct user_pass
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
@@ -1257,7 +1271,14 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     string_mod_remap_name(up->username);
     string_mod(up->password, CC_PRINT, CC_CRLF, '_');
 
-    /* If server is configured with --auth-gen-token and the client sends
+    /*
+     * If auth token succeeds we skip the auth
+     * methods unless otherwise specified
+     */
+    bool skip_auth = false;
+
+    /*
+     * If server is configured with --auth-gen-token and the client sends
      * something that looks like an authentication token, this
      * round will be done internally using the token instead of
      * calling any external authentication modules.
@@ -1266,8 +1287,6 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         memcmp_constant_time(SESSION_ID_PREFIX, up->password,
                              strlen(SESSION_ID_PREFIX))==0)
     {
-        unsigned int ssl_flags = session->opt->ssl_flags;
-
         /* Ensure that the username has not changed */
         if (!tls_lock_username(multi, up->username))
         {
@@ -1286,40 +1305,41 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         }
         else
         {
-            ks->authenticated = true;
-
-            if (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
-            {
-                set_common_name(session, up->username);
-            }
             msg(M_WARN, "TLS: Username/auth-token authentication "
-                "succeeded for username '%s' %s",
-                up->username,
-                (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
+                        "succeeded for username '%s'",
+                up->username);
+            if (!session->opt->auth_token_call_auth)
+              skip_auth = true;
         }
-        return;
     }
 
     /* call plugin(s) and/or script */
-#ifdef MANAGEMENT_DEF_AUTH
-    if (man_def_auth == KMDA_DEF)
+    if (!skip_auth)
     {
-        man_def_auth = verify_user_pass_management(session, up);
-    }
+#ifdef MANAGEMENT_DEF_AUTH
+        if (man_def_auth==KMDA_DEF)
+        {
+            man_def_auth = verify_user_pass_management(session, multi, up);
+        }
 #endif
-    if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
-    {
-        s1 = verify_user_pass_plugin(session, up);
-    }
-    if (session->opt->auth_user_pass_verify_script)
-    {
-        s2 = verify_user_pass_script(session, up);
+        if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
+        {
+            s1 = verify_user_pass_plugin(session, multi, up);
+        }
+
+        if (session->opt->auth_user_pass_verify_script)
+        {
+            s2 = verify_user_pass_script(session, multi, up);
+        }
     }
 
     /* check sizing of username if it will become our common name */
-    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && strlen(up->username) > TLS_USERNAME_LEN)
+    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) &&
+         strlen(up->username)>TLS_USERNAME_LEN)
     {
-        msg(D_TLS_ERRORS, "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters", TLS_USERNAME_LEN);
+        msg(D_TLS_ERRORS,
+                "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters",
+                TLS_USERNAME_LEN);
         s1 = OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
-- 
2.19.2


