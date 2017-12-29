From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 29 Dec 2017 10:53:11 +0100
Message-ID: <1514541191-19471-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <d19475e8-d4b4-56ac-7899-53b3aec2d4f3@...2181...>
References: <d19475e8-d4b4-56ac-7899-53b3aec2d4f3@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5 v3] buffer_list_aggregate_separator():
 don't exceed max_len
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

buffer_list_aggregate_separator() would merge buffer_list entries until it
had exceeded the provided max_len, instead of stopping *before* exceeding
the max value.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: rebase on 1/5 v2 (other patches should still apply)
v3: as suggested by ordex, reorder if contitions and add spaces around '+'

 src/openvpn/buffer.c                   | 13 ++++++++++---
 src/openvpn/buffer.h                   |  3 ++-
 tests/unit_tests/openvpn/test_buffer.c | 11 +++++++----
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 28ce8ca..2656702 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1223,7 +1223,8 @@ buffer_list_peek(struct buffer_list *ol)
 }
 
 void
-buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max, const char *sep)
+buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max_len,
+                                const char *sep)
 {
     int sep_len = strlen(sep);
 
@@ -1232,9 +1233,15 @@ buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max, const
         struct buffer_entry *more = bl->head;
         size_t size = 0;
         int count = 0;
-        for (count = 0; more && size <= max; ++count)
+        for (count = 0; more; ++count)
         {
-            size += BLEN(&more->buf) + sep_len;
+            size_t extra_len = BLEN(&more->buf) + sep_len;
+            if (size + extra_len > max_len)
+            {
+                break;
+            }
+
+            size += extra_len;
             more = more->next;
         }
 
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index b73f6c8..e588b80 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1107,7 +1107,8 @@ void buffer_list_pop(struct buffer_list *ol);
 
 void buffer_list_aggregate(struct buffer_list *bl, const size_t max);
 
-void buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max, const char *sep);
+void buffer_list_aggregate_separator(struct buffer_list *bl,
+                                     const size_t max_len, const char *sep);
 
 struct buffer_list *buffer_list_file(const char *fn, int max_line_len);
 
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index bddb30a..5af9332 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -134,13 +134,16 @@ static void
 test_buffer_list_aggregate_separator_two(void **state)
 {
     struct test_buffer_list_aggregate_ctx *ctx = *state;
+    const char *expected = teststr1 testsep teststr2 testsep;
 
-    /* Aggregate the first two elements */
-    /* FIXME this exceeds the supplied max */
-    buffer_list_aggregate_separator(ctx->one_two_three, 4, testsep);
+    /* Aggregate the first two elements
+     * (add 1 to max_len to test if "three" is not sneaked in too)
+     */
+    buffer_list_aggregate_separator(ctx->one_two_three, strlen(expected) + 1,
+                                    testsep);
     assert_int_equal(ctx->one_two_three->size, 2);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
-    assert_buf_equals_str(buf, teststr1 testsep teststr2 testsep);
+    assert_buf_equals_str(buf, expected);
 }
 
 static void
-- 
2.7.4


