From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Tue, 10 Aug 2021 08:16:44 +0200
Message-ID: <20210810061644.20353-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Replace deprecated mbedtls DRBG update
 function
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

The function mbedtls_ctr_drbg_update is deprecated as of mbedtls 2.16
and is superseded by mbedtls_ctr_drbg_update_ret, which returns an error
code. This commit replaces the call to the deprecated function with the
new one and logs a warning in case of an error.

For older versions of mbedtls, we add a compatibility function that runs
mbedtls_ctr_drbg_update and returns 0.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/ssl_mbedtls.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 265ea36f..1853335e 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -62,6 +62,21 @@
 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>
 
+/**
+ * Compatibility: mbedtls_ctr_drbg_update was deprecated in mbedtls 2.16 and
+ * replaced with mbedtls_ctr_drbg_update_ret, which returns an error code.
+ * For older versions, we call mbedtls_ctr_drbg_update and return 0 (success).
+ */
+#if MBEDTLS_VERSION_NUMBER < 0x02100000
+static int mbedtls_ctr_drbg_update_ret(mbedtls_ctr_drbg_context *ctx,
+                                       const unsigned char *additional,
+                                       size_t add_len)
+{
+    mbedtls_ctr_drbg_update(ctx, additional, add_len);
+    return 0;
+}
+#endif
+
 static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =
 {
     /* Hashes from SHA-1 and above */
@@ -950,7 +965,10 @@ tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 
         if (0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
         {
-            mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32);
+            if (!mbed_ok(mbedtls_ctr_drbg_update_ret(cd_ctx, sha256_hash, 32)))
+            {
+                msg(M_WARN, "WARNING: failed to personalise random, could not update CTR_DRBG");
+            }
             memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash));
         }
     }
-- 
2.11.0


