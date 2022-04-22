From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:36 +0200
Message-Id: <20220422142953.3805364-2-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 11/28] Refactor tls-auth/tls-crypt wrapping
 into into own function
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

This allows the the wrapping to be easier reused by a function that
does not have access to a full TLS session.
---
 src/openvpn/ssl_pkt.c | 82 ++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index e8cc7dee9..86c1f0e29 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -110,51 +110,48 @@ swap_hmac(struct buffer *buf, const struct crypto_options *co, bool incoming)
 
 #undef SWAP_BUF_SIZE
 
-void
-write_control_auth(struct tls_session *session,
-                   struct key_state *ks,
-                   struct buffer *buf,
-                   struct link_socket_actual **to_link_addr,
-                   int opcode,
-                   int max_ack,
-                   bool prepend_ack)
+/**
+ * Wraps a TLS control packet by adding tls-auth HMAC or tls-crypt(-v2)
+ * encryption and opcode header including session id.
+ *
+ * @param ctx           tls wrapping context
+ * @param header        first byte of the packet (opcode and key id)
+ * @param buf           buffer to write the resulting packet to
+ * @param session_id    session id to use as our session id
+ */
+static void
+tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
+                 struct session_id *session_id)
 {
-    uint8_t header = ks->key_id | (opcode << P_OPCODE_SHIFT);
-    struct buffer null = clear_buf();
-
-    ASSERT(link_socket_actual_defined(&ks->remote_addr));
-    ASSERT(reliable_ack_write
-               (ks->rec_ack, buf, &ks->session_id_remote, max_ack, prepend_ack));
-
-    msg(D_TLS_DEBUG, "%s(): %s", __func__, packet_opcode_name(opcode));
-
-    if (session->tls_wrap.mode == TLS_WRAP_AUTH
-        || session->tls_wrap.mode == TLS_WRAP_NONE)
+    if (ctx->mode == TLS_WRAP_AUTH
+        || ctx->mode == TLS_WRAP_NONE)
     {
-        ASSERT(session_id_write_prepend(&session->session_id, buf));
+        ASSERT(session_id_write_prepend(session_id, buf));
         ASSERT(buf_write_prepend(buf, &header, sizeof(header)));
     }
-    if (session->tls_wrap.mode == TLS_WRAP_AUTH)
+    if (ctx->mode == TLS_WRAP_AUTH)
     {
+        struct buffer null = clear_buf();
+
         /* no encryption, only write hmac */
-        openvpn_encrypt(buf, null, &session->tls_wrap.opt);
-        ASSERT(swap_hmac(buf, &session->tls_wrap.opt, false));
+        openvpn_encrypt(buf, null, &ctx->opt);
+        ASSERT(swap_hmac(buf, &ctx->opt, false));
     }
-    else if (session->tls_wrap.mode == TLS_WRAP_CRYPT)
+    else if (ctx->mode == TLS_WRAP_CRYPT)
     {
-        ASSERT(buf_init(&session->tls_wrap.work, buf->offset));
-        ASSERT(buf_write(&session->tls_wrap.work, &header, sizeof(header)));
-        ASSERT(session_id_write(&session->session_id, &session->tls_wrap.work));
-        if (!tls_crypt_wrap(buf, &session->tls_wrap.work, &session->tls_wrap.opt))
+        ASSERT(buf_init(&ctx->work, buf->offset));
+        ASSERT(buf_write(&ctx->work, &header, sizeof(header)));
+        ASSERT(session_id_write(session_id, &ctx->work));
+        if (!tls_crypt_wrap(buf, &ctx->work, &ctx->opt))
         {
             buf->len = 0;
             return;
         }
 
-        if (opcode == P_CONTROL_HARD_RESET_CLIENT_V3)
+        if ((header >> P_OPCODE_SHIFT) == P_CONTROL_HARD_RESET_CLIENT_V3)
         {
-            if (!buf_copy(&session->tls_wrap.work,
-                          session->tls_wrap.tls_crypt_v2_wkc))
+            if (!buf_copy(&ctx->work,
+                          ctx->tls_crypt_v2_wkc))
             {
                 msg(D_TLS_ERRORS, "Could not append tls-crypt-v2 client key");
                 buf->len = 0;
@@ -164,8 +161,29 @@ write_control_auth(struct tls_session *session,
 
         /* Don't change the original data in buf, it's used by the reliability
          * layer to resend on failure. */
-        *buf = session->tls_wrap.work;
+        *buf = ctx->work;
     }
+}
+
+void
+write_control_auth(struct tls_session *session,
+                   struct key_state *ks,
+                   struct buffer *buf,
+                   struct link_socket_actual **to_link_addr,
+                   int opcode,
+                   int max_ack,
+                   bool prepend_ack)
+{
+    uint8_t header = ks->key_id | (opcode << P_OPCODE_SHIFT);
+
+    ASSERT(link_socket_actual_defined(&ks->remote_addr));
+    ASSERT(reliable_ack_write
+               (ks->rec_ack, buf, &ks->session_id_remote, max_ack, prepend_ack));
+
+    msg(D_TLS_DEBUG, "%s(): %s", __func__, packet_opcode_name(opcode));
+
+    tls_wrap_control(&session->tls_wrap, header, buf, &session->session_id);
+
     *to_link_addr = &ks->remote_addr;
 }
 
-- 
2.32.0 (Apple Git-132)


