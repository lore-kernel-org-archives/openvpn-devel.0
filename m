From: Gert Doering <gert@...1296...>
Date: Sat,  4 Apr 2026 09:23:30 +0200
Message-ID: <20260404072336.30014-1-gert@...1296...>
In-Reply-To: <gerrit.1774445432000.I77500d435f212a4bf42ee8cfca07d0285fe694f2@...2715...>
References: <gerrit.1774445432000.I77500d435f212a4bf42ee8cfca07d0285fe694f2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Use ASN1_BIT_STRING_get_bit to check for
 netscape certificate usage
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

The ASN_BIT_STRING object has become opaque in OpenSSL 4.0. So instead
of accessing the internal, we have to use a method now to check these
attributes.

The bit counting in ASN.1 and of this method is a bit strange and
it will count bits from the left instead of the right, so the previous
mask of 0x80 for clients is now 0 and 0x40 for server is now 1.

Change-Id: I77500d435f212a4bf42ee8cfca07d0285fe694f2
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1587
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1587
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 08946cd..c70022f 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -609,22 +609,27 @@
     if (usage == NS_CERT_CHECK_CLIENT)
     {
         /*
-         * Unfortunately, X509_check_purpose() does some weird thing that
+         * Unfortunately, X509_check_purpose() before OpenSSL 4.0 does some weird thing that
          * prevent it to take a const argument
          */
         result_t result =
             X509_check_purpose(peer_cert, X509_PURPOSE_SSL_CLIENT, 0) ? SUCCESS : FAILURE;
-
         /*
-         * old versions of OpenSSL allow us to make the less strict check we used to
-         * do. If this less strict check pass, warn user that this might not be the
-         * case when its distribution will update to OpenSSL 1.1
+         * Note that we did not check for netscape certificate type here but
+         * instead a general SSL/TLS client purpose. These nscert attributes
+         * might stop being accepted by TLS libraries in the future.
+         * Currently, OpenSSL 4.0 and aws-lc 1.9.0 still consider nscert client
+         * as acceptable.
+         *
+         * So in case that this check failed, we now check if this is caused
+         * by the check above no longer recognising nscert attributes.
          */
         if (result == FAILURE)
         {
             ASN1_BIT_STRING *ns;
             ns = X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);
-            result = (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_get0_data(ns)[0] & NS_SSL_CLIENT)) ? SUCCESS : FAILURE;
+            // bit 0 is to check if certificate is the client certificate
+            result = ASN1_BIT_STRING_get_bit(ns, 0) ? SUCCESS : FAILURE;
             if (result == SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a client certificate yet it's purpose "
@@ -637,22 +642,27 @@
     if (usage == NS_CERT_CHECK_SERVER)
     {
         /*
-         * Unfortunately, X509_check_purpose() does some weird thing that
+         * Unfortunately, X509_check_purpose() before OpenSSL 4.0 does some weird thing that
          * prevent it to take a const argument
          */
         result_t result =
             X509_check_purpose(peer_cert, X509_PURPOSE_SSL_SERVER, 0) ? SUCCESS : FAILURE;
 
         /*
-         * old versions of OpenSSL allow us to make the less strict check we used to
-         * do. If this less strict check pass, warn user that this might not be the
-         * case when its distribution will update to OpenSSL 1.1
+         * Note that we did not check for netscape certificate type here but
+         * instead a general SSL/TLS server purpose. These nscert attributes
+         * might stop being accepted by TLS libraries in the future.
+         * Currently, OpenSSL 4.0 and aws-lc 1.9.0 still consider nscert server
+         * as acceptable.
+         *
+         * So in case that this check failed, we now check if this is caused
+         * by the check above no longer recognising nscert attributes.
          */
         if (result == FAILURE)
         {
-            ASN1_BIT_STRING *ns;
-            ns = X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);
-            result = (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_get0_data(ns)[0] & NS_SSL_SERVER)) ? SUCCESS : FAILURE;
+            ASN1_BIT_STRING *ns = X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);
+            // Server bit is 1 for ASN1_BIT_STRING_get_bit
+            result = ASN1_BIT_STRING_get_bit(ns, 1) ? SUCCESS : FAILURE;
             if (result == SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a server certificate yet it's purpose "

