From: Gert Doering <gert@...1296...>
Date: Mon, 16 Feb 2026 16:07:05 +0100
Message-ID: <20260216150711.16130-1-gert@...1296...>
In-Reply-To: <gerrit.1770735307000.I201abb9ef013c061fb568823098edcca32cb2df3@...2715...>
References: <gerrit.1770735307000.I201abb9ef013c061fb568823098edcca32cb2df3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] crypto_backend: Improve signature of
 md_full to avoid conversions
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

Change-Id: I201abb9ef013c061fb568823098edcca32cb2df3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1512
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1512
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 5248614..7f5507a 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -557,9 +557,9 @@
  * @param src_len       The length of the incoming buffer.
  * @param dst           Buffer to write the message digest to. May not be NULL.
  *
- * @return              \c 1 on success, \c 0 on failure
+ * @return              true on success, false on failure
  */
-int md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst);
+bool md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst);
 
 /*
  * Allocate a new message digest context
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 02735cd..cba6bb5 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -696,13 +696,13 @@
     return ctx;
 }
 
-int
-md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
+bool
+md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)
 {
     const md_info_t *md = md_get(mdname);
     if (md == NULL || src_len < 0)
     {
-        return 0;
+        return false;
     }
 
     /* We depend on the caller to ensure that dst has enough room for the hash,
@@ -710,12 +710,12 @@
     size_t dst_size = PSA_HASH_LENGTH(md->psa_alg);
     size_t hash_length = 0;
 
-    psa_status_t status = psa_hash_compute(md->psa_alg, src, (size_t)src_len, dst, dst_size, &hash_length);
+    psa_status_t status = psa_hash_compute(md->psa_alg, src, src_len, dst, dst_size, &hash_length);
     if (status != PSA_SUCCESS || hash_length != dst_size)
     {
-        return 0;
+        return false;
     }
-    return 1;
+    return true;
 }
 
 void
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
index a991349..0dad284 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -835,8 +835,8 @@
  *
  */
 
-int
-md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
+bool
+md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)
 {
     const mbedtls_md_info_t *kt = md_get(mdname);
     return 0 == mbedtls_md(kt, src, src_len, dst);
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index ed39efa..0c6de18 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1104,15 +1104,15 @@
  *
  */
 
-int
-md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
+bool
+md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)
 {
     unsigned int in_md_len = 0;
     evp_md_type *kt = md_get(mdname);
 
     int ret = EVP_Digest(src, src_len, dst, &in_md_len, kt, NULL);
     EVP_MD_free(kt);
-    return ret;
+    return ret == 1;
 }
 
 EVP_MD_CTX *

