From: Arne Schwabe <arne@...1227...>
Date: Mon, 27 Feb 2023 13:50:23 +0100
Message-Id: <20230227125023.2561379-3-arne@...1227...>
In-Reply-To: <20230227125023.2561379-1-arne@...1227...>
References: <20230227125023.2561379-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Prefer OpenSSL's SIPHASH implementation
 when available
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

OpenSSL library is significantly faster than the reference implementation
(almost 2x). Prefer using this when available. The API for using the SIPHASH
MAC is different enough from using normal HMAC or Digest that we already
implement that combining them into one API does not make sense.

Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/Makefile.am                 |   1 +
 src/openvpn/bloom.c                     |  14 ++-
 src/openvpn/bloom.h                     |   6 +
 src/openvpn/openvpn.vcxproj             |   1 +
 src/openvpn/reflect_filter.c            |   1 +
 src/openvpn/siphash.c                   |   4 +-
 src/openvpn/siphash.h                   |  48 +++++++-
 src/openvpn/siphash_openssl.c           | 149 ++++++++++++++++++++++++
 tests/unit_tests/openvpn/Makefile.am    |   1 +
 tests/unit_tests/openvpn/test_reflect.c |  36 ++++++
 10 files changed, 253 insertions(+), 8 deletions(-)
 create mode 100644 src/openvpn/siphash_openssl.c

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index c1de7b723..2e9ba389c 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -124,6 +124,7 @@ openvpn_SOURCES = \
 	shaper.c shaper.h \
 	sig.c sig.h \
 	siphash.c siphash.h \
+	siphash_openssl.c \
 	socket.c socket.h \
 	socks.c socks.h \
 	ssl.c ssl.h  ssl_backend.h \
diff --git a/src/openvpn/bloom.c b/src/openvpn/bloom.c
index 9382bf264..6225e0318 100644
--- a/src/openvpn/bloom.c
+++ b/src/openvpn/bloom.c
@@ -169,11 +169,20 @@ bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc)
     bf->num_siphash = calculate_num_sip_hash_hashes(bf);
 
     ALLOC_ARRAY_GC(bf->siphash_keys, struct siphash_key, bf->num_siphash, gc);
-    
+
+    bf->siphash_ctx = siphash_cryptolib_init();
+
     bloom_clear(bf);
     return bf;
 }
 
+void
+bloom_free(struct bloom_filter *bf)
+{
+    siphash_cryptolib_uninit(bf->siphash_ctx);
+}
+
+
 /**
  * Clear the bloom filter, making it empty again as if it were freshly created
  * @param bf the bloom structure to clear
@@ -209,7 +218,8 @@ bloom_add_test(struct bloom_filter *bf, const uint8_t *item, size_t len, bloom_c
             if (idx == 0)
             {
                 /* We have no longer unused bytes in result, generate the next hash */
-                siphash(item, len, bf->siphash_keys[j++].key, result, SIPHASH_HASH_SIZE);
+                siphash(bf->siphash_ctx, item, len, bf->siphash_keys[j++].key,
+                        result, SIPHASH_HASH_SIZE);
             }
 
             bucket = bucket << 8;
diff --git a/src/openvpn/bloom.h b/src/openvpn/bloom.h
index e18026181..b35d784da 100644
--- a/src/openvpn/bloom.h
+++ b/src/openvpn/bloom.h
@@ -75,6 +75,9 @@ struct bloom_filter {
     /** keys for the siphash functions */
     struct siphash_key *siphash_keys;
 
+    /** (opaque) context for the siphash implementation */
+    void *siphash_ctx;
+
     /** the actual buckets that hold the data */
     bloom_counter_t buckets[];
 };
@@ -83,6 +86,9 @@ struct bloom_filter {
 struct bloom_filter *
 bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc);
 
+void
+bloom_free(struct bloom_filter *bf);
+
 bloom_counter_t
 bloom_test(struct bloom_filter *bf, const uint8_t *item, size_t len);
 
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 2d12f8309..c6bd544d2 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -332,6 +332,7 @@
     <ClCompile Include="shaper.c" />
     <ClCompile Include="sig.c" />
     <ClCompile Include="siphash.c" />
+    <ClCompile Include="siphash_openssl.c" />
     <ClCompile Include="socket.c" />
     <ClCompile Include="socks.c" />
     <ClCompile Include="ssl.c" />
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index 35ab2880c..0d3a742a5 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -450,6 +450,7 @@ initial_rate_limit_init(int max_per_period, int period_length,
 void
 initial_rate_limit_free(struct initial_packet_rate_limit *irl)
 {
+    bloom_free(irl->bf);
     gc_free(&irl->gc);
     free(irl);
     irl = NULL;
diff --git a/src/openvpn/siphash.c b/src/openvpn/siphash.c
index b8a7bbc11..0c995f964 100644
--- a/src/openvpn/siphash.c
+++ b/src/openvpn/siphash.c
@@ -87,8 +87,8 @@
  *  outlen: length of the output in bytes, must be 8 or 16
  */
 int
-siphash(const void *in, const size_t inlen, const void *k, uint8_t *out,
-        const size_t outlen)
+siphash_reference(const void *in, const size_t inlen, const void *k,
+                  uint8_t *out, const size_t outlen)
 {
 
     const unsigned char *ni = (const unsigned char *)in;
diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h
index d26ee36ec..14414d5b4 100644
--- a/src/openvpn/siphash.h
+++ b/src/openvpn/siphash.h
@@ -20,12 +20,52 @@
 
 #include <inttypes.h>
 #include <string.h>
-
-int siphash(const void *in, size_t inlen, const void *k, uint8_t *out,
-            size_t outlen);
+#include <stdbool.h>
 
 /* siphash always uses 128-bit keys */
 #define SIPHASH_KEY_SIZE    16
 #define SIPHASH_HASH_SIZE   16
 
-#endif
+
+/* Prototypes for an implementation of SIPHASH in a crypto library */
+
+/**
+ * Calculates SIPHASH using the crypto library function.
+ */
+int
+siphash_cryptolib(void *sip_context, const void *in, size_t inlen,
+                  const void *k, uint8_t *out, size_t outlen);
+
+/**
+ * Calculates SIPHASH using the reference implementation
+ */
+int
+siphash_reference(const void *in, size_t inlen, const void *k,
+                  uint8_t *out, size_t outlen);
+
+void *
+siphash_cryptolib_init(void);
+
+void
+siphash_cryptolib_uninit(void *sip_context);
+
+bool
+siphash_cryptolib_available(void *sip_context);
+
+static inline
+int
+siphash(void *ctx, const void *in, size_t inlen, const void *k,
+        uint8_t *out, size_t outlen)
+{
+    if (siphash_cryptolib_available(ctx) && false)
+    {
+        return siphash_cryptolib(ctx, in, inlen, k, out, outlen);
+    }
+    else
+    {
+        return siphash_reference(in, inlen, k, out, outlen);
+    }
+
+}
+
+#endif /* ifndef SIPHASH_H */
diff --git a/src/openvpn/siphash_openssl.c b/src/openvpn/siphash_openssl.c
new file mode 100644
index 000000000..d29f3b6a8
--- /dev/null
+++ b/src/openvpn/siphash_openssl.c
@@ -0,0 +1,149 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2023 Arne Schwabe <arne@...1227...>
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
+#include "syshead.h"
+
+#include "siphash.h"
+#include "buffer.h"
+
+
+#ifdef ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv.h>
+#endif
+
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x30000000L
+
+#include <openssl/evp.h>
+#include "crypto_openssl.h"
+
+struct siphash_context
+{
+    EVP_MAC *mac;
+    EVP_MAC_CTX *ctx;
+    size_t size;
+    OSSL_PARAM params[3];
+};
+
+/*
+ *  Computes a SipHash value
+ * in: pointer to input data (read-only)
+ *  inlen: input data length in bytes (any size_t value)
+ * k: pointer to the key data (read-only), must be 16 bytes
+ * out: pointer to output data (write-only), outlen bytes must be allocated
+ *  outlen: length of the output in bytes, must be 8 or 16
+ */
+int
+siphash_cryptolib(void *sip_context, const void *in, const size_t inlen,
+                  const void *k, uint8_t *out, const size_t outlen)
+{
+    struct siphash_context *sip = sip_context;
+
+
+    sip->params[1] = OSSL_PARAM_construct_octet_string("key", (void *)k,
+                                                       SIPHASH_KEY_SIZE);
+    if (!EVP_MAC_init(sip->ctx, NULL, 0, sip->params))
+    {
+        crypto_msg(M_FATAL, "EVP_MAC_init failed");
+    }
+    EVP_MAC_update(sip->ctx, in, inlen);
+
+    size_t outl = 0;
+    EVP_MAC_final(sip->ctx, out, &outl, outlen);
+    return 0;
+}
+
+void *
+siphash_cryptolib_init()
+{
+    struct siphash_context *sip;
+    ALLOC_OBJ(sip, struct siphash_context);
+
+    sip->mac = EVP_MAC_fetch(NULL, "SIPHASH", NULL);
+    if (!sip->mac)
+    {
+        /* Our OpenSSL library does not support SIPHASH */
+        return sip;
+    }
+    sip->ctx = EVP_MAC_CTX_new(sip->mac);
+
+    /* OpenSSL will truly hold a pointer to an int in that parameter */
+    sip->size = SIPHASH_HASH_SIZE;
+    sip->params[0] = OSSL_PARAM_construct_size_t("size", &sip->size);
+    /* params[1] will hold the key that changes which each invocation */
+    sip->params[2] = OSSL_PARAM_construct_end();
+    return sip;
+}
+
+bool
+siphash_cryptolib_available(void *sip_context)
+{
+    struct siphash_context *sip = sip_context;
+
+    return (bool)(sip->mac);
+}
+
+void
+siphash_cryptolib_uninit(void *sip_context)
+{
+    struct siphash_context *sip = sip_context;
+    EVP_MAC_CTX_free(sip->ctx);
+    EVP_MAC_free(sip->mac);
+    free(sip_context);
+}
+
+#else  /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x30000000L */
+/* for now, we only have one implementation of SIPHASH in a libray, so put the
+ * dummy functions also here */
+int
+siphash_cryptolib(void *sip_context, const void *in, const size_t inlen,
+                  const void *k, uint8_t *out, const size_t outlen)
+{
+    return -1;
+}
+
+bool
+siphash_cryptolib_available(void *sip_context)
+{
+    return false;
+}
+
+void *
+siphash_cryptolib_init(void)
+{
+    return NULL;
+}
+
+void
+siphash_cryptolib_uninit(void *sip_context)
+{
+}
+
+
+#endif /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x30000000L */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index b8ba1d4db..c6f026561 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -113,6 +113,7 @@ reflect_testdriver_SOURCES = test_reflect.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/siphash.c \
+	$(openvpn_srcdir)/siphash_openssl.c \
 	$(openvpn_srcdir)/win32-util.c
 
 if !WIN32
diff --git a/tests/unit_tests/openvpn/test_reflect.c b/tests/unit_tests/openvpn/test_reflect.c
index 624c6b20b..0ce111d95 100644
--- a/tests/unit_tests/openvpn/test_reflect.c
+++ b/tests/unit_tests/openvpn/test_reflect.c
@@ -40,8 +40,43 @@
 
 #include <stdio.h>
 
+static void
+test_siphash(void **state)
+{
+    const char *message = "Look behind you, a Three-Headed Monkey!";
+
+    uint8_t out[SIPHASH_HASH_SIZE];
+    const uint8_t key[SIPHASH_KEY_SIZE] = { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };
+
+    siphash_reference(message, strlen(message), key, out, SIPHASH_HASH_SIZE);
+
+    const uint8_t expected_out[SIPHASH_HASH_SIZE] =
+    { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+      0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51};
+    assert_memory_equal(out, expected_out, SIPHASH_HASH_SIZE);
+
+    struct gc_arena gc = gc_new();
+    void *sipctx =  siphash_cryptolib_init();
 
 
+    uint8_t out2[SIPHASH_HASH_SIZE];
+
+    if (siphash_cryptolib_available(sipctx))
+    {
+        siphash_cryptolib(sipctx, message, strlen(message), key, out2,
+                          SIPHASH_HASH_SIZE);
+        assert_memory_equal(out, out2, SIPHASH_HASH_SIZE);
+
+        /* check that calling the function twice is safe */
+        siphash_cryptolib(sipctx, message, strlen(message), key, out2,
+                          SIPHASH_HASH_SIZE);
+        assert_memory_equal(out, out2, SIPHASH_HASH_SIZE);
+    }
+
+    siphash_cryptolib_uninit(sipctx);
+    gc_free(&gc);
+}
+
 static void
 test_bloom(void **state)
 {
@@ -307,6 +342,7 @@ int
 main(void)
 {
     const struct CMUnitTest tests[] = {
+        cmocka_unit_test(test_siphash),
         cmocka_unit_test(test_bloom_access_functions),
         cmocka_unit_test(test_bloom),
         cmocka_unit_test(test_bloom_minimal),
-- 
2.37.1 (Apple Git-137.1)


