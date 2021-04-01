From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:24 +0200
Message-Id: <20210401131337.3684-2-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 01/14] Remove code for aligning non-swapped
 compression
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

This is an optimisation for memory alignment for lzo. Compression is
deprecated so this optimisation is not very important anymore.

Furthermore it is conditionally compiled on !defined(ENABLE_LZ4), which
makes the code not compiled in by default anyway.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/comp.h |  6 ------
 src/openvpn/init.c | 31 -------------------------------
 src/openvpn/mtu.h  |  6 ------
 3 files changed, 43 deletions(-)

diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 5c0322ca6..5c9d77fe1 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -198,11 +198,5 @@ comp_non_stub_enabled(const struct compress_options *info)
            && info->alg != COMP_ALG_UNDEF;
 }
 
-static inline bool
-comp_unswapped_prefix(const struct compress_options *info)
-{
-    return !(info->flags & COMP_F_SWAP);
-}
-
 #endif /* USE_COMP */
 #endif /* ifndef OPENVPN_COMP_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 132d47e4e..1a6015452 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3082,37 +3082,6 @@ do_init_frame(struct context *c)
     {
         comp_add_to_extra_frame(&c->c2.frame);
 
-#if !defined(ENABLE_LZ4)
-        /*
-         * Compression usage affects buffer alignment when non-swapped algs
-         * such as LZO is used.
-         * Newer algs like LZ4 and comp-stub with COMP_F_SWAP don't need
-         * any special alignment because of the control-byte swap approach.
-         * LZO alignment (on the other hand) is problematic because
-         * the presence of the control byte means that either the output of
-         * decryption must be written to an unaligned buffer, or the input
-         * to compression (or packet dispatch if packet is uncompressed)
-         * must be read from an unaligned buffer.
-         * This code tries to align the input to compression (or packet
-         * dispatch if packet is uncompressed) at the cost of requiring
-         * decryption output to be written to an unaligned buffer, so
-         * it's more of a tradeoff than an optimal solution and we don't
-         * include it when we are doing a modern build with LZ4.
-         * Strictly speaking, on the server it would be better to execute
-         * this code for every connection after we decide the compression
-         * method, but currently the frame code doesn't appear to be
-         * flexible enough for this, since the frame is already established
-         * before it is known which compression options will be pushed.
-         */
-        if (comp_unswapped_prefix(&c->options.comp) && CIPHER_ENABLED(c))
-        {
-            frame_add_to_align_adjust(&c->c2.frame, COMP_PREFIX_LEN);
-            frame_or_align_flags(&c->c2.frame,
-                                 FRAME_HEADROOM_MARKER_FRAGMENT
-                                 |FRAME_HEADROOM_MARKER_DECRYPT);
-        }
-#endif
-
 #ifdef ENABLE_FRAGMENT
         comp_add_to_extra_frame(&c->c2.frame_fragment_omit); /* omit compression frame delta from final frame_fragment */
 #endif
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 0c8bdf8ba..92cbe1874 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -300,12 +300,6 @@ frame_add_to_extra_buffer(struct frame *frame, const int increment)
     frame->extra_buffer += increment;
 }
 
-static inline void
-frame_add_to_align_adjust(struct frame *frame, const int increment)
-{
-    frame->align_adjust += increment;
-}
-
 static inline void
 frame_align_to_extra_frame(struct frame *frame)
 {
-- 
2.30.1


