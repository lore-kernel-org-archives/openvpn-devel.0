From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Jan 2025 07:14:15 +0000
In-Reply-To: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
References: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <a857f1d9913bc4c5f80148c7312e1ea7f0c23e49-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m5YlBRruRXA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--m5YlBRruRXA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#13) to the change originally created b=
y plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


Change subject: Implement methods to generate and manage OpenVPN Epoch keys
......................................................................

Implement methods to generate and manage OpenVPN Epoch keys

This implements functions that allow these keys to be generated and
managed. It does not yet implement using them for the data channel.

Change-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250109180537.27686-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
390.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/crypto_epoch.c
M src/openvpn/crypto_epoch.h
M src/openvpn/packet_id.c
M src/openvpn/packet_id.h
M src/openvpn/ssl_common.h
M tests/unit_tests/openvpn/test_crypto.c
8 files changed, 806 insertions(+), 22 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/804/13

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ee9b0c6..b107f88 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -916,14 +916,27 @@
     if (cipher_ctx_mode_aead(ctx->cipher))
     {
         size_t impl_iv_len =3D 0;
+        size_t impl_iv_offset =3D 0;
         ASSERT(cipher_ctx_iv_length(ctx->cipher) >=3D OPENVPN_AEAD_MIN_IV_=
LEN);
-        impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_=
id_type);
-        ASSERT(impl_iv_len + sizeof(packet_id_type) <=3D OPENVPN_MAX_IV_LE=
NGTH);
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
+        ASSERT(impl_iv_offset + impl_iv_len <=3D OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <=3D MAX_HMAC_KEY_LENGTH);
         ASSERT(impl_iv_len <=3D key->hmac_size);
         CLEAR(ctx->implicit_iv);
-        /* The first bytes of the IV are filled with the packet id */
-        memcpy(ctx->implicit_iv + sizeof(packet_id_type), key->hmac, impl_=
iv_len);
+        memcpy(ctx->implicit_iv + impl_iv_offset, key->hmac, impl_iv_len);
     }
 }

@@ -972,6 +985,7 @@
              hmac_ctx_size(ctx->hmac));

     }
+    ctx->epoch =3D key->epoch;
     gc_free(&gc);
 }

@@ -984,6 +998,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
+    ctx->epoch =3D key_params->epoch;
 }

 void
@@ -995,6 +1010,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
+    ctx->epoch =3D key_params->epoch;
 }

 void
@@ -1032,6 +1048,7 @@
     }
     CLEAR(ctx->implicit_iv);
     ctx->plaintext_blocks =3D 0;
+    ctx->epoch =3D 0;
 }

 void
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index fe81c7f..a98dca0 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -171,6 +171,11 @@

     /** Number of bytes set in the HMac key material */
     int hmac_size;
+
+    /** the epoch of the key. Only defined/non zero if key parameters
+     * represent a data channel epoch key parameters.
+     * Other uses of this struct leave this zero. */
+    uint16_t epoch;
 };

 /**
@@ -183,6 +188,11 @@
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
@@ -211,6 +221,10 @@
     uint64_t plaintext_blocks;
     /** number of failed verification using this cipher */
     uint64_t failed_verifications;
+    /** OpenVPN data channel epoch, this variable holds the
+     *  epoch number this key belongs to. Note that epoch 0 is not used
+     *  and epoch is always non-zero for epoch key contexts */
+    uint16_t epoch;
 };

 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -280,6 +294,39 @@
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
+    /** The limit for AEAD cipher, this is the sum of packets + blocks
+     * that are allowed to be used. Will switch to a new epoch if this
+     * limit is reached*/
+    uint64_t aead_usage_limit;
+
+    /** Keeps the future epoch data keys for decryption. The current one
+     * that is expected to be used is stored in key_ctx_bi.
+     *
+     * for encryption keys this is not needed as we only need the current
+     * and move to another key by iteration and we never need to go back
+     * to an older key.
+     */
+    struct key_ctx *epoch_data_keys_future;
+
+    /** number of keys stored in \c epoch_data_keys_future */
+    uint16_t epoch_data_keys_future_count;
+
+    /** The old key before the sender switched to a new epoch data key */
+    struct key_ctx epoch_retiring_data_receive_key;
+    struct packet_id_rec epoch_retiring_key_pid_recv;
+
     struct packet_id packet_id; /**< Current packet ID state for both
                                  *   sending and receiving directions.
                                  *
@@ -288,7 +335,7 @@
                                  *
                                  *   The packet id also used as the IV
                                  *   for AEAD/OFB/CFG ciphers.
-                                 *   */
+                                 */
     struct packet_id_persist *pid_persist;
     /**< Persistent packet ID state for
      *   keeping state between successive
@@ -482,7 +529,8 @@
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
index 667e12a6..67bc910 100644
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

@@ -112,3 +118,346 @@
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
+    /* length of the array without extra \0 byte from the string */
+    const size_t epoch_update_label_len =3D sizeof(epoch_update_label) - 1;
+
+    /* E_N+1 =3D OVPN-Expand-Label(E_N, "datakey upd", "", 32) */
+    ovpn_expand_label(epoch_key->epoch_key, sizeof(epoch_key->epoch_key),
+                      epoch_update_label, epoch_update_label_len,
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
+    /* length of the array without extra \0 byte from the string */
+    const size_t epoch_data_key_label_len =3D sizeof(epoch_data_key_label)=
 - 1;
+
+    ovpn_expand_label(epoch_key->epoch_key, sizeof(epoch_key->epoch_key),
+                      epoch_data_key_label, epoch_data_key_label_len,
+                      NULL, 0,
+                      (uint8_t *)(&key->cipher), key->cipher_size);
+
+    const uint8_t epoch_data_iv_label[] =3D "data_iv";
+    /* length of the array without extra \0 byte from the string */
+    const size_t epoch_data_iv_label_len =3D sizeof(epoch_data_iv_label) -=
 1;
+
+    ovpn_expand_label(epoch_key->epoch_key, sizeof(epoch_key->epoch_key),
+                      epoch_data_iv_label, epoch_data_iv_label_len,
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
+    /* We want the future receive keys to start just after the epoch of
+     * the currently used decryption key. */
+    ASSERT(co->key_ctx_bi.initialized);
+    uint16_t current_decrypt_epoch =3D co->key_ctx_bi.decrypt.epoch;
+
+    /* Either we have not generated any future keys yet (first initialisat=
ion)
+     * or the last index is the same as our current epoch key
+     * (last generated receive epoch key should match the epoch key) */
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
+            && co->epoch_data_keys_future[i].epoch < current_decrypt_epoch)
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
+    uint16_t desired_highest_key =3D current_decrypt_epoch + co->epoch_dat=
a_keys_future_count;
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
+struct key_ctx *
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
+         *    In particular, in two-party communication, one participant c=
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
+         *
+         * Also try to push the sender to use a new key if we are the
+         * decryption fail warn limit.
+         * */
+        else if (opt->key_ctx_bi.encrypt.epoch =3D=3D opt->key_ctx_bi.decr=
ypt.epoch
+                 && (aead_usage_limit_reached(opt->aead_usage_limit,
+                                              &opt->key_ctx_bi.decrypt,
+                                              opt->packet_id.rec.id)
+                     || cipher_decrypt_verify_fail_warn(&opt->key_ctx_bi.d=
ecrypt)
+                     ))
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
index e5d0e5d..b2f3d86 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -67,4 +67,94 @@
                   const uint8_t *context, size_t context_len,
                   uint8_t *out, uint16_t out_len);

-#endif
+/**
+ * Generate a data channel key pair from the epoch key
+ * @param key           Destination for the generated data key
+ * @param epoch_key     Epoch key to be used
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
+ * future keys in crypto_options using the epoch of the key in
+ * crypto_options.key_ctx_bi.decrypt as starting point
+ *
+ * This assume that the normal key_ctx_bi and epoch keys have been already
+ * setup.
+ *
+ * This method is also called if crypto_options.key_ctx_bi.decrypt is chan=
ged.
+ * The method will then change the future keys in epoch_data_keys_future to
+ * free the ones that are older than the crypto_options.key_ctx_bi.decrypt=
 and
+ * generate the keys from the newer epoch.
+ */
+void
+epoch_generate_future_receive_keys(struct crypto_options *co);
+
+
+/** This is called when the peer uses a new send key that is not the defau=
lt
+ * key. This function ensures the following:
+ * - recv key matches the epoch index provided
+ * - send key epoch is equal or higher than recv_key epoch
+ *
+ * @param new_epoch the new epoch to use for the receive key
+ */
+void
+epoch_replace_update_recv_key(struct crypto_options *co,
+                              uint16_t new_epoch);
+
+/**
+ * Updates the send key and send_epoch_key in cryptio_options->key_ctx_bi =
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
+ * @param co                The crypto option struct to initialise the epo=
ch
+ *                          related fields
+ * @param key_type          The parameter of what encryption cipher to use=
 when
+ *                          initialising the epoch related fields
+ * @param e1_send           The E1 send epoch key derived by TLS-EKM
+ * @param e1_recv           The E1 receive epoch key derived by TLS-EKM
+ * @param future_key_count  the number of future epoch keys that should be
+ *                          considered valid when receiving data from the =
peer
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
+struct key_ctx *
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
index 0806e99..149dda2 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -77,6 +77,21 @@
 #endif
 }

+static void
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
 void
 packet_id_init(struct packet_id *p, int seq_backtrack, int time_backtrack,=
 const char *name, int unit)
 {
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
index c05ac9a..07e92ff 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -206,6 +206,13 @@

 void packet_id_free(struct packet_id *p);

+/**
+ * Move the packet id recv structure from \c src to \c dest. \c src will
+ * be reinitialised. \c dest will be freed before the move.
+ */
+void
+packet_id_move_recv(struct packet_id_rec *dest, struct packet_id_rec *src);
+
 /* should we accept an incoming packet id ? */
 bool packet_id_test(struct packet_id_rec *p,
                     const struct packet_id_net *pin);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e697d68..e092472 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -334,8 +334,8 @@
     interval_t packet_timeout;
     int64_t renegotiate_bytes;
     int64_t renegotiate_packets;
-    /** limit for AEAD cipher, this is the sum of packets + blocks
-     * that are allowed to be used */
+    /** limit for AEAD cipher when not running in epoch data key mode,
+     *  this is the sum of packets + blocks that are allowed to be used */
     uint64_t aead_usage_limit;
     interval_t renegotiate_seconds;

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index e16296b..3d9c99c 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -613,7 +613,7 @@
      0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
      0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};

-    const uint8_t *label =3D (const uint8_t *)("unit test");
+    const uint8_t *label =3D (const uint8_t *) ("unit test");
     uint8_t out[16];
     ovpn_expand_label(secret, sizeof(secret), label, 9, NULL, 0, out, size=
of(out));

@@ -708,9 +708,242 @@
 }
 #endif /* if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=
=3D 0x30000000L */

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
+    /* have an epoch key that uses 0x23 for the key for all bytes */
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
+    assert_int_equal(co->epoch_retiring_data_receive_key.epoch, 0);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 1)->epoch, 1);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 2)->epoch, 2);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 13)->epoch, 13);
+    assert_int_equal(epoch_lookup_decrypt_key(co, 14)->epoch, 14);
+    assert_null(epoch_lookup_decrypt_key(co, 15));
+
+    /* Should move 1 to retiring key but leave 2-6 undefined, 7 as
+     * active and 8-20 as future keys*/
+    epoch_replace_update_recv_key(co, 7);
+
+    assert_null(epoch_lookup_decrypt_key(co, 0));
+    assert_int_equal(epoch_lookup_decrypt_key(co, 1)->epoch, 1);
+    assert_ptr_equal(epoch_lookup_decrypt_key(co, 1), &co->epoch_retiring_=
data_receive_key);
+
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
+    assert_ptr_equal(epoch_lookup_decrypt_key(co, 7), &co->epoch_retiring_=
data_receive_key);
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
+    assert_int_equal(co->epoch_data_keys_future_count, 32);
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - co->epoch_data_k=
eys_future_count));
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
+    {0xed, 0x85, 0x33, 0xdb, 0x1c, 0x28, 0xac, 0xe4,
+     0x18, 0xe9, 0x00, 0x6a, 0xb2, 0x9c, 0x17, 0x41,
+     0x7d, 0x60, 0xeb, 0xe6, 0xcd, 0x90, 0xbf, 0x0a};
+
+    uint8_t exp_impl_iv[12] =3D
+    {0x86, 0x89, 0x0a, 0xab, 0xf0, 0x32, 0xcb, 0x59, 0xf4, 0xcf, 0xa3, 0x4=
e};
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
@@ -725,7 +958,24 @@
         cmocka_unit_test(crypto_test_hkdf_expand_testa3),
         cmocka_unit_test(crypto_test_hkdf_expand_test_ovpn),
         cmocka_unit_test(crypto_test_ovpn_label_expand),
-        cmocka_unit_test(crypto_test_ovpn_expand_openssl3)
+        cmocka_unit_test(crypto_test_ovpn_expand_openssl3),
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
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--m5YlBRruRXA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #13</strong> to the change originally c=
reated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/804?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Implement methods to generate and manage OpenVPN Epoc=
h keys<br><br>This implements functions that allow these keys to be generat=
ed and<br>managed. It does not yet implement using them for the data channe=
l.<br><br>Change-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80<br>Signed-of=
f-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: MaxF &lt;max@...2854...=
6...&gt;<br>Message-Id: &lt;20250109180537.27686-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg303=
90.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/crypto_epoc=
h.c<br>M src/openvpn/crypto_epoch.h<br>M src/openvpn/packet_id.c<br>M src/o=
penvpn/packet_id.h<br>M src/openvpn/ssl_common.h<br>M tests/unit_tests/open=
vpn/test_crypto.c<br>8 files changed, 806 insertions(+), 22 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/804=
/13</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span>=
<br><span>index ee9b0c6..b107f88 100644</span><br><span>--- a/src/openvpn/c=
rypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -916,=
14 +916,27 @@</span><br><span>     if (cipher_ctx_mode_aead(ctx-&gt;cipher)=
)</span><br><span>     {</span><br><span>         size_t impl_iv_len =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t impl=
_iv_offset =3D 0;</span><br><span>         ASSERT(cipher_ctx_iv_length(ctx-=
&gt;cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        impl_iv_len =3D cipher_ctx_iv_length(ctx-&g=
t;cipher) - sizeof(packet_id_type);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        ASSERT(impl_iv_len + sizeof(packet_id_type) &lt;=3D O=
PENVPN_MAX_IV_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Epoch=
 keys use XOR of full IV length with the packet id to generate</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * IVs. Old data format =
uses concatenation instead (XOR with 0 for the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * first 4 bytes (sizeof(packet_id_type)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (key-=
&gt;epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            impl_iv=
_len =3D cipher_ctx_iv_length(ctx-&gt;cipher);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            impl_iv_offset =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;ciph=
er) - sizeof(packet_id_type);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            impl_iv_offset =3D sizeof(packet_id_type);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ASSERT(impl_iv_offset + impl_iv_=
len &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>         ASSERT(impl_iv=
_len &lt;=3D MAX_HMAC_KEY_LENGTH);</span><br><span>         ASSERT(impl_iv_=
len &lt;=3D key-&gt;hmac_size);</span><br><span>         CLEAR(ctx-&gt;impl=
icit_iv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* T=
he first bytes of the IV are filled with the packet id */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        memcpy(ctx-&gt;implicit_iv + si=
zeof(packet_id_type), key-&gt;hmac, impl_iv_len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        memcpy(ctx-&gt;implicit_iv + impl_iv_=
offset, key-&gt;hmac, impl_iv_len);</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span>@@ -972,6 +985,7 @@</span><br><span>  =
            hmac_ctx_size(ctx-&gt;hmac));</span><br><span> </span><br><span=
>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;=
epoch =3D key-&gt;epoch;</span><br><span>     gc_free(&amp;gc);</span><br><=
span> }</span><br><span> </span><br><span>@@ -984,6 +998,7 @@</span><br><sp=
an>     snprintf(log_prefix, sizeof(log_prefix), &quot;Outgoing %s&quot;, n=
ame);</span><br><span>     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_ENC=
RYPT, log_prefix);</span><br><span>     key_ctx_update_implicit_iv(ctx, key=
_params);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&g=
t;epoch =3D key_params-&gt;epoch;</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span>@@ -995,6 +1010,7 @@</span><br><span>    =
 snprintf(log_prefix, sizeof(log_prefix), &quot;Incoming %s&quot;, name);</=
span><br><span>     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, l=
og_prefix);</span><br><span>     key_ctx_update_implicit_iv(ctx, key_params=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;epoch=
 =3D key_params-&gt;epoch;</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span>@@ -1032,6 +1048,7 @@</span><br><span>     }</sp=
an><br><span>     CLEAR(ctx-&gt;implicit_iv);</span><br><span>     ctx-&gt;=
plaintext_blocks =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ctx-&gt;epoch =3D 0;</span><br><span> }</span><br><span> </span><br=
><span> void</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvp=
n/crypto.h</span><br><span>index fe81c7f..a98dca0 100644</span><br><span>--=
- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><=
br><span>@@ -171,6 +171,11 @@</span><br><span> </span><br><span>     /** Nu=
mber of bytes set in the HMac key material */</span><br><span>     int hmac=
_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /** the epoch of the key. On=
ly defined/non zero if key parameters</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * represent a data channel epoch key parameters.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Other uses of th=
is struct leave this zero. */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint16_t epoch;</span><br><span> };</span><br><span> </span><=
br><span> /**</span><br><span>@@ -183,6 +188,11 @@</span><br><span> void</s=
pan><br><span> key_parameters_from_key(struct key_parameters *key_params, c=
onst struct key *key);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+struct epoch_key {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint8_t epoch_key[SHA256_DIGEST_LENGTH];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t epoch;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Conta=
iner for one set of cipher and/or HMAC contexts.</span><br><span>  * @ingro=
up control_processor</span><br><span>@@ -211,6 +221,10 @@</span><br><span> =
    uint64_t plaintext_blocks;</span><br><span>     /** number of failed ve=
rification using this cipher */</span><br><span>     uint64_t failed_verifi=
cations;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Ope=
nVPN data channel epoch, this variable holds the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     *  epoch number this key belongs to. Note=
 that epoch 0 is not used</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     *  and epoch is always non-zero for epoch key contexts */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t epoch;</span>=
<br><span> };</span><br><span> </span><br><span> #define KEY_DIRECTION_BIDI=
RECTIONAL 0 /* same keys for both directions */</span><br><span>@@ -280,6 +=
294,39 @@</span><br><span>     /**&lt; OpenSSL cipher and HMAC contexts for=
</span><br><span>      *   both sending and receiving</span><br><span>     =
 *   directions. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** last epoch_=
key used for generation of the current send data keys.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * As invariant, the epoch of epoch_=
key_send is always kept &gt;=3D the epoch of</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * epoch_key_recv */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct epoch_key epoch_key_send;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /** epoch_key used for the highest receive =
epoch keys */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct epoch_key epoch_key_recv;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** =
the key_type that is used to generate the epoch keys */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct key_type epoch_key_type;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** The limit for AEAD cipher, this i=
s the sum of packets + blocks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * that are allowed to be used. Will switch to a new epoch if=
 this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * limit i=
s reached*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
64_t aead_usage_limit;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Keeps th=
e future epoch data keys for decryption. The current one</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * that is expected to be used is =
stored in key_ctx_bi.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * for =
encryption keys this is not needed as we only need the current</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * and move to another key b=
y iteration and we never need to go back</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * to an older key.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct key_ctx *epoch_data_keys_future;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /** number of keys stored in \c epoch_data_keys_futur=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t ep=
och_data_keys_future_count;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The=
 old key before the sender switched to a new epoch data key */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct key_ctx epoch_retirin=
g_data_receive_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct packet_id_rec epoch_retiring_key_pid_recv;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct packet_id pa=
cket_id; /**&lt; Current packet ID state for both</span><br><span>         =
                         *   sending and receiving directions.</span><br><s=
pan>                                  *</span><br><span>@@ -288,7 +335,7 @@=
</span><br><span>                                  *</span><br><span>      =
                            *   The packet id also used as the IV</span><br=
><span>                                  *   for AEAD/OFB/CFG ciphers.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
       *   */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                           */</span><br><span>     struct packet_id_persist=
 *pid_persist;</span><br><span>     /**&lt; Persistent packet ID state for<=
/span><br><span>      *   keeping state between successive</span><br><span>=
@@ -482,7 +529,8 @@</span><br><span>  * @return true if packet ID is valida=
ted to be not a replay, false otherwise.</span><br><span>  */</span><br><sp=
an> bool crypto_check_replay(struct crypto_options *opt,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                         const struct pa=
cket_id_net *pin, const char *error_prefix,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                         const struct packet_id_net=
 *pin,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
            const char *error_prefix,</span><br><span>                     =
     struct gc_arena *gc);</span><br><span> </span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c</s=
pan><br><span>index 667e12a6..67bc910 100644</span><br><span>--- a/src/open=
vpn/crypto_epoch.c</span><br><span>+++ b/src/openvpn/crypto_epoch.c</span><=
br><span>@@ -29,7 +29,13 @@</span><br><span> #endif</span><br><span> </span=
><br><span> #include &lt;inttypes.h&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;crypto_b=
ackend.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;packet_id.h&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;crypto.h&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;crypto_epoch.h&quot;</span><br><span> #inc=
lude &quot;buffer.h&quot;</span><br><span> #include &quot;integer.h&quot;</=
span><br><span> </span><br><span>@@ -112,3 +118,346 @@</span><br><span>    =
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
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* length =
of the array without extra \0 byte from the string */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const size_t epoch_update_label_len =
=3D sizeof(epoch_update_label) - 1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* E_N+1 =3D OVPN-Expand-Label(E_N, &quot;datakey upd&quot;, &quot;&quot;,=
 32) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ovpn_exp=
and_label(epoch_key-&gt;epoch_key, sizeof(epoch_key-&gt;epoch_key),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      epoch=
_update_label, epoch_update_label_len,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                      NULL, 0,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                      new_epoch_key.epoch_key=
, sizeof(new_epoch_key.epoch_key));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    *epoch_key =3D new_epoch_key;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_data_key_derive(=
struct key_parameters *key,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                      const struct epoch_key *epoch_key,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                      const st=
ruct key_type *kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key-&gt;hmac_si=
ze =3D cipher_kt_iv_size(kt-&gt;cipher);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    key-&gt;cipher_size =3D cipher_kt_key_size(kt-&gt;=
cipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Generate data key from =
epoch key:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * K_=
i =3D OVPN-Expand-Label(E_i, &quot;data_key&quot;, &quot;&quot;, key_size)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * implicit_iv =
=3D OVPN-Expand-Label(E_i, &quot;data_iv&quot;, &quot;&quot;, implicit_iv_l=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const uint8_t epoch_data_key_label[] =3D &q=
uot;data_key&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* length of the array without extra \0 byte from the string */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t epoch_data=
_key_label_len =3D sizeof(epoch_data_key_label) - 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ovpn_expand_label(epoch_key-&gt;epoch_key, sizeof(epoch_=
key-&gt;epoch_key),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                      epoch_data_key_label, epoch_data_key_label_len,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                      NUL=
L, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
        (uint8_t *)(&amp;key-&gt;cipher), key-&gt;cipher_size);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const uint8_t epoch_data_iv_label[] =3D &quot;=
data_iv&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* length of the array without extra \0 byte from the string */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const size_t epoch_data_iv_l=
abel_len =3D sizeof(epoch_data_iv_label) - 1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ovpn_expand_label(epoch_key-&gt;epoch_key, sizeof(epoch_key-&gt;=
epoch_key),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
              epoch_data_iv_label, epoch_data_iv_label_len,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                      NULL, 0,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                      (u=
int8_t *)(&amp;key-&gt;hmac), key-&gt;hmac_size);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    key-&gt;epoch =3D epoch_key-&gt;epoch;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+epoch_init_send_key_ctx(struct crypto_options *co)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Ensure that we are NEVER regenerating the same =
key that has already</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * been generated. Since we also reset the packet ID counter this woul=
d be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * catastro=
phic as we would do IV reuse which breaks ciphers like AES-GCM */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;key_ctx_bi.=
encrypt.epoch !=3D co-&gt;epoch_key_send.epoch);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char name[32] =3D { 0 };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    snprintf(name, sizeof(name), &quo=
t;Epoch Data key %&quot; PRIu16, co-&gt;epoch_key_send.epoch);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct key_parameters send_key =3D { 0 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    epoch_data_key_derive(&amp;send_key, &am=
p;co-&gt;epoch_key_send, &amp;co-&gt;epoch_key_type);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    init_key_bi_ctx_send(&amp;co-&gt;key_ctx_bi.encrypt, &am=
p;send_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                 &amp;co-&gt;epoch_key_type, name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;co-&gt;pack=
et_id.send);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLE=
AR(send_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+epoch_init_recv_key(struct key_ctx *ctx, struct crypto_options *co)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct key_parameters recv_key =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_da=
ta_key_derive(&amp;recv_key, &amp;co-&gt;epoch_key_recv, &amp;co-&gt;epoch_=
key_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char name[32];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    snprintf(name, sizeof(name), &quot;Epoch Dat=
a key %&quot; PRIu16, co-&gt;epoch_key_recv.epoch);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    init_key_bi_ctx_recv(ctx, &amp;recv_key, &amp;co-&gt;epo=
ch_key_type, name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    CLEAR(recv_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+epoch_generate_future_receive_keys(struct crypto_op=
tions *co)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We want the future r=
eceive keys to start just after the epoch of</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * the currently used decryption key. */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;key_ctx=
_bi.initialized);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint16_t current_decrypt_epoch =3D co-&gt;key_ctx_bi.decrypt.epoch;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Either we have not generated any futu=
re keys yet (first initialisation)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * or the last index is the same as our current epoch ke=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (last gener=
ated receive epoch key should match the epoch key) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct key_ctx *highest_future_key =
=3D &amp;co-&gt;epoch_data_keys_future[co-&gt;epoch_data_keys_future_count =
- 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;epoch_key_recv.=
epoch =3D=3D 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
      || highest_future_key-&gt;epoch =3D=3D co-&gt;epoch_key_recv.epoch);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* free the keys that are not used =
anymore */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
uint16_t i =3D 0; i &lt; co-&gt;epoch_data_keys_future_count; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Keys in future keys are always=
 epoch &gt; 1 if initialised */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (co-&gt;epoch_data_keys_future[i].epoch &gt; 0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; co=
-&gt;epoch_data_keys_future[i].epoch &lt; current_decrypt_epoch)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            /* Key is old, free it */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            free_key_c=
tx(&amp;co-&gt;epoch_data_keys_future[i]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Calculate the=
 number of keys that need to be generated,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * if no keys have been generated assume only th=
e first key is defined */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint16_t current_highest_key =3D highest_future_key-&gt;epoch ? h=
ighest_future_key-&gt;epoch : 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uint16_t desired_highest_key =3D current_decrypt_epoch + c=
o-&gt;epoch_data_keys_future_count;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint16_t num_keys_generate =3D desired_highest_key - cu=
rrent_highest_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Move the old keys out of the way=
 so the order of keys stays strictly</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * monotonic and consecutive. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* first check that the destination w=
e are going to overwrite is freed */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (uint16_t i =3D 0; i &lt; num_keys_generate; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(co-&gt;epoch_data_k=
eys_future[i].epoch =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 memmove(co-&gt;epoch_data_keys_future,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            co-&gt;epoch_data_keys_future + num_keys_ge=
nerate,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
(co-&gt;epoch_data_keys_future_count - num_keys_generate) * sizeof(struct k=
ey_ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Clear and regenerate t=
he array elements at the end */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    for (uint16_t i =3D co-&gt;epoch_data_keys_future_count - n=
um_keys_generate; i &lt; co-&gt;epoch_data_keys_future_count; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        CLEAR(co-&gt;epoch_data_keys_futu=
re[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        epoc=
h_key_iterate(&amp;co-&gt;epoch_key_recv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        epoch_init_recv_key(&amp;co-&gt;epoch_data_keys_future[i], co);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Assert that all keys are initialised */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uint16_t i =3D 0=
; i &lt; co-&gt;epoch_data_keys_future_count; i++)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ASSERT(co-&gt;epoch_data_keys_future[i].epoch &gt;=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_=
iterate_send_key(struct crypto_options *co)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(co-&gt;epoch_key_send.epoch &lt; UINT16_MAX);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    epoch_key_iterate(&amp;co-&g=
t;epoch_key_send);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   free_key_ctx(&amp;co-&gt;key_ctx_bi.encrypt);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    epoch_init_send_key_ctx(co);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_repl=
ace_update_recv_key(struct crypto_options *co,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                              uint16_t new_epoch=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Find the key of the new epoch=
 in future keys */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t fki;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (fki =3D 0; fki &lt; co-&gt;epoch_data_keys_future_count; fki++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (co-&gt;epoch_data_keys_futu=
re[fki].epoch =3D=3D new_epoch)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we should only e=
ver be called when we successfully decrypted/authenticated</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * a packet from a peer, ie the =
epoch recv key *MUST* be in that</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * array */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ASSERT(fki &lt; co-&gt;epoch_data_keys_future_count);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;epoch_data=
_keys_future[fki].epoch =3D=3D new_epoch);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct key_ctx *new_ctx =3D &amp;co-&gt;epoch_data_keys_future[fki]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Check if the new recv key epoc=
h is higher than the send key epoch. If</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * yes we will replace the send key as well */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (co-&gt;key_ctx_b=
i.encrypt.epoch &lt; new_epoch)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      free_key_ctx(&amp;co-&gt;key_ctx_bi.encrypt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* Update the epoch_key for send to match the curren=
t key being used.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * This is a bit of extra work but since we are a maximum of 16</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * keys behind, a=
 maximum 16 HMAC invocations are a small price to</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * pay for not keeping all the old ep=
och keys around in future_keys</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * array */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        while (co-&gt;epoch_key_send.epoch &lt; new_epoch)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            epoch_key_iterate(&amp;=
co-&gt;epoch_key_send);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  epoch_init_send_key_ctx(co);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Replace receive=
 key */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key=
_ctx(&amp;co-&gt;epoch_retiring_data_receive_key);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    co-&gt;epoch_retiring_data_receive_key =
=3D co-&gt;key_ctx_bi.decrypt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    packet_id_move_recv(&amp;co-&gt;epoch_retiring_key_pid_recv,=
 &amp;co-&gt;packet_id.rec);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt=
;key_ctx_bi.decrypt =3D *new_ctx;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Zero the old location instead to of free_key_ctx since we moved the keys<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and do not wa=
nt to free the pointers in the old place */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    memset(new_ctx, 0, sizeof(struct key_ctx));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Generate new future keys */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_generate_future_=
receive_keys(co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+free_epoch_key_ctx(struct crypto_options *co)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (uint16_t i =3D 0; i &lt; co-&gt;epoch=
_data_keys_future_count; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    free_key_ctx(&amp;co-&gt;epoch_data_keys_future[i]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    free(co-&gt;epoch_data_keys_future);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free_key_ctx(&amp;co-&gt;epoch_retiring_data_r=
eceive_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fre=
e(co-&gt;epoch_retiring_key_pid_recv.seq_list);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    CLEAR(co-&gt;epoch_key_recv);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(co-&gt;epoch_key_send);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+epoch_init_key_ctx(struct crypto_options *co, const struct key_type *ke=
y_type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       const struct epoch_key *e1_send,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                   const struct epoch_key *e1_recv,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                   uint=
16_t future_key_count)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(e1_s=
end-&gt;epoch =3D=3D 1 &amp;&amp; e1_recv-&gt;epoch =3D=3D 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;epoch_key_recv =3D *e=
1_recv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;e=
poch_key_send =3D *e1_send;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;=
epoch_key_type =3D *key_type;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    co-&gt;aead_usage_limit =3D cipher_get_aead_limits(key_type-&=
gt;cipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_init_send_key_ctx=
(co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_init=
_recv_key(&amp;co-&gt;key_ctx_bi.decrypt, co);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    co-&gt;key_ctx_bi.initialized =3D true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    co-&gt;epoch_data_keys_future_count =
=3D future_key_count;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ALLOC_ARRAY_CLEAR(co-&gt;epoch_data_keys_future, struct key_ctx, co-&=
gt;epoch_data_keys_future_count);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    epoch_generate_future_receive_keys(co);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct key_ctx *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ep=
och_lookup_decrypt_key(struct crypto_options *opt, uint16_t epoch)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Current decrypt key is the most likely =
one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&=
gt;key_ctx_bi.decrypt.epoch =3D=3D epoch)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return &amp;opt-&gt;key_ctx_bi.decrypt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (opt-&gt;epoch_retiring_data_receive_key.=
epoch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             &=
amp;&amp; opt-&gt;epoch_retiring_data_receive_key.epoch =3D=3D epoch)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return &amp;opt-&gt;epoch_retir=
ing_data_receive_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(epoch &gt; opt-&gt;key_ctx_bi.decrypt.epoch</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             &amp;&amp; epoch &lt;=3D opt-&gt;key_=
ctx_bi.decrypt.epoch + opt-&gt;epoch_data_keys_future_count)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* Key in the range of future keys */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        int index =3D =
epoch - (opt-&gt;key_ctx_bi.decrypt.epoch + 1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* If we have reached the edge of the valid keys we do not=
 return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * t=
he key anymore since regenerating the new keys would move us</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * over the window of vali=
d keys and would need all kind of</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * special casing, so we stop returning the key in th=
is case */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (epoch &gt; (UINT16_MAX - opt-&gt;epoch_data_keys_future_count - 1))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return &amp;opt-&gt;epoch_data_keys_future[i=
ndex];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+epoch_check_send_iterate(struct crypto_options *opt)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (opt-&gt;epoch_key_send.epoch =3D=3D UINT16_MAX)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* limit of epoch keys rea=
ched, cannot move to a newer key anymore */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (opt-&gt;aead_usage_limit)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (aead_usage_limit_reached(opt-&gt;aead_usage_limit, &amp;o=
pt-&gt;key_ctx_bi.encrypt,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                     opt-&gt;packet_id.send.id))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* Send key limit rea=
ched */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
epoch_iterate_send_key(opt);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* draft 8 of the aead usage limit still had but draft 9 complete</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * dropped thi=
s statement:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *    In=
 particular, in two-party communication, one participant cannot</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         *    regard apparent o=
veruse of a key by other participants as</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         *    being in error, when it could be that th=
e other participant has</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         *    better information about bounds.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * OpenVPN 2.x implements a compromise of not=
 regarding this as an</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * error but still accepting packets of the usage limit but tries=
 to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * push =
the peer to a new epoch key by increasing our own key epoch</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * Also try to push the sender to us=
e a new key if we are the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         * decryption fail warn limit.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else if (opt-&gt;key_ctx_bi.encrypt.epoch =3D=3D=
 opt-&gt;key_ctx_bi.decrypt.epoch</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                 &amp;&amp; (aead_usage_limit_reached(opt-&gt=
;aead_usage_limit,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                             &amp;opt-&gt;key_ctx_bi.decryp=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                             opt-&gt;packet_id.rec.id)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     || cipher_decrypt_v=
erify_fail_warn(&amp;opt-&gt;key_ctx_bi.decrypt)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                     ))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* Receive key limit reached. Increase =
our own send key to signal</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             * that we want to use a new epoch. Peer should then als=
o move its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    * key but is not required to do this */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            epoch_iterate_send_key(opt);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (opt-&gt;packet_id.send.id =3D=3D PACKET_ID_EPOCH_MAX)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        epoch_iterate_send_key(opt);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/crypto_epoch.h b/=
src/openvpn/crypto_epoch.h</span><br><span>index e5d0e5d..b2f3d86 100644</s=
pan><br><span>--- a/src/openvpn/crypto_epoch.h</span><br><span>+++ b/src/op=
envpn/crypto_epoch.h</span><br><span>@@ -67,4 +67,94 @@</span><br><span>   =
                const uint8_t *context, size_t context_len,</span><br><span=
>                   uint8_t *out, uint16_t out_len);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Generate a data channel key pair from the epoch key<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param key       =
    Destination for the generated data key</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param epoch_key     Epoch key to be used</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @parm kt             Cip=
her information to generate the data channel key for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+epoch_data_key_derive(struct key_parameters *key,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      const struct epoch_=
key *epoch_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                  const struct key_type *kt);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Genera=
tes and fills the epoch_data_keys_future with next valid</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * future keys in crypto_options using=
 the epoch of the key in</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * crypto_options.key_ctx_bi.decrypt as starting point</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * This assume that the normal key_ctx_bi and epoch =
keys have been already</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * setup.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method is also c=
alled if crypto_options.key_ctx_bi.decrypt is changed.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * The method will then change the futur=
e keys in epoch_data_keys_future to</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * free the ones that are older than the crypto_options.key=
_ctx_bi.decrypt and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * generate the keys from the newer epoch.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_ge=
nerate_future_receive_keys(struct crypto_options *co);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
 This is called when the peer uses a new send key that is not the default</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * key. This function=
 ensures the following:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * - recv key matches the epoch index provided</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * - send key epoch is equal or higher than =
recv_key epoch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param new_epoch th=
e new epoch to use for the receive key</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_replac=
e_update_recv_key(struct crypto_options *co,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                              uint16_t new_epoch);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Updates the send key and send_epoch_key in cryptio_=
options-&gt;key_ctx_bi to</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * use the next epoch */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoc=
h_iterate_send_key(struct crypto_options *co);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Frees=
 the extra data structures used by epoch keys in \c crypto_options</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+free_epoch_key_ctx(struct crypto_options *co);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Initialises data channel keys and internal structures for epoch =
data keys</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * using t=
he provided E0 epoch key</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param co=
                The crypto option struct to initialise the epoch</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *                          re=
lated fields</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am key_type          The parameter of what encryption cipher to use when</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                    =
      initialising the epoch related fields</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param e1_send           The E1 send epoch key d=
erived by TLS-EKM</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param e1_recv           The E1 receive epoch key derived by TLS-EKM</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param future_key_coun=
t  the number of future epoch keys that should be</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *                          considered valid =
when receiving data from the peer</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_init_key_ct=
x(struct crypto_options *co, const struct key_type *key_type,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   const struct e=
poch_key *e1_send, const struct epoch_key *e1_recv,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   uint16_t future_key_co=
unt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Using an epoch, this function will try to retr=
ieve a decryption</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 key context that matches that epoch from the \c opt argument</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param opt       crypto_option=
s to use to find the decrypt key</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param epoch     epoch of the key to lookup</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return          the key context=
 with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+struct key_ctx *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+epoch_lookup_decrypt_key(struct c=
rypto_options *opt, uint16_t epoch);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Checks if we ne=
ed to iterate the send epoch key. This needs to be in one</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * of the following condition</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - max epoch counter rea=
ched</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - send key =
aead usage limit reached (for AES-GCM and similar ciphers)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  - recv key usage limit reached</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+epoch_check_send_iterate(struct crypto_options *opt)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif /* ifndef CRYPTO_EPOCH_H */</span><br><span>diff =
--git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c</span><br><span>i=
ndex 0806e99..149dda2 100644</span><br><span>--- a/src/openvpn/packet_id.c<=
/span><br><span>+++ b/src/openvpn/packet_id.c</span><br><span>@@ -77,6 +77,=
21 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+packet_id_init_recv(struct packet_id=
_rec *rec, int seq_backtrack, int time_backtrack, const char *name, int uni=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    rec-&gt;name =3D name;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    rec-&gt;unit =3D unit;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (seq_backtrack=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(MIN_SEQ_BACKTRACK=
 &lt;=3D seq_backtrack &amp;&amp; seq_backtrack &lt;=3D MAX_SEQ_BACKTRACK);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(MIN_=
TIME_BACKTRACK &lt;=3D time_backtrack &amp;&amp; time_backtrack &lt;=3D MAX=
_TIME_BACKTRACK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      CIRC_LIST_ALLOC(rec-&gt;seq_list, struct seq_list, seq_backtrack);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        rec-&gt;seq_ba=
cktrack =3D seq_backtrack;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        rec-&gt;time_backtrack =3D time_backtrack;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    rec-&gt;initialized =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> void</span><br><sp=
an> packet_id_init(struct packet_id *p, int seq_backtrack, int time_backtra=
ck, const char *name, int unit)</span><br><span> {</span><br><span>@@ -87,1=
7 +102,25 @@</span><br><span>     ASSERT(p);</span><br><span>     CLEAR(*p)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  p-&gt;rec.name =3D name;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    p-&gt;rec.unit =3D unit;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (seq_backtrack)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     ASSERT(MIN_SEQ_BACKTRACK &lt;=3D seq_backtrack &amp;&amp; seq_backtrac=
k &lt;=3D MAX_SEQ_BACKTRACK);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        ASSERT(MIN_TIME_BACKTRACK &lt;=3D time_backtrack &amp;&amp;=
 time_backtrack &lt;=3D MAX_TIME_BACKTRACK);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        CIRC_LIST_ALLOC(p-&gt;rec.seq_list, struct s=
eq_list, seq_backtrack);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        p-&gt;rec.seq_backtrack =3D seq_backtrack;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        p-&gt;rec.time_backtrack =3D time_b=
acktrack;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;rec.initialized =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet=
_id_init_recv(&amp;p-&gt;rec, seq_backtrack, time_backtrack, name, unit);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+packet_id_move_recv(struct packet_id_rec *dest, struct packet_id_rec *src=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(src);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(dest);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* clear free any old data in rec lis=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(dest-&=
gt;seq_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CL=
EAR(*dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy data to dest */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *dest =3D *src;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Reinitalise the source */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*src);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init_recv(src,=
 dest-&gt;seq_backtrack, dest-&gt;time_backtrack,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        dest-&gt;name, dest-&=
gt;unit);</span><br><span> }</span><br><span> </span><br><span> void</span>=
<br><span>diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h</s=
pan><br><span>index c05ac9a..07e92ff 100644</span><br><span>--- a/src/openv=
pn/packet_id.h</span><br><span>+++ b/src/openvpn/packet_id.h</span><br><spa=
n>@@ -206,6 +206,13 @@</span><br><span> </span><br><span> void packet_id_fr=
ee(struct packet_id *p);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Move the packet id recv structure from \c src to \c dest. \c src =
will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * be reinitial=
ised. \c dest will be freed before the move.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+packet=
_id_move_recv(struct packet_id_rec *dest, struct packet_id_rec *src);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* shou=
ld we accept an incoming packet id ? */</span><br><span> bool packet_id_tes=
t(struct packet_id_rec *p,</span><br><span>                     const struc=
t packet_id_net *pin);</span><br><span>diff --git a/src/openvpn/ssl_common.=
h b/src/openvpn/ssl_common.h</span><br><span>index e697d68..e092472 100644<=
/span><br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/op=
envpn/ssl_common.h</span><br><span>@@ -334,8 +334,8 @@</span><br><span>    =
 interval_t packet_timeout;</span><br><span>     int64_t renegotiate_bytes;=
</span><br><span>     int64_t renegotiate_packets;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /** limit for AEAD cipher, this is the sum=
 of packets + blocks</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * that are allowed to be used */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /** limit for AEAD cipher when not running in epoch da=
ta key mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
 this is the sum of packets + blocks that are allowed to be used */</span><=
br><span>     uint64_t aead_usage_limit;</span><br><span>     interval_t re=
negotiate_seconds;</span><br><span> </span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</spa=
n><br><span>index e16296b..3d9c99c 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_crypto.c</span><br><span>@@ -613,7 +613,7 @@</span><br><span>      0x9=
0, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,</span><br><span>      0x22, 0x=
ec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t *label =3D (const ui=
nt8_t *)(&quot;unit test&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const uint8_t *label =3D (const uint8_t *) (&quot;unit tes=
t&quot;);</span><br><span>     uint8_t out[16];</span><br><span>     ovpn_e=
xpand_label(secret, sizeof(secret), label, 9, NULL, 0, out, sizeof(out));</=
span><br><span> </span><br><span>@@ -708,9 +708,242 @@</span><br><span> }</=
span><br><span> #endif /* if defined(OPENSSL_VERSION_NUMBER) &amp;&amp; OPE=
NSSL_VERSION_NUMBER &gt;=3D 0x30000000L */</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct epoch_test_state</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct key_type kt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct crypto_options co;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
crypto_test_epoch_setup(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int *num_future_keys =3D (int *)*state;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct epoch_test_state *data =3D calloc(1, siz=
eof(struct epoch_test_state));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    data=
-&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type=
(&amp;data-&gt;kt, &quot;AES-128-GCM&quot;, &quot;none&quot;, true, false);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* have an epoch key that uses 0x2=
3 for the key for all bytes */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct epoch_key epoch1send =3D { .epoch =3D 1, .epoch_key =
=3D {0x23} };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct epoch_key epoch1recv =3D { .epoch =3D 1, .epoch_key =3D {0x27} };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    epoch_init_key_ctx(&amp;data-&gt;co, =
&amp;data-&gt;kt, &amp;epoch1send,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                       &amp;epoch1recv, *num_future_keys);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    *state =3D data;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_epoc=
h_teardown(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ep=
och_test_state *data =3D *state;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    free_epoch_key_ctx(&amp;data-&gt;co);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx_bi(&amp;data-&gt;co.key=
_ctx_bi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;data-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    free(*state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+crypto_test_epoch_key_generation(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct epoch_test_state *data =3D *state;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto_option=
s *co =3D &amp;data-&gt;co;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* chec=
k the keys look like expect */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(co-&gt;epoch_data_keys_future[0].epoch, 2);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(co-&gt;epoch_data_keys_future[15].epoch, 17);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_key_send.epoc=
h, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(co-&gt;epoch_key_recv.epoch, 17);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Now replace the recv key with the 6th future key (epoch =3D 8) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx(&a=
mp;co-&gt;key_ctx_bi.decrypt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(co-&gt;epoch_data_keys_future[6].epoch, 8);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;key_ctx_=
bi.decrypt =3D co-&gt;epoch_data_keys_future[6];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    CLEAR(co-&gt;epoch_data_keys_future[6]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    epoch_generate_future_receive_keys(c=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(co-&gt;epoch_data_keys_future[0].epoch, 9);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_data_keys_fu=
ture[15].epoch, 24);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+crypto_test_epoch_key_rotation(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct epoch_test_state *data =3D *state;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct crypto_options *co =3D &am=
p;data-&gt;co;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* should replace se=
nd + key recv */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 epoch_replace_update_recv_key(co, 9);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(co-&gt;key_ctx_bi.decrypt.epoch, 9);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_b=
i.encrypt.epoch, 9);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(co-&gt;epoch_key_send.epoch, 9);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_retiri=
ng_data_receive_key.epoch, 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* I=
terate the data send key four times to get it to 13 */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 4; i++)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        epoch_iterate_send_key(co);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx=
_bi.encrypt.epoch, 13);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_repla=
ce_update_recv_key(co, 10);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(co-&gt;key_ctx_bi.decrypt.epoch, 10);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;=
key_ctx_bi.encrypt.epoch, 13);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(co-&gt;epoch_key_send.epoch, 13);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;e=
poch_retiring_data_receive_key.epoch, 9);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    epoch_replace_update_recv_key(co, 12);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.decrypt.ep=
och, 12);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, 13);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_key_send.epo=
ch, 13);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(co-&gt;epoch_retiring_data_receive_key.epoch, 10);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    epoch_iterate_send_key(co);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.en=
crypt.epoch, 14);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+crypto_test_epoch_key_receive_lookup(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct epoch_test_state *data =3D *st=
ate;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct cryp=
to_options *co =3D &amp;data-&gt;co;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* lookup some wacky things that should fail */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, =
2000));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_n=
ull(epoch_lookup_decrypt_key(co, -1));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 0xefff));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Lookup the edges of the current w=
indow */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
null(epoch_lookup_decrypt_key(co, 0));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_retiring_data_receive_=
key.epoch, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(epoch_lookup_decrypt_key(co, 1)-&gt;epoch, 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_looku=
p_decrypt_key(co, 2)-&gt;epoch, 2);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, 13)-&gt;e=
poch, 13);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(epoch_lookup_decrypt_key(co, 14)-&gt;epoch, 14);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decry=
pt_key(co, 15));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Should move 1 t=
o retiring key but leave 2-6 undefined, 7 as</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * active and 8-20 as future keys*/</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    epoch_replace_update_recv_=
key(co, 7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_looku=
p_decrypt_key(co, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(epoch_lookup_decrypt_key(co, 1)-&gt;epoch, 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(epo=
ch_lookup_decrypt_key(co, 1), &amp;co-&gt;epoch_retiring_data_receive_key);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_k=
ey(co, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_null(epoch_lookup_decrypt_key(co, 3));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 4));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_l=
ookup_decrypt_key(co, 5));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_null(epoch_lookup_decrypt_key(co, 6));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_decr=
ypt_key(co, 7)-&gt;epoch, 7);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, 8)-&gt;epoch, 8=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(epoch_lookup_decrypt_key(co, 20)-&gt;epoch, 20);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(=
co, 21));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_null(epoch_lookup_decrypt_key(co, 22));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Should mov=
e 7 to retiring key and have 8 as active key and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * 9-21 as future keys */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    epoch_replace_update_recv_key(co=
, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_nul=
l(epoch_lookup_decrypt_key(co, 0));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 1));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_=
decrypt_key(co, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_null(epoch_lookup_decrypt_key(co, 3));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co,=
 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_nul=
l(epoch_lookup_decrypt_key(co, 5));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 6));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_lo=
okup_decrypt_key(co, 7)-&gt;epoch, 7);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_ptr_equal(epoch_lookup_decrypt_key(co, 7), &a=
mp;co-&gt;epoch_retiring_data_receive_key);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, 8=
)-&gt;epoch, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(epoch_lookup_decrypt_key(co, 20)-&gt;epoch, 20);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_l=
ookup_decrypt_key(co, 21)-&gt;epoch, 21);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 22));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_=
lookup_decrypt_key(co, 23));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+crypto_test_epoch_key_overflow(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct epoch_test_state *data =
=3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct crypto_options *co =3D &amp;data-&gt;co;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Modify the receive epoch and keys to have a very high epoch to =
test</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the end =
of array. Iterating through all 16k keys takes a 2-3s, so we</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * avoid this for the unit tes=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;key_=
ctx_bi.decrypt.epoch =3D 16000;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    co-&gt;key_ctx_bi.encrypt.epoch =3D 16000;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    co-&gt;epoch_key_send.epoch =3D 16000;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;epoch_key_recv.epoch =
=3D 16000 + co-&gt;epoch_data_keys_future_count;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (uint16_t i =3D 0; i &lt; co-&gt;epoch_data_keys_future_c=
ount; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        co-&gt;epoch_da=
ta_keys_future[i].epoch =3D 16001 + i;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Move th=
e last few keys until we are close to the limit */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    while (co-&gt;key_ctx_bi.decrypt.epoch &=
lt; (UINT16_MAX - 40))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        epo=
ch_replace_update_recv_key(co, co-&gt;key_ctx_bi.decrypt.epoch + 10);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Looking up this key should still work as it will no=
t break the limit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * when generating keys */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 34)=
-&gt;epoch, UINT16_MAX - 34);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 33=
)-&gt;epoch, UINT16_MAX - 33);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* T=
his key is no longer eligible for decrypting as the 32 future keys</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * would be larger than =
uint16_t maximum */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(co-&gt;epoch_data_keys_future_count, 32);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_dec=
rypt_key(co, UINT16_MAX - co-&gt;epoch_data_keys_future_count));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_d=
ecrypt_key(co, UINT16_MAX));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Che=
ck that moving to the last possible epoch works */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    epoch_replace_update_recv_key(co, UINT16=
_MAX - 33);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 33)-&gt;epoch, UINT1=
6_MAX - 33);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - 32));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_k=
ey(co, UINT16_MAX));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+epoch_test_derive_data_key(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct epoch_key e17 =3D { .epoch =3D 17, .e=
poch_key =3D { 19, 12 }};</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct key_type kt =3D { 0 };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct key_parameters key_parameters =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;=
kt, &quot;AES-192-GCM&quot;, &quot;none&quot;, true, false);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    epoch_data_key_derive(&amp;key_parameters, &amp;e17, &amp;kt);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(key_parameters.cipher_s=
ize, 24);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(key_parameters.hmac_size, 12);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint8_t exp_cipherkey[24] =3D</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {0xed, 0x85, 0x33, 0xdb, 0x1c, 0x28, 0xac, 0xe4,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x18, 0xe9, 0x00, 0x=
6a, 0xb2, 0x9c, 0x17, 0x41,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     0x7d, 0x60, 0xeb, 0xe6, 0xcd, 0x90, 0xbf, 0x0a};</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint8_t exp_impl_iv[12] =3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {0x86, 0x89, 0x0a, 0xab, 0xf0, 0x32,=
 0xcb, 0x59, 0xf4, 0xcf, 0xa3, 0x4e};</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_memory_equal(key_parameters.cipher, exp_cipherkey, sizeof(exp_cip=
herkey));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_memory_equal(key_parameters.hmac, exp_impl_iv, sizeof(exp_impl_iv));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> ma=
in(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int prestate_num13 =3D 13;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int prestate_num16 =3D 16;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int prestate_num32 =3D 32;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     openvpn_unit=
_test_setup();</span><br><span>     const struct CMUnitTest tests[] =3D {</=
span><br><span>         cmocka_unit_test(crypto_pem_encode_decode_loopback)=
,</span><br><span>@@ -725,7 +958,24 @@</span><br><span>         cmocka_unit=
_test(crypto_test_hkdf_expand_testa3),</span><br><span>         cmocka_unit=
_test(crypto_test_hkdf_expand_test_ovpn),</span><br><span>         cmocka_u=
nit_test(crypto_test_ovpn_label_expand),</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        cmocka_unit_test(crypto_test_ovpn_expand_openssl=
3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(crypto_test_ovpn_expand_openssl3),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test_prestate_setup_teardown(cry=
pto_test_epoch_key_generation,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                                 crypto_test_epo=
ch_setup,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                       crypto_test_epoch_teardown,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
                     &amp;prestate_num16),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test_prestate_setup_teardown(cry=
pto_test_epoch_key_rotation,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                                 crypto_test_epoch=
_setup,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                     crypto_test_epoch_teardown,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
                   &amp;prestate_num13),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test_prestate_setup_teardown(crypt=
o_test_epoch_key_receive_lookup,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                                 crypto_test_e=
poch_setup,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                         crypto_test_epoch_teardown,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                       &amp;prestate_num13),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test_prestate_setup_teardown(c=
rypto_test_epoch_key_overflow,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                                 crypto_test_epo=
ch_setup,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                       crypto_test_epoch_teardown,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
                     &amp;prestate_num32),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(epoch_test_derive_data_key)=
</span><br><span>     };</span><br><span> </span><br><span> #if defined(ENA=
BLE_CRYPTO_OPENSSL)</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail">change 804</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/804?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc=
62175820e9b80 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 804 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--m5YlBRruRXA=--

