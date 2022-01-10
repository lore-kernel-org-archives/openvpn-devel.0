From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Jan 2022 17:26:31 +0100
Message-Id: <20220110162631.3473205-1-arne@...1227...>
In-Reply-To: <20220101162532.2251835-1-arne@...1227...>
References: <20220101162532.2251835-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Change buffer allocation calculation and
 checks to be more static
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

Currently we use half dynamic buffer sizes where we use have a fixed
overhead for crypto (crypto_max_overhead) but use a dynamic overhead
for the the other small header sizes.

Patch v3: rebase
Patch v4: add size of ack array to control channel frame size

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/comp-lz4.c   |   4 +-
 src/openvpn/crypto.c     |   4 +-
 src/openvpn/forward.c    |   8 +--
 src/openvpn/init.c       | 107 +++++++++++++++++++++++++++++++++++----
 src/openvpn/lzo.c        |   2 +-
 src/openvpn/mtu.c        |   7 ++-
 src/openvpn/mtu.h        |  74 ++++++++++++++-------------
 src/openvpn/multi.c      |   4 +-
 src/openvpn/multi.h      |   2 +-
 src/openvpn/occ.c        |   4 +-
 src/openvpn/options.c    |   2 +-
 src/openvpn/ping.c       |   2 +-
 src/openvpn/reliable.c   |   2 -
 src/openvpn/reliable.h   |   3 ++
 src/openvpn/ssl.c        |  38 +++++++++++---
 src/openvpn/ssl_common.h |   3 +-
 16 files changed, 193 insertions(+), 73 deletions(-)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index bceca5e2..aa83ea80 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -213,7 +213,7 @@ lz4_decompress(struct buffer *buf, struct buffer work,
                struct compress_context *compctx,
                const struct frame *frame)
 {
-    size_t zlen_max = EXPANDED_SIZE(frame);
+    size_t zlen_max = frame->buf.payload_size;
     uint8_t c;          /* flag indicating whether or not our peer compressed */
 
     if (buf->len <= 0)
@@ -250,7 +250,7 @@ lz4v2_decompress(struct buffer *buf, struct buffer work,
                  struct compress_context *compctx,
                  const struct frame *frame)
 {
-    size_t zlen_max = EXPANDED_SIZE(frame);
+    size_t zlen_max = frame->buf.payload_size;
     uint8_t c;          /* flag indicating whether or not our peer compressed */
 
     if (buf->len <= 0)
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 05a2c6be..18a6c99c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1064,7 +1064,7 @@ test_crypto(struct crypto_options *co, struct frame *frame)
 {
     int i, j;
     struct gc_arena gc = gc_new();
-    struct buffer src = alloc_buf_gc(TUN_MTU_SIZE(frame), &gc);
+    struct buffer src = alloc_buf_gc(frame->buf.payload_size, &gc);
     struct buffer work = alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer encrypt_workspace = alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer decrypt_workspace = alloc_buf_gc(BUF_SIZE(frame), &gc);
@@ -1095,7 +1095,7 @@ test_crypto(struct crypto_options *co, struct frame *frame)
     }
 
     msg(M_INFO, "Entering " PACKAGE_NAME " crypto self-test mode.");
-    for (i = 1; i <= TUN_MTU_SIZE(frame); ++i)
+    for (i = 1; i <= frame->buf.payload_size; ++i)
     {
         update_time();
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f82386a1..c971c6bd 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1119,8 +1119,8 @@ read_incoming_tun(struct context *c)
     }
 #else  /* ifdef _WIN32 */
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
-    ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
-    c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf), MAX_RW_SIZE_TUN(&c->c2.frame));
+    ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
+    c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.buf.payload_size);
 #endif /* ifdef _WIN32 */
 
 #ifdef PACKET_TRUNCATION_CHECK
@@ -1709,7 +1709,7 @@ process_outgoing_tun(struct context *c)
                       PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIENT_NAT | PIP_OUTGOING,
                       &c->c2.to_tun);
 
-    if (c->c2.to_tun.len <= MAX_RW_SIZE_TUN(&c->c2.frame))
+    if (c->c2.to_tun.len <= c->c2.frame.buf.payload_size)
     {
         /*
          * Write to TUN/TAP device.
@@ -1769,7 +1769,7 @@ process_outgoing_tun(struct context *c)
          */
         msg(D_LINK_ERRORS, "tun packet too large on write (tried=%d,max=%d)",
             c->c2.to_tun.len,
-            MAX_RW_SIZE_TUN(&c->c2.frame));
+            c->c2.frame.buf.payload_size);
     }
 
     buf_reset(&c->c2.to_tun);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e8723714..c4770c21 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -740,7 +740,7 @@ init_port_share(struct context *c)
     {
         port_share = port_share_open(c->options.port_share_host,
                                      c->options.port_share_port,
-                                     MAX_RW_SIZE_LINK(&c->c2.frame),
+                                     c->c2.frame.buf.payload_size,
                                      c->options.port_share_journal_dir);
         if (port_share == NULL)
         {
@@ -2505,6 +2505,35 @@ do_startup_pause(struct context *c)
     }
 }
 
+static size_t
+get_frame_mtu(struct context *c, const struct options *o)
+{
+    size_t mtu;
+
+    if (o->ce.link_mtu_defined)
+    {
+        ASSERT(o->ce.link_mtu_defined);
+        /* if we have a link mtu defined we calculate what the old code
+         * would have come up with as tun-mtu */
+        size_t overhead = frame_calculate_protocol_header_size(&c->c1.ks.key_type,
+                                                               o, true);
+        mtu = o->ce.link_mtu - overhead;
+
+    }
+    else
+    {
+        ASSERT(o->ce.tun_mtu_defined);
+        mtu = o->ce.tun_mtu;
+    }
+
+    if (mtu < TUN_MTU_MIN)
+    {
+        msg(M_WARN, "TUN MTU value (%lu) must be at least %d", mtu, TUN_MTU_MIN);
+        frame_print(&c->c2.frame, M_FATAL, "MTU is too small");
+    }
+    return mtu;
+}
+
 /*
  * Finalize MTU parameters based on command line or config file options.
  */
@@ -2516,12 +2545,68 @@ frame_finalize_options(struct context *c, const struct options *o)
         o = &c->options;
     }
 
-    frame_add_to_extra_buffer(&c->c2.frame, PAYLOAD_ALIGN);
-    frame_finalize(&c->c2.frame,
+    struct frame *frame = &c->c2.frame;
+
+    frame->tun_mtu = get_frame_mtu(c, o);
+
+    /* We always allow at least 1500 MTU packets to be received in our buffer
+     * space */
+    size_t payload_size = max_int(1500, frame->tun_mtu);
+
+    /* The extra tun needs to be added to the payload size */
+    if (o->ce.tun_mtu_defined)
+    {
+        payload_size += o->ce.tun_mtu_extra;
+    }
+
+    /* Add 100 byte of extra space in the buffer to account for slightly
+     * mismatched MUTs between peers */
+    payload_size += 100;
+
+
+    /* the space that is reserved before the payload to add extra headers to it
+    * we always reserve the space for the worst case */
+    size_t headroom = 0;
+
+    /* includes IV and packet ID */
+    headroom += crypto_max_overhead();
+
+    /* peer id + opcode */
+    headroom += 4;
+
+    /* socks proxy header */
+    headroom += 10;
+
+    /* compression header and fragment header (part of the encrypted payload) */
+    headroom += 1 + 1;
+
+    /* Round up headroom to the next multiple of 4 to ensure alignment */
+    headroom = (headroom + 3) & ~3;
+
+    /* Add the headroom to the payloadsize as a received (IP) packet can have
+     * all the extra headers in it */
+    payload_size += headroom;
+
+    /* the space after the payload, this needs some extra buffer space for
+     * encryption so headroom is probably too much but we do not really care
+     * the few extra bytes */
+    size_t tailroom = headroom;
+
+#ifdef USE_COMP
+    tailroom += COMP_EXTRA_BUFFER(frame->buf.payload_size);
+#endif
+
+    frame->buf.payload_size = payload_size;
+    frame->buf.headroom = headroom;
+    frame->buf.tailroom = tailroom;
+
+    /* Kept to still update/calculate the other fields for now */
+    frame_finalize(frame,
                    o->ce.link_mtu_defined,
                    o->ce.link_mtu,
                    o->ce.tun_mtu_defined,
                    o->ce.tun_mtu);
+
 }
 
 /*
@@ -3288,17 +3373,19 @@ init_context_buffers(const struct frame *frame)
 
     ALLOC_OBJ_CLEAR(b, struct context_buffers);
 
-    b->read_link_buf = alloc_buf(BUF_SIZE(frame));
-    b->read_tun_buf = alloc_buf(BUF_SIZE(frame));
+    size_t buf_size = BUF_SIZE(frame);
+
+    b->read_link_buf = alloc_buf(buf_size);
+    b->read_tun_buf = alloc_buf(buf_size);
 
-    b->aux_buf = alloc_buf(BUF_SIZE(frame));
+    b->aux_buf = alloc_buf(buf_size);
 
-    b->encrypt_buf = alloc_buf(BUF_SIZE(frame));
-    b->decrypt_buf = alloc_buf(BUF_SIZE(frame));
+    b->encrypt_buf = alloc_buf(buf_size);
+    b->decrypt_buf = alloc_buf(buf_size);
 
 #ifdef USE_COMP
-    b->compress_buf = alloc_buf(BUF_SIZE(frame));
-    b->decompress_buf = alloc_buf(BUF_SIZE(frame));
+    b->compress_buf = alloc_buf(buf_size);
+    b->decompress_buf = alloc_buf(buf_size);
 #endif
 
     return b;
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 8d572684..e7e89655 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -213,7 +213,7 @@ lzo_decompress(struct buffer *buf, struct buffer work,
                struct compress_context *compctx,
                const struct frame *frame)
 {
-    lzo_uint zlen = EXPANDED_SIZE(frame);
+    lzo_uint zlen = frame->buf.payload_size;
     int err;
     uint8_t c;          /* flag indicating whether or not our peer compressed */
 
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index cc7c95e4..1648c8fe 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -48,7 +48,7 @@ alloc_buf_sock_tun(struct buffer *buf,
     /* allocate buffer for overlapped I/O */
     *buf = alloc_buf(BUF_SIZE(frame));
     ASSERT(buf_init(buf, FRAME_HEADROOM(frame)));
-    buf->len = tuntap_buffer ? MAX_RW_SIZE_TUN(frame) : MAX_RW_SIZE_LINK(frame);
+    buf->len = frame->buf.payload_size;
     ASSERT(buf_safe(buf, 0));
 }
 
@@ -296,6 +296,11 @@ frame_print(const struct frame *frame,
         buf_printf(&out, "%s ", prefix);
     }
     buf_printf(&out, "[");
+    buf_printf(&out, " mss_fix:%d", frame->mss_fix);
+    buf_printf(&out, " tun_mtu:%d", frame->tun_mtu);
+    buf_printf(&out, " headroom:%d", frame->buf.headroom);
+    buf_printf(&out, " payload:%d", frame->buf.payload_size);
+    buf_printf(&out, " tailroom:%d", frame->buf.tailroom);
     buf_printf(&out, " L:%d", frame->link_mtu);
     buf_printf(&out, " D:%d", frame->link_mtu_dynamic);
     buf_printf(&out, " EF:%d", frame->extra_frame);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index c83d8816..930c4b73 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -91,6 +91,25 @@
  * Packet geometry parameters.
  */
 struct frame {
+    struct {
+        /* This struct holds all the information about the buffers that are
+         * allocated to match this frame */
+        int payload_size;       /**< the maximum size that a payload that our
+                                 *   buffers can hold from either tun device
+                                 *   or network link.
+                                 */
+
+
+        int headroom;           /**< the headroom in the buffer, this is choosen
+                                 *   to allow all potential header to be added
+                                 *   before the packet */
+
+        int tailroom;            /**< the tailroom in the buffer. Chosen large
+                                  *  enough to also accompany any extrea header
+                                  *  or work space required by
+                                  *  decryption/encryption or compression. */
+    } buf;
+
     int link_mtu;               /**< Maximum packet size to be sent over
                                  *   the external network interface. */
 
@@ -110,6 +129,17 @@ struct frame {
                                  *   @endcode
                                  */
 
+    int tun_mtu;                /**< the (user) configured tun-mtu. This is used
+                                 *   in configuring the tun interface or
+                                 *   in calculations that use the desired size
+                                 *   of the payload in the buffer.
+                                 *
+                                 *   This variable is also used in control
+                                 *   frame context to set the desired maximum
+                                 *   control frame payload (although most of
+                                 *   code ignores it)
+                                 */
+
     int extra_buffer;           /**< Maximum number of bytes that
                                  *   processing steps could expand the
                                  *   internal work buffer.
@@ -165,8 +195,8 @@ struct options;
  * a tap device ifconfiged to an MTU of 1200 might actually want
  * to return a packet size of 1214 on a read().
  */
-#define PAYLOAD_SIZE(f)          ((f)->link_mtu - (f)->extra_frame)
 #define PAYLOAD_SIZE_DYNAMIC(f)  ((f)->link_mtu_dynamic - (f)->extra_frame)
+#define PAYLOAD_SIZE(f)          ((f)->buf.payload_size)
 
 /*
  * Max size of a payload packet after encryption, compression, etc.
@@ -176,35 +206,23 @@ struct options;
 #define EXPANDED_SIZE_DYNAMIC(f) ((f)->link_mtu_dynamic)
 #define EXPANDED_SIZE_MIN(f)     (TUN_MTU_MIN + TUN_LINK_DELTA(f))
 
-/*
- * These values are used as maximum size constraints
- * on read() or write() from TUN/TAP device or TCP/UDP port.
- */
-#define MAX_RW_SIZE_TUN(f)       (PAYLOAD_SIZE(f))
-#define MAX_RW_SIZE_LINK(f)      (EXPANDED_SIZE(f) + (f)->extra_link)
-
 /*
  * Control buffer headroom allocations to allow for efficient prepending.
  */
-#define FRAME_HEADROOM_BASE(f)     (TUN_LINK_DELTA(f) + (f)->extra_buffer + (f)->extra_link)
-/* Same as FRAME_HEADROOM_BASE but rounded up to next multiple of PAYLOAD_ALIGN */
-#define FRAME_HEADROOM(f)          frame_headroom(f)
 
 /*
  * Max size of a buffer used to build a packet for output to
- * the TCP/UDP port.
- *
- * the FRAME_HEADROOM_BASE(f) * 2 should not be necessary but it looks that at
- * some point in the past we seem to have lost the information what parts of
- * the extra space we need to have before the data and which we need after
- * the data. So we ensure we have the FRAME_HEADROOM before and after the
- * actual data.
+ * the TCP/UDP port or to read a packet from a tap/tun device.
  *
  * Most of our code only prepends headers but compression needs the extra bytes
  * *after* the data as compressed data might end up larger than the original
- * data (and max compression overhead is part of extra_buffer)
+ * data (and max compression overhead is part of extra_buffer). Also crypto
+ * needs an extra block for encryption. Therefore tailroom is larger than the
+ * headroom.
  */
-#define BUF_SIZE(f)              (TUN_MTU_SIZE(f) + FRAME_HEADROOM_BASE(f) * 2)
+#define BUF_SIZE(f) ((f)->buf.headroom + (f)->buf.payload_size + (f)->buf.tailroom)
+
+#define FRAME_HEADROOM(f)          ((f)->buf.headroom)
 
 /*
  * Function prototypes.
@@ -326,20 +344,6 @@ const char *format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc);
 
 #endif
 
-/*
- * Calculate a starting offset into a buffer object, dealing with
- * headroom and alignment issues.
- */
-static inline int
-frame_headroom(const struct frame *f)
-{
-    const int offset = FRAME_HEADROOM_BASE(f);
-    /* These two lines just pad offset to next multiple of PAYLOAD_ALIGN in
-     * a complicated and confusing way */
-    const int delta = ((PAYLOAD_ALIGN << 24) - offset) & (PAYLOAD_ALIGN - 1);
-    return offset + delta;
-}
-
 /*
  * frame member adjustment functions
  */
@@ -383,7 +387,7 @@ frame_add_to_extra_buffer(struct frame *frame, const int increment)
 static inline bool
 frame_defined(const struct frame *frame)
 {
-    return frame->link_mtu > 0;
+    return frame->buf.payload_size > 0;
 }
 
 #endif /* ifndef MTU_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 103e882e..e5ffebff 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3495,7 +3495,7 @@ gremlin_flood_clients(struct multi_context *m)
         int i;
 
         ASSERT(buf_init(&buf, FRAME_HEADROOM(&m->top.c2.frame)));
-        parm.packet_size = min_int(parm.packet_size, MAX_RW_SIZE_TUN(&m->top.c2.frame));
+        parm.packet_size = min_int(parm.packet_size, m->top.c2.frame.buf.payload_size);
 
         msg(D_GREMLIN, "GREMLIN_FLOOD_CLIENTS: flooding clients with %d packets of size %d",
             parm.n_packets,
@@ -3557,7 +3557,7 @@ multi_process_per_second_timers_dowork(struct multi_context *m)
 }
 
 void
-multi_top_init(struct multi_context *m, const struct context *top)
+multi_top_init(struct multi_context *m, struct context *top)
 {
     inherit_context_top(&m->top, top);
     m->top.c2.buffers = init_context_buffers(&top->c2.frame);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 6e85c21c..c2b085e3 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -257,7 +257,7 @@ void multi_init(struct multi_context *m, struct context *t, bool tcp_mode);
 
 void multi_uninit(struct multi_context *m);
 
-void multi_top_init(struct multi_context *m, const struct context *top);
+void multi_top_init(struct multi_context *m, struct context *top);
 
 void multi_top_free(struct multi_context *m);
 
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 610c05f5..c4e7c1be 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -219,7 +219,7 @@ check_send_occ_msg_dowork(struct context *c)
 
     c->c2.buf = c->c2.buffers->aux_buf;
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
-    ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
+    ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
     ASSERT(buf_write(&c->c2.buf, occ_magic, OCC_STRING_SIZE));
 
     switch (c->c2.occ_op)
@@ -319,7 +319,7 @@ check_send_occ_msg_dowork(struct context *c)
                  OCC_STRING_SIZE,
                  (int) sizeof(uint8_t),
                  EXTRA_FRAME(&c->c2.frame),
-                 MAX_RW_SIZE_TUN(&c->c2.frame),
+                 c->c2.frame.buf.payload_size,
                  BLEN(&c->c2.buf));
             doit = true;
         }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2ca24685..6e3dccb1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3832,7 +3832,7 @@ options_string(const struct options *o,
     buf_printf(&out, ",link-mtu %u",
                (unsigned int) calc_options_string_link_mtu(o, frame));
 
-    buf_printf(&out, ",tun-mtu %d", PAYLOAD_SIZE(frame));
+    buf_printf(&out, ",tun-mtu %d", frame->tun_mtu);
     buf_printf(&out, ",proto %s",  proto_remote(o->ce.proto, remote));
 
     bool p2p_nopull = o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o);
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 67bbca14..a28f347f 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -80,7 +80,7 @@ check_ping_send_dowork(struct context *c)
 {
     c->c2.buf = c->c2.buffers->aux_buf;
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
-    ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
+    ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
     ASSERT(buf_write(&c->c2.buf, ping_string, sizeof(ping_string)));
 
     /*
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 08c9ab19..ef17aae7 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -205,8 +205,6 @@ error:
     return false;
 }
 
-#define ACK_SIZE(n) (sizeof(uint8_t) + ((n) ? SID_SIZE : 0) + sizeof(packet_id_type) * (n))
-
 /* write a packet ID acknowledgement record to buf, */
 /* removing all acknowledged entries from ack */
 bool
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 693abb3c..02484d1e 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -66,6 +66,9 @@ struct reliable_ack
     packet_id_type packet_id[RELIABLE_ACK_SIZE];
 };
 
+/* The size of the ACK header */
+#define ACK_SIZE(n) (sizeof(uint8_t) + ((n) ? SID_SIZE : 0) + sizeof(packet_id_type) * (n))
+
 /**
  * The structure in which the reliability layer stores a single incoming
  * or outgoing packet.
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 96c78199..8a24458d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -332,6 +332,35 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
     /* set dynamic link MTU to cap control channel packets at 1250 bytes */
     ASSERT(TUN_LINK_DELTA(frame) < min_int(frame->link_mtu, 1250));
     frame->link_mtu_dynamic = min_int(frame->link_mtu, 1250) - TUN_LINK_DELTA(frame);
+
+    /* calculate the maximum overhead that control channel frames may have */
+    int overhead = 0;
+
+    /* Socks */
+    overhead += 10;
+
+    /* tls-auth and tls-crypt */
+    overhead += max_int(tls_crypt_buf_overhead(),
+                        packet_id_size(true) + OPENVPN_MAX_HMAC_SIZE);
+
+    /* TCP length field and opcode */
+    overhead+= 3;
+
+    /* ACK array and remote SESSION ID (part of the ACK array) */
+    overhead += ACK_SIZE(RELIABLE_ACK_SIZE);
+
+    /* Previous OpenVPN version calculated the maximum size and buffer of a
+     * control frame depending on the overhead of the data channel frame
+     * overhead and limited its maximum size to 1250. We always allocate the
+     * 1250 buffer size since a lot of code blindly assumes a large buffer
+     * (e.g. PUSH_BUNDLE_SIZE) and set frame->mtu_mtu as suggestion for the
+     * size */
+    frame->buf.payload_size = 1250 + overhead;
+
+    frame->buf.headroom = overhead;
+    frame->buf.tailroom = overhead;
+
+    frame->tun_mtu = min_int(data_channel_frame->tun_mtu, 1250);
 }
 
 void
@@ -1870,13 +1899,6 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
         msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
             options->ciphername);
     }
-    else
-    {
-        /* Very hacky workaround and quick fix for frame calculation
-         * different when adjusting frame size when the original and new cipher
-         * are identical to avoid a regression with client without NCP */
-        return tls_session_generate_data_channel_keys(session);
-    }
 
     init_key_type(&session->opt->key_type, options->ciphername,
                   options->authname, true, true);
@@ -2959,7 +2981,7 @@ tls_process(struct tls_multi *multi,
             buf = reliable_get_buf_output_sequenced(ks->send_reliable);
             if (buf)
             {
-                int status = key_state_read_ciphertext(&ks->ks_ssl, buf, PAYLOAD_SIZE_DYNAMIC(&multi->opt.frame));
+                int status = key_state_read_ciphertext(&ks->ks_ssl, buf, multi->opt.frame.tun_mtu);
                 if (status == -1)
                 {
                     msg(D_TLS_ERRORS,
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f851bd2b..ada68b4b 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -221,8 +221,9 @@ struct key_state
     struct reliable *rec_reliable; /* order incoming ciphertext packets before we pass to TLS */
     struct reliable_ack *rec_ack; /* buffers all packet IDs we want to ACK back to sender */
 
+    /** Holds outgoing message for the control channel until ks->state reaches
+     * S_ACTIVE */
     struct buffer_list *paybuf;
-
     counter_type n_bytes;                /* how many bytes sent/recvd since last key exchange */
     counter_type n_packets;              /* how many packets sent/recvd since last key exchange */
 
-- 
2.33.0


