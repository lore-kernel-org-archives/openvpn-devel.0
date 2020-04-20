From: Arne Schwabe <arne@...1227...>
Date: Mon, 20 Apr 2020 12:44:35 +0200
Message-Id: <20200420104435.7082-1-arne@...1227...>
In-Reply-To: <E1jLTnR-0005sV-FD@...2479...>
References: <E1jLTnR-0005sV-FD@...2479...>
Subject: [Openvpn-devel] [PATCH] Add tls-crypt-v2 test writing metadata
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

---
 tests/unit_tests/openvpn/test_tls_crypt.c | 44 +++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index b9e3a7a6..91a4d209 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -72,6 +72,24 @@ static const char *test_client_key = \
         "/Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n"
         "-----END OpenVPN tls-crypt-v2 client key-----\n";
 
+
+/* Has custom metadata of AABBCCDD (base64) */
+static const char *test_client_key_metadata= \
+        "-----BEGIN OpenVPN tls-crypt-v2 client key-----\n"
+        "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
+        "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
+        "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n"
+        "kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n"
+        "wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"
+        "8PHy8/T19vf4+fr7/P3+/2ntp1WCqhcLjJQY/igkjNt3Yb6i0neqFkfrOp2UCDcz\n"
+        "6RSJtPLZbvOOKUHk2qwxPYUsFCnz/IWV6/ZiLRrabzUpS8oSN1HS6P7qqAdrHKgf\n"
+        "hVTHasdSf2UdMTPC7HBgnP9Ll0FhKN0h7vSzbbt7QM7wH9mr1ecc/Mt0SYW2lpwA\n"
+        "aJObYGTyk6hTgWm0g/MLrworLrezTqUHBZzVsu+LDyqLWK1lzJNd66MuNOsGA4YF\n"
+        "fbCsDh8n3H+Cw1k5YNBZDYYJOtVUgBWXheO6vgoOmqDdI0dAQ3hVo9DE+SkCFjgf\n"
+        "l4FY2yLEh9ZVZZrl1eD1Owh/X178CkHrBJYl9LNQSyQEKlDGWwBLQ/pY3qtjctr3\n"
+        "pV62MPQdBo+1lcsjDCJVQA6XUyltas4BKQ==\n"
+        "-----END OpenVPN tls-crypt-v2 client key-----\n";
+
 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *file,
                   const int line_num, int msglevel, struct gc_arena *gc)
@@ -520,21 +538,40 @@ test_tls_crypt_v2_write_server_key_file(void **state) {
 
 static void
 test_tls_crypt_v2_write_client_key_file(void **state) {
+  const char *filename = "testfilename.key";
+
+  /* Test writing the client key */
+  expect_string(__wrap_buffer_write_file, filename, filename);
+  expect_string(__wrap_buffer_write_file, pem, test_client_key);
+  will_return(__wrap_buffer_write_file, true);
+
+  /* Key generation re-reads the created file as a sanity check */
+  expect_string(__wrap_buffer_read_from_file, filename, filename);
+  will_return(__wrap_buffer_read_from_file, test_client_key);
+
+  tls_crypt_v2_write_client_key_file(filename, NULL, INLINE_FILE_TAG,
+                                     test_server_key);
+}
+
+static void
+test_tls_crypt_v2_write_client_key_file_metadata(void **state) {
     const char *filename = "testfilename.key";
+    const char *b64metadata = "AABBCCDD";
 
     /* Test writing the client key */
     expect_string(__wrap_buffer_write_file, filename, filename);
-    expect_string(__wrap_buffer_write_file, pem, test_client_key);
+    expect_string(__wrap_buffer_write_file, pem, test_client_key_metadata);
     will_return(__wrap_buffer_write_file, true);
 
     /* Key generation re-reads the created file as a sanity check */
     expect_string(__wrap_buffer_read_from_file, filename, filename);
-    will_return(__wrap_buffer_read_from_file, test_client_key);
+    will_return(__wrap_buffer_read_from_file, test_client_key_metadata);
 
-    tls_crypt_v2_write_client_key_file(filename, NULL, INLINE_FILE_TAG,
+    tls_crypt_v2_write_client_key_file(filename, b64metadata, INLINE_FILE_TAG,
                                        test_server_key);
 }
 
+
 int
 main(void) {
     const struct CMUnitTest tests[] = {
@@ -576,6 +613,7 @@ main(void) {
                                         test_tls_crypt_v2_teardown),
         cmocka_unit_test(test_tls_crypt_v2_write_server_key_file),
         cmocka_unit_test(test_tls_crypt_v2_write_client_key_file),
+        cmocka_unit_test(test_tls_crypt_v2_write_client_key_file_metadata),
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-- 
2.26.0


