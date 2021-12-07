From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:02:10 +0100
Message-Id: <20211207170211.3275837-21-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 20/21] Remove frame->link_mtu
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
 src/openvpn/init.c    | 31 +++----------------------------
 src/openvpn/mtu.c     |  1 -
 src/openvpn/mtu.h     | 16 ----------------
 src/openvpn/ssl.c     |  9 ---------
 7 files changed, 5 insertions(+), 66 deletions(-)

diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index ad49b00b9..2d89e944d 100644
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
index 0d284e274..e42fc144f 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -178,8 +178,6 @@ void comp_uninit(struct compress_context *compctx);
 
 void comp_add_to_extra_frame(struct frame *frame);
 
-void comp_add_to_extra_buffer(struct frame *frame);
-
 void comp_print_stats(const struct compress_context *compctx, struct status_output *so);
 
 void comp_generate_peer_info_string(const struct compress_options *opt, struct buffer *out);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5f8361d3e..b6e9eabbb 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1544,7 +1544,7 @@ process_outgoing_link(struct context *c)
 
     perf_push(PERF_PROC_OUT_LINK);
 
-    if (c->c2.to_link.len > 0 && c->c2.to_link.len <= EXPANDED_SIZE(&c->c2.frame))
+    if (c->c2.to_link.len > 0 && c->c2.to_link.len <= c->c2.frame.buf.payload_size)
     {
         /*
          * Setup for call to send/sendto which will send
@@ -1672,7 +1672,7 @@ process_outgoing_link(struct context *c)
             msg(D_LINK_ERRORS, "TCP/UDP packet too large on write to %s (tried=%d,max=%d)",
                 print_link_socket_actual(c->c2.to_link_addr, &gc),
                 c->c2.to_link.len,
-                EXPANDED_SIZE(&c->c2.frame));
+                c->c2.frame.buf.payload_size);
         }
     }
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a8717c92a..abdf6aaf3 100644
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
@@ -3032,8 +3008,8 @@ do_init_frame_tls(struct context *c)
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
@@ -3125,9 +3101,8 @@ do_init_frame(struct context *c)
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
index 9ca58c1f0..eb823165a 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -211,7 +211,6 @@ frame_print(const struct frame *frame,
     buf_printf(&out, " headroom:%d", frame->buf.headroom);
     buf_printf(&out, " payload:%d", frame->buf.payload_size);
     buf_printf(&out, " tailroom:%d", frame->buf.tailroom);
-    buf_printf(&out, " L:%d", frame->link_mtu);
     buf_printf(&out, " EF:%d", frame->extra_frame);
     buf_printf(&out, " EB:%d", frame->extra_buffer);
     buf_printf(&out, " ET:%d", frame->extra_tun);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index b7c12b968..72cf80917 100644
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
@@ -323,12 +313,6 @@ const char *format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc);
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
index d55ffcdd2..bb1ff04cc 100644
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
 
@@ -1923,9 +1917,6 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
 
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


