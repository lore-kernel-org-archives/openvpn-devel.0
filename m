From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 2 Jan 2017 13:54:58 +0100
Message-ID: <1483361698-9693-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove deprecated --no-iv option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The --no-iv option was deprecated in OpenVPN 2.4 (commit 4969f0d6),
and promised to be remove in 2.5.  This patch fulfills that promise.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c  | 68 +++++++++++++++++----------------------------------
 src/openvpn/crypto.h  | 14 +++--------
 src/openvpn/init.c    | 36 +++++++--------------------
 src/openvpn/options.c | 24 +++---------------
 src/openvpn/options.h |  1 -
 src/openvpn/ssl.c     |  2 +-
 6 files changed, 40 insertions(+), 105 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7119abc..5d4426f 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -77,7 +77,6 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
     /* IV, packet-ID and implicit IV required for this mode. */
     ASSERT(ctx->cipher);
     ASSERT(cipher_kt_mode_aead(cipher_kt));
-    ASSERT(opt->flags & CO_USE_IV);
     ASSERT(packet_id_initialized(&opt->packet_id));
 
     gc_init(&gc);
@@ -190,10 +189,7 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
             if (cipher_kt_mode_cbc(cipher_kt))
             {
                 /* generate pseudo-random IV */
-                if (opt->flags & CO_USE_IV)
-                {
-                    prng_bytes(iv_buf, iv_size);
-                }
+                prng_bytes(iv_buf, iv_size);
 
                 /* Put packet ID in plaintext buffer */
                 if (packet_id_initialized(&opt->packet_id))
@@ -208,8 +204,7 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
                 struct packet_id_net pin;
                 struct buffer b;
 
-                /* IV and packet-ID required for this mode. */
-                ASSERT(opt->flags & CO_USE_IV);
+                /* packet-ID required for this mode. */
                 ASSERT(packet_id_initialized(&opt->packet_id));
 
                 packet_id_alloc_outgoing(&opt->packet_id.send, &pin, true);
@@ -222,11 +217,8 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
             }
 
             /* set the IV pseudo-randomly */
-            if (opt->flags & CO_USE_IV)
-            {
-                ASSERT(buf_write(&work, iv_buf, iv_size));
-                dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
-            }
+            ASSERT(buf_write(&work, iv_buf, iv_size));
+            dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
 
             dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s",
                  format_hex(BPTR(buf), BLEN(buf), 80, &gc));
@@ -354,13 +346,13 @@ crypto_check_replay(struct crypto_options *opt,
     return ret;
 }
 
-/*
- * If (opt->flags & CO_USE_IV) is not NULL, we will read an IV from the packet.
+/**
+ * Unwrap (authenticate, decrypt and check replay protection) AEAD-mode data
+ * channel packets.
  *
  * Set buf->len to 0 and return false on decrypt error.
  *
- * On success, buf is set to point to plaintext, true
- * is returned.
+ * On success, buf is set to point to plaintext, true is returned.
  */
 static bool
 openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
@@ -394,7 +386,6 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
 
     /* IV and Packet ID required for this mode */
     ASSERT(packet_id_initialized(&opt->packet_id));
-    ASSERT(opt->flags & CO_USE_IV);
 
     /* Combine IV from explicit part from packet and implicit part from context */
     {
@@ -503,12 +494,12 @@ error_exit:
 }
 
 /*
- * If (opt->flags & CO_USE_IV) is not NULL, we will read an IV from the packet.
+ * Unwrap (authenticate, decrypt and check replay protection) CBC, OFB or CFB
+ * mode data channel packets.
  *
  * Set buf->len to 0 and return false on decrypt error.
  *
- * On success, buf is set to point to plaintext, true
- * is returned.
+ * On success, buf is set to point to plaintext, true is returned.
  */
 static bool
 openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
@@ -568,22 +559,14 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
             /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
             ASSERT(buf_init(&work, FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_DECRYPT)));
 
-            /* use IV if user requested it */
-            if (opt->flags & CO_USE_IV)
-            {
-                if (buf->len < iv_size)
-                {
-                    CRYPT_ERROR("missing IV info");
-                }
-                memcpy(iv_buf, BPTR(buf), iv_size);
-                ASSERT(buf_advance(buf, iv_size));
-            }
-
-            /* show the IV's initial state */
-            if (opt->flags & CO_USE_IV)
+            /* read the IV from the packet */
+            if (buf->len < iv_size)
             {
-                dmsg(D_PACKET_CONTENT, "DECRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
+                CRYPT_ERROR("missing IV info");
             }
+            memcpy(iv_buf, BPTR(buf), iv_size);
+            ASSERT(buf_advance(buf, iv_size));
+            dmsg(D_PACKET_CONTENT, "DECRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
 
             if (buf->len < 1)
             {
@@ -636,8 +619,7 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
                 {
                     struct buffer b;
 
-                    /* IV and packet-ID required for this mode. */
-                    ASSERT(opt->flags & CO_USE_IV);
+                    /* packet-ID required for this mode. */
                     ASSERT(packet_id_initialized(&opt->packet_id));
 
                     buf_set_read(&b, iv_buf, iv_size);
@@ -713,7 +695,6 @@ openvpn_decrypt(struct buffer *buf, struct buffer work,
 void
 crypto_adjust_frame_parameters(struct frame *frame,
                                const struct key_type *kt,
-                               bool use_iv,
                                bool packet_id,
                                bool packet_id_long_form)
 {
@@ -726,10 +707,7 @@ crypto_adjust_frame_parameters(struct frame *frame,
 
     if (kt->cipher)
     {
-        if (use_iv)
-        {
-            crypto_overhead += cipher_kt_iv_size(kt->cipher);
-        }
+        crypto_overhead += cipher_kt_iv_size(kt->cipher);
 
         if (cipher_kt_mode_aead(kt->cipher))
         {
@@ -995,15 +973,13 @@ fixup_key(struct key *key, const struct key_type *kt)
 }
 
 void
-check_replay_iv_consistency(const struct key_type *kt, bool packet_id, bool use_iv)
+check_replay_consistency(const struct key_type *kt, bool packet_id)
 {
     ASSERT(kt);
 
-    if (!(packet_id && use_iv) && (cipher_kt_mode_ofb_cfb(kt->cipher)
-                                   || cipher_kt_mode_aead(kt->cipher)))
+    if (cipher_kt_mode_ofb_cfb(kt->cipher) || cipher_kt_mode_aead(kt->cipher))
     {
-        msg(M_FATAL, "--no-replay or --no-iv cannot be used with a CFB, OFB or "
-            "AEAD mode cipher");
+        msg(M_FATAL, "--no-replay cannot be used with a CFB, OFB or AEAD mode cipher");
     }
 }
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 61e9b59..3d96d08 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -39,8 +39,7 @@
  *  - \b HMAC, covering the ciphertext IV + ciphertext. The HMAC size depends
  *    on the \c \-\-auth option. If \c \-\-auth \c none is specified, there is no
  *    HMAC at all.
- *  - \b Ciphertext \b IV, if not disabled by \c \-\-no-iv. The IV size depends on
- *    the \c \-\-cipher option.
+ *  - \b Ciphertext \b IV. The IV size depends on the \c \-\-cipher option.
  *  - \b Packet \b ID, a 32-bit incrementing packet counter that provides replay
  *    protection (if not disabled by \c \-\-no-replay).
  *  - \b Timestamp, a 32-bit timestamp of the current time.
@@ -249,17 +248,13 @@ struct crypto_options
 #define CO_PACKET_ID_LONG_FORM  (1<<0)
     /**< Bit-flag indicating whether to use
     *   OpenVPN's long packet ID format. */
-#define CO_USE_IV               (1<<1)
-    /**< Bit-flag indicating whether to
-     *   generate a pseudo-random IV for each
-     *   packet being encrypted. */
-#define CO_IGNORE_PACKET_ID     (1<<2)
+#define CO_IGNORE_PACKET_ID     (1<<1)
     /**< Bit-flag indicating whether to ignore
      *   the packet ID of a received packet.
      *   This flag is used during processing
      *   of the first packet received from a
      *   client. */
-#define CO_MUTE_REPLAY_WARNINGS (1<<3)
+#define CO_MUTE_REPLAY_WARNINGS (1<<2)
     /**< Bit-flag indicating not to display
      *   replay warnings. */
     unsigned int flags;         /**< Bit-flags determining behavior of
@@ -288,7 +283,7 @@ int read_passphrase_hash(const char *passphrase_file,
 
 void generate_key_random(struct key *key, const struct key_type *kt);
 
-void check_replay_iv_consistency(const struct key_type *kt, bool packet_id, bool use_iv);
+void check_replay_consistency(const struct key_type *kt, bool packet_id);
 
 bool check_key(struct key *key, const struct key_type *kt);
 
@@ -418,7 +413,6 @@ bool crypto_check_replay(struct crypto_options *opt,
 /** Calculate crypto overhead and adjust frame to account for that */
 void crypto_adjust_frame_parameters(struct frame *frame,
                                     const struct key_type *kt,
-                                    bool use_iv,
                                     bool packet_id,
                                     bool packet_id_long_form);
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9a3e29d..b2547f4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2351,11 +2351,6 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
     init_crypto_pre(c, flags);
 
     /* Initialize flags */
-    if (c->options.use_iv)
-    {
-        c->c2.crypto_options.flags |= CO_USE_IV;
-    }
-
     if (c->options.mute_replay_warnings)
     {
         c->c2.crypto_options.flags |= CO_MUTE_REPLAY_WARNINGS;
@@ -2396,13 +2391,11 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
     c->c2.crypto_options.key_ctx_bi = c->c1.ks.static_key;
 
     /* Compute MTU parameters */
-    crypto_adjust_frame_parameters(&c->c2.frame,
-                                   &c->c1.ks.key_type,
-                                   options->use_iv, options->replay, true);
+    crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
+                                   options->replay, true);
 
-    /* Sanity check on IV, sequence number, and cipher mode options */
-    check_replay_iv_consistency(&c->c1.ks.key_type, options->replay,
-                                options->use_iv);
+    /* Sanity check on sequence number, and cipher mode options */
+    check_replay_consistency(&c->c1.ks.key_type, options->replay);
 }
 
 /*
@@ -2529,9 +2522,8 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         return;
     }
 
-    /* Sanity check on IV, sequence number, and cipher mode options */
-    check_replay_iv_consistency(&c->c1.ks.key_type, options->replay,
-                                options->use_iv);
+    /* Sanity check on sequence number, and cipher mode options */
+    check_replay_consistency(&c->c1.ks.key_type, options->replay);
 
     /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
     packet_id_long_form = cipher_kt_mode_ofb_cfb(c->c1.ks.key_type.cipher);
@@ -2545,18 +2537,13 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     else
     {
         crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
-                                       options->use_iv, options->replay, packet_id_long_form);
+                                       options->replay, packet_id_long_form);
     }
     tls_adjust_frame_parameters(&c->c2.frame);
 
     /* Set all command-line TLS-related options */
     CLEAR(to);
 
-    if (options->use_iv)
-    {
-        to.crypto_flags |= CO_USE_IV;
-    }
-
     if (options->mute_replay_warnings)
     {
         to.crypto_flags |= CO_MUTE_REPLAY_WARNINGS;
@@ -2692,9 +2679,8 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
         to.tls_wrap.opt.pid_persist = &c->c1.pid_persist;
         to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
-        crypto_adjust_frame_parameters(&to.frame,
-                                       &c->c1.ks.tls_auth_key_type,
-                                       false, true, true);
+        crypto_adjust_frame_parameters(&to.frame, &c->c1.ks.tls_auth_key_type,
+                                       true, true);
     }
 
     /* TLS handshake encryption (--tls-crypt) */
@@ -2980,10 +2966,6 @@ do_option_warnings(struct context *c)
     {
         msg(M_WARN, "WARNING: You have disabled Replay Protection (--no-replay) which may make " PACKAGE_NAME " less secure");
     }
-    if (!o->use_iv)
-    {
-        msg(M_WARN, "WARNING: You have disabled Crypto IVs (--no-iv) which may make " PACKAGE_NAME " less secure");
-    }
 
     if (o->tls_server)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bfedb6a..1ebf866 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -551,7 +551,6 @@ static const char usage_message[] =
     "--replay-window n [t]  : Use a replay protection sliding window of size n\n"
     "                         and a time window of t seconds.\n"
     "                         Default n=%d t=%d\n"
-    "--no-iv         : Disable cipher IV -- only allowed with CBC mode ciphers.\n"
     "--replay-persist file : Persist replay-protection state across sessions\n"
     "                  using file.\n"
     "--test-crypto   : Run a self-test of crypto features enabled.\n"
@@ -863,7 +862,6 @@ init_options(struct options *o, const bool init_gc)
     o->replay = true;
     o->replay_window = DEFAULT_SEQ_BACKTRACK;
     o->replay_time = DEFAULT_TIME_BACKTRACK;
-    o->use_iv = true;
     o->key_direction = KEY_DIRECTION_BIDIRECTIONAL;
 #ifdef ENABLE_PREDICTION_RESISTANCE
     o->use_prediction_resistance = false;
@@ -1715,7 +1713,6 @@ show_settings(const struct options *o)
     SHOW_INT(replay_window);
     SHOW_INT(replay_time);
     SHOW_STR(packet_id_file);
-    SHOW_BOOL(use_iv);
     SHOW_BOOL(test_crypto);
 #ifdef ENABLE_PREDICTION_RESISTANCE
     SHOW_BOOL(use_prediction_resistance);
@@ -2476,14 +2473,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
     {
         msg(M_USAGE, "NCP cipher list contains unsupported ciphers.");
     }
-    if (options->ncp_enabled && !options->use_iv)
-    {
-        msg(M_USAGE, "--no-iv not allowed when NCP is enabled.");
-    }
-    if (!options->use_iv)
-    {
-        msg(M_WARN, "WARNING: --no-iv is deprecated and will be removed in 2.5");
-    }
 
     /*
      * Check consistency of replay options
@@ -3447,8 +3436,8 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
         init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
                       false);
         frame_add_to_extra_frame(&fake_frame, -(crypto_max_overhead()));
-        crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->use_iv,
-                                       o->replay, cipher_kt_mode_ofb_cfb(fake_kt.cipher));
+        crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
+                                       cipher_kt_mode_ofb_cfb(fake_kt.cipher));
         frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
                        o->ce.tun_mtu_defined, o->ce.tun_mtu);
         msg(D_MTU_DEBUG, "%s: link-mtu %u -> %d", __func__, (unsigned int) link_mtu,
@@ -3493,7 +3482,6 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
  * --keysize
  * --secret
  * --no-replay
- * --no-iv
  *
  * SSL Options:
  *
@@ -3627,10 +3615,6 @@ options_string(const struct options *o,
         {
             buf_printf(&out, ",no-replay");
         }
-        if (!o->use_iv)
-        {
-            buf_printf(&out, ",no-iv");
-        }
 
 #ifdef ENABLE_PREDICTION_RESISTANCE
         if (o->use_prediction_resistance)
@@ -7559,8 +7543,8 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "no-iv") && !p[1])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->use_iv = false;
+        msg(msglevel,
+            "--no-iv is no longer supported. Remove it from client and server configs.");
     }
     else if (streq(p[0], "replay-persist") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b3ab029..dc63aed 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -483,7 +483,6 @@ struct options
     int replay_window;
     int replay_time;
     const char *packet_id_file;
-    bool use_iv;
     bool test_crypto;
 #ifdef ENABLE_PREDICTION_RESISTANCE
     bool use_prediction_resistance;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cff4052..de66325 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1967,7 +1967,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     /* Update frame parameters: undo worst-case overhead, add actual overhead */
     frame_add_to_extra_frame(frame, -(crypto_max_overhead()));
     crypto_adjust_frame_parameters(frame, &session->opt->key_type,
-                                   options->use_iv, options->replay, packet_id_long_form);
+                                   options->replay, packet_id_long_form);
     frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
                    options->ce.tun_mtu_defined, options->ce.tun_mtu);
     frame_init_mssfix(frame, options);
-- 
2.7.4


