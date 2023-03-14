From: Arne Schwabe <arne@...1227...>
Date: Tue, 14 Mar 2023 15:48:53 +0100
Message-Id: <20230314144854.182110-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Fix memory leaks in HMAC initial packet
 id
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

The HMAC leaks are just forgotten frees/deinitialisations. tls_wrap_control
will sometimes return the original buffer (non tls-crypt) and sometimes
tls_wrap.work, handling this buffer lifetime is a bit more complicated. Instead
of further complicating that code just give our work buffer the same lifetime
as the other one inside tls_wrap.work as that is also more consistent.

Also packet_id_init will allocated a buffer with malloc and not using a
gc_arena, so we need to manually also free it.

Found-By: clang with asan
Change-Id: I0cff44f79ee7e3bcf7b5981fc94f469c15f21af3
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c                  |  3 +++
 src/openvpn/ssl.c                   | 12 ++++++++++++
 src/openvpn/ssl.h                   |  6 ++++++
 src/openvpn/ssl_pkt.c               |  8 ++++++--
 src/openvpn/ssl_pkt.h               |  2 +-
 tests/unit_tests/openvpn/test_pkt.c |  2 ++
 6 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 124ac76bd..fa2681dc7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3483,6 +3483,7 @@ do_init_frame_tls(struct context *c)
         frame_print(&c->c2.tls_auth_standalone->frame, D_MTU_INFO,
                     "TLS-Auth MTU parms");
         c->c2.tls_auth_standalone->tls_wrap.work = alloc_buf_gc(BUF_SIZE(&c->c2.frame), &c->c2.gc);
+        c->c2.tls_auth_standalone->workbuf = alloc_buf_gc(BUF_SIZE(&c->c2.frame), &c->c2.gc);
     }
 }
 
@@ -3881,6 +3882,8 @@ do_close_tls(struct context *c)
         md_ctx_cleanup(c->c2.pulled_options_state);
         md_ctx_free(c->c2.pulled_options_state);
     }
+
+    tls_auth_standalone_free(c->c2.tls_auth_standalone);
 }
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 78cec90a1..f2331f712 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1358,9 +1358,21 @@ tls_auth_standalone_init(struct tls_options *tls_options,
     packet_id_init(&tas->tls_wrap.opt.packet_id, tls_options->replay_window,
                    tls_options->replay_time, "TAS", 0);
 
+    tas->workbuf = alloc_buf_gc(tas->frame.buf.payload_size, gc);
     return tas;
 }
 
+void
+tls_auth_standalone_free(struct tls_auth_standalone *tas)
+{
+    if (!tas)
+    {
+        return;
+    }
+
+    packet_id_free(&tas->tls_wrap.opt.packet_id);
+}
+
 /*
  * Set local and remote option compatibility strings.
  * Used to verify compatibility of local and remote option
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 58ff4b9b4..a050cd5c9 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -180,6 +180,12 @@ void tls_multi_init_finalize(struct tls_multi *multi, int tls_mtu);
 struct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_options,
                                                      struct gc_arena *gc);
 
+/**
+ * Frees a standalone tls-auth verification object.
+ * @param tas   the object to free. May be NULL.
+ */
+void tls_auth_standalone_free(struct tls_auth_standalone *tas);
+
 /*
  * Setups the control channel frame size parameters from the data channel
  * parameters
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 17a7f8917..8b3391e76 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -434,7 +434,10 @@ tls_reset_standalone(struct tls_wrap_ctx *ctx,
                      uint8_t header,
                      bool request_resend_wkc)
 {
-    struct buffer buf = alloc_buf(tas->frame.buf.payload_size);
+    /* Copy buffer here to point at the same data but allow tls_wrap_control
+     * to potentially change buf to point to another buffer without
+     * modifying the buffer in tas */
+    struct buffer buf = tas->workbuf;
     ASSERT(buf_init(&buf, tas->frame.buf.headroom));
 
     /* Reliable ACK structure */
@@ -461,7 +464,8 @@ tls_reset_standalone(struct tls_wrap_ctx *ctx,
         buf_write_u16(&buf, EARLY_NEG_FLAG_RESEND_WKC);
     }
 
-    /* Add tls-auth/tls-crypt wrapping, this might replace buf */
+    /* Add tls-auth/tls-crypt wrapping, this might replace buf with
+     * ctx->work */
     tls_wrap_control(ctx, header, &buf, own_sid);
 
     return buf;
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index ec7b48daf..ef4852e5d 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -77,6 +77,7 @@
 struct tls_auth_standalone
 {
     struct tls_wrap_ctx tls_wrap;
+    struct buffer workbuf;
     struct frame frame;
 };
 
@@ -220,7 +221,6 @@ read_control_auth(struct buffer *buf,
  * This function creates a reset packet using the information
  * from the tls pre decrypt state.
  *
- * The returned buf needs to be free with \c free_buf
  */
 struct buffer
 tls_reset_standalone(struct tls_wrap_ctx *ctx,
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index f11e52a11..8574afc6a 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -563,6 +563,7 @@ test_generate_reset_packet_plain(void **ut_state)
     tas.tls_wrap.mode = TLS_WRAP_NONE;
     struct frame frame = { {.headroom = 200, .payload_size = 1400}, 0};
     tas.frame = frame;
+    tas.workbuf = alloc_buf(1600);
 
     uint8_t header = 0 | (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT);
 
@@ -580,6 +581,7 @@ test_generate_reset_packet_plain(void **ut_state)
     free_buf(&buf2);
 
     free_tls_pre_decrypt_state(&state);
+    free_buf(&tas.workbuf);
     free_buf(&buf);
 }
 
-- 
2.37.1 (Apple Git-137.1)


