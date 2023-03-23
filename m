From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 23 Mar 2023 15:31:40 +0100
Message-Id: <20230323143140.76949-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] unit_tests: make cert_data.h compile with
 MSVC
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

Currently this is not obvious since we never build the
UTs with MSVC, but it doesn't like the initializers with
"const" variables. They cause
error C2099: initializer is not a constant
when used in an initializer.
So change all of them to preprocessor defines instead.

It also doesn't like the empty initializer.
error C2059: syntax error: '}'

CC: Selva Nair <selva.nair@...277...>
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/unit_tests/openvpn/cert_data.h      | 240 +++++++++++-----------
 tests/unit_tests/openvpn/test_cryptoapi.c |  10 +-
 tests/unit_tests/openvpn/test_pkcs11.c    |  10 +-
 3 files changed, 127 insertions(+), 133 deletions(-)

Notes:
* this is an prereq for my CMake patch but is otherwise independent,
  so submitting separately
* this is on top of Selva's "Unit tests: Test for PKCS#11 using a
  softhsm2 token"

diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h
index 33de35ec..359718bb 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -36,131 +36,125 @@
  */
 
 /* sample-ec.crt */
-static const char *const cert1 =
-    "-----BEGIN CERTIFICATE-----\n"
-    "MIIClzCCAX+gAwIBAgIRAIJr3cy95V63CPEtaAA8JN4wDQYJKoZIhvcNAQELBQAw\n"
-    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjExMjhaGA8yMTIz\n"
-    "MDIxNzE2MTEyOFowGDEWMBQGA1UEAwwNb3Zwbi10ZXN0LWVjMTBZMBMGByqGSM49\n"
-    "AgEGCCqGSM49AwEHA0IABHhJG+dK4Z0mY+K0pupwVtyDLOwwGWHjBY6u3LgjRmUh\n"
-    "fFjaoSfJvdgrPg50wbOkrsUt9Bl6EeDosZuVwuzgRbujgaQwgaEwCQYDVR0TBAIw\n"
-    "ADAdBgNVHQ4EFgQUPWeU5BEmD8VEOSKeNf9kAvhcVuowUwYDVR0jBEwwSoAU3MLD\n"
-    "NDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9WUE4gVEVTVCBDQTGC\n"
-    "FD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsGAQUFBwMCMAsGA1Ud\n"
-    "DwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAhH/wOFqP4R+FK5QvU+oW/XacFMku\n"
-    "+qT8lL9J7BG28WhZ0ZcAy/AmtnyynkDyuZSwnlzGgJ5m4L/RfwTzJKhEHiSU3BvB\n"
-    "5C1Z1Q8k67MHSfb565iCn8GzPUQLK4zsILCoTkJPvimv2bJ/RZmNaD+D4LWiySD4\n"
-    "tuOEdHKrxIrbJ5eAaN0WxRrvDdwGlyPvbMFvfhXzd/tbkP4R2xvlm7S2DPeSTJ8s\n"
-    "srXMaPe0lAea4etMSZsjIRPwGRMXBrwbRmb6iN2Cq40867HdaJoAryYig7IiDwSX\n"
-    "htCbOA6sX+60+FEOYDEx5cmkogl633Pw7LJ3ICkyzIrUSEt6BOT1Gsc1eQ==\n"
-    "-----END CERTIFICATE-----\n";
-static const char *const key1 =
-    "-----BEGIN PRIVATE KEY-----\n"
-    "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg5Xpw/lLvBrWjAWDq\n"
-    "L6dm/4a1or6AQ6O3yXYgw78B23ihRANCAAR4SRvnSuGdJmPitKbqcFbcgyzsMBlh\n"
-    "4wWOrty4I0ZlIXxY2qEnyb3YKz4OdMGzpK7FLfQZehHg6LGblcLs4EW7\n"
-    "-----END PRIVATE KEY-----\n";
-static const char *const hash1 = "A4B74F1D68AF50691F62CBD675E24C8655369567";
-static const char *const cname1 = "ovpn-test-ec1";
+#define cd_cert1 "-----BEGIN CERTIFICATE-----\n" \
+    "MIIClzCCAX+gAwIBAgIRAIJr3cy95V63CPEtaAA8JN4wDQYJKoZIhvcNAQELBQAw\n" \
+    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjExMjhaGA8yMTIz\n" \
+    "MDIxNzE2MTEyOFowGDEWMBQGA1UEAwwNb3Zwbi10ZXN0LWVjMTBZMBMGByqGSM49\n" \
+    "AgEGCCqGSM49AwEHA0IABHhJG+dK4Z0mY+K0pupwVtyDLOwwGWHjBY6u3LgjRmUh\n" \
+    "fFjaoSfJvdgrPg50wbOkrsUt9Bl6EeDosZuVwuzgRbujgaQwgaEwCQYDVR0TBAIw\n" \
+    "ADAdBgNVHQ4EFgQUPWeU5BEmD8VEOSKeNf9kAvhcVuowUwYDVR0jBEwwSoAU3MLD\n" \
+    "NDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9WUE4gVEVTVCBDQTGC\n" \
+    "FD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsGAQUFBwMCMAsGA1Ud\n" \
+    "DwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAhH/wOFqP4R+FK5QvU+oW/XacFMku\n" \
+    "+qT8lL9J7BG28WhZ0ZcAy/AmtnyynkDyuZSwnlzGgJ5m4L/RfwTzJKhEHiSU3BvB\n" \
+    "5C1Z1Q8k67MHSfb565iCn8GzPUQLK4zsILCoTkJPvimv2bJ/RZmNaD+D4LWiySD4\n" \
+    "tuOEdHKrxIrbJ5eAaN0WxRrvDdwGlyPvbMFvfhXzd/tbkP4R2xvlm7S2DPeSTJ8s\n" \
+    "srXMaPe0lAea4etMSZsjIRPwGRMXBrwbRmb6iN2Cq40867HdaJoAryYig7IiDwSX\n" \
+    "htCbOA6sX+60+FEOYDEx5cmkogl633Pw7LJ3ICkyzIrUSEt6BOT1Gsc1eQ==\n" \
+    "-----END CERTIFICATE-----\n"
+#define cd_key1 "-----BEGIN PRIVATE KEY-----\n" \
+    "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg5Xpw/lLvBrWjAWDq\n" \
+    "L6dm/4a1or6AQ6O3yXYgw78B23ihRANCAAR4SRvnSuGdJmPitKbqcFbcgyzsMBlh\n" \
+    "4wWOrty4I0ZlIXxY2qEnyb3YKz4OdMGzpK7FLfQZehHg6LGblcLs4EW7\n" \
+    "-----END PRIVATE KEY-----\n"
+#define cd_hash1 "A4B74F1D68AF50691F62CBD675E24C8655369567"
+#define cd_cname1 "ovpn-test-ec1"
 
-static const char *const cert2 =
-    "-----BEGIN CERTIFICATE-----\n"
-    "MIIClzCCAX+gAwIBAgIRAN9fIkTDOjX0Bd9adHVcLx8wDQYJKoZIhvcNAQELBQAw\n"
-    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMjAgFw0yMzAzMTMxODAzMzFaGA8yMTIz\n"
-    "MDIxNzE4MDMzMVowGDEWMBQGA1UEAwwNb3Zwbi10ZXN0LWVjMjBZMBMGByqGSM49\n"
-    "AgEGCCqGSM49AwEHA0IABHhJG+dK4Z0mY+K0pupwVtyDLOwwGWHjBY6u3LgjRmUh\n"
-    "fFjaoSfJvdgrPg50wbOkrsUt9Bl6EeDosZuVwuzgRbujgaQwgaEwCQYDVR0TBAIw\n"
-    "ADAdBgNVHQ4EFgQUPWeU5BEmD8VEOSKeNf9kAvhcVuowUwYDVR0jBEwwSoAUyX3c\n"
-    "tpRP5cKlESsG80rOGhEphsGhHKQaMBgxFjAUBgNVBAMMDU9WUE4gVEVTVCBDQTKC\n"
-    "FBc8ra53hwYrlIkdY3Ay1WCrrHJ8MBMGA1UdJQQMMAoGCCsGAQUFBwMCMAsGA1Ud\n"
-    "DwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAWmA40BvEgBbKb1ReKlKzk64xi2ak\n"
-    "4tyr3sW9wIYQ2N1zkSomwEV6wGEawLqPADRbXiYdjtAqLz12OJvBnBwgxN3dVmqL\n"
-    "6UN4ZIwMWJ4fSW9vK/Nt+JNwebN+Jgw/nIXvSdK95ha4iusZZOIZ4qDj3DWwjhjV\n"
-    "L5/m6zP09L9G9/79j1Tsu4Stl5SI1XxtYc0eVn29vJEMBfpsS7pPD6V9JpY3Y1f3\n"
-    "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n"
-    "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA==\n"
-    "-----END CERTIFICATE-----\n";
-static const char *const key2 = key1;
-static const char *const hash2 = "FA18FD34BAABE47D6E2910E080F421C109CA97F5";
-static const char *const cname2 = "ovpn-test-ec2";
+#define cd_cert2 "-----BEGIN CERTIFICATE-----\n" \
+    "MIIClzCCAX+gAwIBAgIRAN9fIkTDOjX0Bd9adHVcLx8wDQYJKoZIhvcNAQELBQAw\n" \
+    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMjAgFw0yMzAzMTMxODAzMzFaGA8yMTIz\n" \
+    "MDIxNzE4MDMzMVowGDEWMBQGA1UEAwwNb3Zwbi10ZXN0LWVjMjBZMBMGByqGSM49\n" \
+    "AgEGCCqGSM49AwEHA0IABHhJG+dK4Z0mY+K0pupwVtyDLOwwGWHjBY6u3LgjRmUh\n" \
+    "fFjaoSfJvdgrPg50wbOkrsUt9Bl6EeDosZuVwuzgRbujgaQwgaEwCQYDVR0TBAIw\n" \
+    "ADAdBgNVHQ4EFgQUPWeU5BEmD8VEOSKeNf9kAvhcVuowUwYDVR0jBEwwSoAUyX3c\n" \
+    "tpRP5cKlESsG80rOGhEphsGhHKQaMBgxFjAUBgNVBAMMDU9WUE4gVEVTVCBDQTKC\n" \
+    "FBc8ra53hwYrlIkdY3Ay1WCrrHJ8MBMGA1UdJQQMMAoGCCsGAQUFBwMCMAsGA1Ud\n" \
+    "DwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAWmA40BvEgBbKb1ReKlKzk64xi2ak\n" \
+    "4tyr3sW9wIYQ2N1zkSomwEV6wGEawLqPADRbXiYdjtAqLz12OJvBnBwgxN3dVmqL\n" \
+    "6UN4ZIwMWJ4fSW9vK/Nt+JNwebN+Jgw/nIXvSdK95ha4iusZZOIZ4qDj3DWwjhjV\n" \
+    "L5/m6zP09L9G9/79j1Tsu4Stl5SI1XxtYc0eVn29vJEMBfpsS7pPD6V9JpY3Y1f3\n" \
+    "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n" \
+    "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA==\n" \
+    "-----END CERTIFICATE-----\n"
+#define cd_key2 cd_key1
+#define cd_hash2 "FA18FD34BAABE47D6E2910E080F421C109CA97F5"
+#define cd_cname2 "ovpn-test-ec2"
 
-static const char *const cert3 =
-    "-----BEGIN CERTIFICATE-----\n"
-    "MIIDYzCCAkugAwIBAgIRALrXTx4lqa8QgF7uGjISxmcwDQYJKoZIhvcNAQELBQAw\n"
-    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjA5MThaGA8yMTIz\n"
-    "MDIxNzE2MDkxOFowGTEXMBUGA1UEAwwOb3Zwbi10ZXN0LXJzYTEwggEiMA0GCSqG\n"
-    "SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7xFoR6fmoyfsJIQDKKgbYgFw0MzVuDAmp\n"
-    "Rx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/4dRR3skisBug6Vd5LXeB\n"
-    "GZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159x9FBDl5A3sLP18ubeex0\n"
-    "pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwTPnS+CRXrSq4JjGDJLsXl\n"
-    "0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIhLbG2DcIv8l29EuEj2w3j\n"
-    "u/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJcDjOZVCArAgMBAAGjgaQw\n"
-    "gaEwCQYDVR0TBAIwADAdBgNVHQ4EFgQUqYnRaBHrZmKLtMZES5AuwqzJkGYwUwYD\n"
-    "VR0jBEwwSoAU3MLDNDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9W\n"
-    "UE4gVEVTVCBDQTGCFD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsG\n"
-    "AQUFBwMCMAsGA1UdDwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAZVcXrezA9Aby\n"
-    "sfUNHAsMxrex/EO0PrIPSrmSmc9sCiD8cCIeB6kL8c5iPPigoWW0uLA9zteDRFes\n"
-    "ez+Z8wBY6g8VQ0tFPURDooUg5011GZPDcuw7/PsI4+I2J9q6LHEp+6Oo4faSn/kl\n"
-    "yWYCLjM4FZdGXbOijDacQJiN6HcRv0UdodBrEVRf7YHJJmMCbCI7ZUGW2zef/+rO\n"
-    "e4Lkxh0MLYqCkNKH5ZfoGTC4Oeb0xKykswAanqgR60r+upaLU8PFuI2L9M3vc6KU\n"
-    "F6MgVGSxl6eylJgDYckvJiAbmcp2PD/LRQQOxQA0yqeAMg2cbdvclETuYD6zoFfu\n"
-    "Y8aO7dvDlw==\n"
-    "-----END CERTIFICATE-----\n";
-static const char *const key3 =
-    "-----BEGIN PRIVATE KEY-----\n"
-    "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n"
-    "IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/\n"
-    "4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159\n"
-    "x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n"
-    "PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n"
-    "LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJc\n"
-    "DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn2rf\n"
-    "v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n"
-    "EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n"
-    "slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n"
-    "BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n"
-    "U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8apOs/17\n"
-    "YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF4j/kX1ZWG\n"
-    "k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0lyBymdKA3p/i5Dx+8Nc9cGns\n"
-    "LGI9MvviLX7pQFIkvbaCkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n"
-    "UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n"
-    "4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+QW82hqSvEwSsvnwwn3eOW\n"
-    "nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxBDIID/4gaZxoMJP\n"
-    "hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw\n"
-    "qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n"
-    "+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n"
-    "UVveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n"
-    "Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAorc3PAX7M0bsQrrqYxUS8\n"
-    "56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAGOCCZrTcI3Ejg\n"
-    "xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0\n"
-    "ZbX6nKcJ7jciJVKJds59Jg==\n"
-    "-----END PRIVATE KEY-----\n";
-static const char *const hash3 = "2463628674E362578113F508BA05F29EF142E979";
-static const char *const cname3 = "ovpn-test-rsa1";
+#define cd_cert3 "-----BEGIN CERTIFICATE-----\n" \
+    "MIIDYzCCAkugAwIBAgIRALrXTx4lqa8QgF7uGjISxmcwDQYJKoZIhvcNAQELBQAw\n" \
+    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjA5MThaGA8yMTIz\n" \
+    "MDIxNzE2MDkxOFowGTEXMBUGA1UEAwwOb3Zwbi10ZXN0LXJzYTEwggEiMA0GCSqG\n" \
+    "SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7xFoR6fmoyfsJIQDKKgbYgFw0MzVuDAmp\n" \
+    "Rx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/4dRR3skisBug6Vd5LXeB\n" \
+    "GZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159x9FBDl5A3sLP18ubeex0\n" \
+    "pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwTPnS+CRXrSq4JjGDJLsXl\n" \
+    "0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIhLbG2DcIv8l29EuEj2w3j\n" \
+    "u/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJcDjOZVCArAgMBAAGjgaQw\n" \
+    "gaEwCQYDVR0TBAIwADAdBgNVHQ4EFgQUqYnRaBHrZmKLtMZES5AuwqzJkGYwUwYD\n" \
+    "VR0jBEwwSoAU3MLDNDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9W\n" \
+    "UE4gVEVTVCBDQTGCFD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsG\n" \
+    "AQUFBwMCMAsGA1UdDwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAZVcXrezA9Aby\n" \
+    "sfUNHAsMxrex/EO0PrIPSrmSmc9sCiD8cCIeB6kL8c5iPPigoWW0uLA9zteDRFes\n" \
+    "ez+Z8wBY6g8VQ0tFPURDooUg5011GZPDcuw7/PsI4+I2J9q6LHEp+6Oo4faSn/kl\n" \
+    "yWYCLjM4FZdGXbOijDacQJiN6HcRv0UdodBrEVRf7YHJJmMCbCI7ZUGW2zef/+rO\n" \
+    "e4Lkxh0MLYqCkNKH5ZfoGTC4Oeb0xKykswAanqgR60r+upaLU8PFuI2L9M3vc6KU\n" \
+    "F6MgVGSxl6eylJgDYckvJiAbmcp2PD/LRQQOxQA0yqeAMg2cbdvclETuYD6zoFfu\n" \
+    "Y8aO7dvDlw==\n" \
+    "-----END CERTIFICATE-----\n"
+#define cd_key3 "-----BEGIN PRIVATE KEY-----\n" \
+    "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n" \
+    "IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/\n" \
+    "4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159\n" \
+    "x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n" \
+    "PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n" \
+    "LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJc\n" \
+    "DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn2rf\n" \
+    "v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n" \
+    "EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n" \
+    "slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n" \
+    "BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n" \
+    "U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8apOs/17\n" \
+    "YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF4j/kX1ZWG\n" \
+    "k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0lyBymdKA3p/i5Dx+8Nc9cGns\n" \
+    "LGI9MvviLX7pQFIkvbaCkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n" \
+    "UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n" \
+    "4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+QW82hqSvEwSsvnwwn3eOW\n" \
+    "nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxBDIID/4gaZxoMJP\n" \
+    "hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw\n" \
+    "qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n" \
+    "+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n" \
+    "UVveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n" \
+    "Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAorc3PAX7M0bsQrrqYxUS8\n" \
+    "56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAGOCCZrTcI3Ejg\n" \
+    "xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0\n" \
+    "ZbX6nKcJ7jciJVKJds59Jg==\n" \
+    "-----END PRIVATE KEY-----\n"
+#define cd_hash3 "2463628674E362578113F508BA05F29EF142E979"
+#define cd_cname3 "ovpn-test-rsa1"
 
-static const char *const cert4 =
-    "-----BEGIN CERTIFICATE-----\n"
-    "MIIDYTCCAkmgAwIBAgIRAPTJucQy27qoIv0oYoE71z8wDQYJKoZIhvcNAQELBQAw\n"
-    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMjAeFw0yMzAzMTMxNzQ2MDNaFw0yMzAz\n"
-    "MTQxNzQ2MDNaMBkxFzAVBgNVBAMMDm92cG4tdGVzdC1yc2ExMIIBIjANBgkqhkiG\n"
-    "9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu8RaEen5qMn7CSEAyioG2IBcNDM1bgwJqUce\n"
-    "ikxIoYE3IZEMfXx3XVmyojlG3BJ0Ityzbsez+EFZf+HUUd7JIrAboOlXeS13gRma\n"
-    "pqbuV2YheA4C89ZV9tRtGjqIBVpIntqhhHLKONNefcfRQQ5eQN7Cz9fLm3nsdKXf\n"
-    "wcwxb+kizk8lVjvxgjXPCF/4tLjeJi76FVNNEnqsEz50vgkV60quCYxgyS7F5dPz\n"
-    "5cZI7IFNMjjgNGdnfBc5N8ApcD+h3OPQTjFirLVCIS2xtg3CL/JdvRLhI9sN47v+\n"
-    "4JHsKJfel0NrcKT76aFQGolYf5u4UFHEDkUAg+niXA4zmVQgKwIDAQABo4GkMIGh\n"
-    "MAkGA1UdEwQCMAAwHQYDVR0OBBYEFKmJ0WgR62Zii7TGREuQLsKsyZBmMFMGA1Ud\n"
-    "IwRMMEqAFMl93LaUT+XCpRErBvNKzhoRKYbBoRykGjAYMRYwFAYDVQQDDA1PVlBO\n"
-    "IFRFU1QgQ0EyghQXPK2ud4cGK5SJHWNwMtVgq6xyfDATBgNVHSUEDDAKBggrBgEF\n"
-    "BQcDAjALBgNVHQ8EBAMCB4AwDQYJKoZIhvcNAQELBQADggEBAFjJvZFwhY77UOWu\n"
-    "O6n5yLxcG6/VNWMbD0CazZP8pBqCGJRU9Rq0vXxZ00E0WSYTJLZoq1aFmeWIX0vZ\n"
-    "sudVkdbfWLdiwuQZDWBS+qC4SkIcnNe5FYSSUlXlvpSUN2CgGCLmryP+SZKHp8YV\n"
-    "e37pQxDjImXCu5Jdk5AhK6pkFm5IMskdTKfWJjjR69lBgWHPoM2WAwkV8vxKdpy8\n"
-    "0Bqef8MZZM+qVYw7OguAFos2Am7waLpa3q9SYqCRYctq4Q2++p2WjINv3nkXIwYS\n"
-    "353PpJJ9s2b/Fqoc4d7udqhQogA7jqbayTKhJxbT134l2NzqDROzuS0kXbX8bXCi\n"
-    "mXSa4c8=\n"
-    "-----END CERTIFICATE-----\n";
-static const char *const key4 = key3;
-static const char *const hash4 = "E1401D4497C944783E3D62CDBD2A1F69F5E5071E";
-static const char *const cname4 = cname3; /* same CN as that of cert3 */
+#define cd_cert4 "-----BEGIN CERTIFICATE-----\n" \
+    "MIIDYTCCAkmgAwIBAgIRAPTJucQy27qoIv0oYoE71z8wDQYJKoZIhvcNAQELBQAw\n" \
+    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMjAeFw0yMzAzMTMxNzQ2MDNaFw0yMzAz\n" \
+    "MTQxNzQ2MDNaMBkxFzAVBgNVBAMMDm92cG4tdGVzdC1yc2ExMIIBIjANBgkqhkiG\n" \
+    "9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu8RaEen5qMn7CSEAyioG2IBcNDM1bgwJqUce\n" \
+    "ikxIoYE3IZEMfXx3XVmyojlG3BJ0Ityzbsez+EFZf+HUUd7JIrAboOlXeS13gRma\n" \
+    "pqbuV2YheA4C89ZV9tRtGjqIBVpIntqhhHLKONNefcfRQQ5eQN7Cz9fLm3nsdKXf\n" \
+    "wcwxb+kizk8lVjvxgjXPCF/4tLjeJi76FVNNEnqsEz50vgkV60quCYxgyS7F5dPz\n" \
+    "5cZI7IFNMjjgNGdnfBc5N8ApcD+h3OPQTjFirLVCIS2xtg3CL/JdvRLhI9sN47v+\n" \
+    "4JHsKJfel0NrcKT76aFQGolYf5u4UFHEDkUAg+niXA4zmVQgKwIDAQABo4GkMIGh\n" \
+    "MAkGA1UdEwQCMAAwHQYDVR0OBBYEFKmJ0WgR62Zii7TGREuQLsKsyZBmMFMGA1Ud\n" \
+    "IwRMMEqAFMl93LaUT+XCpRErBvNKzhoRKYbBoRykGjAYMRYwFAYDVQQDDA1PVlBO\n" \
+    "IFRFU1QgQ0EyghQXPK2ud4cGK5SJHWNwMtVgq6xyfDATBgNVHSUEDDAKBggrBgEF\n" \
+    "BQcDAjALBgNVHQ8EBAMCB4AwDQYJKoZIhvcNAQELBQADggEBAFjJvZFwhY77UOWu\n" \
+    "O6n5yLxcG6/VNWMbD0CazZP8pBqCGJRU9Rq0vXxZ00E0WSYTJLZoq1aFmeWIX0vZ\n" \
+    "sudVkdbfWLdiwuQZDWBS+qC4SkIcnNe5FYSSUlXlvpSUN2CgGCLmryP+SZKHp8YV\n" \
+    "e37pQxDjImXCu5Jdk5AhK6pkFm5IMskdTKfWJjjR69lBgWHPoM2WAwkV8vxKdpy8\n" \
+    "0Bqef8MZZM+qVYw7OguAFos2Am7waLpa3q9SYqCRYctq4Q2++p2WjINv3nkXIwYS\n" \
+    "353PpJJ9s2b/Fqoc4d7udqhQogA7jqbayTKhJxbT134l2NzqDROzuS0kXbX8bXCi\n" \
+    "mXSa4c8=\n" \
+    "-----END CERTIFICATE-----\n"
+#define cd_key4 cd_key3
+#define cd_hash4 "E1401D4497C944783E3D62CDBD2A1F69F5E5071E"
+#define cd_cname4 cd_cname3
 
 #endif /* CERT_DATA_H */
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index c8468103..af80f14a 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -100,11 +100,11 @@ static struct test_cert
     const char *hash;                   /* SHA1 fingerprint */
     int valid;                          /* nonzero if certificate has not expired */
 } certs[] = {
-    {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  hash1,  1},
-    {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  hash2,  1},
-    {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  hash3,  1},
-    {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  hash4,  0},
-    {}
+    {cd_cert1,  cd_key1,  cd_cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  cd_hash1,  1},
+    {cd_cert2,  cd_key2,  cd_cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  cd_hash2,  1},
+    {cd_cert3,  cd_key3,  cd_cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  cd_hash3,  1},
+    {cd_cert4,  cd_key4,  cd_cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  cd_hash4,  0},
+    {NULL,      NULL,     NULL,       NULL,             NULL,                NULL,      0}
 };
 
 static bool certs_loaded;
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index ea394bea..bba972f2 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -113,11 +113,11 @@ static struct test_cert
     uint8_t hash[HASHSIZE];             /* SHA1 fingerprint: computed and filled in later */
     char *p11_id;                       /* PKCS#11 id -- filled in later */
 } certs[] = {
-    {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  {},  NULL},
-    {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  {},  NULL},
-    {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  {},  NULL},
-    {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  {},  NULL},
-    {}
+    {cd_cert1,  cd_key1,  cd_cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  {},  NULL},
+    {cd_cert2,  cd_key2,  cd_cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  {},  NULL},
+    {cd_cert3,  cd_key3,  cd_cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  {},  NULL},
+    {cd_cert4,  cd_key4,  cd_cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  {},  NULL},
+    {NULL,      NULL,     NULL,       NULL,              NULL,               {},  NULL}
 };
 
 static bool pkcs11_id_management;
-- 
2.34.1


