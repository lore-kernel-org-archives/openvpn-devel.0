From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  6 Sep 2024 12:38:14 +0200
Message-Id: <20240906103814.36839-1-frank@...2641...>
In-Reply-To: <gerrit.1724095724000.Ic6f089896191145f68ce9a11023587d05dcec4d8@...2715...>
References: <gerrit.1724095724000.Ic6f089896191145f68ce9a11023587d05dcec4d8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add a test for loading certificate and
 key to ssl context
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

From: Selva Nair <selva.nair@...277...>

The test certificate used in test_ssl.c is updated to use 2048 bit
RSA and the matching key is added.

Tests include loading certificate and key as inlined pem as well as
from files. Note that loading the key also checks that it matches
the certificate, providing an indirect test that the latter was loaded
correctly.

Change-Id: Ic6f089896191145f68ce9a11023587d05dcec4d8
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/729
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index da50e55..a5c58a0 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -79,18 +79,58 @@
     return;
 }
 
-const char *unittest_cert = "-----BEGIN CERTIFICATE-----\n"
-                            "MIIBuTCCAUCgAwIBAgIUTLtjSBzx53qZRvZ6Ur7D9kgoOHkwCgYIKoZIzj0EAwIw\n"
-                            "EzERMA8GA1UEAwwIdW5pdHRlc3QwIBcNMjMxMTIxMDk1NDQ3WhgPMjA3ODA4MjQw\n"
-                            "OTU0NDdaMBMxETAPBgNVBAMMCHVuaXR0ZXN0MHYwEAYHKoZIzj0CAQYFK4EEACID\n"
-                            "YgAEHYB2hn2xx3f4lClXDtdi36P19pMZA+kI1Dkv/Vn10vBZ/j9oa+P99T8duz/e\n"
-                            "QlPeHpesNJO4fX8iEDj6+vMeWejOT7jAQ4MmG5EZjpcBKxCfwFooEvzu8bVujUcu\n"
-                            "wTQEo1MwUTAdBgNVHQ4EFgQUPcgBEVXjF5vYfDsInoE3dF6UfQswHwYDVR0jBBgw\n"
-                            "FoAUPcgBEVXjF5vYfDsInoE3dF6UfQswDwYDVR0TAQH/BAUwAwEB/zAKBggqhkjO\n"
-                            "PQQDAgNnADBkAjBLPAGrQAyinigqiu0RomoV8TVaknVLFSq6H6A8jgvzfsFCUK1O\n"
-                            "dvNZhFPM6idKB+oCME2JLOBANCSV8o7aJzq7SYHKwPyb1J4JFlwKe/0Jpv7oh9b1\n"
-                            "IJbuaM9Z/VSKbrIXGg==\n"
-                            "-----END CERTIFICATE-----\n";
+static const char *const unittest_cert =
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIDYzCCAkugAwIBAgIRALrXTx4lqa8QgF7uGjISxmcwDQYJKoZIhvcNAQELBQAw\n"
+    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjA5MThaGA8yMTIz\n"
+    "MDIxNzE2MDkxOFowGTEXMBUGA1UEAwwOb3Zwbi10ZXN0LXJzYTEwggEiMA0GCSqG\n"
+    "SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7xFoR6fmoyfsJIQDKKgbYgFw0MzVuDAmp\n"
+    "Rx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/4dRR3skisBug6Vd5LXeB\n"
+    "GZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159x9FBDl5A3sLP18ubeex0\n"
+    "pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwTPnS+CRXrSq4JjGDJLsXl\n"
+    "0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIhLbG2DcIv8l29EuEj2w3j\n"
+    "u/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJcDjOZVCArAgMBAAGjgaQw\n"
+    "gaEwCQYDVR0TBAIwADAdBgNVHQ4EFgQUqYnRaBHrZmKLtMZES5AuwqzJkGYwUwYD\n"
+    "VR0jBEwwSoAU3MLDNDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9W\n"
+    "UE4gVEVTVCBDQTGCFD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsG\n"
+    "AQUFBwMCMAsGA1UdDwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAZVcXrezA9Aby\n"
+    "sfUNHAsMxrex/EO0PrIPSrmSmc9sCiD8cCIeB6kL8c5iPPigoWW0uLA9zteDRFes\n"
+    "ez+Z8wBY6g8VQ0tFPURDooUg5011GZPDcuw7/PsI4+I2J9q6LHEp+6Oo4faSn/kl\n"
+    "yWYCLjM4FZdGXbOijDacQJiN6HcRv0UdodBrEVRf7YHJJmMCbCI7ZUGW2zef/+rO\n"
+    "e4Lkxh0MLYqCkNKH5ZfoGTC4Oeb0xKykswAanqgR60r+upaLU8PFuI2L9M3vc6KU\n"
+    "F6MgVGSxl6eylJgDYckvJiAbmcp2PD/LRQQOxQA0yqeAMg2cbdvclETuYD6zoFfu\n"
+    "Y8aO7dvDlw==\n"
+    "-----END CERTIFICATE-----\n";
+
+static const char *const unittest_key =
+    "-----BEGIN PRIVATE KEY-----\n"
+    "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n"
+    "IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/\n"
+    "4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159\n"
+    "x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n"
+    "PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n"
+    "LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJc\n"
+    "DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn2rf\n"
+    "v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n"
+    "EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n"
+    "slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n"
+    "BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n"
+    "U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8apOs/17\n"
+    "YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF4j/kX1ZWG\n"
+    "k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0lyBymdKA3p/i5Dx+8Nc9cGns\n"
+    "LGI9MvviLX7pQFIkvbaCkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n"
+    "UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n"
+    "4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+QW82hqSvEwSsvnwwn3eOW\n"
+    "nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxBDIID/4gaZxoMJP\n"
+    "hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw\n"
+    "qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n"
+    "+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n"
+    "UVveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n"
+    "Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAorc3PAX7M0bsQrrqYxUS8\n"
+    "56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAGOCCZrTcI3Ejg\n"
+    "xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0\n"
+    "ZbX6nKcJ7jciJVKJds59Jg==\n"
+    "-----END PRIVATE KEY-----\n";
 
 static const char *
 get_tmp_dir(void)
@@ -105,6 +145,44 @@
     return ret;
 }
 
+static struct
+{
+    struct gc_arena gc;
+    const char *certfile;
+    const char *keyfile;
+} global_state;
+
+static int
+init(void **state)
+{
+    (void) state;
+    global_state.gc = gc_new();
+    global_state.certfile = platform_create_temp_file(get_tmp_dir(), "cert", &global_state.gc);
+    global_state.keyfile = platform_create_temp_file(get_tmp_dir(), "key", &global_state.gc);
+
+    int certfd = open(global_state.certfile, O_RDWR);
+    int keyfd = open(global_state.keyfile, O_RDWR);
+    if (certfd < 0 || keyfd < 0)
+    {
+        fail_msg("make tmpfile for certificate or key data failed (error = %d)", errno);
+    }
+    assert_int_equal(write(certfd, unittest_cert, strlen(unittest_cert)), strlen(unittest_cert));
+    assert_int_equal(write(keyfd, unittest_key, strlen(unittest_key)), strlen(unittest_key));
+    close(certfd);
+    close(keyfd);
+    return 0;
+}
+
+static int
+cleanup(void **state)
+{
+    (void) state;
+    unlink(global_state.certfile);
+    unlink(global_state.keyfile);
+    gc_free(&global_state.gc);
+    return 0;
+}
+
 static void
 crypto_pem_encode_certificate(void **state)
 {
@@ -136,6 +214,27 @@
 }
 
 static void
+test_load_certificate_and_key(void **state)
+{
+    (void) state;
+    struct tls_root_ctx ctx = { 0 };
+
+    /* test loading of inlined cert and key.
+     * loading the key also checks that it matches the loaded certificate
+     */
+    tls_ctx_client_new(&ctx);
+    tls_ctx_load_cert_file(&ctx, unittest_cert, true);
+    assert_int_equal(tls_ctx_load_priv_file(&ctx, unittest_key, true), 0);
+    tls_ctx_free(&ctx);
+
+    /* test loading of cert and key from file */
+    tls_ctx_client_new(&ctx);
+    tls_ctx_load_cert_file(&ctx, global_state.certfile, false);
+    assert_int_equal(tls_ctx_load_priv_file(&ctx, global_state.keyfile, false), 0);
+    tls_ctx_free(&ctx);
+}
+
+static void
 init_implicit_iv(struct crypto_options *co)
 {
     cipher_ctx_t *cipher = co->key_ctx_bi.encrypt.cipher;
@@ -369,6 +468,7 @@
 
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(crypto_pem_encode_certificate),
+        cmocka_unit_test(test_load_certificate_and_key),
         cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm),
         cmocka_unit_test(test_data_channel_roundtrip_aes_192_gcm),
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),
@@ -383,7 +483,7 @@
     tls_init_lib();
 #endif
 
-    int ret = cmocka_run_group_tests_name("ssl tests", tests, NULL, NULL);
+    int ret = cmocka_run_group_tests_name("ssl tests", tests, init, cleanup);
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
     tls_free_lib();

