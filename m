From: Gert Doering <gert@...1296...>
Date: Sun, 16 Nov 2025 15:07:48 +0100
Message-ID: <20251116140754.17177-1-gert@...1296...>
In-Reply-To: <gerrit.1763141628000.I3f11423834814bab5d653f160fc2326dae4c0e8e@...2715...>
References: <gerrit.1763141628000.I3f11423834814bab5d653f160fc2326dae4c0e8e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tls_crypt: Avoid some conversion warnings
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

From: Frank Lichtenheld <frank@...2641...>

The casts should be safe, since one is a constant
(but got type from sizeof()) and the other is
limited by the buffer length.

While here make the code in tls_crypt_v2_wrap_client_key
as little easier to follow.

Change-Id: I3f11423834814bab5d653f160fc2326dae4c0e8e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1379
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1379
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index a808de3..ab719b3 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -205,11 +205,6 @@
     return false;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct crypto_options *opt)
 {
@@ -246,7 +241,7 @@
             CRYPT_ERROR("cipher reset failed");
         }
         if (!cipher_ctx_update(ctx->cipher, BPTR(dst), &outlen, BPTR(src) + TLS_CRYPT_OFF_CT,
-                               BLEN(src) - TLS_CRYPT_OFF_CT))
+                               BLEN(src) - (int)TLS_CRYPT_OFF_CT))
         {
             CRYPT_ERROR("cipher update failed");
         }
@@ -381,8 +376,9 @@
         msg(M_WARN, "ERROR: could not write tag");
         return false;
     }
-    uint16_t net_len = htons(sizeof(src_key->keys) + BLEN(src_metadata) + TLS_CRYPT_V2_TAG_SIZE
-                             + sizeof(uint16_t));
+    const int data_len = BLEN(src_metadata) + sizeof(src_key->keys) + sizeof(uint16_t);
+    const int tagged_len = data_len + TLS_CRYPT_TAG_SIZE;
+    const uint16_t net_len = htons((uint16_t)tagged_len);
     hmac_ctx_t *hmac_ctx = server_key->hmac;
     hmac_ctx_reset(hmac_ctx);
     hmac_ctx_update(hmac_ctx, (void *)&net_len, sizeof(net_len));
@@ -396,8 +392,8 @@
     ASSERT(cipher_ctx_reset(cipher_ctx, tag));
 
     /* Overflow check (OpenSSL requires an extra block in the dst buffer) */
-    if (buf_forward_capacity(&work) < (sizeof(src_key->keys) + BLEN(src_metadata) + sizeof(net_len)
-                                       + cipher_ctx_block_size(cipher_ctx)))
+    const int padded_len = data_len + cipher_ctx_block_size(cipher_ctx);
+    if (buf_forward_capacity(&work) < padded_len)
     {
         msg(M_WARN, "ERROR: could not crypt: insufficient space in dst");
         return false;
@@ -418,10 +414,6 @@
     return buf_copy(wkc, &work);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 tls_crypt_v2_unwrap_client_key(struct key2 *client_key, struct buffer *metadata,
                                struct buffer wrapped_client_key, struct key_ctx *server_key)

