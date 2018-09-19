From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 19 Sep 2018 18:20:09 +0200
Message-ID: <1537374009-11133-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove unused void_ptr_hash_function and
 void_ptr_compare_function
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

Both functions are never used, so let's get rid of them.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/list.c | 12 ------------
 src/openvpn/list.h |  4 ----
 2 files changed, 16 deletions(-)

diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 09e393a..6023ea6 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -222,18 +222,6 @@ hash_remove_marked(struct hash *hash, struct hash_bucket *bucket)
     }
 }
 
-uint32_t
-void_ptr_hash_function(const void *key, uint32_t iv)
-{
-    return hash_func((const void *)&key, sizeof(key), iv);
-}
-
-bool
-void_ptr_compare_function(const void *key1, const void *key2)
-{
-    return key1 == key2;
-}
-
 void
 hash_iterator_init_range(struct hash *hash,
                          struct hash_iterator *hi,
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index b67301c..6177157 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -116,10 +116,6 @@ void hash_iterator_free(struct hash_iterator *hi);
 
 uint32_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
 
-uint32_t void_ptr_hash_function(const void *key, uint32_t iv);
-
-bool void_ptr_compare_function(const void *key1, const void *key2);
-
 #ifdef LIST_TEST
 void list_test(void);
 
-- 
2.7.4


