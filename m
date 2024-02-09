From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  9 Feb 2024 12:06:29 +0100
Message-Id: <20240209110629.15364-1-frank@...2641...>
In-Reply-To: <gerrit.1700595358000.Ic74195a4ed340547c5e862dc2438f95be318c286@...2715...>
References: <gerrit.1700595358000.Ic74195a4ed340547c5e862dc2438f95be318c286@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] Implement generating TLS 1.0 PRF using
 new OpenSSL 3.0 APIs
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

OpenSSL 3.0 introduced a new API for doing key derivation. So this leaves
us now with three different implementation for 1.0.2, 1.1.x and 3.x.

This was initially done to maybe still have a working TLS 1.0 PRF when
using OpenSSL 3.0 in FIPS but it gives the same error as with the older API.
But since moving to a new API is always good, we use the new API when using
OpenSSL 3.0. We also print the internal OpenSSL error message when
the KDF fails.

This also allows us now to compile an OpenSSL build that has been built with
OPENSSL_NO_MD5. Which is not yet common but might be in the future.

Change-Id: Ic74195a4ed340547c5e862dc2438f95be318c286
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/457
This mail reflects revision 8 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

Typo fix in commit message added during submission.

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e8ddf14..4fd5e6b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -54,6 +54,7 @@
 #endif
 #if OPENSSL_VERSION_NUMBER >= 0x30000000L
 #include <openssl/provider.h>
+#include <openssl/core_names.h>
 #endif
 
 #if defined(_WIN32) && defined(OPENSSL_NO_EC)
@@ -1329,8 +1330,57 @@
 {
     return CRYPTO_memcmp(a, b, size);
 }
+#if (OPENSSL_VERSION_NUMBER >= 0x30000000L) && !defined(LIBRESSL_VERSION_NUMBER)
+bool
+ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
+             int secret_len, uint8_t *output, int output_len)
+{
+    bool ret = true;
+    EVP_KDF_CTX *kctx = NULL;
 
-#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(LIBRESSL_VERSION_NUMBER)
+
+    EVP_KDF *kdf = EVP_KDF_fetch(NULL, "TLS1-PRF", NULL);
+    if (!kdf)
+    {
+        goto err;
+    }
+
+    kctx = EVP_KDF_CTX_new(kdf);
+
+    if (!kctx)
+    {
+        goto err;
+    }
+
+    OSSL_PARAM params[4];
+
+    /* The OpenSSL APIs require us to cast the const aways even though the
+     * strings are never changed and only read */
+    params[0] = OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST,
+                                                 SN_md5_sha1, strlen(SN_md5_sha1));
+    params[1] = OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SECRET,
+                                                  (uint8_t *) secret, (size_t) secret_len);
+    params[2] = OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_SEED,
+                                                  (uint8_t *) seed, (size_t) seed_len);
+    params[3] = OSSL_PARAM_construct_end();
+
+    if (EVP_KDF_derive(kctx, output, output_len, params) <= 0)
+    {
+        crypto_msg(D_TLS_DEBUG_LOW, "Generating TLS 1.0 PRF using "
+                   "EVP_KDF_derive failed");
+        goto err;
+    }
+
+    goto out;
+
+err:
+    ret = false;
+out:
+    EVP_KDF_free(kdf);
+
+    return ret;
+}
+#elif (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(LIBRESSL_VERSION_NUMBER)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)

