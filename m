From: Gert Doering <gert@...1296...>
Date: Sun, 26 Apr 2020 11:54:02 +0200
Message-Id: <20200426095402.65047-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Uncrustify the tests/unit_tests/ part of
 our tree.
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

Apply uncrustify 0.70.1 (FreeBSD port) with our rules to that part
of the tree, which followed a more compact coding style so far.
---
 tests/unit_tests/example_test/test.c       |  18 ++-
 tests/unit_tests/example_test/test2.c      |   6 +-
 tests/unit_tests/openvpn/test_argv.c       |   5 +-
 tests/unit_tests/openvpn/test_buffer.c     |   6 +-
 tests/unit_tests/openvpn/test_crypto.c     |   6 +-
 tests/unit_tests/openvpn/test_ncp.c        |   6 +-
 tests/unit_tests/openvpn/test_networking.c |  40 +++++
 tests/unit_tests/openvpn/test_packet_id.c  |  35 +++--
 tests/unit_tests/openvpn/test_tls_crypt.c  | 161 ++++++++++++---------
 9 files changed, 180 insertions(+), 103 deletions(-)

diff --git a/tests/unit_tests/example_test/test.c b/tests/unit_tests/example_test/test.c
index d48e5f55..bc3fdc17 100644
--- a/tests/unit_tests/example_test/test.c
+++ b/tests/unit_tests/example_test/test.c
@@ -7,7 +7,8 @@
 #include <cmocka.h>
 
 static int
-setup(void **state) {
+setup(void **state)
+{
     int *answer  = malloc(sizeof(int));
 
     *answer = 42;
@@ -17,31 +18,36 @@ setup(void **state) {
 }
 
 static int
-teardown(void **state) {
+teardown(void **state)
+{
     free(*state);
 
     return 0;
 }
 
 static void
-null_test_success(void **state) {
+null_test_success(void **state)
+{
     (void) state;
 }
 
 static void
-int_test_success(void **state) {
+int_test_success(void **state)
+{
     int *answer = *state;
     assert_int_equal(*answer, 42);
 }
 
 static void
-failing_test(void **state) {
+failing_test(void **state)
+{
     /* This tests fails to test that make check fails */
     assert_int_equal(0, 42);
 }
 
 int
-main(void) {
+main(void)
+{
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(null_test_success),
         cmocka_unit_test_setup_teardown(int_test_success, setup, teardown),
diff --git a/tests/unit_tests/example_test/test2.c b/tests/unit_tests/example_test/test2.c
index b5d4fa60..5a186d5d 100644
--- a/tests/unit_tests/example_test/test2.c
+++ b/tests/unit_tests/example_test/test2.c
@@ -8,13 +8,15 @@
 
 
 static void
-test_true(void **state) {
+test_true(void **state)
+{
     (void) state;
 }
 
 
 int
-main(void) {
+main(void)
+{
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(test_true),
     };
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 25e80c1c..3dc470a5 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -204,7 +204,7 @@ argv_str__multiple_argv__correct_output(void **state)
     argv_printf_cat(&a, "%lu", 1L );
     output = argv_str(&a, &gc, PA_BRACKET);
     assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2 "]"
-				" [-1] [4294967295] [1]");
+                        " [-1] [4294967295] [1]");
 
     argv_free(&a);
     gc_free(&gc);
@@ -234,7 +234,8 @@ argv_insert_head__non_empty_argv__head_added(void **state)
     argv_printf(&a, "%s", PATH2);
     b = argv_insert_head(&a, PATH1);
     assert_int_equal(b.argc, a.argc + 1);
-    for (i = 0; i < b.argc; i++) {
+    for (i = 0; i < b.argc; i++)
+    {
         if (i == 0)
         {
             assert_string_equal(b.argv[i], PATH1);
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 7c9a9e2f..d2188b02 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -63,7 +63,8 @@ struct test_buffer_list_aggregate_ctx {
     struct buffer_list *empty_buffers;
 };
 
-static int test_buffer_list_setup(void **state)
+static int
+test_buffer_list_setup(void **state)
 {
     struct test_buffer_list_aggregate_ctx *ctx  = calloc(1, sizeof(*ctx));
     ctx->empty = buffer_list_new(0);
@@ -86,7 +87,8 @@ static int test_buffer_list_setup(void **state)
     return 0;
 }
 
-static int test_buffer_list_teardown(void **state)
+static int
+test_buffer_list_teardown(void **state)
 {
     struct test_buffer_list_aggregate_ctx *ctx = *state;
 
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 7027d3da..fdf814de 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -44,7 +44,8 @@
 static const char testtext[] = "Dummy text to test PEM encoding";
 
 static void
-crypto_pem_encode_decode_loopback(void **state) {
+crypto_pem_encode_decode_loopback(void **state)
+{
     struct gc_arena gc = gc_new();
     struct buffer src_buf;
     buf_set_read(&src_buf, (void *)testtext, sizeof(testtext));
@@ -69,7 +70,8 @@ crypto_pem_encode_decode_loopback(void **state) {
 }
 
 int
-main(void) {
+main(void)
+{
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(crypto_pem_encode_decode_loopback),
     };
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index f8d03b35..19432410 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -66,12 +66,12 @@ test_check_ncp_ciphers_list(void **state)
     }
 
     /* For testing that with OpenSSL 1.1.0+ that also accepts ciphers in
-       a different spelling the normalised cipher output is the same */
+     * a different spelling the normalised cipher output is the same */
     bool have_chacha_mixed_case = cipher_kt_get("ChaCha20-Poly1305");
     if (have_chacha_mixed_case)
     {
-      assert_string_equal(mutate_ncp_cipher_list("BF-CBC:ChaCha20-Poly1305", &gc),
-			  bf_chacha);
+        assert_string_equal(mutate_ncp_cipher_list("BF-CBC:ChaCha20-Poly1305", &gc),
+                            bf_chacha);
     }
 
     assert_ptr_equal(mutate_ncp_cipher_list("vollbit", &gc), NULL);
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 2d37d6e1..e7c148f0 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -29,7 +29,9 @@ net__addr_v4_add(const char *addr_str, int prefixlen)
 
     ret = inet_pton(AF_INET, addr_str, &addr);
     if (ret != 1)
+    {
         return -1;
+    }
 
     addr = ntohl(addr);
 
@@ -46,7 +48,9 @@ net__addr_v6_add(const char *addr_str, int prefixlen)
 
     ret = inet_pton(AF_INET6, addr_str, &addr);
     if (ret != 1)
+    {
         return -1;
+    }
 
     printf("CMD: ip -6 addr add %s/%d dev %s\n", addr_str, prefixlen, iface);
 
@@ -60,17 +64,23 @@ net__route_v4_add(const char *dst_str, int prefixlen, int metric)
     int ret;
 
     if (!dst_str)
+    {
         return -1;
+    }
 
     ret = inet_pton(AF_INET, dst_str, &dst);
     if (ret != 1)
+    {
         return -1;
+    }
 
     dst = ntohl(dst);
 
     printf("CMD: ip route add %s/%d dev %s", dst_str, prefixlen, iface);
     if (metric > 0)
+    {
         printf(" metric %d", metric);
+    }
     printf("\n");
 
     return net_route_v4_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
@@ -85,15 +95,21 @@ net__route_v4_add_gw(const char *dst_str, int prefixlen, const char *gw_str,
     int ret;
 
     if (!dst_str || !gw_str)
+    {
         return -1;
+    }
 
     ret = inet_pton(AF_INET, dst_str, &dst);
     if (ret != 1)
+    {
         return -1;
+    }
 
     ret = inet_pton(AF_INET, gw_str, &gw);
     if (ret != 1)
+    {
         return -1;
+    }
 
     dst = ntohl(dst);
     gw = ntohl(gw);
@@ -101,7 +117,9 @@ net__route_v4_add_gw(const char *dst_str, int prefixlen, const char *gw_str,
     printf("CMD: ip route add %s/%d dev %s via %s", dst_str, prefixlen, iface,
            gw_str);
     if (metric > 0)
+    {
         printf(" metric %d", metric);
+    }
     printf("\n");
 
     return net_route_v4_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
@@ -114,15 +132,21 @@ net__route_v6_add(const char *dst_str, int prefixlen, int metric)
     int ret;
 
     if (!dst_str)
+    {
         return -1;
+    }
 
     ret = inet_pton(AF_INET6, dst_str, &dst);
     if (ret != 1)
+    {
         return -1;
+    }
 
     printf("CMD: ip -6 route add %s/%d dev %s", dst_str, prefixlen, iface);
     if (metric > 0)
+    {
         printf(" metric %d", metric);
+    }
     printf("\n");
 
     return net_route_v6_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
@@ -137,20 +161,28 @@ net__route_v6_add_gw(const char *dst_str, int prefixlen, const char *gw_str,
     int ret;
 
     if (!dst_str || !gw_str)
+    {
         return -1;
+    }
 
     ret = inet_pton(AF_INET6, dst_str, &dst);
     if (ret != 1)
+    {
         return -1;
+    }
 
     ret = inet_pton(AF_INET6, gw_str, &gw);
     if (ret != 1)
+    {
         return -1;
+    }
 
     printf("CMD: ip -6 route add %s/%d dev %s via %s", dst_str, prefixlen,
            iface, gw_str);
     if (metric > 0)
+    {
         printf(" metric %d", metric);
+    }
     printf("\n");
 
     return net_route_v6_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
@@ -189,20 +221,28 @@ main(int argc, char *argv[])
     {
         case 0:
             return net__iface_up(true);
+
         case 1:
             return net__iface_mtu_set(1281);
+
         case 2:
             return net__addr_v4_add("10.255.255.1", 24);
+
         case 3:
             return net__addr_v6_add("2001::1", 64);
+
         case 4:
             return net__route_v4_add("11.11.11.0", 24, 0);
+
         case 5:
             return net__route_v4_add_gw("11.11.12.0", 24, "10.255.255.2", 0);
+
         case 6:
             return net__route_v6_add("2001:babe:cafe:babe::", 64, 600);
+
         case 7:
             return net__route_v6_add_gw("2001:cafe:babe::", 48, "2001::2", 600);
+
         default:
             printf("invalid test: %d\n", test);
             break;
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index ba420c49..a12b8b0f 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -49,9 +49,10 @@ struct test_packet_id_write_data {
 };
 
 static int
-test_packet_id_write_setup(void **state) {
+test_packet_id_write_setup(void **state)
+{
     struct test_packet_id_write_data *data =
-            calloc(1, sizeof(struct test_packet_id_write_data));
+        calloc(1, sizeof(struct test_packet_id_write_data));
 
     if (!data)
     {
@@ -66,7 +67,8 @@ test_packet_id_write_setup(void **state) {
 }
 
 static int
-test_packet_id_write_teardown(void **state) {
+test_packet_id_write_teardown(void **state)
+{
     free(*state);
     return 0;
 }
@@ -155,20 +157,21 @@ test_packet_id_write_long_wrap(void **state)
 }
 
 int
-main(void) {
+main(void)
+{
     const struct CMUnitTest tests[] = {
-            cmocka_unit_test_setup_teardown(test_packet_id_write_short,
-                    test_packet_id_write_setup, test_packet_id_write_teardown),
-            cmocka_unit_test_setup_teardown(test_packet_id_write_long,
-                    test_packet_id_write_setup, test_packet_id_write_teardown),
-            cmocka_unit_test_setup_teardown(test_packet_id_write_short_prepend,
-                    test_packet_id_write_setup, test_packet_id_write_teardown),
-            cmocka_unit_test_setup_teardown(test_packet_id_write_long_prepend,
-                    test_packet_id_write_setup, test_packet_id_write_teardown),
-            cmocka_unit_test_setup_teardown(test_packet_id_write_short_wrap,
-                    test_packet_id_write_setup, test_packet_id_write_teardown),
-            cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
-                    test_packet_id_write_setup, test_packet_id_write_teardown),
+        cmocka_unit_test_setup_teardown(test_packet_id_write_short,
+                                        test_packet_id_write_setup, test_packet_id_write_teardown),
+        cmocka_unit_test_setup_teardown(test_packet_id_write_long,
+                                        test_packet_id_write_setup, test_packet_id_write_teardown),
+        cmocka_unit_test_setup_teardown(test_packet_id_write_short_prepend,
+                                        test_packet_id_write_setup, test_packet_id_write_teardown),
+        cmocka_unit_test_setup_teardown(test_packet_id_write_long_prepend,
+                                        test_packet_id_write_setup, test_packet_id_write_teardown),
+        cmocka_unit_test_setup_teardown(test_packet_id_write_short_wrap,
+                                        test_packet_id_write_setup, test_packet_id_write_teardown),
+        cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
+                                        test_packet_id_write_setup, test_packet_id_write_teardown),
     };
 
     return cmocka_run_group_tests_name("packet_id tests", tests, NULL, NULL);
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 366b48d5..8406d89d 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -50,45 +50,45 @@
 #define PARAM2      "param two"
 
 static const char *test_server_key = \
-        "-----BEGIN OpenVPN tls-crypt-v2 server key-----\n"
-        "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
-        "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
-        "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=\n"
-        "-----END OpenVPN tls-crypt-v2 server key-----\n";
+    "-----BEGIN OpenVPN tls-crypt-v2 server key-----\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=\n"
+    "-----END OpenVPN tls-crypt-v2 server key-----\n";
 
 static const char *test_client_key = \
-        "-----BEGIN OpenVPN tls-crypt-v2 client key-----\n"
-        "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
-        "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
-        "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n"
-        "kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n"
-        "wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"
-        "8PHy8/T19vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n"
-        "LHg5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n"
-        "3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n"
-        "zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh\n"
-        "j0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n"
-        "RZ+q17SC4nba3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n"
-        "/Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n"
-        "-----END OpenVPN tls-crypt-v2 client key-----\n";
+    "-----BEGIN OpenVPN tls-crypt-v2 client key-----\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n"
+    "kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n"
+    "wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"
+    "8PHy8/T19vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n"
+    "LHg5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n"
+    "3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n"
+    "zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh\n"
+    "j0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n"
+    "RZ+q17SC4nba3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n"
+    "/Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n"
+    "-----END OpenVPN tls-crypt-v2 client key-----\n";
 
 
 /* Has custom metadata of AABBCCDD (base64) */
-static const char *test_client_key_metadata= \
-        "-----BEGIN OpenVPN tls-crypt-v2 client key-----\n"
-        "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
-        "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
-        "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n"
-        "kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n"
-        "wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"
-        "8PHy8/T19vf4+fr7/P3+/2ntp1WCqhcLjJQY/igkjNt3Yb6i0neqFkfrOp2UCDcz\n"
-        "6RSJtPLZbvOOKUHk2qwxPYUsFCnz/IWV6/ZiLRrabzUpS8oSN1HS6P7qqAdrHKgf\n"
-        "hVTHasdSf2UdMTPC7HBgnP9Ll0FhKN0h7vSzbbt7QM7wH9mr1ecc/Mt0SYW2lpwA\n"
-        "aJObYGTyk6hTgWm0g/MLrworLrezTqUHBZzVsu+LDyqLWK1lzJNd66MuNOsGA4YF\n"
-        "fbCsDh8n3H+Cw1k5YNBZDYYJOtVUgBWXheO6vgoOmqDdI0dAQ3hVo9DE+SkCFjgf\n"
-        "l4FY2yLEh9ZVZZrl1eD1Owh/X178CkHrBJYl9LNQSyQEKlDGWwBLQ/pY3qtjctr3\n"
-        "pV62MPQdBo+1lcsjDCJVQA6XUyltas4BKQ==\n"
-        "-----END OpenVPN tls-crypt-v2 client key-----\n";
+static const char *test_client_key_metadata = \
+    "-----BEGIN OpenVPN tls-crypt-v2 client key-----\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n"
+    "kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n"
+    "wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"
+    "8PHy8/T19vf4+fr7/P3+/2ntp1WCqhcLjJQY/igkjNt3Yb6i0neqFkfrOp2UCDcz\n"
+    "6RSJtPLZbvOOKUHk2qwxPYUsFCnz/IWV6/ZiLRrabzUpS8oSN1HS6P7qqAdrHKgf\n"
+    "hVTHasdSf2UdMTPC7HBgnP9Ll0FhKN0h7vSzbbt7QM7wH9mr1ecc/Mt0SYW2lpwA\n"
+    "aJObYGTyk6hTgWm0g/MLrworLrezTqUHBZzVsu+LDyqLWK1lzJNd66MuNOsGA4YF\n"
+    "fbCsDh8n3H+Cw1k5YNBZDYYJOtVUgBWXheO6vgoOmqDdI0dAQ3hVo9DE+SkCFjgf\n"
+    "l4FY2yLEh9ZVZZrl1eD1Owh/X178CkHrBJYl9LNQSyQEKlDGWwBLQ/pY3qtjctr3\n"
+    "pV62MPQdBo+1lcsjDCJVQA6XUyltas4BKQ==\n"
+    "-----END OpenVPN tls-crypt-v2 client key-----\n";
 
 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *file,
@@ -143,7 +143,8 @@ struct test_tls_crypt_context {
 };
 
 static int
-test_tls_crypt_setup(void **state) {
+test_tls_crypt_setup(void **state)
+{
     struct test_tls_crypt_context *ctx = calloc(1, sizeof(*ctx));
     *state = ctx;
 
@@ -175,9 +176,10 @@ test_tls_crypt_setup(void **state) {
 }
 
 static int
-test_tls_crypt_teardown(void **state) {
+test_tls_crypt_teardown(void **state)
+{
     struct test_tls_crypt_context *ctx =
-            (struct test_tls_crypt_context *)*state;
+        (struct test_tls_crypt_context *)*state;
 
     free_buf(&ctx->source);
     free_buf(&ctx->ciphertext);
@@ -190,7 +192,8 @@ test_tls_crypt_teardown(void **state) {
     return 0;
 }
 
-static void skip_if_tls_crypt_not_supported(struct test_tls_crypt_context *ctx)
+static void
+skip_if_tls_crypt_not_supported(struct test_tls_crypt_context *ctx)
 {
     if (!ctx->kt.cipher || !ctx->kt.digest)
     {
@@ -202,7 +205,8 @@ static void skip_if_tls_crypt_not_supported(struct test_tls_crypt_context *ctx)
  * Check that short messages are successfully wrapped-and-unwrapped.
  */
 static void
-tls_crypt_loopback(void **state) {
+tls_crypt_loopback(void **state)
+{
     struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
@@ -219,7 +223,8 @@ tls_crypt_loopback(void **state) {
  * Check that zero-byte messages are successfully wrapped-and-unwrapped.
  */
 static void
-tls_crypt_loopback_zero_len(void **state) {
+tls_crypt_loopback_zero_len(void **state)
+{
     struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
@@ -238,7 +243,8 @@ tls_crypt_loopback_zero_len(void **state) {
  * Check that max-length messages are successfully wrapped-and-unwrapped.
  */
 static void
-tls_crypt_loopback_max_len(void **state) {
+tls_crypt_loopback_max_len(void **state)
+{
     struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
@@ -259,7 +265,8 @@ tls_crypt_loopback_max_len(void **state) {
  * Check that too-long messages are gracefully rejected.
  */
 static void
-tls_crypt_fail_msg_too_long(void **state) {
+tls_crypt_fail_msg_too_long(void **state)
+{
     struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
@@ -275,7 +282,8 @@ tls_crypt_fail_msg_too_long(void **state) {
  * are not accepted.
  */
 static void
-tls_crypt_fail_invalid_key(void **state) {
+tls_crypt_fail_invalid_key(void **state)
+{
     struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
@@ -294,7 +302,8 @@ tls_crypt_fail_invalid_key(void **state) {
  * Check that replayed packets are not accepted.
  */
 static void
-tls_crypt_fail_replay(void **state) {
+tls_crypt_fail_replay(void **state)
+{
     struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
@@ -313,7 +322,8 @@ tls_crypt_fail_replay(void **state) {
  * know the packet ID yet.
  */
 static void
-tls_crypt_ignore_replay(void **state) {
+tls_crypt_ignore_replay(void **state)
+{
     struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
@@ -340,7 +350,8 @@ struct test_tls_crypt_v2_context {
 };
 
 static int
-test_tls_crypt_v2_setup(void **state) {
+test_tls_crypt_v2_setup(void **state)
+{
     struct test_tls_crypt_v2_context *ctx = calloc(1, sizeof(*ctx));
     *state = ctx;
 
@@ -368,9 +379,10 @@ test_tls_crypt_v2_setup(void **state) {
 }
 
 static int
-test_tls_crypt_v2_teardown(void **state) {
+test_tls_crypt_v2_teardown(void **state)
+{
     struct test_tls_crypt_v2_context *ctx =
-            (struct test_tls_crypt_v2_context *) *state;
+        (struct test_tls_crypt_v2_context *) *state;
 
     free_key_ctx_bi(&ctx->server_keys);
     free_key_ctx_bi(&ctx->client_key);
@@ -386,9 +398,10 @@ test_tls_crypt_v2_teardown(void **state) {
  * Check wrapping and unwrapping a tls-crypt-v2 client key without metadata.
  */
 static void
-tls_crypt_v2_wrap_unwrap_no_metadata(void **state) {
+tls_crypt_v2_wrap_unwrap_no_metadata(void **state)
+{
     struct test_tls_crypt_v2_context *ctx =
-            (struct test_tls_crypt_v2_context *) *state;
+        (struct test_tls_crypt_v2_context *) *state;
 
     struct buffer wrapped_client_key = alloc_buf_gc(TLS_CRYPT_V2_MAX_WKC_LEN,
                                                     &ctx->gc);
@@ -415,12 +428,13 @@ tls_crypt_v2_wrap_unwrap_no_metadata(void **state) {
  * metadata.
  */
 static void
-tls_crypt_v2_wrap_unwrap_max_metadata(void **state) {
+tls_crypt_v2_wrap_unwrap_max_metadata(void **state)
+{
     struct test_tls_crypt_v2_context *ctx =
-            (struct test_tls_crypt_v2_context *) *state;
+        (struct test_tls_crypt_v2_context *) *state;
 
-    uint8_t* metadata =
-            buf_write_alloc(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN);
+    uint8_t *metadata =
+        buf_write_alloc(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN);
     assert_true(rand_bytes(metadata, TLS_CRYPT_V2_MAX_METADATA_LEN));
     assert_true(tls_crypt_v2_wrap_client_key(&ctx->wkc, &ctx->client_key2,
                                              &ctx->metadata,
@@ -439,8 +453,8 @@ tls_crypt_v2_wrap_unwrap_max_metadata(void **state) {
     assert_true(buf_equal(&ctx->metadata, &unwrap_metadata));
 
     struct tls_wrap_ctx wrap_ctx = {
-            .mode = TLS_WRAP_CRYPT,
-            .tls_crypt_v2_server_key = ctx->server_keys.encrypt,
+        .mode = TLS_WRAP_CRYPT,
+        .tls_crypt_v2_server_key = ctx->server_keys.encrypt,
     };
     assert_true(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx, NULL));
     tls_wrap_free(&wrap_ctx);
@@ -451,9 +465,10 @@ tls_crypt_v2_wrap_unwrap_max_metadata(void **state) {
  * as expected.
  */
 static void
-tls_crypt_v2_wrap_too_long_metadata(void **state) {
+tls_crypt_v2_wrap_too_long_metadata(void **state)
+{
     struct test_tls_crypt_v2_context *ctx =
-            (struct test_tls_crypt_v2_context *) *state;
+        (struct test_tls_crypt_v2_context *) *state;
 
     assert_true(buf_inc_len(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN+1));
     assert_false(tls_crypt_v2_wrap_client_key(&ctx->wkc, &ctx->client_key2,
@@ -467,9 +482,10 @@ tls_crypt_v2_wrap_too_long_metadata(void **state) {
  * fails as expected.
  */
 static void
-tls_crypt_v2_wrap_unwrap_wrong_key(void **state) {
+tls_crypt_v2_wrap_unwrap_wrong_key(void **state)
+{
     struct test_tls_crypt_v2_context *ctx =
-            (struct test_tls_crypt_v2_context *) *state;
+        (struct test_tls_crypt_v2_context *) *state;
 
     assert_true(tls_crypt_v2_wrap_client_key(&ctx->wkc, &ctx->client_key2,
                                              &ctx->metadata,
@@ -501,12 +517,13 @@ tls_crypt_v2_wrap_unwrap_wrong_key(void **state) {
  * buffer fails as expected.
  */
 static void
-tls_crypt_v2_wrap_unwrap_dst_too_small(void **state) {
+tls_crypt_v2_wrap_unwrap_dst_too_small(void **state)
+{
     struct test_tls_crypt_v2_context *ctx =
-            (struct test_tls_crypt_v2_context *) *state;
+        (struct test_tls_crypt_v2_context *) *state;
 
-    uint8_t* metadata =
-            buf_write_alloc(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN);
+    uint8_t *metadata =
+        buf_write_alloc(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN);
     assert_true(rand_bytes(metadata, TLS_CRYPT_V2_MAX_METADATA_LEN));
     assert_true(tls_crypt_v2_wrap_client_key(&ctx->wkc, &ctx->client_key2,
                                              &ctx->metadata,
@@ -515,7 +532,7 @@ tls_crypt_v2_wrap_unwrap_dst_too_small(void **state) {
 
     struct key2 unwrapped_client_key2 = { 0 };
     struct buffer unwrapped_metadata =
-            alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN-1, &ctx->gc);
+        alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN-1, &ctx->gc);
     assert_false(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2,
                                                 &unwrapped_metadata, ctx->wkc,
                                                 &ctx->server_keys.decrypt));
@@ -526,7 +543,8 @@ tls_crypt_v2_wrap_unwrap_dst_too_small(void **state) {
 }
 
 static void
-test_tls_crypt_v2_write_server_key_file(void **state) {
+test_tls_crypt_v2_write_server_key_file(void **state)
+{
     const char *filename = "testfilename.key";
 
     expect_string(__wrap_buffer_write_file, filename, filename);
@@ -537,7 +555,8 @@ test_tls_crypt_v2_write_server_key_file(void **state) {
 }
 
 static void
-test_tls_crypt_v2_write_client_key_file(void **state) {
+test_tls_crypt_v2_write_client_key_file(void **state)
+{
     const char *filename = "testfilename.key";
 
     /* Test writing the client key */
@@ -550,11 +569,12 @@ test_tls_crypt_v2_write_client_key_file(void **state) {
     will_return(__wrap_buffer_read_from_file, test_client_key);
 
     tls_crypt_v2_write_client_key_file(filename, NULL, INLINE_FILE_TAG,
-				       test_server_key);
+                                       test_server_key);
 }
 
 static void
-test_tls_crypt_v2_write_client_key_file_metadata(void **state) {
+test_tls_crypt_v2_write_client_key_file_metadata(void **state)
+{
     const char *filename = "testfilename.key";
     const char *b64metadata = "AABBCCDD";
 
@@ -572,7 +592,8 @@ test_tls_crypt_v2_write_client_key_file_metadata(void **state) {
 }
 
 int
-main(void) {
+main(void)
+{
     const struct CMUnitTest tests[] = {
         cmocka_unit_test_setup_teardown(tls_crypt_loopback,
                                         test_tls_crypt_setup,
-- 
2.25.2


