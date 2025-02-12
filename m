From: Gert Doering <gert@...1296...>
Date: Wed, 12 Feb 2025 17:13:11 +0100
Message-ID: <20250212161311.16888-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
References: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v19] Implement epoch key data format
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

From: Arne Schwabe <arne@...1227...>

With DCO and possible future hardware assisted OpenVPN acceleration we
are approaching the point where 32 bit IVs are not cutting it any more,
especially if we are limiting the IVs to the safe limits of AES-GCM where
the limit is more 2^29.

To illustrate the problem, some back of the envelope math here:

If we want to keep the current 3600s renegotiation interval and have
a safety margin of 25% (when we trigger renegotiation) we have about
3.2 million packets (2*32 * 0.7) to work with. That translates to
about 835k packets per second. Currently, implementation trigger the
renegotiation at 0xff00000000 or at 7/8 of the AEAD usage limit.

With 1300 Byte packets that translates into 8-9 Gbit/s. That is far
from unrealistic any more. Current DCO implementations are already in
spitting distance to that or might even reach (for a single client
connection) that if you have extremely fast
single core performance CPU.

With the AEAD usage limit, these limits are almost a factor of 8 lower
so with the limit becomes 1-2 GBit/s. This is already reached without
DCO on some platforms.

This introduces the epoch data format for AEAD data channel
ciphers in TLS mode ciphers. No effort has been made to support
larger packet counters in any other scenario since those are all legacy.
This uses the same approach of epoch keys as (D)TLS 1.3 does and switches
the data channel regularly for affected AEAD ciphers when reaching the
usage limit.

For Chacha20-Poly1305, which does not suffer the same problems as AES-GCM,
the full 48 bit of packet counter are used only after that the same logic
to switch to a new key as with AES-GCM is done.

Change-Id: I00751c42cb04e30205ba8e6584530831e0d143c5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/806
This mail reflects revision 19 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index ea8d006..5081e81 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -706,6 +706,7 @@
 
     target_sources(test_auth_token PRIVATE
         src/openvpn/base64.c
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
@@ -734,9 +735,10 @@
             tests/unit_tests/openvpn/mock_win32_execve.c
             src/openvpn/argv.c
             src/openvpn/base64.c
-            src/openvpn/crypto.c
+            src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
             src/openvpn/crypto_openssl.c
+            src/openvpn/crypto.c
             src/openvpn/cryptoapi.c
             src/openvpn/env_set.c
             src/openvpn/mss.c
@@ -762,6 +764,7 @@
         )
 
     target_sources(test_ncp PRIVATE
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
@@ -783,6 +786,7 @@
         tests/unit_tests/openvpn/mock_win32_execve.c
         src/openvpn/argv.c
         src/openvpn/base64.c
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
@@ -836,9 +840,11 @@
         target_compile_options(test_networking PRIVATE -UNDEBUG)
         target_sources(test_networking PRIVATE
             src/openvpn/networking_sitnl.c
+            src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
+            src/openvpn/crypto_epoch.c
             src/openvpn/otime.c
             src/openvpn/packet_id.c
             )
@@ -854,6 +860,7 @@
             tests/unit_tests/openvpn/mock_win32_execve.c
             src/openvpn/argv.c
             src/openvpn/base64.c
+            src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
diff --git a/Changes.rst b/Changes.rst
index d01816b..e011811 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -35,6 +35,19 @@
     replaced by the default ciphers used by OpenVPN, making it easier to
     add an allowed cipher without having to spell out the default ciphers.
 
+Epoch data keys and packet format
+    This introduces the epoch data format for AEAD data channel
+    ciphers in TLS mode ciphers. This new data format has a number of
+    improvements over the standard "DATA_V2" format.
+
+    - AEAD tag at the end of packet which is more hardware implementation
+      friendly
+    - Automatic key switchover when cipher usage limits are hit, similar to
+      the epoch data keys in (D)TLS 1.3
+    - 64 bit instead of 32 bit packet ids to allow the data channel to be
+      ready for 10 GBit/s without having frequent renegotiation
+    - IV constructed with XOR instead of concatenation to not have (parts) of
+      the real IV on the wire
 
 Deprecated features
 -------------------
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index dbd95a8..ed70f51 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -32,6 +32,8 @@
 #include <string.h>
 
 #include "crypto.h"
+#include "crypto_epoch.h"
+#include "packet_id.h"
 #include "error.h"
 #include "integer.h"
 #include "platform.h"
@@ -67,6 +69,13 @@
 {
     struct gc_arena gc;
     int outlen = 0;
+    const bool use_epoch_data_format = opt->flags & CO_EPOCH_DATA_KEY_FORMAT;
+
+    if (use_epoch_data_format)
+    {
+        epoch_check_send_iterate(opt);
+    }
+
     const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
     uint8_t *mac_out = NULL;
     const int mac_len = OPENVPN_AEAD_TAG_LENGTH;
@@ -88,14 +97,24 @@
         buf_set_write(&iv_buffer, iv, iv_len);
 
         /* IV starts with packet id to make the IV unique for packet */
-        if (!packet_id_write(&opt->packet_id.send, &iv_buffer, false, false))
+        if (use_epoch_data_format)
         {
-            msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
-            goto err;
+            if (!packet_id_write_epoch(&opt->packet_id.send, ctx->epoch, &iv_buffer))
+            {
+                msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+                goto err;
+            }
         }
-
+        else
+        {
+            if (!packet_id_write(&opt->packet_id.send, &iv_buffer, false, false))
+            {
+                msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+                goto err;
+            }
+        }
         /* Write packet id part of IV to work buffer */
-        ASSERT(buf_write(&work, iv, packet_id_size(false)));
+        ASSERT(buf_write(&work, iv, buf_len(&iv_buffer)));
 
         /* This generates the IV by XORing the implicit part of the IV
          * with the packet id already written to the iv buffer */
@@ -127,7 +146,7 @@
     dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s",
          format_hex(BPTR(&work), BLEN(&work), 0, &gc));
 
-    if (!(opt->flags & CO_EPOCH_DATA_KEY_FORMAT))
+    if (!use_epoch_data_format)
     {
         /* Reserve space for authentication tag */
         mac_out = buf_write_alloc(&work, mac_len);
@@ -148,7 +167,7 @@
     ASSERT(buf_inc_len(&work, outlen));
 
     /* if the tag is at end the end, allocate it now */
-    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
+    if (use_epoch_data_format)
     {
         /* Reserve space for authentication tag */
         mac_out = buf_write_alloc(&work, mac_len);
@@ -363,14 +382,35 @@
 
 bool
 crypto_check_replay(struct crypto_options *opt,
-                    const struct packet_id_net *pin, const char *error_prefix,
+                    const struct packet_id_net *pin, uint16_t epoch,
+                    const char *error_prefix,
                     struct gc_arena *gc)
 {
     bool ret = false;
-    packet_id_reap_test(&opt->packet_id.rec);
-    if (packet_id_test(&opt->packet_id.rec, pin))
+    struct packet_id_rec *recv;
+
+    if (epoch == 0 || opt->key_ctx_bi.decrypt.epoch == epoch)
     {
-        packet_id_add(&opt->packet_id.rec, pin);
+        recv = &opt->packet_id.rec;
+    }
+    else if (epoch == opt->epoch_retiring_data_receive_key.epoch)
+    {
+        recv = &opt->epoch_retiring_key_pid_recv;
+    }
+    else
+    {
+        /* We have an epoch that is neither current or old recv key but
+         * is authenticated, ie we need to move to a new current recv key */
+        msg(D_GENKEY, "Received data packet with new epoch %d. Updating "
+            "receive key", epoch);
+        epoch_replace_update_recv_key(opt, epoch);
+        recv = &opt->packet_id.rec;
+    }
+
+    packet_id_reap_test(recv);
+    if (packet_id_test(recv, pin))
+    {
+        packet_id_add(recv, pin);
         if (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
         {
             packet_id_persist_save_obj(opt->pid_persist, &opt->packet_id);
@@ -405,16 +445,19 @@
 {
     static const char error_prefix[] = "AEAD Decrypt error";
     struct packet_id_net pin = { 0 };
-    struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
     struct gc_arena gc;
-
     gc_init(&gc);
 
-    if (cipher_decrypt_verify_fail_exceeded(ctx))
+    struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
+    const bool use_epoch_data_format = opt->flags & CO_EPOCH_DATA_KEY_FORMAT;
+    if (!use_epoch_data_format && cipher_decrypt_verify_fail_exceeded(ctx))
     {
         CRYPT_DROP("Decryption failed verification limit reached.");
     }
 
+    const int tag_size = OPENVPN_AEAD_TAG_LENGTH;
+
+
     ASSERT(opt);
     ASSERT(frame);
     ASSERT(buf->len > 0);
@@ -430,18 +473,60 @@
     /* IV and Packet ID required for this mode */
     ASSERT(packet_id_initialized(&opt->packet_id));
 
+    /* Ensure that the packet size is long enough */
+    int min_packet_len = packet_id_size(false) + tag_size + 1;
+
+    if (use_epoch_data_format)
+    {
+        min_packet_len += sizeof(uint32_t);
+    }
+
+    if (buf->len < min_packet_len)
+    {
+        CRYPT_ERROR("missing IV info, missing tag or no payload");
+    }
+
+    uint16_t epoch = 0;
     /* Combine IV from explicit part from packet and implicit part from context */
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] = { 0 };
         const int iv_len = cipher_ctx_iv_length(ctx->cipher);
-        const size_t packet_iv_len = packet_id_size(false);
 
-        if (buf->len < packet_iv_len)
+        /* Read packet id. For epoch data format also lookup the epoch key
+         * to be able to use the implicit IV of the correct decryption key */
+        if (use_epoch_data_format)
         {
-            CRYPT_ERROR("missing IV info");
-        }
+            /* packet ID format is 16 bit epoch + 48 per epoch packet-counter */
+            const size_t packet_iv_len = sizeof(uint64_t);
 
-        memcpy(iv, BPTR(buf), packet_iv_len);
+            /* copy the epoch-counter part into the IV */
+            memcpy(iv, BPTR(buf), packet_iv_len);
+
+            epoch = packet_id_read_epoch(&pin, buf);
+            if (epoch == 0)
+            {
+                CRYPT_ERROR("error reading packet-id");
+            }
+            ctx = epoch_lookup_decrypt_key(opt, epoch);
+            if (!ctx)
+            {
+                CRYPT_ERROR("data packet with unknown epoch");
+            }
+            else if (cipher_decrypt_verify_fail_exceeded(ctx))
+            {
+                CRYPT_DROP("Decryption failed verification limit reached");
+            }
+        }
+        else
+        {
+            const size_t packet_iv_len = packet_id_size(false);
+            /* Packet ID form is a 32 bit packet counter */
+            memcpy(iv, BPTR(buf), packet_iv_len);
+            if (!packet_id_read(&pin, buf, false))
+            {
+                CRYPT_ERROR("error reading packet-id");
+            }
+        }
 
         /* This generates the IV by XORing the implicit part of the IV
          * with the packet id already written to the iv buffer */
@@ -459,25 +544,12 @@
         }
     }
 
-    /* Read packet ID from packet */
-    if (!packet_id_read(&pin, buf, false))
-    {
-        CRYPT_ERROR("error reading packet-id");
-    }
-
-    /* keep the tag value to feed in later */
-    const int tag_size = OPENVPN_AEAD_TAG_LENGTH;
-    if (buf->len < tag_size + 1)
-    {
-        CRYPT_ERROR("missing tag or no payload");
-    }
-
     const int ad_size = BPTR(buf) - ad_start;
 
     uint8_t *tag_ptr = NULL;
     int data_len = 0;
 
-    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
+    if (use_epoch_data_format)
     {
         data_len = BLEN(buf) - tag_size;
         tag_ptr = BPTR(buf) + data_len;
@@ -498,15 +570,13 @@
         CRYPT_ERROR("potential buffer overflow");
     }
 
-
     /* feed in tag and the authenticated data */
     ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, ad_size));
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s",
          format_hex(ad_start, ad_size, 0, &gc));
 
-    int outlen;
-
     /* Decrypt and authenticate packet */
+    int outlen;
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
                            data_len))
     {
@@ -525,7 +595,7 @@
     dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s",
          format_hex(BPTR(&work), BLEN(&work), 80, &gc));
 
-    if (!crypto_check_replay(opt, &pin, error_prefix, &gc))
+    if (!crypto_check_replay(opt, &pin, epoch, error_prefix, &gc))
     {
         goto error_exit;
     }
@@ -702,7 +772,7 @@
             }
         }
 
-        if (have_pin && !crypto_check_replay(opt, &pin, error_prefix, &gc))
+        if (have_pin && !crypto_check_replay(opt, &pin, 0, error_prefix, &gc))
         {
             goto error_exit;
         }
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 5ceb523..94f1f7f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -525,6 +525,7 @@
  *
  * @param opt   Crypto options for this packet, contains replay state.
  * @param pin   Packet ID read from packet.
+ * @param epoch Epoch read from packet or 0 when epoch is not used.
  * @param error_prefix  Prefix to use when printing error messages.
  * @param gc    Garbage collector to use.
  *
@@ -532,6 +533,7 @@
  */
 bool crypto_check_replay(struct crypto_options *opt,
                          const struct packet_id_net *pin,
+                         uint16_t epoch,
                          const char *error_prefix,
                          struct gc_arena *gc);
 
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 6371013..71e8228 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -39,7 +39,7 @@
 #include "basic.h"
 #include "buffer.h"
 
-/* TLS uses a tag of 128 bytes, let's do the same for OpenVPN */
+/* TLS uses a tag of 128 bits, let's do the same for OpenVPN */
 #define OPENVPN_AEAD_TAG_LENGTH 16
 
 /* Maximum cipher block size (bytes) */
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 035474f..c3e05a8 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -249,6 +249,15 @@
  */
 const char *dco_get_supported_ciphers(void);
 
+/**
+ * Return whether the dco implementation supports the new protocol features of
+ * a 64 bit packet counter and AEAD tag at the end.
+ */
+static inline bool
+dco_supports_epoch_data(struct context *c)
+{
+    return false;
+}
 #else /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -380,5 +389,10 @@
     return "";
 }
 
+static inline bool
+dco_supports_epoch_data(struct context *c)
+{
+    return false;
+}
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4014517..a01dbdc 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2788,6 +2788,19 @@
         }
     }
 
+    /* Ensure that for epoch data format is only enabled if also data v2
+     * is enabled */
+    bool epoch_data = (c->options.imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT);
+    bool datav2_enabled = (c->options.peer_id >= 0 && c->options.peer_id < MAX_PEER_ID);
+
+    if (epoch_data && !datav2_enabled)
+    {
+        msg(D_PUSH_ERRORS, "OPTIONS ERROR: Epoch key data format tag requires "
+            "data v2 (peer-id) to be enabled.");
+        return false;
+    }
+
+
     if (found & OPT_P_PUSH_MTU)
     {
         /* MTU has changed, check that the pushed MTU is small enough to
@@ -3384,6 +3397,15 @@
         to.push_peer_info_detail = 1;
     }
 
+    /* Check if the DCO drivers support the epoch data format */
+    if (dco_enabled(options))
+    {
+        to.data_epoch_supported = dco_supports_epoch_data(c);
+    }
+    else
+    {
+        to.data_epoch_supported = true;
+    }
 
     /* should we not xmit any packets until we get an initial
      * response from client? */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 96fa6cd..f76dad8 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1878,9 +1878,15 @@
     char *push_cipher = ncp_get_best_cipher(o->ncp_ciphers, peer_info,
                                             tls_multi->remote_ciphername,
                                             &o->gc);
-
     if (push_cipher)
     {
+        /* Enable epoch data key format if supported and AEAD cipher in use */
+        if (tls_multi->session[TM_ACTIVE].opt->data_epoch_supported
+            && (proto & IV_PROTO_DATA_EPOCH) && cipher_kt_mode_aead(push_cipher))
+        {
+            o->imported_protocol_flags |= CO_EPOCH_DATA_KEY_FORMAT;
+        }
+
         o->ciphername = push_cipher;
         return true;
     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 6f78a76..439ce79 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -55,6 +55,7 @@
 #include "route.h"
 #include "tls_crypt.h"
 
+#include "crypto_epoch.h"
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "ssl_backend.h"
@@ -915,6 +916,7 @@
     key_state_ssl_free(&ks->ks_ssl);
 
     free_key_ctx_bi(&ks->crypto_options.key_ctx_bi);
+    free_epoch_key_ctx(&ks->crypto_options);
     free_buf(&ks->plaintext_read_buf);
     free_buf(&ks->plaintext_write_buf);
     free_buf(&ks->ack_write_buf);
@@ -1362,6 +1364,48 @@
 }
 
 static void
+init_epoch_keys(struct key_state *ks,
+                struct tls_multi *multi,
+                const struct key_type *key_type,
+                bool server,
+                struct key2 *key2)
+{
+    /* For now we hardcode this to be 16 for the software based data channel
+     * DCO based implementations/HW implementation might adjust this number
+     * based on their expected speed */
+    const int future_key_count = 16;
+
+    int key_direction = server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
+    struct key_direction_state kds;
+    key_direction_state_init(&kds, key_direction);
+
+    struct crypto_options *co = &ks->crypto_options;
+
+    /* For the epoch key we use the first 32 bytes of key2 cipher keys
+     * for the  initial secret */
+    struct epoch_key e1_send = { 0 };
+    e1_send.epoch = 1;
+    memcpy(&e1_send.epoch_key, key2->keys[kds.out_key].cipher, sizeof(e1_send.epoch_key));
+
+    struct epoch_key e1_recv = { 0 };
+    e1_recv.epoch = 1;
+    memcpy(&e1_recv.epoch_key, key2->keys[kds.in_key].cipher, sizeof(e1_recv.epoch_key));
+
+    /* DCO implementations have two choices at this point.
+     *
+     * a) (more likely) they probably to pass E1 directly to kernel
+     * space at this point and do all the other key derivation in kernel
+     *
+     * b) They let userspace do the key derivation and pass all the individual
+     * keys to the DCO layer.
+     * */
+    epoch_init_key_ctx(co, key_type, &e1_send, &e1_recv,  future_key_count);
+
+    secure_memzero(&e1_send, sizeof(e1_send));
+    secure_memzero(&e1_recv, sizeof(e1_recv));
+}
+
+static void
 init_key_contexts(struct key_state *ks,
                   struct tls_multi *multi,
                   const struct key_type *key_type,
@@ -1394,6 +1438,16 @@
         CLEAR(key->decrypt);
         key->initialized = true;
     }
+    else if (multi->opt.crypto_flags & CO_EPOCH_DATA_KEY_FORMAT)
+    {
+        if (!cipher_kt_mode_aead(key_type->cipher))
+        {
+            msg(M_FATAL, "AEAD cipher (currently %s) "
+                "required for epoch data format.",
+                cipher_kt_name(key_type->cipher));
+        }
+        init_epoch_keys(ks, multi, key_type, server, key2);
+    }
     else
     {
         init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
@@ -1969,6 +2023,11 @@
             iv_proto |= IV_PROTO_NCP_P2P;
         }
 
+        if (session->opt->data_epoch_supported)
+        {
+            iv_proto |= IV_PROTO_DATA_EPOCH;
+        }
+
         buf_printf(&out, "IV_CIPHERS=%s\n", session->opt->config_ncp_ciphers);
 
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
@@ -2978,6 +3037,22 @@
         return true;
     }
 
+    /* epoch key id approaching the 16 bit limit */
+    if (ks->crypto_options.flags & CO_EPOCH_DATA_KEY_FORMAT)
+    {
+        /* We only need to check the send key as we always keep send
+         * key epoch >= recv key epoch in \c epoch_replace_update_recv_key */
+        if (ks->crypto_options.epoch_key_send.epoch >= 0xF000)
+        {
+            return true;
+        }
+        else
+        {
+            return false;
+        }
+    }
+
+
     /* Packet id approach the limit of the packet id */
     if (packet_id_close_to_wrapping(&ks->crypto_options.packet_id.send))
     {
@@ -2993,7 +3068,9 @@
      *  Since if both sides were aware, then both sides will probably also
      *  switch to use epoch data channel instead, so this code is not
      *  in effect then.
-     */
+     *
+     * When epoch are in use the crypto layer will handle this internally
+     * with new epochs instead of triggering a renegotiation */
     const struct key_ctx_bi *key_ctx_bi = &ks->crypto_options.key_ctx_bi;
     const uint64_t usage_limit = session->opt->aead_usage_limit;
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e092472..9625a99 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -315,7 +315,6 @@
 
     /* from command line */
     bool single_session;
-    bool disable_occ;
     int mode;
     bool pull;
     /**
@@ -368,6 +367,12 @@
     const char *config_ciphername;
     const char *config_ncp_ciphers;
 
+    /** whether our underlying data channel supports new data channel
+     * features (epoch keys with AEAD tag at the end). This is always true
+     * for the internal implementation but can be false for DCO
+     * implementations */
+    bool data_epoch_supported;
+
     bool tls_crypt_v2;
     const char *tls_crypt_v2_verify_script;
 
@@ -497,8 +502,6 @@
      */
     int key_id;
 
-    int limit_next;             /* used for traffic shaping on the control channel */
-
     int verify_maxlevel;
 
     char *common_name;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index b238fc0..ead91da 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -411,7 +411,8 @@
 }
 
 static void
-p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session)
+p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session,
+                    const char *common_cipher)
 {
     /* will return 0 if peer_info is null */
     const unsigned int iv_proto_peer = extract_iv_proto(multi->peer_info);
@@ -433,6 +434,18 @@
         session->opt->crypto_flags |= CO_USE_CC_EXIT_NOTIFY;
     }
 
+    if (session->opt->data_epoch_supported && (iv_proto_peer & IV_PROTO_DATA_EPOCH)
+        && common_cipher && cipher_kt_mode_aead(common_cipher))
+    {
+        session->opt->crypto_flags |= CO_EPOCH_DATA_KEY_FORMAT;
+    }
+    else
+    {
+        /* The peer might have changed its ciphers options during reconnect,
+         * ensure we clear the flag if we previously had it enabled */
+        session->opt->crypto_flags &= ~CO_EPOCH_DATA_KEY_FORMAT;
+    }
+
 #if defined(HAVE_EXPORT_KEYING_MATERIAL)
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
@@ -472,15 +485,15 @@
 void
 p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
 {
-    /* Set the common options */
-    p2p_ncp_set_options(multi, session);
-
     struct gc_arena gc = gc_new();
 
     /* Query the common cipher here to log it as part of our message.
      * We postpone switching the cipher to do_up */
     const char *common_cipher = get_p2p_ncp_cipher(session, multi->peer_info, &gc);
 
+    /* Set the common options */
+    p2p_ncp_set_options(multi, session, common_cipher);
+
     if (!common_cipher)
     {
         struct buffer out = alloc_buf_gc(128, &gc);
@@ -502,9 +515,12 @@
     }
 
     msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
-        "TLS_export=%d, DATA_v2=%d, peer-id %d, cipher=%s",
+        "TLS_export=%d, DATA_v2=%d, peer-id %d, epoch=%d, cipher=%s",
         (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
-        multi->use_peer_id, multi->peer_id, common_cipher);
+        multi->use_peer_id,
+        multi->peer_id,
+        (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+        common_cipher);
 
     gc_free(&gc);
 }
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 0e5dfee..2e51c1d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -301,7 +301,7 @@
         struct buffer tmp = *src;
         ASSERT(buf_advance(&tmp, TLS_CRYPT_OFF_PID));
         ASSERT(packet_id_read(&pin, &tmp, true));
-        if (!crypto_check_replay(opt, &pin, error_prefix, &gc))
+        if (!crypto_check_replay(opt, &pin, 0, error_prefix, &gc))
         {
             CRYPT_ERROR("packet replay");
         }
diff --git a/tests/Makefile.am b/tests/Makefile.am
index f26b3b8..3246e34 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -52,6 +52,7 @@
 	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/otime.c \
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 307f9ed..471389b 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -86,6 +86,7 @@
 	$(top_srcdir)/src/compat/compat-strsep.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/cryptoapi.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
@@ -132,6 +133,7 @@
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
@@ -160,6 +162,7 @@
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
@@ -179,6 +182,7 @@
 	$(top_srcdir)/src/openvpn/networking_sitnl.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -250,6 +254,7 @@
 auth_token_testdriver_SOURCES = test_auth_token.c mock_msg.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -285,6 +290,7 @@
 ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/otime.c \
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 3d9c99c..5b583c7 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -874,17 +874,17 @@
     struct crypto_options *co = &data->co;
 
     /* Modify the receive epoch and keys to have a very high epoch to test
-     * the end of array. Iterating through all 16k keys takes a 2-3s, so we
+     * the end of array. Iterating through all 65k keys takes a 2-3s, so we
      * avoid this for the unit test */
-    co->key_ctx_bi.decrypt.epoch = 16000;
-    co->key_ctx_bi.encrypt.epoch = 16000;
+    co->key_ctx_bi.decrypt.epoch = 65500;
+    co->key_ctx_bi.encrypt.epoch = 65500;
 
-    co->epoch_key_send.epoch = 16000;
-    co->epoch_key_recv.epoch = 16000 + co->epoch_data_keys_future_count;
+    co->epoch_key_send.epoch = 65500;
+    co->epoch_key_recv.epoch = 65500 + co->epoch_data_keys_future_count;
 
     for (uint16_t i = 0; i < co->epoch_data_keys_future_count; i++)
     {
-        co->epoch_data_keys_future[i].epoch = 16001 + i;
+        co->epoch_data_keys_future[i].epoch = 65501 + i;
     }
 
     /* Move the last few keys until we are close to the limit */
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 845ca56..486e298 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -35,6 +35,7 @@
 #include <cmocka.h>
 
 #include "crypto.h"
+#include "crypto_epoch.h"
 #include "options.h"
 #include "ssl_backend.h"
 #include "options_util.h"
@@ -370,22 +371,46 @@
 
 
 struct crypto_options
-init_crypto_options(const char *cipher, const char *auth)
+init_crypto_options(const char *cipher, const char *auth, bool epoch,
+                    struct key2 *statickey)
 {
     struct key2 key2 = { .n = 2};
 
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
+    }
 
     struct crypto_options co = { 0 };
 
     struct key_type kt = create_kt(cipher, auth, "ssl-test");
 
-    init_key_ctx_bi(&co.key_ctx_bi, &key2, 0, &kt, "unit-test-ssl");
-    packet_id_init(&co.packet_id,  5, 5, "UNITTEST", 0);
+    if (epoch)
+    {
+        struct epoch_key e1 = { .epoch = 1, .epoch_key = { 0 }};
+        memcpy(e1.epoch_key, key2.keys[0].cipher, sizeof(e1.epoch_key));
+        co.flags |= CO_EPOCH_DATA_KEY_FORMAT;
+        epoch_init_key_ctx(&co, &kt, &e1, &e1, 5);
 
+        /* Do a little of dancing for the epoch_send_key_iterate to test
+         * that this works too */
+        epoch_iterate_send_key(&co);
+        epoch_iterate_send_key(&co);
+        epoch_iterate_send_key(&co);
+    }
+    else
+    {
+        init_key_ctx_bi(&co.key_ctx_bi, &key2, KEY_DIRECTION_BIDIRECTIONAL, &kt, "unit-test-ssl");
+    }
+    packet_id_init(&co.packet_id, 5, 5, "UNITTEST", 0);
     return co;
 }
 
@@ -394,17 +419,16 @@
 {
     packet_id_free(&co->packet_id);
     free_key_ctx_bi(&co->key_ctx_bi);
-
+    free_epoch_key_ctx(co);
 }
 
 /* This adds a few more methods than strictly necessary but this allows
  * us to see which exact test was run from the backtrace of the test
  * when it fails */
 static void
-run_data_channel_with_cipher_end(const char *cipher)
+run_data_channel_with_cipher_epoch(const char *cipher)
 {
-    struct crypto_options co = init_crypto_options(cipher, "none");
-    co.flags |= CO_EPOCH_DATA_KEY_FORMAT;
+    struct crypto_options co = init_crypto_options(cipher, "none", true, NULL);
     do_data_channel_round_trip(&co);
     uninit_crypto_options(&co);
 }
@@ -412,7 +436,7 @@
 static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
 {
-    struct crypto_options co = init_crypto_options(cipher, auth);
+    struct crypto_options co = init_crypto_options(cipher, auth, false, NULL);
     do_data_channel_round_trip(&co);
     uninit_crypto_options(&co);
 }
@@ -421,25 +445,40 @@
 static void
 test_data_channel_roundtrip_aes_128_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-128-GCM");
     run_data_channel_with_cipher("AES-128-GCM", "none");
 }
 
 static void
+test_data_channel_roundtrip_aes_128_gcm_epoch(void **state)
+{
+    run_data_channel_with_cipher_epoch("AES-128-GCM");
+}
+
+static void
 test_data_channel_roundtrip_aes_192_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-192-GCM");
     run_data_channel_with_cipher("AES-192-GCM", "none");
 }
 
 static void
+test_data_channel_roundtrip_aes_192_gcm_epoch(void **state)
+{
+    run_data_channel_with_cipher_epoch("AES-192-GCM");
+}
+
+static void
 test_data_channel_roundtrip_aes_256_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-256-GCM");
     run_data_channel_with_cipher("AES-256-GCM", "none");
 }
 
 static void
+test_data_channel_roundtrip_aes_256_gcm_epoch(void **state)
+{
+    run_data_channel_with_cipher_epoch("AES-256-GCM");
+}
+
+static void
 test_data_channel_roundtrip_aes_128_cbc(void **state)
 {
     run_data_channel_with_cipher("AES-128-CBC", "SHA256");
@@ -466,11 +505,22 @@
         return;
     }
 
-    run_data_channel_with_cipher_end("ChaCha20-Poly1305");
     run_data_channel_with_cipher("ChaCha20-Poly1305", "none");
 }
 
 static void
+test_data_channel_roundtrip_chacha20_poly1305_epoch(void **state)
+{
+    if (!cipher_valid("ChaCha20-Poly1305"))
+    {
+        skip();
+        return;
+    }
+
+    run_data_channel_with_cipher_epoch("ChaCha20-Poly1305");
+}
+
+static void
 test_data_channel_roundtrip_bf_cbc(void **state)
 {
     if (!cipher_valid("BF-CBC"))
@@ -482,6 +532,154 @@
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
+    ASSERT(memcpy(key2.keys[0].cipher, keydata, sizeof(key2.keys[0].cipher)));
+    ASSERT(memcpy(key2.keys[0].hmac, keydata + 64, sizeof(key2.keys[0].hmac)));
+    ASSERT(memcpy(key2.keys[1].cipher, keydata + 128, sizeof(key2.keys[1].cipher)));
+    ASSERT(memcpy(key2.keys[1].hmac, keydata + 192, sizeof(key2.keys)[1].hmac));
+
+    return key2;
+}
+
+static void
+test_data_channel_known_vectors_run(bool epoch)
+{
+    struct key2 key2 = create_key();
+
+    struct crypto_options co = init_crypto_options("AES-256-GCM", "none", epoch,
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
+    if (epoch)
+    {
+        uint8_t packetid1[8] = {0, 0x04, 0, 0, 0, 0, 0, 1};
+        assert_memory_equal(BPTR(&buf), packetid1, 8);
+    }
+    else
+    {
+        uint8_t packetid1[4] = {0, 0, 0, 1};
+        assert_memory_equal(BPTR(&buf), packetid1, 4);
+    }
+
+    if (epoch)
+    {
+        uint8_t *tag_location = BEND(&buf) - OPENVPN_AEAD_TAG_LENGTH;
+        const uint8_t exp_tag_epoch[16] =
+        {0x0f, 0xff, 0xf5, 0x91, 0x3d, 0x39, 0xd7, 0x5b,
+         0x18, 0x57, 0x3b, 0x57, 0x48, 0x58, 0x9a, 0x7d};
+
+        assert_memory_equal(tag_location, exp_tag_epoch, OPENVPN_AEAD_TAG_LENGTH);
+    }
+    else
+    {
+        uint8_t *tag_location = BPTR(&buf) + 4;
+        const uint8_t exp_tag_noepoch[16] =
+        {0x1f, 0xdd, 0x90, 0x8f, 0x0e, 0x9d, 0xc2, 0x5e, 0x79, 0xd8, 0x32, 0x02, 0x0d, 0x58, 0xe7, 0x3f};
+        assert_memory_equal(tag_location, exp_tag_noepoch, OPENVPN_AEAD_TAG_LENGTH);
+    }
+
+    /* Check some bytes at the beginning of the encrypted part */
+    if (epoch)
+    {
+        const uint8_t bytesat14[6] = {0x36, 0xaa, 0xb4, 0xd4, 0x9c, 0xe6};
+        assert_memory_equal(BPTR(&buf) + 14, bytesat14, sizeof(bytesat14));
+    }
+    else
+    {
+        const uint8_t bytesat30[6] = {0xa8, 0x2e, 0x6b, 0x17, 0x06, 0xd9};
+        assert_memory_equal(BPTR(&buf) + 30, bytesat30, sizeof(bytesat30));
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
+test_data_channel_known_vectors_epoch(void **state)
+{
+    test_data_channel_known_vectors_run(true);
+}
+
+static void
+test_data_channel_known_vectors_shortpktid(void **state)
+{
+    test_data_channel_known_vectors_run(false);
+}
+
+
 int
 main(void)
 {
@@ -492,13 +690,19 @@
         cmocka_unit_test(test_load_certificate_and_key),
         cmocka_unit_test(test_load_certificate_and_key_uri),
         cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm_epoch),
         cmocka_unit_test(test_data_channel_roundtrip_aes_192_gcm),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_192_gcm_epoch),
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm_epoch),
         cmocka_unit_test(test_data_channel_roundtrip_chacha20_poly1305),
+        cmocka_unit_test(test_data_channel_roundtrip_chacha20_poly1305_epoch),
         cmocka_unit_test(test_data_channel_roundtrip_aes_128_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_aes_192_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
+        cmocka_unit_test(test_data_channel_known_vectors_epoch),
+        cmocka_unit_test(test_data_channel_known_vectors_shortpktid)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

