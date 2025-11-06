From: Gert Doering <gert@...1296...>
Date: Thu,  6 Nov 2025 14:39:30 +0100
Message-ID: <20251106133936.30264-1-gert@...1296...>
In-Reply-To: <gerrit.1762436081000.I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995@...2715...>
References: <gerrit.1762436081000.I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] pkcs11_openssl: Silence a conversion
 warning
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

The only caller of this function uses a constant
for this parameter, so this is all quite safe. Add
an ASSERT for good measure anyway to make the assumption
explicit.

Change-Id: I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1352
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1352
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index f619b95..1d527db 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -428,18 +428,12 @@
     return dn;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 pkcs11_certificate_serial(pkcs11h_certificate_t certificate, char *serial, size_t serial_len)
 {
     X509 *x509 = NULL;
     BIO *bio = NULL;
     int ret = 1;
-    int n;
 
     if ((x509 = pkcs11h_openssl_getX509(certificate)) == NULL)
     {
@@ -454,7 +448,8 @@
     }
 
     i2a_ASN1_INTEGER(bio, X509_get_serialNumber(x509));
-    n = BIO_read(bio, serial, serial_len - 1);
+    ASSERT(serial_len <= INT_MAX);
+    int n = BIO_read(bio, serial, (int)serial_len - 1);
 
     if (n < 0)
     {
@@ -474,8 +469,4 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* defined(ENABLE_PKCS11) && defined(ENABLE_OPENSSL) */

