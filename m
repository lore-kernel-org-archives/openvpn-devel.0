From: Gert Doering <gert@...1296...>
Date: Mon, 22 Sep 2025 22:43:23 +0200
Message-ID: <20250922204329.23460-1-gert@...1296...>
In-Reply-To: <gerrit.1754490554000.If971006b6d3a1a93d87b29627d91dd72faf5ceb2@...2715...>
References: <gerrit.1754490554000.If971006b6d3a1a93d87b29627d91dd72faf5ceb2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] ssl_verify: Change backend_x509_*
 functions to size_t for lengths
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

Fix conversion warnings without actual code changes.

Change-Id: If971006b6d3a1a93d87b29627d91dd72faf5ceb2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1138
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1138
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index a0559c9..c6ab9dd 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -123,7 +123,7 @@
  *
  * @return              \c FAILURE, \c or SUCCESS
  */
-result_t backend_x509_get_username(char *common_name, int cn_len, char *x509_username_field,
+result_t backend_x509_get_username(char *common_name, size_t cn_len, char *x509_username_field,
                                    openvpn_x509_cert_t *peer_cert);
 
 #ifdef ENABLE_X509ALTUSERNAME
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index cfcfb25..986c7da 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -128,7 +128,7 @@
 #endif
 
 result_t
-backend_x509_get_username(char *cn, int cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
+backend_x509_get_username(char *cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
 {
     mbedtls_x509_name *name;
 
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index b79b09b..5bbd72c 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -120,7 +120,7 @@
 }
 
 static bool
-extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
+extract_x509_extension(X509 *cert, char *fieldname, char *out, size_t size)
 {
     bool retval = false;
     char *buf = 0;
@@ -195,7 +195,7 @@
  * to contain result is grounds for error).
  */
 static result_t
-extract_x509_field_ssl(X509_NAME *x509, const char *field_name, char *out, int size)
+extract_x509_field_ssl(X509_NAME *x509, const char *field_name, char *out, size_t size)
 {
     int lastpos = -1;
     int tmp = -1;
@@ -252,7 +252,7 @@
 }
 
 result_t
-backend_x509_get_username(char *common_name, int cn_len, char *x509_username_field, X509 *peer_cert)
+backend_x509_get_username(char *common_name, size_t cn_len, char *x509_username_field, X509 *peer_cert)
 {
 #ifdef ENABLE_X509ALTUSERNAME
     if (strncmp("ext:", x509_username_field, 4) == 0)

