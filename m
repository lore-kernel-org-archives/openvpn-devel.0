From: Gert Doering <gert@...1296...>
Date: Thu,  9 Jan 2025 19:05:37 +0100
Message-ID: <20250109180537.27686-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
References: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v12] Implement methods to generate and
 manage OpenVPN Epoch keys
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

This implements functions that allow these keys to be generated and
managed. It does not yet implement using them for the data channel.

Change-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/804
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ee9b0c6..b107f88 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -916,14 +916,27 @@
     if (cipher_ctx_mode_aead(ctx->cipher))
     {
         size_t impl_iv_len = 0;
+        size_t impl_iv_offset = 0;
         ASSERT(cipher_ctx_iv_length(ctx->cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
-        impl_iv_len = cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_id_type);
-        ASSERT(impl_iv_len + sizeof(packet_id_type) <= OPENVPN_MAX_IV_LENGTH);
+
+        /* Epoch keys use XOR of full IV length with the packet id to generate
+         * IVs. Old data format uses concatenation instead (XOR with 0 for the
+         * first 4 bytes (sizeof(packet_id_type) */
+        if (key->epoch)
+        {
+            impl_iv_len = cipher_ctx_iv_length(ctx->cipher);
+            impl_iv_offset = 0;
+        }
+        else
+        {
+            impl_iv_len = cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_id_type);
+            impl_iv_offset = sizeof(packet_id_type);
+        }
+        ASSERT(impl_iv_offset + impl_iv_len <= OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <= MAX_HMAC_KEY_LENGTH);
         ASSERT(impl_iv_len <= key->hmac_size);
         CLEAR(ctx->implicit_iv);
-        /* The first bytes of the IV are filled with the packet id */
-        memcpy(ctx->implicit_iv + sizeof(packet_id_type), key->hmac, impl_iv_len);
+        memcpy(ctx->implicit_iv + impl_iv_offset, key->hmac, impl_iv_len);
     }
 }
 
@@ -972,6 +985,7 @@
              hmac_ctx_size(ctx->hmac));
 
     }
+    ctx->epoch = key->epoch;
     gc_free(&gc);
 }
 
@@ -984,6 +998,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
+    ctx->epoch = key_params->epoch;
 }
 
 void
@@ -995,6 +1010,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
+    ctx->epoch = key_params->epoch;
 }
 
 void
@@ -1032,6 +1048,7 @@
     }
     CLEAR(ctx->implicit_iv);
     ctx->plaintext_blocks = 0;
+    ctx->epoch = 0;
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
 key_parameters_from_key(struct key_parameters *key_params, const struct key *key);
 
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
+     * As invariant, the epoch of epoch_key_send is always kept >= the epoch of
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
  * @return true if packet ID is validated to be not a replay, false otherwise.
  */
 bool crypto_check_replay(struct crypto_options *opt,
-                         const struct packet_id_net *pin, const char *error_prefix,
+                         const struct packet_id_net *pin,
+                         const char *error_prefix,
                          struct gc_arena *gc);
 
 
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 667e12a6..368344b 100644
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
+    struct epoch_key new_epoch_key = { 0 };
+    new_epoch_key.epoch = epoch_key->epoch + 1;
+    const uint8_t epoch_update_label[] = "datakey upd";
+    /* length of the array without extra \0 byte from the string */
+    const size_t epoch_update_label_len = sizeof(epoch_update_label) - 1;
+
+    /* E_N+1 = OVPN-Expand-Label(E_N, "datakey upd", "", 32) */
+    ovpn_expand_label(epoch_key->epoch_key, sizeof(epoch_key->epoch_key),
+                      epoch_update_label, epoch_update_label_len,
+                      NULL, 0,
+                      new_epoch_key.epoch_key, sizeof(new_epoch_key.epoch_key));
+    *epoch_key = new_epoch_key;
+}
+
+void
+epoch_data_key_derive(struct key_parameters *key,
+                      const struct epoch_key *epoch_key,
+                      const struct key_type *kt)
+{
+    key->hmac_size = cipher_kt_iv_size(kt->cipher);
+    key->cipher_size = cipher_kt_key_size(kt->cipher);
+
+    /* Generate data key from epoch key:
+     * K_i = OVPN-Expand-Label(E_i, "data_key", "", key_size)
+     * implicit_iv = OVPN-Expand-Label(E_i, "data_iv", "", implicit_iv_len)
+     */
+
+    const uint8_t epoch_data_key_label[] = "data_key";
+    /* length of the array without extra \0 byte from the string */
+    const size_t epoch_data_key_label_len = sizeof(epoch_data_key_label) - 1;
+
+    ovpn_expand_label(epoch_key->epoch_key, sizeof(epoch_key->epoch_key),
+                      epoch_data_key_label, epoch_data_key_label_len,
+                      NULL, 0,
+                      (uint8_t *)(&key->cipher), key->cipher_size);
+
+    const uint8_t epoch_data_iv_label[] = "data_iv";
+    /* length of the array without extra \0 byte from the string */
+    const size_t epoch_data_iv_label_len = sizeof(epoch_data_iv_label) - 1;
+
+    ovpn_expand_label(epoch_key->epoch_key, sizeof(epoch_key->epoch_key),
+                      epoch_data_iv_label, epoch_data_iv_label_len,
+                      NULL, 0,
+                      (uint8_t *)(&key->hmac), key->hmac_size);
+    key->epoch = epoch_key->epoch;
+}
+
+static void
+epoch_init_send_key_ctx(struct crypto_options *co)
+{
+    /* Ensure that we are NEVER regenerating the same key that has already
+     * been generated. Since we also reset the packet ID counter this would be
+     * catastrophic as we would do IV reuse which breaks ciphers like AES-GCM */
+    ASSERT(co->key_ctx_bi.encrypt.epoch != co->epoch_key_send.epoch);
+    char name[32] = { 0 };
+    snprintf(name, sizeof(name), "Epoch Data key %" PRIu16, co->epoch_key_send.epoch);
+
+    struct key_parameters send_key = { 0 };
+
+    epoch_data_key_derive(&send_key, &co->epoch_key_send, &co->epoch_key_type);
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
+    struct key_parameters recv_key = { 0 };
+    epoch_data_key_derive(&recv_key, &co->epoch_key_recv, &co->epoch_key_type);
+
+    char name[32];
+
+    snprintf(name, sizeof(name), "Epoch Data key %" PRIu16, co->epoch_key_recv.epoch);
+
+    init_key_bi_ctx_recv(ctx, &recv_key, &co->epoch_key_type, name);
+    CLEAR(recv_key);
+}
+
+void
+epoch_generate_future_receive_keys(struct crypto_options *co)
+{
+    /* We want the future receive keys to start just after the epoch of the
+     * the currently used decryption key. */
+    ASSERT(co->key_ctx_bi.initialized);
+    uint16_t current_decrypt_epoch = co->key_ctx_bi.decrypt.epoch;
+
+    /* Either we have not generated any future keys yet (first initialisation)
+     * or the last index is the same as our current epoch key
+     * (last generated receive epoch key should match the epoch key) */
+    struct key_ctx *highest_future_key = &co->epoch_data_keys_future[co->epoch_data_keys_future_count - 1];
+
+    ASSERT(co->epoch_key_recv.epoch == 1
+           || highest_future_key->epoch == co->epoch_key_recv.epoch);
+
+    /* free the keys that are not used anymore */
+    for (uint16_t i = 0; i < co->epoch_data_keys_future_count; i++)
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
+     * if no keys have been generated assume only the first key is defined */
+    uint16_t current_highest_key = highest_future_key->epoch ? highest_future_key->epoch : 1;
+    uint16_t desired_highest_key = current_decrypt_epoch + co->epoch_data_keys_future_count;
+    uint16_t num_keys_generate = desired_highest_key - current_highest_key;
+
+
+    /* Move the old keys out of the way so the order of keys stays strictly
+     * monotonic and consecutive. */
+    /* first check that the destination we are going to overwrite is freed */
+    for (uint16_t i = 0; i < num_keys_generate; i++)
+    {
+        ASSERT(co->epoch_data_keys_future[i].epoch == 0);
+    }
+    memmove(co->epoch_data_keys_future,
+            co->epoch_data_keys_future + num_keys_generate,
+            (co->epoch_data_keys_future_count - num_keys_generate) * sizeof(struct key_ctx));
+
+    /* Clear and regenerate the array elements at the end */
+    for (uint16_t i = co->epoch_data_keys_future_count - num_keys_generate; i < co->epoch_data_keys_future_count; i++)
+    {
+        CLEAR(co->epoch_data_keys_future[i]);
+        epoch_key_iterate(&co->epoch_key_recv);
+
+        epoch_init_recv_key(&co->epoch_data_keys_future[i], co);
+    }
+
+    /* Assert that all keys are initialised */
+    for (uint16_t i = 0; i < co->epoch_data_keys_future_count; i++)
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
+    for (fki = 0; fki < co->epoch_data_keys_future_count; fki++)
+    {
+        if (co->epoch_data_keys_future[fki].epoch == new_epoch)
+        {
+            break;
+        }
+    }
+    /* we should only ever be called when we successfully decrypted/authenticated
+     * a packet from a peer, ie the epoch recv key *MUST* be in that
+     * array */
+    ASSERT(fki < co->epoch_data_keys_future_count);
+    ASSERT(co->epoch_data_keys_future[fki].epoch == new_epoch);
+
+    struct key_ctx *new_ctx = &co->epoch_data_keys_future[fki];
+
+    /* Check if the new recv key epoch is higher than the send key epoch. If
+     * yes we will replace the send key as well */
+    if (co->key_ctx_bi.encrypt.epoch < new_epoch)
+    {
+        free_key_ctx(&co->key_ctx_bi.encrypt);
+
+        /* Update the epoch_key for send to match the current key being used.
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
+    co->epoch_retiring_data_receive_key = co->key_ctx_bi.decrypt;
+    packet_id_move_recv(&co->epoch_retiring_key_pid_recv, &co->packet_id.rec);
+
+    co->key_ctx_bi.decrypt = *new_ctx;
+
+    /* Zero the old location instead to of free_key_ctx since we moved the keys
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
+    for (uint16_t i = 0; i < co->epoch_data_keys_future_count; i++)
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
+epoch_init_key_ctx(struct crypto_options *co, const struct key_type *key_type,
+                   const struct epoch_key *e1_send,
+                   const struct epoch_key *e1_recv,
+                   uint16_t future_key_count)
+{
+    ASSERT(e1_send->epoch == 1 && e1_recv->epoch == 1);
+    co->epoch_key_recv = *e1_recv;
+    co->epoch_key_send = *e1_send;
+
+    co->epoch_key_type = *key_type;
+    co->aead_usage_limit = cipher_get_aead_limits(key_type->cipher);
+
+    epoch_init_send_key_ctx(co);
+    epoch_init_recv_key(&co->key_ctx_bi.decrypt, co);
+    co->key_ctx_bi.initialized = true;
+
+    co->epoch_data_keys_future_count = future_key_count;
+    ALLOC_ARRAY_CLEAR(co->epoch_data_keys_future, struct key_ctx, co->epoch_data_keys_future_count);
+    epoch_generate_future_receive_keys(co);
+}
+
+struct key_ctx *
+epoch_lookup_decrypt_key(struct crypto_options *opt, uint16_t epoch)
+{
+    /* Current decrypt key is the most likely one */
+    if (opt->key_ctx_bi.decrypt.epoch == epoch)
+    {
+        return &opt->key_ctx_bi.decrypt;
+    }
+    else if (opt->epoch_retiring_data_receive_key.epoch
+             && opt->epoch_retiring_data_receive_key.epoch == epoch)
+    {
+        return &opt->epoch_retiring_data_receive_key;
+    }
+    else if (epoch > opt->key_ctx_bi.decrypt.epoch
+             && epoch <= opt->key_ctx_bi.decrypt.epoch + opt->epoch_data_keys_future_count)
+    {
+        /* Key in the range of future keys */
+        int index = epoch - (opt->key_ctx_bi.decrypt.epoch + 1);
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
+    if (opt->epoch_key_send.epoch == UINT16_MAX)
+    {
+        /* limit of epoch keys reached, cannot move to a newer key anymore */
+        return;
+    }
+    if (opt->aead_usage_limit)
+    {
+        if (aead_usage_limit_reached(opt->aead_usage_limit, &opt->key_ctx_bi.encrypt,
+                                     opt->packet_id.send.id))
+        {
+            /* Send key limit reached */
+            epoch_iterate_send_key(opt);
+        }
+        /* draft 8 of the aead usage limit still had but draft 9 complete
+         * dropped this statement:
+         *
+         *    In particular, in two-party communication, one participant cannot
+         *    regard apparent overuse of a key by other participants as
+         *    being in error, when it could be that the other participant has
+         *    better information about bounds.
+         *
+         * OpenVPN 2.x implements a compromise of not regarding this as an
+         * error but still accepting packets of the usage limit but tries to
+         * push the peer to a new epoch key by increasing our own key epoch
+         *
+         * Also try to push the sender to use a new key if we are the
+         * decryption fail warn limit.
+         * */
+        else if (opt->key_ctx_bi.encrypt.epoch == opt->key_ctx_bi.decrypt.epoch
+                 && (aead_usage_limit_reached(opt->aead_usage_limit,
+                                              &opt->key_ctx_bi.decrypt,
+                                              opt->packet_id.rec.id)
+                     || cipher_decrypt_verify_fail_warn(&opt->key_ctx_bi.decrypt)
+                     ))
+        {
+            /* Receive key limit reached. Increase our own send key to signal
+             * that we want to use a new epoch. Peer should then also move its
+             * key but is not required to do this */
+            epoch_iterate_send_key(opt);
+        }
+    }
+
+    if (opt->packet_id.send.id == PACKET_ID_EPOCH_MAX)
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
+ * @parm kt             Cipher information to generate the data channel key for
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
+ * This method is also called if crypto_options.key_ctx_bi.decrypt is changed.
+ * The method will then change the future keys in epoch_data_keys_future to
+ * free the ones that are older than the crypto_options.key_ctx_bi.decrypt and
+ * generate the keys from the newer epoch.
+ */
+void
+epoch_generate_future_receive_keys(struct crypto_options *co);
+
+
+/** This is called when the peer uses a new send key that is not the default
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
+ * Updates the send key and send_epoch_key in cryptio_options->key_ctx_bi to
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
+ * Initialises data channel keys and internal structures for epoch data keys
+ * using the provided E0 epoch key
+ *
+ * @param co                The crypto option struct to initialise the epoch
+ *                          related fields
+ * @param key_type          The parameter of what encryption cipher to use when
+ *                          initialising the epoch related fields
+ * @param e1_send           The E1 send epoch key derived by TLS-EKM
+ * @param e1_recv           The E1 receive epoch key derived by TLS-EKM
+ * @param future_key_count  the number of future epoch keys that should be
+ *                          considered valid when receiving data from the peer
+ */
+void
+epoch_init_key_ctx(struct crypto_options *co, const struct key_type *key_type,
+                   const struct epoch_key *e1_send, const struct epoch_key *e1_recv,
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
+packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time_backtrack, const char *name, int unit)
+{
+    rec->name = name;
+    rec->unit = unit;
+    if (seq_backtrack)
+    {
+        ASSERT(MIN_SEQ_BACKTRACK <= seq_backtrack && seq_backtrack <= MAX_SEQ_BACKTRACK);
+        ASSERT(MIN_TIME_BACKTRACK <= time_backtrack && time_backtrack <= MAX_TIME_BACKTRACK);
+        CIRC_LIST_ALLOC(rec->seq_list, struct seq_list, seq_backtrack);
+        rec->seq_backtrack = seq_backtrack;
+        rec->time_backtrack = time_backtrack;
+    }
+    rec->initialized = true;
+}
 void
 packet_id_init(struct packet_id *p, int seq_backtrack, int time_backtrack, const char *name, int unit)
 {
@@ -87,17 +102,25 @@
     ASSERT(p);
     CLEAR(*p);
 
-    p->rec.name = name;
-    p->rec.unit = unit;
-    if (seq_backtrack)
-    {
-        ASSERT(MIN_SEQ_BACKTRACK <= seq_backtrack && seq_backtrack <= MAX_SEQ_BACKTRACK);
-        ASSERT(MIN_TIME_BACKTRACK <= time_backtrack && time_backtrack <= MAX_TIME_BACKTRACK);
-        CIRC_LIST_ALLOC(p->rec.seq_list, struct seq_list, seq_backtrack);
-        p->rec.seq_backtrack = seq_backtrack;
-        p->rec.time_backtrack = time_backtrack;
-    }
-    p->rec.initialized = true;
+    packet_id_init_recv(&p->rec, seq_backtrack, time_backtrack, name, unit);
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
+    *dest = *src;
+
+    /* Reinitalise the source */
+    CLEAR(*src);
+    packet_id_init_recv(src, dest->seq_backtrack, dest->time_backtrack,
+                        dest->name, dest->unit);
 }
 
 void
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index c05ac9a..9c0f464 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -206,6 +206,13 @@
 
 void packet_id_free(struct packet_id *p);
 
+/**
+ * Move the packet id recv structure from \c src to \c dest. \c src will will
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
 
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index e16296b..3d9c99c 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -613,7 +613,7 @@
      0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
      0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};
 
-    const uint8_t *label = (const uint8_t *)("unit test");
+    const uint8_t *label = (const uint8_t *) ("unit test");
     uint8_t out[16];
     ovpn_expand_label(secret, sizeof(secret), label, 9, NULL, 0, out, sizeof(out));
 
@@ -708,9 +708,242 @@
 }
 #endif /* if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >= 0x30000000L */
 
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
+    int *num_future_keys = (int *)*state;
+    struct epoch_test_state *data = calloc(1, sizeof(struct epoch_test_state));
+
+    data->gc = gc_new();
+
+    init_key_type(&data->kt, "AES-128-GCM", "none", true, false);
+
+    /* have an epoch key that uses 0x23 for the key for all bytes */
+    struct epoch_key epoch1send = { .epoch = 1, .epoch_key = {0x23} };
+    struct epoch_key epoch1recv = { .epoch = 1, .epoch_key = {0x27} };
+
+    epoch_init_key_ctx(&data->co, &data->kt, &epoch1send,
+                       &epoch1recv, *num_future_keys);
+
+    *state = data;
+    return 0;
+}
+
+static int
+crypto_test_epoch_teardown(void **state)
+{
+    struct epoch_test_state *data = *state;
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
+    struct epoch_test_state *data = *state;
+    struct crypto_options *co = &data->co;
+
+    /* check the keys look like expect */
+    assert_int_equal(co->epoch_data_keys_future[0].epoch, 2);
+    assert_int_equal(co->epoch_data_keys_future[15].epoch, 17);
+    assert_int_equal(co->epoch_key_send.epoch, 1);
+    assert_int_equal(co->epoch_key_recv.epoch, 17);
+
+    /* Now replace the recv key with the 6th future key (epoch = 8) */
+    free_key_ctx(&co->key_ctx_bi.decrypt);
+    assert_int_equal(co->epoch_data_keys_future[6].epoch, 8);
+    co->key_ctx_bi.decrypt = co->epoch_data_keys_future[6];
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
+    struct epoch_test_state *data = *state;
+    struct crypto_options *co = &data->co;
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
+    for (int i = 0; i < 4; i++)
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
+    struct epoch_test_state *data = *state;
+    struct crypto_options *co = &data->co;
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
+    assert_ptr_equal(epoch_lookup_decrypt_key(co, 1), &co->epoch_retiring_data_receive_key);
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
+    assert_ptr_equal(epoch_lookup_decrypt_key(co, 7), &co->epoch_retiring_data_receive_key);
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
+    struct epoch_test_state *data = *state;
+    struct crypto_options *co = &data->co;
+
+    /* Modify the receive epoch and keys to have a very high epoch to test
+     * the end of array. Iterating through all 16k keys takes a 2-3s, so we
+     * avoid this for the unit test */
+    co->key_ctx_bi.decrypt.epoch = 16000;
+    co->key_ctx_bi.encrypt.epoch = 16000;
+
+    co->epoch_key_send.epoch = 16000;
+    co->epoch_key_recv.epoch = 16000 + co->epoch_data_keys_future_count;
+
+    for (uint16_t i = 0; i < co->epoch_data_keys_future_count; i++)
+    {
+        co->epoch_data_keys_future[i].epoch = 16001 + i;
+    }
+
+    /* Move the last few keys until we are close to the limit */
+    while (co->key_ctx_bi.decrypt.epoch < (UINT16_MAX - 40))
+    {
+        epoch_replace_update_recv_key(co, co->key_ctx_bi.decrypt.epoch + 10);
+    }
+
+    /* Looking up this key should still work as it will not break the limit
+     * when generating keys */
+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 34)->epoch, UINT16_MAX - 34);
+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 33)->epoch, UINT16_MAX - 33);
+
+    /* This key is no longer eligible for decrypting as the 32 future keys
+     * would be larger than uint16_t maximum */
+    assert_int_equal(co->epoch_data_keys_future_count, 32);
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - co->epoch_data_keys_future_count));
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX));
+
+    /* Check that moving to the last possible epoch works */
+    epoch_replace_update_recv_key(co, UINT16_MAX - 33);
+    assert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 33)->epoch, UINT16_MAX - 33);
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - 32));
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX));
+}
+
+void
+epoch_test_derive_data_key(void **state)
+{
+    struct epoch_key e17 = { .epoch = 17, .epoch_key = { 19, 12 }};
+    struct key_type kt = { 0 };
+    struct key_parameters key_parameters = { 0 };
+    init_key_type(&kt, "AES-192-GCM", "none", true, false);
+
+
+    epoch_data_key_derive(&key_parameters, &e17, &kt);
+
+    assert_int_equal(key_parameters.cipher_size, 24);
+    assert_int_equal(key_parameters.hmac_size, 12);
+
+    uint8_t exp_cipherkey[24] =
+    {0xed, 0x85, 0x33, 0xdb, 0x1c, 0x28, 0xac, 0xe4,
+     0x18, 0xe9, 0x00, 0x6a, 0xb2, 0x9c, 0x17, 0x41,
+     0x7d, 0x60, 0xeb, 0xe6, 0xcd, 0x90, 0xbf, 0x0a};
+
+    uint8_t exp_impl_iv[12] =
+    {0x86, 0x89, 0x0a, 0xab, 0xf0, 0x32, 0xcb, 0x59, 0xf4, 0xcf, 0xa3, 0x4e};
+
+    assert_memory_equal(key_parameters.cipher, exp_cipherkey, sizeof(exp_cipherkey));
+    assert_memory_equal(key_parameters.hmac, exp_impl_iv, sizeof(exp_impl_iv));
+}
+
 int
 main(void)
 {
+    int prestate_num13 = 13;
+    int prestate_num16 = 16;
+    int prestate_num32 = 32;
+
     openvpn_unit_test_setup();
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(crypto_pem_encode_decode_loopback),
@@ -725,7 +958,24 @@
         cmocka_unit_test(crypto_test_hkdf_expand_testa3),
         cmocka_unit_test(crypto_test_hkdf_expand_test_ovpn),
         cmocka_unit_test(crypto_test_ovpn_label_expand),
-        cmocka_unit_test(crypto_test_ovpn_expand_openssl3)
+        cmocka_unit_test(crypto_test_ovpn_expand_openssl3),
+        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_generation,
+                                                 crypto_test_epoch_setup,
+                                                 crypto_test_epoch_teardown,
+                                                 &prestate_num16),
+        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_rotation,
+                                                 crypto_test_epoch_setup,
+                                                 crypto_test_epoch_teardown,
+                                                 &prestate_num13),
+        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_receive_lookup,
+                                                 crypto_test_epoch_setup,
+                                                 crypto_test_epoch_teardown,
+                                                 &prestate_num13),
+        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_overflow,
+                                                 crypto_test_epoch_setup,
+                                                 crypto_test_epoch_teardown,
+                                                 &prestate_num32),
+        cmocka_unit_test(epoch_test_derive_data_key)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

