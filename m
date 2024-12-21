From: Gert Doering <gert@...1296...>
Date: Sat, 21 Dec 2024 16:37:30 +0100
Message-ID: <20241221153731.1755-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v14] Trigger renegotiation of data key if
 getting close to the AEAD usage limit
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

This implements the limitation of AEAD key usage[1] with a confidentiality
margin of 2^-57, the same as TLS 1.3.  In this implementation, unlike
TLS 1.3 that counts the number of records, we count the actual number of
packets and plaintext blocks. TLS 1.3 can reasonable assume that for
large data transfers, full records are used and therefore the maximum
record size of 2**14 (2*10 blocks) is used to calculate the number of
records before a new key needs to be used.

For a VPN like OpenVPN, the same calculation would either require using a
pessimistic assumption of using a MTU size of 65k which limits us to
2^24 packets, which equals only 24 GB with more common MTU/MSS of 1400
or requiring a dynamic calculation which includes the actual MTU that
we allow to send. For 1500 the calculation yields 2*29.4 which is a
quite significant higher number of packets (923 GB at 1400 MSS/MTU).

To avoid this dynamic calculation and also avoid needing to know the
MSS/MTU size in the crypto layer, this implementation foregoes the
simplification of counting just packets but will count blocks and packets
instead and determines the limit from that.

This also has the side effect that connections with a lot of small packets
(like TCP ACKs) mixed with large packets will be able to keep using the same
key much longer until requiring a renegotiation.

This patch will set the limit where to trigger the renegotiation at 7/8
of the recommended maximum value.

[1]  https://www.ietf.org/archive/id/draft-irtf-cfrg-aead-limits-08.html

Testing instructions:

The easiest way to test if this patch works as
intended is to manually change the return value of cipher_get_aead_limits
to some silly low value like 2048. After a bit of VPN traffic, a soft
reset should occur that indicates being over the

    TLS: soft reset sec=41/3600 bytes=59720/-1 pkts=78/0 aead_limit_send=1883/1792 aead_limit_recv=1937/1792

Here the send limit is over the limit (1792 = 2048 * 8/7).

Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/796
This mail reflects revision 14 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Changes.rst b/Changes.rst
index a6cc3be..34542a5 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -22,6 +22,14 @@
 
     For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwipovpn).
 
+Enforcement of AES-GCM usage limit
+    OpenVPN will now enforce the usage limits on AES-GCM with the same
+    confidentiality margin as TLS 1.3 does. This mean that renegotiation will
+    be triggered after roughly 2^28 to 2^31 packets depending of the packet
+    size. More details about usage limit of AES-GCM can be found here:
+
+    https://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d548c8d..faf69fc 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -138,6 +138,11 @@
     ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)));
     ASSERT(buf_inc_len(&work, outlen));
 
+    /* update number of plaintext blocks encrypted. Use the (x + (n-1))/n trick
+     * to round up the result to the number of blocks used */
+    const int blocksize = AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.encrypt.plaintext_blocks += (outlen + (blocksize - 1))/blocksize;
+
     /* Flush the encryption buffer */
     ASSERT(cipher_ctx_final(ctx->cipher, BEND(&work), &outlen));
     ASSERT(buf_inc_len(&work, outlen));
@@ -325,6 +330,37 @@
     }
 }
 
+uint64_t
+cipher_get_aead_limits(const char *ciphername)
+{
+    if (!cipher_kt_mode_aead(ciphername))
+    {
+        return 0;
+    }
+
+    if (cipher_kt_name(ciphername) == cipher_kt_name("CHACHA20-POLY1305"))
+    {
+        return 0;
+    }
+
+    /* Assume all other ciphers require the limit */
+
+    /* We focus here on the equation
+     *
+     *       q + s <= p^(1/2) * 2^(129/2) - 1
+     *
+     * as is the one that is limiting us.
+     *
+     *  With p = 2^-57 this becomes
+     *
+     *      q + s <= (2^36 - 1)
+     *
+     */
+    uint64_t rs = (1ull << 36) - 1;
+
+    return rs;
+}
+
 bool
 crypto_check_replay(struct crypto_options *opt,
                     const struct packet_id_net *pin, const char *error_prefix,
@@ -487,6 +523,12 @@
         goto error_exit;
     }
 
+
+    /* update number of plaintext blocks decrypted. Use the (x + (n-1))/n trick
+     * to round up the result to the number of blocks used. */
+    const int blocksize = AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.decrypt.plaintext_blocks += (outlen + (blocksize - 1))/blocksize;
+
     *buf = work;
 
     gc_free(&gc);
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 04d7bb2..4579b65 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -177,6 +177,10 @@
     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
     /**< The implicit part of the IV */
     size_t implicit_iv_len;     /**< The length of implicit_iv */
+    /** Counter for the number of plaintext block encrypted using this cipher
+     * with the current key in number of 128 bit blocks (only used for
+     * AEAD ciphers) */
+    uint64_t plaintext_blocks;
 };
 
 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -607,6 +611,25 @@
 }
 
 /**
+ * Check if the cipher is an AEAD cipher and needs to be limited to a certain
+ * number of number of blocks + packets. Return 0 if ciphername is not an AEAD
+ * cipher or no limit (e.g. Chacha20-Poly1305) is needed. (Or the limit is
+ * larger than 2^64)
+ *
+ * For reference see the OpenVPN RFC draft and
+ * https://www.ietf.org/archive/id/draft-irtf-cfrg-aead-limits-08.html
+ */
+uint64_t
+cipher_get_aead_limits(const char *ciphername);
+
+/**
+ * Blocksize used for the AEAD limit caluclation
+ *
+ * Since cipher_ctx_block_size() is not reliable and will return 1 in many
+ * cases use a hardcoded blocksize instead */
+#define     AEAD_LIMIT_BLOCKSIZE    16
+
+/**
  * Checks if the current TLS library supports the TLS 1.0 PRF with MD5+SHA1
  * that OpenVPN uses when TLS Keying Material Export is not available.
  *
@@ -614,4 +637,20 @@
  */
 bool check_tls_prf_working(void);
 
+/**
+ * Checks if the usage limit for an AEAD cipher is reached
+ *
+ * This method abstracts the calculation to make the calling function easier
+ * to read.
+ */
+static inline bool
+aead_usage_limit_reached(const uint64_t limit, const struct key_ctx *key_ctx,
+                         int64_t higest_pid)
+{
+    /* This is the  q + s <=  p^(1/2) * 2^(129/2) - 1 calculation where
+     * q is the number of protected messages (highest_pid)
+     * s Total plaintext length in all messages (in blocks) */
+    return (limit > 0 && key_ctx->plaintext_blocks + (uint64_t) higest_pid > limit);
+}
+
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index fcfb344..c77c4ed 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -131,6 +131,26 @@
     }
 }
 
+static uint64_t
+tls_get_limit_aead(const char *ciphername)
+{
+    uint64_t limit = cipher_get_aead_limits(ciphername);
+
+    if (limit == 0)
+    {
+        return 0;
+    }
+
+    /* set limit to 7/8 of the limit so the renegotiation can succeed before
+     * we go over the limit */
+    limit = limit/8 * 7;
+
+    msg(D_SHOW_KEYS, "Note: AEAD cipher %s will trigger a renegotiation"
+        " at a sum of %" PRIi64 " blocks and packets.",
+        ciphername, limit);
+    return limit;
+}
+
 void
 tls_init_control_channel_frame_parameters(struct frame *frame, int tls_mtu)
 {
@@ -1579,6 +1599,8 @@
     tls_limit_reneg_bytes(session->opt->key_type.cipher,
                           &session->opt->renegotiate_bytes);
 
+    session->opt->aead_usage_limit = tls_get_limit_aead(session->opt->key_type.cipher);
+
     /* set the state of the keys for the session to generated */
     ks->state = S_GENERATED_KEYS;
 
@@ -2999,6 +3021,27 @@
         return true;
     }
 
+    /* Check the AEAD usage limit of cleartext blocks + packets.
+     *
+     *  Contrary to when epoch data mode is active, where only the sender side
+     *  checks the limit, here we check both receive and send limit since
+     *  we assume that only one side is aware of the limit.
+     *
+     *  Since if both sides were aware, then both sides will probably also
+     *  switch to use epoch data channel instead, so this code is not
+     *  in effect then.
+     */
+    const struct key_ctx_bi *key_ctx_bi = &ks->crypto_options.key_ctx_bi;
+    const uint64_t usage_limit = session->opt->aead_usage_limit;
+
+    if (aead_usage_limit_reached(usage_limit, &key_ctx_bi->encrypt,
+                                 ks->crypto_options.packet_id.send.id)
+        || aead_usage_limit_reached(usage_limit, &key_ctx_bi->decrypt,
+                                    ks->crypto_options.packet_id.rec.id))
+    {
+        return true;
+    }
+
     return false;
 }
 /*
@@ -3031,10 +3074,17 @@
         && should_trigger_renegotiation(session, ks))
     {
         msg(D_TLS_DEBUG_LOW, "TLS: soft reset sec=%d/%d bytes=" counter_format
-            "/%" PRIi64 " pkts=" counter_format "/%" PRIi64,
+            "/%" PRIi64 " pkts=" counter_format "/%" PRIi64
+            " aead_limit_send=%" PRIu64 "/%" PRIu64
+            " aead_limit_recv=%" PRIu64 "/%" PRIu64,
             (int) (now - ks->established), session->opt->renegotiate_seconds,
             ks->n_bytes, session->opt->renegotiate_bytes,
-            ks->n_packets, session->opt->renegotiate_packets);
+            ks->n_packets, session->opt->renegotiate_packets,
+            ks->crypto_options.key_ctx_bi.encrypt.plaintext_blocks + ks->n_packets,
+            session->opt->aead_usage_limit,
+            ks->crypto_options.key_ctx_bi.decrypt.plaintext_blocks + ks->n_packets,
+            session->opt->aead_usage_limit
+            );
         key_state_soft_reset(session);
     }
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 5840e2d..ccbc053 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -333,6 +333,9 @@
     interval_t packet_timeout;
     int64_t renegotiate_bytes;
     int64_t renegotiate_packets;
+    /** limit for AEAD cipher, this is the sum of packets + blocks
+     * that are allowed to be used */
+    uint64_t aead_usage_limit;
     interval_t renegotiate_seconds;
 
     /* cert verification parms */
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index fdc8fbd..ec8e661 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -448,6 +448,29 @@
     gc_free(&gc);
 }
 
+void
+crypto_test_aead_limits(void **state)
+{
+    /* if ChaCha20-Poly1305 is not supported by the crypto library or in the
+     * current mode (FIPS), this will still return -1 */
+    assert_int_equal(cipher_get_aead_limits("CHACHA20-POLY1305"), 0);
+
+    int64_t aeslimit = cipher_get_aead_limits("AES-128-GCM");
+
+    assert_int_equal(aeslimit, (1ull << 36) - 1);
+
+    /* Check if this matches our exception for 1600 size packets assuming
+     * AEAD_LIMIT_BLOCKSIZE (128 bits/ 16 bytes). Gives us 100 blocks
+     * + 1 for the packet */
+    int64_t L = 101;
+    /* 2 ^ 29.34, using the result here to avoid linking to libm */
+    assert_int_equal(aeslimit / L, 680390858);
+
+    /* and for 9000, 2^26.86 */
+    L = 563;
+    assert_int_equal(aeslimit / L, 122059461);
+}
+
 int
 main(void)
 {
@@ -458,7 +481,8 @@
         cmocka_unit_test(crypto_test_tls_prf),
         cmocka_unit_test(crypto_test_hmac),
         cmocka_unit_test(test_occ_mtu_calculation),
-        cmocka_unit_test(test_mssfix_mtu_calculation)
+        cmocka_unit_test(test_mssfix_mtu_calculation),
+        cmocka_unit_test(crypto_test_aead_limits)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

