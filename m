From: Arne Schwabe <arne@...1227...>
Date: Fri, 24 Jun 2022 13:13:18 +0200
Message-Id: <20220624111318.3219982-4-arne@...1227...>
In-Reply-To: <20220624111318.3219982-1-arne@...1227...>
References: <20220624111318.3219982-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 4/4] Allow tun-mtu to be pushed
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

This allows tun-mtu to pushed but only up to the size of the preallocated
buffers. This is not a perfect solution but should allow most of the use
cases where the mtu is close enough to 1500.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                              |  8 ++++
 doc/man-sections/client-options.rst      |  4 ++
 doc/man-sections/vpn-network-options.rst |  5 +++
 src/openvpn/init.c                       | 50 ++++++++++++++++++++----
 src/openvpn/mtu.c                        |  1 +
 src/openvpn/mtu.h                        |  3 ++
 src/openvpn/options.c                    | 15 ++++++-
 src/openvpn/options.h                    |  2 +
 src/openvpn/ssl.c                        |  3 ++
 9 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 98d6df60d..616a977ed 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -79,6 +79,14 @@ Cookie based handshake for UDP server
     shake. The tls-crypt-v2 option allows controlling if older clients are
     accepted.
 
+
+Tun MTU can be pushed
+    As part of changing the ``--tun-mtu`` default to 1420 (see below), the
+    client can now also dynamically configure its MTU and the server will
+    try to push the client MTU when the client supports it. The directive
+    ``--tun-mtu-max`` has been introduced to specify the maximum pushable
+    MTU size.
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 8e0e4f18a..940175eaf 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -358,6 +358,10 @@ configuration.
         The client announces the list of supported ciphers configured with the
         ``--data-ciphers`` option to the server.
 
+  :code:`IV_MTU=<max_mtu>`
+        The client announces the support of pushable MTU and the maximum MTU
+        it is willing to accept.
+
   :code:`IV_GUI_VER=<gui_id> <version>`
         The UI version of a UI if one is running, for example
         :code:`de.blinkt.openvpn 0.5.47` for the Android app.
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 26b37dc36..1dda4912d 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -542,6 +542,11 @@ routing.
   packets larger than ``tun-mtu`` (e.g. Linux and FreeBSD) but other platforms
   (like macOS) limit received packets to the same size as the MTU.
 
+--tun-max-mtu maxmtu
+  This configures the maximum MTU size that a server can push to ``maxmtu``.
+  The default for ``maxmtu`` is 1600. This will increase internal buffers
+  allocation for larger packet sizes.
+
 --tun-mtu-extra n
   Assume that the TUN/TAP device might return as many as ``n`` bytes more
   than the ``--tun-mtu`` size on read. This parameter defaults to 0, which
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 638fd10c8..246dbae9e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2126,7 +2126,8 @@ pull_permission_mask(const struct context *c)
         | OPT_P_ECHO
         | OPT_P_PULL_MODE
         | OPT_P_PEER_ID
-        | OPT_P_NCP;
+        | OPT_P_NCP
+        | OPT_P_PUSH_MTU;
 
     if (!c->options.route_nopull)
     {
@@ -2285,6 +2286,31 @@ do_deferred_options(struct context *c, const unsigned int found)
 #endif
 
         struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+        if (!update_session_cipher(session, &c->options))
+        {
+            /* The update_session_cipher method will already print an error */
+            return false;
+        }
+
+        /* Cipher is considered safe, so we can use it to calculate the max
+         * MTU size */
+        if (found & OPT_P_PUSH_MTU)
+        {
+            /* MTU has changed, check that the pushed MTU is small enough to
+             * be able to change it */
+            msg(D_PUSH, "OPTIONS IMPORT: tun-mtu set to %d", c->options.ce.tun_mtu);
+
+            struct frame *frame = &c->c2.frame;
+
+            if (c->options.ce.tun_mtu > frame->tun_max_mtu)
+            {
+                msg(D_PUSH_ERRORS, "Server pushed a large mtu, please add "
+                    "tun-mtu-max %d in the client configuration",
+                    c->options.ce.tun_mtu);
+            }
+            frame->tun_mtu = min_int(frame->tun_max_mtu, c->options.ce.tun_mtu);
+        }
+
         if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
                                               frame_fragment, get_link_socket_info(c)))
         {
@@ -2448,10 +2474,16 @@ frame_finalize_options(struct context *c, const struct options *o)
     struct frame *frame = &c->c2.frame;
 
     frame->tun_mtu = get_frame_mtu(c, o);
+    frame->tun_max_mtu = o->ce.tun_mtu_max;
 
-    /* We always allow at least 1500 MTU packets to be received in our buffer
-     * space */
-    size_t payload_size = max_int(1500, frame->tun_mtu);
+    /* max mtu needs to be at least as large as the tun mtu */
+    frame->tun_max_mtu = max_int(frame->tun_mtu, frame->tun_max_mtu);
+
+    /* We always allow at least 1600 MTU packets to be received in our buffer
+     * space to allow server to push "baby giant" MTU sizes */
+    frame->tun_max_mtu = max_int(1600, frame->tun_max_mtu);
+
+    size_t payload_size = frame->tun_max_mtu;
 
     /* The extra tun needs to be added to the payload size */
     if (o->ce.tun_mtu_defined)
@@ -2459,9 +2491,9 @@ frame_finalize_options(struct context *c, const struct options *o)
         payload_size += o->ce.tun_mtu_extra;
     }
 
-    /* Add 100 byte of extra space in the buffer to account for slightly
-     * mismatched MUTs between peers */
-    payload_size += 100;
+    /* Add 32 byte of extra space in the buffer to account for small errors
+     * in the calculation */
+    payload_size += 32;
 
 
     /* the space that is reserved before the payload to add extra headers to it
@@ -2994,6 +3026,10 @@ do_init_frame_tls(struct context *c)
                c->c2.frame.buf.payload_size);
         frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO,
                     "Control Channel MTU parms");
+
+        /* Keep the max mtu also in the frame of tls multi so it can access
+         * it in push_peer_info */
+        c->c2.tls_multi->opt.frame.tun_max_mtu = c->c2.frame.tun_max_mtu;
     }
     if (c->c2.tls_auth_standalone)
     {
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 0cad9b1c9..e4d4a9cd5 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -244,6 +244,7 @@ frame_print(const struct frame *frame,
     buf_printf(&out, " max_frag:%d", frame->max_fragment_size);
 #endif
     buf_printf(&out, " tun_mtu:%d", frame->tun_mtu);
+    buf_printf(&out, " tun_max_mtu:%d", frame->tun_max_mtu);
     buf_printf(&out, " headroom:%d", frame->buf.headroom);
     buf_printf(&out, " payload:%d", frame->buf.payload_size);
     buf_printf(&out, " tailroom:%d", frame->buf.tailroom);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index d643027d3..e80d8bd01 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -137,6 +137,9 @@ struct frame {
                                  *   control frame payload (although most of
                                  *   code ignores it)
                                  */
+    int tun_max_mtu;            /**< the maximum tun-mtu size the buffers are
+                                 *   are sized for. This is the upper bound that
+                                 *   a server can push as MTU */
 
     int extra_tun;              /**< Maximum number of bytes in excess of
                                  *   the tun/tap MTU that might be read
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b30c05eba..d87c6595c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6283,7 +6283,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);
         options->ce.tun_mtu = positive_atoi(p[1]);
         options->ce.tun_mtu_defined = true;
         if (p[2])
@@ -6295,6 +6295,19 @@ add_option(struct options *options,
             options->ce.occ_mtu = 0;
         }
     }
+    else if (streq(p[0], "tun-mtu-max") && p[1] && !p[3])
+    {
+        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        int max_mtu = positive_atoi(p[1]);
+        if (max_mtu < 68 || max_mtu > 65536)
+        {
+            msg(msglevel, "--tun-mtu-max value '%s' is invalid", p[1]);
+        }
+        else
+        {
+            options->ce.tun_mtu_max = max_mtu;
+        }
+    }
     else if (streq(p[0], "tun-mtu-extra") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 1085a462a..5a1720ca9 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -119,6 +119,7 @@ struct connection_entry
 
     int tun_mtu;         /* MTU of tun device */
     int occ_mtu;         /* if non-null, this is the MTU we announce to peers in OCC */
+    int tun_mtu_max;     /* maximum MTU that can be pushed */
     bool tun_mtu_defined; /* true if user overriding parm with command line option */
     int tun_mtu_extra;
     bool tun_mtu_extra_defined;
@@ -720,6 +721,7 @@ struct options
 #define OPT_P_CONNECTION      (1<<27)
 #define OPT_P_PEER_ID         (1<<28)
 #define OPT_P_INLINE          (1<<29)
+#define OPT_P_PUSH_MTU        (1<<30)
 
 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ddd90080b..a6071e3c1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1939,6 +1939,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         {
             iv_proto |= IV_PROTO_REQUEST_PUSH;
             iv_proto |= IV_PROTO_AUTH_PENDING_KW;
+
+            /* support for tun-mtu as part of the push message */
+            buf_printf(&out, "IV_MTU=%d\n", session->opt->frame.tun_max_mtu);
         }
 
         /* support for Negotiable Crypto Parameters */
-- 
2.32.1 (Apple Git-133)


