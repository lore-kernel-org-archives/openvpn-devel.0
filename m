Date: Sun, 22 Mar 2026 04:36:00 +0000
From: Rudi Heitbaum <rudi@...2993...>
Message-ID: <ab9xsPqPbK_jLNF2@...3014...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] ssl_verify_openssl: use official
 ASN1_STRING_ API
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
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

ASN1_STRING are now opaque types in OpenSSL 4.x — the internal data and
length fields are no longer directly accessible. Use the accessor API
instead. Accessors have been available since OpenSSL 1.1.0

The ASN1_STRING_length accessor is already in use, but not consistently
applied. Standardise on using ASN1_STRING_length and ASN1_STRING_get0_data
which allows for successful build of OpenSSL 4.x

Signed-off-by: Rudi Heitbaum <rudi@...2993...>
---
 src/openvpn/ssl_verify_openssl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 46401cd3..d96879bd 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -259,7 +259,7 @@ backend_x509_get_username(char *common_name, size_t cn_len, char *x509_username_
     {
         ASN1_INTEGER *asn1_i = X509_get_serialNumber(peer_cert);
         struct gc_arena gc = gc_new();
-        char *serial = format_hex_ex(asn1_i->data, asn1_i->length, 0, 1 | FHE_CAPS, NULL, &gc);
+        char *serial = format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length(asn1_i), 0, 1 | FHE_CAPS, NULL, &gc);
 
         if (!serial || cn_len <= strlen(serial) + 2)
         {
@@ -313,7 +313,7 @@ backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
     const ASN1_INTEGER *asn1_i = X509_get_serialNumber(cert);
 
-    return format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, ":", gc);
+    return format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length(asn1_i), 0, 1, ":", gc);
 }
 
 result_t
@@ -626,7 +626,7 @@ x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int usage)
         {
             ASN1_BIT_STRING *ns;
             ns = X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);
-            result = (ns && ns->length > 0 && (ns->data[0] & NS_SSL_CLIENT)) ? SUCCESS : FAILURE;
+            result = (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_get0_data(ns)[0] & NS_SSL_CLIENT)) ? SUCCESS : FAILURE;
             if (result == SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a client certificate yet it's purpose "
@@ -654,7 +654,7 @@ x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int usage)
         {
             ASN1_BIT_STRING *ns;
             ns = X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);
-            result = (ns && ns->length > 0 && (ns->data[0] & NS_SSL_SERVER)) ? SUCCESS : FAILURE;
+            result = (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_get0_data(ns)[0] & NS_SSL_SERVER)) ? SUCCESS : FAILURE;
             if (result == SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a server certificate yet it's purpose "
-- 
2.53.0


