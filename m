From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 29 Dec 2017 10:52:24 +0100
Message-ID: <1514541144-19407-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <d4afae6b-30f3-f5cd-3b66-8649aaa9bd65@...2181...>
References: <d4afae6b-30f3-f5cd-3b66-8649aaa9bd65@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/5 v3] buffer_list_aggregate_separator():
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
v3: add spaces around '-'

 src/openvpn/buffer.c                   |  1 +
 tests/unit_tests/openvpn/test_buffer.c | 15 +++++----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index e601a31..28ce8ca 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1257,6 +1257,7 @@ buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max, const
                 e = next;
             }
             bl->head = f;
+            bl->size -= count - 1;
             f->next = more;
             if (!more)
             {
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index b4625bb..bddb30a 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -138,8 +138,7 @@ test_buffer_list_aggregate_separator_two(void **state)
     /* Aggregate the first two elements */
     /* FIXME this exceeds the supplied max */
     buffer_list_aggregate_separator(ctx->one_two_three, 4, testsep);
-    /* FIXME size does not get adjusted after aggregating */
-    assert_int_equal(ctx->one_two_three->size, 3);
+    assert_int_equal(ctx->one_two_three->size, 2);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 testsep teststr2 testsep);
 }
@@ -151,8 +150,7 @@ test_buffer_list_aggregate_separator_all(void **state)
 
     /* Aggregate all */
     buffer_list_aggregate_separator(ctx->one_two_three, 1<<16, testsep);
-    /* FIXME size does not get adjusted after aggregating */
-    assert_int_equal(ctx->one_two_three->size, 3);
+    assert_int_equal(ctx->one_two_three->size, 1);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf,
                           teststr1 testsep teststr2 testsep teststr3 testsep);
@@ -165,8 +163,7 @@ test_buffer_list_aggregate_separator_nosep(void **state)
 
     /* Aggregate all */
     buffer_list_aggregate_separator(ctx->one_two_three, 1<<16, testnosep);
-    /* FIXME size does not get adjusted after aggregating */
-    assert_int_equal(ctx->one_two_three->size, 3);
+    assert_int_equal(ctx->one_two_three->size, 1);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 teststr2 teststr3);
 }
@@ -179,8 +176,7 @@ test_buffer_list_aggregate_separator_zerolen(void **state)
 
     /* Aggregate all */
     buffer_list_aggregate_separator(bl_zerolen, 1<<16, testnosep);
-    /* FIXME size does not get adjusted after aggregating */
-    assert_int_equal(bl_zerolen->size, 2);
+    assert_int_equal(bl_zerolen->size, 1);
     struct buffer *buf = buffer_list_peek(bl_zerolen);
     assert_buf_equals_str(buf, "");
 }
@@ -193,8 +189,7 @@ test_buffer_list_aggregate_separator_emptybuffers(void **state)
 
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


