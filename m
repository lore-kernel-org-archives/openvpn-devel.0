From: Gert Doering <gert@...1296...>
Date: Thu,  9 Jan 2025 18:49:28 +0100
Message-ID: <20250109174928.17862-1-gert@...1296...>
In-Reply-To: <gerrit.1734706182000.I81440ac28a1ad553652e201234e5ddfe03a8c190@...2715...>
References: <gerrit.1734706182000.I81440ac28a1ad553652e201234e5ddfe03a8c190@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Do not attempt to decrypt packets
 anymore after 2**36 failed decryptions
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

To avoid attacks (especially on Chacha20-Poly1305) we do not allow
decryption anymore after 2**36 failed verifications.

Change-Id: I81440ac28a1ad553652e201234e5ddfe03a8c190
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/843
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index df38cdd..ee9b0c6 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -405,7 +405,13 @@
 {
     static const char error_prefix[] = "AEAD Decrypt error";
     struct packet_id_net pin = { 0 };
-    const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
+    struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
+
+    if (cipher_decrypt_verify_fail_exceeded(ctx))
+    {
+        CRYPT_DROP("Decryption failed verification limit reached.");
+    }
+
     int outlen;
     struct gc_arena gc;
 
@@ -511,6 +517,7 @@
     if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen,
                                     &outlen, tag_ptr, tag_size))
     {
+        ctx->failed_verifications++;
         CRYPT_DROP("packet tag authentication failed");
     }
     ASSERT(buf_inc_len(&work, outlen));
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 3ad31c5..fe81c7f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -209,6 +209,8 @@
      * with the current key in number of 128 bit blocks (only used for
      * AEAD ciphers) */
     uint64_t plaintext_blocks;
+    /** number of failed verification using this cipher */
+    uint64_t failed_verifications;
 };
 
 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -661,6 +663,32 @@
 cipher_get_aead_limits(const char *ciphername);
 
 /**
+ * Check if the number of failed decryption is over the acceptable limit.
+ */
+static inline bool
+cipher_decrypt_verify_fail_exceeded(const struct key_ctx *ctx)
+{
+    /* Use 2**36, same as DTLS 1.3. Strictly speaking this only guarantees
+     * the security margin for packets up to 2^10 blocks (16384 bytes)
+     * but we accept slightly lower security bound for the edge
+     * of Chacha20-Poly1305 and packets over 16k as MTUs over 16k are
+     * extremely rarely used */
+    return ctx->failed_verifications >  (1ull << 36);
+}
+
+/**
+ * Check if the number of failed decryption is approaching the limit and we
+ * should try to move to a new key
+ */
+static inline bool
+cipher_decrypt_verify_fail_warn(const struct key_ctx *ctx)
+{
+    /* Use 2**35, half the amount after which we refuse to decrypt */
+    return ctx->failed_verifications >  (1ull << 35);
+}
+
+
+/**
  * Blocksize used for the AEAD limit caluclation
  *
  * Since cipher_ctx_block_size() is not reliable and will return 1 in many
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cf7f34f..e4a7b57 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3005,6 +3005,11 @@
         return true;
     }
 
+    if (cipher_decrypt_verify_fail_warn(&key_ctx_bi->decrypt))
+    {
+        return true;
+    }
+
     return false;
 }
 /*

