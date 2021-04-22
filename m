From: Arne Schwabe <arne@...1227...>
Date: Thu, 22 Apr 2021 17:17:24 +0200
Message-Id: <20210422151724.2132573-7-arne@...1227...>
In-Reply-To: <20210422151724.2132573-1-arne@...1227...>
References: <20210422151724.2132573-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/7] Move auth_token_state_flags to
 tls_session and cleanup initial_token
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

The usage of the auth_token_state_flags is tied to the authentication.
The other authentication related flags and status are in the
tls_session struct instead of the tls_multi struct. Move
auth_token_state_flags to the right place.

This also changes that auth_token_initial is set when the token is
initially generated instead when pushing the token. Even I don't know
anymore why I did it in this way in the first place. Also use
multi->auth_token_initial as source for the sesssion ID since it should
now always be available.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/auth_token.c                   | 22 ++++++++++++++++++----
 src/openvpn/push.c                         |  8 --------
 src/openvpn/ssl_verify.c                   |  5 ++++-
 tests/unit_tests/openvpn/test_auth_token.c | 14 ++++++++++----
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 0ea6d1832..d0cdc5f7f 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -109,11 +109,11 @@ add_session_token_env(struct tls_session *session, struct tls_multi *multi,
         /*
          * No session before, generate a new session token for the new session
          */
-        if (!multi->auth_token)
+        if (!multi->auth_token_initial)
         {
             generate_auth_token(up, multi);
         }
-        session_id_source = multi->auth_token;
+        session_id_source = multi->auth_token_initial;
     }
     /*
      * In the auth-token the auth token is already base64 encoded
@@ -184,7 +184,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
 
     uint8_t sessid[AUTH_TOKEN_SESSION_ID_LEN];
 
-    if (multi->auth_token)
+    if (multi->auth_token_initial)
     {
         /* Just enough space to fit 8 bytes+ 1 extra to decode a non padded
          * base64 string (multiple of 3 bytes). 9 bytes => 12 bytes base64
@@ -192,13 +192,18 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
          */
         char old_tstamp_decode[9];
 
+        /* Make a copy of the string to not modify multi->auth_token_initial */
+        char* initial_token_copy = string_alloc(multi->auth_token_initial, &gc);
+
         /*
          * reuse the same session id and timestamp and null terminate it at
          * for base64 decode it only decodes the session id part of it
          */
-        char *old_sessid = multi->auth_token + strlen(SESSION_ID_PREFIX);
+        char *old_sessid =initial_token_copy + strlen(SESSION_ID_PREFIX);
         char *old_tsamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;
 
+
+
         old_tsamp_initial[12] = '\0';
         ASSERT(openvpn_base64_decode(old_tsamp_initial, old_tstamp_decode, 9) == 9);
 
@@ -277,6 +282,15 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
     dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)",
          multi->auth_token, up->username);
 
+    if (!multi->auth_token_initial)
+    {
+        /*
+         * Save the initial auth token for clients that ignore
+         * the updates to the token
+         */
+        multi->auth_token_initial = strdup(multi->auth_token);
+    }
+
     gc_free(&gc);
 }
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 428efb68e..c42b5f2e6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -523,14 +523,6 @@ prepare_auth_token_push_reply(struct tls_multi *tls_multi, struct gc_arena *gc,
         push_option_fmt(gc, push_list, M_USAGE,
                         "auth-token %s",
                         tls_multi->auth_token);
-        if (!tls_multi->auth_token_initial)
-        {
-            /*
-             * Save the initial auth token for clients that ignore
-             * the updates to the token
-             */
-            tls_multi->auth_token_initial = strdup(tls_multi->auth_token);
-        }
     }
 }
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 912012eb7..ff983551f 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1544,6 +1544,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
      */
     if (session->opt->auth_token_generate && is_auth_token(up->password))
     {
+
         ks->auth_token_state_flags = verify_auth_token(up, multi, session);
         if (session->opt->auth_token_call_auth)
         {
@@ -1672,7 +1673,9 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
          * Otherwise the auth-token get pushed out as part of the "normal"
          * push-reply
          */
-        if (multi->auth_token_initial)
+        bool initial_connect = session->key[KS_PRIMARY].key_id == 0;
+
+        if (multi->auth_token_initial && !initial_connect)
         {
             /*
              * We do not explicitly schedule the sending of the
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 69fc1f8c9..922bd9b13 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -174,7 +174,9 @@ auth_token_test_timeout(void **state)
 
     now = 100000;
     generate_auth_token(&ctx->up, &ctx->multi);
+
     strcpy(ctx->up.password, ctx->multi.auth_token);
+    ctx->multi.auth_token_initial = NULL;
 
     /* No time has passed */
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
@@ -244,10 +246,10 @@ auth_token_test_known_keys(void **state)
 
     now = 0;
     /* Preload the session id so the same session id is used here */
-    ctx->multi.auth_token = strdup(now0key0);
+    ctx->multi.auth_token_initial = strdup(now0key0);
 
     /* Zero the hmac part to ensure we have a newly generated token */
-    zerohmac(ctx->multi.auth_token);
+    zerohmac(ctx->multi.auth_token_initial);
 
     generate_auth_token(&ctx->up, &ctx->multi);
 
@@ -305,13 +307,16 @@ auth_token_test_env(void **state)
 {
     struct test_context *ctx = (struct test_context *) *state;
 
+
     struct key_state *ks = &ctx->multi.session[TM_ACTIVE].key[KS_PRIMARY];
     
     ks->auth_token_state_flags = 0;
+
     ctx->multi.auth_token = NULL;
     add_session_token_env(ctx->session, &ctx->multi, &ctx->up);
     assert_string_equal(lastsesion_statevalue, "Initial");
 
+
     ks->auth_token_state_flags = 0;
     strcpy(ctx->up.password, now0key0);
     add_session_token_env(ctx->session, &ctx->multi, &ctx->up);
@@ -331,6 +336,7 @@ auth_token_test_env(void **state)
 
     ks->auth_token_state_flags = AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED|AUTH_TOKEN_VALID_EMPTYUSER;
     add_session_token_env(ctx->session, &ctx->multi, &ctx->up);
+
     assert_string_equal(lastsesion_statevalue, "ExpiredEmptyUser");
 }
 
@@ -341,13 +347,13 @@ auth_token_test_random_keys(void **state)
 
     now = 0x5c331e9c;
     /* Preload the session id so the same session id is used here */
-    ctx->multi.auth_token = strdup(random_token);
+    ctx->multi.auth_token_initial = strdup(random_token);
 
     free_key_ctx(&ctx->multi.opt.auth_token_key);
     auth_token_init_secret(&ctx->multi.opt.auth_token_key, random_key, true);
 
     /* Zero the hmac part to ensure we have a newly generated token */
-    zerohmac(ctx->multi.auth_token);
+    zerohmac(ctx->multi.auth_token_initial);
 
     generate_auth_token(&ctx->up, &ctx->multi);
 
-- 
2.31.1


