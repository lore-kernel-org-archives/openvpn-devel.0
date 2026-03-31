From: Gert Doering <gert@...1296...>
Date: Tue, 31 Mar 2026 19:33:57 +0200
Message-ID: <20260331173403.3082-1-gert@...1296...>
In-Reply-To: <gerrit.1774974242000.Iacbd8195cdedc7226bddc686ca8dccf9f25f8842@...2715...>
References: <gerrit.1774974242000.Iacbd8195cdedc7226bddc686ca8dccf9f25f8842@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add unit test for printing various
 details of certificates
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

These unit tests will ensure that refactoring of these methods does not
change the output.

Change-Id: Iacbd8195cdedc7226bddc686ca8dccf9f25f8842
Signed-off-by: Arne Schwabe <arne@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1598
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1598
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 2b73ee7..0e9cecf 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -46,7 +46,9 @@
 #include "test_common.h"
 #include "ssl.h"
 #include "buffer.h"
+#include "cert_data.h"
 #include "packet_id.h"
+#include "ssl_verify.h"
 
 /* Mock function to be allowed to include win32.c which is required for
  * getting the temp directory */
@@ -750,6 +752,83 @@
     test_data_channel_known_vectors_run(false);
 }
 
+#if defined(ENABLE_CRYPTO_MBEDTLS)
+static openvpn_x509_cert_t *
+get_certificate(const char *cert_str)
+{
+    mbedtls_x509_crt *cert;
+    ALLOC_OBJ_CLEAR(cert, mbedtls_x509_crt);
+    int ret = mbedtls_x509_crt_parse(cert, (const unsigned char *)cert_str,
+                                     strlen(cert_str) + 1);
+
+    assert_int_equal(ret, 0);
+    return cert;
+}
+
+static void
+free_certificate(openvpn_x509_cert_t *cert)
+{
+    mbedtls_x509_crt_free(cert);
+    free(cert);
+}
+#else
+static openvpn_x509_cert_t *
+get_certificate(const char *cert_str)
+{
+    BIO *in = BIO_new_mem_buf((char *)cert1, -1);
+    assert_non_null(in);
+    X509 *cert = PEM_read_bio_X509(in, NULL, NULL, NULL);
+    assert_non_null(cert);
+    BIO_free(in);
+    return cert;
+}
+
+static void
+free_certificate(openvpn_x509_cert_t *cert)
+{
+    X509_free(cert);
+}
+#endif
+
+void
+crypto_test_print_cert_details(void **state)
+{
+    openvpn_x509_cert_t *cert = get_certificate(cert1);
+    struct gc_arena gc = gc_new();
+
+    const char *fp = backend_x509_get_serial_hex(cert, &gc);
+
+    /* we messed this up between TLS libraries. But let's at least notice in
+     * the future ...*/
+#if defined(ENABLE_CRYPTO_MBEDTLS)
+    assert_string_equal(fp, "82:6B:DD:CC:BD:E5:5E:B7:08:F1:2D:68:00:3C:24:DE");
+#else
+    assert_string_equal(fp, "82:6b:dd:cc:bd:e5:5e:b7:08:f1:2d:68:00:3c:24:de");
+#endif
+
+    const char *sn = backend_x509_get_serial(cert, &gc);
+    assert_string_equal(sn, "173359713849739808110610111821055272158");
+
+    char username[TLS_USERNAME_LEN + 1] = { 0 }; /* null-terminated */
+
+    int ret = backend_x509_get_username(username, sizeof(username), "CN",
+                                        cert);
+
+    assert_string_equal(username, "ovpn-test-ec1");
+    assert_int_equal(ret, SUCCESS);
+
+#ifndef ENABLE_CRYPTO_MBEDTLS
+    /* mbed TLS does not implement this */
+    ret = backend_x509_get_username(username, sizeof(username), "serialNumber",
+                                    cert);
+    assert_int_equal(ret, SUCCESS);
+    assert_string_equal(username, "0x826BDDCCBDE55EB708F12D68003C24DE");
+#endif
+
+    gc_free(&gc);
+    free_certificate(cert);
+}
+
 
 int
 main(void)
@@ -773,7 +852,9 @@
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
         cmocka_unit_test(test_data_channel_known_vectors_epoch),
-        cmocka_unit_test(test_data_channel_known_vectors_shortpktid)
+        cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
+        cmocka_unit_test(crypto_test_print_cert_details)
+
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

