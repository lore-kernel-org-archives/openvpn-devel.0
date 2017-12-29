From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 29 Dec 2017 10:54:31 +0100
Message-ID: <1514541271-19597-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1498913642-32459-5-git-send-email-steffan.karger@...1435...>
References: <1498913642-32459-5-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5 v2] buffer_list_aggregate_separator():
 simplify code
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

Clean up the function by slightly simplifying the logic.

Mostly witespace changes, so best reviewed using 'git diff -w'.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: rebase on new version of preceding patches

 src/openvpn/buffer.c | 71 ++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index cfe6f2c..858bb08 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1226,49 +1226,44 @@ void
 buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max_len,
                                 const char *sep)
 {
-    int sep_len = strlen(sep);
+    const int sep_len = strlen(sep);
+    struct buffer_entry *more = bl->head;
+    size_t size = 0;
+    int count = 0;
+    for (count = 0; more; ++count)
+    {
+        size_t extra_len = BLEN(&more->buf) + sep_len;
+        if (size + extra_len > max_len)
+        {
+            break;
+        }
+
+        size += extra_len;
+        more = more->next;
+    }
 
-    if (bl->head)
+    if (count >= 2)
     {
-        struct buffer_entry *more = bl->head;
-        size_t size = 0;
-        int count = 0;
-        for (count = 0; more; ++count)
-        {
-            size_t extra_len = BLEN(&more->buf) + sep_len;
-            if (size + extra_len > max_len)
-            {
-                break;
-            }
+        struct buffer_entry *f;
+        ALLOC_OBJ_CLEAR(f, struct buffer_entry);
+        f->buf = alloc_buf(size + 1); /* prevent 0-byte malloc */
 
-            size += extra_len;
-            more = more->next;
+        struct buffer_entry *e = bl->head;
+        for (size_t i = 0; e && i < count; ++i)
+        {
+            struct buffer_entry *next = e->next;
+            buf_copy(&f->buf, &e->buf);
+            buf_write(&f->buf, sep, sep_len);
+            free_buf(&e->buf);
+            free(e);
+            e = next;
         }
-
-        if (count >= 2)
+        bl->head = f;
+        bl->size -= count - 1;
+        f->next = more;
+        if (!more)
         {
-            int i;
-            struct buffer_entry *e = bl->head, *f;
-
-            ALLOC_OBJ_CLEAR(f, struct buffer_entry);
-            f->buf = alloc_buf(size + 1); /* prevent 0-byte malloc */
-            f->buf.capacity = size;
-            for (i = 0; e && i < count; ++i)
-            {
-                struct buffer_entry *next = e->next;
-                buf_copy(&f->buf, &e->buf);
-                buf_write(&f->buf, sep, sep_len);
-                free_buf(&e->buf);
-                free(e);
-                e = next;
-            }
-            bl->head = f;
-            bl->size -= count - 1;
-            f->next = more;
-            if (!more)
-            {
-                bl->tail = f;
-            }
+            bl->tail = f;
         }
     }
 }
-- 
2.7.4


