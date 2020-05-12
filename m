From: Arne Schwabe <arne@...1227...>
Date: Tue, 12 May 2020 14:43:44 +0200
Message-Id: <20200512124344.15929-1-arne@...1227...>
In-Reply-To: <20200326172332.2356-1-arne@...1227...>
References: <20200326172332.2356-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 1/3] [Auth-token] Fix session id and
 initial timestamp not begin preserved
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

In the initial state of checking whether an auth-token has been
validated, the check check if multi->auth_token is already set and
only then sets the value. This defeats the purpose and lead to always
a new auth-token with new session id and lifetime being generated when
the server restarts or the client reconnect to another server.

Patch V2: Only set multi->auth_token when NULL to avoid leaking
          memory. Improve comments and documentation of auth-token.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/auth_token.h | 17 +++++++++++------
 src/openvpn/ssl_verify.c |  9 ++++++---
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 6f34b760..d5694898 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -34,8 +34,8 @@
  *
  * Format of the auth-token (before base64 encode)
  *
- * session id(12 bytes)|uint64 timestamp (4 bytes)|
- * uint64 timestamp (4 bytes)|sha256-hmac(32 bytes)
+ * session id(12 bytes)|uint64 timestamp (8 bytes)|
+ * uint64 timestamp (8 bytes)|sha256-hmac(32 bytes)
  *
  * The first timestamp is the time the token was initially created and is used to
  * determine the maximum renewable time of the token. We always include this even
@@ -45,14 +45,19 @@
  * to determine if this token has been renewed in the acceptable time range
  * (2 * renogiation timeout)
  *
- * The session is a random string of 12 byte (or 16 in base64) that is not used by
- * OpenVPN itself but kept intact so that external logging/managment can track the
- * session multiple reconnects/servers
+ * The session id is a random string of 12 byte (or 16 in base64) that is not
+ * used by OpenVPN itself but kept intact so that external logging/managment
+ * can track the session multiple reconnects/servers. It is delibrately chosen
+ * be a multiple of 3 bytes to have a base64 encoding without padding.
  *
  * The hmac is calculated over the username contactinated with the
  * raw auth-token bytes to include authentication of the username in the token
  *
- * we prepend the session id with SESS_ID_ before sending it to the client
+ * We encode the auth-token with base64 and then it with SESS_ID_ before
+ * sending it to the client.
+ *
+ * This function will free() an existing multi->auth_token and keep the existing
+ * initial timestamp and session id contained in that token.
  */
 void
 generate_auth_token(const struct user_pass *up, struct tls_multi *multi);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e66d81e1..ddaef6d7 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1380,15 +1380,15 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
              * to store the auth-token in multi->auth_token, so
              * the initial timestamp and session id can be extracted from it
              */
-            if (multi->auth_token && (multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
+            if (!multi->auth_token && (multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
                 && !(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
             {
                 multi->auth_token = strdup(up->password);
             }
 
             /*
-             * Server is configured with --auth-gen-token but no token has yet
-             * been generated for this client.  Generate one and save it.
+             * Server is configured with --auth-gen-token. Generate or renew
+             * the token.
              */
             generate_auth_token(up, multi);
         }
@@ -1396,6 +1396,9 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
          * Auth token already sent to client, update auth-token on client.
          * The initial auth-token is sent as part of the push message, for this
          * update we need to schedule an extra push message.
+         *
+         * Otherwise the auth-token get pushed out as part of the "normal"
+         * push-reply
          */
         if (multi->auth_token_initial)
         {
-- 
2.26.0


