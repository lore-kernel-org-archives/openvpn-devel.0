From: Gert Doering <gert@...1296...>
Date: Sun, 22 Dec 2024 22:45:41 +0100
Message-ID: <20241222214541.11021-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.Id223612c7bcab91d49c013fb775024bd64ab0836@...2715...>
References: <gerrit.1731290343000.Id223612c7bcab91d49c013fb775024bd64ab0836@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] Move initialisation of implicit IVs to
 init_key_ctx_bi methods
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

This is really more a function of initialising the data cipher and key
context and putting it into the init_key_ctx_bi makes more sense.

It will allow calling init_key_ctx_bi to fully initialise a
data channel key without calling some extra functions after that
which will make the (upcoming) epoch key implementation cleaner.

Also ensure that free_ctx_bi actually also sets initialized to false.

Change-Id: Id223612c7bcab91d49c013fb775024bd64ab0836
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/800
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 53f50de..67c4d3b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -900,6 +900,33 @@
     }
 }
 
+/**
+ * Update the implicit IV for a key_ctx_bi based on TLS session ids and cipher
+ * used.
+ *
+ * Note that the implicit IV is based on the HMAC key, but only in AEAD modes
+ * where the HMAC key is not used for an actual HMAC.
+ *
+ * @param ctx                   Encrypt/decrypt key context
+ * @param key                   key, hmac part used to calculate implicit IV
+ */
+static void
+key_ctx_update_implicit_iv(struct key_ctx *ctx, const struct key *key)
+{
+    /* Only use implicit IV in AEAD cipher mode, where HMAC key is not used */
+    if (cipher_ctx_mode_aead(ctx->cipher))
+    {
+        size_t impl_iv_len = 0;
+        ASSERT(cipher_ctx_iv_length(ctx->cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
+        impl_iv_len = cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_id_type);
+        ASSERT(impl_iv_len + sizeof(packet_id_type) <= OPENVPN_MAX_IV_LENGTH);
+        ASSERT(impl_iv_len <= MAX_HMAC_KEY_LENGTH);
+        CLEAR(ctx->implicit_iv);
+        /* The first bytes of the IV are filled with the packet id */
+        memcpy(ctx->implicit_iv + sizeof(packet_id_type), key->hmac, impl_iv_len);
+    }
+}
+
 /* given a key and key_type, build a key_ctx */
 void
 init_key_ctx(struct key_ctx *ctx, const struct key *key,
@@ -958,7 +985,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, &key2->keys[kds.out_key], kt,
                  OPENVPN_OP_ENCRYPT, log_prefix);
-
+    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.out_key]);
 }
 
 void
@@ -973,7 +1000,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(ctx, &key2->keys[kds.in_key], kt,
                  OPENVPN_OP_DECRYPT, log_prefix);
-
+    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.in_key]);
 }
 
 void
@@ -1008,6 +1035,7 @@
 {
     free_key_ctx(&ctx->encrypt);
     free_key_ctx(&ctx->decrypt);
+    ctx->initialized = false;
 }
 
 static bool
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 73201ef..5adc6b1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -96,21 +96,6 @@
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */
 
 /**
- * Update the implicit IV for a key_ctx_bi based on TLS session ids and cipher
- * used.
- *
- * Note that the implicit IV is based on the HMAC key, but only in AEAD modes
- * where the HMAC key is not used for an actual HMAC.
- *
- * @param ctx                   Encrypt/decrypt key context
- * @param key                   HMAC key, used to calculate implicit IV
- * @param key_len               HMAC key length
- */
-static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len);
-
-
-/**
  * Limit the reneg_bytes value when using a small-block (<128 bytes) cipher.
  *
  * @param cipher        The current cipher (may be NULL).
@@ -1411,12 +1396,6 @@
     else
     {
         init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
-        /* Initialize implicit IVs */
-        key_ctx_update_implicit_iv(&key->encrypt, key2->keys[(int)server].hmac,
-                                   MAX_HMAC_KEY_LENGTH);
-        key_ctx_update_implicit_iv(&key->decrypt,
-                                   key2->keys[1 - (int)server].hmac,
-                                   MAX_HMAC_KEY_LENGTH);
     }
 }
 
@@ -1553,23 +1532,6 @@
     return ret;
 }
 
-static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)
-{
-    /* Only use implicit IV in AEAD cipher mode, where HMAC key is not used */
-    if (cipher_ctx_mode_aead(ctx->cipher))
-    {
-        size_t impl_iv_len = 0;
-        ASSERT(cipher_ctx_iv_length(ctx->cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
-        impl_iv_len = cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_id_type);
-        ASSERT(impl_iv_len + sizeof(packet_id_type) <= OPENVPN_MAX_IV_LENGTH);
-        ASSERT(impl_iv_len <= key_len);
-        CLEAR(ctx->implicit_iv);
-        /* The first bytes of the IV are filled with the packet id */
-        memcpy(ctx->implicit_iv + sizeof(packet_id_type), key, impl_iv_len);
-    }
-}
-
 /**
  * Generate data channel keys for the supplied TLS session.
  *
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index ae33cc6..caacd9e 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -277,24 +277,6 @@
 #endif /* HAVE_OPENSSL_STORE */
 }
 
-static void
-init_implicit_iv(struct crypto_options *co)
-{
-    cipher_ctx_t *cipher = co->key_ctx_bi.encrypt.cipher;
-
-    if (cipher_ctx_mode_aead(cipher))
-    {
-        ASSERT(cipher_ctx_iv_length(cipher) <= OPENVPN_MAX_IV_LENGTH);
-        ASSERT(cipher_ctx_iv_length(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
-
-        /* Generate dummy implicit IV */
-        ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
-                          OPENVPN_MAX_IV_LENGTH));
-
-        memcpy(co->key_ctx_bi.decrypt.implicit_iv,
-               co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
-    }
-}
 
 static void
 init_frame_parameters(struct frame *frame)
@@ -346,7 +328,6 @@
     /* init work */
     ASSERT(buf_init(&work, frame.buf.headroom));
 
-    init_implicit_iv(co);
     update_time();
 
     /* Test encryption, decryption for all packet sizes */

