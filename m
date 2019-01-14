From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Jan 2019 16:48:16 +0100
Message-Id: <20190114154819.6064-3-arne@...1227...>
In-Reply-To: <20190114154819.6064-1-arne@...1227...>
References: <20190114154819.6064-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/6] Add send_control_channel_string_dowork
 variant
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
Cc: Arne Schwabe <arne@...515...>

From: Arne Schwabe <arne@...515...>

The send_control_channel_string_dowork variant does not schedule
the sending of the actual and can be used where struct context is not
available.
---
 src/openvpn/forward.c | 43 +++++++++++++++++++++++--------------------
 src/openvpn/forward.h | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0a90fff0..4076f647 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -464,42 +464,45 @@ check_connection_established_dowork(struct context *c)
     }
 }
 
-/*
- * Send a string to remote over the TLS control channel.
- * Used for push/pull messages, passing username/password,
- * etc.
- */
+bool
+send_control_channel_string_dowork(struct tls_multi *multi,
+                                   const char *str, int msglevel)
+{
+    struct gc_arena gc = gc_new();
+    bool stat;
+
+    /* buffered cleartext write onto TLS control channel */
+    stat = tls_send_payload(multi, (uint8_t *) str, strlen(str) + 1);
+
+    msg(msglevel, "SENT CONTROL [%s]: '%s' (status=%d)",
+        tls_common_name(multi, false),
+        sanitize_control_message(str, &gc),
+        (int) stat);
+
+    gc_free(&gc);
+    return stat;
+}
+
 bool
 send_control_channel_string(struct context *c, const char *str, int msglevel)
 {
     if (c->c2.tls_multi)
     {
-        struct gc_arena gc = gc_new();
-        bool stat;
-
-        /* buffered cleartext write onto TLS control channel */
-        stat = tls_send_payload(c->c2.tls_multi, (uint8_t *) str, strlen(str) + 1);
-
+        bool ret = send_control_channel_string_dowork(c->c2.tls_multi,
+                                                      str, msglevel);
         /*
          * Reschedule tls_multi_process.
          * NOTE: in multi-client mode, usually the below two statements are
          * insufficient to reschedule the client instance object unless
          * multi_schedule_context_wakeup(m, mi) is also called.
          */
+
         interval_action(&c->c2.tmp_int);
         context_immediate_reschedule(c); /* ZERO-TIMEOUT */
-
-        msg(msglevel, "SENT CONTROL [%s]: '%s' (status=%d)",
-            tls_common_name(c->c2.tls_multi, false),
-            sanitize_control_message(str, &gc),
-            (int) stat);
-
-        gc_free(&gc);
-        return stat;
+        return ret;
     }
     return true;
 }
-
 /*
  * Add routes.
  */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index f97b0e2e..48202c07 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -286,7 +286,36 @@ void process_outgoing_tun(struct context *c);
 
 /**************************************************************************/
 
-bool send_control_channel_string(struct context *c, const char *str, int msglevel);
+/*
+ * Send a string to remote over the TLS control channel.
+ * Used for push/pull messages, passing username/password,
+ * etc.
+ * @param c          - The context structure of the VPN tunnel associated with
+ *                     the packet.
+ * @param str        - The message to be sent
+ * @param msglevel   - Message level to use for logging
+ */
+bool
+send_control_channel_string(struct context *c, const char *str, int msglevel);
+
+/*
+ * Send a string to remote over the TLS control channel.
+ * Used for push/pull messages, passing username/password,
+ * etc.
+ *
+ * This variant does not schedule the actual sending of the message
+ * The caller needs to ensure that it is scheduled or call
+ * send_control_channel_string
+ *
+ * @param multi      - The tls_multi structure of the VPN tunnel associated
+ *                     with the packet.
+ * @param str        - The message to be sent
+ * @param msglevel   - Message level to use for logging
+ */
+
+bool
+send_control_channel_string_dowork(struct tls_multi *multi,
+                                   const char *str, int msglevel);
 
 #define PIPV4_PASSTOS                   (1<<0)
 #define PIP_MSSFIX                      (1<<1)         /* v4 and v6 */
-- 
2.19.2


