From: Arne Schwabe <arne@...1227...>
Date: Wed, 30 Sep 2020 15:13:08 +0200
Message-Id: <20200930131317.1299-4-arne@...1227...>
In-Reply-To: <20200930131317.1299-1-arne@...1227...>
References: <20200930131317.1299-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 02/11] Implement client side handling of
 AUTH_PENDING message
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

This allows a client to extend the timeout of pull-request response
while waiting for the user to complete a pending authentication. A
timeout of 60s for a normal authentication might still works for a
simple 2FA (but still challenging). With a sophisticated (or overly
complicated) web based authentication 60s are quite short.

To avoid not detecting network problem in this phase, we use the
constant sending of PUSH_REQUEST/AUTH_PENDING as keepalive signal
and still timeout the session after the handshake window time.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/server-options.rst |  4 ++
 doc/management-notes.txt            | 39 ++++++++++++----
 src/openvpn/forward.c               | 11 ++++-
 src/openvpn/integer.h               | 25 ++++++++++
 src/openvpn/push.c                  | 72 ++++++++++++++++++++++++++++-
 src/openvpn/push.h                  |  9 ++++
 src/openvpn/ssl.c                   |  3 ++
 src/openvpn/ssl.h                   |  3 ++
 src/openvpn/ssl_common.h            |  1 +
 9 files changed, 156 insertions(+), 11 deletions(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 5a689452..271c54d0 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -473,6 +473,10 @@ fast hardware. SSL/TLS authentication must be used in this mode.
     - bit 1: The peer supports peer-id floating mechanism
     - bit 2: The client expects a push-reply and the server may
       send this reply without waiting for a push-request first.
+    - bit 3: The client is capable of doing key derivation using
+      RFC5705 key material exporter.
+    - bit 4: The client is capable of accepting additional arguments
+      to the `AUTH_PENDING` message.
 
   :code:`IV_NCP=2`
         Negotiable ciphers, client supports ``--cipher`` pushed by
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 61daaf07..99ba178a 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -600,14 +600,30 @@ to signal a pending authenticating to the client. A pending auth means
 that the connecting requires extra authentication like a one time
 password or doing a single sign one via web.
 
-    client-pending-auth {CID} {EXTRA}
-
-The server will send AUTH_PENDING and INFO_PRE,{EXTRA} to the client.
-The client is expected to inform the user that authentication is pending and
-display the extra information. For the format of EXTRA see below
-For the OpenVPN server this is stateless operation and needs to be
-followed by a client-deny/client-auth[-nt] command (that is the result of the
-out of band authentication).
+    client-pending-auth {CID} {EXTRA} {TIMEOUT}
+
+The server will send AUTH_PENDING and INFO_PRE,{EXTRA} to the client. If the
+client supports accepting keywords to AUTH_PENDING (announced via IV_PROTO),
+TIMEOUT parameter will be also be announced to the client to allow it to modify
+its own timeout. The client is expected to inform the user that authentication
+is pending and display the extra information and also show the user the
+remaining time to complete the auth if applicable.
+
+Receiving a AUTH_PENDING message will make the client change its timeout the
+timeout proposed by the server, even if the timeout is shorter.
+If the client does not receive a packet from the server for hand-window the
+connection times out regardless of the timeout. This ensures that the connection
+still times out relatively quickly in case of network problems. The client will
+continously send PULL_REQUEST messages to the server until the timeout is reached.
+This message also triggers an ACK message from the server that resets the
+hand-window based timeout.
+
+Both client and server limit the maximum timeout to the smaller value of half the
+--tls-reneg minimum time and --hand-window time (defaults to 60s).
+
+For the format of EXTRA see below. For the OpenVPN server this is a stateless
+operation and needs to be followed by a client-deny/client-auth[-nt] command
+(that is the result of the out of band authentication).
 
 Before issuing a client-pending-auth to a client instead of a
 client-auth/client-deny, the server should check the IV_SSO
@@ -620,7 +636,7 @@ set
     setenv IV_SSO openurl,crtext
 
 The variable name IV_SSO is historic as AUTH_PENDING was first used
-to signal single sign on support. To keep compatiblity with existing
+to signal single sign on support. To keep compatibility with existing
 implementations the name IV_SSO is kept in lieu of a better name.
 
 openurl
@@ -636,6 +652,11 @@ The space in a control message is limited, so this url should be kept
 short to avoid issues. If a loger url is required a URL that redirects
 to the longer URL should be sent instead.
 
+A complete documentation how URLs should be handled on the client is available
+in the openvpn3 repository:
+
+https://github.com/OpenVPN/openvpn3/blob/master/doc/webauth.md
+
 url_proxy
 ========
 To avoid issues with OpenVPN connection persist-tun and not able
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 325f1373..7d559544 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -233,6 +233,10 @@ check_incoming_control_channel(struct context *c)
         {
             receive_cr_response(c, &buf);
         }
+        else if (buf_string_match_head_str(&buf, "AUTH_PENDING"))
+        {
+            receive_auth_pending(c, &buf);
+        }
         else
         {
             msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", BSTR(&buf));
@@ -292,7 +296,12 @@ check_connection_established(struct context *c)
             }
 #endif
             /* fire up push request right away (already 1s delayed) */
-            c->c2.push_request_timeout = now + c->options.handshake_window;
+            /* We might receive a AUTH_PENDING request before we armed this
+             * timer. In that case we don't change the value */
+            if (c->c2.push_request_timeout < now)
+            {
+                c->c2.push_request_timeout = now + c->options.handshake_window;
+            }
             event_timeout_init(&c->c2.push_request_interval, 0, now);
             reset_coarse_timers(c);
         }
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 3755f43f..0c3511e6 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -39,6 +39,31 @@
 /*
  * min/max functions
  */
+static inline unsigned int
+max_uint(unsigned int x, unsigned int y)
+{
+    if (x > y)
+    {
+        return x;
+    }
+    else
+    {
+        return y;
+    }
+}
+
+static inline unsigned int
+min_uint(unsigned int x, unsigned int y)
+{
+    if (x < y)
+    {
+        return x;
+    }
+    else
+    {
+        return y;
+    }
+}
 
 static inline int
 max_int(int x, int y)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 5fc3eb18..44633dc6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -231,6 +231,66 @@ receive_cr_response(struct context *c, const struct buffer *buffer)
     msg(D_PUSH, "CR response was sent by client ('%s')", m);
 }
 
+/**
+ * Parse the keyword for the AUTH_PENDING request
+ * @param buffer                buffer containing the keywords, the buffer's
+ *                              content will be modified by this function
+ * @param server_timeout        timeout pushed by the server or unchanged
+ *                              if the server does not push a timeout
+ */
+static void
+parse_auth_pending_keywords(const struct buffer *buffer,
+                            unsigned int *server_timeout)
+{
+    struct buffer buf = *buffer;
+
+    /* does the buffer start with "AUTH_PENDING," ? */
+    if (!buf_advance(&buf, strlen("AUTH_PENDING"))
+        || !(buf_read_u8(&buf) == ',') || !BLEN(&buf))
+    {
+        return;
+    }
+
+    /* parse the keywords in the same way that push options are parsed */
+    char line[OPTION_LINE_SIZE];
+
+    while (buf_parse(&buf, ',', line, sizeof(line)))
+    {
+        if (sscanf(line, "timeout %u", server_timeout) == 1)
+        {
+            ;
+        }
+        else
+        {
+            msg(D_PUSH, "ignoring AUTH_PENDING parameter: %s", line);
+        }
+    }
+}
+
+void
+receive_auth_pending(struct context *c, const struct buffer *buffer)
+{
+    if (!c->options.pull)
+        return;
+
+    /* Cap the increase at the maximum time we are willing stay in the
+     * pending authentication state */
+    unsigned int max_timeout = max_uint(c->options.renegotiate_seconds/2,
+                               c->options.handshake_window);
+
+    /* try to parse parameter keywords, default to hand-winow timeout if the
+     * server does not supply a timeout */
+    unsigned int server_timeout = c->options.handshake_window;
+    parse_auth_pending_keywords(buffer, &server_timeout);
+
+    msg(D_PUSH, "AUTH_PENDING received, extending handshake timeout from %us "
+                "to %us", c->options.handshake_window,
+                min_uint(max_timeout, server_timeout));
+
+    struct key_state *ks = &c->c2.tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
+    c->c2.push_request_timeout = ks->established + min_uint(max_timeout, server_timeout);
+}
+
 /**
  * Add an option to the given push list by providing a format string.
  *
@@ -372,7 +432,17 @@ send_push_request(struct context *c)
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
     struct key_state *ks = &session->key[KS_PRIMARY];
 
-    if (c->c2.push_request_timeout > now)
+    /* We timeout here under two conditions:
+     * a) we reached the hard limit of push_request_timeout
+     * b) we have not seen anything from the server in hand_window time
+     *
+     * for non auth-pending scenario, push_request_timeout is the same as
+     * hand_window timeout. For b) every PUSH_REQUEST is a acknowledged by
+     * the server by a P_ACK_V1 packet that reset the keepalive timer
+     */
+
+    if (c->c2.push_request_timeout > now
+        && (now - ks->peer_last_packet) < c->options.handshake_window)
     {
         return send_control_channel_string(c, "PUSH_REQUEST", D_PUSH);
     }
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 2faf19a6..01847671 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -89,5 +89,14 @@ void send_restart(struct context *c, const char *kill_msg);
  */
 void send_push_reply_auth_token(struct tls_multi *multi);
 
+/**
+ * Parses an AUTH_PENDING message and if in pull mode extends the timeout
+ *
+ * @param c             The context struct
+ * @param buffer        Buffer containing the control message with AUTH_PENDING
+ */
+void
+receive_auth_pending(struct context *c, const struct buffer *buffer);
+
 #endif /* if P2MP */
 #endif /* ifndef PUSH_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3fcaa25f..c019c194 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2218,6 +2218,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         if(session->opt->pull)
         {
             iv_proto |= IV_PROTO_REQUEST_PUSH;
+            iv_proto |= IV_PROTO_AUTH_PENDING_KW;
         }
 
         buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
@@ -3669,6 +3670,8 @@ tls_pre_decrypt(struct tls_multi *multi,
             }
         }
     }
+    /* Remember that we received a valid control channel packet */
+    ks->peer_last_packet = now;
 
 done:
     buf->len = 0;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 005628f6..cce61354 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -117,6 +117,9 @@
 #define IV_PROTO_REQUEST_PUSH   (1<<2)
 
 
+/** Supports signaling keywords with AUTH_PENDING, e.g. timeout=xy */
+#define IV_PROTO_AUTH_PENDING_KW (1<<4)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 96897e48..d0a2c89b 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -178,6 +178,7 @@ struct key_state
     time_t established;         /* when our state went S_ACTIVE */
     time_t must_negotiate;      /* key negotiation times out if not finished before this time */
     time_t must_die;            /* this object is destroyed at this time */
+    time_t peer_last_packet;    /* Last time we received a paket in this control session */
 
     int initial_opcode;         /* our initial P_ opcode */
     struct session_id session_id_remote; /* peer's random session ID */
-- 
2.26.2


