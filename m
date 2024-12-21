From: Gert Doering <gert@...1296...>
Date: Sat, 21 Dec 2024 23:39:05 +0100
Message-ID: <20241221223905.18820-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.If9e029bdac264dcc05b2d256c4d323315904a92b@...2715...>
References: <gerrit.1731290343000.If9e029bdac264dcc05b2d256c4d323315904a92b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] Split init_key_ctx_bi into send/recv init
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

From: Arne Schwabe <arne@...1227...>

This allows for only initialising one of the keys. This is needed
for epoch keys where key rotation of send/recv key can happen at
different time points.

Change-Id: If9e029bdac264dcc05b2d256c4d323315904a92b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/799
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 88a9f24..53f50de 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -947,8 +947,8 @@
 }
 
 void
-init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,
-                int key_direction, const struct key_type *kt, const char *name)
+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,
+                     int key_direction, const struct key_type *kt, const char *name)
 {
     char log_prefix[128] = { 0 };
     struct key_direction_state kds;
@@ -956,13 +956,32 @@
     key_direction_state_init(&kds, key_direction);
 
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
-    init_key_ctx(&ctx->encrypt, &key2->keys[kds.out_key], kt,
+    init_key_ctx(ctx, &key2->keys[kds.out_key], kt,
                  OPENVPN_OP_ENCRYPT, log_prefix);
 
+}
+
+void
+init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,
+                     int key_direction, const struct key_type *kt, const char *name)
+{
+    char log_prefix[128] = { 0 };
+    struct key_direction_state kds;
+
+    key_direction_state_init(&kds, key_direction);
+
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
-    init_key_ctx(&ctx->decrypt, &key2->keys[kds.in_key], kt,
+    init_key_ctx(ctx, &key2->keys[kds.in_key], kt,
                  OPENVPN_OP_DECRYPT, log_prefix);
 
+}
+
+void
+init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,
+                int key_direction, const struct key_type *kt, const char *name)
+{
+    init_key_bi_ctx_send(&ctx->encrypt, key2, key_direction, kt, name);
+    init_key_bi_ctx_recv(&ctx->decrypt, key2, key_direction, kt, name);
     ctx->initialized = true;
 }
 
@@ -980,6 +999,8 @@
         hmac_ctx_free(ctx->hmac);
         ctx->hmac = NULL;
     }
+    CLEAR(ctx->implicit_iv);
+    ctx->plaintext_blocks = 0;
 }
 
 void
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index bb417e1..648b2c8 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -198,7 +198,9 @@
     int n;                      /**< The number of \c key objects stored
                                  *   in the \c key2.keys array. */
     struct key keys[2];         /**< Two unidirectional sets of %key
-                                 *   material. */
+                                 *   material. The first key is the client
+                                 *   (encrypts) to server (decrypts), the
+                                 *   second the server to client key. */
 };
 
 /**
@@ -351,6 +353,16 @@
                   const struct key_type *kt, int enc,
                   const char *prefix);
 
+void
+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,
+                     int key_direction, const struct key_type *kt,
+                     const char *name);
+
+void
+init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,
+                     int key_direction, const struct key_type *kt,
+                     const char *name);
+
 void free_key_ctx(struct key_ctx *ctx);
 
 void init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,

