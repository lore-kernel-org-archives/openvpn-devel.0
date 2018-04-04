From: Arne Schwabe <arne@...1227...>
Date: Wed,  4 Apr 2018 18:57:00 +0200
Message-Id: <1522861020-21528-1-git-send-email-arne@...1227...>
In-Reply-To: <1520262951-1807-1-git-send-email-arne@...1227...>
References: <1520262951-1807-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4] Revert to original password
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
---
 doc/openvpn.8      |  8 +++++++-
 src/openvpn/misc.c | 16 ++++++++++------
 src/openvpn/misc.h |  3 +--
 src/openvpn/push.c | 16 ++++++++++++++--
 src/openvpn/ssl.c  | 36 ++++++++++++++++++++++--------------
 src/openvpn/ssl.h  |  2 ++
 6 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 6ced4e4b..dc210890 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5362,7 +5362,13 @@ push "auth\-token UNIQUE_TOKEN_VALUE"
 into the file/buffer for dynamic configuration data.  This
 will then make the OpenVPN server to push this value to the
 client, which replaces the local password with the
-UNIQUE_TOKEN_VALUE.
+UNIQUE_TOKEN_VALUE. 
+
+Newer clients (2.4.6+) will fall back to the original password method
+after a failed auth. Older clients will keep using
+the token value and react acording to
+.B \-\-auth-retry
+.
 .\"*********************************************************
 .TP
 .B \-\-tls\-verify cmd
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index fc68027f..f2449eed 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -882,7 +882,7 @@ purge_user_pass(struct user_pass *up, const bool force)
      * don't show warning if the pass has been replaced by a token: this is an
      * artificial "auth-nocache"
      */
-    else if (!warn_shown && (!up->tokenized))
+    else if (!warn_shown)
     {
         msg(M_WARN, "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this");
         warn_shown = true;
@@ -890,14 +890,18 @@ purge_user_pass(struct user_pass *up, const bool force)
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
index 5680c274..29a6b89a 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -102,7 +102,6 @@ struct user_pass
 {
     bool defined;
     bool nocache;
-    bool tokenized; /* true if password has been substituted by a token */
     bool wait_for_push; /* true if this object is waiting for a push-reply */
 
 /* max length of username/password */
@@ -184,7 +183,7 @@ void fail_user_pass(const char *prefix,
 
 void purge_user_pass(struct user_pass *up, const bool force);
 
-void set_auth_token(struct user_pass *up, const char *token);
+void set_auth_token(struct user_pass *up, struct user_pass *tk, const char *token);
 
 /*
  * Process string received by untrusted peer before
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6a30e479..43df91ba 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -55,8 +55,19 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
 
     if (c->options.pull)
     {
-        switch (auth_retry_get())
+        /* Before checking how to react on AUTH_FAILED, first check if the failed authed might be
+         * the result of an expired auth-token.
+         * Note that a server restart will trigger a generic AUTH_FAILED instead an AUTH_FAILED,SESSION so 
+         * handle all AUTH_FAILED message identical for this scenario */
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
@@ -70,8 +81,9 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
 
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
index 669f941b..1c1ba305 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -398,6 +398,7 @@ pem_password_callback(char *buf, int size, int rwflag, void *u)
 
 static bool auth_user_pass_enabled;     /* GLOBAL */
 static struct user_pass auth_user_pass; /* GLOBAL */
+static struct user_pass auth_token;     /* GLOBAL */
 
 #ifdef ENABLE_CLIENT_CR
 static char *auth_challenge; /* GLOBAL */
@@ -407,7 +408,7 @@ void
 auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *sci)
 {
     auth_user_pass_enabled = true;
-    if (!auth_user_pass.defined)
+    if (!auth_user_pass.defined && !auth_token.defined)
     {
 #if AUTO_USERID
         get_user_pass_auto_userid(&auth_user_pass, auth_file);
@@ -449,7 +450,7 @@ ssl_set_auth_nocache(void)
 {
     passbuf.nocache = true;
     auth_user_pass.nocache = true;
-    /* wait for push-reply, because auth-token may invert nocache */
+    /* wait for push-reply, because auth-token may still need the username */
     auth_user_pass.wait_for_push = true;
 }
 
@@ -459,15 +460,18 @@ ssl_set_auth_nocache(void)
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
@@ -2377,19 +2381,23 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
 #else
         auth_user_pass_setup(session->opt->auth_user_pass_file, NULL);
 #endif
-        if (!write_string(buf, auth_user_pass.username, -1))
+        struct user_pass* up = &auth_user_pass;
+
+        /* If we have a valid auth-token, send that instead of real username/password */
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
index a2501c9b..116e76a1 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -428,6 +428,8 @@ void ssl_purge_auth(const bool auth_user_pass_only);
 
 void ssl_set_auth_token(const char *token);
 
+bool ssl_clean_auth_token(void);
+
 #ifdef ENABLE_CLIENT_CR
 /*
  * ssl_get_auth_challenge will parse the server-pushed auth-failed
-- 
2.16.2


