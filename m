From: Arne Schwabe <arne@...1227...>
Date: Fri,  7 Oct 2022 17:38:23 +0200
Message-Id: <20221007153823.1334940-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Allow Authtoken lifetime to be short than
 renegotiation time
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

Currently the life time of the auth-token is tied to the reneogotiation time.
While this is fine for many setups, some setups prefer a user to be no longer
authenticated when the user disconnects from the VPN for a certain amount of
time.

This commit allows to shorten the renewal time of the auth-token and ensures
that the server resends the auth-token often enough over the existing control
channel. This way of updating the auth token is a lot more lightweight than
the alternative.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/server-options.rst        | 16 ++++---
 src/openvpn/auth_token.c                   | 49 ++++++++++++++++++----
 src/openvpn/auth_token.h                   | 14 +++++--
 src/openvpn/forward.c                      | 15 ++++++-
 src/openvpn/init.c                         | 11 +++++
 src/openvpn/openvpn.h                      |  3 ++
 src/openvpn/options.c                      | 24 +++++++++--
 src/openvpn/options.h                      |  2 +-
 src/openvpn/ssl.c                          |  8 +++-
 src/openvpn/ssl_common.h                   |  7 +++-
 tests/unit_tests/openvpn/test_auth_token.c |  3 +-
 11 files changed, 127 insertions(+), 25 deletions(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 54ea8b66c..e0d99c4f1 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -14,7 +14,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   Valid syntax:
   ::
 
-     auth-gen-token [lifetime] [external-auth]
+     auth-gen-token [lifetime] [renewal-time] [external-auth]
 
   After successful user/password authentication, the OpenVPN server will
   with this option generate a temporary authentication token and push that
@@ -31,13 +31,17 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   The lifetime is defined in seconds. If lifetime is not set or it is set
   to :code:`0`, the token will never expire.
 
+  If ``renewal-time`` is not set it defaults to ``renog-sec``.
+
+
   The token will expire either after the configured ``lifetime`` of the
   token is reached or after not being renewed for more than 2 \*
-  ``reneg-sec`` seconds. Clients will be sent renewed tokens on every TLS
-  renogiation to keep the client's token updated. This is done to
-  invalidate a token if a client is disconnected for a sufficiently long
-  time, while at the same time permitting much longer token lifetimes for
-  active clients.
+  ``renewal-time`` seconds. Clients will be sent renewed tokens on every TLS
+  renogiation. If ``renewal-time`` is lower than ``renog-sec`` the server
+  will push an  updated temporary authentication token every ``reneweal-time``
+  seconds. This is done to invalidate a token if a client is disconnected for a
+  sufficiently long time, while at the same time permitting much longer token
+  lifetimes for active clients.
 
   This feature is useful for environments which are configured to use One
   Time Passwords (OTP) as part of the user/password authentications and
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index b5f9f6dd7..ca52dfb2e 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -174,7 +174,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
 
     if (multi->auth_token_initial)
     {
-        /* Just enough space to fit 8 bytes+ 1 extra to decode a non padded
+        /* Just enough space to fit 8 bytes+ 1 extra to decode a non-padded
          * base64 string (multiple of 3 bytes). 9 bytes => 12 bytes base64
          * bytes
          */
@@ -349,11 +349,11 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
     /* Accept session tokens only if their timestamp is in the acceptable range
      * for renegotiations */
     bool in_renegotiation_time = now >= timestamp
-                                 && now < timestamp + 2 * session->opt->renegotiate_seconds;
+                                 && now < timestamp + 2 * session->opt->auth_token_renewal;
 
     if (!in_renegotiation_time)
     {
-        msg(M_WARN, "Timestamp (%" PRIu64 ") of auth-token is out of the renegotiation window",
+        msg(M_WARN, "Timestamp (%" PRIu64 ") of auth-token is out of the renewal window",
             timestamp);
         ret |= AUTH_TOKEN_EXPIRED;
     }
@@ -416,6 +416,43 @@ wipe_auth_token(struct tls_multi *multi)
     }
 }
 
+void
+check_send_auth_token(struct context *c)
+{
+    struct tls_multi *multi = c->c2.tls_multi;
+    struct tls_session *session = &multi->session[TM_ACTIVE];
+
+    if (get_primary_key(multi)->state < S_GENERATED_KEYS
+        || get_primary_key(multi)->authenticated != KS_AUTH_TRUE)
+    {
+        /* the currently active session is still in renegotiation or another
+         * not fully authorized state. We are either very close to a
+         * renegotiation or have deauthorized the client. In both cases
+         * we just ignore the request to send another token*/
+        return;
+    }
+
+    if (!multi->auth_token_initial)
+    {
+        msg(D_SHOW_KEYS, "initial auth-token not generated yet, skipping "
+            "auth-token renewal.");
+        return;
+    }
+
+    if (!multi->locked_username)
+    {
+        msg(D_SHOW_KEYS, "username not locked, skipping auth-token renewal.");
+        return;
+    }
+
+    struct user_pass up;
+    strncpynt(up.username, multi->locked_username, sizeof(up.username));
+
+    generate_auth_token(&up, multi);
+
+    resend_auth_token_renegotiation(multi, session);
+}
+
 void
 resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *session)
 {
@@ -424,12 +461,10 @@ resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *ses
      * The initial auth-token is sent as part of the push message, for this
      * update we need to schedule an extra push message.
      *
-     * Otherwise the auth-token get pushed out as part of the "normal"
+     * Otherwise, the auth-token get pushed out as part of the "normal"
      * push-reply
      */
-    bool is_renegotiation = session->key[KS_PRIMARY].key_id != 0;
-
-    if (multi->auth_token_initial && is_renegotiation)
+    if (multi->auth_token_initial)
     {
         /*
          * We do not explicitly reschedule the sending of the
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 50b90cfa4..5e23d8c44 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -46,11 +46,11 @@
  * (2 * renogiation timeout)
  *
  * The session id is a random string of 12 byte (or 16 in base64) that is not
- * used by OpenVPN itself but kept intact so that external logging/managment
- * can track the session multiple reconnects/servers. It is delibrately chosen
+ * used by OpenVPN itself but kept intact so that external logging/management
+ * can track the session multiple reconnects/servers. It is deliberately chosen
  * be a multiple of 3 bytes to have a base64 encoding without padding.
  *
- * The hmac is calculated over the username contactinated with the
+ * The hmac is calculated over the username concatenated with the
  * raw auth-token bytes to include authentication of the username in the token
  *
  * We encode the auth-token with base64 and then prepend "SESS_ID_" before
@@ -138,4 +138,12 @@ is_auth_token(const char *password)
 void
 resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *session);
 
+
+/**
+ * Checks if the timer to resend the auth-token has expired and if a new
+ * auth-token should be send to the client and triggers the resending
+ */
+void
+check_send_auth_token(struct context *c);
+
 #endif /* AUTH_TOKEN_H */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6a45b9e91..eca4a4335 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -42,6 +42,7 @@
 #include "common.h"
 #include "ssl_verify.h"
 #include "dco.h"
+#include "auth_token.h"
 
 #include "memdbg.h"
 
@@ -195,9 +196,15 @@ check_tls(struct context *c)
 
     interval_schedule_wakeup(&c->c2.tmp_int, &wakeup);
 
-    /* Our current code has no good hooks in the TLS machinery to update
+    /*
+     * Our current code has no good hooks in the TLS machinery to update
      * DCO keys. So we check the key status after the whole TLS machinery
      * has been completed and potentially update them
+     *
+     * We have a hidden state transition from secondary to primary key based
+     * on ks->auth_deferred_expire that DCO needs to check that the normal
+     * TLS state engine does not check. So we call the doc check even if
+     * tmp_status does not indicate that something has changed.
      */
     check_dco_key_status(c);
 
@@ -669,6 +676,12 @@ process_coarse_timers(struct context *c)
         check_add_routes(c);
     }
 
+    /* check if we want to refresh the auth-token */
+    if (event_timeout_trigger(&c->c2.auth_token_renewal_interval, &c->c2.timeval, ETT_DEFAULT))
+    {
+        check_send_auth_token(c);
+    }
+
     /* possibly exit due to --inactive */
     if (c->options.inactivity_timeout
         && event_timeout_trigger(&c->c2.inactivity_interval, &c->c2.timeval, ETT_DEFAULT))
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c88c09155..9214c0017 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1340,6 +1340,16 @@ do_init_timers(struct context *c, bool deferred)
         }
     }
 
+    /* Arm the timer if we need to renew the auth-token renewal interval is
+     * shorter than renog-sec to send additional auth-token to ensure the
+     * token is updated on the client */
+    if (c->options.auth_token_generate
+        && c->options.auth_token_renewal < c->options.renegotiate_seconds)
+    {
+        event_timeout_init(&c->c2.auth_token_renewal_interval,
+                           c->options.auth_token_renewal, now);
+    }
+
     if (!deferred)
     {
         /* initialize connection establishment timer */
@@ -3075,6 +3085,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.auth_user_pass_file = options->auth_user_pass_file;
     to.auth_token_generate = options->auth_token_generate;
     to.auth_token_lifetime = options->auth_token_lifetime;
+    to.auth_token_renewal = options->auth_token_renewal;
     to.auth_token_call_auth = options->auth_token_call_auth;
     to.auth_token_key = c->c1.ks.auth_token_key;
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index dd69ac031..96a682822 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -288,6 +288,9 @@ struct context_2
     struct event_timeout inactivity_interval;
     int64_t inactivity_bytes;
 
+    /* auth token renewal timer */
+    struct event_timeout auth_token_renewal_interval;
+
     /* the option strings must match across peers */
     char *options_string_local;
     char *options_string_remote;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e44993c03..fea6a05fb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2630,6 +2630,14 @@ options_postprocess_verify_ce(const struct options *options,
             msg(M_USAGE, "--auth-gen-token needs a non-infinite "
                 "--renegotiate_seconds setting");
         }
+        if (options->auth_token_generate && options->auth_token_renewal
+            && options->auth_token_renewal < 2 * options->handshake_window)
+        {
+            msg(M_USAGE, "--auth-gen-token reneweal time needs to be at least "
+                " two times --hand-window (%d).",
+                options->handshake_window);
+
+        }
         {
             const bool ccnr = (options->auth_user_pass_verify_script
                                || PLUGIN_OPTION_LIST(options)
@@ -3743,6 +3751,10 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
         foreign_options_copy_dns(o, es);
 #endif
     }
+    if (o->auth_token_generate && !o->auth_token_renewal)
+    {
+        o->auth_token_renewal = o->renegotiate_seconds;
+    }
     pre_connect_save(o);
 }
 
@@ -7461,15 +7473,21 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->auth_token_generate = true;
         options->auth_token_lifetime = p[1] ? positive_atoi(p[1]) : 0;
-        if (p[2])
+
+        for (int i = 2; i < MAX_PARMS && p[i] != NULL; i++)
         {
-            if (streq(p[2], "external-auth"))
+            /* the second parameter can be the reneweal time */
+            if (i == 2 && positive_atoi(p[i]))
+            {
+                options->auth_token_renewal = positive_atoi(p[i]);
+            }
+            else if (streq(p[i], "external-auth"))
             {
                 options->auth_token_call_auth = true;
             }
             else
             {
-                msg(msglevel, "Invalid argument to auth-gen-token: %s", p[2]);
+                msg(msglevel, "Invalid argument to auth-gen-token: %s (%d)", p[i], i);
             }
         }
 
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index e83bc0ed8..3c9e218f7 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -513,9 +513,9 @@ struct options
     const char *auth_user_pass_verify_script;
     bool auth_user_pass_verify_script_via_file;
     bool auth_token_generate;
-    bool auth_token_gen_secret_file;
     bool auth_token_call_auth;
     int auth_token_lifetime;
+    int auth_token_renewal;
     const char *auth_token_secret_file;
     bool auth_token_secret_file_inline;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 672cd9c84..d902fe592 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3133,8 +3133,12 @@ tls_multi_process(struct tls_multi *multi,
                     ks->state = S_ERROR;
                 }
 
-                /* Update auth token on the client if needed */
-                resend_auth_token_renegotiation(multi, session);
+                /* Update auth token on the client if needed on renegotiation
+                 * (key id !=0) */
+                if (session->key[KS_PRIMARY].key_id != 0)
+                {
+                    resend_auth_token_renegotiation(multi, session);
+                }
             }
         }
     }
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f1cade2ef..db0a96cc9 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -196,7 +196,7 @@ struct key_state
 {
     int state;
     /** The state of the auth-token sent from the client */
-    int auth_token_state_flags;
+    unsigned int auth_token_state_flags;
 
     /**
      * Key id for this key_state,  inherited from struct tls_session.
@@ -373,6 +373,7 @@ struct tls_options
                                  * options->auth_token_generate. */
     bool auth_token_call_auth; /**< always call normal authentication */
     unsigned int auth_token_lifetime;
+    unsigned int auth_token_renewal;
 
     struct key_ctx auth_token_key;
 
@@ -624,6 +625,10 @@ struct tls_multi
                           *   user/pass authentications in this session.
                           */
     char *auth_token_initial;
+    /**< Last time an auth-token was generated, this is strictly speaking redundant
+     *  as the auth_token attribute already contains the information but in a
+     *  highly encoded way */
+    time_t auth_token_lastgenerated;
     /**< The first auth-token we sent to a client. We use this to remember
      * the session ID and initial timestamp when generating new auth-token.
      */
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 5299c3643..2c3c3db71 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -102,7 +102,8 @@ setup(void **state)
     ctx->session = &ctx->multi.session[TM_ACTIVE];
 
     ctx->session->opt = calloc(1, sizeof(struct tls_options));
-    ctx->session->opt->renegotiate_seconds = 120;
+    ctx->session->opt->renegotiate_seconds = 240;
+    ctx->session->opt->auth_token_renewal = 120;
     ctx->session->opt->auth_token_lifetime = 3000;
 
     strcpy(ctx->up.username, "test user name");
-- 
2.37.0 (Apple Git-136)


