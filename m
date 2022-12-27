From: Arne Schwabe <arne@...1227...>
Date: Tue, 27 Dec 2022 15:02:45 +0100
Message-Id: <20221227140249.3524943-2-arne@...1227...>
In-Reply-To: <20221227140249.3524943-1-arne@...1227...>
References: <20221227140249.3524943-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Replace realloc with new gc_realloc
 function
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

The realloc logic has the problem that it relies on the memory being
deallocated by uninit_options rather than by freeing the gc. This
does not always happen in all code path. Especially the crypto selftest
run by make check will not call uninit_options.

This introduces a gc_realloc function that ensures that the pointer is
instead freed when gc_free is called.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/buffer.c                   | 33 ++++++++++++++++++++++++++
 src/openvpn/buffer.h                   | 13 ++++++++++
 src/openvpn/options.c                  |  6 ++---
 tests/unit_tests/openvpn/test_buffer.c | 32 +++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 575d45a1f..e3d5ba241 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -412,6 +412,39 @@ gc_malloc(size_t size, bool clear, struct gc_arena *a)
     return ret;
 }
 
+void *
+gc_realloc(void *ptr, size_t size, struct gc_arena *a)
+{
+    void *ret = realloc(ptr, size);
+    check_malloc_return(ret);
+    if (a)
+    {
+        if (ptr && ptr != ret)
+        {
+            /* find the old entry and modify it if realloc changed
+             * the pointer */
+            struct gc_entry_special *e = NULL;
+            for (e = a->list_special; e != NULL; e = e->next)
+            {
+                if (e->addr == ptr)
+                {
+                    break;
+                }
+            }
+            ASSERT(e);
+            ASSERT(e->addr == ptr);
+            e->addr = ret;
+        }
+        else if (!ptr)
+        {
+            /* sets e->addr to newptr */
+            gc_addspecial(ret, free, a);
+        }
+    }
+
+    return ret;
+}
+
 void
 x_gc_free(struct gc_arena *a)
 {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index fece6336d..185226f7c 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -187,6 +187,19 @@ struct buffer string_alloc_buf(const char *str, struct gc_arena *gc);
 
 void gc_addspecial(void *addr, void (*free_function)(void *), struct gc_arena *a);
 
+/**
+ * allows to realloc a pointer previously allocated by gc_malloc or gc_realloc
+ *
+ * @note only use this function on pointers returned by gc_malloc or re_alloc
+ *       with the same gc_arena
+ *
+ * @param ptr   Pointer of the previously allocated memory
+ * @param size  New size
+ * @param a     gc_arena to use
+ * @return      new pointer
+ */
+void *
+gc_realloc(void *ptr, size_t size, struct gc_arena *a);
 
 #ifdef BUF_INIT_TRACKING
 #define buf_init(buf, offset) buf_init_debug(buf, offset, __FILE__, __LINE__)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4e018fb84..e454b2ac0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -918,12 +918,10 @@ uninit_options(struct options *o)
 {
     if (o->connection_list)
     {
-        free(o->connection_list->array);
         CLEAR(*o->connection_list);
     }
     if (o->remote_list)
     {
-        free(o->remote_list->array);
         CLEAR(*o->remote_list);
     }
     if (o->gc_owned)
@@ -2173,7 +2171,7 @@ alloc_connection_entry(struct options *options, const int msglevel)
     if (l->len == l->capacity)
     {
         int capacity = l->capacity + CONNECTION_LIST_SIZE;
-        struct connection_entry **ce = realloc(l->array, capacity*sizeof(struct connection_entry *));
+        struct connection_entry **ce = gc_realloc(l->array, capacity*sizeof(struct connection_entry *), &options->gc);
         if (ce == NULL)
         {
             msg(msglevel, "Unable to process more connection options: out of memory. Number of entries = %d", l->len);
@@ -2206,7 +2204,7 @@ alloc_remote_entry(struct options *options, const int msglevel)
     if (l->len == l->capacity)
     {
         int capacity = l->capacity + CONNECTION_LIST_SIZE;
-        struct remote_entry **re = realloc(l->array, capacity*sizeof(struct remote_entry *));
+        struct remote_entry **re = gc_realloc(l->array, capacity*sizeof(struct remote_entry *), &options->gc);
         if (re == NULL)
         {
             msg(msglevel, "Unable to process more remote options: out of memory. Number of entries = %d", l->len);
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index ac701669f..9e3b1d2e9 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -231,6 +231,37 @@ test_buffer_free_gc_two(void **state)
     gc_free(&gc);
 }
 
+
+static void
+test_buffer_gc_realloc(void **state)
+{
+    struct gc_arena gc = gc_new();
+
+    void *p1 = gc_realloc(NULL, 512, &gc);
+    void *p2 = gc_realloc(NULL, 512, &gc);
+
+    assert_ptr_not_equal(p1, p2);
+
+    memset(p1, '1', 512);
+    memset(p2, '2', 512);
+
+    p1 = gc_realloc(p1, 512, &gc);
+
+    /* allocate 512kB to ensure the pointer needs to change */
+    void *p1new = gc_realloc(p1, 512ul * 1024, &gc);
+    assert_ptr_not_equal(p1, p1new);
+
+    void *p2new = gc_realloc(p2, 512ul * 1024, &gc);
+    assert_ptr_not_equal(p2, p2new);
+
+    void *p3 = gc_realloc(NULL, 512, &gc);
+    memset(p3, '3', 512);
+
+
+    gc_free(&gc);
+}
+
+
 int
 main(void)
 {
@@ -259,6 +290,7 @@ main(void)
                                         test_buffer_list_teardown),
         cmocka_unit_test(test_buffer_free_gc_one),
         cmocka_unit_test(test_buffer_free_gc_two),
+        cmocka_unit_test(test_buffer_gc_realloc),
     };
 
     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);
-- 
2.37.1 (Apple Git-137.1)


