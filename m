From: Gert Doering <gert@...1296...>
Date: Tue,  7 Apr 2026 11:50:38 +0200
Message-ID: <20260407095044.28528-1-gert@...1296...>
In-Reply-To: <gerrit.1773842036000.I01683153a68e1809a4d7ab455eb346f53780e219@...2715...>
References: <gerrit.1773842036000.I01683153a68e1809a4d7ab455eb346f53780e219@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] test_buffer: Add test for
 buf_null_terminate
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

Change-Id: I01683153a68e1809a4d7ab455eb346f53780e219
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1580
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1580
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 5f43e0d..326de40 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -460,6 +460,32 @@
     gc_free(&gc);
 }
 
+void
+test_buffer_null_terminate(void **state)
+{
+    struct gc_arena gc = gc_new();
+
+    struct buffer buf = alloc_buf_gc(5, &gc);
+    const char test1[] = "1234";
+    const char test2[] = "12345";
+    assert_true(buf_write(&buf, test1, sizeof(test1)));
+    assert_string_equal(BSTR(&buf), "1234");
+    buf_null_terminate(&buf);
+    assert_string_equal(BSTR(&buf), "1234");
+
+    assert_true(buf_inc_len(&buf, -1));
+    assert_true(buf_write_u8(&buf, '5'));
+    assert_memory_equal(BPTR(&buf), test2, strlen(test2));
+    buf_null_terminate(&buf);
+    assert_string_equal(BSTR(&buf), "1234");
+
+    struct buffer buf2;
+    CLEAR(buf2);
+    buf_null_terminate(&buf2);
+
+    gc_free(&gc);
+}
+
 /* for building long texts */
 #define A_TIMES_256 "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO"
 
@@ -540,6 +566,7 @@
         cmocka_unit_test(test_snprintf),
         cmocka_unit_test(test_checked_snprintf),
         cmocka_unit_test(test_buffer_chomp),
+        cmocka_unit_test(test_buffer_null_terminate),
         cmocka_unit_test(test_buffer_parse)
     };
 

