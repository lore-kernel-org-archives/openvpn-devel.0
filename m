From: Steffan Karger <steffan@...1856...>
Date: Fri, 10 Nov 2017 12:08:58 +0100
Message-Id: <20171110110858.11482-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Simplify and inline clear_buf()
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

Such a simple operation should not need a full function call.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/buffer.c | 8 --------
 src/openvpn/buffer.h | 9 +++++++--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 7395ab29..4226a808 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -179,14 +179,6 @@ buf_assign(struct buffer *dest, const struct buffer *src)
     return buf_write(dest, BPTR(src), BLEN(src));
 }
 
-struct buffer
-clear_buf(void)
-{
-    struct buffer buf;
-    CLEAR(buf);
-    return buf;
-}
-
 void
 free_buf(struct buffer *buf)
 {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index a754fc14..a088e181 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -131,8 +131,6 @@ struct gc_arena
 
 void buf_clear(struct buffer *buf);
 
-struct buffer clear_buf(void);
-
 void free_buf(struct buffer *buf);
 
 bool buf_assign(struct buffer *dest, const struct buffer *src);
@@ -213,6 +211,13 @@ gc_freeaddrinfo_callback(void *addr)
     freeaddrinfo((struct addrinfo *) addr);
 }
 
+/** Return an empty struct buffer */
+static inline struct buffer
+clear_buf(void)
+{
+    return (struct buffer) { 0 };
+}
+
 static inline bool
 buf_defined(const struct buffer *buf)
 {
-- 
2.14.1


