From: Gert Doering <gert@...1296...>
Date: Sun,  5 Apr 2026 12:31:04 +0200
Message-ID: <20260405103110.32401-1-gert@...1296...>
In-Reply-To: <gerrit.1775344373000.Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929@...2715...>
References: <gerrit.1775344373000.Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] crypto_backend: Remove md_full
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

There was only one user for mbedtls < 4.0,
so remove all the unused implementations.

Identified by cppcheck.

Change-Id: Ie2285f5bf52f5c669fb01f9ae36d6aa1674f0929
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1612
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1612
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 4e9283d..360abbe 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -549,18 +549,6 @@
  *
  */
 
-/**
- * Calculates the message digest for the given buffer.
- *
- * @param mdname        message digest name
- * @param src           Buffer to digest. May not be NULL.
- * @param src_len       The length of the incoming buffer.
- * @param dst           Buffer to write the message digest to. May not be NULL.
- *
- * @return              true on success, false on failure
- */
-bool md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst);
-
 /*
  * Allocate a new message digest context
  *
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index b0d0820..665257c0 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -696,28 +696,6 @@
     return ctx;
 }
 
-bool
-md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)
-{
-    const md_info_t *md = md_get(mdname);
-    if (md == NULL)
-    {
-        return false;
-    }
-
-    /* We depend on the caller to ensure that dst has enough room for the hash,
-     * so we just tell PSA that it can hold the appropriate amount of bytes. */
-    size_t dst_size = PSA_HASH_LENGTH(md->psa_alg);
-    size_t hash_length = 0;
-
-    psa_status_t status = psa_hash_compute(md->psa_alg, src, src_len, dst, dst_size, &hash_length);
-    if (status != PSA_SUCCESS || hash_length != dst_size)
-    {
-        return false;
-    }
-    return true;
-}
-
 void
 md_ctx_free(md_ctx_t *ctx)
 {
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
index 3f04a3e..6556358 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -769,7 +769,7 @@
  */
 
 
-static const mbedtls_md_info_t *
+const mbedtls_md_info_t *
 md_get(const char *digest)
 {
     const mbedtls_md_info_t *md = NULL;
@@ -825,13 +825,6 @@
  *
  */
 
-bool
-md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)
-{
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    return 0 == mbedtls_md(kt, src, src_len, dst);
-}
-
 mbedtls_md_context_t *
 md_ctx_new(void)
 {
diff --git a/src/openvpn/crypto_mbedtls_legacy.h b/src/openvpn/crypto_mbedtls_legacy.h
index 1005057..23113be 100644
--- a/src/openvpn/crypto_mbedtls_legacy.h
+++ b/src/openvpn/crypto_mbedtls_legacy.h
@@ -137,4 +137,6 @@
  */
 #define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
 
+const mbedtls_md_info_t *md_get(const char *digest);
+
 #endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e49f654..e268d7c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1107,17 +1107,6 @@
  *
  */
 
-bool
-md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)
-{
-    unsigned int in_md_len = 0;
-    evp_md_type *kt = md_get(mdname);
-
-    int ret = EVP_Digest(src, src_len, dst, &in_md_len, kt, NULL);
-    EVP_MD_free(kt);
-    return ret == 1;
-}
-
 EVP_MD_CTX *
 md_ctx_new(void)
 {
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index d0c481e..a62ff76 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1029,8 +1029,9 @@
     if (NULL != ctx->crt_chain)
     {
         mbedtls_x509_crt *cert = ctx->crt_chain;
+        const mbedtls_md_info_t *kt = md_get("SHA256");
 
-        if (!md_full("SHA256", cert->tbs.p, cert->tbs.len, sha256_hash))
+        if (0 != mbedtls_md(kt, cert->tbs.p, cert->tbs.len, sha256_hash))
         {
             msg(M_WARN, "WARNING: failed to personalise random");
         }

