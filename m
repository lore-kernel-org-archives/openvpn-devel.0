From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:44 +0200
Message-Id: <20220422142953.3805364-10-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 19/28] Make buf_write_u8/16/32 take the type
 they pretend to take
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

This functions should accept the type of integer they say to write. Calling
the u32 function with an integer that is actually 32 bit unsigned gives
compiler warnings.
---
 src/openvpn/buffer.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 97cc86241..231f1b0d4 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -694,23 +694,22 @@ buf_write_prepend(struct buffer *dest, const void *src, int size)
 }
 
 static inline bool
-buf_write_u8(struct buffer *dest, int data)
+buf_write_u8(struct buffer *dest, uint8_t data)
 {
-    uint8_t u8 = (uint8_t) data;
-    return buf_write(dest, &u8, sizeof(uint8_t));
+    return buf_write(dest, &data, sizeof(uint8_t));
 }
 
 static inline bool
-buf_write_u16(struct buffer *dest, int data)
+buf_write_u16(struct buffer *dest, uint16_t data)
 {
-    uint16_t u16 = htons((uint16_t) data);
+    uint16_t u16 = htons(data);
     return buf_write(dest, &u16, sizeof(uint16_t));
 }
 
 static inline bool
-buf_write_u32(struct buffer *dest, int data)
+buf_write_u32(struct buffer *dest, uint32_t data)
 {
-    uint32_t u32 = htonl((uint32_t) data);
+    uint32_t u32 = htonl(data);
     return buf_write(dest, &u32, sizeof(uint32_t));
 }
 
-- 
2.32.0 (Apple Git-132)


