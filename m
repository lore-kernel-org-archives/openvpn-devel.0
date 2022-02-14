From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Feb 2022 01:14:40 +0100
Message-Id: <20220214001440.3739838-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove FRAME_HEADROOM, PAYLOAD_SIZE,
 EXTRA_FRAME and TUN_LINK_DELTA macros
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

The buffer overhaul simplified the frame struct to a point that these
macros are either not used anymore or are not adding any benefit in
understanding the code anymore. Replace the macros with direct member
acessses.
---
 src/openvpn/comp-lz4.c |  8 ++++----
 src/openvpn/crypto.c   |  8 ++++----
 src/openvpn/fragment.c |  6 +++---
 src/openvpn/lzo.c      |  6 +++---
 src/openvpn/mtu.c      |  2 +-
 src/openvpn/mtu.h      | 21 ---------------------
 6 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 0f2034f7..bf0c05b1 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -69,11 +69,11 @@ do_lz4_compress(struct buffer *buf,
      */
     if (buf->len >= COMPRESS_THRESHOLD && (compctx->flags & COMP_F_ALLOW_COMPRESS))
     {
-        const size_t ps = PAYLOAD_SIZE(frame);
+        const size_t ps = frame->buf.payload_size;
         int zlen_max = ps + COMP_EXTRA_BUFFER(ps);
         int zlen;
 
-        ASSERT(buf_init(work, FRAME_HEADROOM(frame)));
+        ASSERT(buf_init(work, frame->buf.headroom));
         ASSERT(buf_safe(work, zlen_max));
 
         if (buf->len > ps)
@@ -221,7 +221,7 @@ lz4_decompress(struct buffer *buf, struct buffer work,
         return;
     }
 
-    ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+    ASSERT(buf_init(&work, frame->buf.headroom));
 
     /* do unframing/swap (assumes buf->len > 0) */
     {
@@ -258,7 +258,7 @@ lz4v2_decompress(struct buffer *buf, struct buffer work,
         return;
     }
 
-    ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+    ASSERT(buf_init(&work, frame->buf.headroom));
 
     /* do unframing/swap (assumes buf->len > 0) */
     uint8_t *head = BPTR(buf);
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c8d2bcca..13ac1576 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -370,7 +370,7 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
 
     ASSERT(ad_start >= buf->data && ad_start <= BPTR(buf));
 
-    ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+    ASSERT(buf_init(&work, frame->buf.headroom));
 
     /* IV and Packet ID required for this mode */
     ASSERT(packet_id_initialized(&opt->packet_id));
@@ -533,7 +533,7 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
             int outlen;
 
             /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
-            ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+            ASSERT(buf_init(&work, frame->buf.headroom));
 
             /* read the IV from the packet */
             if (buf->len < iv_size)
@@ -1035,7 +1035,7 @@ test_crypto(struct crypto_options *co, struct frame *frame)
     void *buf_p;
 
     /* init work */
-    ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+    ASSERT(buf_init(&work, frame->buf.headroom));
 
     /* init implicit IV */
     {
@@ -1079,7 +1079,7 @@ test_crypto(struct crypto_options *co, struct frame *frame)
         memcpy(buf_p, BPTR(&src), BLEN(&src));
 
         /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
-        ASSERT(buf_init(&encrypt_workspace, FRAME_HEADROOM(frame)));
+        ASSERT(buf_init(&encrypt_workspace, frame->buf.headroom));
 
         /* encrypt */
         openvpn_encrypt(&buf, encrypt_workspace, co);
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 949db8f5..e7ca12f2 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -211,7 +211,7 @@ fragment_incoming(struct fragment_master *f, struct buffer *buf,
                 frag->defined = true;
                 frag->max_frag_size = size;
                 frag->map = 0;
-                ASSERT(buf_init(&frag->buf, FRAME_HEADROOM(frame)));
+                ASSERT(buf_init(&frag->buf, frame->buf.headroom));
             }
 
             /* copy the data to fragment buffer */
@@ -342,7 +342,7 @@ fragment_outgoing(struct fragment_master *f, struct buffer *buf,
             {
                 FRAG_ERR("too many fragments would be required to send datagram");
             }
-            ASSERT(buf_init(&f->outgoing, FRAME_HEADROOM(frame)));
+            ASSERT(buf_init(&f->outgoing, frame->buf.headroom));
             ASSERT(buf_copy(&f->outgoing, buf));
             f->outgoing_seq_id = modulo_add(f->outgoing_seq_id, 1, N_SEQ_ID);
             f->outgoing_frag_id = 0;
@@ -391,7 +391,7 @@ fragment_ready_to_send(struct fragment_master *f, struct buffer *buf,
 
         /* initialize return buffer */
         *buf = f->outgoing_return;
-        ASSERT(buf_init(buf, FRAME_HEADROOM(frame)));
+        ASSERT(buf_init(buf, frame->buf.headroom));
         ASSERT(buf_copy_n(buf, &f->outgoing, size));
 
         /* fragment flags differ based on whether or not we are sending the last fragment */
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index a293ccad..39e833cb 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -160,8 +160,8 @@ lzo_compress(struct buffer *buf, struct buffer work,
      */
     if (buf->len >= COMPRESS_THRESHOLD && lzo_compression_enabled(compctx))
     {
-        const size_t ps = PAYLOAD_SIZE(frame);
-        ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+        const size_t ps = frame->buf.payload_size;
+        ASSERT(buf_init(&work, frame->buf.headroom));
         ASSERT(buf_safe(&work, ps + COMP_EXTRA_BUFFER(ps)));
 
         if (buf->len > ps)
@@ -222,7 +222,7 @@ lzo_decompress(struct buffer *buf, struct buffer work,
         return;
     }
 
-    ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+    ASSERT(buf_init(&work, frame->buf.headroom));
 
     c = *BPTR(buf);
     ASSERT(buf_advance(buf, 1));
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 3e48d275..aa810f1c 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -47,7 +47,7 @@ alloc_buf_sock_tun(struct buffer *buf,
 {
     /* allocate buffer for overlapped I/O */
     *buf = alloc_buf(BUF_SIZE(frame));
-    ASSERT(buf_init(buf, FRAME_HEADROOM(frame)));
+    ASSERT(buf_init(buf, frame->buf.headroom));
     buf->len = frame->buf.payload_size;
     ASSERT(buf_safe(buf, 0));
 }
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index dddbf4fc..08bd8dbc 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -148,27 +148,6 @@ struct frame {
 /* Forward declarations, to prevent includes */
 struct options;
 
-/* Routines which read struct frame should use the macros below */
-
-/*
- * Overhead added to packet payload due to encapsulation
- */
-#define EXTRA_FRAME(f)           ((f)->extra_frame)
-
-/*
- * Delta between tun payload size and final TCP/UDP datagram size
- * (not including extra_link additions)
- */
-#define TUN_LINK_DELTA(f)        ((f)->extra_frame + (f)->extra_tun)
-
-/*
- * This is the maximum packet size that we need to be able to
- * read from or write to a tun or tap device.  For example,
- * a tap device ifconfiged to an MTU of 1200 might actually want
- * to return a packet size of 1214 on a read().
- */
-#define PAYLOAD_SIZE(f)          ((f)->buf.payload_size)
-
 /*
  * Control buffer headroom allocations to allow for efficient prepending.
  */
-- 
2.33.0


