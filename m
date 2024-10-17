From: Gert Doering <gert@...1296...>
Date: Thu, 17 Oct 2024 08:49:55 +0200
Message-ID: <20241017064955.23959-1-gert@...1296...>
In-Reply-To: <gerrit.1727597930000.I0fd48191babe4fe5c56f10eb3ba88182ffb075d1@...2715...>
References: <gerrit.1727597930000.I0fd48191babe4fe5c56f10eb3ba88182ffb075d1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Improve data channel crypto error
 messages
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

From: Steffan Karger <steffan@...1856...>

 * Make decryption error messages better understandable.
 * Increase verbosity level for authentication errors, because those can
   be expected on bad connections.

Change-Id: I0fd48191babe4fe5c56f10eb3ba88182ffb075d1
Signed-off-by: Steffan Karger <steffan@...1856...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/774
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 12ad0b9..064e59e 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -459,14 +459,14 @@
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
                            data_len))
     {
-        CRYPT_ERROR("cipher update failed");
+        CRYPT_ERROR("packet decryption failed");
     }
 
     ASSERT(buf_inc_len(&work, outlen));
     if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen,
                                     &outlen, tag_ptr, tag_size))
     {
-        CRYPT_ERROR("cipher final failed");
+        CRYPT_DROP("packet tag authentication failed");
     }
     ASSERT(buf_inc_len(&work, outlen));
 
@@ -538,7 +538,7 @@
             /* Compare locally computed HMAC with packet HMAC */
             if (memcmp_constant_time(local_hmac, BPTR(buf), hmac_len))
             {
-                CRYPT_ERROR("packet HMAC authentication failed");
+                CRYPT_DROP("packet HMAC authentication failed");
             }
 
             ASSERT(buf_advance(buf, hmac_len));
@@ -572,26 +572,26 @@
             /* ctx->cipher was already initialized with key & keylen */
             if (!cipher_ctx_reset(ctx->cipher, iv_buf))
             {
-                CRYPT_ERROR("cipher init failed");
+                CRYPT_ERROR("decrypt initialization failed");
             }
 
             /* Buffer overflow check (should never happen) */
             if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
             {
-                CRYPT_ERROR("potential buffer overflow");
+                CRYPT_ERROR("packet too big to decrypt");
             }
 
             /* Decrypt packet ID, payload */
             if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf), BLEN(buf)))
             {
-                CRYPT_ERROR("cipher update failed");
+                CRYPT_ERROR("packet decryption failed");
             }
             ASSERT(buf_inc_len(&work, outlen));
 
             /* Flush the decryption buffer */
             if (!cipher_ctx_final(ctx->cipher, BPTR(&work) + outlen, &outlen))
             {
-                CRYPT_ERROR("cipher final failed");
+                CRYPT_DROP("packet authentication failed, dropping.");
             }
             ASSERT(buf_inc_len(&work, outlen));
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 61184bc..d91de74 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -288,8 +288,11 @@
                                  *   security operation functions. */
 };
 
-#define CRYPT_ERROR(format) \
-    do { msg(D_CRYPT_ERRORS, "%s: " format, error_prefix); goto error_exit; } while (false)
+#define CRYPT_ERROR_EXIT(flags, format) \
+    do { msg(flags, "%s: " format, error_prefix); goto error_exit; } while (false)
+
+#define CRYPT_ERROR(format) CRYPT_ERROR_EXIT(D_CRYPT_ERRORS, format)
+#define CRYPT_DROP(format) CRYPT_ERROR_EXIT(D_MULTI_DROPPED, format)
 
 /**
  * Minimal IV length for AEAD mode ciphers (in bytes):

