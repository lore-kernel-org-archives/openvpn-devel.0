From: selva.nair@...277...
Date: Tue, 14 Mar 2023 21:35:13 -0400
Message-Id: <20230315013516.1256700-2-selva.nair@...277...>
In-Reply-To: <20230315013516.1256700-1-selva.nair@...277...>
References: <20230315013516.1256700-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Import some sample certificates into
 Windows store for testing
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

- A few sample certificates are defined and imported into
  Windows certificate store (user store).
  This only tests the import process. Use of these certs to test the
  core functionality of 'cryptoapicert' are in following commits.

Change-Id: Ida5fc12c5bad5fde202da0bf0e8cdc71efe548c2
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 tests/unit_tests/openvpn/cert_data.h      | 166 ++++++++++++++++++++++
 tests/unit_tests/openvpn/test_cryptoapi.c | 160 ++++++++++++++++++++-
 2 files changed, 324 insertions(+), 2 deletions(-)
 create mode 100644 tests/unit_tests/openvpn/cert_data.h

diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h
new file mode 100644
index 00000000..33de35ec
--- /dev/null
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -0,0 +1,166 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 Selva Nair <selva.nair@...277...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation, either version 2 of the License,
+ *  or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef CERT_DATA_H
+#define CERT_DATA_H
+
+/* Some certificates and their private keys for testing cryptoapi.c.
+ * Two certificates, cert1 (EC) and cert3 (RSA) are signed by one CA
+ * and the other two, cert2 (EC) and cert4 (RSA), by another to have a
+ * different issuer name. The common name of cert4 is the same as
+ * that of cert3 but the former has expired. It is used to test
+ * retrieval of valid certificate by name when an expired one with same
+ * common name exists.
+ * To reduce data volume, certs of same keytype use the same private key.
+ */
+
+/* sample-ec.crt */
+static const char *const cert1 =
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIClzCCAX+gAwIBAgIRAIJr3cy95V63CPEtaAA8JN4wDQYJKoZIhvcNAQELBQAw\n"
+    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjExMjhaGA8yMTIz\n"
+    "MDIxNzE2MTEyOFowGDEWMBQGA1UEAwwNb3Zwbi10ZXN0LWVjMTBZMBMGByqGSM49\n"
+    "AgEGCCqGSM49AwEHA0IABHhJG+dK4Z0mY+K0pupwVtyDLOwwGWHjBY6u3LgjRmUh\n"
+    "fFjaoSfJvdgrPg50wbOkrsUt9Bl6EeDosZuVwuzgRbujgaQwgaEwCQYDVR0TBAIw\n"
+    "ADAdBgNVHQ4EFgQUPWeU5BEmD8VEOSKeNf9kAvhcVuowUwYDVR0jBEwwSoAU3MLD\n"
+    "NDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9WUE4gVEVTVCBDQTGC\n"
+    "FD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsGAQUFBwMCMAsGA1Ud\n"
+    "DwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAhH/wOFqP4R+FK5QvU+oW/XacFMku\n"
+    "+qT8lL9J7BG28WhZ0ZcAy/AmtnyynkDyuZSwnlzGgJ5m4L/RfwTzJKhEHiSU3BvB\n"
+    "5C1Z1Q8k67MHSfb565iCn8GzPUQLK4zsILCoTkJPvimv2bJ/RZmNaD+D4LWiySD4\n"
+    "tuOEdHKrxIrbJ5eAaN0WxRrvDdwGlyPvbMFvfhXzd/tbkP4R2xvlm7S2DPeSTJ8s\n"
+    "srXMaPe0lAea4etMSZsjIRPwGRMXBrwbRmb6iN2Cq40867HdaJoAryYig7IiDwSX\n"
+    "htCbOA6sX+60+FEOYDEx5cmkogl633Pw7LJ3ICkyzIrUSEt6BOT1Gsc1eQ==\n"
+    "-----END CERTIFICATE-----\n";
+static const char *const key1 =
+    "-----BEGIN PRIVATE KEY-----\n"
+    "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg5Xpw/lLvBrWjAWDq\n"
+    "L6dm/4a1or6AQ6O3yXYgw78B23ihRANCAAR4SRvnSuGdJmPitKbqcFbcgyzsMBlh\n"
+    "4wWOrty4I0ZlIXxY2qEnyb3YKz4OdMGzpK7FLfQZehHg6LGblcLs4EW7\n"
+    "-----END PRIVATE KEY-----\n";
+static const char *const hash1 = "A4B74F1D68AF50691F62CBD675E24C8655369567";
+static const char *const cname1 = "ovpn-test-ec1";
+
+static const char *const cert2 =
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIClzCCAX+gAwIBAgIRAN9fIkTDOjX0Bd9adHVcLx8wDQYJKoZIhvcNAQELBQAw\n"
+    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMjAgFw0yMzAzMTMxODAzMzFaGA8yMTIz\n"
+    "MDIxNzE4MDMzMVowGDEWMBQGA1UEAwwNb3Zwbi10ZXN0LWVjMjBZMBMGByqGSM49\n"
+    "AgEGCCqGSM49AwEHA0IABHhJG+dK4Z0mY+K0pupwVtyDLOwwGWHjBY6u3LgjRmUh\n"
+    "fFjaoSfJvdgrPg50wbOkrsUt9Bl6EeDosZuVwuzgRbujgaQwgaEwCQYDVR0TBAIw\n"
+    "ADAdBgNVHQ4EFgQUPWeU5BEmD8VEOSKeNf9kAvhcVuowUwYDVR0jBEwwSoAUyX3c\n"
+    "tpRP5cKlESsG80rOGhEphsGhHKQaMBgxFjAUBgNVBAMMDU9WUE4gVEVTVCBDQTKC\n"
+    "FBc8ra53hwYrlIkdY3Ay1WCrrHJ8MBMGA1UdJQQMMAoGCCsGAQUFBwMCMAsGA1Ud\n"
+    "DwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAWmA40BvEgBbKb1ReKlKzk64xi2ak\n"
+    "4tyr3sW9wIYQ2N1zkSomwEV6wGEawLqPADRbXiYdjtAqLz12OJvBnBwgxN3dVmqL\n"
+    "6UN4ZIwMWJ4fSW9vK/Nt+JNwebN+Jgw/nIXvSdK95ha4iusZZOIZ4qDj3DWwjhjV\n"
+    "L5/m6zP09L9G9/79j1Tsu4Stl5SI1XxtYc0eVn29vJEMBfpsS7pPD6V9JpY3Y1f3\n"
+    "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n"
+    "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA==\n"
+    "-----END CERTIFICATE-----\n";
+static const char *const key2 = key1;
+static const char *const hash2 = "FA18FD34BAABE47D6E2910E080F421C109CA97F5";
+static const char *const cname2 = "ovpn-test-ec2";
+
+static const char *const cert3 =
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
+static const char *const key3 =
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
+static const char *const hash3 = "2463628674E362578113F508BA05F29EF142E979";
+static const char *const cname3 = "ovpn-test-rsa1";
+
+static const char *const cert4 =
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIDYTCCAkmgAwIBAgIRAPTJucQy27qoIv0oYoE71z8wDQYJKoZIhvcNAQELBQAw\n"
+    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMjAeFw0yMzAzMTMxNzQ2MDNaFw0yMzAz\n"
+    "MTQxNzQ2MDNaMBkxFzAVBgNVBAMMDm92cG4tdGVzdC1yc2ExMIIBIjANBgkqhkiG\n"
+    "9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu8RaEen5qMn7CSEAyioG2IBcNDM1bgwJqUce\n"
+    "ikxIoYE3IZEMfXx3XVmyojlG3BJ0Ityzbsez+EFZf+HUUd7JIrAboOlXeS13gRma\n"
+    "pqbuV2YheA4C89ZV9tRtGjqIBVpIntqhhHLKONNefcfRQQ5eQN7Cz9fLm3nsdKXf\n"
+    "wcwxb+kizk8lVjvxgjXPCF/4tLjeJi76FVNNEnqsEz50vgkV60quCYxgyS7F5dPz\n"
+    "5cZI7IFNMjjgNGdnfBc5N8ApcD+h3OPQTjFirLVCIS2xtg3CL/JdvRLhI9sN47v+\n"
+    "4JHsKJfel0NrcKT76aFQGolYf5u4UFHEDkUAg+niXA4zmVQgKwIDAQABo4GkMIGh\n"
+    "MAkGA1UdEwQCMAAwHQYDVR0OBBYEFKmJ0WgR62Zii7TGREuQLsKsyZBmMFMGA1Ud\n"
+    "IwRMMEqAFMl93LaUT+XCpRErBvNKzhoRKYbBoRykGjAYMRYwFAYDVQQDDA1PVlBO\n"
+    "IFRFU1QgQ0EyghQXPK2ud4cGK5SJHWNwMtVgq6xyfDATBgNVHSUEDDAKBggrBgEF\n"
+    "BQcDAjALBgNVHQ8EBAMCB4AwDQYJKoZIhvcNAQELBQADggEBAFjJvZFwhY77UOWu\n"
+    "O6n5yLxcG6/VNWMbD0CazZP8pBqCGJRU9Rq0vXxZ00E0WSYTJLZoq1aFmeWIX0vZ\n"
+    "sudVkdbfWLdiwuQZDWBS+qC4SkIcnNe5FYSSUlXlvpSUN2CgGCLmryP+SZKHp8YV\n"
+    "e37pQxDjImXCu5Jdk5AhK6pkFm5IMskdTKfWJjjR69lBgWHPoM2WAwkV8vxKdpy8\n"
+    "0Bqef8MZZM+qVYw7OguAFos2Am7waLpa3q9SYqCRYctq4Q2++p2WjINv3nkXIwYS\n"
+    "353PpJJ9s2b/Fqoc4d7udqhQogA7jqbayTKhJxbT134l2NzqDROzuS0kXbX8bXCi\n"
+    "mXSa4c8=\n"
+    "-----END CERTIFICATE-----\n";
+static const char *const key4 = key3;
+static const char *const hash4 = "E1401D4497C944783E3D62CDBD2A1F69F5E5071E";
+static const char *const cname4 = cname3; /* same CN as that of cert3 */
+
+#endif /* CERT_DATA_H */
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 73ef34e9..54dbd094 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -32,6 +32,7 @@
 #include "manage.h"
 #include "integer.h"
 #include "xkey_common.h"
+#include "cert_data.h"
 
 #if defined(HAVE_XKEY_PROVIDER) && defined (ENABLE_CRYPTOAPI)
 #include <setjmp.h>
@@ -40,6 +41,7 @@
 #include <openssl/pem.h>
 #include <openssl/core_names.h>
 #include <openssl/evp.h>
+#include <openssl/pkcs12.h>
 
 #include <cryptoapi.h>
 #include <cryptoapi.c> /* pull-in the whole file to test static functions */
@@ -84,6 +86,157 @@ static const char *invalid_str[] = {
     "7738x5001e9648c6570baec0b796f9664d5fd0b7",   /* non hex character */
 };
 
+/* Test certificate database: data for cert1, cert2 .. key1, key2 etc.
+ * are stashed away in cert_data.h
+ */
+static struct test_cert
+{
+    const char *const cert;             /* certificate as PEM */
+    const char *const key;              /* key as unencrypted PEM */
+    const char *const cname;            /* common-name */
+    const char *const issuer;           /* issuer common-name */
+    const char *const friendly_name;    /* identifies certs loaded to the store -- keep unique */
+    const char *hash;                   /* SHA1 fingerprint */
+    int valid;                          /* nonzero if certificate has not expired */
+} certs[] = {
+    {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  hash1,  1},
+    {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  hash2,  1},
+    {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  hash3,  1},
+    {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  hash4,  0},
+    {}
+};
+
+static bool certs_loaded;
+static HCERTSTORE user_store;
+
+/* Lookup a certificate in our certificate/key db */
+static struct test_cert *
+lookup_cert(const char *friendly_name)
+{
+    struct test_cert *c = certs;
+    while (c->cert && strcmp(c->friendly_name, friendly_name))
+    {
+        c++;
+    }
+    return c->cert ? c : NULL;
+}
+
+/* import sample certificates into windows cert store */
+static void
+import_certs(void **state)
+{
+    (void) state;
+    if (certs_loaded)
+    {
+        return;
+    }
+    user_store = CertOpenStore(CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_CURRENT_USER
+                               |CERT_STORE_OPEN_EXISTING_FLAG, L"MY");
+    assert_non_null(user_store);
+    for (struct test_cert *c = certs; c->cert; c++)
+    {
+        /* Convert PEM cert & key to pkcs12 and import */
+        const char *pass = "opensesame";        /* some password */
+        const wchar_t *wpass = L"opensesame";   /* same as a wide string */
+
+        X509 *x509 = NULL;
+        EVP_PKEY *pkey = NULL;
+
+        BIO *buf = BIO_new_mem_buf(c->cert, -1);
+        if (buf)
+        {
+            x509 = PEM_read_bio_X509(buf, NULL, NULL, NULL);
+        }
+        BIO_free(buf);
+
+        buf = BIO_new_mem_buf(c->key, -1);
+        if (buf)
+        {
+            pkey = PEM_read_bio_PrivateKey(buf, NULL, NULL, NULL);
+        }
+        BIO_free(buf);
+
+        if (!x509 || !pkey)
+        {
+            fail_msg("Failed to parse certificate/key data: <%s>", c->friendly_name);
+            return;
+        }
+
+        PKCS12 *p12 = PKCS12_create(pass, c->friendly_name, pkey, x509, NULL, 0, 0, 0, 0, 0);
+        X509_free(x509);
+        EVP_PKEY_free(pkey);
+        if (!p12)
+        {
+            fail_msg("Failed to convert to PKCS12: <%s>", c->friendly_name);
+            return;
+        }
+
+        CRYPT_DATA_BLOB blob = {.cbData = 0, .pbData = NULL};
+        int len = i2d_PKCS12(p12, &blob.pbData); /* pbData will be allocated by OpenSSL */
+        if (len <= 0)
+        {
+            fail_msg("Failed to DER encode PKCS12: <%s>", c->friendly_name);
+            return;
+        }
+        blob.cbData = len;
+
+        DWORD flags = PKCS12_ALLOW_OVERWRITE_KEY|PKCS12_ALWAYS_CNG_KSP;
+        HCERTSTORE tmp_store = PFXImportCertStore(&blob, wpass, flags);
+        PKCS12_free(p12);
+        OPENSSL_free(blob.pbData);
+
+        assert_non_null(tmp_store);
+
+        /* The cert and key get imported into a temp store. We have to move it to
+         * user's store to accumulate all certs in one place and use them for tests.
+         * It seems there is no API to directly import a p12 blob into an existing store.
+         * Nothing in Windows is ever easy.
+         */
+
+        const CERT_CONTEXT *ctx = CertEnumCertificatesInStore(tmp_store, NULL);
+        assert_non_null(ctx);
+        bool added = CertAddCertificateContextToStore(user_store, ctx,
+                                                      CERT_STORE_ADD_REPLACE_EXISTING, NULL);
+        assert_true(added);
+
+        CertFreeCertificateContext(ctx);
+        CertCloseStore(tmp_store, 0);
+    }
+    certs_loaded = true;
+}
+
+static int
+cleanup(void **state)
+{
+    (void) state;
+    struct gc_arena gc = gc_new();
+    if (user_store) /* delete all certs we imported */
+    {
+        const CERT_CONTEXT *ctx = NULL;
+        while ((ctx = CertEnumCertificatesInStore(user_store, ctx)))
+        {
+            char *friendly_name = get_cert_name(ctx, &gc);
+            if (!lookup_cert(friendly_name)) /* not our cert */
+            {
+                continue;
+            }
+
+            /* create a dup context to not destroy the state of loop iterator */
+            const CERT_CONTEXT *ctx_dup = CertDuplicateCertificateContext(ctx);
+            if (ctx_dup)
+            {
+                CertDeleteCertificateFromStore(ctx_dup);
+                /* the above also releases ctx_dup */
+            }
+        }
+        CertCloseStore(user_store, 0);
+    }
+    user_store = NULL;
+    certs_loaded = false;
+    gc_free(&gc);
+    return 0;
+}
+
 static void
 test_parse_hexstring(void **state)
 {
@@ -108,9 +261,12 @@ test_parse_hexstring(void **state)
 int
 main(void)
 {
-    const struct CMUnitTest tests[] = { cmocka_unit_test(test_parse_hexstring) };
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(test_parse_hexstring),
+        cmocka_unit_test(import_certs),
+    };
 
-    int ret = cmocka_run_group_tests_name("cryptoapi tests", tests, NULL, NULL);
+    int ret = cmocka_run_group_tests_name("cryptoapi tests", tests, NULL, cleanup);
 
     return ret;
 }
-- 
2.34.1


