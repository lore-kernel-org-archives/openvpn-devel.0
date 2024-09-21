From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 21 Sep 2024 14:16:25 +0000
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2f931f9786824e41a49a23b878dfea8cffcd20f3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rw+jdijlZu8="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement initial
 packet reflection protection using bloom filter
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

--rw+jdijlZu8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/30?usp=3Demail

to review the following change.


Change subject: Implement initial packet reflection protection using bloom =
filter
......................................................................

Implement initial packet reflection protection using bloom filter

When an OpenVPN server is used/tried to be usedc in a reflection attack
the protection with the simple --connect-freq-initial also block legimitate
client from other networks that are not attacked by a reflection attack.

To allow a server to still reply to these clients, we need to make the coun=
ts
rather more detailed and count per subnet or IP address. On the other hand
when we keep all this state, we eliminate the advantage of having a statele=
ss
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
M .github/workflows/build.yaml
M CMakeLists.txt
M Changes.rst
M doc/man-sections/server-options.rst
M src/openvpn/Makefile.am
A src/openvpn/bloom.c
A src/openvpn/bloom.h
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/reflect_filter.c
M src/openvpn/reflect_filter.h
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/test_reflect.c
15 files changed, 1,302 insertions(+), 15 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/30/9

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 361d457..93c67d1 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -102,6 +102,9 @@
         env:
           srcdir: "${{ github.workspace }}/tests/unit_tests/openvpn"

+      - name: Run reflect unit test
+        run: ./unittests/test_reflect.exe
+
   ubuntu:
     strategy:
       fail-fast: false
diff --git a/CMakeLists.txt b/CMakeLists.txt
index ad620fa..5aba2d4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -369,6 +369,7 @@
     src/openvpn/base64.c
     src/openvpn/base64.h
     src/openvpn/basic.h
+    src/openvpn/bloom.c
     src/openvpn/buffer.c
     src/openvpn/buffer.h
     src/openvpn/circ_list.h
@@ -511,6 +512,8 @@
     src/openvpn/shaper.h
     src/openvpn/sig.c
     src/openvpn/sig.h
+    src/openvpn/siphash.h
+    src/openvpn/siphash_reference.c
     src/openvpn/socket.c
     src/openvpn/socket.h
     src/openvpn/socks.c
@@ -605,6 +608,7 @@
         "test_packet_id"
         "test_pkt"
         "test_provider"
+        "test_reflect"
         "test_ssl"
         "test_user_pass"
         )
@@ -770,6 +774,19 @@
         src/openvpn/session_id.c
         )

+    target_sources(test_reflect PRIVATE
+        src/openvpn/bloom.c
+        src/openvpn/reflect_filter.c
+        src/openvpn/reflect_filter.h
+        src/openvpn/siphash.h
+        src/openvpn/siphash_reference.c
+        src/openvpn/otime.c
+        src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_openssl.c
+        src/openvpn/crypto.c
+        src/openvpn/packet_id.c
+        )
+
     target_sources(test_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win32_execve.c
         src/openvpn/argv.c
diff --git a/Changes.rst b/Changes.rst
index 439352a..af72678 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -9,6 +9,14 @@
     the user experience as the client shows an error instead of running in=
to
     a timeout when the server just stops responding completely.

+Bloom filter based reflection protection
+    To avoid the limitation of ``--connect-freq-initial`` to block legimit=
ate
+    clients when an OpenVPN server is tried to be used in a reflection att=
ack,
+    the new ``--connect-freq-initial-bloom-limit`` can impose limit on a
+    per-subnet basis. See the manual for more details. Note: this option
+    requires 2MB of extra memory in the default configuration.
+
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 0632e31..f102df2 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -208,6 +208,77 @@
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
+   of the bloom filter is, the more accurate they are. This option configu=
res
+   the number of buckets in the bloom filter. Each bucket takes up 4 bits.
+   E.g. the default of  8336608 (8 * 2^20) when the option is not set
+   will require 2MB of memory. The numhashes will control the number of ha=
sh
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
+   ``--connect-freq-initial`` but takes the source of the initial packet i=
nto
+   account. This function shares the the reset after a time period and
+   enabling this function will not disable the overall limit of
+   ``--conect-freq-initial``.
+
+   To avoid resource exhaustion on the OpenVPN server side from reflection
+   attacks and also trying to avoid blocking legitimate clients when an
+   attacker tries to use an OpenVPN server, the limits are not applied glo=
bally
+   but rather a per netmask granularity. Each line of this command configu=
res
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
+    drop any further packets. Similarly, if a /16 network receives more th=
an
+    100 connection requests, the server will drop further packets.
+    If the count of all packets exceeds 1000, further packets will be
+    completely dropped regardless of their origin.
+
+   The implementation uses a counting bloom filter to store information of=
 how
+   many packets the server has seen per subnet. A bloom filter is a
+   probabilistic data structure can yield false positives. In this case, t=
he
+   server will drop packets even though the limit
+   for that particular subnet is not yet reached. Since we are using a
+   counting bloom filter, a reply from a client that triggers a removal of=
 an
+   entry can also lead to a false negative. However, this is limited in the
+   sense a reply can at most trigger one false negative.
+
+   Every limit configured with this option will put more more entries into
+   the bloomfilter since per limit (per family), one entry is put into the
+   bloom filter. So a large number of entries requires a larger bloom filt=
er
+   to avoid too many false positives.
+
+   IPv6 mapped IPv4 addresses (::ffff:0:0/96) are treated as IPv4 addresses
+   for these limits.
+
 --duplicate-cn
   Allow multiple clients with the same common name to concurrently
   connect. In the absence of this option, OpenVPN will disconnect a client
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 3784a98..ca77718 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -44,6 +44,7 @@
 	auth_token.c auth_token.h \
 	base64.c base64.h \
 	basic.h \
+    bloom.c bloom.h \
 	buffer.c buffer.h \
 	circ_list.h \
 	clinat.c clinat.h \
@@ -124,6 +125,7 @@
 	session_id.c session_id.h \
 	shaper.c shaper.h \
 	sig.c sig.h \
+	siphash_reference.c siphash.h \
 	socket.c socket.h \
 	socks.c socks.h \
 	ssl.c ssl.h  ssl_backend.h \
diff --git a/src/openvpn/bloom.c b/src/openvpn/bloom.c
new file mode 100644
index 0000000..729429e
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
+ * used in OpenVPN to mitigate it being used in reflection attacks. The bl=
oom
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
+    size_t numbits =3D 0;
+    while (num >>=3D 1)
+    {
+        numbits++;
+    }
+    return numbits;
+}
+
+/**
+ * Calculate number of bytes needed for each hash function in the bloom fi=
lter
+ *
+ */
+static inline size_t
+calculate_num_bytes_hashfun(size_t size)
+{
+    size_t hash_bits =3D calc_ceil_log2(size);
+    /* round up to the nearest byte size */
+    size_t hash_bytes =3D (hash_bits + 7) /8;
+    return hash_bytes;
+}
+
+/**
+ * A bloom filter uses a number of hashes to perform its functionality.
+ *
+ * Instead of using the same number of siphash function we split the bytes=
 of
+ * the siphash to the different hashes.
+ *
+ * We could also optimise this further by splitting at the bit level but t=
hat
+ * crates a lot of extra code for bit shifting, etc. so we waste some bits
+ *
+ * @param bf
+ * @param num_hashes
+ * @return
+ */
+size_t
+calculate_num_sip_hash_hashes(struct bloom_filter *bf)
+{
+    size_t hash_bytes =3D calculate_num_bytes_hashfun(bf->size);
+    size_t total_bytes =3D bf->num_hashes * hash_bytes;
+
+    /* Round up to next SIPHASH_HASH_SIZE */
+    size_t num_siphash =3D (total_bytes + SIPHASH_HASH_SIZE -1) / SIPHASH_=
HASH_SIZE;
+
+    return num_siphash;
+}
+
+/**
+ * Calculates the number of bytes we need for storing a bloom filter of si=
ze
+ * size. We add + 1 to avoid rounding problems and too small allocation */
+static inline
+size_t
+bloom_get_filter_byte_count(size_t size)
+{
+    static_assert(sizeof(bloom_counter_t) * 8 % BLOOM_FILTER_BITS_COUNT =
=3D=3D 0,
+                  "bloom_counter_t must be a multiple of BLOOM_FILTER_BIT_=
COUNT");
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
+    static_assert((BLOOM_FILTER_BITS_MASK + 1) =3D=3D  (1 << BLOOM_FILTER_=
BITS_COUNT),
+                  "BLOOM_FILTER_BITMASK and BLOOM_FILTER_BIT_COUNT are inc=
onsistent");
+
+    bloom_counter_t counter =3D bf->buckets[bloom_get_filter_array_index(b=
ucket)];
+    size_t bitoffset =3D bloom_get_filter_bit_offset(bucket);
+
+    return (counter >> bitoffset) & BLOOM_FILTER_BITS_MASK;
+}
+
+static inline void
+bloom_set_filter_counter(struct bloom_filter *bf, size_t bucket, bloom_cou=
nter_t value)
+{
+    bloom_counter_t data =3D bf->buckets[bloom_get_filter_array_index(buck=
et)];
+    size_t bitoffset =3D bloom_get_filter_bit_offset(bucket);
+
+    data =3D data & ~(BLOOM_FILTER_BITS_MASK << bitoffset);
+
+    data =3D data | ((value & BLOOM_FILTER_BITS_MASK) << bitoffset);
+
+    bf->buckets[bloom_get_filter_array_index(bucket)] =3D data;
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
+    size_t bloomfilter_bytes =3D bloom_get_filter_byte_count(size);
+    struct bloom_filter *bf =3D gc_malloc(sizeof(struct bloom_filter) + bl=
oomfilter_bytes,
+                                        false, gc);
+    bf->size =3D size;
+    bf->num_hashes =3D num_hashes;
+
+    bf->hash_bytes =3D calculate_num_bytes_hashfun(size);
+    bf->num_siphash =3D calculate_num_sip_hash_hashes(bf);
+
+    ALLOC_ARRAY_GC(bf->siphash_keys, struct siphash_key, bf->num_siphash, =
gc);
+
+    bloom_clear(bf);
+    return bf;
+}
+
+/**
+ * Clear the bloom filter, making it empty again as if it were freshly cre=
ated
+ * @param bf the bloom structure to clear
+ */
+void
+bloom_clear(struct bloom_filter *bf)
+{
+    memset(bf->buckets, 0, bloom_get_filter_byte_count(bf->size));
+
+    /* We randomise the bloom filter keys on every clear of the bloom filt=
er
+     * to avoid scenarios where an attacker might learn specific pattern
+     * that could exploit false positives in the bloom filter */
+    for (size_t i =3D 0; i < bf->num_siphash; i++)
+    {
+        prng_bytes(bf->siphash_keys[i].key, SIPHASH_KEY_SIZE);
+    }
+}
+
+
+static bloom_counter_t
+bloom_add_test(struct bloom_filter *bf, const uint8_t *item, size_t len, b=
loom_counter_t inc)
+{
+    uint8_t result[SIPHASH_HASH_SIZE];
+    size_t j =3D 0;
+    size_t idx =3D 0;
+    bloom_counter_t ret =3D bloom_counter_max;
+
+    for (size_t i =3D 0; i < bf->num_hashes; i++)
+    {
+        size_t bucket =3D 0;
+        for (int k =3D 0; k < bf->hash_bytes; k++)
+        {
+            if (idx =3D=3D 0)
+            {
+                /* We have no longer unused bytes in result, generate the =
next hash */
+                siphash(item, len, bf->siphash_keys[j++].key, result, SIPH=
ASH_HASH_SIZE);
+            }
+
+            bucket =3D bucket << 8;
+            bucket |=3D result[idx];
+
+            idx =3D (idx + 1) % SIPHASH_HASH_SIZE;
+        }
+
+        bucket =3D bucket % bf->size;
+        bloom_counter_t value =3D bloom_get_filter_get_counter(bf, bucket);
+
+        ret =3D min_bloom_counter(ret, value);
+
+        if (inc)
+        {
+            value =3D min_bloom_counter(bloom_counter_max, value + 1);
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
index 0000000..e180261
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
+/* This is the type we use for the buckets. This is split into small bucke=
ts
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
+    /** Size of the bloom filter in entries, ie total bits/bits per counte=
r */
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
index 268b430..9fbffac 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -84,7 +84,7 @@
     {
         /* Check if we are still below our limit for sending out
          * responses */
-        if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
+        if (!reflect_filter_check(m->initial_rate_limiter, from))
         {
             return false;
         }
@@ -254,7 +254,8 @@
                 {
                     /* a successful three-way handshake only counts against
                      * connect-freq but not against connect-freq-initial */
-                    reflect_filter_rate_limit_decrease(m->initial_rate_lim=
iter);
+                    reflect_filter_rate_limit_decrease(m->initial_rate_lim=
iter,
+                                                       &m->top.c2.from.des=
t);

                     mi =3D multi_create_instance(m, &real);
                     if (mi)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0509911..b9de040 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -368,7 +368,8 @@
     m->new_connection_limiter =3D frequency_limit_init(t->options.cf_max,
                                                      t->options.cf_per);
     m->initial_rate_limiter =3D initial_rate_limit_init(t->options.cf_init=
ial_max,
-                                                      t->options.cf_initia=
l_per);
+                                                      t->options.cf_initia=
l_per,
+                                                      &t->options.initial_=
cf_bloom_config);

     /*
      * Allocate broadcast/multicast buffer list
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 649f48b..20c953a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3461,6 +3461,22 @@
 }

 static void
+check_filter_tier_under_global_limit(struct filter_tier *ft, size_t limit,
+                                     const char *family)
+{
+    while (ft)
+    {
+        if (ft->limit < limit)
+        {
+            msg(M_WARN, "Note: --connect-freq-initial-bloom-limit %s %d %d=
 "
+                "has a larger limit than connect-freq-limit-initial "
+                "limit (%zu).", family, ft->netmask, ft->limit, limit);
+        }
+        ft =3D ft->next;
+    }
+}
+
+static void
 options_postprocess_verify(const struct options *o)
 {
     if (o->connection_list)
@@ -3484,6 +3500,18 @@
             "channel offload: packets are always sent to the VPN "
             "interface and then routed based on the system routing table");
     }
+
+    if ((bool)(o->initial_cf_bloom_config.inet_tiers)
+        +(bool)(o->initial_cf_bloom_config.inet6_tiers) =3D=3D 1)
+    {
+        msg(M_FATAL, "connect-freq-initial-bloom-limit must be provided fo=
r "
+            "both inet and inet6");
+    }
+    check_filter_tier_under_global_limit(o->initial_cf_bloom_config.inet_t=
iers,
+                                         o->cf_initial_max, "inet");
+    check_filter_tier_under_global_limit(o->initial_cf_bloom_config.inet6_=
tiers,
+                                         o->cf_initial_max, "inet6");
+
 }


@@ -7562,6 +7590,71 @@
         options->cf_initial_max =3D cf_max;
         options->cf_initial_per =3D cf_per;
     }
+    else if (streq(p[0], "connect-freq-initial-bloom-size") && p[1] && !p[=
3])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+
+        int cf_bloom_size =3D atoi(p[1]);
+
+        if (cf_bloom_size <=3D 0)
+        {
+            msg(msglevel, "--connect-freq-initial-bloom-size size must be =
> 0");
+            goto err;
+        }
+        options->initial_cf_bloom_config.size =3D cf_bloom_size;
+        if (p[2])
+        {
+            int num_hash =3D atoi(p[1]);
+            if (num_hash <=3D 0)
+            {
+                msg(msglevel, "--connect-freq-initial-bloom-size number of=
 hash "
+                    "functions must be > 0");
+                goto err;
+            }
+            options->initial_cf_bloom_config.num_hashes =3D num_hash;
+        }
+    }
+    else if (streq(p[0], "connect-freq-initial-bloom-limit") && p[1] && p[=
2]
+             && p[3] && !p[4])
+    {
+        int netmask =3D atoi(p[2]);
+        int limit =3D atoi(p[3]);
+
+        if (limit <=3D 0)
+        {
+            msg(msglevel, "Limit parameter to %s must be > 0", p[0]);
+            goto err;
+        }
+
+        if (streq(p[1], "inet"))
+        {
+            if (netmask < 0 || netmask > 32)
+            {
+                msg(msglevel, "Netmask parameter (%s) for IPv4 for %s must=
 be "
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
+                msg(msglevel, "Netmask parameter (%s) for IPv6 for %s must=
 be "
+                    "between 0 and 128", p[2], p[0]);
+                goto err;
+            }
+            reflect_add_filter_tier(&options->initial_cf_bloom_config,
+                                    &options->gc, true, netmask, limit);
+        }
+        else
+        {
+            msg(msglevel, "Unknown parameter %s for %s. Must be inet or in=
et6",
+                p[1], p[0]);
+            goto err;
+        }
+    }
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
     {
         int max_clients;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f608cb8..8448071 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -43,6 +43,7 @@
 #include "clinat.h"
 #include "crypto_backend.h"
 #include "dns.h"
+#include "reflect_filter.h"


 /*
@@ -515,6 +516,8 @@
     int cf_initial_max;
     int cf_initial_per;

+    struct bloom_filter_conf initial_cf_bloom_config;
+
     int max_clients;
     int max_routes_per_client;
     int stale_routes_check_interval;
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index 538bbbc..75445c0 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -38,8 +38,7 @@
 #include "crypto.h"
 #include "reflect_filter.h"

-
-bool
+static bool
 reflect_filter_rate_limit_check(struct initial_packet_rate_limit *irl)
 {
     if (now > irl->last_period_reset + irl->period_length)
@@ -72,34 +71,384 @@
     return !over_limit;
 }

-void
-reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl)
+static void
+reset_filter_tier(struct initial_packet_rate_limit *irl,
+                  struct filter_tier *tier, const char *prefix)
 {
+    for (; tier !=3D NULL; tier =3D tier->next)
+    {
+        if (tier->dropped > 0)
+        {
+            msg(D_TLS_DEBUG_LOW, "Dropped %zu initial handshake packets du=
e to "
+                "--connect-freq-initial-bloom-limit %s %d %d",
+                tier->dropped, prefix, tier->netmask, tier->limit);
+            tier->dropped =3D 0;
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
+     * and bloom filter usage is the same for 20000 request from the same =
IP
+     * (20k entries with different count but same IP) and from 20000 rando=
m ips
+     * (20k entries with count 1 but different IP) */
+    int count;
+};
+
+static inline struct bloom_filter_key
+filter_mask_inet6(struct openvpn_sockaddr *addr, int netmask)
+{
+    struct bloom_filter_key ret =3D { 0 };
+    ret.in6 =3D addr->addr.in6.sin6_addr;
+
+    int bits_to_clear =3D 128 - netmask;
+    int bytes_to_clear =3D  bits_to_clear /8;
+    bits_to_clear =3D bits_to_clear % 8;
+
+    memset(&ret.in6.s6_addr[15 - bytes_to_clear], 0x00, bytes_to_clear);
+
+    ret.in6.s6_addr[15 - bytes_to_clear - 1] &=3D (0xff << bits_to_clear);
+
+    ret.netmask =3D netmask;
+
+    return ret;
+}
+
+static inline struct bloom_filter_key
+filter_mask_inet(struct openvpn_sockaddr *addr, int netmask)
+{
+    struct bloom_filter_key ret =3D { 0 };
+    ret.in =3D addr->addr.in4.sin_addr;
+    ret.in.s_addr &=3D htonl(0xffffffff << (32 - netmask));
+    ret.netmask =3D netmask;
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
+reflect_lookup_bf_key(struct bloom_filter *bf, struct bloom_filter_key *ke=
y, int limit)
+{
+    /* we do a lookup for 1,2,3, and 4 and the limit first
+     * and after that do regular binary search. This is meant to optimise
+     * the common case where just a small number of requests are coming fr=
om
+     * each IP */
+    key->count =3D limit;
+    if (bloom_test(bf, (const uint8_t *) key, sizeof(struct bloom_filter_k=
ey)) > 0)
+    {
+        return limit;
+    }
+
+    key->count =3D 4;
+    if (bloom_test(bf, (const uint8_t *) key, sizeof(struct bloom_filter_k=
ey)) =3D=3D 0)
+    {
+        /* The value for 4 has not been found, so the real value might be =
1, 2, or 3. */
+        for (int i =3D 3; i > 0; i--)
+        {
+            key->count =3D i;
+            if (bloom_test(bf, (const uint8_t *) key, sizeof(struct bloom_=
filter_key)) > 0)
+            {
+                return i;
+            }
+        }
+
+        /* 4 was no in the map and 1-3 are also not there, so assume the k=
ey is not in the map */
+        return 0;
+    }
+
+    int low =3D 3;
+    int high =3D limit;
+
+    while (low < high)
+    {
+
+        key->count =3D (high + low + 1)/2;
+        bloom_counter_t count =3D bloom_test(bf, (const uint8_t *) key, si=
zeof(struct bloom_filter_key));
+        if (count > 0)
+        {
+            low =3D key->count;
+        }
+        else
+        {
+            high =3D key->count - 1;
+        }
+    }
+
+    if (low =3D=3D 4)
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
+    struct openvpn_sockaddr from_mapped =3D { 0 };
+    /* we ignore the fields like port that the key in the bloom filter
+     * ignores too. This makes this function non-generic */
+
+    from_mapped.addr.in4.sin_family =3D AF_INET;
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
+    bool found =3D false;
+    struct filter_tier *tier =3D NULL;
+
+    struct openvpn_sockaddr from_mapped;
+
+    if (from->addr.sa.sa_family =3D=3D AF_INET6
+        && IN6_IS_ADDR_V4MAPPED(&from->addr.in6.sin6_addr))
+    {
+        from_mapped =3D convert_mapped_inet_sockaddr(from);
+        from =3D &from_mapped;
+    }
+
+    if (from->addr.sa.sa_family =3D=3D AF_INET)
+    {
+        tier =3D irl->bloom_conf.inet_tiers;
+
+    }
+    else if (from->addr.sa.sa_family =3D=3D AF_INET6)
+    {
+        tier =3D irl->bloom_conf.inet6_tiers;
+    }
+
+    while (tier)
+    {
+        struct filter_tier *next_tier =3D tier->next;
+        struct bloom_filter_key key;
+
+        if (from->addr.sa.sa_family =3D=3D AF_INET6)
+        {
+            key =3D filter_mask_inet6(from, tier->netmask);
+        }
+        else
+        {
+            key =3D filter_mask_inet(from, tier->netmask);
+        }
+
+        /* fetch the current count of the key in the bloom filter */
+        int result =3D reflect_lookup_bf_key(irl->bf, &key, tier->limit);
+        struct gc_arena gc =3D gc_new();
+        gc_free(&gc);
+
+        switch (action)
+        {
+
+            case REFLECT_CHECK:
+                if (result >=3D tier->limit)
+                {
+                    found =3D true;
+                    tier->dropped++;
+                    if (tier->dropped =3D=3D 1)
+                    {
+                        msg(M_WARN, "Note: --connect-freq-initial-bloom-li=
mit "
+                            "limit for netmask /%d exceeded. Expect additi=
onal "
+                            "initial packet drops for the next %d seconds",
+                            tier->netmask,
+                            (int)(irl->last_period_reset + irl->period_len=
gth - now));
+                    }
+                }
+                break;
+
+            case REFLECT_INCREASE:
+                ASSERT(result < tier->limit);
+                key.count =3D result + 1;
+                bloom_add(irl->bf, (const uint8_t *) &key, sizeof(key));
+                break;
+
+            case REFLECT_DECREASE:
+                key.count =3D result - 1;
+                bloom_remove(irl->bf, (const uint8_t *) &key, sizeof(key));
+                break;
+        }
+
+        tier =3D next_tier;
+
+    }
+    if (!found && action =3D=3D REFLECT_CHECK)
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
+    /* We are doing the bloom filter check first so packets that are alrea=
dy
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
+void
+reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl, =
struct openvpn_sockaddr *from)
+{
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
+reflect_add_filter_tier(struct bloom_filter_conf *bfconf, struct gc_arena =
*gc,
+                        bool ipv6, int netmask, int limit)
+{
+    struct filter_tier *ftnew =3D gc_malloc(sizeof(struct filter_tier), tr=
ue, gc);
+
+    ftnew->netmask =3D netmask;
+    ftnew->limit =3D limit;
+
+    if (ipv6)
+    {
+        ftnew->next =3D bfconf->inet6_tiers;
+        bfconf->inet6_tiers =3D ftnew;
+    }
+    else
+    {
+        ftnew->next =3D bfconf->inet_tiers;
+        bfconf->inet_tiers =3D ftnew;
+    }
+}
+
+void
+init_bloom_filter(struct initial_packet_rate_limit *irl)
+{
+    if (!irl->bloom_conf.size)
+    {
+        /* the default allocates 2MB for bloom filter entries */
+        irl->bloom_conf.size =3D 1024ul * 1024 * 8;
+    }
+    if (!irl->bloom_conf.num_hashes)
+    {
+        irl->bloom_conf.num_hashes =3D 7;
+    }
+
+    irl->bf =3D bloom_create(irl->bloom_conf.size, irl->bloom_conf.num_has=
hes,
+                           &irl->gc);
+    bloom_clear(irl->bf);
+}

 struct initial_packet_rate_limit *
-initial_rate_limit_init(int max_per_period, int period_length)
+initial_rate_limit_init(int max_per_period, int period_length,
+                        struct bloom_filter_conf *bconf)
 {
-    struct initial_packet_rate_limit *irl;

+    struct initial_packet_rate_limit *irl =3D NULL;
+    ALLOC_OBJ_CLEAR(irl, struct initial_packet_rate_limit);

-    ALLOC_OBJ(irl, struct initial_packet_rate_limit);
+    irl->gc =3D gc_new();

     irl->max_per_period =3D max_per_period;
     irl->period_length =3D period_length;
     irl->curr_period_counter =3D 0;
     irl->last_period_reset =3D 0;

+    if (bconf)
+    {
+        irl->bloom_conf =3D *bconf;
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
+    irl =3D NULL;
 }
diff --git a/src/openvpn/reflect_filter.h b/src/openvpn/reflect_filter.h
index 12eb0a1..c639888 100644
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
@@ -35,7 +57,7 @@
     int period_length;

     /** Number of packets in the current period. We use int64_t here
-     * to avoid any potiential issues with overflow */
+     * to avoid any potential issues with overflow */
     int64_t curr_period_counter;

     /* Last time we reset our timer */
@@ -44,15 +66,28 @@
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
+reflect_add_filter_tier(struct bloom_filter_conf *bfconf, struct gc_arena =
*gc,
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
@@ -60,16 +95,27 @@
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
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index a4e6235..cd1c378 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -11,7 +11,7 @@
 endif

 test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_testd=
river ncp_testdriver misc_testdriver \
-	pkt_testdriver ssl_testdriver user_pass_testdriver
+	pkt_testdriver ssl_testdriver user_pass_testdriver reflect_testdriver

 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
@@ -144,6 +144,22 @@
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/tls_crypt.c

+reflect_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn
+reflect_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+reflect_testdriver_SOURCES =3D test_reflect.c mock_msg.c mock_msg.h \
+	$(top_srcdir)/src/openvpn/reflect_filter.c \
+	$(top_srcdir)/src/openvpn/bloom.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/siphash_reference.c \
+	$(top_srcdir)/src/openvpn/win32-util.c
+
 if !WIN32
 tls_crypt_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
diff --git a/tests/unit_tests/openvpn/test_reflect.c b/tests/unit_tests/ope=
nvpn/test_reflect.c
new file mode 100644
index 0000000..5158631
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_reflect.c
@@ -0,0 +1,327 @@
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
+#include "test_common.h"
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
+    static const int present_mod =3D 77;
+
+    struct gc_arena gc =3D gc_new();
+    /* Use a bloom filter with 1M entries (256kB) for the unit test */
+    struct bloom_filter *bf =3D bloom_create(1024ul*1024, 8, &gc);
+
+    for (int32_t i =3D 0; i < 20000; i +=3D present_mod)
+    {
+        bloom_add(bf, (const uint8_t *) &i, sizeof(i));
+    }
+
+    /* all these should be positive, for the small unit test we do not exp=
ect
+     * false positive */
+    for (int32_t i =3D 0; i < 20000; i++)
+    {
+        int present =3D (i % present_mod =3D=3D 0 ) ? 1 : 0;
+        /* cast to bool to only get 1 and 0 for present/not present and no=
t */
+        assert_int_equal((bool) bloom_test(bf, (const uint8_t *) &i, sizeo=
f(i)), present);
+    }
+
+    bloom_free(bf);
+    gc_free(&gc);
+}
+
+static void
+test_reflect_ddos(void **state)
+{
+    /* This tests if the bloom filter implementation does actually work wi=
th
+     * the goal of dropping packets to a reflected /24 while still allowing
+     * other clients */
+
+    /* Disable the normal fallback that puts a hard cap on the reflection =
filter */
+    struct initial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_=
MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 24, 5);
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 8, 20);
+    init_bloom_filter(irl);
+
+    int num_legimate_reject =3D 0;
+    int num_legimate_accepted =3D 0;
+
+    int num_ddos_rejected =3D 0;
+    int num_ddos_accepted =3D 0;
+
+
+    /* /24 net addresses in host byte order */
+    in_addr_t net_attack[4];
+    for (int i =3D 0; i < 3; i++)
+    {
+        net_attack[i] =3D random() % 0xff;
+    }
+
+    /* The 4th network is close enough to the 3rd to fall in the same /16 =
*/
+    /* XOR the 3rd byte to achieve this */
+    net_attack[3] =3D net_attack[2] ^ 00002300;
+
+    /* Assume 200000 packets, including roughly 200 legitimate packets,
+     * the unit test works also with 20 millions packet but takes too long=
*/
+    static const int total_packets =3D 200 * 1000;
+
+    for (int i =3D 0; i < total_packets; i++)
+    {
+        struct openvpn_sockaddr from =3D { 0 };
+        from.addr.in4.sin_family =3D AF_INET;
+        from.addr.in4.sin_addr.s_addr =3D random();
+        from.addr.in4.sin_port =3D random();
+
+        if (i % 1023 =3D=3D 0)
+        {
+            /* roughly 200 legitimate clients with random addresses */
+            from.addr.in4.sin_addr.s_addr =3D random();
+
+            bool allowed =3D reflect_filter_check(irl, &from);
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
+            from.addr.in4.sin_addr.s_addr  =3D net_attack[random() % 4] + =
(random() % 256);
+
+            bool allowed  =3D reflect_filter_check(irl, &from);
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
+    assert_int_equal(num_legimate_reject + num_legimate_accepted + num_ddo=
s_accepted + num_ddos_rejected, total_packets);
+
+    /* We assume that most legitimate made it through but a few were unfor=
tunate to be in an attacked network */
+    assert_in_range(num_legimate_reject, 0, 10);
+
+    /* We disabled total number of packets, so we expect all /8 to have th=
eir
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
+    struct gc_arena gc =3D gc_new();
+    struct bloom_filter *bf =3D bloom_create(2048, 3, &gc);
+
+    int item =3D 0xbabe;
+
+    bloom_add(bf, (const uint8_t *) &item, sizeof(item));
+    assert_int_equal(bloom_test(bf, (const uint8_t *) &item, sizeof(item))=
, 1);
+
+    item =3D 0xf00f;
+    assert_int_equal(bloom_test(bf, (const uint8_t *) &item, sizeof(item))=
, 0);
+
+    bloom_free(bf);
+    gc_free(&gc);
+}
+
+static void
+test_reflect_reflect_bloom_simple(void **state)
+{
+    struct initial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_=
MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, true, 32, 50);
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, true, 56, 200);
+    init_bloom_filter(irl);
+
+    struct openvpn_sockaddr from =3D { 0 };
+    from.addr.in6.sin6_family =3D AF_INET6;
+    from.addr.in6.sin6_port =3D random();
+    from.addr.in6.sin6_addr.s6_addr[15] =3D 1;  /* ::1 */
+
+    /* There are 50 attempts that should work until one fails */
+    for (int i =3D 0; i < 50; i++)
+    {
+        assert_true(reflect_filter_check(irl, &from));
+    }
+
+    /* 2002::1 */
+    struct openvpn_sockaddr from2 =3D from;
+    from2.addr.in6.sin6_addr.s6_addr[0] =3D 0x7;
+    from2.addr.in6.sin6_addr.s6_addr[1] =3D 0x7;
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
+    struct initial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_=
MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, true, 45, 10);
+    init_bloom_filter(irl);
+
+    struct openvpn_sockaddr from =3D { 0 };
+    from.addr.in6.sin6_family =3D AF_INET6;
+    from.addr.in6.sin6_port =3D random();
+    for (int i =3D 0; i < 15; i++)
+    {
+        from.addr.in6.sin6_addr.s6_addr[i] =3D random();
+    }
+
+    for (int i =3D 0; i < 10; i++)
+    {
+        /* /45 means that if we leave the leave first 8 bytes and 5 bits
+         * untouched, it is still the same subnet  */
+        for (int j =3D 8; j<15; j++)
+        {
+            from.addr.in6.sin6_addr.s6_addr[j] =3D random();
+            from.addr.in6.sin6_addr.s6_addr[7] ^=3D random() & 0x7;
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
+    struct initial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_=
MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 24, 50);
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 8, 80);
+    init_bloom_filter(irl);
+
+    /* Our OpenVPN server will not receive IPv4 as well as IPv4 mapped
+     * addresses in the same process but for the unit test it is convient
+     * to see if they actually mapped to the same entries */
+
+    struct openvpn_sockaddr mapped_v4 =3D  { 0 };
+    mapped_v4.addr.in6.sin6_family =3D AF_INET6;
+    mapped_v4.addr.in6.sin6_port =3D random();
+    /* ::ffff:192.168.0.99 */
+    mapped_v4.addr.in6.sin6_addr.s6_addr[10] =3D 0xff;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[11] =3D 0xff;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[12] =3D 192;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[13] =3D 168;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[14] =3D 0;
+    mapped_v4.addr.in6.sin6_addr.s6_addr[15] =3D 99;
+
+    assert_true(IN6_IS_ADDR_V4MAPPED(&mapped_v4.addr.in6.sin6_addr));
+
+    /* Not the same address but in the same /8 */
+    struct openvpn_sockaddr v4addr =3D {0 };
+    v4addr.addr.in4.sin_family =3D AF_INET;
+    v4addr.addr.in4.sin_port =3D random();
+    /* 192.168.123.244 */
+    v4addr.addr.in4.sin_addr.s_addr =3D htonl(0xc0a87bf4);
+
+    /* check that we run into the 50 limit with our mapped address */
+    for (int i =3D 0; i < 50; i++)
+    {
+        assert_true(reflect_filter_check(irl, &mapped_v4));
+    }
+    assert_false(reflect_filter_check(irl, &mapped_v4));
+
+
+    /* Check that the non-mapped IPv4 address uses the same /8 subnet limi=
t */
+    for (int i =3D 0; i < 30; i++)
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
+    static_assert(BLOOM_FILTER_BITS_COUNT =3D=3D 2, "unit test not in sync=
");
+    static_assert(BLOOM_FILTER_BITS_MASK =3D=3D 0x3, "unit test not in syn=
c");
+}
+
+
+int
+main(void)
+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTest tests[] =3D {
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
+    int ret =3D cmocka_run_group_tests_name("crypto tests", tests, NULL, N=
ULL);
+
+    return ret;
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/30?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
Gerrit-Change-Number: 30
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--rw+jdijlZu8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/30?usp=3Demail">Vie=
w Change</a></p><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Implement initial packet reflection protection using bloom fil=
ter<br><br>When an OpenVPN server is used/tried to be usedc in a reflection=
 attack<br>the protection with the simple --connect-freq-initial also block=
 legimitate<br>client from other networks that are not attacked by a reflec=
tion attack.<br><br>To allow a server to still reply to these clients, we n=
eed to make the counts<br>rather more detailed and count per subnet or IP a=
ddress. On the other hand<br>when we keep all this state, we eliminate the =
advantage of having a stateless<br>cookie based initial packet handshake.<b=
r><br>As compromoise we use a bloom filter to store the information. This d=
ata<br>structure is probabilistic and can have false positive and more pack=
ets<br>being dropped but since it is a constant size and the size of this m=
ap<br>is small enough for non-embedded systems (tests were done with a 2MB<=
br>bloom filter), it is a good compromise.<br><br>The code is split into th=
e bloom filter implementation and the actual logic<br>implementing tracking=
 the subnets, so the bloom filter should be relatively<br>easily be exchang=
able by another data structure.<br><br>As hash funtion SIPHASH has been cho=
sen since it was designed for this kind<br>of application.<br><br>Change-Id=
: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9<br>Signed-off-by: Arne Schwabe =
&lt;arne@...1227...&gt;<br>---<br>M .github/workflows/build.yaml<br>M CMake=
Lists.txt<br>M Changes.rst<br>M doc/man-sections/server-options.rst<br>M sr=
c/openvpn/Makefile.am<br>A src/openvpn/bloom.c<br>A src/openvpn/bloom.h<br>=
M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M src/openvpn/options.c<br=
>M src/openvpn/options.h<br>M src/openvpn/reflect_filter.c<br>M src/openvpn=
/reflect_filter.h<br>M tests/unit_tests/openvpn/Makefile.am<br>A tests/unit=
_tests/openvpn/test_reflect.c<br>15 files changed, 1,302 insertions(+), 15 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/30/30/9</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.githu=
b/workflows/build.yaml</span><br><span>index 361d457..93c67d1 100644</span>=
<br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/=
workflows/build.yaml</span><br><span>@@ -102,6 +102,9 @@</span><br><span>  =
       env:</span><br><span>           srcdir: &quot;${{ github.workspace }=
}/tests/unit_tests/openvpn&quot;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      - name: Run reflect unit test</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        run: ./unittests/tes=
t_reflect.exe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>   ubuntu:</span><br><span>     strategy:</span><br><span>      =
 fail-fast: false</span><br><span>diff --git a/CMakeLists.txt b/CMakeLists.=
txt</span><br><span>index ad620fa..5aba2d4 100644</span><br><span>--- a/CMa=
keLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -369,6 =
+369,7 @@</span><br><span>     src/openvpn/base64.c</span><br><span>     sr=
c/openvpn/base64.h</span><br><span>     src/openvpn/basic.h</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/bloom.c</span><br><=
span>     src/openvpn/buffer.c</span><br><span>     src/openvpn/buffer.h</s=
pan><br><span>     src/openvpn/circ_list.h</span><br><span>@@ -511,6 +512,8=
 @@</span><br><span>     src/openvpn/shaper.h</span><br><span>     src/open=
vpn/sig.c</span><br><span>     src/openvpn/sig.h</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    src/openvpn/siphash.h</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/siphash_reference.c</spa=
n><br><span>     src/openvpn/socket.c</span><br><span>     src/openvpn/sock=
et.h</span><br><span>     src/openvpn/socks.c</span><br><span>@@ -605,6 +60=
8,7 @@</span><br><span>         &quot;test_packet_id&quot;</span><br><span>=
         &quot;test_pkt&quot;</span><br><span>         &quot;test_provider&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;=
test_reflect&quot;</span><br><span>         &quot;test_ssl&quot;</span><br>=
<span>         &quot;test_user_pass&quot;</span><br><span>         )</span>=
<br><span>@@ -770,6 +774,19 @@</span><br><span>         src/openvpn/session=
_id.c</span><br><span>         )</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    target_sources(test_reflect PRIVATE</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/bloo=
m.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/open=
vpn/reflect_filter.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        src/openvpn/reflect_filter.h</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        src/openvpn/siphash.h</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        src/openvpn/siphash_reference.c</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/otime.c=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn=
/crypto_mbedtls.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      src/openvpn/crypto_openssl.c</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        src/openvpn/crypto.c</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        src/openvpn/packet_id.c</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     target_sources(test_pkt PRI=
VATE</span><br><span>         tests/unit_tests/openvpn/mock_win32_execve.c<=
/span><br><span>         src/openvpn/argv.c</span><br><span>diff --git a/Ch=
anges.rst b/Changes.rst</span><br><span>index 439352a..af72678 100644</span=
><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><s=
pan>@@ -9,6 +9,14 @@</span><br><span>     the user experience as the client=
 shows an error instead of running into</span><br><span>     a timeout when=
 the server just stops responding completely.</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+Bloom filter based reflection p=
rotection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    To avo=
id the limitation of ``--connect-freq-initial`` to block legimitate</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    clients when an OpenVPN=
 server is tried to be used in a reflection attack,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    the new ``--connect-freq-initial-bloo=
m-limit`` can impose limit on a</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    per-subnet basis. See the manual for more details. Note: th=
is option</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    requir=
es 2MB of extra memory in the default configuration.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> Deprecated features</span><br><span> -----=
--------------</span><br><span> ``secret`` support has been removed by defa=
ult.</span><br><span>diff --git a/doc/man-sections/server-options.rst b/doc=
/man-sections/server-options.rst</span><br><span>index 0632e31..f102df2 100=
644</span><br><span>--- a/doc/man-sections/server-options.rst</span><br><sp=
an>+++ b/doc/man-sections/server-options.rst</span><br><span>@@ -208,6 +208=
,77 @@</span><br><span>   will not be counted against the limit. The defaul=
t is to allow</span><br><span>   100 initial connection per 10s.</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+--connect-freq-initial-bloom-si=
ze args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+   Valid syntax:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+   ::</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      connect-freq-initial-bloom-size size [numhashes]</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+   Configures the size of the bloom filter used for=
 the initial connection</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+   packet responses. See `--connect-freq-initial-bloom-limit` for a ful=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   description of =
the feature.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   Bloom filters are proba=
bilistic by their nature and the larger the size</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   of the bloom filter is, the more accurate t=
hey are. This option configures</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   the number of buckets in the bloom filter. Each bucket takes=
 up 4 bits.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   E.g. =
the default of  8336608 (8 * 2^20) when the option is not set</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+   will require 2MB of memory. Th=
e numhashes will control the number of hash</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+   functions that are used for the bloom filter. Th=
e default is 7.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+--connect-freq-initial-=
bloom-limit arg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+   Valid syntax:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   ::</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      connect-freq-initial-bloom-limit inet netmask limit</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      connect-freq-in=
itial-bloom-limit inet6 netmask limit</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
  This option implements a rate limiting function for initial packet like</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+   ``--connect-freq-i=
nitial`` but takes the source of the initial packet into</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+   account. This function shares the t=
he reset after a time period and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+   enabling this function will not disable the overall limit o=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   ``--conect-freq=
-initial``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   To avoid resource exhaus=
tion on the OpenVPN server side from reflection</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+   attacks and also trying to avoid blocking le=
gitimate clients when an</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+   attacker tries to use an OpenVPN server, the limits are not applied=
 globally</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   but rat=
her a per netmask granularity. Each line of this command configures</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   a separate granularity. =
As example, the following configuration,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+   ::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        connect-freq-initial 10=
00 60</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        connec=
t-freq-initial-bloom-limit inet 24 50</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        connect-freq-initial-bloom-limit inet 8 100</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        connect-freq-init=
ial-bloom-limit inet6 56 50</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        connect-freq-initial-bloom-limit inet6 32 100</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    will limit the number of (unanswered) replies pe=
r /24 network to 50</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    packets. After 50 packets from the same /24, the server will</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    drop any further packets. =
Similarly, if a /16 network receives more than</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    100 connection requests, the server will dro=
p further packets.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   If the count of all packets exceeds 1000, further packets will be</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    completely dropped reg=
ardless of their origin.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   The impleme=
ntation uses a counting bloom filter to store information of how</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+   many packets the server has=
 seen per subnet. A bloom filter is a</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+   probabilistic data structure can yield false positives=
. In this case, the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
   server will drop packets even though the limit</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+   for that particular subnet is not yet reac=
hed. Since we are using a</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+   counting bloom filter, a reply from a client that triggers a remov=
al of an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   entry ca=
n also lead to a false negative. However, this is limited in the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+   sense a reply can at most t=
rigger one false negative.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   Every lim=
it configured with this option will put more more entries into</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+   the bloomfilter since per lim=
it (per family), one entry is put into the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+   bloom filter. So a large number of entries requir=
es a larger bloom filter</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+   to avoid too many false positives.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+   IPv6 mapped IPv4 addresses (::ffff:0:0/96) are treated as IPv4 addre=
sses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   for these li=
mits.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> --duplicate-cn</span><br><span>   Allow multiple clients with the same =
common name to concurrently</span><br><span>   connect. In the absence of t=
his option, OpenVPN will disconnect a client</span><br><span>diff --git a/s=
rc/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index 3784=
a98..ca77718 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br=
><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -44,6 +44,7 @@</spa=
n><br><span> 	auth_token.c auth_token.h \</span><br><span> 	base64.c base64=
.h \</span><br><span> 	basic.h \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bloom.c bloom.h \</span><br><span> 	buffer.c buffer.h \</s=
pan><br><span> 	circ_list.h \</span><br><span> 	clinat.c clinat.h \</span><=
br><span>@@ -124,6 +125,7 @@</span><br><span> 	session_id.c session_id.h \<=
/span><br><span> 	shaper.c shaper.h \</span><br><span> 	sig.c sig.h \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash_reference.c siph=
ash.h \</span><br><span> 	socket.c socket.h \</span><br><span> 	socks.c soc=
ks.h \</span><br><span> 	ssl.c ssl.h  ssl_backend.h \</span><br><span>diff =
--git a/src/openvpn/bloom.c b/src/openvpn/bloom.c</span><br><span>new file =
mode 100644</span><br><span>index 0000000..729429e</span><br><span>--- /dev=
/null</span><br><span>+++ b/src/openvpn/bloom.c</span><br><span>@@ -0,0 +1,=
253 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application =
to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             over a single TCP/UDP port, with support for SSL/=
TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     session authentication and key exchange,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             packet encryption, packet authenti=
cation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       packet compression.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyri=
ght (C) 2022 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  This program is free software; you can redistribute it and/=
or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it und=
er the terms of the GNU General Public License version 2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software =
Foundation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distr=
ibuted in the hope that it will be useful,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the impli=
ed warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  M=
ERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for=
 more details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have re=
ceived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* This file implements a specialised counting bloo=
m filter implementation</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * used in OpenVPN to mitigate it being used in reflection attacks. The=
 bloom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * implementa=
tion should be general enough to be used in other contexts</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * however */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#elif defined(_MSC_VER)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;config-msvc.h&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt=
;stdint.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &lt;stddef.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;stdlib.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;string.h&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &lt;stdbool.h&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;siphash.h&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;crypto.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;bloom.h&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static s=
ize_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+calc_ceil_log2=
(size_t num)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Figure out how man=
y bits we have in our hash by doing</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * ceil(log2(bf-&gt;size) */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    size_t numbits =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    while (num &gt;&gt;=3D 1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        numbits++;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return numbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Calculate number of bytes needed for each hash functi=
on in the bloom filter</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static inline size_t</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+calculate_num_bytes_hashfun(s=
ize_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t hash_bits =3D c=
alc_ceil_log2(size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* round up to the nearest byte size */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    size_t hash_bytes =3D (hash_bits + 7) /8;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return hash_bytes;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * A bloom filter uses a number of hashes to perform its functionality.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Instead of using the same number of =
siphash function we split the bytes of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * the siphash to the different hashes.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * We could also optimise this further by splitting a=
t the bit level but that</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * crates a lot of extra code for bit shifting, etc. so we waste some =
bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param bf</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param num_hashes</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
alculate_num_sip_hash_hashes(struct bloom_filter *bf)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    size_t hash_bytes =3D calculate_num_bytes_hashfun(bf-&g=
t;size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t =
total_bytes =3D bf-&gt;num_hashes * hash_bytes;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Round up to next SIPHASH_HASH_SIZE */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t num_siphash =3D (total_bytes +=
 SIPHASH_HASH_SIZE -1) / SIPHASH_HASH_SIZE;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return num_siphash;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Calculates the number of bytes we need fo=
r storing a bloom filter of size</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * size. We add + 1 to avoid rounding problems and too small a=
llocation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
inline</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_get_filter_byte_coun=
t(size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    static_assert(sizeo=
f(bloom_counter_t) * 8 % BLOOM_FILTER_BITS_COUNT =3D=3D 0,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                  &quot;bloom_counte=
r_t must be a multiple of BLOOM_FILTER_BIT_COUNT&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return size * sizeof(bloom_counter_t)/BLOOM_FILTER_BI=
TS_COUNT + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloo=
m_get_filter_bit_offset(size_t bucket)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return (bucket * BLOOM_FILTER_BITS_COUNT) % sizeof(bloom_counter_t);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static inline</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bl=
oom_get_filter_array_index(size_t bucket)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return (bucket * BLOOM_FILTER_BITS_COUNT) / sizeof(bloom_counter_t)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static inline bloom_counter_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bloom_get_filter_get_counter(struct bloom_fil=
ter *bf, size_t bucket)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static_ass=
ert((BLOOM_FILTER_BITS_MASK + 1) =3D=3D  (1 &lt;&lt; BLOOM_FILTER_BITS_COUN=
T),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
  &quot;BLOOM_FILTER_BITMASK and BLOOM_FILTER_BIT_COUNT are inconsistent&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t counter =3D b=
f-&gt;buckets[bloom_get_filter_array_index(bucket)];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t bitoffset =3D bloom_get_filter=
_bit_offset(bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (counte=
r &gt;&gt; bitoffset) &amp; BLOOM_FILTER_BITS_MASK;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloo=
m_set_filter_counter(struct bloom_filter *bf, size_t bucket, bloom_counter_=
t value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t data =3D =
bf-&gt;buckets[bloom_get_filter_array_index(bucket)];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t bitoffset =3D bloom_get_filter=
_bit_offset(bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    data =3D data =
&amp; ~(BLOOM_FILTER_BITS_MASK &lt;&lt; bitoffset);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    data =3D data | ((value &amp; BLOOM_FILTER_BITS_MASK) &l=
t;&lt; bitoffset);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;buckets[b=
loom_get_filter_array_index(bucket)] =3D data;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Creates a new bloom fil=
ter structure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram size the number of buckets.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return  the newly created bloom filter structure</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+struct bloom_filter *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bloom_create(size_t size, size_t num_hashes,=
 struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t bloom=
filter_bytes =3D bloom_get_filter_byte_count(size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter *bf =3D gc_malloc=
(sizeof(struct bloom_filter) + bloomfilter_bytes,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                        false=
, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;si=
ze =3D size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bf-=
&gt;num_hashes =3D num_hashes;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bf-&=
gt;hash_bytes =3D calculate_num_bytes_hashfun(size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;num_siphash =3D calculate_num_=
sip_hash_hashes(bf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY_GC=
(bf-&gt;siphash_keys, struct siphash_key, bf-&gt;num_siphash, gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bloom_clear(bf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return bf;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Clear the bloom filter, ma=
king it empty again as if it were freshly created</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param bf the bloom structure to clear</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bloom_clear(struct bloom_filter *bf)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    memset(bf-&gt;buckets, 0, bloom_get_filter_byte_cou=
nt(bf-&gt;size));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We randomise t=
he bloom filter keys on every clear of the bloom filter</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * to avoid scenarios where an atta=
cker might learn specific pattern</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * that could exploit false positives in the bloom filter=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t =
i =3D 0; i &lt; bf-&gt;num_siphash; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        prng_bytes(bf-&gt;siphash_keys[i].key, SIPHASH_KEY_SIZE);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bloom_coun=
ter_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_add_test=
(struct bloom_filter *bf, const uint8_t *item, size_t len, bloom_counter_t =
inc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint8_t result[SIPHASH_HASH_S=
IZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t j =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t id=
x =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bloom_c=
ounter_t ret =3D bloom_counter_max;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (size_t i =3D 0; i &lt; bf-&gt;num_hashes; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        size_t bucket =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        for (int k =3D 0; k &lt; bf-&gt;hash_b=
ytes; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (idx=
 =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 /* We have no longer unused bytes in result, generate the next hash */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                siphash=
(item, len, bf-&gt;siphash_keys[j++].key, result, SIPHASH_HASH_SIZE);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            bucket =3D bucket &lt;&lt; 8;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            bucket |=3D resu=
lt[idx];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            idx =3D (idx + 1) =
% SIPHASH_HASH_SIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        bucket =3D bucket % =
bf-&gt;size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 bloom_counter_t value =3D bloom_get_filter_get_counter(bf, bucket);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ret =3D min_bloom_counter(ret, value)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (inc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            value =3D min_bloom_counter(bloom_coun=
ter_max, value + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            bloom_set_filter_counter(bf, bucket, value);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bloom_add(struct bloom_filter *bf, const uint8_t *=
item, size_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return bloom_add=
_test(bf, item, len, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bloom_remove(struct bloom_filter *bf=
, const uint8_t *item, size_t len)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return bloom_add_test(bf, item, len, -1);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bloom_test(struct bloom_filter *bf, c=
onst uint8_t *item, size_t len)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn bloom_add_test(bf, item, len, 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/bloom.h b/src=
/openvpn/bloom.h</span><br><span>new file mode 100644</span><br><span>index=
 0000000..e180261</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/bloom.h</span><br><span>@@ -0,0 +1,97 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a s=
ingle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             session authentication and ke=
y exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet compression.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2022 OpenVPN Inc &lt;sa=
les@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is=
 free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is distributed in the hope that it will=
 be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Genera=
l Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin =
Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef=
 BLOOM_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define BLO=
OM_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdint.h&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash.h&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;bu=
ffer.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* This is the type we use=
 for the buckets. This is split into small buckets</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * with BLOOM_FILTER_BIT_COUNT size */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef uint32_t bloom_co=
unter_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define BLO=
OM_FILTER_BITS_COUNT    2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define BLOOM_FILTER_BITS_MASK   0x03</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define bloom_counter_max        0x03</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline bloom_counter_t</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+min_bloom_counter(bloom_counter_t x, bloom_counter_t y)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (x &lt; y)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return x;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return y;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct siphash_key {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint8_t key[SIPHASH_KEY_SIZE];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct bloom_filter=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Size of t=
he bloom filter in entries, ie total bits/bits per counter */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    size_t size;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /** Number of bytes used by each hash function:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * log2(size * 8) bits rounded u=
p to the next byte</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * This is=
 a cached value since log2 is surprisingly slow</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * (5% of total time of if we do not cache =
it) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t ha=
sh_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /** number of hashes we u=
se to determine the bit positions */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    size_t num_hashes;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /** number of siphash function needed to calculate.=
 This can be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
calculated from the other members of the struct but we store it</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * in the struct for fast a=
ccess */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t =
num_siphash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /** keys for the sipha=
sh functions */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct siphash_key *siphash_keys;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
** the actual buckets that hold the data */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    bloom_counter_t buckets[];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct bloom_filter =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_create(size_=
t size, size_t num_hashes, struct gc_arena *gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bloom_counter_t</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bloom_test(struct bloom_filter *bf, const uint8_t *item, size_t len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bloom_add(struct bloom_filter *bf, const =
uint8_t *item, size_t len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_count=
er_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_remove(st=
ruct bloom_filter *bf, const uint8_t *item, size_t len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bloom_clear(struct bloom_filter *bf);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif /* ifndef BLOOM_H */</span><br><span>diff --git=
 a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 268b430..9=
fbffac 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ =
b/src/openvpn/mudp.c</span><br><span>@@ -84,7 +84,7 @@</span><br><span>    =
 {</span><br><span>         /* Check if we are still below our limit for se=
nding out</span><br><span>          * responses */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (!reflect_filter_rate_limit_check(m=
-&gt;initial_rate_limiter))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!reflect_filter_check(m-&gt;initial_rate_limiter, from)=
)</span><br><span>         {</span><br><span>             return false;</sp=
an><br><span>         }</span><br><span>@@ -254,7 +254,8 @@</span><br><span=
>                 {</span><br><span>                     /* a successful th=
ree-way handshake only counts against</span><br><span>                     =
 * connect-freq but not against connect-freq-initial */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    reflect_filter_rate_l=
imit_decrease(m-&gt;initial_rate_limiter);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    reflect_filter_rate_limit_decrea=
se(m-&gt;initial_rate_limiter,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                                       &amp;m-&g=
t;top.c2.from.dest);</span><br><span> </span><br><span>                    =
 mi =3D multi_create_instance(m, &amp;real);</span><br><span>              =
       if (mi)</span><br><span>diff --git a/src/openvpn/multi.c b/src/openv=
pn/multi.c</span><br><span>index 0509911..b9de040 100644</span><br><span>--=
- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br=
><span>@@ -368,7 +368,8 @@</span><br><span>     m-&gt;new_connection_limite=
r =3D frequency_limit_init(t-&gt;options.cf_max,</span><br><span>          =
                                            t-&gt;options.cf_per);</span><b=
r><span>     m-&gt;initial_rate_limiter =3D initial_rate_limit_init(t-&gt;o=
ptions.cf_initial_max,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                                      t-&gt;options.cf_ini=
tial_per);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                             t-&gt;options.cf_initial_per,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                                  &amp;t-&gt;options.initial_cf_bloom_confi=
g);</span><br><span> </span><br><span>     /*</span><br><span>      * Alloc=
ate broadcast/multicast buffer list</span><br><span>diff --git a/src/openvp=
n/options.c b/src/openvpn/options.c</span><br><span>index 649f48b..20c953a =
100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/sr=
c/openvpn/options.c</span><br><span>@@ -3461,6 +3461,22 @@</span><br><span>=
 }</span><br><span> </span><br><span> static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+check_filter_tier_under_global_limit(struct f=
ilter_tier *ft, size_t limit,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                     const char *family)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    while (ft)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (ft-&gt;limit &lt; limit)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(M_WARN, &quot;Note: --connect-freq-initial=
-bloom-limit %s %d %d &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                &quot;has a larger limit than connect-freq-limit-i=
nitial &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          &quot;limit (%zu).&quot;, family, ft-&gt;netmask, ft-&gt;limit, l=
imit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ft =3D ft-&gt;n=
ext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span> options_postprocess_verify(const stru=
ct options *o)</span><br><span> {</span><br><span>     if (o-&gt;connection=
_list)</span><br><span>@@ -3484,6 +3500,18 @@</span><br><span>             =
&quot;channel offload: packets are always sent to the VPN &quot;</span><br>=
<span>             &quot;interface and then routed based on the system rout=
ing table&quot;);</span><br><span>     }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if ((bool)(o-&gt;initial_cf_bloom_config.inet_tiers)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        +(bool)(o-&gt;initial_cf_blo=
om_config.inet6_tiers) =3D=3D 1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_FATAL, &quot;connect-freq-initial-bloom-limit must be provided=
 for &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    &quot;both inet and inet6&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    check_filter_tier_under_global_limit(o-&gt;initial_cf_bloom_config.=
inet_tiers,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                 o-&gt;cf_initial_max, &quot;inet&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_filter_tier=
_under_global_limit(o-&gt;initial_cf_bloom_config.inet6_tiers,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
         o-&gt;cf_initial_max, &quot;inet6&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> }</span><br><span> </span>=
<br><span> </span><br><span>@@ -7562,6 +7590,71 @@</span><br><span>        =
 options-&gt;cf_initial_max =3D cf_max;</span><br><span>         options-&g=
t;cf_initial_per =3D cf_per;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;connect-fr=
eq-initial-bloom-size&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int cf_bloom_size =3D atoi(p[1]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (cf_bloom_size &lt;=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot=
;--connect-freq-initial-bloom-size size must be &gt; 0&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        options-&gt;initial_cf_bloom_con=
fig.size =3D cf_bloom_size;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (p[2])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        int num_hash =3D atoi(p[1]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (num_hash &lt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--connect-f=
req-initial-bloom-size number of hash &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    &quot;functions must be &gt; 0=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 options-&gt;initial_cf_bloom_config.num_hashes =3D num_hash;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (streq(p[0], &quot;connect-freq-initial-blo=
om-limit&quot;) &amp;&amp; p[1] &amp;&amp; p[2]</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             &amp;&amp; p[3] &amp;&amp; !p[4])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int netmask =3D atoi(p[2])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int limit =
=3D atoi(p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (limit &lt;=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msgleve=
l, &quot;Limit parameter to %s must be &gt; 0&quot;, p[0]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (streq(p[1], &quot;inet&quot;))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (netmask &lt; 0 || netmask &gt; =
32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(ms=
glevel, &quot;Netmask parameter (%s) for IPv4 for %s must be &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;b=
etween 0 and 32&quot;, p[2], p[0]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                goto err;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            reflect_add_filter_tier(&amp;options-&gt;initia=
l_cf_bloom_config,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                   &amp;options-&gt;gc, false, netmask, lim=
it);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (streq(p[=
1], &quot;inet6&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (netmask &lt; 0 || netmask &gt; 128)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                msg(msglevel, &quot;Netmask parameter (=
%s) for IPv6 for %s must be &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    &quot;between 0 and 128&quot;, p[2], p[0=
]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            refl=
ect_add_filter_tier(&amp;options-&gt;initial_cf_bloom_config,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
   &amp;options-&gt;gc, true, netmask, limit);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(msglevel, &quot;Unknown parameter %s for %s. Must be inet o=
r inet6&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           p[1], p[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span>     else if (streq(p[0], &quot;max-clients&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>        =
 int max_clients;</span><br><span>diff --git a/src/openvpn/options.h b/src/=
openvpn/options.h</span><br><span>index f608cb8..8448071 100644</span><br><=
span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.=
h</span><br><span>@@ -43,6 +43,7 @@</span><br><span> #include &quot;clinat.=
h&quot;</span><br><span> #include &quot;crypto_backend.h&quot;</span><br><s=
pan> #include &quot;dns.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;reflect_filter.h&quot;</span><br><span> </span><=
br><span> </span><br><span> /*</span><br><span>@@ -515,6 +516,8 @@</span><b=
r><span>     int cf_initial_max;</span><br><span>     int cf_initial_per;</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct bloom_filter_conf initial_cf_bloom_config;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     int max_clients;</span=
><br><span>     int max_routes_per_client;</span><br><span>     int stale_r=
outes_check_interval;</span><br><span>diff --git a/src/openvpn/reflect_filt=
er.c b/src/openvpn/reflect_filter.c</span><br><span>index 538bbbc..75445c0 =
100644</span><br><span>--- a/src/openvpn/reflect_filter.c</span><br><span>+=
++ b/src/openvpn/reflect_filter.c</span><br><span>@@ -38,8 +38,7 @@</span><=
br><span> #include &quot;crypto.h&quot;</span><br><span> #include &quot;ref=
lect_filter.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><b=
r><span> reflect_filter_rate_limit_check(struct initial_packet_rate_limit *=
irl)</span><br><span> {</span><br><span>     if (now &gt; irl-&gt;last_peri=
od_reset + irl-&gt;period_length)</span><br><span>@@ -72,34 +71,384 @@</spa=
n><br><span>     return !over_limit;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-reflect_filter_rate_limit_decrease(struc=
t initial_packet_rate_limit *irl)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+reset_filter_tier(struct initial_packet_rate_limit *irl,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                  struct filter_=
tier *tier, const char *prefix)</span><br><span> {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (; tier !=3D NULL; tier =3D tier-&gt=
;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tier-&gt;droppe=
d &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TL=
S_DEBUG_LOW, &quot;Dropped %zu initial handshake packets due to &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;--=
connect-freq-initial-bloom-limit %s %d %d&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                tier-&gt;dropped, prefix, tier=
-&gt;netmask, tier-&gt;limit);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            tier-&gt;dropped =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bloom_filter_check_reset(struct initial_p=
acket_rate_limit *irl)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (now &gt=
; irl-&gt;last_period_reset + irl-&gt;period_length)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        reset_filter_tier(irl, irl-&gt;bloom_conf.inet_=
tiers, &quot;inet&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        reset_filter_tier(irl, irl-&gt;bloom_conf.inet6_tiers, &quot;=
inet6&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        bloom_clear(irl-&=
gt;bf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * structure used as lo=
okup key for the bloom structure. We used the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * netmask as part of the structure to avoid the =
look for the first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* IP of a subnet and the subnet to be same key.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct bloom_filter_key {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    union {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct in_addr in;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct in6_addr in6;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int netmask;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* we keep the count in the key instead of in the bloom filte=
r table as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ca=
n then keep the counter in the bloom filter itself small (2 bits)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * and bloom filter usage=
 is the same for 20000 request from the same IP</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * (20k entries with different count but sa=
me IP) and from 20000 random ips</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * (20k entries with count 1 but different IP) */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int count;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static inline struct bloom_filter_key</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+filter_mask_inet6(struct openvpn_sockaddr *addr, in=
t netmask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter_key=
 ret =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ret.in6 =3D addr-&gt;addr.in6.sin6_addr;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int bits_to_clear =3D 128 - netmask;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int bytes_to_clear =3D  bits_to_clear /8;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    bits_to_clear =3D bits=
_to_clear % 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(&amp;ret.in6.=
s6_addr[15 - bytes_to_clear], 0x00, bytes_to_clear);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ret.in6.s6_addr[15 - bytes_to_clear - 1] &amp;=3D (0xff =
&lt;&lt; bits_to_clear);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret.netmas=
k =3D netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static inline struct bloom_filter_key</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+filter_mask_inet(struct openvpn_sockaddr *addr,=
 int netmask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter_=
key ret =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ret.in =3D addr-&gt;addr.in4.sin_addr;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ret.in.s_addr &amp;=3D htonl(0xffffffff &lt;&lt; =
(32 - netmask));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ret.netmask =3D netmask;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* We use one function and an actio=
n argument to avoid repeating</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * the code to iterate to the tiers and the creating the lookup</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * keys */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+enum bloom_filter_action</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    REFLECT_CHECK,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    REFLECT_INCREASE,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    REFLECT_DECREASE,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reflect=
_lookup_bf_key(struct bloom_filter *bf, struct bloom_filter_key *key, int l=
imit)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* we do a lookup for 1,2,3,=
 and 4 and the limit first</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * and after that do regular binary search. This is meant to opt=
imise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the com=
mon case where just a small number of requests are coming from</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * each IP */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    key-&gt;count =3D limit;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bloom_test(bf, (c=
onst uint8_t *) key, sizeof(struct bloom_filter_key)) &gt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return limit;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 key-&gt;count =3D 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (bloom_test(bf, (const uint8_t *) key, sizeof(struct bloom_filter_=
key)) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The val=
ue for 4 has not been found, so the real value might be 1, 2, or 3. */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 3=
; i &gt; 0; i--)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            k=
ey-&gt;count =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (bloom_test(bf, (const uint8_t *) key, sizeof(struct bloom_f=
ilter_key)) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          return i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* 4 was no in the map and =
1-3 are also not there, so assume the key is not in the map */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int low =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int high =3D limit;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whil=
e (low &lt; high)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        key-&gt;count =3D (high + l=
ow + 1)/2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        b=
loom_counter_t count =3D bloom_test(bf, (const uint8_t *) key, sizeof(struc=
t bloom_filter_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (count &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          low =3D key-&gt;count;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            hi=
gh =3D key-&gt;count - 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (low =3D=3D 4)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* we reached the lower end of our binary=
 search have not found the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * key and we know that 4 is in the map */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return 4;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return low;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Convert a mapped IPv6 mapped IPv4 address (::ffff:0:0/96) to an</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * equivalent IPv4 adre=
ss.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @note: This function only conv=
erts the IP itself and ignores other</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * parts of the \c from structure like port or protocol.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static struct openvpn_sockaddr</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+convert_mapped_inet_sockad=
dr(struct openvpn_sockaddr *from)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct openvpn_sockaddr from_mapped =3D { 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* we ignore the fields like port that the k=
ey in the bloom filter</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * ignores too. This makes this function non-generic */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    from_mapped.addr.in4.sin_family =3D AF_INET;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    memcpy(&amp;from_mapped.addr.in4.sin_=
addr.s_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
    &amp;from-&gt;addr.in6.sin6_addr.s6_addr[12],</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+           sizeof(from_mapped.addr.in4.sin_ad=
dr.s_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return from_mapped;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bloom_filter_action(struct initial_packet_rate_limit *irl,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    struct o=
penvpn_sockaddr *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    enum bloom_filter_action action)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool found =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct filter_tier *tier =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from_mapped;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (from-&gt;addr.sa.sa_family =3D=3D AF_INET=
6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp;=
 IN6_IS_ADDR_V4MAPPED(&amp;from-&gt;addr.in6.sin6_addr))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        from_mapped =3D convert_mapped_inet_sockaddr=
(from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        from=
 =3D &amp;from_mapped;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (from-&gt;addr.sa.sa_fa=
mily =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tier =
=3D irl-&gt;bloom_conf.inet_tiers;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (from-=
&gt;addr.sa.sa_family =3D=3D AF_INET6)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        tier =3D irl-&gt;bloom_conf.inet6_tiers;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    while (tier)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct f=
ilter_tier *next_tier =3D tier-&gt;next;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct bloom_filter_key key;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (from-&gt;addr.sa.sa_family =3D=3D AF_INET6)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            key =3D filter_mas=
k_inet6(from, tier-&gt;netmask);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ke=
y =3D filter_mask_inet(from, tier-&gt;netmask);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* fetch the current count of the key in the bloom filter */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        int result =3D refl=
ect_lookup_bf_key(irl-&gt;bf, &amp;key, tier-&gt;limit);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        switch (action)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            case REFLECT_CHECK:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if (result &gt;=3D tier-&=
gt;limit)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        found =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    tier-&gt;dropped++;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    if (tier-&gt;dropped =3D=3D 1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      msg(M_WARN, &quot;Note: --connect-freq-initial-bloom-limit &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
     &quot;limit for netmask /%d exceeded. Expect additional &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 &quot;initial packet drops for the next %d seconds&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                            tier-&gt=
;netmask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                  (int)(irl-&gt;last_period_reset + irl-&gt;period_length -=
 now));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            case REFLECT_INC=
REASE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   ASSERT(result &lt; tier-&gt;limit);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                key.count =3D result + 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                bloom_add(irl-&gt;=
bf, (const uint8_t *) &amp;key, sizeof(key));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            case REFLECT_DECREASE:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                key.count =3D result - 1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                bloom_remove=
(irl-&gt;bf, (const uint8_t *) &amp;key, sizeof(key));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        tier =3D next_tier;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!found &=
amp;&amp; action =3D=3D REFLECT_CHECK)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* We only want to increase the counters if the IP is not alre=
ady</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * in th=
e set. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bl=
oom_filter_action(irl, from, REFLECT_INCREASE);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return found;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bloom_filter_check(struct initial=
_packet_rate_limit *irl,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                   struct openvpn_sockaddr *from)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (now &gt; irl-&gt;last_period_reset + irl-&gt;perio=
d_length)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        bloom_filter_check_reset(irl);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        bloom_clear(ir=
l-&gt;bf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return bloom_filter_action(irl, from,=
 REFLECT_CHECK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+reflect_filter_check(struct initial_packet_rate_limit *irl,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     struct openvp=
n_sockaddr *from)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We are doing =
the bloom filter check first so packets that are already</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * rejected by the bloom filter do=
 not count against the limit of the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * simple rate limiter */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (irl-&gt;bf &amp;&amp; bloom_filter_check(=
irl, from))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!reflect_filter_rate_limit_check(irl))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit *i=
rl, struct openvpn_sockaddr *from)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (irl-&gt;bf &amp;&amp; bloom_filter_action(irl, from, REFLECT_CHECK))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* Only remove if it is act=
ually present. This might be a packet</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * coming from an early period or be relayed */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bloom_filter_=
action(irl, from, REFLECT_DECREASE);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     if (irl-&gt;curr_period_counter &gt; 0)</span><br>=
<span>     {</span><br><span>         irl-&gt;curr_period_counter--;</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+reflect_add_filter_tier(struct bloom_filter_conf *bfconf=
, struct gc_arena *gc,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        bool ipv6, int netmask, int limit)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct filter_tier *ftnew =3D gc_malloc(sizeof(=
struct filter_tier), true, gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ftn=
ew-&gt;netmask =3D netmask;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ftnew-&gt;limit =3D limit;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ftnew-&gt;ne=
xt =3D bfconf-&gt;inet6_tiers;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        bfconf-&gt;inet6_tiers =3D ftnew;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ftnew-&gt;next =3D bfconf-&gt;inet_tiers;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        bfconf-&gt;inet_tiers =3D ftnew;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_bloom_filter(=
struct initial_packet_rate_limit *irl)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!irl-&gt;bloom_conf.size)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* the default allocates 2MB for bloom filter entries */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        irl-&gt;bloom_conf.si=
ze =3D 1024ul * 1024 * 8;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!irl-&gt;bloom_conf.num_hashes)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      irl-&gt;bloom_conf.num_hashes =3D 7;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    irl-&g=
t;bf =3D bloom_create(irl-&gt;bloom_conf.size, irl-&gt;bloom_conf.num_hashe=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
          &amp;irl-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bloom_clear(irl-&gt;bf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span> </span><br><span> struct initial_packet=
_rate_limit *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-initial_=
rate_limit_init(int max_per_period, int period_length)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+initial_rate_limit_init(int max_per_peri=
od, int period_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        struct bloom_filter_conf *bconf)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct initial=
_packet_rate_limit *irl;</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct initial_packet_rate_limit *irl =3D NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(=
irl, struct initial_packet_rate_limit);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ(irl, struct initial_packe=
t_rate_limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
rl-&gt;gc =3D gc_new();</span><br><span> </span><br><span>     irl-&gt;max_=
per_period =3D max_per_period;</span><br><span>     irl-&gt;period_length =
=3D period_length;</span><br><span>     irl-&gt;curr_period_counter =3D 0;<=
/span><br><span>     irl-&gt;last_period_reset =3D 0;</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bconf)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        irl-&gt;bloom_conf =3D *bconf;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        init_bloom_fil=
ter(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     re=
turn irl;</span><br><span> }</span><br><span> </span><br><span> void</span>=
<br><span> initial_rate_limit_free(struct initial_packet_rate_limit *irl)</=
span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;irl-&gt;gc);</span><br><span>     free(irl);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    irl =3D NULL;</span><br><span> =
}</span><br><span>diff --git a/src/openvpn/reflect_filter.h b/src/openvpn/r=
eflect_filter.h</span><br><span>index 12eb0a1..c639888 100644</span><br><sp=
an>--- a/src/openvpn/reflect_filter.h</span><br><span>+++ b/src/openvpn/ref=
lect_filter.h</span><br><span>@@ -24,6 +24,28 @@</span><br><span> #define R=
EFLECT_FILTER_H</span><br><span> </span><br><span> #include &lt;limits.h&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;soc=
ket.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;bloom.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct filter_tier=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct filter=
_tier *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int limit;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int netmask;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /** The number of packets we dropped since we wen=
t over this limit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    size_t dropped;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+struct bloom_filter_conf {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct filter_tier *inet=
_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct f=
ilter_tier *inet6_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Configu=
ration of the bloom filter */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    size_t num_hashes;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size_t size;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> </span><br><span> /** struct that handles all the rate limiting =
logic for initial</span><br><span>  * responses */</span><br><span>@@ -35,7=
 +57,7 @@</span><br><span>     int period_length;</span><br><span> </span><=
br><span>     /** Number of packets in the current period. We use int64_t h=
ere</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * to avoid an=
y potiential issues with overflow */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * to avoid any potential issues with overflow */</spa=
n><br><span>     int64_t curr_period_counter;</span><br><span> </span><br><=
span>     /* Last time we reset our timer */</span><br><span>@@ -44,15 +66,=
28 @@</span><br><span>     /* we want to warn once per period that packets =
are being started to</span><br><span>      * be dropped */</span><br><span>=
     bool warning_displayed;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 bloom_filter_conf bloom_conf;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct bloom_filter *bf;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* gc_arena used for the various allocations by this struct */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc;</sp=
an><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Adds a bloom filter tier to the bloom filter config.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+reflect_add_filter_tier(struct bloom_filter_conf *bfconf, struct gc_are=
na *gc,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            bool ipv6, int netmask, int limit);</span><br><span> </span><br=
><span> /**</span><br><span>  * checks if the connection is still allowed t=
o connect under the rate</span><br><span>  * limit. This also increases the=
 internal counter at the same time</span><br><span>  */</span><br><span> bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reflect_filter_rate=
_limit_check(struct initial_packet_rate_limit *irl);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+reflect_filter_check(struct initial_packe=
t_rate_limit *irl,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    struct openvpn_sockaddr *from);</span><br><span> </span=
><br><span> /**</span><br><span>  * decreases the counter of initial packet=
s seen, so connections that</span><br><span>@@ -60,16 +95,27 @@</span><br><=
span>  * the counter of initial connection attempts</span><br><span>  */</s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-re=
flect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+reflect_filter_rate_li=
mit_decrease(struct initial_packet_rate_limit *irl,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                   struct=
 openvpn_sockaddr *from);</span><br><span> </span><br><span> /**</span><br>=
<span>  * allocate and initialize the initial-packet rate limiter structure=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Note: this function does not copy=
 bconf&#39;s contents.</span><br><span>  */</span><br><span> struct initial=
_packet_rate_limit *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
nitial_rate_limit_init(int max_per_period, int period_length);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+initial_rate_limit_init(int max_=
per_period, int period_length,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        struct bloom_filter_conf *bconf);</span>=
<br><span> </span><br><span> /**</span><br><span>  * free the initial-packe=
t rate limiter structure</span><br><span>  */</span><br><span> void initial=
_rate_limit_free(struct initial_packet_rate_limit *irl);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Initialises the bloom filter with the configuration values of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * irl-&gt;bloom_conf</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+init_bloom_filter(struct initial_packet_rate_limit *irl)=
;</span><br><span> #endif /* ifndef REFLECT_FILTER_H */</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/M=
akefile.am</span><br><span>index a4e6235..cd1c378 100644</span><br><span>--=
- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_t=
ests/openvpn/Makefile.am</span><br><span>@@ -11,7 +11,7 @@</span><br><span>=
 endif</span><br><span> </span><br><span> test_binaries +=3D crypto_testdri=
ver packet_id_testdriver auth_token_testdriver ncp_testdriver misc_testdriv=
er \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	pkt_testdriver s=
sl_testdriver user_pass_testdriver</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	pkt_testdriver ssl_testdriver user_pass_testdriver reflect_=
testdriver</span><br><span> </span><br><span> if HAVE_LD_WRAP_SUPPORT</span=
><br><span> if !WIN32</span><br><span>@@ -144,6 +144,22 @@</span><br><span>=
 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span> 	$(top_srcdir)/=
src/openvpn/tls_crypt.c</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+reflect_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include -=
I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+reflect_testdriver_LDFLAGS =3D @TEST_LDFL=
AGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reflect_testdri=
ver_SOURCES =3D test_reflect.c mock_msg.c mock_msg.h \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/reflect_filte=
r.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)=
/src/openvpn/bloom.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_mb=
edtls.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_src=
dir)/src/openvpn/crypto_openssl.c \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	$(top_srcdir)/src/openvpn/otime.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/packet_id.c \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/o=
penvpn/platform.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	$(top_srcdir)/src/openvpn/siphash_reference.c \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util.c</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if !WIN3=
2</span><br><span> tls_crypt_testdriver_CFLAGS  =3D \</span><br><span> 	-I$=
(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn=
 \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_reflect.c b/t=
ests/unit_tests/openvpn/test_reflect.c</span><br><span>new file mode 100644=
</span><br><span>index 0000000..5158631</span><br><span>--- /dev/null</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_reflect.c</span><br><span>@@=
 -0,0 +1,327 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An app=
lication to securely tunnel IP networks</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             over a single UDP port, with support for=
 SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          session authentication and key exchange,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet aut=
hentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            packet compression.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  C=
opyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  This program is free software; you can red=
istribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  it under the terms of the GNU General Public License version 2</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by t=
he Free Software Foundation.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is distributed in the hope that it will be useful,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General P=
ublic License for more details.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Y=
ou should have received a copy of the GNU General Public License</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  along with this program (s=
ee the file COPYING included with this</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  distribution); if not, write to the Free Software Fo=
undation, Inc.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
59 Temple Place, Suite 330, Boston, MA  02111-1307  USA</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;config.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;config-msvc.h&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;syshead.h&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;bloom.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;buffer.h&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;reflect_filter.h&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;stdarg.h&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;stdio.h&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_bloom(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    static const int present_mod =3D 77;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Use a bloom filter with =
1M entries (256kB) for the unit test */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct bloom_filter *bf =3D bloom_create(1024ul*102=
4, 8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int32_t i =3D =
0; i &lt; 20000; i +=3D present_mod)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        bloom_add(bf, (const uint8_t *) &amp;i, sizeof(i));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* all these should be positive, for the small unit test we d=
o not expect</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
false positive */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  for (int32_t i =3D 0; i &lt; 20000; i++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        int present =3D (i % present_mod =3D=3D 0 ) ? 1 : 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* cast to bool t=
o only get 1 and 0 for present/not present and not */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal((bool) bloom_tes=
t(bf, (const uint8_t *) &amp;i, sizeof(i)), present);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bloom_free(bf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_reflect_ddos(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* This tests if the bloom filter implement=
ation does actually work with</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * the goal of dropping packets to a reflected /24 while stil=
l allowing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ot=
her clients */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Disable the norma=
l fallback that puts a hard cap on the reflection filter */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct initial_packet_rate_limi=
t *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;=
irl-&gt;gc, false, 24, 5);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc=
, false, 8, 20);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 init_bloom_filter(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int num_le=
gimate_reject =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int num_legimate_accepted =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int num_ddos_rejected =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int num_ddos_accepted =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /24 ne=
t addresses in host byte order */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    in_addr_t net_attack[4];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 3; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        net_attack[i] =3D random() % 0xff;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* The 4th network is close enough to the 3rd to fall i=
n the same /16 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* XOR the 3rd byte to achieve this */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    net_attack[3] =3D net_attack[2] ^ 00002300;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Assume 200000 packets, including rough=
ly 200 legitimate packets,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * the unit test works also with 20 millions packet but takes to=
o long*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static =
const int total_packets =3D 200 * 1000;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (int i =3D 0; i &lt; total_packets; i++)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct openvpn_sockaddr from =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        from.addr.in4.sin_famil=
y =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   from.addr.in4.sin_addr.s_addr =3D random();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        from.addr.in4.sin_port =3D random();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (i % 1023 =3D=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            /* roughly 200 legitimate cl=
ients with random addresses */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            from.addr.in4.sin_addr.s_addr =3D random();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            bool allowed =3D reflect_filter_che=
ck(irl, &amp;from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (allowed)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               num_legimate_accepted++;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                num_legimate_reject++;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* We attack the=
 4 networks at random */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            from.addr.in4.sin_addr.s_addr  =3D net_attack[random() % 4=
] + (random() % 256);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bool =
allowed  =3D reflect_filter_check(irl, &amp;from);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (allowed)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                num_ddos_accepted++;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                num_ddos_rejected++;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(num_legimate_reject + num_legimate_accepted + num_dd=
os_accepted + num_ddos_rejected, total_packets);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* We assume that most legitimate made it through but a few w=
ere unfortunate to be in an attacked network */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_in_range(num_legimate_reject, 0, 10)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* We disabled total number of pa=
ckets, so we expect all /8 to have their</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * 20 packets, which is 5120. */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_in_range(num_ddos_accepted=
, 0, 256 * 20);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    initial_rate_limit_=
free(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_bloom_minimal(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct bloom_filter *bf =3D bloom_create(2048, 3, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int item =3D 0xbabe;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bloom_add(bf, (const uint8_t *) &amp;item, siz=
eof(item));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(bloom_test(bf, (const uint8_t *) &amp;item, sizeof(item)), 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    item =3D 0xf00f;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(bloom_test(bf, (=
const uint8_t *) &amp;item, sizeof(item)), 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bloom_free(bf);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_reflect_reflect_bloom_simple(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct initial_packet=
_rate_limit *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_c=
onf, &amp;irl-&gt;gc, true, 32, 50);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;=
irl-&gt;gc, true, 56, 200);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    init_bloom_filter(irl);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct openvpn_sockaddr from =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    from.addr.in6.sin6_family =3D AF_INET6;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    from.addr.in6.sin6_port =
=3D random();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fr=
om.addr.in6.sin6_addr.s6_addr[15] =3D 1;  /* ::1 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* There are 50 attempts that should work until one fail=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; 50; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ass=
ert_true(reflect_filter_check(irl, &amp;from));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* 2002::1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct openvpn_sockaddr from2 =3D from;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    from2.addr.in6.sin6_addr.s6_addr[0] =3D 0x7;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    from2.addr.in6.sin6_addr.=
s6_addr[1] =3D 0x7;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ref=
lect_filter_check(irl, &amp;from2));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Any more attempts from ::1 should fail */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(reflect_filter_check(irl, &amp;=
from));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    initial_rate_limit_free(irl=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_reflect_bloom_netmask_masking(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct initial_packet_rate_limit *irl =3D initi=
al_rate_limit_init(INT_MAX, 300, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, true=
, 45, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_=
bloom_filter(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_s=
ockaddr from =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    from.addr.in6.sin6_family =3D AF_INET6;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    from.addr.in6.sin6_port =3D random();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &=
lt; 15; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        from.addr.in6=
.sin6_addr.s6_addr[i] =3D random();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; 10; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
/45 means that if we leave the leave first 8 bytes and 5 bits</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * untouched, it is still=
 the same subnet  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        for (int j =3D 8; j&lt;15; j++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            from.addr.in6.sin6_addr.s6_addr[j] =3D random();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            from.addr.i=
n6.sin6_addr.s6_addr[7] ^=3D random() &amp; 0x7;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        assert_true(reflect_filter_check(irl, &amp;from)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* testing the last IP again should give us a negative result */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ref=
lect_filter_check(irl, &amp;from));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 initial_rate_limit_free(irl);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_reflect_reflect_bloom_mapped(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct initial_packet_rate_limit *irl=
 =3D initial_rate_limit_init(INT_MAX, 300, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&g=
t;gc, false, 24, 50);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, fal=
se, 8, 80);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init=
_bloom_filter(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Our OpenVPN =
server will not receive IPv4 as well as IPv4 mapped</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * addresses in the same process but =
for the unit test it is convient</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * to see if they actually mapped to the same entries */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr mapped_v4 =
=3D  { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mapp=
ed_v4.addr.in6.sin6_family =3D AF_INET6;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    mapped_v4.addr.in6.sin6_port =3D random();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ::ffff:192.168.0.99 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mapped_v4.add=
r.in6.sin6_addr.s6_addr[10] =3D 0xff;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    mapped_v4.addr.in6.sin6_addr.s6_addr[11] =3D 0xff;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    mapped_v4.addr.in6=
.sin6_addr.s6_addr[12] =3D 192;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mapped_v4.addr.in6.sin6_addr.s6_addr[13] =3D 168;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    mapped_v4.addr.in6.sin6_a=
ddr.s6_addr[14] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    mapped_v4.addr.in6.sin6_addr.s6_addr[15] =3D 99;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(IN6_IS_ADDR_V4MAPPED(&amp;mapped_v4.addr.i=
n6.sin6_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Not the same add=
ress but in the same /8 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct openvpn_sockaddr v4addr =3D {0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    v4addr.addr.in4.sin_family =3D AF_INE=
T;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    v4addr.addr.i=
n4.sin_port =3D random();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* 192.168.123.244 */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    v4addr.addr.in4.sin_addr.s_addr =3D htonl(0xc0a87bf4);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* check that we run into the 50 limi=
t with our mapped address */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    for (int i =3D 0; i &lt; 50; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        assert_true(reflect_filter_check(irl, &amp;mapped_v4))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reflect_filter_=
check(irl, &amp;mapped_v4));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check that the non-map=
ped IPv4 address uses the same /8 subnet limit */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 30; i++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_true(reflect_filter_check(=
irl, &amp;v4addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fal=
se(reflect_filter_check(irl, &amp;v4addr));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    initial_rate_limit_free(irl);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_bloom_access_functions(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static_assert(BLOOM_FILTER_BITS_COUNT=
 =3D=3D 2, &quot;unit test not in sync&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    static_assert(BLOOM_FILTER_BITS_MASK =3D=3D =
0x3, &quot;unit test not in sync&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 openvpn_unit_test_setup();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const struct CMUnitTest tests[] =3D {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_bloom_access_fu=
nctions),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_bloom),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_bloom_minimal),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reflect_ref=
lect_bloom_simple),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test(test_reflect_reflect_bloom_mapped),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_refl=
ect_bloom_netmask_masking),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_reflect_ddos),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D c=
mocka_run_group_tests_name(&quot;crypto tests&quot;, tests, NULL, NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/30?usp=3Demail">ch=
ange 30</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/30?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb=
9a072e0bfa6b9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 30 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--rw+jdijlZu8=--

