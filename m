From: Frank Lichtenheld <frank@...2641...>
Date: Sun,  8 Oct 2023 12:40:22 +0200
Message-Id: <20231008104022.20200-1-frank@...2641...>
In-Reply-To: <gerrit.1683717398000.Ic996eca227d9e68279a454db93fcbc86a7bd0380@...2715...>
References: <gerrit.1683717398000.Ic996eca227d9e68279a454db93fcbc86a7bd0380@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] mss/mtu: make all size calculations use
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/269
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 30b9ecf..a0e421d 100644
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
@@ -201,8 +208,8 @@
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
index d7ee4c2..108b370 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -207,8 +207,8 @@
     }
 }
 
-static inline unsigned int
-adjust_payload_max_cbc(const struct key_type *kt, unsigned int target)
+static inline size_t
+adjust_payload_max_cbc(const struct key_type *kt, size_t target)
 {
     if (!cipher_kt_mode_cbc(kt->cipher))
     {
@@ -221,13 +221,13 @@
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
@@ -258,7 +258,7 @@
                          struct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
-    unsigned int overhead;
+    size_t overhead;
 
     overhead = frame_calculate_protocol_header_size(kt, options, false);
 
@@ -267,12 +267,12 @@
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
@@ -296,7 +296,7 @@
         return;
     }
 
-    unsigned int overhead, payload_overhead;
+    size_t overhead, payload_overhead;
 
     overhead = frame_calculate_protocol_header_size(kt, options, false);
 
@@ -325,7 +325,7 @@
      * by ce.mssfix */
 
     /* This is the target value our payload needs to be smaller */
-    unsigned int target = options->ce.mssfix - overhead;
+    size_t target = options->ce.mssfix - overhead;
     frame->mss_fix = (uint16_t)(adjust_payload_max_cbc(kt, target) - payload_overhead);
 
 
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 389d140..df6ba13 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -174,7 +174,7 @@
      */
     const char *ciphername = o->ciphername;
 
-    unsigned int overhead = 0;
+    size_t overhead = 0;
 
     if (strcmp(o->ciphername, "BF-CBC") == 0)
     {
@@ -192,7 +192,7 @@
      * the ciphers are actually valid for non tls in occ calucation */
     init_key_type(&occ_kt, ciphername, o->authname, true, false);
 
-    unsigned int payload = frame_calculate_payload_size(frame, o, &occ_kt);
+    size_t payload = frame_calculate_payload_size(frame, o, &occ_kt);
     overhead += frame_calculate_protocol_header_size(&occ_kt, o, true);
 
     return payload + overhead;

