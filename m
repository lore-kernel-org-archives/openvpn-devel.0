From: Gert Doering <gert@...1296...>
Date: Thu, 28 Feb 2019 19:51:28 +0100
Message-Id: <20190228185128.43982-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Copy one byte less in strncpynt()
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

While the existing code is not wrong and will never cause an overflow,
it will copy (on a too-long source string) "maxlen" bytes to dest, and
then overwrite the last byte just copied with "0" - which causes a
warning in gcc 9 about filling the target buffer "up to the end,
with no room for a trailing 0 anymore".

Reducing the maximum bytes-to-be-copied to "maxlen -1", because the
last byte will be stamped with 0 anyway.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/buffer.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index a4fe6f9b..52de5a2b 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -347,7 +347,8 @@ buf_set_read(struct buffer *buf, const uint8_t *data, int size)
 static inline void
 strncpynt(char *dest, const char *src, size_t maxlen)
 {
-    strncpy(dest, src, maxlen);
+    ASSERT(maxlen>0);
+    strncpy(dest, src, maxlen-1);
     if (maxlen > 0)
     {
         dest[maxlen - 1] = 0;
-- 
2.18.0


