From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:50 +0200
Message-Id: <20220422142953.3805364-16-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 25/28] Ensure that control channel packet
 are respecting tls-mtu
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

This ensure that control packets are actually are actually smaller than
tls-mtu. Since OpenVPN will consider a control message packet complete
when the TLS record is complete, we have to ensure that the SSL library
will still write one records, so the receiving side will only be able
to get/read the control message content when a TLS records is
complete. To achieve this goal, this commit does:

- Splitting one read from TLS library into multiple control
  channel packets, splitting one TLS record into multiple
  control packets.
- increase allowed number of outstanding packets to 6 from 4 on the
  sender side. This is still okay with older implementation as
  receivers will have room for 8.
- calculate the overhead for control channel message to allow
  staying below that threshold.
- remove maxlen from key_state_read_ciphertext and related functions
  as we now always allow control channel messages to be up to
  TLS_CHANNEL_BUF_SIZE in size and longer limit this by the mtu of
  control packets as the implemented splitting will take care of
  larger payloads from the SSL library
---
 src/openvpn/reliable.c    |  64 +++++++++++----
 src/openvpn/reliable.h    |  32 +++++++-
 src/openvpn/ssl.c         | 162 ++++++++++++++++++++++++++++++++------
 src/openvpn/ssl_backend.h |   8 +-
 src/openvpn/ssl_mbedtls.c |  14 +---
 src/openvpn/ssl_openssl.c |  16 ++--
 src/openvpn/ssl_pkt.h     |   4 +-
 7 files changed, 229 insertions(+), 71 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 372444350..28f99d187 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -41,30 +41,30 @@
 
 #include "memdbg.h"
 
-/*
- * verify that test - base < extent while allowing for base or test wraparound
- */
-static inline bool
-reliable_pid_in_range1(const packet_id_type test,
-                       const packet_id_type base,
-                       const unsigned int extent)
+/* calculates test - base while allowing for base or test wraparound. test is
+ * assume to be higher than base */
+static inline packet_id_type
+subtract_pid(const packet_id_type test, const packet_id_type base)
 {
     if (test >= base)
     {
-        if (test - base < extent)
-        {
-            return true;
-        }
+        return test - base;
     }
     else
     {
-        if ((test+0x80000000u) - (base+0x80000000u) < extent)
-        {
-            return true;
-        }
+        return (test+0x80000000u) - (base+0x80000000u);
     }
+}
 
-    return false;
+/*
+ * verify that test - base < extent while allowing for base or test wraparound
+ */
+static inline bool
+reliable_pid_in_range1(const packet_id_type test,
+                       const packet_id_type base,
+                       const unsigned int extent)
+{
+    return subtract_pid(test, base) < extent;
 }
 
 /*
@@ -496,6 +496,38 @@ reliable_get_buf(struct reliable *rel)
     return NULL;
 }
 
+/* Counts the number of free buffers in output that can be potientially used
+ * for sending */
+int
+reliable_get_num_output_sequenced_available(struct reliable *rel)
+{
+    struct gc_arena gc = gc_new();
+    packet_id_type min_id = 0;
+    bool min_id_defined = false;
+
+    /* find minimum active packet_id */
+    for (int i = 0; i < rel->size; ++i)
+    {
+        const struct reliable_entry *e = &rel->array[i];
+        if (e->active)
+        {
+            if (!min_id_defined || reliable_pid_min(e->packet_id, min_id))
+            {
+                min_id_defined = true;
+                min_id = e->packet_id;
+            }
+        }
+    }
+
+    int ret = rel->size;
+    if (min_id_defined)
+    {
+        ret -= subtract_pid(rel->packet_id, min_id);
+    }
+    gc_free(&gc);
+    return ret;
+}
+
 /* grab a free buffer, fail if buffer clogged by unacknowledged low packet IDs */
 struct buffer *
 reliable_get_buf_output_sequenced(struct reliable *rel)
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 8152e788c..c80949525 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -46,7 +46,7 @@
                                  *   be stored in one \c reliable_ack
                                  *   structure. */
 
-#define RELIABLE_CAPACITY 8     /**< The maximum number of packets that
+#define RELIABLE_CAPACITY 12    /**< The maximum number of packets that
                                  *   the reliability layer for one VPN
                                  *   tunnel in one direction can store. */
 
@@ -93,7 +93,7 @@ struct reliable
     int size;
     interval_t initial_timeout;
     packet_id_type packet_id;
-    int offset;
+    int offset; /**< Offset of the bufs in the reliable_entry array */
     bool hold; /* don't xmit until reliable_schedule_now is called */
     struct reliable_entry array[RELIABLE_CAPACITY];
 };
@@ -178,6 +178,20 @@ reliable_ack_empty(struct reliable_ack *ack)
     return !ack->len;
 }
 
+/**
+ * Returns the number of packets that need to be acked.
+ *
+ * @param ack The acknowledgment structure to check.
+ *
+ * @returns the number of outstanding acks
+ */
+static inline bool
+reliable_ack_outstanding(struct reliable_ack *ack)
+{
+    return ack->len;
+}
+
+
 /**
  * Write a packet ID acknowledgment record to a buffer.
  *
@@ -385,6 +399,20 @@ void reliable_mark_deleted(struct reliable *rel, struct buffer *buf);
  */
 struct buffer *reliable_get_buf_output_sequenced(struct reliable *rel);
 
+
+/**
+ * Counts the number of free buffers in output that can be potientially used
+ * for sending
+ *
+ *  @param rel The reliable structure in which to search for a free
+ *     entry.
+ *
+ *  @return the number of buffer that are available for sending without
+ *             breaking ack sequence
+ * */
+int
+reliable_get_num_output_sequenced_available(struct reliable *rel);
+
 /**
  * Mark the reliable entry associated with the given buffer as
  *     active outgoing.
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 01717559c..3b81f9707 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -323,10 +323,12 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
     /* Previous OpenVPN version calculated the maximum size and buffer of a
      * control frame depending on the overhead of the data channel frame
      * overhead and limited its maximum size to 1250. We always allocate the
-     * 1250 buffer size since a lot of code blindly assumes a large buffer
-     * (e.g. PUSH_BUNDLE_SIZE) and set frame->mtu_mtu as suggestion for the
+     * TLS_CHANNEL_BUF_SIZE buffer size since a lot of code blindly assumes
+     * a large buffer (e.g. PUSH_BUNDLE_SIZE) and also our peer might have
+     * a higher size configure and we still want to be able to receive the
+     * packets. frame->mtu_mtu is set as suggestion for the maximum packet
      * size */
-    frame->buf.payload_size = 1250 + overhead;
+    frame->buf.payload_size = TLS_CHANNEL_BUF_SIZE + overhead;
 
     frame->buf.headroom = overhead;
     frame->buf.tailroom = overhead;
@@ -334,6 +336,48 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
     frame->tun_mtu = min_int(data_channel_frame->tun_mtu, 1250);
 }
 
+/**
+ * calculate the maximum overhead that control channel frames have
+ * This includes header, op code and everything apart from the
+ * payload itself. This method is a bit pessmistic and might give higher
+ * overhead that we actually have */
+static int
+calc_control_channel_frame_overhead(const struct tls_session *session)
+{
+    const struct key_state *ks = &session->key[KS_PRIMARY];
+    int overhead = 0;
+
+    /* TCP length field and opcode */
+    overhead+= 3;
+
+    /* our own session id */
+    overhead += SID_SIZE;
+
+    /* ACK array and remote SESSION ID (part of the ACK array) */
+    overhead += ACK_SIZE(min_int(reliable_ack_outstanding(ks->rec_ack), CONTROL_SEND_ACK_MAX));
+
+    /* Message packet id */
+    overhead += sizeof(packet_id_type);
+
+    if (session->tls_wrap.mode == TLS_WRAP_CRYPT)
+    {
+        overhead += tls_crypt_buf_overhead();
+        overhead += packet_id_size(true);
+    }
+    else if (session->tls_wrap.mode == TLS_WRAP_AUTH)
+    {
+        overhead += hmac_ctx_size(session->tls_wrap.opt.key_ctx_bi.encrypt.hmac);
+        overhead += packet_id_size(true);
+    }
+
+    /* Add the typical UDP overhead for an IPv6 UDP packet. TCP+IPv6 has a
+     * larger overhead but the risk of a TCP connection getting dropped because
+     * we try to send a too large packet is basically zero */
+    overhead += datagram_overhead(AF_INET6, PROTO_UDP);
+
+    return overhead;
+}
+
 void
 init_ssl_lib(void)
 {
@@ -2613,10 +2657,13 @@ control_packet_needs_wkc(const struct key_state *ks)
 }
 
 static bool
-read_incoming_tls_plaintext(struct buffer *buf, struct key_state *ks, interval_t *wakeup)
+read_incoming_tls_plaintext(struct tls_session *session, struct buffer *buf,
+                            interval_t *wakeup, bool *state_change)
 {
     ASSERT(buf_init(buf, 0));
-    int status = key_state_read_plaintext(&ks->ks_ssl, buf, TLS_CHANNEL_BUF_SIZE);
+    struct key_state *ks = &session->key[KS_PRIMARY];
+
+    int status = key_state_read_plaintext(&ks->ks_ssl, buf);
     update_time();
     if (status == -1)
     {
@@ -2634,6 +2681,91 @@ read_incoming_tls_plaintext(struct buffer *buf, struct key_state *ks, interval_t
     return true;
 }
 
+static bool
+write_outgoing_tls_ciphertext(struct tls_session *session, bool *state_change)
+{
+    struct key_state *ks = &session->key[KS_PRIMARY];
+
+    int rel_avail = reliable_get_num_output_sequenced_available(ks->send_reliable);
+    if (rel_avail == 0)
+    {
+        return true;
+    }
+
+    /* We need to determine how much space is actually available in the control
+     * channel frame */
+
+    int max_pkt_len = min_int(TLS_CHANNEL_BUF_SIZE, session->opt->frame.tun_mtu);
+
+
+    /* Subtract overhead */
+    max_pkt_len -= calc_control_channel_frame_overhead(session);
+
+    /* calculate total available length for outgoing tls ciphertext */
+    int maxlen = max_pkt_len * rel_avail;
+
+    /* Is first packet one that will have a WKC appended? */
+    if (control_packet_needs_wkc(ks))
+    {
+        maxlen -= buf_len(session->tls_wrap.tls_crypt_v2_wkc);
+    }
+
+    /* Not enough space available to send a full control channel packet */
+    if (maxlen < TLS_CHANNEL_BUF_SIZE)
+    {
+        if (rel_avail == TLS_RELIABLE_N_SEND_BUFFERS)
+        {
+            msg(D_TLS_ERRORS, "--tls-mtu setting to low. Unable to send TLS packets");
+        }
+        msg(D_REL_LOW, "Reliable: Send queue full, postponing TLS send");
+        return true;
+    }
+
+    /* This seems a bit wasteful to allocate every time */
+    struct gc_arena gc = gc_new();
+    struct buffer tmp = alloc_buf_gc(TLS_CHANNEL_BUF_SIZE, &gc);
+
+    int status = key_state_read_ciphertext(&ks->ks_ssl, &tmp);
+
+    if (status == -1)
+    {
+        msg(D_TLS_ERRORS,
+            "TLS Error: Ciphertext -> reliable TCP/UDP transport read error");
+        gc_free(&gc);
+        return false;
+    }
+    if (status == 1)
+    {
+        /* Split the TLS ciphertext (TLS record) into multiple small packets
+         * that respect tls_mtu */
+        while (tmp.len)
+        {
+            int len = max_pkt_len;
+            int opcode = P_CONTROL_V1;
+            if (control_packet_needs_wkc(ks))
+            {
+                opcode = P_CONTROL_WKC_V1;
+                len = max_int(0, len - buf_len(session->tls_wrap.tls_crypt_v2_wkc));
+            }
+            /* do not send more than available */
+            len = min_int(len, tmp.len);
+
+            struct buffer *buf = reliable_get_buf_output_sequenced(ks->send_reliable);
+            /* we assert here since we checked for its availibility before */
+            ASSERT(buf);
+            buf_copy_n(buf, &tmp, len);
+
+            reliable_mark_active_outgoing(ks->send_reliable, buf, opcode);
+            INCR_GENERATED;
+            *state_change = true;
+        }
+        dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
+    }
+
+    gc_free(&gc);
+    return true;
+}
+
 
 static bool
 tls_process_state(struct tls_multi *multi,
@@ -2727,7 +2859,7 @@ tls_process_state(struct tls_multi *multi,
     struct buffer *buf = &ks->plaintext_read_buf;
     if (!buf->len)
     {
-        if (!read_incoming_tls_plaintext(buf, ks, wakeup))
+        if (!read_incoming_tls_plaintext(session, buf, wakeup, &state_change))
         {
             goto error;
         }
@@ -2788,26 +2920,10 @@ tls_process_state(struct tls_multi *multi,
         buf = reliable_get_buf_output_sequenced(ks->send_reliable);
         if (buf)
         {
-            int status = key_state_read_ciphertext(&ks->ks_ssl, buf, multi->opt.frame.tun_mtu);
-
-            if (status == -1)
+            if (!write_outgoing_tls_ciphertext(session, &state_change))
             {
-                msg(D_TLS_ERRORS,
-                    "TLS Error: Ciphertext -> reliable TCP/UDP transport read error");
                 goto error;
             }
-            if (status == 1)
-            {
-                int opcode = P_CONTROL_V1;
-                if (control_packet_needs_wkc(ks))
-                {
-                    opcode = P_CONTROL_WKC_V1;
-                }
-                reliable_mark_active_outgoing(ks->send_reliable, buf, opcode);
-                INCR_GENERATED;
-                state_change = true;
-                dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
-            }
         }
     }
 
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 1bd336999..215425d41 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -461,7 +461,6 @@ int key_state_write_plaintext_const(struct key_state_ssl *ks_ssl,
  * @param ks_ssl       - The security parameter state for this %key
  *                       session.
  * @param buf          - A buffer in which to store the ciphertext.
- * @param maxlen       - The maximum number of bytes to extract.
  *
  * @return The return value indicates whether the data was successfully
  *     processed:
@@ -470,8 +469,8 @@ int key_state_write_plaintext_const(struct key_state_ssl *ks_ssl,
  *   later to retry.
  * - \c -1: An error occurred.
  */
-int key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf,
-                              int maxlen);
+int key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf);
+
 
 /** @} name Functions for packets to be sent to a remote OpenVPN peer */
 
@@ -517,8 +516,7 @@ int key_state_write_ciphertext(struct key_state_ssl *ks_ssl,
  *   later to retry.
  * - \c -1: An error occurred.
  */
-int key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf,
-                             int maxlen);
+int key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf);
 
 /** @} name Functions for packets received from a remote OpenVPN peer */
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b0785bae9..ea06cf703 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1285,8 +1285,7 @@ key_state_write_plaintext_const(struct key_state_ssl *ks, const uint8_t *data, i
 }
 
 int
-key_state_read_ciphertext(struct key_state_ssl *ks, struct buffer *buf,
-                          int maxlen)
+key_state_read_ciphertext(struct key_state_ssl *ks, struct buffer *buf)
 {
     int retval = 0;
     int len = 0;
@@ -1304,10 +1303,6 @@ key_state_read_ciphertext(struct key_state_ssl *ks, struct buffer *buf,
     }
 
     len = buf_forward_capacity(buf);
-    if (maxlen < len)
-    {
-        len = maxlen;
-    }
 
     retval = endless_buf_read(&ks->bio_ctx->out, BPTR(buf), len);
 
@@ -1388,8 +1383,7 @@ key_state_write_ciphertext(struct key_state_ssl *ks, struct buffer *buf)
 }
 
 int
-key_state_read_plaintext(struct key_state_ssl *ks, struct buffer *buf,
-                         int maxlen)
+key_state_read_plaintext(struct key_state_ssl *ks, struct buffer *buf)
 {
     int retval = 0;
     int len = 0;
@@ -1407,10 +1401,6 @@ key_state_read_plaintext(struct key_state_ssl *ks, struct buffer *buf,
     }
 
     len = buf_forward_capacity(buf);
-    if (maxlen < len)
-    {
-        len = maxlen;
-    }
 
     retval = mbedtls_ssl_read(ks->ctx, BPTR(buf), len);
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c9ea10d49..92bf60862 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1871,7 +1871,7 @@ bio_write_post(const int status, struct buffer *buf)
  * Read from an OpenSSL BIO in non-blocking mode.
  */
 static int
-bio_read(BIO *bio, struct buffer *buf, int maxlen, const char *desc)
+bio_read(BIO *bio, struct buffer *buf, const char *desc)
 {
     int i;
     int ret = 0;
@@ -1882,10 +1882,6 @@ bio_read(BIO *bio, struct buffer *buf, int maxlen, const char *desc)
     else
     {
         int len = buf_forward_capacity(buf);
-        if (maxlen < len)
-        {
-            len = maxlen;
-        }
 
         /*
          * BIO_read brackets most of the serious RSA
@@ -2012,15 +2008,14 @@ key_state_write_plaintext_const(struct key_state_ssl *ks_ssl, const uint8_t *dat
 }
 
 int
-key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf,
-                          int maxlen)
+key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf)
 {
     int ret = 0;
     perf_push(PERF_BIO_READ_CIPHERTEXT);
 
     ASSERT(NULL != ks_ssl);
 
-    ret = bio_read(ks_ssl->ct_out, buf, maxlen, "tls_read_ciphertext");
+    ret = bio_read(ks_ssl->ct_out, buf, "tls_read_ciphertext");
 
     perf_pop();
     return ret;
@@ -2042,15 +2037,14 @@ key_state_write_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf)
 }
 
 int
-key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf,
-                         int maxlen)
+key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf)
 {
     int ret = 0;
     perf_push(PERF_BIO_READ_PLAINTEXT);
 
     ASSERT(NULL != ks_ssl);
 
-    ret = bio_read(ks_ssl->ssl_bio, buf, maxlen, "tls_read_plaintext");
+    ret = bio_read(ks_ssl->ssl_bio, buf, "tls_read_plaintext");
 
     perf_pop();
     return ret;
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 48b94e952..9d87c955c 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -67,8 +67,8 @@
 /*
  * Define number of buffers for send and receive in the reliability layer.
  */
-#define TLS_RELIABLE_N_SEND_BUFFERS  4 /* also window size for reliability layer */
-#define TLS_RELIABLE_N_REC_BUFFERS   8
+#define TLS_RELIABLE_N_SEND_BUFFERS  6 /* also window size for reliability layer */
+#define TLS_RELIABLE_N_REC_BUFFERS   12
 
 /*
  * Used in --mode server mode to check tls-auth signature on initial
-- 
2.32.0 (Apple Git-132)


