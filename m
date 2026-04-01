From: Gert Doering <gert@...1296...>
Date: Wed,  1 Apr 2026 12:22:42 +0200
Message-ID: <20260401102247.21915-1-gert@...1296...>
In-Reply-To: <gerrit.1774974242000.Id8680e6555a66024417d6eb9322d4fde79922453@...2715...>
References: <gerrit.1774974242000.Id8680e6555a66024417d6eb9322d4fde79922453@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Rename key* to privkey* in cert_data.h
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

The name key2 conflicts with our struct key2 and prevents these
test keys from being used in test_ssl.c

Change-Id: Id8680e6555a66024417d6eb9322d4fde79922453
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1597
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1597
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h
index c5d897e..9c16929 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -52,11 +52,11 @@
     "srXMaPe0lAea4etMSZsjIRPwGRMXBrwbRmb6iN2Cq40867HdaJoAryYig7IiDwSX\n"
     "htCbOA6sX+60+FEOYDEx5cmkogl633Pw7LJ3ICkyzIrUSEt6BOT1Gsc1eQ==\n"
     "-----END CERTIFICATE-----\n";
-static const char *const key1 = "-----BEGIN PRIVATE KEY-----\n"
-                                "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg5Xpw/lLvBrWjAWDq\n"
-                                "L6dm/4a1or6AQ6O3yXYgw78B23ihRANCAAR4SRvnSuGdJmPitKbqcFbcgyzsMBlh\n"
-                                "4wWOrty4I0ZlIXxY2qEnyb3YKz4OdMGzpK7FLfQZehHg6LGblcLs4EW7\n"
-                                "-----END PRIVATE KEY-----\n";
+static const char *const privkey1 = "-----BEGIN PRIVATE KEY-----\n"
+                                    "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg5Xpw/lLvBrWjAWDq\n"
+                                    "L6dm/4a1or6AQ6O3yXYgw78B23ihRANCAAR4SRvnSuGdJmPitKbqcFbcgyzsMBlh\n"
+                                    "4wWOrty4I0ZlIXxY2qEnyb3YKz4OdMGzpK7FLfQZehHg6LGblcLs4EW7\n"
+                                    "-----END PRIVATE KEY-----\n";
 static const char *const hash1 = "A4B74F1D68AF50691F62CBD675E24C8655369567";
 static const char *const cname1 = "ovpn-test-ec1";
 
@@ -77,7 +77,7 @@
     "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n"
     "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA==\n"
     "-----END CERTIFICATE-----\n";
-#define key2 key1
+#define privkey2 privkey1
 static const char *const hash2 = "FA18FD34BAABE47D6E2910E080F421C109CA97F5";
 static const char *const cname2 = "ovpn-test-ec2";
 
@@ -103,34 +103,34 @@
     "F6MgVGSxl6eylJgDYckvJiAbmcp2PD/LRQQOxQA0yqeAMg2cbdvclETuYD6zoFfu\n"
     "Y8aO7dvDlw==\n"
     "-----END CERTIFICATE-----\n";
-static const char *const key3 = "-----BEGIN PRIVATE KEY-----\n"
-                                "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n"
-                                "IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/\n"
-                                "4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159\n"
-                                "x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n"
-                                "PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n"
-                                "LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJc\n"
-                                "DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn2rf\n"
-                                "v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n"
-                                "EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n"
-                                "slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n"
-                                "BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n"
-                                "U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8apOs/17\n"
-                                "YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF4j/kX1ZWG\n"
-                                "k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0lyBymdKA3p/i5Dx+8Nc9cGns\n"
-                                "LGI9MvviLX7pQFIkvbaCkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n"
-                                "UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n"
-                                "4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+QW82hqSvEwSsvnwwn3eOW\n"
-                                "nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxBDIID/4gaZxoMJP\n"
-                                "hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw\n"
-                                "qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n"
-                                "+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n"
-                                "UVveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n"
-                                "Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAorc3PAX7M0bsQrrqYxUS8\n"
-                                "56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAGOCCZrTcI3Ejg\n"
-                                "xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0\n"
-                                "ZbX6nKcJ7jciJVKJds59Jg==\n"
-                                "-----END PRIVATE KEY-----\n";
+static const char *const privkey3 = "-----BEGIN PRIVATE KEY-----\n"
+                                    "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n"
+                                    "IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/\n"
+                                    "4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159\n"
+                                    "x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n"
+                                    "PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n"
+                                    "LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJc\n"
+                                    "DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn2rf\n"
+                                    "v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n"
+                                    "EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n"
+                                    "slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n"
+                                    "BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n"
+                                    "U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8apOs/17\n"
+                                    "YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF4j/kX1ZWG\n"
+                                    "k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0lyBymdKA3p/i5Dx+8Nc9cGns\n"
+                                    "LGI9MvviLX7pQFIkvbaCkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n"
+                                    "UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n"
+                                    "4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+QW82hqSvEwSsvnwwn3eOW\n"
+                                    "nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxBDIID/4gaZxoMJP\n"
+                                    "hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw\n"
+                                    "qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n"
+                                    "+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n"
+                                    "UVveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n"
+                                    "Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAorc3PAX7M0bsQrrqYxUS8\n"
+                                    "56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAGOCCZrTcI3Ejg\n"
+                                    "xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0\n"
+                                    "ZbX6nKcJ7jciJVKJds59Jg==\n"
+                                    "-----END PRIVATE KEY-----\n";
 static const char *const hash3 = "2463628674E362578113F508BA05F29EF142E979";
 static const char *const cname3 = "ovpn-test-rsa1";
 
@@ -156,7 +156,7 @@
     "353PpJJ9s2b/Fqoc4d7udqhQogA7jqbayTKhJxbT134l2NzqDROzuS0kXbX8bXCi\n"
     "mXSa4c8=\n"
     "-----END CERTIFICATE-----\n";
-#define key4 key3
+#define privkey4 privkey3
 static const char *const hash4 = "E1401D4497C944783E3D62CDBD2A1F69F5E5071E";
 #define cname4 cname3 /* same CN as that of cert3 */
 
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 59a356d..508afc9 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -115,10 +115,10 @@
 init_cert_data(void)
 {
     struct test_cert certs_local[] = {
-        { cert1, key1, cname1, "OVPN TEST CA1", "OVPN Test Cert 1", hash1, 1 },
-        { cert2, key2, cname2, "OVPN TEST CA2", "OVPN Test Cert 2", hash2, 1 },
-        { cert3, key3, cname3, "OVPN TEST CA1", "OVPN Test Cert 3", hash3, 1 },
-        { cert4, key4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", hash4, 0 },
+        { cert1, privkey1, cname1, "OVPN TEST CA1", "OVPN Test Cert 1", hash1, 1 },
+        { cert2, privkey2, cname2, "OVPN TEST CA2", "OVPN Test Cert 2", hash2, 1 },
+        { cert3, privkey3, cname3, "OVPN TEST CA1", "OVPN Test Cert 3", hash3, 1 },
+        { cert4, privkey4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", hash4, 0 },
         { 0 }
     };
     assert_int_equal(sizeof(certs_local), sizeof(certs));
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 722f9b1..8b6e594 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -142,10 +142,10 @@
 init_cert_data(void)
 {
     struct test_cert certs_local[] = {
-        { cert1, key1, cname1, "OVPN TEST CA1", "OVPN Test Cert 1", { 0 }, NULL },
-        { cert2, key2, cname2, "OVPN TEST CA2", "OVPN Test Cert 2", { 0 }, NULL },
-        { cert3, key3, cname3, "OVPN TEST CA1", "OVPN Test Cert 3", { 0 }, NULL },
-        { cert4, key4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", { 0 }, NULL },
+        { cert1, privkey1, cname1, "OVPN TEST CA1", "OVPN Test Cert 1", { 0 }, NULL },
+        { cert2, privkey2, cname2, "OVPN TEST CA2", "OVPN Test Cert 2", { 0 }, NULL },
+        { cert3, privkey3, cname3, "OVPN TEST CA1", "OVPN Test Cert 3", { 0 }, NULL },
+        { cert4, privkey4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", { 0 }, NULL },
         { 0 }
     };
     assert_int_equal(sizeof(certs_local), sizeof(certs));

