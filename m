From: Gert Doering <gert@...1296...>
Date: Mon, 23 Mar 2026 13:19:00 +0100
Message-ID: <20260323121908.730-1-gert@...1296...>
In-Reply-To: <gerrit.1774267774000.I8adffc3152b5b502a820a8ae0f901717e4831f81@...2715...>
References: <gerrit.1774267774000.I8adffc3152b5b502a820a8ae0f901717e4831f81@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ssl_verify_openssl: use official
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
To: openvpn-devel@lists.sourceforge.net

From: Rudi Heitbaum <rudi@...2993...>

ASN1_STRING are now opaque types in OpenSSL 4.x — the internal data and
length fields are no longer directly accessible. Use the accessor API
instead. Accessors have been available since OpenSSL 1.1.0

The ASN1_STRING_length accessor is already in use, but not consistently
applied. Standardise on using ASN1_STRING_length and ASN1_STRING_get0_data
which allows for successful build of OpenSSL 4.x

Change-Id: I8adffc3152b5b502a820a8ae0f901717e4831f81
Signed-off-by: Rudi Heitbaum <rudi@...2993...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1584
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1584
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 46401cd..d96879b 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -259,7 +259,7 @@
     {
         ASN1_INTEGER *asn1_i = X509_get_serialNumber(peer_cert);
         struct gc_arena gc = gc_new();
-        char *serial = format_hex_ex(asn1_i->data, asn1_i->length, 0, 1 | FHE_CAPS, NULL, &gc);
+        char *serial = format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length(asn1_i), 0, 1 | FHE_CAPS, NULL, &gc);
 
         if (!serial || cn_len <= strlen(serial) + 2)
         {
@@ -313,7 +313,7 @@
 {
     const ASN1_INTEGER *asn1_i = X509_get_serialNumber(cert);
 
-    return format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, ":", gc);
+    return format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length(asn1_i), 0, 1, ":", gc);
 }
 
 result_t
@@ -626,7 +626,7 @@
         {
             ASN1_BIT_STRING *ns;
             ns = X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);
-            result = (ns && ns->length > 0 && (ns->data[0] & NS_SSL_CLIENT)) ? SUCCESS : FAILURE;
+            result = (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_get0_data(ns)[0] & NS_SSL_CLIENT)) ? SUCCESS : FAILURE;
             if (result == SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a client certificate yet it's purpose "
@@ -654,7 +654,7 @@
         {
             ASN1_BIT_STRING *ns;
             ns = X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);
-            result = (ns && ns->length > 0 && (ns->data[0] & NS_SSL_SERVER)) ? SUCCESS : FAILURE;
+            result = (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_get0_data(ns)[0] & NS_SSL_SERVER)) ? SUCCESS : FAILURE;
             if (result == SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a server certificate yet it's purpose "

