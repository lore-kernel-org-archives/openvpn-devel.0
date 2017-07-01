From: Steffan Karger <steffan.karger@...1435...>
Date: Sat, 1 Jul 2017 14:54:00 +0200
Message-ID: <1498913642-32459-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
References: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5] buffer_list_aggregate_separator():
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
 src/openvpn/buffer.c                   | 17 +++++++++++++----
 src/openvpn/buffer.h                   |  2 +-
 tests/unit_tests/openvpn/test_buffer.c | 12 +++++++-----
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 1cc2957..2700ad1 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1231,7 +1231,8 @@ buffer_list_peek(struct buffer_list *ol)
 }
 
 void
-buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max, const char *sep)
+buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max_len,
+                                const char *sep)
 {
     int sep_len = strlen(sep);
 
@@ -1240,10 +1241,18 @@ buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max, const
         struct buffer_entry *more = bl->head;
         size_t size = 0;
         int count = 0;
-        for (count = 0; more && size <= max; ++count)
+        for (count = 0; more; ++count)
         {
-            size += BLEN(&more->buf) + sep_len;
-            more = more->next;
+            size_t extra_len = BLEN(&more->buf) + sep_len;
+            if (size + extra_len <= max_len)
+            {
+                size += extra_len;
+                more = more->next;
+            }
+            else
+            {
+                break;
+            }
         }
 
         if (count >= 2)
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 8bc4428..019e606 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1102,7 +1102,7 @@ void buffer_list_pop(struct buffer_list *ol);
 
 void buffer_list_aggregate(struct buffer_list *bl, const size_t max);
 
-void buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max, const char *sep);
+void buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max_len, const char *sep);
 
 struct buffer_list *buffer_list_file(const char *fn, int max_line_len);
 
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 6842114..8b2575f 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -131,14 +131,16 @@ static void
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
+    buffer_list_aggregate_separator(ctx->one_two_three, strlen(expected)+1,
+                                    testsep);
     assert_int_equal(ctx->one_two_three->size, 2);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
-    assert_string_equal((const char *)buf->data,
-                        teststr1 testsep teststr2 testsep);
+    assert_string_equal((const char *)buf->data, expected);
 }
 
 static void
-- 
2.7.4


