From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:51 +0200
Message-Id: <20220422142953.3805364-17-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 26/28] Allow setting control channel packet
 size with tls-mtu
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

Currently control packet size is controlled by tun-mtu in a very
non-obvious way since the control overhead is not taken into account
and control channel packet will end up with a different size than
data channel packet.

Instead we decouple this and introduce tls-mtu which defaults to
1250.
---
 Changes.rst                       |  8 ++++++++
 doc/man-sections/link-options.rst |  7 +++++++
 src/openvpn/init.c                |  8 ++++++--
 src/openvpn/mtu.h                 |  5 +++++
 src/openvpn/options.c             | 14 ++++++++++++++
 src/openvpn/options.h             |  1 +
 src/openvpn/ssl.c                 | 25 +++++++++++++------------
 src/openvpn/ssl.h                 |  8 +++-----
 8 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index a7e8b4b81..3d9ebf188 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -77,6 +77,12 @@ Cookie based handshake for UDP server
     requires OpenVPN 2.6 clients or later and the tls-crypt-v2 option allows
     controlling if older clients are accepted.
 
+Improved control channel packet size control (``--tls-mtu``)
+    The size of control channel is no longer tied to
+    ``--link-mtu``/``--tun-mtu`` and can be set using ``--tls-mtu``. Setting
+    the size to small sizes no longer breaks the OpenVPN protocol in certain
+    situation.
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
@@ -139,6 +145,8 @@ User-visible Changes
 - Option ``--nobind`` is default when ``--client`` or ``--pull`` is used in the configuration
 - :code:`link_mtu` parameter is removed from environment or replaced with 0 when scripts are
   called with parameters. This parameter is unreliable and no longer internally calculated.
+- control channel packet maximum size is no longer influenced by ``--link-mtu``/``--tun-mtu``
+  and must be set by ``--tls-mtu`` now.
 
 Overview of changes in 2.5
 ==========================
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 6473ad423..b084fe082 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -454,3 +454,10 @@ the local and the remote host.
      if mode server:
          socket-flags TCP_NODELAY
          push "socket-flags TCP_NODELAY"
+
+--tls-mtu size
+  This option sets the maximum size for control channel packets. OpenVPN will
+  try to keep its control channel messages below this size but due to some
+  constraints in the protocol this is not always possible. If the option is
+  not set, it default to 1250. Valid sizes are between 512 and 2048.
+  The maximum packet size includes encapsalution overhead like UDP and IP.
\ No newline at end of file
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a88f7d80d..bbd1783c3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2452,6 +2452,10 @@ frame_finalize_options(struct context *c, const struct options *o)
      * space */
     size_t payload_size = max_int(1500, frame->tun_mtu);
 
+    /* we need to be also large enough to hold larger control channel packets
+     * if configured */
+    payload_size = max_int(payload_size, o->ce.tls_mtu);
+
     /* The extra tun needs to be added to the payload size */
     if (o->ce.tun_mtu_defined)
     {
@@ -2993,7 +2997,7 @@ do_init_frame_tls(struct context *c)
 {
     if (c->c2.tls_multi)
     {
-        tls_multi_init_finalize(c->c2.tls_multi, &c->c2.frame);
+        tls_multi_init_finalize(c->c2.tls_multi, c->options.ce.tls_mtu);
         ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <=
                c->c2.frame.buf.payload_size);
         frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO,
@@ -3001,7 +3005,7 @@ do_init_frame_tls(struct context *c)
     }
     if (c->c2.tls_auth_standalone)
     {
-        tls_init_control_channel_frame_parameters(&c->c2.frame, &c->c2.tls_auth_standalone->frame);
+        tls_init_control_channel_frame_parameters(&c->c2.tls_auth_standalone->frame, c->options.ce.tls_mtu);
         frame_print(&c->c2.tls_auth_standalone->frame, D_MTU_INFO,
                     "TLS-Auth MTU parms");
         c->c2.tls_auth_standalone->tls_wrap.work = alloc_buf_gc(BUF_SIZE(&c->c2.frame), &c->c2.gc);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 7f967e066..86959bd53 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -79,6 +79,11 @@
  */
 #define MSSFIX_DEFAULT     1492
 
+/*
+ * Default maximum size of control channel packets
+ */
+#define TLS_MTU_DEFAULT    1250
+
 /*
  * Alignment of payload data such as IP packet or
  * ethernet frame.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9ff384d09..d156e0ed1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -815,6 +815,7 @@ init_options(struct options *o, const bool init_gc)
     o->ce.bind_local = true;
     o->ce.tun_mtu = TUN_MTU_DEFAULT;
     o->ce.link_mtu = LINK_MTU_DEFAULT;
+    o->ce.tls_mtu = TLS_MTU_DEFAULT;
     o->ce.mtu_discover_type = -1;
     o->ce.mssfix = 0;
     o->ce.mssfix_default = true;
@@ -1582,6 +1583,7 @@ show_connection_entry(const struct connection_entry *o)
     SHOW_BOOL(link_mtu_defined);
     SHOW_INT(tun_mtu_extra);
     SHOW_BOOL(tun_mtu_extra_defined);
+    SHOW_INT(tls_mtu);
 
     SHOW_INT(mtu_discover_type);
 
@@ -6281,6 +6283,18 @@ add_option(struct options *options,
         options->ce.tun_mtu_extra = positive_atoi(p[1]);
         options->ce.tun_mtu_extra_defined = true;
     }
+    else if (streq(p[0], "tls-mtu") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        int tls_mtu = atoi(p[1]);
+        if (tls_mtu < 512 || tls_mtu > TLS_CHANNEL_BUF_SIZE)
+        {
+            msg(msglevel, "Bad tls-mtu value, must be between %d and %d",
+                512, TLS_CHANNEL_BUF_SIZE);
+            goto err;
+        }
+        options->ce.tls_mtu = positive_atoi(p[1]);
+    }
 #ifdef ENABLE_FRAGMENT
     else if (streq(p[0], "mtu-dynamic"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c2937dc37..6615d1c74 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -123,6 +123,7 @@ struct connection_entry
     bool tun_mtu_extra_defined;
     int link_mtu;        /* MTU of device over which tunnel packets pass via TCP/UDP */
     bool link_mtu_defined; /* true if user overriding parm with command line option */
+    int tls_mtu;         /* Maximum MTU for the control channel messages */
 
     /* Advanced MTU negotiation and datagram fragmentation options */
     int mtu_discover_type; /* used if OS supports setting Path MTU discovery options on socket */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3b81f9707..94ac6fc3c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -296,8 +296,7 @@ tls_limit_reneg_bytes(const char *ciphername, int *reneg_bytes)
 }
 
 void
-tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame,
-                                          struct frame *frame)
+tls_init_control_channel_frame_parameters(struct frame *frame, int tls_mtu)
 {
     /*
      * frame->extra_frame is already initialized with tls_auth buffer requirements,
@@ -322,18 +321,20 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
 
     /* Previous OpenVPN version calculated the maximum size and buffer of a
      * control frame depending on the overhead of the data channel frame
-     * overhead and limited its maximum size to 1250. We always allocate the
-     * TLS_CHANNEL_BUF_SIZE buffer size since a lot of code blindly assumes
-     * a large buffer (e.g. PUSH_BUNDLE_SIZE) and also our peer might have
-     * a higher size configure and we still want to be able to receive the
-     * packets. frame->mtu_mtu is set as suggestion for the maximum packet
-     * size */
-    frame->buf.payload_size = TLS_CHANNEL_BUF_SIZE + overhead;
+     * overhead and limited its maximum size to 1250. Since control frame
+     * frames also need to fit into data channel buffer we have the same
+     * default of 1500 + 100 as data channel buffers have. Increasing
+     * tls-mtu beyond this limit also the data channel buffers */
+    frame->buf.payload_size = max_int(1500, tls_mtu) + 100;
 
     frame->buf.headroom = overhead;
     frame->buf.tailroom = overhead;
 
-    frame->tun_mtu = min_int(data_channel_frame->tun_mtu, 1250);
+    frame->tun_mtu = tls_mtu;
+
+    /* Ensure the tun-mtu stays in a valid range */
+    frame->tun_mtu = min_int(frame->tun_mtu, TLS_CHANNEL_BUF_SIZE);
+    frame->tun_mtu = max_int(frame->tun_mtu, 512);
 }
 
 /**
@@ -1300,9 +1301,9 @@ tls_multi_init(struct tls_options *tls_options)
 }
 
 void
-tls_multi_init_finalize(struct tls_multi *multi, const struct frame *frame)
+tls_multi_init_finalize(struct tls_multi *multi, int tls_mtu)
 {
-    tls_init_control_channel_frame_parameters(frame, &multi->opt.frame);
+    tls_init_control_channel_frame_parameters(&multi->opt.frame, tls_mtu);
     /* initialize the active and untrusted sessions */
 
     tls_session_init(multi, &multi->session[TM_ACTIVE]);
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index fbc781c70..061c69a82 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -156,10 +156,9 @@ struct tls_multi *tls_multi_init(struct tls_options *tls_options);
  *
  * @param multi        - The \c tls_multi structure of which to finalize
  *                       initialization.
- * @param frame        - The data channel's \c frame structure.
+ * @param tls_mtu      - maximum allowed size for control channel packets
  */
-void tls_multi_init_finalize(struct tls_multi *multi,
-                             const struct frame *frame);
+void tls_multi_init_finalize(struct tls_multi *multi, int tls_mtu);
 
 /*
  * Initialize a standalone tls-auth verification object.
@@ -171,8 +170,7 @@ struct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_opt
  * Setups up the control channel frame size parameters from the data channel
  * parameters
  */
-void tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame,
-                                               struct frame *frame);
+void tls_init_control_channel_frame_parameters(struct frame *frame, int tls_mtu);
 
 /*
  * Set local and remote option compatibility strings.
-- 
2.32.0 (Apple Git-132)


