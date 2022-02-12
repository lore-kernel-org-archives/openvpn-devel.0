From: Arne Schwabe <arne@...1227...>
Date: Sat, 12 Feb 2022 01:33:31 +0100
Message-Id: <20220212003331.3483107-1-arne@...1227...>
In-Reply-To: <20220210162632.3309974-3-arne@...1227...>
References: <20220210162632.3309974-3-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Add mtu paramter to --fragment and
 change fragment calculation
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

Instead relying on the link_mtu_dynamic field and its calculation
in the frame struct, add a new field max_fragment_size and add
a calculation of it similar to mssfix.

Also whenever mssfix value is calculated, we also want to calculate
the values for fragment as both options need to be calculated from
the real overhead.

Patch v2: Fix syntax in rst man page
Patch v5: fix segfault when get_ip_encap_overhead gets called early in
          init_instance and note that these calls will always be
          overwritten by NCP in tls_session_update_crypto_params

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                            |   9 +-
 doc/man-sections/link-options.rst      |  20 ++++-
 src/openvpn/forward.c                  |   3 +-
 src/openvpn/fragment.c                 |   4 +-
 src/openvpn/init.c                     |  15 ++--
 src/openvpn/mss.c                      | 111 +++++++++++++++++++++++--
 src/openvpn/mss.h                      |  13 ++-
 src/openvpn/mtu.c                      |  48 +----------
 src/openvpn/mtu.h                      |  21 +++--
 src/openvpn/options.c                  |  12 ++-
 src/openvpn/options.h                  |   2 +
 src/openvpn/socket.c                   |  11 ---
 src/openvpn/socket.h                   |   2 -
 src/openvpn/ssl.c                      |  20 +----
 tests/unit_tests/openvpn/test_crypto.c |   8 +-
 15 files changed, 185 insertions(+), 114 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 7d6fb7f7..ceb0b268 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -63,10 +63,11 @@ Optional ciphers in ``--data-ciphers``
     those as optional and only use them if the SSL library supports them.
 
 
-Improved ``--mssfix`` calculation
-    The ``--mssfix`` option now allows an optional :code:`mtu` parameter to specify
-    that different overhead for IPv4/IPv6 should taken into account and the resulting
-    size is specified as the total size of the VPN packets including IP and UDP headers.
+Improved ``--mssfix`` and ``--fragment`` calculation
+    The ``--mssfix`` and ``--fragment`` options now allow an optional :code:`mtu`
+    parameter to specify that different overhead for IPv4/IPv6 should taken into
+    account and the resulting size is specified as the total size of the VPN packets
+    including IP and UDP headers.
 
 Deprecated features
 -------------------
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 1792aaec..1cf6dd84 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -24,13 +24,25 @@ the local and the remote host.
   from any address, not only the address which was specified in the
   ``--remote`` option.
 
---fragment max
+--fragment args
+
+  Valid syntax:
+  ::
+
+     fragment max
+     fragment max mtu
+
   Enable internal datagram fragmentation so that no UDP datagrams are sent
   which are larger than ``max`` bytes.
 
-  The ``max`` parameter is interpreted in the same way as the
-  ``--link-mtu`` parameter, i.e. the UDP packet size after encapsulation
-  overhead has been added in, but not including the UDP header itself.
+  If the :code:`mtu` parameter is present the ``max`` parameter is
+  interpreted to include IP and UDP encapsulation overhead. The
+  :code:`mtu` parameter is introduced in OpenVPN version 2.6.0.
+
+  If the :code:`mtu` parameter is absent, the ``max`` parameter is
+  interpreted in the same way as the ``--link-mtu`` parameter, i.e.
+  the UDP packet size after encapsulation overhead has been added in,
+  but not including the UDP header itself.
 
   The ``--fragment`` option only makes sense when you are using the UDP
   protocol (``--proto udp``).
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index dcc430d4..37554fc9 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -482,8 +482,7 @@ check_fragment(struct context *c)
     /* OS MTU Hint? */
     if (lsi->mtu_changed && lsi->lsa)
     {
-        frame_adjust_path_mtu(&c->c2.frame_fragment, c->c2.link_socket->mtu,
-                              lsi->lsa->actual.dest.addr.sa.sa_family, lsi->proto);
+        frame_adjust_path_mtu(c);
         lsi->mtu_changed = false;
     }
 
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 6ede4b95..f10fa9ac 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -335,12 +335,12 @@ fragment_outgoing(struct fragment_master *f, struct buffer *buf,
             msg(D_FRAG_ERRORS, "FRAG: outgoing buffer is not empty, len=[%d,%d]",
                 buf->len, f->outgoing.len);
         }
-        if (buf->len > PAYLOAD_SIZE_DYNAMIC(frame)) /* should we fragment? */
+        if (buf->len > frame->max_fragment_size) /* should we fragment? */
         {
             /*
              * Send the datagram as a series of 2 or more fragments.
              */
-            f->outgoing_frag_size = optimal_fragment_size(buf->len, PAYLOAD_SIZE_DYNAMIC(frame));
+            f->outgoing_frag_size = optimal_fragment_size(buf->len, frame->max_fragment_size);
             if (buf->len > f->outgoing_frag_size * MAX_FRAGS)
             {
                 FRAG_ERR("too many fragments would be required to send datagram");
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4c799f19..2b1b1713 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3361,8 +3361,8 @@ static void
 do_init_fragment(struct context *c)
 {
     ASSERT(c->options.ce.fragment);
-    frame_set_mtu_dynamic(&c->c2.frame_fragment,
-                          c->options.ce.fragment, SET_MTU_UPPER_BOUND);
+    frame_calculate_dynamic(&c->c2.frame_fragment, &c->c1.ks.key_type,
+                            &c->options, get_link_socket_info(c));
     fragment_frame_init(c->c2.fragment, &c->c2.frame_fragment);
 }
 #endif
@@ -4230,10 +4230,6 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
     }
 #endif
 
-    /* initialize dynamic MTU variable */
-    frame_calculate_mssfix(&c->c2.frame, &c->c1.ks.key_type, &c->options,
-                           get_link_socket_info(c));
-
     /* bind the TCP/UDP socket */
     if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
     {
@@ -4284,6 +4280,13 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         link_socket_init_phase2(c);
     }
 
+    /* Update dynamic frame calculation as exact transport socket information
+     * (IP vs IPv6) may be only available after socket phase2 has finished.
+     * This is only needed for --static or no crypto, NCP will recalculate this
+     * in tls_session_update_crypto_params (P2MP) */
+    frame_calculate_dynamic(&c->c2.frame, &c->c1.ks.key_type, &c->options,
+                            get_link_socket_info(c));
+
     /*
      * Actually do UID/GID downgrade, and chroot, if requested.
      * May be delayed by --client, --pull, or --up-delay.
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 03624741..81692e91 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -33,6 +33,7 @@
 #include "crypto.h"
 #include "ssl_common.h"
 #include "memdbg.h"
+#include "forward.h"
 
 /*
  * Lower MSS on TCP SYN packets to fix MTU
@@ -233,30 +234,61 @@ get_ip_encap_overhead(const struct options *options,
 {
     /* Add the overhead of the encapsulating IP packets */
     sa_family_t af;
-    if (lsi->lsa)
+    int proto;
+
+    if (lsi && lsi->lsa)
     {
         af = lsi->lsa->actual.dest.addr.sa.sa_family;
+        proto = lsi->proto;
     }
     else
     {
         /* In the early init before the connection is established or we
          * are in listen mode we can only make an educated guess
-         * from the af of the connection entry */
+         * from the af of the connection entry, in p2mp this will be
+         * later updated */
         af = options->ce.af;
+        proto = options->ce.proto;
     }
-    return datagram_overhead(af, lsi->proto);
+    return datagram_overhead(af, proto);
 }
 
-void
-frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
-                       const struct options *options,
-                       struct link_socket_info *lsi)
+static void
+frame_calculate_fragment(struct frame *frame, struct key_type *kt,
+                         const struct options *options,
+                         struct link_socket_info *lsi)
 {
-    if (options->ce.mssfix == 0)
+#if defined(ENABLE_FRAGMENT)
+    unsigned int overhead;
+
+    overhead = frame_calculate_protocol_header_size(kt, options, false);
+
+    if (options->ce.fragment_encap)
     {
-        return;
+        overhead += get_ip_encap_overhead(options, lsi);
+    }
+
+    unsigned int target = options->ce.fragment - overhead;
+    /* The 4 bytes of header that fragment adds itself. The other extra payload
+     * bytes (Ethernet header/compression) are handled by the fragment code
+     * just as part of the payload and therefore automatically taken into
+     * account if the packet needs to fragmented */
+    frame->max_fragment_size = adjust_payload_max_cbc(kt, target) - 4;
+
+    if (cipher_kt_mode_cbc(kt->cipher))
+    {
+        /* The packet id gets added to *each* fragment in CBC mode, so we need
+         * to account for it */
+        frame->max_fragment_size -= calc_packet_id_size_dc(options, kt);
     }
+#endif
+}
 
+static void
+frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
+                       const struct options *options,
+                       struct link_socket_info *lsi)
+{
     unsigned int overhead, payload_overhead;
 
     overhead = frame_calculate_protocol_header_size(kt, options, false);
@@ -291,3 +323,64 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
 
 
 }
+
+void
+frame_calculate_dynamic(struct frame *frame, struct key_type *kt,
+                        const struct options *options,
+                        struct link_socket_info *lsi)
+{
+    if (options->ce.fragment > 0)
+    {
+        frame_calculate_fragment(frame, kt, options, lsi);
+    }
+
+    if (options->ce.mssfix > 0)
+    {
+        frame_calculate_mssfix(frame, kt, options, lsi);
+    }
+}
+
+/*
+ * Adjust frame structure based on a Path MTU value given
+ * to us by the OS.
+ */
+void
+frame_adjust_path_mtu(struct context *c)
+{
+    struct link_socket_info *lsi = get_link_socket_info(c);
+    struct options *o = &c->options;
+
+    int pmtu = c->c2.link_socket->mtu;
+    sa_family_t af = lsi->lsa->actual.dest.addr.sa.sa_family;
+    int proto = lsi->proto;
+
+    int encap_overhead = datagram_overhead(af, proto);
+
+    /* check if mssfix and fragment need to be adjusted */
+    if (pmtu < o->ce.mssfix
+        || (o->ce.mssfix_encap && pmtu < o->ce.mssfix + encap_overhead))
+    {
+        const char* mtustr = o->ce.mssfix_encap ? " mtu" : "";
+        msg(D_MTU_INFO, "Note adjusting 'mssfix %d %s' to 'mssfix %d mtu' "
+                        "according to path MTU discovery", o->ce.mssfix,
+            mtustr, pmtu);
+        o->ce.mssfix = pmtu;
+        o->ce.mssfix_encap = true;
+        frame_calculate_dynamic(&c->c2.frame, &c->c1.ks.key_type, o, lsi);
+    }
+
+#if defined(ENABLE_FRAGMENT)
+    if (pmtu < o->ce.fragment ||
+        (o->ce.fragment_encap && pmtu < o->ce.fragment + encap_overhead))
+    {
+        const char* mtustr = o->ce.fragment_encap ? " mtu" : "";
+        msg(D_MTU_INFO, "Note adjusting 'fragment %d %s' to 'fragment %d mtu' "
+                        "according to path MTU discovery", o->ce.mssfix,
+            mtustr, pmtu);
+        o->ce.fragment = pmtu;
+        o->ce.fragment_encap = true;
+        frame_calculate_dynamic(&c->c2.frame_fragment, &c->c1.ks.key_type,
+                                o, lsi);
+    }
+#endif
+}
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 298148f4..4b809b1c 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -36,8 +36,15 @@ void mss_fixup_ipv6(struct buffer *buf, int maxmss);
 void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
 
 /** Set the --mssfix option. */
-void frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
-                            const struct options *options,
-                            struct link_socket_info *lsi);
+void frame_calculate_dynamic(struct frame *frame, struct key_type *kt,
+                             const struct options *options,
+                             struct link_socket_info *lsi);
+
+/**
+ * Checks and adjusts the fragment and mssfix value according to the
+ * discovered path mtu value
+ * @param c     context to adjust
+ */
+void frame_adjust_path_mtu(struct context *c);
 
 #endif
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 783fcc5f..6d349f7a 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -52,12 +52,7 @@ alloc_buf_sock_tun(struct buffer *buf,
     ASSERT(buf_safe(buf, 0));
 }
 
-
-/**
- * Return the size of the packet ID size that is currently in use by cipher and
- * options for the data channel.
- */
-static unsigned int
+unsigned int
 calc_packet_id_size_dc(const struct options *options, const struct key_type *kt)
 {
     /* Unless no-replay is enabled, we have a packet id, no matter if
@@ -234,44 +229,7 @@ frame_finalize(struct frame *frame,
         msg(M_WARN, "TUN MTU value (%d) must be at least %d", frame->tun_mtu, TUN_MTU_MIN);
         frame_print(frame, M_FATAL, "MTU is too small");
     }
-
-    frame->link_mtu_dynamic = frame->link_mtu;
 }
-
-/*
- * Set the tun MTU dynamically.
- */
-void
-frame_set_mtu_dynamic(struct frame *frame, int mtu, unsigned int flags)
-{
-
-#ifdef ENABLE_DEBUG
-    const int orig_mtu = mtu;
-    const int orig_link_mtu_dynamic = frame->link_mtu_dynamic;
-#endif
-
-    ASSERT(mtu >= 0);
-
-    if (flags & SET_MTU_TUN)
-    {
-        mtu += TUN_LINK_DELTA(frame);
-    }
-
-    if (!(flags & SET_MTU_UPPER_BOUND) || mtu < frame->link_mtu_dynamic)
-    {
-        frame->link_mtu_dynamic = constrain_int(
-            mtu,
-            EXPANDED_SIZE_MIN(frame),
-            EXPANDED_SIZE(frame));
-    }
-
-    dmsg(D_MTU_DEBUG, "MTU DYNAMIC mtu=%d, flags=%u, %d -> %d",
-         orig_mtu,
-         flags,
-         orig_link_mtu_dynamic,
-         frame->link_mtu_dynamic);
-}
-
 /*
  * Move extra_frame octets into extra_tun.  Used by fragmenting code
  * to adjust frame relative to its position in the buffer processing
@@ -297,12 +255,14 @@ frame_print(const struct frame *frame,
     }
     buf_printf(&out, "[");
     buf_printf(&out, " mss_fix:%d", frame->mss_fix);
+#ifdef ENABLE_FRAGMENT
+    buf_printf(&out, " max_frag:%d", frame->max_fragment_size);
+#endif
     buf_printf(&out, " tun_mtu:%d", frame->tun_mtu);
     buf_printf(&out, " headroom:%d", frame->buf.headroom);
     buf_printf(&out, " payload:%d", frame->buf.payload_size);
     buf_printf(&out, " tailroom:%d", frame->buf.tailroom);
     buf_printf(&out, " L:%d", frame->link_mtu);
-    buf_printf(&out, " D:%d", frame->link_mtu_dynamic);
     buf_printf(&out, " EF:%d", frame->extra_frame);
     buf_printf(&out, " EB:%d", frame->extra_buffer);
     buf_printf(&out, " ET:%d", frame->extra_tun);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 3a8faec1..5f7205f4 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -113,14 +113,18 @@ struct frame {
     int link_mtu;               /**< Maximum packet size to be sent over
                                  *   the external network interface. */
 
-    unsigned int mss_fix;      /**< The actual MSS value that should be
+    unsigned int mss_fix;       /**< The actual MSS value that should be
                                  *   written to the payload packets. This
                                  *   is the value for IPv4 TCP packets. For
                                  *   IPv6 packets another 20 bytes must
                                  *   be subtracted */
 
-    int link_mtu_dynamic;       /**< Dynamic MTU value for the external
-                                 *   network interface. */
+    int max_fragment_size;      /**< The maximum size of a fragment.
+                                 * Fragmentation is done on the unencrypted
+                                 * payload after (potential) compression. So
+                                 * this value specifies the maximum payload
+                                 * size that can be send in a single fragment
+                                 */
 
     int extra_frame;            /**< Maximum number of bytes that all
                                  *   processing steps together could add.
@@ -190,7 +194,6 @@ struct options;
  * a tap device ifconfiged to an MTU of 1200 might actually want
  * to return a packet size of 1214 on a read().
  */
-#define PAYLOAD_SIZE_DYNAMIC(f)  ((f)->link_mtu_dynamic - (f)->extra_frame)
 #define PAYLOAD_SIZE(f)          ((f)->buf.payload_size)
 
 /*
@@ -198,7 +201,6 @@ struct options;
  * overhead is added.
  */
 #define EXPANDED_SIZE(f)         ((f)->link_mtu)
-#define EXPANDED_SIZE_DYNAMIC(f) ((f)->link_mtu_dynamic)
 #define EXPANDED_SIZE_MIN(f)     (TUN_MTU_MIN + TUN_LINK_DELTA(f))
 
 /*
@@ -309,6 +311,15 @@ size_t
 calc_options_string_link_mtu(const struct options *options,
                              const struct frame *frame);
 
+/**
+ * Return the size of the packet ID size that is currently in use by cipher and
+ * options for the data channel.
+ */
+unsigned int
+calc_packet_id_size_dc(const struct options *options,
+                       const struct key_type *kt);
+
+
 /*
  * frame_set_mtu_dynamic and flags
  */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 491edbe5..392d2896 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6159,11 +6159,19 @@ add_option(struct options *options,
         msg(msglevel, "--mtu-dynamic has been replaced by --fragment");
         goto err;
     }
-    else if (streq(p[0], "fragment") && p[1] && !p[2])
+    else if (streq(p[0], "fragment") && p[1] && !p[3])
     {
-/*      VERIFY_PERMISSION (OPT_P_MTU); */
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
         options->ce.fragment = positive_atoi(p[1]);
+
+        if (p[2] && streq(p[2], "mtu"))
+        {
+            options->ce.fragment_encap = true;
+        }
+        else if (p[2])
+        {
+            msg(msglevel, "Unknown parameter to --fragment: %s", p[2]);
+        }
     }
 #endif
     else if (streq(p[0], "mtu-disc") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3d0f7fe7..9c25fbaf 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -125,6 +125,8 @@ struct connection_entry
     int mtu_discover_type; /* used if OS supports setting Path MTU discovery options on socket */
 
     int fragment;        /* internal fragmentation size */
+    bool fragment_encap; /* true if --fragment had the "mtu" parameter to
+                          * include overhead from IP and TCP/UDP encapsulation */
     int mssfix;          /* Upper bound on TCP MSS */
     bool mssfix_default; /* true if --mssfix should use the default parameters */
     bool mssfix_encap;   /* true if --mssfix had the "mtu" parameter to include
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 45541c12..be66994f 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1644,17 +1644,6 @@ socket_frame_init(const struct frame *frame, struct link_socket *sock)
     }
 }
 
-/*
- * Adjust frame structure based on a Path MTU value given
- * to us by the OS.
- */
-void
-frame_adjust_path_mtu(struct frame *frame, int pmtu, sa_family_t af, int proto)
-{
-    frame_set_mtu_dynamic(frame, pmtu - datagram_overhead(af, proto),
-                          SET_MTU_UPPER_BOUND);
-}
-
 static void
 resolve_bind_local(struct link_socket *sock, const sa_family_t af)
 {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 63a25485..51f28ba5 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -333,8 +333,6 @@ void do_preresolve(struct context *c);
 
 void socket_adjust_frame_parameters(struct frame *frame, int proto);
 
-void frame_adjust_path_mtu(struct frame *frame, int pmtu, sa_family_t af, int proto);
-
 void link_socket_close(struct link_socket *sock);
 
 void sd_close(socket_descriptor_t *sd);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ea6ae180..10f75d66 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -331,7 +331,6 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
 
     /* set dynamic link MTU to cap control channel packets at 1250 bytes */
     ASSERT(TUN_LINK_DELTA(frame) < min_int(frame->link_mtu, 1250));
-    frame->link_mtu_dynamic = min_int(frame->link_mtu, 1250) - TUN_LINK_DELTA(frame);
 
     /* calculate the maximum overhead that control channel frames may have */
     int overhead = 0;
@@ -1920,9 +1919,8 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
     frame_remove_from_extra_frame(frame, crypto_max_overhead());
     crypto_adjust_frame_parameters(frame, &session->opt->key_type,
                                    options->replay, packet_id_long_form);
-    frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
-                   options->ce.tun_mtu_defined, options->ce.tun_mtu);
-    frame_calculate_mssfix(frame, &session->opt->key_type, options, lsi);
+    frame_calculate_dynamic(frame, &session->opt->key_type, options, lsi);
+
     frame_print(frame, D_MTU_INFO, "Data Channel MTU parms");
 
     /*
@@ -1937,7 +1935,7 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
         frame_remove_from_extra_frame(frame_fragment, crypto_max_overhead());
         crypto_adjust_frame_parameters(frame_fragment, &session->opt->key_type,
                                        options->replay, packet_id_long_form);
-        frame_set_mtu_dynamic(frame_fragment, options->ce.fragment, SET_MTU_UPPER_BOUND);
+        frame_calculate_dynamic(frame_fragment, &session->opt->key_type, options, lsi);
         frame_print(frame_fragment, D_MTU_INFO, "Fragmentation MTU parms");
     }
 
@@ -2990,6 +2988,7 @@ tls_process(struct tls_multi *multi,
             if (buf)
             {
                 int status = key_state_read_ciphertext(&ks->ks_ssl, buf, multi->opt.frame.tun_mtu);
+
                 if (status == -1)
                 {
                     msg(D_TLS_ERRORS,
@@ -3835,17 +3834,6 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
         goto error;
     }
 
-    if (buf->len > EXPANDED_SIZE_DYNAMIC(&tas->frame))
-    {
-        dmsg(D_TLS_STATE_ERRORS,
-             "TLS State Error: Large packet (size %d) received from %s -- a packet no larger than %d bytes was expected",
-             buf->len,
-             print_link_socket_actual(from, &gc),
-             EXPANDED_SIZE_DYNAMIC(&tas->frame));
-        goto error;
-    }
-
-
     struct buffer newbuf = clone_buf(buf);
     struct tls_wrap_ctx tls_wrap_tmp = tas->tls_wrap;
 
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 5669948f..7fb9d624 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -388,7 +388,7 @@ test_mssfix_mtu_calculation(void **state)
     init_key_type(&kt, o.ciphername, o.authname, false, false);
 
     /* No encryption, just packet id (8) + TCP payload(20) + IP payload(20) */
-    frame_calculate_mssfix(&f, &kt, &o, NULL);
+    frame_calculate_dynamic(&f, &kt, &o, NULL);
     assert_int_equal(f.mss_fix, 952);
 
     /* Static key OCC examples */
@@ -398,7 +398,7 @@ test_mssfix_mtu_calculation(void **state)
     o.ciphername = "none";
     o.authname = "none";
     init_key_type(&kt, o.ciphername, o.authname, false, false);
-    frame_calculate_mssfix(&f, &kt, &o, NULL);
+    frame_calculate_dynamic(&f, &kt, &o, NULL);
     assert_int_equal(f.mss_fix, 952);
 
     /* secret, cipher AES-128-CBC, auth none */
@@ -412,7 +412,7 @@ test_mssfix_mtu_calculation(void **state)
          * all result in the same CBC block size/padding and <= 991 and >=1008
          * should be one block less and more respectively */
         o.ce.mssfix = i;
-        frame_calculate_mssfix(&f, &kt, &o, NULL);
+        frame_calculate_dynamic(&f, &kt, &o, NULL);
         if (i <= 991)
         {
             assert_int_equal(f.mss_fix, 911);
@@ -440,7 +440,7 @@ test_mssfix_mtu_calculation(void **state)
         /* For stream ciphers, the value should not be influenced by block
          * sizes or similar but always have the same difference */
         o.ce.mssfix = i;
-        frame_calculate_mssfix(&f, &kt, &o, NULL);
+        frame_calculate_dynamic(&f, &kt, &o, NULL);
 
         /* 4 byte opcode/peerid, 4 byte pkt ID, 16 byte tag, 40 TCP+IP */
         assert_int_equal(f.mss_fix, i - 4 - 4 - 16 - 40);
-- 
2.33.0


