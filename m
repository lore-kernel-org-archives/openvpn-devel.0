From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 28 Oct 2016 18:42:43 +0200
Message-ID: <1477672963-5724-8-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/7] Add gc_arena to struct argv to save
	allocations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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
 src/openvpn/argv.c                   | 37 ++++++++++++++++++------------------
 src/openvpn/argv.h                   |  1 +
 tests/unit_tests/openvpn/test_argv.c | 21 ++++++++++++++++++++
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 664785b..9f139bb 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -62,6 +62,7 @@ argv_init (struct argv *a)
   a->capacity = 0;
   a->argc = 0;
   a->argv = NULL;
+  a->gc = gc_new ();
   argv_extend (a, 8);
 }
 
@@ -76,22 +77,23 @@ argv_new (void)
 void
 argv_free (struct argv *a)
 {
-  size_t i;
-  for (i = 0; i < a->argc; ++i)
-    free (a->argv[i]);
+  gc_free (&a->gc);
   free (a->argv);
 }
 
 static void
 argv_reset (struct argv *a)
 {
-  size_t i;
-  for (i = 0; i < a->argc; ++i)
+  if (a->argc)
     {
-      free (a->argv[i]);
-      a->argv[i] = NULL;
+      size_t i;
+      for (i = 0; i < a->argc; ++i)
+        a->argv[i] = NULL;
+      a->argc = 0;
+
+      gc_free (&a->gc);
+      a->gc = gc_new ();
     }
-  a->argc = 0;
 }
 
 static void
@@ -103,7 +105,7 @@ argv_grow (struct argv *a, const size_t add)
 }
 
 static void
-argv_append (struct argv *a, char *str) /* str must have been malloced or be NULL */
+argv_append (struct argv *a, char *str) /* str must have been gc_malloced or be NULL */
 {
   argv_grow (a, 1);
   a->argv[a->argc++] = str;
@@ -121,7 +123,7 @@ argv_clone (const struct argv *a, const size_t headroom)
   if (a)
     {
       for (i = 0; i < a->argc; ++i)
-        argv_append (&r, string_alloc (a->argv[i], NULL));
+        argv_append (&r, string_alloc (a->argv[i], &r.gc));
     }
   return r;
 }
@@ -131,7 +133,7 @@ argv_insert_head (const struct argv *a, const char *head)
 {
   struct argv r;
   r = argv_clone (a, 1);
-  r.argv[0] = string_alloc (head, NULL);
+  r.argv[0] = string_alloc (head, &r.gc);
   return r;
 }
 
@@ -212,7 +214,7 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
     goto out;
 
   size = adjust_power_of_2 (len + 1);
-  buf = gc_malloc (size, false, &gc);
+  buf = gc_malloc (size, false, &a->gc);
   len = vsnprintf (buf, size, f, arglist);
   if (len < 0 || len >= size)
     goto out;
@@ -220,7 +222,7 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
   token = strtok (buf, delim);
   while (token)
     {
-      argv_append (a, string_alloc (token, NULL));
+      argv_append (a, token);
       token = strtok (NULL, delim);
     }
 
@@ -266,19 +268,16 @@ argv_parse_cmd (struct argv *a, const char *s)
 {
   int nparms;
   char *parms[MAX_PARMS + 1];
-  struct gc_arena gc = gc_new ();
 
   argv_reset (a);
 
-  nparms = parse_line (s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
+  nparms = parse_line (s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &a->gc);
   if (nparms)
     {
       int i;
       for (i = 0; i < nparms; ++i)
-        argv_append (a, string_alloc (parms[i], NULL));
+        argv_append (a, parms[i]);
     }
   else
-    argv_append (a, string_alloc (s, NULL));
-
-  gc_free (&gc);
+    argv_append (a, string_alloc (s, &a->gc));
 }
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 99fd7ad..7169f1d 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -34,6 +34,7 @@
 #include "buffer.h"
 
 struct argv {
+  struct gc_arena gc;
   size_t capacity;
   size_t argc;
   char **argv;
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index d2cd96d..3de1897 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -123,6 +123,27 @@ argv_printf__combined_path_with_spaces__argc_correct (void **state)
 }
 
 static void
+argv_printf__long_args__data_correct (void **state)
+{
+  int i;
+  struct argv a = argv_new ();
+  const char *args[] = {
+    "good_tools_have_good_names_even_though_it_might_impair_typing",
+    "--long-opt=looooooooooooooooooooooooooooooooooooooooooooooooong",
+    "--long-cat=loooooooooooooooooooooooooooooooooooooooooooooooooooonger",
+    "file_with_very_descriptive_filename_that_leaves_no_questions_open.jpg.exe"
+  };
+
+  argv_printf (&a, "%s %s %s %s", args[0], args[1], args[2], args[3]);
+  assert_int_equal (a.argc, 4);
+  for (i = 0; i < a.argc; i++) {
+    assert_string_equal (a.argv[i], args[i]);
+  }
+
+  argv_free (&a);
+}
+
+static void
 argv_parse_cmd__command_string__argc_correct (void **state)
 {
   struct argv a = argv_new ();
-- 
2.7.4


