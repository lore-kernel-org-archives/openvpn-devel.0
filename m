From: Gert Doering <gert@...1296...>
Date: Sat, 14 Mar 2026 18:09:43 +0100
Message-ID: <20260314170948.2898-1-gert@...1296...>
In-Reply-To: <gerrit.1772798203000.I777a3a5f4f137432a19746972e2aad1732184feb@...2715...>
References: <gerrit.1772798203000.I777a3a5f4f137432a19746972e2aad1732184feb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] ssl_mbedtls: Avoid conversion and
 sign-compare warnings
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

Change-Id: I777a3a5f4f137432a19746972e2aad1732184feb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1559
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1559
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a9506ef..d0c481e 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -624,12 +624,6 @@
     return 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 #if MBEDTLS_VERSION_NUMBER < 0x04000000
 /**
  * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that uses
@@ -656,7 +650,6 @@
 {
     struct external_context *const ctx = ctx_voidptr;
     int rv;
-    uint8_t *to_sign = NULL;
     size_t asn_len = 0, oid_size = 0;
     const char *oid = NULL;
 
@@ -688,11 +681,13 @@
         asn_len = 10 + oid_size;
     }
 
-    if ((SIZE_MAX - hashlen) < asn_len || ctx->signature_length < (asn_len + hashlen))
+    if (ctx->signature_length < (asn_len + hashlen)
+        || (asn_len + hashlen) > UINT8_MAX)
     {
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }
 
+    uint8_t *to_sign = NULL;
     ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);
     uint8_t *p = to_sign;
     if (md_alg != MBEDTLS_MD_NONE)
@@ -707,20 +702,20 @@
          * Digest ::= OCTET STRING
          */
         *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-        *p++ = (unsigned char)(0x08 + oid_size + hashlen);
+        *p++ = (uint8_t)(0x08 + oid_size + hashlen);
         *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-        *p++ = (unsigned char)(0x04 + oid_size);
+        *p++ = (uint8_t)(0x04 + oid_size);
         *p++ = MBEDTLS_ASN1_OID;
-        *p++ = oid_size & 0xFF;
+        *p++ = (uint8_t)oid_size;
         memcpy(p, oid, oid_size);
         p += oid_size;
         *p++ = MBEDTLS_ASN1_NULL;
         *p++ = 0x00;
         *p++ = MBEDTLS_ASN1_OCTET_STRING;
-        *p++ = hashlen;
+        *p++ = (uint8_t)hashlen;
 
         /* Double-check ASN length */
-        ASSERT(asn_len == p - to_sign);
+        ASSERT(asn_len == (uintptr_t)(p - to_sign));
     }
 
     /* Copy the hash to be signed */
@@ -810,7 +805,7 @@
         goto cleanup;
     }
 
-    if (openvpn_base64_decode(dst_b64, dst, (int)dst_len) != dst_len)
+    if (openvpn_base64_decode(dst_b64, dst, (int)dst_len) != (int)dst_len)
     {
         goto cleanup;
     }
@@ -923,6 +918,8 @@
 {
     size_t read_len = 0;
 
+    ASSERT(out_len <= INT_MAX);
+
     if (in->first_block == NULL)
     {
         return MBEDTLS_ERR_SSL_WANT_READ;
@@ -930,7 +927,7 @@
 
     while (in->first_block != NULL && read_len < out_len)
     {
-        int block_len = in->first_block->length - in->data_start;
+        size_t block_len = in->first_block->length - in->data_start;
         if (block_len <= out_len - read_len)
         {
             buffer_entry *cur_entry = in->first_block;
@@ -956,7 +953,7 @@
         }
     }
 
-    return read_len;
+    return (int)read_len;
 }
 
 static int
@@ -975,6 +972,8 @@
         return MBEDTLS_ERR_NET_SEND_FAILED;
     }
 
+    ASSERT(len <= INT_MAX);
+
     new_block->length = len;
     new_block->next_block = NULL;
 
@@ -992,7 +991,7 @@
 
     out->last_block = new_block;
 
-    return len;
+    return (int)len;
 }
 
 static int
@@ -1012,7 +1011,7 @@
 static void
 my_debug(void *ctx, int level, const char *file, int line, const char *str)
 {
-    int my_loglevel = (level < 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
+    msglvl_t my_loglevel = (level < 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
     msg(my_loglevel, "mbed TLS msg (%s:%d): %s", file, line, str);
 }
 
@@ -1048,10 +1047,6 @@
 #endif /* MBEDTLS_VERSION_NUMBER < 0x040000 */
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 tls_version_max(void)
 {
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 7495085..ad5479c 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -565,11 +565,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Save X509 fields to environment, using the naming convention:
  *
@@ -678,10 +673,6 @@
     return fFound;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 result_t
 x509_verify_cert_eku(mbedtls_x509_crt *cert, const char *const expected_oid)
 {

