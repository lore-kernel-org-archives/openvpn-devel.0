From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 30 Apr 2024 12:13:15 +0000
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <9e5111ed961146922a93ccdf7500cc7adaf0a165-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="47iPcoTiEWo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement support
 for larger packet counter sizes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--47iPcoTiEWo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail

to look at the new patch set (#6).


Change subject: Implement support for larger packet counter sizes
......................................................................

Implement support for larger packet counter sizes

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
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/dco.h
M src/openvpn/init.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/packet_id.c
M src/openvpn/packet_id.h
M src/openvpn/push.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/ssl_common.h
M src/openvpn/ssl_ncp.c
M tests/unit_tests/openvpn/test_ssl.c
14 files changed, 402 insertions(+), 42 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/507/6

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9758c8c..51c9eb9 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -68,6 +68,7 @@
     const struct key_ctx *ctx =3D &opt->key_ctx_bi.encrypt;
     uint8_t *mac_out =3D NULL;
     const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;
+    bool longiv =3D opt->flags & CO_64_BIT_PKT_ID;

     /* IV, packet-ID and implicit IV required for this mode. */
     ASSERT(ctx->cipher);
@@ -86,7 +87,7 @@
         buf_set_write(&iv_buffer, iv, iv_len);

         /* IV starts with packet id to make the IV unique for packet */
-        if (!packet_id_write(&opt->packet_id.send, &iv_buffer, false, fals=
e))
+        if (!packet_id_write_flat(&opt->packet_id.send, &iv_buffer, longiv=
))
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

-    /* Combine IV from explicit part from packet and implicit part from co=
ntext */
+    bool longiv =3D opt->flags & CO_64_BIT_PKT_ID;
+
+    /* Combine IV from explicit part from packet and implicit part from co=
ntext.
+     * packet_iv_len and implicit_iv are initialised in init_key_contexts
+     * when keys are initialised as well */
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };
         const int iv_len =3D cipher_ctx_iv_length(ctx->cipher);
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
+    /**< Bit-flag indicating whether to use OpenVPN's long packet ID forma=
t.
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
+     * counter instead of the 32 bit that we use by default. The differenc=
e to
+     * the normal CO_PACKET_ID_LONG_FORM packet ID is that this a real 64 =
bit
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
index 50ebb35..6d886f4 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -249,6 +249,16 @@
  */
 const char *dco_get_supported_ciphers();

+/**
+ * Return whether the dco implementation supports the new protocol feature=
s of
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
index c56ce48..f0f923b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2316,6 +2316,10 @@
         {
             buf_printf(&out, " aead-tag-end");
         }
+        if (o->imported_protocol_flags & CO_64_BIT_PKT_ID)
+        {
+            buf_printf(&out, " pkt-id-64-bit");
+        }
     }

     if (buf_len(&out) > strlen(header))
@@ -2688,6 +2692,17 @@
                 "this server");
             return false;
         }
+
+        /* Ensure that for proto v3 is enabled fully or not at all */
+        bool aead_end =3D (c->options.imported_protocol_flags & CO_AEAD_TA=
G_AT_THE_END);
+        bool longpktiud =3D (c->options.imported_protocol_flags & CO_64_BI=
T_PKT_ID);
+
+        if (aead_end !=3D longpktiud)
+        {
+            msg(D_PUSH_ERRORS, "OPTIONS ERROR: Aead tag at the end and 64 =
bit"
+                "packet counter must be enabled together.");
+            return false;
+        }
     }

     if (found & OPT_P_PUSH_MTU)
@@ -3286,6 +3301,16 @@
         to.push_peer_info_detail =3D 1;
     }

+    /* Check if the DCO drivers support the new 64bit packet counter and
+     * AEAD tag at the end */
+    if (dco_enabled(options))
+    {
+        to.data_v3_features_supported =3D dco_supports_data_v3(c);
+    }
+    else
+    {
+        to.data_v3_features_supported =3D true;
+    }

     /* should we not xmit any packets until we get an initial
      * response from client? */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 162b23e..4ac2c0d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1851,6 +1851,13 @@
         o->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }

+    if (tls_multi->session[TM_ACTIVE].opt->data_v3_features_supported
+        && (proto & IV_PROTO_DATA_V3))
+    {
+        o->imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_END;
+        o->imported_protocol_flags |=3D CO_64_BIT_PKT_ID;
+    }
+
     /* Select cipher if client supports Negotiable Crypto Parameters */

     /* if we have already created our key, we cannot *change* our own
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 26d2b35..9b98f70 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8687,6 +8687,10 @@
             {
                 options->imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_E=
ND;
             }
+            else if (streq(p[j], "pkt-id-64-bit"))
+            {
+                options->imported_protocol_flags |=3D CO_64_BIT_PKT_ID;
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
+packet_id_read_flat(struct packet_id_net *pin, struct buffer *buf, bool lo=
ng_form)
+{
+    packet_id_type net_id;
+    net_time_t net_time;
+
+    pin->id =3D 0;
+    pin->time =3D 0;
+
+    if (long_form)
+    {
+        if (!buf_read(buf, &net_time, sizeof(net_time)))
+        {
+            return false;
+        }
+        pin->time =3D ntohtime(net_time);
+    }
+    if (!buf_read(buf, &net_id, sizeof(net_id)))
+    {
+        return false;
+    }
+    pin->id =3D ntohpid(net_id);
+    return true;
+}
+
 static bool
 packet_id_send_update(struct packet_id_send *p, bool long_form)
 {
@@ -344,6 +369,30 @@
 }

 bool
+packet_id_write_flat(struct packet_id_send *p, struct buffer *buf, bool lo=
ng_form)
+{
+    if (!packet_id_send_update(p, long_form))
+    {
+        return false;
+    }
+
+    const packet_id_type net_id =3D htonpid(p->id);
+    const net_time_t net_time =3D htontime(p->time);
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
 packet_id_write(struct packet_id_send *p, struct buffer *buf, bool long_fo=
rm,
                 bool prepend)
 {
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 558361a..d4b5f1e 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -244,10 +244,17 @@
  * Read/write a packet ID to/from the buffer.  Short form is sequence numb=
er
  * only.  Long form is sequence number and timestamp.
  */
-
 bool packet_id_read(struct packet_id_net *pin, struct buffer *buf, bool lo=
ng_form);

 /**
+ * Variant of packet_id_read that expects the timestamp first and packet
+ * counter after that to form a flat 64bit counter on the wire if we are
+ * using the long form.
+ */
+bool packet_id_read_flat(struct packet_id_net *pin, struct buffer *buf, bo=
ol long_form);
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
index 10806ac..2f0fc19 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -691,6 +691,10 @@
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
index 7c49451..1a321a1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -105,9 +105,11 @@
  * @param ctx                   Encrypt/decrypt key context
  * @param key                   HMAC key, used to calculate implicit IV
  * @param key_len               HMAC key length
+ * @param long_pkt_id           64-bit packet counters are used
  */
 static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_l=
en);
+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_l=
en,
+                           bool long_pkt_id);


 /**
@@ -1369,13 +1371,15 @@
     }
     else
     {
+        bool longiv =3D ks->crypto_options.flags & CO_64_BIT_PKT_ID;
         init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel"=
);
         /* Initialize implicit IVs */
-        key_ctx_update_implicit_iv(&key->encrypt, key2->keys[(int)server].=
hmac,
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

@@ -1513,14 +1517,15 @@
 }

 static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_l=
en)
+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key,
+                           size_t key_len, bool longiv)
 {
     /* Only use implicit IV in AEAD cipher mode, where HMAC key is not use=
d */
     if (cipher_ctx_mode_aead(ctx->cipher))
     {
         size_t impl_iv_len =3D 0;
         ASSERT(cipher_ctx_iv_length(ctx->cipher) >=3D OPENVPN_AEAD_MIN_IV_=
LEN);
-        impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_=
id_type);
+        impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - packet_id_size=
(longiv);
         ASSERT(impl_iv_len <=3D OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <=3D key_len);
         memcpy(ctx->implicit_iv, key, impl_iv_len);
@@ -1935,6 +1940,12 @@
         iv_proto |=3D IV_PROTO_DYN_TLS_CRYPT;
 #endif

+        /* support for AEAD tag at the end and 8 byte IV */
+        if (session->opt->data_v3_features_supported)
+        {
+            iv_proto |=3D IV_PROTO_DATA_V3;
+        }
+
         buf_printf(&out, "IV_PROTO=3D%d\n", iv_proto);

         if (session->opt->push_peer_info_detail > 1)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 98e59e8..1f770e0 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -107,6 +107,9 @@
 /** Support to dynamic tls-crypt (renegotiation with TLS-EKM derived tls-c=
rypt key) */
 #define IV_PROTO_DYN_TLS_CRYPT   (1<<9)

+/** Support for the AEAD tag at the end and larger AEAD packet id */
+#define IV_PROTO_DATA_V3        (1<<10)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 5a7dd60..dc87c80 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -311,7 +311,6 @@

     /* from command line */
     bool single_session;
-    bool disable_occ;
     int mode;
     bool pull;
     /**
@@ -361,6 +360,11 @@
     const char *config_ciphername;
     const char *config_ncp_ciphers;

+
+    /** whether our underlying data channel supports new data channel
+     * features. This is always true for the internal implementation but
+     * can be false for DCO implementations */
+    bool data_v3_features_supported;
     bool tls_crypt_v2;
     const char *tls_crypt_v2_verify_script;

@@ -490,8 +494,6 @@
      */
     int key_id;

-    int limit_next;             /* used for traffic shaping on the control=
 channel */
-
     int verify_maxlevel;

     char *common_name;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 73ec9f5..bfb8658 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -430,6 +430,12 @@
         session->opt->crypto_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }

+    if (session->opt->data_v3_features_supported && (iv_proto_peer & IV_PR=
OTO_DATA_V3))
+    {
+        session->opt->crypto_flags |=3D CO_AEAD_TAG_AT_THE_END;
+        session->opt->crypto_flags |=3D CO_64_BIT_PKT_ID;
+    }
+
 #if defined(HAVE_EXPORT_KEYING_MATERIAL)
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 8d73858..dd3a108 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -98,7 +98,7 @@
 {
     struct gc_arena gc =3D gc_new();

-    struct tls_root_ctx ctx =3D { 0 };
+    struct tls_root_ctx ctx =3D {0};
     tls_ctx_client_new(&ctx);
     tls_ctx_load_cert_file(&ctx, unittest_cert, true);

@@ -124,19 +124,22 @@
 }

 static void
-init_implicit_iv(struct crypto_options *co)
+init_implicit_iv(struct crypto_options *co, struct key2 *key2)
 {
     cipher_ctx_t *cipher =3D co->key_ctx_bi.encrypt.cipher;

+
     if (cipher_ctx_mode_aead(cipher))
     {
-        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - sizeof(packe=
t_id_type);
+        bool longiv =3D co->flags & CO_64_BIT_PKT_ID;
+
+        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - packet_id_si=
ze(longiv);
         ASSERT(cipher_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH);
         ASSERT(cipher_ctx_iv_length(cipher) >=3D OPENVPN_AEAD_MIN_IV_LEN);

         /* Generate dummy implicit IV */
-        ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
-                          OPENVPN_MAX_IV_LENGTH));
+        ASSERT(memcpy(co->key_ctx_bi.encrypt.implicit_iv, key2->keys[0].hm=
ac,
+                      OPENVPN_MAX_IV_LENGTH));
         co->key_ctx_bi.encrypt.implicit_iv_len =3D impl_iv_len;

         memcpy(co->key_ctx_bi.decrypt.implicit_iv,
@@ -195,7 +198,6 @@
     /* init work */
     ASSERT(buf_init(&work, frame.buf.headroom));

-    init_implicit_iv(co);
     update_time();

     /* Test encryption, decryption for all packet sizes */
@@ -235,24 +237,36 @@
     gc_free(&gc);
 }

-
-
 struct crypto_options
-init_crypto_options(const char *cipher, const char *auth)
+init_crypto_options(const char *cipher, const char *auth, int flags,
+                    struct key2 *statickey)
 {
-    struct key2 key2 =3D { .n =3D 2};
+    struct key2 key2 =3D {.n =3D 2};

-    ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].cipher)));
-    ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));
-    ASSERT(rand_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher)));
-    ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac));
+    if (statickey)
+    {
+        /* Use chosen static key instead of random key when defined */
+        key2 =3D *statickey;
+    }
+    else
+    {
+        ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].cipher)=
));
+        ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));
+        ASSERT(rand_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher)=
));
+        ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac));

-    struct crypto_options co =3D { 0 };
+    }
+
+    struct crypto_options co =3D {0};

     struct key_type kt =3D create_kt(cipher, auth, "ssl-test");

     init_key_ctx_bi(&co.key_ctx_bi, &key2, 0, &kt, "unit-test-ssl");
-    packet_id_init(&co.packet_id,  5, 5, "UNITTEST", 0);
+    packet_id_init(&co.packet_id, 5, 5, "UNITTEST", 0);
+
+    co.flags |=3D flags;
+
+    init_implicit_iv(&co, &key2);

     return co;
 }
@@ -271,8 +285,27 @@
 static void
 run_data_channel_with_cipher_end(const char *cipher)
 {
-    struct crypto_options co =3D init_crypto_options(cipher, "none");
-    co.flags |=3D CO_AEAD_TAG_AT_THE_END;
+    struct crypto_options co =3D init_crypto_options(cipher, "none",
+                                                   CO_AEAD_TAG_AT_THE_END,=
 NULL);
+
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
+
+static void
+run_data_channel_with_cipher_end_and_long_pkt_counter(const char *cipher)
+{
+    struct crypto_options co =3D init_crypto_options(cipher, "none",
+                                                   CO_AEAD_TAG_AT_THE_END =
| CO_64_BIT_PKT_ID, NULL);
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
+
+static void
+run_data_channel_with_long_pkt_counter(const char *cipher)
+{
+    struct crypto_options co =3D init_crypto_options(cipher, "none",
+                                                   CO_64_BIT_PKT_ID, NULL);
     do_data_channel_round_trip(&co);
     uninit_crypto_options(&co);
 }
@@ -280,31 +313,36 @@
 static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
 {
-    struct crypto_options co =3D init_crypto_options(cipher, auth);
+    struct crypto_options co =3D init_crypto_options(cipher, auth, 0, NULL=
);
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
@@ -334,8 +372,7 @@
         return;
     }

-    run_data_channel_with_cipher_end("ChaCha20-Poly1305");
-    run_data_channel_with_cipher("ChaCha20-Poly1305", "none");
+    run_aead_channel_tests("ChaCha20-Poly1305");
 }

 static void
@@ -349,6 +386,154 @@
     run_data_channel_with_cipher("BF-CBC", "SHA1");
 }

+static struct key2
+create_key()
+{
+    struct key2 key2 =3D {.n =3D 2};
+
+    const uint8_t key[] =3D
+    {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', '0', '1', '2', '3', '4', '5',=
 '6', '7', 'A', 'B', 'C', 'D', 'E', 'F',
+     'G', 'H', 'j', 'k', 'u', 'c', 'h', 'e', 'n', 'l'};
+
+    static_assert(sizeof(key) =3D=3D 32, "Size of key should be 32 bytes");
+
+    /* copy the key a few times to ensure to have the size we need for
+     * Statickey but XOR it to not repeat it */
+    uint8_t keydata[sizeof(key2.keys)];
+
+    for (int i =3D 0; i < sizeof(key2.keys); i++)
+    {
+        keydata[i] =3D (uint8_t) (key[i % sizeof(key)] ^ i);
+    }
+
+
+    ASSERT(memcpy(key2.keys[0].cipher, keydata, sizeof(key2.keys[0].cipher=
)));
+    ASSERT(memcpy(key2.keys[0].hmac, keydata + 64, sizeof(key2.keys[0].hma=
c)));
+    ASSERT(memcpy(key2.keys[1].cipher, keydata + 128, sizeof(key2.keys[1].=
cipher)));
+    ASSERT(memcpy(key2.keys[1].hmac, keydata + 192, sizeof(key2.keys)[1].h=
mac));
+
+    return key2;
+}
+
+static void
+test_data_channel_known_vectors_run(bool longpktcounter)
+{
+    struct key2 key2 =3D create_key();
+
+    int flags =3D longpktcounter ? CO_64_BIT_PKT_ID : 0;
+    flags |=3D CO_AEAD_TAG_AT_THE_END;
+
+    struct crypto_options co =3D init_crypto_options("AES-256-GCM", "none"=
, flags,
+                                                   &key2);
+
+    struct gc_arena gc =3D gc_new();
+
+    /* initialise frame for the test */
+    struct frame frame;
+    init_frame_parameters(&frame);
+
+    struct buffer src =3D alloc_buf_gc(frame.buf.payload_size, &gc);
+    struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
+    struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
+    struct buffer buf =3D clear_buf();
+    void *buf_p;
+
+    /* init work */
+    ASSERT(buf_init(&work, frame.buf.headroom));
+
+    now =3D 0;
+
+    /* msg(M_INFO, "TESTING ENCRYPT/DECRYPT of packet length=3D%d", i); */
+
+    /*
+     * Load src with known data.
+     */
+    ASSERT(buf_init(&src, 0));
+    const char *plaintext =3D "The quick little fox jumps over the bureauc=
ratic hurdles";
+
+    ASSERT(buf_write(&src, plaintext, strlen(plaintext)));
+
+    /* copy source to input buf */
+    buf =3D work;
+    buf_p =3D buf_write_alloc(&buf, BLEN(&src));
+    ASSERT(buf_p);
+    memcpy(buf_p, BPTR(&src), BLEN(&src));
+
+    /* initialize work buffer with buf.headroom bytes of prepend capacity =
*/
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
+    uint8_t *ad_start =3D BPTR(&buf);
+    buf_advance(&buf, 4);
+
+    if (longpktcounter)
+    {
+        uint8_t packetid1[8] =3D {0, 0, 0, 0, 0, 0, 0, 1};
+        assert_memory_equal(BPTR(&buf), packetid1, 8);
+    }
+    else
+    {
+        uint8_t packetid1[4] =3D {0, 0, 0, 1};
+        assert_memory_equal(BPTR(&buf), packetid1, 4);
+    }
+
+    uint8_t *tag_location =3D BEND(&buf) - OPENVPN_AEAD_TAG_LENGTH;
+
+    if (longpktcounter)
+    {
+        const uint8_t exp_tag_long[16] =3D
+        {0x52, 0xee, 0xef, 0xdb, 0x34, 0xb7, 0xbd, 0x79, 0xfe, 0xbf, 0x69,=
 0xd0, 0x4e, 0x92, 0xfe, 0x4b};
+        assert_memory_equal(tag_location, exp_tag_long, OPENVPN_AEAD_TAG_L=
ENGTH);
+    }
+    else
+    {
+        const uint8_t exp_tag_short[16] =3D
+        {0x1f, 0xdd, 0x90, 0x8f, 0x0e, 0x9d, 0xc2, 0x5e, 0x79, 0xd8, 0x32,=
 0x02, 0x0d, 0x58, 0xe7, 0x3f};
+        assert_memory_equal(tag_location, exp_tag_short, OPENVPN_AEAD_TAG_=
LENGTH);
+    }
+
+    if (longpktcounter)
+    {
+        const uint8_t bytesat14[6] =3D {0xc7, 0x40, 0x47, 0x81, 0xac, 0x8c=
};
+        assert_memory_equal(BPTR(&buf) + 14, bytesat14, sizeof(bytesat14));
+    }
+    else
+    {
+        const uint8_t bytesat14[6] =3D {0xa8, 0x2e, 0x6b, 0x17, 0x06, 0xd9=
};
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
@@ -365,6 +550,8 @@
         cmocka_unit_test(test_data_channel_roundtrip_aes_192_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
+        cmocka_unit_test(test_data_channel_known_vectors_longpktid),
+        cmocka_unit_test(test_data_channel_known_vectors_shortpktid)
     };

 #if defined(ENABLE_CRYPTO_OPENSSL)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Gerrit-Change-Number: 507
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--47iPcoTiEWo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Implement support for larger packet counter sizes<br><br>With DCO and=
 possible future hardware assisted OpenVPN acceleration we<br>are approachi=
ng the point where 32 bit IVs are not cutting it any more.<br><br>To illust=
rate the problem, some back of the envelope math here:<br><br>If we want to=
 keep the current 3600s renegotiation interval and have<br>a safety margin =
of 25% (when we trigger renegotiation) we have about<br>3.2 million packets=
 (2*32 * 0.7) to work with. That translates to<br>about 835k packets per se=
cond.<br><br>With 1300 Byte packets that translates into 8-9 Gbit/s. That i=
s far<br>from unrealistic any more. Current DCO implementations are already=
 in<br>spitting distance to that or might even reach (for a single client<b=
r>connection) that if you have extremely fast<br>single core performance CP=
U.<br><br>This introduces the 64bit packet counters for AEAD data channel<b=
r>ciphers in TLS mode ciphers. No effort has been made to support<br>larger=
 packet counters in any other scenario since those are all legacy.<br><br>W=
hile we still keep the old --secret logic around we use the same<br>weird u=
nix timestamp + packet counter format to avoid refactoring the<br>code now =
and again when we remove --secret code but DCO<br>implementations are free =
to use just a single 64 bit counter. One<br>other small downside of this ap=
proach is that when rollover happens<br>and we get reordering all the older=
 packets are thrown away since<br>the distance between the packet before an=
d after the rollover is<br>quite large as we probably jump forward more tha=
n 1s (or more than<br>2^32 packet ids). But this is an obscure edge that we=
 can<br>(currently) live with.<br><br>While this implementation under hood =
allows one of the two<br>to be enabled individually we do not expose this f=
unctionality<br>but require the two protocol flags aead-tag-end and pkt-id-=
64-bit<br>to be always come together. This allows other data channel<br>imp=
lementations to only support a limited set of data channel<br>formats.<br><=
br>Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2<br>Signed-off-by: A=
rne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M s=
rc/openvpn/crypto.h<br>M src/openvpn/dco.h<br>M src/openvpn/init.c<br>M src=
/openvpn/multi.c<br>M src/openvpn/options.c<br>M src/openvpn/packet_id.c<br=
>M src/openvpn/packet_id.h<br>M src/openvpn/push.c<br>M src/openvpn/ssl.c<b=
r>M src/openvpn/ssl.h<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl_nc=
p.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>14 files changed, 402 inser=
tions(+), 42 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/07/507/6</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/=
src/openvpn/crypto.c</span><br><span>index 9758c8c..51c9eb9 100644</span><b=
r><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto=
.c</span><br><span>@@ -68,6 +68,7 @@</span><br><span>     const struct key_=
ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.encrypt;</span><br><span>     uint8_t =
*mac_out =3D NULL;</span><br><span>     const int mac_len =3D OPENVPN_AEAD_=
TAG_LENGTH;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 longiv =3D opt-&gt;flags &amp; CO_64_BIT_PKT_ID;</span><br><span> </span><=
br><span>     /* IV, packet-ID and implicit IV required for this mode. */</=
span><br><span>     ASSERT(ctx-&gt;cipher);</span><br><span>@@ -86,7 +87,7 =
@@</span><br><span>         buf_set_write(&amp;iv_buffer, iv, iv_len);</spa=
n><br><span> </span><br><span>         /* IV starts with packet id to make =
the IV unique for packet */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (!packet_id_write(&amp;opt-&gt;packet_id.send, &amp;iv_buf=
fer, false, false))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!packet_id_write_flat(&amp;opt-&gt;packet_id.send, &amp;iv_buff=
er, longiv))</span><br><span>         {</span><br><span>             msg(D_=
CRYPT_ERRORS, &quot;ENCRYPT ERROR: packet ID roll over&quot;);</span><br><s=
pan>             goto err;</span><br><span>@@ -355,6 +356,9 @@</span><br><s=
pan>  * Set buf-&gt;len to 0 and return false on decrypt error.</span><br><=
span>  *</span><br><span>  * On success, buf is set to point to plaintext, =
true is returned.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method assu=
mes that everything between ad_start and BPTR(buf) is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * authenticated data and therefore has n=
o ad_len parameter</span><br><span>  */</span><br><span> static bool</span>=
<br><span> openvpn_decrypt_aead(struct buffer *buf, struct buffer work,</sp=
an><br><span>@@ -384,7 +388,11 @@</span><br><span>     /* IV and Packet ID =
required for this mode */</span><br><span>     ASSERT(packet_id_initialized=
(&amp;opt-&gt;packet_id));</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* Combine IV from explicit part from packet and=
 implicit part from context */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool longiv =3D opt-&gt;flags &amp; CO_64_BIT_PKT_ID;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Combine IV from explicit part from pac=
ket and implicit part from context.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * packet_iv_len and implicit_iv are initialised in ini=
t_key_contexts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* when keys are initialised as well */</span><br><span>     {</span><br><sp=
an>         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };</span><br><span>  =
       const int iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher);</span><br=
><span>@@ -409,7 +417,7 @@</span><br><span>     }</span><br><span> </span><=
br><span>     /* Read packet ID from packet */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!packet_id_read(&amp;pin, buf, false))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!packet_id_read=
_flat(&amp;pin, buf, longiv))</span><br><span>     {</span><br><span>      =
   CRYPT_ERROR(&quot;error reading packet-id&quot;);</span><br><span>     }=
</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</=
span><br><span>index 61184bc..ccaba7c 100644</span><br><span>--- a/src/open=
vpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ =
-248,8 +248,10 @@</span><br><span>      *   OpenVPN process startups. */</s=
pan><br><span> </span><br><span> #define CO_PACKET_ID_LONG_FORM  (1&lt;&lt;=
0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Bit-fla=
g indicating whether to use</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    *   OpenVPN&#39;s long packet ID format. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /**&lt; Bit-flag indicating whether t=
o use OpenVPN&#39;s long packet ID format.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * This format puts [4 byte counter][4byte times=
tamp] on the wire in</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * big endian/network endian format.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     **/</span><br><span> #define CO_IGNORE_PACKET_ID=
     (1&lt;&lt;1)</span><br><span>     /**&lt; Bit-flag indicating whether =
to ignore</span><br><span>      *   the packet ID of a received packet.</sp=
an><br><span>@@ -283,6 +285,20 @@</span><br><span>     /**&lt; Bit-flag ind=
icating that the AEAD tag is at the end of the</span><br><span>      *   pa=
cket.</span><br><span>      */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define CO_64_BIT_PKT_ID  (1&lt;&lt;9)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /**&lt; Bit-flag indicating that we shoul=
d use a 64 bit (8 byte) packet</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * counter instead of the 32 bit that we use by default. The=
 difference to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* the normal CO_PACKET_ID_LONG_FORM packet ID is that this a real 64 bit</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * big endian numb=
er in the wire format.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Thi=
s is only used for AEAD encryption. Other encryption (--static,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * --tls-crypt, --tls-auth,=
...) uses the old format for compatibility</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* N=
ote that even though this software implementation allows to define</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * CO_AEAD_TAG_AT_THE_EN=
D and CO_64_BIT_PKT_ID independently, we only</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * allow both to be used together to avoid ha=
ving to implement</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * the other variations in other data channel (DCO) implementations */</s=
pan><br><span> </span><br><span>     unsigned int flags;         /**&lt; Bi=
t-flags determining behavior of</span><br><span>                           =
       *   security operation functions. */</span><br><span>diff --git a/sr=
c/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index 50ebb35..6d886f4 =
100644</span><br><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/op=
envpn/dco.h</span><br><span>@@ -249,6 +249,16 @@</span><br><span>  */</span=
><br><span> const char *dco_get_supported_ciphers();</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Return whether the dco implementation=
 supports the new protocol features of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * a 64 bit packet counter and AEAD tag at the end.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_supports_data_v3(struct context *c)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> #else /* if defined(ENABLE_DCO) */</span>=
<br><span> </span><br><span> typedef void *dco_context_t;</span><br><span>@=
@ -380,5 +390,10 @@</span><br><span>     return &quot;&quot;;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dco_supports_data_v3(struct context *c)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span> #endif /* defined(ENABLE_DCO) */</span><br><span> #en=
dif /* ifndef DCO_H */</span><br><span>diff --git a/src/openvpn/init.c b/sr=
c/openvpn/init.c</span><br><span>index c56ce48..f0f923b 100644</span><br><s=
pan>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span=
><br><span>@@ -2316,6 +2316,10 @@</span><br><span>         {</span><br><spa=
n>             buf_printf(&amp;out, &quot; aead-tag-end&quot;);</span><br><=
span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (o-&gt;imported_protocol_flags &amp; CO_64_BIT_PKT_ID)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot; p=
kt-id-64-bit&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span>     }</span><br><span> </span><br><span>     if=
 (buf_len(&amp;out) &gt; strlen(header))</span><br><span>@@ -2688,6 +2692,1=
7 @@</span><br><span>                 &quot;this server&quot;);</span><br><=
span>             return false;</span><br><span>         }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* Ensure that for proto v3 is enabled fully or=
 not at all */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   bool aead_end =3D (c-&gt;options.imported_protocol_flags &amp; CO_AEAD_T=
AG_AT_THE_END);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    bool longpktiud =3D (c-&gt;options.imported_protocol_flags &amp; CO_64_=
BIT_PKT_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (aead_end !=3D =
longpktiud)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_=
PUSH_ERRORS, &quot;OPTIONS ERROR: Aead tag at the end and 64 bit&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;pa=
cket counter must be enabled together.&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><b=
r><span> </span><br><span>     if (found &amp; OPT_P_PUSH_MTU)</span><br><s=
pan>@@ -3286,6 +3301,16 @@</span><br><span>         to.push_peer_info_detai=
l =3D 1;</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Check if the DCO drivers support the n=
ew 64bit packet counter and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * AEAD tag at the end */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (dco_enabled(options))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        to.data_v3_features_supported =3D dco_supports_data_v=
3(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        to.data_v3_features_supported =3D true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </=
span><br><span>     /* should we not xmit any packets until we get an initi=
al</span><br><span>      * response from client? */</span><br><span>diff --=
git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 162b2=
3e..4ac2c0d 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><spa=
n>+++ b/src/openvpn/multi.c</span><br><span>@@ -1851,6 +1851,13 @@</span><b=
r><span>         o-&gt;imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (tls_multi-&gt;session[TM_ACTIVE].opt-&gt;data_=
v3_features_supported</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &amp;&amp; (proto &amp; IV_PROTO_DATA_V3))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        o-&gt;imported_protocol_flags |=3D CO_AEAD_TAG_=
AT_THE_END;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
o-&gt;imported_protocol_flags |=3D CO_64_BIT_PKT_ID;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     /* Select cipher if client suppor=
ts Negotiable Crypto Parameters */</span><br><span> </span><br><span>     /=
* if we have already created our key, we cannot *change* our own</span><br>=
<span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br>=
<span>index 26d2b35..9b98f70 100644</span><br><span>--- a/src/openvpn/optio=
ns.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -8687,6=
 +8687,10 @@</span><br><span>             {</span><br><span>               =
  options-&gt;imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_END;</span><b=
r><span>             }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            else if (streq(p[j], &quot;pkt-id-64-bit&quot;))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                options-&gt;imported_=
protocol_flags |=3D CO_64_BIT_PKT_ID;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span>             else</span><br=
><span>             {</span><br><span>                 msg(msglevel, &quot;=
Unknown protocol-flags flag: %s&quot;, p[j]);</span><br><span>diff --git a/=
src/openvpn/packet_id.c b/src/openvpn/packet_id.c</span><br><span>index be2=
8999..5224879 100644</span><br><span>--- a/src/openvpn/packet_id.c</span><b=
r><span>+++ b/src/openvpn/packet_id.c</span><br><span>@@ -320,6 +320,31 @@<=
/span><br><span>     return true;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+packet_id_read_flat(struct packet_id_ne=
t *pin, struct buffer *buf, bool long_form)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    packet_id_type net_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    net_time_t net_time;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   pin-&gt;id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    pin-&gt;time =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (long_f=
orm)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (!buf_read(buf, &a=
mp;net_time, sizeof(net_time)))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      pin-&gt;time =3D ntohtime(net_time);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!buf_read(buf, &amp;net_id, sizeof(net_id)))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    pin-&gt;id =3D ntohpid(net_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> static bool</span><br><span> packet_id_send_=
update(struct packet_id_send *p, bool long_form)</span><br><span> {</span><=
br><span>@@ -344,6 +369,30 @@</span><br><span> }</span><br><span> </span><b=
r><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+packet=
_id_write_flat(struct packet_id_send *p, struct buffer *buf, bool long_form=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!packet_id_send_update(p, lo=
ng_form))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const packet_id_type net_id =3D htonpid(p-&gt;id);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const net_time_t=
 net_time =3D htontime(p-&gt;time);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (long_form &amp;&amp; !buf_write(buf, &amp;net_time, sizeof(net_time)))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!buf_write(buf, &amp;net_id, sizeof(net_id)))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> packet_id_write(s=
truct packet_id_send *p, struct buffer *buf, bool long_form,</span><br><spa=
n>                 bool prepend)</span><br><span> {</span><br><span>diff --=
git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h</span><br><span>ind=
ex 558361a..d4b5f1e 100644</span><br><span>--- a/src/openvpn/packet_id.h</s=
pan><br><span>+++ b/src/openvpn/packet_id.h</span><br><span>@@ -244,10 +244=
,17 @@</span><br><span>  * Read/write a packet ID to/from the buffer.  Shor=
t form is sequence number</span><br><span>  * only.  Long form is sequence =
number and timestamp.</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> bool packet_id_read(struct packet_id=
_net *pin, struct buffer *buf, bool long_form);</span><br><span> </span><br=
><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Varia=
nt of packet_id_read that expects the timestamp first and packet</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * counter after that to form =
a flat 64bit counter on the wire if we are</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * using the long form.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool packet_id_read_flat(struct packet_id_net *pin, struct buffe=
r *buf, bool long_form);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Write a p=
acket ID to buf, and update the packet ID state.</span><br><span>  *</span>=
<br><span>  * @param p             Packet ID state.</span><br><span>@@ -260=
,6 +267,22 @@</span><br><span> bool packet_id_write(struct packet_id_send *=
p, struct buffer *buf,</span><br><span>                      bool long_form=
, bool prepend);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a packet ID=
 to buf, and update the packet ID state. This variant</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * will always use a variant of the packe=
t id that can just be seen as</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * a flat 64 bit counter.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param p             Packet ID state.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param buf           Buffer to write the packet ID t=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param long_for=
m     If true, also update and write time_t to buf</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return true if successful, false otherwise.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+packet_id_write_flat(struct packet_id_send *p, struct buffer *bu=
f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
    bool long_form);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> /*</span><br><span>  * Inline functions.</span><br><span=
>  */</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c<=
/span><br><span>index 10806ac..2f0fc19 100644</span><br><span>--- a/src/ope=
nvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -69=
1,6 +691,10 @@</span><br><span>     {</span><br><span>         buf_printf(&=
amp;proto_flags, &quot; aead-tag-end&quot;);</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;imported_prot=
ocol_flags &amp; CO_64_BIT_PKT_ID)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        buf_printf(&amp;proto_flags, &quot; pkt-id-64-bit&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </spa=
n><br><span>     if (buf_len(&amp;proto_flags) &gt; 0)</span><br><span>    =
 {</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span=
><br><span>index 7c49451..1a321a1 100644</span><br><span>--- a/src/openvpn/=
ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -105,9 +10=
5,11 @@</span><br><span>  * @param ctx                   Encrypt/decrypt ke=
y context</span><br><span>  * @param key                   HMAC key, used t=
o calculate implicit IV</span><br><span>  * @param key_len               HM=
AC key length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram long_pkt_id           64-bit packet counters are used</span><br><span> =
 */</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, si=
ze_t key_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_c=
tx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
     bool long_pkt_id);</span><br><span> </span><br><span> </span><br><span=
> /**</span><br><span>@@ -1369,13 +1371,15 @@</span><br><span>     }</span>=
<br><span>     else</span><br><span>     {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        bool longiv =3D ks-&gt;crypto_options.flags =
&amp; CO_64_BIT_PKT_ID;</span><br><span>         init_key_ctx_bi(key, key2,=
 key_direction, key_type, &quot;Data Channel&quot;);</span><br><span>      =
   /* Initialize implicit IVs */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        key_ctx_update_implicit_iv(&amp;key-&gt;encrypt, key2-&g=
t;keys[(int)server].hmac,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                   MAX_HMAC_KEY_LENGTH);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        key_ctx_update_implicit_iv=
(&amp;key-&gt;encrypt,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                   key2-&gt;keys[(int)server].hmac,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
           MAX_HMAC_KEY_LENGTH, longiv);</span><br><span>         key_ctx_u=
pdate_implicit_iv(&amp;key-&gt;decrypt,</span><br><span>                   =
                 key2-&gt;keys[1 - (int)server].hmac,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                   MAX_HMAC=
_KEY_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                             MAX_HMAC_KEY_LENGTH, longiv);</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span>@@ -1513,14 +15=
17,15 @@</span><br><span> }</span><br><span> </span><br><span> static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_ctx_update_implici=
t_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+key_ctx_update_implicit_iv(struct key_c=
tx *ctx, uint8_t *key,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                           size_t key_len, bool longiv)</span><br><span>=
 {</span><br><span>     /* Only use implicit IV in AEAD cipher mode, where =
HMAC key is not used */</span><br><span>     if (cipher_ctx_mode_aead(ctx-&=
gt;cipher))</span><br><span>     {</span><br><span>         size_t impl_iv_=
len =3D 0;</span><br><span>         ASSERT(cipher_ctx_iv_length(ctx-&gt;cip=
her) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;ciphe=
r) - sizeof(packet_id_type);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - pac=
ket_id_size(longiv);</span><br><span>         ASSERT(impl_iv_len &lt;=3D OP=
ENVPN_MAX_IV_LENGTH);</span><br><span>         ASSERT(impl_iv_len &lt;=3D k=
ey_len);</span><br><span>         memcpy(ctx-&gt;implicit_iv, key, impl_iv_=
len);</span><br><span>@@ -1935,6 +1940,12 @@</span><br><span>         iv_pr=
oto |=3D IV_PROTO_DYN_TLS_CRYPT;</span><br><span> #endif</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* support f=
or AEAD tag at the end and 8 byte IV */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (session-&gt;opt-&gt;data_v3_features_suppor=
ted)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            iv_proto |=3D=
 IV_PROTO_DATA_V3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>         buf_printf(&amp;out, &quot;IV_PROTO=3D%d\n&quot;, iv_proto);=
</span><br><span> </span><br><span>         if (session-&gt;opt-&gt;push_pe=
er_info_detail &gt; 1)</span><br><span>diff --git a/src/openvpn/ssl.h b/src=
/openvpn/ssl.h</span><br><span>index 98e59e8..1f770e0 100644</span><br><spa=
n>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br=
><span>@@ -107,6 +107,9 @@</span><br><span> /** Support to dynamic tls-cryp=
t (renegotiation with TLS-EKM derived tls-crypt key) */</span><br><span> #d=
efine IV_PROTO_DYN_TLS_CRYPT   (1&lt;&lt;9)</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/** Support for the AEAD tag at t=
he end and larger AEAD packet id */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define IV_PROTO_DATA_V3        (1&lt;&lt;10)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Default fiel=
d in X509 to be username */</span><br><span> #define X509_USERNAME_FIELD_DE=
FAULT &quot;CN&quot;</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index 5a7dd60.=
.dc87c80 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><s=
pan>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -311,7 +311,6 @@</spa=
n><br><span> </span><br><span>     /* from command line */</span><br><span>=
     bool single_session;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    bool disable_occ;</span><br><span>     int mode;</span><br><span>  =
   bool pull;</span><br><span>     /**</span><br><span>@@ -361,6 +360,11 @@=
</span><br><span>     const char *config_ciphername;</span><br><span>     c=
onst char *config_ncp_ciphers;</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /** whether our underlying data channel supports new data cha=
nnel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * features=
. This is always true for the internal implementation but</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * can be false for DCO implement=
ations */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool d=
ata_v3_features_supported;</span><br><span>     bool tls_crypt_v2;</span><b=
r><span>     const char *tls_crypt_v2_verify_script;</span><br><span> </spa=
n><br><span>@@ -490,8 +494,6 @@</span><br><span>      */</span><br><span>  =
   int key_id;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int limit_next;             /* used for traffic shaping on t=
he control channel */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     int verify_maxlevel;</span><br><span> </span><br><spa=
n>     char *common_name;</span><br><span>diff --git a/src/openvpn/ssl_ncp.=
c b/src/openvpn/ssl_ncp.c</span><br><span>index 73ec9f5..bfb8658 100644</sp=
an><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/=
ssl_ncp.c</span><br><span>@@ -430,6 +430,12 @@</span><br><span>         ses=
sion-&gt;opt-&gt;crypto_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (session-&gt;opt-&gt;data_v3_features_supported &amp;&amp; (iv_p=
roto_peer &amp; IV_PROTO_DATA_V3))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        session-&gt;opt-&gt;crypto_flags |=3D CO_AEAD_TAG_AT_THE_END;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        session-&gt;opt-=
&gt;crypto_flags |=3D CO_64_BIT_PKT_ID;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> #if defined(HAVE_EXPORT_KEYING_MATERIAL)</span><br>=
<span>     if (iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span=
>     {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/=
tests/unit_tests/openvpn/test_ssl.c</span><br><span>index 8d73858..dd3a108 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -98,7 +9=
8,7 @@</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_ne=
w();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct tls_root_ctx ctx =3D { 0 };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct tls_root_ctx ctx =3D {0};</span><br><span>  =
   tls_ctx_client_new(&amp;ctx);</span><br><span>     tls_ctx_load_cert_fil=
e(&amp;ctx, unittest_cert, true);</span><br><span> </span><br><span>@@ -124=
,19 +124,22 @@</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_implicit_iv=
(struct crypto_options *co)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+init_implicit_iv(struct crypto_options *co, struct key2 *key2)</spa=
n><br><span> {</span><br><span>     cipher_ctx_t *cipher =3D co-&gt;key_ctx=
_bi.encrypt.cipher;</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     if (cipher_ctx_mode_aead(cipher))</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) - sizeof(packet=
_id_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        b=
ool longiv =3D co-&gt;flags &amp; CO_64_BIT_PKT_ID;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) =
- packet_id_size(longiv);</span><br><span>         ASSERT(cipher_ctx_iv_len=
gth(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>         ASSERT=
(cipher_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><=
span> </span><br><span>         /* Generate dummy implicit IV */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_bytes(co-&gt=
;key_ctx_bi.encrypt.implicit_iv,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                          OPENVPN_MAX_IV_LENGTH));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(memcpy(co-&gt;key_=
ctx_bi.encrypt.implicit_iv, key2-&gt;keys[0].hmac,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                      OPENVPN_MAX_IV_LENGTH)=
);</span><br><span>         co-&gt;key_ctx_bi.encrypt.implicit_iv_len =3D i=
mpl_iv_len;</span><br><span> </span><br><span>         memcpy(co-&gt;key_ct=
x_bi.decrypt.implicit_iv,</span><br><span>@@ -195,7 +198,6 @@</span><br><sp=
an>     /* init work */</span><br><span>     ASSERT(buf_init(&amp;work, fra=
me.buf.headroom));</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    init_implicit_iv(co);</span><br><span>     update_time()=
;</span><br><span> </span><br><span>     /* Test encryption, decryption for=
 all packet sizes */</span><br><span>@@ -235,24 +237,36 @@</span><br><span>=
     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> struct crypto_options</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-init_crypto_options(const char *cipher, =
const char *auth)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
it_crypto_options(const char *cipher, const char *auth, int flags,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    struct k=
ey2 *statickey)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct key2 key2 =3D { .n =3D 2};</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct key2 key2 =3D {.n =3D 2};</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].cipher)));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(rand_bytes(key2.keys[0]=
.hmac, sizeof(key2.keys[0].hmac)));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(rand_bytes(key2.keys[1].cipher, sizeof(key2.keys[1=
].cipher)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSER=
T(rand_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (statickey)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* Use chosen static key instead of rando=
m key when defined */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        key2 =3D *statickey;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(rand_bytes(ke=
y2.keys[0].cipher, sizeof(key2.keys[0].cipher)));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ASSERT(rand_bytes(key2.keys[0].hmac, =
sizeof(key2.keys[0].hmac)));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        ASSERT(rand_bytes(key2.keys[1].cipher, sizeof(key2.keys[1]=
.cipher)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac));</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct cr=
ypto_options co =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto_options =
co =3D {0};</span><br><span> </span><br><span>     struct key_type kt =3D c=
reate_kt(cipher, auth, &quot;ssl-test&quot;);</span><br><span> </span><br><=
span>     init_key_ctx_bi(&amp;co.key_ctx_bi, &amp;key2, 0, &amp;kt, &quot;=
unit-test-ssl&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    packet_id_init(&amp;co.packet_id,  5, 5, &quot;UNITTEST&quot;, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;=
co.packet_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    co.flags |=3D flags;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_implicit_iv(&amp;co, &amp;key2);</span><br><span> </span><br><span>     r=
eturn co;</span><br><span> }</span><br><span>@@ -271,8 +285,27 @@</span><br=
><span> static void</span><br><span> run_data_channel_with_cipher_end(const=
 char *cipher)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct crypto_options co =3D init_crypto_options(cipher, &q=
uot;none&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
o.flags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct crypto_options co =3D init_crypto_options(ciphe=
r, &quot;none&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                                   CO_AEAD_TAG_AT_THE_END,=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    do_data_channel_round_trip(=
&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uninit=
_crypto_options(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+run_data_channel_with_cipher_end_and_lo=
ng_pkt_counter(const char *cipher)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct crypto_options co =3D init_crypto_options(cipher, &quot;none&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                                CO_AEAD_TAG_AT_THE_END | CO_64_BIT_PKT_ID, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_data_c=
hannel_round_trip(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uninit_crypto_options(&amp;co);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+run_data_channel_with=
_long_pkt_counter(const char *cipher)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct crypto_options co =3D init_crypto_options(cipher, &quot;none&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                                   CO_64_BIT_PKT_ID, NULL);</span><br><span=
>     do_data_channel_round_trip(&amp;co);</span><br><span>     uninit_cryp=
to_options(&amp;co);</span><br><span> }</span><br><span>@@ -280,31 +313,36 =
@@</span><br><span> static void</span><br><span> run_data_channel_with_ciph=
er(const char *cipher, const char *auth)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct crypto_options co =3D init=
_crypto_options(cipher, auth);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct crypto_options co =3D init_crypto_options(cipher, aut=
h, 0, NULL);</span><br><span>     do_data_channel_round_trip(&amp;co);</spa=
n><br><span>     uninit_crypto_options(&amp;co);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+run_aead_channel_=
tests(const char *cipher)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data=
_channel_with_cipher_end(cipher);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    run_data_channel_with_cipher(cipher, &quot;none&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_=
with_cipher_end_and_long_pkt_counter(cipher);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    run_data_channel_with_long_pkt_counter(cipher=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
> </span><br><span> static void</span><br><span> test_data_channel_roundtri=
p_aes_128_gcm(void **state)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    run_data_channel_with_cipher_end(&quot;AES-128=
-GCM&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    run_d=
ata_channel_with_cipher(&quot;AES-128-GCM&quot;, &quot;none&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    run_aead_channel_tests(=
&quot;AES-128-GCM&quot;);</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span> test_data_channel_roundtrip_aes_192_gcm(v=
oid **state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    run_data_channel_with_cipher_end(&quot;AES-192-GCM&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    run_data_channel_wit=
h_cipher(&quot;AES-192-GCM&quot;, &quot;none&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    run_aead_channel_tests(&quot;AES-192-=
GCM&quot;);</span><br><span> }</span><br><span> </span><br><span> static vo=
id</span><br><span> test_data_channel_roundtrip_aes_256_gcm(void **state)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
run_data_channel_with_cipher_end(&quot;AES-256-GCM&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    run_data_channel_with_cipher(&quot=
;AES-256-GCM&quot;, &quot;none&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    run_aead_channel_tests(&quot;AES-256-GCM&quot;);</sp=
an><br><span> }</span><br><span> </span><br><span> static void</span><br><s=
pan>@@ -334,8 +372,7 @@</span><br><span>         return;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    run_data_channel_with_cipher_end(&quot;ChaCha20-Poly1305&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    run_data_channel_with_c=
ipher(&quot;ChaCha20-Poly1305&quot;, &quot;none&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    run_aead_channel_tests(&quot;ChaCha=
20-Poly1305&quot;);</span><br><span> }</span><br><span> </span><br><span> s=
tatic void</span><br><span>@@ -349,6 +386,154 @@</span><br><span>     run_d=
ata_channel_with_cipher(&quot;BF-CBC&quot;, &quot;SHA1&quot;);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static struct key2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+create_key()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key2 key2 =
=3D {.n =3D 2};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t key[]=
 =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&#39;a&#39=
;, &#39;b&#39;, &#39;c&#39;, &#39;d&#39;, &#39;e&#39;, &#39;f&#39;, &#39;g&=
#39;, &#39;h&#39;, &#39;0&#39;, &#39;1&#39;, &#39;2&#39;, &#39;3&#39;, &#39=
;4&#39;, &#39;5&#39;, &#39;6&#39;, &#39;7&#39;, &#39;A&#39;, &#39;B&#39;, &=
#39;C&#39;, &#39;D&#39;, &#39;E&#39;, &#39;F&#39;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     &#39;G&#39;, &#39;H&#39;, &#39;j&#39;, =
&#39;k&#39;, &#39;u&#39;, &#39;c&#39;, &#39;h&#39;, &#39;e&#39;, &#39;n&#39=
;, &#39;l&#39;};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    static_assert(size=
of(key) =3D=3D 32, &quot;Size of key should be 32 bytes&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* copy the key a few times to ensure to have =
the size we need for</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * Statickey but XOR it to not repeat it */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint8_t keydata[sizeof(key2.keys)];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; sizeof(key2.keys=
); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        keydata[i] =3D (ui=
nt8_t) (key[i % sizeof(key)] ^ i);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(memcpy(key2.keys[0].cipher=
, keydata, sizeof(key2.keys[0].cipher)));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(memcpy(key2.keys[0].hmac, keydata + 64, si=
zeof(key2.keys[0].hmac)));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ASSERT(memcpy(key2.keys[1].cipher, keydata + 128, sizeof(key2.ke=
ys[1].cipher)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ASSERT(memcpy(key2.keys[1].hmac, keydata + 192, sizeof(key2.keys)[1].hmac)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return key2;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_data=
_channel_known_vectors_run(bool longpktcounter)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct key2 key2 =3D create_key();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int flags =3D longpktcounter ? CO_64_BIT_PKT_ID : 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D CO_AEAD_TAG_A=
T_THE_END;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto_options co=
 =3D init_crypto_options(&quot;AES-256-GCM&quot;, &quot;none&quot;, flags,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                               &amp;key2);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* initialise frame for the test */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct frame frame;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    init_frame_parameters(&amp;frame);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer src =3D alloc_buf_gc(frame.buf.=
payload_size, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer e=
ncrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer decrypt_wor=
kspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D clear_buf();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *buf_p;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* init work */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;work, frame.buf.=
headroom));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* msg(M_INFO, &quot;TESTING ENCRYPT/DECRYPT of=
 packet length=3D%d&quot;, i); */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Load src wi=
th known data.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_in=
it(&amp;src, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *plaintext =3D &quot;The quick little fox jumps over the burea=
ucratic hurdles&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_w=
rite(&amp;src, plaintext, strlen(plaintext)));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* copy source to input buf */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf =3D work;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_p =3D buf_write_alloc(&amp;buf, BLEN(&amp;src)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_p)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(buf_p, =
BPTR(&amp;src), BLEN(&amp;src));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 initialize work buffer with buf.headroom bytes of prepend capacity */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp=
;encrypt_workspace, frame.buf.headroom));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* add packet opcode and peer id */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_write_u8(&amp;encrypt_workspace, 7);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(&amp;encry=
pt_workspace, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_write_u8(&amp;encrypt_workspace, 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_write_u8(&amp;encrypt_workspace, 23);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* encrypt */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    openvpn_encrypt(&amp;buf, encrypt_workspace=
, &amp;co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* separate buffer in a=
uthenticated data and encrypted data */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint8_t *ad_start =3D BPTR(&amp;buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(&amp;buf, 4);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (longpktcounter)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uint8_t packetid1[8] =3D {0, 0, 0, 0, 0, 0,=
 0, 1};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asse=
rt_memory_equal(BPTR(&amp;buf), packetid1, 8);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint=
8_t packetid1[4] =3D {0, 0, 0, 1};</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        assert_memory_equal(BPTR(&amp;buf), packetid1, 4);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint8_t *tag_location =3D BEND(&amp;buf) - OPENVPN=
_AEAD_TAG_LENGTH;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (longpktcounte=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        const uint8_t exp_tag_l=
ong[16] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{0x52, 0xee, 0xef, 0xdb, 0x34, 0xb7, 0xbd, 0x79, 0xfe, 0xbf, 0x69, 0xd0, 0x=
4e, 0x92, 0xfe, 0x4b};</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        assert_memory_equal(tag_location, exp_tag_long, OPENVPN_AEAD_TAG=
_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const uint8_t exp_tag_short[16] =3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {0x1f, 0xdd, 0x90=
, 0x8f, 0x0e, 0x9d, 0xc2, 0x5e, 0x79, 0xd8, 0x32, 0x02, 0x0d, 0x58, 0xe7, 0=
x3f};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert=
_memory_equal(tag_location, exp_tag_short, OPENVPN_AEAD_TAG_LENGTH);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (longpktcounter)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const uint8_t bytesat14[6] =3D {0xc7, 0x40, 0x47, 0x81, 0xac,=
 0x8c};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asse=
rt_memory_equal(BPTR(&amp;buf) + 14, bytesat14, sizeof(bytesat14));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        const uint8_t bytesat14[6] =3D {0xa8, 0x2e, 0x6b, 0x17, 0x=
06, 0xd9};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
ssert_memory_equal(BPTR(&amp;buf) + 14, bytesat14, sizeof(bytesat14));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* decrypt */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    openvpn_decrypt(&amp;buf, decrypt_workspace, &amp;co, &=
amp;frame, ad_start);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* compare */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(buf.len, strlen(plaintext));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), plaintext, strlen(plaint=
ext));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_data_channel_known_vectors_longpktid(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    test_data_channel_known_vectors_run(true);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_data_channel_known_vectors_shortpktid(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    test_data_channel_known_vectors_run(false);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><b=
r><span> int</span><br><span> main(void)</span><br><span>@@ -365,6 +550,8 @=
@</span><br><span>         cmocka_unit_test(test_data_channel_roundtrip_aes=
_192_cbc),</span><br><span>         cmocka_unit_test(test_data_channel_roun=
dtrip_aes_256_cbc),</span><br><span>         cmocka_unit_test(test_data_cha=
nnel_roundtrip_bf_cbc),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_data_channel_known_vectors_longpktid),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_data_channel_known_vectors_shortpktid)</span><br><span>     };</spa=
n><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/507?usp=3Demail">change 507</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
07?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b3=
5ddc2318569e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--47iPcoTiEWo=--

