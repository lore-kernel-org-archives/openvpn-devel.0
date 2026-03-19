From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 19 Mar 2026 14:17:13 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@...2715...>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <eac2ae88c8c03ef2887403811a5bb7f1b2471ad6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XvPOg6IgqCo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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

--XvPOg6IgqCo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/31?usp=3Demail

to look at the new patch set (#13).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Allow to use OpenSSL's SIPHASH implementation when available
......................................................................

Allow to use OpenSSL's SIPHASH implementation when available

OpenSSL library is currently slower than the reference implementation
(about 1.5x to 2x depending of the compiler).

The OpenSSL API for using the SIPHASH MAC is different enough from using
normal HMAC or Digest that we already implement that combining them into
one API does not make sense.

SIPHASH is only available on OpenSSL 3.1 and later. We still check for
support on 3.0 and later as the whole API to allow using the SIPHASH alrady
exists in OpenSSL 3.0. Some of the later OpenSSL 3.0.x might get support
for it. Theoretically, a provider can be loaded in OpenSSL 3.0 that
implements SIPHASH.

With OpenSSL's implementation being slower, we currently only use it to
check that our reference implementation and the OpenSSL implementation
yield the same result in unit tests

Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/siphash.h
A src/openvpn/siphash_openssl.c
M src/openvpn/siphash_reference.c
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_crypto.c
7 files changed, 270 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/31/13

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 198c98f..8eb05f6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -556,6 +556,9 @@
     src/openvpn/shaper.h
     src/openvpn/sig.c
     src/openvpn/sig.h
+    src/openvpn/siphash.h
+    src/openvpn/siphash_openssl.c
+    src/openvpn/siphash_reference.c
     src/openvpn/socket.c
     src/openvpn/socket.h
     src/openvpn/socket_util.c
@@ -774,8 +777,12 @@
         src/openvpn/packet_id.c
         src/openvpn/mtu.c
         src/openvpn/mss.c
+        src/openvpn/siphash_reference.c
+        src/openvpn/siphash_openssl.c
         )

+    target_compile_definitions(test_crypto PRIVATE PREFER_OPENSSL_SIPHASH)
+
     target_sources(test_ssl PRIVATE
             tests/unit_tests/openvpn/mock_management.c
             tests/unit_tests/openvpn/mock_ssl_dependencies.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ff8cc54..08c8250 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -128,6 +128,8 @@
 	session_id.c session_id.h \
 	shaper.c shaper.h \
 	sig.c sig.h \
+	siphash_reference.c siphash.h \
+	siphash_openssl.c \
 	socket.c socket.h \
 	socket_util.c socket_util.h \
 	socks.c socks.h \
diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h
index ef61110..973596b 100644
--- a/src/openvpn/siphash.h
+++ b/src/openvpn/siphash.h
@@ -18,12 +18,55 @@
 #ifndef SIPHASH_H
 #define SIPHASH_H

-#include <inttypes.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdbool.h>

 /* siphash always uses 128-bit keys */
 #define SIPHASH_KEY_SIZE 16

-int siphash(const void *in, size_t inlen, const void *k, uint8_t *out,
-            size_t outlen);
+/* Prototypes for an implementation of SIPHASH in a crypto library */

-#endif
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
+/**
+ *
+ * @param hash_size the size of the output hash size
+ * @return initialised context for siphash
+ */
+void *
+siphash_cryptolib_init(size_t hash_size);
+
+void
+siphash_cryptolib_uninit(void *sip_context);
+
+bool
+siphash_cryptolib_available(void *sip_context);
+
+static inline int
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
+}
+
+#endif /* ifndef SIPHASH_H */
\ No newline at end of file
diff --git a/src/openvpn/siphash_openssl.c b/src/openvpn/siphash_openssl.c
new file mode 100644
index 0000000..bb42a38
--- /dev/null
+++ b/src/openvpn/siphash_openssl.c
@@ -0,0 +1,150 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2026 Arne Schwabe <arne@...1227...>
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
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
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
+/* OpenSSL siphash is currently 2-3 times slower than the reference
+ * implementation, so only enable it when PREFER_OPENSSL_SIPHASH is defined
+ * for now */
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x300000=
00L && defined(PREFER_OPENSSL_SIPHASH)
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
+siphash_cryptolib_init(size_t hash_size)
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
+    sip->size =3D hash_size;
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
+#else
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
+siphash_cryptolib_init(size_t hash_size)
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
index b21a86e..a06599f 100644
--- a/src/openvpn/siphash_reference.c
+++ b/src/openvpn/siphash_reference.c
@@ -100,8 +100,8 @@
  *  outlen: length of the output in bytes, must be 8 or 16
  */
 int
-siphash(const void *in, const size_t inlen, const void *k, uint8_t *out,
-        const size_t outlen)
+siphash_reference(const void *in, const size_t inlen, const void *k,
+                  uint8_t *out, const size_t outlen)
 {
     const unsigned char *ni =3D (const unsigned char *)in;
     const unsigned char *kk =3D (const unsigned char *)k;
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 1128eb4..4ed113a 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -84,7 +84,9 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/mtu.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
-	$(top_srcdir)/src/openvpn/mss.c
+	$(top_srcdir)/src/openvpn/mss.c \
+	$(top_srcdir)/src/openvpn/siphash_openssl.c \
+	$(top_srcdir)/src/openvpn/siphash_reference.c

 dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/sr=
c/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
 dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
@@ -97,6 +99,7 @@

 ssl_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
+	-DPREFER_OPENSSL_SIPHASH \
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl.c \
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index cb4eaa2..f943a8e 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -31,12 +31,14 @@
 #include <stdarg.h>
 #include <string.h>
 #include <setjmp.h>
+#include <inttypes.h>
 #include <cmocka.h>

 #include "crypto.h"
 #include "crypto_epoch.h"
 #include "options.h"
 #include "ssl_backend.h"
+#include "siphash.h"

 #include "mss.h"
 #include "test_common.h"
@@ -923,6 +925,59 @@
     assert_memory_equal(key_parameters.hmac, exp_impl_iv, sizeof(exp_impl_=
iv));
 }

+/* Use a define here since some c compilers don't like array initialisation
+ * with an integer */
+#define UT_SIPHASH_HASH_SIZE 16
+
+static void
+test_siphash(void **state)
+{
+    const char *message =3D "Look behind you, a Three-Headed Monkey!";
+
+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55=
, 0x66 };
+
+    siphash_reference(message, strlen(message), key, out, UT_SIPHASH_HASH_=
SIZE);
+
+    const uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x9=
5, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                                                         0x20, 0x47, 0x65,=
 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+    assert_memory_equal(out, expected_out, UT_SIPHASH_HASH_SIZE);
+}
+
+static void
+test_siphash_openssl(void **state)
+{
+    void *sipctx =3D siphash_cryptolib_init(UT_SIPHASH_HASH_SIZE);
+
+    if (!siphash_cryptolib_available(sipctx))
+    {
+        siphash_cryptolib_uninit(sipctx);
+        skip();
+    }
+
+    const char *message =3D "Look behind you, a Three-Headed Monkey!";
+
+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55=
, 0x66 };
+
+
+    const uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x9=
5, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                                                         0x20, 0x47, 0x65,=
 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+
+
+    siphash_cryptolib(sipctx, message, strlen(message), key, out,
+                      UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, out, UT_SIPHASH_HASH_SIZE);
+
+    /* check that calling the function twice is safe */
+    siphash_cryptolib(sipctx, message, strlen(message), key, out,
+                      UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_out, UT_SIPHASH_HASH_SIZE);
+
+    siphash_cryptolib_uninit(sipctx);
+}
+
+
 int
 main(void)
 {
@@ -957,10 +1012,9 @@
         cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_ove=
rflow,
                                                  crypto_test_epoch_setup,
                                                  crypto_test_epoch_teardow=
n, &prestate_num32),
-        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_edge,
-                                                 crypto_test_epoch_setup,
-                                                 crypto_test_epoch_teardow=
n, &prestate_num13),
-        cmocka_unit_test(epoch_test_derive_data_key)
+        cmocka_unit_test(epoch_test_derive_data_key),
+        cmocka_unit_test(test_siphash),
+        cmocka_unit_test(test_siphash_openssl)
     };

     return cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/31?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--XvPOg6IgqCo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #13</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/31?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Allow to use OpenSSL&#39;s S=
IPHASH implementation when available<br><br>OpenSSL library is currently sl=
ower than the reference implementation<br>(about 1.5x to 2x depending of th=
e compiler).<br><br>The OpenSSL API for using the SIPHASH MAC is different =
enough from using<br>normal HMAC or Digest that we already implement that c=
ombining them into<br>one API does not make sense.<br><br>SIPHASH is only a=
vailable on OpenSSL 3.1 and later. We still check for<br>support on 3.0 and=
 later as the whole API to allow using the SIPHASH alrady<br>exists in Open=
SSL 3.0. Some of the later OpenSSL 3.0.x might get support<br>for it. Theor=
etically, a provider can be loaded in OpenSSL 3.0 that<br>implements SIPHAS=
H.<br><br>With OpenSSL&#39;s implementation being slower, we currently only=
 use it to<br>check that our reference implementation and the OpenSSL imple=
mentation<br>yield the same result in unit tests<br><br>Change-Id: I09aa27c=
aa1a3aab0d1be6118b26d54a1c1bf7aa0<br>Signed-off-by: Arne Schwabe &lt;arne@...220...=
..1227...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/Makefile.am<br>M =
src/openvpn/siphash.h<br>A src/openvpn/siphash_openssl.c<br>M src/openvpn/s=
iphash_reference.c<br>M tests/unit_tests/openvpn/Makefile.am<br>M tests/uni=
t_tests/openvpn/test_crypto.c<br>7 files changed, 270 insertions(+), 11 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/31/31/13</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMake=
Lists.txt</span><br><span>index 198c98f..8eb05f6 100644</span><br><span>---=
 a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -=
556,6 +556,9 @@</span><br><span>     src/openvpn/shaper.h</span><br><span> =
    src/openvpn/sig.c</span><br><span>     src/openvpn/sig.h</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/siphash.h</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/siphash_open=
ssl.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvp=
n/siphash_reference.c</span><br><span>     src/openvpn/socket.c</span><br><=
span>     src/openvpn/socket.h</span><br><span>     src/openvpn/socket_util=
.c</span><br><span>@@ -774,8 +777,12 @@</span><br><span>         src/openvp=
n/packet_id.c</span><br><span>         src/openvpn/mtu.c</span><br><span>  =
       src/openvpn/mss.c</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        src/openvpn/siphash_reference.c</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/siphash_openssl.c</span><br><s=
pan>         )</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    target_compile_definitions(test_crypto PRIVATE PREFER_OPEN=
SSL_SIPHASH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     target_sources(test_ssl PRIVATE</span><br><span>            =
 tests/unit_tests/openvpn/mock_management.c</span><br><span>             te=
sts/unit_tests/openvpn/mock_ssl_dependencies.c</span><br><span>diff --git a=
/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index ff=
8cc54..08c8250 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><=
br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -128,6 +128,8 @@<=
/span><br><span> 	session_id.c session_id.h \</span><br><span> 	shaper.c sh=
aper.h \</span><br><span> 	sig.c sig.h \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	siphash_reference.c siphash.h \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	siphash_openssl.c \</span><br><span> 	so=
cket.c socket.h \</span><br><span> 	socket_util.c socket_util.h \</span><br=
><span> 	socks.c socks.h \</span><br><span>diff --git a/src/openvpn/siphash=
.h b/src/openvpn/siphash.h</span><br><span>index ef61110..973596b 100644</s=
pan><br><span>--- a/src/openvpn/siphash.h</span><br><span>+++ b/src/openvpn=
/siphash.h</span><br><span>@@ -18,12 +18,55 @@</span><br><span> #ifndef SIP=
HASH_H</span><br><span> #define SIPHASH_H</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#include &lt;inttypes.h&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdint.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio.h&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbo=
ol.h&gt;</span><br><span> </span><br><span> /* siphash always uses 128-bit =
keys */</span><br><span> #define SIPHASH_KEY_SIZE 16</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-int siphash(const void *in=
, size_t inlen, const void *k, uint8_t *out,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            size_t outlen);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Prototypes for an implementation of SIPHA=
SH in a crypto library */</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calc=
ulates SIPHASH using the crypto library function.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+si=
phash_cryptolib(void *sip_context, const void *in, size_t inlen,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                  const void *=
k, uint8_t *out, size_t outlen);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calculates SIPHASH =
using the reference implementation</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_reference=
(const void *in, size_t inlen, const void *k,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                  uint8_t *out, size_t outlen);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param hash_size the size of the output hash size</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return initialised context for sipha=
sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+siphash_cryptolib_init(size_t hash_size);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+siphash_cryptolib_uninit(void *sip_context);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+siphash_cryptolib_available(void *sip_context);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+siphash(void *ctx, const void *in, size_t inlen, const voi=
d *k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_=
t *out, size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (siphash=
_cryptolib_available(ctx) &amp;&amp; false)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return siphash_cryptolib(ctx, in, inlen, k, out, outlen);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return siphash_reference(in, inlen, k, out, outlen=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif /* ifndef SIPHASH_H */</span><br><span>\ No newline at end of=
 file</span><br><span>diff --git a/src/openvpn/siphash_openssl.c b/src/open=
vpn/siphash_openssl.c</span><br><span>new file mode 100644</span><br><span>=
index 0000000..bb42a38</span><br><span>--- /dev/null</span><br><span>+++ b/=
src/openvpn/siphash_openssl.c</span><br><span>@@ -0,0 +1,150 @@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel=
 IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             session authe=
ntication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet encryption, packet authentication, and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet comp=
ression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 =
OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@...1227...&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; y=
ou can redistribute it and/or modify</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  it under the terms of the GNU General Public License v=
ersion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publ=
ished by the Free Software Foundation.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is distributed in the hope that it will be useful,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  You should have received a copy of the GNU General Public License =
along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this =
program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;config.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;config-msvc.h&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;syshead.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;siphash.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;buffer.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_O=
PENSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;=
openssl/opensslv.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* OpenSSL siphash is current=
ly 2-3 times slower than the reference</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * implementation, so only enable it when PREFER_OPENSSL=
_SIPHASH is defined</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * for now */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30=
000000L &amp;&amp; defined(PREFER_OPENSSL_SIPHASH)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;openssl/evp.h&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_openssl.h&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct siphash_context</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    EVP_MAC *mac;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    EVP_MAC_CTX *ctx;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    size_t size;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    OSSL_PARAM params[3];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Computes a SipHash v=
alue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in: pointer =
to input data (read-only)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  inlen: input data length in bytes (any size_t value)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * k: pointer to the key data (r=
ead-only), must be 16 bytes</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * out: pointer to output data (write-only), outlen bytes must be a=
llocated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  outlen:=
 length of the output in bytes, must be 8 or 16</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siph=
ash_cryptolib(void *sip_context, const void *in, const size_t inlen,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                  const vo=
id *k, uint8_t *out, const size_t outlen)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct siphash_context *sip =3D sip_context;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
sip-&gt;params[1] =3D OSSL_PARAM_construct_octet_string(&quot;key&quot;, (v=
oid *)k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                                            SIPHASH_KEY_SIZE);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!EVP_MAC_init(sip-&gt;ct=
x, NULL, 0, sip-&gt;params))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   crypto_msg(M_FATAL, &quot;EVP_MAC_init failed&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    EVP_MAC_update(sip-&gt;ctx, in, inlen);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    size_t outl =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    EVP_MAC_final(sip-&gt;ctx, out, &amp;out=
l, outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+siphash_cryptolib_init(size_t hash_size)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct siphash_context *sip;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ALLOC_OBJ(sip, struct siphash_context);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;mac =3D EVP_MAC_fetch(NULL, &=
quot;SIPHASH&quot;, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!sip-&gt;mac)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* Our OpenSSL library does not support SIPHASH */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return sip;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sip-&gt;ctx =3D EVP_MAC_CTX_new(sip-&gt;mac);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* OpenSSL will truly hold a pointer to =
an int in that parameter */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    sip-&gt;size =3D hash_size;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sip-&gt;params[0] =3D OSSL_PARAM_construct_size_t(&=
quot;size&quot;, &amp;sip-&gt;size);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* params[1] will hold the key that changes which each=
 invocation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ip-&gt;params[2] =3D OSSL_PARAM_construct_end();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return sip;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_available=
(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash=
_context *sip =3D sip_context;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn (bool)(sip-&gt;mac);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+siphash_cryptolib_uninit(void *sip_context)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context *sip =3D sip_c=
ontext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_=
CTX_free(sip-&gt;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    EVP_MAC_free(sip-&gt;mac);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    free(sip_context);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* for now, we only have one imple=
mentation of SIPHASH in a libray, so put the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * dummy functions also here */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+siphash_cryptolib(void *sip_context, const void *in, c=
onst size_t inlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                 const void *k, uint8_t *out, const size_t outlen)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return -1;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_available(=
void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+siphash_cryptolib_init(size_t hash_size)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+siphash_cryptolib_uninit(void *sip_context)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(E=
NABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L=
 */</span><br><span>diff --git a/src/openvpn/siphash_reference.c b/src/open=
vpn/siphash_reference.c</span><br><span>index b21a86e..a06599f 100644</span=
><br><span>--- a/src/openvpn/siphash_reference.c</span><br><span>+++ b/src/=
openvpn/siphash_reference.c</span><br><span>@@ -100,8 +100,8 @@</span><br><=
span>  *  outlen: length of the output in bytes, must be 8 or 16</span><br>=
<span>  */</span><br><span> int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-siphash(const void *in, const size_t inlen, const void *k, uint8_=
t *out,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const =
size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sipha=
sh_reference(const void *in, const size_t inlen, const void *k,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                  uint8_t *out,=
 const size_t outlen)</span><br><span> {</span><br><span>     const unsigne=
d char *ni =3D (const unsigned char *)in;</span><br><span>     const unsign=
ed char *kk =3D (const unsigned char *)k;</span><br><span>diff --git a/test=
s/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</sp=
an><br><span>index 1128eb4..4ed113a 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/M=
akefile.am</span><br><span>@@ -84,7 +84,9 @@</span><br><span> 	$(top_srcdir=
)/src/openvpn/platform.c \</span><br><span> 	$(top_srcdir)/src/openvpn/mtu.=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/mss.c</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/mss.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top=
_srcdir)/src/openvpn/siphash_openssl.c \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference.c</span><=
br><span> </span><br><span> dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src=
/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</span><b=
r><span> dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/ope=
nvpn</span><br><span>@@ -97,6 +99,7 @@</span><br><span> </span><br><span> s=
sl_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(t=
op_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-DPREFER_OPENSSL_SIPHASH \</span><br><sp=
an> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAG=
S@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D tes=
t_ssl.c \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto=
.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>index cb4eaa2..=
f943a8e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c=
</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br><sp=
an>@@ -31,12 +31,14 @@</span><br><span> #include &lt;stdarg.h&gt;</span><br=
><span> #include &lt;string.h&gt;</span><br><span> #include &lt;setjmp.h&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;intty=
pes.h&gt;</span><br><span> #include &lt;cmocka.h&gt;</span><br><span> </spa=
n><br><span> #include &quot;crypto.h&quot;</span><br><span> #include &quot;=
crypto_epoch.h&quot;</span><br><span> #include &quot;options.h&quot;</span>=
<br><span> #include &quot;ssl_backend.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;siphash.h&quot;</span><br><span> <=
/span><br><span> #include &quot;mss.h&quot;</span><br><span> #include &quot=
;test_common.h&quot;</span><br><span>@@ -923,6 +925,59 @@</span><br><span> =
    assert_memory_equal(key_parameters.hmac, exp_impl_iv, sizeof(exp_impl_i=
v));</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Use a define here since some c compilers don&#39;t=
 like array initialisation</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * with an integer */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define UT_SIPHASH_HASH_SIZE 16</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_s=
iphash(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *m=
essage =3D &quot;Look behind you, a Three-Headed Monkey!&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t key=
[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    siphash_reference(message, strlen(message), key=
, out, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0=
x6d, 0x5c, 0x4e, 0xfa,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                                         0x20, 0x47, 0x6=
5, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_memory_equal(out, expected_out, UT_SIPHASH_HASH_S=
IZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_siphash_openssl(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    void *sipctx =3D siphash_cryptolib_init(UT_SIPHASH_HASH_SI=
ZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!siphash_cryptolib_availab=
le(sipctx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        siphash_crypto=
lib_uninit(sipctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        skip();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *message =3D &quot;Loo=
k behind you, a Three-Headed Monkey!&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint8_t key[SIPHASH_KEY_SIZE] =
=3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint=
8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, =
0x5c, 0x4e, 0xfa,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                                       0x20, 0x47, 0x65, 0x=
7e, 0xdd, 0xcd, 0x62, 0x51 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_cryptolib(sipctx=
, message, strlen(message), key, out,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                      UT_SIPHASH_HASH_SIZE);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(out, out=
, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check t=
hat calling the function twice is safe */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    siphash_cryptolib(sipctx, message, strlen(message=
), key, out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
               UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_memory_equal(out, expected_out, UT_SIPHASH_HAS=
H_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    siphash_cryptolib_uninit(s=
ipctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)=
</span><br><span> {</span><br><span>@@ -957,10 +1012,9 @@</span><br><span> =
        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_over=
flow,</span><br><span>                                                  cry=
pto_test_epoch_setup,</span><br><span>                                     =
             crypto_test_epoch_teardown, &amp;prestate_num32),</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test_prestate_=
setup_teardown(crypto_test_epoch_edge,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                                 crypto_te=
st_epoch_setup,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                           crypto_test_epoch_teardown, &amp=
;prestate_num13),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    cmocka_unit_test(epoch_test_derive_data_key)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(epoch_test_derive_dat=
a_key),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_siphash),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_siphash_openssl)</span><br><span>    =
 };</span><br><span> </span><br><span>     return cmocka_run_group_tests_na=
me(&quot;crypto tests&quot;, tests, NULL, NULL);</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
1?usp=3Demail">change 31</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/31?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26=
d54a1c1bf7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 31 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--XvPOg6IgqCo=--

