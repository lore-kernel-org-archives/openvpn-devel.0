From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:01:55 +0100
Message-Id: <20211207170211.3275837-6-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 05/21] Document frame related function and
 variables a bit more
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mtu.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 72a9e515b..c1148c317 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -28,7 +28,7 @@
 
 /*
  *
- * Packet maninipulation routes such as encrypt, decrypt, compress, decompress
+ * Packet manipulation routes such as encrypt, decrypt, compress, decompress
  * are passed a frame buffer that looks like this:
  *
  *    [extra_frame bytes] [mtu bytes] [extra_frame_bytes] [compression overflow bytes]
@@ -117,7 +117,12 @@ struct frame {
     int extra_tun;              /**< Maximum number of bytes in excess of
                                  *   the tun/tap MTU that might be read
                                  *   from or written to the virtual
-                                 *   tun/tap network interface. */
+                                 *   tun/tap network interface.
+                                 *
+                                 *   Only set with the option --tun-mtu-extra
+                                 *   which defaults to 0 for tun and 32
+                                 *   (\c TAP_MTU_EXTRA_DEFAULT) for tap.
+                                 *   */
 
     int extra_link;             /**< Maximum number of bytes in excess of
                                  *   external network interface's MTU that
@@ -177,11 +182,22 @@ struct options;
  * Control buffer headroom allocations to allow for efficient prepending.
  */
 #define FRAME_HEADROOM_BASE(f)     (TUN_LINK_DELTA(f) + (f)->extra_buffer + (f)->extra_link)
+/* Same as FRAME_HEADROOM_BASE but rounded up to next multiple of PAYLOAD_ALIGN */
 #define FRAME_HEADROOM(f)          frame_headroom(f)
 
 /*
  * Max size of a buffer used to build a packet for output to
  * the TCP/UDP port.
+ *
+ * the FRAME_HEADROOM_BASE(f) * 2 should not be necessary but it looks that at
+ * some point in the past we seem to have lost the information what parts of
+ * the extra space we need to have before the data and which we need after
+ * the data. So we ensure we have the FRAME_HEADROOM before and after the
+ * actual data.
+ *
+ * Most of our code only prepends headers but compression needs the extra bytes
+ * *after* the data as compressed data might end up larger than the original
+ * data (and max compression overhead is part of extra_buffer)
  */
 #define BUF_SIZE(f)              (TUN_MTU_SIZE(f) + FRAME_HEADROOM_BASE(f) * 2)
 
@@ -246,6 +262,8 @@ static inline int
 frame_headroom(const struct frame *f)
 {
     const int offset = FRAME_HEADROOM_BASE(f);
+    /* These two lines just pad offset to next multiple of PAYLOAD_ALIGN in
+     * a complicated and confusing way */
     const int delta = ((PAYLOAD_ALIGN << 24) - offset) & (PAYLOAD_ALIGN - 1);
     return offset + delta;
 }
-- 
2.33.0


