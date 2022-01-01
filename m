From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jan 2022 17:25:20 +0100
Message-Id: <20220101162532.2251835-3-arne@...1227...>
In-Reply-To: <20220101162532.2251835-1-arne@...1227...>
References: <20220101162532.2251835-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 02/14] Fix mssfix and frame calculation
 in CBC mode
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

This commit fixes the MSS calculation in CBC mode. This fix has two parts:

- Added rounding to a multiple of block size during calculation of overhead
- In CBC mode the packet ID is part of the plaintext (or payload) rather
  than part of the header (like for AEAD), adjust the functions to
  correctly reflect this.

OCC link calculation is not affected since it ignores rounding of CBC
block size completely.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c                   | 18 ++----
 src/openvpn/crypto.h                   | 14 ++---
 src/openvpn/integer.h                  |  9 +++
 src/openvpn/mss.c                      | 40 +++++++++---
 src/openvpn/mtu.c                      | 59 +++++++++++++-----
 src/openvpn/mtu.h                      | 39 +++++++-----
 tests/unit_tests/openvpn/test_crypto.c | 86 +++++++++++++++++++++++++-
 7 files changed, 203 insertions(+), 62 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5626e2b6..05a2c6be 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -209,7 +209,7 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
                 ASSERT(0);
             }
 
-            /* set the IV pseudo-randomly */
+            /* write the pseudo-randomly IV (CBC)/packet ID (OFB/CFB) */
             ASSERT(buf_write(&work, iv_buf, iv_size));
             dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
 
@@ -669,17 +669,15 @@ openvpn_decrypt(struct buffer *buf, struct buffer work,
 
 unsigned int
 calculate_crypto_overhead(const struct key_type *kt,
-                          bool packet_id,
-                          bool packet_id_long_form,
-                          unsigned int payload_size,
+                          unsigned int pkt_id_size,
                           bool occ)
 {
     unsigned int crypto_overhead = 0;
 
-    /* We always have a packet id, no matter if encrypted or unencrypted */
-    if (packet_id)
+    if (!cipher_kt_mode_cbc(kt->cipher))
     {
-        crypto_overhead += packet_id_size(packet_id_long_form);
+        /* In CBC mode, the packet id is part of the payload size/overhead */
+        crypto_overhead += pkt_id_size;
     }
 
     if (cipher_kt_mode_aead(kt->cipher))
@@ -702,11 +700,7 @@ calculate_crypto_overhead(const struct key_type *kt,
         if (cipher_defined(kt->cipher))
         {
             /* CBC, OFB or CFB mode */
-            /* This is a worst case upper bound of needing to add
-             * a full extra block for padding when the payload
-             * is exactly a multiple of the block size */
-            if (occ || (cipher_kt_mode_cbc(kt->cipher) &&
-                (payload_size % cipher_kt_block_size(kt->cipher) == 0)))
+            if (occ)
             {
                 crypto_overhead += cipher_kt_block_size(kt->cipher);
             }
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 5a67b7ac..43241b86 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -418,20 +418,20 @@ void crypto_adjust_frame_parameters(struct frame *frame,
 /** Calculate the maximum overhead that our encryption has
  * on a packet. This does not include needed additional buffer size
  *
+ * This does NOT include the padding and rounding of CBC size
+ * as the users (mssfix/fragment) of this function need to adjust for
+ * this and add it themselves.
+ *
  * @param kt            Struct with the crypto algorithm to use
- * @param packet_id     Whether packet_id is used
- * @param packet_id_long_form Whether the packet id has the long form
- * @param payload_size   payload size, only used if occ is false
+ * @param packet_id_size Size of the packet id, can be 0 if no-replay is used
  * @param occ           if true calculates the overhead for crypto in the same
  *                      incorrect way as all previous OpenVPN versions did, to
  *                      end up with identical numbers for OCC compatibility
  */
 unsigned int
 calculate_crypto_overhead(const struct key_type *kt,
-                           bool packet_id,
-                           bool packet_id_long_form,
-                           unsigned int payload_size,
-                           bool occ);
+                          unsigned int pkt_id_size,
+                          bool occ);
 
 /** Return the worst-case OpenVPN crypto overhead (in bytes) */
 unsigned int crypto_max_overhead(void);
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 8b041f22..8770f701 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -185,4 +185,13 @@ index_verify(int index, int size, const char *file, int line)
     return index;
 }
 
+/**
+ * Rounds down num to the nearest multiple of multiple
+ */
+static inline unsigned int
+round_down_uint(unsigned int num, unsigned int multiple)
+{
+    return (num / multiple) * multiple;
+}
+
 #endif /* ifndef INTEGER_H */
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 852ef541..3007cc52 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -207,6 +207,26 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
     }
 }
 
+static inline unsigned int
+adjust_payload_max_cbc(const struct key_type *kt, unsigned int target)
+{
+    if (!cipher_kt_mode_cbc(kt->cipher))
+    {
+        /* With stream ciphers (or block cipher in stream modes like CFB, AEAD)
+         * we can just subtract use the target as is */
+        return target;
+    }
+    else
+    {
+        /* With CBC we need at least one extra byte for padding and then need
+         * to ensure that the resulting CBC ciphertext length, which is always
+         * a multiple of the block size, is not larger than the target value */
+        unsigned int block_size = cipher_kt_block_size(kt->cipher);
+        target = round_down_uint(target, block_size);
+        return target - 1;
+    }
+}
+
 void
 frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
                        const struct options *options)
@@ -216,18 +236,13 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
         return;
     }
 
-    unsigned int payload_size;
-    unsigned int overhead;
-
-
-    payload_size = frame_calculate_payload_size(frame, options);
+    unsigned int overhead, payload_overhead;
 
-    overhead = frame_calculate_protocol_header_size(kt, options,
-                                                    payload_size, false);
+    overhead = frame_calculate_protocol_header_size(kt, options, false);
 
     /* Calculate the number of bytes that the payload differs from the payload
      * MTU. This are fragment/compression/ethernet headers */
-    unsigned payload_overhead = frame_calculate_payload_overhead(frame, options, true);
+    payload_overhead = frame_calculate_payload_overhead(frame, options, kt, true);
 
     /* We are in a "liberal" position with respect to MSS,
      * i.e. we assume that MSS can be calculated from MTU
@@ -238,9 +253,14 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
 
     /* Add 20 bytes for the IPv4 header and 20 byte for the TCP header of the
      * payload, the mssfix method will add 20 extra if payload is IPv6 */
-    overhead += 20 + 20;
+    payload_overhead += 20 + 20;
 
     /* Calculate the maximum MSS value from the max link layer size specified
      * by ce.mssfix */
-    frame->mss_fix = options->ce.mssfix - overhead - payload_overhead;
+
+    /* This is the target value our payload needs to be smaller */
+    unsigned int target = options->ce.mssfix - overhead;
+    frame->mss_fix = adjust_payload_max_cbc(kt, target) - payload_overhead;
+
+
 }
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index dac0c1de..cc7c95e4 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -52,10 +52,31 @@ alloc_buf_sock_tun(struct buffer *buf,
     ASSERT(buf_safe(buf, 0));
 }
 
+
+/**
+ * Return the size of the packet ID size that is currently in use by cipher and
+ * options for the data channel.
+ */
+static unsigned int
+calc_packet_id_size_dc(const struct options *options, const struct key_type *kt)
+{
+    /* Unless no-replay is enabled, we have a packet id, no matter if
+     * encryption is used or not */
+    if (!options->replay)
+    {
+        return 0;
+    }
+
+    bool tlsmode = options->tls_server || options->tls_client;
+
+    bool packet_id_long_form = !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
+
+    return packet_id_size(packet_id_long_form);
+}
+
 size_t
 frame_calculate_protocol_header_size(const struct key_type *kt,
                                      const struct options *options,
-                                     unsigned int payload_size,
                                      bool occ)
 {
     /* Sum of all the overhead that reduces the usable packet size */
@@ -82,15 +103,11 @@ frame_calculate_protocol_header_size(const struct key_type *kt,
         header_size += options->use_peer_id ? 4 : 1;
     }
 
-    /* Add the crypto overhead */
-    bool packet_id = options->replay;
-    bool packet_id_long_form = !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
+    unsigned int pkt_id_size = calc_packet_id_size_dc(options, kt);
 
     /* For figuring out the crypto overhead, we need the size of the payload
      * including all headers that also get encrypted as part of the payload */
-    header_size += calculate_crypto_overhead(kt, packet_id,
-                                             packet_id_long_form,
-                                             payload_size, occ);
+    header_size += calculate_crypto_overhead(kt, pkt_id_size, occ);
     return header_size;
 }
 
@@ -98,13 +115,14 @@ frame_calculate_protocol_header_size(const struct key_type *kt,
 size_t
 frame_calculate_payload_overhead(const struct frame *frame,
                                  const struct options *options,
+                                 const struct key_type *kt,
                                  bool extra_tun)
 {
     size_t overhead = 0;
 
     /* This is the overhead of tap device that is not included in the MTU itself
      * i.e. Ethernet header that we still need to transmit as part of the
-     * payload*/
+     * payload */
     if (extra_tun)
     {
         overhead += frame->extra_tun;
@@ -127,30 +145,40 @@ frame_calculate_payload_overhead(const struct frame *frame,
         overhead += 4;
     }
 #endif
+
+    if (cipher_kt_mode_cbc(kt->cipher))
+    {
+        /* The packet id is part of the plain text payload instead of the
+         * cleartext protocol header and needs to be included in the payload
+         * overhead instead of the protocol header */
+        overhead += calc_packet_id_size_dc(options, kt);
+    }
+
     return overhead;
 }
 
 size_t
-frame_calculate_payload_size(const struct frame *frame, const struct options *options)
+frame_calculate_payload_size(const struct frame *frame,
+                             const struct options *options,
+                             const struct key_type *kt)
 {
     size_t payload_size = options->ce.tun_mtu;
-    payload_size += frame_calculate_payload_overhead(frame, options, true);
+    payload_size += frame_calculate_payload_overhead(frame, options, kt, true);
     return payload_size;
 }
 
 size_t
 calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
 {
-    unsigned int payload = frame_calculate_payload_size(frame, o);
+    struct key_type occ_kt;
 
     /* neither --secret nor TLS mode */
     if (!o->tls_client && !o->tls_server && !o->shared_secret_file)
     {
-        return payload;
+        init_key_type(&occ_kt, "none", "none", false, false);
+        return frame_calculate_payload_size(frame, o, &occ_kt);
     }
 
-    struct key_type occ_kt;
-
     /* o->ciphername might be BF-CBC even though the underlying SSL library
      * does not support it. For this reason we workaround this corner case
      * by pretending to have no encryption enabled and by manually adding
@@ -176,7 +204,8 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
      * the ciphers are actually valid for non tls in occ calucation */
     init_key_type(&occ_kt, ciphername, o->authname, true, false);
 
-    overhead += frame_calculate_protocol_header_size(&occ_kt, o, 0, true);
+    unsigned int payload = frame_calculate_payload_size(frame, o, &occ_kt);
+    overhead += frame_calculate_protocol_header_size(&occ_kt, o, true);
 
     return payload + overhead;
 }
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index f6013860..c83d8816 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -226,19 +226,22 @@ void set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, sa_family_t pro
 
 int translate_mtu_discover_type_name(const char *name);
 
+/* forward declaration of key_type */
+struct key_type;
+
 /**
- * Calculates the size of the payload according to tun-mtu and tap overhead.
- * This also includes compression and fragmentation overhead if they are
- * enabled.
+ * Calculates the size of the payload according to tun-mtu and tap overhead. In
+ * this context payload is identical to the size of the plaintext.
+ * This also includes compression, fragmentation overhead, and packet id in CBC
+ * mode if these options are used.
+ *
  *
  * *  [IP][UDP][OPENVPN PROTOCOL HEADER][ **PAYLOAD incl compression header** ]
- * @param frame
- * @param options
- * @return
  */
 size_t
 frame_calculate_payload_size(const struct frame *frame,
-                             const struct options *options);
+                             const struct options *options,
+                             const struct key_type *kt);
 
 /**
  * Calculates the size of the payload overhead according to tun-mtu and
@@ -247,37 +250,39 @@ frame_calculate_payload_size(const struct frame *frame,
  * are considered part of this overhead that increases the payload larger than
  * tun-mtu.
  *
+ * In CBC mode, the IV is part of the payload instead of part of the OpenVPN
+ * protocol header and is included in the returned value.
+ *
+ * In this context payload is identical to the size of the plaintext and this
+ * method can be also understand as number of bytes that are added to the
+ * plaintext before encryption.
+ *
  * *  [IP][UDP][OPENVPN PROTOCOL HEADER][ **PAYLOAD incl compression header** ]
- * @param frame
- * @param options
- * @param extra_tun
- * @return
  */
 size_t
 frame_calculate_payload_overhead(const struct frame *frame,
                                  const struct options *options,
+                                 const struct key_type *kt,
                                  bool extra_tun);
 
-/* forward declaration of key_type */
-struct key_type;
-
 /**
  * Calculates the size of the OpenVPN protocol header. This includes
  * the crypto IV/tag/HMAC but does not include the IP encapsulation
  *
+ *  This does NOT include the padding and rounding of CBC size
+ *  as the users (mssfix/fragment) of this function need to adjust for
+ *  this and add it themselves.
  *
  *  [IP][UDP][ **OPENVPN PROTOCOL HEADER**][PAYLOAD incl compression header]
  *
  * @param kt            the key_type to use to calculate the crypto overhead
  * @param options       the options struct to be used to calculate
- * @param payload_size  the payload size, ignored if occ is true
- * @param occ           if the calculation should be done for occ compatibility
+ * @param occ           Use the calculation for the OCC link-mtu
  * @return              size of the overhead in bytes
  */
 size_t
 frame_calculate_protocol_header_size(const struct key_type *kt,
                                      const struct options *options,
-                                     unsigned int payload_size,
                                      bool occ);
 
 /**
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 19ce174e..4a094baa 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -41,6 +41,7 @@
 #include "ssl_backend.h"
 
 #include "mock_msg.h"
+#include "mss.h"
 
 static const char testtext[] = "Dummy text to test PEM encoding";
 
@@ -360,6 +361,88 @@ test_occ_mtu_calculation(void **state)
     gc_free(&gc);
 }
 
+static void
+test_mssfix_mtu_calculation(void **state)
+{
+    struct gc_arena gc = gc_new();
+
+    struct frame f = { 0 };
+    struct options o = { 0 };
+
+    /* common defaults */
+    o.ce.tun_mtu = 1400;
+    o.ce.mssfix = 1000;
+    o.replay = true;
+    o.ce.proto = PROTO_UDP;
+
+    /* No crypto at all */
+    o.ciphername = "none";
+    o.authname = "none";
+    struct key_type kt;
+    init_key_type(&kt, o.ciphername, o.authname, false, false);
+
+    /* No encryption, just packet id (8) + TCP payload(20) + IP payload(20) */
+    frame_calculate_mssfix(&f, &kt, &o);
+    assert_int_equal(f.mss_fix, 952);
+
+    /* Static key OCC examples */
+    o.shared_secret_file = "not null";
+
+    /* secret, auth none, cipher none */
+    o.ciphername = "none";
+    o.authname = "none";
+    init_key_type(&kt, o.ciphername, o.authname, false, false);
+    frame_calculate_mssfix(&f, &kt, &o);
+    assert_int_equal(f.mss_fix, 952);
+
+    /* secret, cipher AES-128-CBC, auth none */
+    o.ciphername = "AES-128-CBC";
+    o.authname = "none";
+    init_key_type(&kt, o.ciphername, o.authname, false, false);
+
+    for (int i = 990;i <= 1010;i++)
+    {
+        /* 992 - 1008 should end up with the same mssfix value all they
+         * all result in the same CBC block size/padding and <= 991 and >=1008
+         * should be one block less and more respectively */
+        o.ce.mssfix = i;
+        frame_calculate_mssfix(&f, &kt, &o);
+        if (i <= 991)
+        {
+            assert_int_equal(f.mss_fix, 911);
+        }
+        else if (i >= 1008)
+        {
+            assert_int_equal(f.mss_fix, 943);
+        }
+        else
+        {
+            assert_int_equal(f.mss_fix, 927);
+        }
+    }
+
+    /* tls client, auth SHA1, cipher AES-256-GCM */
+    o.authname = "SHA1";
+    o.ciphername = "AES-256-GCM";
+    o.tls_client = true;
+    o.peer_id = 77;
+    o.use_peer_id = true;
+    init_key_type(&kt, o.ciphername, o.authname, true, false);
+
+    for (int i=900;i <= 1200;i++)
+    {
+        /* For stream ciphers, the value should not be influenced by block
+         * sizes or similar but always have the same difference */
+        o.ce.mssfix = i;
+        frame_calculate_mssfix(&f, &kt, &o);
+
+        /* 4 byte opcode/peerid, 4 byte pkt ID, 16 byte tag, 40 TCP+IP */
+        assert_int_equal(f.mss_fix, i - 4 - 4 - 16 - 40);
+    }
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -369,7 +452,8 @@ main(void)
         cmocka_unit_test(crypto_test_tls_prf),
         cmocka_unit_test(crypto_test_hmac),
         cmocka_unit_test(test_des_encrypt),
-        cmocka_unit_test(test_occ_mtu_calculation)
+        cmocka_unit_test(test_occ_mtu_calculation),
+        cmocka_unit_test(test_mssfix_mtu_calculation)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-- 
2.33.0


