From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 10 Sep 2024 12:46:21 +0200
Message-Id: <20240910104621.238603-1-frank@...2641...>
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] Implement support for larger packet
 counter sizes
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
Cc: Arne Schwabe <arne@...1227...>, Lev Stipakov <lev@...515...>

From: Arne Schwabe <arne@...1227...>

With DCO and possible future hardware assisted OpenVPN acceleration we
are approaching the point where 32 bit IVs are not cutting it any more.

To illustrate the problem, some back of the envelope math here:

If we want to keep the current 3600s renegotiation interval and have
a safety margin of 25% (when we trigger renegotiation) we have about
3.2 million packets (2*32 * 0.7) to work with. That translates to
about 835k packets per second.

With 1300 Byte packets that translates into 8-9 Gbit/s. That is far
from unrealistic any more. Current DCO implementations are already in
spitting distance to that or might even reach (for a single client
connection) that if you have extremely fast
single core performance CPU.

This introduces the 64bit packet counters for AEAD data channel
ciphers in TLS mode ciphers. No effort has been made to support
larger packet counters in any other scenario since those are all legacy.

While we still keep the old --secret logic around we use the same
weird unix timestamp + packet counter format to avoid refactoring the
code now and again when we remove --secret code but DCO
implementations are free to use just a single 64 bit counter. One
other small downside of this approach is that when rollover happens
and we get reordering all the older packets are thrown away since
the distance between the packet before and after the rollover is
quite large as we probably jump forward more than 1s (or more than
2^32 packet ids). But this is an obscure edge that we can
(currently) live with.

While this implementation under hood allows one of the two
to be enabled individually we do not expose this functionality
but require the two protocol flags aead-tag-end and pkt-id-64-bit
to be always come together. This allows other data channel
implementations to only support a limited set of data channel
formats.

Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lev@...515...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/507
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

NOTE:
I've added an Acked-by from Lev manually. He did approve version 9
which only has a minimal code-change compared to 10, so I think
it better reflects the discussion.

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c226727..6a639b7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -68,6 +68,7 @@
     const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
     uint8_t *mac_out = NULL;
     const int mac_len = OPENVPN_AEAD_TAG_LENGTH;
+    bool longiv = opt->flags & CO_64_BIT_PKT_ID;
 
     /* IV, packet-ID and implicit IV required for this mode. */
     ASSERT(ctx->cipher);
@@ -86,7 +87,7 @@
         buf_set_write(&iv_buffer, iv, iv_len);
 
         /* IV starts with packet id to make the IV unique for packet */
-        if (!packet_id_write(&opt->packet_id.send, &iv_buffer, false, false))
+        if (!packet_id_write_flat(&opt->packet_id.send, &iv_buffer, longiv))
         {
             msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
             goto err;
@@ -355,6 +356,9 @@
  * Set buf->len to 0 and return false on decrypt error.
  *
  * On success, buf is set to point to plaintext, true is returned.
+ *
+ * This method assumes that everything between ad_start and BPTR(buf) is
+ * authenticated data and therefore has no ad_len parameter
  */
 static bool
 openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
@@ -384,7 +388,11 @@
     /* IV and Packet ID required for this mode */
     ASSERT(packet_id_initialized(&opt->packet_id));
 
-    /* Combine IV from explicit part from packet and implicit part from context */
+    bool longiv = opt->flags & CO_64_BIT_PKT_ID;
+
+    /* Combine IV from explicit part from packet and implicit part from context.
+     * packet_iv_len and implicit_iv are initialised in init_key_contexts
+     * when keys are initialised as well */
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] = { 0 };
         const int iv_len = cipher_ctx_iv_length(ctx->cipher);
@@ -409,7 +417,7 @@
     }
 
     /* Read packet ID from packet */
-    if (!packet_id_read(&pin, buf, false))
+    if (!packet_id_read_flat(&pin, buf, longiv))
     {
         CRYPT_ERROR("error reading packet-id");
     }
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 61184bc..ccaba7c 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -248,8 +248,10 @@
      *   OpenVPN process startups. */
 
 #define CO_PACKET_ID_LONG_FORM  (1<<0)
-    /**< Bit-flag indicating whether to use
-    *   OpenVPN's long packet ID format. */
+    /**< Bit-flag indicating whether to use OpenVPN's long packet ID format.
+     * This format puts [4 byte counter][4byte timestamp] on the wire in
+     * big endian/network endian format.
+     **/
 #define CO_IGNORE_PACKET_ID     (1<<1)
     /**< Bit-flag indicating whether to ignore
      *   the packet ID of a received packet.
@@ -283,6 +285,20 @@
     /**< Bit-flag indicating that the AEAD tag is at the end of the
      *   packet.
      */
+#define CO_64_BIT_PKT_ID  (1<<9)
+    /**< Bit-flag indicating that we should use a 64 bit (8 byte) packet
+     * counter instead of the 32 bit that we use by default. The difference to
+     * the normal CO_PACKET_ID_LONG_FORM packet ID is that this a real 64 bit
+     * big endian number in the wire format.
+     *
+     * This is only used for AEAD encryption. Other encryption (--static,
+     * --tls-crypt, --tls-auth,...) uses the old format for compatibility
+     */
+
+    /* Note that even though this software implementation allows to define
+     * CO_AEAD_TAG_AT_THE_END and CO_64_BIT_PKT_ID independently, we only
+     * allow both to be used together to avoid having to implement
+     * the other variations in other data channel (DCO) implementations */
 
     unsigned int flags;         /**< Bit-flags determining behavior of
                                  *   security operation functions. */
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 035474f..3ce2c31 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -249,6 +249,16 @@
  */
 const char *dco_get_supported_ciphers(void);
 
+/**
+ * Return whether the dco implementation supports the new protocol features of
+ * a 64 bit packet counter and AEAD tag at the end.
+ */
+static inline bool
+dco_supports_data_v3(struct context *c)
+{
+    return false;
+}
+
 #else /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -380,5 +390,10 @@
     return "";
 }
 
+static inline bool
+dco_supports_data_v3(struct context *c)
+{
+    return false;
+}
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dd56961..72d79c6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2311,6 +2311,10 @@
         {
             buf_printf(&out, " aead-tag-end");
         }
+        if (o->imported_protocol_flags & CO_64_BIT_PKT_ID)
+        {
+            buf_printf(&out, " pkt-id-64-bit");
+        }
     }
 
     if (buf_len(&out) > strlen(header))
@@ -2679,6 +2683,19 @@
                 "this server");
             return false;
         }
+
+        /* Ensure that for proto v3 is fully enabled (both tag at end and
+         * 64 bit counter) or not at all to avoid having to test/implement
+         * 4 modes in data channels instead of just two */
+        bool aead_end = (c->options.imported_protocol_flags & CO_AEAD_TAG_AT_THE_END);
+        bool longpktiud = (c->options.imported_protocol_flags & CO_64_BIT_PKT_ID);
+
+        if (aead_end != longpktiud)
+        {
+            msg(D_PUSH_ERRORS, "OPTIONS ERROR: AEAD tag at the end and 64 bit "
+                "packet counter must be enabled together.");
+            return false;
+        }
     }
 
     if (found & OPT_P_PUSH_MTU)
@@ -3277,6 +3294,16 @@
         to.push_peer_info_detail = 1;
     }
 
+    /* Check if the DCO drivers support the new 64bit packet counter and
+     * AEAD tag at the end */
+    if (dco_enabled(options))
+    {
+        to.data_v3_features_supported = dco_supports_data_v3(c);
+    }
+    else
+    {
+        to.data_v3_features_supported = true;
+    }
 
     /* should we not xmit any packets until we get an initial
      * response from client? */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0509911..b7d30bf 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1851,6 +1851,13 @@
         o->imported_protocol_flags |= CO_USE_CC_EXIT_NOTIFY;
     }
 
+    if (tls_multi->session[TM_ACTIVE].opt->data_v3_features_supported
+        && (proto & IV_PROTO_DATA_V3))
+    {
+        o->imported_protocol_flags |= CO_AEAD_TAG_AT_THE_END;
+        o->imported_protocol_flags |= CO_64_BIT_PKT_ID;
+    }
+
     /* Select cipher if client supports Negotiable Crypto Parameters */
 
     /* if we have already created our key, we cannot *change* our own
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 649f48b..2fd2e81 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8723,6 +8723,10 @@
             {
                 options->imported_protocol_flags |= CO_AEAD_TAG_AT_THE_END;
             }
+            else if (streq(p[j], "pkt-id-64-bit"))
+            {
+                options->imported_protocol_flags |= CO_64_BIT_PKT_ID;
+            }
             else
             {
                 msg(msglevel, "Unknown protocol-flags flag: %s", p[j]);
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index be28999..5224879 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -320,6 +320,31 @@
     return true;
 }
 
+bool
+packet_id_read_flat(struct packet_id_net *pin, struct buffer *buf, bool long_form)
+{
+    packet_id_type net_id;
+    net_time_t net_time;
+
+    pin->id = 0;
+    pin->time = 0;
+
+    if (long_form)
+    {
+        if (!buf_read(buf, &net_time, sizeof(net_time)))
+        {
+            return false;
+        }
+        pin->time = ntohtime(net_time);
+    }
+    if (!buf_read(buf, &net_id, sizeof(net_id)))
+    {
+        return false;
+    }
+    pin->id = ntohpid(net_id);
+    return true;
+}
+
 static bool
 packet_id_send_update(struct packet_id_send *p, bool long_form)
 {
@@ -344,6 +369,30 @@
 }
 
 bool
+packet_id_write_flat(struct packet_id_send *p, struct buffer *buf, bool long_form)
+{
+    if (!packet_id_send_update(p, long_form))
+    {
+        return false;
+    }
+
+    const packet_id_type net_id = htonpid(p->id);
+    const net_time_t net_time = htontime(p->time);
+
+    if (long_form && !buf_write(buf, &net_time, sizeof(net_time)))
+    {
+        return false;
+    }
+
+    if (!buf_write(buf, &net_id, sizeof(net_id)))
+    {
+        return false;
+    }
+
+    return true;
+}
+
+bool
 packet_id_write(struct packet_id_send *p, struct buffer *buf, bool long_form,
                 bool prepend)
 {
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 558361a..d4b5f1e 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -244,10 +244,17 @@
  * Read/write a packet ID to/from the buffer.  Short form is sequence number
  * only.  Long form is sequence number and timestamp.
  */
-
 bool packet_id_read(struct packet_id_net *pin, struct buffer *buf, bool long_form);
 
 /**
+ * Variant of packet_id_read that expects the timestamp first and packet
+ * counter after that to form a flat 64bit counter on the wire if we are
+ * using the long form.
+ */
+bool packet_id_read_flat(struct packet_id_net *pin, struct buffer *buf, bool long_form);
+
+
+/**
  * Write a packet ID to buf, and update the packet ID state.
  *
  * @param p             Packet ID state.
@@ -260,6 +267,22 @@
 bool packet_id_write(struct packet_id_send *p, struct buffer *buf,
                      bool long_form, bool prepend);
 
+
+/**
+ * Write a packet ID to buf, and update the packet ID state. This variant
+ * will always use a variant of the packet id that can just be seen as
+ * a flat 64 bit counter.
+ *
+ * @param p             Packet ID state.
+ * @param buf           Buffer to write the packet ID to
+ * @param long_form     If true, also update and write time_t to buf
+ *
+ * @return true if successful, false otherwise.
+ */
+bool
+packet_id_write_flat(struct packet_id_send *p, struct buffer *buf,
+                     bool long_form);
+
 /*
  * Inline functions.
  */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6c06374..0397e0c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -693,6 +693,10 @@
     {
         buf_printf(&proto_flags, " aead-tag-end");
     }
+    if (o->imported_protocol_flags & CO_64_BIT_PKT_ID)
+    {
+        buf_printf(&proto_flags, " pkt-id-64-bit");
+    }
 
     if (buf_len(&proto_flags) > 0)
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e2be614..aafa9f2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -105,9 +105,11 @@
  * @param ctx                   Encrypt/decrypt key context
  * @param key                   HMAC key, used to calculate implicit IV
  * @param key_len               HMAC key length
+ * @param long_pkt_id           64-bit packet counters are used
  */
 static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len);
+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len,
+                           bool long_pkt_id);
 
 
 /**
@@ -1388,13 +1390,15 @@
     }
     else
     {
+        bool longiv = ks->crypto_options.flags & CO_64_BIT_PKT_ID;
         init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
         /* Initialize implicit IVs */
-        key_ctx_update_implicit_iv(&key->encrypt, key2->keys[(int)server].hmac,
-                                   MAX_HMAC_KEY_LENGTH);
+        key_ctx_update_implicit_iv(&key->encrypt,
+                                   key2->keys[(int)server].hmac,
+                                   MAX_HMAC_KEY_LENGTH, longiv);
         key_ctx_update_implicit_iv(&key->decrypt,
                                    key2->keys[1 - (int)server].hmac,
-                                   MAX_HMAC_KEY_LENGTH);
+                                   MAX_HMAC_KEY_LENGTH, longiv);
     }
 }
 
@@ -1532,14 +1536,14 @@
 }
 
 static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)
+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key,
+                           size_t key_len, bool longiv)
 {
     /* Only use implicit IV in AEAD cipher mode, where HMAC key is not used */
     if (cipher_ctx_mode_aead(ctx->cipher))
     {
-        size_t impl_iv_len = 0;
         ASSERT(cipher_ctx_iv_length(ctx->cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
-        impl_iv_len = cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_id_type);
+        size_t impl_iv_len = cipher_ctx_iv_length(ctx->cipher) - packet_id_size(longiv);
         ASSERT(impl_iv_len <= OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <= key_len);
         memcpy(ctx->implicit_iv, key, impl_iv_len);
@@ -1975,6 +1979,12 @@
         iv_proto |= IV_PROTO_DYN_TLS_CRYPT;
 #endif
 
+        /* support for AEAD tag at the end and 8 byte IV */
+        if (session->opt->data_v3_features_supported)
+        {
+            iv_proto |= IV_PROTO_DATA_V3;
+        }
+
         buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
 
         if (session->opt->push_peer_info_detail > 1)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index eea1323..e72b0e5 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -107,6 +107,9 @@
 /** Support to dynamic tls-crypt (renegotiation with TLS-EKM derived tls-crypt key) */
 #define IV_PROTO_DYN_TLS_CRYPT   (1<<9)
 
+/** Support for the AEAD tag at the end and larger AEAD packet id */
+#define IV_PROTO_DATA_V3        (1<<10)
+
 /** Supports the --dns option after all the incompatible changes */
 #define IV_PROTO_DNS_OPTION_V2   (1<<11)
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 5bc2f2a..80bb502 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -314,7 +314,6 @@
 
     /* from command line */
     bool single_session;
-    bool disable_occ;
     int mode;
     bool pull;
     /**
@@ -364,6 +363,11 @@
     const char *config_ciphername;
     const char *config_ncp_ciphers;
 
+
+    /** whether our underlying data channel supports new data channel
+     * features. This is always true for the internal implementation but
+     * can be false for DCO implementations */
+    bool data_v3_features_supported;
     bool tls_crypt_v2;
     const char *tls_crypt_v2_verify_script;
 
@@ -493,8 +497,6 @@
      */
     int key_id;
 
-    int limit_next;             /* used for traffic shaping on the control channel */
-
     int verify_maxlevel;
 
     char *common_name;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 968858e..a7a7c2f 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -430,6 +430,12 @@
         session->opt->crypto_flags |= CO_USE_CC_EXIT_NOTIFY;
     }
 
+    if (session->opt->data_v3_features_supported && (iv_proto_peer & IV_PROTO_DATA_V3))
+    {
+        session->opt->crypto_flags |= CO_AEAD_TAG_AT_THE_END;
+        session->opt->crypto_flags |= CO_64_BIT_PKT_ID;
+    }
+
 #if defined(HAVE_EXPORT_KEYING_MATERIAL)
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index a1ca344..e3d03e6 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -192,7 +192,7 @@
 {
     struct gc_arena gc = gc_new();
 
-    struct tls_root_ctx ctx = { 0 };
+    struct tls_root_ctx ctx = {0};
     tls_ctx_client_new(&ctx);
     tls_ctx_load_cert_file(&ctx, unittest_cert, true);
 
@@ -278,19 +278,22 @@
 }
 
 static void
-init_implicit_iv(struct crypto_options *co)
+init_implicit_iv(struct crypto_options *co, struct key2 *key2)
 {
     cipher_ctx_t *cipher = co->key_ctx_bi.encrypt.cipher;
 
+
     if (cipher_ctx_mode_aead(cipher))
     {
-        size_t impl_iv_len = cipher_ctx_iv_length(cipher) - sizeof(packet_id_type);
+        bool longiv = co->flags & CO_64_BIT_PKT_ID;
+
+        size_t impl_iv_len = cipher_ctx_iv_length(cipher) - packet_id_size(longiv);
         ASSERT(cipher_ctx_iv_length(cipher) <= OPENVPN_MAX_IV_LENGTH);
         ASSERT(cipher_ctx_iv_length(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
 
         /* Generate dummy implicit IV */
-        ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
-                          OPENVPN_MAX_IV_LENGTH));
+        ASSERT(memcpy(co->key_ctx_bi.encrypt.implicit_iv, key2->keys[0].hmac,
+                      OPENVPN_MAX_IV_LENGTH));
         co->key_ctx_bi.encrypt.implicit_iv_len = impl_iv_len;
 
         memcpy(co->key_ctx_bi.decrypt.implicit_iv,
@@ -349,7 +352,6 @@
     /* init work */
     ASSERT(buf_init(&work, frame.buf.headroom));
 
-    init_implicit_iv(co);
     update_time();
 
     /* Test encryption, decryption for all packet sizes */
@@ -389,24 +391,36 @@
     gc_free(&gc);
 }
 
-
-
 struct crypto_options
-init_crypto_options(const char *cipher, const char *auth)
+init_crypto_options(const char *cipher, const char *auth, int flags,
+                    struct key2 *statickey)
 {
-    struct key2 key2 = { .n = 2};
+    struct key2 key2 = {.n = 2};
 
-    ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].cipher)));
-    ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));
-    ASSERT(rand_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher)));
-    ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac));
+    if (statickey)
+    {
+        /* Use chosen static key instead of random key when defined */
+        key2 = *statickey;
+    }
+    else
+    {
+        ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].cipher)));
+        ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));
+        ASSERT(rand_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher)));
+        ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac));
 
-    struct crypto_options co = { 0 };
+    }
+
+    struct crypto_options co = {0};
 
     struct key_type kt = create_kt(cipher, auth, "ssl-test");
 
     init_key_ctx_bi(&co.key_ctx_bi, &key2, 0, &kt, "unit-test-ssl");
-    packet_id_init(&co.packet_id,  5, 5, "UNITTEST", 0);
+    packet_id_init(&co.packet_id, 5, 5, "UNITTEST", 0);
+
+    co.flags |= flags;
+
+    init_implicit_iv(&co, &key2);
 
     return co;
 }
@@ -416,7 +430,6 @@
 {
     packet_id_free(&co->packet_id);
     free_key_ctx_bi(&co->key_ctx_bi);
-
 }
 
 /* This adds a few more methods than strictly necessary but this allows
@@ -425,8 +438,27 @@
 static void
 run_data_channel_with_cipher_end(const char *cipher)
 {
-    struct crypto_options co = init_crypto_options(cipher, "none");
-    co.flags |= CO_AEAD_TAG_AT_THE_END;
+    struct crypto_options co = init_crypto_options(cipher, "none",
+                                                   CO_AEAD_TAG_AT_THE_END, NULL);
+
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
+
+static void
+run_data_channel_with_cipher_end_and_long_pkt_counter(const char *cipher)
+{
+    struct crypto_options co = init_crypto_options(cipher, "none",
+                                                   CO_AEAD_TAG_AT_THE_END | CO_64_BIT_PKT_ID, NULL);
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
+
+static void
+run_data_channel_with_long_pkt_counter(const char *cipher)
+{
+    struct crypto_options co = init_crypto_options(cipher, "none",
+                                                   CO_64_BIT_PKT_ID, NULL);
     do_data_channel_round_trip(&co);
     uninit_crypto_options(&co);
 }
@@ -434,31 +466,36 @@
 static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
 {
-    struct crypto_options co = init_crypto_options(cipher, auth);
+    struct crypto_options co = init_crypto_options(cipher, auth, 0, NULL);
     do_data_channel_round_trip(&co);
     uninit_crypto_options(&co);
 }
 
+static void
+run_aead_channel_tests(const char *cipher)
+{
+    run_data_channel_with_cipher_end(cipher);
+    run_data_channel_with_cipher(cipher, "none");
+    run_data_channel_with_cipher_end_and_long_pkt_counter(cipher);
+    run_data_channel_with_long_pkt_counter(cipher);
+}
 
 static void
 test_data_channel_roundtrip_aes_128_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-128-GCM");
-    run_data_channel_with_cipher("AES-128-GCM", "none");
+    run_aead_channel_tests("AES-128-GCM");
 }
 
 static void
 test_data_channel_roundtrip_aes_192_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-192-GCM");
-    run_data_channel_with_cipher("AES-192-GCM", "none");
+    run_aead_channel_tests("AES-192-GCM");
 }
 
 static void
 test_data_channel_roundtrip_aes_256_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-256-GCM");
-    run_data_channel_with_cipher("AES-256-GCM", "none");
+    run_aead_channel_tests("AES-256-GCM");
 }
 
 static void
@@ -488,8 +525,7 @@
         return;
     }
 
-    run_data_channel_with_cipher_end("ChaCha20-Poly1305");
-    run_data_channel_with_cipher("ChaCha20-Poly1305", "none");
+    run_aead_channel_tests("ChaCha20-Poly1305");
 }
 
 static void
@@ -503,6 +539,155 @@
     run_data_channel_with_cipher("BF-CBC", "SHA1");
 }
 
+static struct key2
+create_key(void)
+{
+    struct key2 key2 = {.n = 2};
+
+    const uint8_t key[] =
+    {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', '0', '1', '2', '3', '4', '5', '6', '7', 'A', 'B', 'C', 'D', 'E', 'F',
+     'G', 'H', 'j', 'k', 'u', 'c', 'h', 'e', 'n', 'l'};
+
+    static_assert(sizeof(key) == 32, "Size of key should be 32 bytes");
+
+    /* copy the key a few times to ensure to have the size we need for
+     * Statickey but XOR it to not repeat it */
+    uint8_t keydata[sizeof(key2.keys)];
+
+    for (int i = 0; i < sizeof(key2.keys); i++)
+    {
+        keydata[i] = (uint8_t) (key[i % sizeof(key)] ^ i);
+    }
+
+
+    ASSERT(memcpy(key2.keys[0].cipher, keydata, sizeof(key2.keys[0].cipher)));
+    ASSERT(memcpy(key2.keys[0].hmac, keydata + 64, sizeof(key2.keys[0].hmac)));
+    ASSERT(memcpy(key2.keys[1].cipher, keydata + 128, sizeof(key2.keys[1].cipher)));
+    ASSERT(memcpy(key2.keys[1].hmac, keydata + 192, sizeof(key2.keys)[1].hmac));
+
+    return key2;
+}
+
+static void
+test_data_channel_known_vectors_run(bool longpktcounter)
+{
+    struct key2 key2 = create_key();
+
+    int flags = longpktcounter ? CO_64_BIT_PKT_ID : 0;
+    flags |= CO_AEAD_TAG_AT_THE_END;
+
+    struct crypto_options co = init_crypto_options("AES-256-GCM", "none", flags,
+                                                   &key2);
+
+    struct gc_arena gc = gc_new();
+
+    /* initialise frame for the test */
+    struct frame frame;
+    init_frame_parameters(&frame);
+
+    struct buffer src = alloc_buf_gc(frame.buf.payload_size, &gc);
+    struct buffer work = alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer encrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer decrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer buf = clear_buf();
+    void *buf_p;
+
+    /* init work */
+    ASSERT(buf_init(&work, frame.buf.headroom));
+
+    now = 0;
+
+    /* msg(M_INFO, "TESTING ENCRYPT/DECRYPT of packet length=%d", i); */
+
+    /*
+     * Load src with known data.
+     */
+    ASSERT(buf_init(&src, 0));
+    const char *plaintext = "The quick little fox jumps over the bureaucratic hurdles";
+
+    ASSERT(buf_write(&src, plaintext, strlen(plaintext)));
+
+    /* copy source to input buf */
+    buf = work;
+    buf_p = buf_write_alloc(&buf, BLEN(&src));
+    ASSERT(buf_p);
+    memcpy(buf_p, BPTR(&src), BLEN(&src));
+
+    /* initialize work buffer with buf.headroom bytes of prepend capacity */
+    ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
+
+    /* add packet opcode and peer id */
+    buf_write_u8(&encrypt_workspace, 7);
+    buf_write_u8(&encrypt_workspace, 0);
+    buf_write_u8(&encrypt_workspace, 0);
+    buf_write_u8(&encrypt_workspace, 23);
+
+    /* encrypt */
+    openvpn_encrypt(&buf, encrypt_workspace, &co);
+
+    /* separate buffer in authenticated data and encrypted data */
+    uint8_t *ad_start = BPTR(&buf);
+    buf_advance(&buf, 4);
+
+    if (longpktcounter)
+    {
+        uint8_t packetid1[8] = {0, 0, 0, 0, 0, 0, 0, 1};
+        assert_memory_equal(BPTR(&buf), packetid1, 8);
+    }
+    else
+    {
+        uint8_t packetid1[4] = {0, 0, 0, 1};
+        assert_memory_equal(BPTR(&buf), packetid1, 4);
+    }
+
+    uint8_t *tag_location = BEND(&buf) - OPENVPN_AEAD_TAG_LENGTH;
+
+    if (longpktcounter)
+    {
+        const uint8_t exp_tag_long[16] =
+        {0x52, 0xee, 0xef, 0xdb, 0x34, 0xb7, 0xbd, 0x79, 0xfe, 0xbf, 0x69, 0xd0, 0x4e, 0x92, 0xfe, 0x4b};
+        assert_memory_equal(tag_location, exp_tag_long, OPENVPN_AEAD_TAG_LENGTH);
+    }
+    else
+    {
+        const uint8_t exp_tag_short[16] =
+        {0x1f, 0xdd, 0x90, 0x8f, 0x0e, 0x9d, 0xc2, 0x5e, 0x79, 0xd8, 0x32, 0x02, 0x0d, 0x58, 0xe7, 0x3f};
+        assert_memory_equal(tag_location, exp_tag_short, OPENVPN_AEAD_TAG_LENGTH);
+    }
+
+    if (longpktcounter)
+    {
+        const uint8_t bytesat14[6] = {0xc7, 0x40, 0x47, 0x81, 0xac, 0x8c};
+        assert_memory_equal(BPTR(&buf) + 14, bytesat14, sizeof(bytesat14));
+    }
+    else
+    {
+        const uint8_t bytesat14[6] = {0xa8, 0x2e, 0x6b, 0x17, 0x06, 0xd9};
+        assert_memory_equal(BPTR(&buf) + 14, bytesat14, sizeof(bytesat14));
+    }
+
+    /* decrypt */
+    openvpn_decrypt(&buf, decrypt_workspace, &co, &frame, ad_start);
+
+    /* compare */
+    assert_int_equal(buf.len, strlen(plaintext));
+    assert_memory_equal(BPTR(&buf), plaintext, strlen(plaintext));
+
+    uninit_crypto_options(&co);
+    gc_free(&gc);
+}
+
+static void
+test_data_channel_known_vectors_longpktid(void **state)
+{
+    test_data_channel_known_vectors_run(true);
+}
+
+static void
+test_data_channel_known_vectors_shortpktid(void **state)
+{
+    test_data_channel_known_vectors_run(false);
+}
 
 int
 main(void)
@@ -521,6 +706,8 @@
         cmocka_unit_test(test_data_channel_roundtrip_aes_192_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
+        cmocka_unit_test(test_data_channel_known_vectors_longpktid),
+        cmocka_unit_test(test_data_channel_known_vectors_shortpktid)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

