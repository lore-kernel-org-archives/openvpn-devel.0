From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  1 Dec 2023 12:22:43 +0100
Message-Id: <20231201112243.15541-1-frank@...2641...>
In-Reply-To: <gerrit.1701361470000.Ib2aa85b9c34d0a0b8b1dfb9f477f56c9a6b705d0@...2715...>
References: <gerrit.1701361470000.Ib2aa85b9c34d0a0b8b1dfb9f477f56c9a6b705d0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Replace character_class_debug with
 proper unit test
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

Change-Id: Ib2aa85b9c34d0a0b8b1dfb9f477f56c9a6b705d0
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/464
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

Note: this requires "Remove dead remains of extract_x509_field_test"
(https://gerrit.openvpn.net/c/openvpn/+/462) to be applied first.
        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 24f1ef2..0b94a52 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1150,26 +1150,6 @@
     }
 }
 
-#ifdef CHARACTER_CLASS_DEBUG
-
-#define CC_INCLUDE    (CC_PRINT)
-#define CC_EXCLUDE    (0)
-#define CC_REPLACE    ('.')
-
-void
-character_class_debug(void)
-{
-    char buf[256];
-
-    while (fgets(buf, sizeof(buf), stdin) != NULL)
-    {
-        string_mod(buf, CC_INCLUDE, CC_EXCLUDE, CC_REPLACE);
-        printf("%s", buf);
-    }
-}
-
-#endif
-
 #ifdef VERIFY_ALIGNMENT
 void
 valign4(const struct buffer *buf, const char *file, const int line)
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 4cc7950..0456b27 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -896,8 +896,6 @@
  */
 const char *np(const char *str);
 
-/*#define CHARACTER_CLASS_DEBUG*/
-
 /* character classes */
 
 #define CC_ANY                (1<<0)
@@ -961,11 +959,6 @@
 }
 
 
-#ifdef CHARACTER_CLASS_DEBUG
-void character_class_debug(void);
-
-#endif
-
 /*
  * Verify that a pointer is correctly aligned
  */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fdab26b..9972ed7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -875,11 +875,6 @@
     return false;
 #endif
 
-#ifdef CHARACTER_CLASS_DEBUG
-    character_class_debug();
-    return false;
-#endif
-
 #ifdef TIME_TEST
     time_test();
     return false;
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 8232f92..f994812 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -319,6 +319,30 @@
     gc_free(&gc);
 }
 
+static void
+test_character_class(void **state)
+{
+    char buf[256];
+    strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
+    string_mod(buf, CC_PRINT, 0, '@');
+    assert_string_equal(buf, "There is @ a nice 1234 year old tr@ ee!");
+
+    strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
+    string_mod(buf, CC_PRINT, CC_DIGIT, '@');
+    assert_string_equal(buf, "There is @ a nice @@@@ year old tr@ ee!");
+
+    strcpy(buf, "There is \x01 a nice 1234 year old tr\x7f ee!");
+    string_mod(buf, CC_ALPHA, CC_DIGIT, '.');
+    assert_string_equal(buf, "There.is...a.nice......year.old.tr..ee.");
+
+    strcpy(buf, "There is \x01 a 'nice' \"1234\"\n year old \ntr\x7f ee!");
+    string_mod(buf, CC_ALPHA|CC_DIGIT|CC_NEWLINE|CC_SINGLE_QUOTE, CC_DOUBLE_QUOTE|CC_BLANK, '.');
+    assert_string_equal(buf, "There.is...a.'nice'..1234.\n.year.old.\ntr..ee.");
+
+    strcpy(buf, "There is a \\'nice\\' \"1234\" [*] year old \ntree!");
+    string_mod(buf, CC_PRINT, CC_BACKSLASH|CC_ASTERISK, '.');
+    assert_string_equal(buf, "There is a .'nice.' \"1234\" [.] year old .tree!");
+}
 
 int
 main(void)
@@ -351,6 +375,7 @@
         cmocka_unit_test(test_buffer_free_gc_one),
         cmocka_unit_test(test_buffer_free_gc_two),
         cmocka_unit_test(test_buffer_gc_realloc),
+        cmocka_unit_test(test_character_class),
     };
 
     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);

