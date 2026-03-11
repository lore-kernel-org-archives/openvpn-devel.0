From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 18:51:13 +0000
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <71c9f79b3f7ed83f6bb3d8898aaf6af179e44f61-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G29gGWkJOJ0="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--G29gGWkJOJ0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1573?usp=3Demail )


Change subject: Replace custom hash_func with siphash
......................................................................

Replace custom hash_func with siphash

Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/list.c
M src/openvpn/list.h
M src/openvpn/mroute.c
M src/openvpn/multi.c
A src/openvpn/siphash.c
M src/openvpn/siphash.h
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_misc.c
10 files changed, 140 insertions(+), 208 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/1573/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8eb05f6..cd7bafa 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -557,6 +557,7 @@
     src/openvpn/sig.c
     src/openvpn/sig.h
     src/openvpn/siphash.h
+    src/openvpn/siphash.c
     src/openvpn/siphash_openssl.c
     src/openvpn/siphash_reference.c
     src/openvpn/socket.c
@@ -821,7 +822,11 @@
         src/openvpn/options_util.c
         src/openvpn/ssl_util.c
         src/openvpn/list.c
-        )
+        src/openvpn/siphash.h
+        src/openvpn/siphash.c
+        src/openvpn/siphash_reference.c
+        src/openvpn/siphash_openssl.c
+    )

     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 08c8250..4cb93e9 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -128,7 +128,8 @@
 	session_id.c session_id.h \
 	shaper.c shaper.h \
 	sig.c sig.h \
-	siphash_reference.c siphash.h \
+	siphash.c siphash.h \
+	siphash_reference.c \
 	siphash_openssl.c \
 	socket.c socket.h \
 	socket_util.c socket_util.h \
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 36d8ede..1a7dd25 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -31,9 +31,6 @@
 #include "list.h"

 #include "crypto.h"
-#include "misc.h"
-
-#include "memdbg.h"

 struct hash *
 hash_init(const uint32_t n_buckets, void *ctx,
@@ -315,187 +312,4 @@
     ASSERT(hi->last);
     hi->last->key =3D NULL;
     hi->bucket_marked =3D true;
-}
-
-
-/*
- * --------------------------------------------------------------------
- * hash() -- hash a variable-length key into a 32-bit value
- * k     : the key (the unaligned variable-length array of bytes)
- * len   : the length of the key, counting by bytes
- * level : can be any 4-byte value
- * Returns a 32-bit value.  Every bit of the key affects every bit of
- * the return value.  Every 1-bit and 2-bit delta achieves avalanche.
- * About 36+6len instructions.
- *
- * #define hashsize(n) ((uint32_t)1<<(n))
- * #define hashmask(n) (hashsize(n)-1)
- *
- * The best hash table sizes are powers of 2.  There is no need to do
- * mod a prime (mod is sooo slow!).  If you need less than 32 bits,
- * use a bitmask.  For example, if you need only 10 bits, do
- * h =3D (h & hashmask(10));
- * In which case, the hash table should have hashsize(10) elements.
- *
- * If you are hashing n strings (uint8_t **)k, do it like this:
- * for (i=3D0, h=3D0; i<n; ++i) h =3D hash( k[i], len[i], h);
- *
- * By Bob Jenkins, 1996.  bob_jenkins@...2942...  You may use this
- * code any way you wish, private, educational, or commercial.  It's free.
- *
- * See https://burtleburtle.net/bob/hash/evahash.html
- * Use for hash table lookup, or anything where one collision in 2^32 is
- * acceptable.  Do NOT use for cryptographic purposes.
- *
- * --------------------------------------------------------------------
- *
- * mix -- mix 3 32-bit values reversibly.
- * For every delta with one or two bit set, and the deltas of all three
- * high bits or all three low bits, whether the original value of a,b,c
- * is almost all zero or is uniformly distributed,
- * If mix() is run forward or backward, at least 32 bits in a,b,c
- * have at least 1/4 probability of changing.
- * If mix() is run forward, every bit of c will change between 1/3 and
- * 2/3 of the time.  (Well, 22/100 and 78/100 for some 2-bit deltas.)
- * mix() was built out of 36 single-cycle latency instructions in a
- * structure that could supported 2x parallelism, like so:
- *    a -=3D b;
- *    a -=3D c; x =3D (c>>13);
- *    b -=3D c; a ^=3D x;
- *    b -=3D a; x =3D (a<<8);
- *    c -=3D a; b ^=3D x;
- *    c -=3D b; x =3D (b>>13);
- *    ...
- * Unfortunately, superscalar Pentiums and Sparcs can't take advantage
- * of that parallelism.  They've also turned some of those single-cycle
- * latency instructions into multi-cycle latency instructions.  Still,
- * this is the fastest good hash I could find.  There were about 2^^68
- * to choose from.  I only looked at a billion or so.
- *
- * James Yonan Notes:
- *
- * This function is faster than it looks, and appears to be
- * appropriate for our usage in OpenVPN which is primarily
- * for hash-table based address lookup (IPv4, IPv6, and Ethernet MAC).
- * NOTE: This function is never used for cryptographic purposes, only
- * to produce evenly-distributed indexes into hash tables.
- *
- * Benchmark results: 11.39 machine cycles per byte on a P2 266Mhz,
- *                   and 12.1 machine cycles per byte on a
- *                   2.2 Ghz P4 when hashing a 6 byte string.
- * --------------------------------------------------------------------
- */
-
-#define mix(a, b, c)    \
-    {                   \
-        a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (c >> 13); \
-        b -=3D c;         \
-        b -=3D a;         \
-        b ^=3D (a << 8);  \
-        c -=3D a;         \
-        c -=3D b;         \
-        c ^=3D (b >> 13); \
-        a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (c >> 12); \
-        b -=3D c;         \
-        b -=3D a;         \
-        b ^=3D (a << 16); \
-        c -=3D a;         \
-        c -=3D b;         \
-        c ^=3D (b >> 5);  \
-        a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (c >> 3);  \
-        b -=3D c;         \
-        b -=3D a;         \
-        b ^=3D (a << 10); \
-        c -=3D a;         \
-        c -=3D b;         \
-        c ^=3D (b >> 15); \
-    }
-
-void *
-hash_func_new_ctx(void)
-{
-    uint32_t *ctx =3D malloc(sizeof(uint32_t));
-    *ctx =3D (uint32_t)get_random();
-    return ctx;
-}
-
-uint64_t
-hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
-{
-    uint32_t a, b, c, len;
-
-    /* Set up the internal state */
-    len =3D length;
-    a =3D b =3D 0x9e3779b9; /* the golden ratio; an arbitrary value */
-    c =3D initval;        /* the previous hash value */
-
-    /*---------------------------------------- handle most of the key */
-    while (len >=3D 12)
-    {
-        a +=3D (k[0] + ((uint32_t)k[1] << 8) + ((uint32_t)k[2] << 16) + ((=
uint32_t)k[3] << 24));
-        b +=3D (k[4] + ((uint32_t)k[5] << 8) + ((uint32_t)k[6] << 16) + ((=
uint32_t)k[7] << 24));
-        c +=3D (k[8] + ((uint32_t)k[9] << 8) + ((uint32_t)k[10] << 16) + (=
(uint32_t)k[11] << 24));
-        mix(a, b, c);
-        k +=3D 12;
-        len -=3D 12;
-    }
-
-    /*------------------------------------- handle the last 11 bytes */
-    c +=3D length;
-    switch (len) /* all the case statements fall through */
-    {
-        case 11:
-            c +=3D ((uint32_t)k[10] << 24);
-            /* Intentional [[fallthrough]]; */
-
-        case 10:
-            c +=3D ((uint32_t)k[9] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        case 9:
-            c +=3D ((uint32_t)k[8] << 8);
-        /* Intentional [[fallthrough]]; */
-
-        /* the first byte of c is reserved for the length */
-        case 8:
-            b +=3D ((uint32_t)k[7] << 24);
-            /* Intentional [[fallthrough]]; */
-
-        case 7:
-            b +=3D ((uint32_t)k[6] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        case 6:
-            b +=3D ((uint32_t)k[5] << 8);
-            /* Intentional [[fallthrough]]; */
-
-        case 5:
-            b +=3D k[4];
-            /* Intentional [[fallthrough]]; */
-
-        case 4:
-            a +=3D ((uint32_t)k[3] << 24);
-            /* Intentional [[fallthrough]]; */
-
-        case 3:
-            a +=3D ((uint32_t)k[2] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        case 2:
-            a +=3D ((uint32_t)k[1] << 8);
-            /* Intentional [[fallthrough]]; */
-
-        case 1:
-            a +=3D k[0];
-            /* case 0: nothing left to add */
-    }
-    mix(a, b, c);
-    /*-------------------------------------- report the result */
-    return c;
-}
+}
\ No newline at end of file
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index ea6f47a..160bb5d 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -101,10 +101,6 @@

 void hash_iterator_free(struct hash_iterator *hi);

-uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
-
-void *hash_func_new_ctx(void);
-
 static inline uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 89b3ecc..e32894b 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -33,6 +33,7 @@
 #include "socket_util.h"

 #include "memdbg.h"
+#include "siphash.h"

 void
 mroute_addr_init(struct mroute_addr *addr)
@@ -357,9 +358,8 @@
 uint64_t
 mroute_addr_hash_function(const void *key, void *ctx)
 {
-    uint32_t *iv =3D ctx;
-    return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
-                     mroute_addr_hash_len((const struct mroute_addr *)key)=
, *iv);
+    return siphash_hash_func(mroute_addr_hash_ptr((const struct mroute_add=
r *)key),
+                             mroute_addr_hash_len((const struct mroute_add=
r *)key), ctx);
 }

 bool
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 200e1e7..920ae7d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -23,6 +23,7 @@
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif
+#include "siphash.h"

 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify.h>
@@ -290,14 +291,14 @@
      * to determine which client sent an incoming packet
      * which is seen on the TCP/UDP socket.
      */
-    m->hash =3D hash_init(t->options.real_hash_size, hash_func_new_ctx(), =
free,
+    m->hash =3D hash_init(t->options.real_hash_size, siphash_new_context()=
, siphash_free_context,
                         mroute_addr_hash_function, mroute_addr_compare_fun=
ction);

     /*
      * Virtual address hash table.  Used to determine
      * which client to route a packet to.
      */
-    m->vhash =3D hash_init(t->options.virtual_hash_size, hash_func_new_ctx=
(), free,
+    m->vhash =3D hash_init(t->options.virtual_hash_size, siphash_new_conte=
xt(), siphash_free_context,
                          mroute_addr_hash_function, mroute_addr_compare_fu=
nction);

 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/siphash.c b/src/openvpn/siphash.c
new file mode 100644
index 0000000..dac7750
--- /dev/null
+++ b/src/openvpn/siphash.c
@@ -0,0 +1,77 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2025 Arne Schwabe <arne@...1227...>
+ *
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
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include <stdlib.h>
+#include "syshead.h"
+#include "siphash.h"
+#include "buffer.h"
+#include "crypto.h"
+
+void *
+siphash_new_context(void)
+{
+    struct siphash_ctx *ctx;
+    ALLOC_OBJ_CLEAR(ctx, struct siphash_ctx);
+
+    prng_bytes(ctx->key, SIPHASH_KEY_SIZE);
+
+    if (siphash_cryptolib_available(ctx) && false)
+    {
+        ctx->cryptlib_ctx =3D siphash_cryptolib_init(8);
+    }
+    return ctx;
+}
+
+void
+siphash_free_context(void *ctx)
+{
+    struct siphash_ctx *sctx =3D ctx;
+
+    if (sctx->cryptlib_ctx)
+    {
+        siphash_cryptolib_uninit(sctx->cryptlib_ctx);
+    }
+    free(ctx);
+}
+
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, void *ctx)
+{
+    struct siphash_ctx *sctx =3D ctx;
+
+    union
+    {
+        uint8_t out[8];
+        uint64_t hash;
+    } ret;
+    siphash(sctx, k, length, ret.out, sizeof(ret.out));
+    return ret.hash;
+}
\ No newline at end of file
diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h
index 973596b..739c43c 100644
--- a/src/openvpn/siphash.h
+++ b/src/openvpn/siphash.h
@@ -25,8 +25,15 @@
 /* siphash always uses 128-bit keys */
 #define SIPHASH_KEY_SIZE 16

+struct siphash_ctx
+{
+    uint8_t key[SIPHASH_KEY_SIZE];
+    void *cryptlib_ctx;
+};
+
 /* Prototypes for an implementation of SIPHASH in a crypto library */

+
 /**
  * Calculates SIPHASH using the crypto library function.
  */
@@ -56,17 +63,44 @@
 siphash_cryptolib_available(void *sip_context);

 static inline int
-siphash(void *ctx, const void *in, size_t inlen, const void *k,
-        uint8_t *out, size_t outlen)
+siphash(void *ctx, const void *in, size_t inlen, uint8_t *out, size_t outl=
en)
 {
-    if (siphash_cryptolib_available(ctx) && false)
+    struct siphash_ctx *sctx =3D ctx;
+    if (siphash_cryptolib_available(sctx->cryptlib_ctx) && false)
     {
-        return siphash_cryptolib(ctx, in, inlen, k, out, outlen);
+        return siphash_cryptolib(ctx, in, inlen, sctx->key, out, outlen);
     }
     else
     {
-        return siphash_reference(in, inlen, k, out, outlen);
+        return siphash_reference(in, inlen, sctx->key, out, outlen);
     }
 }

+/**
+ * Allocates the resources for a siphash context and returns a pointer to
+ * this context. The context must be freed with siphash_free_context
+ */
+void *
+siphash_new_context(void);
+
+/**
+ *  Releases the resources assigned to a siphash context
+ * @param ctx the context previously allocated by siphash_new_context
+ */
+void
+siphash_free_context(void *ctx);
+
+/**
+ * Wrapper of the siphash function to easily use it in the
+ * hash map.
+ *
+ * @param k the data to hash
+ * @param length length of the data to hash
+ * @param ctx   the siphash context
+ * @return a unit64_t containing the result of the hashing
+ */
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, void *ctx);
+
+
 #endif /* ifndef SIPHASH_H */
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 4ed113a..5f7f692 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -85,6 +85,7 @@
 	$(top_srcdir)/src/openvpn/mtu.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/mss.c \
+	$(top_srcdir)/src/openvpn/siphash.c \
 	$(top_srcdir)/src/openvpn/siphash_openssl.c \
 	$(top_srcdir)/src/openvpn/siphash_reference.c

@@ -378,7 +379,10 @@
 	$(top_srcdir)/src/openvpn/ssl_util.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c \
-	$(top_srcdir)/src/openvpn/list.c
+	$(top_srcdir)/src/openvpn/list.c \
+	$(top_srcdir)/src/openvpn/siphash.c \
+	$(top_srcdir)/src/openvpn/siphash_openssl.c \
+	$(top_srcdir)/src/openvpn/siphash_reference.c

 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 24bf22d..576630d 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <setjmp.h>
 #include <cmocka.h>
+#include <siphash.h>

 #include "ssl_util.h"
 #include "options_util.h"
@@ -127,10 +128,9 @@
 static uint64_t
 word_hash_function(const void *key, void *ctx)
 {
-    uint32_t *iv =3D (uint32_t *)ctx;
     const char *str =3D (const char *)key;
     const uint32_t len =3D (uint32_t)strlen(str);
-    return hash_func((const uint8_t *)str, len, *iv);
+    return siphash_hash_func((const uint8_t *)str, len, ctx);
 }

 static bool
@@ -173,8 +173,8 @@
      * word frequency algorithm.
      */
     struct gc_arena gc =3D gc_new();
-    struct hash *hash =3D hash_init(10000, hash_func_new_ctx(), free, word=
_hash_function, word_compare_function);
-    struct hash *nhash =3D hash_init(256, hash_func_new_ctx(), free, word_=
hash_function, word_compare_function);
+    struct hash *hash =3D hash_init(10000, siphash_new_context(), siphash_=
free_context, word_hash_function, word_compare_function);
+    struct hash *nhash =3D hash_init(256, siphash_new_context(), siphash_f=
ree_context, word_hash_function, word_compare_function);

     printf("hash_init n_buckets=3D%u mask=3D0x%08x\n", hash->n_buckets, ha=
sh->mask);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1573?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--G29gGWkJOJ0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1573?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Replace custom hash_func with siphash<br><br>Change-Id: I807f398903ac20=
47530800c29949793c6f4f0ec9<br>Signed-off-by: Arne Schwabe &lt;arne@...2639...=
..&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/Makefile.am<br>M src/ope=
nvpn/list.c<br>M src/openvpn/list.h<br>M src/openvpn/mroute.c<br>M src/open=
vpn/multi.c<br>A src/openvpn/siphash.c<br>M src/openvpn/siphash.h<br>M test=
s/unit_tests/openvpn/Makefile.am<br>M tests/unit_tests/openvpn/test_misc.c<=
br>10 files changed, 140 insertions(+), 208 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/15=
73/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>i=
ndex 8eb05f6..cd7bafa 100644</span><br><span>--- a/CMakeLists.txt</span><br=
><span>+++ b/CMakeLists.txt</span><br><span>@@ -557,6 +557,7 @@</span><br><=
span>     src/openvpn/sig.c</span><br><span>     src/openvpn/sig.h</span><b=
r><span>     src/openvpn/siphash.h</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    src/openvpn/siphash.c</span><br><span>     src/openvpn/s=
iphash_openssl.c</span><br><span>     src/openvpn/siphash_reference.c</span=
><br><span>     src/openvpn/socket.c</span><br><span>@@ -821,7 +822,11 @@</=
span><br><span>         src/openvpn/options_util.c</span><br><span>        =
 src/openvpn/ssl_util.c</span><br><span>         src/openvpn/list.c</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash.h</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash.c=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn=
/siphash_reference.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        src/openvpn/siphash_openssl.c</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    )</span><br><span> </span><br><span>     target_sour=
ces(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_epoch.c</s=
pan><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.a=
m</span><br><span>index 08c8250..4cb93e9 100644</span><br><span>--- a/src/o=
penvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br>=
<span>@@ -128,7 +128,8 @@</span><br><span> 	session_id.c session_id.h \</sp=
an><br><span> 	shaper.c shaper.h \</span><br><span> 	sig.c sig.h \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	siphash_reference.c siphash.h=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash.c siphas=
h.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash_refer=
ence.c \</span><br><span> 	siphash_openssl.c \</span><br><span> 	socket.c s=
ocket.h \</span><br><span> 	socket_util.c socket_util.h \</span><br><span>d=
iff --git a/src/openvpn/list.c b/src/openvpn/list.c</span><br><span>index 3=
6d8ede..1a7dd25 100644</span><br><span>--- a/src/openvpn/list.c</span><br><=
span>+++ b/src/openvpn/list.c</span><br><span>@@ -31,9 +31,6 @@</span><br><=
span> #include &quot;list.h&quot;</span><br><span> </span><br><span> #inclu=
de &quot;crypto.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#include &quot;misc.h&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quo=
t;memdbg.h&quot;</span><br><span> </span><br><span> struct hash *</span><br=
><span> hash_init(const uint32_t n_buckets, void *ctx,</span><br><span>@@ -=
315,187 +312,4 @@</span><br><span>     ASSERT(hi-&gt;last);</span><br><span=
>     hi-&gt;last-&gt;key =3D NULL;</span><br><span>     hi-&gt;bucket_mark=
ed =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ------------=
--------------------------------------------------------</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * hash() -- hash a variable-length key =
into a 32-bit value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 k     : the key (the unaligned variable-length array of bytes)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * len   : the length of the key,=
 counting by bytes</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
level : can be any 4-byte value</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Returns a 32-bit value.  Every bit of the key affects every bi=
t of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the return val=
ue.  Every 1-bit and 2-bit delta achieves avalanche.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * About 36+6len instructions.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * #define hashsize(n) ((uint32_t)1&lt;&lt;(n))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * #define hashmask(n) (has=
hsize(n)-1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * The best hash table sizes =
are powers of 2.  There is no need to do</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * mod a prime (mod is sooo slow!).  If you need less th=
an 32 bits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * use a b=
itmask.  For example, if you need only 10 bits, do</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * h =3D (h &amp; hashmask(10));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * In which case, the hash table sh=
ould have hashsize(10) elements.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If yo=
u are hashing n strings (uint8_t **)k, do it like this:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * for (i=3D0, h=3D0; i&lt;n; ++i) h =3D =
hash( k[i], len[i], h);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * By Bob Jenkins=
, 1996.  bob_jenkins@...2942...  You may use this</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * code any way you wish, private, educational,=
 or commercial.  It&#39;s free.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * See ht=
tps://burtleburtle.net/bob/hash/evahash.html</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * Use for hash table lookup, or anything where one =
collision in 2^32 is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* acceptable.  Do NOT use for cryptographic purposes.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * -----------------------------------------------------------=
---------</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * mix -- mix 3 32-bit values r=
eversibly.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * For ever=
y delta with one or two bit set, and the deltas of all three</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * high bits or all three low bits, =
whether the original value of a,b,c</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * is almost all zero or is uniformly distributed,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * If mix() is run forward or ba=
ckward, at least 32 bits in a,b,c</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * have at least 1/4 probability of changing.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * If mix() is run forward, every bit o=
f c will change between 1/3 and</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * 2/3 of the time.  (Well, 22/100 and 78/100 for some 2-bit delt=
as.)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mix() was buil=
t out of 36 single-cycle latency instructions in a</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * structure that could supported 2x paralleli=
sm, like so:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    a -=
=3D b;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    a -=3D c;=
 x =3D (c&gt;&gt;13);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *    b -=3D c; a ^=3D x;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *    b -=3D a; x =3D (a&lt;&lt;8);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *    c -=3D a; b ^=3D x;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *    c -=3D b; x =3D (b&gt;&gt;13);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *    ...</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Unfortunately, superscalar Pentiums and Sparcs =
can&#39;t take advantage</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * of that parallelism.  They&#39;ve also turned some of those single-cy=
cle</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * latency instruc=
tions into multi-cycle latency instructions.  Still,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * this is the fastest good hash I could fi=
nd.  There were about 2^^68</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * to choose from.  I only looked at a billion or so.</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * James Yonan Notes:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * This function is faster than it looks, and appears to be</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * appropriate for our usage in OpenV=
PN which is primarily</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * for hash-table based address lookup (IPv4, IPv6, and Ethernet MAC).</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * NOTE: This function is =
never used for cryptographic purposes, only</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * to produce evenly-distributed indexes into hash ta=
bles.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Benchmark results: 11.39 machine=
 cycles per byte on a P2 266Mhz,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *                   and 12.1 machine cycles per byte on a</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *                   2.2 Gh=
z P4 when hashing a 6 byte string.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * -----------------------------------------------------------=
---------</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define mix(a, b, c)    \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {                   \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 13);=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=
=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   b ^=3D (a &lt;&lt; 8);  \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        c -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        c -=3D b;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 13); \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 12);=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=
=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   b ^=3D (a &lt;&lt; 16); \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        c -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        c -=3D b;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 5);  \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 3); =
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=
=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   b ^=3D (a &lt;&lt; 10); \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        c -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        c -=3D b;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 15); \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_func_new_ctx(vo=
id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    uint32_t *ctx =3D malloc(sizeof(ui=
nt32_t));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *ctx =3D=
 (uint32_t)get_random();</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-uint64_t</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-hash_func(const uint8_t *k, uint32_t length, uint32_t in=
itval)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    uint32_t a, b, c, len;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Set up the internal state */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    len =3D length;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    a =3D b =3D 0x9e3779b9; /* the gold=
en ratio; an arbitrary value */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    c =3D initval;        /* the previous hash value */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /*---------------------------------------- handl=
e most of the key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   while (len &gt;=3D 12)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a +=
=3D (k[0] + ((uint32_t)k[1] &lt;&lt; 8) + ((uint32_t)k[2] &lt;&lt; 16) + ((=
uint32_t)k[3] &lt;&lt; 24));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        b +=3D (k[4] + ((uint32_t)k[5] &lt;&lt; 8) + ((uint32_t)k[6]=
 &lt;&lt; 16) + ((uint32_t)k[7] &lt;&lt; 24));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c +=3D (k[8] + ((uint32_t)k[9] &lt;&lt; 8)=
 + ((uint32_t)k[10] &lt;&lt; 16) + ((uint32_t)k[11] &lt;&lt; 24));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        mix(a, b, c);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        k +=3D 12;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        len -=3D 12;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /*------------------------------------- handle the last 11 bytes */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c +=3D length;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (len) /* all =
the case statements fall through */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      case 11:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     c +=3D ((uint32_t)k[10] &lt;&lt; 24);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        case 10:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[9] &lt;&lt; 16);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [=
[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 9:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)=
k[8] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* the first byte of c is reserved for the length */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        case 8:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            b +=3D ((uint32_t)k[7] &lt;&lt; 24=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Inte=
ntional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 7:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((=
uint32_t)k[6] &lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            /* Intentional [[fallthrough]]; */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        case 6:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            b +=3D ((uint32_t)k[5] &lt;&lt; 8);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]];=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        case 5:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            b +=3D k[4];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough=
]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        case 4:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            a +=3D ((uint32_t)k[3] &lt;&lt=
; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* =
Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cas=
e 3:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            a +=
=3D ((uint32_t)k[2] &lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /* Intentional [[fallthrough]]; */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case 2:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            a +=3D ((uint32_t)k[1] &lt;&lt; 8);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthroug=
h]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        case 1:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            a +=3D k[0];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            /* case 0: nothing left to=
 add */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    mix(a, b, c);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /*----------------------------=
---------- report the result */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return c;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n>\ No newline at end of file</span><br><span>diff --git a/src/openvpn/list=
.h b/src/openvpn/list.h</span><br><span>index ea6f47a..160bb5d 100644</span=
><br><span>--- a/src/openvpn/list.h</span><br><span>+++ b/src/openvpn/list.=
h</span><br><span>@@ -101,10 +101,6 @@</span><br><span> </span><br><span> v=
oid hash_iterator_free(struct hash_iterator *hi);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t hash_func(const uint=
8_t *k, uint32_t length, uint32_t initval);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void *hash_func_new_ctx(void);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> static inline uint64_t</span><br><span> hash_va=
lue(const struct hash *hash, const void *key)</span><br><span> {</span><br>=
<span>diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><s=
pan>index 89b3ecc..e32894b 100644</span><br><span>--- a/src/openvpn/mroute.=
c</span><br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -33,6 +33,7=
 @@</span><br><span> #include &quot;socket_util.h&quot;</span><br><span> </=
span><br><span> #include &quot;memdbg.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;siphash.h&quot;</span><br><span> <=
/span><br><span> void</span><br><span> mroute_addr_init(struct mroute_addr =
*addr)</span><br><span>@@ -357,9 +358,8 @@</span><br><span> uint64_t</span>=
<br><span> mroute_addr_hash_function(const void *key, void *ctx)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t =
*iv =3D ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                     mroute_ad=
dr_hash_len((const struct mroute_addr *)key), *iv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func(mroute_addr_=
hash_ptr((const struct mroute_addr *)key),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                             mroute_addr_hash_len((c=
onst struct mroute_addr *)key), ctx);</span><br><span> }</span><br><span> <=
/span><br><span> bool</span><br><span>diff --git a/src/openvpn/multi.c b/sr=
c/openvpn/multi.c</span><br><span>index 200e1e7..920ae7d 100644</span><br><=
span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</s=
pan><br><span>@@ -23,6 +23,7 @@</span><br><span> #ifdef HAVE_CONFIG_H</span=
><br><span> #include &quot;config.h&quot;</span><br><span> #endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash.h&quot=
;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><s=
pan> #include &lt;sys/inotify.h&gt;</span><br><span>@@ -290,14 +291,14 @@</=
span><br><span>      * to determine which client sent an incoming packet</s=
pan><br><span>      * which is seen on the TCP/UDP socket.</span><br><span>=
      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;has=
h =3D hash_init(t-&gt;options.real_hash_size, hash_func_new_ctx(), free,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;hash =3D has=
h_init(t-&gt;options.real_hash_size, siphash_new_context(), siphash_free_co=
ntext,</span><br><span>                         mroute_addr_hash_function, =
mroute_addr_compare_function);</span><br><span> </span><br><span>     /*</s=
pan><br><span>      * Virtual address hash table.  Used to determine</span>=
<br><span>      * which client to route a packet to.</span><br><span>      =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D=
 hash_init(t-&gt;options.virtual_hash_size, hash_func_new_ctx(), free,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;vhash =3D hash=
_init(t-&gt;options.virtual_hash_size, siphash_new_context(), siphash_free_=
context,</span><br><span>                          mroute_addr_hash_functio=
n, mroute_addr_compare_function);</span><br><span> </span><br><span> #ifdef=
 ENABLE_MANAGEMENT</span><br><span>diff --git a/src/openvpn/siphash.c b/src=
/openvpn/siphash.c</span><br><span>new file mode 100644</span><br><span>ind=
ex 0000000..dac7750</span><br><span>--- /dev/null</span><br><span>+++ b/src=
/openvpn/siphash.c</span><br><span>@@ -0,0 +1,77 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt=
;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@...1227...&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is free software; you can redistribute it and/or mo=
dify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under th=
e terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribu=
ted in the hope that it will be useful,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mo=
re details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the =
Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#elif defined(_MSC_VER)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;config-msvc.h&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash.h&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer.h&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;c=
rypto.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+siphash_new_context(void)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct siphash_ctx *ctx;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(ctx, struct siphash_c=
tx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    prng_bytes(ctx-&gt;key, SIPHAS=
H_KEY_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (siphash_cryptolib_=
available(ctx) &amp;&amp; false)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       ctx-&gt;cryptlib_ctx =3D siphash_cryptolib_init(8);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return ctx;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+siphash_free_context(void *ctx)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct siphash_ctx *sctx =3D ctx;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (sctx-&gt;cryptlib_ctx)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        siphash_cryptolib_uninit(sctx-&gt=
;cryptlib_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+siphash_hash_func(const uint8_t *k, uint32_t length, void *ctx)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct siphash_ctx *sctx =3D ctx;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    union</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        uint8_t out[8];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        uint64_t hash;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    } ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    siphash(sctx, k, length, ret.out, sizeof(ret.out));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return ret.hash;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at e=
nd of file</span><br><span>diff --git a/src/openvpn/siphash.h b/src/openvpn=
/siphash.h</span><br><span>index 973596b..739c43c 100644</span><br><span>--=
- a/src/openvpn/siphash.h</span><br><span>+++ b/src/openvpn/siphash.h</span=
><br><span>@@ -25,8 +25,15 @@</span><br><span> /* siphash always uses 128-b=
it keys */</span><br><span> #define SIPHASH_KEY_SIZE 16</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct siphash_ctx</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *cryptlib_ctx;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Prototypes for an=
 implementation of SIPHASH in a crypto library */</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span=
><br><span>  * Calculates SIPHASH using the crypto library function.</span>=
<br><span>  */</span><br><span>@@ -56,17 +63,44 @@</span><br><span> siphash=
_cryptolib_available(void *sip_context);</span><br><span> </span><br><span>=
 static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sip=
hash(void *ctx, const void *in, size_t inlen, const void *k,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        uint8_t *out, size_t outlen)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash(void *ctx, =
const void *in, size_t inlen, uint8_t *out, size_t outlen)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (siphash_cry=
ptolib_available(ctx) &amp;&amp; false)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct siphash_ctx *sctx =3D ctx;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (siphash_cryptolib_available(s=
ctx-&gt;cryptlib_ctx) &amp;&amp; false)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return siphash_cryptolib(c=
tx, in, inlen, k, out, outlen);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return siphash_cryptolib(ctx, in, inlen, sctx-&gt;key, =
out, outlen);</span><br><span>     }</span><br><span>     else</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn siphash_reference(in, inlen, k, out, outlen);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return siphash_reference(in, inlen, s=
ctx-&gt;key, out, outlen);</span><br><span>     }</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocates the resourc=
es for a siphash context and returns a pointer to</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * this context. The context must be freed wi=
th siphash_free_context</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_new_context(void)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  Releases the resources assigned to a siphash cont=
ext</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx th=
e context previously allocated by siphash_new_context</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+siphash_free_context(void *ctx);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wrapper of the s=
iphash function to easily use it in the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * hash map.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param k the data to hash</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param length length of the data to hash</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param ctx   the siphash context</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return a unit64_t containi=
ng the result of the hashing</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_hash_func(=
const uint8_t *k, uint32_t length, void *ctx);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #endif /* ifndef SIPHASH_H */</span><br><span>\ N=
o newline at end of file</span><br><span>diff --git a/tests/unit_tests/open=
vpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>inde=
x 4ed113a..5f7f692 100644</span><br><span>--- a/tests/unit_tests/openvpn/Ma=
kefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span>=
<br><span>@@ -85,6 +85,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/mtu=
.c \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><=
span> 	$(top_srcdir)/src/openvpn/mss.c \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash.c \</span><br><span=
> 	$(top_srcdir)/src/openvpn/siphash_openssl.c \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/siphash_reference.c</span><br><span> </span><br><span>@@ =
-378,7 +379,10 @@</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util.c \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/platform.c \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/list.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/list.c \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvp=
n/siphash.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top=
_srcdir)/src/openvpn/siphash_openssl.c \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference.c</span><=
br><span> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_s=
rcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tes=
ts/openvpn/test_misc.c</span><br><span>index 24bf22d..576630d 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_misc.c</span><br><span>@@ -32,6 +32,7 @@</spa=
n><br><span> #include &lt;string.h&gt;</span><br><span> #include &lt;setjmp=
.h&gt;</span><br><span> #include &lt;cmocka.h&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;siphash.h&gt;</span><br><span> <=
/span><br><span> #include &quot;ssl_util.h&quot;</span><br><span> #include =
&quot;options_util.h&quot;</span><br><span>@@ -127,10 +128,9 @@</span><br><=
span> static uint64_t</span><br><span> word_hash_function(const void *key, =
void *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    uint32_t *iv =3D (uint32_t *)ctx;</span><br><span>     const ch=
ar *str =3D (const char *)key;</span><br><span>     const uint32_t len =3D =
(uint32_t)strlen(str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return hash_func((const uint8_t *)str, len, *iv);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func((const uint=
8_t *)str, len, ctx);</span><br><span> }</span><br><span> </span><br><span>=
 static bool</span><br><span>@@ -173,8 +173,8 @@</span><br><span>      * wo=
rd frequency algorithm.</span><br><span>      */</span><br><span>     struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct hash *hash =3D hash_init(10000, hash_func_new_ctx(), free,=
 word_hash_function, word_compare_function);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct hash *nhash =3D hash_init(256, hash_func_=
new_ctx(), free, word_hash_function, word_compare_function);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash =3D hash_ini=
t(10000, siphash_new_context(), siphash_free_context, word_hash_function, w=
ord_compare_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct hash *nhash =3D hash_init(256, siphash_new_context(), siphash=
_free_context, word_hash_function, word_compare_function);</span><br><span>=
 </span><br><span>     printf(&quot;hash_init n_buckets=3D%u mask=3D0x%08x\=
n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br><span> </span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1573?usp=3Demail">change 1573</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I807f398903ac2047530800c2994=
9793c6f4f0ec9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--G29gGWkJOJ0=--

