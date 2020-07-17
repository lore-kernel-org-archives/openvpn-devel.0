From: David Sommerseth <davids@...515...>
Date: Fri, 17 Jul 2020 19:10:36 +0200
Message-Id: <20200717171036.20687-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove --no-replay
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

The --no-replay feature is considered to be a security weakness, which
was also highlighed during the OpenVPN 2.4 security audit [0].  This
option was added to the DeprecatedOptions[1] list and has been reported
as deprecated since OpenVPN 2.4.

Now we remove it.

URL: [0] https://community.openvpn.net/openvpn/wiki/QuarkslabAndCryptographyEngineerAudits#OVPN-03-3:Insecureconfigurationoptions:--no-replay
URL: [1] https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#Option:--no-replay
Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst                         |  5 ++++
 doc/man-sections/link-options.rst   |  3 +--
 doc/man-sections/server-options.rst |  2 +-
 src/openvpn/crypto.c                | 21 ++--------------
 src/openvpn/crypto.h                |  5 +---
 src/openvpn/init.c                  | 38 +++++++++--------------------
 src/openvpn/options.c               | 25 +------------------
 src/openvpn/options.h               |  1 -
 src/openvpn/ssl.c                   | 13 ++++------
 src/openvpn/ssl_common.h            |  1 -
 10 files changed, 27 insertions(+), 87 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 18b03e47..e279d360 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -34,6 +34,11 @@ https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
     With the improved and matured data channel cipher negotiation, the use
     of ``ncp-disable`` should not be necessary anymore.
 
+- ``-no-replay`` has been removed
+    This has been listed as a deprecated option since OpenVPN 2.4 and
+    adds a security weakness.  This was also highlighted during the
+    `OpenVPN 2.4 security audit <https://community.openvpn.net/openvpn/wiki/QuarkslabAndCryptographyEngineerAudits#OVPN-03-3:Insecureconfigurationoptions:--no-replay>`_.
+
 
 Overview of changes in 2.4
 ==========================
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index c132a623..a4239644 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -311,8 +311,7 @@ the local and the remote host.
   order they were received to the TCP/IP protocol stack, provided they
   satisfy several constraints.
 
-  (a)   The packet cannot be a replay (unless ``--no-replay`` is
-        specified, which disables replay protection altogether).
+  (a)   The packet cannot be a replay.
 
   (b)   If a packet arrives out of order, it will only be accepted if
         the difference between its sequence number and the highest sequence
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index c24aec0b..2381f5c8 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -398,7 +398,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   Options that will be compared for compatibility include ``dev-type``,
   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,
   ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,
-  ``auth``, ``keysize``, ``secret``, ``no-replay``,
+  ``auth``, ``keysize``, ``secret``,
   ``no-iv``, ``tls-auth``, ``key-method``, ``tls-server``
   and ``tls-client``.
 
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1ce98184..58d7980a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -340,7 +340,7 @@ crypto_check_replay(struct crypto_options *opt,
         if (!(opt->flags & CO_MUTE_REPLAY_WARNINGS))
         {
             msg(D_REPLAY_ERRORS, "%s: bad packet ID (may be a replay): %s -- "
-                "see the man page entry for --no-replay and --replay-window for "
+                "see the man page entry for --replay-window for "
                 "more info or silence this warning with --mute-replay-warnings",
                 error_prefix, packet_id_net_print(pin, true, gc));
         }
@@ -697,15 +697,9 @@ openvpn_decrypt(struct buffer *buf, struct buffer work,
 void
 crypto_adjust_frame_parameters(struct frame *frame,
                                const struct key_type *kt,
-                               bool packet_id,
                                bool packet_id_long_form)
 {
-    unsigned int crypto_overhead = 0;
-
-    if (packet_id)
-    {
-        crypto_overhead += packet_id_size(packet_id_long_form);
-    }
+    unsigned int crypto_overhead = packet_id_size(packet_id_long_form);
 
     if (kt->cipher)
     {
@@ -1013,17 +1007,6 @@ fixup_key(struct key *key, const struct key_type *kt)
     gc_free(&gc);
 }
 
-void
-check_replay_consistency(const struct key_type *kt, bool packet_id)
-{
-    ASSERT(kt);
-
-    if (!packet_id && (cipher_kt_mode_ofb_cfb(kt->cipher)
-                       || cipher_kt_mode_aead(kt->cipher)))
-    {
-        msg(M_FATAL, "--no-replay cannot be used with a CFB, OFB or AEAD mode cipher");
-    }
-}
 
 /*
  * Generate a random key.  If key_type is provided, make
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 999f643e..ea1ba5b1 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -40,7 +40,7 @@
  *    HMAC at all.
  *  - \b Ciphertext \b IV. The IV size depends on the \c \-\-cipher option.
  *  - \b Packet \b ID, a 32-bit incrementing packet counter that provides replay
- *    protection (if not disabled by \c \-\-no-replay).
+ *    protection.
  *  - \b Timestamp, a 32-bit timestamp of the current time.
  *  - \b Payload, the plain text network packet to be encrypted (unless
  *    encryption is disabled by using \c \-\-cipher \c none). The payload might
@@ -280,8 +280,6 @@ int write_key_file(const int nkeys, const char *filename);
 
 void generate_key_random(struct key *key, const struct key_type *kt);
 
-void check_replay_consistency(const struct key_type *kt, bool packet_id);
-
 bool check_key(struct key *key, const struct key_type *kt);
 
 void fixup_key(struct key *key, const struct key_type *kt);
@@ -414,7 +412,6 @@ bool crypto_check_replay(struct crypto_options *opt,
 /** Calculate crypto overhead and adjust frame to account for that */
 void crypto_adjust_frame_parameters(struct frame *frame,
                                     const struct key_type *kt,
-                                    bool packet_id,
                                     bool packet_id_long_form);
 
 /** Return the worst-case OpenVPN crypto overhead (in bytes) */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e9c01629..bb5e35fc 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2599,17 +2599,14 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
     }
 
     /* Initialize packet ID tracking */
-    if (options->replay)
-    {
-        packet_id_init(&c->c2.crypto_options.packet_id,
-                       options->replay_window,
-                       options->replay_time,
-                       "STATIC", 0);
-        c->c2.crypto_options.pid_persist = &c->c1.pid_persist;
-        c->c2.crypto_options.flags |= CO_PACKET_ID_LONG_FORM;
-        packet_id_persist_load_obj(&c->c1.pid_persist,
-                                   &c->c2.crypto_options.packet_id);
-    }
+    packet_id_init(&c->c2.crypto_options.packet_id,
+                   options->replay_window,
+                   options->replay_time,
+                   "STATIC", 0);
+    c->c2.crypto_options.pid_persist = &c->c1.pid_persist;
+    c->c2.crypto_options.flags |= CO_PACKET_ID_LONG_FORM;
+    packet_id_persist_load_obj(&c->c1.pid_persist,
+                               &c->c2.crypto_options.packet_id);
 
     if (!key_ctx_bi_defined(&c->c1.ks.static_key))
     {
@@ -2633,11 +2630,7 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
     c->c2.crypto_options.key_ctx_bi = c->c1.ks.static_key;
 
     /* Compute MTU parameters */
-    crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
-                                   options->replay, true);
-
-    /* Sanity check on sequence number, and cipher mode options */
-    check_replay_consistency(&c->c1.ks.key_type, options->replay);
+    crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type, true);
 }
 
 /*
@@ -2816,9 +2809,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         return;
     }
 
-    /* Sanity check on sequence number, and cipher mode options */
-    check_replay_consistency(&c->c1.ks.key_type, options->replay);
-
     /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
     packet_id_long_form = cipher_kt_mode_ofb_cfb(c->c1.ks.key_type.cipher);
 
@@ -2831,7 +2821,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     else
     {
         crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
-                                       options->replay, packet_id_long_form);
+                                       packet_id_long_form);
     }
     tls_adjust_frame_parameters(&c->c2.frame);
 
@@ -2853,7 +2843,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.key_type = c->c1.ks.key_type;
     to.server = options->tls_server;
     to.key_method = options->key_method;
-    to.replay = options->replay;
     to.replay_window = options->replay_window;
     to.replay_time = options->replay_time;
     to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
@@ -2987,7 +2976,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.tls_wrap.opt.pid_persist = &c->c1.pid_persist;
         to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
         crypto_adjust_frame_parameters(&to.frame, &c->c1.ks.tls_auth_key_type,
-                                       true, true);
+                                       true);
     }
 
     /* TLS handshake encryption (--tls-crypt) */
@@ -3279,11 +3268,6 @@ do_option_warnings(struct context *c)
     }
 #endif /* if P2MP */
 
-    if (!o->replay)
-    {
-        msg(M_WARN, "WARNING: You have disabled Replay Protection (--no-replay) which may make " PACKAGE_NAME " less secure");
-    }
-
     if (o->tls_server)
     {
         warn_on_use_of_common_subnets(&c->net_ctx);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b6b8d769..e1658472 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -555,7 +555,6 @@ static const char usage_message[] =
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
 #endif
-    "--no-replay     : (DEPRECATED) Disable replay protection.\n"
     "--mute-replay-warnings : Silence the output of replay warnings to log file.\n"
     "--replay-window n [t]  : Use a replay protection sliding window of size n\n"
     "                         and a time window of t seconds.\n"
@@ -880,7 +879,6 @@ init_options(struct options *o, const bool init_gc)
     o->authname = "SHA1";
     o->prng_hash = "SHA1";
     o->prng_nonce_secret_len = 16;
-    o->replay = true;
     o->replay_window = DEFAULT_SEQ_BACKTRACK;
     o->replay_time = DEFAULT_TIME_BACKTRACK;
     o->key_direction = KEY_DIRECTION_BIDIRECTIONAL;
@@ -1709,7 +1707,6 @@ show_settings(const struct options *o)
 #ifndef ENABLE_CRYPTO_MBEDTLS
     SHOW_BOOL(engine);
 #endif /* ENABLE_CRYPTO_MBEDTLS */
-    SHOW_BOOL(replay);
     SHOW_BOOL(mute_replay_warnings);
     SHOW_INT(replay_window);
     SHOW_INT(replay_time);
@@ -2526,16 +2523,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_WARN, "WARNING: --keysize is DEPRECATED and will be removed in OpenVPN 2.6");
     }
 
-    /*
-     * Check consistency of replay options
-     */
-    if (!options->replay
-        && (options->replay_window != defaults.replay_window
-            || options->replay_time != defaults.replay_time))
-    {
-        msg(M_USAGE, "--replay-window doesn't make sense when replay protection is disabled with --no-replay");
-    }
-
     /*
      * SSL/TLS mode sanity checks.
      */
@@ -3629,7 +3616,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
         init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
                       false);
         frame_remove_from_extra_frame(&fake_frame, crypto_max_overhead());
-        crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
+        crypto_adjust_frame_parameters(&fake_frame, &fake_kt,
                                        cipher_kt_mode_ofb_cfb(fake_kt.cipher));
         frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
                        o->ce.tun_mtu_defined, o->ce.tun_mtu);
@@ -3673,7 +3660,6 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
  * --auth
  * --keysize
  * --secret
- * --no-replay
  *
  * SSL Options:
  *
@@ -3802,10 +3788,6 @@ options_string(const struct options *o,
         {
             buf_printf(&out, ",secret");
         }
-        if (!o->replay)
-        {
-            buf_printf(&out, ",no-replay");
-        }
 
 #ifdef ENABLE_PREDICTION_RESISTANCE
         if (o->use_prediction_resistance)
@@ -7958,11 +7940,6 @@ add_option(struct options *options,
             }
         }
     }
-    else if (streq(p[0], "no-replay") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->replay = false;
-    }
     else if (streq(p[0], "replay-window") && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c37006d3..23f5c3bb 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -514,7 +514,6 @@ struct options
     const char *prng_hash;
     int prng_nonce_secret_len;
     const char *engine;
-    bool replay;
     bool mute_replay_warnings;
     int replay_window;
     int replay_time;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 54a23011..a280df67 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -952,12 +952,9 @@ key_state_init(struct tls_session *session, struct key_state *ks)
     reliable_set_timeout(ks->send_reliable, session->opt->packet_timeout);
 
     /* init packet ID tracker */
-    if (session->opt->replay)
-    {
-        packet_id_init(&ks->crypto_options.packet_id,
-                       session->opt->replay_window, session->opt->replay_time, "SSL",
-                       ks->key_id);
-    }
+    packet_id_init(&ks->crypto_options.packet_id,
+                   session->opt->replay_window, session->opt->replay_time, "SSL",
+                   ks->key_id);
 
     ks->crypto_options.pid_persist = NULL;
 
@@ -2006,7 +2003,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     /* Update frame parameters: undo worst-case overhead, add actual overhead */
     frame_remove_from_extra_frame(frame, crypto_max_overhead());
     crypto_adjust_frame_parameters(frame, &session->opt->key_type,
-                                   options->replay, packet_id_long_form);
+                                   packet_id_long_form);
     frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
                    options->ce.tun_mtu_defined, options->ce.tun_mtu);
     frame_init_mssfix(frame, options);
@@ -2023,7 +2020,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     {
         frame_remove_from_extra_frame(frame_fragment, crypto_max_overhead());
         crypto_adjust_frame_parameters(frame_fragment, &session->opt->key_type,
-                                       options->replay, packet_id_long_form);
+                                       packet_id_long_form);
         frame_set_mtu_dynamic(frame_fragment, options->ce.fragment, SET_MTU_UPPER_BOUND);
         frame_print(frame_fragment, D_MTU_INFO, "Fragmentation MTU parms");
     }
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e0b3ee56..03e8985e 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -263,7 +263,6 @@ struct tls_options
 
     /* from command line */
     int key_method;
-    bool replay;
     bool single_session;
 #ifdef ENABLE_OCC
     bool disable_occ;
-- 
2.26.0


