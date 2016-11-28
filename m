From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 28 Nov 2016 15:26:40 +0100
Message-ID: <1480343200-25908-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <8D624060-471D-42CA-BC8F-9EBA929A6B75@...2127...>
References: <8D624060-471D-42CA-BC8F-9EBA929A6B75@...2127...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Clean up format_hex_ex()
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

Fix a potential null-pointer dereference, and make the code a bit more
readable while doing so.

The NULL dereference could not be triggered, because the current code
never called format_hex_ex() with maxouput == 0 and separator == NULL.
But it's nicer to not depend on that.

Our use of int vs size_t for lengths needs some attention too, but I'm
not pulling that into this patch.  Instead I decided to just make the
(previously existing) assumption that INT_MAX <= SIZE_MAX explicit by
adding a static_assert().

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/buffer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 84d2669..6af8dbb 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -440,13 +440,16 @@ format_hex_ex (const uint8_t *data, int size, int maxoutput,
 	       unsigned int space_break_flags, const char* separator,
 	       struct gc_arena *gc)
 {
-  struct buffer out = alloc_buf_gc (maxoutput ? maxoutput :
-				    ((size * 2) + (size / (space_break_flags & FHE_SPACE_BREAK_MASK)) * (int) strlen (separator) + 2),
-				    gc);
-  int i;
-  for (i = 0; i < size; ++i)
+  const size_t bytes_per_hexblock = space_break_flags & FHE_SPACE_BREAK_MASK;
+  const size_t separator_len = separator ? strlen (separator) : 0;
+  static_assert (INT_MAX <= SIZE_MAX, "Code assumes INT_MAX <= SIZE_MAX");
+  const size_t out_len = maxoutput > 0 ? maxoutput :
+	    ((size * 2) + ((size / bytes_per_hexblock) * separator_len) + 2);
+
+  struct buffer out = alloc_buf_gc (out_len, gc);
+  for (int i = 0; i < size; ++i)
     {
-      if (separator && i && !(i % (space_break_flags & FHE_SPACE_BREAK_MASK)))
+      if (separator && i && !(i % bytes_per_hexblock))
 	buf_printf (&out, "%s", separator);
       if (space_break_flags & FHE_CAPS)
 	buf_printf (&out, "%02X", data[i]);
-- 
2.7.4


