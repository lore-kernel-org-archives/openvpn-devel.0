From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Dec 2023 15:53:30 +0000
In-Reply-To: <gerrit.1700478678000.I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21@...2715...>
References: <gerrit.1700478678000.I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ff98b7319fdcdbc53b19ab2c076226685e4bb405-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yENaD66wnk4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove dead list
 test code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yENaD66wnk4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Remove dead list test code
......................................................................

Remove dead list test code

Change-Id: I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M src/openvpn/init.c
M src/openvpn/list.c
M src/openvpn/list.h
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_misc.c
6 files changed, 177 insertions(+), 193 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/446/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 577bc5d..3beb259 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -669,8 +669,11 @@
         tests/unit_tests/openvpn/mock_get_random.c
         src/openvpn/options_util.c
         src/openvpn/ssl_util.c
+        src/openvpn/list.c
         )

+    target_compile_definitions(test_misc PRIVATE "-DSOURCEDIR=3D\"${CMAKE_=
SOURCE_DIR}\"")
+
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9e2b3845..33b6fad 100644
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
-    const char *str =3D (const char *) key;
-    const int len =3D strlen(str);
-    return hash_func((const uint8_t *)str, len, iv);
-}
-
-static bool
-word_compare_function(const void *key1, const void *key2)
-{
-    return strcmp((const char *)key1, (const char *)key2) =3D=3D 0;
-}
-
-static void
-print_nhash(struct hash *hash)
-{
-    struct hash_iterator hi;
-    struct hash_element *he;
-    int count =3D 0;
-
-    hash_iterator_init(hash, &hi, true);
-
-    while ((he =3D hash_iterator_next(&hi)))
-    {
-        printf("%d ", (int) he->value);
-        ++count;
-    }
-    printf("\n");
-
-    hash_iterator_free(&hi);
-    ASSERT(count =3D=3D hash_n_elements(hash));
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
-        struct gc_arena gc =3D gc_new();
-        struct hash *hash =3D hash_init(10000, get_random(), word_hash_fun=
ction, word_compare_function);
-        struct hash *nhash =3D hash_init(256, get_random(), word_hash_func=
tion, word_compare_function);
-
-        printf("hash_init n_buckets=3D%d mask=3D0x%08x\n", hash->n_buckets=
, hash->mask);
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
-            bi =3D wbi =3D 0;
-            do
-            {
-                c =3D buf[bi++];
-                if (isalnum(c) || c =3D=3D '_')
-                {
-                    ASSERT(wbi < (int) sizeof(wordbuf));
-                    wordbuf[wbi++] =3D c;
-                }
-                else
-                {
-                    if (wbi)
-                    {
-                        struct word *w;
-                        ASSERT(wbi < (int) sizeof(wordbuf));
-                        wordbuf[wbi++] =3D '\0';
-
-                        /* word is parsed from stdin */
-
-                        /* does it already exist in table? */
-                        w =3D (struct word *) hash_lookup(hash, wordbuf);
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
-                            w->word =3D string_alloc(wordbuf, &gc);
-                            w->n =3D 1;
-                            ASSERT(hash_add(hash, w->word, w, false));
-                            ASSERT(hash_add(nhash, w->word, (void *) ((ran=
dom() & 0x0F) + 1), false));
-                        }
-                    }
-                    wbi =3D 0;
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
-            int inc =3D 0;
-            int count =3D 0;
-
-            for (base =3D 0; base < hash_n_buckets(hash); base +=3D inc)
-            {
-                struct hash_iterator hi;
-                struct hash_element *he;
-                inc =3D (get_random() % 3) + 1;
-                hash_iterator_init_range(hash, &hi, true, base, base + inc=
);
-
-                while ((he =3D hash_iterator_next(&hi)))
-                {
-                    struct word *w =3D (struct word *) he->value;
-                    printf("%6d '%s'\n", w->n, w->word);
-                    ++count;
-                }
-
-                hash_iterator_free(&hi);
-            }
-            ASSERT(count =3D=3D hash_n_elements(hash));
-        }
-
-#if 1
-        /* test hash_remove_by_value function */
-        {
-            int i;
-            for (i =3D 1; i <=3D 16; ++i)
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
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index ef45b11..a9df34f 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -233,7 +233,8 @@
 	$(top_srcdir)/src/openvpn/ssl_util.c

 misc_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
-	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
+	-DSOURCEDIR=3D\"$(top_srcdir)\"

 misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@

@@ -243,4 +244,6 @@
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
-	$(top_srcdir)/src/openvpn/platform.c
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/list.c
+
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 43ae96b..7b9e38c 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -36,6 +36,7 @@

 #include "ssl_util.h"
 #include "options_util.h"
+#include "list.h"

 static void
 test_compat_lzo_string(void **state)
@@ -107,11 +108,179 @@
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
+    const char *str =3D (const char *) key;
+    const int len =3D strlen(str);
+    return hash_func((const uint8_t *)str, len, iv);
+}
+
+static bool
+word_compare_function(const void *key1, const void *key2)
+{
+    return strcmp((const char *)key1, (const char *)key2) =3D=3D 0;
+}
+
+static unsigned long
+get_random(void)
+{
+    /* rand() is not very random, but it's C99 and this is just for testin=
g */
+    return rand();
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
+    struct gc_arena gc =3D gc_new();
+    struct hash *hash =3D hash_init(10000, get_random(), word_hash_functio=
n, word_compare_function);
+    struct hash *nhash =3D hash_init(256, get_random(), word_hash_function=
, word_compare_function);
+
+    printf("hash_init n_buckets=3D%d mask=3D0x%08x\n", hash->n_buckets, ha=
sh->mask);
+
+    const char *wordfile =3D SOURCEDIR "/COPYRIGHT.GPL";
+    FILE *words =3D fopen(wordfile, "r");
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
+        char c =3D 0;
+        int bi =3D 0, wbi =3D 0;
+        do
+        {
+            c =3D buf[bi++];
+            if (isalnum(c) || c =3D=3D '_')
+            {
+                ASSERT(wbi < (int) sizeof(wordbuf));
+                wordbuf[wbi++] =3D c;
+            }
+            else
+            {
+                if (wbi)
+                {
+                    ASSERT(wbi < (int) sizeof(wordbuf));
+                    wordbuf[wbi++] =3D '\0';
+
+                    /* word is parsed from stdin */
+
+                    /* does it already exist in table? */
+                    struct word *w =3D (struct word *) hash_lookup(hash, w=
ordbuf);
+
+                    if (w)
+                    {
+                        /* yes, increment count */
+                        ++w->n;
+                    }
+                    else
+                    {
+                        /* no, make a new object */
+                        ALLOC_OBJ_GC(w, struct word, &gc);
+                        w->word =3D string_alloc(wordbuf, &gc);
+                        w->n =3D 1;
+                        ASSERT(hash_add(hash, w->word, w, false));
+                        ASSERT(hash_add(nhash, w->word, (void *) ((ptr_typ=
e )(random() & 0x0F) + 1), false));
+                    }
+                }
+                wbi =3D 0;
+            }
+        }
+        while (c);
+    }
+
+    /* remove some words from the table */
+    {
+        assert_true(hash_remove(hash, "DEFECTIVE"));
+        assert_false(hash_remove(hash, "false"));
+    }
+
+    /* output contents of hash table */
+    {
+        ptr_type inc =3D 0;
+        int count =3D 0;
+
+        for (ptr_type base =3D 0; base < hash_n_buckets(hash); base +=3D i=
nc)
+        {
+            struct hash_iterator hi;
+            struct hash_element *he;
+            inc =3D (get_random() % 3) + 1;
+            hash_iterator_init_range(hash, &hi, base, base + inc);
+
+            while ((he =3D hash_iterator_next(&hi)))
+            {
+                struct word *w =3D (struct word *) he->value;
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
+        ASSERT(count =3D=3D hash_n_elements(hash));
+    }
+
+    /* test hash_remove_by_value function */
+    {
+        for (ptr_type i =3D 1; i <=3D 16; ++i)
+        {
+            hash_remove_by_value(nhash, (void *) i);
+        }
+    }
+
+    hash_free(hash);
+    hash_free(nhash);
+    gc_free(&gc);
+}
+
+
 const struct CMUnitTest misc_tests[] =3D {
     cmocka_unit_test(test_compat_lzo_string),
     cmocka_unit_test(test_auth_fail_temp_no_flags),
     cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
+    cmocka_unit_test(test_list)
 };

 int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21
Gerrit-Change-Number: 446
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--yENaD66wnk4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Remove dead list test code<br><br>Change-Id: =
I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21<br>Signed-off-by: Arne Schwabe &l=
t;arne@...1227...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/init.c<br=
>M src/openvpn/list.c<br>M src/openvpn/list.h<br>M tests/unit_tests/openvpn=
/Makefile.am<br>M tests/unit_tests/openvpn/test_misc.c<br>6 files changed, =
177 insertions(+), 193 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/46/446/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.tx=
t b/CMakeLists.txt</span><br><span>index 577bc5d..3beb259 100644</span><br>=
<span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><=
span>@@ -669,8 +669,11 @@</span><br><span>         tests/unit_tests/openvpn=
/mock_get_random.c</span><br><span>         src/openvpn/options_util.c</spa=
n><br><span>         src/openvpn/ssl_util.c</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        src/openvpn/list.c</span><br><span>        =
 )</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    target_compile_definitions(test_misc PRIVATE &quot;-DSOURCEDIR=3D\&quo=
t;${CMAKE_SOURCE_DIR}\&quot;&quot;)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     target_sources(test_ncp PRIVATE</span=
><br><span>         src/openvpn/crypto_mbedtls.c</span><br><span>         s=
rc/openvpn/crypto_openssl.c</span><br><span>diff --git a/src/openvpn/init.c=
 b/src/openvpn/init.c</span><br><span>index 9e2b3845..33b6fad 100644</span>=
<br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c=
</span><br><span>@@ -865,11 +865,6 @@</span><br><span>     return false;</s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifdef LIST_TEST</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    list_test();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return false;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> #ifdef IFCONFIG_POOL_TEST</span><br><span>     ifconfig_pool_test(0x=
0A010004, 0x0A0100FF);</span><br><span>     return false;</span><br><span>d=
iff --git a/src/openvpn/list.c b/src/openvpn/list.c</span><br><span>index 4=
80f39d..dc4b1df 100644</span><br><span>--- a/src/openvpn/list.c</span><br><=
span>+++ b/src/openvpn/list.c</span><br><span>@@ -326,185 +326,6 @@</span><=
br><span> }</span><br><span> </span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef LIST_TEST</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Test the hash co=
de by implementing a simple</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * word frequency algorithm.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-struct word</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const char *word;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int n;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-word_hash_function(const void *key, ui=
nt32_t iv)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const char *str =3D (const =
char *) key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 int len =3D strlen(str);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return hash_func((const uint8_t *)str, len, iv);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-word_compare_fun=
ction(const void *key1, const void *key2)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return strcmp((const char *)key1, (const char *)key2) =3D=3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print=
_nhash(struct hash *hash)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_=
iterator hi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t hash_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int count =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    hash_iterator_init(h=
ash, &amp;hi, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while ((he =3D has=
h_iterator_next(&amp;hi)))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pri=
ntf(&quot;%d &quot;, (int) he-&gt;value);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        ++count;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   printf(&quot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hash_iterato=
r_free(&amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A=
SSERT(count =3D=3D hash_n_elements(hash));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-rmhash(struct hash *hash, cons=
t char *word)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    hash_remove(hash, word);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-list=
_test(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_thread_init();</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct hash *hash =3D hash_init(100=
00, get_random(), word_hash_function, word_compare_function);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct hash *nhash =3D hash=
_init(256, get_random(), word_hash_function, word_compare_function);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        printf(&quot;hash_init n_buckets=3D%d mas=
k=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /* parse words from stdin */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        while (true)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            char buf[256];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            char wordbuf[256];</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            int wbi;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            int bi;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            char c;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (!fgets(buf, sizeof(buf), stdin))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                break;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        bi =3D wbi =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     c =3D buf[bi++];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                if (isalnum(c) || c =3D=3D &#39;_&#39;)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    ASSERT(wbi &lt; (int) s=
izeof(wordbuf));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               wordbuf[wbi++] =3D c;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    if (wbi)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        struct word *w;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        ASSERT(wbi &lt; (in=
t) sizeof(wordbuf));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       wordbuf[wbi++] =3D &#39;\0&#39;;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        /* word is parsed from stdin */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        /* does it already exist =
in table? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               w =3D (struct word *) hash_lookup(hash, wordbuf);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        if (w)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                            /* yes, inc=
rement count */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                      ++w-&gt;n;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                        else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                            /* no, make a new obj=
ect */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
             ALLOC_OBJ_GC(w, struct word, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                            w-&gt;word =3D =
string_alloc(wordbuf, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                            w-&gt;n =3D 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                            ASSERT(hash_add=
(hash, w-&gt;word, w, false));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                            ASSERT(hash_add(nhash, w-&gt;word, (vo=
id *) ((random() &amp; 0x0F) + 1), false));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    wbi =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            } while (c);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* rem=
ove some words from the table */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           rmhash(hash, &quot;true&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            rmhash(hash, &quot;false&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* output contents of hash table */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            int base;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            int inc =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            int count =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         for (base =3D 0; base &lt; hash_n_buckets(hash); base +=3D inc)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                struct hash_iter=
ator hi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   struct hash_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                inc =3D (get_random() % 3) + 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                hash_iterator_init_range(ha=
sh, &amp;hi, true, base, base + inc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    struct word *w =3D (str=
uct word *) he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    printf(&quot;%6d &#39;%s&#39;\n&quot;, w-&gt;n, w-&=
gt;word);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        ++count;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                hash_iterator_=
free(&amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASS=
ERT(count =3D=3D hash_n_elements(hash));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 1</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* test hash_remove_by=
_value function */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int=
 i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            for (i=
 =3D 1; i &lt;=3D 16; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             printf(&quot;[%d] ***********************************\n&quot;,=
 i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                p=
rint_nhash(nhash);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             hash_remove_by_value(nhash, (void *) i, true);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            printf(&quot;FINAL ************=
**************\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            print_nhash(nhash);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        hash_free(hash);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        hash_free(nhash);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    openvpn_thread_cleanup();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef LIS=
T_TEST */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> /*</span><br><span>  * ----------------------------------------------=
----------------------</span><br><span>  * hash() -- hash a variable-length=
 key into a 32-bit value</span><br><span>diff --git a/src/openvpn/list.h b/=
src/openvpn/list.h</span><br><span>index 94d14f2..18afc54 100644</span><br>=
<span>--- a/src/openvpn/list.h</span><br><span>+++ b/src/openvpn/list.h</sp=
an><br><span>@@ -33,8 +33,6 @@</span><br><span>  * client instances over va=
rious key spaces.</span><br><span>  */</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/* define this to enable special list te=
st mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*#define L=
IST_TEST*/</span><br><span> </span><br><span> #include &quot;basic.h&quot;<=
/span><br><span> #include &quot;buffer.h&quot;</span><br><span>@@ -114,11 +=
112,6 @@</span><br><span> </span><br><span> uint32_t hash_func(const uint8_=
t *k, uint32_t length, uint32_t initval);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef LIST_TEST</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void list_test(void);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> static inline uint32_t</span><br><span> hash_value(const str=
uct hash *hash, const void *key)</span><br><span> {</span><br><span>diff --=
git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makef=
ile.am</span><br><span>index ef45b11..a9df34f 100644</span><br><span>--- a/=
tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests=
/openvpn/Makefile.am</span><br><span>@@ -233,7 +233,8 @@</span><br><span> 	=
$(top_srcdir)/src/openvpn/ssl_util.c</span><br><span> </span><br><span> mis=
c_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(=
top_srcdir)/src/openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src=
/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-DSOURCE=
DIR=3D\&quot;$(top_srcdir)\&quot;</span><br><span> </span><br><span> misc_t=
estdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> </span><br><span>@@ -=
243,4 +244,6 @@</span><br><span> 	$(top_srcdir)/src/openvpn/options_util.c =
\</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/platform.c</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform.=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/s=
rc/openvpn/list.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/un=
it_tests/openvpn/test_misc.c</span><br><span>index 43ae96b..7b9e38c 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_misc.c</span><br><span>@@ -36,6 +36,7 @=
@</span><br><span> </span><br><span> #include &quot;ssl_util.h&quot;</span>=
<br><span> #include &quot;options_util.h&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;list.h&quot;</span><br><span> </s=
pan><br><span> static void</span><br><span> test_compat_lzo_string(void **s=
tate)</span><br><span>@@ -107,11 +108,179 @@</span><br><span>     assert_in=
t_equal(o.server_backoff_time, 77);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct word</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *word;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static uint32_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wo=
rd_hash_function(const void *key, uint32_t iv)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *str =3D (const char *) key;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const int len =3D strlen(str);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return hash_func((cons=
t uint8_t *)str, len, iv);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+word_compare_function(const void *key1=
, const void *key2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return strcmp(=
(const char *)key1, (const char *)key2) =3D=3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
unsigned long</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ra=
ndom(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* rand() is not very r=
andom, but it&#39;s C99 and this is just for testing */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return rand();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_list(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Test the hash code by implementing a simple</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * word frequency algorithm.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash =3D hash_init(1000=
0, get_random(), word_hash_function, word_compare_function);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct hash *nhash =3D hash_in=
it(256, get_random(), word_hash_function, word_compare_function);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    printf(&quot;hash_init n_buckets=3D%d mask=
=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *wordfile =3D SOURCEDIR &quot;/COPYRIGHT.GPL=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FILE *wo=
rds =3D fopen(wordfile, &quot;r&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* parse words from file */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    while (true)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    char buf[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       char wordbuf[256];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
fgets(buf, sizeof(buf), words))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        char c =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        int bi =3D 0, wbi =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            c =3D buf[bi++];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (isalnum=
(c) || c =3D=3D &#39;_&#39;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                ASSERT(wbi &lt; (int) sizeof(wordbuf));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                wordbuf[wbi++] =3D c=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                if (wbi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    ASSERT(wbi=
 &lt; (int) sizeof(wordbuf));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    wordbuf[wbi++] =3D &#39;\0&#39;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    /* word is parsed from stdin */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    /* does it already=
 exist in table? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    struct word *w =3D (struct word *) hash_lookup(hash, wo=
rdbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    if (w)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  /* yes, increment count */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        ++w-&gt;n;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        /* no, make a new=
 object */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               ALLOC_OBJ_GC(w, struct word, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        w-&gt;word =3D st=
ring_alloc(wordbuf, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        w-&gt;n =3D 1;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        ASSERT(hash_add(hash, =
w-&gt;word, w, false));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        ASSERT(hash_add(nhash, w-&gt;word, (void *) ((p=
tr_type )(random() &amp; 0x0F) + 1), false));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                wbi =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        while (c);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* remove so=
me words from the table */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 assert_true(hash_remove(hash, &quot;DEFECTIVE&quot;));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        assert_false(hash_remove(hash, =
&quot;false&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* output contents of hash t=
able */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        ptr_type inc =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int count =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        for (ptr_type base =3D 0=
; base &lt; hash_n_buckets(hash); base +=3D inc)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            struct hash_iterator hi;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            struct hash_element *he;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            inc =3D (g=
et_random() % 3) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            hash_iterator_init_range(hash, &amp;hi, base, base + inc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            while ((he =3D hash_iterator_=
next(&amp;hi)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      struct word *w =3D (struct word *) he-&gt;value;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                /*printf(&quot;%6d &#39;=
%s&#39;\n&quot;, w-&gt;n, w-&gt;word); */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                ++count;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                /* check a few words to match pr=
ior results */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           if (!strcmp(w-&gt;word, &quot;is&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    assert_int_equal(w-&g=
t;n, 49);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    else if  (!strcmp(w-&gt;word, &quot;redistribute&quot;))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    assert_int_equal=
(w-&gt;n, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        else if  (!strcmp(w-&gt;word, &quot;circumstances&quot;))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    assert_int_=
equal(w-&gt;n, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             else if  (!strcmp(w-&gt;word, &quot;so&quot;))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    assert_int_equal(=
w-&gt;n, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       else if  (!strcmp(w-&gt;word, &quot;BECAUSE&quot;))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    assert_int_equal(w=
-&gt;n, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            hash_iterator_free(&amp=
;hi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(count =3D=
=3D hash_n_elements(hash));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* test hash_remove_b=
y_value function */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (p=
tr_type i =3D 1; i &lt;=3D 16; ++i)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            hash_remove_by_value(nhash, (void *) i);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
hash_free(hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 hash_free(nhash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUni=
tTest misc_tests[] =3D {</span><br><span>     cmocka_unit_test(test_compat_=
lzo_string),</span><br><span>     cmocka_unit_test(test_auth_fail_temp_no_f=
lags),</span><br><span>     cmocka_unit_test(test_auth_fail_temp_flags),</s=
pan><br><span>     cmocka_unit_test(test_auth_fail_temp_flags_msg),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_l=
ist)</span><br><span> };</span><br><span> </span><br><span> int</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/446?usp=3Demail">change 446</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/446=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7511bc43cd6a0bcb89476f27d58=
22ab4a78d0d21 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 446 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--yENaD66wnk4=--

