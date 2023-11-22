From: David Sommerseth <dazo+openvpn@...2108...>
Date: Wed, 22 Nov 2023 20:01:25 +0100
Message-Id: <20231122190125.120500-1-dazo+openvpn@...2108...>
In-Reply-To: <20231122143110.58520-1-dazo+openvpn@...2108...>
References: <20231122143110.58520-1-dazo+openvpn@...2108...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove superfluous x509_write_pem()
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

After removing --tls-export-cert, this function was left in the code
base with no other users.  This was an oversight in the previous
change.  Removing it to avoid leaving dead code behind.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/ssl_verify_backend.h | 11 -----------
 src/openvpn/ssl_verify_mbedtls.c |  7 -------
 src/openvpn/ssl_verify_openssl.c | 11 -----------
 3 files changed, 29 deletions(-)

diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 3b798811..d402b1f2 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -249,17 +249,6 @@ result_t x509_verify_cert_ku(openvpn_x509_cert_t *x509, const unsigned *const ex
  */
 result_t x509_verify_cert_eku(openvpn_x509_cert_t *x509, const char *const expected_oid);
 
-/*
- * Store the given certificate in pem format in a temporary file in tmp_dir
- *
- * @param cert          Certificate to store
- * @param tmp_dir       Temporary directory to store the directory
- * @param gc            gc_arena to store temporary objects in
- *
- *
- */
-result_t x509_write_pem(FILE *peercert_file, openvpn_x509_cert_t *peercert);
-
 /**
  * Return true iff a CRL is configured, but is not loaded.  This can be caused
  * by e.g. a CRL parsing error, a missing CRL file or CRL file permission
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index a1ddf8d0..4596843c 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -547,13 +547,6 @@ x509_verify_cert_eku(mbedtls_x509_crt *cert, const char *const expected_oid)
     return fFound;
 }
 
-result_t
-x509_write_pem(FILE *peercert_file, mbedtls_x509_crt *peercert)
-{
-    msg(M_WARN, "mbed TLS does not support writing peer certificate in PEM format");
-    return FAILURE;
-}
-
 bool
 tls_verify_crl_missing(const struct tls_options *opt)
 {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 3194c232..5afffc1f 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -762,17 +762,6 @@ x509_verify_cert_eku(X509 *x509, const char *const expected_oid)
     return fFound;
 }
 
-result_t
-x509_write_pem(FILE *peercert_file, X509 *peercert)
-{
-    if (PEM_write_X509(peercert_file, peercert) < 0)
-    {
-        msg(M_NONFATAL, "Failed to write peer certificate in PEM format");
-        return FAILURE;
-    }
-    return SUCCESS;
-}
-
 bool
 tls_verify_crl_missing(const struct tls_options *opt)
 {
-- 
2.39.3


