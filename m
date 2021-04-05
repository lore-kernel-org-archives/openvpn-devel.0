From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Apr 2021 10:00:05 +0200
Message-Id: <20210405080007.1665-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] openssl: fix EVP_PKEY_CTX memory leak
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

A context allocated with EVP_PKEY_CTX_new_id() must be ultimately free'd
by Eng VP_PKEY_CTX_free(). Failing to do so will result in a memory leak.

This bug was discovered using GCC with "-fsanitize=address".

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/crypto_openssl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index f3e86863..d54ca6d2 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1125,37 +1125,41 @@ bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
 {
+    bool ret = false;
     EVP_PKEY_CTX *pctx = EVP_PKEY_CTX_new_id(EVP_PKEY_TLS1_PRF, NULL);
     if (!EVP_PKEY_derive_init(pctx))
     {
-        return false;
+        goto out;
     }
 
     if (!EVP_PKEY_CTX_set_tls1_prf_md(pctx, EVP_md5_sha1()))
     {
-        return false;
+        goto out;
     }
 
     if (!EVP_PKEY_CTX_set1_tls1_prf_secret(pctx, secret, secret_len))
     {
-        return false;
+        goto out;
     }
 
     if (!EVP_PKEY_CTX_add1_tls1_prf_seed(pctx, seed, seed_len))
     {
-        return false;
+        goto out;
     }
 
     size_t out_len = output_len;
     if (!EVP_PKEY_derive(pctx, output, &out_len))
     {
-        return false;
+        goto out;
     }
     if (out_len != output_len)
     {
-        return false;
+        goto out;
     }
-    return true;
+    ret = true;
+out:
+    EVP_PKEY_CTX_free(pctx);
+    return ret;
 }
 #else  /* if OPENSSL_VERSION_NUMBER >= 0x10100000L */
 /*
-- 
2.26.3


