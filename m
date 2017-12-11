From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 11 Dec 2017 12:41:58 +0100
Message-ID: <1512992518-29910-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1498913642-32459-2-git-send-email-steffan.karger@...1435...>
References: <1498913642-32459-2-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/5 v2] buffer_list_aggregate_separator():
 update list size after aggregating
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

After aggregating a buffer_list, the size should be adjusted accordingly.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: rebase on master

 src/openvpn/buffer.c                   |  1 +
 tests/unit_tests/openvpn/test_buffer.c | 15 +++++----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index ecd3b17..28ac508 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1257,6 +1257,7 @@ buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max, const
                 e = next;
             }
             bl->head = f;
+            bl->size -= count-1;
             f->next = more;
             if (!more)
             {
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index ba5aa67..f5830a1 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -139,8 +139,7 @@ test_buffer_list_aggregate_separator_two(void **state)
     /* Aggregate the first two elements */
     /* FIXME this exceeds the supplied max */
     buffer_list_aggregate_separator(ctx->one_two_three, 4, testsep);
-    /* FIXME size does not get adjusted after aggregating */
-    assert_int_equal(ctx->one_two_three->size, 3);
+    assert_int_equal(ctx->one_two_three->size, 2);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 testsep teststr2 testsep);
 }
@@ -152,8 +151,7 @@ test_buffer_list_aggregate_separator_all(void **state)
 
     /* Aggregate all */
     buffer_list_aggregate_separator(ctx->one_two_three, 1<<16, testsep);
-    /* FIXME size does not get adjusted after aggregating */
-    assert_int_equal(ctx->one_two_three->size, 3);
+    assert_int_equal(ctx->one_two_three->size, 1);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf,
                           teststr1 testsep teststr2 testsep teststr3 testsep);
@@ -166,8 +164,7 @@ test_buffer_list_aggregate_separator_nosep(void **state)
 
     /* Aggregate all */
     buffer_list_aggregate_separator(ctx->one_two_three, 1<<16, testnosep);
-    /* FIXME size does not get adjusted after aggregating */
-    assert_int_equal(ctx->one_two_three->size, 3);
+    assert_int_equal(ctx->one_two_three->size, 1);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 teststr2 teststr3);
 }
@@ -180,8 +177,7 @@ test_buffer_list_aggregate_separator_zerolen(void **state)
 
     /* Aggregate all */
     buffer_list_aggregate_separator(bl_zerolen, 1<<16, testnosep);
-    /* FIXME size does not get adjusted after aggregating */
-    assert_int_equal(bl_zerolen->size, 2);
+    assert_int_equal(bl_zerolen->size, 1);
     struct buffer *buf = buffer_list_peek(bl_zerolen);
     assert_buf_equals_str(buf, "");
 }
@@ -194,8 +190,7 @@ test_buffer_list_aggregate_separator_emptybuffers(void **state)
 
     /* Aggregate all */
     buffer_list_aggregate_separator(bl_emptybuffers, 1<<16, testnosep);
-    /* FIXME size does not get adjusted after aggregating */
-    assert_int_equal(bl_emptybuffers->size, 2);
+    assert_int_equal(bl_emptybuffers->size, 1);
     struct buffer *buf = buffer_list_peek(bl_emptybuffers);
     assert_int_equal(BLEN(buf), 0);
 }
-- 
2.7.4


