From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 21 Sep 2024 14:16:30 +0000
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <b126ff61491348895e2e63cd497c3bb2f2980c74-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZfHzmf9+YLo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Prefer OpenSSL's
 SIPHASH implementation when available
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

--ZfHzmf9+YLo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/31?usp=3Demail

to review the following change.


Change subject: Prefer OpenSSL's SIPHASH implementation when available
......................................................................

Prefer OpenSSL's SIPHASH implementation when available

OpenSSL library is significantly faster than the reference implementation
(almost 2x). Prefer using this when available. The API for using the SIPHASH
MAC is different enough from using normal HMAC or Digest that we already
implement that combining them into one API does not make sense.

SIPHASH is only available on OpenSSL 3.1 and later. We still check for
support on 3.0 and later as the whole API to allow using the SIPHASH alrady
exists in OpenSSL 3.0. Some of the later OpenSSL 3.0.x might get support
for it. Theoretically, a provider can be loaded in OpenSSL 3.0 that
implements SIPHASH.

Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/bloom.c
M src/openvpn/bloom.h
M src/openvpn/reflect_filter.c
M src/openvpn/siphash.h
A src/openvpn/siphash_openssl.c
M src/openvpn/siphash_reference.c
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_reflect.c
10 files changed, 253 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/31/9

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5aba2d4..0faf8da 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -513,6 +513,7 @@
     src/openvpn/sig.c
     src/openvpn/sig.h
     src/openvpn/siphash.h
+    src/openvpn/siphash_openssl.c
     src/openvpn/siphash_reference.c
     src/openvpn/socket.c
     src/openvpn/socket.h
@@ -780,6 +781,7 @@
         src/openvpn/reflect_filter.h
         src/openvpn/siphash.h
         src/openvpn/siphash_reference.c
+        src/openvpn/siphash_openssl.c
         src/openvpn/otime.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ca77718..f357764 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -126,6 +126,7 @@
 	shaper.c shaper.h \
 	sig.c sig.h \
 	siphash_reference.c siphash.h \
+	siphash_openssl.c \
 	socket.c socket.h \
 	socks.c socks.h \
 	ssl.c ssl.h  ssl_backend.h \
diff --git a/src/openvpn/bloom.c b/src/openvpn/bloom.c
index 729429e..6225e03 100644
--- a/src/openvpn/bloom.c
+++ b/src/openvpn/bloom.c
@@ -170,10 +170,19 @@

     ALLOC_ARRAY_GC(bf->siphash_keys, struct siphash_key, bf->num_siphash, =
gc);

+    bf->siphash_ctx =3D siphash_cryptolib_init();
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
  * Clear the bloom filter, making it empty again as if it were freshly cre=
ated
  * @param bf the bloom structure to clear
@@ -209,7 +218,8 @@
             if (idx =3D=3D 0)
             {
                 /* We have no longer unused bytes in result, generate the =
next hash */
-                siphash(item, len, bf->siphash_keys[j++].key, result, SIPH=
ASH_HASH_SIZE);
+                siphash(bf->siphash_ctx, item, len, bf->siphash_keys[j++].=
key,
+                        result, SIPHASH_HASH_SIZE);
             }

             bucket =3D bucket << 8;
diff --git a/src/openvpn/bloom.h b/src/openvpn/bloom.h
index e180261..b35d784 100644
--- a/src/openvpn/bloom.h
+++ b/src/openvpn/bloom.h
@@ -75,6 +75,9 @@
     /** keys for the siphash functions */
     struct siphash_key *siphash_keys;

+    /** (opaque) context for the siphash implementation */
+    void *siphash_ctx;
+
     /** the actual buckets that hold the data */
     bloom_counter_t buckets[];
 };
@@ -83,6 +86,9 @@
 struct bloom_filter *
 bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc);

+void
+bloom_free(struct bloom_filter *bf);
+
 bloom_counter_t
 bloom_test(struct bloom_filter *bf, const uint8_t *item, size_t len);

diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index 75445c0..f665e4c 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -448,6 +448,7 @@
 void
 initial_rate_limit_free(struct initial_packet_rate_limit *irl)
 {
+    bloom_free(irl->bf);
     gc_free(&irl->gc);
     free(irl);
     irl =3D NULL;
diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h
index d26ee36..14414d5 100644
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
index 0000000..67a77f1
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
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x300000=
00L
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
+    struct siphash_context *sip =3D sip_context;
+
+
+    sip->params[1] =3D OSSL_PARAM_construct_octet_string("key", (void *)k,
+                                                       SIPHASH_KEY_SIZE);
+    if (!EVP_MAC_init(sip->ctx, NULL, 0, sip->params))
+    {
+        crypto_msg(M_FATAL, "EVP_MAC_init failed");
+    }
+    EVP_MAC_update(sip->ctx, in, inlen);
+
+    size_t outl =3D 0;
+    EVP_MAC_final(sip->ctx, out, &outl, outlen);
+    return 0;
+}
+
+void *
+siphash_cryptolib_init(void)
+{
+    struct siphash_context *sip;
+    ALLOC_OBJ(sip, struct siphash_context);
+
+    sip->mac =3D EVP_MAC_fetch(NULL, "SIPHASH", NULL);
+    if (!sip->mac)
+    {
+        /* Our OpenSSL library does not support SIPHASH */
+        return sip;
+    }
+    sip->ctx =3D EVP_MAC_CTX_new(sip->mac);
+
+    /* OpenSSL will truly hold a pointer to an int in that parameter */
+    sip->size =3D SIPHASH_HASH_SIZE;
+    sip->params[0] =3D OSSL_PARAM_construct_size_t("size", &sip->size);
+    /* params[1] will hold the key that changes which each invocation */
+    sip->params[2] =3D OSSL_PARAM_construct_end();
+    return sip;
+}
+
+bool
+siphash_cryptolib_available(void *sip_context)
+{
+    struct siphash_context *sip =3D sip_context;
+
+    return (bool)(sip->mac);
+}
+
+void
+siphash_cryptolib_uninit(void *sip_context)
+{
+    struct siphash_context *sip =3D sip_context;
+    EVP_MAC_CTX_free(sip->ctx);
+    EVP_MAC_free(sip->mac);
+    free(sip_context);
+}
+
+#else  /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D=
 0x30000000L */
+/* for now, we only have one implementation of SIPHASH in a libray, so put=
 the
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
+#endif /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D=
 0x30000000L */
diff --git a/src/openvpn/siphash_reference.c b/src/openvpn/siphash_referenc=
e.c
index 35af707..2a83b5e 100644
--- a/src/openvpn/siphash_reference.c
+++ b/src/openvpn/siphash_reference.c
@@ -98,8 +98,8 @@
  *  outlen: length of the output in bytes, must be 8 or 16
  */
 int
-siphash(const void *in, const size_t inlen, const void *k, uint8_t *out,
-        const size_t outlen)
+siphash_reference(const void *in, const size_t inlen, const void *k,
+                  uint8_t *out, const size_t outlen)
 {

     const unsigned char *ni =3D (const unsigned char *)in;
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index cd1c378..9370360 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -158,6 +158,7 @@
 	$(top_srcdir)/src/openvpn/packet_id.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/siphash_reference.c \
+	$(top_srcdir)/src/openvpn/siphash_openssl.c \
 	$(top_srcdir)/src/openvpn/win32-util.c

 if !WIN32
diff --git a/tests/unit_tests/openvpn/test_reflect.c b/tests/unit_tests/ope=
nvpn/test_reflect.c
index 5158631..9238fe8 100644
--- a/tests/unit_tests/openvpn/test_reflect.c
+++ b/tests/unit_tests/openvpn/test_reflect.c
@@ -41,7 +41,42 @@

 #include <stdio.h>

+static void
+test_siphash(void **state)
+{
+    const char *message =3D "Look behind you, a Three-Headed Monkey!";

+    uint8_t out[SIPHASH_HASH_SIZE];
+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55=
, 0x66 };
+
+    siphash_reference(message, strlen(message), key, out, SIPHASH_HASH_SIZ=
E);
+
+    const uint8_t expected_out[SIPHASH_HASH_SIZE] =3D
+    { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+      0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51};
+    assert_memory_equal(out, expected_out, SIPHASH_HASH_SIZE);
+
+    struct gc_arena gc =3D gc_new();
+    void *sipctx =3D  siphash_cryptolib_init();
+
+
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

 static void
 test_bloom(void **state)
@@ -311,6 +346,7 @@
 {
     openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_siphash),
         cmocka_unit_test(test_bloom_access_functions),
         cmocka_unit_test(test_bloom),
         cmocka_unit_test(test_bloom_minimal),

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/31?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ZfHzmf9+YLo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/31?usp=3Demail">Vie=
w Change</a></p><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Prefer OpenSSL&#39;s SIPHASH implementation when available<br>=
<br>OpenSSL library is significantly faster than the reference implementati=
on<br>(almost 2x). Prefer using this when available. The API for using the =
SIPHASH<br>MAC is different enough from using normal HMAC or Digest that we=
 already<br>implement that combining them into one API does not make sense.=
<br><br>SIPHASH is only available on OpenSSL 3.1 and later. We still check =
for<br>support on 3.0 and later as the whole API to allow using the SIPHASH=
 alrady<br>exists in OpenSSL 3.0. Some of the later OpenSSL 3.0.x might get=
 support<br>for it. Theoretically, a provider can be loaded in OpenSSL 3.0 =
that<br>implements SIPHASH.<br><br>Change-Id: I09aa27caa1a3aab0d1be6118b26d=
54a1c1bf7aa0<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<=
br>M CMakeLists.txt<br>M src/openvpn/Makefile.am<br>M src/openvpn/bloom.c<b=
r>M src/openvpn/bloom.h<br>M src/openvpn/reflect_filter.c<br>M src/openvpn/=
siphash.h<br>A src/openvpn/siphash_openssl.c<br>M src/openvpn/siphash_refer=
ence.c<br>M tests/unit_tests/openvpn/Makefile.am<br>M tests/unit_tests/open=
vpn/test_reflect.c<br>10 files changed, 253 insertions(+), 7 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/31=
/9</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>ind=
ex 5aba2d4..0faf8da 100644</span><br><span>--- a/CMakeLists.txt</span><br><=
span>+++ b/CMakeLists.txt</span><br><span>@@ -513,6 +513,7 @@</span><br><sp=
an>     src/openvpn/sig.c</span><br><span>     src/openvpn/sig.h</span><br>=
<span>     src/openvpn/siphash.h</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    src/openvpn/siphash_openssl.c</span><br><span>     src/ope=
nvpn/siphash_reference.c</span><br><span>     src/openvpn/socket.c</span><b=
r><span>     src/openvpn/socket.h</span><br><span>@@ -780,6 +781,7 @@</span=
><br><span>         src/openvpn/reflect_filter.h</span><br><span>         s=
rc/openvpn/siphash.h</span><br><span>         src/openvpn/siphash_reference=
.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openv=
pn/siphash_openssl.c</span><br><span>         src/openvpn/otime.c</span><br=
><span>         src/openvpn/crypto_mbedtls.c</span><br><span>         src/o=
penvpn/crypto_openssl.c</span><br><span>diff --git a/src/openvpn/Makefile.a=
m b/src/openvpn/Makefile.am</span><br><span>index ca77718..f357764 100644</=
span><br><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/open=
vpn/Makefile.am</span><br><span>@@ -126,6 +126,7 @@</span><br><span> 	shape=
r.c shaper.h \</span><br><span> 	sig.c sig.h \</span><br><span> 	siphash_re=
ference.c siphash.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	siphash_openssl.c \</span><br><span> 	socket.c socket.h \</span><br><spa=
n> 	socks.c socks.h \</span><br><span> 	ssl.c ssl.h  ssl_backend.h \</span>=
<br><span>diff --git a/src/openvpn/bloom.c b/src/openvpn/bloom.c</span><br>=
<span>index 729429e..6225e03 100644</span><br><span>--- a/src/openvpn/bloom=
.c</span><br><span>+++ b/src/openvpn/bloom.c</span><br><span>@@ -170,10 +17=
0,19 @@</span><br><span> </span><br><span>     ALLOC_ARRAY_GC(bf-&gt;siphas=
h_keys, struct siphash_key, bf-&gt;num_siphash, gc);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;siphash_ctx =
=3D siphash_cryptolib_init();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     bloom_clear(bf);</span><br><span>     retur=
n bf;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bloom_free(struct bloom_filter *bf)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    siphash_cryptolib_uninit(bf-&gt;siphash_ctx);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /**</span><br><span>  * Clear the bloom filter, making it =
empty again as if it were freshly created</span><br><span>  * @param bf the=
 bloom structure to clear</span><br><span>@@ -209,7 +218,8 @@</span><br><sp=
an>             if (idx =3D=3D 0)</span><br><span>             {</span><br>=
<span>                 /* We have no longer unused bytes in result, generat=
e the next hash */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             siphash(item, len, bf-&gt;siphash_keys[j++].key, result, SIPHA=
SH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           siphash(bf-&gt;siphash_ctx, item, len, bf-&gt;siphash_keys[j++].=
key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         result, SIPHASH_HASH_SIZE);</span><br><span>             }</span><=
br><span> </span><br><span>             bucket =3D bucket &lt;&lt; 8;</span=
><br><span>diff --git a/src/openvpn/bloom.h b/src/openvpn/bloom.h</span><br=
><span>index e180261..b35d784 100644</span><br><span>--- a/src/openvpn/bloo=
m.h</span><br><span>+++ b/src/openvpn/bloom.h</span><br><span>@@ -75,6 +75,=
9 @@</span><br><span>     /** keys for the siphash functions */</span><br><=
span>     struct siphash_key *siphash_keys;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /** (opaque) context for the =
siphash implementation */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    void *siphash_ctx;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     /** the actual buckets that hold the data */=
</span><br><span>     bloom_counter_t buckets[];</span><br><span> };</span>=
<br><span>@@ -83,6 +86,9 @@</span><br><span> struct bloom_filter *</span><b=
r><span> bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc);=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_free(struc=
t bloom_filter *bf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> bloom_counter_t</span><br><span> bloom_test(struct bloom=
_filter *bf, const uint8_t *item, size_t len);</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filte=
r.c</span><br><span>index 75445c0..f665e4c 100644</span><br><span>--- a/src=
/openvpn/reflect_filter.c</span><br><span>+++ b/src/openvpn/reflect_filter.=
c</span><br><span>@@ -448,6 +448,7 @@</span><br><span> void</span><br><span=
> initial_rate_limit_free(struct initial_packet_rate_limit *irl)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bloom_f=
ree(irl-&gt;bf);</span><br><span>     gc_free(&amp;irl-&gt;gc);</span><br><=
span>     free(irl);</span><br><span>     irl =3D NULL;</span><br><span>dif=
f --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h</span><br><span>ind=
ex d26ee36..14414d5 100644</span><br><span>--- a/src/openvpn/siphash.h</spa=
n><br><span>+++ b/src/openvpn/siphash.h</span><br><span>@@ -20,12 +20,52 @@=
</span><br><span> </span><br><span> #include &lt;inttypes.h&gt;</span><br><=
span> #include &lt;string.h&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int siphash=
(const void *in, size_t inlen, const void *k, uint8_t *out,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            size_t outlen);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool.h&gt;</s=
pan><br><span> </span><br><span> /* siphash always uses 128-bit keys */</sp=
an><br><span> #define SIPHASH_KEY_SIZE    16</span><br><span> #define SIPHA=
SH_HASH_SIZE   16</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Prototypes for =
an implementation of SIPHASH in a crypto library */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Calculates SIPHASH using the crypto library function.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+siphash_cryptolib(void *sip_context, const void *in, size_t inlen,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                  const =
void *k, uint8_t *out, size_t outlen);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calculates SI=
PHASH using the reference implementation</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_ref=
erence(const void *in, size_t inlen, const void *k,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  uint8_t *out, size_t ou=
tlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+siphash_cryptolib_init(void);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+siphash_cryptolib_uninit(void *sip_context);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sip=
hash_cryptolib_available(void *sip_context);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static inline</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash(void *ct=
x, const void *in, size_t inlen, const void *k,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uint8_t *out, size_t outlen)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (siphash_cryptolib_available(ctx) &amp;&a=
mp; false)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return siphash_=
cryptolib(ctx, in, inlen, k, out, outlen);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return s=
iphash_reference(in, inlen, k, out, outlen);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif /* ifndef SIPHASH_H */</span><br><span=
>diff --git a/src/openvpn/siphash_openssl.c b/src/openvpn/siphash_openssl.c=
</span><br><span>new file mode 100644</span><br><span>index 0000000..67a77f=
1</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/siphash_o=
penssl.c</span><br><span>@@ -0,0 +1,149 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single=
 TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             session authentication and key exc=
hange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  packet encryption, packet authentication, and</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             packet compression.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023 OpenVPN Inc &lt;sales@...1696...=
15...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyri=
ght (C) 2023 Arne Schwabe &lt;arne@...1227...&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  This program is free software; you can redistribute it and=
/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it un=
der the terms of the GNU General Public License version 2</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software=
 Foundation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is dist=
ributed in the hope that it will be useful,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the impl=
ied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have r=
eceived a copy of the GNU General Public License along</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to =
the Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 =
USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#elif defined(_MSC_VER)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config-msvc.h&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;siphash.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;buffer.h&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fdef ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;openssl/opensslv.h&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000=
000L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/evp.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_o=
penssl.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+struct siphash_context</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC *mac;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_CTX *ctx;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    size_t size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OSSL_PARAM params[3];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Computes =
a SipHash value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * i=
n: pointer to input data (read-only)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  inlen: input data length in bytes (any size_t value)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * k: pointer to the =
key data (read-only), must be 16 bytes</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * out: pointer to output data (write-only), outlen byte=
s must be allocated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  outlen: length of the output in bytes, must be 8 or 16</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+siphash_cryptolib(void *sip_context, const void *in, const size_t in=
len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
   const void *k, uint8_t *out, const size_t outlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct siphash_context *sip =3D sip_context;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    sip-&gt;params[1] =3D OSSL_PARAM_construct_octet_string(&quot;ke=
y&quot;, (void *)k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                                       SIPHASH_KEY_SIZE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!EVP_MAC_init=
(sip-&gt;ctx, NULL, 0, sip-&gt;params))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        crypto_msg(M_FATAL, &quot;EVP_MAC_init failed&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_update(sip-&gt;ctx, in, inlen=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    size_t outl =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_final(sip-&gt;ctx, ou=
t, &amp;outl, outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+siphash_cryptolib_init(void)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct siphash_context *sip;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ALLOC_OBJ(sip, struct siphash_context);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    sip-&gt;mac =3D EVP_MAC_fetch(NULL, &quo=
t;SIPHASH&quot;, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!sip-&gt;mac)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* Our OpenSSL library does not support SIPHASH */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return sip;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    sip-&gt;ctx =3D EVP_MAC_CTX_new(sip-&gt;mac);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* OpenSSL will truly hold a pointer to an =
int in that parameter */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    sip-&gt;size =3D SIPHASH_HASH_SIZE;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    sip-&gt;params[0] =3D OSSL_PARAM_construct_siz=
e_t(&quot;size&quot;, &amp;sip-&gt;size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* params[1] will hold the key that changes which=
 each invocation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    sip-&gt;params[2] =3D OSSL_PARAM_construct_end();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return sip;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_avai=
lable(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct si=
phash_context *sip =3D sip_context;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return (bool)(sip-&gt;mac);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_uninit(void *sip_contex=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context *sip =3D=
 sip_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EV=
P_MAC_CTX_free(sip-&gt;ctx);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    EVP_MAC_free(sip-&gt;mac);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    free(sip_context);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if d=
efined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x3=
0000000L */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* for n=
ow, we only have one implementation of SIPHASH in a libray, so put the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * dummy functions also =
here */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib(void *sip_=
context, const void *in, const size_t inlen,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                  const void *k, uint8_t *out, con=
st size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
siphash_cryptolib_available(void *sip_context)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_init(void)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_uninit(void =
*sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &=
gt;=3D 0x30000000L */</span><br><span>diff --git a/src/openvpn/siphash_refe=
rence.c b/src/openvpn/siphash_reference.c</span><br><span>index 35af707..2a=
83b5e 100644</span><br><span>--- a/src/openvpn/siphash_reference.c</span><b=
r><span>+++ b/src/openvpn/siphash_reference.c</span><br><span>@@ -98,8 +98,=
8 @@</span><br><span>  *  outlen: length of the output in bytes, must be 8 =
or 16</span><br><span>  */</span><br><span> int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-siphash(const void *in, const size_t inlen, const=
 void *k, uint8_t *out,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        const size_t outlen)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+siphash_reference(const void *in, const size_t inlen, const void=
 *k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
   uint8_t *out, const size_t outlen)</span><br><span> {</span><br><span> <=
/span><br><span>     const unsigned char *ni =3D (const unsigned char *)in;=
</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/=
unit_tests/openvpn/Makefile.am</span><br><span>index cd1c378..9370360 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -158,6 +158=
,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/packet_id.c \</span><br><=
span> 	$(top_srcdir)/src/openvpn/platform.c \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/siphash_reference.c \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_openssl.c \</span><br><=
span> 	$(top_srcdir)/src/openvpn/win32-util.c</span><br><span> </span><br><=
span> if !WIN32</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
reflect.c b/tests/unit_tests/openvpn/test_reflect.c</span><br><span>index 5=
158631..9238fe8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
reflect.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_reflect.c</sp=
an><br><span>@@ -41,7 +41,42 @@</span><br><span> </span><br><span> #include=
 &lt;stdio.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_siphash(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *message =3D &quot;Look behind you, a Three-Headed Monkey!&quot;=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint8_t out[SIPHASH_HASH_SIZE];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0=
x33, 0x44, 0x55, 0x66 };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_re=
ference(message, strlen(message), key, out, SIPHASH_HASH_SIZE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const uint8_t expected_out[SIPHASH_HASH_SIZE] =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { 0x3e, 0xea=
, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51};</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equa=
l(out, expected_out, SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    void *sipctx =3D  siphash_cryptolib_init();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint8_t out2[SIPHASH_HASH_SIZE];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (siphash_cryptolib_available(sipctx))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        siphash_cryptolib(sipctx, message, strlen(messa=
ge), key, out2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                      SIPHASH_HASH_SIZE);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        assert_memory_equal(out, out2, SIPHASH_HASH_S=
IZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* check that calling the=
 function twice is safe */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        siphash_cryptolib(sipctx, message, strlen(message), key, out=
2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
         SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        assert_memory_equal(out, out2, SIPHASH_HASH_SIZE);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    siphash_cryptolib_uninit(sipctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> st=
atic void</span><br><span> test_bloom(void **state)</span><br><span>@@ -311=
,6 +346,7 @@</span><br><span> {</span><br><span>     openvpn_unit_test_setu=
p();</span><br><span>     const struct CMUnitTest tests[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_s=
iphash),</span><br><span>         cmocka_unit_test(test_bloom_access_functi=
ons),</span><br><span>         cmocka_unit_test(test_bloom),</span><br><spa=
n>         cmocka_unit_test(test_bloom_minimal),</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
1?usp=3Demail">change 31</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/31?usp=3Demail"/><me=
ta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26=
d54a1c1bf7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 31 </div>
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


--ZfHzmf9+YLo=--

