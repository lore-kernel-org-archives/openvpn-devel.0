From: Arne Schwabe <arne@...1227...>
Date: Fri, 20 May 2022 23:32:47 +0200
Message-Id: <20220520213250.3126372-2-arne@...1227...>
In-Reply-To: <20220520213250.3126372-1-arne@...1227...>
References: <20220520213250.3126372-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/4] Implement exit notification via
 control channel
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

Current exit notification relies on data channel messages with specific
prefix. Adding these to new data channel modules (DCO) adds unncessary
complexity for the data for messages that from their idea belong to the
control channel anyway.

This patch adds announcing support for control channel and sending/receving
it. We use the simple EXIT message for this.

Patch V2: add comment about protocol-flags to be not a user visible option,
          fix various grammar mistakes, remove unused argument to
          receive_exit_message
---
 doc/man-sections/client-options.rst |  7 ++++++-
 src/openvpn/crypto.h                |  5 +++++
 src/openvpn/forward.c               |  4 ++++
 src/openvpn/multi.c                 |  5 +++++
 src/openvpn/options.c               | 20 ++++++++++++++++++++
 src/openvpn/push.c                  | 19 +++++++++++++++++++
 src/openvpn/push.h                  |  2 ++
 src/openvpn/sig.c                   | 27 +++++++++++++++++++++++++--
 src/openvpn/ssl.c                   |  3 +++
 src/openvpn/ssl.h                   |  3 +++
 src/openvpn/ssl_ncp.c               |  5 +++++
 11 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 8e0e4f18a..5a906895b 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -220,9 +220,14 @@ configuration.
   immediately close its client instance object rather than waiting for a
   timeout.
 
+  If both server and client support sending this message using the control
+  channel, the message will be sent as control-channel message. Otherwise
+  the message is sent as data-channel message, which will be ignored by
+  data-channel offloaded peers.
+
   The **n** parameter (default :code:`1` if not present) controls the
   maximum number of attempts that the client will try to resend the exit
-  notification message.
+  notification message if messages are sent in data-channel mode.
 
   In UDP server mode, send :code:`RESTART` control channel command to
   connected clients. The ``n`` parameter (default :code:`1` if not present)
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 98e2c7664..5ea889081 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -264,6 +264,11 @@ struct crypto_options
     /**< Bit-flag indicating that we do not allow clients that do
      * not support resending the wrapped client key (WKc) with the
      * third packet of the three-way handshake */
+#define CO_USE_CC_EXIT_NOTIFY       (1<<6)
+    /**< Bit-flag indicating that explicit exit notifies should be
+     * sent via the control channel instead of using an OCC message
+     */
+
     unsigned int flags;         /**< Bit-flags determining behavior of
                                  *   security operation functions. */
 };
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6afe152b4..4fb3a20d7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -241,6 +241,10 @@ check_incoming_control_channel(struct context *c)
         {
             receive_auth_pending(c, &buf);
         }
+        else if (buf_string_match_head_str(&buf, "EXIT"))
+        {
+            receive_exit_message(c);
+        }
         else
         {
             msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", BSTR(&buf));
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ba2f6d581..e7c99f813 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1777,6 +1777,11 @@ multi_client_set_protocol_options(struct context *c)
     }
 #endif
 
+    if (proto & IV_PROTO_CC_EXIT_NOTIFY)
+    {
+        o->data_channel_crypto_flags |= CO_USE_CC_EXIT_NOTIFY;
+    }
+
     /* Select cipher if client supports Negotiable Crypto Parameters */
 
     /* if we have already created our key, we cannot *change* our own
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9ff384d09..427d58392 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8326,6 +8326,8 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "key-derivation") && p[1])
     {
+        /* NCP only option that is pushed by the server to enable EKM,
+         * should not be used by normal users in config files*/
         VERIFY_PERMISSION(OPT_P_NCP)
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
         if (streq(p[1], "tls-ekm"))
@@ -8338,6 +8340,24 @@ add_option(struct options *options,
             msg(msglevel, "Unknown key-derivation method %s", p[1]);
         }
     }
+    else if (streq(p[0], "protocol-flags") && p[1])
+    {
+        /* NCP only option that is pushed by the server to enable protocol
+         * features that are negotiated, should not be used by normal users
+         * in config files */
+        VERIFY_PERMISSION(OPT_P_NCP)
+        for (size_t j = 1; j < MAX_PARMS && p[j] != NULL; j++)
+        {
+            if (streq(p[j], "cc-exit"))
+            {
+                options->data_channel_crypto_flags |= CO_USE_CC_EXIT_NOTIFY;
+            }
+            else
+            {
+                msg(msglevel, "Unknown protocol-flags flag: %s", p[j]);
+            }
+        }
+    }
     else if (streq(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL library PRNG is used)");
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 70fd1c3ce..fa0def7f8 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -176,6 +176,21 @@ server_pushed_signal(struct context *c, const struct buffer *buffer, const bool
     }
 }
 
+void
+receive_exit_message(struct context *c)
+{
+    dmsg(D_STREAM_ERRORS, "Exit message received by peer");
+    c->sig->signal_received = SIGTERM;
+    c->sig->signal_text = "remote-exit";
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_notify(management, "info", c->sig->signal_text, "EXIT");
+    }
+#endif
+}
+
+
 void
 server_pushed_info(struct context *c, const struct buffer *buffer,
                    const int adv)
@@ -604,6 +619,10 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
     {
         push_option_fmt(gc, push_list, M_USAGE, "key-derivation tls-ekm");
     }
+    if (o->data_channel_crypto_flags & CO_USE_CC_EXIT_NOTIFY)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "protocol-flags cc-exit");
+    }
     return true;
 }
 
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 62fad4a14..7138055a7 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -48,6 +48,8 @@ void receive_auth_failed(struct context *c, const struct buffer *buffer);
 
 void server_pushed_signal(struct context *c, const struct buffer *buffer, const bool restart, const int adv);
 
+void receive_exit_message(struct context *c);
+
 void server_pushed_info(struct context *c, const struct buffer *buffer,
                         const int adv);
 
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index e06edd216..d6683d2d1 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -321,20 +321,43 @@ print_status(const struct context *c, struct status_output *so)
     gc_free(&gc);
 }
 
+
+/* Small helper function to determine if we should send the exit notification
+ * via control channel */
+static inline bool
+cc_exit_notify_enabled(struct context *c)
+{
+    /* Check if we have TLS active at all */
+    if (!c->c2.tls_multi)
+    {
+        return false;
+    }
+
+    const struct key_state *ks = get_primary_key(c->c2.tls_multi);
+    return (ks->crypto_options.flags & CO_USE_CC_EXIT_NOTIFY);
+}
+
 /*
  * Handle the triggering and time-wait of explicit
  * exit notification.
  */
-
 static void
 process_explicit_exit_notification_init(struct context *c)
 {
     msg(M_INFO, "SIGTERM received, sending exit notification to peer");
     event_timeout_init(&c->c2.explicit_exit_notification_interval, 1, 0);
     reset_coarse_timers(c);
+
     signal_reset(c->sig);
     halt_non_edge_triggered_signals();
     c->c2.explicit_exit_notification_time_wait = now;
+
+    /* Check if we are in TLS mode and should send the notification via data
+     * channel */
+    if (cc_exit_notify_enabled(c))
+    {
+        send_control_channel_string(c, "EXIT", D_PUSH);
+    }
 }
 
 void
@@ -351,7 +374,7 @@ process_explicit_exit_notification_timer_wakeup(struct context *c)
             c->sig->signal_received = SIGTERM;
             c->sig->signal_text = "exit-with-notification";
         }
-        else
+        else if (!cc_exit_notify_enabled(c))
         {
             c->c2.occ_op = OCC_EXIT;
         }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 61dea996d..4506b7504 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1940,6 +1940,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         /* support for P_DATA_V2 */
         int iv_proto = IV_PROTO_DATA_V2;
 
+        /* support for exit notify via control channel */
+        iv_proto |= IV_PROTO_CC_EXIT_NOTIFY;
+
         /* support for receiving push_reply before sending
          * push request, also signal that the client wants
          * to get push-reply messages without without requiring a round
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 0ba86d3e6..1b8b736b9 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -93,6 +93,9 @@
  * result. */
 #define IV_PROTO_NCP_P2P         (1<<5)
 
+/** Support for explicit exit notify via control channel */
+#define IV_PROTO_CC_EXIT_NOTIFY  (1<<7)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
 
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 5d7e6dd38..4a083e247 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -419,6 +419,11 @@ p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session)
         multi->peer_id = 0x76706e; /* 'v' 'p' 'n' */
     }
 
+    if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
+    {
+        session->opt->crypto_flags |= CO_USE_CC_EXIT_NOTIFY;
+    }
+
 #if defined(HAVE_EXPORT_KEYING_MATERIAL)
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
-- 
2.32.0 (Apple Git-132)


