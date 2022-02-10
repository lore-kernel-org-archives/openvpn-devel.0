From: Arne Schwabe <arne@...1227...>
Date: Thu, 10 Feb 2022 17:26:31 +0100
Message-Id: <20220210162632.3309974-7-arne@...1227...>
In-Reply-To: <20220210162632.3309974-1-arne@...1227...>
References: <20220210162632.3309974-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 7/8] Remove frame->link_mtu
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
 src/openvpn/comp.c    |  8 --------
 src/openvpn/comp.h    |  2 --
 src/openvpn/forward.c |  4 ++--
 src/openvpn/init.c    | 39 +++------------------------------------
 src/openvpn/mtu.c     | 26 --------------------------
 src/openvpn/mtu.h     | 22 ----------------------
 src/openvpn/ssl.c     |  9 ---------
 7 files changed, 5 insertions(+), 105 deletions(-)

diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 757f503d..7fff869b 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -123,14 +123,6 @@ comp_add_to_extra_frame(struct frame *frame)
     frame_add_to_extra_frame(frame, COMP_PREFIX_LEN);
 }
 
-void
-comp_add_to_extra_buffer(struct frame *frame)
-{
-    /* Leave room for compression buffer to expand in worst case scenario
-     * where data is totally incompressible */
-    frame_add_to_extra_buffer(frame, COMP_EXTRA_BUFFER(EXPANDED_SIZE(frame)));
-}
-
 void
 comp_print_stats(const struct compress_context *compctx, struct status_output *so)
 {
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index f2c9ea8a..964fbce5 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -178,8 +178,6 @@ void comp_uninit(struct compress_context *compctx);
 
 void comp_add_to_extra_frame(struct frame *frame);
 
-void comp_add_to_extra_buffer(struct frame *frame);
-
 void comp_print_stats(const struct compress_context *compctx, struct status_output *so);
 
 void comp_generate_peer_info_string(const struct compress_options *opt, struct buffer *out);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 37554fc9..f508d3b6 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1545,7 +1545,7 @@ process_outgoing_link(struct context *c)
 
     perf_push(PERF_PROC_OUT_LINK);
 
-    if (c->c2.to_link.len > 0 && c->c2.to_link.len <= EXPANDED_SIZE(&c->c2.frame))
+    if (c->c2.to_link.len > 0 && c->c2.to_link.len <= c->c2.frame.buf.payload_size)
     {
         /*
          * Setup for call to send/sendto which will send
@@ -1673,7 +1673,7 @@ process_outgoing_link(struct context *c)
             msg(D_LINK_ERRORS, "TCP/UDP packet too large on write to %s (tried=%d,max=%d)",
                 print_link_socket_actual(c->c2.to_link_addr, &gc),
                 c->c2.to_link.len,
-                EXPANDED_SIZE(&c->c2.frame));
+                c->c2.frame.buf.payload_size);
         }
     }
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 7e22d09b..038fc504 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2140,24 +2140,6 @@ pull_permission_mask(const struct context *c)
     return flags;
 }
 
-static
-void adjust_mtu_peerid(struct context *c)
-{
-    frame_add_to_extra_frame(&c->c2.frame, 3);     /* peer-id overhead */
-    if (!c->options.ce.link_mtu_defined)
-    {
-        frame_add_to_link_mtu(&c->c2.frame, 3);
-        msg(D_PUSH, "OPTIONS IMPORT: adjusting link_mtu to %d",
-            EXPANDED_SIZE(&c->c2.frame));
-    }
-    else
-    {
-        msg(M_WARN, "OPTIONS IMPORT: WARNING: peer-id set, but link-mtu"
-                    " fixed by config - reducing tun-mtu to %d, expect"
-                    " MTU problems", c->c2.frame.tun_mtu);
-    }
-}
-
 static bool
 do_deferred_p2p_ncp(struct context *c)
 {
@@ -2166,11 +2148,6 @@ do_deferred_p2p_ncp(struct context *c)
         return true;
     }
 
-    if (c->c2.tls_multi->use_peer_id)
-    {
-        adjust_mtu_peerid(c);
-    }
-
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
 
     const char *ncp_cipher = get_p2p_ncp_cipher(session, c->c2.tls_multi->peer_info,
@@ -2292,7 +2269,6 @@ do_deferred_options(struct context *c, const unsigned int found)
         msg(D_PUSH, "OPTIONS IMPORT: peer-id set");
         c->c2.tls_multi->use_peer_id = true;
         c->c2.tls_multi->peer_id = c->options.peer_id;
-        adjust_mtu_peerid(c);
     }
 
     /* process (potentially pushed) crypto options */
@@ -2528,14 +2504,6 @@ frame_finalize_options(struct context *c, const struct options *o)
     frame->buf.payload_size = payload_size;
     frame->buf.headroom = headroom;
     frame->buf.tailroom = tailroom;
-
-    /* Kept to still update/calculate the other fields for now */
-    frame_finalize(frame,
-                   o->ce.link_mtu_defined,
-                   o->ce.link_mtu,
-                   o->ce.tun_mtu_defined,
-                   o->ce.tun_mtu);
-
 }
 
 /*
@@ -3043,8 +3011,8 @@ do_init_frame_tls(struct context *c)
     if (c->c2.tls_multi)
     {
         tls_multi_init_finalize(c->c2.tls_multi, &c->c2.frame);
-        ASSERT(EXPANDED_SIZE(&c->c2.tls_multi->opt.frame) <=
-               EXPANDED_SIZE(&c->c2.frame));
+        ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <=
+               c->c2.frame.buf.payload_size);
         frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO,
                     "Control Channel MTU parms");
     }
@@ -3136,9 +3104,8 @@ do_init_frame(struct context *c)
      * Modify frame parameters if compression is compiled in.
      * Should be called after frame_finalize_options.
      */
-    comp_add_to_extra_buffer(&c->c2.frame);
 #ifdef ENABLE_FRAGMENT
-    comp_add_to_extra_buffer(&c->c2.frame_fragment_omit); /* omit compression frame delta from final frame_fragment */
+    /*TODO:frame comp_add_to_extra_buffer(&c->c2.frame_fragment_omit);  omit compression frame delta from final frame_fragment */
 #endif
 #endif /* USE_COMP */
 
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 2c455c3e..c9cd0e38 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -205,31 +205,6 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
     return payload + overhead;
 }
 
-void
-frame_finalize(struct frame *frame,
-               bool link_mtu_defined,
-               int link_mtu,
-               bool tun_mtu_defined,
-               int tun_mtu)
-{
-    /* Set link_mtu based on command line options */
-    if (tun_mtu_defined)
-    {
-        ASSERT(!link_mtu_defined);
-        frame->link_mtu = tun_mtu + TUN_LINK_DELTA(frame);
-    }
-    else
-    {
-        ASSERT(link_mtu_defined);
-        frame->link_mtu = link_mtu;
-    }
-
-    if (frame->tun_mtu < TUN_MTU_MIN)
-    {
-        msg(M_WARN, "TUN MTU value (%d) must be at least %d", frame->tun_mtu, TUN_MTU_MIN);
-        frame_print(frame, M_FATAL, "MTU is too small");
-    }
-}
 /*
  * Move extra_frame octets into extra_tun.  Used by fragmenting code
  * to adjust frame relative to its position in the buffer processing
@@ -262,7 +237,6 @@ frame_print(const struct frame *frame,
     buf_printf(&out, " headroom:%d", frame->buf.headroom);
     buf_printf(&out, " payload:%d", frame->buf.payload_size);
     buf_printf(&out, " tailroom:%d", frame->buf.tailroom);
-    buf_printf(&out, " L:%d", frame->link_mtu);
     buf_printf(&out, " EF:%d", frame->extra_frame);
     buf_printf(&out, " EB:%d", frame->extra_buffer);
     buf_printf(&out, " ET:%d", frame->extra_tun);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 6188c0da..86c0f2ac 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -110,9 +110,6 @@ struct frame {
                                   *  decryption/encryption or compression. */
     } buf;
 
-    int link_mtu;               /**< Maximum packet size to be sent over
-                                 *   the external network interface. */
-
     unsigned int mss_fix;       /**< The actual MSS value that should be
                                  *   written to the payload packets. This
                                  *   is the value for IPv4 TCP packets. For
@@ -189,13 +186,6 @@ struct options;
  */
 #define PAYLOAD_SIZE(f)          ((f)->buf.payload_size)
 
-/*
- * Max size of a payload packet after encryption, compression, etc.
- * overhead is added.
- */
-#define EXPANDED_SIZE(f)         ((f)->link_mtu)
-#define EXPANDED_SIZE_MIN(f)     (TUN_MTU_MIN + TUN_LINK_DELTA(f))
-
 /*
  * Control buffer headroom allocations to allow for efficient prepending.
  */
@@ -218,12 +208,6 @@ struct options;
  * Function prototypes.
  */
 
-void frame_finalize(struct frame *frame,
-                    bool link_mtu_defined,
-                    int link_mtu,
-                    bool tun_mtu_defined,
-                    int tun_mtu);
-
 void frame_subtract_extra(struct frame *frame, const struct frame *src);
 
 void frame_print(const struct frame *frame,
@@ -347,12 +331,6 @@ const char *format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc);
  * frame member adjustment functions
  */
 
-static inline void
-frame_add_to_link_mtu(struct frame *frame, const int increment)
-{
-    frame->link_mtu += increment;
-}
-
 static inline void
 frame_add_to_extra_frame(struct frame *frame, const unsigned int increment)
 {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 38085f77..306c2efd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -320,17 +320,11 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
      * if --tls-auth is enabled.
      */
 
-    /* inherit link MTU and extra_link from data channel */
-    frame->link_mtu = data_channel_frame->link_mtu;
-
     /* set extra_frame */
     tls_adjust_frame_parameters(frame);
     reliable_ack_adjust_frame_parameters(frame, CONTROL_SEND_ACK_MAX);
     frame_add_to_extra_frame(frame, SID_SIZE + sizeof(packet_id_type));
 
-    /* set dynamic link MTU to cap control channel packets at 1250 bytes */
-    ASSERT(TUN_LINK_DELTA(frame) < min_int(frame->link_mtu, 1250));
-
     /* calculate the maximum overhead that control channel frames may have */
     int overhead = 0;
 
@@ -1931,9 +1925,6 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
 
     if (frame_fragment)
     {
-        frame_remove_from_extra_frame(frame_fragment, crypto_max_overhead());
-        crypto_adjust_frame_parameters(frame_fragment, &session->opt->key_type,
-                                       options->replay, packet_id_long_form);
         frame_calculate_dynamic(frame_fragment, &session->opt->key_type, options, lsi);
         frame_print(frame_fragment, D_MTU_INFO, "Fragmentation MTU parms");
     }
-- 
2.33.0


