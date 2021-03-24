From: Arne Schwabe <arne@...1227...>
Date: Wed, 24 Mar 2021 23:23:27 +0100
Message-Id: <20210324222330.455-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/4] Make buffer related function conversion
 explicit when narrowing
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

Clang and gcc do report many of the narrowing conversion that MSVC
reports, like these:

 warning C4267: 'function': conversion from 'size_t' to 'int', possible loss of data

This commit changes int to size_t where it is safe
(e.g. checked by buf_size_valid) and add casts where necessary.

In the function buffer_read_from_file the return value of fread is
size_t (at least on Linux/Windows/macOS and cppreference), so fix the
check to actually make sense.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/buffer.c | 20 ++++++++++----------
 src/openvpn/buffer.h | 16 ++++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 35d9ecdc..48bf25d5 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -661,7 +661,7 @@ rm_trailing_chars(char *str, const char *what_to_delete)
     bool modified;
     do
     {
-        const int len = strlen(str);
+        const size_t len = strlen(str);
         modified = false;
         if (len > 0)
         {
@@ -687,7 +687,7 @@ string_alloc(const char *str, struct gc_arena *gc)
 {
     if (str)
     {
-        const int n = strlen(str) + 1;
+        const size_t n = strlen(str) + 1;
         char *ret;
 
         if (gc)
@@ -814,7 +814,7 @@ string_alloc_buf(const char *str, struct gc_arena *gc)
 bool
 buf_string_match_head_str(const struct buffer *src, const char *match)
 {
-    const int size = strlen(match);
+    const size_t size = strlen(match);
     if (size < 0 || size > src->len)
     {
         return false;
@@ -827,7 +827,7 @@ buf_string_compare_advance(struct buffer *src, const char *match)
 {
     if (buf_string_match_head_str(src, match))
     {
-        buf_advance(src, strlen(match));
+        buf_advance(src, (int)strlen(match));
         return true;
     }
     else
@@ -1244,7 +1244,7 @@ buffer_list_push(struct buffer_list *ol, const char *str)
         struct buffer_entry *e = buffer_list_push_data(ol, str, len+1);
         if (e)
         {
-            e->buf.len = len; /* Don't count trailing '\0' as part of length */
+            e->buf.len = (int)len; /* Don't count trailing '\0' as part of length */
         }
     }
 }
@@ -1293,7 +1293,7 @@ void
 buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max_len,
                                 const char *sep)
 {
-    const int sep_len = strlen(sep);
+    const size_t sep_len = strlen(sep);
     struct buffer_entry *more = bl->head;
     size_t size = 0;
     int count = 0;
@@ -1400,7 +1400,7 @@ buffer_read_from_file(const char *filename, struct gc_arena *gc)
 {
     struct buffer ret = { 0 };
 
-    platform_stat_t file_stat = {0};
+    platform_stat_t file_stat = { 0 };
     if (platform_stat(filename, &file_stat) < 0)
     {
         return ret;
@@ -1414,13 +1414,13 @@ buffer_read_from_file(const char *filename, struct gc_arena *gc)
 
     const size_t size = file_stat.st_size;
     ret = alloc_buf_gc(size + 1, gc); /* space for trailing \0 */
-    ssize_t read_size = fread(BPTR(&ret), 1, size, fp);
-    if (read_size < 0)
+    size_t read_size = fread(BPTR(&ret), 1, size, fp);
+    if (read_size == 0)
     {
         free_buf_gc(&ret, gc);
         goto cleanup;
     }
-    ASSERT(buf_inc_len(&ret, read_size));
+    ASSERT(buf_inc_len(&ret, (int)read_size));
     buf_null_terminate(&ret);
 
 cleanup:
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 1722ffd5..9ea70284 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -332,13 +332,13 @@ buf_set_write(struct buffer *buf, uint8_t *data, int size)
 }
 
 static inline void
-buf_set_read(struct buffer *buf, const uint8_t *data, int size)
+buf_set_read(struct buffer *buf, const uint8_t *data, size_t size)
 {
     if (!buf_size_valid(size))
     {
         buf_size_error(size);
     }
-    buf->len = buf->capacity = size;
+    buf->len = buf->capacity = (int)size;
     buf->offset = 0;
     buf->data = (uint8_t *)data;
 }
@@ -538,10 +538,10 @@ struct buffer buf_sub(struct buffer *buf, int size, bool prepend);
  */
 
 static inline bool
-buf_safe(const struct buffer *buf, int len)
+buf_safe(const struct buffer *buf, size_t len)
 {
     return buf_valid(buf) && buf_size_valid(len)
-           && buf->offset + buf->len + len <= buf->capacity;
+           && buf->offset + buf->len + (int)len <= buf->capacity;
 }
 
 static inline bool
@@ -549,7 +549,7 @@ buf_safe_bidir(const struct buffer *buf, int len)
 {
     if (buf_valid(buf) && buf_size_valid_signed(len))
     {
-        const int newlen = buf->len + len;
+        int newlen = buf->len + len;
         return newlen >= 0 && buf->offset + newlen <= buf->capacity;
     }
     else
@@ -653,7 +653,7 @@ buf_advance(struct buffer *buf, int size)
  */
 
 static inline uint8_t *
-buf_write_alloc(struct buffer *buf, int size)
+buf_write_alloc(struct buffer *buf, size_t size)
 {
     uint8_t *ret;
     if (!buf_safe(buf, size))
@@ -661,7 +661,7 @@ buf_write_alloc(struct buffer *buf, int size)
         return NULL;
     }
     ret = BPTR(buf) + buf->len;
-    buf->len += size;
+    buf->len += (int)size;
     return ret;
 }
 
@@ -686,7 +686,7 @@ buf_read_alloc(struct buffer *buf, int size)
 }
 
 static inline bool
-buf_write(struct buffer *dest, const void *src, int size)
+buf_write(struct buffer *dest, const void *src, size_t size)
 {
     uint8_t *cp = buf_write_alloc(dest, size);
     if (!cp)
-- 
2.30.1


