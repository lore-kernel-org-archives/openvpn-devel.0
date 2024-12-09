From: Gert Doering <gert@...1296...>
Date: Mon,  9 Dec 2024 22:09:56 +0100
Message-ID: <20241209210956.13536-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] Use XOR instead of concatenation for
 calculation of IV from implicit IV
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

This change prepares the extended packet id data where also the packet id
part of the IV will be derived using xor.  Using xor also in the AEAD
case where this degenerates to a concatenation allows using the same
IV generation code later.

Change-Id: I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/797
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 67c5b04..d6cd256 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -94,12 +94,16 @@
             goto err;
         }
 
-        /* Remainder of IV consists of implicit part (unique per session) */
-        ASSERT(buf_write(&iv_buffer, ctx->implicit_iv, ctx->implicit_iv_len));
-        ASSERT(iv_buffer.len == iv_len);
+        /* Write packet id part of IV to work buffer */
+        ASSERT(buf_write(&work, iv, packet_id_size(false)));
 
-        /* Write explicit part of IV to work buffer */
-        ASSERT(buf_write(&work, iv, iv_len - ctx->implicit_iv_len));
+        /* This generates the IV by XORing the implicit part of the IV
+         * with the packet id already written to the iv buffer */
+        for (int i = 0; i < iv_len; i++)
+        {
+            iv[i] = iv[i] ^ ctx->implicit_iv[i];
+        }
+
         dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv, iv_len, 0, &gc));
 
         /* Init cipher_ctx with IV.  key & keylen are already initialized */
@@ -426,16 +430,21 @@
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] = { 0 };
         const int iv_len = cipher_ctx_iv_length(ctx->cipher);
-        const size_t packet_iv_len = iv_len - ctx->implicit_iv_len;
+        const size_t packet_iv_len = packet_id_size(false);
 
-        ASSERT(ctx->implicit_iv_len <= iv_len);
-        if (buf->len + ctx->implicit_iv_len < iv_len)
+        if (buf->len < packet_iv_len)
         {
             CRYPT_ERROR("missing IV info");
         }
 
         memcpy(iv, BPTR(buf), packet_iv_len);
-        memcpy(iv + packet_iv_len, ctx->implicit_iv, ctx->implicit_iv_len);
+
+        /* This generates the IV by XORing the implicit part of the IV
+         * with the packet id already written to the iv buffer */
+        for (int i = 0; i < iv_len; i++)
+        {
+            iv[i] = iv[i] ^ ctx->implicit_iv[i];
+        }
 
         dmsg(D_PACKET_CONTENT, "DECRYPT IV: %s", format_hex(iv, iv_len, 0, &gc));
 
@@ -962,7 +971,6 @@
         hmac_ctx_free(ctx->hmac);
         ctx->hmac = NULL;
     }
-    ctx->implicit_iv_len = 0;
 }
 
 void
@@ -1078,18 +1086,15 @@
         cipher_ctx_t *cipher = co->key_ctx_bi.encrypt.cipher;
         if (cipher_ctx_mode_aead(cipher))
         {
-            size_t impl_iv_len = cipher_ctx_iv_length(cipher) - sizeof(packet_id_type);
             ASSERT(cipher_ctx_iv_length(cipher) <= OPENVPN_MAX_IV_LENGTH);
             ASSERT(cipher_ctx_iv_length(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
 
             /* Generate dummy implicit IV */
             ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
                               OPENVPN_MAX_IV_LENGTH));
-            co->key_ctx_bi.encrypt.implicit_iv_len = impl_iv_len;
 
             memcpy(co->key_ctx_bi.decrypt.implicit_iv,
                    co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
-            co->key_ctx_bi.decrypt.implicit_iv_len = impl_iv_len;
         }
     }
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 7d32353..531664d 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -163,6 +163,17 @@
 {
     cipher_ctx_t *cipher;       /**< Generic cipher %context. */
     hmac_ctx_t *hmac;           /**< Generic HMAC %context. */
+    /**
+     * This implicit IV will be always XORed with the packet id that is sent on
+     * the wire to get the IV. For the common AEAD ciphers of AES-GCM and
+     * Chacha20-Poly1305, the length of the IV is 12 bytes (96 bits).
+     *
+     * For non-epoch 32bit packet id AEAD format we set the first 32
+     * bits of implicit_iv to 0.
+     * Xor with the packet id in this case works as concatenation:
+     * after xor the lower 32 bit of the IV are the packet id and
+     * the rest of the IV is from the implicit IV.
+     */
     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
     /**< The implicit part of the IV */
     size_t implicit_iv_len;     /**< The length of implicit_iv */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 2acf985..05079cc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1562,8 +1562,9 @@
         impl_iv_len = cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_id_type);
         ASSERT(impl_iv_len <= OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <= key_len);
-        memcpy(ctx->implicit_iv, key, impl_iv_len);
-        ctx->implicit_iv_len = impl_iv_len;
+        CLEAR(ctx->implicit_iv);
+        /* The first bytes of the IV are filled with the packet id */
+        memcpy(ctx->implicit_iv + sizeof(packet_id_type), key, impl_iv_len);
     }
 }
 
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index a1ca344..ae33cc6 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -284,18 +284,15 @@
 
     if (cipher_ctx_mode_aead(cipher))
     {
-        size_t impl_iv_len = cipher_ctx_iv_length(cipher) - sizeof(packet_id_type);
         ASSERT(cipher_ctx_iv_length(cipher) <= OPENVPN_MAX_IV_LENGTH);
         ASSERT(cipher_ctx_iv_length(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
 
         /* Generate dummy implicit IV */
         ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
                           OPENVPN_MAX_IV_LENGTH));
-        co->key_ctx_bi.encrypt.implicit_iv_len = impl_iv_len;
 
         memcpy(co->key_ctx_bi.decrypt.implicit_iv,
                co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
-        co->key_ctx_bi.decrypt.implicit_iv_len = impl_iv_len;
     }
 }
 

