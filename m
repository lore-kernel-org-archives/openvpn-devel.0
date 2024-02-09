From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  9 Feb 2024 11:59:02 +0100
Message-Id: <20240209105902.14506-1-frank@...2641...>
In-Reply-To: <gerrit.1700478678000.I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21@...2715...>
References: <gerrit.1700478678000.I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Turn dead list test code into unit test
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

Change-Id: I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/446
This mail reflects revision 5 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index fdd2b01..3127611 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -747,6 +747,7 @@
         tests/unit_tests/openvpn/mock_get_random.c
         src/openvpn/options_util.c
         src/openvpn/ssl_util.c
+        src/openvpn/list.c
         )
 
     target_sources(test_ncp PRIVATE
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c5cc154..52b4308 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -865,11 +865,6 @@
     return false;
 #endif
 
-#ifdef LIST_TEST
-    list_test();
-    return false;
-#endif
-
 #ifdef IFCONFIG_POOL_TEST
     ifconfig_pool_test(0x0A010004, 0x0A0100FF);
     return false;
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 480f39d..dc4b1df 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -326,185 +326,6 @@
 }
 
 
-#ifdef LIST_TEST
-
-/*
- * Test the hash code by implementing a simple
- * word frequency algorithm.
- */
-
-struct word
-{
-    const char *word;
-    int n;
-};
-
-static uint32_t
-word_hash_function(const void *key, uint32_t iv)
-{
-    const char *str = (const char *) key;
-    const int len = strlen(str);
-    return hash_func((const uint8_t *)str, len, iv);
-}
-
-static bool
-word_compare_function(const void *key1, const void *key2)
-{
-    return strcmp((const char *)key1, (const char *)key2) == 0;
-}
-
-static void
-print_nhash(struct hash *hash)
-{
-    struct hash_iterator hi;
-    struct hash_element *he;
-    int count = 0;
-
-    hash_iterator_init(hash, &hi, true);
-
-    while ((he = hash_iterator_next(&hi)))
-    {
-        printf("%d ", (int) he->value);
-        ++count;
-    }
-    printf("\n");
-
-    hash_iterator_free(&hi);
-    ASSERT(count == hash_n_elements(hash));
-}
-
-static void
-rmhash(struct hash *hash, const char *word)
-{
-    hash_remove(hash, word);
-}
-
-void
-list_test(void)
-{
-    openvpn_thread_init();
-
-    {
-        struct gc_arena gc = gc_new();
-        struct hash *hash = hash_init(10000, get_random(), word_hash_function, word_compare_function);
-        struct hash *nhash = hash_init(256, get_random(), word_hash_function, word_compare_function);
-
-        printf("hash_init n_buckets=%d mask=0x%08x\n", hash->n_buckets, hash->mask);
-
-        /* parse words from stdin */
-        while (true)
-        {
-            char buf[256];
-            char wordbuf[256];
-            int wbi;
-            int bi;
-            char c;
-
-            if (!fgets(buf, sizeof(buf), stdin))
-            {
-                break;
-            }
-
-            bi = wbi = 0;
-            do
-            {
-                c = buf[bi++];
-                if (isalnum(c) || c == '_')
-                {
-                    ASSERT(wbi < (int) sizeof(wordbuf));
-                    wordbuf[wbi++] = c;
-                }
-                else
-                {
-                    if (wbi)
-                    {
-                        struct word *w;
-                        ASSERT(wbi < (int) sizeof(wordbuf));
-                        wordbuf[wbi++] = '\0';
-
-                        /* word is parsed from stdin */
-
-                        /* does it already exist in table? */
-                        w = (struct word *) hash_lookup(hash, wordbuf);
-
-                        if (w)
-                        {
-                            /* yes, increment count */
-                            ++w->n;
-                        }
-                        else
-                        {
-                            /* no, make a new object */
-                            ALLOC_OBJ_GC(w, struct word, &gc);
-                            w->word = string_alloc(wordbuf, &gc);
-                            w->n = 1;
-                            ASSERT(hash_add(hash, w->word, w, false));
-                            ASSERT(hash_add(nhash, w->word, (void *) ((random() & 0x0F) + 1), false));
-                        }
-                    }
-                    wbi = 0;
-                }
-            } while (c);
-        }
-
-#if 1
-        /* remove some words from the table */
-        {
-            rmhash(hash, "true");
-            rmhash(hash, "false");
-        }
-#endif
-
-        /* output contents of hash table */
-        {
-            int base;
-            int inc = 0;
-            int count = 0;
-
-            for (base = 0; base < hash_n_buckets(hash); base += inc)
-            {
-                struct hash_iterator hi;
-                struct hash_element *he;
-                inc = (get_random() % 3) + 1;
-                hash_iterator_init_range(hash, &hi, true, base, base + inc);
-
-                while ((he = hash_iterator_next(&hi)))
-                {
-                    struct word *w = (struct word *) he->value;
-                    printf("%6d '%s'\n", w->n, w->word);
-                    ++count;
-                }
-
-                hash_iterator_free(&hi);
-            }
-            ASSERT(count == hash_n_elements(hash));
-        }
-
-#if 1
-        /* test hash_remove_by_value function */
-        {
-            int i;
-            for (i = 1; i <= 16; ++i)
-            {
-                printf("[%d] ***********************************\n", i);
-                print_nhash(nhash);
-                hash_remove_by_value(nhash, (void *) i, true);
-            }
-            printf("FINAL **************************\n");
-            print_nhash(nhash);
-        }
-#endif
-
-        hash_free(hash);
-        hash_free(nhash);
-        gc_free(&gc);
-    }
-
-    openvpn_thread_cleanup();
-}
-
-#endif /* ifdef LIST_TEST */
-
 /*
  * --------------------------------------------------------------------
  * hash() -- hash a variable-length key into a 32-bit value
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 94d14f2..18afc54 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -33,8 +33,6 @@
  * client instances over various key spaces.
  */
 
-/* define this to enable special list test mode */
-/*#define LIST_TEST*/
 
 #include "basic.h"
 #include "buffer.h"
@@ -114,11 +112,6 @@
 
 uint32_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
 
-#ifdef LIST_TEST
-void list_test(void);
-
-#endif
-
 static inline uint32_t
 hash_value(const struct hash *hash, const void *key)
 {
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 88a694d..dfb9f6a 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -288,7 +288,8 @@
 	$(top_srcdir)/src/openvpn/ssl_util.c
 
 misc_testdriver_CFLAGS  = @TEST_CFLAGS@ \
-	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	-DSOURCEDIR=\"$(top_srcdir)\"
 
 misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
 
@@ -298,4 +299,6 @@
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
-	$(top_srcdir)/src/openvpn/platform.c
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/list.c
+
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 193f131..04dbd5a 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -37,6 +37,7 @@
 #include "ssl_util.h"
 #include "options_util.h"
 #include "test_common.h"
+#include "list.h"
 
 static void
 test_compat_lzo_string(void **state)
@@ -108,11 +109,215 @@
     assert_int_equal(o.server_backoff_time, 77);
 }
 
+
+
+struct word
+{
+    const char *word;
+    int n;
+};
+
+
+static uint32_t
+word_hash_function(const void *key, uint32_t iv)
+{
+    const char *str = (const char *) key;
+    const int len = strlen(str);
+    return hash_func((const uint8_t *)str, len, iv);
+}
+
+static bool
+word_compare_function(const void *key1, const void *key2)
+{
+    return strcmp((const char *)key1, (const char *)key2) == 0;
+}
+
+static unsigned long
+get_random(void)
+{
+    /* rand() is not very random, but it's C99 and this is just for testing */
+    return rand();
+}
+
+static struct hash_element *
+hash_lookup_by_value(struct hash *hash, void *value)
+{
+    struct hash_iterator hi;
+    struct hash_element *he;
+    struct hash_element *ret = NULL;
+    hash_iterator_init(hash, &hi);
+
+    while ((he = hash_iterator_next(&hi)))
+    {
+        if (he->value == value)
+        {
+            ret = he;
+        }
+    }
+    hash_iterator_free(&hi);
+    return ret;
+}
+
+static void
+test_list(void **state)
+{
+
+/*
+ * Test the hash code by implementing a simple
+ * word frequency algorithm.
+ */
+
+    struct gc_arena gc = gc_new();
+    struct hash *hash = hash_init(10000, get_random(), word_hash_function, word_compare_function);
+    struct hash *nhash = hash_init(256, get_random(), word_hash_function, word_compare_function);
+
+    printf("hash_init n_buckets=%d mask=0x%08x\n", hash->n_buckets, hash->mask);
+
+    char wordfile[PATH_MAX] = { 0 };
+    openvpn_test_get_srcdir_dir(wordfile, PATH_MAX, "/../../../COPYRIGHT.GPL" );
+
+    FILE *words = fopen(wordfile, "r");
+    assert_non_null(words);
+
+    int wordcount = 0;
+
+    /* parse words from file */
+    while (true)
+    {
+        char buf[256];
+        char wordbuf[256];
+
+        if (!fgets(buf, sizeof(buf), words))
+        {
+            break;
+        }
+
+        char c = 0;
+        int bi = 0, wbi = 0;
+
+        do
+        {
+            c = buf[bi++];
+            if (isalnum(c) || c == '_')
+            {
+                assert_true(wbi < (int) sizeof(wordbuf));
+                wordbuf[wbi++] = c;
+            }
+            else
+            {
+                if (wbi)
+                {
+                    wordcount++;
+
+                    ASSERT(wbi < (int) sizeof(wordbuf));
+                    wordbuf[wbi++] = '\0';
+
+                    /* word is parsed from stdin */
+
+                    /* does it already exist in table? */
+                    struct word *w = (struct word *) hash_lookup(hash, wordbuf);
+
+                    if (w)
+                    {
+                        assert_string_equal(w->word, wordbuf);
+                        /* yes, increment count */
+                        ++w->n;
+                    }
+                    else
+                    {
+                        /* no, make a new object */
+                        ALLOC_OBJ_GC(w, struct word, &gc);
+                        w->word = string_alloc(wordbuf, &gc);
+                        w->n = 1;
+                        assert_true(hash_add(hash, w->word, w, false));
+                        assert_true(hash_add(nhash, w->word, (void *) ((ptr_type )(random() & 0x0F) + 1), false));
+                    }
+                }
+                wbi = 0;
+            }
+        }
+        while (c);
+    }
+
+    assert_int_equal(wordcount, 2978);
+
+    /* remove some words from the table */
+    {
+        assert_true(hash_remove(hash, "DEFECTIVE"));
+        assert_false(hash_remove(hash, "false"));
+    }
+
+    /* output contents of hash table */
+    {
+        ptr_type inc = 0;
+        int count = 0;
+
+        for (ptr_type base = 0; base < hash_n_buckets(hash); base += inc)
+        {
+            struct hash_iterator hi;
+            struct hash_element *he;
+            inc = (get_random() % 3) + 1;
+            hash_iterator_init_range(hash, &hi, base, base + inc);
+
+            while ((he = hash_iterator_next(&hi)))
+            {
+                struct word *w = (struct word *) he->value;
+                /*printf("%6d '%s'\n", w->n, w->word); */
+                ++count;
+                /* check a few words to match prior results */
+                if (!strcmp(w->word, "is"))
+                {
+                    assert_int_equal(w->n, 49);
+                }
+                else if  (!strcmp(w->word, "redistribute"))
+                {
+                    assert_int_equal(w->n, 5);
+                }
+                else if  (!strcmp(w->word, "circumstances"))
+                {
+                    assert_int_equal(w->n, 1);
+                }
+                else if  (!strcmp(w->word, "so"))
+                {
+                    assert_int_equal(w->n, 8);
+                }
+                else if  (!strcmp(w->word, "BECAUSE"))
+                {
+                    assert_int_equal(w->n, 1);
+                }
+            }
+
+            hash_iterator_free(&hi);
+        }
+        assert_int_equal(count, hash_n_elements(hash));
+    }
+
+    /* test hash_remove_by_value function */
+    {
+        for (ptr_type i = 1; i <= 16; ++i)
+        {
+            struct hash_element *item = hash_lookup_by_value(nhash, (void *) i);
+            hash_remove_by_value(nhash, (void *) i);
+            /* check item got removed if it was present before */
+            if (item)
+            {
+                assert_null(hash_lookup_by_value(nhash, (void *) i));
+            }
+        }
+    }
+
+    hash_free(hash);
+    hash_free(nhash);
+    gc_free(&gc);
+}
+
+
 const struct CMUnitTest misc_tests[] = {
     cmocka_unit_test(test_compat_lzo_string),
     cmocka_unit_test(test_auth_fail_temp_no_flags),
     cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
+    cmocka_unit_test(test_list)
 };
 
 int

