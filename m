From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:01:51 +0100
Message-Id: <20211207170211.3275837-2-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 01/21] Remove max_size from buffer_list_new
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

This argument is never used apart from a unit test. Remove this
argument as a small cleanup.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/buffer.c                   |  7 +++----
 src/openvpn/buffer.h                   |  4 +---
 src/openvpn/manage.c                   |  4 ++--
 src/openvpn/ssl.c                      |  2 +-
 tests/unit_tests/openvpn/test_buffer.c | 22 ++++------------------
 5 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 486a77548..e9afb6d6a 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1171,11 +1171,10 @@ valign4(const struct buffer *buf, const char *file, const int line)
  * struct buffer_list
  */
 struct buffer_list *
-buffer_list_new(const int max_size)
+buffer_list_new()
 {
     struct buffer_list *ret;
     ALLOC_OBJ_CLEAR(ret, struct buffer_list);
-    ret->max_size = max_size;
     ret->size = 0;
     return ret;
 }
@@ -1229,7 +1228,7 @@ struct buffer_entry *
 buffer_list_push_data(struct buffer_list *ol, const void *data, size_t size)
 {
     struct buffer_entry *e = NULL;
-    if (data && (!ol->max_size || ol->size < ol->max_size))
+    if (data)
     {
         ALLOC_OBJ_CLEAR(e, struct buffer_entry);
 
@@ -1359,7 +1358,7 @@ buffer_list_file(const char *fn, int max_line_len)
         char *line = (char *) malloc(max_line_len);
         if (line)
         {
-            bl = buffer_list_new(0);
+            bl = buffer_list_new();
             while (fgets(line, max_line_len, fp) != NULL)
             {
                 buffer_list_push(bl, line);
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 8cc03c08f..619c3a95d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1102,11 +1102,9 @@ struct buffer_list
 /**
  * Allocate an empty buffer list of capacity \c max_size.
  *
- * @param max_size  the capacity of the list to allocate
- *
  * @return the new list
  */
-struct buffer_list *buffer_list_new(const int max_size);
+struct buffer_list *buffer_list_new();
 
 /**
  * Frees a buffer list and all the buffers in it.
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 28315b82a..1f408f0b5 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -878,7 +878,7 @@ in_extra_reset(struct man_connection *mc, const int mode)
         }
         if (mode == IER_NEW)
         {
-            mc->in_extra = buffer_list_new(0);
+            mc->in_extra = buffer_list_new();
         }
     }
 }
@@ -2507,7 +2507,7 @@ man_connection_init(struct management *man)
          * command output from/to the socket.
          */
         man->connection.in = command_line_new(1024);
-        man->connection.out = buffer_list_new(0);
+        man->connection.out = buffer_list_new();
 
         /*
          * Initialize event set for standalone usage, when we are
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 0d811f24e..05096ee0a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3989,7 +3989,7 @@ tls_send_payload(struct tls_multi *multi,
     {
         if (!ks->paybuf)
         {
-            ks->paybuf = buffer_list_new(0);
+            ks->paybuf = buffer_list_new();
         }
         buffer_list_push_data(ks->paybuf, data, (size_t)size);
         ret = true;
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 5e854c22e..ac701669f 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -67,18 +67,18 @@ static int
 test_buffer_list_setup(void **state)
 {
     struct test_buffer_list_aggregate_ctx *ctx  = calloc(1, sizeof(*ctx));
-    ctx->empty = buffer_list_new(0);
+    ctx->empty = buffer_list_new();
 
-    ctx->one_two_three = buffer_list_new(3);
+    ctx->one_two_three = buffer_list_new();
     buffer_list_push(ctx->one_two_three, teststr1);
     buffer_list_push(ctx->one_two_three, teststr2);
     buffer_list_push(ctx->one_two_three, teststr3);
 
-    ctx->zero_length_strings = buffer_list_new(2);
+    ctx->zero_length_strings = buffer_list_new();
     buffer_list_push(ctx->zero_length_strings, "");
     buffer_list_push(ctx->zero_length_strings, "");
 
-    ctx->empty_buffers = buffer_list_new(2);
+    ctx->empty_buffers = buffer_list_new();
     uint8_t data = 0;
     buffer_list_push_data(ctx->empty_buffers, &data, 0);
     buffer_list_push_data(ctx->empty_buffers, &data, 0);
@@ -100,17 +100,6 @@ test_buffer_list_teardown(void **state)
     return 0;
 }
 
-static void
-test_buffer_list_full(void **state)
-{
-    struct test_buffer_list_aggregate_ctx *ctx = *state;
-
-    /* list full */
-    assert_int_equal(ctx->one_two_three->size, 3);
-    buffer_list_push(ctx->one_two_three, teststr4);
-    assert_int_equal(ctx->one_two_three->size, 3);
-}
-
 static void
 test_buffer_list_aggregate_separator_empty(void **state)
 {
@@ -247,9 +236,6 @@ main(void)
 {
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(test_buffer_strprefix),
-        cmocka_unit_test_setup_teardown(test_buffer_list_full,
-                                        test_buffer_list_setup,
-                                        test_buffer_list_teardown),
         cmocka_unit_test_setup_teardown(test_buffer_list_aggregate_separator_empty,
                                         test_buffer_list_setup,
                                         test_buffer_list_teardown),
-- 
2.33.0


