From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 02:00:01 +0000
References: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <4134baab4dccf956709c8577b8a4d87858aff017-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UKKifhIs9UY="; charset=UTF-8
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

--UKKifhIs9UY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail

to review the following change.


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
8 files changed, 776 insertions(+), 22 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/804/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index f4453d8..dc23ffc 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -909,14 +909,27 @@
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

@@ -965,6 +978,7 @@
              hmac_ctx_size(ctx->hmac));

     }
+    ctx->epoch =3D key->epoch;
     gc_free(&gc);
 }

@@ -977,6 +991,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
+    ctx->epoch =3D key_params->epoch;
 }

 void
@@ -988,6 +1003,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
+    ctx->epoch =3D key_params->epoch;
 }

 void
@@ -1025,6 +1041,7 @@
     }
     CLEAR(ctx->implicit_iv);
     ctx->plaintext_blocks =3D 0;
+    ctx->epoch =3D 0;
 }

 void
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index ff24f87..abba30c 100644
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
@@ -199,6 +207,10 @@
     /** Counter for the number of plaintext encrypted using this cipher
      * in number of 128 bit blocks (only used for AEAD ciphers) */
     uint64_t plaintext_blocks;
+    /** OpenVPN data channel epoch, this variable holds the
+     *  epoch number that is key belongs to. Note that epoch 0 is not used
+     *  and epoch is always non-zero for epoch key contexts */
+    uint16_t epoch;
 };

 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -268,6 +280,39 @@
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
@@ -276,7 +321,7 @@
                                  *
                                  *   The packet id also used as the IV
                                  *   for AEAD/OFB/CFG ciphers.
-                                 *   */
+                                 */
     struct packet_id_persist *pid_persist;
     /**< Persistent packet ID state for
      *   keeping state between successive
@@ -464,13 +509,15 @@
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
index 7a5b460..1f89804 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -21,7 +21,7 @@
  *  You should have received a copy of the GNU General Public License along
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-*/
+ */


 #ifdef HAVE_CONFIG_H
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

@@ -103,4 +109,333 @@

     gc_free(&gc);
     return true;
-}
\ No newline at end of file
+}
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--UKKifhIs9UY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Implement methods to generate and manage OpenVPN Epoch keys<b=
r><br>This implements functions that allow these keys to be generated and<b=
r>managed. It does not yet implement using them for the data channel.<br><b=
r>Change-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M sr=
c/openvpn/crypto.h<br>M src/openvpn/crypto_epoch.c<br>M src/openvpn/crypto_=
epoch.h<br>M src/openvpn/packet_id.c<br>M src/openvpn/packet_id.h<br>M src/=
openvpn/ssl_common.h<br>M tests/unit_tests/openvpn/test_crypto.c<br>8 files=
 changed, 776 insertions(+), 22 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/04/804/1</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index f4453d8..dc23=
ffc 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b=
/src/openvpn/crypto.c</span><br><span>@@ -909,14 +909,27 @@</span><br><span=
>     if (cipher_ctx_mode_aead(ctx-&gt;cipher))</span><br><span>     {</spa=
n><br><span>         size_t impl_iv_len =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        size_t impl_iv_offset =3D 0;</span><br><=
span>         ASSERT(cipher_ctx_iv_length(ctx-&gt;cipher) &gt;=3D OPENVPN_A=
EAD_MIN_IV_LEN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - sizeof(packet_id_=
type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* Epoch keys use XOR of=
 full IV length with the packet id to generate</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * IVs. Old data format uses concatenati=
on instead (XOR with 0 for the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * first 4 bytes (sizeof(packet_id_type) */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (key-&gt;epoch)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            impl_iv_len =3D cipher_=
ctx_iv_length(ctx-&gt;cipher);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            impl_iv_offset =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - sizeof(pac=
ket_id_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      impl_iv_offset =3D sizeof(packet_id_type);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span>         ASSERT(impl=
_iv_len &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>         ASSERT(imp=
l_iv_len &lt;=3D MAX_HMAC_KEY_LENGTH);</span><br><span>         ASSERT(key-=
&gt;hmac_size &gt;=3D impl_iv_len);</span><br><span>         CLEAR(ctx-&gt;=
implicit_iv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
/* The first bytes of the IV are filled with the packet id */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        memcpy(ctx-&gt;implicit_iv =
+ sizeof(packet_id_type), key-&gt;hmac, impl_iv_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        memcpy(ctx-&gt;implicit_iv + impl=
_iv_offset, key-&gt;hmac, impl_iv_len);</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span>@@ -965,6 +978,7 @@</span><br><spa=
n>              hmac_ctx_size(ctx-&gt;hmac));</span><br><span> </span><br><=
span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-=
&gt;epoch =3D key-&gt;epoch;</span><br><span>     gc_free(&amp;gc);</span><=
br><span> }</span><br><span> </span><br><span>@@ -977,6 +991,7 @@</span><br=
><span>     snprintf(log_prefix, sizeof(log_prefix), &quot;Outgoing %s&quot=
;, name);</span><br><span>     init_key_ctx(ctx, key_params, kt, OPENVPN_OP=
_ENCRYPT, log_prefix);</span><br><span>     key_ctx_update_implicit_iv(ctx,=
 key_params);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ct=
x-&gt;epoch =3D key_params-&gt;epoch;</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span>@@ -988,6 +1003,7 @@</span><br><span>=
     snprintf(log_prefix, sizeof(log_prefix), &quot;Incoming %s&quot;, name=
);</span><br><span>     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYP=
T, log_prefix);</span><br><span>     key_ctx_update_implicit_iv(ctx, key_pa=
rams);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;e=
poch =3D key_params-&gt;epoch;</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span>@@ -1025,6 +1041,7 @@</span><br><span>     }=
</span><br><span>     CLEAR(ctx-&gt;implicit_iv);</span><br><span>     ctx-=
&gt;plaintext_blocks =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ctx-&gt;epoch =3D 0;</span><br><span> }</span><br><span> </span=
><br><span> void</span><br><span>diff --git a/src/openvpn/crypto.h b/src/op=
envpn/crypto.h</span><br><span>index ff24f87..abba30c 100644</span><br><spa=
n>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</sp=
an><br><span>@@ -170,6 +170,9 @@</span><br><span> </span><br><span>     /**=
 Number of bytes set in the HMac key material */</span><br><span>     int h=
mac_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /** the epoch of the key =
is if it was generated as epoch data key material */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint16_t epoch;</span><br><span> };</=
span><br><span> </span><br><span> /**</span><br><span>@@ -180,6 +183,11 @@<=
/span><br><span> void</span><br><span> key_parameters_from_key(struct key_p=
arameters *key_params, const struct key *key);</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+struct epoch_key {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t epoch_key[SHA256_DI=
GEST_LENGTH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt16_t epoch;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</=
span><br><span>  * Container for one set of cipher and/or HMAC contexts.</s=
pan><br><span>  * @ingroup control_processor</span><br><span>@@ -199,6 +207=
,10 @@</span><br><span>     /** Counter for the number of plaintext encrypt=
ed using this cipher</span><br><span>      * in number of 128 bit blocks (o=
nly used for AEAD ciphers) */</span><br><span>     uint64_t plaintext_block=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** OpenVPN d=
ata channel epoch, this variable holds the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     *  epoch number that is key belongs to. Note th=
at epoch 0 is not used</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     *  and epoch is always non-zero for epoch key contexts */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t epoch;</span><br=
><span> };</span><br><span> </span><br><span> #define KEY_DIRECTION_BIDIREC=
TIONAL 0 /* same keys for both directions */</span><br><span>@@ -268,6 +280=
,39 @@</span><br><span>     /**&lt; OpenSSL cipher and HMAC contexts for</s=
pan><br><span>      *   both sending and receiving</span><br><span>      * =
  directions. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** last epoch_key=
 used for generation of the current send data keys.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * As invariant, the epoch of epoch_k=
ey_send is always kept &gt;=3D the epoch of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * epoch_key_recv */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct epoch_key epoch_key_send;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /** epoch_key used for the highest receive e=
poch keys */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct epoch_key epoch_key_recv;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** t=
he key_type that is used to generate the epoch keys */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct key_type epoch_key_type;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** This limit for AEAD cipher, this =
is the sum of packets + blocks</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * that are allowed to be used. Will switch to a new epoch i=
f this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * limit =
is reached*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t64_t aead_usage_limit;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Keeps t=
he future epoch data keys for decryption. The current one</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * that is expected to be used is=
 stored in key_ctx_bi.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * We =
keep both decrypt and encrypt key here in the future keys</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * as we want to be able to switc=
h also sending key if the peer</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * switching to a newer key epoch</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct key_ctx *epoch_data_keys_future;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /** number of keys stored in \c epoch_data_keys=
_future */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint1=
6_t epoch_data_keys_future_count;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
** The old key bevor the sender switch to a new epoch data key */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_ctx epoch_reti=
ring_data_receive_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct packet_id_rec epoch_retiring_key_pid_recv;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct packet_id=
 packet_id; /**&lt; Current packet ID state for both</span><br><span>      =
                            *   sending and receiving directions.</span><br=
><span>                                  *</span><br><span>@@ -276,7 +321,7=
 @@</span><br><span>                                  *</span><br><span>   =
                               *   The packet id also used as the IV</span>=
<br><span>                                  *   for AEAD/OFB/CFG ciphers.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
          *   */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                              */</span><br><span>     struct packet_id_pers=
ist *pid_persist;</span><br><span>     /**&lt; Persistent packet ID state f=
or</span><br><span>      *   keeping state between successive</span><br><sp=
an>@@ -464,13 +509,15 @@</span><br><span>  *</span><br><span>  * @param opt=
   Crypto options for this packet, contains replay state.</span><br><span> =
 * @param pin   Packet ID read from packet.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param epoch Epoch read from packet or 0 when ep=
och is not used.</span><br><span>  * @param error_prefix  Prefix to use whe=
n printing error messages.</span><br><span>  * @param gc    Garbage collect=
or to use.</span><br><span>  *</span><br><span>  * @return true if packet I=
D is validated to be not a replay, false otherwise.</span><br><span>  */</s=
pan><br><span> bool crypto_check_replay(struct crypto_options *opt,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                         cons=
t struct packet_id_net *pin, const char *error_prefix,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                         const struct pa=
cket_id_net *pin,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       const char *error_prefix,</span><br><span>          =
                struct gc_arena *gc);</span><br><span> </span><br><span> </=
span><br><span>diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto=
_epoch.c</span><br><span>index 7a5b460..1f89804 100644</span><br><span>--- =
a/src/openvpn/crypto_epoch.c</span><br><span>+++ b/src/openvpn/crypto_epoch=
.c</span><br><span>@@ -21,7 +21,7 @@</span><br><span>  *  You should have r=
eceived a copy of the GNU General Public License along</span><br><span>  * =
 with this program; if not, write to the Free Software Foundation, Inc.,</s=
pan><br><span>  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-*/</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> </span><br><sp=
an> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>@@ -29,7 +29,13 =
@@</span><br><span> #endif</span><br><span> </span><br><span> #include &lt;=
inttypes.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &lt;string.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &lt;stdlib.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> #include &quot;crypto_backend.h&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;packet_id.h&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;cryp=
to.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;crypto_epoch.h&quot;</span><br><span> #include &quot;buffer.h&quot;</=
span><br><span> #include &quot;integer.h&quot;</span><br><span> </span><br>=
<span>@@ -103,4 +109,333 @@</span><br><span> </span><br><span>     gc_free(=
&amp;gc);</span><br><span>     return true;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span>\ No newline at end of file</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It=
erates the epoch key to make it E_n+1, ie increase the epoch by one</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * and derive the new key m=
aterial accordingly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param epoch_key epoch key to iterate</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epo=
ch_key_iterate(struct epoch_key *epoch_key)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct epoch_key new_epoch_key =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    new_epoch_key.epoch =3D epoch_key-&gt=
;epoch + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint8_t epoch_update_label[] =3D &quot;datakey upd&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* E_N+1 =3D OVPN-Expand-Label(E_N, &quot;datakey =
upd&quot;, &quot;&quot;, 32) */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ovpn_expand_label(epoch_key-&gt;epoch_key, sizeof(epoch_key=
-&gt;epoch_key),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   epoch_update_label, 11,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                      NULL, 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      new_epoch_key.epoch=
_key, sizeof(new_epoch_key.epoch_key));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    *epoch_key =3D new_epoch_key;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_data_key_der=
ive(struct key_parameters *key,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                      const struct epoch_key *epoch_key,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                      cons=
t struct key_type *kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key-&gt;hma=
c_size =3D cipher_kt_iv_size(kt-&gt;cipher);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    key-&gt;cipher_size =3D cipher_kt_key_size(kt-=
&gt;cipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Generate data key f=
rom epoch key:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* K_i =3D OVPN-Expand-Label(E_i, &quot;data_key&quot;, &quot;&quot;, key_si=
ze)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * implicit_=
iv =3D OVPN-Expand-Label(E_i, &quot;data_iv&quot;, &quot;&quot;, implicit_i=
v_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const uint8_t epoch_data_key_label[] =3D=
 &quot;data_key&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ovpn_expand_label(epoch_key-&gt;epoch_key, sizeof(epoch_key-&gt;epoc=
h_key),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
          epoch_data_key_label, 8,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                      NULL, 0,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                      (uint8_t *)(&amp;key-&gt;ci=
pher), key-&gt;cipher_size);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
uint8_t epoch_data_iv_label[] =3D &quot;data_iv&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ovpn_expand_label(epoch_key-&gt;epoc=
h_key, sizeof(epoch_key-&gt;epoch_key),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                      epoch_data_iv_label, 7,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                      NULL, 0=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
    (uint8_t *)(&amp;key-&gt;hmac), key-&gt;hmac_size);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    key-&gt;epoch =3D epoch_key-&gt;epo=
ch;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+epoch_init_send_key_ctx(struct crypto_options *co)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Ensure that we are NEVER regenerating the=
 same key that has already</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * been generated. Since we also reset the packet ID counter thi=
s would be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ca=
tastrophic as we would do IV reuse which breaks ciphers like AES-GCM */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;key_c=
tx_bi.encrypt.epoch !=3D co-&gt;epoch_key_send.epoch);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char name[32] =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(name, sizeof(name)=
, &quot;Epoch Data key %&quot; PRIu16, co-&gt;epoch_key_send.epoch);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct key_parameters send_key =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    epoch_data_key_derive(&amp;send_ke=
y, &amp;co-&gt;epoch_key_send, &amp;co-&gt;epoch_key_type);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    init_key_bi_ctx_send(&amp;co-&gt;key_ctx_bi.encryp=
t, &amp;send_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       &amp;co-&gt;epoch_key_type, name);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;co-&gt;=
packet_id.send);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 CLEAR(send_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+epoch_init_recv_key(struct key_ctx *ctx, struct crypto_options *co=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct key_parameters recv_key =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch=
_data_key_derive(&amp;recv_key, &amp;co-&gt;epoch_key_recv, &amp;co-&gt;epo=
ch_key_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char name[32];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    snprintf(name, sizeof(name), &quot;Epoch =
Data key %&quot; PRIu16, co-&gt;epoch_key_recv.epoch);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    init_key_bi_ctx_recv(ctx, &amp;recv_key, &amp;co-&gt;ep=
och_key_type, name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    CLEAR(recv_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+epoch_generate_future_receive_keys(struct crypto_o=
ptions *co)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We want the number =
of receive keys starting with the currently used</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * keys. */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;key_ctx_bi.initialized);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t current_epoch_=
recv =3D co-&gt;key_ctx_bi.decrypt.epoch;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Either we have not generated any future keys yet or the last</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * index is the same=
 as our current epoch key */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct key_ctx *highest_future_key =3D &amp;co-&gt;epoch_data_=
keys_future[co-&gt;epoch_data_keys_future_count - 1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ASSERT(co-&gt;epoch_key_recv.epoch =3D=3D 1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+           || highest_future_key=
-&gt;epoch =3D=3D co-&gt;epoch_key_recv.epoch);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* free the keys that are not used anymore */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (uint16_t i =3D 0; i &lt; co=
-&gt;epoch_data_keys_future_count; i++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* Keys in future keys are always epoch &gt; 1 if initialised=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (co-&=
gt;epoch_data_keys_future[i].epoch &gt; 0</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &amp;&amp; co-&gt;epoch_data_keys_future[=
i].epoch &lt; current_epoch_recv)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /* Key is old, free it */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            free_key_ctx(&amp;co-&gt;epoch_data_keys_=
future[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Calculate the number of keys that need to be=
 generated,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * i=
f no keys have been generated assume only the first key is defined */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t current_high=
est_key =3D highest_future_key-&gt;epoch ? highest_future_key-&gt;epoch : 1=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t desir=
ed_highest_key =3D current_epoch_recv + co-&gt;epoch_data_keys_future_count=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t num_k=
eys_generate =3D desired_highest_key - current_highest_key;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Move the old keys out of the way so the order of keys stays strict=
ly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * monotonic =
and consecutive. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* first check that the destination we are going to overwrite is freed =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uint16_t=
 i =3D 0; i &lt; num_keys_generate; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ASSERT(co-&gt;epoch_data_keys_future[i].epoch =3D=3D 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    memmove(co-&gt;epoch_data_keys_fu=
ture,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            co=
-&gt;epoch_data_keys_future + num_keys_generate,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            (co-&gt;epoch_data_keys_future_cou=
nt - num_keys_generate) * sizeof(struct key_ctx));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Clear and regenerate the array elements at the end */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uint16_t i =
=3D co-&gt;epoch_data_keys_future_count - num_keys_generate; i &lt; co-&gt;=
epoch_data_keys_future_count; i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        CLEAR(co-&gt;epoch_data_keys_future[i]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        epoch_key_iterate(&amp;co-&gt;epoch_k=
ey_recv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        epoch_init_recv_key(&=
amp;co-&gt;epoch_data_keys_future[i], co);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ass=
ert that all keys are initialised */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (uint16_t i =3D 0; i &lt; co-&gt;epoch_data_keys_f=
uture_count; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(c=
o-&gt;epoch_data_keys_future[i].epoch &gt; 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+epoch_iterate_send_key(struct crypto_op=
tions *co)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(co-&gt;epoch_key=
_send.epoch &lt; UINT16_MAX);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    epoch_key_iterate(&amp;co-&gt;epoch_key_send);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx(&amp;co-&gt;key_c=
tx_bi.encrypt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
epoch_init_send_key_ctx(co);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+epoch_replace_update_recv_key(struct cryp=
to_options *co,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                          uint16_t new_epoch)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Find the key of the new epoch in future keys */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint16_t fki;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (fki =3D 0; fki &lt; co-&g=
t;epoch_data_keys_future_count; fki++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (co-&gt;epoch_data_keys_future[fki].epoch =3D=3D new_epoch)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* we should only ever be called when we successfu=
lly decrypted/authenticated</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * a packet from a peer, ie the epoch recv key *MUST* be in tha=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * array */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(fki &lt; co=
-&gt;epoch_data_keys_future_count);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(co-&gt;epoch_data_keys_future[fki].epoch =3D=3D =
new_epoch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_ctx *new_ctx=
 =3D &amp;co-&gt;epoch_data_keys_future[fki];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Check if the new recv key epoch is higher than the send key e=
poch. If</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * yes =
we will replace the send key as well */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (co-&gt;key_ctx_bi.encrypt.epoch &lt; new_epoch)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        free_key_ctx(&amp;co-&gt;=
key_ctx_bi.encrypt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Update =
the epoch_key for send to match the current key being used.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * This is a bit of extra w=
ork but since we are a maximum of 16</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * keys behind, a maximum 16 HMAC invocations are =
a small price to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * pay for not keeping all the old epoch keys around in future_keys</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * array */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        while (co-&gt;=
epoch_key_send.epoch &lt; new_epoch)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            epoch_key_iterate(&amp;co-&gt;epoch_key_send);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        epoch_init_send_key_ctx(co);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Replace receive key */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free_key_ctx(&amp;co-&gt;epoch_retiring_d=
ata_receive_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  co-&gt;epoch_retiring_data_receive_key =3D co-&gt;key_ctx_bi.decrypt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_move_recv=
(&amp;co-&gt;epoch_retiring_key_pid_recv, &amp;co-&gt;packet_id.rec);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    co-&gt;key_ctx_bi.decrypt =3D *new_ctx;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Zero the old location instead to=
 of free_key_ctx since we moved the keys</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * and do not want to free the pointers in the old=
 place */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset=
(new_ctx, 0, sizeof(struct key_ctx));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Generate new future keys */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    epoch_generate_future_receive_keys(co);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+free_epoch_key=
_ctx(struct crypto_options *co)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (uint16_t i =3D 0; i &lt; co-&gt;epoch_data_keys_future_count; i++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        free_key_ctx(&amp;co-&gt;epoch_=
data_keys_future[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    free(co-&gt;epoch_data_keys=
_future);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_k=
ey_ctx(&amp;co-&gt;epoch_retiring_data_receive_key);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free(co-&gt;epoch_retiring_key_pid_re=
cv.seq_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CL=
EAR(co-&gt;epoch_key_recv);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(co-&gt;epoch_key_send);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+epoch_init_key_ctx(struct cryp=
to_options *co, const struct key_type *key_type,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                   const struct epoch_key *e1_=
send,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     const struct epoch_key *e1_recv,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   uint16_t future_key_count)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(e1_send-&gt;epoch =3D=3D 1 &amp;&amp; =
e1_recv-&gt;epoch =3D=3D 1);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    co-&gt;epoch_key_recv =3D *e1_recv;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    co-&gt;epoch_key_send =3D *e1_send;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    co-&gt;epoch_key_type =3D *key_type;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;aead_usage_li=
mit =3D cipher_get_aead_limits(key_type-&gt;cipher);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    epoch_init_send_key_ctx(co);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    epoch_init_recv_key(&amp;co-&gt;key_ctx_bi.=
decrypt, co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
-&gt;key_ctx_bi.initialized =3D true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   co-&gt;epoch_data_keys_future_count =3D future_key_count;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY_CLEAR(co-&gt;epoch=
_data_keys_future, struct key_ctx, co-&gt;epoch_data_keys_future_count);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_generate_fut=
ure_receive_keys(co);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+const struct key_ctx *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+epoch_lookup_decrypt_key(struct =
crypto_options *opt, uint16_t epoch)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Current decrypt key is the most likely one */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;key_ctx_bi.decrypt.epoch =
=3D=3D epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &amp;=
opt-&gt;key_ctx_bi.decrypt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (opt-&gt;epoch_retiring_data_receive_key.epoch</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; opt-&gt;epoch_ret=
iring_data_receive_key.epoch =3D=3D epoch)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return &amp;opt-&gt;epoch_retiring_data_receive_key;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (epoch &gt; opt-&gt;key_ctx=
_bi.decrypt.epoch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
           &amp;&amp; epoch &lt;=3D opt-&gt;key_ctx_bi.decrypt.epoch + opt-=
&gt;epoch_data_keys_future_count)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* Key in the range of future keys */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        int index =3D epoch - (opt-&gt;key_ctx_bi=
.decrypt.epoch + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* If we h=
ave reached the edge of the valid keys we do not return</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * the key anymore since regene=
rating the new keys would move us</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * over the window of valid keys and would need all k=
ind of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * sp=
ecial casing, so we stop returning the key in this case */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (epoch &gt; (UINT16_MAX -=
 opt-&gt;epoch_data_keys_future_count - 1))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return &amp;opt-&gt;epoch_data_keys_future[index];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_check_send_iterat=
e(struct crypto_options *opt)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
opt-&gt;epoch_key_send.epoch =3D=3D UINT16_MAX)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* limit of epoch keys reached, cannot move to a newe=
r key anymore */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;aead_=
usage_limit)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (aead_usag=
e_limit_reached(opt-&gt;aead_usage_limit, &amp;opt-&gt;key_ctx_bi.encrypt,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                 opt-&gt;packet_id.send.id))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* Send key limit reached */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            epoch_iterate_send_key(opt)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* draft 8 of the ae=
ad usage limit still had but draft 9 complete</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * dropped this statement:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         *    In particular, is two-party=
 communication, one participant cannot</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         *    regard apparent overuse of a key by other =
participants as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     *    being in error, when it could be that the other participant has</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *    better =
information about bounds.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * OpenVPN 2.x implements a compromise of not regarding this as an</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * error but st=
ill accepting packets of the usage limit but tries to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * push the peer to a new epoch k=
ey by increasing our own key epoch</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else if (opt-&gt;key_ctx_bi.encrypt.epoch =3D=3D opt-&gt;k=
ey_ctx_bi.decrypt.epoch</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 &amp;&amp; aead_usage_limit_reached(opt-&gt;aead_usage=
_limit,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                 &amp;opt-&gt;key_ctx_bi.decrypt,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                opt-&gt;packet_id.rec.id))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            /* Receive key limit reached. Increase our own sen=
d key to signal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * that we want to use a new epoch. Peer should then also move its<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * key b=
ut is not required to do this */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            epoch_iterate_send_key(opt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o=
pt-&gt;packet_id.send.id =3D=3D PACKET_ID_EPOCH_MAX)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        epoch_iterate_send_key(opt);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span>diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn=
/crypto_epoch.h</span><br><span>index dad2473..95d8e9e 100644</span><br><sp=
an>--- a/src/openvpn/crypto_epoch.h</span><br><span>+++ b/src/openvpn/crypt=
o_epoch.h</span><br><span>@@ -66,4 +66,81 @@</span><br><span>              =
     const uint8_t *context, size_t context_len,</span><br><span>          =
         uint8_t *out, uint16_t out_len);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Generate a data channel key pair from the epoch key</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param epoch_key     Epoch k=
ey to be used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram key          Destination for the generated data key</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @parm kt             Cipher informat=
ion to generate the data channel key for</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_data=
_key_derive(struct key_parameters *key,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                      const struct epoch_key *epoch_key=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
    const struct key_type *kt);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Generates and fills =
the epoch_data_keys_future with next valid</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * future keys in crypto_options</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * This assume that the normal key_ctx_bi and epoch keys=
 are already setup</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+epoch_generate_future_receive_ke=
ys(struct crypto_options *co);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/** This is called when the=
 peer using a new send key that is not the default</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * key. This function ensures the following:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - recv key match=
es the epoch index provided</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * - send key epoch is equal or higher than recv_key epoch</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param new_epoch the new epoch to use a th=
e receive key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+epoch_replace_update_recv_key(struct =
crypto_options *co,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                              uint16_t new_epoch);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * U=
pdates the send key and send_epoch_keyt in cryptio_options-&gt;key_ctx_bi t=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * use the next ep=
och */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+epoch_iterate_send_key(struc=
t crypto_options *co);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Frees the extra data structur=
es used by epoch keys in \c crypto_options</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+free_epo=
ch_key_ctx(struct crypto_options *co);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initialises d=
ata channel keys and internal structures for epoch data keys</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * using the provided E0 epoch key=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param e1_send    The E1 send epo=
ch key derived by TLS-EKM</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param e1_recv    The E1 receive epoch key derived by TLS-EKM</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+epoch_init_key_ctx(struct crypto_options *co, const str=
uct key_type *key_type,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   const struct epoch_key *e1_send, const struct epoch_=
key *e1_recv,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
             uint16_t future_key_count);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Using an ep=
och, this function will try to retrieve a decryption</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * key context that matches that epoch fr=
om the \c opt argument</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param opt       crypto_options to use to find the decrypt key</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param epoch     epoch =
of the key to lookup</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return          the key context with</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+const struct key_ctx *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+epoch_lookup_decrypt_key(struct crypto_options *opt, uint16_t epoc=
h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Checks if we need to iterate the send epoch key.=
 This needs to be in one</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * of the following condition</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  - max epoch counter reached</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  - send key aead usage limit reached (for AES=
-GCM and similar ciphers)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  - recv key usage limit reached</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+epoch_chec=
k_send_iterate(struct crypto_options *opt);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifnd=
ef CRYPTO_EPOCH_H */</span><br><span>diff --git a/src/openvpn/packet_id.c b=
/src/openvpn/packet_id.c</span><br><span>index 8cde108..177391a 100644</spa=
n><br><span>--- a/src/openvpn/packet_id.c</span><br><span>+++ b/src/openvpn=
/packet_id.c</span><br><span>@@ -78,6 +78,21 @@</span><br><span> }</span><b=
r><span> </span><br><span> void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrac=
k, int time_backtrack, const char *name, int unit)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    rec-&gt;name =3D name;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    rec-&gt;unit =3D unit;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (seq_backtrack)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ASSERT(MIN_SEQ_BACKTRACK &lt;=3D seq_backtrack &amp=
;&amp; seq_backtrack &lt;=3D MAX_SEQ_BACKTRACK);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ASSERT(MIN_TIME_BACKTRACK &lt;=3D time=
_backtrack &amp;&amp; time_backtrack &lt;=3D MAX_TIME_BACKTRACK);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        CIRC_LIST_ALLOC(rec-&=
gt;seq_list, struct seq_list, seq_backtrack);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        rec-&gt;seq_backtrack =3D seq_backtrack;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rec-&gt;time=
_backtrack =3D time_backtrack;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 rec-&gt;initialized =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span> packet_id_init(struct packet_id *p, int seq_backtrack, int t=
ime_backtrack, const char *name, int unit)</span><br><span> {</span><br><sp=
an>     dmsg(D_PID_DEBUG, &quot;PID packet_id_init seq_backtrack=3D%d time_=
backtrack=3D%d&quot;,</span><br><span>@@ -87,17 +102,25 @@</span><br><span>=
     ASSERT(p);</span><br><span>     CLEAR(*p);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;rec.name =3D name;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;rec.unit =3D u=
nit;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (seq_backt=
rack)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(MIN_SEQ_BACKTRACK=
 &lt;=3D seq_backtrack &amp;&amp; seq_backtrack &lt;=3D MAX_SEQ_BACKTRACK);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(MIN_TI=
ME_BACKTRACK &lt;=3D time_backtrack &amp;&amp; time_backtrack &lt;=3D MAX_T=
IME_BACKTRACK);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  CIRC_LIST_ALLOC(p-&gt;rec.seq_list, struct seq_list, seq_backtrack);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        p-&gt;rec.seq_back=
track =3D seq_backtrack;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        p-&gt;rec.time_backtrack =3D time_backtrack;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    p-&gt;rec.initialized =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    packet_id_init_recv(&amp;p-&gt;rec, s=
eq_backtrack, time_backtrack, name, unit);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+packet_id_move_recv(struct pa=
cket_id_rec *dest, struct packet_id_rec *src)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(src);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ASSERT(dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* clear free any old data in rec list */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    free(dest-&gt;seq_list);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*dest);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Copy data to dest */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    *dest =3D *src;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Reinitalise the source */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    CLEAR(*src);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    packet_id_init_recv(src, dest-&gt;seq_backtrack, dest-&=
gt;time_backtrack,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       dest-&gt;name, dest-&gt;unit);</span><br><span> }</s=
pan><br><span> </span><br><span> void</span><br><span>diff --git a/src/open=
vpn/packet_id.h b/src/openvpn/packet_id.h</span><br><span>index 79224d2..76=
20ce5 100644</span><br><span>--- a/src/openvpn/packet_id.h</span><br><span>=
+++ b/src/openvpn/packet_id.h</span><br><span>@@ -203,6 +203,15 @@</span><b=
r><span> </span><br><span> void packet_id_free(struct packet_id *p);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Move the packet id re=
cv structure from src to dest. src will will</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * be reinitialised with</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param dest</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param src</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+packet_id_mo=
ve_recv(struct packet_id_rec *dest, struct packet_id_rec *src);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* should we =
accept an incoming packet id ? */</span><br><span> bool packet_id_test(stru=
ct packet_id_rec *p,</span><br><span>                     const struct pack=
et_id_net *pin);</span><br><span>diff --git a/src/openvpn/ssl_common.h b/sr=
c/openvpn/ssl_common.h</span><br><span>index ce1cd9e..511127d 100644</span>=
<br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/=
ssl_common.h</span><br><span>@@ -333,8 +333,8 @@</span><br><span>     inter=
val_t packet_timeout;</span><br><span>     int64_t renegotiate_bytes;</span=
><br><span>     int64_t renegotiate_packets;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /** This limit for AEAD cipher, this is the sum =
of packets + blocks</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * that are allowed to be used */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /** This limit for AEAD cipher when not running in epoc=
h data key mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * this is the sum of packets + blocks that are allowed to be used */</spa=
n><br><span>     int64_t aead_usage_limit;</span><br><span>     interval_t =
renegotiate_seconds;</span><br><span> </span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</s=
pan><br><span>index c8d2a10..54a6caa 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_crypto.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_crypto.c</span><br><span>@@ -575,7 +575,7 @@</span><br><span>      0=
x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,</span><br><span>      0x22, =
0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t *label =3D (const =
uint8_t *)(&quot;unit test&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const uint8_t *label =3D (const uint8_t *) (&quot;unit t=
est&quot;);</span><br><span>     uint8_t out[16];</span><br><span>     ovpn=
_expand_label(secret, sizeof(secret), label, 9, NULL, 0, out, sizeof(out));=
</span><br><span> </span><br><span>@@ -586,9 +586,238 @@</span><br><span>  =
   assert_memory_equal(out, out_expected, 16);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct epoc=
h_test_state</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_type kt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto=
_options co;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+crypto_test_epoch_setup(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int *num_future_keys =3D (int *)*state;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct epoch_test_stat=
e *data =3D calloc(1, sizeof(struct epoch_test_state));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    data-&gt;gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    init_key_type(&amp;data-&gt;kt, &quot;AES-128-GCM&quot;, &quot;=
none&quot;, true, false);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* have a=
n epoch key that is uses 0x23 for the key for all bytes */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct epoch_key epoch1send =3D =
{ .epoch =3D 1, .epoch_key =3D {0x23} };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct epoch_key epoch1recv =3D { .epoch =3D 1, .e=
poch_key =3D {0x27} };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_init_k=
ey_ctx(&amp;data-&gt;co, &amp;data-&gt;kt, &amp;epoch1send,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                       &amp;epoch1r=
ecv, *num_future_keys);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *state =3D =
data;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+crypto_test_epoch_teardown(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct epoch_test_state *data =3D *state;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free_epoch_key_ctx(&amp;data-&gt;=
co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ct=
x_bi(&amp;data-&gt;co.key_ctx_bi);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;data-&gt;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    free(*state);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+crypto_test_epoch_key_generation(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct epoch_test_sta=
te *data =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct crypto_options *co =3D &amp;data-&gt;co;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* check the keys look like expect */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_data=
_keys_future[0].epoch, 2);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(co-&gt;epoch_data_keys_future[15].epoch, 17);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
co-&gt;epoch_key_send.epoch, 1);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(co-&gt;epoch_key_recv.epoch, 17);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Now replace the recv key with the 6th f=
uture key (epoch =3D 8) */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free_key_ctx(&amp;co-&gt;key_ctx_bi.decrypt);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_data=
_keys_future[6].epoch, 8);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    co-&gt;key_ctx_bi.decrypt =3D co-&gt;epoch_data_keys_future[6];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(co-&gt;epo=
ch_data_keys_future[6]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_gene=
rate_future_receive_keys(co);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(co-&gt;epoch_data_keys_future[0].epoch, 9);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(co-&gt;epoch_data_keys_future[15].epoch, 24);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+crypto_test_epoch_key_rotation(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct epoch_test_state *data =3D=
 *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
crypto_options *co =3D &amp;data-&gt;co;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* should replace send + key recv */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    epoch_replace_update_recv_key(co, 9);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.decrypt.ep=
och, 9);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(co-&gt;key_ctx_bi.encrypt.epoch, 9);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_key_send.epoch=
, 9);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(co-&gt;epoch_retiring_data_receive_key.epoch, 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Iterate the data send key four times to get it to =
13 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i=
 =3D 0; i &lt; 4; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        epo=
ch_iterate_send_key(co);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, 13);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    epoch_replace_update_recv_key(co, 10);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.de=
crypt.epoch, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, 13);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;epoch_key_=
send.epoch, 13);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(co-&gt;epoch_retiring_data_receive_key.epoch, 9);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    epoch_replace_update_recv_key(co, 12);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(co=
-&gt;key_ctx_bi.decrypt.epoch, 12);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, 13);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(co-&gt;epoch_key_send.epoch, 13);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(co-&gt;epoch_retiring_data_receive_key.=
epoch, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_iterate_send_key(=
co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(co-&gt;key_ctx_bi.encrypt.epoch, 14);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_epoch_key_receiv=
e_lookup(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct epoc=
h_test_state *data =3D *state;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct crypto_options *co =3D &amp;data-&gt;co;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* lookup some wacky things that should fail */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epo=
ch_lookup_decrypt_key(co, 2000));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, -1));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_d=
ecrypt_key(co, 0xefff));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Lookup =
the edges of the current window */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 0));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_loo=
kup_decrypt_key(co, 1)-&gt;epoch, 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, 2)-&gt;=
epoch, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(epoch_lookup_decrypt_key(co, 13)-&gt;epoch, 13);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_=
decrypt_key(co, 14)-&gt;epoch, 14);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 15));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Should move 1 to retiring key but leave =
1-5 undefined, 7 as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * active and 8-20 as future keys*/</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    epoch_replace_update_recv_key(co, 7);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 0));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(e=
poch_lookup_decrypt_key(co, 1)-&gt;epoch, 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 2));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epo=
ch_lookup_decrypt_key(co, 3));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 4));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decry=
pt_key(co, 5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_null(epoch_lookup_decrypt_key(co, 6));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key(co,=
 7)-&gt;epoch, 7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(epoch_lookup_decrypt_key(co, 8)-&gt;epoch, 8);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_l=
ookup_decrypt_key(co, 20)-&gt;epoch, 20);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 21));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_=
lookup_decrypt_key(co, 22));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Should move 7 to retir=
ing key and have 8 as active key and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * 9-21 as future keys */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    epoch_replace_update_recv_key(co, 8);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_look=
up_decrypt_key(co, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_null(epoch_lookup_decrypt_key(co, 1));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(=
co, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
null(epoch_lookup_decrypt_key(co, 3));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, 4));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_look=
up_decrypt_key(co, 5));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_null(epoch_lookup_decrypt_key(co, 6));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt=
_key(co, 7)-&gt;epoch, 7);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(epoch_lookup_decrypt_key(co, 8)-&gt;epoch, 8);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(epoch_lookup_decrypt_key(co, 20)-&gt;epoch, 20);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(epoch_lookup_decrypt_key=
(co, 21)-&gt;epoch, 21);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_null(epoch_lookup_decrypt_key(co, 22));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_ke=
y(co, 23));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+crypto_test_epoch_key_overflow(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct epoch_test_state *data =3D *state;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto_options *=
co =3D &amp;data-&gt;co;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Modify =
the receive epoch and keys to have a very high epoch to test</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * the end of array. Iterating=
 through all 16k keys takes a 2-3s, so we</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * avoid this for the unit test */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;key_ctx_bi.decrypt.epoc=
h =3D 16000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-=
&gt;key_ctx_bi.encrypt.epoch =3D 16000;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    co-&gt;epoch_key_send.epoch =3D 16000;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    co-&gt;epoch_key_recv.epoch =3D 16000 + co-&gt;=
epoch_data_keys_future_count;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
uint16_t i =3D 0; i &lt; co-&gt;epoch_data_keys_future_count; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        co-&gt;epoch_data_keys_future[i].=
epoch =3D 16001 + i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Move the last few keys un=
til we are close to the limit */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    while (co-&gt;key_ctx_bi.decrypt.epoch &lt; (UINT16_MAX - =
40))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        epoch_replace_update_=
recv_key(co, co-&gt;key_ctx_bi.decrypt.epoch + 10);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Looking up this key should still work as it will not break the limi=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * when genera=
ting keys */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 34)-&gt;epoch, UINT=
16_MAX - 34);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(epoch_lookup_decrypt_key(co, UINT16_MAX - 33)-&gt;epoch, UIN=
T16_MAX - 33);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This key is no lo=
nger eligible for decrypting as the 32 future keys</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * would be larger than uint16_t maximum=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(=
epoch_lookup_decrypt_key(co, UINT16_MAX - 32));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, UI=
NT16_MAX));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check that moving to=
 the last possible epoch works */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    epoch_replace_update_recv_key(co, UINT16_MAX - 33);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(epoc=
h_lookup_decrypt_key(co, UINT16_MAX - 33)-&gt;epoch, UINT16_MAX - 33);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(epoch_lo=
okup_decrypt_key(co, UINT16_MAX - 32));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+epoch_test_derive_data_key(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct epoch_key e17 =3D { .epoch =3D 17, .epoch_key =3D { 19=
, 12 }};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
key_type kt =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct key_parameters key_parameters =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;kt, &quot;AES-192=
-GCM&quot;, &quot;none&quot;, true, false);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    epoch_data=
_key_derive(&amp;key_parameters, &amp;e17, &amp;kt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(key_parameters.cipher_size, 24);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(key_p=
arameters.hmac_size, 12);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t e=
xp_cipherkey[24] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {0x00, 0x62, 0x84, 0xcb, 0x31, 0x57, 0xc7, 0x97,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     0x8d, 0xe8, 0xfb, 0x6e, 0xdc, 0x60, =
0x38, 0xc3,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0xa=
4, 0xb9, 0xa1, 0xea, 0xf4, 0x01, 0x86, 0xbc };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint8_t exp_impl_iv[12] =3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    { 0xb4, 0x32, 0xeb, 0x4e, 0x61, 0x4b, 0xa2, 0xf3,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      0x5d, 0x86, 0x2=
2, 0x1f  };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(key=
_parameters.cipher, exp_cipherkey, sizeof(exp_cipherkey));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(key_paramete=
rs.hmac, exp_impl_iv, sizeof(exp_impl_iv));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> int</span><br><span> main(void)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int prestate_num=
13 =3D 13;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int p=
restate_num16 =3D 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int prestate_num32 =3D 32;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     openvpn_unit_test_setup();</span><br><sp=
an>     const struct CMUnitTest tests[] =3D {</span><br><span>         cmoc=
ka_unit_test(crypto_pem_encode_decode_loopback),</span><br><span>@@ -602,6 =
+831,23 @@</span><br><span>         cmocka_unit_test(crypto_test_hkdf_expan=
d_testa2),</span><br><span>         cmocka_unit_test(crypto_test_hkdf_expan=
d_testa3),</span><br><span>         cmocka_unit_test(crypto_test_ovpn_label=
_expand),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_generation,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                           crypto_test_epoch_setup,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
        crypto_test_epoch_teardown,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                                 &amp;prest=
ate_num16),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_rotation,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                           crypto_test_epoch_setup,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
        crypto_test_epoch_teardown,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                                 &amp;prest=
ate_num13),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_receive_look=
up,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                                 crypto_test_epoch_setup,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
            crypto_test_epoch_teardown,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                                 &amp;p=
restate_num13),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_overflow=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                               crypto_test_epoch_setup,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
          crypto_test_epoch_teardown,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                                 &amp;pre=
state_num32),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(epoch_test_derive_data_key)</span><br><span>     };</spa=
n><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/804?usp=3Demail">change 804</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
04?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc=
62175820e9b80 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 804 </div>
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


--UKKifhIs9UY=--

