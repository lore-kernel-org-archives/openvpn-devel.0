From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Feb 2022 10:26:07 +0100
Message-Id: <20220214092607.3785665-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Remove FRAME_HEADROOM, PAYLOAD_SIZE,
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

Patch v2: Remove all FRAME_HEADROOM macros
---
 src/openvpn/comp-lz4.c |  8 ++++----
 src/openvpn/crypto.c   | 19 ++++++++++---------
 src/openvpn/forward.c  |  8 ++++----
 src/openvpn/fragment.c |  6 +++---
 src/openvpn/lzo.c      |  6 +++---
 src/openvpn/mtu.c      |  2 +-
 src/openvpn/mtu.h      | 23 -----------------------
 src/openvpn/multi.c    |  2 +-
 src/openvpn/occ.c      |  2 +-
 src/openvpn/ping.c     |  2 +-
 src/openvpn/ssl.c      |  6 +++---
 11 files changed, 31 insertions(+), 53 deletions(-)

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
index c8d2bcca..3176a1b7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -49,14 +49,14 @@
  * work is a workspace buffer we are given of size BUF_SIZE.
  * work may be used to return output data, or the input buffer
  * may be modified and returned as output.  If output data is
- * returned in work, the data should start after FRAME_HEADROOM bytes
+ * returned in work, the data should start after buf.headroom bytes
  * of padding to leave room for downstream routines to prepend.
  *
- * Up to a total of FRAME_HEADROOM bytes may be prepended to the input buf
+ * Up to a total of buf.headroom bytes may be prepended to the input buf
  * by all routines (encryption, decryption, compression, and decompression).
  *
  * Note that the buf_prepend return will assert if we try to
- * make a header bigger than FRAME_HEADROOM.  This should not
+ * make a header bigger than buf.headroom.  This should not
  * happen unless the frame parameters are wrong.
  */
 
@@ -370,7 +370,7 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
 
     ASSERT(ad_start >= buf->data && ad_start <= BPTR(buf));
 
-    ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+    ASSERT(buf_init(&work, frame->buf.headroom));
 
     /* IV and Packet ID required for this mode */
     ASSERT(packet_id_initialized(&opt->packet_id));
@@ -532,8 +532,8 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = { 0 };
             int outlen;
 
-            /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
-            ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+            /* initialize work buffer with buf.headroom bytes of prepend capacity */
+            ASSERT(buf_init(&work, frame->buf.headroom));
 
             /* read the IV from the packet */
             if (buf->len < iv_size)
@@ -742,6 +742,7 @@ warn_insecure_key_type(const char *ciphername)
  * Build a struct key_type.
  */
 void
+
 init_key_type(struct key_type *kt, const char *ciphername,
               const char *authname, bool tls_mode, bool warn)
 {
@@ -1035,7 +1036,7 @@ test_crypto(struct crypto_options *co, struct frame *frame)
     void *buf_p;
 
     /* init work */
-    ASSERT(buf_init(&work, FRAME_HEADROOM(frame)));
+    ASSERT(buf_init(&work, frame->buf.headroom));
 
     /* init implicit IV */
     {
@@ -1078,8 +1079,8 @@ test_crypto(struct crypto_options *co, struct frame *frame)
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLEN(&src));
 
-        /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
-        ASSERT(buf_init(&encrypt_workspace, FRAME_HEADROOM(frame)));
+        /* initialize work buffer with buf.headroom bytes of prepend capacity */
+        ASSERT(buf_init(&encrypt_workspace, frame->buf.headroom));
 
         /* encrypt */
         openvpn_encrypt(&buf, encrypt_workspace, co);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f508d3b6..c615eed4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -556,8 +556,8 @@ encrypt_sign(struct context *c, bool comp_frag)
 #endif
     }
 
-    /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
-    ASSERT(buf_init(&b->encrypt_buf, FRAME_HEADROOM(&c->c2.frame)));
+    /* initialize work buffer with buf.headroom bytes of prepend capacity */
+    ASSERT(buf_init(&b->encrypt_buf, c->c2.frame.buf.headroom));
 
     if (c->c2.tls_multi)
     {
@@ -802,7 +802,7 @@ read_incoming_link(struct context *c)
     perf_push(PERF_READ_IN_LINK);
 
     c->c2.buf = c->c2.buffers->read_link_buf;
-    ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
+    ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
 
     status = link_socket_read(c->c2.link_socket,
                               &c->c2.buf,
@@ -1118,7 +1118,7 @@ read_incoming_tun(struct context *c)
         sockethandle_finalize(sh, &c->c1.tuntap->reads, &c->c2.buf, NULL);
     }
 #else  /* ifdef _WIN32 */
-    ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
+    ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
     ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
     c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.buf.payload_size);
 #endif /* ifdef _WIN32 */
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
index dddbf4fc..7f967e06 100644
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
@@ -184,8 +163,6 @@ struct options;
  */
 #define BUF_SIZE(f) ((f)->buf.headroom + (f)->buf.payload_size + (f)->buf.tailroom)
 
-#define FRAME_HEADROOM(f)          ((f)->buf.headroom)
-
 /*
  * Function prototypes.
  */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e7f2c697..74e8ef3c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3495,7 +3495,7 @@ gremlin_flood_clients(struct multi_context *m)
         struct packet_flood_parms parm = get_packet_flood_parms(level);
         int i;
 
-        ASSERT(buf_init(&buf, FRAME_HEADROOM(&m->top.c2.frame)));
+        ASSERT(buf_init(&buf, m->top.c2.frame.buf.headroom));
         parm.packet_size = min_int(parm.packet_size, m->top.c2.frame.buf.payload_size);
 
         msg(D_GREMLIN, "GREMLIN_FLOOD_CLIENTS: flooding clients with %d packets of size %d",
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index b7670356..1ed0d377 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -221,7 +221,7 @@ check_send_occ_msg_dowork(struct context *c)
     bool doit = false;
 
     c->c2.buf = c->c2.buffers->aux_buf;
-    ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
+    ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
     ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
     ASSERT(buf_write(&c->c2.buf, occ_magic, OCC_STRING_SIZE));
 
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index b38f2016..588723d0 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -79,7 +79,7 @@ void
 check_ping_send_dowork(struct context *c)
 {
     c->c2.buf = c->c2.buffers->aux_buf;
-    ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
+    ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
     ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
     ASSERT(buf_write(&c->c2.buf, ping_string, sizeof(ping_string)));
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ae6a9914..14a943a7 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -979,10 +979,10 @@ key_state_init(struct tls_session *session, struct key_state *ks)
     ks->plaintext_write_buf = alloc_buf(TLS_CHANNEL_BUF_SIZE);
     ks->ack_write_buf = alloc_buf(BUF_SIZE(&session->opt->frame));
     reliable_init(ks->send_reliable, BUF_SIZE(&session->opt->frame),
-                  FRAME_HEADROOM(&session->opt->frame), TLS_RELIABLE_N_SEND_BUFFERS,
+                  session->opt->frame.buf.headroom, TLS_RELIABLE_N_SEND_BUFFERS,
                   ks->key_id ? false : session->opt->xmit_hold);
     reliable_init(ks->rec_reliable, BUF_SIZE(&session->opt->frame),
-                  FRAME_HEADROOM(&session->opt->frame), TLS_RELIABLE_N_REC_BUFFERS,
+                  session->opt->frame.buf.headroom, TLS_RELIABLE_N_REC_BUFFERS,
                   false);
     reliable_set_timeout(ks->send_reliable, session->opt->packet_timeout);
 
@@ -2982,7 +2982,7 @@ tls_process(struct tls_multi *multi,
     if (!to_link->len && !reliable_ack_empty(ks->rec_ack))
     {
         struct buffer buf = ks->ack_write_buf;
-        ASSERT(buf_init(&buf, FRAME_HEADROOM(&multi->opt.frame)));
+        ASSERT(buf_init(&buf, multi->opt.frame.buf.headroom));
         write_control_auth(session, ks, &buf, to_link_addr, P_ACK_V1,
                            RELIABLE_ACK_SIZE, false);
         *to_link = buf;
-- 
2.33.0


