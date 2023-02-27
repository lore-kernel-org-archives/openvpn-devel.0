From: Arne Schwabe <arne@...1227...>
Date: Mon, 27 Feb 2023 13:50:22 +0100
Message-Id: <20230227125023.2561379-2-arne@...1227...>
In-Reply-To: <20230227125023.2561379-1-arne@...1227...>
References: <20230227125023.2561379-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Implement initial packet reflection
 protection using bloom filter
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

When an OpenVPN server is used/tried to be usedc in a reflection attack
the protection with the simple --connect-freq-initial also block legimitate
client from other networks that are not attacked by a reflection attack.

To allow a server to still reply to these clients, we need to make the counts
rather more detailed and count per subnet or IP address. On the other hand
when we keep all this state, we eliminate the advantage of having a stateless
cookie based initial packet handshake.

As compromoise we use a bloom filter to store the information. This data
structure is probabilistic and can have false positive and more packets
being dropped but since it is a constant size and the size of this map
is small enough for non-embedded systems (tests were done with a 2MB
bloom filter), it is a good compromise.

The code is split into the bloom filter implementation and the actual logic
implementing tracking the subnets, so the bloom filter should be relatively
easily be exchangable by another data structure.

As hash funtion SIPHASH has been chosen since it was designed for this kind
of application.

Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml            |  21 +-
 doc/man-sections/server-options.rst     |  71 +++++
 src/openvpn/Makefile.am                 |   2 +
 src/openvpn/bloom.c                     | 253 +++++++++++++++++
 src/openvpn/bloom.h                     |  97 +++++++
 src/openvpn/mudp.c                      |   5 +-
 src/openvpn/multi.c                     |   3 +-
 src/openvpn/openvpn.vcxproj             |   3 +
 src/openvpn/options.c                   |  93 ++++++
 src/openvpn/options.h                   |   3 +
 src/openvpn/reflect_filter.c            | 361 +++++++++++++++++++++++-
 src/openvpn/reflect_filter.h            |  54 +++-
 tests/unit_tests/openvpn/Makefile.am    |  18 +-
 tests/unit_tests/openvpn/test_reflect.c | 323 +++++++++++++++++++++
 14 files changed, 1284 insertions(+), 23 deletions(-)
 create mode 100644 src/openvpn/bloom.c
 create mode 100644 src/openvpn/bloom.h
 create mode 100644 tests/unit_tests/openvpn/test_reflect.c

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index a3ca7a2ea..13009d3dc 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -234,36 +234,39 @@ jobs:
       - name: List unittests directory
         run: "dir unittests"
 
-      - name: Run argvunit test
+      - name: Run argv unit test
         run: ./unittests/argv_testdriver.exe
 
-      - name: Run auth_tokenunit test
+      - name: Run auth_token unit test
         run: ./unittests/auth_token_testdriver.exe
 
-      - name: Run bufferunit test
+      - name: Run buffer unit test
         run: ./unittests/buffer_testdriver.exe
 
       - name: Run cryptoapi unit test
         run: ./unittests/cryptoapi_testdriver.exe
 
-      - name: Run cryptounit test
+      - name: Run crypto unit test
         run: ./unittests/crypto_testdriver.exe
 
-      - name: Run miscunit test
+      - name: Run misc unit test
         run: ./unittests/misc_testdriver.exe
 
-      - name: Run ncpunit test
+      - name: Run ncp unit test
         run: ./unittests/ncp_testdriver.exe
 
-      - name: Run packet idunit test
+      - name: Run packet id unit test
         run: ./unittests/packet_id_testdriver.exe
 
-      - name: Run pktunit test
+      - name: Run pkt unit test
         run: ./unittests/pkt_testdriver.exe
 
-      - name: Run providerunit test
+      - name: Run provider unit test
         run: ./unittests/provider_testdriver.exe
 
+      - name: Run reflect unit test
+        run: ./unittests/reflect_testdriver.exe
+
   ubuntu:
     strategy:
       fail-fast: false
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 6b9ad21b8..320ec0068 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -208,6 +208,77 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   will not be counted against the limit. The default is to allow
   100 initial connection per 10s.
 
+
+--connect-freq-initial-bloom-size args
+
+   Valid syntax:
+   ::
+
+      connect-freq-initial-bloom-size size [numhashes]
+
+   Configures the size of the bloom filter used for the initial connection
+   packet responses. See `--connect-freq-initial-bloom-limit` for a full
+   description of the feature.
+
+   Bloom filters are probabilistic by their nature and the larger the size
+   of the bloom filter is, the more accurate they are. This option configures
+   the number of buckets in the bloom filter. Each bucket takes up 4 bits.
+   E.g. the default of  8336608 (8 * 2^20) when the option is not set
+   will require 2MB of memory. The numhashes will control the number of hash
+   functions that are used for the bloom filter. The default is 7.
+
+--connect-freq-initial-bloom-limit arg
+
+   Valid syntax:
+   ::
+
+      connect-freq-initial-bloom-limit inet netmask limit
+      connect-freq-initial-bloom-limit inet6 netmask limit
+
+   This option implements a rate limiting function for initial packet like
+   ``--connect-freq-initial`` but takes the source of the initial packet into
+   account. This function shares the the reset after a time period and
+   enabling this function will not disable the overall limit of
+   ``--conect-freq-initial``.
+
+   To avoid resource exhaustion on the OpenVPN server side from reflection
+   attacks and also trying to avoid blocking legitimate clients when an
+   attacker tries to use an OpenVPN server, the limits are not applied globally
+   but rather a per netmask granularity. Each line of this command configures
+   a separate granularity. As example, the following configuration,
+
+   ::
+
+        connect-freq-initial 1000 60
+        connect-freq-initial-bloom-limit inet 24 50
+        connect-freq-initial-bloom-limit inet 8 100
+        connect-freq-initial-bloom-limit inet6 56 50
+        connect-freq-initial-bloom-limit inet6 32 100
+
+    will limit the number of (unanswered) replies per /24 network to 50
+    packets. After 50 packets from the same /24, the server will
+    drop any further packets. Similarly, if a /16 network receives more than
+    100 connection requests, the server will drop further packets.
+    If the count of all packets exceeds 1000, further packets will be
+    completely dropped regardless of their origin.
+
+   The implementation uses a counting bloom filter to store information of how
+   many packets the server has seen per subnet. A bloom filter is a
+   probabilistic data structure can yield false positives. In this case, the
+   server will drop packets even though the limit
+   for that particular subnet is not yet reached. Since we are using a
+   counting bloom filter, a reply from a client that triggers a removal of an
+   entry can also lead to a false negative. However, this is limited in the
+   sense a reply can at most trigger one false negative.
+
+   Every limit configured with this option will put more more entries into
+   the bloomfilter since per limit (per family), one entry is put into the
+   bloom filter. So a large number of entries requires a larger bloom filter
+   to avoid too many false positives.
+
+   IPv6 mapped IPv4 addresses (::ffff:0:0/96) are treated as IPv4 addresses
+   for these limits.
+
 --duplicate-cn
   Allow multiple clients with the same common name to concurrently
   connect. In the absence of this option, OpenVPN will disconnect a client
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index a8e44528c..c1de7b723 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -43,6 +43,7 @@ openvpn_SOURCES = \
 	auth_token.c auth_token.h \
 	base64.c base64.h \
 	basic.h \
+    bloom.c bloom.h \
 	buffer.c buffer.h \
 	circ_list.h \
 	clinat.c clinat.h \
@@ -122,6 +123,7 @@ openvpn_SOURCES = \
 	session_id.c session_id.h \
 	shaper.c shaper.h \
 	sig.c sig.h \
+	siphash.c siphash.h \
 	socket.c socket.h \
 	socks.c socks.h \
 	ssl.c ssl.h  ssl_backend.h \
diff --git a/src/openvpn/bloom.c b/src/openvpn/bloom.c
new file mode 100644
index 000000000..9382bf264
--- /dev/null
+++ b/src/openvpn/bloom.c
@@ -0,0 +1,253 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/* This file implements a specialised counting bloom filter implementation
+ * used in OpenVPN to mitigate it being used in reflection attacks. The bloom
+ * implementation should be general enough to be used in other contexts
+ * however */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+
+#include <stdint.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include "siphash.h"
+#include "crypto.h"
+
+#include "bloom.h"
+
+
+static size_t
+calc_ceil_log2(size_t num)
+{
+    /* Figure out how many bits we have in our hash by doing
+     * ceil(log2(bf->size) */
+
+    size_t numbits = 0;
+    while (num >>= 1)
+    {
+        numbits++;
+    }
+    return numbits;
+}
+
+/**
+ * Calculate number of bytes needed for each hash function in the bloom filter
+ *
+ */
+static inline size_t
+calculate_num_bytes_hashfun(size_t size)
+{
+    size_t hash_bits = calc_ceil_log2(size);
+    /* round up to the nearest byte size */
+    size_t hash_bytes = (hash_bits + 7) /8;
+    return hash_bytes;
+}
+
+/**
+ * A bloom filter uses a number of hashes to perform its functionality.
+ *
+ * Instead of using the same number of siphash function we split the bytes of
+ * the siphash to the different hashes.
+ *
+ * We could also optimise this further by splitting at the bit level but that
+ * crates a lot of extra code for bit shifting, etc. so we waste some bits
+ *
+ * @param bf
+ * @param num_hashes
+ * @return
+ */
+size_t
+calculate_num_sip_hash_hashes(struct bloom_filter *bf)
+{
+    size_t hash_bytes = calculate_num_bytes_hashfun(bf->size);
+    size_t total_bytes = bf->num_hashes * hash_bytes;
+
+    /* Round up to next SIPHASH_HASH_SIZE */
+    size_t num_siphash = (total_bytes + SIPHASH_HASH_SIZE -1) / SIPHASH_HASH_SIZE;
+
+    return num_siphash;
+}
+
+/**
+ * Calculates the number of bytes we need for storing a bloom filter of size
+ * size. We add + 1 to avoid rounding problems and too small allocation */
+static inline
+size_t
+bloom_get_filter_byte_count(size_t size)
+{
+    static_assert(sizeof(bloom_counter_t) * 8 % BLOOM_FILTER_BITS_COUNT == 0,
+                  "bloom_counter_t must be a multiple of BLOOM_FILTER_BIT_COUNT");
+
+    return size * sizeof(bloom_counter_t)/BLOOM_FILTER_BITS_COUNT + 1;
+}
+
+
+static inline
+size_t
+bloom_get_filter_bit_offset(size_t bucket)
+{
+    return (bucket * BLOOM_FILTER_BITS_COUNT) % sizeof(bloom_counter_t);
+}
+
+static inline
+size_t
+bloom_get_filter_array_index(size_t bucket)
+{
+    return (bucket * BLOOM_FILTER_BITS_COUNT) / sizeof(bloom_counter_t);
+}
+
+static inline bloom_counter_t
+bloom_get_filter_get_counter(struct bloom_filter *bf, size_t bucket)
+{
+    static_assert((BLOOM_FILTER_BITS_MASK + 1) ==  (1 << BLOOM_FILTER_BITS_COUNT),
+                  "BLOOM_FILTER_BITMASK and BLOOM_FILTER_BIT_COUNT are inconsistent");
+
+    bloom_counter_t counter = bf->buckets[bloom_get_filter_array_index(bucket)];
+    size_t bitoffset = bloom_get_filter_bit_offset(bucket);
+
+    return (counter >> bitoffset) & BLOOM_FILTER_BITS_MASK;
+}
+
+static inline void
+bloom_set_filter_counter(struct bloom_filter *bf, size_t bucket, bloom_counter_t value)
+{
+    bloom_counter_t data = bf->buckets[bloom_get_filter_array_index(bucket)];
+    size_t bitoffset = bloom_get_filter_bit_offset(bucket);
+
+    data = data & ~(BLOOM_FILTER_BITS_MASK << bitoffset);
+
+    data = data | ((value & BLOOM_FILTER_BITS_MASK) << bitoffset);
+
+    bf->buckets[bloom_get_filter_array_index(bucket)] = data;
+}
+
+/**
+ * Creates a new bloom filter structure
+ * @param size the number of buckets.
+ * @return  the newly created bloom filter structure
+ */
+struct bloom_filter *
+bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc)
+{
+    size_t bloomfilter_bytes = bloom_get_filter_byte_count(size);
+    struct bloom_filter *bf = gc_malloc(sizeof(struct bloom_filter) + bloomfilter_bytes,
+                                        false, gc);
+    bf->size = size;
+    bf->num_hashes = num_hashes;
+
+    bf->hash_bytes = calculate_num_bytes_hashfun(size);
+    bf->num_siphash = calculate_num_sip_hash_hashes(bf);
+
+    ALLOC_ARRAY_GC(bf->siphash_keys, struct siphash_key, bf->num_siphash, gc);
+    
+    bloom_clear(bf);
+    return bf;
+}
+
+/**
+ * Clear the bloom filter, making it empty again as if it were freshly created
+ * @param bf the bloom structure to clear
+ */
+void
+bloom_clear(struct bloom_filter *bf)
+{
+    memset(bf->buckets, 0, bloom_get_filter_byte_count(bf->size));
+
+    /* We randomise the bloom filter keys on every clear of the bloom filter
+     * to avoid scenarios where an attacker might learn specific pattern
+     * that could exploit false positives in the bloom filter */
+    for (size_t i = 0; i < bf->num_siphash; i++)
+    {
+        prng_bytes(bf->siphash_keys[i].key, SIPHASH_KEY_SIZE);
+    }
+}
+
+
+static bloom_counter_t
+bloom_add_test(struct bloom_filter *bf, const uint8_t *item, size_t len, bloom_counter_t inc)
+{
+    uint8_t result[SIPHASH_HASH_SIZE];
+    size_t j = 0;
+    size_t idx = 0;
+    bloom_counter_t ret = bloom_counter_max;
+
+    for (size_t i = 0; i < bf->num_hashes; i++)
+    {
+        size_t bucket = 0;
+        for (int k = 0; k < bf->hash_bytes; k++)
+        {
+            if (idx == 0)
+            {
+                /* We have no longer unused bytes in result, generate the next hash */
+                siphash(item, len, bf->siphash_keys[j++].key, result, SIPHASH_HASH_SIZE);
+            }
+
+            bucket = bucket << 8;
+            bucket |= result[idx];
+
+            idx = (idx + 1) % SIPHASH_HASH_SIZE;
+        }
+
+        bucket = bucket % bf->size;
+        bloom_counter_t value = bloom_get_filter_get_counter(bf, bucket);
+
+        ret = min_bloom_counter(ret, value);
+
+        if (inc)
+        {
+            value = min_bloom_counter(bloom_counter_max, value + 1);
+            bloom_set_filter_counter(bf, bucket, value);
+        }
+    }
+    return ret;
+}
+
+
+bloom_counter_t
+bloom_add(struct bloom_filter *bf, const uint8_t *item, size_t len)
+{
+    return bloom_add_test(bf, item, len, 1);
+}
+
+bloom_counter_t
+bloom_remove(struct bloom_filter *bf, const uint8_t *item, size_t len)
+{
+    return bloom_add_test(bf, item, len, -1);
+}
+
+
+bloom_counter_t
+bloom_test(struct bloom_filter *bf, const uint8_t *item, size_t len)
+{
+    return bloom_add_test(bf, item, len, 0);
+}
diff --git a/src/openvpn/bloom.h b/src/openvpn/bloom.h
new file mode 100644
index 000000000..e18026181
--- /dev/null
+++ b/src/openvpn/bloom.h
@@ -0,0 +1,97 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef BLOOM_H
+#define BLOOM_H
+
+#include <stdint.h>
+#include "siphash.h"
+#include "buffer.h"
+
+/* This is the type we use for the buckets. This is split into small buckets
+ * with BLOOM_FILTER_BIT_COUNT size */
+typedef uint32_t bloom_counter_t;
+#define BLOOM_FILTER_BITS_COUNT    2
+#define BLOOM_FILTER_BITS_MASK   0x03
+#define bloom_counter_max        0x03
+
+
+static inline bloom_counter_t
+min_bloom_counter(bloom_counter_t x, bloom_counter_t y)
+{
+    if (x < y)
+    {
+        return x;
+    }
+    else
+    {
+        return y;
+    }
+}
+
+struct siphash_key {
+    uint8_t key[SIPHASH_KEY_SIZE];
+};
+
+struct bloom_filter {
+    /** Size of the bloom filter in entries, ie total bits/bits per counter */
+    size_t size;
+
+    /** Number of bytes used by each hash function:
+     *
+     * log2(size * 8) bits rounded up to the next byte
+     *
+     * This is a cached value since log2 is surprisingly slow
+     * (5% of total time of if we do not cache it) */
+    size_t hash_bytes;
+
+    /** number of hashes we use to determine the bit positions */
+    size_t num_hashes;
+    /** number of siphash function needed to calculate. This can be
+     * calculated from the other members of the struct but we store it
+     * in the struct for fast access */
+    size_t num_siphash;
+
+    /** keys for the siphash functions */
+    struct siphash_key *siphash_keys;
+
+    /** the actual buckets that hold the data */
+    bloom_counter_t buckets[];
+};
+
+
+struct bloom_filter *
+bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc);
+
+bloom_counter_t
+bloom_test(struct bloom_filter *bf, const uint8_t *item, size_t len);
+
+bloom_counter_t
+bloom_add(struct bloom_filter *bf, const uint8_t *item, size_t len);
+
+bloom_counter_t
+bloom_remove(struct bloom_filter *bf, const uint8_t *item, size_t len);
+
+void
+bloom_clear(struct bloom_filter *bf);
+#endif /* ifndef BLOOM_H */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 8698aefc8..b4053a84f 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -86,7 +86,7 @@ do_pre_decrypt_check(struct multi_context *m,
     {
         /* Check if we are still below our limit for sending out
          * responses */
-        if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
+        if (!reflect_filter_check(m->initial_rate_limiter, from))
         {
             return false;
         }
@@ -256,7 +256,8 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
                 {
                     /* a successful three-way handshake only counts against
                      * connect-freq but not against connect-freq-initial */
-                    reflect_filter_rate_limit_decrease(m->initial_rate_limiter);
+                    reflect_filter_rate_limit_decrease(m->initial_rate_limiter,
+                                                       &m->top.c2.from.dest);
 
                     mi = multi_create_instance(m, &real);
                     if (mi)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f25590168..ef8828a8b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -370,7 +370,8 @@ multi_init(struct multi_context *m, struct context *t, bool tcp_mode)
     m->new_connection_limiter = frequency_limit_init(t->options.cf_max,
                                                      t->options.cf_per);
     m->initial_rate_limiter = initial_rate_limit_init(t->options.cf_initial_max,
-                                                      t->options.cf_initial_per);
+                                                      t->options.cf_initial_per,
+                                                      &t->options.initial_cf_bloom_config);
 
     /*
      * Allocate broadcast/multicast buffer list
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 97baf678c..2d12f8309 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -266,6 +266,7 @@
     <ClCompile Include="auth_token.c" />
     <ClCompile Include="base64.c" />
     <ClCompile Include="block_dns.c" />
+    <ClCompile Include="bloom.c" />
     <ClCompile Include="buffer.c" />
     <ClCompile Include="clinat.c" />
     <ClCompile Include="comp-lz4.c" />
@@ -330,6 +331,7 @@
     <ClCompile Include="session_id.c" />
     <ClCompile Include="shaper.c" />
     <ClCompile Include="sig.c" />
+    <ClCompile Include="siphash.c" />
     <ClCompile Include="socket.c" />
     <ClCompile Include="socks.c" />
     <ClCompile Include="ssl.c" />
@@ -427,6 +429,7 @@
     <ClInclude Include="session_id.h" />
     <ClInclude Include="shaper.h" />
     <ClInclude Include="sig.h" />
+    <ClInclude Include="siphash.h" />
     <ClInclude Include="socket.h" />
     <ClInclude Include="socks.h" />
     <ClInclude Include="ssl.h" />
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9105449c7..041e3961f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3453,6 +3453,22 @@ options_postprocess_mutate_invariant(struct options *options)
 #endif
 }
 
+static void
+check_filter_tier_under_global_limit(struct filter_tier *ft, size_t limit,
+                                     const char *family)
+{
+    while (ft)
+    {
+        if (ft->limit < limit)
+        {
+            msg(M_WARN, "Note: --connect-freq-initial-bloom-limit %s %d %d "
+                "has a larger limit than connect-freq-limit-initial "
+                "limit (%zu).", family, ft->netmask, ft->limit, limit);
+        }
+        ft = ft->next;
+    }
+}
+
 static void
 options_postprocess_verify(const struct options *o)
 {
@@ -3477,6 +3493,18 @@ options_postprocess_verify(const struct options *o)
             "channel offload: packets are always sent to the VPN "
             "interface and then routed based on the system routing table");
     }
+
+    if ((bool)(o->initial_cf_bloom_config.inet_tiers)
+        +(bool)(o->initial_cf_bloom_config.inet6_tiers) == 1)
+    {
+        msg(M_FATAL, "connect-freq-initial-bloom-limit must be provided for "
+            "both inet and inet6");
+    }
+    check_filter_tier_under_global_limit(o->initial_cf_bloom_config.inet_tiers,
+                                         o->cf_initial_max, "inet");
+    check_filter_tier_under_global_limit(o->initial_cf_bloom_config.inet6_tiers,
+                                         o->cf_initial_max, "inet6");
+
 }
 
 /**
@@ -7473,6 +7501,71 @@ add_option(struct options *options,
         options->cf_initial_max = cf_max;
         options->cf_initial_per = cf_per;
     }
+    else if (streq(p[0], "connect-freq-initial-bloom-size") && p[1] && !p[3])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+
+        int cf_bloom_size = atoi(p[1]);
+
+        if (cf_bloom_size <= 0)
+        {
+            msg(msglevel, "--connect-freq-initial-bloom-size size must be > 0");
+            goto err;
+        }
+        options->initial_cf_bloom_config.size = cf_bloom_size;
+        if (p[2])
+        {
+            int num_hash = atoi(p[1]);
+            if (num_hash <= 0)
+            {
+                msg(msglevel, "--connect-freq-initial-bloom-size number of hash "
+                    "functions must be > 0");
+                goto err;
+            }
+            options->initial_cf_bloom_config.num_hashes = num_hash;
+        }
+    }
+    else if (streq(p[0], "connect-freq-initial-bloom-limit") && p[1] && p[2]
+             && p[3] && !p[4])
+    {
+        int netmask = atoi(p[2]);
+        int limit = atoi(p[3]);
+
+        if (limit <= 0)
+        {
+            msg(msglevel, "Limit parameter to %s must be > 0", p[0]);
+            goto err;
+        }
+
+        if (streq(p[1], "inet"))
+        {
+            if (netmask < 0 || netmask > 32)
+            {
+                msg(msglevel, "Netmask parameter (%s) for IPv4 for %s must be "
+                    "between 0 and 32", p[2], p[0]);
+                goto err;
+            }
+            reflect_add_filter_tier(&options->initial_cf_bloom_config,
+                                    &options->gc, false, netmask, limit);
+        }
+        else if (streq(p[1], "inet6"))
+        {
+            if (netmask < 0 || netmask > 128)
+            {
+                msg(msglevel, "Netmask parameter (%s) for IPv6 for %s must be "
+                    "between 0 and 128", p[2], p[0]);
+                goto err;
+            }
+            reflect_add_filter_tier(&options->initial_cf_bloom_config,
+                                    &options->gc, true, netmask, limit);
+        }
+        else
+        {
+            msg(msglevel, "Unknown parameter %s for %s. Must be inet or inet6",
+                p[1], p[0]);
+            goto err;
+        }
+    }
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
     {
         int max_clients;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 7df717f73..b078cfded 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -43,6 +43,7 @@
 #include "clinat.h"
 #include "crypto_backend.h"
 #include "dns.h"
+#include "reflect_filter.h"
 
 
 /*
@@ -520,6 +521,8 @@ struct options
     int cf_initial_max;
     int cf_initial_per;
 
+    struct bloom_filter_conf initial_cf_bloom_config;
+
     int max_clients;
     int max_routes_per_client;
     int stale_routes_check_interval;
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index cfe69a634..35ab2880c 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -40,8 +40,7 @@
 #include "crypto.h"
 #include "reflect_filter.h"
 
-
-bool
+static bool
 reflect_filter_rate_limit_check(struct initial_packet_rate_limit *irl)
 {
     if (now > irl->last_period_reset + irl->period_length)
@@ -74,34 +73,384 @@ reflect_filter_rate_limit_check(struct initial_packet_rate_limit *irl)
     return !over_limit;
 }
 
+static void
+reset_filter_tier(struct initial_packet_rate_limit *irl,
+                  struct filter_tier *tier, const char *prefix)
+{
+    for (; tier != NULL; tier = tier->next)
+    {
+        if (tier->dropped > 0)
+        {
+            msg(D_TLS_DEBUG_LOW, "Dropped %zu initial handshake packets due to "
+                "--connect-freq-initial-bloom-limit %s %d %d",
+                tier->dropped, prefix, tier->netmask, tier->limit);
+            tier->dropped = 0;
+        }
+    }
+}
+
+static void
+bloom_filter_check_reset(struct initial_packet_rate_limit *irl)
+{
+    if (now > irl->last_period_reset + irl->period_length)
+    {
+        reset_filter_tier(irl, irl->bloom_conf.inet_tiers, "inet");
+        reset_filter_tier(irl, irl->bloom_conf.inet6_tiers, "inet6");
+
+        bloom_clear(irl->bf);
+    }
+}
+
+
+/**
+ * structure used as lookup key for the bloom structure. We used the
+ * netmask as part of the structure to avoid the look for the first
+ * IP of a subnet and the subnet to be same key.
+ */
+struct bloom_filter_key {
+    union {
+        struct in_addr in;
+        struct in6_addr in6;
+    };
+    int netmask;
+    /* we keep the count in the key instead of in the bloom filter table as
+     * can then keep the counter in the bloom filter itself small (2 bits)
+     * and bloom filter usage is the same for 20000 request from the same IP
+     * (20k entries with different count but same IP) and from 20000 random ips
+     * (20k entries with count 1 but different IP) */
+    int count;
+};
+
+static inline struct bloom_filter_key
+filter_mask_inet6(struct openvpn_sockaddr *addr, int netmask)
+{
+    struct bloom_filter_key ret = { 0 };
+    ret.in6 = addr->addr.in6.sin6_addr;
+
+    int bits_to_clear = 128 - netmask;
+    int bytes_to_clear =  bits_to_clear /8;
+    bits_to_clear = bits_to_clear % 8;
+
+    memset(&ret.in6.s6_addr[15 - bytes_to_clear], 0x00, bytes_to_clear);
+
+    ret.in6.s6_addr[15 - bytes_to_clear - 1] &= (0xff << bits_to_clear);
+
+    ret.netmask = netmask;
+
+    return ret;
+}
+
+static inline struct bloom_filter_key
+filter_mask_inet(struct openvpn_sockaddr *addr, int netmask)
+{
+    struct bloom_filter_key ret = { 0 };
+    ret.in = addr->addr.in4.sin_addr;
+    ret.in.s_addr &= htonl(0xffffffff << (32 - netmask));
+    ret.netmask = netmask;
+    return ret;
+}
+
+/* We use one function and an action argument to avoid repeating
+ * the code to iterate to the tiers and the creating the lookup
+ * keys */
+enum bloom_filter_action
+{
+    REFLECT_CHECK,
+    REFLECT_INCREASE,
+    REFLECT_DECREASE,
+};
+
+static int
+reflect_lookup_bf_key(struct bloom_filter *bf, struct bloom_filter_key *key, int limit)
+{
+    /* we do a lookup for 1,2,3, and 4 and the limit first
+     * and after that do regular binary search. This is meant to optimise
+     * the common case where just a small number of requests are coming from
+     * each IP */
+    key->count = limit;
+    if (bloom_test(bf, (const uint8_t *) key, sizeof(struct bloom_filter_key)) > 0)
+    {
+        return limit;
+    }
+
+    key->count = 4;
+    if (bloom_test(bf, (const uint8_t *) key, sizeof(struct bloom_filter_key)) == 0)
+    {
+        /* The value for 4 has not been found, so the real value might be 1, 2, or 3. */
+        for (int i = 3; i > 0; i--)
+        {
+            key->count = i;
+            if (bloom_test(bf, (const uint8_t *) key, sizeof(struct bloom_filter_key)) > 0)
+            {
+                return i;
+            }
+        }
+
+        /* 4 was no in the map and 1-3 are also not there, so assume the key is not in the map */
+        return 0;
+    }
+
+    int low = 3;
+    int high = limit;
+
+    while (low < high)
+    {
+
+        key->count = (high + low + 1)/2;
+        bloom_counter_t count = bloom_test(bf, (const uint8_t *) key, sizeof(struct bloom_filter_key));
+        if (count > 0)
+        {
+            low = key->count;
+        }
+        else
+        {
+            high = key->count - 1;
+        }
+    }
+
+    if (low == 4)
+    {
+        /* we reached the lower end of our binary search have not found the
+         * key and we know that 4 is in the map */
+        return 4;
+    }
+    else
+    {
+        return low;
+    }
+}
+
+/**
+ * Convert a mapped IPv6 mapped IPv4 address (::ffff:0:0/96) to an
+ * equivalent IPv4 adress.
+ *
+ * @note: This function only converts the IP itself and ignores other
+ * parts of the \c from structure like port or protocol.
+ */
+static struct openvpn_sockaddr
+convert_mapped_inet_sockaddr(struct openvpn_sockaddr *from)
+{
+    struct openvpn_sockaddr from_mapped = { 0 };
+    /* we ignore the fields like port that the key in the bloom filter
+     * ignores too. This makes this function non-generic */
+
+    from_mapped.addr.in4.sin_family = AF_INET;
+
+    memcpy(&from_mapped.addr.in4.sin_addr.s_addr,
+           &from->addr.in6.sin6_addr.s6_addr[12],
+           sizeof(from_mapped.addr.in4.sin_addr.s_addr));
+
+    return from_mapped;
+}
+
+static bool
+bloom_filter_action(struct initial_packet_rate_limit *irl,
+                    struct openvpn_sockaddr *from,
+                    enum bloom_filter_action action)
+{
+    bool found = false;
+    struct filter_tier *tier = NULL;
+
+    struct openvpn_sockaddr from_mapped;
+
+    if (from->addr.sa.sa_family == AF_INET6
+        && IN6_IS_ADDR_V4MAPPED(&from->addr.in6.sin6_addr))
+    {
+        from_mapped = convert_mapped_inet_sockaddr(from);
+        from = &from_mapped;
+    }
+
+    if (from->addr.sa.sa_family == AF_INET)
+    {
+        tier = irl->bloom_conf.inet_tiers;
+
+    }
+    else if (from->addr.sa.sa_family == AF_INET6)
+    {
+        tier = irl->bloom_conf.inet6_tiers;
+    }
+
+    while (tier)
+    {
+        struct filter_tier *next_tier = tier->next;
+        struct bloom_filter_key key;
+
+        if (from->addr.sa.sa_family == AF_INET6)
+        {
+            key = filter_mask_inet6(from, tier->netmask);
+        }
+        else
+        {
+            key = filter_mask_inet(from, tier->netmask);
+        }
+
+        /* fetch the current count of the key in the bloom filter */
+        int result = reflect_lookup_bf_key(irl->bf, &key, tier->limit);
+        struct gc_arena gc = gc_new();
+        gc_free(&gc);
+
+        switch (action)
+        {
+
+            case REFLECT_CHECK:
+                if (result >= tier->limit)
+                {
+                    found = true;
+                    tier->dropped++;
+                    if (tier->dropped == 1)
+                    {
+                        msg(M_WARN, "Note: --connect-freq-initial-bloom-limit "
+                            "limit for netmask /%d exceeded. Expect additional "
+                            "initial packet drops for the next %d seconds",
+                            tier->netmask,
+                            (int)(irl->last_period_reset + irl->period_length - now));
+                    }
+                }
+                break;
+
+            case REFLECT_INCREASE:
+                ASSERT(result < tier->limit);
+                key.count = result + 1;
+                bloom_add(irl->bf, (const uint8_t *) &key, sizeof(key));
+                break;
+
+            case REFLECT_DECREASE:
+                key.count = result - 1;
+                bloom_remove(irl->bf, (const uint8_t *) &key, sizeof(key));
+                break;
+        }
+
+        tier = next_tier;
+
+    }
+    if (!found && action == REFLECT_CHECK)
+    {
+        /* We only want to increase the counters if the IP is not already
+         * in the set. */
+        bloom_filter_action(irl, from, REFLECT_INCREASE);
+    }
+    return found;
+}
+
+static bool
+bloom_filter_check(struct initial_packet_rate_limit *irl,
+                   struct openvpn_sockaddr *from)
+{
+    if (now > irl->last_period_reset + irl->period_length)
+    {
+
+        bloom_filter_check_reset(irl);
+        bloom_clear(irl->bf);
+    }
+
+    return bloom_filter_action(irl, from, REFLECT_CHECK);
+}
+
+
+bool
+reflect_filter_check(struct initial_packet_rate_limit *irl,
+                     struct openvpn_sockaddr *from)
+{
+    /* We are doing the bloom filter check first so packets that are already
+     * rejected by the bloom filter do not count against the limit of the
+     * simple rate limiter */
+    if (irl->bf && bloom_filter_check(irl, from))
+    {
+        return false;
+    }
+
+    if (!reflect_filter_rate_limit_check(irl))
+    {
+        return false;
+    }
+
+    return true;
+}
+
+
 void
-reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl)
+reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl, struct openvpn_sockaddr *from)
 {
+    if (irl->bf && bloom_filter_action(irl, from, REFLECT_CHECK))
+    {
+        /* Only remove if it is actually present. This might be a packet
+         * coming from an early period or be relayed */
+        bloom_filter_action(irl, from, REFLECT_DECREASE);
+    }
+
     if (irl->curr_period_counter > 0)
     {
         irl->curr_period_counter--;
     }
 }
 
+void
+reflect_add_filter_tier(struct bloom_filter_conf *bfconf, struct gc_arena *gc,
+                        bool ipv6, int netmask, int limit)
+{
+    struct filter_tier *ftnew = gc_malloc(sizeof(struct filter_tier), true, gc);
+
+    ftnew->netmask = netmask;
+    ftnew->limit = limit;
+
+    if (ipv6)
+    {
+        ftnew->next = bfconf->inet6_tiers;
+        bfconf->inet6_tiers = ftnew;
+    }
+    else
+    {
+        ftnew->next = bfconf->inet_tiers;
+        bfconf->inet_tiers = ftnew;
+    }
+}
+
+void
+init_bloom_filter(struct initial_packet_rate_limit *irl)
+{
+    if (!irl->bloom_conf.size)
+    {
+        /* the default allocates 2MB for bloom filter entries */
+        irl->bloom_conf.size = 1024ul * 1024 * 8;
+    }
+    if (!irl->bloom_conf.num_hashes)
+    {
+        irl->bloom_conf.num_hashes = 7;
+    }
+
+    irl->bf = bloom_create(irl->bloom_conf.size, irl->bloom_conf.num_hashes,
+                           &irl->gc);
+    bloom_clear(irl->bf);
+}
 
 struct initial_packet_rate_limit *
-initial_rate_limit_init(int max_per_period, int period_length)
+initial_rate_limit_init(int max_per_period, int period_length,
+                        struct bloom_filter_conf *bconf)
 {
-    struct initial_packet_rate_limit *irl;
 
+    struct initial_packet_rate_limit *irl = NULL;
+    ALLOC_OBJ_CLEAR(irl, struct initial_packet_rate_limit);
 
-    ALLOC_OBJ(irl, struct initial_packet_rate_limit);
+    irl->gc = gc_new();
 
     irl->max_per_period = max_per_period;
     irl->period_length = period_length;
     irl->curr_period_counter = 0;
     irl->last_period_reset = 0;
 
+    if (bconf)
+    {
+        irl->bloom_conf = *bconf;
+        init_bloom_filter(irl);
+    }
+
     return irl;
 }
 
 void
 initial_rate_limit_free(struct initial_packet_rate_limit *irl)
 {
+    gc_free(&irl->gc);
     free(irl);
+    irl = NULL;
 }
diff --git a/src/openvpn/reflect_filter.h b/src/openvpn/reflect_filter.h
index b708d4fd1..e94de587e 100644
--- a/src/openvpn/reflect_filter.h
+++ b/src/openvpn/reflect_filter.h
@@ -24,6 +24,28 @@
 #define REFLECT_FILTER_H
 
 #include <limits.h>
+#include "socket.h"
+#include "bloom.h"
+
+struct filter_tier {
+    struct filter_tier *next;
+
+    int limit;
+    int netmask;
+
+    /** The number of packets we dropped since we went over this limit */
+    size_t dropped;
+};
+
+struct bloom_filter_conf {
+    struct filter_tier *inet_tiers;
+    struct filter_tier *inet6_tiers;
+
+    /* Configuration of the bloom filter */
+    size_t num_hashes;
+    size_t size;
+};
+
 
 /** struct that handles all the rate limiting logic for initial
  * responses */
@@ -35,7 +57,7 @@ struct initial_packet_rate_limit {
     int period_length;
 
     /** Number of packets in the current period. We use int64_t here
-     * to avoid any potiential issues with overflow */
+     * to avoid any potential issues with overflow */
     int64_t curr_period_counter;
 
     /* Last time we reset our timer */
@@ -44,15 +66,28 @@ struct initial_packet_rate_limit {
     /* we want to warn once per period that packets are being started to
      * be dropped */
     bool warning_displayed;
+
+    struct bloom_filter_conf bloom_conf;
+    struct bloom_filter *bf;
+
+    /* gc_arena used for the various allocations by this struct */
+    struct gc_arena gc;
 };
 
+/**
+ * Adds a bloom filter tier to the bloom filter config.
+ */
+void
+reflect_add_filter_tier(struct bloom_filter_conf *bfconf, struct gc_arena *gc,
+                        bool ipv6, int netmask, int limit);
 
 /**
  * checks if the connection is still allowed to connect under the rate
  * limit. This also increases the internal counter at the same time
  */
 bool
-reflect_filter_rate_limit_check(struct initial_packet_rate_limit *irl);
+reflect_filter_check(struct initial_packet_rate_limit *irl,
+                     struct openvpn_sockaddr *from);
 
 /**
  * decreases the counter of initial packets seen, so connections that
@@ -60,16 +95,27 @@ reflect_filter_rate_limit_check(struct initial_packet_rate_limit *irl);
  * the counter of initial connection attempts
  */
 void
-reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl);
+reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl,
+                                   struct openvpn_sockaddr *from);
 
 /**
  * allocate and initialize the initial-packet rate limiter structure
+ *
+ * Note: this function does not copy bconf's contents.
  */
 struct initial_packet_rate_limit *
-initial_rate_limit_init(int max_per_period, int period_length);
+initial_rate_limit_init(int max_per_period, int period_length,
+                        struct bloom_filter_conf *bconf);
 
 /**
  * free the initial-packet rate limiter structure
  */
 void initial_rate_limit_free(struct initial_packet_rate_limit *irl);
+
+/**
+ * Initialises the bloom filter with the configuration values of
+ * irl->bloom_conf
+ */
+void
+init_bloom_filter(struct initial_packet_rate_limit *irl);
 #endif /* ifndef REFLECT_FILTER_H */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index ee0a3d8aa..b8ba1d4db 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -7,7 +7,7 @@ test_binaries += argv_testdriver buffer_testdriver
 endif
 
 test_binaries += crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdriver misc_testdriver \
-	pkt_testdriver
+	pkt_testdriver reflect_testdriver
 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
 test_binaries += tls_crypt_testdriver
@@ -99,6 +99,22 @@ pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/tls_crypt.c
 
+reflect_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
+reflect_testdriver_LDFLAGS = @TEST_LDFLAGS@
+reflect_testdriver_SOURCES = test_reflect.c mock_msg.c mock_msg.h \
+	$(openvpn_srcdir)/reflect_filter.c \
+	$(openvpn_srcdir)/bloom.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/crypto.c \
+	$(openvpn_srcdir)/crypto_mbedtls.c \
+	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/otime.c \
+	$(openvpn_srcdir)/packet_id.c \
+	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/siphash.c \
+	$(openvpn_srcdir)/win32-util.c
+
 if !WIN32
 tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
diff --git a/tests/unit_tests/openvpn/test_reflect.c b/tests/unit_tests/openvpn/test_reflect.c
new file mode 100644
index 000000000..624c6b20b
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_reflect.c
@@ -0,0 +1,323 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include "bloom.h"
+#include "buffer.h"
+#include "reflect_filter.h"
+
+#include <setjmp.h>
+#include <stdarg.h>
+#include <cmocka.h>
+
+#include <stdio.h>
+
+
+
+static void
+test_bloom(void **state)
+{
+    static const int present_mod = 77;
+
+    struct gc_arena gc = gc_new();
+    /* Use a bloom filter with 1M entries (256kB) for the unit test */
+    struct bloom_filter *bf = bloom_create(1024ul*1024, 8, &gc);
+
+    for (int32_t i = 0; i < 20000; i += present_mod)
+    {
+        bloom_add(bf, (const uint8_t *) &i, sizeof(i));
+    }
+
+    /* all these should be positive, for the small unit test we do not expect
+     * false positive */
+    for (int32_t i = 0; i < 20000; i++)
+    {
+        int present = (i % present_mod == 0 ) ? 1 : 0;
+        /* cast to bool to only get 1 and 0 for present/not present and not */
+        assert_int_equal((bool) bloom_test(bf, (const uint8_t *) &i, sizeof(i)), present);
+    }
+    gc_free(&gc);
+}
+
+static void
+test_reflect_ddos(void **state)
+{
+    /* This tests if the bloom filter implementation does actually work with
+     * the goal of dropping packets to a reflected /24 while still allowing
+     * other clients */
+
+    /* Disable the normal fallback that puts a hard cap on the reflection filter */
+    struct initial_packet_rate_limit *irl = initial_rate_limit_init(INT_MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 24, 5);
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 8, 20);
+    init_bloom_filter(irl);
+
+    int num_legimate_reject = 0;
+    int num_legimate_accepted = 0;
+
+    int num_ddos_rejected = 0;
+    int num_ddos_accepted = 0;
+
+
+    /* /24 net addresses in host byte order */
+    in_addr_t net_attack[4];
+    for (int i = 0; i < 3; i++)
+    {
+        net_attack[i] = random() % 0xff;
+    }
+
+    /* The 4th network is close enough to the 3rd to fall in the same /16 */
+    /* XOR the 3rd byte to achieve this */
+    net_attack[3] = net_attack[2] ^ 00002300;
+
+    /* Assume 200000 packets, including roughly 200 legitimate packets,
+     * the unit test works also with 20 millions packet but takes too long*/
+    static const int total_packets = 200 * 1000;
+
+    for (int i = 0; i < total_packets; i++)
+    {
+        struct openvpn_sockaddr from = { 0 };
+        from.addr.in4.sin_family = AF_INET;
+        from.addr.in4.sin_addr.s_addr = random();
+        from.addr.in4.sin_port = random();
+
+        if (i % 1023 == 0)
+        {
+            /* roughly 200 legitimate clients with random addresses */
+            from.addr.in4.sin_addr.s_addr = random();
+
+            bool allowed = reflect_filter_check(irl, &from);
+            if (allowed)
+            {
+                num_legimate_accepted++;
+            }
+            else
+            {
+                num_legimate_reject++;
+            }
+
+        }
+        else
+        {
+            /* We attack the 4 networks at random */
+            from.addr.in4.sin_addr.s_addr  = net_attack[random() % 4] + (random() % 256);
+
+            bool allowed  = reflect_filter_check(irl, &from);
+            if (allowed)
+            {
+                num_ddos_accepted++;
+            }
+            else
+            {
+                num_ddos_rejected++;
+            }
+        }
+    }
+
+    assert_int_equal(num_legimate_reject + num_legimate_accepted + num_ddos_accepted + num_ddos_rejected, total_packets);
+
+    /* We assume that most legitimate made it through but a few were unfortunate to be in an attacked network */
+    assert_in_range(num_legimate_reject, 0, 10);
+
+    /* We disabled total number of packets, so we expect all /8 to have their
+     * 20 packets, which is 5120. */
+    assert_in_range(num_ddos_accepted, 0, 256 * 20);
+
+    initial_rate_limit_free(irl);
+}
+
+
+static void
+test_bloom_minimal(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct bloom_filter *bf = bloom_create(2048, 3, &gc);
+
+    int item = 0xbabe;
+
+    bloom_add(bf, (const uint8_t *) &item, sizeof(item));
+    assert_int_equal(bloom_test(bf, (const uint8_t *) &item, sizeof(item)), 1);
+
+    item = 0xf00f;
+    assert_int_equal(bloom_test(bf, (const uint8_t *) &item, sizeof(item)), 0);
+
+    bloom_free(bf);
+    gc_free(&gc);
+}
+
+static void
+test_reflect_reflect_bloom_simple(void **state)
+{
+    struct initial_packet_rate_limit *irl = initial_rate_limit_init(INT_MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, true, 32, 50);
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, true, 56, 200);
+    init_bloom_filter(irl);
+
+    struct openvpn_sockaddr from = { 0 };
+    from.addr.in6.sin6_family = AF_INET6;
+    from.addr.in6.sin6_port = random();
+    from.addr.in6.sin6_addr.s6_addr[15] = 1;  /* ::1 */
+
+    /* There are 50 attempts that should work until one fails */
+    for (int i = 0; i < 50; i++)
+    {
+        assert_true(reflect_filter_check(irl, &from));
+    }
+
+    /* 2002::1 */
+    struct openvpn_sockaddr from2 = from;
+    from2.addr.in6.sin6_addr.s6_addr[0] = 0x7;
+    from2.addr.in6.sin6_addr.s6_addr[1] = 0x7;
+
+    assert_true(reflect_filter_check(irl, &from2));
+
+    /* Any more attempts from ::1 should fail */
+    assert_false(reflect_filter_check(irl, &from));
+
+    initial_rate_limit_free(irl);
+}
+
+static void
+test_reflect_bloom_netmask_masking(void **state)
+{
+    struct initial_packet_rate_limit *irl = initial_rate_limit_init(INT_MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, true, 45, 10);
+    init_bloom_filter(irl);
+
+    struct openvpn_sockaddr from = { 0 };
+    from.addr.in6.sin6_family = AF_INET6;
+    from.addr.in6.sin6_port = random();
+    for (int i = 0; i < 15; i++)
+    {
+        from.addr.in6.sin6_addr.s6_addr[i] = random();
+    }
+
+    for (int i = 0; i < 10; i++)
+    {
+        /* /45 means that if we leave the leave first 8 bytes and 5 bits
+         * untouched, it is still the same subnet  */
+        for (int j = 8; j<15; j++)
+        {
+            from.addr.in6.sin6_addr.s6_addr[j] = random();
+            from.addr.in6.sin6_addr.s6_addr[7] ^= random() & 0x7;
+        }
+        assert_true(reflect_filter_check(irl, &from));
+
+    }
+
+    /* testing the last IP again should give us a negative result */
+    assert_false(reflect_filter_check(irl, &from));
+
+    initial_rate_limit_free(irl);
+}
+
+
+static void
+test_reflect_reflect_bloom_mapped(void **state)
+{
+    struct initial_packet_rate_limit *irl = initial_rate_limit_init(INT_MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 24, 50);
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 8, 80);
+    init_bloom_filter(irl);
+
+    /* Our OpenVPN server will not receive IPv4 as well as IPv4 mapped
+     * addresses in the same process but for the unit test it is convient
+     * to see if they actually mapped to the same entries */
+
+    struct openvpn_sockaddr mapped_v4 = { 0 };
+    mapped_v4.addr.in6.sin6_family = AF_INET6;
+    mapped_v4.addr.in6.sin6_port = random();
+    /* ::ffff:192.168.0.99 */
+    mapped_v4.addr.in6.sin6_addr.s6_addr[10] = 0xff;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[11] = 0xff;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[12] = 192;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[13] = 168;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[14] = 0;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[15] = 99;
+
+    assert_true(IN6_IS_ADDR_V4MAPPED(&mapped_v4.addr.in6.sin6_addr));
+
+    /* Not the same address but in the same /8 */
+    struct openvpn_sockaddr v4addr = {0 };
+    v4addr.addr.in4.sin_family = AF_INET;
+    v4addr.addr.in4.sin_port = random();
+    /* 192.168.123.244 */
+    v4addr.addr.in4.sin_addr.s_addr = htonl(0xc0a87bf4);
+
+    /* check that we run into the 50 limit with our mapped address */
+    for (int i = 0; i < 50; i++)
+    {
+        assert_true(reflect_filter_check(irl, &mapped_v4));
+    }
+    assert_false(reflect_filter_check(irl, &mapped_v4));
+
+
+    /* Check that the non-mapped IPv4 address uses the same /8 subnet limit */
+    for (int i = 0; i < 30; i++)
+    {
+        assert_true(reflect_filter_check(irl, &v4addr));
+    }
+    assert_false(reflect_filter_check(irl, &v4addr));
+
+    initial_rate_limit_free(irl);
+}
+
+
+static void
+test_bloom_access_functions(void **state)
+{
+    static_assert(BLOOM_FILTER_BITS_COUNT == 2, "unit test not in sync");
+    static_assert(BLOOM_FILTER_BITS_MASK == 0x3, "unit test not in sync");
+}
+
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(test_bloom_access_functions),
+        cmocka_unit_test(test_bloom),
+        cmocka_unit_test(test_bloom_minimal),
+        cmocka_unit_test(test_reflect_reflect_bloom_simple),
+        cmocka_unit_test(test_reflect_reflect_bloom_mapped),
+        cmocka_unit_test(test_reflect_bloom_netmask_masking),
+        cmocka_unit_test(test_reflect_ddos),
+    };
+
+
+    int ret = cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);
+
+    return ret;
+}
-- 
2.37.1 (Apple Git-137.1)


