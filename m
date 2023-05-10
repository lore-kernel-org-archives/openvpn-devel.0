From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 10 May 2023 13:22:36 +0200
Message-Id: <20230510112236.248026-4-frank@...2641...>
In-Reply-To: <20230510112236.248026-1-frank@...2641...>
References: <20230510112236.248026-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] mss/mtu: make all size calculations use
 size_t
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

Half of them used unsigned int, the other half size_t.
Standardize on one. Could've also standardized on the
other, both are much too big for the expected numbers
anyway.

Add a new utility function clamp_size_to_int for
cases we need to change from size_t to int (there
are a lot of those all over our codebase).

Resolves some -Wconversion warnings.

Change-Id: Ic996eca227d9e68279a454db93fcbc86a7bd0380
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/integer.h | 11 +++++++++--
 src/openvpn/mss.c     | 20 ++++++++++----------
 src/openvpn/mtu.c     |  4 ++--
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 2551428e..8be7c3c2 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -36,6 +36,13 @@
                    ((uint64_t)ntohl((uint32_t)((x) & 0xFFFFFFFF)) << 32) | ntohl((uint32_t)((x) >> 32)))
 #endif
 
+static inline int
+clamp_size_to_int(size_t size)
+{
+    ASSERT(size <= INT_MAX);
+    return (int)size;
+}
+
 /*
  * min/max functions
  */
@@ -188,8 +195,8 @@ index_verify(int index, int size, const char *file, int line)
 /**
  * Rounds down num to the nearest multiple of multiple
  */
-static inline unsigned int
-round_down_uint(unsigned int num, unsigned int multiple)
+static inline size_t
+round_down_size(size_t num, size_t multiple)
 {
     return (num / multiple) * multiple;
 }
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 44b316da..d0471ebf 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -209,8 +209,8 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
     }
 }
 
-static inline unsigned int
-adjust_payload_max_cbc(const struct key_type *kt, unsigned int target)
+static inline size_t
+adjust_payload_max_cbc(const struct key_type *kt, size_t target)
 {
     if (!cipher_kt_mode_cbc(kt->cipher))
     {
@@ -223,13 +223,13 @@ adjust_payload_max_cbc(const struct key_type *kt, unsigned int target)
         /* With CBC we need at least one extra byte for padding and then need
          * to ensure that the resulting CBC ciphertext length, which is always
          * a multiple of the block size, is not larger than the target value */
-        unsigned int block_size = cipher_kt_block_size(kt->cipher);
-        target = round_down_uint(target, block_size);
+        size_t block_size = cipher_kt_block_size(kt->cipher);
+        target = round_down_size(target, block_size);
         return target - 1;
     }
 }
 
-static unsigned int
+static size_t
 get_ip_encap_overhead(const struct options *options,
                       const struct link_socket_info *lsi)
 {
@@ -260,7 +260,7 @@ frame_calculate_fragment(struct frame *frame, struct key_type *kt,
                          struct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
-    unsigned int overhead;
+    size_t overhead;
 
     overhead = frame_calculate_protocol_header_size(kt, options, false);
 
@@ -269,12 +269,12 @@ frame_calculate_fragment(struct frame *frame, struct key_type *kt,
         overhead += get_ip_encap_overhead(options, lsi);
     }
 
-    unsigned int target = options->ce.fragment - overhead;
+    size_t target = options->ce.fragment - overhead;
     /* The 4 bytes of header that fragment adds itself. The other extra payload
      * bytes (Ethernet header/compression) are handled by the fragment code
      * just as part of the payload and therefore automatically taken into
      * account if the packet needs to fragmented */
-    frame->max_fragment_size = adjust_payload_max_cbc(kt, target) - 4;
+    frame->max_fragment_size = clamp_size_to_int(adjust_payload_max_cbc(kt, target)) - 4;
 
     if (cipher_kt_mode_cbc(kt->cipher))
     {
@@ -298,7 +298,7 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
         return;
     }
 
-    unsigned int overhead, payload_overhead;
+    size_t overhead, payload_overhead;
 
     overhead = frame_calculate_protocol_header_size(kt, options, false);
 
@@ -327,7 +327,7 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
      * by ce.mssfix */
 
     /* This is the target value our payload needs to be smaller */
-    unsigned int target = options->ce.mssfix - overhead;
+    size_t target = options->ce.mssfix - overhead;
     frame->mss_fix = (uint16_t)(adjust_payload_max_cbc(kt, target) - payload_overhead);
 
 
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 3c8468a9..c1d55ade 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -176,7 +176,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
      */
     const char *ciphername = o->ciphername;
 
-    unsigned int overhead = 0;
+    size_t overhead = 0;
 
     if (strcmp(o->ciphername, "BF-CBC") == 0)
     {
@@ -194,7 +194,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
      * the ciphers are actually valid for non tls in occ calucation */
     init_key_type(&occ_kt, ciphername, o->authname, true, false);
 
-    unsigned int payload = frame_calculate_payload_size(frame, o, &occ_kt);
+    size_t payload = frame_calculate_payload_size(frame, o, &occ_kt);
     overhead += frame_calculate_protocol_header_size(&occ_kt, o, true);
 
     return payload + overhead;
-- 
2.34.1


