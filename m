From: Arne Schwabe <arne@...1227...>
Date: Wed, 29 Dec 2021 17:34:45 +0100
Message-Id: <20211229163445.1893687-1-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 07/21] Add helper functions to calculate
 header/payload sizes
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

These functions are intended to lay the groundwork to later replace
the distributed frame calculations and centralise the calculation in
one place.

Patch v2: clarify that the socks comments is assuming IPv4 and improve other
          comments

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c | 55 ++++++++++++++++++++++++++++
 src/openvpn/crypto.h | 18 +++++++++
 src/openvpn/mtu.c    | 87 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/mtu.h    | 54 +++++++++++++++++++++++++++
 4 files changed, 214 insertions(+)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index dc7ba542..5626e2b6 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -667,6 +667,61 @@ openvpn_decrypt(struct buffer *buf, struct buffer work,
     return ret;
 }
 
+unsigned int
+calculate_crypto_overhead(const struct key_type *kt,
+                          bool packet_id,
+                          bool packet_id_long_form,
+                          unsigned int payload_size,
+                          bool occ)
+{
+    unsigned int crypto_overhead = 0;
+
+    /* We always have a packet id, no matter if encrypted or unencrypted */
+    if (packet_id)
+    {
+        crypto_overhead += packet_id_size(packet_id_long_form);
+    }
+
+    if (cipher_kt_mode_aead(kt->cipher))
+    {
+        /* For AEAD ciphers, we basically use a stream cipher/CTR for
+         * the encryption, so no overhead apart from the extra bytes
+         * we add */
+        crypto_overhead += cipher_kt_tag_size(kt->cipher);
+
+        if (occ)
+        {
+            /* the frame calculation of old clients adds these to the link-mtu
+             * even though they are not part of the actual packet */
+            crypto_overhead += cipher_kt_iv_size(kt->cipher);
+            crypto_overhead += cipher_kt_block_size(kt->cipher);
+        }
+    }
+    else
+    {
+        if (cipher_defined(kt->cipher))
+        {
+            /* CBC, OFB or CFB mode */
+            /* This is a worst case upper bound of needing to add
+             * a full extra block for padding when the payload
+             * is exactly a multiple of the block size */
+            if (occ || (cipher_kt_mode_cbc(kt->cipher) &&
+                (payload_size % cipher_kt_block_size(kt->cipher) == 0)))
+            {
+                crypto_overhead += cipher_kt_block_size(kt->cipher);
+            }
+            /* IV is always added (no-iv has been removed a while ago) */
+            crypto_overhead += cipher_kt_iv_size(kt->cipher);
+        }
+        if (md_defined(kt->digest))
+        {
+            crypto_overhead += md_kt_size(kt->digest);
+        }
+    }
+
+    return crypto_overhead;
+}
+
 void
 crypto_adjust_frame_parameters(struct frame *frame,
                                const struct key_type *kt,
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index ad3543c1..5a67b7ac 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -415,6 +415,24 @@ void crypto_adjust_frame_parameters(struct frame *frame,
                                     bool packet_id,
                                     bool packet_id_long_form);
 
+/** Calculate the maximum overhead that our encryption has
+ * on a packet. This does not include needed additional buffer size
+ *
+ * @param kt            Struct with the crypto algorithm to use
+ * @param packet_id     Whether packet_id is used
+ * @param packet_id_long_form Whether the packet id has the long form
+ * @param payload_size   payload size, only used if occ is false
+ * @param occ           if true calculates the overhead for crypto in the same
+ *                      incorrect way as all previous OpenVPN versions did, to
+ *                      end up with identical numbers for OCC compatibility
+ */
+unsigned int
+calculate_crypto_overhead(const struct key_type *kt,
+                           bool packet_id,
+                           bool packet_id_long_form,
+                           unsigned int payload_size,
+                           bool occ);
+
 /** Return the worst-case OpenVPN crypto overhead (in bytes) */
 unsigned int crypto_max_overhead(void);
 
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 0ab716d7..70ef9599 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -35,6 +35,7 @@
 #include "integer.h"
 #include "mtu.h"
 #include "options.h"
+#include "crypto.h"
 
 #include "memdbg.h"
 
@@ -51,6 +52,92 @@ alloc_buf_sock_tun(struct buffer *buf,
     ASSERT(buf_safe(buf, 0));
 }
 
+size_t
+frame_calculate_protocol_header_size(const struct key_type *kt,
+                                     const struct options *options,
+                                     unsigned int payload_size,
+                                     bool occ)
+{
+    /* Sum of all the overhead that reduces the usable packet size */
+    size_t header_size = 0;
+
+    bool tlsmode = options->tls_server || options->tls_client;
+
+    /* A socks proxy adds 10 byte of extra header to each packet
+     * (we only support Socks with IPv4, this value is different for IPv6) */
+    if (options->ce.socks_proxy_server && proto_is_udp(options->ce.proto))
+    {
+        header_size += 10;
+    }
+
+    /* TCP stream based packets have a 16 bit length field */
+    if (proto_is_tcp(options->ce.proto))
+    {
+        header_size += 2;
+    }
+
+    /* Add the opcode and peerid */
+    if (tlsmode)
+    {
+        header_size += options->use_peer_id ? 4 : 1;
+    }
+
+    /* Add the crypto overhead */
+    bool packet_id = options->replay;
+    bool packet_id_long_form = !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
+
+    /* For figuring out the crypto overhead, we need to the size of the payload
+     * including all headers that also get encrypted as part of the payload */
+    header_size += calculate_crypto_overhead(kt, packet_id,
+                                             packet_id_long_form,
+                                             payload_size, occ);
+    return header_size;
+}
+
+
+size_t
+frame_calculate_payload_overhead(const struct frame *frame,
+                                 const struct options *options,
+                                 bool extra_tun)
+{
+    size_t overhead = 0;
+
+    /* This is the overhead of tap device that is not included in the MTU itself
+     * i.e. Ethernet header that we still need to transmit as part of the
+     * payload*/
+    if (extra_tun)
+    {
+        overhead += frame->extra_tun;
+    }
+
+#if defined(USE_COMP)
+    /* v1 Compression schemes add 1 byte header. V2 only adds a header when it
+     * does not increase the packet length. We ignore the unlikely escaping
+     * for tap here */
+    if (options->comp.alg == COMP_ALG_LZ4 || options->comp.alg == COMP_ALG_STUB
+        || options->comp.alg == COMP_ALG_LZO)
+    {
+        overhead += 1;
+    }
+#endif
+#if defined(ENABLE_FRAGMENT)
+    /* Add the size of the fragment header (uint32_t) */
+    if (options->ce.fragment)
+    {
+        overhead += 4;
+    }
+#endif
+    return overhead;
+}
+
+size_t
+frame_calculate_payload_size(const struct frame *frame, const struct options *options)
+{
+    size_t payload_size = options->ce.tun_mtu;
+    payload_size += frame_calculate_payload_overhead(frame, options, true);
+    return payload_size;
+}
+
 void
 frame_finalize(struct frame *frame,
                bool link_mtu_defined,
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index c1148c31..5ad0931f 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -221,6 +221,60 @@ void set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, sa_family_t pro
 
 int translate_mtu_discover_type_name(const char *name);
 
+/**
+ * Calculates the size of the payload according to tun-mtu and tap overhead.
+ * This also includes compression and fragmentation overhead if they are
+ * enabled.
+ *
+ * *  [IP][UDP][OPENVPN PROTOCOL HEADER][ **PAYLOAD incl compression header** ]
+ * @param frame
+ * @param options
+ * @return
+ */
+size_t
+frame_calculate_payload_size(const struct frame *frame,
+                             const struct options *options);
+
+/**
+ * Calculates the size of the payload overhead according to tun-mtu and
+ * tap overhead. This all the overhead that is considered part of the payload
+ * itself. The compression and fragmentation header and extra header from tap
+ * are considered part of this overhead that increases the payload larger than
+ * tun-mtu.
+ *
+ * *  [IP][UDP][OPENVPN PROTOCOL HEADER][ **PAYLOAD incl compression header** ]
+ * @param frame
+ * @param options
+ * @param extra_tun
+ * @return
+ */
+size_t
+frame_calculate_payload_overhead(const struct frame *frame,
+                                 const struct options *options,
+                                 bool extra_tun);
+
+/* forward declaration of key_type */
+struct key_type;
+
+/**
+ * Calculates the size of the OpenVPN protocol header. This includes
+ * the crypto IV/tag/HMAC but does not include the IP encapsulation
+ *
+ *
+ *  [IP][UDP][ **OPENVPN PROTOCOL HEADER**][PAYLOAD incl compression header]
+ *
+ * @param kt            the key_type to use to calculate the crypto overhead
+ * @param options       the options struct to be used to calculate
+ * @param payload_size  the payload size, ignored if occ is true
+ * @param occ           if the calculation should be done for occ compatibility
+ * @return              size of the overhead in bytes
+ */
+size_t
+frame_calculate_protocol_header_size(const struct key_type *kt,
+                                     const struct options *options,
+                                     unsigned int payload_size,
+                                     bool occ);
+
 /*
  * frame_set_mtu_dynamic and flags
  */
-- 
2.33.0


