From: Ilya Shipitsin <chipitsine@...277...>
Date: Sun, 18 Sep 2016 19:19:24 +0500
Message-Id: <1474208364-11251-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] cppcheck finding: add "ASSERT( maxoutput >
	0 || separator != NULL )" to prevent possible null pointer derefence
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

---
 src/openvpn/buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 52c6ab9..57bded9 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -438,10 +438,12 @@ format_hex_ex (const uint8_t *data, int size, int maxoutput,
 	       unsigned int space_break_flags, const char* separator,
 	       struct gc_arena *gc)
 {
-  struct buffer out = alloc_buf_gc (maxoutput ? maxoutput :
+  int i;
+  struct buffer out;
+  ASSERT( maxoutput > 0 || separator != NULL );
+  out = alloc_buf_gc (maxoutput ? maxoutput :
 				    ((size * 2) + (size / (space_break_flags & FHE_SPACE_BREAK_MASK)) * (int) strlen (separator) + 2),
 				    gc);
-  int i;
   for (i = 0; i < size; ++i)
     {
       if (separator && i && !(i % (space_break_flags & FHE_SPACE_BREAK_MASK)))
-- 
2.5.5


