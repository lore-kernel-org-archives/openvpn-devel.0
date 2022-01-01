From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jan 2022 17:25:32 +0100
Message-Id: <20220101162532.2251835-15-arne@...1227...>
In-Reply-To: <20220101162532.2251835-1-arne@...1227...>
References: <20220101162532.2251835-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 14/14] Remove frame.extra_frame and
 frame.extra_buffer
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/comp.c      |  7 ------
 src/openvpn/comp.h      |  2 --
 src/openvpn/crypto.c    | 37 ---------------------------
 src/openvpn/fragment.c  |  3 ---
 src/openvpn/init.c      | 56 -----------------------------------------
 src/openvpn/mtu.c       | 14 -----------
 src/openvpn/mtu.h       | 42 ++-----------------------------
 src/openvpn/reliable.c  |  7 ------
 src/openvpn/reliable.h  |  3 ---
 src/openvpn/socket.c    | 10 --------
 src/openvpn/socket.h    |  2 --
 src/openvpn/ssl.c       | 21 ----------------
 src/openvpn/ssl.h       |  5 ----
 src/openvpn/tls_crypt.c | 10 --------
 src/openvpn/tls_crypt.h |  5 ----
 15 files changed, 2 insertions(+), 222 deletions(-)

diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 2d89e944..33bf21a7 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -116,13 +116,6 @@ comp_uninit(struct compress_context *compctx)
     }
 }
 
-void
-comp_add_to_extra_frame(struct frame *frame)
-{
-    /* Leave room for our one-byte compressed/didn't-compress prefix byte. */
-    frame_add_to_extra_frame(frame, COMP_PREFIX_LEN);
-}
-
 void
 comp_print_stats(const struct compress_context *compctx, struct status_output *so)
 {
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index e42fc144..d059d6cd 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -176,8 +176,6 @@ struct compress_context *comp_init(const struct compress_options *opt);
 
 void comp_uninit(struct compress_context *compctx);
 
-void comp_add_to_extra_frame(struct frame *frame);
-
 void comp_print_stats(const struct compress_context *compctx, struct status_output *so);
 
 void comp_generate_peer_info_string(const struct compress_options *opt, struct buffer *out);
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 18a6c99c..e68665e8 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -716,43 +716,6 @@ calculate_crypto_overhead(const struct key_type *kt,
     return crypto_overhead;
 }
 
-void
-crypto_adjust_frame_parameters(struct frame *frame,
-                               const struct key_type *kt,
-                               bool packet_id,
-                               bool packet_id_long_form)
-{
-    unsigned int crypto_overhead = 0;
-
-    if (packet_id)
-    {
-        crypto_overhead += packet_id_size(packet_id_long_form);
-    }
-
-    if (cipher_defined(kt->cipher))
-    {
-        crypto_overhead += cipher_kt_iv_size(kt->cipher);
-
-        if (cipher_kt_mode_aead(kt->cipher))
-        {
-            crypto_overhead += cipher_kt_tag_size(kt->cipher);
-        }
-
-        /* extra block required by cipher_ctx_update() */
-        crypto_overhead += cipher_kt_block_size(kt->cipher);
-    }
-
-    if (md_defined(kt->digest))
-    {
-        crypto_overhead += md_kt_size(kt->digest);
-    }
-
-    frame_add_to_extra_frame(frame, crypto_overhead);
-
-    msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %u bytes",
-        __func__, crypto_overhead);
-}
-
 unsigned int
 crypto_max_overhead(void)
 {
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index ce8cd348..eb90dcac 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -96,9 +96,6 @@ fragment_init(struct frame *frame)
      * fragment_master assume an initial CLEAR */
     ALLOC_OBJ_CLEAR(ret, struct fragment_master);
 
-    /* add in the size of our contribution to the expanded frame size */
-    frame_add_to_extra_frame(frame, sizeof(fragment_header_type));
-
     /*
      * Outgoing sequence ID is randomized to reduce
      * the probability of sequence number collisions
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2baa3c4f..0b6247f8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2658,10 +2658,6 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
     /* Get key schedule */
     c->c2.crypto_options.key_ctx_bi = c->c1.ks.static_key;
 
-    /* Compute MTU parameters */
-    crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
-                                   options->replay, true);
-
     /* Sanity check on sequence number, and cipher mode options */
     check_replay_consistency(&c->c1.ks.key_type, options->replay);
 }
@@ -2853,19 +2849,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
     packet_id_long_form = cipher_kt_mode_ofb_cfb(c->c1.ks.key_type.cipher);
 
-    /* Compute MTU parameters (postpone if we push/pull options) */
-    if (c->options.pull || c->options.mode == MODE_SERVER)
-    {
-        /* Account for worst-case crypto overhead before allocating buffers */
-        frame_add_to_extra_frame(&c->c2.frame, crypto_max_overhead());
-    }
-    else
-    {
-        crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
-                                       options->replay, packet_id_long_form);
-    }
-    tls_adjust_frame_parameters(&c->c2.frame);
-
     /* Set all command-line TLS-related options */
     CLEAR(to);
 
@@ -3018,8 +3001,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
         to.tls_wrap.opt.pid_persist = &c->c1.pid_persist;
         to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
-        crypto_adjust_frame_parameters(&to.frame, &c->c1.ks.tls_auth_key_type,
-                                       true, true);
     }
 
     /* TLS handshake encryption (--tls-crypt) */
@@ -3030,7 +3011,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
         to.tls_wrap.opt.pid_persist = &c->c1.pid_persist;
         to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
-        tls_crypt_adjust_frame_parameters(&to.frame);
 
         if (options->ce.tls_crypt_v2_file)
         {
@@ -3048,10 +3028,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         }
     }
 
-    /* If we are running over TCP, allow for
-     * length prefix */
-    socket_adjust_frame_parameters(&to.frame, options->ce.proto);
-
     /*
      * Initialize OpenVPN's master TLS-mode object.
      */
@@ -3125,20 +3101,6 @@ do_init_crypto(struct context *c, const unsigned int flags)
 static void
 do_init_frame(struct context *c)
 {
-#ifdef USE_COMP
-    /*
-     * modify frame parameters if compression is enabled
-     */
-    if (comp_enabled(&c->options.comp))
-    {
-        comp_add_to_extra_frame(&c->c2.frame);
-
-#ifdef ENABLE_FRAGMENT
-        comp_add_to_extra_frame(&c->c2.frame_fragment_omit); /* omit compression frame delta from final frame_fragment */
-#endif
-    }
-#endif /* USE_COMP */
-
     /*
      * Adjust frame size based on the --tun-mtu-extra parameter.
      */
@@ -3147,29 +3109,12 @@ do_init_frame(struct context *c)
         frame_add_to_extra_tun(&c->c2.frame, c->options.ce.tun_mtu_extra);
     }
 
-    /*
-     * Adjust frame size based on link socket parameters.
-     * (Since TCP is a stream protocol, we need to insert
-     * a packet length uint16_t in the buffer.)
-     */
-    socket_adjust_frame_parameters(&c->c2.frame, c->options.ce.proto);
-
     /*
      * Fill in the blanks in the frame parameters structure,
      * make sure values are rational, etc.
      */
     frame_finalize_options(c, NULL);
 
-#ifdef USE_COMP
-    /*
-     * Modify frame parameters if compression is compiled in.
-     * Should be called after frame_finalize_options.
-     */
-#ifdef ENABLE_FRAGMENT
-    /*TODO:frame comp_add_to_extra_buffer(&c->c2.frame_fragment_omit);  omit compression frame delta from final frame_fragment */
-#endif
-#endif /* USE_COMP */
-
 #ifdef ENABLE_FRAGMENT
     /*
      * Set frame parameter for fragment code.  This is necessary because
@@ -3177,7 +3122,6 @@ do_init_frame(struct context *c)
      * passed through the compression code.
      */
     c->c2.frame_fragment = c->c2.frame;
-    frame_subtract_extra(&c->c2.frame_fragment, &c->c2.frame_fragment_omit);
     c->c2.frame_fragment_initial = c->c2.frame_fragment;
 #endif
 
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 986cae47..aa2c425c 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -205,18 +205,6 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
     return payload + overhead;
 }
 
-/*
- * Move extra_frame octets into extra_tun.  Used by fragmenting code
- * to adjust frame relative to its position in the buffer processing
- * queue.
- */
-void
-frame_subtract_extra(struct frame *frame, const struct frame *src)
-{
-    frame->extra_frame -= src->extra_frame;
-    frame->extra_tun   += src->extra_frame;
-}
-
 void
 frame_print(const struct frame *frame,
             int level,
@@ -237,8 +225,6 @@ frame_print(const struct frame *frame,
     buf_printf(&out, " headroom:%d", frame->buf.headroom);
     buf_printf(&out, " payload:%d", frame->buf.payload_size);
     buf_printf(&out, " tailroom:%d", frame->buf.tailroom);
-    buf_printf(&out, " EF:%d", frame->extra_frame);
-    buf_printf(&out, " EB:%d", frame->extra_buffer);
     buf_printf(&out, " ET:%d", frame->extra_tun);
     buf_printf(&out, " ]");
 
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 3e4dfb6d..a6d112eb 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -123,13 +123,6 @@ struct frame {
                                  * size that can be send in a single fragment
                                  */
 
-    int extra_frame;            /**< Maximum number of bytes that all
-                                 *   processing steps together could add.
-                                 *   @code
-                                 *   frame.link_mtu = "socket MTU" - extra_frame;
-                                 *   @endcode
-                                 */
-
     int tun_mtu;                /**< the (user) configured tun-mtu. This is used
                                  *   in configuring the tun interface or
                                  *   in calculations that use the desired size
@@ -141,16 +134,6 @@ struct frame {
                                  *   code ignores it)
                                  */
 
-    int extra_buffer;           /**< Maximum number of bytes that
-                                 *   processing steps could expand the
-                                 *   internal work buffer.
-                                 *
-                                 *   This is used by the \link compression
-                                 *   Data Channel Compression
-                                 *   module\endlink to give enough working
-                                 *   space for worst-case expansion of
-                                 *   incompressible content. */
-
     int extra_tun;              /**< Maximum number of bytes in excess of
                                  *   the tun/tap MTU that might be read
                                  *   from or written to the virtual
@@ -196,9 +179,8 @@ struct options;
  *
  * Most of our code only prepends headers but compression needs the extra bytes
  * *after* the data as compressed data might end up larger than the original
- * data (and max compression overhead is part of extra_buffer). Also crypto
- * needs an extra block for encryption. Therefore tailroom is larger than the
- * headroom.
+ * data. Also crypto needs an extra block for encryption. Therefore tailroom is
+ * larger than the headroom.
  */
 #define BUF_SIZE(f) ((f)->buf.headroom + (f)->buf.payload_size + (f)->buf.tailroom)
 
@@ -208,8 +190,6 @@ struct options;
  * Function prototypes.
  */
 
-void frame_subtract_extra(struct frame *frame, const struct frame *src);
-
 void frame_print(const struct frame *frame,
                  int level,
                  const char *prefix);
@@ -331,30 +311,12 @@ const char *format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc);
  * frame member adjustment functions
  */
 
-static inline void
-frame_add_to_extra_frame(struct frame *frame, const unsigned int increment)
-{
-    frame->extra_frame += increment;
-}
-
-static inline void
-frame_remove_from_extra_frame(struct frame *frame, const unsigned int decrement)
-{
-    frame->extra_frame -= decrement;
-}
-
 static inline void
 frame_add_to_extra_tun(struct frame *frame, const int increment)
 {
     frame->extra_tun += increment;
 }
 
-static inline void
-frame_add_to_extra_buffer(struct frame *frame, const int increment)
-{
-    frame->extra_buffer += increment;
-}
-
 static inline bool
 frame_defined(const struct frame *frame)
 {
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 08c9ab19..6f997101 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -253,13 +253,6 @@ error:
     return false;
 }
 
-/* add to extra_frame the maximum number of bytes we will need for reliable_ack_write */
-void
-reliable_ack_adjust_frame_parameters(struct frame *frame, int max)
-{
-    frame_add_to_extra_frame(frame, ACK_SIZE(max));
-}
-
 /* print a reliable ACK record coming off the wire */
 const char *
 reliable_ack_print(struct buffer *buf, bool verbose, struct gc_arena *gc)
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 693abb3c..cbd9cc8f 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -207,9 +207,6 @@ void reliable_init(struct reliable *rel, int buf_size, int offset, int array_siz
  */
 void reliable_free(struct reliable *rel);
 
-/* add to extra_frame the maximum number of bytes we will need for reliable_ack_write */
-void reliable_ack_adjust_frame_parameters(struct frame *frame, int max);
-
 /** @} name Functions for initialization and cleanup */
 
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index fe1dfb31..93b857f0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2285,16 +2285,6 @@ link_socket_close(struct link_socket *sock)
     }
 }
 
-/* for stream protocols, allow for packet length prefix */
-void
-socket_adjust_frame_parameters(struct frame *frame, int proto)
-{
-    if (link_socket_proto_connection_oriented(proto))
-    {
-        frame_add_to_extra_frame(frame, sizeof(packet_size_type));
-    }
-}
-
 void
 setenv_trusted(struct env_set *es, const struct link_socket_info *info)
 {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index a43ed80b..2ad0e1b3 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -298,8 +298,6 @@ void link_socket_init_phase2(struct context *c);
 
 void do_preresolve(struct context *c);
 
-void socket_adjust_frame_parameters(struct frame *frame, int proto);
-
 void link_socket_close(struct link_socket *sock);
 
 void sd_close(socket_descriptor_t *sd);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5b6db4e5..4cdeb295 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -295,18 +295,6 @@ tls_limit_reneg_bytes(const char *ciphername, int *reneg_bytes)
     }
 }
 
-/*
- * Max number of bytes we will add
- * for data structures common to both
- * data and control channel packets.
- * (opcode only).
- */
-void
-tls_adjust_frame_parameters(struct frame *frame)
-{
-    frame_add_to_extra_frame(frame, 1); /* space for opcode */
-}
-
 /*
  * Max number of bytes we will add
  * to control channel packet.
@@ -320,11 +308,6 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
      * if --tls-auth is enabled.
      */
 
-    /* set extra_frame */
-    tls_adjust_frame_parameters(frame);
-    reliable_ack_adjust_frame_parameters(frame, CONTROL_SEND_ACK_MAX);
-    frame_add_to_extra_frame(frame, SID_SIZE + sizeof(packet_id_type));
-
     /* calculate the maximum overhead that control channel frames may have */
     int overhead = 0;
 
@@ -1900,10 +1883,6 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
         session->opt->crypto_flags |= CO_PACKET_ID_LONG_FORM;
     }
 
-    /* Update frame parameters: undo worst-case overhead, add actual overhead */
-    frame_remove_from_extra_frame(frame, crypto_max_overhead());
-    crypto_adjust_frame_parameters(frame, &session->opt->key_type,
-                                   options->replay, packet_id_long_form);
     frame_calculate_dynamic(frame, &session->opt->key_type, options, lsi);
 
     frame_print(frame, D_MTU_INFO, "Data Channel MTU parms");
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index e566acd8..5e1c7a2a 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -471,11 +471,6 @@ void ssl_put_auth_challenge(const char *cr_str);
 
 #endif
 
-/*
- * Reserve any extra space required on frames.
- */
-void tls_adjust_frame_parameters(struct frame *frame);
-
 /*
  * Send a payload over the TLS control channel
  */
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index d940ec30..610168b0 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -89,16 +89,6 @@ tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
                             "Control Channel Encryption", "tls-crypt");
 }
 
-void
-tls_crypt_adjust_frame_parameters(struct frame *frame)
-{
-    frame_add_to_extra_frame(frame, tls_crypt_buf_overhead());
-
-    msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for tls-crypt by %i bytes",
-        __func__, tls_crypt_buf_overhead());
-}
-
-
 bool
 tls_crypt_wrap(const struct buffer *src, struct buffer *dst,
                struct crypto_options *opt)
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 81d0a10e..928ff547 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -123,11 +123,6 @@ void tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
  */
 int tls_crypt_buf_overhead(void);
 
-/**
- * Adjust frame parameters for --tls-crypt overhead.
- */
-void tls_crypt_adjust_frame_parameters(struct frame *frame);
-
 /**
  * Wrap a control channel packet (both authenticates and encrypts the data).
  *
-- 
2.33.0


