From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 29 Dec 2024 03:12:52 +0000
In-Reply-To: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
References: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <24f780957108b93cb558bb17dc229111426bd4c7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b2cR3Axl67E="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement epoch key
 data format
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

--b2cR3Axl67E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail

to look at the new patch set (#10).


Change subject: Implement epoch key data format
......................................................................

Implement epoch key data format

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
---
M CMakeLists.txt
M Changes.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/crypto_backend.h
M src/openvpn/dco.h
M src/openvpn/init.c
M src/openvpn/multi.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M src/openvpn/ssl_ncp.c
M src/openvpn/tls_crypt.c
M tests/Makefile.am
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_ssl.c
15 files changed, 497 insertions(+), 62 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/806/10

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9ffcc89..e27f269 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -704,6 +704,7 @@

     target_sources(test_auth_token PRIVATE
         src/openvpn/base64.c
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
@@ -732,9 +733,10 @@
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
@@ -760,6 +762,7 @@
         )

     target_sources(test_ncp PRIVATE
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
@@ -781,6 +784,7 @@
         tests/unit_tests/openvpn/mock_win32_execve.c
         src/openvpn/argv.c
         src/openvpn/base64.c
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
@@ -834,9 +838,11 @@
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
@@ -852,6 +858,7 @@
             tests/unit_tests/openvpn/mock_win32_execve.c
             src/openvpn/argv.c
             src/openvpn/base64.c
+            src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
diff --git a/Changes.rst b/Changes.rst
index 34542a5..f066988 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -30,6 +30,20 @@

     https://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/

+Epoch data keys
+    This introduces the epoch data format for AEAD data channel
+    ciphers in TLS mode ciphers. This new data format has a number of=3D
+    improvements over the standard "DATA_V2" format.
+
+    - AEAD tag at the end of packet which is more hardware implementation
+      friendly
+    - Automatic key switchover when cipher usage limits are hit, similar to
+      the epoch data keys in (D)TLS 1.3
+    - 64 bit instead of 32 bit packet ids to allow the data channel to be
+      ready for 10 GBit/s without having frequent renegotiation
+    - IV constructed with XOR instead of concatenation to not have (parts)=
 of
+      the real IV on the wire
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 763d756..492eb5a 100644
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
     int outlen =3D 0;
+    const bool use_epoch_data_format =3D opt->flags & CO_EPOCH_DATA_KEY_FO=
RMAT;
+
+    if (use_epoch_data_format)
+    {
+        epoch_check_send_iterate(opt);
+    }
+
     const struct key_ctx *ctx =3D &opt->key_ctx_bi.encrypt;
     uint8_t *mac_out =3D NULL;
     const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;
@@ -88,14 +97,24 @@
         buf_set_write(&iv_buffer, iv, iv_len);

         /* IV starts with packet id to make the IV unique for packet */
-        if (!packet_id_write(&opt->packet_id.send, &iv_buffer, false, fals=
e))
+        if (use_epoch_data_format)
         {
-            msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
-            goto err;
+            if (!packet_id_write_epoch(&opt->packet_id.send, ctx->epoch, &=
iv_buffer))
+            {
+                msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+                goto err;
+            }
         }
-
+        else
+        {
+            if (!packet_id_write(&opt->packet_id.send, &iv_buffer, false, =
false))
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
         mac_out =3D buf_write_alloc(&work, mac_len);
@@ -148,7 +167,7 @@
     ASSERT(buf_inc_len(&work, outlen));

     /* if the tag is at end the end, allocate it now */
-    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
+    if (use_epoch_data_format)
     {
         /* Reserve space for authentication tag */
         mac_out =3D buf_write_alloc(&work, mac_len);
@@ -363,14 +382,35 @@

 bool
 crypto_check_replay(struct crypto_options *opt,
-                    const struct packet_id_net *pin, const char *error_pre=
fix,
+                    const struct packet_id_net *pin, uint16_t epoch,
+                    const char *error_prefix,
                     struct gc_arena *gc)
 {
     bool ret =3D false;
-    packet_id_reap_test(&opt->packet_id.rec);
-    if (packet_id_test(&opt->packet_id.rec, pin))
+    struct packet_id_rec *recv;
+
+    if (epoch =3D=3D 0 || opt->key_ctx_bi.decrypt.epoch =3D=3D epoch)
     {
-        packet_id_add(&opt->packet_id.rec, pin);
+        recv =3D &opt->packet_id.rec;
+    }
+    else if (epoch =3D=3D opt->epoch_retiring_data_receive_key.epoch)
+    {
+        recv =3D &opt->epoch_retiring_key_pid_recv;
+    }
+    else
+    {
+        /* We have an epoch that is neither current or old recv key but
+         * is authenticated, ie we need to move to a new current recv key =
*/
+        msg(D_GENKEY, "Received data packet with new epoch %d. Updating "
+            "receive key", epoch);
+        epoch_replace_update_recv_key(opt, epoch);
+        recv =3D &opt->packet_id.rec;
+    }
+
+    packet_id_reap_test(recv);
+    if (packet_id_test(recv, pin))
+    {
+        packet_id_add(recv, pin);
         if (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
         {
             packet_id_persist_save_obj(opt->pid_persist, &opt->packet_id);
@@ -405,15 +445,17 @@
 {
     static const char error_prefix[] =3D "AEAD Decrypt error";
     struct packet_id_net pin =3D { 0 };
-    struct key_ctx *ctx =3D &opt->key_ctx_bi.decrypt;

-    if (cipher_decrypt_verify_fail_exceeded(ctx))
+    struct key_ctx *ctx =3D &opt->key_ctx_bi.decrypt;
+    struct gc_arena gc;
+    const bool use_epoch_data_format =3D opt->flags & CO_EPOCH_DATA_KEY_FO=
RMAT;
+    if (!use_epoch_data_format && cipher_decrypt_verify_fail_exceeded(ctx))
     {
         CRYPT_DROP("Decryption failed verification limit reached.");
+        goto error_exit;
     }

-    int outlen;
-    struct gc_arena gc;
+    const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;

     gc_init(&gc);

@@ -434,18 +476,61 @@
     /* IV and Packet ID required for this mode */
     ASSERT(packet_id_initialized(&opt->packet_id));

+    /* Ensure that the packet size is long enough */
+    int min_packet_len =3D packet_id_size(false) + tag_size + 1;
+
+    if (use_epoch_data_format)
+    {
+        min_packet_len +=3D sizeof(uint32_t);
+    }
+
+    if (buf->len < min_packet_len)
+    {
+        CRYPT_ERROR("missing IV info, missing tag or no payload");
+    }
+
+    uint16_t epoch =3D 0;
     /* Combine IV from explicit part from packet and implicit part from co=
ntext */
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };
         const int iv_len =3D cipher_ctx_iv_length(ctx->cipher);
-        const size_t packet_iv_len =3D packet_id_size(false);

-        if (buf->len < packet_iv_len)
+        /* Read packet id. For epoch data format also lookup the epoch key
+         * to be able to use the implicit IV of the correct decryption key=
 */
+        if (use_epoch_data_format)
         {
-            CRYPT_ERROR("missing IV info");
-        }
+            /* packet ID format is 16 bit epoch + 48 per epoch packet-coun=
ter */
+            const size_t packet_iv_len =3D sizeof(uint64_t);

-        memcpy(iv, BPTR(buf), packet_iv_len);
+            /* copy the epoch-counter part into the IV */
+            memcpy(iv, BPTR(buf), packet_iv_len);
+
+            epoch =3D packet_id_read_epoch(&pin, buf);
+            if (epoch =3D=3D 0)
+            {
+                CRYPT_ERROR("error reading packet-id");
+            }
+            ctx =3D epoch_lookup_decrypt_key(opt, epoch);
+            if (!ctx)
+            {
+                CRYPT_ERROR("data packet with unknown epoch");
+            }
+            else if (cipher_decrypt_verify_fail_exceeded(ctx))
+            {
+                CRYPT_DROP("Decryption failed verification limit reached");
+                goto error_exit;
+            }
+        }
+        else
+        {
+            const size_t packet_iv_len =3D packet_id_size(false);
+            /* Packet ID form is a 32 bit packet counter */
+            memcpy(iv, BPTR(buf), packet_iv_len);
+            if (!packet_id_read(&pin, buf, false))
+            {
+                CRYPT_ERROR("error reading packet-id");
+            }
+        }

         /* This generates the IV by XORing the implicit part of the IV
          * with the packet id already written to the iv buffer */
@@ -463,25 +548,12 @@
         }
     }

-    /* Read packet ID from packet */
-    if (!packet_id_read(&pin, buf, false))
-    {
-        CRYPT_ERROR("error reading packet-id");
-    }
-
-    /* keep the tag value to feed in later */
-    const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;
-    if (buf->len < tag_size + 1)
-    {
-        CRYPT_ERROR("missing tag or no payload");
-    }
-
     const int ad_size =3D BPTR(buf) - ad_start;

     uint8_t *tag_ptr =3D NULL;
     int data_len =3D 0;

-    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
+    if (use_epoch_data_format)
     {
         data_len =3D BLEN(buf) - tag_size;
         tag_ptr =3D BPTR(buf) + data_len;
@@ -502,13 +574,13 @@
         CRYPT_ERROR("potential buffer overflow");
     }

-
     /* feed in tag and the authenticated data */
     ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, ad_size));
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s",
          format_hex(ad_start, ad_size, 0, &gc));

     /* Decrypt and authenticate packet */
+    int outlen;
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
                            data_len))
     {
@@ -527,7 +599,7 @@
     dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s",
          format_hex(BPTR(&work), BLEN(&work), 80, &gc));

-    if (!crypto_check_replay(opt, &pin, error_prefix, &gc))
+    if (!crypto_check_replay(opt, &pin, epoch, error_prefix, &gc))
     {
         goto error_exit;
     }
@@ -704,7 +776,7 @@
             }
         }

-        if (have_pin && !crypto_check_replay(opt, &pin, error_prefix, &gc))
+        if (have_pin && !crypto_check_replay(opt, &pin, 0, error_prefix, &=
gc))
         {
             goto error_exit;
         }
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 3776c9b..4f2c172 100644
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
+ * Return whether the dco implementation supports the new protocol feature=
s of
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
index ee28380..100f3d3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2761,6 +2761,19 @@
         }
     }

+    /* Ensure that for epoch data format is only enabled if also data v2
+     * is enabled */
+    bool epoch_data =3D (c->options.imported_protocol_flags & CO_EPOCH_DAT=
A_KEY_FORMAT);
+    bool datav2_enabled =3D (c->options.peer_id >=3D 0 && c->options.peer_=
id < MAX_PEER_ID);
+
+    if (epoch_data && !datav2_enabled)
+    {
+        msg(D_PUSH_ERRORS, "OPTIONS ERROR: Epoch key data format tag requi=
res "
+            "data v2 (peer-id) to be enabled.");
+        return false;
+    }
+
+
     if (found & OPT_P_PUSH_MTU)
     {
         /* MTU has changed, check that the pushed MTU is small enough to
@@ -3357,6 +3370,15 @@
         to.push_peer_info_detail =3D 1;
     }

+    /* Check if the DCO drivers support the epoch data format */
+    if (dco_enabled(options))
+    {
+        to.data_epoch_supported =3D dco_supports_epoch_data(c);
+    }
+    else
+    {
+        to.data_epoch_supported =3D true;
+    }

     /* should we not xmit any packets until we get an initial
      * response from client? */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 45b3cfa..8a6887a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1849,6 +1849,12 @@
     }
 #endif

+    if (tls_multi->session[TM_ACTIVE].opt->data_epoch_supported
+        && (proto & IV_PROTO_DATA_EPOCH))
+    {
+        o->imported_protocol_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;
+    }
+
     if (proto & IV_PROTO_CC_EXIT_NOTIFY)
     {
         o->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e4a7b57..b58a3c8 100644
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
+    /* For now we hardcode this to be 16 for the software based data chann=
el
+     * DCO based implementations/HW implementation might adjust this number
+     * based on their expected speed */
+    const int future_key_count =3D 16;
+
+    int key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_N=
ORMAL;
+    struct key_direction_state kds;
+    key_direction_state_init(&kds, key_direction);
+
+    struct crypto_options *co =3D &ks->crypto_options;
+
+    /* For the epoch key we use the first 32 bytes of key2 cipher keys
+     * for the  initial secret */
+    struct epoch_key e1_send =3D { 0 };
+    e1_send.epoch =3D 1;
+    memcpy(&e1_send.epoch_key, key2->keys[kds.out_key].cipher, sizeof(e1_s=
end.epoch_key));
+
+    struct epoch_key e1_recv =3D { 0 };
+    e1_recv.epoch =3D 1;
+    memcpy(&e1_recv.epoch_key, key2->keys[kds.in_key].cipher, sizeof(e1_re=
cv.epoch_key));
+
+    /* DCO implementations have two choices at this point.
+     *
+     * a) (more likely) they probably to pass E1 directly to kernel
+     * space at this point and do all the other key derivation in kernel
+     *
+     * b) They let userspace do the key derivation and pass all the indivi=
dual
+     * keys to the DCO layer.
+     * */
+    epoch_init_key_ctx(co, key_type, &e1_send, &e1_recv,  future_key_count=
);
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
         key->initialized =3D true;
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
         init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel"=
);
@@ -1969,6 +2023,11 @@
             iv_proto |=3D IV_PROTO_NCP_P2P;
         }

+        if (session->opt->data_epoch_supported)
+        {
+            iv_proto |=3D IV_PROTO_DATA_EPOCH;
+        }
+
         buf_printf(&out, "IV_CIPHERS=3D%s\n", session->opt->config_ncp_cip=
hers);

 #ifdef HAVE_EXPORT_KEYING_MATERIAL
@@ -2978,6 +3037,21 @@
         return true;
     }

+    if (ks->crypto_options.flags & CO_EPOCH_DATA_KEY_FORMAT)
+    {
+        /* We only need to check the send key as we always keep send
+         * key epoch >=3D recv key epoch in \c epoch_replace_update_recv_k=
ey */
+        if (ks->crypto_options.epoch_key_send.epoch >=3D 0xF000)
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
@@ -2993,7 +3067,9 @@
      *  Since if both sides were aware, then both sides will probably also
      *  switch to use epoch data channel instead, so this code is not
      *  in effect then.
-     */
+     *
+     * When epoch are in use the crypto layer will handle this internally
+     * with new epochs instead of triggering a renegotiation */
     const struct key_ctx_bi *key_ctx_bi =3D &ks->crypto_options.key_ctx_bi;
     const uint64_t usage_limit =3D session->opt->aead_usage_limit;

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

-    int limit_next;             /* used for traffic shaping on the control=
 channel */
-
     int verify_maxlevel;

     char *common_name;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 167bdb2..89528f2 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -431,6 +431,11 @@
         session->opt->crypto_flags |=3D CO_USE_CC_EXIT_NOTIFY;
     }

+    if (session->opt->data_epoch_supported && (iv_proto_peer & IV_PROTO_DA=
TA_EPOCH))
+    {
+        session->opt->crypto_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;
+    }
+
 #if defined(HAVE_EXPORT_KEYING_MATERIAL)
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
@@ -500,9 +505,12 @@
     }

     msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, cipher=3D%s",
+        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%=
s",
         (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT=
),
-        multi->use_peer_id, multi->peer_id, common_cipher);
+        multi->use_peer_id,
+        multi->peer_id,
+        (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+        common_cipher);

     gc_free(&gc);
 }
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 76f06bc..7c5eb01 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -301,7 +301,7 @@
         struct buffer tmp =3D *src;
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
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
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
 auth_token_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -285,6 +290,7 @@
 ncp_testdriver_SOURCES =3D test_ncp.c mock_msg.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/otime.c \
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 845ca56..842c944 100644
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
     struct key2 key2 =3D { .n =3D 2};

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
+    }

     struct crypto_options co =3D { 0 };

     struct key_type kt =3D create_kt(cipher, auth, "ssl-test");

-    init_key_ctx_bi(&co.key_ctx_bi, &key2, 0, &kt, "unit-test-ssl");
-    packet_id_init(&co.packet_id,  5, 5, "UNITTEST", 0);
+    if (epoch)
+    {
+        struct epoch_key e1 =3D { .epoch =3D 1, .epoch_key =3D { 0 }};
+        memcpy(e1.epoch_key, key2.keys[0].cipher, sizeof(e1.epoch_key));
+        co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;
+        epoch_init_key_ctx(&co, &kt, &e1, &e1, 5);

+        /* Do a little of dancing for the epoch_send_key_iterate to test
+         * that this works too */
+        epoch_iterate_send_key(&co);
+        epoch_iterate_send_key(&co);
+        epoch_iterate_send_key(&co);
+    }
+    else
+    {
+        init_key_ctx_bi(&co.key_ctx_bi, &key2, KEY_DIRECTION_BIDIRECTIONAL=
, &kt, "unit-test-ssl");
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
-    struct crypto_options co =3D init_crypto_options(cipher, "none");
-    co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;
+    struct crypto_options co =3D init_crypto_options(cipher, "none", true,=
 NULL);
     do_data_channel_round_trip(&co);
     uninit_crypto_options(&co);
 }
@@ -412,7 +436,7 @@
 static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
 {
-    struct crypto_options co =3D init_crypto_options(cipher, auth);
+    struct crypto_options co =3D init_crypto_options(cipher, auth, false, =
NULL);
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
=20
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
+test_data_channel_known_vectors_run(bool epoch)
+{
+    struct key2 key2 =3D create_key();
+
+    struct crypto_options co =3D init_crypto_options("AES-256-GCM", "none"=
, epoch,
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
+    if (epoch)
+    {
+        uint8_t packetid1[8] =3D {0, 0x04, 0, 0, 0, 0, 0, 1};
+        assert_memory_equal(BPTR(&buf), packetid1, 8);
+    }
+    else
+    {
+        uint8_t packetid1[4] =3D {0, 0, 0, 1};
+        assert_memory_equal(BPTR(&buf), packetid1, 4);
+    }
+
+    if (epoch)
+    {
+        uint8_t *tag_location =3D BEND(&buf) - OPENVPN_AEAD_TAG_LENGTH;
+        const uint8_t exp_tag_long[16] =3D
+        {0x0f, 0xff, 0xf5, 0x91, 0x3d, 0x39, 0xd7, 0x5b,
+         0x18, 0x57, 0x3b, 0x57, 0x48, 0x58, 0x9a, 0x7d};
+
+        assert_memory_equal(tag_location, exp_tag_long, OPENVPN_AEAD_TAG_L=
ENGTH);
+    }
+    else
+    {
+        uint8_t *tag_location =3D BPTR(&buf) + 4;
+        const uint8_t exp_tag_short[16] =3D
+        {0x1f, 0xdd, 0x90, 0x8f, 0x0e, 0x9d, 0xc2, 0x5e, 0x79, 0xd8, 0x32,=
 0x02, 0x0d, 0x58, 0xe7, 0x3f};
+        assert_memory_equal(tag_location, exp_tag_short, OPENVPN_AEAD_TAG_=
LENGTH);
+    }
+
+    /* Check some bytes at the beginning of the encrypted part */
+    if (epoch)
+    {
+        const uint8_t bytesat14[6] =3D {0x36, 0xaa, 0xb4, 0xd4, 0x9c, 0xe6=
};
+        assert_memory_equal(BPTR(&buf) + 14, bytesat14, sizeof(bytesat14));
+    }
+    else
+    {
+        const uint8_t bytesat30[6] =3D {0xa8, 0x2e, 0x6b, 0x17, 0x06, 0xd9=
};
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
+        cmocka_unit_test(test_data_channel_roundtrip_chacha20_poly1305_epo=
ch),
         cmocka_unit_test(test_data_channel_roundtrip_aes_128_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_aes_192_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
+        cmocka_unit_test(test_data_channel_known_vectors_epoch),
+        cmocka_unit_test(test_data_channel_known_vectors_shortpktid)
     };

 #if defined(ENABLE_CRYPTO_OPENSSL)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00751c42cb04e30205ba8e6584530831e0d143c5
Gerrit-Change-Number: 806
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--b2cR3Axl67E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #10</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Implement epoch key data format<br><br>With DCO and possible future =
hardware assisted OpenVPN acceleration we<br>are approaching the point wher=
e 32 bit IVs are not cutting it any more,<br>especially if we are limiting =
the IVs to the safe limits of AES-GCM where<br>the limit is more 2^29.<br><=
br>To illustrate the problem, some back of the envelope math here:<br><br>I=
f we want to keep the current 3600s renegotiation interval and have<br>a sa=
fety margin of 25% (when we trigger renegotiation) we have about<br>3.2 mil=
lion packets (2*32 * 0.7) to work with. That translates to<br>about 835k pa=
ckets per second. Currently, implementation trigger the<br>renegotiation at=
 0xff00000000 or at 7/8 of the AEAD usage limit.<br><br>With 1300 Byte pack=
ets that translates into 8-9 Gbit/s. That is far<br>from unrealistic any mo=
re. Current DCO implementations are already in<br>spitting distance to that=
 or might even reach (for a single client<br>connection) that if you have e=
xtremely fast<br>single core performance CPU.<br><br>With the AEAD usage li=
mit, these limits are almost a factor of 8 lower<br>so with the limit becom=
es 1-2 GBit/s. This is already reached without<br>DCO on some platforms.<br=
><br>This introduces the epoch data format for AEAD data channel<br>ciphers=
 in TLS mode ciphers. No effort has been made to support<br>larger packet c=
ounters in any other scenario since those are all legacy.<br>This uses the =
same approach of epoch keys as (D)TLS 1.3 does and switches<br>the data cha=
nnel regularly for affected AEAD ciphers when reaching the<br>usage limit.<=
br><br>For Chacha20-Poly1305, which does not suffer the same problems as AE=
S-GCM,<br>the full 48 bit of packet counter are used only after that the sa=
me logic<br>to switch to a new key as with AES-GCM is done.<br><br>Change-I=
d: I00751c42cb04e30205ba8e6584530831e0d143c5<br>Signed-off-by: Arne Schwabe=
 &lt;arne@...1227...&gt;<br>---<br>M CMakeLists.txt<br>M Changes.rst<br>M s=
rc/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/crypto_backe=
nd.h<br>M src/openvpn/dco.h<br>M src/openvpn/init.c<br>M src/openvpn/multi.=
c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl=
_ncp.c<br>M src/openvpn/tls_crypt.c<br>M tests/Makefile.am<br>M tests/unit_=
tests/openvpn/Makefile.am<br>M tests/unit_tests/openvpn/test_ssl.c<br>15 fi=
les changed, 497 insertions(+), 62 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/06/806/10</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
CMakeLists.txt b/CMakeLists.txt</span><br><span>index 9ffcc89..e27f269 1006=
44</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.tx=
t</span><br><span>@@ -704,6 +704,7 @@</span><br><span> </span><br><span>   =
  target_sources(test_auth_token PRIVATE</span><br><span>         src/openv=
pn/base64.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
src/openvpn/crypto_epoch.c</span><br><span>         src/openvpn/crypto_mbed=
tls.c</span><br><span>         src/openvpn/crypto_openssl.c</span><br><span=
>         src/openvpn/crypto.c</span><br><span>@@ -732,9 +733,10 @@</span><=
br><span>             tests/unit_tests/openvpn/mock_win32_execve.c</span><b=
r><span>             src/openvpn/argv.c</span><br><span>             src/op=
envpn/base64.c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     src/openvpn/crypto.c</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            src/openvpn/crypto_epoch.c</span><br><span>             s=
rc/openvpn/crypto_mbedtls.c</span><br><span>             src/openvpn/crypto=
_openssl.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   src/openvpn/crypto.c</span><br><span>             src/openvpn/cryptoapi.=
c</span><br><span>             src/openvpn/env_set.c</span><br><span>      =
       src/openvpn/mss.c</span><br><span>@@ -760,6 +762,7 @@</span><br><spa=
n>         )</span><br><span> </span><br><span>     target_sources(test_ncp=
 PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src=
/openvpn/crypto_epoch.c</span><br><span>         src/openvpn/crypto_mbedtls=
.c</span><br><span>         src/openvpn/crypto_openssl.c</span><br><span>  =
       src/openvpn/crypto.c</span><br><span>@@ -781,6 +784,7 @@</span><br><=
span>         tests/unit_tests/openvpn/mock_win32_execve.c</span><br><span>=
         src/openvpn/argv.c</span><br><span>         src/openvpn/base64.c</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/c=
rypto_epoch.c</span><br><span>         src/openvpn/crypto_mbedtls.c</span><=
br><span>         src/openvpn/crypto_openssl.c</span><br><span>         src=
/openvpn/crypto.c</span><br><span>@@ -834,9 +838,11 @@</span><br><span>    =
     target_compile_options(test_networking PRIVATE -UNDEBUG)</span><br><sp=
an>         target_sources(test_networking PRIVATE</span><br><span>        =
     src/openvpn/networking_sitnl.c</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            src/openvpn/crypto_epoch.c</span><br><span>    =
         src/openvpn/crypto_mbedtls.c</span><br><span>             src/open=
vpn/crypto_openssl.c</span><br><span>             src/openvpn/crypto.c</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/=
crypto_epoch.c</span><br><span>             src/openvpn/otime.c</span><br><=
span>             src/openvpn/packet_id.c</span><br><span>             )</s=
pan><br><span>@@ -852,6 +858,7 @@</span><br><span>             tests/unit_t=
ests/openvpn/mock_win32_execve.c</span><br><span>             src/openvpn/a=
rgv.c</span><br><span>             src/openvpn/base64.c</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/crypto_epoch.c<=
/span><br><span>             src/openvpn/crypto_mbedtls.c</span><br><span> =
            src/openvpn/crypto_openssl.c</span><br><span>             src/o=
penvpn/crypto.c</span><br><span>diff --git a/Changes.rst b/Changes.rst</spa=
n><br><span>index 34542a5..f066988 100644</span><br><span>--- a/Changes.rst=
</span><br><span>+++ b/Changes.rst</span><br><span>@@ -30,6 +30,20 @@</span=
><br><span> </span><br><span>     https://datatracker.ietf.org/doc/draft-ir=
tf-cfrg-aead-limits/</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+Epoch data keys</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    This introduces the epoch data format for AEAD data chan=
nel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ciphers in T=
LS mode ciphers. This new data format has a number of=3D</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    improvements over the standard &qu=
ot;DATA_V2&quot; format.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    - AEAD tag=
 at the end of packet which is more hardware implementation</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      friendly</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    - Automatic key switchover when ciph=
er usage limits are hit, similar to</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      the epoch data keys in (D)TLS 1.3</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    - 64 bit instead of 32 bit packet i=
ds to allow the data channel to be</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      ready for 10 GBit/s without having frequent renegotiat=
ion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    - IV constru=
cted with XOR instead of concatenation to not have (parts) of</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      the real IV on the wire</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Depre=
cated features</span><br><span> -------------------</span><br><span> ``secr=
et`` support has been removed by default.</span><br><span>diff --git a/src/=
openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index 763d756..492e=
b5a 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b=
/src/openvpn/crypto.c</span><br><span>@@ -32,6 +32,8 @@</span><br><span> #i=
nclude &lt;string.h&gt;</span><br><span> </span><br><span> #include &quot;c=
rypto.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;crypto_epoch.h&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;packet_id.h&quot;</span><br><span> #include &quot;=
error.h&quot;</span><br><span> #include &quot;integer.h&quot;</span><br><sp=
an> #include &quot;platform.h&quot;</span><br><span>@@ -67,6 +69,13 @@</spa=
n><br><span> {</span><br><span>     struct gc_arena gc;</span><br><span>   =
  int outlen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const bool use_epoch_data_format =3D opt-&gt;flags &amp; CO_EPOCH_DATA_=
KEY_FORMAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (use_epoch_data_form=
at)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        epoch_check_send_itera=
te(opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     con=
st struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.encrypt;</span><br><span=
>     uint8_t *mac_out =3D NULL;</span><br><span>     const int mac_len =3D=
 OPENVPN_AEAD_TAG_LENGTH;</span><br><span>@@ -88,14 +97,24 @@</span><br><sp=
an>         buf_set_write(&amp;iv_buffer, iv, iv_len);</span><br><span> </s=
pan><br><span>         /* IV starts with packet id to make the IV unique fo=
r packet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (!packet_id_write(&amp;opt-&gt;packet_id.send, &amp;iv_buffer, false, fals=
e))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (use_=
epoch_data_format)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(D_CRYPT_ERRORS, &quot;ENCRYPT ERROR=
: packet ID roll over&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            goto err;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (!packet_id_write_epoch(&amp;opt-&gt;packet_id.sen=
d, ctx-&gt;epoch, &amp;iv_buffer))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                msg(D_CRYPT_ERRORS, &quot;ENCRYPT ERROR: packet ID=
 roll over&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span>         }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!packet_id_write(&amp;opt-&gt;packet_id.send, &amp;iv_buffer, false, fa=
lse))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
D_CRYPT_ERRORS, &quot;ENCRYPT ERROR: packet ID roll over&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>    =
     /* Write packet id part of IV to work buffer */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_write(&amp;work, iv, pac=
ket_id_size(false)));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ASSERT(buf_write(&amp;work, iv, buf_len(&amp;iv_buffer)));</span>=
<br><span> </span><br><span>         /* This generates the IV by XORing the=
 implicit part of the IV</span><br><span>          * with the packet id alr=
eady written to the iv buffer */</span><br><span>@@ -127,7 +146,7 @@</span>=
<br><span>     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;,</span><br=
><span>          format_hex(BPTR(&amp;work), BLEN(&amp;work), 0, &amp;gc));=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (!(opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!use_epoch_data_format)</span><br=
><span>     {</span><br><span>         /* Reserve space for authentication =
tag */</span><br><span>         mac_out =3D buf_write_alloc(&amp;work, mac_=
len);</span><br><span>@@ -148,7 +167,7 @@</span><br><span>     ASSERT(buf_i=
nc_len(&amp;work, outlen));</span><br><span> </span><br><span>     /* if th=
e tag is at end the end, allocate it now */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (use_epoch_d=
ata_format)</span><br><span>     {</span><br><span>         /* Reserve spac=
e for authentication tag */</span><br><span>         mac_out =3D buf_write_=
alloc(&amp;work, mac_len);</span><br><span>@@ -363,14 +382,35 @@</span><br>=
<span> </span><br><span> bool</span><br><span> crypto_check_replay(struct c=
rypto_options *opt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  const struct packet_id_net *pin, const char *error_prefix=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  const struct packet_id_net *pin, uint16_t epoch,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    const char *error_prefix=
,</span><br><span>                     struct gc_arena *gc)</span><br><span=
> {</span><br><span>     bool ret =3D false;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    packet_id_reap_test(&amp;opt-&gt;packet_id.rec);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (packet_id_tes=
t(&amp;opt-&gt;packet_id.rec, pin))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct packet_id_rec *recv;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (epoch =3D=3D 0 || opt-&gt;key_ctx_bi.decrypt.epoch =3D=3D =
epoch)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        packet_id_add(&amp;opt-&gt;packet_id.rec, pin);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        recv =3D &amp;opt-&gt;p=
acket_id.rec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (epoch =
=3D=3D opt-&gt;epoch_retiring_data_receive_key.epoch)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        recv =3D &amp;opt-&gt;epoch_retiring_key_pid_re=
cv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* We have an epoch that is neither current or =
old recv key but</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * is authenticated, ie we need to move to a new current recv key */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_GENKEY,=
 &quot;Received data packet with new epoch %d. Updating &quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;receive key&qu=
ot;, epoch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 epoch_replace_update_recv_key(opt, epoch);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        recv =3D &amp;opt-&gt;packet_id.rec;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    packet_id_reap_test(recv);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (packet_id_test(recv, pin))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        packet_id_add(recv, pin);</span><br><sp=
an>         if (opt-&gt;pid_persist &amp;&amp; (opt-&gt;flags &amp; CO_PACK=
ET_ID_LONG_FORM))</span><br><span>         {</span><br><span>             p=
acket_id_persist_save_obj(opt-&gt;pid_persist, &amp;opt-&gt;packet_id);</sp=
an><br><span>@@ -405,15 +445,17 @@</span><br><span> {</span><br><span>     =
static const char error_prefix[] =3D &quot;AEAD Decrypt error&quot;;</span>=
<br><span>     struct packet_id_net pin =3D { 0 };</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct key_ctx *ctx =3D &amp;opt-&gt;key_c=
tx_bi.decrypt;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (cipher_decrypt_verify_fail_exceeded(ctx))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct key_ctx *ctx =3D &amp;o=
pt-&gt;key_ctx_bi.decrypt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const bool use_epoch_data_format =3D opt-&gt;flags &amp; CO_=
EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!use_epoch_data_format &amp;&amp; cipher_decrypt_verify_fail_exc=
eeded(ctx))</span><br><span>     {</span><br><span>         CRYPT_DROP(&quo=
t;Decryption failed verification limit reached.&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        goto error_exit;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int outlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span> </s=
pan><br><span>     gc_init(&amp;gc);</span><br><span> </span><br><span>@@ -=
434,18 +476,61 @@</span><br><span>     /* IV and Packet ID required for thi=
s mode */</span><br><span>     ASSERT(packet_id_initialized(&amp;opt-&gt;pa=
cket_id));</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Ensure that the packet size is long enough */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int min_packet_len =3D packet=
_id_size(false) + tag_size + 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(use_epoch_data_format)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi=
n_packet_len +=3D sizeof(uint32_t);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf-&gt;l=
en &lt; min_packet_len)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CR=
YPT_ERROR(&quot;missing IV info, missing tag or no payload&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint16_t epoch =3D 0;</span><br><span>     /* Combine IV=
 from explicit part from packet and implicit part from context */</span><br=
><span>     {</span><br><span>         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =
=3D { 0 };</span><br><span>         const int iv_len =3D cipher_ctx_iv_leng=
th(ctx-&gt;cipher);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      const size_t packet_iv_len =3D packet_id_size(false);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf-&gt=
;len &lt; packet_iv_len)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* Read packet id. For epoch data format also lookup the epoch=
 key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * to b=
e able to use the implicit IV of the correct decryption key */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (use_epoch_data_forma=
t)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            CRYPT_ERROR(&quot;missing IV info&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* packet ID format is 16 bit epo=
ch + 48 per epoch packet-counter */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            const size_t packet_iv_len =3D sizeof(uint64_t)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      memcpy(iv, BPTR(buf), packet_iv_len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* copy the epoch-counter part into the=
 IV */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
emcpy(iv, BPTR(buf), packet_iv_len);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          epoch =3D packet_id_read_epoch(&amp;pin, buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (epoch =3D=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                CRYPT_ERROR(&quo=
t;error reading packet-id&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            ctx =3D epoch_lookup_decrypt_key(opt, epoch);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (!ctx)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                CRYPT_ERROR(&quot=
;data packet with unknown epoch&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            else if (cipher_decrypt_verify_fail_exceeded(ctx)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                CRYPT_DR=
OP(&quot;Decryption failed verification limit reached&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                goto error_exit;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            const size_t packet_iv_len =3D packet_i=
d_size(false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* Packet ID form is a 32 bit packet counter */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            memcpy(iv, BPTR(buf), packet=
_iv_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (!packet_id_read(&amp;pin, buf, false))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                CRYPT_ERROR(&quot;error reading packet-i=
d&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span> </span><br><span>         /* This generates the IV by XORing the=
 implicit part of the IV</span><br><span>          * with the packet id alr=
eady written to the iv buffer */</span><br><span>@@ -463,25 +548,12 @@</spa=
n><br><span>         }</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* Read packet ID from packet=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!packet_id=
_read(&amp;pin, buf, false))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        C=
RYPT_ERROR(&quot;error reading packet-id&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* kee=
p the tag value to feed in later */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt; tag_si=
ze + 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;miss=
ing tag or no payload&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     const int ad_size =3D BPTR(buf) - ad_start;</span><br><span> =
</span><br><span>     uint8_t *tag_ptr =3D NULL;</span><br><span>     int d=
ata_len =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (use_epoch_data_format)=
</span><br><span>     {</span><br><span>         data_len =3D BLEN(buf) - t=
ag_size;</span><br><span>         tag_ptr =3D BPTR(buf) + data_len;</span><=
br><span>@@ -502,13 +574,13 @@</span><br><span>         CRYPT_ERROR(&quot;p=
otential buffer overflow&quot;);</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /=
* feed in tag and the authenticated data */</span><br><span>     ASSERT(cip=
her_ctx_update_ad(ctx-&gt;cipher, ad_start, ad_size));</span><br><span>    =
 dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;,</span><br><span>       =
   format_hex(ad_start, ad_size, 0, &amp;gc));</span><br><span> </span><br>=
<span>     /* Decrypt and authenticate packet */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int outlen;</span><br><span>     if (!ciph=
er_ctx_update(ctx-&gt;cipher, BPTR(&amp;work), &amp;outlen, BPTR(buf),</spa=
n><br><span>                            data_len))</span><br><span>     {</=
span><br><span>@@ -527,7 +599,7 @@</span><br><span>     dmsg(D_PACKET_CONTE=
NT, &quot;DECRYPT TO: %s&quot;,</span><br><span>          format_hex(BPTR(&=
amp;work), BLEN(&amp;work), 80, &amp;gc));</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!crypto_check_replay(opt, &a=
mp;pin, error_prefix, &amp;gc))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!crypto_check_replay(opt, &amp;pin, epoch, error_prefix=
, &amp;gc))</span><br><span>     {</span><br><span>         goto error_exit=
;</span><br><span>     }</span><br><span>@@ -704,7 +776,7 @@</span><br><spa=
n>             }</span><br><span>         }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (have_pin &amp;&amp; !cr=
ypto_check_replay(opt, &amp;pin, error_prefix, &amp;gc))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (have_pin &amp;&amp; !crypt=
o_check_replay(opt, &amp;pin, 0, error_prefix, &amp;gc))</span><br><span>  =
       {</span><br><span>             goto error_exit;</span><br><span>    =
     }</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/cryp=
to.h</span><br><span>index 3776c9b..4f2c172 100644</span><br><span>--- a/sr=
c/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><sp=
an>@@ -525,6 +525,7 @@</span><br><span>  *</span><br><span>  * @param opt  =
 Crypto options for this packet, contains replay state.</span><br><span>  *=
 @param pin   Packet ID read from packet.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param epoch Epoch read from packet or 0 when epoc=
h is not used.</span><br><span>  * @param error_prefix  Prefix to use when =
printing error messages.</span><br><span>  * @param gc    Garbage collector=
 to use.</span><br><span>  *</span><br><span>@@ -532,6 +533,7 @@</span><br>=
<span>  */</span><br><span> bool crypto_check_replay(struct crypto_options =
*opt,</span><br><span>                          const struct packet_id_net =
*pin,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
           uint16_t epoch,</span><br><span>                          const =
char *error_prefix,</span><br><span>                          struct gc_are=
na *gc);</span><br><span> </span><br><span>diff --git a/src/openvpn/crypto_=
backend.h b/src/openvpn/crypto_backend.h</span><br><span>index 6371013..71e=
8228 100644</span><br><span>--- a/src/openvpn/crypto_backend.h</span><br><s=
pan>+++ b/src/openvpn/crypto_backend.h</span><br><span>@@ -39,7 +39,7 @@</s=
pan><br><span> #include &quot;basic.h&quot;</span><br><span> #include &quot=
;buffer.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/* TLS uses a tag of 128 bytes, let&#39;s do the same for OpenV=
PN */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLS uses a =
tag of 128 bits, let&#39;s do the same for OpenVPN */</span><br><span> #def=
ine OPENVPN_AEAD_TAG_LENGTH 16</span><br><span> </span><br><span> /* Maximu=
m cipher block size (bytes) */</span><br><span>diff --git a/src/openvpn/dco=
.h b/src/openvpn/dco.h</span><br><span>index 035474f..c3e05a8 100644</span>=
<br><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</=
span><br><span>@@ -249,6 +249,15 @@</span><br><span>  */</span><br><span> c=
onst char *dco_get_supported_ciphers(void);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Return whether the dco implementation supports=
 the new protocol features of</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * a 64 bit packet counter and AEAD tag at the end.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+dco_supports_epoch_data(struct context *c)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span> #else /* if defined(ENABLE_D=
CO) */</span><br><span> </span><br><span> typedef void *dco_context_t;</spa=
n><br><span>@@ -380,5 +389,10 @@</span><br><span>     return &quot;&quot;;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dco_supports_epoch_data(struct context *c)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span> #endif /* defined(ENABLE_DCO) */</spa=
n><br><span> #endif /* ifndef DCO_H */</span><br><span>diff --git a/src/ope=
nvpn/init.c b/src/openvpn/init.c</span><br><span>index ee28380..100f3d3 100=
644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/open=
vpn/init.c</span><br><span>@@ -2761,6 +2761,19 @@</span><br><span>         =
}</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Ensure that for epoch data format is only ena=
bled if also data v2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * is enabled */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool epoch_data =3D (c-&gt;options.imported_protocol_flags &amp; CO_E=
POCH_DATA_KEY_FORMAT);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool datav2_enabled =3D (c-&gt;options.peer_id &gt;=3D 0 &amp;&amp; =
c-&gt;options.peer_id &lt; MAX_PEER_ID);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (epoch_data &amp;&amp; !datav2_enabled)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;OPTIONS ERROR: Epoch key da=
ta format tag requires &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            &quot;data v2 (peer-id) to be enabled.&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     if (found &amp; OPT_P_PUSH_MTU)</sp=
an><br><span>     {</span><br><span>         /* MTU has changed, check that=
 the pushed MTU is small enough to</span><br><span>@@ -3357,6 +3370,15 @@</=
span><br><span>         to.push_peer_info_detail =3D 1;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Check if the DCO drivers support the epoch data format */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(options)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        to.data_epoch_supported =
=3D dco_supports_epoch_data(c);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        to.data_epoch_suppo=
rted =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span> </span><br><span>     /* should we not xmit any packets u=
ntil we get an initial</span><br><span>      * response from client? */</sp=
an><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><=
br><span>index 45b3cfa..8a6887a 100644</span><br><span>--- a/src/openvpn/mu=
lti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1849,6 =
+1849,12 @@</span><br><span>     }</span><br><span> #endif</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_multi-=
&gt;session[TM_ACTIVE].opt-&gt;data_epoch_supported</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (proto &amp; IV_PROTO_=
DATA_EPOCH))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;importe=
d_protocol_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     if (proto &amp; IV_PROTO_CC_EXIT_NOTIFY=
)</span><br><span>     {</span><br><span>         o-&gt;imported_protocol_f=
lags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><span>diff --git a/src/openvpn/s=
sl.c b/src/openvpn/ssl.c</span><br><span>index e4a7b57..b58a3c8 100644</spa=
n><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c=
</span><br><span>@@ -55,6 +55,7 @@</span><br><span> #include &quot;route.h&=
quot;</span><br><span> #include &quot;tls_crypt.h&quot;</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=
_epoch.h&quot;</span><br><span> #include &quot;ssl.h&quot;</span><br><span>=
 #include &quot;ssl_verify.h&quot;</span><br><span> #include &quot;ssl_back=
end.h&quot;</span><br><span>@@ -915,6 +916,7 @@</span><br><span>     key_st=
ate_ssl_free(&amp;ks-&gt;ks_ssl);</span><br><span> </span><br><span>     fr=
ee_key_ctx_bi(&amp;ks-&gt;crypto_options.key_ctx_bi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_epoch_key_ctx(&amp;ks-&gt;crypto=
_options);</span><br><span>     free_buf(&amp;ks-&gt;plaintext_read_buf);</=
span><br><span>     free_buf(&amp;ks-&gt;plaintext_write_buf);</span><br><s=
pan>     free_buf(&amp;ks-&gt;ack_write_buf);</span><br><span>@@ -1362,6 +1=
364,48 @@</span><br><span> }</span><br><span> </span><br><span> static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_epoch_keys(str=
uct key_state *ks,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               struct tls_multi *multi,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                const struct key_type *key_type,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                bool serve=
r,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
truct key2 *key2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* For now we ha=
rdcode this to be 16 for the software based data channel</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * DCO based implementations/HW im=
plementation might adjust this number</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * based on their expected speed */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const int future_key_count =3D 16=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int key_direction =3D server ? KE=
Y_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct key_direction_state kds;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    key_direction_state_init(&amp;k=
ds, key_direction);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto_o=
ptions *co =3D &amp;ks-&gt;crypto_options;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* For the epoch key we use the first 32 bytes of key2 cipher keys<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * for the  init=
ial secret */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct epoch_key e1_send =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    e1_send.epoch =3D 1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    memcpy(&amp;e1_send.epoch_key, key2-&gt;keys[kds.out=
_key].cipher, sizeof(e1_send.epoch_key));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct epoch_key e1_recv =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    e1_recv.epoch =3D 1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    memcpy(&amp;e1_recv.epoch_key, key2-&gt;key=
s[kds.in_key].cipher, sizeof(e1_recv.epoch_key));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* DCO implementations have two choices at this point.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * a) (more likely) they probably =
to pass E1 directly to kernel</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * space at this point and do all the other key derivation in=
 kernel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * b) They let usersp=
ace do the key derivation and pass all the individual</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * keys to the DCO layer.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    epoch_init_key_ctx(co, key_type, &amp=
;e1_send, &amp;e1_recv,  future_key_count);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    secure_memzero(&amp;e1_send, sizeof(e1_send));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&amp;e1_recv, sizeof=
(e1_recv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span> init_key_context=
s(struct key_state *ks,</span><br><span>                   struct tls_multi=
 *multi,</span><br><span>                   const struct key_type *key_type=
,</span><br><span>@@ -1394,6 +1438,16 @@</span><br><span>         CLEAR(key=
-&gt;decrypt);</span><br><span>         key-&gt;initialized =3D true;</span=
><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (multi-&gt;opt.crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!cipher_kt_mode_aead(key_ty=
pe-&gt;cipher))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(M_FATAL, &quot;AEAD cipher (currently %s) &quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                &quot;required for epoch dat=
a format.&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             cipher_kt_name(key_type-&gt;cipher));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        init_epoch_keys(ks, multi, key_type, server, k=
ey2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span>     else</span><br><span>     {</span><br><span>         init_key_=
ctx_bi(key, key2, key_direction, key_type, &quot;Data Channel&quot;);</span=
><br><span>@@ -1969,6 +2023,11 @@</span><br><span>             iv_proto |=
=3D IV_PROTO_NCP_P2P;</span><br><span>         }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt;opt-=
&gt;data_epoch_supported)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        iv_proto |=3D IV_PROTO_DATA_EPOCH;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>         buf_printf(&amp;out, &quot;IV_CIPHER=
S=3D%s\n&quot;, session-&gt;opt-&gt;config_ncp_ciphers);</span><br><span> <=
/span><br><span> #ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>@@ -297=
8,6 +3037,21 @@</span><br><span>         return true;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (ks-&gt;crypto_options.flags &amp; CO_EPOCH_DATA_KEY_FORMAT)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* We only need to check the send=
 key as we always keep send</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * key epoch &gt;=3D recv key epoch in \c epoch_replace_upd=
ate_recv_key */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (ks-&gt;crypto_options.epoch_key_send.epoch &gt;=3D 0xF000)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  /* Packet id approach the limit of the packet id */</span><br><span>     =
if (packet_id_close_to_wrapping(&amp;ks-&gt;crypto_options.packet_id.send))=
</span><br><span>     {</span><br><span>@@ -2993,7 +3067,9 @@</span><br><sp=
an>      *  Since if both sides were aware, then both sides will probably a=
lso</span><br><span>      *  switch to use epoch data channel instead, so t=
his code is not</span><br><span>      *  in effect then.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * When epoch are in use the crypto layer will handle this in=
ternally</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * with=
 new epochs instead of triggering a renegotiation */</span><br><span>     c=
onst struct key_ctx_bi *key_ctx_bi =3D &amp;ks-&gt;crypto_options.key_ctx_b=
i;</span><br><span>     const uint64_t usage_limit =3D session-&gt;opt-&gt;=
aead_usage_limit;</span><br><span> </span><br><span>diff --git a/src/openvp=
n/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index e092472..96=
25a99 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><span=
>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -315,7 +315,6 @@</span><=
br><span> </span><br><span>     /* from command line */</span><br><span>   =
  bool single_session;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    bool disable_occ;</span><br><span>     int mode;</span><br><span>     =
bool pull;</span><br><span>     /**</span><br><span>@@ -368,6 +367,12 @@</s=
pan><br><span>     const char *config_ciphername;</span><br><span>     cons=
t char *config_ncp_ciphers;</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /** whether our underlying data channel suppo=
rts new data channel</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * features (epoch keys with AEAD tag at the end). This is always true=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * for the inte=
rnal implementation but can be false for DCO</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * implementations */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    bool data_epoch_supported;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool tls_cr=
ypt_v2;</span><br><span>     const char *tls_crypt_v2_verify_script;</span>=
<br><span> </span><br><span>@@ -497,8 +502,6 @@</span><br><span>      */</s=
pan><br><span>     int key_id;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int limit_next;             /* used for traf=
fic shaping on the control channel */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     int verify_maxlevel;</span><br><span>=
 </span><br><span>     char *common_name;</span><br><span>diff --git a/src/=
openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><br><span>index 167bdb2..89=
528f2 100644</span><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>++=
+ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -431,6 +431,11 @@</span><br><s=
pan>         session-&gt;opt-&gt;crypto_flags |=3D CO_USE_CC_EXIT_NOTIFY;</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (session-&gt;opt-&gt;data_epoch_supported &amp;&=
amp; (iv_proto_peer &amp; IV_PROTO_DATA_EPOCH))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        session-&gt;opt-&gt;crypto_flags |=3D CO_EPOCH_DATA_K=
EY_FORMAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if d=
efined(HAVE_EXPORT_KEYING_MATERIAL)</span><br><span>     if (iv_proto_peer =
&amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span>     {</span><br><span>@@ -5=
00,9 +505,12 @@</span><br><span>     }</span><br><span> </span><br><span>  =
   msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiation result: &quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;TLS_export=3D=
%d, DATA_v2=3D%d, peer-id %d, cipher=3D%s&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        &quot;TLS_export=3D%d, DATA_v2=3D%d, p=
eer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span>         (bool)(s=
ession-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;use_peer=
_id, multi-&gt;peer_id, common_cipher);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        multi-&gt;use_peer_id,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        multi-&gt;peer_id,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;cr=
ypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        common_cipher);</span><br><span> </span><br=
><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>diff --git=
 a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>index =
76f06bc..7c5eb01 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</span=
><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -301,7 +301,7 @=
@</span><br><span>         struct buffer tmp =3D *src;</span><br><span>    =
     ASSERT(buf_advance(&amp;tmp, TLS_CRYPT_OFF_PID));</span><br><span>    =
     ASSERT(packet_id_read(&amp;pin, &amp;tmp, true));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (!crypto_check_replay(opt, &amp=
;pin, error_prefix, &amp;gc))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (!crypto_check_replay(opt, &amp;pin, 0, error_prefix, =
&amp;gc))</span><br><span>         {</span><br><span>             CRYPT_ERR=
OR(&quot;packet replay&quot;);</span><br><span>         }</span><br><span>d=
iff --git a/tests/Makefile.am b/tests/Makefile.am</span><br><span>index f26=
b3b8..3246e34 100644</span><br><span>--- a/tests/Makefile.am</span><br><spa=
n>+++ b/tests/Makefile.am</span><br><span>@@ -52,6 +52,7 @@</span><br><span=
> 	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir=
)/src/openvpn/crypto.c \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/crypto_mbedtls.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.=
c \</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tes=
ts/unit_tests/openvpn/Makefile.am</span><br><span>index 307f9ed..471389b 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><=
span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -86,6 +8=
6,7 @@</span><br><span> 	$(top_srcdir)/src/compat/compat-strsep.c \</span><=
br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_src=
dir)/src/openvpn/cryptoapi.c \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(=
top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span> 	$(top_srcdir)/=
src/openvpn/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/=
env_set.c \</span><br><span>@@ -132,6 +133,7 @@</span><br><span> 	$(top_src=
dir)/src/openvpn/base64.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buf=
fer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypt=
o_epoch.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/env_set.c \</span><br><span>@@ -160,6 +162,=
7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/base64.c \</span><br><span=
> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src=
/openvpn/crypto.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)=
/src/openvpn/crypto_mbedtls.c \</span><br><span> 	$(top_srcdir)/src/openvpn=
/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/env_set.c \=
</span><br><span>@@ -179,6 +182,7 @@</span><br><span> 	$(top_srcdir)/src/op=
envpn/networking_sitnl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buff=
er.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto=
_epoch.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</=
span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><span>@@ -250,6 +254,7 @=
@</span><br><span> auth_token_testdriver_SOURCES =3D test_auth_token.c mock=
_msg.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><=
span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><=
br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span> 	$=
(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span> 	$(top_srcdir)=
/src/openvpn/otime.c \</span><br><span>@@ -285,6 +290,7 @@</span><br><span>=
 ncp_testdriver_SOURCES =3D test_ncp.c mock_msg.c \</span><br><span> 	$(top=
_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn=
/crypto.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_s=
rcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/crypto_mbedtls.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_=
openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/=
openvpn/test_ssl.c</span><br><span>index 845ca56..842c944 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -35,6 +35,7 @@</span><br>=
<span> #include &lt;cmocka.h&gt;</span><br><span> </span><br><span> #includ=
e &quot;crypto.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;crypto_epoch.h&quot;</span><br><span> #include &quot;opti=
ons.h&quot;</span><br><span> #include &quot;ssl_backend.h&quot;</span><br><=
span> #include &quot;options_util.h&quot;</span><br><span>@@ -370,22 +371,4=
6 @@</span><br><span> </span><br><span> </span><br><span> struct crypto_opt=
ions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_crypto_optio=
ns(const char *cipher, const char *auth)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+init_crypto_options(const char *cipher, const char *au=
th, bool epoch,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                struct key2 *statickey)</span><br><span> {</span><br><span>=
     struct key2 key2 =3D { .n =3D 2};</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(rand_bytes(key2.keys[0].ciphe=
r, sizeof(key2.keys[0].cipher)));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hm=
ac)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(rand=
_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher)));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(rand_bytes(key2.keys[1].hma=
c, sizeof(key2.keys)[1].hmac));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (statickey)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* Use chosen static key instead of random key when defined */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        key2 =3D *statickey=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(k=
ey2.keys[0].cipher)));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(ran=
d_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher)));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(rand_bytes(key2.keys=
[1].hmac, sizeof(key2.keys)[1].hmac));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span> </span><br><span>     struct cryp=
to_options co =3D { 0 };</span><br><span> </span><br><span>     struct key_=
type kt =3D create_kt(cipher, auth, &quot;ssl-test&quot;);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_ctx_bi(=
&amp;co.key_ctx_bi, &amp;key2, 0, &amp;kt, &quot;unit-test-ssl&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_init(&amp;co=
.packet_id,  5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (epoch)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct epoch_key e1 =3D { .epoch =3D 1, .epoch_key =3D { 0 }}=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(e1.=
epoch_key, key2.keys[0].cipher, sizeof(e1.epoch_key));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        co.flags |=3D CO_EPOCH_DATA_KEY_=
FORMAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        epoc=
h_init_key_ctx(&amp;co, &amp;kt, &amp;e1, &amp;e1, 5);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Do a little=
 of dancing for the epoch_send_key_iterate to test</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * that this works too */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        epoch_iterate_send_key=
(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
poch_iterate_send_key(&amp;co);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        epoch_iterate_send_key(&amp;co);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   init_key_ctx_bi(&amp;co.key_ctx_bi, &amp;key2, KEY_DIRECTION_BIDIRECTION=
AL, &amp;kt, &quot;unit-test-ssl&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    packet_id_init(&amp;co.packet_id, 5, 5, &quot;UNITTEST&quot;, 0)=
;</span><br><span>     return co;</span><br><span> }</span><br><span> </spa=
n><br><span>@@ -394,17 +419,16 @@</span><br><span> {</span><br><span>     p=
acket_id_free(&amp;co-&gt;packet_id);</span><br><span>     free_key_ctx_bi(=
&amp;co-&gt;key_ctx_bi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_epoch_k=
ey_ctx(co);</span><br><span> }</span><br><span> </span><br><span> /* This a=
dds a few more methods than strictly necessary but this allows</span><br><s=
pan>  * us to see which exact test was run from the backtrace of the test</=
span><br><span>  * when it fails */</span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-run_data_channel_with_cipher_end=
(const char *cipher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+run_data_channel_with_cipher_epoch(const char *cipher)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct crypto_opti=
ons co =3D init_crypto_options(cipher, &quot;none&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    co.flags |=3D CO_EPOCH_DATA_KEY_FOR=
MAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct cryp=
to_options co =3D init_crypto_options(cipher, &quot;none&quot;, true, NULL)=
;</span><br><span>     do_data_channel_round_trip(&amp;co);</span><br><span=
>     uninit_crypto_options(&amp;co);</span><br><span> }</span><br><span>@@=
 -412,7 +436,7 @@</span><br><span> static void</span><br><span> run_data_ch=
annel_with_cipher(const char *cipher, const char *auth)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct crypto_opti=
ons co =3D init_crypto_options(cipher, auth);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct crypto_options co =3D init_crypto_opti=
ons(cipher, auth, false, NULL);</span><br><span>     do_data_channel_round_=
trip(&amp;co);</span><br><span>     uninit_crypto_options(&amp;co);</span><=
br><span> }</span><br><span>@@ -421,25 +445,40 @@</span><br><span> static v=
oid</span><br><span> test_data_channel_roundtrip_aes_128_gcm(void **state)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 run_data_channel_with_cipher_end(&quot;AES-128-GCM&quot;);</span><br><span=
>     run_data_channel_with_cipher(&quot;AES-128-GCM&quot;, &quot;none&quot=
;);</span><br><span> }</span><br><span> </span><br><span> static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_data_channel_roundtr=
ip_aes_128_gcm_epoch(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 run_data_channel_with_cipher_epoch(&quot;AES-128-GCM&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span> test_data_channel_roundtrip_aes_192_gcm(v=
oid **state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    run_data_channel_with_cipher_end(&quot;AES-192-GCM&quot;);</s=
pan><br><span>     run_data_channel_with_cipher(&quot;AES-192-GCM&quot;, &q=
uot;none&quot;);</span><br><span> }</span><br><span> </span><br><span> stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_data_ch=
annel_roundtrip_aes_192_gcm_epoch(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    run_data_channel_with_cipher_epoch(&quot;AES-192-GCM&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span> test_data_channel_roundtrip_=
aes_256_gcm(void **state)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    run_data_channel_with_cipher_end(&quot;AES-256-G=
CM&quot;);</span><br><span>     run_data_channel_with_cipher(&quot;AES-256-=
GCM&quot;, &quot;none&quot;);</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_data_channel_roundtrip_aes_256_gcm_epoch(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    run_data_channel_with_cipher_epoch(&quot;AES-256=
-GCM&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span> test_data_chann=
el_roundtrip_aes_128_cbc(void **state)</span><br><span> {</span><br><span> =
    run_data_channel_with_cipher(&quot;AES-128-CBC&quot;, &quot;SHA256&quot=
;);</span><br><span>@@ -466,11 +505,22 @@</span><br><span>         return;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    run_data_channel_with_cipher_end(&quot;ChaCha20-Poly=
1305&quot;);</span><br><span>     run_data_channel_with_cipher(&quot;ChaCha=
20-Poly1305&quot;, &quot;none&quot;);</span><br><span> }</span><br><span> <=
/span><br><span> static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_data_channel_roundtrip_chacha20_poly1305_epoch(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!cipher_valid(&quot;ChaCha20-P=
oly1305&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        skip();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    run_data_channel_with_cipher_epoch(&quot;ChaCha20-Poly1=
305&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span> test_data_channe=
l_roundtrip_bf_cbc(void **state)</span><br><span> {</span><br><span>     if=
 (!cipher_valid(&quot;BF-CBC&quot;))</span><br><span>@@ -482,6 +532,154 @@<=
/span><br><span> }</span><br><span> </span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static struct key2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+create_key(void)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct key2 key2 =3D {.n =3D 2};</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const uint8_t key[] =3D</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {&#39;a&#39;, &#39;b&#39;, &#39;c&#39;, &#39;d&#39;,=
 &#39;e&#39;, &#39;f&#39;, &#39;g&#39;, &#39;h&#39;, &#39;0&#39;, &#39;1&#3=
9;, &#39;2&#39;, &#39;3&#39;, &#39;4&#39;, &#39;5&#39;, &#39;6&#39;, &#39;7=
&#39;, &#39;A&#39;, &#39;B&#39;, &#39;C&#39;, &#39;D&#39;, &#39;E&#39;, &#3=
9;F&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     &#39;=
G&#39;, &#39;H&#39;, &#39;j&#39;, &#39;k&#39;, &#39;u&#39;, &#39;c&#39;, &#=
39;h&#39;, &#39;e&#39;, &#39;n&#39;, &#39;l&#39;};</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    static_assert(sizeof(key) =3D=3D 32, &quot;Size of key shou=
ld be 32 bytes&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* copy the =
key a few times to ensure to have the size we need for</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * Statickey but XOR it to not repea=
t it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t =
keydata[sizeof(key2.keys)];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (in=
t i =3D 0; i &lt; sizeof(key2.keys); i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        keydata[i] =3D (uint8_t) (key[i % sizeof(key)] ^ i);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(memcpy(key2.keys[0].cipher, keydata, sizeof(key2=
.keys[0].cipher)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(memcpy(key2.keys[0].hmac, keydata + 64, sizeof(key2.keys[0].hmac=
)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(memc=
py(key2.keys[1].cipher, keydata + 128, sizeof(key2.keys[1].cipher)));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(memcpy(key2.ke=
ys[1].hmac, keydata + 192, sizeof(key2.keys)[1].hmac));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return key2;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_data_channel_known_vectors=
_run(bool epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key2 key2 =
=3D create_key();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto_opt=
ions co =3D init_crypto_options(&quot;AES-256-GCM&quot;, &quot;none&quot;, =
epoch,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                      &amp;key2);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* initialise frame for the test */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct frame frame;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    init_frame_parameters(&amp;frame);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer src =3D alloc_buf_gc(fr=
ame.buf.payload_size, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer dec=
rypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D clear=
_buf();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *bu=
f_p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* init work */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;work, fra=
me.buf.headroom));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * Load src with known data.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ASSERT(buf_init(&amp;src, 0));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *plaintext =3D &quot;The q=
uick little fox jumps over the bureaucratic hurdles&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(buf_write(&amp;src, plaintext, strlen(plaint=
ext)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* copy source to input buf=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D work=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_p =3D buf_=
write_alloc(&amp;buf, BLEN(&amp;src));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ASSERT(buf_p);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    memcpy(buf_p, BPTR(&amp;src), BLEN(&amp;src));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* initialize work buffer with buf.headro=
om bytes of prepend capacity */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(buf_init(&amp;encrypt_workspace, frame.buf.headroom)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* add packet opcode and peer id=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8=
(&amp;encrypt_workspace, 7);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_write_u8(&amp;encrypt_workspace, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(&amp;encrypt_workspace, =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8=
(&amp;encrypt_workspace, 23);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* en=
crypt */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn=
_encrypt(&amp;buf, encrypt_workspace, &amp;co);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* separate buffer in authenticated data and encrypted data */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *ad_sta=
rt =3D BPTR(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_advance(&amp;buf, 4);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t packetid1=
[8] =3D {0, 0x04, 0, 0, 0, 0, 0, 1};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        assert_memory_equal(BPTR(&amp;buf), packetid1, 8);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        uint8_t packetid1[4] =3D {0, 0, 0, 1};</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equal(BPT=
R(&amp;buf), packetid1, 4);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (epoch)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uint8_t *tag_location =3D BEND(&amp;=
buf) - OPENVPN_AEAD_TAG_LENGTH;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const uint8_t exp_tag_long[16] =3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {0x0f, 0xff, 0xf5, 0x91, 0x3d, 0=
x39, 0xd7, 0x5b,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      0x18, 0x57, 0x3b, 0x57, 0x48, 0x58, 0x9a, 0x7d};</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        assert_memory_equal(tag_location, exp_tag_long, OPE=
NVPN_AEAD_TAG_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        uint8_t *tag_location =3D BP=
TR(&amp;buf) + 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const uint8_t exp_tag_short[16] =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {0x1f, 0xdd, 0x90, 0x8f, 0x0e, 0x9d, 0xc2, 0x=
5e, 0x79, 0xd8, 0x32, 0x02, 0x0d, 0x58, 0xe7, 0x3f};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equal(tag_location,=
 exp_tag_short, OPENVPN_AEAD_TAG_LENGTH);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Chec=
k some bytes at the beginning of the encrypted part */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (epoch)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        const uint8_t bytesat14[6] =3D {0x36, 0xaa, 0xb4, 0=
xd4, 0x9c, 0xe6};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      assert_memory_equal(BPTR(&amp;buf) + 14, bytesat14, sizeof(bytesat14)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const uint8_t bytesat30[6] =3D {0xa8, 0x2e, 0x6=
b, 0x17, 0x06, 0xd9};</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        assert_memory_equal(BPTR(&amp;buf) + 30, bytesat30, sizeof(bytesa=
t30));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* decrypt */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    openvpn_decrypt(&amp;buf, decrypt_workspace,=
 &amp;co, &amp;frame, ad_start);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 compare */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(buf.len, strlen(plaintext));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), plaintext, st=
rlen(plaintext));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uninit_crypto_opt=
ions(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_data_channel_known_vectors_epoch(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    test_data_channel_known_vector=
s_run(true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_data_channel_known_vectors_shortpktid(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    test_data_channel_known_vecto=
rs_run(false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> ma=
in(void)</span><br><span> {</span><br><span>@@ -492,13 +690,19 @@</span><br=
><span>         cmocka_unit_test(test_load_certificate_and_key),</span><br>=
<span>         cmocka_unit_test(test_load_certificate_and_key_uri),</span><=
br><span>         cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_data_channel_roundtrip_aes_128_gcm_epoch),</span><br><span>    =
     cmocka_unit_test(test_data_channel_roundtrip_aes_192_gcm),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_d=
ata_channel_roundtrip_aes_192_gcm_epoch),</span><br><span>         cmocka_u=
nit_test(test_data_channel_roundtrip_aes_256_gcm),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_data_channel_r=
oundtrip_aes_256_gcm_epoch),</span><br><span>         cmocka_unit_test(test=
_data_channel_roundtrip_chacha20_poly1305),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_data_channel_roundtri=
p_chacha20_poly1305_epoch),</span><br><span>         cmocka_unit_test(test_=
data_channel_roundtrip_aes_128_cbc),</span><br><span>         cmocka_unit_t=
est(test_data_channel_roundtrip_aes_192_cbc),</span><br><span>         cmoc=
ka_unit_test(test_data_channel_roundtrip_aes_256_cbc),</span><br><span>    =
     cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_data_c=
hannel_known_vectors_epoch),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_data_channel_known_vectors_shortpkti=
d)</span><br><span>     };</span><br><span> </span><br><span> #if defined(E=
NABLE_CRYPTO_OPENSSL)</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail">change 806<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00751c42cb04e30205ba8e65845=
30831e0d143c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 806 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--b2cR3Axl67E=--

