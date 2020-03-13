From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 13 Mar 2020 18:59:13 +0200
Message-Id: <20200313165913.12682-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix broken async push with NCP is used
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

With NCP and deferred auth, we perform cipher negotiation and
generate data channel keys on incoming push request, assuming that auth
succeeded. With async push, when auth succeeds in between push requests,
we send push reply immediately.

The code which generates data channel keys is only called on handling incoming
push requests (incoming_push_message). It might not be called with NCP,
deferred auth and async push because on incoming push request auth might not
be complete yet. When auth is complete in between push requests, push reply
is sent and it is assumed that connection is established. However, since data channel keys
are not generated on the server side, connection doesn't work.

Fix by generating data channel keys when async push is triggered.

Reported-by: smaxfield@...2543...
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/init.c  |  6 ++----
 src/openvpn/multi.c | 24 +++++++++++++++++++++++-
 src/openvpn/push.c  |  6 ++----
 src/openvpn/ssl.c   |  6 ++++++
 src/openvpn/ssl.h   |  5 +++--
 5 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 824b6667..b3096dc8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2343,10 +2343,8 @@ do_deferred_options(struct context *c, const unsigned int found)
         }
 #endif
 
-        /* Do not regenerate keys if server sends an extra push reply */
-        if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized
-            && !tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
-                                                 frame_fragment))
+        if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
+                                              frame_fragment))
         {
             msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
             return false;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index da0aeeba..b42bcec9 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2137,8 +2137,30 @@ multi_process_file_closed(struct multi_context *m, const unsigned int mpp_flags)
         {
             if (mi)
             {
-                /* continue authentication and send push_reply */
+                /* continue authentication, perform NCP negotiation and send push_reply */
                 multi_process_post(m, mi, mpp_flags);
+
+                /* With NCP and deferred authentication, we perform cipher negotiation and
+                 * data channel keys generation on incoming push request, assuming that auth
+                 * succeeded. When auth succeeds in between push requests and async push is used,
+                 * we send push reply immediately. Above multi_process_post() call performs
+                 * NCP negotiation and here we do keys generation. */
+
+                struct context *c = &mi->context;
+                struct frame *frame_fragment = NULL;
+#ifdef ENABLE_FRAGMENT
+                if (c->options.ce.fragment)
+                {
+                    frame_fragment = &c->c2.frame_fragment;
+                }
+#endif
+                struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+                if (!tls_session_update_crypto_params(session, &c->options,
+                                                      &c->c2.frame, frame_fragment))
+                {
+                    msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
+                    register_signal(c, SIGUSR1, "init-data-channel-failed");
+                }
             }
             else
             {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 71f22e94..aef00d34 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -298,10 +298,8 @@ incoming_push_message(struct context *c, const struct buffer *buffer)
             }
 #endif
             struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
-            /* Do not regenerate keys if client send a second push request */
-            if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized
-                && !tls_session_update_crypto_params(session, &c->options,
-                                                     &c->c2.frame, frame_fragment))
+            if (!tls_session_update_crypto_params(session, &c->options,
+                                                  &c->c2.frame, frame_fragment))
             {
                 msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
                 goto error;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e21279f1..56d0576a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1956,6 +1956,12 @@ tls_session_update_crypto_params(struct tls_session *session,
                                  struct options *options, struct frame *frame,
                                  struct frame *frame_fragment)
 {
+    if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
+    {
+        /* keys already generated, nothing to do */
+        return true;
+    }
+
     if (!session->opt->server
         && 0 != strcmp(options->ciphername, session->opt->config_ciphername)
         && !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 3449d91e..f0a8ef54 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -474,7 +474,8 @@ void tls_update_remote_addr(struct tls_multi *multi,
 
 /**
  * Update TLS session crypto parameters (cipher and auth) and derive data
- * channel keys based on the supplied options.
+ * channel keys based on the supplied options. Does nothing if keys are already
+ * generated.
  *
  * @param session         The TLS session to update.
  * @param options         The options to use when updating session.
@@ -482,7 +483,7 @@ void tls_update_remote_addr(struct tls_multi *multi,
  *                        adjusted based on the selected cipher/auth).
  * @param frame_fragment  The fragment frame options.
  *
- * @return true if updating succeeded, false otherwise.
+ * @return true if updating succeeded or keys are already generated, false otherwise.
  */
 bool tls_session_update_crypto_params(struct tls_session *session,
                                       struct options *options,
-- 
2.17.1


