From: Arne Schwabe <arne@...1227...>
Date: Wed, 10 Mar 2021 11:28:23 +0100
Message-Id: <20210310102823.29508-1-arne@...1227...>
In-Reply-To: <20210201150340.19305-1-arne@...1227...>
References: <20210201150340.19305-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4] Change parameter of
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

Patch V2: Adjust the comment of reschedule_multi_process to actually fit a
          function.

Patch V3: Rebase needed because v3 of 3/11

Patch V4: Send with push.h prototype

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 17 +++++++++--------
 src/openvpn/forward.h |  9 +++++++++
 src/openvpn/multi.c   |  4 +++-
 src/openvpn/push.c    |  9 ++++-----
 src/openvpn/push.h    |  2 +-
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8296900e..828abb25 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -342,6 +342,14 @@ send_control_channel_string_dowork(struct tls_multi *multi,
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
@@ -349,15 +357,8 @@ send_control_channel_string(struct context *c, const char *str, int msglevel)
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
index a8b19f69..9ce3bc1c 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -317,6 +317,15 @@ bool
 send_control_channel_string_dowork(struct tls_multi *multi,
                                    const char *str, int msglevel);
 
+
+/**
+ * Reschedule tls_multi_process.
+ * NOTE: in multi-client mode, usually calling the function is
+ * insufficient to reschedule the client instance object unless
+ * multi_schedule_context_wakeup(m, mi) is also called.
+ */
+void reschedule_multi_process(struct context *c);
+
 #define PIPV4_PASSTOS                   (1<<0)
 #define PIP_MSSFIX                      (1<<1)         /* v4 and v6 */
 #define PIP_OUTGOING                    (1<<2)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ac5d3f5b..d10f188c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3904,7 +3904,9 @@ management_client_pending_auth(void *arg,
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
index 46267835..320ad737 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -363,10 +363,9 @@ send_auth_failed(struct context *c, const char *client_reason)
 
 
 bool
-send_auth_pending_messages(struct context *c, const char *extra,
+send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
                            unsigned int timeout)
 {
-    struct tls_multi *tls_multi = c->c2.tls_multi;
     struct key_state *ks = &tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
 
     static const char info_pre[] = "INFO_PRE,";
@@ -384,7 +383,7 @@ send_auth_pending_messages(struct context *c, const char *extra,
     struct gc_arena gc = gc_new();
     if ((proto & IV_PROTO_AUTH_PENDING_KW) == 0)
     {
-        send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
+        send_control_channel_string_dowork(tls_multi, "AUTH_PENDING", D_PUSH);
     }
     else
     {
@@ -395,7 +394,7 @@ send_auth_pending_messages(struct context *c, const char *extra,
         struct buffer buf = alloc_buf_gc(len, &gc);
         buf_printf(&buf, auth_pre);
         buf_printf(&buf, "%u", timeout);
-        send_control_channel_string(c, BSTR(&buf), D_PUSH);
+        send_control_channel_string_dowork(tls_multi, BSTR(&buf), D_PUSH);
     }
 
     size_t len = strlen(extra) + 1 + sizeof(info_pre);
@@ -408,7 +407,7 @@ send_auth_pending_messages(struct context *c, const char *extra,
     struct buffer buf = alloc_buf_gc(len, &gc);
     buf_printf(&buf, info_pre);
     buf_printf(&buf, "%s", extra);
-    send_control_channel_string(c, BSTR(&buf), D_PUSH);
+    send_control_channel_string_dowork(tls_multi, BSTR(&buf), D_PUSH);
 
     ks->auth_deferred_expire = now + timeout;
 
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index e7271de2..377f94a6 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -78,7 +78,7 @@ void send_auth_failed(struct context *c, const char *client_reason);
  * more details on message format
  */
 bool
-send_auth_pending_messages(struct context *c, const char *extra,
+send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
                            unsigned int timeout);
 
 void send_restart(struct context *c, const char *kill_msg);
-- 
2.30.1


