From: Gert Doering <gert@...1296...>
Date: Wed, 25 Dec 2024 17:56:29 +0100
Message-ID: <20241225165629.5558-1-gert@...1296...>
In-Reply-To: <gerrit.1732292548000.Ia0799189d45223e0b987a5a4da5be60404388f1f@...2715...>
References: <gerrit.1732292548000.Ia0799189d45223e0b987a5a4da5be60404388f1f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Add small unit test for buf_chomp
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

Change-Id: Ia0799189d45223e0b987a5a4da5be60404388f1f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/817
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 0fb4697..d43d5c1 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -426,6 +426,32 @@
 #endif
 }
 
+void
+test_buffer_chomp(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(1024, &gc);
+
+    const char test1[] =  "There is a nice 1234 year old tree!\n\r";
+    buf_write(&buf, test1, sizeof(test1));
+    buf_chomp(&buf);
+    /* Check that our own method agrees */
+    assert_true(string_check_buf(&buf, CC_PRINT | CC_NULL, CC_CRLF));
+    assert_string_equal(BSTR(&buf), "There is a nice 1234 year old tree!");
+
+    struct buffer buf2 = alloc_buf_gc(1024, &gc);
+    const char test2[] =  "CR_RESPONSE,MTIx\x0a\x00";
+    buf_write(&buf2, test2, sizeof(test2));
+    buf_chomp(&buf2);
+
+    buf_chomp(&buf2);
+    /* Check that our own method agrees */
+    assert_true(string_check_buf(&buf2, CC_PRINT | CC_NULL, CC_CRLF));
+    assert_string_equal(BSTR(&buf2), "CR_RESPONSE,MTIx");
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -460,7 +486,8 @@
         cmocka_unit_test(test_buffer_gc_realloc),
         cmocka_unit_test(test_character_class),
         cmocka_unit_test(test_character_string_mod_buf),
-        cmocka_unit_test(test_snprintf)
+        cmocka_unit_test(test_snprintf),
+        cmocka_unit_test(test_buffer_chomp)
     };
 
     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);

