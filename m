From: Arne Schwabe <arne@...1227...>
Date: Thu, 20 May 2021 17:11:41 +0200
Message-Id: <20210520151148.2565578-2-arne@...1227...>
In-Reply-To: <20210520151148.2565578-1-arne@...1227...>
References: <20210520151148.2565578-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/9] Implement auth-token-user
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

When not using username and password (i.e. auth-user-pass) it can still make
to provide the client with an auth-token, e.g. for allowing a session to
continue after a reconnect without requiring 2FA again.

However, without --auth-user-pass openvpn does not have a username and will
ignore any pushed auth-token command.

This patch adds support for auth-token-user to set the username that should
be used for auth-token

The spec of using auth-token-user base64-encoded-user are the ones that
OpenVPN3 already implements.

Patch V2: Improve style, fix comments and commit message

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/client-options.rst |  8 +++++++
 src/openvpn/misc.c                  | 37 +++++++++++++++++++++++++----
 src/openvpn/misc.h                  | 21 +++++++++++++---
 src/openvpn/options.c               |  5 ++++
 src/openvpn/ssl.c                   | 12 +++++++---
 src/openvpn/ssl.h                   |  2 ++
 6 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index af21fbcd7..c5b7ad960 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -50,6 +50,14 @@ configuration.
   after a failed auth. Older clients will keep using the token value and
   react according to ``--auth-retry``
 
+--auth-token-user base64username
+  Companion option to ``--auth-token``. This options allows to override
+  the username used by the client when reauthenticating with the ``auth-token``.
+  It also allows to use ``--auth-token`` in setups that normally do not use
+  username and password.
+
+  The username has to be base64 encoded.
+
 --auth-user-pass
   Authenticate with server using username/password.
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 650daa0c6..29061cd6f 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -490,22 +490,49 @@ void
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
+         * --auth-token has no username, so it needs the username
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
+    if (strlen(username))
+    {
+        /* Clear the username before decoding to ensure no old material is left
+         * and also allow decoding to not use all space to ensure the last byte is
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
index d9005353e..0d2d42489 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -56,6 +56,9 @@ const char *hostname_randomize(const char *hostname, struct gc_arena *gc);
 struct user_pass
 {
     bool defined;
+    /* For auth-token username and token can be set individually, so
+     * we this second bool to track if the token (password) is defined */
+    bool token_defined;
     bool nocache;
 
 /* max length of username/password */
@@ -138,19 +141,31 @@ void fail_user_pass(const char *prefix,
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
index 5a6f37d7d..fa3ee50d6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8308,6 +8308,11 @@ add_option(struct options *options,
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
index e843b2152..7eb356ddf 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -446,6 +446,12 @@ ssl_set_auth_token(const char *token)
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
@@ -2310,8 +2316,8 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
         }
     }
 
-    /* write username/password if specified */
-    if (auth_user_pass_enabled)
+    /* write username/password if specified or we are using a auth-token */
+    if (auth_user_pass_enabled || (auth_token.token_defined && auth_token.defined))
     {
 #ifdef ENABLE_MANAGEMENT
         auth_user_pass_setup(session->opt->auth_user_pass_file, session->opt->sci);
@@ -2324,7 +2330,7 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
          * If we have a valid auth-token, send that instead of real
          * username/password
          */
-        if (auth_token.defined)
+        if (auth_token.token_defined && auth_token.defined)
         {
             up = &auth_token;
         }
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 88f89876a..81cc22131 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -450,6 +450,8 @@ void ssl_purge_auth(const bool auth_user_pass_only);
 
 void ssl_set_auth_token(const char *token);
 
+void ssl_set_auth_token_user(const char *username);
+
 bool ssl_clean_auth_token(void);
 
 #ifdef ENABLE_MANAGEMENT
-- 
2.31.1


