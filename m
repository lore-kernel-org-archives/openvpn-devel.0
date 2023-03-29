From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 29 Mar 2023 11:04:47 +0200
Message-Id: <20230329090447.246561-2-frank@...2641...>
In-Reply-To: <20230329090447.246561-1-frank@...2641...>
References: <20230328151233.217296-1-frank@...2641...>
 <20230329090447.246561-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] test_buffer: add tests for buf_catrunc
 and its caller format_hex_ex
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

Just some very basic tests.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/unit_tests/openvpn/test_buffer.c | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 9e3b1d2e..5e61fb07 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -56,6 +56,63 @@ test_buffer_strprefix(void **state)
     assert_int_equal(BLEN(buf), strlen(str)); \
     assert_memory_equal(BPTR(buf), str, BLEN(buf));
 
+static void
+test_buffer_printf_catrunc(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(16, &gc);
+
+    buf_printf(&buf, "%d", 123);
+    buf_printf(&buf, "%s", "some text, too long to fit");
+    assert_buf_equals_str(&buf, "123some text, t");
+
+    buf_catrunc(&buf, "...");
+    assert_buf_equals_str(&buf, "123some text...");
+
+    buf_catrunc(&buf, "some other text, much too long to fit");
+    assert_buf_equals_str(&buf, "123some text...");
+
+    buf_catrunc(&buf, "something other");
+    assert_buf_equals_str(&buf, "something other");
+
+    gc_free(&gc);
+}
+
+static void
+test_buffer_format_hex_ex(void **state)
+{
+    const int input_size = 10;
+    const uint8_t input[] = {
+        0x01, 0x00, 0xff, 0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0x0a
+    };
+    char *output;
+    struct gc_arena gc = gc_new();
+
+    int maxoutput = 0;
+    unsigned int blocksize = 5;
+    char *separator = " ";
+    output = format_hex_ex(input, input_size, maxoutput, blocksize, separator, &gc);
+    assert_string_equal(output, "0100ff10ff 00f00f090a");
+
+    maxoutput = 14;
+    output = format_hex_ex(input, input_size, maxoutput, blocksize, separator, &gc);
+    assert_string_equal(output, "0100[more...]");
+
+    maxoutput = 10;
+    output = format_hex_ex(input, input_size, maxoutput, blocksize, separator, &gc);
+    assert_string_equal(output, "[more...]");
+
+    maxoutput = 9;
+    output = format_hex_ex(input, input_size, maxoutput, blocksize, separator, &gc);
+    assert_string_equal(output, "0100ff10");
+
+    maxoutput = 8;
+    output = format_hex_ex(input, input_size, maxoutput, blocksize, separator, &gc);
+    assert_string_equal(output, "0100ff1");
+
+    gc_free(&gc);
+}
+
 struct test_buffer_list_aggregate_ctx {
     struct buffer_list *empty;
     struct buffer_list *one_two_three;
@@ -267,6 +324,8 @@ main(void)
 {
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(test_buffer_strprefix),
+        cmocka_unit_test(test_buffer_printf_catrunc),
+        cmocka_unit_test(test_buffer_format_hex_ex),
         cmocka_unit_test_setup_teardown(test_buffer_list_aggregate_separator_empty,
                                         test_buffer_list_setup,
                                         test_buffer_list_teardown),
-- 
2.34.1


