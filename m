From: Arne Schwabe <arne@...1227...>
Date: Mon, 13 Jul 2020 11:46:46 +0200
Message-Id: <20200713094646.13929-3-arne@...1227...>
In-Reply-To: <20200713094646.13929-1-arne@...1227...>
References: <20200713094646.13929-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/3] Remove key-method 1
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
 doc/doxygen/doc_control_processor.h |   6 +-
 doc/doxygen/doc_key_generation.h    |   6 +-
 doc/doxygen/doc_protocol_overview.h |   2 +-
 src/openvpn/forward.c               |   2 +-
 src/openvpn/helper.c                |   5 -
 src/openvpn/init.c                  |   1 -
 src/openvpn/options.c               |  37 +-----
 src/openvpn/options.h               |   4 -
 src/openvpn/ssl.c                   | 180 +++-------------------------
 src/openvpn/ssl.h                   |   6 +-
 src/openvpn/ssl_common.h            |   1 -
 11 files changed, 23 insertions(+), 227 deletions(-)

diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_processor.h
index f87324cc..1bbf2d2d 100644
--- a/doc/doxygen/doc_control_processor.h
+++ b/doc/doxygen/doc_control_processor.h
@@ -175,11 +175,7 @@
  *    appropriate messages to be sent.
  *
  * @par Functions which control data channel key generation
- *  - Key method 1 key exchange functions:
- *     - \c key_method_1_write(), generates and processes key material to
- *       be sent to the remote OpenVPN peer.
- *     - \c key_method_1_read(), processes key material received from the
- *       remote OpenVPN peer.
+ *  - Key method 1 key exchange functions were removed from OpenVPN 2.5
  *  - Key method 2 key exchange functions:
  *     - \c key_method_2_write(), generates and processes key material to
  *       be sent to the remote OpenVPN peer.
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
index efe61155..4bb9c708 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -131,11 +131,7 @@ S_ACTIVE                                                            S_ACTIVE
  * control_processor Control Channel Processor module's\endlink \c
  * tls_process() function and control the %key generation and exchange
  * process as follows:
- * - %Key method 1:
- *   - \c key_method_1_write(): generate random material locally, and load
- *     as "sending" keys.
- *   - \c key_method_1_read(): read random material received from remote
- *     peer, and load as "receiving" keys.
+ * - %Key method 1 has been removed in OpenVPN 2.5
  * - %Key method 2:
  *   - \c key_method_2_write(): generate random material locally, and if
  *     in server mode generate %key expansion.
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
index 3f48b18a..08212223 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -150,7 +150,7 @@
  *
  * @subsection network_protocol_control_plaintext Structure of plaintext control channel messages
  *
- *  - %Key method 1:
+ *  - %Key method 1 (support removed in OpenVPN 2.5):
  *     - Cipher %key length in bytes (1 byte).
  *     - Cipher %key (n bytes).
  *     - HMAC %key length in bytes (1 byte).
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5c4370a8..34124b6f 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1100,7 +1100,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
                                 floated, &ad_start))
             {
                 /* Restore pre-NCP frame parameters */
-                if (is_hard_reset(opcode, c->options.key_method))
+                if (is_hard_reset(opcode, KEY_METHOD_2))
                 {
                     c->c2.frame = c->c2.frame_initial;
 #ifdef ENABLE_FRAGMENT
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 6e9cc63c..a1d03070 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -490,11 +490,6 @@ helper_client_server(struct options *o)
      */
     if (o->client)
     {
-        if (o->key_method != 2)
-        {
-            msg(M_USAGE, "--client requires --key-method 2");
-        }
-
         o->pull = true;
         o->tls_client = true;
     }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e9c01629..b96d1471 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2852,7 +2852,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.ssl_ctx = c->c1.ks.ssl_ctx;
     to.key_type = c->c1.ks.key_type;
     to.server = options->tls_server;
-    to.key_method = options->key_method;
     to.replay = options->replay;
     to.replay_window = options->replay_window;
     to.replay_time = options->replay_time;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 345e0b29..e667ca21 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -886,7 +886,6 @@ init_options(struct options *o, const bool init_gc)
 #ifdef ENABLE_PREDICTION_RESISTANCE
     o->use_prediction_resistance = false;
 #endif
-    o->key_method = 2;
     o->tls_timeout = 2;
     o->renegotiate_bytes = -1;
     o->renegotiate_seconds = 3600;
@@ -1709,7 +1708,6 @@ show_settings(const struct options *o)
 
     SHOW_BOOL(tls_server);
     SHOW_BOOL(tls_client);
-    SHOW_INT(key_method);
     SHOW_STR(ca_file);
     SHOW_STR(ca_path);
     SHOW_STR(dh_file);
@@ -2370,10 +2368,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         {
             msg(M_USAGE, "--ccd-exclusive must be used with --client-config-dir");
         }
-        if (options->key_method != 2)
-        {
-            msg(M_USAGE, "--mode server requires --key-method 2");
-        }
         if (options->auth_token_generate && !options->renegotiate_seconds)
         {
             msg(M_USAGE, "--auth-gen-token needs a non-infinite "
@@ -2540,13 +2534,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
             "may accept clients which do not present a certificate");
     }
 
-    if (options->key_method == 1)
-    {
-        msg(M_WARN, "WARNING: --key-method 1 is deprecated and will be removed "
-            "in OpenVPN 2.5.  By default --key-method 2 will be used if not set "
-            "in the configuration file, which is the recommended approach.");
-    }
-
     const int tls_version_max =
         (options->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
         & SSLF_TLS_VERSION_MAX_MASK;
@@ -2788,7 +2775,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         MUST_BE_UNDEF(push_peer_info);
         MUST_BE_UNDEF(tls_exit);
         MUST_BE_UNDEF(crl_file);
-        MUST_BE_UNDEF(key_method);
         MUST_BE_UNDEF(ns_cert_type);
         MUST_BE_UNDEF(remote_cert_ku[0]);
         MUST_BE_UNDEF(remote_cert_eku);
@@ -3817,10 +3803,9 @@ options_string(const struct options *o,
              * tls-auth/tls-crypt does not match.  Removing tls-auth here would
              * break stuff, so leaving that in place. */
 
-            if (o->key_method > 1)
-            {
-                buf_printf(&out, ",key-method %d", o->key_method);
-            }
+
+
+            buf_printf(&out, ",key-method %d", 2);
         }
 
         if (remote)
@@ -8459,22 +8444,6 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->tls_crypt_v2_verify_script = p[1];
     }
-    else if (streq(p[0], "key-method") && p[1] && !p[2])
-    {
-        int key_method;
-
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        key_method = atoi(p[1]);
-        if (key_method < KEY_METHOD_MIN || key_method > KEY_METHOD_MAX)
-        {
-            msg(msglevel, "key_method parameter (%d) must be >= %d and <= %d",
-                key_method,
-                KEY_METHOD_MIN,
-                KEY_METHOD_MAX);
-            goto err;
-        }
-        options->key_method = key_method;
-    }
     else if (streq(p[0], "x509-track") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 1b038c91..3546bab3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -572,10 +572,6 @@ struct options
 #ifdef ENABLE_CRYPTOAPI
     const char *cryptoapi_cert;
 #endif
-
-    /* data channel key exchange method */
-    int key_method;
-
     /* Per-packet timeout on control channel */
     int tls_timeout;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 00b97352..35c70d71 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1097,23 +1097,14 @@ tls_session_init(struct tls_multi *multi, struct tls_session *session)
     }
 
     /* Are we a TLS server or client? */
-    ASSERT(session->opt->key_method >= 1);
-    if (session->opt->key_method == 1)
+    if (session->opt->server)
     {
-        session->initial_opcode = session->opt->server ?
-                                  P_CONTROL_HARD_RESET_SERVER_V1 : P_CONTROL_HARD_RESET_CLIENT_V1;
+        session->initial_opcode = P_CONTROL_HARD_RESET_SERVER_V2;
     }
-    else /* session->opt->key_method >= 2 */
+    else
     {
-        if (session->opt->server)
-        {
-            session->initial_opcode = P_CONTROL_HARD_RESET_SERVER_V2;
-        }
-        else
-        {
-            session->initial_opcode = session->opt->tls_crypt_v2 ?
-                                      P_CONTROL_HARD_RESET_CLIENT_V3 : P_CONTROL_HARD_RESET_CLIENT_V2;
-        }
+        session->initial_opcode = session->opt->tls_crypt_v2 ?
+                                  P_CONTROL_HARD_RESET_CLIENT_V3 : P_CONTROL_HARD_RESET_CLIENT_V2;
     }
 
     /* Initialize control channel authentication parameters */
@@ -2225,52 +2216,6 @@ read_string_alloc(struct buffer *buf)
     return str;
 }
 
-/*
- * Handle the reading and writing of key data to and from
- * the TLS control channel (cleartext).
- */
-
-static bool
-key_method_1_write(struct buffer *buf, struct tls_session *session)
-{
-    struct key key;
-    struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
-
-    ASSERT(session->opt->key_method == 1);
-    ASSERT(buf_init(buf, 0));
-
-    generate_key_random(&key, &session->opt->key_type);
-    if (!check_key(&key, &session->opt->key_type))
-    {
-        msg(D_TLS_ERRORS, "TLS Error: Bad encrypting key generated");
-        return false;
-    }
-
-    if (!write_key(&key, &session->opt->key_type, buf))
-    {
-        msg(D_TLS_ERRORS, "TLS Error: write_key failed");
-        return false;
-    }
-
-    init_key_ctx(&ks->crypto_options.key_ctx_bi.encrypt, &key,
-                 &session->opt->key_type, OPENVPN_OP_ENCRYPT,
-                 "Data Channel Encrypt");
-    secure_memzero(&key, sizeof(key));
-
-    /* send local options string */
-    {
-        const char *local_options = local_options_string(session);
-        const int optlen = strlen(local_options) + 1;
-        if (!buf_write(buf, local_options, optlen))
-        {
-            msg(D_TLS_ERRORS, "TLS Error: KM1 write options failed");
-            return false;
-        }
-    }
-
-    return true;
-}
-
 static bool
 push_peer_info(struct buffer *buf, struct tls_session *session)
 {
@@ -2394,7 +2339,6 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
-    ASSERT(session->opt->key_method == 2);
     ASSERT(buf_init(buf, 0));
 
     /* write a uint32 0 */
@@ -2404,7 +2348,7 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
     }
 
     /* write key_method + flags */
-    if (!buf_write_u8(buf, (session->opt->key_method & KEY_METHOD_MASK)))
+    if (!buf_write_u8(buf, (KEY_METHOD_2 & KEY_METHOD_MASK)))
     {
         goto error;
     }
@@ -2506,73 +2450,11 @@ error:
     return false;
 }
 
-static bool
-key_method_1_read(struct buffer *buf, struct tls_session *session)
-{
-    int status;
-    struct key key;
-    struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
-
-    ASSERT(session->opt->key_method == 1);
-
-    if (!session->verified)
-    {
-        msg(D_TLS_ERRORS,
-            "TLS Error: Certificate verification failed (key-method 1)");
-        goto error;
-    }
-
-    status = read_key(&key, &session->opt->key_type, buf);
-    if (status != 1)
-    {
-        msg(D_TLS_ERRORS,
-            "TLS Error: Error reading data channel key from plaintext buffer");
-        goto error;
-    }
-
-    if (!check_key(&key, &session->opt->key_type))
-    {
-        msg(D_TLS_ERRORS, "TLS Error: Bad decrypting key received from peer");
-        goto error;
-    }
-
-    if (buf->len < 1)
-    {
-        msg(D_TLS_ERRORS, "TLS Error: Missing options string");
-        goto error;
-    }
-
-#ifdef ENABLE_OCC
-    /* compare received remote options string
-     * with our locally computed options string */
-    if (!session->opt->disable_occ
-        && !options_cmp_equal_safe((char *) BPTR(buf), session->opt->remote_options, buf->len))
-    {
-        options_warning_safe((char *) BPTR(buf), session->opt->remote_options, buf->len);
-    }
-#endif
-
-    buf_clear(buf);
-
-    init_key_ctx(&ks->crypto_options.key_ctx_bi.decrypt, &key,
-                 &session->opt->key_type, OPENVPN_OP_DECRYPT,
-                 "Data Channel Decrypt");
-    secure_memzero(&key, sizeof(key));
-    ks->authenticated = KS_AUTH_TRUE;
-    return true;
-
-error:
-    buf_clear(buf);
-    secure_memzero(&key, sizeof(key));
-    return false;
-}
-
 static bool
 key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
-    int key_method_flags;
     bool username_status, password_status;
 
     struct gc_arena gc = gc_new();
@@ -2582,8 +2464,6 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
     /* allocate temporary objects */
     ALLOC_ARRAY_CLEAR_GC(options, char, TLS_OPTIONS_LEN, &gc);
 
-    ASSERT(session->opt->key_method == 2);
-
     /* discard leading uint32 */
     if (!buf_advance(buf, 4))
     {
@@ -2593,7 +2473,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
     }
 
     /* get key method */
-    key_method_flags = buf_read_u8(buf);
+    int key_method_flags = buf_read_u8(buf);
     if ((key_method_flags & KEY_METHOD_MASK) != 2)
     {
         msg(D_TLS_ERRORS,
@@ -3003,23 +2883,9 @@ tls_process(struct tls_multi *multi,
         if (!buf->len && ((ks->state == S_START && !session->opt->server)
                           || (ks->state == S_GOT_KEY && session->opt->server)))
         {
-            if (session->opt->key_method == 1)
+            if (!key_method_2_write(buf, session))
             {
-                if (!key_method_1_write(buf, session))
-                {
-                    goto error;
-                }
-            }
-            else if (session->opt->key_method == 2)
-            {
-                if (!key_method_2_write(buf, session))
-                {
-                    goto error;
-                }
-            }
-            else
-            {
-                ASSERT(0);
+                goto error;
             }
 
             state_change = true;
@@ -3033,23 +2899,9 @@ tls_process(struct tls_multi *multi,
             && ((ks->state == S_SENT_KEY && !session->opt->server)
                 || (ks->state == S_START && session->opt->server)))
         {
-            if (session->opt->key_method == 1)
-            {
-                if (!key_method_1_read(buf, session))
-                {
-                    goto error;
-                }
-            }
-            else if (session->opt->key_method == 2)
-            {
-                if (!key_method_2_read(buf, multi, session))
-                {
-                    goto error;
-                }
-            }
-            else
+            if (!key_method_2_read(buf, multi, session))
             {
-                ASSERT(0);
+                goto error;
             }
 
             state_change = true;
@@ -3547,11 +3399,10 @@ tls_pre_decrypt(struct tls_multi *multi,
                 struct tls_session *session = &multi->session[TM_ACTIVE];
                 struct key_state *ks = &session->key[KS_PRIMARY];
 
-                if (!is_hard_reset(op, multi->opt.key_method))
+                if (!is_hard_reset(op, KEY_METHOD_2))
                 {
                     msg(D_TLS_ERRORS, "TLS ERROR: initial packet local/remote key_method mismatch, local key_method=%d, op=%s",
-                        multi->opt.key_method,
-                        packet_opcode_name(op));
+                        KEY_METHOD_2, packet_opcode_name(op));
                     goto error;
                 }
 
@@ -3614,11 +3465,10 @@ tls_pre_decrypt(struct tls_multi *multi,
                     goto error;
                 }
 
-                if (!is_hard_reset(op, multi->opt.key_method))
+                if (!is_hard_reset(op, KEY_METHOD_2))
                 {
                     msg(D_TLS_ERRORS, "TLS ERROR: new session local/remote key_method mismatch, local key_method=%d, op=%s",
-                        multi->opt.key_method,
-                        packet_opcode_name(op));
+                        KEY_METHOD_2, packet_opcode_name(op));
                     goto error;
                 }
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 86fb6853..3fcc3654 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -109,11 +109,7 @@
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
 
-/*
- * Range of key exchange methods
- */
-#define KEY_METHOD_MIN 1
-#define KEY_METHOD_MAX 2
+#define KEY_METHOD_2  2
 
 /* key method taken from lower 4 bits */
 #define KEY_METHOD_MASK 0x0F
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e0b3ee56..d904c31f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -262,7 +262,6 @@ struct tls_options
 #endif
 
     /* from command line */
-    int key_method;
     bool replay;
     bool single_session;
 #ifdef ENABLE_OCC
-- 
2.26.2


