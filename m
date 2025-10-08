From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 12:29:55 +0200
Message-ID: <20251008103001.7696-1-gert@...1296...>
In-Reply-To: <gerrit.1759330832000.I3724660bf0f8336ee58c172acfb7c4f38e457393@...2715...>
References: <gerrit.1759330832000.I3724660bf0f8336ee58c172acfb7c4f38e457393@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] buffer: Fix buf_parse eating input
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

When parsing a "line" that is longer than the
available line buffer, then buf_parse was
eating up to 2 characters. It advanced past
them but they were not part of the output.

This can lead to unexpected results if buf_parse
is used in a while loop on unrestricted input,
like e.g. when reading configs (see in_src_get()
used for check_inline_file_via_buf()).

Change-Id: I3724660bf0f8336ee58c172acfb7c4f38e457393
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1246
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1246
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index c0b85b2..28de00f 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -832,19 +832,24 @@
 
     do
     {
-        c = buf_read_u8(buf);
+        c = buf_peek_u8(buf);
         if (c < 0)
         {
             eol = true;
+            line[n] = 0;
+            break;
         }
-        if (c <= 0 || c == delim)
+        if (c == delim)
         {
-            c = 0;
+            buf_advance(buf, 1);
+            line[n] = 0;
+            break;
         }
-        if (n >= size)
+        if (n >= (size - 1))
         {
             break;
         }
+        buf_advance(buf, 1);
         line[n++] = (char)c;
     } while (c);
 
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 1405667..148cee0 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -771,7 +771,7 @@
 }
 
 static inline int
-buf_read_u8(struct buffer *buf)
+buf_peek_u8(struct buffer *buf)
 {
     int ret;
     if (BLEN(buf) < 1)
@@ -779,7 +779,17 @@
         return -1;
     }
     ret = *BPTR(buf);
-    buf_advance(buf, 1);
+    return ret;
+}
+
+static inline int
+buf_read_u8(struct buffer *buf)
+{
+    int ret = buf_peek_u8(buf);
+    if (ret >= 0)
+    {
+        buf_advance(buf, 1);
+    }
     return ret;
 }
 
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index c86c19e..92c4c65 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -450,6 +450,56 @@
     gc_free(&gc);
 }
 
+/* for building long texts */
+#define A_TIMES_256 "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO"
+
+void
+test_buffer_parse(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(1024, &gc);
+    char line[512];
+    bool status;
+    const char test1[] = A_TIMES_256 "EOL\n" A_TIMES_256 "EOF";
+
+    /* line buffer bigger than actual line */
+    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    status = buf_parse(&buf, '\n', line, sizeof(line));
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256 "EOL");
+    status = buf_parse(&buf, '\n', line, sizeof(line));
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256 "EOF");
+
+    /* line buffer exactly same size as actual line + terminating \0 */
+    buf_reset_len(&buf);
+    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    status = buf_parse(&buf, '\n', line, 260);
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256 "EOL");
+    status = buf_parse(&buf, '\n', line, 260);
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256 "EOF");
+
+    /* line buffer smaller than actual line */
+    buf_reset_len(&buf);
+    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    status = buf_parse(&buf, '\n', line, 257);
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256);
+    status = buf_parse(&buf, '\n', line, 257);
+    assert_int_equal(status, true);
+    assert_string_equal(line, "EOL");
+    status = buf_parse(&buf, '\n', line, 257);
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256);
+    status = buf_parse(&buf, '\n', line, 257);
+    assert_int_equal(status, true);
+    assert_string_equal(line, "EOF");
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -478,7 +528,8 @@
         cmocka_unit_test(test_character_class),
         cmocka_unit_test(test_character_string_mod_buf),
         cmocka_unit_test(test_snprintf),
-        cmocka_unit_test(test_buffer_chomp)
+        cmocka_unit_test(test_buffer_chomp),
+        cmocka_unit_test(test_buffer_parse)
     };
 
     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);

