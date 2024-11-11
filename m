From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 02:00:09 +0000
References: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a095cdb053f42726de436a1c3c37473191f6dd2c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/k/p7inG4Sc="; charset=UTF-8
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

--/k/p7inG4Sc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail

to review the following change.


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
14 files changed, 443 insertions(+), 60 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/806/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index cbc93cd..6daeaea 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -705,6 +705,7 @@

     target_sources(test_auth_token PRIVATE
         src/openvpn/base64.c
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
@@ -733,9 +734,10 @@
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
@@ -761,6 +763,7 @@
         )

     target_sources(test_ncp PRIVATE
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
@@ -782,6 +785,7 @@
         tests/unit_tests/openvpn/mock_win32_execve.c
         src/openvpn/argv.c
         src/openvpn/base64.c
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
@@ -835,9 +839,11 @@
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
@@ -853,6 +859,7 @@
             tests/unit_tests/openvpn/mock_win32_execve.c
             src/openvpn/argv.c
             src/openvpn/base64.c
+            src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 996830c..f239282 100644
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
@@ -68,7 +70,15 @@
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
+
     uint8_t *mac_out =3D NULL;
     const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;

@@ -89,14 +99,24 @@
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

         /* Remainder of IV consists of implicit part (unique per session)
          * XOR of packet and implicit IV */
@@ -128,7 +148,7 @@
     dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s",
          format_hex(BPTR(&work), BLEN(&work), 0, &gc));

-    if (!(opt->flags & CO_EPOCH_DATA_KEY_FORMAT))
+    if (!use_epoch_data_format)
     {
         /* Reserve space for authentication tag */
         mac_out =3D buf_write_alloc(&work, mac_len);
@@ -149,7 +169,7 @@
     ASSERT(buf_inc_len(&work, outlen));

     /* if the tag is at end the end, allocate it now */
-    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
+    if (use_epoch_data_format)
     {
         /* Reserve space for authentication tag */
         mac_out =3D buf_write_alloc(&work, mac_len);
@@ -365,14 +385,35 @@

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
@@ -408,8 +449,9 @@
     static const char error_prefix[] =3D "AEAD Decrypt error";
     struct packet_id_net pin =3D { 0 };
     const struct key_ctx *ctx =3D &opt->key_ctx_bi.decrypt;
-    int outlen;
     struct gc_arena gc;
+    const bool use_epoch_data_format =3D opt->flags & CO_EPOCH_DATA_KEY_FO=
RMAT;
+    const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;

     gc_init(&gc);

@@ -428,20 +470,58 @@
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

-        if (buf->len < packet_id_size(false))
+        /* Read packet id. For epoch data format also lookup the epoch key
+         * to be able to use the implicit IV of the correct decryption key=
 */
+        if (use_epoch_data_format)
         {
-            CRYPT_ERROR("missing IV info");
+            /* packet ID format is 16 bit epoch + 48 per epoch packet-coun=
ter */
+            const size_t packet_iv_len =3D sizeof(uint64_t);
+
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
         }

-        memcpy(iv, BPTR(buf), packet_iv_len);
-
-        /* Remainder of IV consists of implicit part (unique per session)
+        /* Remainder of IV consists of implicit part (unique per session/e=
poch key)
          * XOR of packet counter and implicit IV */
         for (int i =3D 0; i < iv_len; i++)
         {
@@ -457,25 +537,12 @@
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
@@ -496,13 +563,13 @@
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
@@ -525,7 +592,7 @@
     dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s",
          format_hex(BPTR(&work), BLEN(&work), 80, &gc));

-    if (!crypto_check_replay(opt, &pin, error_prefix, &gc))
+    if (!crypto_check_replay(opt, &pin, epoch, error_prefix, &gc))
     {
         goto error_exit;
     }
@@ -696,7 +763,7 @@
             }
         }

-        if (have_pin && !crypto_check_replay(opt, &pin, error_prefix, &gc))
+        if (have_pin && !crypto_check_replay(opt, &pin, 0, error_prefix, &=
gc))
         {
             goto error_exit;
         }
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 933bc2f..369d19f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -518,6 +518,7 @@
  */
 bool crypto_check_replay(struct crypto_options *opt,
                          const struct packet_id_net *pin,
+                         uint16_t epoch,
                          const char *error_prefix,
                          struct gc_arena *gc);

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index c454c64..de74def 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -38,7 +38,7 @@
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
index 2c831fe..387d895 100644
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
index 9eaf3ac..d2d862f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -54,6 +54,7 @@
 #include "route.h"
 #include "tls_crypt.h"

+#include "crypto_epoch.h"
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "ssl_backend.h"
@@ -912,6 +913,7 @@
     key_state_ssl_free(&ks->ks_ssl);

     free_key_ctx_bi(&ks->crypto_options.key_ctx_bi);
+    free_epoch_key_ctx(&ks->crypto_options);
     free_buf(&ks->plaintext_read_buf);
     free_buf(&ks->plaintext_write_buf);
     free_buf(&ks->ack_write_buf);
@@ -1359,6 +1361,48 @@
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
@@ -1391,6 +1435,16 @@
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
@@ -1966,6 +2020,11 @@
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
@@ -2975,13 +3034,29 @@
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
         return true;
     }

-    /* Check the AEAD usage limit of cleartext blocks + packets */
+    /* Check the AEAD usage limit of cleartext blocks + packets.
+     * When epoch are in use the crypto layer will handle this internally =
*/
     const struct key_ctx_bi *key_ctx_bi =3D &ks->crypto_options.key_ctx_bi;
     const int64_t usage_limit =3D session->opt->aead_usage_limit;

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 511127d..6a4b39d 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -314,7 +314,6 @@

     /* from command line */
     bool single_session;
-    bool disable_occ;
     int mode;
     bool pull;
     /**
@@ -367,6 +366,12 @@
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

@@ -496,8 +501,6 @@
      */
     int key_id;

-    int limit_next;             /* used for traffic shaping on the control=
 channel */
-
     int verify_maxlevel;

     char *common_name;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 968858e..00be96d 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -430,6 +430,11 @@
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
@@ -499,9 +504,12 @@
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
index 845ca56..93b3094 100644
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
@@ -421,21 +445,21 @@
 static void
 test_data_channel_roundtrip_aes_128_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-128-GCM");
+    run_data_channel_with_cipher_epoch("AES-128-GCM");
     run_data_channel_with_cipher("AES-128-GCM", "none");
 }

 static void
 test_data_channel_roundtrip_aes_192_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-192-GCM");
+    run_data_channel_with_cipher_epoch("AES-192-GCM");
     run_data_channel_with_cipher("AES-192-GCM", "none");
 }

 static void
 test_data_channel_roundtrip_aes_256_gcm(void **state)
 {
-    run_data_channel_with_cipher_end("AES-256-GCM");
+    run_data_channel_with_cipher_epoch("AES-256-GCM");
     run_data_channel_with_cipher("AES-256-GCM", "none");
 }

@@ -466,7 +490,7 @@
         return;
     }

-    run_data_channel_with_cipher_end("ChaCha20-Poly1305");
+    run_data_channel_with_cipher_epoch("ChaCha20-Poly1305");
     run_data_channel_with_cipher("ChaCha20-Poly1305", "none");
 }

@@ -482,6 +506,153 @@
 }
=20

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
+        {0x86, 0x20, 0xfe, 0xc6, 0x65, 0xa6, 0xab, 0x2a,
+         0x34, 0xa6, 0xb8, 0xd4, 0xb4, 0xa9, 0x00, 0x9e};
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
+        const uint8_t bytesat14[6] =3D {0x62, 0xa9, 0xe3, 0x7a, 0xa7, 0xf0=
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
@@ -499,6 +670,8 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--/k/p7inG4Sc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Implement epoch key data format<br><br>With DCO and possible =
future hardware assisted OpenVPN acceleration we<br>are approaching the poi=
nt where 32 bit IVs are not cutting it any more,<br>especially if we are li=
miting the IVs to the safe limits of AES-GCM where<br>the limit is more 2^2=
9.<br><br>To illustrate the problem, some back of the envelope math here:<b=
r><br>If we want to keep the current 3600s renegotiation interval and have<=
br>a safety margin of 25% (when we trigger renegotiation) we have about<br>=
3.2 million packets (2*32 * 0.7) to work with. That translates to<br>about =
835k packets per second. Currently, implementation trigger the<br>renegotia=
tion at 0xff00000000 or at 7/8 of the AEAD usage limit.<br><br>With 1300 By=
te packets that translates into 8-9 Gbit/s. That is far<br>from unrealistic=
 any more. Current DCO implementations are already in<br>spitting distance =
to that or might even reach (for a single client<br>connection) that if you=
 have extremely fast<br>single core performance CPU.<br><br>With the AEAD u=
sage limit, these limits are almost a factor of 8 lower<br>so with the limi=
t becomes 1-2 GBit/s. This is already reached without<br>DCO on some platfo=
rms.<br><br>This introduces the epoch data format for AEAD data channel<br>=
ciphers in TLS mode ciphers. No effort has been made to support<br>larger p=
acket counters in any other scenario since those are all legacy.<br>This us=
es the same approach of epoch keys as (D)TLS 1.3 does and switches<br>the d=
ata channel regularly for affected AEAD ciphers when reaching the<br>usage =
limit.<br><br>For Chacha20-Poly1305, which does not suffer the same problem=
s as AES-GCM,<br>the full 48 bit of packet counter are used only after that=
 the same logic<br>to switch to a new key as with AES-GCM is done.<br><br>C=
hange-Id: I00751c42cb04e30205ba8e6584530831e0d143c5<br>Signed-off-by: Arne =
Schwabe &lt;arne@...1227...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn=
/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/crypto_backend.h<br>M =
src/openvpn/dco.h<br>M src/openvpn/init.c<br>M src/openvpn/multi.c<br>M src=
/openvpn/ssl.c<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl_ncp.c<br>=
M src/openvpn/tls_crypt.c<br>M tests/Makefile.am<br>M tests/unit_tests/open=
vpn/Makefile.am<br>M tests/unit_tests/openvpn/test_ssl.c<br>14 files change=
d, 443 insertions(+), 60 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/06/806/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.=
txt b/CMakeLists.txt</span><br><span>index cbc93cd..6daeaea 100644</span><b=
r><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br=
><span>@@ -705,6 +705,7 @@</span><br><span> </span><br><span>     target_so=
urces(test_auth_token PRIVATE</span><br><span>         src/openvpn/base64.c=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn=
/crypto_epoch.c</span><br><span>         src/openvpn/crypto_mbedtls.c</span=
><br><span>         src/openvpn/crypto_openssl.c</span><br><span>         s=
rc/openvpn/crypto.c</span><br><span>@@ -733,9 +734,10 @@</span><br><span>  =
           tests/unit_tests/openvpn/mock_win32_execve.c</span><br><span>   =
          src/openvpn/argv.c</span><br><span>             src/openvpn/base6=
4.c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            src/op=
envpn/crypto.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       src/openvpn/crypto_epoch.c</span><br><span>             src/openvpn/=
crypto_mbedtls.c</span><br><span>             src/openvpn/crypto_openssl.c<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/open=
vpn/crypto.c</span><br><span>             src/openvpn/cryptoapi.c</span><br=
><span>             src/openvpn/env_set.c</span><br><span>             src/=
openvpn/mss.c</span><br><span>@@ -761,6 +763,7 @@</span><br><span>         =
)</span><br><span> </span><br><span>     target_sources(test_ncp PRIVATE</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/cr=
ypto_epoch.c</span><br><span>         src/openvpn/crypto_mbedtls.c</span><b=
r><span>         src/openvpn/crypto_openssl.c</span><br><span>         src/=
openvpn/crypto.c</span><br><span>@@ -782,6 +785,7 @@</span><br><span>      =
   tests/unit_tests/openvpn/mock_win32_execve.c</span><br><span>         sr=
c/openvpn/argv.c</span><br><span>         src/openvpn/base64.c</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/crypto_epoch=
.c</span><br><span>         src/openvpn/crypto_mbedtls.c</span><br><span>  =
       src/openvpn/crypto_openssl.c</span><br><span>         src/openvpn/cr=
ypto.c</span><br><span>@@ -835,9 +839,11 @@</span><br><span>         target=
_compile_options(test_networking PRIVATE -UNDEBUG)</span><br><span>        =
 target_sources(test_networking PRIVATE</span><br><span>             src/op=
envpn/networking_sitnl.c</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            src/openvpn/crypto_epoch.c</span><br><span>             sr=
c/openvpn/crypto_mbedtls.c</span><br><span>             src/openvpn/crypto_=
openssl.c</span><br><span>             src/openvpn/crypto.c</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/crypto_epoc=
h.c</span><br><span>             src/openvpn/otime.c</span><br><span>      =
       src/openvpn/packet_id.c</span><br><span>             )</span><br><sp=
an>@@ -853,6 +859,7 @@</span><br><span>             tests/unit_tests/openvp=
n/mock_win32_execve.c</span><br><span>             src/openvpn/argv.c</span=
><br><span>             src/openvpn/base64.c</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            src/openvpn/crypto_epoch.c</span><br><=
span>             src/openvpn/crypto_mbedtls.c</span><br><span>            =
 src/openvpn/crypto_openssl.c</span><br><span>             src/openvpn/cryp=
to.c</span><br><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto=
.c</span><br><span>index 996830c..f239282 100644</span><br><span>--- a/src/=
openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span=
>@@ -32,6 +32,8 @@</span><br><span> #include &lt;string.h&gt;</span><br><sp=
an> </span><br><span> #include &quot;crypto.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_epoch.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;packet_id.=
h&quot;</span><br><span> #include &quot;error.h&quot;</span><br><span> #inc=
lude &quot;integer.h&quot;</span><br><span> #include &quot;platform.h&quot;=
</span><br><span>@@ -68,7 +70,15 @@</span><br><span> {</span><br><span>    =
 struct gc_arena gc;</span><br><span>     int outlen =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const bool use_epoch_data_forma=
t =3D opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (use_epoch_data_format)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        epoch_check_send_iterate(opt);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     const struct key_ctx *ctx =3D &amp;o=
pt-&gt;key_ctx_bi.encrypt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     uint8_t *mac_out =3D NULL;</span><br><span>   =
  const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span> </span><b=
r><span>@@ -89,14 +99,24 @@</span><br><span>         buf_set_write(&amp;iv_=
buffer, iv, iv_len);</span><br><span> </span><br><span>         /* IV start=
s with packet id to make the IV unique for packet */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!packet_id_write(&amp;opt-&gt;p=
acket_id.send, &amp;iv_buffer, false, false))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (use_epoch_data_format)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(D_CRYPT_ERRORS, &quot;ENCRYPT ERROR: packet ID roll over&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto err;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!packet=
_id_write_epoch(&amp;opt-&gt;packet_id.send, ctx-&gt;epoch, &amp;iv_buffer)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_CR=
YPT_ERRORS, &quot;ENCRYPT ERROR: packet ID roll over&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (!packet_id_write(&amp;opt-&gt=
;packet_id.send, &amp;iv_buffer, false, false))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                msg(D_CRYPT_ERRORS, &quot;ENCRYPT ERR=
OR: packet ID roll over&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                goto err;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span>         /* Write packet id part of I=
V to work buffer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      ASSERT(buf_write(&amp;work, iv, packet_id_size(false)));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(buf_write(&amp;wo=
rk, iv, buf_len(&amp;iv_buffer)));</span><br><span> </span><br><span>      =
   /* Remainder of IV consists of implicit part (unique per session)</span>=
<br><span>          * XOR of packet and implicit IV */</span><br><span>@@ -=
128,7 +148,7 @@</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT A=
D: %s&quot;,</span><br><span>          format_hex(BPTR(&amp;work), BLEN(&am=
p;work), 0, &amp;gc));</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!(opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!use_epoch_=
data_format)</span><br><span>     {</span><br><span>         /* Reserve spa=
ce for authentication tag */</span><br><span>         mac_out =3D buf_write=
_alloc(&amp;work, mac_len);</span><br><span>@@ -149,7 +169,7 @@</span><br><=
span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><=
br><span>     /* if the tag is at end the end, allocate it now */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (opt-&gt;flags &amp; CO_=
EPOCH_DATA_KEY_FORMAT)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (use_epoch_data_format)</span><br><span>     {</span><br><span>  =
       /* Reserve space for authentication tag */</span><br><span>         =
mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><br><span>@@ -365,14=
 +385,35 @@</span><br><span> </span><br><span> bool</span><br><span> crypto=
_check_replay(struct crypto_options *opt,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    const struct packet_id_net *pin, co=
nst char *error_prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    const struct packet_id_net *pin, uint16_t epoch,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    co=
nst char *error_prefix,</span><br><span>                     struct gc_aren=
a *gc)</span><br><span> {</span><br><span>     bool ret =3D false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_reap_test(&amp;o=
pt-&gt;packet_id.rec);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (packet_id_test(&amp;opt-&gt;packet_id.rec, pin))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct packet_id_rec *recv;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (epoch =3D=3D 0 || opt-&gt;key_ctx_bi=
.decrypt.epoch =3D=3D epoch)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        packet_id_add(&amp;opt-&gt;packet_i=
d.rec, pin);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 recv =3D &amp;opt-&gt;packet_id.rec;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (epoch =3D=3D opt-&gt;epoch_retiring_data_receive_key.epoch=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        recv =3D &amp;opt-&gt;ep=
och_retiring_key_pid_recv;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* We have an epoch that=
 is neither current or old recv key but</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * is authenticated, ie we need to move to a ne=
w current recv key */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(D_GENKEY, &quot;Received data packet with new epoch %d. Updat=
ing &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;receive key&quot;, epoch);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        epoch_replace_update_recv_key(opt, epoch);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        recv =3D &amp;opt-&g=
t;packet_id.rec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    packet_id_reap_test(recv);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (packet_id_test(re=
cv, pin))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        packet_id_add(re=
cv, pin);</span><br><span>         if (opt-&gt;pid_persist &amp;&amp; (opt-=
&gt;flags &amp; CO_PACKET_ID_LONG_FORM))</span><br><span>         {</span><=
br><span>             packet_id_persist_save_obj(opt-&gt;pid_persist, &amp;=
opt-&gt;packet_id);</span><br><span>@@ -408,8 +449,9 @@</span><br><span>   =
  static const char error_prefix[] =3D &quot;AEAD Decrypt error&quot;;</spa=
n><br><span>     struct packet_id_net pin =3D { 0 };</span><br><span>     c=
onst struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.decrypt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int outlen;</span><br><span>   =
  struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const bool use_epoch_data_format =3D opt-&gt;flags &amp; CO_EPOCH_DAT=
A_KEY_FORMAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span> </span><br><=
span>     gc_init(&amp;gc);</span><br><span> </span><br><span>@@ -428,20 +4=
70,58 @@</span><br><span>     /* IV and Packet ID required for this mode */=
</span><br><span>     ASSERT(packet_id_initialized(&amp;opt-&gt;packet_id))=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Ensure that the packet size is long enough */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int min_packet_len =3D packet_id_size=
(false) + tag_size + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (use_epo=
ch_data_format)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        min_packet=
_len +=3D sizeof(uint32_t);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf-&gt;len &lt; =
min_packet_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CRYPT_ERRO=
R(&quot;missing IV info, missing tag or no payload&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint16_t epoch =3D 0;</span><br><span>     /* Combine IV from exp=
licit part from packet and implicit part from context */</span><br><span>  =
   {</span><br><span>         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };<=
/span><br><span>         const int iv_len =3D cipher_ctx_iv_length(ctx-&gt;=
cipher);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const=
 size_t packet_iv_len =3D packet_id_size(false);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf-&gt;len &lt; p=
acket_id_size(false))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Read packet id. For epoch data format also lookup the epoch ke=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * to be a=
ble to use the implicit IV of the correct decryption key */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (use_epoch_data_format)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            CRYPT_ERROR(&quot;missing IV info&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            /* packet ID format is 1=
6 bit epoch + 48 per epoch packet-counter */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            const size_t packet_iv_len =3D sizeof(=
uint64_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* copy the epoc=
h-counter part into the IV */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            memcpy(iv, BPTR(buf), packet_iv_len);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            epoch =3D packet_id_read_epoch(&amp;pin, b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(epoch =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       CRYPT_ERROR(&quot;error reading packet-id&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            ctx =3D epoch_lookup_decrypt_key=
(opt, epoch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (!ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      CRYPT_ERROR(&quot;data packet with unknown epoch&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            const size_t packet_iv_len =3D packet_id_size(false);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Pack=
et ID form is a 32 bit packet counter */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            memcpy(iv, BPTR(buf), packet_iv_len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!packet_=
id_read(&amp;pin, buf, false))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                CRYPT_ERROR(&quot;error reading packet-id&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        memcpy(iv, BPTR(buf), packet_iv_len);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* Remainder of IV consists of implicit part (uniqu=
e per session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* Remainder of IV consists of implicit part (unique per session/epoch k=
ey)</span><br><span>          * XOR of packet counter and implicit IV */</s=
pan><br><span>         for (int i =3D 0; i &lt; iv_len; i++)</span><br><spa=
n>         {</span><br><span>@@ -457,25 +537,12 @@</span><br><span>        =
 }</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* Read packet ID from packet */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (!packet_id_read(&amp;pin, buf,=
 false))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;err=
or reading packet-id&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* keep the tag value to f=
eed in later */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt; tag_size + 1)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;missing tag or no payloa=
d&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     const =
int ad_size =3D BPTR(buf) - ad_start;</span><br><span> </span><br><span>   =
  uint8_t *tag_ptr =3D NULL;</span><br><span>     int data_len =3D 0;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o=
pt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (use_epoch_data_format)</span><br><span>   =
  {</span><br><span>         data_len =3D BLEN(buf) - tag_size;</span><br><=
span>         tag_ptr =3D BPTR(buf) + data_len;</span><br><span>@@ -496,13 =
+563,13 @@</span><br><span>         CRYPT_ERROR(&quot;potential buffer over=
flow&quot;);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* feed in tag and th=
e authenticated data */</span><br><span>     ASSERT(cipher_ctx_update_ad(ct=
x-&gt;cipher, ad_start, ad_size));</span><br><span>     dmsg(D_PACKET_CONTE=
NT, &quot;DECRYPT AD: %s&quot;,</span><br><span>          format_hex(ad_sta=
rt, ad_size, 0, &amp;gc));</span><br><span> </span><br><span>     /* Decryp=
t and authenticate packet */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int outlen;</span><br><span>     if (!cipher_ctx_update(ctx-&g=
t;cipher, BPTR(&amp;work), &amp;outlen, BPTR(buf),</span><br><span>        =
                    data_len))</span><br><span>     {</span><br><span>@@ -5=
25,7 +592,7 @@</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT TO=
: %s&quot;,</span><br><span>          format_hex(BPTR(&amp;work), BLEN(&amp=
;work), 80, &amp;gc));</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!crypto_check_replay(opt, &amp;pin, error_prefix=
, &amp;gc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!crypto_check_replay(opt, &amp;pin, epoch, error_prefix, &amp;gc))</span><b=
r><span>     {</span><br><span>         goto error_exit;</span><br><span>  =
   }</span><br><span>@@ -696,7 +763,7 @@</span><br><span>             }</sp=
an><br><span>         }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (have_pin &amp;&amp; !crypto_check_replay(op=
t, &amp;pin, error_prefix, &amp;gc))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (have_pin &amp;&amp; !crypto_check_replay(opt, =
&amp;pin, 0, error_prefix, &amp;gc))</span><br><span>         {</span><br><=
span>             goto error_exit;</span><br><span>         }</span><br><sp=
an>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span=
>index 933bc2f..369d19f 100644</span><br><span>--- a/src/openvpn/crypto.h</=
span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -518,6 +518,7 =
@@</span><br><span>  */</span><br><span> bool crypto_check_replay(struct cr=
ypto_options *opt,</span><br><span>                          const struct p=
acket_id_net *pin,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                        uint16_t epoch,</span><br><span>                   =
       const char *error_prefix,</span><br><span>                          =
struct gc_arena *gc);</span><br><span> </span><br><span>diff --git a/src/op=
envpn/crypto_backend.h b/src/openvpn/crypto_backend.h</span><br><span>index=
 c454c64..de74def 100644</span><br><span>--- a/src/openvpn/crypto_backend.h=
</span><br><span>+++ b/src/openvpn/crypto_backend.h</span><br><span>@@ -38,=
7 +38,7 @@</span><br><span> #include &quot;basic.h&quot;</span><br><span> #=
include &quot;buffer.h&quot;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/* TLS uses a tag of 128 bytes, let&#39;s do the s=
ame for OpenVPN */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* TLS uses a tag of 128 bits, let&#39;s do the same for OpenVPN */</span><b=
r><span> #define OPENVPN_AEAD_TAG_LENGTH 16</span><br><span> </span><br><sp=
an> /* Maximum cipher block size (bytes) */</span><br><span>diff --git a/sr=
c/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index 035474f..c3e05a8 =
100644</span><br><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/op=
envpn/dco.h</span><br><span>@@ -249,6 +249,15 @@</span><br><span>  */</span=
><br><span> const char *dco_get_supported_ciphers(void);</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Return whether the dco implementa=
tion supports the new protocol features of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * a 64 bit packet counter and AEAD tag at the end.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(struct contex=
t *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else /* if def=
ined(ENABLE_DCO) */</span><br><span> </span><br><span> typedef void *dco_co=
ntext_t;</span><br><span>@@ -380,5 +389,10 @@</span><br><span>     return &=
quot;&quot;;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dco_supports_epoch_data(struct context *c)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #endif /* defined(ENAB=
LE_DCO) */</span><br><span> #endif /* ifndef DCO_H */</span><br><span>diff =
--git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 2c831=
fe..387d895 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span=
>+++ b/src/openvpn/init.c</span><br><span>@@ -2761,6 +2761,19 @@</span><br>=
<span>         }</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Ensure that for epoch data for=
mat is only enabled if also data v2</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * is enabled */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool epoch_data =3D (c-&gt;options.imported_protocol_f=
lags &amp; CO_EPOCH_DATA_KEY_FORMAT);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool datav2_enabled =3D (c-&gt;options.peer_id &gt;=
=3D 0 &amp;&amp; c-&gt;options.peer_id &lt; MAX_PEER_ID);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (epoch_data &amp;&amp; !datav2_enabled)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;OPTIONS =
ERROR: Epoch key data format tag requires &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;data v2 (peer-id) to be enab=
led.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (found &amp; =
OPT_P_PUSH_MTU)</span><br><span>     {</span><br><span>         /* MTU has =
changed, check that the pushed MTU is small enough to</span><br><span>@@ -3=
357,6 +3370,15 @@</span><br><span>         to.push_peer_info_detail =3D 1;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Check if the DCO drivers support the epoch data=
 format */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (d=
co_enabled(options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        to.da=
ta_epoch_supported =3D dco_supports_epoch_data(c);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
to.data_epoch_supported =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span> </span><br><span>     /* should we not=
 xmit any packets until we get an initial</span><br><span>      * response =
from client? */</span><br><span>diff --git a/src/openvpn/multi.c b/src/open=
vpn/multi.c</span><br><span>index 45b3cfa..8a6887a 100644</span><br><span>-=
-- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><b=
r><span>@@ -1849,6 +1849,12 @@</span><br><span>     }</span><br><span> #end=
if</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (tls_multi-&gt;session[TM_ACTIVE].opt-&gt;data_epoch_supported</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (prot=
o &amp; IV_PROTO_DATA_EPOCH))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    o-&gt;imported_protocol_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     if (proto &amp; IV_PRO=
TO_CC_EXIT_NOTIFY)</span><br><span>     {</span><br><span>         o-&gt;im=
ported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><span>diff --gi=
t a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 9eaf3ac..d2=
d862f 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/=
src/openvpn/ssl.c</span><br><span>@@ -54,6 +54,7 @@</span><br><span> #inclu=
de &quot;route.h&quot;</span><br><span> #include &quot;tls_crypt.h&quot;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;crypto_epoch.h&quot;</span><br><span> #include &quot;ssl.h&quot;=
</span><br><span> #include &quot;ssl_verify.h&quot;</span><br><span> #inclu=
de &quot;ssl_backend.h&quot;</span><br><span>@@ -912,6 +913,7 @@</span><br>=
<span>     key_state_ssl_free(&amp;ks-&gt;ks_ssl);</span><br><span> </span>=
<br><span>     free_key_ctx_bi(&amp;ks-&gt;crypto_options.key_ctx_bi);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_epoch_key_ctx(&=
amp;ks-&gt;crypto_options);</span><br><span>     free_buf(&amp;ks-&gt;plain=
text_read_buf);</span><br><span>     free_buf(&amp;ks-&gt;plaintext_write_b=
uf);</span><br><span>     free_buf(&amp;ks-&gt;ack_write_buf);</span><br><s=
pan>@@ -1359,6 +1361,48 @@</span><br><span> }</span><br><span> </span><br><=
span> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
it_epoch_keys(struct key_state *ks,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                struct tls_multi *multi,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                const struct key_type =
*key_type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       bool server,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                struct key2 *key2)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* For now we hardcode this to be 16 for the software based data channel</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * DCO based impl=
ementations/HW implementation might adjust this number</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * based on their expected speed */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int future=
_key_count =3D 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int key_directio=
n =3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct key_direction_state kds=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key_direction_=
state_init(&amp;kds, key_direction);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct crypto_options *co =3D &amp;ks-&gt;crypto_options;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* For the epoch key we use the first 32 bytes of =
key2 cipher keys</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * for the  initial secret */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct epoch_key e1_send =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    e1_send.epoch =3D 1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    memcpy(&amp;e1_send.epoch_key, key2=
-&gt;keys[kds.out_key].cipher, sizeof(e1_send.epoch_key));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct epoch_key e1_recv =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    e1_recv.epoch =3D 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(&amp;e1_recv.epoch_=
key, key2-&gt;keys[kds.in_key].cipher, sizeof(e1_recv.epoch_key));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* DCO implementations have two choices at =
this point.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * a) (more likel=
y) they probably to pass E1 directly to kernel</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * space at this point and do all the other =
key derivation in kernel</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * b=
) They let userspace do the key derivation and pass all the individual</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * keys to the DCO l=
ayer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_init_key_ctx(c=
o, key_type, &amp;e1_send, &amp;e1_recv,  future_key_count);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    secure_memzero(&amp;e1_send, sizeof(e1_send));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&am=
p;e1_recv, sizeof(e1_recv));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span>=
 init_key_contexts(struct key_state *ks,</span><br><span>                  =
 struct tls_multi *multi,</span><br><span>                   const struct k=
ey_type *key_type,</span><br><span>@@ -1391,6 +1435,16 @@</span><br><span> =
        CLEAR(key-&gt;decrypt);</span><br><span>         key-&gt;initialize=
d =3D true;</span><br><span>     }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else if (multi-&gt;opt.crypto_flags &amp; CO_EPOCH_DATA_=
KEY_FORMAT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!cipher_kt=
_mode_aead(key_type-&gt;cipher))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_FATAL, &quot;AEAD cipher (currently %s) &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;requi=
red for epoch data format.&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                cipher_kt_name(key_type-&gt;cipher));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        init_epoch_keys(ks, multi, ke=
y_type, server, key2);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span>     else</span><br><span>     {</span><br><span> =
        init_key_ctx_bi(key, key2, key_direction, key_type, &quot;Data Chan=
nel&quot;);</span><br><span>@@ -1966,6 +2020,11 @@</span><br><span>        =
     iv_proto |=3D IV_PROTO_NCP_P2P;</span><br><span>         }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (s=
ession-&gt;opt-&gt;data_epoch_supported)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            iv_proto |=3D IV_PROTO_DATA_EPOCH;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>         buf_printf(&amp;out, =
&quot;IV_CIPHERS=3D%s\n&quot;, session-&gt;opt-&gt;config_ncp_ciphers);</sp=
an><br><span> </span><br><span> #ifdef HAVE_EXPORT_KEYING_MATERIAL</span><b=
r><span>@@ -2975,13 +3034,29 @@</span><br><span>         return true;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (ks-&gt;crypto_options.flags &amp; CO_EPOCH_DATA_KEY=
_FORMAT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* We only need t=
o check the send key as we always keep send</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * key epoch &gt;=3D recv key epoch in \c e=
poch_replace_update_recv_key */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (ks-&gt;crypto_options.epoch_key_send.epoch &gt;=3D =
0xF000)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     /* Packet id approach the limit of the packet id */</span><=
br><span>     if (packet_id_close_to_wrapping(&amp;ks-&gt;crypto_options.pa=
cket_id.send))</span><br><span>     {</span><br><span>         return true;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* Check the AEAD usage limit of cleartext blocks +=
 packets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* C=
heck the AEAD usage limit of cleartext blocks + packets.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * When epoch are in use the crypt=
o layer will handle this internally */</span><br><span>     const struct ke=
y_ctx_bi *key_ctx_bi =3D &amp;ks-&gt;crypto_options.key_ctx_bi;</span><br><=
span>     const int64_t usage_limit =3D session-&gt;opt-&gt;aead_usage_limi=
t;</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_common.h =
b/src/openvpn/ssl_common.h</span><br><span>index 511127d..6a4b39d 100644</s=
pan><br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/open=
vpn/ssl_common.h</span><br><span>@@ -314,7 +314,6 @@</span><br><span> </spa=
n><br><span>     /* from command line */</span><br><span>     bool single_s=
ession;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool disab=
le_occ;</span><br><span>     int mode;</span><br><span>     bool pull;</spa=
n><br><span>     /**</span><br><span>@@ -367,6 +366,12 @@</span><br><span> =
    const char *config_ciphername;</span><br><span>     const char *config_=
ncp_ciphers;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /** whether our underlying data channel supports new data ch=
annel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * feature=
s (epoch keys with AEAD tag at the end). This is always true</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * for the internal implementa=
tion but can be false for DCO</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * implementations */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool data_epoch_supported;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     bool tls_crypt_v2;</span><=
br><span>     const char *tls_crypt_v2_verify_script;</span><br><span> </sp=
an><br><span>@@ -496,8 +501,6 @@</span><br><span>      */</span><br><span> =
    int key_id;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int limit_next;             /* used for traffic shaping on =
the control channel */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>     int verify_maxlevel;</span><br><span> </span><br><sp=
an>     char *common_name;</span><br><span>diff --git a/src/openvpn/ssl_ncp=
.c b/src/openvpn/ssl_ncp.c</span><br><span>index 968858e..00be96d 100644</s=
pan><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn=
/ssl_ncp.c</span><br><span>@@ -430,6 +430,11 @@</span><br><span>         se=
ssion-&gt;opt-&gt;crypto_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (session-&gt;opt-&gt;data_epoch_supported &amp;&amp; (iv_proto_=
peer &amp; IV_PROTO_DATA_EPOCH))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       session-&gt;opt-&gt;crypto_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(HAVE_EXP=
ORT_KEYING_MATERIAL)</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_=
TLS_KEY_EXPORT)</span><br><span>     {</span><br><span>@@ -499,9 +504,12 @@=
</span><br><span>     }</span><br><span> </span><br><span>     msg(D_TLS_DE=
BUG_LOW, &quot;P2P mode NCP negotiation result: &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        &quot;TLS_export=3D%d, DATA_v2=3D%=
d, peer-id %d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &quot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoc=
h=3D%d, cipher=3D%s&quot;,</span><br><span>         (bool)(session-&gt;opt-=
&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;use_peer_id, multi-&gt;=
peer_id, common_cipher);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi-&gt;use_peer_id,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        multi-&gt;peer_id,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto_flags &amp=
; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        common_cipher);</span><br><span> </span><br><span>     gc_=
free(&amp;gc);</span><br><span> }</span><br><span>diff --git a/src/openvpn/=
tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>index 76f06bc..7c5eb0=
1 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ =
b/src/openvpn/tls_crypt.c</span><br><span>@@ -301,7 +301,7 @@</span><br><sp=
an>         struct buffer tmp =3D *src;</span><br><span>         ASSERT(buf=
_advance(&amp;tmp, TLS_CRYPT_OFF_PID));</span><br><span>         ASSERT(pac=
ket_id_read(&amp;pin, &amp;tmp, true));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (!crypto_check_replay(opt, &amp;pin, error_pre=
fix, &amp;gc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!crypto_check_replay(opt, &amp;pin, 0, error_prefix, &amp;gc))</span=
><br><span>         {</span><br><span>             CRYPT_ERROR(&quot;packet=
 replay&quot;);</span><br><span>         }</span><br><span>diff --git a/tes=
ts/Makefile.am b/tests/Makefile.am</span><br><span>index f26b3b8..3246e34 1=
00644</span><br><span>--- a/tests/Makefile.am</span><br><span>+++ b/tests/M=
akefile.am</span><br><span>@@ -52,6 +52,7 @@</span><br><span> 	unit_tests/o=
penvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/c=
rypto.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_src=
dir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src/openv=
pn/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mb=
edtls.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><=
span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/o=
penvpn/Makefile.am</span><br><span>index 307f9ed..471389b 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/test=
s/unit_tests/openvpn/Makefile.am</span><br><span>@@ -86,6 +86,7 @@</span><b=
r><span> 	$(top_srcdir)/src/compat/compat-strsep.c \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvp=
n/cryptoapi.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src=
/openvpn/crypto_mbedtls.c \</span><br><span> 	$(top_srcdir)/src/openvpn/cry=
pto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/env_set.c \</sp=
an><br><span>@@ -132,6 +133,7 @@</span><br><span> 	$(top_srcdir)/src/openvp=
n/base64.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><=
br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_epoch.c \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span=
> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span> 	$(top_src=
dir)/src/openvpn/env_set.c \</span><br><span>@@ -160,6 +162,7 @@</span><br>=
<span> 	$(top_srcdir)/src/openvpn/base64.c \</span><br><span> 	$(top_srcdir=
)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/=
src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src/openvpn/cr=
ypto_mbedtls.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl=
.c \</span><br><span> 	$(top_srcdir)/src/openvpn/env_set.c \</span><br><spa=
n>@@ -179,6 +182,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/networkin=
g_sitnl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_epoch.c \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/otime.c \</span><br><span>@@ -250,6 +254,7 @@</span><br><sp=
an> auth_token_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/crypto.c \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/ot=
ime.c \</span><br><span>@@ -285,6 +290,7 @@</span><br><span> ncp_testdriver=
_SOURCES =3D test_ncp.c mock_msg.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbe=
dtls.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ss=
l.c</span><br><span>index 845ca56..93b3094 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_ssl.c</span><br><span>@@ -35,6 +35,7 @@</span><br><span> #include=
 &lt;cmocka.h&gt;</span><br><span> </span><br><span> #include &quot;crypto.=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;crypto_epoch.h&quot;</span><br><span> #include &quot;options.h&quot;</sp=
an><br><span> #include &quot;ssl_backend.h&quot;</span><br><span> #include =
&quot;options_util.h&quot;</span><br><span>@@ -370,22 +371,46 @@</span><br>=
<span> </span><br><span> </span><br><span> struct crypto_options</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-init_crypto_options(const char *=
cipher, const char *auth)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+init_crypto_options(const char *cipher, const char *auth, bool epoch,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 struct key2 *statickey)</span><br><span> {</span><br><span>     struct key=
2 key2 =3D { .n =3D 2};</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.=
keys[0].cipher)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(rand_bytes(key2.key=
s[1].cipher, sizeof(key2.keys[1].cipher)));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2.=
keys)[1].hmac));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (statickey)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Use cho=
sen static key instead of random key when defined */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        key2 =3D *statickey;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].ciph=
er)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSER=
T(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(rand_bytes(key2.key=
s[1].cipher, sizeof(key2.keys[1].cipher)));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ASSERT(rand_bytes(key2.keys[1].hmac, sizeof=
(key2.keys)[1].hmac));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span> </span><br><span>     struct crypto_options co =
=3D { 0 };</span><br><span> </span><br><span>     struct key_type kt =3D cr=
eate_kt(cipher, auth, &quot;ssl-test&quot;);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    init_key_ctx_bi(&amp;co.key_ct=
x_bi, &amp;key2, 0, &amp;kt, &quot;unit-test-ssl&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    packet_id_init(&amp;co.packet_id,  5=
, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (epoch)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct epoch_key e1 =3D { .epoch =3D 1, .epoch_key =3D { 0 }};</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        memcpy(e1.epoch_key, key=
2.keys[0].cipher, sizeof(e1.epoch_key));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        epoch_init_key_ctx=
(&amp;co, &amp;kt, &amp;e1, &amp;e1, 5);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* Do a little of dancing fo=
r the epoch_send_key_iterate to test</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * that this works too */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        epoch_iterate_send_key(&amp;co);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        epoch_iterate_s=
end_key(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      epoch_iterate_send_key(&amp;co);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        init_key_ctx=
_bi(&amp;co.key_ctx_bi, &amp;key2, KEY_DIRECTION_BIDIRECTIONAL, &amp;kt, &q=
uot;unit-test-ssl&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pack=
et_id_init(&amp;co.packet_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><sp=
an>     return co;</span><br><span> }</span><br><span> </span><br><span>@@ =
-394,17 +419,16 @@</span><br><span> {</span><br><span>     packet_id_free(&=
amp;co-&gt;packet_id);</span><br><span>     free_key_ctx_bi(&amp;co-&gt;key=
_ctx_bi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    free_epoch_key_ctx(co);</sp=
an><br><span> }</span><br><span> </span><br><span> /* This adds a few more =
methods than strictly necessary but this allows</span><br><span>  * us to s=
ee which exact test was run from the backtrace of the test</span><br><span>=
  * when it fails */</span><br><span> static void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-run_data_channel_with_cipher_end(const char *ci=
pher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+run_data_chann=
el_with_cipher_epoch(const char *cipher)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct crypto_options co =3D init=
_crypto_options(cipher, &quot;none&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto_options co =
=3D init_crypto_options(cipher, &quot;none&quot;, true, NULL);</span><br><s=
pan>     do_data_channel_round_trip(&amp;co);</span><br><span>     uninit_c=
rypto_options(&amp;co);</span><br><span> }</span><br><span>@@ -412,7 +436,7=
 @@</span><br><span> static void</span><br><span> run_data_channel_with_cip=
her(const char *cipher, const char *auth)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct crypto_options co =3D ini=
t_crypto_options(cipher, auth);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct crypto_options co =3D init_crypto_options(cipher, au=
th, false, NULL);</span><br><span>     do_data_channel_round_trip(&amp;co);=
</span><br><span>     uninit_crypto_options(&amp;co);</span><br><span> }</s=
pan><br><span>@@ -421,21 +445,21 @@</span><br><span> static void</span><br>=
<span> test_data_channel_roundtrip_aes_128_gcm(void **state)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    run_data_chan=
nel_with_cipher_end(&quot;AES-128-GCM&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    run_data_channel_with_cipher_epoch(&quot;AES-=
128-GCM&quot;);</span><br><span>     run_data_channel_with_cipher(&quot;AES=
-128-GCM&quot;, &quot;none&quot;);</span><br><span> }</span><br><span> </sp=
an><br><span> static void</span><br><span> test_data_channel_roundtrip_aes_=
192_gcm(void **state)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    run_data_channel_with_cipher_end(&quot;AES-192-GCM&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_=
channel_with_cipher_epoch(&quot;AES-192-GCM&quot;);</span><br><span>     ru=
n_data_channel_with_cipher(&quot;AES-192-GCM&quot;, &quot;none&quot;);</spa=
n><br><span> }</span><br><span> </span><br><span> static void</span><br><sp=
an> test_data_channel_roundtrip_aes_256_gcm(void **state)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    run_data_channel=
_with_cipher_end(&quot;AES-256-GCM&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    run_data_channel_with_cipher_epoch(&quot;AES-256=
-GCM&quot;);</span><br><span>     run_data_channel_with_cipher(&quot;AES-25=
6-GCM&quot;, &quot;none&quot;);</span><br><span> }</span><br><span> </span>=
<br><span>@@ -466,7 +490,7 @@</span><br><span>         return;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    run_data_channel_with_cipher_end(&quot;ChaCha20-Poly1305&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channe=
l_with_cipher_epoch(&quot;ChaCha20-Poly1305&quot;);</span><br><span>     ru=
n_data_channel_with_cipher(&quot;ChaCha20-Poly1305&quot;, &quot;none&quot;)=
;</span><br><span> }</span><br><span> </span><br><span>@@ -482,6 +506,153 @=
@</span><br><span> }</span><br><span> </span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static struct key2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+create_key(void)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct key2 key2 =3D {.n =3D 2};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const uint8_t key[] =3D</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {&#39;a&#39;, &#39;b&#39;, &#39;c&#39;, &#39;d&#=
39;, &#39;e&#39;, &#39;f&#39;, &#39;g&#39;, &#39;h&#39;, &#39;0&#39;, &#39;=
1&#39;, &#39;2&#39;, &#39;3&#39;, &#39;4&#39;, &#39;5&#39;, &#39;6&#39;, &#=
39;7&#39;, &#39;A&#39;, &#39;B&#39;, &#39;C&#39;, &#39;D&#39;, &#39;E&#39;,=
 &#39;F&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     &=
#39;G&#39;, &#39;H&#39;, &#39;j&#39;, &#39;k&#39;, &#39;u&#39;, &#39;c&#39;=
, &#39;h&#39;, &#39;e&#39;, &#39;n&#39;, &#39;l&#39;};</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    static_assert(sizeof(key) =3D=3D 32, &quot;Size of key =
should be 32 bytes&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* copy =
the key a few times to ensure to have the size we need for</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * Statickey but XOR it to not r=
epeat it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
8_t keydata[sizeof(key2.keys)];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (int i =3D 0; i &lt; sizeof(key2.keys); i++)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        keydata[i] =3D (uint8_t) (key[i % sizeof(key)] ^ i);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(memcpy(key2.keys[0].cipher, keydata, sizeof(=
key2.keys[0].cipher)));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(memcpy(key2.keys[0].hmac, keydata + 64, sizeof(key2.keys[0].=
hmac)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
memcpy(key2.keys[1].cipher, keydata + 128, sizeof(key2.keys[1].cipher)));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(memcpy(key=
2.keys[1].hmac, keydata + 192, sizeof(key2.keys)[1].hmac));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return key2;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_data_channel_known_vec=
tors_run(bool epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key2 k=
ey2 =3D create_key();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto=
_options co =3D init_crypto_options(&quot;AES-256-GCM&quot;, &quot;none&quo=
t;, epoch,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                          &amp;key2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* initialise frame for the test */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct frame frame;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    init_frame_parameters(&amp;frame=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer src =3D alloc_buf_=
gc(frame.buf.payload_size, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;fram=
e), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D =
clear_buf();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    voi=
d *buf_p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* init work */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;work=
, frame.buf.headroom));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * Load src with known data.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;src, 0));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *plaintext =3D &quot;=
The quick little fox jumps over the bureaucratic hurdles&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(buf_write(&amp;src, plaintext, strlen(p=
laintext)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* copy source to inpu=
t buf */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D=
 work;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_p =3D=
 buf_write_alloc(&amp;buf, BLEN(&amp;src));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(buf_p);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    memcpy(buf_p, BPTR(&amp;src), BLEN(&amp;src));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* initialize work buffer with buf.h=
eadroom bytes of prepend capacity */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(buf_init(&amp;encrypt_workspace, frame.buf.head=
room));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* add packet opcode and pe=
er id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_wri=
te_u8(&amp;encrypt_workspace, 7);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    buf_write_u8(&amp;encrypt_workspace, 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(&amp;encrypt_worksp=
ace, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_wri=
te_u8(&amp;encrypt_workspace, 23);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* encrypt */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    op=
envpn_encrypt(&amp;buf, encrypt_workspace, &amp;co);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* separate buffer in authenticated data and encrypted d=
ata */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *=
ad_start =3D BPTR(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_advance(&amp;buf, 4);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t pac=
ketid1[8] =3D {0, 0x04, 0, 0, 0, 0, 0, 1};</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        assert_memory_equal(BPTR(&amp;buf), packetid=
1, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uint8_t packetid1[4] =3D {0, 0, 0, 1};</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equ=
al(BPTR(&amp;buf), packetid1, 4);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (epoch)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uint8_t *tag_location =3D BEND=
(&amp;buf) - OPENVPN_AEAD_TAG_LENGTH;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const uint8_t exp_tag_long[16] =3D</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {0x86, 0x20, 0xfe, 0xc6, 0=
x65, 0xa6, 0xab, 0x2a,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         0x34, 0xa6, 0xb8, 0xd4, 0xb4, 0xa9, 0x00, 0x9e};</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equal(tag_lo=
cation, exp_tag_long, OPENVPN_AEAD_TAG_LENGTH);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uin=
t8_t *tag_location =3D BPTR(&amp;buf) + 4;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const uint8_t exp_tag_short[16] =3D</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {0x1f, 0xdd, 0x90, 0=
x8f, 0x0e, 0x9d, 0xc2, 0x5e, 0x79, 0xd8, 0x32, 0x02, 0x0d, 0x58, 0xe7, 0x3f=
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_me=
mory_equal(tag_location, exp_tag_short, OPENVPN_AEAD_TAG_LENGTH);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Check some bytes at the beginning of the encrypted pa=
rt */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (epoch)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        const uint8_t bytesat14[6=
] =3D {0x62, 0xa9, 0xe3, 0x7a, 0xa7, 0xf0};</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        assert_memory_equal(BPTR(&amp;buf) + 14, by=
tesat14, sizeof(bytesat14));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const uint8_t bytesat3=
0[6] =3D {0xa8, 0x2e, 0x6b, 0x17, 0x06, 0xd9};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        assert_memory_equal(BPTR(&amp;buf) + 30,=
 bytesat30, sizeof(bytesat30));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* decrypt */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_decrypt(&am=
p;buf, decrypt_workspace, &amp;co, &amp;frame, ad_start);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* compare */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(buf.len, strlen(plaintext));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR=
(&amp;buf), plaintext, strlen(plaintext));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uninit_crypto_options(&amp;co);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test_data_channel_known=
_vectors_epoch(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_=
data_channel_known_vectors_run(true);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_data_channel_known_vec=
tors_shortpktid(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test=
_data_channel_known_vectors_run(false);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 int</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -499=
,6 +670,8 @@</span><br><span>         cmocka_unit_test(test_data_channel_ro=
undtrip_aes_192_cbc),</span><br><span>         cmocka_unit_test(test_data_c=
hannel_roundtrip_aes_256_cbc),</span><br><span>         cmocka_unit_test(te=
st_data_channel_roundtrip_bf_cbc),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_data_channel_known_vectors_epo=
ch),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_data_channel_known_vectors_shortpktid)</span><br><span>     =
};</span><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/806?usp=3Demail">change 806</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/806?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00751c42cb04e30205ba8e65845=
30831e0d143c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 806 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--/k/p7inG4Sc=--

