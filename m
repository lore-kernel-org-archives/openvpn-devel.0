From: Gert Doering <gert@...1296...>
Date: Sat,  8 Jun 2019 09:56:22 +0200
Message-Id: <20190608075622.11589-1-gert@...1296...>
In-Reply-To: <20190228185128.43982-1-gert@...1296...>
References: <20190228185128.43982-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Copy one byte less in strncpynt()
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

v2: do not ASSERT() on "maxlen == 0", but move the strncpy() call inside
the if() clause - so "just do nothing" on maxlen == 0, as before.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index a4fe6f9b..e8b83a5e 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -347,9 +347,9 @@ buf_set_read(struct buffer *buf, const uint8_t *data, int size)
 static inline void
 strncpynt(char *dest, const char *src, size_t maxlen)
 {
-    strncpy(dest, src, maxlen);
     if (maxlen > 0)
     {
+	strncpy(dest, src, maxlen-1);
         dest[maxlen - 1] = 0;
     }
 }
-- 
2.21.0


