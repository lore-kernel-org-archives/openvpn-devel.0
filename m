From: Gert Doering <gert@...1296...>
Date: Fri, 26 Sep 2025 18:48:39 +0200
Message-ID: <20250926164845.1215-1-gert@...1296...>
In-Reply-To: <gerrit.1758731785000.Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564@...2715...>
References: <gerrit.1758731785000.Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] comp-lz4: Fix types in call to
 LZ4_decompress_safe
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

From: Frank Lichtenheld <frank@...2641...>

This is ints all around but we uselessly threw some
size_t conversions in there.

Change-Id: Ie550dd4df65dc4fc13c839c3e745ba96e0c5c564
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1215
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1215
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index a78c664..53a5b3f 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -88,19 +88,13 @@
     compv2_escape_data_ifneeded(buf);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
-do_lz4_decompress(size_t zlen_max, struct buffer *work, struct buffer *buf,
+do_lz4_decompress(int zlen_max, struct buffer *work, struct buffer *buf,
                   struct compress_context *compctx)
 {
-    int uncomp_len;
     ASSERT(buf_safe(work, zlen_max));
-    uncomp_len = LZ4_decompress_safe((const char *)BPTR(buf), (char *)BPTR(work), (size_t)BLEN(buf),
-                                     zlen_max);
+    int uncomp_len = LZ4_decompress_safe((const char *)BPTR(buf), (char *)BPTR(work), BLEN(buf),
+                                         zlen_max);
     if (uncomp_len <= 0)
     {
         dmsg(D_COMP_ERRORS, "LZ4 decompression error: %d", uncomp_len);
@@ -118,15 +112,11 @@
     *buf = *work;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 lz4_decompress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
                const struct frame *frame)
 {
-    size_t zlen_max = frame->buf.payload_size;
+    int zlen_max = frame->buf.payload_size;
     uint8_t c; /* flag indicating whether or not our peer compressed */
 
     if (buf->len <= 0)
@@ -163,7 +153,7 @@
 lz4v2_decompress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
                  const struct frame *frame)
 {
-    size_t zlen_max = frame->buf.payload_size;
+    int zlen_max = frame->buf.payload_size;
     uint8_t c; /* flag indicating whether or not our peer compressed */
 
     if (buf->len <= 0)

