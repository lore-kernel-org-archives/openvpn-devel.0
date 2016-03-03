From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:19:00 -0700
Message-Id: <1456993146-63968-4-git-send-email-james@...515...>
In-Reply-To: <1456993146-63968-1-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 04/10] Added flags parameter to
	format_hex_ex.
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
Cc: James Yonan <james@...515...>

We add the flags parameter without changing the signature of
the function by repurposing the space_break parameter into
space_break_flags where the lower 8 bits are used for the
previous space_break parameter and the higher bits are used
for flag values.

Added new flag FHE_CAPS that formats the generated hex string
in upper case.

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/buffer.c | 11 +++++++----
 src/openvpn/buffer.h |  4 +++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index bc67d65..52c6ab9 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -435,18 +435,21 @@ gc_transfer (struct gc_arena *dest, struct gc_arena *src)
 
 char *
 format_hex_ex (const uint8_t *data, int size, int maxoutput,
-	       int space_break, const char* separator,
+	       unsigned int space_break_flags, const char* separator,
 	       struct gc_arena *gc)
 {
   struct buffer out = alloc_buf_gc (maxoutput ? maxoutput :
-				    ((size * 2) + (size / space_break) * (int) strlen (separator) + 2),
+				    ((size * 2) + (size / (space_break_flags & FHE_SPACE_BREAK_MASK)) * (int) strlen (separator) + 2),
 				    gc);
   int i;
   for (i = 0; i < size; ++i)
     {
-      if (separator && i && !(i % space_break))
+      if (separator && i && !(i % (space_break_flags & FHE_SPACE_BREAK_MASK)))
 	buf_printf (&out, "%s", separator);
-      buf_printf (&out, "%02x", data[i]);
+      if (space_break_flags & FHE_CAPS)
+	buf_printf (&out, "%02X", data[i]);
+      else
+	buf_printf (&out, "%02x", data[i]);
     }
   buf_catrunc (&out, "[more...]");
   return (char *)out.data;
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 24f52aa..8070439 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -403,9 +403,11 @@ bool buf_parse (struct buffer *buf, const int delim, char *line, const int size)
 /*
  * Hex dump -- Output a binary buffer to a hex string and return it.
  */
+#define FHE_SPACE_BREAK_MASK 0xFF /* space_break parameter in lower 8 bits */
+#define FHE_CAPS 0x100            /* output hex in caps */
 char *
 format_hex_ex (const uint8_t *data, int size, int maxoutput,
-	       int space_break, const char* separator,
+	       unsigned int space_break_flags, const char* separator,
 	       struct gc_arena *gc);
 
 static inline char *
-- 
1.9.1


