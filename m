From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Sep 2022 12:49:29 +0200
Message-Id: <20220921104930.3452270-2-arne@...1227...>
In-Reply-To: <20220921104930.3452270-1-arne@...1227...>
References: <20220921104930.3452270-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 2/3] Allow setting control channel packet
 size with max-packet-size
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

Instead we decouple this and introduce max-packet-size. Control packet size
defaults to 1250 if max-packet-size is not set.

Patch v2: rebase on latest patch set
Patch v3: Introduce TLS_CHANNEL_MTU_MIN define and give explaination
          of its value.
Patch v4: introduce max-packet-size instead of tls-mtu

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                       |  9 +++++++++
 doc/man-sections/link-options.rst | 16 ++++++++++++++++
 src/openvpn/common.h              | 10 ++++++++++
 src/openvpn/init.c                |  8 ++++++--
 src/openvpn/mtu.h                 |  5 +++++
 src/openvpn/options.c             | 21 +++++++++++++++++++++
 src/openvpn/options.h             |  1 +
 src/openvpn/ssl.c                 | 26 ++++++++++++++------------
 src/openvpn/ssl.h                 |  8 +++-----
 9 files changed, 85 insertions(+), 19 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 275f8d647..25b0e9846 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -88,6 +88,12 @@ Data channel offloading with ovpn-dco
     which brings DATA_V2 packet support.
 
 
+Improved control channel packet size control (``max-packet-size``)
+    The size of control channel is no longer tied to
+    ``--link-mtu``/``--tun-mtu`` and can be set using ``--max-packet-size``.
+    Setting the size to small sizes no longer breaks the OpenVPN protocol in
+    certain situations.
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
@@ -150,6 +156,9 @@ User-visible Changes
 - Option ``--nobind`` is default when ``--client`` or ``--pull`` is used in the configuration
 - :code:`link_mtu` parameter is removed from environment or replaced with 0 when scripts are
   called with parameters. This parameter is unreliable and no longer internally calculated.
+- control channel packet maximum size is no longer influenced by ``--link-mtu``/``--tun-mtu``
+  and must be set by ``--max-packet-size`` now.
+
 
 Overview of changes in 2.5
 ==========================
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 373193aa3..176c2b0db 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -454,3 +454,19 @@ the local and the remote host.
      if mode server:
          socket-flags TCP_NODELAY
          push "socket-flags TCP_NODELAY"
+
+--max-packet-size size
+  This option will instruct OpenVPN to try to limit the maximum on-write packet
+  size by restricting the control channel packet size and setting ``--mssfix``.
+
+  OpenVPN will try to keep its control channel messages below this size but
+  due to some constraints in the protocol this is not always possible. If the
+  option is not set, the control packet maximum size defaults to 1250.
+  The control channel packet size will be restricted to values between
+  512 and 2048. The maximum packet size includes encapsulation overhead like
+  UDP and IP.
+
+  For ``--mssfix`` it will expand to:
+  ::
+
+      mssfix size mtu
\ No newline at end of file
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index b94680885..056c25438 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -68,6 +68,16 @@ typedef unsigned long ptr_type;
  */
 #define TLS_CHANNEL_BUF_SIZE 2048
 
+/* TLS control buffer minimum size, this size is not actually inherent to
+ * the protocol but. Our current sending window is 6 and the receive window
+ * is 8 or 12 depending on the OpenVPN version. We need to be able to send
+ * a TLS record of size TLS_CHANNEL_BUF_SIZE. Splitting this into more than
+ * 6 packets (with overhead) would complicate our sending logic a lot more, so
+ * we settle here for a "round" number that allow with overhead of ~100 bytes
+ * to be larger than TLS_CHANNEL_BUF_SIZE. E.g. 6x ~400 > 2048.
+ * */
+#define TLS_CHANNEL_MTU_MIN 512
+
 /*
  * This parameter controls the maximum size of a bundle
  * of pushed options.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 034168441..305cc40f6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2627,6 +2627,10 @@ frame_finalize_options(struct context *c, const struct options *o)
      * space */
     size_t payload_size = max_int(1500, frame->tun_mtu);
 
+    /* we need to be also large enough to hold larger control channel packets
+     * if configured */
+    payload_size = max_int(payload_size, o->ce.tls_mtu);
+
     /* The extra tun needs to be added to the payload size */
     if (o->ce.tun_mtu_defined)
     {
@@ -3172,7 +3176,7 @@ do_init_frame_tls(struct context *c)
 {
     if (c->c2.tls_multi)
     {
-        tls_multi_init_finalize(c->c2.tls_multi, &c->c2.frame);
+        tls_multi_init_finalize(c->c2.tls_multi, c->options.ce.tls_mtu);
         ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <=
                c->c2.frame.buf.payload_size);
         frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO,
@@ -3180,7 +3184,7 @@ do_init_frame_tls(struct context *c)
     }
     if (c->c2.tls_auth_standalone)
     {
-        tls_init_control_channel_frame_parameters(&c->c2.frame, &c->c2.tls_auth_standalone->frame);
+        tls_init_control_channel_frame_parameters(&c->c2.tls_auth_standalone->frame, c->options.ce.tls_mtu);
         frame_print(&c->c2.tls_auth_standalone->frame, D_MTU_INFO,
                     "TLS-Auth MTU parms");
         c->c2.tls_auth_standalone->tls_wrap.work = alloc_buf_gc(BUF_SIZE(&c->c2.frame), &c->c2.gc);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index d4856f166..370806fb5 100644
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
index e44993c03..a7385118e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -825,6 +825,7 @@ init_options(struct options *o, const bool init_gc)
     o->ce.bind_local = true;
     o->ce.tun_mtu = TUN_MTU_DEFAULT;
     o->ce.link_mtu = LINK_MTU_DEFAULT;
+    o->ce.tls_mtu = TLS_MTU_DEFAULT;
     o->ce.mtu_discover_type = -1;
     o->ce.mssfix = 0;
     o->ce.mssfix_default = true;
@@ -1711,6 +1712,7 @@ show_connection_entry(const struct connection_entry *o)
     SHOW_BOOL(link_mtu_defined);
     SHOW_INT(tun_mtu_extra);
     SHOW_BOOL(tun_mtu_extra_defined);
+    SHOW_INT(tls_mtu);
 
     SHOW_INT(mtu_discover_type);
 
@@ -6442,6 +6444,25 @@ add_option(struct options *options,
         options->ce.tun_mtu_extra = positive_atoi(p[1]);
         options->ce.tun_mtu_extra_defined = true;
     }
+    else if (streq(p[0], "max-packet-size") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        int maxmtu = positive_atoi(p[1]);
+        options->ce.tls_mtu = constrain_int(maxmtu, TLS_CHANNEL_MTU_MIN, TLS_CHANNEL_BUF_SIZE);
+
+        if (maxmtu < TLS_CHANNEL_MTU_MIN || maxmtu > TLS_CHANNEL_BUF_SIZE)
+        {
+            msg(M_WARN, "max-packet-size value outside of allowed control "
+                "channel packet size (%d to %d), will use %d "
+                "instead", TLS_CHANNEL_MTU_MIN, TLS_CHANNEL_BUF_SIZE,
+                options->ce.tls_mtu);
+        }
+
+        /* also set mssfix maxmtu mtu */
+        options->ce.mssfix = maxmtu;
+        options->ce.mssfix_default = false;
+        options->ce.mssfix_encap = true;
+    }
 #ifdef ENABLE_FRAGMENT
     else if (streq(p[0], "mtu-dynamic"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index e83bc0ed8..c9065a5fa 100644
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
index b69258be8..5f246db3b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -297,8 +297,7 @@ tls_limit_reneg_bytes(const char *ciphername, int *reneg_bytes)
 }
 
 void
-tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame,
-                                          struct frame *frame)
+tls_init_control_channel_frame_parameters(struct frame *frame, int tls_mtu)
 {
     /*
      * frame->extra_frame is already initialized with tls_auth buffer requirements,
@@ -323,18 +322,21 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
 
     /* Previous OpenVPN version calculated the maximum size and buffer of a
      * control frame depending on the overhead of the data channel frame
-     * overhead and limited its maximum size to 1250. We always allocate the
-     * TLS_CHANNEL_BUF_SIZE buffer size since a lot of code blindly assumes
-     * a large buffer (e.g. PUSH_BUNDLE_SIZE) and also our peer might have
-     * a higher size configured and we still want to be able to receive the
-     * packets. frame->mtu_mtu is set as suggestion for the maximum packet
-     * size */
-    frame->buf.payload_size = 1250 + overhead;
+     * overhead and limited its maximum size to 1250. Since control frames
+     * also need to fit into data channel buffer we have the same
+     * default of 1500 + 100 as data channel buffers have. Increasing
+     * control channel mtu beyond this limit also increases the data channel
+     * buffers */
+    frame->buf.payload_size = max_int(1500, tls_mtu) + 100;
 
     frame->buf.headroom = overhead;
     frame->buf.tailroom = overhead;
 
-    frame->tun_mtu = min_int(data_channel_frame->tun_mtu, 1250);
+    frame->tun_mtu = tls_mtu;
+
+    /* Ensure the tun-mtu stays in a valid range */
+    frame->tun_mtu = min_int(frame->tun_mtu, TLS_CHANNEL_BUF_SIZE);
+    frame->tun_mtu = max_int(frame->tun_mtu, TLS_CHANNEL_MTU_MIN);
 }
 
 /**
@@ -1300,9 +1302,9 @@ tls_multi_init(struct tls_options *tls_options)
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
index 8ca4c4aa8..eddaca8cd 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -166,10 +166,9 @@ struct tls_multi *tls_multi_init(struct tls_options *tls_options);
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
@@ -181,8 +180,7 @@ struct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_opt
  * Setups the control channel frame size parameters from the data channel
  * parameters
  */
-void tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame,
-                                               struct frame *frame);
+void tls_init_control_channel_frame_parameters(struct frame *frame, int tls_mtu);
 
 /*
  * Set local and remote option compatibility strings.
-- 
2.37.0 (Apple Git-136)


