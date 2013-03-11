From: Arne Schwabe <arne@...1227...>
Date: Mon, 11 Mar 2013 21:10:48 +0100
Message-Id: <1363032651-23934-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/4] Remove unused function xor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The function name xor is also a reserved keyword in C++

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/buffer.h |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 5e11de0..7cae733 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -689,16 +689,6 @@ bool buf_string_compare_advance (struct buffer *src, const char *match);
 int buf_substring_len (const struct buffer *buf, int delim);
 
 /*
- * Bitwise operations
- */
-static inline void
-xor (uint8_t *dest, const uint8_t *src, int len)
-{
-  while (len-- > 0)
-    *dest++ ^= *src++;
-}
-
-/*
  * Print a string which might be NULL
  */
 const char *np (const char *str);
-- 
1.7.9.5


