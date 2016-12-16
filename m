From: David Sommerseth <davids@...515...>
Date: Fri, 16 Dec 2016 11:25:07 +0100
Message-Id: <1481883907-26413-1-git-send-email-davids@...515...>
In-Reply-To: <1481728374-7196-1-git-send-email-davids@...515...>
References: <1481728374-7196-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v4] auth-gen-token: Hardening memory cleanup
	on auth-token failuers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Further improve the memory management when a clients --auth-token
fails the server side token authentication enabled via --auth-gen-token.

v2 - Add ASSERT() if base64 encoding of token fails
v3 - Use proper boolean logic in ASSERT()
v4 - Rebase against The Great Reformatting

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/ssl_verify.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 54a3416..e901202 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1213,6 +1213,21 @@ verify_user_pass_management(struct tls_session *session, const struct user_pass
 }
 #endif /* ifdef MANAGEMENT_DEF_AUTH */
 
+/**
+ *  Wipes the authentication token out of the memory, frees and cleans up related buffers and flags
+ *
+ *  @param multi  Pointer to a multi object holding the auth_token variables
+ */
+static void
+wipe_auth_token(struct tls_multi *multi)
+{
+    secure_memzero(multi->auth_token, AUTH_TOKEN_SIZE);
+    free(multi->auth_token);
+    multi->auth_token = NULL;
+    multi->auth_token_sent = false;
+}
+
+
 /*
  * Main username/password verification entry point
  */
@@ -1264,6 +1279,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         /* Ensure that the username has not changed */
         if (!tls_lock_username(multi, up->username))
         {
+            wipe_auth_token(multi);
             ks->authenticated = false;
             goto done;
         }
@@ -1275,6 +1291,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
             && (multi->auth_token_tstamp + session->opt->auth_token_lifetime) < now)
         {
             msg(D_HANDSHAKE, "Auth-token for client expired\n");
+            wipe_auth_token(multi);
             ks->authenticated = false;
             goto done;
         }
@@ -1283,10 +1300,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         if (memcmp_constant_time(multi->auth_token, up->password,
                                  strlen(multi->auth_token)) != 0)
         {
-            secure_memzero(multi->auth_token, AUTH_TOKEN_SIZE);
-            free(multi->auth_token);
-            multi->auth_token = NULL;
-            multi->auth_token_sent = false;
+            wipe_auth_token(multi);
             ks->authenticated = false;
             tls_deauthenticate(multi);
 
@@ -1374,30 +1388,18 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
             /* The token should be longer than the input when
              * being base64 encoded
              */
-            if (openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
-                                      &multi->auth_token) < AUTH_TOKEN_SIZE)
-            {
-                msg(D_TLS_ERRORS, "BASE64 encoding of token failed. "
-                    "No auth-token will be activated now");
-                if (multi->auth_token)
-                {
-                    secure_memzero(multi->auth_token, AUTH_TOKEN_SIZE);
-                    free(multi->auth_token);
-                    multi->auth_token = NULL;
-                }
-            }
-            else
-            {
-                multi->auth_token_tstamp = now;
-                dmsg(D_SHOW_KEYS, "Generated token for client: %s",
-                     multi->auth_token);
-            }
+            ASSERT(openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
+                                         &multi->auth_token) > AUTH_TOKEN_SIZE);
+            multi->auth_token_tstamp = now;
+            dmsg(D_SHOW_KEYS, "Generated token for client: %s",
+                 multi->auth_token);
         }
 
         if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
         {
             set_common_name(session, up->username);
         }
+
 #ifdef ENABLE_DEF_AUTH
         msg(D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
             ks->auth_deferred ? "deferred" : "succeeded",
-- 
1.8.3.1


