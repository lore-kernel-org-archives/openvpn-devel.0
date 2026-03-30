From: Gert Doering <gert@...1296...>
Date: Mon, 30 Mar 2026 13:36:39 +0200
Message-ID: <20260330113648.19896-1-gert@...1296...>
In-Reply-To: <gerrit.1773071900000.Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef@...2715...>
References: <gerrit.1773071900000.Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] buffer: Avoid sign-compare warnings
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

From: Frank Lichtenheld <frank@...2641...>

- Switch buffer_list size and max_size to size_t
- Guard some unavoidable size_t -> int conversions

Change-Id: Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1561
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1561
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 75110ed..71f3769 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -53,7 +53,7 @@
 void
 buf_size_error(const size_t size)
 {
-    msg(M_FATAL, "fatal buffer size error, size=%lu", (unsigned long)size);
+    msg(M_FATAL, "fatal buffer size error, size=%zu", size);
 }
 
 struct buffer
@@ -280,11 +280,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * write a string to the end of a buffer that was
  * truncated by buf_printf
@@ -295,7 +290,7 @@
     if (buf_forward_capacity(buf) <= 1)
     {
         size_t len = strlen(str) + 1;
-        if (len < buf_forward_capacity_total(buf))
+        if (buf_size_valid(len) && (int)len < buf_forward_capacity_total(buf))
         {
             memcpy(buf->data + buf->capacity - len, str, len);
         }
@@ -782,7 +777,7 @@
 buf_string_match_head_str(const struct buffer *src, const char *match)
 {
     const size_t size = strlen(match);
-    if (size > src->len)
+    if (!buf_size_valid(size) || (int)size > src->len)
     {
         return false;
     }
@@ -1196,7 +1191,7 @@
 bool
 buffer_list_defined(const struct buffer_list *ol)
 {
-    return ol && ol->head != NULL;
+    return ol && ol->head != NULL && ol->size > 0;
 }
 
 void
@@ -1223,7 +1218,7 @@
         struct buffer_entry *e = buffer_list_push_data(ol, str, len + 1);
         if (e)
         {
-            e->buf.len = (int)len; /* Don't count trailing '\0' as part of length */
+            e->buf.len--; /* Don't count trailing '\0' as part of length */
         }
     }
 }
@@ -1249,6 +1244,7 @@
         }
         e->buf = alloc_buf(size);
         memcpy(e->buf.data, data, size);
+        /* Note: size implicitly checked by alloc_buf */
         e->buf.len = (int)size;
         ol->tail = e;
     }
@@ -1274,7 +1270,7 @@
     const size_t sep_len = strlen(sep);
     struct buffer_entry *more = bl->head;
     size_t size = 0;
-    int count = 0;
+    size_t count = 0;
     for (; more; ++count)
     {
         size_t extra_len = BLENZ(&more->buf) + sep_len;
@@ -1313,10 +1309,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 buffer_list_aggregate(struct buffer_list *bl, const size_t max)
 {
@@ -1326,7 +1318,7 @@
 void
 buffer_list_pop(struct buffer_list *ol)
 {
-    if (ol && ol->head)
+    if (buffer_list_defined(ol))
     {
         struct buffer_entry *e = ol->head->next;
         free_buf(&ol->head->buf);
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 040f752..fcc923b 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1149,8 +1149,8 @@
 {
     struct buffer_entry *head; /* next item to pop/peek */
     struct buffer_entry *tail; /* last item pushed */
-    int size;                  /* current number of entries */
-    int max_size;              /* maximum size list should grow to */
+    size_t size;               /* current number of entries */
+    size_t max_size;           /* maximum size list should grow to */
 };
 
 /**

