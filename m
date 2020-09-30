From: Arne Schwabe <arne@...1227...>
Date: Wed, 30 Sep 2020 15:13:11 +0200
Message-Id: <20200930131317.1299-7-arne@...1227...>
In-Reply-To: <20200930131317.1299-1-arne@...1227...>
References: <20200930131317.1299-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 05/11] Change parameter of
 send_auth_pending_messages from context to tls_multi
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

This prepares send_auth_pending_messages to be used a in context that
does not have context c available but also does not need to schedule
an immediate sending of the message (auth plugin/script)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 17 +++++++++--------
 src/openvpn/forward.h |  9 +++++++++
 src/openvpn/multi.c   |  4 +++-
 src/openvpn/push.c    |  9 ++++-----
 src/openvpn/push.h    |  4 +++-
 5 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7d559544..7c759a62 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -335,6 +335,14 @@ send_control_channel_string_dowork(struct tls_multi *multi,
     return stat;
 }
 
+void reschedule_multi_process(struct context *c)
+{
+
+    interval_action(&c->c2.tmp_int);
+    context_immediate_reschedule(c); /* ZERO-TIMEOUT */
+}
+
+
 bool
 send_control_channel_string(struct context *c, const char *str, int msglevel)
 {
@@ -342,15 +350,8 @@ send_control_channel_string(struct context *c, const char *str, int msglevel)
     {
         bool ret = send_control_channel_string_dowork(c->c2.tls_multi,
                                                       str, msglevel);
-        /*
-         * Reschedule tls_multi_process.
-         * NOTE: in multi-client mode, usually the below two statements are
-         * insufficient to reschedule the client instance object unless
-         * multi_schedule_context_wakeup(m, mi) is also called.
-         */
+        reschedule_multi_process(c);
 
-        interval_action(&c->c2.tmp_int);
-        context_immediate_reschedule(c); /* ZERO-TIMEOUT */
         return ret;
     }
     return true;
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index a8b19f69..4336db5a 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -317,6 +317,15 @@ bool
 send_control_channel_string_dowork(struct tls_multi *multi,
                                    const char *str, int msglevel);
 
+
+/**
+ * Reschedule tls_multi_process.
+ * NOTE: in multi-client mode, usually the below two statements are
+ * insufficient to reschedule the client instance object unless
+ * multi_schedule_context_wakeup(m, mi) is also called.
+ */
+void reschedule_multi_process(struct context *c);
+
 #define PIPV4_PASSTOS                   (1<<0)
 #define PIP_MSSFIX                      (1<<1)         /* v4 and v6 */
 #define PIP_OUTGOING                    (1<<2)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 50e2e350..e2454753 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3903,7 +3903,9 @@ management_client_pending_auth(void *arg,
     if (mi)
     {
         /* sends INFO_PRE and AUTH_PENDING messages to client */
-        bool ret = send_auth_pending_messages(&mi->context, extra, timeout);
+        bool ret = send_auth_pending_messages(mi->context.c2.tls_multi, extra,
+                                              timeout);
+        reschedule_multi_process(&mi->context);
         multi_schedule_context_wakeup(m, mi);
         return ret;
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 59f8f33c..58e20baa 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -367,14 +367,13 @@ send_auth_failed(struct context *c, const char *client_reason)
 
 
 bool
-send_auth_pending_messages(struct context *c, const char *extra,
+send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
                            unsigned int timeout)
 {
     struct key_state *ks = &tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
 
     static const char info_pre[] = "INFO_PRE,";
 
-    struct tls_multi *tls_multi = c->c2.tls_multi;
     const char *const peer_info = tls_multi->peer_info;
     unsigned int proto = extract_iv_proto(peer_info);
 
@@ -388,7 +387,7 @@ send_auth_pending_messages(struct context *c, const char *extra,
     struct gc_arena gc = gc_new();
     if ((proto & IV_PROTO_AUTH_PENDING_KW) == 0)
     {
-        send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
+        send_control_channel_string_dowork(tls_multi, "AUTH_PENDING", D_PUSH);
     }
     else
     {
@@ -399,7 +398,7 @@ send_auth_pending_messages(struct context *c, const char *extra,
         struct buffer buf = alloc_buf_gc(len, &gc);
         buf_printf(&buf, auth_pre);
         buf_printf(&buf, "%u", timeout);
-        send_control_channel_string(c, BSTR(&buf), D_PUSH);
+        send_control_channel_string_dowork(tls_multi, BSTR(&buf), D_PUSH);
     }
 
 
@@ -413,7 +412,7 @@ send_auth_pending_messages(struct context *c, const char *extra,
     struct buffer buf = alloc_buf_gc(len, &gc);
     buf_printf(&buf, info_pre);
     buf_printf(&buf, "%s", extra);
-    send_control_channel_string(c, BSTR(&buf), D_PUSH);
+    send_control_channel_string_dowork(tls_multi, BSTR(&buf), D_PUSH);
 
     ks->auth_deferred_expire = now + timeout;
 
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index a2192114..377f94a6 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -77,7 +77,9 @@ void send_auth_failed(struct context *c, const char *client_reason);
  * doc/management-notes.txt under client-pending-auth for
  * more details on message format
  */
-bool send_auth_pending_messages(struct context *c, const char *extra);
+bool
+send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
+                           unsigned int timeout);
 
 void send_restart(struct context *c, const char *kill_msg);
 
-- 
2.26.2


