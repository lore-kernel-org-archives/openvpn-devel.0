From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Thu, 11 Aug 2022 14:07:22 +0200
Message-ID: <20220811120722.29168-2-maximilian.fillinger@...2507...>
In-Reply-To: <20220811120722.29168-1-maximilian.fillinger@...2507...>
References: <20220811120722.29168-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Handle EVP_MD_CTX as an opaque struct
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

Building OpenVPN on the latest OpenBSD snapshot failed because EVP_MD_CTX
is an opaque struct in LibreSSL now. Therefore, call md_ctx_new() instead
of declaring them on the stack. When they're not on the stack anymore, we
don't have to call EVP_MD_CTX_init() anymore, but we need to call
EVP_MD_CTX_free() instead of cleanup.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/crypto_openssl.c | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 5cd09e33..5c86268d 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1492,7 +1492,7 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
 {
     int chunk;
     size_t j;
-    EVP_MD_CTX ctx, ctx_tmp, ctx_init;
+    EVP_MD_CTX *ctx, *ctx_tmp, *ctx_init;
     EVP_PKEY *mac_key;
     unsigned char A1[EVP_MAX_MD_SIZE];
     size_t A1_len = EVP_MAX_MD_SIZE;
@@ -1501,28 +1501,28 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
     chunk = EVP_MD_size(md);
     OPENSSL_assert(chunk >= 0);
 
-    EVP_MD_CTX_init(&ctx);
-    EVP_MD_CTX_init(&ctx_tmp);
-    EVP_MD_CTX_init(&ctx_init);
-    EVP_MD_CTX_set_flags(&ctx_init, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);
+    ctx = md_ctx_new();
+    ctx_tmp = md_ctx_new();
+    ctx_init = md_ctx_new();
+    EVP_MD_CTX_set_flags(ctx_init, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);
     mac_key = EVP_PKEY_new_mac_key(EVP_PKEY_HMAC, NULL, sec, sec_len);
     if (!mac_key)
     {
         goto err;
     }
-    if (!EVP_DigestSignInit(&ctx_init, NULL, md, NULL, mac_key))
+    if (!EVP_DigestSignInit(ctx_init, NULL, md, NULL, mac_key))
     {
         goto err;
     }
-    if (!EVP_MD_CTX_copy_ex(&ctx, &ctx_init))
+    if (!EVP_MD_CTX_copy_ex(ctx, ctx_init))
     {
         goto err;
     }
-    if (!EVP_DigestSignUpdate(&ctx, seed, seed_len))
+    if (!EVP_DigestSignUpdate(ctx, seed, seed_len))
     {
         goto err;
     }
-    if (!EVP_DigestSignFinal(&ctx, A1, &A1_len))
+    if (!EVP_DigestSignFinal(ctx, A1, &A1_len))
     {
         goto err;
     }
@@ -1530,19 +1530,19 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
     for (;; )
     {
         /* Reinit mac contexts */
-        if (!EVP_MD_CTX_copy_ex(&ctx, &ctx_init))
+        if (!EVP_MD_CTX_copy_ex(ctx, ctx_init))
         {
             goto err;
         }
-        if (!EVP_DigestSignUpdate(&ctx, A1, A1_len))
+        if (!EVP_DigestSignUpdate(ctx, A1, A1_len))
         {
             goto err;
         }
-        if (olen > chunk && !EVP_MD_CTX_copy_ex(&ctx_tmp, &ctx))
+        if (olen > chunk && !EVP_MD_CTX_copy_ex(ctx_tmp, ctx))
         {
             goto err;
         }
-        if (!EVP_DigestSignUpdate(&ctx, seed, seed_len))
+        if (!EVP_DigestSignUpdate(ctx, seed, seed_len))
         {
             goto err;
         }
@@ -1550,14 +1550,14 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
         if (olen > chunk)
         {
             j = olen;
-            if (!EVP_DigestSignFinal(&ctx, out, &j))
+            if (!EVP_DigestSignFinal(ctx, out, &j))
             {
                 goto err;
             }
             out += j;
             olen -= j;
             /* calc the next A1 value */
-            if (!EVP_DigestSignFinal(&ctx_tmp, A1, &A1_len))
+            if (!EVP_DigestSignFinal(ctx_tmp, A1, &A1_len))
             {
                 goto err;
             }
@@ -1566,7 +1566,7 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
         {
             A1_len = EVP_MAX_MD_SIZE;
             /* last one */
-            if (!EVP_DigestSignFinal(&ctx, A1, &A1_len))
+            if (!EVP_DigestSignFinal(ctx, A1, &A1_len))
             {
                 goto err;
             }
@@ -1577,9 +1577,9 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
     ret = true;
 err:
     EVP_PKEY_free(mac_key);
-    EVP_MD_CTX_cleanup(&ctx);
-    EVP_MD_CTX_cleanup(&ctx_tmp);
-    EVP_MD_CTX_cleanup(&ctx_init);
+    EVP_MD_CTX_free(ctx);
+    EVP_MD_CTX_free(ctx_tmp);
+    EVP_MD_CTX_free(ctx_init);
     OPENSSL_cleanse(A1, sizeof(A1));
     return ret;
 }
-- 
2.30.2


