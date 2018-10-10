From: Arne Schwabe <arne@...1227...>
Date: Wed, 10 Oct 2018 16:30:51 +0200
Message-Id: <20181010143051.27163-1-arne@...1227...>
In-Reply-To: <1520262951-1807-1-git-send-email-arne@...1227...>
References: <1520262951-1807-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v5] Revert to original password
 authentication after failed auth-token
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

Auth-tokens can expire. For by reconnecting when the server uses
auth-gen-toke.

Behaviour of OpenVPN client is to never fallback to the previous
authentication method and continue using the auth-token. Depending on
auth-retry it either quit or tried endlessly with an expired
token. Since auth-gen-token tokens expire on reconnect, a client will
not survive a reconnect.

This patches changes the behaviour on failed auth when using an
auth-token as a soft error (USR1) and clean the auth-token falling
back to the original auth method.

Patch V2: properly formatted commit message, fix openvpn3 detection

Patch V3: remove all server changes, include only minimal non
intrusive client changes that only improve error recovery but don't
change overall behaviour.

Patch V4: forget add push.c to git index, now also included

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8      |  6 ++++++
 src/openvpn/misc.c | 16 ++++++++++------
 src/openvpn/misc.h |  4 ++--
 src/openvpn/push.c | 17 +++++++++++++++--
 src/openvpn/ssl.c  | 39 +++++++++++++++++++++++++--------------
 src/openvpn/ssl.h  |  2 ++
 6 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e94ab760..39fc4fdf 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5347,6 +5347,12 @@ into the file/buffer for dynamic configuration data.  This
 will then make the OpenVPN server to push this value to the
 client, which replaces the local password with the
 UNIQUE_TOKEN_VALUE.
+
+Newer clients (2.4.7+) will fall back to the original password method
+after a failed auth. Older clients will keep using the token value
+and react acording to
+.B \-\-auth-retry
+.
 .\"*********************************************************
 .TP
 .B \-\-tls\-verify cmd
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index d75b7685..75f4ff47 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -469,7 +469,7 @@ purge_user_pass(struct user_pass *up, const bool force)
      * don't show warning if the pass has been replaced by a token: this is an
      * artificial "auth-nocache"
      */
-    else if (!warn_shown && (!up->tokenized))
+    else if (!warn_shown)
     {
         msg(M_WARN, "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this");
         warn_shown = true;
@@ -477,14 +477,18 @@ purge_user_pass(struct user_pass *up, const bool force)
 }
 
 void
-set_auth_token(struct user_pass *up, const char *token)
+set_auth_token(struct user_pass *up, struct user_pass *tk, const char *token)
 {
-    if (token && strlen(token) && up && up->defined && !up->nocache)
+
+    if (token && strlen(token) && up && up->defined)
     {
-        CLEAR(up->password);
-        strncpynt(up->password, token, USER_PASS_LEN);
-        up->tokenized = true;
+        strncpynt(tk->password, token, USER_PASS_LEN);
+        strncpynt(tk->username, up->username, USER_PASS_LEN);
+        tk->defined = true;
     }
+
+    /* Cleans user/pass for nocache */
+    purge_user_pass(up, false);
 }
 
 /*
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index a54185f0..00de2b23 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -63,7 +63,6 @@ struct user_pass
 {
     bool defined;
     bool nocache;
-    bool tokenized; /* true if password has been substituted by a token */
     bool wait_for_push; /* true if this object is waiting for a push-reply */
 
 /* max length of username/password */
@@ -145,7 +144,8 @@ void fail_user_pass(const char *prefix,
 
 void purge_user_pass(struct user_pass *up, const bool force);
 
-void set_auth_token(struct user_pass *up, const char *token);
+void set_auth_token(struct user_pass *up, struct user_pass *tk,
+                    const char *token);
 
 /*
  * Process string received by untrusted peer before
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 72f09962..4798e26d 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -55,8 +55,20 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
 
     if (c->options.pull)
     {
-        switch (auth_retry_get())
+        /* Before checking how to react on AUTH_FAILED, first check if the 
+         * failed auth might be the result of an expired auth-token.
+         * Note that a server restart will trigger a generic AUTH_FAILED 
+         * instead an AUTH_FAILED,SESSION so handle all AUTH_FAILED message 
+         * identical for this scenario */
+        if (ssl_clean_auth_token())
         {
+            c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Auth failure error */
+            c->sig->signal_text = "auth-failure (auth-token)";
+        }
+        else
+        {
+            switch (auth_retry_get())
+            {
             case AR_NONE:
                 c->sig->signal_received = SIGTERM; /* SOFT-SIGTERM -- Auth failure error */
                 break;
@@ -70,8 +82,9 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
 
             default:
                 ASSERT(0);
+            }
+            c->sig->signal_text = "auth-failure";
         }
-        c->sig->signal_text = "auth-failure";
 #ifdef ENABLE_MANAGEMENT
         if (management)
         {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 58261e66..b52c2ab5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -398,6 +398,7 @@ pem_password_callback(char *buf, int size, int rwflag, void *u)
 
 static bool auth_user_pass_enabled;     /* GLOBAL */
 static struct user_pass auth_user_pass; /* GLOBAL */
+static struct user_pass auth_token;     /* GLOBAL */
 
 #ifdef ENABLE_MANAGEMENT
 static char *auth_challenge; /* GLOBAL */
@@ -407,7 +408,7 @@ void
 auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *sci)
 {
     auth_user_pass_enabled = true;
-    if (!auth_user_pass.defined)
+    if (!auth_user_pass.defined && !auth_token.defined)
     {
 #ifdef ENABLE_MANAGEMENT
         if (auth_challenge) /* dynamic challenge/response */
@@ -445,7 +446,7 @@ ssl_set_auth_nocache(void)
 {
     passbuf.nocache = true;
     auth_user_pass.nocache = true;
-    /* wait for push-reply, because auth-token may invert nocache */
+    /* wait for push-reply, because auth-token may still need the username */
     auth_user_pass.wait_for_push = true;
 }
 
@@ -455,15 +456,18 @@ ssl_set_auth_nocache(void)
 void
 ssl_set_auth_token(const char *token)
 {
-    if (auth_user_pass.nocache)
-    {
-        msg(M_INFO,
-            "auth-token received, disabling auth-nocache for the "
-            "authentication token");
-        auth_user_pass.nocache = false;
-    }
+    set_auth_token(&auth_user_pass, &auth_token, token);
+}
 
-    set_auth_token(&auth_user_pass, token);
+/*
+ * Cleans an auth token and checks if it was active
+ */
+bool
+ssl_clean_auth_token (void)
+{
+    bool wasdefined = auth_token.defined;
+    purge_user_pass(&auth_token, true);
+    return wasdefined;
 }
 
 /*
@@ -2369,19 +2373,26 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
 #else
         auth_user_pass_setup(session->opt->auth_user_pass_file, NULL);
 #endif
-        if (!write_string(buf, auth_user_pass.username, -1))
+        struct user_pass *up = &auth_user_pass;
+
+        /*
+         * If we have a valid auth-token, send that instead of real
+         * username/password
+         */
+        if (auth_token.defined)
+            up = &auth_token;
+
+        if (!write_string(buf, up->username, -1))
         {
             goto error;
         }
-        if (!write_string(buf, auth_user_pass.password, -1))
+        else if (!write_string(buf, up->password, -1))
         {
             goto error;
         }
         /* if auth-nocache was specified, the auth_user_pass object reaches
          * a "complete" state only after having received the push-reply
          * message.
-         * This is the case because auth-token statement in a push-reply would
-         * invert its nocache.
          *
          * For this reason, skip the purge operation here if no push-reply
          * message has been received yet.
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index a1bd9bf0..781adb94 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -437,6 +437,8 @@ void ssl_set_auth_token(const char *token);
  */
 void ssl_purge_auth_challenge(void);
 
+bool ssl_clean_auth_token(void);
+
 void ssl_put_auth_challenge(const char *cr_str);
 
 #endif
-- 
2.19.0


