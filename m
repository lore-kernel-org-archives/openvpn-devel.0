From: Arne Schwabe <arne@...1227...>
Date: Mon,  5 Mar 2018 16:15:51 +0100
Message-Id: <1520262951-1807-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Rework OpenVPN auth-token support
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

Auth-token is documented as a token that the client will use instead of a auth-token. When using an external auth-token script and OTP authentication, it is useful to have this token survive on reconnect (e.g. mobile device roaming).
On the other hand if the token does expire, the client should fall back to the previous authentication methd (e.g. user/pass) or ask for a OTP password again.

Behaviour of OpenVPN client (prior to this patch) is to never fallback to the previous authentication method. Depending on auth-retry it either quit or tried endlessly with an expired token. Since auth-gen-token tokens expire on reconnect, a client will not survive a reconnect.

This patch changes the client behaviour:
- Treat a failed auth when using an auth-token as a soft error (USR1) and clean the auth-token falling back to the original auth method
- Implement a new pushable option forget-token-reconnect that forces to forget an auth-token when reconnecting
- Sending IV_PROTO=3 to signal that it is safe to send this client an expiring auth-token

The behaviour of the server option auth-gen-token:
- Automatically push forget-token-reconnect to avoid a failed authentication after reconnect
- By default only send auth-token to clients that will gracefully handle auth-token to avoid having clients not able to reconnect
- Add a force option to auth-gen-token that allow to ignore if the client can handle auth-tokens
---
 doc/openvpn.8            | 39 ++++++++++++++++++--
 src/openvpn/init.c       |  4 ++
 src/openvpn/misc.c       | 16 +++++---
 src/openvpn/misc.h       |  3 +-
 src/openvpn/options.c    | 11 +++++-
 src/openvpn/options.h    |  2 +
 src/openvpn/push.c       | 95 ++++++++++++++++++++++++++++++++----------------
 src/openvpn/ssl.c        | 41 +++++++++++++--------
 src/openvpn/ssl.h        |  2 +
 src/openvpn/ssl_common.h |  2 +
 10 files changed, 156 insertions(+), 59 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d1fb4ec6..02c51a10 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3058,7 +3058,8 @@ IV_LZO_STUB=1 \-\- if client was built with LZO stub capability
 
 IV_LZ4=1 \-\- if the client supports LZ4 compressions.
 
-IV_PROTO=2 \-\- if the client supports peer\-id floating mechansim
+IV_PROTO=3 \-\- if the client supports peer\-id floating mechansim (2 or greater) and
+fallback to normal authentication after a failed auth-token authentication (3 or greater)
 
 IV_NCP=2 \-\- negotiable ciphers, client supports
 .B \-\-cipher
@@ -3664,7 +3665,7 @@ For a sample script that performs PAM authentication, see
 in the OpenVPN source distribution.
 .\"*********************************************************
 .TP
-.B \-\-auth\-gen\-token [lifetime]
+.B \-\-auth\-gen\-token [lifetime] [force]
 After successful user/password authentication, the OpenVPN
 server will with this option generate a temporary
 authentication token and push that to client.  On the following
@@ -3684,6 +3685,12 @@ This feature is useful for environments which is configured
 to use One Time Passwords (OTP) as part of the user/password
 authentications and that authentication mechanism does not
 implement any auth\-token support.
+
+The
+.B force
+option will send auth-token even if the client does not signal
+proper auth-token support on reconnect and will fail on reconnect with
+failed authentication. This is the behaviour of versions prior to 2.4.6.
 .\"*********************************************************
 .TP
 .B \-\-opt\-verify
@@ -5337,7 +5344,33 @@ push "auth\-token UNIQUE_TOKEN_VALUE"
 into the file/buffer for dynamic configuration data.  This
 will then make the OpenVPN server to push this value to the
 client, which replaces the local password with the
-UNIQUE_TOKEN_VALUE.
+UNIQUE_TOKEN_VALUE. If you want the client (2.4.6+) to forget the token when
+reconnecting also use:
+
+.nf
+.ft 3
+.in +4
+push "forget\-token\-reconnect"
+.in -4
+.ft
+.fi
+
+Newer clients (2.4.6+) will fall back to the original password method
+after a failed auth-token attempt. Older clients will keep using the token
+value and react acording to
+.B \-\-auth-retry
+.
+.\**********************************************************
+.TP
+.B forget\-token\-reconnect
+
+Normally a client will retry an auth-token after a reconnect (e.g. USR1 triggered).
+If the token fails, the client will fall back to the original method and make an additional
+connection attempt. If the token is only valid for a single connection this option can be used
+to skip the first attempt on reconnect. The
+.B
+auth\-gen\-token
+option automatically pushes this option.
 .\"*********************************************************
 .TP
 .B \-\-tls\-verify cmd
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 36c1a4c4..59be55e8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2750,6 +2750,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.auth_user_pass_file = options->auth_user_pass_file;
     to.auth_token_generate = options->auth_token_generate;
     to.auth_token_lifetime = options->auth_token_lifetime;
+    to.auth_token_generate_force = options->auth_token_generate_force;
 #endif
 
     to.x509_track = options->x509_track;
@@ -3390,6 +3391,9 @@ do_close_tls(struct context *c)
         md_ctx_cleanup(c->c2.pulled_options_state);
         md_ctx_free(c->c2.pulled_options_state);
     }
+
+    if (c->options.forget_token_on_reconnect)
+        ssl_clean_auth_token();
 }
 
 /*
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 72ffc406..e41198ee 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1258,7 +1258,7 @@ purge_user_pass(struct user_pass *up, const bool force)
      * don't show warning if the pass has been replaced by a token: this is an
      * artificial "auth-nocache"
      */
-    else if (!warn_shown && (!up->tokenized))
+    else if (!warn_shown)
     {
         msg(M_WARN, "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this");
         warn_shown = true;
@@ -1266,14 +1266,18 @@ purge_user_pass(struct user_pass *up, const bool force)
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
index dad6a5de..68ec6a94 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -168,7 +168,6 @@ struct user_pass
 {
     bool defined;
     bool nocache;
-    bool tokenized; /* true if password has been substituted by a token */
     bool wait_for_push; /* true if this object is waiting for a push-reply */
 
 /* max length of username/password */
@@ -250,7 +249,7 @@ void fail_user_pass(const char *prefix,
 
 void purge_user_pass(struct user_pass *up, const bool force);
 
-void set_auth_token(struct user_pass *up, const char *token);
+void set_auth_token(struct user_pass *up, struct user_pass *tk, const char *token);
 
 /*
  * Process string received by untrusted peer before
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cea143b8..0dc6cc5c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -883,6 +883,7 @@ init_options(struct options *o, const bool init_gc)
 /* P2MP server context features */
 #if P2MP_SERVER
     o->auth_token_generate = false;
+    o->auth_token_generate_force = false;
 
     /* Set default --tmp-dir */
 #ifdef _WIN32
@@ -1334,6 +1335,7 @@ show_p2mp_parms(const struct options *o)
     SHOW_STR(auth_user_pass_verify_script);
     SHOW_BOOL(auth_user_pass_verify_script_via_file);
     SHOW_BOOL(auth_token_generate);
+    SHOW_BOOL(auth_token_generate_force);
     SHOW_INT(auth_token_lifetime);
 #if PORT_SHARE
     SHOW_STR(port_share_host);
@@ -6718,11 +6720,13 @@ add_option(struct options *options,
                         &options->auth_user_pass_verify_script,
                         p[1], "auth-user-pass-verify", true);
     }
-    else if (streq(p[0], "auth-gen-token"))
+    else if (streq(p[0], "auth-gen-token") && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->auth_token_generate = true;
         options->auth_token_lifetime = p[1] ? positive_atoi(p[1]) : 0;
+        if (p[2] && streq(p[2], "force"))
+            options->auth_token_generate_force = true;
     }
     else if (streq(p[0], "client-connect") && p[1])
     {
@@ -7791,6 +7795,11 @@ add_option(struct options *options,
         }
 #endif
     }
+    else if (streq(p[0], "forget-token-reconnect") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_ECHO);
+        options->forget_token_on_reconnect = true;
+    }
     else if (streq(p[0], "single-session") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d9a5b372..5e3a999e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -443,6 +443,7 @@ struct options
     const char *auth_user_pass_verify_script;
     bool auth_user_pass_verify_script_via_file;
     bool auth_token_generate;
+    bool auth_token_generate_force;
     unsigned int auth_token_lifetime;
 #if PORT_SHARE
     char *port_share_host;
@@ -457,6 +458,7 @@ struct options
     unsigned int push_option_types_found;
     const char *auth_user_pass_file;
     struct options_pre_pull *pre_pull;
+    bool forget_token_on_reconnect;
 
     int scheduled_exit_interval;
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6a30e479..8e154959 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -53,25 +53,31 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
     msg(M_VERB0, "AUTH: Received control message: %s", BSTR(buffer));
     c->options.no_advance = true;
 
-    if (c->options.pull)
-    {
-        switch (auth_retry_get())
+    if (c->options.pull) {
+        /* Before checking how to react on AUTH_FAILED, first check if the failed authed might be
+         * the result of an expired auth-token */
+        if (ssl_clean_auth_token())
         {
-            case AR_NONE:
-                c->sig->signal_received = SIGTERM; /* SOFT-SIGTERM -- Auth failure error */
-                break;
-
-            case AR_INTERACT:
-                ssl_purge_auth(false);
-
-            case AR_NOINTERACT:
-                c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Auth failure error */
-                break;
-
-            default:
-                ASSERT(0);
+            c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Auth failure error */
+            c->sig->signal_text = "auth-failure (auth-token)";
+        } else {
+            switch (auth_retry_get()) {
+                case AR_NONE:
+                    c->sig->signal_received = SIGTERM; /* SOFT-SIGTERM -- Auth failure error */
+                    break;
+
+                case AR_INTERACT:
+                    ssl_purge_auth(false);
+
+                case AR_NOINTERACT:
+                    c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Auth failure error */
+                    break;
+
+                default:
+                    ASSERT(0);
+            }
+            c->sig->signal_text = "auth-failure";
         }
-        c->sig->signal_text = "auth-failure";
 #ifdef ENABLE_MANAGEMENT
         if (management)
         {
@@ -325,7 +331,6 @@ static bool
 prepare_push_reply(struct context *c, struct gc_arena *gc,
                    struct push_list *push_list)
 {
-    const char *optstr = NULL;
     struct tls_multi *tls_multi = c->c2.tls_multi;
     const char *const peer_info = tls_multi->peer_info;
     struct options *o = &c->options;
@@ -355,18 +360,33 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
                                         0, gc));
     }
 
-    /* Send peer-id if client supports it */
-    optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
+    /* Extract the version info from IV_PROTO */
+    const char* optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
+    int protover = 0;
     if (optstr)
     {
-        int proto = 0;
-        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
-        if ((r == 1) && (proto >= 2))
-        {
-            push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
-                            tls_multi->peer_id);
-            tls_multi->use_peer_id = true;
-        }
+        int r = sscanf(optstr, "IV_PROTO=%d", &protover);
+        if (r != 1)
+            protover = 0;
+    }
+
+    /* OpenVPN 3 C++ core *always* forgets the auth-token at the end of a session, check if client
+     * is an OpenVPN 3 client */
+    int clientmajor=0;
+    optstr = peer_info ? strstr(peer_info, "IV_VER=") : NULL;
+    if (optstr)
+    {
+      int r = sscanf(optstr, "IV_VER=%d", &protover);
+      if (r != 0)
+        clientmajor=0;
+    }
+
+    /* Send peer-id if client supports it */
+    if (protover >= 2)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
+                        tls_multi->peer_id);
+        tls_multi->use_peer_id = true;
     }
 
     /* Push cipher if client supports Negotiable Crypto Parameters */
@@ -400,12 +420,25 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
 
     /* If server uses --auth-gen-token and we have an auth token
      * to send to the client
+     * Also push forget-token-reconnect since our token is only valid for
+     * a sigle connection. Older clients will just ignore the option
      */
     if (false == tls_multi->auth_token_sent && NULL != tls_multi->auth_token)
     {
-        push_option_fmt(gc, push_list, M_USAGE,
-                        "auth-token %s", tls_multi->auth_token);
-        tls_multi->auth_token_sent = true;
+        if (protover >= 3 || clientmajor == 3 || o->auth_token_generate_force)
+        {
+            push_option_fmt(gc, push_list, M_USAGE,
+                            "auth-token %s", tls_multi->auth_token);
+            push_option_fmt(gc, push_list, M_USAGE,
+                            "forget-token-reconnect");
+            tls_multi->auth_token_sent = true;
+        }
+        else
+        {
+            msg(D_TLS_DEBUG_LOW, "Not sending auth-token to client since it will not "
+                             "properly reconnect. (Use force option to auth-gen-token "
+                			 "to force sending)");
+        }
     }
     return true;
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d758c31a..d90b914d 100644
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
@@ -2270,8 +2274,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         buf_printf(&out, "IV_PLAT=win\n");
 #endif
 
-        /* support for P_DATA_V2 */
-        buf_printf(&out, "IV_PROTO=2\n");
+        /* support for P_DATA_V2 and
+         * fallback to normal authentication after a failed auth-token authentication  */
+        buf_printf(&out, "IV_PROTO=3\n");
 
         /* support for Negotiable Crypto Paramters */
         if (session->opt->ncp_enabled
@@ -2377,19 +2382,23 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
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
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 08ef6ffa..d39380d4 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -299,6 +299,8 @@ struct tls_options
     const char *auth_user_pass_file;
     bool auth_token_generate;   /**< Generate auth-tokens on successful user/pass auth,
                                  *   set via options->auth_token_generate. */
+    bool auth_token_generate_force;  /* Sent auth-tokens even if the client will not reconnect
+                                      * properly with them */
     unsigned int auth_token_lifetime;
 
     /* use the client-config-dir as a positive authenticator */
-- 
2.11.0


