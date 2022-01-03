From: Constance Blue <constance_blue@...2047...>
Date: Mon, 3 Jan 2022 00:31:06 +0000
Message-ID: <DM6PR04MB4891B058B4837F427DB10251E9499@...2646...>
References: <20220101162532.2251835-1-arne@...1227...>
 <20220101162532.2251835-4-arne@...1227...>
In-Reply-To: <20220101162532.2251835-4-arne@...1227...>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_DM6PR04MB4891B058B4837F427DB10251E9499DM6PR04MB4891namp_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3 03/14] Change buffer allocation
 calculation and checks to be more static
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_DM6PR04MB4891B058B4837F427DB10251E9499DM6PR04MB4891namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Arne Schwabe <arne@...1227...>
Sent: Saturday, January 1, 2022 5:26 PM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH v3 03/14] Change buffer allocation calculat=
ion and checks to be more static

Currently we use half dynamic buffer sizes where we use have a fixed
overhead for crypto (crypto_max_overhead) but use a dynamic overhead
for the the other small header sizes.

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
 src/openvpn/ssl.c        |  35 ++++++++++---
 src/openvpn/ssl_common.h |   3 +-
 14 files changed, 187 insertions(+), 71 deletions(-)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index bceca5e2..aa83ea80 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -213,7 +213,7 @@ lz4_decompress(struct buffer *buf, struct buffer work,
                struct compress_context *compctx,
                const struct frame *frame)
 {
-    size_t zlen_max =3D EXPANDED_SIZE(frame);
+    size_t zlen_max =3D frame->buf.payload_size;
     uint8_t c;          /* flag indicating whether or not our peer compres=
sed */

     if (buf->len <=3D 0)
@@ -250,7 +250,7 @@ lz4v2_decompress(struct buffer *buf, struct buffer work,
                  struct compress_context *compctx,
                  const struct frame *frame)
 {
-    size_t zlen_max =3D EXPANDED_SIZE(frame);
+    size_t zlen_max =3D frame->buf.payload_size;
     uint8_t c;          /* flag indicating whether or not our peer compres=
sed */

     if (buf->len <=3D 0)
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 05a2c6be..18a6c99c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1064,7 +1064,7 @@ test_crypto(struct crypto_options *co, struct frame *=
frame)
 {
     int i, j;
     struct gc_arena gc =3D gc_new();
-    struct buffer src =3D alloc_buf_gc(TUN_MTU_SIZE(frame), &gc);
+    struct buffer src =3D alloc_buf_gc(frame->buf.payload_size, &gc);
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
@@ -1095,7 +1095,7 @@ test_crypto(struct crypto_options *co, struct frame *=
frame)
     }

     msg(M_INFO, "Entering " PACKAGE_NAME " crypto self-test mode.");
-    for (i =3D 1; i <=3D TUN_MTU_SIZE(frame); ++i)
+    for (i =3D 1; i <=3D frame->buf.payload_size; ++i)
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
-    c->c2.buf.len =3D read_tun(c->c1.tuntap, BPTR(&c->c2.buf), MAX_RW_SIZE=
_TUN(&c->c2.frame));
+    ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
+    c->c2.buf.len =3D read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame=
.buf.payload_size);
 #endif /* ifdef _WIN32 */

 #ifdef PACKET_TRUNCATION_CHECK
@@ -1709,7 +1709,7 @@ process_outgoing_tun(struct context *c)
                       PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIEN=
T_NAT | PIP_OUTGOING,
                       &c->c2.to_tun);

-    if (c->c2.to_tun.len <=3D MAX_RW_SIZE_TUN(&c->c2.frame))
+    if (c->c2.to_tun.len <=3D c->c2.frame.buf.payload_size)
     {
         /*
          * Write to TUN/TAP device.
@@ -1769,7 +1769,7 @@ process_outgoing_tun(struct context *c)
          */
         msg(D_LINK_ERRORS, "tun packet too large on write (tried=3D%d,max=
=3D%d)",
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
         port_share =3D port_share_open(c->options.port_share_host,
                                      c->options.port_share_port,
-                                     MAX_RW_SIZE_LINK(&c->c2.frame),
+                                     c->c2.frame.buf.payload_size,
                                      c->options.port_share_journal_dir);
         if (port_share =3D=3D NULL)
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
+        size_t overhead =3D frame_calculate_protocol_header_size(&c->c1.ks=
.key_type,
+                                                               o, true);
+        mtu =3D o->ce.link_mtu - overhead;
+
+    }
+    else
+    {
+        ASSERT(o->ce.tun_mtu_defined);
+        mtu =3D o->ce.tun_mtu;
+    }
+
+    if (mtu < TUN_MTU_MIN)
+    {
+        msg(M_WARN, "TUN MTU value (%lu) must be at least %d", mtu, TUN_MT=
U_MIN);
+        frame_print(&c->c2.frame, M_FATAL, "MTU is too small");
+    }
+    return mtu;
+}
+
 /*
  * Finalize MTU parameters based on command line or config file options.
  */
@@ -2516,12 +2545,68 @@ frame_finalize_options(struct context *c, const str=
uct options *o)
         o =3D &c->options;
     }

-    frame_add_to_extra_buffer(&c->c2.frame, PAYLOAD_ALIGN);
-    frame_finalize(&c->c2.frame,
+    struct frame *frame =3D &c->c2.frame;
+
+    frame->tun_mtu =3D get_frame_mtu(c, o);
+
+    /* We always allow at least 1500 MTU packets to be received in our buf=
fer
+     * space */
+    size_t payload_size =3D max_int(1500, frame->tun_mtu);
+
+    /* The extra tun needs to be added to the payload size */
+    if (o->ce.tun_mtu_defined)
+    {
+        payload_size +=3D o->ce.tun_mtu_extra;
+    }
+
+    /* Add 100 byte of extra space in the buffer to account for slightly
+     * mismatched MUTs between peers */
+    payload_size +=3D 100;
+
+
+    /* the space that is reserved before the payload to add extra headers =
to it
+    * we always reserve the space for the worst case */
+    size_t headroom =3D 0;
+
+    /* includes IV and packet ID */
+    headroom +=3D crypto_max_overhead();
+
+    /* peer id + opcode */
+    headroom +=3D 4;
+
+    /* socks proxy header */
+    headroom +=3D 10;
+
+    /* compression header and fragment header (part of the encrypted paylo=
ad) */
+    headroom +=3D 1 + 1;
+
+    /* Round up headroom to the next multiple of 4 to ensure alignment */
+    headroom =3D (headroom + 3) & ~3;
+
+    /* Add the headroom to the payloadsize as a received (IP) packet can h=
ave
+     * all the extra headers in it */
+    payload_size +=3D headroom;
+
+    /* the space after the payload, this needs some extra buffer space for
+     * encryption so headroom is probably too much but we do not really ca=
re
+     * the few extra bytes */
+    size_t tailroom =3D headroom;
+
+#ifdef USE_COMP
+    tailroom +=3D COMP_EXTRA_BUFFER(frame->buf.payload_size);
+#endif
+
+    frame->buf.payload_size =3D payload_size;
+    frame->buf.headroom =3D headroom;
+    frame->buf.tailroom =3D tailroom;
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

-    b->read_link_buf =3D alloc_buf(BUF_SIZE(frame));
-    b->read_tun_buf =3D alloc_buf(BUF_SIZE(frame));
+    size_t buf_size =3D BUF_SIZE(frame);
+
+    b->read_link_buf =3D alloc_buf(buf_size);
+    b->read_tun_buf =3D alloc_buf(buf_size);

-    b->aux_buf =3D alloc_buf(BUF_SIZE(frame));
+    b->aux_buf =3D alloc_buf(buf_size);

-    b->encrypt_buf =3D alloc_buf(BUF_SIZE(frame));
-    b->decrypt_buf =3D alloc_buf(BUF_SIZE(frame));
+    b->encrypt_buf =3D alloc_buf(buf_size);
+    b->decrypt_buf =3D alloc_buf(buf_size);

 #ifdef USE_COMP
-    b->compress_buf =3D alloc_buf(BUF_SIZE(frame));
-    b->decompress_buf =3D alloc_buf(BUF_SIZE(frame));
+    b->compress_buf =3D alloc_buf(buf_size);
+    b->decompress_buf =3D alloc_buf(buf_size);
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
-    lzo_uint zlen =3D EXPANDED_SIZE(frame);
+    lzo_uint zlen =3D frame->buf.payload_size;
     int err;
     uint8_t c;          /* flag indicating whether or not our peer compres=
sed */

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index cc7c95e4..1648c8fe 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -48,7 +48,7 @@ alloc_buf_sock_tun(struct buffer *buf,
     /* allocate buffer for overlapped I/O */
     *buf =3D alloc_buf(BUF_SIZE(frame));
     ASSERT(buf_init(buf, FRAME_HEADROOM(frame)));
-    buf->len =3D tuntap_buffer ? MAX_RW_SIZE_TUN(frame) : MAX_RW_SIZE_LINK=
(frame);
+    buf->len =3D frame->buf.payload_size;
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
+        int payload_size;       /**< the maximum size that a payload that =
our
+                                 *   buffers can hold from either tun devi=
ce
+                                 *   or network link.
+                                 */
+
+
+        int headroom;           /**< the headroom in the buffer, this is c=
hoosen
+                                 *   to allow all potential header to be a=
dded
+                                 *   before the packet */
+
+        int tailroom;            /**< the tailroom in the buffer. Chosen l=
arge
+                                  *  enough to also accompany any extrea h=
eader
+                                  *  or work space required by
+                                  *  decryption/encryption or compression.=
 */
+    } buf;
+
     int link_mtu;               /**< Maximum packet size to be sent over
                                  *   the external network interface. */

@@ -110,6 +129,17 @@ struct frame {
                                  *   @endcode
                                  */

+    int tun_mtu;                /**< the (user) configured tun-mtu. This i=
s used
+                                 *   in configuring the tun interface or
+                                 *   in calculations that use the desired =
size
+                                 *   of the payload in the buffer.
+                                 *
+                                 *   This variable is also used in control
+                                 *   frame context to set the desired maxi=
mum
+                                 *   control frame payload (although most =
of
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
-#define FRAME_HEADROOM_BASE(f)     (TUN_LINK_DELTA(f) + (f)->extra_buffer =
+ (f)->extra_link)
-/* Same as FRAME_HEADROOM_BASE but rounded up to next multiple of PAYLOAD_=
ALIGN */
-#define FRAME_HEADROOM(f)          frame_headroom(f)

 /*
  * Max size of a buffer used to build a packet for output to
- * the TCP/UDP port.
- *
- * the FRAME_HEADROOM_BASE(f) * 2 should not be necessary but it looks tha=
t at
- * some point in the past we seem to have lost the information what parts =
of
- * the extra space we need to have before the data and which we need after
- * the data. So we ensure we have the FRAME_HEADROOM before and after the
- * actual data.
+ * the TCP/UDP port or to read a packet from a tap/tun device.
  *
  * Most of our code only prepends headers but compression needs the extra =
bytes
  * *after* the data as compressed data might end up larger than the origin=
al
- * data (and max compression overhead is part of extra_buffer)
+ * data (and max compression overhead is part of extra_buffer). Also crypto
+ * needs an extra block for encryption. Therefore tailroom is larger than =
the
+ * headroom.
  */
-#define BUF_SIZE(f)              (TUN_MTU_SIZE(f) + FRAME_HEADROOM_BASE(f)=
 * 2)
+#define BUF_SIZE(f) ((f)->buf.headroom + (f)->buf.payload_size + (f)->buf.=
tailroom)
+
+#define FRAME_HEADROOM(f)          ((f)->buf.headroom)

 /*
  * Function prototypes.
@@ -326,20 +344,6 @@ const char *format_extended_socket_error(int fd, int *=
mtu, struct gc_arena *gc);

 #endif

-/*
- * Calculate a starting offset into a buffer object, dealing with
- * headroom and alignment issues.
- */
-static inline int
-frame_headroom(const struct frame *f)
-{
-    const int offset =3D FRAME_HEADROOM_BASE(f);
-    /* These two lines just pad offset to next multiple of PAYLOAD_ALIGN in
-     * a complicated and confusing way */
-    const int delta =3D ((PAYLOAD_ALIGN << 24) - offset) & (PAYLOAD_ALIGN =
- 1);
-    return offset + delta;
-}
-
 /*
  * frame member adjustment functions
  */
@@ -383,7 +387,7 @@ frame_add_to_extra_buffer(struct frame *frame, const in=
t increment)
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
-        parm.packet_size =3D min_int(parm.packet_size, MAX_RW_SIZE_TUN(&m-=
>top.c2.frame));
+        parm.packet_size =3D min_int(parm.packet_size, m->top.c2.frame.buf=
.payload_size);

         msg(D_GREMLIN, "GREMLIN_FLOOD_CLIENTS: flooding clients with %d pa=
ckets of size %d",
             parm.n_packets,
@@ -3557,7 +3557,7 @@ multi_process_per_second_timers_dowork(struct multi_c=
ontext *m)
 }

 void
-multi_top_init(struct multi_context *m, const struct context *top)
+multi_top_init(struct multi_context *m, struct context *top)
 {
     inherit_context_top(&m->top, top);
     m->top.c2.buffers =3D init_context_buffers(&top->c2.frame);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 6e85c21c..c2b085e3 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -257,7 +257,7 @@ void multi_init(struct multi_context *m, struct context=
 *t, bool tcp_mode);

 void multi_uninit(struct multi_context *m);

-void multi_top_init(struct multi_context *m, const struct context *top);
+void multi_top_init(struct multi_context *m, struct context *top);

 void multi_top_free(struct multi_context *m);

diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 610c05f5..c4e7c1be 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -219,7 +219,7 @@ check_send_occ_msg_dowork(struct context *c)

     c->c2.buf =3D c->c2.buffers->aux_buf;
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
             doit =3D true;
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

     bool p2p_nopull =3D o->mode =3D=3D MODE_POINT_TO_POINT && !PULL_DEFINE=
D(o);
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 67bbca14..a28f347f 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -80,7 +80,7 @@ check_ping_send_dowork(struct context *c)
 {
     c->c2.buf =3D c->c2.buffers->aux_buf;
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
-    ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
+    ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
     ASSERT(buf_write(&c->c2.buf, ping_string, sizeof(ping_string)));

     /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 96c78199..b815cdfc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -332,6 +332,32 @@ tls_init_control_channel_frame_parameters(const struct=
 frame *data_channel_frame
     /* set dynamic link MTU to cap control channel packets at 1250 bytes */
     ASSERT(TUN_LINK_DELTA(frame) < min_int(frame->link_mtu, 1250));
     frame->link_mtu_dynamic =3D min_int(frame->link_mtu, 1250) - TUN_LINK_=
DELTA(frame);
+
+    /* calculate the maximum overhead that control channel frames may have=
 */
+    int overhead =3D 0;
+
+    /* Socks */
+    overhead +=3D 10;
+
+    /* tls-auth and tls-crypt */
+    overhead +=3D max_int(tls_crypt_buf_overhead(),
+                        packet_id_size(true) + OPENVPN_MAX_HMAC_SIZE);
+
+    /* TCP length field and opcode */
+    overhead+=3D 3;
+
+    /* Previous OpenVPN version calculated the maximum size and buffer of a
+     * control frame depending on the overhead of the data channel frame
+     * overhead and limited its maximum size to 1250. We always allocate t=
he
+     * 1250 buffer size since a lot of code blindly assumes a large buffer
+     * (e.g. PUSH_BUNDLE_SIZE) and set frame->mtu_mtu as suggestion for the
+     * size */
+    frame->buf.payload_size =3D 1250 + overhead;
+
+    frame->buf.headroom =3D overhead;
+    frame->buf.tailroom =3D overhead;
+
+    frame->tun_mtu =3D min_int(data_channel_frame->tun_mtu, 1250);
 }

 void
@@ -1870,13 +1896,6 @@ tls_session_update_crypto_params_do_work(struct tls_=
session *session,
         msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
             options->ciphername);
     }
-    else
-    {
-        /* Very hacky workaround and quick fix for frame calculation
-         * different when adjusting frame size when the original and new c=
ipher
-         * are identical to avoid a regression with client without NCP */
-        return tls_session_generate_data_channel_keys(session);
-    }

     init_key_type(&session->opt->key_type, options->ciphername,
                   options->authname, true, true);
@@ -2959,7 +2978,7 @@ tls_process(struct tls_multi *multi,
             buf =3D reliable_get_buf_output_sequenced(ks->send_reliable);
             if (buf)
             {
-                int status =3D key_state_read_ciphertext(&ks->ks_ssl, buf,=
 PAYLOAD_SIZE_DYNAMIC(&multi->opt.frame));
+                int status =3D key_state_read_ciphertext(&ks->ks_ssl, buf,=
 multi->opt.frame.tun_mtu);
                 if (status =3D=3D -1)
                 {
                     msg(D_TLS_ERRORS,
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f851bd2b..ada68b4b 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -221,8 +221,9 @@ struct key_state
     struct reliable *rec_reliable; /* order incoming ciphertext packets be=
fore we pass to TLS */
     struct reliable_ack *rec_ack; /* buffers all packet IDs we want to ACK=
 back to sender */

+    /** Holds outgoing message for the control channel until ks->state rea=
ches
+     * S_ACTIVE */
     struct buffer_list *paybuf;
-
     counter_type n_bytes;                /* how many bytes sent/recvd sinc=
e last key exchange */
     counter_type n_packets;              /* how many packets sent/recvd si=
nce last key exchange */

--
2.33.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.so=
urceforge.net%2Flists%2Flistinfo%2Fopenvpn-devel&amp;data=3D04%7C01%7C%7Cc6=
b0d28a607f43d51a2008d9cd437553%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7=
C637766511911959351%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D7JCqlDEY7ZQhaObeHQ%2=
FaEL77ZhIgLdjhR5G7HVnkquA%3D&amp;reserved=3D0

--_000_DM6PR04MB4891B058B4837F427DB10251E9499DM6PR04MB4891namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
</head>
<body>
<div dir=3D"ltr">
<div></div>
<div>
<div>
<div dir=3D"ltr"></div>
</div>
<div dir=3D"ltr"><br>
</div>
<div class=3D"ms-outlook-ios-signature">Get <a href=3D"https://aka.ms/o0uke=
f">Outlook for iOS</a></div>
</div>
<div id=3D"id-e8561b4b-45dc-4dfd-8efd-f81521d8c359" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display: inline-block; width: 98%; font-family: -webkit-standa=
rd; font-size: 9.72pt; color: rgb(0, 0, 0);" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> Arne Schwabe &lt;arne@...1227...&gt;<br>
<b>Sent:</b> Saturday, January 1, 2022 5:26 PM<br>
<b>To:</b> openvpn-devel@lists.sourceforge.net<br>
<b>Subject:</b> [Openvpn-devel] [PATCH v3 03/14] Change buffer allocation c=
alculation and checks to be more static
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style><font size=3D"=
2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Currently we use half dynamic buffer sizes where w=
e use have a fixed<br>
overhead for crypto (crypto_max_overhead) but use a dynamic overhead<br>
for the the other small header sizes.<br>
<br>
Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>
---<br>
&nbsp;src/openvpn/comp-lz4.c&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&nbsp;src/openvpn/crypto.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&nbsp;src/openvpn/forward.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 +--<br>
&nbsp;src/openvpn/init.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 107 ++++++++=
+++++++++++++++++++++++++++----<br>
&nbsp;src/openvpn/lzo.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&n=
bsp; 2 +-<br>
&nbsp;src/openvpn/mtu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&n=
bsp; 7 ++-<br>
&nbsp;src/openvpn/mtu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7=
4 ++++++++++++++-------------<br>
&nbsp;src/openvpn/multi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<=
br>
&nbsp;src/openvpn/multi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<=
br>
&nbsp;src/openvpn/occ.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&n=
bsp; 4 +-<br>
&nbsp;src/openvpn/options.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<br>
&nbsp;src/openvpn/ping.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; =
2 +-<br>
&nbsp;src/openvpn/ssl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3=
5 ++++++++++---<br>
&nbsp;src/openvpn/ssl_common.h |&nbsp;&nbsp; 3 +-<br>
&nbsp;14 files changed, 187 insertions(+), 71 deletions(-)<br>
<br>
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c<br>
index bceca5e2..aa83ea80 100644<br>
--- a/src/openvpn/comp-lz4.c<br>
+++ b/src/openvpn/comp-lz4.c<br>
@@ -213,7 +213,7 @@ lz4_decompress(struct buffer *buf, struct buffer work,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct compress_context *compctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const struct frame *frame)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; size_t zlen_max =3D EXPANDED_SIZE(frame);<br>
+&nbsp;&nbsp;&nbsp; size_t zlen_max =3D frame-&gt;buf.payload_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t c;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* flag indicating whether or not our peer compressed */<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (buf-&gt;len &lt;=3D 0)<br>
@@ -250,7 +250,7 @@ lz4v2_decompress(struct buffer *buf, struct buffer work=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct compress_context *compctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; const struct frame *frame)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; size_t zlen_max =3D EXPANDED_SIZE(frame);<br>
+&nbsp;&nbsp;&nbsp; size_t zlen_max =3D frame-&gt;buf.payload_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t c;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* flag indicating whether or not our peer compressed */<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (buf-&gt;len &lt;=3D 0)<br>
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c<br>
index 05a2c6be..18a6c99c 100644<br>
--- a/src/openvpn/crypto.c<br>
+++ b/src/openvpn/crypto.c<br>
@@ -1064,7 +1064,7 @@ test_crypto(struct crypto_options *co, struct frame *=
frame)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct gc_arena gc =3D gc_new();<br>
-&nbsp;&nbsp;&nbsp; struct buffer src =3D alloc_buf_gc(TUN_MTU_SIZE(frame),=
 &amp;gc);<br>
+&nbsp;&nbsp;&nbsp; struct buffer src =3D alloc_buf_gc(frame-&gt;buf.payloa=
d_size, &amp;gc);<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct buffer work =3D alloc_buf_gc(BUF_SIZE(frame=
), &amp;gc);<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct buffer encrypt_workspace =3D alloc_buf_gc(B=
UF_SIZE(frame), &amp;gc);<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct buffer decrypt_workspace =3D alloc_buf_gc(B=
UF_SIZE(frame), &amp;gc);<br>
@@ -1095,7 +1095,7 @@ test_crypto(struct crypto_options *co, struct frame *=
frame)<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; msg(M_INFO, &quot;Entering &quot; PACKAGE_NAME &qu=
ot; crypto self-test mode.&quot;);<br>
-&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt;=3D TUN_MTU_SIZE(frame); ++i)<br>
+&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt;=3D frame-&gt;buf.payload_size; ++i=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_time();<br>
&nbsp;<br>
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c<br>
index f82386a1..c971c6bd 100644<br>
--- a/src/openvpn/forward.c<br>
+++ b/src/openvpn/forward.c<br>
@@ -1119,8 +1119,8 @@ read_incoming_tun(struct context *c)<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;#else&nbsp; /* ifdef _WIN32 */<br>
&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(buf_init(&amp;c-&gt;c2.buf, FRAME_HEADROOM(=
&amp;c-&gt;c2.frame)));<br>
-&nbsp;&nbsp;&nbsp; ASSERT(buf_safe(&amp;c-&gt;c2.buf, MAX_RW_SIZE_TUN(&amp=
;c-&gt;c2.frame)));<br>
-&nbsp;&nbsp;&nbsp; c-&gt;c2.buf.len =3D read_tun(c-&gt;c1.tuntap, BPTR(&am=
p;c-&gt;c2.buf), MAX_RW_SIZE_TUN(&amp;c-&gt;c2.frame));<br>
+&nbsp;&nbsp;&nbsp; ASSERT(buf_safe(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.p=
ayload_size));<br>
+&nbsp;&nbsp;&nbsp; c-&gt;c2.buf.len =3D read_tun(c-&gt;c1.tuntap, BPTR(&am=
p;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);<br>
&nbsp;#endif /* ifdef _WIN32 */<br>
&nbsp;<br>
&nbsp;#ifdef PACKET_TRUNCATION_CHECK<br>
@@ -1709,7 +1709,7 @@ process_outgoing_tun(struct context *c)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PIP_MSSFIX | PIPV=
4_EXTRACT_DHCP_ROUTER | PIPV4_CLIENT_NAT | PIP_OUTGOING,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;c-&gt;c2.to_=
tun);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (c-&gt;c2.to_tun.len &lt;=3D MAX_RW_SIZE_TUN(&amp;c-=
&gt;c2.frame))<br>
+&nbsp;&nbsp;&nbsp; if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.buf.payl=
oad_size)<br>
&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Write to TUN/TAP d=
evice.<br>
@@ -1769,7 +1769,7 @@ process_outgoing_tun(struct context *c)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg(D_LINK_ERRORS, &quot;t=
un packet too large on write (tried=3D%d,max=3D%d)&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c-=
&gt;c2.to_tun.len,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_RW_=
SIZE_TUN(&amp;c-&gt;c2.frame));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c-&gt;c=
2.frame.buf.payload_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; buf_reset(&amp;c-&gt;c2.to_tun);<br>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
index e8723714..c4770c21 100644<br>
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -740,7 +740,7 @@ init_port_share(struct context *c)<br>
&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_share =3D port_share_=
open(c-&gt;options.port_share_host,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c-=
&gt;options.port_share_port,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_RW_=
SIZE_LINK(&amp;c-&gt;c2.frame),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c-&gt;c=
2.frame.buf.payload_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c-=
&gt;options.port_share_journal_dir);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (port_share =3D=3D NULL=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
@@ -2505,6 +2505,35 @@ do_startup_pause(struct context *c)<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+static size_t<br>
+get_frame_mtu(struct context *c, const struct options *o)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; size_t mtu;<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (o-&gt;ce.link_mtu_defined)<br>
+&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(o-&gt;ce.link_mtu_define=
d);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if we have a link mtu define=
d we calculate what the old code<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * would have come up with=
 as tun-mtu */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t overhead =3D frame_calcu=
late_protocol_header_size(&amp;c-&gt;c1.ks.key_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o=
, true);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtu =3D o-&gt;ce.link_mtu - ove=
rhead;<br>
+<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(o-&gt;ce.tun_mtu_defined=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtu =3D o-&gt;ce.tun_mtu;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (mtu &lt; TUN_MTU_MIN)<br>
+&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg(M_WARN, &quot;TUN MTU value=
 (%lu) must be at least %d&quot;, mtu, TUN_MTU_MIN);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_print(&amp;c-&gt;c2.frame=
, M_FATAL, &quot;MTU is too small&quot;);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; return mtu;<br>
+}<br>
+<br>
&nbsp;/*<br>
&nbsp; * Finalize MTU parameters based on command line or config file optio=
ns.<br>
&nbsp; */<br>
@@ -2516,12 +2545,68 @@ frame_finalize_options(struct context *c, const str=
uct options *o)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o =3D &amp;c-&gt;options;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; frame_add_to_extra_buffer(&amp;c-&gt;c2.frame, PAYLOAD_=
ALIGN);<br>
-&nbsp;&nbsp;&nbsp; frame_finalize(&amp;c-&gt;c2.frame,<br>
+&nbsp;&nbsp;&nbsp; struct frame *frame =3D &amp;c-&gt;c2.frame;<br>
+<br>
+&nbsp;&nbsp;&nbsp; frame-&gt;tun_mtu =3D get_frame_mtu(c, o);<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* We always allow at least 1500 MTU packets to be rece=
ived in our buffer<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * space */<br>
+&nbsp;&nbsp;&nbsp; size_t payload_size =3D max_int(1500, frame-&gt;tun_mtu=
);<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* The extra tun needs to be added to the payload size =
*/<br>
+&nbsp;&nbsp;&nbsp; if (o-&gt;ce.tun_mtu_defined)<br>
+&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; payload_size +=3D o-&gt;ce.tun_=
mtu_extra;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Add 100 byte of extra space in the buffer to account=
 for slightly<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * mismatched MUTs between peers */<br>
+&nbsp;&nbsp;&nbsp; payload_size +=3D 100;<br>
+<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* the space that is reserved before the payload to add=
 extra headers to it<br>
+&nbsp;&nbsp;&nbsp; * we always reserve the space for the worst case */<br>
+&nbsp;&nbsp;&nbsp; size_t headroom =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* includes IV and packet ID */<br>
+&nbsp;&nbsp;&nbsp; headroom +=3D crypto_max_overhead();<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* peer id + opcode */<br>
+&nbsp;&nbsp;&nbsp; headroom +=3D 4;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* socks proxy header */<br>
+&nbsp;&nbsp;&nbsp; headroom +=3D 10;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* compression header and fragment header (part of the =
encrypted payload) */<br>
+&nbsp;&nbsp;&nbsp; headroom +=3D 1 + 1;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Round up headroom to the next multiple of 4 to ensur=
e alignment */<br>
+&nbsp;&nbsp;&nbsp; headroom =3D (headroom + 3) &amp; ~3;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Add the headroom to the payloadsize as a received (I=
P) packet can have<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * all the extra headers in it */<br>
+&nbsp;&nbsp;&nbsp; payload_size +=3D headroom;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* the space after the payload, this needs some extra b=
uffer space for<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * encryption so headroom is probably too much but=
 we do not really care<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * the few extra bytes */<br>
+&nbsp;&nbsp;&nbsp; size_t tailroom =3D headroom;<br>
+<br>
+#ifdef USE_COMP<br>
+&nbsp;&nbsp;&nbsp; tailroom +=3D COMP_EXTRA_BUFFER(frame-&gt;buf.payload_s=
ize);<br>
+#endif<br>
+<br>
+&nbsp;&nbsp;&nbsp; frame-&gt;buf.payload_size =3D payload_size;<br>
+&nbsp;&nbsp;&nbsp; frame-&gt;buf.headroom =3D headroom;<br>
+&nbsp;&nbsp;&nbsp; frame-&gt;buf.tailroom =3D tailroom;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Kept to still update/calculate the other fields for =
now */<br>
+&nbsp;&nbsp;&nbsp; frame_finalize(frame,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o-&gt;ce.link_mtu_defined,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o-&gt;ce.link_mtu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o-&gt;ce.tun_mtu_defined,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o-&gt;ce.tun_mtu);<br>
+<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
@@ -3288,17 +3373,19 @@ init_context_buffers(const struct frame *frame)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ALLOC_OBJ_CLEAR(b, struct context_buffers);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; b-&gt;read_link_buf =3D alloc_buf(BUF_SIZE(frame));<br>
-&nbsp;&nbsp;&nbsp; b-&gt;read_tun_buf =3D alloc_buf(BUF_SIZE(frame));<br>
+&nbsp;&nbsp;&nbsp; size_t buf_size =3D BUF_SIZE(frame);<br>
+<br>
+&nbsp;&nbsp;&nbsp; b-&gt;read_link_buf =3D alloc_buf(buf_size);<br>
+&nbsp;&nbsp;&nbsp; b-&gt;read_tun_buf =3D alloc_buf(buf_size);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; b-&gt;aux_buf =3D alloc_buf(BUF_SIZE(frame));<br>
+&nbsp;&nbsp;&nbsp; b-&gt;aux_buf =3D alloc_buf(buf_size);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; b-&gt;encrypt_buf =3D alloc_buf(BUF_SIZE(frame));<br>
-&nbsp;&nbsp;&nbsp; b-&gt;decrypt_buf =3D alloc_buf(BUF_SIZE(frame));<br>
+&nbsp;&nbsp;&nbsp; b-&gt;encrypt_buf =3D alloc_buf(buf_size);<br>
+&nbsp;&nbsp;&nbsp; b-&gt;decrypt_buf =3D alloc_buf(buf_size);<br>
&nbsp;<br>
&nbsp;#ifdef USE_COMP<br>
-&nbsp;&nbsp;&nbsp; b-&gt;compress_buf =3D alloc_buf(BUF_SIZE(frame));<br>
-&nbsp;&nbsp;&nbsp; b-&gt;decompress_buf =3D alloc_buf(BUF_SIZE(frame));<br>
+&nbsp;&nbsp;&nbsp; b-&gt;compress_buf =3D alloc_buf(buf_size);<br>
+&nbsp;&nbsp;&nbsp; b-&gt;decompress_buf =3D alloc_buf(buf_size);<br>
&nbsp;#endif<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; return b;<br>
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c<br>
index 8d572684..e7e89655 100644<br>
--- a/src/openvpn/lzo.c<br>
+++ b/src/openvpn/lzo.c<br>
@@ -213,7 +213,7 @@ lzo_decompress(struct buffer *buf, struct buffer work,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct compress_context *compctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const struct frame *frame)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; lzo_uint zlen =3D EXPANDED_SIZE(frame);<br>
+&nbsp;&nbsp;&nbsp; lzo_uint zlen =3D frame-&gt;buf.payload_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t c;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* flag indicating whether or not our peer compressed */<br>
&nbsp;<br>
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c<br>
index cc7c95e4..1648c8fe 100644<br>
--- a/src/openvpn/mtu.c<br>
+++ b/src/openvpn/mtu.c<br>
@@ -48,7 +48,7 @@ alloc_buf_sock_tun(struct buffer *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* allocate buffer for overlapped I/O */<br>
&nbsp;&nbsp;&nbsp;&nbsp; *buf =3D alloc_buf(BUF_SIZE(frame));<br>
&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(buf_init(buf, FRAME_HEADROOM(frame)));<br>
-&nbsp;&nbsp;&nbsp; buf-&gt;len =3D tuntap_buffer ? MAX_RW_SIZE_TUN(frame) =
: MAX_RW_SIZE_LINK(frame);<br>
+&nbsp;&nbsp;&nbsp; buf-&gt;len =3D frame-&gt;buf.payload_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(buf_safe(buf, 0));<br>
&nbsp;}<br>
&nbsp;<br>
@@ -296,6 +296,11 @@ frame_print(const struct frame *frame,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot=
;%s &quot;, prefix);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot;[&quot;);<br>
+&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot; mss_fix:%d&quot;, frame-&gt=
;mss_fix);<br>
+&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot; tun_mtu:%d&quot;, frame-&gt=
;tun_mtu);<br>
+&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot; headroom:%d&quot;, frame-&g=
t;buf.headroom);<br>
+&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot; payload:%d&quot;, frame-&gt=
;buf.payload_size);<br>
+&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot; tailroom:%d&quot;, frame-&g=
t;buf.tailroom);<br>
&nbsp;&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot; L:%d&quot;, frame-&gt;=
link_mtu);<br>
&nbsp;&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot; D:%d&quot;, frame-&gt;=
link_mtu_dynamic);<br>
&nbsp;&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot; EF:%d&quot;, frame-&gt=
;extra_frame);<br>
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h<br>
index c83d8816..930c4b73 100644<br>
--- a/src/openvpn/mtu.h<br>
+++ b/src/openvpn/mtu.h<br>
@@ -91,6 +91,25 @@<br>
&nbsp; * Packet geometry parameters.<br>
&nbsp; */<br>
&nbsp;struct frame {<br>
+&nbsp;&nbsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This struct holds all the in=
formation about the buffers that are<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * allocated to match this=
 frame */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int payload_size;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /**&lt; the maximum size that a payload that our<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; buffers can hold =
from either tun device<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; or network link.<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int headroom;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; the headroom in the buff=
er, this is choosen<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; to allow all pote=
ntial header to be added<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; before the packet=
 */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int tailroom;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; the tailroom in th=
e buffer. Chosen large<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; enough to also ac=
company any extrea header<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; or work space req=
uired by<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; decryption/encryp=
tion or compression. */<br>
+&nbsp;&nbsp;&nbsp; } buf;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; int link_mtu;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Maximum packet size=
 to be sent over<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; the external=
 network interface. */<br>
&nbsp;<br>
@@ -110,6 +129,17 @@ struct frame {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; @endcode<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp; int tun_mtu;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; the (user) configur=
ed tun-mtu. This is used<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; in configuring th=
e tun interface or<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; in calculations t=
hat use the desired size<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; of the payload in=
 the buffer.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; This variable is =
also used in control<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; frame context to =
set the desired maximum<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; control frame pay=
load (although most of<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; code ignores it)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; int extra_buffer;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Maximum number of bytes that<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; processing s=
teps could expand the<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; internal wor=
k buffer.<br>
@@ -165,8 +195,8 @@ struct options;<br>
&nbsp; * a tap device ifconfiged to an MTU of 1200 might actually want<br>
&nbsp; * to return a packet size of 1214 on a read().<br>
&nbsp; */<br>
-#define PAYLOAD_SIZE(f)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ((f)-&gt;link_mtu - (f)-&gt;extra_frame)<br>
&nbsp;#define PAYLOAD_SIZE_DYNAMIC(f)&nbsp; ((f)-&gt;link_mtu_dynamic - (f)=
-&gt;extra_frame)<br>
+#define PAYLOAD_SIZE(f)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ((f)-&gt;buf.payload_size)<br>
&nbsp;<br>
&nbsp;/*<br>
&nbsp; * Max size of a payload packet after encryption, compression, etc.<b=
r>
@@ -176,35 +206,23 @@ struct options;<br>
&nbsp;#define EXPANDED_SIZE_DYNAMIC(f) ((f)-&gt;link_mtu_dynamic)<br>
&nbsp;#define EXPANDED_SIZE_MIN(f)&nbsp;&nbsp;&nbsp;&nbsp; (TUN_MTU_MIN + T=
UN_LINK_DELTA(f))<br>
&nbsp;<br>
-/*<br>
- * These values are used as maximum size constraints<br>
- * on read() or write() from TUN/TAP device or TCP/UDP port.<br>
- */<br>
-#define MAX_RW_SIZE_TUN(f)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (PAYLOAD_SI=
ZE(f))<br>
-#define MAX_RW_SIZE_LINK(f)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (EXPANDED_SIZE(f=
) + (f)-&gt;extra_link)<br>
-<br>
&nbsp;/*<br>
&nbsp; * Control buffer headroom allocations to allow for efficient prepend=
ing.<br>
&nbsp; */<br>
-#define FRAME_HEADROOM_BASE(f)&nbsp;&nbsp;&nbsp;&nbsp; (TUN_LINK_DELTA(f) =
+ (f)-&gt;extra_buffer + (f)-&gt;extra_link)<br>
-/* Same as FRAME_HEADROOM_BASE but rounded up to next multiple of PAYLOAD_=
ALIGN */<br>
-#define FRAME_HEADROOM(f)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; frame_headroom(f)<br>
&nbsp;<br>
&nbsp;/*<br>
&nbsp; * Max size of a buffer used to build a packet for output to<br>
- * the TCP/UDP port.<br>
- *<br>
- * the FRAME_HEADROOM_BASE(f) * 2 should not be necessary but it looks tha=
t at<br>
- * some point in the past we seem to have lost the information what parts =
of<br>
- * the extra space we need to have before the data and which we need after=
<br>
- * the data. So we ensure we have the FRAME_HEADROOM before and after the<=
br>
- * actual data.<br>
+ * the TCP/UDP port or to read a packet from a tap/tun device.<br>
&nbsp; *<br>
&nbsp; * Most of our code only prepends headers but compression needs the e=
xtra bytes<br>
&nbsp; * *after* the data as compressed data might end up larger than the o=
riginal<br>
- * data (and max compression overhead is part of extra_buffer)<br>
+ * data (and max compression overhead is part of extra_buffer). Also crypt=
o<br>
+ * needs an extra block for encryption. Therefore tailroom is larger than =
the<br>
+ * headroom.<br>
&nbsp; */<br>
-#define BUF_SIZE(f)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; (TUN_MTU_SIZE(f) + FRAME_HEADROOM_BASE(f) * 2)<br>
+#define BUF_SIZE(f) ((f)-&gt;buf.headroom + (f)-&gt;buf.payload_size + (f)=
-&gt;buf.tailroom)<br>
+<br>
+#define FRAME_HEADROOM(f)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ((f)-&gt;buf.headroom)<br>
&nbsp;<br>
&nbsp;/*<br>
&nbsp; * Function prototypes.<br>
@@ -326,20 +344,6 @@ const char *format_extended_socket_error(int fd, int *=
mtu, struct gc_arena *gc);<br>
&nbsp;<br>
&nbsp;#endif<br>
&nbsp;<br>
-/*<br>
- * Calculate a starting offset into a buffer object, dealing with<br>
- * headroom and alignment issues.<br>
- */<br>
-static inline int<br>
-frame_headroom(const struct frame *f)<br>
-{<br>
-&nbsp;&nbsp;&nbsp; const int offset =3D FRAME_HEADROOM_BASE(f);<br>
-&nbsp;&nbsp;&nbsp; /* These two lines just pad offset to next multiple of =
PAYLOAD_ALIGN in<br>
-&nbsp;&nbsp;&nbsp;&nbsp; * a complicated and confusing way */<br>
-&nbsp;&nbsp;&nbsp; const int delta =3D ((PAYLOAD_ALIGN &lt;&lt; 24) - offs=
et) &amp; (PAYLOAD_ALIGN - 1);<br>
-&nbsp;&nbsp;&nbsp; return offset + delta;<br>
-}<br>
-<br>
&nbsp;/*<br>
&nbsp; * frame member adjustment functions<br>
&nbsp; */<br>
@@ -383,7 +387,7 @@ frame_add_to_extra_buffer(struct frame *frame, const in=
t increment)<br>
&nbsp;static inline bool<br>
&nbsp;frame_defined(const struct frame *frame)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; return frame-&gt;link_mtu &gt; 0;<br>
+&nbsp;&nbsp;&nbsp; return frame-&gt;buf.payload_size &gt; 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;#endif /* ifndef MTU_H */<br>
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c<br>
index 103e882e..e5ffebff 100644<br>
--- a/src/openvpn/multi.c<br>
+++ b/src/openvpn/multi.c<br>
@@ -3495,7 +3495,7 @@ gremlin_flood_clients(struct multi_context *m)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(buf_init(&amp;buf, =
FRAME_HEADROOM(&amp;m-&gt;top.c2.frame)));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parm.packet_size =3D min_int(pa=
rm.packet_size, MAX_RW_SIZE_TUN(&amp;m-&gt;top.c2.frame));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parm.packet_size =3D min_int(pa=
rm.packet_size, m-&gt;top.c2.frame.buf.payload_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg(D_GREMLIN, &quot;GREML=
IN_FLOOD_CLIENTS: flooding clients with %d packets of size %d&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pa=
rm.n_packets,<br>
@@ -3557,7 +3557,7 @@ multi_process_per_second_timers_dowork(struct multi_c=
ontext *m)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void<br>
-multi_top_init(struct multi_context *m, const struct context *top)<br>
+multi_top_init(struct multi_context *m, struct context *top)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; inherit_context_top(&amp;m-&gt;top, top);<br>
&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;top.c2.buffers =3D init_context_buffers(&amp=
;top-&gt;c2.frame);<br>
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h<br>
index 6e85c21c..c2b085e3 100644<br>
--- a/src/openvpn/multi.h<br>
+++ b/src/openvpn/multi.h<br>
@@ -257,7 +257,7 @@ void multi_init(struct multi_context *m, struct context=
 *t, bool tcp_mode);<br>
&nbsp;<br>
&nbsp;void multi_uninit(struct multi_context *m);<br>
&nbsp;<br>
-void multi_top_init(struct multi_context *m, const struct context *top);<b=
r>
+void multi_top_init(struct multi_context *m, struct context *top);<br>
&nbsp;<br>
&nbsp;void multi_top_free(struct multi_context *m);<br>
&nbsp;<br>
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c<br>
index 610c05f5..c4e7c1be 100644<br>
--- a/src/openvpn/occ.c<br>
+++ b/src/openvpn/occ.c<br>
@@ -219,7 +219,7 @@ check_send_occ_msg_dowork(struct context *c)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; c-&gt;c2.buf =3D c-&gt;c2.buffers-&gt;aux_buf;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(buf_init(&amp;c-&gt;c2.buf, FRAME_HEADROOM(=
&amp;c-&gt;c2.frame)));<br>
-&nbsp;&nbsp;&nbsp; ASSERT(buf_safe(&amp;c-&gt;c2.buf, MAX_RW_SIZE_TUN(&amp=
;c-&gt;c2.frame)));<br>
+&nbsp;&nbsp;&nbsp; ASSERT(buf_safe(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.p=
ayload_size));<br>
&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(buf_write(&amp;c-&gt;c2.buf, occ_magic, OCC=
_STRING_SIZE));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; switch (c-&gt;c2.occ_op)<br>
@@ -319,7 +319,7 @@ check_send_occ_msg_dowork(struct context *c)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; OCC_STRING_SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (int) sizeof(uint8_t),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; EXTRA_FRAME(&amp;c-&gt;c2.frame),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; MAX_RW_SIZE_TUN(&amp;c-&gt;c2.frame),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; c-&gt;c2.frame.buf.payload_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; BLEN(&amp;c-&gt;c2.buf));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do=
it =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index 2ca24685..6e3dccb1 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -3832,7 +3832,7 @@ options_string(const struct options *o,<br>
&nbsp;&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot;,link-mtu %u&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (unsigned int) calc_options_string_link_mtu(o, frame));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot;,tun-mtu %d&quot;, PAYLOAD_S=
IZE(frame));<br>
+&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot;,tun-mtu %d&quot;, frame-&gt=
;tun_mtu);<br>
&nbsp;&nbsp;&nbsp;&nbsp; buf_printf(&amp;out, &quot;,proto %s&quot;,&nbsp; =
proto_remote(o-&gt;ce.proto, remote));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool p2p_nopull =3D o-&gt;mode =3D=3D MODE_POINT_T=
O_POINT &amp;&amp; !PULL_DEFINED(o);<br>
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c<br>
index 67bbca14..a28f347f 100644<br>
--- a/src/openvpn/ping.c<br>
+++ b/src/openvpn/ping.c<br>
@@ -80,7 +80,7 @@ check_ping_send_dowork(struct context *c)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; c-&gt;c2.buf =3D c-&gt;c2.buffers-&gt;aux_buf;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(buf_init(&amp;c-&gt;c2.buf, FRAME_HEADROOM(=
&amp;c-&gt;c2.frame)));<br>
-&nbsp;&nbsp;&nbsp; ASSERT(buf_safe(&amp;c-&gt;c2.buf, MAX_RW_SIZE_TUN(&amp=
;c-&gt;c2.frame)));<br>
+&nbsp;&nbsp;&nbsp; ASSERT(buf_safe(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.p=
ayload_size));<br>
&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(buf_write(&amp;c-&gt;c2.buf, ping_string, s=
izeof(ping_string)));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c<br>
index 96c78199..b815cdfc 100644<br>
--- a/src/openvpn/ssl.c<br>
+++ b/src/openvpn/ssl.c<br>
@@ -332,6 +332,32 @@ tls_init_control_channel_frame_parameters(const struct=
 frame *data_channel_frame<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* set dynamic link MTU to cap control channel pac=
kets at 1250 bytes */<br>
&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(TUN_LINK_DELTA(frame) &lt; min_int(frame-&g=
t;link_mtu, 1250));<br>
&nbsp;&nbsp;&nbsp;&nbsp; frame-&gt;link_mtu_dynamic =3D min_int(frame-&gt;l=
ink_mtu, 1250) - TUN_LINK_DELTA(frame);<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* calculate the maximum overhead that control channel =
frames may have */<br>
+&nbsp;&nbsp;&nbsp; int overhead =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Socks */<br>
+&nbsp;&nbsp;&nbsp; overhead +=3D 10;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* tls-auth and tls-crypt */<br>
+&nbsp;&nbsp;&nbsp; overhead +=3D max_int(tls_crypt_buf_overhead(),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; packet_id_=
size(true) + OPENVPN_MAX_HMAC_SIZE);<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* TCP length field and opcode */<br>
+&nbsp;&nbsp;&nbsp; overhead+=3D 3;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* Previous OpenVPN version calculated the maximum size=
 and buffer of a<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * control frame depending on the overhead of the =
data channel frame<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * overhead and limited its maximum size to 1250. =
We always allocate the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * 1250 buffer size since a lot of code blindly as=
sumes a large buffer<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * (e.g. PUSH_BUNDLE_SIZE) and set frame-&gt;mtu_m=
tu as suggestion for the<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * size */<br>
+&nbsp;&nbsp;&nbsp; frame-&gt;buf.payload_size =3D 1250 + overhead;<br>
+<br>
+&nbsp;&nbsp;&nbsp; frame-&gt;buf.headroom =3D overhead;<br>
+&nbsp;&nbsp;&nbsp; frame-&gt;buf.tailroom =3D overhead;<br>
+<br>
+&nbsp;&nbsp;&nbsp; frame-&gt;tun_mtu =3D min_int(data_channel_frame-&gt;tu=
n_mtu, 1250);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void<br>
@@ -1870,13 +1896,6 @@ tls_session_update_crypto_params_do_work(struct tls_=
session *session,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg(D_HANDSHAKE, &quot;Dat=
a Channel: using negotiated cipher '%s'&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op=
tions-&gt;ciphername);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Very hacky workaround and qu=
ick fix for frame calculation<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * different when adjustin=
g frame size when the original and new cipher<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * are identical to avoid =
a regression with client without NCP */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return tls_session_generate_dat=
a_channel_keys(session);<br>
-&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; init_key_type(&amp;session-&gt;opt-&gt;key_type, o=
ptions-&gt;ciphername,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; options-&gt;authname, true, true);<br>
@@ -2959,7 +2978,7 @@ tls_process(struct tls_multi *multi,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bu=
f =3D reliable_get_buf_output_sequenced(ks-&gt;send_reliable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (buf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; int status =3D key_state_read_ciphertext(&amp;ks-&gt;ks_ss=
l, buf, PAYLOAD_SIZE_DYNAMIC(&amp;multi-&gt;opt.frame));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; int status =3D key_state_read_ciphertext(&amp;ks-&gt;ks_ss=
l, buf, multi-&gt;opt.frame.tun_mtu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (status =3D=3D -1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg(D_TLS_ERRORS,<br>
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h<br>
index f851bd2b..ada68b4b 100644<br>
--- a/src/openvpn/ssl_common.h<br>
+++ b/src/openvpn/ssl_common.h<br>
@@ -221,8 +221,9 @@ struct key_state<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct reliable *rec_reliable; /* order incoming c=
iphertext packets before we pass to TLS */<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct reliable_ack *rec_ack; /* buffers all packe=
t IDs we want to ACK back to sender */<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp; /** Holds outgoing message for the control channel unti=
l ks-&gt;state reaches<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * S_ACTIVE */<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct buffer_list *paybuf;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; counter_type n_bytes;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* how many b=
ytes sent/recvd since last key exchange */<br>
&nbsp;&nbsp;&nbsp;&nbsp; counter_type n_packets;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* how many packets sen=
t/recvd since last key exchange */<br>
&nbsp;<br>
-- <br>
2.33.0<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
Openvpn-devel@lists.sourceforge.net<br>
<a href=3D"https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flists.sourceforge.net%2Flists%2Flistinfo%2Fopenvpn-devel&amp;amp;data=3D=
04%7C01%7C%7Cc6b0d28a607f43d51a2008d9cd437553%7C84df9e7fe9f640afb435aaaaaaa=
aaaaa%7C1%7C0%7C637766511911959351%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3D7=
JCqlDEY7ZQhaObeHQ%2FaEL77ZhIgLdjhR5G7HVnkquA%3D&amp;amp;reserved=3D0">https=
://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.sourcef=
orge.net%2Flists%2Flistinfo%2Fopenvpn-devel&amp;amp;data=3D04%7C01%7C%7Cc6b=
0d28a607f43d51a2008d9cd437553%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C=
637766511911959351%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3D7JCqlDEY7ZQhaObeH=
Q%2FaEL77ZhIgLdjhR5G7HVnkquA%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR04MB4891B058B4837F427DB10251E9499DM6PR04MB4891namp_--

