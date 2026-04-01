From: Gert Doering <gert@...1296...>
Date: Wed,  1 Apr 2026 14:31:40 +0200
Message-ID: <20260401123147.32686-1-gert@...1296...>
In-Reply-To: <gerrit.1774445432000.I5158fbb0762443ea4954e5745f520e83e019ed30@...2715...>
References: <gerrit.1774445432000.I5158fbb0762443ea4954e5745f520e83e019ed30@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Do not access internals of ASN1_INTEGER
 to print hex of serial
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

OpenSSL 4.0 does not allow internal access to to these data structures
anymore. So use public methods to get the serial data and convert it to
hex.

Change-Id: I5158fbb0762443ea4954e5745f520e83e019ed30
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1589
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1589
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index ef30620..1a0f5d4 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -260,17 +260,19 @@
     }
     else if (strcmp(LN_serialNumber, x509_username_field) == 0)
     {
-        ASN1_INTEGER *asn1_i = X509_get_serialNumber(peer_cert);
-        struct gc_arena gc = gc_new();
-        char *serial = format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length(asn1_i), 0, 1 | FHE_CAPS, NULL, &gc);
+        const ASN1_INTEGER *asn1_i = X509_get_serialNumber(peer_cert);
+
+        BIGNUM *bn_serial = ASN1_INTEGER_to_BN(asn1_i, NULL);
+        char *serial = BN_bn2hex(bn_serial);
+        BN_free(bn_serial);
 
         if (!serial || cn_len <= strlen(serial) + 2)
         {
-            gc_free(&gc);
+            OPENSSL_free(serial);
             return FAILURE;
         }
         snprintf(common_name, cn_len, "0x%s", serial);
-        gc_free(&gc);
+        OPENSSL_free(serial);
     }
     else
     {
@@ -315,8 +317,16 @@
 backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
     const ASN1_INTEGER *asn1_i = X509_get_serialNumber(cert);
+    BIGNUM *bn_serial = ASN1_INTEGER_to_BN(asn1_i, NULL);
+    int len_serial = BN_num_bytes(bn_serial);
+    unsigned char *buf = malloc(len_serial);
+    BN_bn2binpad(bn_serial, buf, len_serial);
 
-    return format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length(asn1_i), 0, 1, ":", gc);
+    char *ret = format_hex_ex(buf, len_serial, 0, 1, ":", gc);
+    free(buf);
+    BN_free(bn_serial);
+
+    return ret;
 }
 
 result_t

