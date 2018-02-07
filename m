From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 7 Feb 2018 13:22:46 +0100
Message-ID: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] mbedtls: don't use API deprecated in mbed
 2.7
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

The void-returning mbedtls_sha256() was deprecated in mbed TLS 2.7.
Use our own md_full() abstraction instead.

(The new function can theoretically fail, but only in case of highly
unlikely digest function failures.  The personalisation on random using
the certificate is a best-effort measure, so we simply log a warning and
skip the personalisation if such highly unlikely errors occur.)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_mbedtls.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 2a1215d..3906cd5 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -60,7 +60,6 @@
 
 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>
-#include <mbedtls/sha256.h>
 
 static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =
 {
@@ -851,9 +850,14 @@ tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 
     if (NULL != ctx->crt_chain)
     {
+        const md_kt_t *sha256_kt = md_kt_get("SHA256");
         mbedtls_x509_crt *cert = ctx->crt_chain;
 
-        mbedtls_sha256(cert->tbs.p, cert->tbs.len, sha256_hash, false);
+        if (0 != md_full(sha256_kt, cert->tbs.p, cert->tbs.len, sha256_hash))
+        {
+            msg(M_WARN, "WARNING: failed to personalise random");
+        }
+
         if (0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
         {
             mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32);
-- 
2.7.4


