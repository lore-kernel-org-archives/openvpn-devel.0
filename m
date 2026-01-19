From: Gert Doering <gert@...1296...>
Date: Mon, 19 Jan 2026 13:20:51 +0100
Message-ID: <20260119122058.14865-1-gert@...1296...>
In-Reply-To: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
References: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] ssl_verify_openssl: Avoid conversion
 warning in x509_verify_cert_ku
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

Just use the correct types.

v2:
 - Change type of expected_len argument to size_t

Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1445
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1445
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 1d56533..d70f2df 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -243,7 +243,7 @@
  *                      if key usage is not enabled, or the values do not match.
  */
 result_t x509_verify_cert_ku(openvpn_x509_cert_t *x509, const unsigned *const expected_ku,
-                             int expected_len);
+                             size_t expected_len);
 
 /*
  * Verify X.509 extended key usage extension field.
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index b7de550..a38f5e9 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -483,7 +483,7 @@
 }
 
 result_t
-x509_verify_cert_ku(mbedtls_x509_crt *cert, const unsigned *const expected_ku, int expected_len)
+x509_verify_cert_ku(mbedtls_x509_crt *cert, const unsigned int *const expected_ku, size_t expected_len)
 {
     msg(D_HANDSHAKE, "Validating certificate key usage");
 
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 633f78d..ec7acf8 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -674,13 +674,8 @@
     return FAILURE;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 result_t
-x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku, int expected_len)
+x509_verify_cert_ku(X509 *x509, const unsigned int *const expected_ku, size_t expected_len)
 {
     ASN1_BIT_STRING *ku = X509_get_ext_d2i(x509, NID_key_usage, NULL, NULL);
 
@@ -697,8 +692,8 @@
         return SUCCESS;
     }
 
-    unsigned nku = 0;
-    for (size_t i = 0; i < 8; i++)
+    unsigned int nku = 0;
+    for (int i = 0; i < 8; i++)
     {
         if (ASN1_BIT_STRING_get_bit(ku, i))
         {
@@ -738,10 +733,6 @@
     return fFound;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 result_t
 x509_verify_cert_eku(X509 *x509, const char *const expected_oid)
 {

