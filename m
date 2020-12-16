From: Arne Schwabe <arne@...1227...>
Date: Wed, 16 Dec 2020 16:33:17 +0100
Message-Id: <20201216153317.20718-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Implement auth-token-user
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

Even for non username/password session using a auth token can make,
e.g. for allowing a session to continue after a reconnect. Since
without username openvpn does not have a username it will just ignore
pushed auth-token command. This adds support for auth-token-user to
set the username.

The spec of using auth-token-user base64-encoded-user are the ones that
OpenVPN3 already implements.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/client-options.rst |  6 +++++
 src/openvpn/misc.c                  | 37 +++++++++++++++++++++++++----
 src/openvpn/misc.h                  | 21 +++++++++++++---
 src/openvpn/options.c               |  5 ++++
 src/openvpn/ssl.c                   | 12 +++++++---
 src/openvpn/ssl.h                   |  2 ++
 6 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index af21fbcd..63f82090 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -50,6 +50,12 @@ configuration.
   after a failed auth. Older clients will keep using the token value and
   react according to ``--auth-retry``
 
+--auth-token-user base64username
+  Companion option to ``--auth-token``. This options allows to override
+  the username used by the client when reauthenticating with the ``auth-token``.
+  It also allows to use ``--auth-token`` in setups that normally do not use
+  username and password.
+
 --auth-user-pass
   Authenticate with server using username/password.
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index c0c72dd7..531f685c 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -510,22 +510,49 @@ void
 set_auth_token(struct user_pass *up, struct user_pass *tk, const char *token)
 {
 
-    if (strlen(token) && (up->defined || tk->defined))
+    if (strlen(token))
     {
-        /* auth-token has no password, so it needs the username
-         * either already set or copied from up */
         strncpynt(tk->password, token, USER_PASS_LEN);
-        if (up->defined)
+        tk->token_defined = true;
+
+        /*
+         * auth-token has no password, so it needs the username
+         * either already set or copied from up, or later set by
+         * --auth-token-user
+         *
+         * Do not overwrite the username if already set to avoid
+         * overwriting an auth-token
+         */
+        if (up->defined && !tk->defined)
         {
             strncpynt(tk->username, up->username, USER_PASS_LEN);
+            tk->defined = true;
         }
-        tk->defined = true;
     }
 
     /* Cleans user/pass for nocache */
     purge_user_pass(up, false);
 }
 
+void
+set_auth_token_user(struct user_pass *tk, const char *username)
+{
+    if  (strlen(username))
+    {
+        /* Clear the username before decoding to ensure no old material is left
+         * and also allow decoding to not use all sapce to ensure the last byte is
+         * always 0 */
+        CLEAR(tk->username);
+        int len = openvpn_base64_decode(username, tk->username, USER_PASS_LEN - 1);
+        tk->defined = len > 0;
+        if (!tk->defined)
+        {
+            msg(D_PUSH, "Error decoding auth-token-username");
+        }
+    }
+}
+
+
 /*
  * Process string received by untrusted peer before
  * printing to console or log file.
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index e4342b0d..5e7f230b 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -63,6 +63,9 @@ const char *hostname_randomize(const char *hostname, struct gc_arena *gc);
 struct user_pass
 {
     bool defined;
+    /* For auth-token username and token can be set indiviually, so
+     * we this second bool to track if the token (password) is defined */
+    bool token_defined;
     bool nocache;
 
 /* max length of username/password */
@@ -145,19 +148,31 @@ void fail_user_pass(const char *prefix,
 void purge_user_pass(struct user_pass *up, const bool force);
 
 /**
- * Sets the auth-token to token if a username is available from either
- * up or already present in tk. The method will also purge up if
+ * Sets the auth-token to token. Ff a username is available from either
+ * up or already present in tk is the auth-token that will be used as default
+ * username for the token. The method will also purge up if
  * the auth-nocache option is active.
  *
  * @param up        (non Auth-token) Username/password
  * @param tk        auth-token userpass to set
- * @param token     token to use as password for the
+ * @param token     token to use as password for the auth-token
  *
  * @note    all parameters to this function must not be null.
  */
 void set_auth_token(struct user_pass *up, struct user_pass *tk,
                     const char *token);
 
+/**
+ * Sets the auth-token username by base64 decoding the passed
+ * username
+ *
+ * @param tk        auth-token userpass to set
+ * @param username  base64 encoded username to set
+ *
+ * @note    all parameters to this function must not be null.
+ */
+void set_auth_token_user(struct user_pass *tk, const char *username);
+
 /*
  * Process string received by untrusted peer before
  * printing to console or log file.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ff3954d5..f9276e9a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8272,6 +8272,11 @@ add_option(struct options *options,
         }
 #endif
     }
+    else if (streq(p[0], "auth-token-user") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_ECHO);
+        ssl_set_auth_token_user(p[1]);
+    }
     else if (streq(p[0], "single-session") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index efbf688f..08ddc76e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -445,6 +445,12 @@ ssl_set_auth_token(const char *token)
     set_auth_token(&auth_user_pass, &auth_token, token);
 }
 
+void
+ssl_set_auth_token_user(const char *username)
+{
+    set_auth_token_user(&auth_token, username);
+}
+
 /*
  * Cleans an auth token and checks if it was active
  */
@@ -2383,8 +2389,8 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
         }
     }
 
-    /* write username/password if specified */
-    if (auth_user_pass_enabled)
+    /* write username/password if specified or we are using a auth-token*/
+    if (auth_user_pass_enabled || (auth_token.token_defined && auth_token.defined))
     {
 #ifdef ENABLE_MANAGEMENT
         auth_user_pass_setup(session->opt->auth_user_pass_file, session->opt->sci);
@@ -2397,7 +2403,7 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
          * If we have a valid auth-token, send that instead of real
          * username/password
          */
-        if (auth_token.defined)
+        if (auth_token.token_defined && auth_token.defined)
         {
             up = &auth_token;
         }
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 56034540..5a77e701 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -440,6 +440,8 @@ void ssl_purge_auth(const bool auth_user_pass_only);
 
 void ssl_set_auth_token(const char *token);
 
+void ssl_set_auth_token_user(const char *username);
+
 bool ssl_clean_auth_token(void);
 
 #ifdef ENABLE_MANAGEMENT
-- 
2.26.2


