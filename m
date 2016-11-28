From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 28 Nov 2016 17:55:07 +0100
Message-ID: <1480352107-19652-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <201611281631.uASGVUuK073499@...2054...>
References: <201611281631.uASGVUuK073499@...2054...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2.3] Clean up format_hex_ex()
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

Cherry-pick of commit 29404010 from master, slightly reworked to match the
2.3 codebase (no flags inside space_break here), and pulled in the new
static_assert() fallback we also have in master now.

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
 src/openvpn/buffer.c | 10 +++++++---
 src/openvpn/error.h  |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index fb3b52d..edbdd66 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -400,9 +400,13 @@ format_hex_ex (const uint8_t *data, int size, int maxoutput,
 	       int space_break, const char* separator,
 	       struct gc_arena *gc)
 {
-  struct buffer out = alloc_buf_gc (maxoutput ? maxoutput :
-				    ((size * 2) + (size / space_break) * (int) strlen (separator) + 2),
-				    gc);
+  const size_t separator_len = separator ? strlen (separator) : 0;
+  static_assert (INT_MAX <= SIZE_MAX, "Code assumes INT_MAX <= SIZE_MAX");
+  const size_t out_len = maxoutput > 0 ? maxoutput :
+	    ((size * 2) + ((size / space_break) * separator_len) + 2);
+
+  struct buffer out = alloc_buf_gc (out_len, gc);
+
   int i;
   for (i = 0; i < size; ++i)
     {
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 36819e0..4d7fef9 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -217,6 +217,14 @@ FILE *msg_fp(const unsigned int flags);
 void assert_failed (const char *filename, int line, const char *condition)
   __attribute__((__noreturn__));
 
+/* Poor-man's static_assert() for when not supplied by assert.h, taken from
+ * Linux's sys/cdefs.h under GPLv2 */
+#ifndef static_assert
+#define static_assert(expr, diagnostic) \
+    extern int (*__OpenVPN_static_assert_function (void)) \
+      [!!sizeof (struct { int __error_if_negative: (expr) ? 2 : -1; })]
+#endif
+
 #ifdef ENABLE_DEBUG
 void crash (void); /* force a segfault (debugging only) */
 #endif
-- 
2.7.4


