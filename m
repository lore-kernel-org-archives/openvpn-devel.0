From: Gert Doering <gert@...1296...>
Date: Mon,  8 Sep 2025 20:18:46 +0200
Message-ID: <20250908181852.5054-1-gert@...1296...>
In-Reply-To: <gerrit.1757337482000.I327ecc9a85dd906517c28e71fe500883bfa028a4@...2715...>
References: <gerrit.1757337482000.I327ecc9a85dd906517c28e71fe500883bfa028a4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Switch test_ssl certificate from RSA
 2048 to secp384r1
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

This allow the unit test to also run in environments that have seclevel
(SSL_CTX_set_security_level) set to 3.

Closes: openvpn/openvpn#830
Change-Id: I327ecc9a85dd906517c28e71fe500883bfa028a4
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1172
This mail reflects revision 2 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 7bf5396..bb02fcc 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -83,59 +83,36 @@
     return;
 }
 
+/* generated using
+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
+ * -noenc -sha256 -days 3650 -subj '/CN=ovpn-test-secp384r1'  -nodes \
+ * -addext 'subjectAltName=DNS:unittest.example.com' \
+ * -addext 'extendedKeyUsage=clientAuth'
+ */
 static const char *const unittest_cert =
     "-----BEGIN CERTIFICATE-----\n"
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
+    "MIICBjCCAYygAwIBAgIUFoXgpP4beykV7tpgrjHQTWPGi4cwCgYIKoZIzj0EAwIw\n"
+    "HjEcMBoGA1UEAwwTb3Zwbi10ZXN0LXNlY3AzODRyMTAeFw0yNTA5MDgxMzExNTBa\n"
+    "Fw0zNTA5MDYxMzExNTBaMB4xHDAaBgNVBAMME292cG4tdGVzdC1zZWNwMzg0cjEw\n"
+    "djAQBgcqhkjOPQIBBgUrgQQAIgNiAAQVDmf+TZB3rW6zqWFox606u/PhA93ysX/h\n"
+    "1s2xyq9+QGzIdE/hks6p/Yzyu7RLOUjxvO0J45RHcYmo67DlvSOi496T3zrgvp1H\n"
+    "KfHD5ohMyvzw0+e8lmjJqJjn+PegMkOjgYowgYcwHQYDVR0OBBYEFCH1eYnaV8fh\n"
+    "E3Bv7lyrlYu24eoVMB8GA1UdIwQYMBaAFCH1eYnaV8fhE3Bv7lyrlYu24eoVMA8G\n"
+    "A1UdEwEB/wQFMAMBAf8wHwYDVR0RBBgwFoIUdW5pdHRlc3QuZXhhbXBsZS5jb20w\n"
+    "EwYDVR0lBAwwCgYIKwYBBQUHAwIwCgYIKoZIzj0EAwIDaAAwZQIxAL7q7jcwTOuq\n"
+    "5sp0Beq81Vnznd3gsDZYNs1OYRWH33xergDVKlBb6kCwus0dhghtVAIwIgT4ytkY\n"
+    "oAPx8LB3oP8ubEu1ue6V9jZln/cCiLyXDDtaiJOZHtDqHGfHqvc6rAok\n"
     "-----END CERTIFICATE-----\n";
 
 static const char *const unittest_key =
     "-----BEGIN PRIVATE KEY-----\n"
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
+    "MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDAXBC7tpa9UepoMVZlM\n"
+    "OxUubkECGK7aWFebxDc3UPoEQemEPMOCdkWBSU/t7Mm4R66hZANiAAQVDmf+TZB3\n"
+    "rW6zqWFox606u/PhA93ysX/h1s2xyq9+QGzIdE/hks6p/Yzyu7RLOUjxvO0J45RH\n"
+    "cYmo67DlvSOi496T3zrgvp1HKfHD5ohMyvzw0+e8lmjJqJjn+PegMkM=\n"
     "-----END PRIVATE KEY-----\n";
 
+
 static const char *
 get_tmp_dir(void)
 {

