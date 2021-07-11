From: Arne Schwabe <arne@...1227...>
Date: Sun, 11 Jul 2021 16:10:11 +0200
Message-Id: <20210711141011.3272289-1-arne@...1227...>
In-Reply-To: <20210520151148.2565578-7-arne@...1227...>
References: <20210520151148.2565578-7-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Cleanup handling of initial auth token
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

This changes that auth_token_initial is set when the token is
initially generated instead when pushing the token. Even I do not know
anymore why I did it in this way in the first place. Also use
multi->auth_token_initial as source for the sesssion ID since it should
now always be available.

Since the change makes auth_token_initial always available we need to add
a check to only send a PUSH reply to update the token on renegotiations.
The old code relied on multi->auth_token not being set in this case.

This commit also removes the workaround for old OpenVPN clients. These
were only available as commercial OpenVPN Connect client and not in use
anymore.

Patch V2: rebase.
Patch V3: fix formatting, clarifying commit message, remove initial
          token workaround for old v3.
Patch v4: move sending the auth-token for renegotiations to a sane place
          and trigger it when the TLS session reaches its fully authenticated
          state.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/server-options.rst        |  4 +-
 src/openvpn/auth_token.c                   | 58 ++++++++++++++++------
 src/openvpn/auth_token.h                   |  9 ++++
 src/openvpn/push.c                         |  8 ---
 src/openvpn/ssl.c                          |  7 ++-
 src/openvpn/ssl_common.h                   |  8 +--
 src/openvpn/ssl_verify.c                   | 22 +-------
 tests/unit_tests/openvpn/test_auth_token.c |  7 ++-
 8 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 047f2270f..1ab00e81b 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -35,7 +35,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   token is reached or after not being renewed for more than 2 \*
   ``reneg-sec`` seconds. Clients will be sent renewed tokens on every TLS
   renogiation to keep the client's token updated. This is done to
-  invalidate a token if a client is disconnected for a sufficently long
+  invalidate a token if a client is disconnected for a sufficiently long
   time, while at the same time permitting much longer token lifetimes for
   active clients.
 
@@ -46,7 +46,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   When the :code:`external-auth` keyword is present the normal
   authentication method will always be called even if auth-token succeeds.
   Normally other authentications method are skipped if auth-token
-  verification suceeds or fails.
+  verification succeeds or fails.
 
   This option postpones this decision to the external authentication
   methods and checks the validity of the account and do other checks.
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 0ea6d1832..aa949ff09 100644
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
@@ -192,11 +192,14 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
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
+        char *old_sessid = initial_token_copy + strlen(SESSION_ID_PREFIX);
         char *old_tsamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;
 
         old_tsamp_initial[12] = '\0';
@@ -212,10 +215,6 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
 
         old_tsamp_initial[0] = '\0';
         ASSERT(openvpn_base64_decode(old_sessid, sessid, AUTH_TOKEN_SESSION_ID_LEN)==AUTH_TOKEN_SESSION_ID_LEN);
-
-
-        /* free the auth-token, we will replace it with a new one */
-        free(multi->auth_token);
     }
     else if (!rand_bytes(sessid, AUTH_TOKEN_SESSION_ID_LEN))
     {
@@ -272,11 +271,22 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
 
     free(b64output);
 
+    /* free the auth-token if defined, we will replace it with a new one */
+    free(multi->auth_token);
     multi->auth_token = strdup((char *)BPTR(&session_token));
 
     dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)",
          multi->auth_token, up->username);
 
+    if (!multi->auth_token_initial)
+    {
+        /*
+         * Save the initial auth token to continue using the same session ID
+         * and timestamp in updates
+         */
+        multi->auth_token_initial = strdup(multi->auth_token);
+    }
+
     gc_free(&gc);
 }
 
@@ -353,13 +363,7 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
     bool in_renog_time = now >= timestamp
                          && now < timestamp + 2 * session->opt->renegotiate_seconds;
 
-    /* We could still have a client that does not update
-     * its auth-token, so also allow the initial auth-token */
-    bool initialtoken = multi->auth_token_initial
-                        && memcmp_constant_time(up->password, multi->auth_token_initial,
-                                                strlen(multi->auth_token_initial)) == 0;
-
-    if (!in_renog_time && !initialtoken)
+    if (!in_renog_time)
     {
         ret |= AUTH_TOKEN_EXPIRED;
     }
@@ -408,3 +412,27 @@ wipe_auth_token(struct tls_multi *multi)
         multi->auth_token_initial = NULL;
     }
 }
+
+void
+resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *session)
+{
+    /*
+     * Auth token already sent to client, update auth-token on client.
+     * The initial auth-token is sent as part of the push message, for this
+     * update we need to schedule an extra push message.
+     *
+     * Otherwise the auth-token get pushed out as part of the "normal"
+     * push-reply
+     */
+    bool is_renegotiation = session->key[KS_PRIMARY].key_id != 0;
+
+    if (multi->auth_token_initial && is_renegotiation)
+    {
+        /*
+         * We do not explicitly reschedule the sending of the
+         * control message here. This might delay this reply
+         * a few seconds until but this message is not time critical
+         */
+        send_push_reply_auth_token(multi);
+    }
+}
\ No newline at end of file
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 73a00ddd7..e9c33dc37 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -129,4 +129,13 @@ is_auth_token(const char *password)
     return (memcmp_constant_time(SESSION_ID_PREFIX, password,
                                  strlen(SESSION_ID_PREFIX)) == 0);
 }
+/**
+ * Checks if a client has should be send a new auth token to update its
+ * current auth-token
+ * @param multi     Pointer the multi object of the TLS session
+ * @param session   Pointer to the TLS session itself
+ */
+void
+resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *session);
+
 #endif /* AUTH_TOKEN_H */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index f4957f147..53cb7ca6f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -527,14 +527,6 @@ prepare_auth_token_push_reply(struct tls_multi *tls_multi, struct gc_arena *gc,
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
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 592b2b893..504efab72 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3115,13 +3115,18 @@ tls_multi_process(struct tls_multi *multi,
 
             if (ks->state == S_ACTIVE && ks->authenticated == KS_AUTH_TRUE)
             {
-                /* This will ks->state from S_ACTIVE to S_GENERATED_KEYS */
+                /* Session is now fully authenticated.
+                 * tls_session_generate_data_channel_keys will ks->state
+                 * from S_ACTIVE to S_GENERATED_KEYS */
                 if (!tls_session_generate_data_channel_keys(session))
                 {
                     msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
                     ks->authenticated = KS_AUTH_FALSE;
                     ks->state = S_ERROR;
                 }
+
+                /* Update auth token on the client if needed */
+                resend_auth_token_renegotiation(multi, session);
             }
         }
     }
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 43d6276be..5c261115c 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -96,7 +96,9 @@
                                  *   handshake window, deferred auth, client
                                  *   connect and can still
                                  *   be pending. */
-#define S_GENERATED_KEYS  7     /**< The data channel keys have been generated */
+#define S_GENERATED_KEYS  7     /**< The data channel keys have been generated.
+                                  *  The TLS session is fully authenticated
+                                  *  when reaching this state. */
 /* Note that earlier versions also had a S_OP_NORMAL state that was
  * virtually identical with S_ACTIVE and the code still assumes everything
  * >= S_ACTIVE to be fully operational */
@@ -597,8 +599,8 @@ struct tls_multi
                           *   user/pass authentications in this session.
                           */
     char *auth_token_initial;
-    /**< The first auth-token we sent to a client, for clients that do
-     * not update their auth-token (older OpenVPN3 core versions)
+    /**< The first auth-token we sent to a client. We use this to remember
+     * the session ID and initial timestamp when generating new auth-token.
      */
 #define  AUTH_TOKEN_HMAC_OK              (1<<0)
     /**< Auth-token sent from client has valid hmac */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index bbb1878a3..6cc49c876 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1631,27 +1631,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
              */
             generate_auth_token(up, multi);
         }
-        /*
-         * Auth token already sent to client, update auth-token on client.
-         * The initial auth-token is sent as part of the push message, for this
-         * update we need to schedule an extra push message.
-         *
-         * Otherwise the auth-token get pushed out as part of the "normal"
-         * push-reply
-         */
-        if (multi->auth_token_initial)
-        {
-            /*
-             * We do not explicitly schedule the sending of the
-             * control message here but control message are only
-             * postponed when the control channel  is not yet fully
-             * established and furthermore since this is called in
-             * the middle of authentication, there are other messages
-             * (new data channel keys) that are sent anyway and will
-             * trigger schedueling
-             */
-            send_push_reply_auth_token(multi);
-        }
+
         msg(D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
             (ks->authenticated == KS_AUTH_DEFERRED) ? "deferred" : "succeeded",
             up->username,
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 4030052e0..a504eed91 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -174,7 +174,10 @@ auth_token_test_timeout(void **state)
 
     now = 100000;
     generate_auth_token(&ctx->up, &ctx->multi);
+
     strcpy(ctx->up.password, ctx->multi.auth_token);
+    free(ctx->multi.auth_token_initial);
+    ctx->multi.auth_token_initial = NULL;
 
     /* No time has passed */
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
@@ -244,10 +247,10 @@ auth_token_test_known_keys(void **state)
 
     now = 0;
     /* Preload the session id so the same session id is used here */
-    ctx->multi.auth_token = strdup(now0key0);
+    ctx->multi.auth_token_initial = strdup(now0key0);
 
     /* Zero the hmac part to ensure we have a newly generated token */
-    zerohmac(ctx->multi.auth_token);
+    zerohmac(ctx->multi.auth_token_initial);
 
     generate_auth_token(&ctx->up, &ctx->multi);
 
-- 
2.32.0


