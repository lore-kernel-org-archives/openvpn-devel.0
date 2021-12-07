From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:01:53 +0100
Message-Id: <20211207170211.3275837-4-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 03/21] Remove align_adjust frame code
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

The align_adjust variable was only set to a non-zero value when
no cipher was used for the data channel. Since we no longer want to
optimise non encrypted data channel traffic, remove this optimisation
and simplify the code.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c   |  4 ++--
 src/openvpn/forward.c  |  2 +-
 src/openvpn/fragment.c |  2 +-
 src/openvpn/init.c     | 13 -------------
 src/openvpn/mtu.c      |  9 ++-------
 src/openvpn/mtu.h      | 38 ++++++++------------------------------
 src/openvpn/socket.c   |  3 +--
 src/openvpn/win32.c    |  2 +-
 8 files changed, 16 insertions(+), 57 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 36f880433..cd791ab8a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -370,7 +370,7 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
 
     ASSERT(ad_start >= buf->data && ad_start <= BPTR(buf));
 
-    ASSERT(buf_init(&work, FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_DECRYPT)));
+    ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
 
     /* IV and Packet ID required for this mode */
     ASSERT(packet_id_initialized(&opt->packet_id));
@@ -533,7 +533,7 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
             int outlen;
 
             /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
-            ASSERT(buf_init(&work, FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_DECRYPT)));
+            ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
 
             /* read the IV from the packet */
             if (buf->len < iv_size)
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 41ef12e30..29efcd3b9 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -803,7 +803,7 @@ read_incoming_link(struct context *c)
     perf_push(PERF_READ_IN_LINK);
 
     c->c2.buf = c->c2.buffers->read_link_buf;
-    ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM_ADJ(&c->c2.frame, FRAME_HEADROOM_MARKER_READ_LINK)));
+    ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
 
     status = link_socket_read(c->c2.link_socket,
                               &c->c2.buf,
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index aba611fa0..6f8fb4476 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -214,7 +214,7 @@ fragment_incoming(struct fragment_master *f, struct buffer *buf,
                 frag->defined = true;
                 frag->max_frag_size = size;
                 frag->map = 0;
-                ASSERT(buf_init(&frag->buf, FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_FRAGMENT)));
+                ASSERT(buf_init(&frag->buf, FRAME_HEADROOM(frame)));
             }
 
             /* copy the data to fragment buffer */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f8a13fdfa..0009bcb72 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2461,19 +2461,6 @@ frame_finalize_options(struct context *c, const struct options *o)
         o = &c->options;
     }
 
-    /*
-     * Set adjustment factor for buffer alignment when no
-     * cipher is used.
-     */
-    if (!cipher_defined(c->c1.ks.key_type.cipher))
-    {
-        frame_align_to_extra_frame(&c->c2.frame);
-        frame_or_align_flags(&c->c2.frame,
-                             FRAME_HEADROOM_MARKER_FRAGMENT
-                             |FRAME_HEADROOM_MARKER_READ_LINK
-                             |FRAME_HEADROOM_MARKER_READ_STREAM);
-    }
-
     frame_add_to_extra_buffer(&c->c2.frame, PAYLOAD_ALIGN);
     frame_finalize(&c->c2.frame,
                    o->ce.link_mtu_defined,
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index e4143e267..0ab716d7a 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -42,12 +42,11 @@
 void
 alloc_buf_sock_tun(struct buffer *buf,
                    const struct frame *frame,
-                   const bool tuntap_buffer,
-                   const unsigned int align_mask)
+                   const bool tuntap_buffer)
 {
     /* allocate buffer for overlapped I/O */
     *buf = alloc_buf(BUF_SIZE(frame));
-    ASSERT(buf_init(buf, FRAME_HEADROOM_ADJ(frame, align_mask)));
+    ASSERT(buf_init(buf, FRAME_HEADROOM(frame)));
     buf->len = tuntap_buffer ? MAX_RW_SIZE_TUN(frame) : MAX_RW_SIZE_LINK(frame);
     ASSERT(buf_safe(buf, 0));
 }
@@ -153,10 +152,6 @@ frame_print(const struct frame *frame,
     buf_printf(&out, " EB:%d", frame->extra_buffer);
     buf_printf(&out, " ET:%d", frame->extra_tun);
     buf_printf(&out, " EL:%d", frame->extra_link);
-    if (frame->align_flags && frame->align_adjust)
-    {
-        buf_printf(&out, " AF:%u/%d", frame->align_flags, frame->align_adjust);
-    }
     buf_printf(&out, " ]");
 
     msg(level, "%s", out.data);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 7b18b3621..72a9e515b 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -121,17 +121,10 @@ struct frame {
 
     int extra_link;             /**< Maximum number of bytes in excess of
                                  *   external network interface's MTU that
-                                 *   might be read from or written to it. */
-
-    /*
-     * Alignment control
-     */
-#define FRAME_HEADROOM_MARKER_DECRYPT     (1<<0)
-#define FRAME_HEADROOM_MARKER_FRAGMENT    (1<<1)
-#define FRAME_HEADROOM_MARKER_READ_LINK   (1<<2)
-#define FRAME_HEADROOM_MARKER_READ_STREAM (1<<3)
-    unsigned int align_flags;
-    int align_adjust;
+                                 *   might be read from or written to it.
+                                 *
+                                 *   Used by peer-id (3) and
+                                 *   socks UDP (10) */
 };
 
 /* Forward declarations, to prevent includes */
@@ -184,8 +177,7 @@ struct options;
  * Control buffer headroom allocations to allow for efficient prepending.
  */
 #define FRAME_HEADROOM_BASE(f)     (TUN_LINK_DELTA(f) + (f)->extra_buffer + (f)->extra_link)
-#define FRAME_HEADROOM(f)          frame_headroom(f, 0)
-#define FRAME_HEADROOM_ADJ(f, fm)  frame_headroom(f, fm)
+#define FRAME_HEADROOM(f)          frame_headroom(f)
 
 /*
  * Max size of a buffer used to build a packet for output to
@@ -227,8 +219,7 @@ void frame_set_mtu_dynamic(struct frame *frame, int mtu, unsigned int flags);
  */
 void alloc_buf_sock_tun(struct buffer *buf,
                         const struct frame *frame,
-                        const bool tuntap_buffer,
-                        const unsigned int align_mask);
+                        const bool tuntap_buffer);
 
 /** Set the --mssfix option. */
 void frame_init_mssfix(struct frame *frame, const struct options *options);
@@ -252,11 +243,10 @@ const char *format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc);
  * headroom and alignment issues.
  */
 static inline int
-frame_headroom(const struct frame *f, const unsigned int flag_mask)
+frame_headroom(const struct frame *f)
 {
     const int offset = FRAME_HEADROOM_BASE(f);
-    const int adjust = (flag_mask & f->align_flags) ? f->align_adjust : 0;
-    const int delta = ((PAYLOAD_ALIGN << 24) - (offset + adjust)) & (PAYLOAD_ALIGN - 1);
+    const int delta = ((PAYLOAD_ALIGN << 24) - offset) & (PAYLOAD_ALIGN - 1);
     return offset + delta;
 }
 
@@ -300,18 +290,6 @@ frame_add_to_extra_buffer(struct frame *frame, const int increment)
     frame->extra_buffer += increment;
 }
 
-static inline void
-frame_align_to_extra_frame(struct frame *frame)
-{
-    frame->align_adjust = frame->extra_frame + frame->extra_link;
-}
-
-static inline void
-frame_or_align_flags(struct frame *frame, const unsigned int flag_mask)
-{
-    frame->align_flags |= flag_mask;
-}
-
 static inline bool
 frame_defined(const struct frame *frame)
 {
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 72062cd08..df7367469 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1645,8 +1645,7 @@ socket_frame_init(const struct frame *frame, struct link_socket *sock)
 #else
         alloc_buf_sock_tun(&sock->stream_buf_data,
                            frame,
-                           false,
-                           FRAME_HEADROOM_MARKER_READ_STREAM);
+                           false);
 
         stream_buf_init(&sock->stream_buf,
                         &sock->stream_buf_data,
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index fd1246cde..1dc1c5e77 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -186,7 +186,7 @@ overlapped_io_init(struct overlapped_io *o,
     }
 
     /* allocate buffer for overlapped I/O */
-    alloc_buf_sock_tun(&o->buf_init, frame, tuntap_buffer, 0);
+    alloc_buf_sock_tun(&o->buf_init, frame, tuntap_buffer);
 }
 
 void
-- 
2.33.0


