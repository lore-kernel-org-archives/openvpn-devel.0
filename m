From: Arne Schwabe <arne@...1227...>
Date: Sun, 26 Jun 2022 01:41:49 +0200
Message-Id: <20220625234150.3398864-4-arne@...1227...>
In-Reply-To: <20220625234150.3398864-1-arne@...1227...>
References: <20220625234150.3398864-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 4/5] Implement a function to calculate
 the default MTU
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

We could also just hardcode this value to 1420 but this approach does
not add much (complicated) code and it is a bit better than to have
a magic number to just be there.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mtu.c                      | 22 ++++++++++++++++++++++
 src/openvpn/mtu.h                      | 14 ++++++++++++++
 tests/unit_tests/openvpn/test_crypto.c | 19 ++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 8fc45b341..e4d4a9cd5 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -205,6 +205,28 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
     return payload + overhead;
 }
 
+int
+frame_calculate_default_mtu(struct options *o)
+{
+    struct options options = *o;
+
+    /* assume we have peer_id enabled */
+    options.use_peer_id = true;
+
+    /* We use IPv6+UDP here to have a consistent size for tun MTU no matter
+     * the combination of udp/tcp and IPv4/IPv6 */
+    int encap_overhead = datagram_overhead(AF_INET6, PROTO_UDP);
+
+    struct key_type kt;
+    init_key_type(&kt, "AES-256-GCM", "none", true, false);
+
+    size_t payload_overhead = frame_calculate_payload_overhead(0, &options, &kt, false);
+    size_t protocol_overhead = frame_calculate_protocol_header_size(&kt, &options, false);
+
+    return MTU_ENCAP_DEFAULT - encap_overhead - payload_overhead - protocol_overhead;
+
+}
+
 void
 frame_print(const struct frame *frame,
             int level,
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index db6bddb42..e80d8bd01 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -79,6 +79,10 @@
  */
 #define MSSFIX_DEFAULT     1492
 
+/* The default size we aim to reach to with our VPN packets by setting
+ * the MTU accordingly */
+#define MTU_ENCAP_DEFAULT   1492
+
 /*
  * Alignment of payload data such as IP packet or
  * ethernet frame.
@@ -263,6 +267,16 @@ void alloc_buf_sock_tun(struct buffer *buf,
                         const struct frame *frame,
                         const bool tuntap_buffer);
 
+
+/**
+ * Function to calculate the default MTU for Layer 3 VPNs. The function
+ * assumes that UDP packets should be a maximum of \c MTU_ENCAP_DEFAULT (1492)
+ * with a AEAD cipher. This default comes out to be 1420.
+ */
+int
+frame_calculate_default_mtu(struct options *o);
+
+
 /*
  * EXTENDED_SOCKET_ERROR_CAPABILITY functions -- print extra error info
  * on socket errors, such as PMTU size.  As of 2003.05.11, only works
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 83572b827..ca595b0a5 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -477,6 +477,22 @@ test_mssfix_mtu_calculation(void **state)
     gc_free(&gc);
 }
 
+
+static void
+test_mtu_default_calculation(void **state)
+{
+    struct options o = {0};
+
+    /* common defaults */
+    o.ce.tun_mtu = 1400;
+    o.ce.mssfix = 1000;
+    o.replay = true;
+    o.ce.proto = PROTO_UDP;
+
+    size_t mtu = frame_calculate_default_mtu(&o);
+    assert_int_equal(1420, mtu);
+}
+
 int
 main(void)
 {
@@ -487,7 +503,8 @@ main(void)
         cmocka_unit_test(crypto_test_hmac),
         cmocka_unit_test(test_des_encrypt),
         cmocka_unit_test(test_occ_mtu_calculation),
-        cmocka_unit_test(test_mssfix_mtu_calculation)
+        cmocka_unit_test(test_mssfix_mtu_calculation),
+        cmocka_unit_test(test_mtu_default_calculation)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-- 
2.32.1 (Apple Git-133)


