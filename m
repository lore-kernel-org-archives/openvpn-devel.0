From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 15 Nov 2024 15:12:22 +0000
In-Reply-To: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
References: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a47ce7790950cb405de51416b5e715811988286d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kHM2chMGwOM="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement methods to
 generate and manage OpenVPN Epoch keys
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

--kHM2chMGwOM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail

to look at the new patch set (#4).


Change subject: Implement methods to generate and manage OpenVPN Epoch keys
......................................................................

Implement methods to generate and manage OpenVPN Epoch keys

This implements functions that allow these keys to be generated and
managed. It does not yet implement using them for the data channel.

Change-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/crypto_epoch.c
M src/openvpn/crypto_epoch.h
M src/openvpn/packet_id.c
M src/openvpn/packet_id.h
M src/openvpn/ssl_common.h
M tests/unit_tests/openvpn/test_crypto.c
8 files changed, 774 insertions(+), 20 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/804/4

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 769a274..a055b20 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -908,14 +908,27 @@
     if (cipher_ctx_mode_aead(ctx->cipher))
     {
         size_t impl_iv_len =3D 0;
+        size_t impl_iv_offset =3D 0;
         ASSERT(cipher_ctx_iv_length(ctx->cipher) >=3D OPENVPN_AEAD_MIN_IV_=
LEN);
-        impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_=
id_type);
+
+        /* Epoch keys use XOR of full IV length with the packet id to gene=
rate
+         * IVs. Old data format uses concatenation instead (XOR with 0 for=
 the
+         * first 4 bytes (sizeof(packet_id_type) */
+        if (key->epoch)
+        {
+            impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher);
+            impl_iv_offset =3D 0;
+        }
+        else
+        {
+            impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(pac=
ket_id_type);
+            impl_iv_offset =3D sizeof(packet_id_type);
+        }
         ASSERT(impl_iv_len <=3D OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <=3D MAX_HMAC_KEY_LENGTH);
         ASSERT(key->hmac_size >=3D impl_iv_len);
         CLEAR(ctx->implicit_iv);
-        /* The first bytes of the IV are filled with the packet id */
-        memcpy(ctx->implicit_iv + sizeof(packet_id_type), key->hmac, impl_=
iv_len);
+        memcpy(ctx->implicit_iv + impl_iv_offset, key->hmac, impl_iv_len);
     }
 }

@@ -964,6 +977,7 @@
              hmac_ctx_size(ctx->hmac));

     }
+    ctx->epoch =3D key->epoch;
     gc_free(&gc);
 }
=20
@@ -976,6 +990,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
+    ctx->epoch =3D key_params->epoch;
 }

 void
@@ -987,6 +1002,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
+    ctx->epoch =3D key_params->epoch;
 }

 void
@@ -1024,6 +1040,7 @@
     }
     CLEAR(ctx->implicit_iv);
     ctx->plaintext_blocks =3D 0;
+    ctx->epoch =3D 0;
 }

 void
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 640e321..617246b 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -170,6 +170,9 @@

     /** Number of bytes set in the HMac key material */
     int hmac_size;
+
+    /** the epoch of the key is if it was generated as epoch data key mate=
rial */
+    uint16_t epoch;
 };

 /**
@@ -180,6 +183,11 @@
 void
 key_parameters_from_key(struct key_parameters *key_params, const struct ke=
y *key);

+struct epoch_key {
+    uint8_t epoch_key[SHA256_DIGEST_LENGTH];
+    uint16_t epoch;
+};
+
 /**
  * Container for one set of cipher and/or HMAC contexts.
  * @ingroup control_processor
@@ -203,6 +211,10 @@
     /** Counter for the number of plaintext encrypted using this cipher
      * in number of 128 bit blocks (only used for AEAD ciphers) */
     uint64_t plaintext_blocks;
+    /** OpenVPN data channel epoch, this variable holds the
+     *  epoch number that is key belongs to. Note that epoch 0 is not used
+     *  and epoch is always non-zero for epoch key contexts */
+    uint16_t epoch;
 };

 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -272,6 +284,39 @@
     /**< OpenSSL cipher and HMAC contexts for
      *   both sending and receiving
      *   directions. */
+
+    /** last epoch_key used for generation of the current send data keys.
+     * As invariant, the epoch of epoch_key_send is always kept >=3D the e=
poch of
+     * epoch_key_recv */
+    struct epoch_key epoch_key_send;
+
+    /** epoch_key used for the highest receive epoch keys */
+    struct epoch_key epoch_key_recv;
+
+    /** the key_type that is used to generate the epoch keys */
+    struct key_type epoch_key_type;
+
+    /** This limit for AEAD cipher, this is the sum of packets + blocks
+     * that are allowed to be used. Will switch to a new epoch if this
+     * limit is reached*/
+    uint64_t aead_usage_limit;
+
+    /** Keeps the future epoch data keys for decryption. The current one
+     * that is expected to be used is stored in key_ctx_bi.
+     *
+     * We keep both decrypt and encrypt key here in the future keys
+     * as we want to be able to switch also sending key if the peer
+     * switching to a newer key epoch
+     * */
+    struct key_ctx *epoch_data_keys_future;
+
+    /** number of keys stored in \c epoch_data_keys_future */
+    uint16_t epoch_data_keys_future_count;
+
+    /** The old key bevor the sender switch to a new epoch data key */
+    struct key_ctx epoch_retiring_data_receive_key;
+    struct packet_id_rec epoch_retiring_key_pid_recv;
+
     struct packet_id packet_id; /**< Current packet ID state for both
                                  *   sending and receiving directions.
                                  *
@@ -280,7 +325,7 @@
                                  *
                                  *   The packet id also used as the IV
                                  *   for AEAD/OFB/CFG ciphers.
-                                 *   */
+                                 */
     struct packet_id_persist *pid_persist;
     /**< Persistent packet ID state for
      *   keeping state between successive
@@ -468,13 +513,15 @@
  *
  * @param opt   Crypto options for this packet, contains replay state.
  * @param pin   Packet ID read from packet.
+ * @param epoch Epoch read from packet or 0 when epoch is not used.
  * @param error_prefix  Prefix to use when printing error messages.
  * @param gc    Garbage collector to use.
  *
  * @return true if packet ID is validated to be not a replay, false otherw=
ise.
  */
 bool crypto_check_replay(struct crypto_options *opt,
-                         const struct packet_id_net *pin, const char *erro=
r_prefix,
+                         const struct packet_id_net *pin,
+                         const char *error_prefix,
                          struct gc_arena *gc);


diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index f9111f1..1f89804 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -29,7 +29,13 @@
 #endif

 #include <inttypes.h>
+#include <string.h>
+#include <stdlib.h>
+
 #include "crypto_backend.h"
+#include "packet_id.h"
+#include "crypto.h"
+#include "crypto_epoch.h"
 #include "buffer.h"
 #include "integer.h"

@@ -104,3 +110,332 @@
     gc_free(&gc);
     return true;
 }
+
+/**
+ * Iterates the epoch key to make it E_n+1, ie increase the epoch by one
+ * and derive the new key material accordingly
+ * @param epoch_key epoch key to iterate
+ */
+static void
+epoch_key_iterate(struct epoch_key *epoch_key)
+{
+    struct epoch_key new_epoch_key =3D { 0 };
+    new_epoch_key.epoch =3D epoch_key->epoch + 1;
+    const uint8_t epoch_update_label[] =3D "datakey upd";
+
+    /* E_N+1 =3D OVPN-Expand-Label(E_N, "datakey upd", "", 32) */
+    ovpn_expand_label(epoch_key->epoch_key, sizeof(epoch_key->epoch_key),
+                      epoch_update_label, 11,
+                      NULL, 0,
+                      new_epoch_key.epoch_key, sizeof(new_epoch_key.epoch_=
key));
+    *epoch_key =3D new_epoch_key;
+}
+
+void
+epoch_data_key_derive(struct key_parameters *key,
+                      const struct epoch_key *epoch_key,
+                      const struct key_type *kt)
+{
+    key->hmac_size =3D cipher_kt_iv_size(kt->cipher);
+    key->cipher_size =3D cipher_kt_key_size(kt->cipher);
+
+    /* Generate data key from epoch key:
+     * K_i =3D OVPN-Expand-Label(E_i, "data_key", "", key_size)
+     * implicit_iv =3D OVPN-Expand-Label(E_i, "data_iv", "", implicit_iv_l=
en)
+     */
+
+    const uint8_t epoch_data_key_label[] =3D "data_key";
+    ovpn_expand_label(epoch_key->epoch_key, sizeof(epoch_key->epoch_key),
+                      epoch_data_key_label, 8,
+                      NULL, 0,
+                      (uint8_t *)(&key->cipher), key->cipher_size);
+
+    const uint8_t epoch_data_iv_label[] =3D "data_iv";
+    ovpn_expand_label(epoch_key->epoch_key, sizeof(epoch_key->epoch_key),
+                      epoch_data_iv_label, 7,
+                      NULL, 0,
+                      (uint8_t *)(&key->hmac), key->hmac_size);
+    key->epoch =3D epoch_key->epoch;
+}
+
+static void
+epoch_init_send_key_ctx(struct crypto_options *co)
+{
+    /* Ensure that we are NEVER regenerating the same key that has already
+     * been generated. Since we also reset the packet ID counter this woul=
d be
+     * catastrophic as we would do IV reuse which breaks ciphers like AES-=
GCM */
+    ASSERT(co->key_ctx_bi.encrypt.epoch !=3D co->epoch_key_send.epoch);
+    char name[32] =3D { 0 };
+    snprintf(name, sizeof(name), "Epoch Data key %" PRIu16, co->epoch_key_=
send.epoch);
+
+    struct key_parameters send_key =3D { 0 };
+
+    epoch_data_key_derive(&send_key, &co->epoch_key_send, &co->epoch_key_t=
ype);
+
+    init_key_bi_ctx_send(&co->key_ctx_bi.encrypt, &send_key,
+                         &co->epoch_key_type, name);
+    reset_packet_id_send(&co->packet_id.send);
+    CLEAR(send_key);
+}
+
+
+static void
+epoch_init_recv_key(struct key_ctx *ctx, struct crypto_options *co)
+{
+    struct key_parameters recv_key =3D { 0 };
+    epoch_data_key_derive(&recv_key, &co->epoch_key_recv, &co->epoch_key_t=
ype);
+
+    char name[32];
+
+    snprintf(name, sizeof(name), "Epoch Data key %" PRIu16, co->epoch_key_=
recv.epoch);
+
+    init_key_bi_ctx_recv(ctx, &recv_key, &co->epoch_key_type, name);
+    CLEAR(recv_key);
+}
+
+void
+epoch_generate_future_receive_keys(struct crypto_options *co)
+{
+    /* We want the number of receive keys starting with the currently used
+     * keys. */
+    ASSERT(co->key_ctx_bi.initialized);
+    uint16_t current_epoch_recv =3D co->key_ctx_bi.decrypt.epoch;
+
+    /* Either we have not generated any future keys yet or the last
+     * index is the same as our current epoch key */
+    struct key_ctx *highest_future_key =3D &co->epoch_data_keys_future[co-=
>epoch_data_keys_future_count - 1];
+
+    ASSERT(co->epoch_key_recv.epoch =3D=3D 1
+           || highest_future_key->epoch =3D=3D co->epoch_key_recv.epoch);
+
+    /* free the keys that are not used anymore */
+    for (uint16_t i =3D 0; i < co->epoch_data_keys_future_count; i++)
+    {
+        /* Keys in future keys are always epoch > 1 if initialised */
+        if (co->epoch_data_keys_future[i].epoch > 0
+            && co->epoch_data_keys_future[i].epoch < current_epoch_recv)
+        {
+            /* Key is old, free it */
+            free_key_ctx(&co->epoch_data_keys_future[i]);
+        }
+    }
+
+    /* Calculate the number of keys that need to be generated,
+     * if no keys have been generated assume only the first key is defined=
 */
+    uint16_t current_highest_key =3D highest_future_key->epoch ? highest_f=
uture_key->epoch : 1;
+    uint16_t desired_highest_key =3D current_epoch_recv + co->epoch_data_k=
eys_future_count;
+    uint16_t num_keys_generate =3D desired_highest_key - current_highest_k=
ey;
+
+
+    /* Move the old keys out of the way so the order of keys stays strictly
+     * monotonic and consecutive. */
+    /* first check that the destination we are going to overwrite is freed=
 */
+    for (uint16_t i =3D 0; i < num_keys_generate; i++)
+    {
+        ASSERT(co->epoch_data_keys_future[i].epoch =3D=3D 0);
+    }
+    memmove(co->epoch_data_keys_future,
+            co->epoch_data_keys_future + num_keys_generate,
+            (co->epoch_data_keys_future_count - num_keys_generate) * sizeo=
f(struct key_ctx));
+
+    /* Clear and regenerate the array elements at the end */
+    for (uint16_t i =3D co->epoch_data_keys_future_count - num_keys_genera=
te; i < co->epoch_data_keys_future_count; i++)
+    {
+        CLEAR(co->epoch_data_keys_future[i]);
+        epoch_key_iterate(&co->epoch_key_recv);
+
+        epoch_init_recv_key(&co->epoch_data_keys_future[i], co);
+    }
+
+    /* Assert that all keys are initialised */
+    for (uint16_t i =3D 0; i < co->epoch_data_keys_future_count; i++)
+    {
+        ASSERT(co->epoch_data_keys_future[i].epoch > 0);
+    }
+}
+
+void
+epoch_iterate_send_key(struct crypto_options *co)
+{
+    ASSERT(co->epoch_key_send.epoch < UINT16_MAX);
+    epoch_key_iterate(&co->epoch_key_send);
+    free_key_ctx(&co->key_ctx_bi.encrypt);
+    epoch_init_send_key_ctx(co);
+}
+
+void
+epoch_replace_update_recv_key(struct crypto_options *co,
+                              uint16_t new_epoch)
+{
+    /* Find the key of the new epoch in future keys */
+    uint16_t fki;
+    for (fki =3D 0; fki < co->epoch_data_keys_future_count; fki++)
+    {
+        if (co->epoch_data_keys_future[fki].epoch =3D=3D new_epoch)
+        {
+            break;
+        }
+    }
+    /* we should only ever be called when we successfully decrypted/authen=
ticated
+     * a packet from a peer, ie the epoch recv key *MUST* be in that
+     * array */
+    ASSERT(fki < co->epoch_data_keys_future_count);
+    ASSERT(co->epoch_data_keys_future[fki].epoch =3D=3D new_epoch);
+
+    struct key_ctx *new_ctx =3D &co->epoch_data_keys_future[fki];
+
+    /* Check if the new recv key epoch is higher than the send key epoch. =
If
+     * yes we will replace the send key as well */
+    if (co->key_ctx_bi.encrypt.epoch < new_epoch)
+    {
+        free_key_ctx(&co->key_ctx_bi.encrypt);
+
+        /* Update the epoch_key for send to match the current key being us=
ed.
+         * This is a bit of extra work but since we are a maximum of 16
+         * keys behind, a maximum 16 HMAC invocations are a small price to
+         * pay for not keeping all the old epoch keys around in future_keys
+         * array */
+        while (co->epoch_key_send.epoch < new_epoch)
+        {
+            epoch_key_iterate(&co->epoch_key_send);
+        }
+        epoch_init_send_key_ctx(co);
+    }
+
+    /* Replace receive key */
+    free_key_ctx(&co->epoch_retiring_data_receive_key);
+    co->epoch_retiring_data_receive_key =3D co->key_ctx_bi.decrypt;
+    packet_id_move_recv(&co->epoch_retiring_key_pid_recv, &co->packet_id.r=
ec);
+
+    co->key_ctx_bi.decrypt =3D *new_ctx;
+
+    /* Zero the old location instead to of free_key_ctx since we moved the=
 keys
+     * and do not want to free the pointers in the old place */
+    memset(new_ctx, 0, sizeof(struct key_ctx));
+
+    /* Generate new future keys */
+    epoch_generate_future_receive_keys(co);
+}
+
+void
+free_epoch_key_ctx(struct crypto_options *co)
+{
+    for (uint16_t i =3D 0; i < co->epoch_data_keys_future_count; i++)
+    {
+        free_key_ctx(&co->epoch_data_keys_future[i]);
+    }
+
+    free(co->epoch_data_keys_future);
+    free_key_ctx(&co->epoch_retiring_data_receive_key);
+    free(co->epoch_retiring_key_pid_recv.seq_list);
+    CLEAR(co->epoch_key_recv);
+    CLEAR(co->epoch_key_send);
+}
+
+void
+epoch_init_key_ctx(struct crypto_options *co, const struct key_type *key_t=
ype,
+                   const struct epoch_key *e1_send,
+                   const struct epoch_key *e1_recv,
+                   uint16_t future_key_count)
+{
+    ASSERT(e1_send->epoch =3D=3D 1 && e1_recv->epoch =3D=3D 1);
+    co->epoch_key_recv =3D *e1_recv;
+    co->epoch_key_send =3D *e1_send;
+
+    co->epoch_key_type =3D *key_type;
+    co->aead_usage_limit =3D cipher_get_aead_limits(key_type->cipher);
+
+    epoch_init_send_key_ctx(co);
+    epoch_init_recv_key(&co->key_ctx_bi.decrypt, co);
+    co->key_ctx_bi.initialized =3D true;
+
+    co->epoch_data_keys_future_count =3D future_key_count;
+    ALLOC_ARRAY_CLEAR(co->epoch_data_keys_future, struct key_ctx, co->epoc=
h_data_keys_future_count);
+    epoch_generate_future_receive_keys(co);
+}
+
+const struct key_ctx *
+epoch_lookup_decrypt_key(struct crypto_options *opt, uint16_t epoch)
+{
+    /* Current decrypt key is the most likely one */
+    if (opt->key_ctx_bi.decrypt.epoch =3D=3D epoch)
+    {
+        return &opt->key_ctx_bi.decrypt;
+    }
+    else if (opt->epoch_retiring_data_receive_key.epoch
+             && opt->epoch_retiring_data_receive_key.epoch =3D=3D epoch)
+    {
+        return &opt->epoch_retiring_data_receive_key;
+    }
+    else if (epoch > opt->key_ctx_bi.decrypt.epoch
+             && epoch <=3D opt->key_ctx_bi.decrypt.epoch + opt->epoch_data=
_keys_future_count)
+    {
+        /* Key in the range of future keys */
+        int index =3D epoch - (opt->key_ctx_bi.decrypt.epoch + 1);
+
+        /* If we have reached the edge of the valid keys we do not return
+         * the key anymore since regenerating the new keys would move us
+         * over the window of valid keys and would need all kind of
+         * special casing, so we stop returning the key in this case */
+        if (epoch > (UINT16_MAX - opt->epoch_data_keys_future_count - 1))
+        {
+            return NULL;
+        }
+        else
+        {
+            return &opt->epoch_data_keys_future[index];
+        }
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
+
+void
+epoch_check_send_iterate(struct crypto_options *opt)
+{
+    if (opt->epoch_key_send.epoch =3D=3D UINT16_MAX)
+    {
+        /* limit of epoch keys reached, cannot move to a newer key anymore=
 */
+        return;
+    }
+    if (opt->aead_usage_limit)
+    {
+        if (aead_usage_limit_reached(opt->aead_usage_limit, &opt->key_ctx_=
bi.encrypt,
+                                     opt->packet_id.send.id))
+        {
+            /* Send key limit reached */
+            epoch_iterate_send_key(opt);
+        }
+        /* draft 8 of the aead usage limit still had but draft 9 complete
+         * dropped this statement:
+         *
+         *    In particular, is two-party communication, one participant c=
annot
+         *    regard apparent overuse of a key by other participants as
+         *    being in error, when it could be that the other participant =
has
+         *    better information about bounds.
+         *
+         * OpenVPN 2.x implements a compromise of not regarding this as an
+         * error but still accepting packets of the usage limit but tries =
to
+         * push the peer to a new epoch key by increasing our own key epoch
+         * */
+        else if (opt->key_ctx_bi.encrypt.epoch =3D=3D opt->key_ctx_bi.decr=
ypt.epoch
+                 && aead_usage_limit_reached(opt->aead_usage_limit,
+                                             &opt->key_ctx_bi.decrypt,
+                                             opt->packet_id.rec.id))
+        {
+            /* Receive key limit reached. Increase our own send key to sig=
nal
+             * that we want to use a new epoch. Peer should then also move=
 its
+             * key but is not required to do this */
+            epoch_iterate_send_key(opt);
+        }
+    }
+
+    if (opt->packet_id.send.id =3D=3D PACKET_ID_EPOCH_MAX)
+    {
+        epoch_iterate_send_key(opt);
+    }
+
+}
diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
index dad2473..95d8e9e 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -66,4 +66,81 @@
                   const uint8_t *context, size_t context_len,
                   uint8_t *out, uint16_t out_len);

-#endif
+/**
+ * Generate a data channel key pair from the epoch key
+ * @param epoch_key     Epoch key to be used
+ * @param key          Destination for the generated data key
+ * @parm kt             Cipher information to generate the data channel ke=
y for
+ */
+void
+epoch_data_key_derive(struct key_parameters *key,
+                      const struct epoch_key *epoch_key,
+                      const struct key_type *kt);
+
+/**
+ * Generates and fills the epoch_data_keys_future with next valid
+ * future keys in crypto_options
+ *
+ * This assume that the normal key_ctx_bi and epoch keys are already setup
+ */
+void
+epoch_generate_future_receive_keys(struct crypto_options *co);
+
+
+/** This is called when the peer using a new send key that is not the defa=
ult
+ * key. This function ensures the following:
+ * - recv key matches the epoch index provided
+ * - send key epoch is equal or higher than recv_key epoch
+ *
+ * @param new_epoch the new epoch to use a the receive key
+ */
+void
+epoch_replace_update_recv_key(struct crypto_options *co,
+                              uint16_t new_epoch);
+
+/**
+ * Updates the send key and send_epoch_keyt in cryptio_options->key_ctx_bi=
 to
+ * use the next epoch */
+void
+epoch_iterate_send_key(struct crypto_options *co);
+
+/**
+ * Frees the extra data structures used by epoch keys in \c crypto_options
+ */
+void
+free_epoch_key_ctx(struct crypto_options *co);
+
+/**
+ * Initialises data channel keys and internal structures for epoch data ke=
ys
+ * using the provided E0 epoch key
+ *
+ * @param e1_send    The E1 send epoch key derived by TLS-EKM
+ * @param e1_recv    The E1 receive epoch key derived by TLS-EKM
+ */
+void
+epoch_init_key_ctx(struct crypto_options *co, const struct key_type *key_t=
ype,
+                   const struct epoch_key *e1_send, const struct epoch_key=
 *e1_recv,
+                   uint16_t future_key_count);
+
+/**
+ * Using an epoch, this function will try to retrieve a decryption
+ * key context that matches that epoch from the \c opt argument
+ * @param opt       crypto_options to use to find the decrypt key
+ * @param epoch     epoch of the key to lookup
+ * @return          the key context with
+ */
+const struct key_ctx *
+epoch_lookup_decrypt_key(struct crypto_options *opt, uint16_t epoch);
+
+/**
+ * Checks if we need to iterate the send epoch key. This needs to be in one
+ * of the following condition
+ *  - max epoch counter reached
+ *  - send key aead usage limit reached (for AES-GCM and similar ciphers)
+ *  - recv key usage limit reached
+ */
+void
+epoch_check_send_iterate(struct crypto_options *opt);
+
+
+#endif /* ifndef CRYPTO_EPOCH_H */
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 8cde108..177391a 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -78,6 +78,21 @@
 }

 void
+packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time=
_backtrack, const char *name, int unit)
+{
+    rec->name =3D name;
+    rec->unit =3D unit;
+    if (seq_backtrack)
+    {
+        ASSERT(MIN_SEQ_BACKTRACK <=3D seq_backtrack && seq_backtrack <=3D =
MAX_SEQ_BACKTRACK);
+        ASSERT(MIN_TIME_BACKTRACK <=3D time_backtrack && time_backtrack <=
=3D MAX_TIME_BACKTRACK);
+        CIRC_LIST_ALLOC(rec->seq_list, struct seq_list, seq_backtrack);
+        rec->seq_backtrack =3D seq_backtrack;
+        rec->time_backtrack =3D time_backtrack;
+    }
+    rec->initialized =3D true;
+}
+void
 packet_id_init(struct packet_id *p, int seq_backtrack, int time_backtrack,=
 const char *name, int unit)
 {
     dmsg(D_PID_DEBUG, "PID packet_id_init seq_backtrack=3D%d time_backtrac=
k=3D%d",
@@ -87,17 +102,25 @@
     ASSERT(p);
     CLEAR(*p);

-    p->rec.name =3D name;
-    p->rec.unit =3D unit;
-    if (seq_backtrack)
-    {
-        ASSERT(MIN_SEQ_BACKTRACK <=3D seq_backtrack && seq_backtrack <=3D =
MAX_SEQ_BACKTRACK);
-        ASSERT(MIN_TIME_BACKTRACK <=3D time_backtrack && time_backtrack <=
=3D MAX_TIME_BACKTRACK);
-        CIRC_LIST_ALLOC(p->rec.seq_list, struct seq_list, seq_backtrack);
-        p->rec.seq_backtrack =3D seq_backtrack;
-        p->rec.time_backtrack =3D time_backtrack;
-    }
-    p->rec.initialized =3D true;
+    packet_id_init_recv(&p->rec, seq_backtrack, time_backtrack, name, unit=
);
+}
+
+void
+packet_id_move_recv(struct packet_id_rec *dest, struct packet_id_rec *src)
+{
+    ASSERT(src);
+    ASSERT(dest);
+    /* clear free any old data in rec list */
+    free(dest->seq_list);
+    CLEAR(*dest);
+
+    /* Copy data to dest */
+    *dest =3D *src;
+
+    /* Reinitalise the source */
+    CLEAR(*src);
+    packet_id_init_recv(src, dest->seq_backtrack, dest->time_backtrack,
+                        dest->name, dest->unit);
 }

 void
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 79224d2..7620ce5 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -203,6 +203,15 @@
=20
 void packet_id_free(struct packet_id *p);

+/**
+ * Move the packet id recv structure from src to dest. src will will
+ * be reinitialised with
+ * @param dest
+ * @param src
+ */
+void
+packet_id_move_recv(struct packet_id_rec *dest, struct packet_id_rec *src);
+
 /* should we accept an incoming packet id ? */
 bool packet_id_test(struct packet_id_rec *p,
                     const struct packet_id_net *pin);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index ce1cd9e..511127d 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -333,8 +333,8 @@
     interval_t packet_timeout;
     int64_t renegotiate_bytes;
     int64_t renegotiate_packets;
-    /** This limit for AEAD cipher, this is the sum of packets + blocks
-     * that are allowed to be used */
+    /** This limit for AEAD cipher when not running in epoch data key mode,
+     * this is the sum of packets + blocks that are allowed to be used */
     int64_t aead_usage_limit;
     interval_t renegotiate_seconds;

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index c8d2a10..54a6caa 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -575,7 +575,7 @@
      0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
      0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};

-    const uint8_t *label =3D (const uint8_t *)("unit test");
+    const uint8_t *label =3D (const uint8_t *) ("unit test");
     uint8_t out[16];
     ovpn_expand_label(secret, sizeof(secret), label, 9, NULL, 0, out, size=
of(out));

@@ -586,9 +586,238 @@
     assert_memory_equal(out, out_expected, 16);
 }

+struct epoch_test_state
+{
+    struct key_type kt;
+    struct gc_arena gc;
+    struct crypto_options co;
+};
+
+static int
+crypto_test_epoch_setup(void **state)
+{
+    int *num_future_keys =3D (int *)*state;
+    struct epoch_test_state *data =3D calloc(1, sizeof(struct epoch_test_s=
tate));
+
+    data->gc =3D gc_new();
+
+    init_key_type(&data->kt, "AES-128-GCM", "none", true, false);
+
+    /* have an epoch key that is uses 0x23 for the key for all bytes */
+    struct epoch_key epoch1send =3D { .epoch =3D 1, .epoch_key =3D {0x23} =
};
+    struct epoch_key epoch1recv =3D { .epoch =3D 1, .epoch_key =3D {0x27} =
};
+
+    epoch_init_key_ctx(&data->co, &data->kt, &epoch1send,
+                       &epoch1recv, *num_future_keys);
+
+    *state =3D data;
+    return 0;
+}
+
+static int
+crypto_test_epoch_teardown(void **state)
+{
+    struct epoch_test_state *data =3D *state;
+    free_epoch_key_ctx(&data->co);
+    free_key_ctx_bi(&data->co.key_ctx_bi);
+    gc_free(&data->gc);
+    free(*state);
+    return 0;
+}
+
+void
+crypto_test_epoch_key_generation(void **state)
+{
+    struct epoch_test_state *data =3D *state;
+    struct crypto_options *co =3D &data->co;
+
+    /* check the keys look like expect */
+    assert_int_equal(co->epoch_data_keys_future[0].epoch, 2);
+    assert_int_equal(co->epoch_data_keys_future[15].epoch, 17);
+    assert_int_equal(co->epoch_key_send.epoch, 1);
+    assert_int_equal(co->epoch_key_recv.epoch, 17);
+
+    /* Now replace the recv key with the 6th future key (epoch =3D 8) */
+    free_key_ctx(&co->key_ctx_bi.decrypt);
+    assert_int_equal(co->epoch_data_keys_future[6].epoch, 8);
+    co->key_ctx_bi.decrypt =3D co->epoch_data_keys_future[6];
+    CLEAR(co->epoch_data_keys_future[6]);
+
+    epoch_generate_future_receive_keys(co);
+    assert_int_equal(co->epoch_data_keys_future[0].epoch, 9);
+    assert_int_equal(co->epoch_data_keys_future[15].epoch, 24);
+}
+
+
+void
+crypto_test_epoch_key_rotation(void **state)
+{
+    struct epoch_test_state *data =3D *state;
+    struct crypto_options *co =3D &data->co;
+
+    /* should replace send + key recv */
+    epoch_replace_update_recv_key(co, 9);
+
+    assert_int_equal(co->key_ctx_bi.decrypt.epoch, 9);
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, 9);
+    assert_int_equal(co->epoch_key_send.epoch, 9);
+    assert_int_equal(co->epoch_retiring_data_receive_key.epoch, 1);
+
+    /* Iterate the data send key four times to get it to 13 */
+    for (int i =3D 0; i < 4; i++)
+    {
+        epoch_iterate_send_key(co);
+    }
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, 13);
+
+    epoch_replace_update_recv_key(co, 10);
+    assert_int_equal(co->key_ctx_bi.decrypt.epoch, 10);
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, 13);
+    assert_int_equal(co->epoch_key_send.epoch, 13);
+    assert_int_equal(co->epoch_retiring_data_receive_key.epoch, 9);
+
+    epoch_replace_update_recv_key(co, 12);
+    assert_int_equal(co->key_ctx_bi.decrypt.epoch, 12);
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, 13);
+    assert_int_equal(co->epoch_key_send.epoch, 13);
+    assert_int_equal(co->epoch_retiring_data_receive_key.epoch, 10);
+
+    epoch_iterate_send_key(co);
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, 14);
+}
+
+void
+crypto_test_epoch_key_receive_lookup(void **state)
+{
+    struct epoch_test_state *data =3D *state;
+    struct crypto_options *co =3D &data->co;
+
+    /* lookup some wacky things that should fail */
+    assert_null(epoch_lookup_decrypt_key(co, 2000));
+    assert_null(epoch_lookup_decrypt_key(co, -1));
+    assert_null(epoch_lookup_decrypt_key(co, 0xefff));
+
+    /* Lookup the edges of the current window */
+    assert_null(epoch_lookup_decrypt_key(co, 0));
+    assert_int_equal(epoch_lookup_decrypt_key(co, 1)->epoch, 1);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 2)->epoch, 2);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 13)->epoch, 13);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 14)->epoch, 14);
+    assert_null(epoch_lookup_decrypt_key(co, 15));
+
+    /* Should move 1 to retiring key but leave 1-5 undefined, 7 as
+     * active and 8-20 as future keys*/
+    epoch_replace_update_recv_key(co, 7);
+
+    assert_null(epoch_lookup_decrypt_key(co, 0));
+    assert_int_equal(epoch_lookup_decrypt_key(co, 1)->epoch, 1);
+    assert_null(epoch_lookup_decrypt_key(co, 2));
+    assert_null(epoch_lookup_decrypt_key(co, 3));
+    assert_null(epoch_lookup_decrypt_key(co, 4));
+    assert_null(epoch_lookup_decrypt_key(co, 5));
+    assert_null(epoch_lookup_decrypt_key(co, 6));
+    assert_int_equal(epoch_lookup_decrypt_key(co, 7)->epoch, 7);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 8)->epoch, 8);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 20)->epoch, 20);
+    assert_null(epoch_lookup_decrypt_key(co, 21));
+    assert_null(epoch_lookup_decrypt_key(co, 22));
+
+
+    /* Should move 7 to retiring key and have 8 as active key and
+     * 9-21 as future keys */
+    epoch_replace_update_recv_key(co, 8);
+    assert_null(epoch_lookup_decrypt_key(co, 0));
+    assert_null(epoch_lookup_decrypt_key(co, 1));
+    assert_null(epoch_lookup_decrypt_key(co, 2));
+    assert_null(epoch_lookup_decrypt_key(co, 3));
+    assert_null(epoch_lookup_decrypt_key(co, 4));
+    assert_null(epoch_lookup_decrypt_key(co, 5));
+    assert_null(epoch_lookup_decrypt_key(co, 6));
+    assert_int_equal(epoch_lookup_decrypt_key(co, 7)->epoch, 7);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 8)->epoch, 8);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 20)->epoch, 20);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 21)->epoch, 21);
+    assert_null(epoch_lookup_decrypt_key(co, 22));
+    assert_null(epoch_lookup_decrypt_key(co, 23));
+}
+
+void
+crypto_test_epoch_key_overflow(void **state)
+{
+    struct epoch_test_state *data =3D *state;
+    struct crypto_options *co =3D &data->co;
+
+    /* Modify the receive epoch and keys to have a very high epoch to test
+     * the end of array. Iterating through all 16k keys takes a 2-3s, so we
+     * avoid this for the unit test */
+    co->key_ctx_bi.decrypt.epoch =3D 16000;
+    co->key_ctx_bi.encrypt.epoch =3D 16000;
+
+    co->epoch_key_send.epoch =3D 16000;
+    co->epoch_key_recv.epoch =3D 16000 + co->epoch_data_keys_future_count;
+
+    for (uint16_t i =3D 0; i < co->epoch_data_keys_future_count; i++)
+    {
+        co->epoch_data_keys_future[i].epoch =3D 16001 + i;
+    }
+
+    /* Move the last few keys until we are close to the limit */
+    while (co->key_ctx_bi.decrypt.epoch < (UINT16_MAX - 40))
+    {
+        epoch_replace_update_recv_key(co, co->key_ctx_bi.decrypt.epoch + 1=
0);
+    }
+
+    /* Looking up this key should still work as it will not break the limit
+     * when generating keys */
+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 34)->epoch,=
 UINT16_MAX - 34);
+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 33)->epoch,=
 UINT16_MAX - 33);
+
+    /* This key is no longer eligible for decrypting as the 32 future keys
+     * would be larger than uint16_t maximum */
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - 32));
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX));
+
+    /* Check that moving to the last possible epoch works */
+    epoch_replace_update_recv_key(co, UINT16_MAX - 33);
+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 33)->epoch,=
 UINT16_MAX - 33);
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - 32));
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX));
+}
+
+void
+epoch_test_derive_data_key(void **state)
+{
+    struct epoch_key e17 =3D { .epoch =3D 17, .epoch_key =3D { 19, 12 }};
+    struct key_type kt =3D { 0 };
+    struct key_parameters key_parameters =3D { 0 };
+    init_key_type(&kt, "AES-192-GCM", "none", true, false);
+
+
+    epoch_data_key_derive(&key_parameters, &e17, &kt);
+
+    assert_int_equal(key_parameters.cipher_size, 24);
+    assert_int_equal(key_parameters.hmac_size, 12);
+
+    uint8_t exp_cipherkey[24] =3D
+    {0x00, 0x62, 0x84, 0xcb, 0x31, 0x57, 0xc7, 0x97,
+     0x8d, 0xe8, 0xfb, 0x6e, 0xdc, 0x60, 0x38, 0xc3,
+     0xa4, 0xb9, 0xa1, 0xea, 0xf4, 0x01, 0x86, 0xbc };
+
+    uint8_t exp_impl_iv[12] =3D
+    { 0xb4, 0x32, 0xeb, 0x4e, 0x61, 0x4b, 0xa2, 0xf3,
+      0x5d, 0x86, 0x22, 0x1f  };
+
+    assert_memory_equal(key_parameters.cipher, exp_cipherkey, sizeof(exp_c=
ipherkey));
+    assert_memory_equal(key_parameters.hmac, exp_impl_iv, sizeof(exp_impl_=
iv));
+}
+
 int
 main(void)
 {
+    int prestate_num13 =3D 13;
+    int prestate_num16 =3D 16;
+    int prestate_num32 =3D 32;
+
     openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(crypto_pem_encode_decode_loopback),
@@ -602,6 +831,23 @@
         cmocka_unit_test(crypto_test_hkdf_expand_testa2),
         cmocka_unit_test(crypto_test_hkdf_expand_testa3),
         cmocka_unit_test(crypto_test_ovpn_label_expand),
+        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_gen=
eration,
+                                                 crypto_test_epoch_setup,
+                                                 crypto_test_epoch_teardow=
n,
+                                                 &prestate_num16),
+        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_rot=
ation,
+                                                 crypto_test_epoch_setup,
+                                                 crypto_test_epoch_teardow=
n,
+                                                 &prestate_num13),
+        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_rec=
eive_lookup,
+                                                 crypto_test_epoch_setup,
+                                                 crypto_test_epoch_teardow=
n,
+                                                 &prestate_num13),
+        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_ove=
rflow,
+                                                 crypto_test_epoch_setup,
+                                                 crypto_test_epoch_teardow=
n,
+                                                 &prestate_num32),
+        cmocka_unit_test(epoch_test_derive_data_key)
     };

 #if defined(ENABLE_CRYPTO_OPENSSL)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80
Gerrit-Change-Number: 804
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--kHM2chMGwOM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Implement methods to generate and manage OpenVPN Epoch keys<br><br>Th=
is implements functions that allow these keys to be generated and<br>manage=
d. It does not yet implement using them for the data channel.<br><br>Change=
-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80<br>Signed-off-by: Arne Schwa=
be &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openvp=
n/crypto.h<br>M src/openvpn/crypto_epoch.c<br>M src/openvpn/crypto_epoch.h<=
br>M src/openvpn/packet_id.c<br>M src/openvpn/packet_id.h<br>M src/openvpn/=
ssl_common.h<br>M tests/unit_tests/openvpn/test_crypto.c<br>8 files changed=
, 774 insertions(+), 20 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/04/804/4</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
crypto.c b/src/openvpn/crypto.c</span><br><span>index 769a274..a055b20 1006=
44</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/ope=
nvpn/crypto.c</span><br><span>@@ -908,14 +908,27 @@</span><br><span>     if=
 (cipher_ctx_mode_aead(ctx-&gt;cipher))</span><br><span>     {</span><br><s=
pan>         size_t impl_iv_len =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        size_t impl_iv_offset =3D 0;</span><br><span>   =
      ASSERT(cipher_ctx_iv_length(ctx-&gt;cipher) &gt;=3D OPENVPN_AEAD_MIN_=
IV_LEN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        impl_=
iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - sizeof(packet_id_type);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* Epoch keys use XOR of full IV=
 length with the packet id to generate</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * IVs. Old data format uses concatenation inste=
ad (XOR with 0 for the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         * first 4 bytes (sizeof(packet_id_type) */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (key-&gt;epoch)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            impl_iv_len =3D cipher_ctx_iv=
_length(ctx-&gt;cipher);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            impl_iv_offset =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - sizeof(packet_id=
_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
impl_iv_offset =3D sizeof(packet_id_type);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span>         ASSERT(impl_iv_le=
n &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>         ASSERT(impl_iv_l=
en &lt;=3D MAX_HMAC_KEY_LENGTH);</span><br><span>         ASSERT(key-&gt;hm=
ac_size &gt;=3D impl_iv_len);</span><br><span>         CLEAR(ctx-&gt;implic=
it_iv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* The=
 first bytes of the IV are filled with the packet id */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        memcpy(ctx-&gt;implicit_iv + size=
of(packet_id_type), key-&gt;hmac, impl_iv_len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        memcpy(ctx-&gt;implicit_iv + impl_iv_of=
fset, key-&gt;hmac, impl_iv_len);</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span>@@ -964,6 +977,7 @@</span><br><span>    =
          hmac_ctx_size(ctx-&gt;hmac));</span><br><span> </span><br><span> =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;ep=
och =3D key-&gt;epoch;</span><br><span>     gc_free(&amp;gc);</span><br><sp=
an> }</span><br><span> </span><br><span>@@ -976,6 +990,7 @@</span><br><span=
>     snprintf(log_prefix, sizeof(log_prefix), &quot;Outgoing %s&quot;, nam=
e);</span><br><span>     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_ENCRY=
PT, log_prefix);</span><br><span>     key_ctx_update_implicit_iv(ctx, key_p=
arams);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;=
epoch =3D key_params-&gt;epoch;</span><br><span> }</span><br><span> </span>=
<br><span> void</span><br><span>@@ -987,6 +1002,7 @@</span><br><span>     s=
nprintf(log_prefix, sizeof(log_prefix), &quot;Incoming %s&quot;, name);</sp=
an><br><span>     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log=
_prefix);</span><br><span>     key_ctx_update_implicit_iv(ctx, key_params);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;epoch =
=3D key_params-&gt;epoch;</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br><span>@@ -1024,6 +1040,7 @@</span><br><span>     }</spa=
n><br><span>     CLEAR(ctx-&gt;implicit_iv);</span><br><span>     ctx-&gt;p=
laintext_blocks =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ctx-&gt;epoch =3D 0;</span><br><span> }</span><br><span> </span><br>=
<span> void</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn=
/crypto.h</span><br><span>index 640e321..617246b 100644</span><br><span>---=
 a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><b=
r><span>@@ -170,6 +170,9 @@</span><br><span> </span><br><span>     /** Numb=
er of bytes set in the HMac key material */</span><br><span>     int hmac_s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /** the epoch of the key is if=
 it was generated as epoch data key material */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint16_t epoch;</span><br><span> };</span><=
br><span> </span><br><span> /**</span><br><span>@@ -180,6 +183,11 @@</span>=
<br><span> void</span><br><span> key_parameters_from_key(struct key_paramet=
ers *key_params, const struct key *key);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+struct epoch_key {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint8_t epoch_key[SHA256_DIGEST_L=
ENGTH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t=
 epoch;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><=
br><span>  * Container for one set of cipher and/or HMAC contexts.</span><b=
r><span>  * @ingroup control_processor</span><br><span>@@ -203,6 +211,10 @@=
</span><br><span>     /** Counter for the number of plaintext encrypted usi=
ng this cipher</span><br><span>      * in number of 128 bit blocks (only us=
ed for AEAD ciphers) */</span><br><span>     uint64_t plaintext_blocks;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** OpenVPN data ch=
annel epoch, this variable holds the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     *  epoch number that is key belongs to. Note that epo=
ch 0 is not used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  *  and epoch is always non-zero for epoch key contexts */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint16_t epoch;</span><br><span=
> };</span><br><span> </span><br><span> #define KEY_DIRECTION_BIDIRECTIONAL=
 0 /* same keys for both directions */</span><br><span>@@ -272,6 +284,39 @@=
</span><br><span>     /**&lt; OpenSSL cipher and HMAC contexts for</span><b=
r><span>      *   both sending and receiving</span><br><span>      *   dire=
ctions. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /** last epoch_key used =
for generation of the current send data keys.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * As invariant, the epoch of epoch_key_send =
is always kept &gt;=3D the epoch of</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * epoch_key_recv */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct epoch_key epoch_key_send;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /** epoch_key used for the highest receive epoch key=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct epoc=
h_key epoch_key_recv;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the key_t=
ype that is used to generate the epoch keys */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct key_type epoch_key_type;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /** This limit for AEAD cipher, this is the sum=
 of packets + blocks</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * that are allowed to be used. Will switch to a new epoch if this</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * limit is reached=
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t aead=
_usage_limit;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Keeps the future =
epoch data keys for decryption. The current one</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * that is expected to be used is stored in=
 key_ctx_bi.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * We keep both =
decrypt and encrypt key here in the future keys</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * as we want to be able to switch also sen=
ding key if the peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * switching to a newer key epoch</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct key_ctx *epoch_data_keys_future;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /** number of keys stored in \c epoch_data_keys_future *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t epoch=
_data_keys_future_count;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The ol=
d key bevor the sender switch to a new epoch data key */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct key_ctx epoch_retiring_data=
_receive_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct packet_id_rec epoch_retiring_key_pid_recv;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     struct packet_id packet_i=
d; /**&lt; Current packet ID state for both</span><br><span>               =
                   *   sending and receiving directions.</span><br><span>  =
                                *</span><br><span>@@ -280,7 +325,7 @@</span=
><br><span>                                  *</span><br><span>            =
                      *   The packet id also used as the IV</span><br><span=
>                                  *   for AEAD/OFB/CFG ciphers.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
 *   */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                     */</span><br><span>     struct packet_id_persist *pid_=
persist;</span><br><span>     /**&lt; Persistent packet ID state for</span>=
<br><span>      *   keeping state between successive</span><br><span>@@ -46=
8,13 +513,15 @@</span><br><span>  *</span><br><span>  * @param opt   Crypto=
 options for this packet, contains replay state.</span><br><span>  * @param=
 pin   Packet ID read from packet.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param epoch Epoch read from packet or 0 when epoch is no=
t used.</span><br><span>  * @param error_prefix  Prefix to use when printin=
g error messages.</span><br><span>  * @param gc    Garbage collector to use=
.</span><br><span>  *</span><br><span>  * @return true if packet ID is vali=
dated to be not a replay, false otherwise.</span><br><span>  */</span><br><=
span> bool crypto_check_replay(struct crypto_options *opt,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                         const struct =
packet_id_net *pin, const char *error_prefix,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                         const struct packet_id_n=
et *pin,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
              const char *error_prefix,</span><br><span>                   =
       struct gc_arena *gc);</span><br><span> </span><br><span> </span><br>=
<span>diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c<=
/span><br><span>index f9111f1..1f89804 100644</span><br><span>--- a/src/ope=
nvpn/crypto_epoch.c</span><br><span>+++ b/src/openvpn/crypto_epoch.c</span>=
<br><span>@@ -29,7 +29,13 @@</span><br><span> #endif</span><br><span> </spa=
n><br><span> #include &lt;inttypes.h&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;crypto_b=
ackend.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;packet_id.h&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;crypto.h&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;crypto_epoch.h&quot;</span><br><span> #inc=
lude &quot;buffer.h&quot;</span><br><span> #include &quot;integer.h&quot;</=
span><br><span> </span><br><span>@@ -104,3 +110,332 @@</span><br><span>    =
 gc_free(&amp;gc);</span><br><span>     return true;</span><br><span> }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Iterates the epoch key to make it E_n+1, ie increase t=
he epoch by one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a=
nd derive the new key material accordingly</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param epoch_key epoch key to iterate</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+epoch_key_iterate(struct epoch_key *epoch_key)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct epoch_key new_epoch_key =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    new_epoch_key.ep=
och =3D epoch_key-&gt;epoch + 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const uint8_t epoch_update_label[] =3D &quot;datakey upd&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* E_N+1 =3D OVPN-Expand-Labe=
l(E_N, &quot;datakey upd&quot;, &quot;&quot;, 32) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ovpn_expand_label(epoch_key-&gt;epoch=
_key, sizeof(epoch_key-&gt;epoch_key),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                      epoch_update_label, 11,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                      NULL, 0,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
   new_epoch_key.epoch_key, sizeof(new_epoch_key.epoch_key));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    *epoch_key =3D new_epoch_key;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+epoch_data_key_derive(struct key_parameters *key,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      const struct epoch_=
key *epoch_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                  const struct key_type *kt)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    key-&gt;hmac_size =3D cipher_kt_iv_size(kt-&gt;cipher);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    key-&gt;cipher_size =3D =
cipher_kt_key_size(kt-&gt;cipher);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Generate data key from epoch key:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * K_i =3D OVPN-Expand-Label(E_i, &quot;data_key&quot;=
, &quot;&quot;, key_size)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * implicit_iv =3D OVPN-Expand-Label(E_i, &quot;data_iv&quot;, &q=
uot;&quot;, implicit_iv_len)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t epoc=
h_data_key_label[] =3D &quot;data_key&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ovpn_expand_label(epoch_key-&gt;epoch_key, siz=
eof(epoch_key-&gt;epoch_key),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                      epoch_data_key_label, 8,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                      NULL, 0,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      (uint=
8_t *)(&amp;key-&gt;cipher), key-&gt;cipher_size);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const uint8_t epoch_data_iv_label[] =3D &quot;data_iv&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ovpn_expand_la=
bel(epoch_key-&gt;epoch_key, sizeof(epoch_key-&gt;epoch_key),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                      epoch_data_=
iv_label, 7,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
               NULL, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                      (uint8_t *)(&amp;key-&gt;hmac), key-&gt;hmac_size=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key-&gt;epoch=
 =3D epoch_key-&gt;epoch;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+epoch_init_send_key_ctx(struct crypto_o=
ptions *co)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ensure that we are =
NEVER regenerating the same key that has already</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * been generated. Since we also reset the=
 packet ID counter this would be</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * catastrophic as we would do IV reuse which breaks ciphe=
rs like AES-GCM */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(co-&gt;key_ctx_bi.encrypt.epoch !=3D co-&gt;epoch_key_send.epoch)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char name[32] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snpri=
ntf(name, sizeof(name), &quot;Epoch Data key %&quot; PRIu16, co-&gt;epoch_k=
ey_send.epoch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_paramete=
rs send_key =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_data_k=
ey_derive(&amp;send_key, &amp;co-&gt;epoch_key_send, &amp;co-&gt;epoch_key_=
type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    init_key_bi_ctx_send(&amp;co=
-&gt;key_ctx_bi.encrypt, &amp;send_key,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                         &amp;co-&gt;epoch_key_type, na=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_packe=
t_id_send(&amp;co-&gt;packet_id.send);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    CLEAR(send_key);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+epoch_init_recv_key(struct key_ctx *ctx, str=
uct crypto_options *co)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key=
_parameters recv_key =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    epoch_data_key_derive(&amp;recv_key, &amp;co-&gt;epoch_key_=
recv, &amp;co-&gt;epoch_key_type);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
char name[32];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(name, sizeo=
f(name), &quot;Epoch Data key %&quot; PRIu16, co-&gt;epoch_key_recv.epoch);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    init_key_bi_ctx_recv(ctx, &amp;rec=
v_key, &amp;co-&gt;epoch_key_type, name);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(recv_key);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+epoch_generate_future_receive=
_keys(struct crypto_options *co)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* We want the number of receive keys starting with the currently used</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * keys. */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;key_ctx_bi.=
initialized);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt16_t current_epoch_recv =3D co-&gt;key_ctx_bi.decrypt.epoch;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Either we have not generated any future keys=
 yet or the last</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * index is the same as our current epoch key */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct key_ctx *highest_future_key =3D &a=
mp;co-&gt;epoch_data_keys_future[co-&gt;epoch_data_keys_future_count - 1];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;epoch_key_recv.epoch =
=3D=3D 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
|| highest_future_key-&gt;epoch =3D=3D co-&gt;epoch_key_recv.epoch);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* free the keys that are not used anymor=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uint16=
_t i =3D 0; i &lt; co-&gt;epoch_data_keys_future_count; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* Keys in future keys are always epoch =
&gt; 1 if initialised */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (co-&gt;epoch_data_keys_future[i].epoch &gt; 0</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; co-&gt;ep=
och_data_keys_future[i].epoch &lt; current_epoch_recv)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            /* Key is old, free it */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            free_key_ctx(&amp;co=
-&gt;epoch_data_keys_future[i]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Calculate the number of=
 keys that need to be generated,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * if no keys have been generated assume only the first ke=
y is defined */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint16_t current_highest_key =3D highest_future_key-&gt;epoch ? highest_fut=
ure_key-&gt;epoch : 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint16_t desired_highest_key =3D current_epoch_recv + co-&gt;epoch_d=
ata_keys_future_count;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint16_t num_keys_generate =3D desired_highest_key - current_highest=
_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Move the old keys out of the way so the order=
 of keys stays strictly</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * monotonic and consecutive. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* first check that the destination we are going t=
o overwrite is freed */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (uint16_t i =3D 0; i &lt; num_keys_generate; i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ASSERT(co-&gt;epoch_data_keys_future[i]=
.epoch =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memmove(co-&=
gt;epoch_data_keys_future,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            co-&gt;epoch_data_keys_future + num_keys_generate,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            (co-&gt;epoch=
_data_keys_future_count - num_keys_generate) * sizeof(struct key_ctx));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Clear and regenerate the array ele=
ments at the end */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (uint16_t i =3D co-&gt;epoch_data_keys_future_count - num_keys_gene=
rate; i &lt; co-&gt;epoch_data_keys_future_count; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        CLEAR(co-&gt;epoch_data_keys_future[i]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        epoch_key_iterate=
(&amp;co-&gt;epoch_key_recv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
poch_init_recv_key(&amp;co-&gt;epoch_data_keys_future[i], co);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Assert that all keys are initialised */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (uint16_t i =3D 0; i &lt; co-&=
gt;epoch_data_keys_future_count; i++)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ASSERT(co-&gt;epoch_data_keys_future[i].epoch &gt; 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_iterate_send=
_key(struct crypto_options *co)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AS=
SERT(co-&gt;epoch_key_send.epoch &lt; UINT16_MAX);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    epoch_key_iterate(&amp;co-&gt;epoch_key_=
send);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_=
ctx(&amp;co-&gt;key_ctx_bi.encrypt);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    epoch_init_send_key_ctx(co);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_replace_update_r=
ecv_key(struct crypto_options *co,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                              uint16_t new_epoch)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Find the key of the new epoch in future k=
eys */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t =
fki;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (fki =
=3D 0; fki &lt; co-&gt;epoch_data_keys_future_count; fki++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (co-&gt;epoch_data_keys_future[fki].ep=
och =3D=3D new_epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* we should only ever be cal=
led when we successfully decrypted/authenticated</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * a packet from a peer, ie the epoch recv=
 key *MUST* be in that</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * array */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(fki &lt; co-&gt;epoch_data_keys_future_count);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;epoch_data_keys_futu=
re[fki].epoch =3D=3D new_epoch);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct key_ctx *new_ctx =3D &amp;co-&gt;epoch_data_keys_future[fki];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Check if the new recv key epoch is highe=
r than the send key epoch. If</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * yes we will replace the send key as well */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (co-&gt;key_ctx_bi.encrypt.=
epoch &lt; new_epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free=
_key_ctx(&amp;co-&gt;key_ctx_bi.encrypt);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* Update the epoch_key for send to match the current key being =
used.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Thi=
s is a bit of extra work but since we are a maximum of 16</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * keys behind, a maximum 16 =
HMAC invocations are a small price to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * pay for not keeping all the old epoch keys aro=
und in future_keys</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * array */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       while (co-&gt;epoch_key_send.epoch &lt; new_epoch)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            epoch_key_iterate(&amp;co-&gt;epoch=
_key_send);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        epoch_init=
_send_key_ctx(co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Replace receive key */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx(&amp;co=
-&gt;epoch_retiring_data_receive_key);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    co-&gt;epoch_retiring_data_receive_key =3D co-&gt;ke=
y_ctx_bi.decrypt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  packet_id_move_recv(&amp;co-&gt;epoch_retiring_key_pid_recv, &amp;co-&gt;=
packet_id.rec);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;key_ctx_bi.d=
ecrypt =3D *new_ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Zero the ol=
d location instead to of free_key_ctx since we moved the keys</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * and do not want to free th=
e pointers in the old place */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    memset(new_ctx, 0, sizeof(struct key_ctx));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Generate new future keys */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    epoch_generate_future_receive_keys(c=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+free_epoch_key_ctx(struct crypto_options *co)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (uint16_t i =3D 0; i &lt; co-&gt;epoch_data_keys_fu=
ture_count; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free_key_=
ctx(&amp;co-&gt;epoch_data_keys_future[i]);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(=
co-&gt;epoch_data_keys_future);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    free_key_ctx(&amp;co-&gt;epoch_retiring_data_receive_key);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(co-&gt;epoc=
h_retiring_key_pid_recv.seq_list);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(co-&gt;epoch_key_recv);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    CLEAR(co-&gt;epoch_key_send);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_ini=
t_key_ctx(struct crypto_options *co, const struct key_type *key_type,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                   const =
struct epoch_key *e1_send,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                   const struct epoch_key *e1_recv,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                   uint16_t future_k=
ey_count)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(e1_send-&gt;epoch=
 =3D=3D 1 &amp;&amp; e1_recv-&gt;epoch =3D=3D 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    co-&gt;epoch_key_recv =3D *e1_recv;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;epoch_key_send=
 =3D *e1_send;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;epoch_key_typ=
e =3D *key_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 co-&gt;aead_usage_limit =3D cipher_get_aead_limits(key_type-&gt;cipher);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    epoch_init_send_key_ctx(co);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_init_recv_key(&am=
p;co-&gt;key_ctx_bi.decrypt, co);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    co-&gt;key_ctx_bi.initialized =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    co-&gt;epoch_data_keys_future_count =3D future_key_c=
ount;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRA=
Y_CLEAR(co-&gt;epoch_data_keys_future, struct key_ctx, co-&gt;epoch_data_ke=
ys_future_count);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  epoch_generate_future_receive_keys(co);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct ke=
y_ctx *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_lookup=
_decrypt_key(struct crypto_options *opt, uint16_t epoch)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Current decrypt key is the most likely one */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;key_ctx=
_bi.decrypt.epoch =3D=3D epoch)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return &amp;opt-&gt;key_ctx_bi.decrypt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (opt-&gt;epoch_retiring_data_receive_key.epoch</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; =
opt-&gt;epoch_retiring_data_receive_key.epoch =3D=3D epoch)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return &amp;opt-&gt;epoch_retiring_data_r=
eceive_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (epoch &gt=
; opt-&gt;key_ctx_bi.decrypt.epoch</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+             &amp;&amp; epoch &lt;=3D opt-&gt;key_ctx_bi.dec=
rypt.epoch + opt-&gt;epoch_data_keys_future_count)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* Key in the range of future keys */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        int index =3D epoch - (o=
pt-&gt;key_ctx_bi.decrypt.epoch + 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* If we have reached the edge of the valid keys we do not return</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the key any=
more since regenerating the new keys would move us</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * over the window of valid keys and=
 would need all kind of</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         * special casing, so we stop returning the key in this case */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (epoch &=
gt; (UINT16_MAX - opt-&gt;epoch_data_keys_future_count - 1))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return &amp;opt-&gt;epoch_data_keys_future[index];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_=
check_send_iterate(struct crypto_options *opt)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (opt-&gt;epoch_key_send.epoch =3D=3D UINT16_MAX)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* limit of epoch keys reached, cann=
ot move to a newer key anymore */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (opt-&gt;aead_usage_limit)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (aead_usage_limit_reached(opt-&gt;aead_usage_limit, &amp;opt-&gt;key=
_ctx_bi.encrypt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                  opt-&gt;packet_id.send.id))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Send key limit reached */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            epoch_it=
erate_send_key(opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* draft 8 of the aead usage limit still had but draft 9 complete</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * dropped this statem=
ent:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         *    In particu=
lar, is two-party communication, one participant cannot</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         *    regard apparent overuse o=
f a key by other participants as</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         *    being in error, when it could be that the other =
participant has</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     *    better information about bounds.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * OpenVPN 2.x implements a compromise of not regardi=
ng this as an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * error but still accepting packets of the usage limit but tries to</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * push the peer=
 to a new epoch key by increasing our own key epoch</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else if (opt-&gt;key_ctx_bi.encrypt.epo=
ch =3D=3D opt-&gt;key_ctx_bi.decrypt.epoch</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                 &amp;&amp; aead_usage_limit_reached=
(opt-&gt;aead_usage_limit,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                             &amp;opt-&gt;key_ctx_bi=
.decrypt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                   opt-&gt;packet_id.rec.id))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Receive key limit reached.=
 Increase our own send key to signal</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             * that we want to use a new epoch. Peer shoul=
d then also move its</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+             * key but is not required to do this */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            epoch_iterate_send_key(opt);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (opt-&gt;packet_id.send.id =3D=3D PACKET_ID_EPOCH_MAX)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        epoch_iterate_send_key(opt)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/crypto_e=
poch.h b/src/openvpn/crypto_epoch.h</span><br><span>index dad2473..95d8e9e =
100644</span><br><span>--- a/src/openvpn/crypto_epoch.h</span><br><span>+++=
 b/src/openvpn/crypto_epoch.h</span><br><span>@@ -66,4 +66,81 @@</span><br>=
<span>                   const uint8_t *context, size_t context_len,</span>=
<br><span>                   uint8_t *out, uint16_t out_len);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Generate a data channel key pair from the e=
poch key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param e=
poch_key     Epoch key to be used</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param key          Destination for the generated data key=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @parm kt        =
     Cipher information to generate the data channel key for</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+epoch_data_key_derive(struct key_parameters *key,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                      const struct =
epoch_key *epoch_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                      const struct key_type *kt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Generates and fills the epoch_data_keys_future with next valid</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * future keys in crypto_optio=
ns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * This assume that the normal key=
_ctx_bi and epoch keys are already setup</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_gene=
rate_future_receive_keys(struct crypto_options *co);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** =
This is called when the peer using a new send key that is not the default</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * key. This function=
 ensures the following:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * - recv key matches the epoch index provided</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * - send key epoch is equal or higher than =
recv_key epoch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param new_epoch th=
e new epoch to use a the receive key</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_replace_=
update_recv_key(struct crypto_options *co,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                              uint16_t new_epoch);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Updates the send key and send_epoch_keyt in cryptio_o=
ptions-&gt;key_ctx_bi to</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * use the next epoch */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch=
_iterate_send_key(struct crypto_options *co);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Frees =
the extra data structures used by epoch keys in \c crypto_options</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+free_epoch_key_ctx(struct crypto_options *co);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Initialises data channel keys and internal structures for epoch d=
ata keys</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * using th=
e provided E0 epoch key</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param e1_=
send    The E1 send epoch key derived by TLS-EKM</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param e1_recv    The E1 receive epoch key =
derived by TLS-EKM</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+epoch_init_key_ctx(struct crypto=
_options *co, const struct key_type *key_type,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                   const struct epoch_key *e1_se=
nd, const struct epoch_key *e1_recv,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                   uint16_t future_key_count);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Using an epoch, this function will try to retrieve a decryption=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * key context that=
 matches that epoch from the \c opt argument</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param opt       crypto_options to use to find =
the decrypt key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param epoch     epoch of the key to lookup</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return          the key context with</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+const struct key_ctx *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+epoch_lookup_decrypt_key(struct crypto_optio=
ns *opt, uint16_t epoch);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Checks if we need to itera=
te the send epoch key. This needs to be in one</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * of the following condition</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  - max epoch counter reached</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - send key aead usage =
limit reached (for AES-GCM and similar ciphers)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  - recv key usage limit reached</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+epoch_check_send_iterate(struct crypto_options *opt);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif /* ifndef CRYPTO_EPOCH_H */</span><br><span>diff --git a/src=
/openvpn/packet_id.c b/src/openvpn/packet_id.c</span><br><span>index 8cde10=
8..177391a 100644</span><br><span>--- a/src/openvpn/packet_id.c</span><br><=
span>+++ b/src/openvpn/packet_id.c</span><br><span>@@ -78,6 +78,21 @@</span=
><br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+packet_id_init_recv(struct packet_id_rec =
*rec, int seq_backtrack, int time_backtrack, const char *name, int unit)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    rec-&gt;name =3D name;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    rec-&gt;unit =3D unit;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (seq_backtrack)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        ASSERT(MIN_SEQ_BACKTRACK &lt;=
=3D seq_backtrack &amp;&amp; seq_backtrack &lt;=3D MAX_SEQ_BACKTRACK);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(MIN_TIME_=
BACKTRACK &lt;=3D time_backtrack &amp;&amp; time_backtrack &lt;=3D MAX_TIME=
_BACKTRACK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 CIRC_LIST_ALLOC(rec-&gt;seq_list, struct seq_list, seq_backtrack);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        rec-&gt;seq_backtra=
ck =3D seq_backtrack;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        rec-&gt;time_backtrack =3D time_backtrack;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    rec-&gt;initialized =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span> packet_id_init(struct packet_id *p, i=
nt seq_backtrack, int time_backtrack, const char *name, int unit)</span><br=
><span> {</span><br><span>     dmsg(D_PID_DEBUG, &quot;PID packet_id_init s=
eq_backtrack=3D%d time_backtrack=3D%d&quot;,</span><br><span>@@ -87,17 +102=
,25 @@</span><br><span>     ASSERT(p);</span><br><span>     CLEAR(*p);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&g=
t;rec.name =3D name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   p-&gt;rec.unit =3D unit;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (seq_backtrack)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        A=
SSERT(MIN_SEQ_BACKTRACK &lt;=3D seq_backtrack &amp;&amp; seq_backtrack &lt;=
=3D MAX_SEQ_BACKTRACK);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ASSERT(MIN_TIME_BACKTRACK &lt;=3D time_backtrack &amp;&amp; time_=
backtrack &lt;=3D MAX_TIME_BACKTRACK);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        CIRC_LIST_ALLOC(p-&gt;rec.seq_list, struct seq_lis=
t, seq_backtrack);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     p-&gt;rec.seq_backtrack =3D seq_backtrack;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        p-&gt;rec.time_backtrack =3D time_backtra=
ck;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;rec.initialized =3D true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init=
_recv(&amp;p-&gt;rec, seq_backtrack, time_backtrack, name, unit);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+packet=
_id_move_recv(struct packet_id_rec *dest, struct packet_id_rec *src)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(src);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ASSERT(dest);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* clear free any old data in rec list */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(dest-&gt;seq_l=
ist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*des=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Copy data to dest */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    *dest =3D *src;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Reinitalise the source */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*src);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init_recv(src, dest-&g=
t;seq_backtrack, dest-&gt;time_backtrack,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        dest-&gt;name, dest-&gt;unit)=
;</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n>diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h</span><br>=
<span>index 79224d2..7620ce5 100644</span><br><span>--- a/src/openvpn/packe=
t_id.h</span><br><span>+++ b/src/openvpn/packet_id.h</span><br><span>@@ -20=
3,6 +203,15 @@</span><br><span> </span><br><span> void packet_id_free(struc=
t packet_id *p);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Move the packet id recv structure from src to dest. src will will</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * be reinitialised with</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dest</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param src</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+packet_id_move_recv(struct packet_id_rec *dest, struct packet_id=
_rec *src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /* should we accept an incoming packet id ? */</span><br><span> b=
ool packet_id_test(struct packet_id_rec *p,</span><br><span>               =
      const struct packet_id_net *pin);</span><br><span>diff --git a/src/op=
envpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index ce1cd9e=
..511127d 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><=
span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -333,8 +333,8 @@</sp=
an><br><span>     interval_t packet_timeout;</span><br><span>     int64_t r=
enegotiate_bytes;</span><br><span>     int64_t renegotiate_packets;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /** This limit for AEAD c=
ipher, this is the sum of packets + blocks</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * that are allowed to be used */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /** This limit for AEAD cipher w=
hen not running in epoch data key mode,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * this is the sum of packets + blocks that are all=
owed to be used */</span><br><span>     int64_t aead_usage_limit;</span><br=
><span>     interval_t renegotiate_seconds;</span><br><span> </span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/o=
penvpn/test_crypto.c</span><br><span>index c8d2a10..54a6caa 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -575,7 +575,7 @@<=
/span><br><span>      0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,</span=
><br><span>      0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uin=
t8_t *label =3D (const uint8_t *)(&quot;unit test&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *label =3D (const u=
int8_t *) (&quot;unit test&quot;);</span><br><span>     uint8_t out[16];</s=
pan><br><span>     ovpn_expand_label(secret, sizeof(secret), label, 9, NULL=
, 0, out, sizeof(out));</span><br><span> </span><br><span>@@ -586,9 +586,23=
8 @@</span><br><span>     assert_memory_equal(out, out_expected, 16);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct epoch_test_state</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct key_type kt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct crypto_options co;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_epoch_setup(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int *num_future_keys =3D =
(int *)*state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct epoch_test_state *data =3D calloc(1, sizeof(struct epoch_test_state))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    data-&gt;gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    init_key_type(&amp;data-&gt;kt, &quot;AES-=
128-GCM&quot;, &quot;none&quot;, true, false);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* have an epoch key that is uses 0x23 for the key for all byte=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct epoc=
h_key epoch1send =3D { .epoch =3D 1, .epoch_key =3D {0x23} };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct epoch_key epoch1recv =
=3D { .epoch =3D 1, .epoch_key =3D {0x27} };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    epoch_init_key_ctx(&amp;data-&gt;co, &amp;data-&gt;kt, &amp;epoch=
1send,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
          &amp;epoch1recv, *num_future_keys);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    *state =3D data;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+crypto_test_epoch_teardown(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct epoch_test_state *data =3D *st=
ate;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_epoch_=
key_ctx(&amp;data-&gt;co);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free_key_ctx_bi(&amp;data-&gt;co.key_ctx_bi);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;data-&gt;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    free(*state);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_=
epoch_key_generation(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct epoch_test_state *data =3D *state;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct crypto_options *co =3D &amp;data-&gt;co;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* check the keys look like expect =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(co-&gt;epoch_data_keys_future[0].epoch, 2);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_data_keys_fut=
ure[15].epoch, 17);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(co-&gt;epoch_key_send.epoch, 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_key_rec=
v.epoch, 17);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Now replace the re=
cv key with the 6th future key (epoch =3D 8) */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    free_key_ctx(&amp;co-&gt;key_ctx_bi.decrypt=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(co-&gt;epoch_data_keys_future[6].epoch, 8);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    co-&gt;key_ctx_bi.decrypt =3D co-&gt;epoch_=
data_keys_future[6];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    CLEAR(co-&gt;epoch_data_keys_future[6]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    epoch_generate_future_receive_keys(co);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_data_keys_=
future[0].epoch, 9);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(co-&gt;epoch_data_keys_future[15].epoch, 24);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_epoch_key_r=
otation(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct epoch=
_test_state *data =3D *state;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct crypto_options *co =3D &amp;data-&gt;co;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* should replace send + key recv */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    epoch_replace_update_recv_k=
ey(co, 9);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;=
key_ctx_bi.decrypt.epoch, 9);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, 9);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt=
;epoch_key_send.epoch, 9);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(co-&gt;epoch_retiring_data_receive_key.epoch, 1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Iterate the data send key fou=
r times to get it to 13 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (int i =3D 0; i &lt; 4; i++)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        epoch_iterate_send_key(co);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, 13);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    epoch_replace_update_recv_key(co, 10)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(co-&gt;key_ctx_bi.decrypt.epoch, 10);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, =
13);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(co-&gt;epoch_key_send.epoch, 13);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_retiring_data_receive=
_key.epoch, 9);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_replace_updat=
e_recv_key(co, 12);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(co-&gt;key_ctx_bi.decrypt.epoch, 12);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_=
bi.encrypt.epoch, 13);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(co-&gt;epoch_key_send.epoch, 13);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_ret=
iring_data_receive_key.epoch, 10);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
epoch_iterate_send_key(co);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, 14);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypt=
o_test_epoch_key_receive_lookup(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct epoch_test_state *data =3D *state;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct crypto_options *co =3D &amp;da=
ta-&gt;co;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* lookup some wacky thi=
ngs that should fail */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_null(epoch_lookup_decrypt_key(co, 2000));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_k=
ey(co, -1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_null(epoch_lookup_decrypt_key(co, 0xefff));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Lookup the edges of the current window */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_=
key(co, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(epoch_lookup_decrypt_key(co, 1)-&gt;epoch, 1);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_=
decrypt_key(co, 2)-&gt;epoch, 2);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, 13)-&gt;epo=
ch, 13);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(epoch_lookup_decrypt_key(co, 14)-&gt;epoch, 14);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt=
_key(co, 15));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Should move 1 to =
retiring key but leave 1-5 undefined, 7 as</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * active and 8-20 as future keys*/</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    epoch_replace_update_recv_ke=
y(co, 7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_=
decrypt_key(co, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(epoch_lookup_decrypt_key(co, 1)-&gt;epoch, 1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_look=
up_decrypt_key(co, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_null(epoch_lookup_decrypt_key(co, 3));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(=
co, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
null(epoch_lookup_decrypt_key(co, 5));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 6));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch=
_lookup_decrypt_key(co, 7)-&gt;epoch, 7);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, 8)-=
&gt;epoch, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(epoch_lookup_decrypt_key(co, 20)-&gt;epoch, 20);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_d=
ecrypt_key(co, 21));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_null(epoch_lookup_decrypt_key(co, 22));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Should move 7 to retiring key and have 8 as active key and</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * 9-21 as future keys */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_replace_updat=
e_recv_key(co, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_null(epoch_lookup_decrypt_key(co, 0));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 1=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(=
epoch_lookup_decrypt_key(co, 2));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 3));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_de=
crypt_key(co, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_null(epoch_lookup_decrypt_key(co, 5));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 6=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(epoch_lookup_decrypt_key(co, 7)-&gt;epoch, 7);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt=
_key(co, 8)-&gt;epoch, 8);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, 20)-&gt;epoch, 20)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(epoch_lookup_decrypt_key(co, 21)-&gt;epoch, 21);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(=
co, 22));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_null(epoch_lookup_decrypt_key(co, 23));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_epoch_key_overflow(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct epoch_test_st=
ate *data =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct crypto_options *co =3D &amp;data-&gt;co;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Modify the receive epoch and keys to have a very high=
 epoch to test</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* the end of array. Iterating through all 16k keys takes a 2-3s, so we</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * avoid this for th=
e unit test */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
o-&gt;key_ctx_bi.decrypt.epoch =3D 16000;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    co-&gt;key_ctx_bi.encrypt.epoch =3D 16000;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    co-&gt;epoch_key_send.epoch =3D 16000;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;epoch_key_r=
ecv.epoch =3D 16000 + co-&gt;epoch_data_keys_future_count;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (uint16_t i =3D 0; i &lt; co-&gt;epoch_data_key=
s_future_count; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co-&g=
t;epoch_data_keys_future[i].epoch =3D 16001 + i;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Move the last few keys until we are close to the limit */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    while (co-&gt;key_ctx_bi.decry=
pt.epoch &lt; (UINT16_MAX - 40))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       epoch_replace_update_recv_key(co, co-&gt;key_ctx_bi.decrypt.epoch + =
10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Looking up this key should still work as =
it will not break the limit</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * when generating keys */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16=
_MAX - 34)-&gt;epoch, UINT16_MAX - 34);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT1=
6_MAX - 33)-&gt;epoch, UINT16_MAX - 33);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* This key is no longer eligible for decrypting as the 32 future key=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * would be la=
rger than uint16_t maximum */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - 32));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch=
_lookup_decrypt_key(co, UINT16_MAX));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Check that moving to the last possible epoch works */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    epoch_replace_update_recv_key(c=
o, UINT16_MAX - 33);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 33)-&gt;epo=
ch, UINT16_MAX - 33);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - 32));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_=
decrypt_key(co, UINT16_MAX));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+epoch_test_derive_data_key(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct epoch_key e17 =3D { .epoch =
=3D 17, .epoch_key =3D { 19, 12 }};</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct key_type kt =3D { 0 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct key_parameters key_parameters =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_=
type(&amp;kt, &quot;AES-192-GCM&quot;, &quot;none&quot;, true, false);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    epoch_data_key_derive(&amp;key_parameters, &amp;e17, &am=
p;kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(key_paramet=
ers.cipher_size, 24);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(key_parameters.hmac_size, 12);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint8_t exp_cipherkey[24] =3D</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {0x00, 0x62, 0x84, 0xcb, 0x31, 0x57, 0xc7,=
 0x97,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x8d, 0x=
e8, 0xfb, 0x6e, 0xdc, 0x60, 0x38, 0xc3,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     0xa4, 0xb9, 0xa1, 0xea, 0xf4, 0x01, 0x86, 0xbc };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint8_t exp_impl_iv[12] =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    { 0xb4, 0x32, 0xeb, 0x4=
e, 0x61, 0x4b, 0xa2, 0xf3,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      0x5d, 0x86, 0x22, 0x1f  };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_memory_equal(key_parameters.cipher, exp_cipherkey, sizeof(exp_c=
ipherkey));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_memory_equal(key_parameters.hmac, exp_impl_iv, sizeof(exp_impl_iv));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> ma=
in(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int prestate_num13 =3D 13;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int prestate_num16 =3D 16;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int prestate_num32 =3D 32;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     openvpn_unit=
_test_setup();</span><br><span>     const struct CMUnitTest tests[] =3D {</=
span><br><span>         cmocka_unit_test(crypto_pem_encode_decode_loopback)=
,</span><br><span>@@ -602,6 +831,23 @@</span><br><span>         cmocka_unit=
_test(crypto_test_hkdf_expand_testa2),</span><br><span>         cmocka_unit=
_test(crypto_test_hkdf_expand_testa3),</span><br><span>         cmocka_unit=
_test(crypto_test_ovpn_label_expand),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test_prestate_setup_teardown(crypto_t=
est_epoch_key_generation,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                                 crypto_test_epoch_se=
tup,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                                  crypto_test_epoch_teardown,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
                &amp;prestate_num16),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test_prestate_setup_teardown(crypto_t=
est_epoch_key_rotation,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                                 crypto_test_epoch_setu=
p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                                crypto_test_epoch_teardown,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
              &amp;prestate_num13),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test_prestate_setup_teardown(crypto_tes=
t_epoch_key_receive_lookup,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                                 crypto_test_epoch_=
setup,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                    crypto_test_epoch_teardown,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                  &amp;prestate_num13),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test_prestate_setup_teardown(crypto=
_test_epoch_key_overflow,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                                 crypto_test_epoch_se=
tup,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                                  crypto_test_epoch_teardown,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
                &amp;prestate_num32),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(epoch_test_derive_data_key)</spa=
n><br><span>     };</span><br><span> </span><br><span> #if defined(ENABLE_C=
RYPTO_OPENSSL)</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail">change 804</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/804?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc=
62175820e9b80 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 804 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--kHM2chMGwOM=--

