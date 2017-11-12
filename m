From: Heiko Hund <heiko.hund@...1489...>
Date: Sun, 12 Nov 2017 09:34:03 +0100
Message-ID: <20171112083403.15922-1-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-8-git-send-email-heiko.hund@...1489...>
References: <1477672963-5724-8-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2 7/7] Add gc_arena to struct argv to save
 allocations
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

With the private gc_arena we do not have to allocate the strings
found during parsing again, since we know the arena they are
allocated in is valid as long as the argv vector is.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/argv.c                   | 44 ++++++++++++++++--------------------
 src/openvpn/argv.h                   |  1 +
 tests/unit_tests/openvpn/test_argv.c | 23 +++++++++++++++++++
 3 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 419b1dc6..51dd1b22 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -46,12 +46,11 @@ argv_extend(struct argv *a, const size_t newcap)
     {
         char **newargv;
         size_t i;
-        ALLOC_ARRAY_CLEAR(newargv, char *, newcap);
+        ALLOC_ARRAY_CLEAR_GC(newargv, char *, newcap, &a->gc);
         for (i = 0; i < a->argc; ++i)
         {
             newargv[i] = a->argv[i];
         }
-        free(a->argv);
         a->argv = newargv;
         a->capacity = newcap;
     }
@@ -63,6 +62,7 @@ argv_init(struct argv *a)
     a->capacity = 0;
     a->argc = 0;
     a->argv = NULL;
+    a->gc = gc_new();
     argv_extend(a, 8);
 }
 
@@ -77,24 +77,21 @@ argv_new(void)
 void
 argv_free(struct argv *a)
 {
-    size_t i;
-    for (i = 0; i < a->argc; ++i)
-    {
-        free(a->argv[i]);
-    }
-    free(a->argv);
+    gc_free(&a->gc);
 }
 
 static void
 argv_reset(struct argv *a)
 {
-    size_t i;
-    for (i = 0; i < a->argc; ++i)
+    if (a->argc)
     {
-        free(a->argv[i]);
-        a->argv[i] = NULL;
+        size_t i;
+        for (i = 0; i < a->argc; ++i)
+        {
+            a->argv[i] = NULL;
+        }
+        a->argc = 0;
     }
-    a->argc = 0;
 }
 
 static void
@@ -106,7 +103,7 @@ argv_grow(struct argv *a, const size_t add)
 }
 
 static void
-argv_append(struct argv *a, char *str)  /* str must have been malloced or be NULL */
+argv_append(struct argv *a, char *str)  /* str must have been gc_malloced or be NULL */
 {
     argv_grow(a, 1);
     a->argv[a->argc++] = str;
@@ -127,7 +124,7 @@ argv_clone(const struct argv *a, const size_t headroom)
     {
         for (i = 0; i < a->argc; ++i)
         {
-            argv_append(&r, string_alloc(a->argv[i], NULL));
+            argv_append(&r, string_alloc(a->argv[i], &r.gc));
         }
     }
     return r;
@@ -138,7 +135,7 @@ argv_insert_head(const struct argv *a, const char *head)
 {
     struct argv r;
     r = argv_clone(a, 1);
-    r.argv[0] = string_alloc(head, NULL);
+    r.argv[0] = string_alloc(head, &r.gc);
     return r;
 }
 
@@ -243,7 +240,7 @@ argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
     }
 
     size = adjust_power_of_2(len + 1);
-    buf = gc_malloc(size, false, &gc);
+    buf = gc_malloc(size, false, &a->gc);
     len = vsnprintf(buf, size, f, arglist);
     if (len < 0 || len >= size)
     {
@@ -255,11 +252,11 @@ argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
     while (end)
     {
         *end = '\0';
-        argv_append(a, string_alloc(buf, NULL));
+        argv_append(a, buf);
         buf = end + 1;
         end = strchr(buf, delim);
     }
-    argv_append(a, string_alloc(buf, NULL));
+    argv_append(a, buf);
 
     if (a->argc != argc)
     {
@@ -303,23 +300,20 @@ argv_parse_cmd(struct argv *a, const char *s)
 {
     int nparms;
     char *parms[MAX_PARMS + 1];
-    struct gc_arena gc = gc_new();
 
     argv_reset(a);
 
-    nparms = parse_line(s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
+    nparms = parse_line(s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &a->gc);
     if (nparms)
     {
         int i;
         for (i = 0; i < nparms; ++i)
         {
-            argv_append(a, string_alloc(parms[i], NULL));
+            argv_append(a, parms[i]);
         }
     }
     else
     {
-        argv_append(a, string_alloc(s, NULL));
+        argv_append(a, string_alloc(s, &a->gc));
     }
-
-    gc_free(&gc);
 }
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 2a1945e3..a1aa7ebb 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -33,6 +33,7 @@
 #include "buffer.h"
 
 struct argv {
+    struct gc_arena gc;
     size_t capacity;
     size_t argc;
     char **argv;
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index e15e2fe5..5bfef8af 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -118,6 +118,28 @@ argv_printf__empty_parameter__argc_correct(void **state)
 }
 
 static void
+argv_printf__long_args__data_correct(void **state)
+{
+    int i;
+    struct argv a = argv_new();
+    const char *args[] = {
+        "good_tools_have_good_names_even_though_it_might_impair_typing",
+        "--long-opt=looooooooooooooooooooooooooooooooooooooooooooooooong",
+        "--long-cat=loooooooooooooooooooooooooooooooooooooooooooooooooooonger",
+        "file_with_very_descriptive_filename_that_leaves_no_questions_open.jpg.exe"
+    };
+
+    argv_printf(&a, "%s %s %s %s", args[0], args[1], args[2], args[3]);
+    assert_int_equal(a.argc, 4);
+    for (i = 0; i < a.argc; i++)
+    {
+        assert_string_equal(a.argv[i], args[i]);
+    }
+
+    argv_free(&a);
+}
+
+static void
 argv_parse_cmd__command_string__argc_correct(void **state)
 {
     struct argv a = argv_new();
@@ -233,6 +255,7 @@ main(void)
         cmocka_unit_test(argv_printf__group_sep_in_arg__fail_no_ouput),
         cmocka_unit_test(argv_printf__combined_path_with_spaces__argc_correct),
         cmocka_unit_test(argv_printf__empty_parameter__argc_correct),
+        cmocka_unit_test(argv_printf__long_args__data_correct),
         cmocka_unit_test(argv_parse_cmd__command_string__argc_correct),
         cmocka_unit_test(argv_parse_cmd__command_and_extra_options__argc_correct),
         cmocka_unit_test(argv_printf_cat__used_twice__argc_correct),
-- 
2.11.0


