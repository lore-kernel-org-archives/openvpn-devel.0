From: Arne Schwabe <arne@...1227...>
Date: Tue, 14 Mar 2023 14:09:31 +0100
Message-Id: <20230314130931.173992-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Fix memory leaks in HMAC initial packet
 id and dco open tun
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

The open_tun_dco_generic already allocates the actual_name string, this
shadows the allocation in the FreeBSD/Linux specific methods.

The HMAC leaks are just forgotten frees/deinitialisations. tls_wrap_control
will sometimes return the original buffer (non tls-crypt) and sometimes
tls_wrap.work, handling this buffer lifetime is a bit more complicated. Instead
of further complicating that code just give our work buffer the same lifetime
as the other one inside tls_wrap.work as that is also more consistent.

Found-By: clang with asan

Patch v2: rebase. Include linux bits accidentially forgotten.
Patch v3: fix also tls-crypt.

Change-Id: I3c344af047abe94c0178bde1781eb450f10d157d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_freebsd.c |  1 -
 src/openvpn/dco_linux.c   |  1 -
 src/openvpn/init.c        |  3 +++
 src/openvpn/ssl.c         | 12 ++++++++++++
 src/openvpn/ssl.h         |  6 ++++++
 src/openvpn/ssl_pkt.c     |  8 ++++++--
 src/openvpn/ssl_pkt.h     |  2 +-
 7 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index ecca2a076..225b3cf88 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -232,7 +232,6 @@ create_interface(struct tuntap *tt, const char *dev)
     }
 
     snprintf(tt->dco.ifname, IFNAMSIZ, "%s", ifr.ifr_data);
-    tt->actual_name = string_alloc(tt->dco.ifname, NULL);
 
     /* see "Interface Flags" in ifnet(9) */
     int i = IFF_POINTOPOINT | IFF_MULTICAST;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b2fdbf53f..e5cea3c71 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -457,7 +457,6 @@ open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
         msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);
     }
 
-    tt->actual_name = string_alloc(dev, NULL);
     tt->dco.dco_message_peer_id = -1;
 
     ovpn_dco_register(&tt->dco);
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
-- 
2.37.1 (Apple Git-137.1)


