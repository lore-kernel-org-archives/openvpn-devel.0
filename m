From: Steffan Karger <steffan@...1856...>
Date: Fri,  8 Dec 2017 10:12:18 +0100
Message-Id: <1512724338-22197-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix memory leak in buffer unit tests
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

buffer_list_push_data does not take ownership of the memory, so just feed
it stack data to plug the leak.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 tests/unit_tests/openvpn/test_buffer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index ba5aa67..c2b7f30 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -77,10 +77,9 @@ static int test_buffer_list_setup(void **state)
     buffer_list_push(ctx->zero_length_strings, "");
 
     ctx->empty_buffers = buffer_list_new(2);
-    uint8_t *data1 = malloc(1);
-    uint8_t *data2 = malloc(1);
-    buffer_list_push_data(ctx->empty_buffers, data1, 0);
-    buffer_list_push_data(ctx->empty_buffers, data2, 0);
+    uint8_t data = 0;
+    buffer_list_push_data(ctx->empty_buffers, &data, 0);
+    buffer_list_push_data(ctx->empty_buffers, &data, 0);
 
     *state = ctx;
     return 0;
-- 
2.7.4


