From: Gert Doering <gert@...1296...>
Date: Fri, 16 Jan 2026 18:19:42 +0100
Message-ID: <20260116172010.25278-1-gert@...1296...>
In-Reply-To: <gerrit.1765907598000.I99bc4692526f9143a913e29b266a1816295dfd51@...2715...>
References: <gerrit.1765907598000.I99bc4692526f9143a913e29b266a1816295dfd51@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] crypto_openssl: Fix various conversion
 warnings
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

EVP_CIPHER_CTX_flags is documented to output
int in OpenSSL, but is actually unsigned long
in OpenSSL 3.
In libressl it is correctly documented to output
unsigned long.

Change-Id: I99bc4692526f9143a913e29b266a1816295dfd51
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1446
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1446
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index ec0269c..19359f3 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -896,11 +896,6 @@
     return EVP_CIPHER_CTX_mode(ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
 {
@@ -909,7 +904,7 @@
         return false;
     }
 
-    int flags = EVP_CIPHER_CTX_flags(ctx);
+    unsigned long flags = EVP_CIPHER_CTX_flags(ctx);
     int mode = EVP_CIPHER_CTX_mode(ctx);
 
     return mode == EVP_CIPH_CBC_MODE
@@ -940,7 +935,7 @@
 {
     if (ctx)
     {
-        int flags = EVP_CIPHER_CTX_flags(ctx);
+        unsigned long flags = EVP_CIPHER_CTX_flags(ctx);
         if (flags & EVP_CIPH_FLAG_AEAD_CIPHER)
         {
             return true;
@@ -995,8 +990,8 @@
 cipher_ctx_final_check_tag(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,
                            size_t tag_len)
 {
-    ASSERT(tag_len < SIZE_MAX);
-    if (!EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_TAG, tag_len, tag))
+    ASSERT(tag_len < INT_MAX);
+    if (!EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_TAG, (int)tag_len, tag))
     {
         return 0;
     }
@@ -1004,10 +999,6 @@
     return cipher_ctx_final(ctx, dst, dst_len);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  *
  * Generic message digest information functions

