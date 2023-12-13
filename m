From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 13 Dec 2023 14:06:59 +0000
In-Reply-To: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
References: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7ef31d31eb8355381d31326479793383b37fa16a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TA23DA8nIow="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add test_ssl unit
 test and test export of PEM to file
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

--TA23DA8nIow=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Add test_ssl unit test and test export of PEM to file
......................................................................

Add test_ssl unit test and test export of PEM to file

This introduces a number of mock function to be able to compile
ssl_verify_*.c and ssl_mbedtls.c/ssl_openssl.c into a unit and adds
quite a number of files to that unit. But it allows similar unit tests
(in term of dependencies) to be added in the future.

Change-Id: Ie248d35d063bb6878f3dd42840c77ba0d6fa3381
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
M CMakeLists.txt
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/mock_management.c
A tests/unit_tests/openvpn/mock_ssl_dependencies.c
A tests/unit_tests/openvpn/test_ssl.c
6 files changed, 311 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/471/3

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 4393f5c..bdb30c8 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -85,7 +85,7 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
-        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, tls_crypt]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, ssl, tls_crypt]

     runs-on: windows-latest
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6cbee56..6ac453c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -588,6 +588,7 @@
         "test_packet_id"
         "test_pkt"
         "test_provider"
+        "test_ssl"
         )

     if (WIN32)
@@ -697,6 +698,34 @@
         src/openvpn/mss.c
         )

+    target_sources(test_ssl PRIVATE
+            tests/unit_tests/openvpn/mock_management.c
+            tests/unit_tests/openvpn/mock_ssl_dependencies.c
+            tests/unit_tests/openvpn/mock_win32_execve.c
+            src/openvpn/argv.c
+            src/openvpn/base64.c
+            src/openvpn/block_dns.c
+            src/openvpn/crypto.c
+            src/openvpn/crypto_mbedtls.c
+            src/openvpn/crypto_openssl.c
+            src/openvpn/cryptoapi.c
+            src/openvpn/env_set.c
+            src/openvpn/env_set.c
+            src/openvpn/mss.c
+            src/openvpn/mtu.c
+            src/openvpn/options_util.c
+            src/openvpn/otime.c
+            src/openvpn/packet_id.c
+            src/openvpn/run_command.c
+            src/openvpn/ssl_mbedtls.c
+            src/openvpn/ssl_openssl.c
+            src/openvpn/ssl_util.c
+            src/openvpn/ssl_verify_mbedtls.c
+            src/openvpn/ssl_verify_openssl.c
+            src/openvpn/xkey_helper.c
+            src/openvpn/xkey_provider.c
+    )
+
     target_sources(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
         src/openvpn/options_util.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index ef45b11..eb8ccc8 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -7,7 +7,8 @@
 endif

 test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_testd=
river ncp_testdriver misc_testdriver \
-	pkt_testdriver
+	pkt_testdriver ssl_testdriver
+
 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
 test_binaries +=3D tls_crypt_testdriver
@@ -67,6 +68,28 @@
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/mss.c

+ssl_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn
+ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+ssl_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h \
+	mock_management.c mock_ssl_dependencies.c mock_win32_execve.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/mtu.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/mss.c \
+	$(top_srcdir)/src/openvpn/xkey_provider.c \
+	$(top_srcdir)/src/openvpn/xkey_helper.c \
+	$(top_srcdir)/src/openvpn/ssl_util.c \
+	$(top_srcdir)/src/openvpn/base64.c \
+	$(top_srcdir)/src/openvpn/cryptoapi.c
+
+
 packet_id_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn
 packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/=
openvpn/mock_management.c
new file mode 100644
index 0000000..8936c3a
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -0,0 +1,51 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
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
+/* Minimal set of mocked management function/globals to get unit tests to
+ * compile */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "manage.h"
+
+#ifdef ENABLE_MANAGEMENT
+
+struct management *management; /* GLOBAL */
+
+void
+management_auth_failure(struct management *man, const char *type, const ch=
ar *reason)
+{
+    ASSERT(false);
+}
+
+char *
+management_query_pk_sig(struct management *man, const char *b64_data,
+                        const char *algorithm)
+{
+    return NULL;
+}
+#endif
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_=
tests/openvpn/mock_ssl_dependencies.c
new file mode 100644
index 0000000..9231d65
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -0,0 +1,67 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
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
+/* Minimal set of mocked function/globals to get unit tests to
+ * compile that use the ssl_* files */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include <setjmp.h>
+#include <cmocka.h>
+
+
+#include "ssl.h"
+#include "ssl_verify.h"
+
+int
+parse_line(const char *line, char **p, const int n, const char *file,
+           const int line_num, int msglevel, struct gc_arena *gc)
+{
+    /* Dummy function to get the linker happy, should never be called */
+    assert_true(false);
+    return 0;
+}
+
+
+int
+pem_password_callback(char *buf, int size, int rwflag, void *u)
+{
+    return 0;
+}
+
+void
+cert_hash_remember(struct tls_session *session, const int cert_depth,
+                   const struct buffer *cert_hash)
+{
+    assert_false(true);
+}
+
+result_t
+verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int ce=
rt_depth)
+{
+    return FAILURE;
+}
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
new file mode 100644
index 0000000..acaaad5
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -0,0 +1,139 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ * Copyright (C) 2023 OpenVPN Inc <sales@...515...>
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
+#endif
+
+#include "syshead.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "crypto.h"
+#include "options.h"
+#include "ssl_backend.h"
+#include "options_util.h"
+
+#include "mock_msg.h"
+#include "mss.h"
+#include "ssl_verify_backend.h"
+#include "win32.h"
+
+/* Mock function to be allowed to include win32.c which is required for
+ * getting the temp directory */
+#ifdef _WIN32
+struct signal_info siginfo_static; /* GLOBAL */
+
+const char *
+strerror_win32(DWORD errnum, struct gc_arena *gc)
+{
+    ASSERT(false);
+}
+
+void
+throw_signal(const int signum)
+{
+    ASSERT(false);
+}
+#endif
+
+
+const char *unittest_cert =3D "-----BEGIN CERTIFICATE-----\n"
+                            "MIIBuTCCAUCgAwIBAgIUTLtjSBzx53qZRvZ6Ur7D9kgoO=
HkwCgYIKoZIzj0EAwIw\n"
+                            "EzERMA8GA1UEAwwIdW5pdHRlc3QwIBcNMjMxMTIxMDk1N=
DQ3WhgPMjA3ODA4MjQw\n"
+                            "OTU0NDdaMBMxETAPBgNVBAMMCHVuaXR0ZXN0MHYwEAYHK=
oZIzj0CAQYFK4EEACID\n"
+                            "YgAEHYB2hn2xx3f4lClXDtdi36P19pMZA+kI1Dkv/Vn10=
vBZ/j9oa+P99T8duz/e\n"
+                            "QlPeHpesNJO4fX8iEDj6+vMeWejOT7jAQ4MmG5EZjpcBK=
xCfwFooEvzu8bVujUcu\n"
+                            "wTQEo1MwUTAdBgNVHQ4EFgQUPcgBEVXjF5vYfDsInoE3d=
F6UfQswHwYDVR0jBBgw\n"
+                            "FoAUPcgBEVXjF5vYfDsInoE3dF6UfQswDwYDVR0TAQH/B=
AUwAwEB/zAKBggqhkjO\n"
+                            "PQQDAgNnADBkAjBLPAGrQAyinigqiu0RomoV8TVaknVLF=
Sq6H6A8jgvzfsFCUK1O\n"
+                            "dvNZhFPM6idKB+oCME2JLOBANCSV8o7aJzq7SYHKwPyb1=
J4JFlwKe/0Jpv7oh9b1\n"
+                            "IJbuaM9Z/VSKbrIXGg=3D=3D\n"
+                            "-----END CERTIFICATE-----\n";
+
+static const char *
+get_tmp_dir()
+{
+    const char *ret;
+#ifdef _WIN32
+    ret =3D win_get_tempdir();
+#else
+    ret =3D "/tmp";
+#endif
+    assert_non_null(ret);
+    return ret;
+}
+
+static void
+crypto_pem_encode_certificate(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+
+    struct tls_root_ctx ctx =3D { 0 };
+    tls_ctx_client_new(&ctx);
+    tls_ctx_load_cert_file(&ctx, unittest_cert, true);
+
+    openvpn_x509_cert_t *cert =3D NULL;
+
+    /* we do not have methods to fetch certificates from ssl contexts, use
+     * internal TLS library methods for the unit test */
+#ifdef ENABLE_CRYPTO_OPENSSL
+    cert =3D SSL_CTX_get0_certificate(ctx.ctx);
+#elif defined(ENABLE_CRYPTO_MBEDTLS)
+    cert =3D ctx.crt_chain;
+#endif
+
+    const char *tmpfile =3D platform_create_temp_file(get_tmp_dir(), "ut_p=
em", &gc);
+    backend_x509_write_pem(cert, tmpfile);
+
+    struct buffer exported_pem =3D buffer_read_from_file(tmpfile, &gc);
+    assert_string_equal(BSTR(&exported_pem), unittest_cert);
+
+    unlink(tmpfile);
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(crypto_pem_encode_certificate)
+    };
+
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    OpenSSL_add_all_algorithms();
+#endif
+
+    int ret =3D cmocka_run_group_tests_name("crypto tests", tests, NULL, N=
ULL);
+
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    EVP_cleanup();
+#endif
+
+    return ret;
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie248d35d063bb6878f3dd42840c77ba0d6fa3381
Gerrit-Change-Number: 471
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--TA23DA8nIow=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add test_ssl unit test and test export of PEM=
 to file<br><br>This introduces a number of mock function to be able to com=
pile<br>ssl_verify_*.c and ssl_mbedtls.c/ssl_openssl.c into a unit and adds=
<br>quite a number of files to that unit. But it allows similar unit tests<=
br>(in term of dependencies) to be added in the future.<br><br>Change-Id: I=
e248d35d063bb6878f3dd42840c77ba0d6fa3381<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>---<br>M .github/workflows/build.yaml<br>M CMakeLis=
ts.txt<br>M tests/unit_tests/openvpn/Makefile.am<br>A tests/unit_tests/open=
vpn/mock_management.c<br>A tests/unit_tests/openvpn/mock_ssl_dependencies.c=
<br>A tests/unit_tests/openvpn/test_ssl.c<br>6 files changed, 311 insertion=
s(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/71/471/3</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml=
 b/.github/workflows/build.yaml</span><br><span>index 4393f5c..bdb30c8 1006=
44</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b=
/.github/workflows/build.yaml</span><br><span>@@ -85,7 +85,7 @@</span><br><=
span>       fail-fast: false</span><br><span>       matrix:</span><br><span=
>         arch: [x86, x64]</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp,=
 packet_id, pkt, provider, tls_crypt]</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        test: [argv, auth_token, buffer, cryptoapi, crypt=
o, misc, ncp, packet_id, pkt, provider, ssl, tls_crypt]</span><br><span> </=
span><br><span>     runs-on: windows-latest</span><br><span>     name: &quo=
t;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</span=
><br><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>ind=
ex 6cbee56..6ac453c 100644</span><br><span>--- a/CMakeLists.txt</span><br><=
span>+++ b/CMakeLists.txt</span><br><span>@@ -588,6 +588,7 @@</span><br><sp=
an>         &quot;test_packet_id&quot;</span><br><span>         &quot;test_=
pkt&quot;</span><br><span>         &quot;test_provider&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        &quot;test_ssl&quot;</span=
><br><span>         )</span><br><span> </span><br><span>     if (WIN32)</sp=
an><br><span>@@ -697,6 +698,34 @@</span><br><span>         src/openvpn/mss.=
c</span><br><span>         )</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    target_sources(test_ssl PRIVATE</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/ope=
nvpn/mock_management.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            tests/unit_tests/openvpn/mock_ssl_dependencies.c</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/op=
envpn/mock_win32_execve.c</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            src/openvpn/argv.c</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            src/openvpn/base64.c</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            src/openvpn/block_dns.c</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/crypt=
o.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/=
openvpn/crypto_mbedtls.c</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            src/openvpn/crypto_openssl.c</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            src/openvpn/cryptoapi.c</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/env_set.c=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/ope=
nvpn/env_set.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       src/openvpn/mss.c</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            src/openvpn/mtu.c</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            src/openvpn/options_util.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/otime.c</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/packe=
t_id.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
rc/openvpn/run_command.c</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            src/openvpn/ssl_mbedtls.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            src/openvpn/ssl_openssl.c</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/ssl_util.c=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/ope=
nvpn/ssl_verify_mbedtls.c</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            src/openvpn/ssl_verify_openssl.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            src/openvpn/xkey_helper.c</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/xk=
ey_provider.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    )<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  target_sources(test_misc PRIVATE</span><br><span>         tests/unit_test=
s/openvpn/mock_get_random.c</span><br><span>         src/openvpn/options_ut=
il.c</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/te=
sts/unit_tests/openvpn/Makefile.am</span><br><span>index ef45b11..eb8ccc8 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br>=
<span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -7,7 +7=
,8 @@</span><br><span> endif</span><br><span> </span><br><span> test_binari=
es +=3D crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_te=
stdriver misc_testdriver \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	pkt_testdriver</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	pkt_testdriver ssl_testdriver</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><span> if !=
WIN32</span><br><span> test_binaries +=3D tls_crypt_testdriver</span><br><s=
pan>@@ -67,6 +68,28 @@</span><br><span> 	$(top_srcdir)/src/openvpn/win32-ut=
il.c \</span><br><span> 	$(top_srcdir)/src/openvpn/mss.c</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_testdriver_CFLAG=
S  =3D @TEST_CFLAGS@ \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/=
openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_testdriv=
er_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ssl_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_management.c m=
ock_ssl_dependencies.c mock_win32_execve.c \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer.c \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypt=
o.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)=
/src/openvpn/crypto_mbedtls.c \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/otime.c \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/o=
penvpn/packet_id.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/openvpn/platform.c \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/mtu.c \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util.c=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/sr=
c/openvpn/mss.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$=
(top_srcdir)/src/openvpn/xkey_provider.c \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/xkey_helper.c \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ss=
l_util.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_sr=
cdir)/src/openvpn/base64.c \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/cryptoapi.c</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> packet_id_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \=
</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(t=
op_srcdir)/src/openvpn</span><br><span> packet_id_testdriver_LDFLAGS =3D @T=
EST_LDFLAGS@</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_man=
agement.c b/tests/unit_tests/openvpn/mock_management.c</span><br><span>new =
file mode 100644</span><br><span>index 0000000..8936c3a</span><br><span>---=
 /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management.c=
</span><br><span>@@ -0,0 +1,51 @@</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 OpenVPN -- An application to securely tunnel IP networks</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  Copyright (C) 2002-2023 OpenVPN Inc &lt;sales@...515...&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; =
you can redistribute it and/or modify</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  it under the terms of the GNU General Public License =
version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pub=
lished by the Free Software Foundation.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GN=
U General Public License for more details.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  You should have received a copy of the GNU General Public License=
 along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this=
 program; if not, write to the Free Software Foundation, Inc.,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Minimal set of mocke=
d management function/globals to get unit tests to</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * compile */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;config.h&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
syshead.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;manage.h=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+struct management *management; /* GLOBAL */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+management_auth_failure(struct management *man, const ch=
ar *type, const char *reason)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSE=
RT(false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+management_query_pk_sig(struct management *man, const char =
*b64_data,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               const char *algorithm)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/uni=
t_tests/openvpn/mock_ssl_dependencies.c</span><br><span>new file mode 10064=
4</span><br><span>index 0000000..9231d65</span><br><span>--- /dev/null</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c</span><b=
r><span>@@ -0,0 +1,67 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN =
-- An application to securely tunnel IP networks</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             over a single UDP port, with su=
pport for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             session authentication and key exchange,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, p=
acket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             packet compression.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2002-2023 OpenVPN Inc &lt;sales@...515...&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  This program is free software; you can r=
edistribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  it under the terms of the GNU General Public License version 2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by=
 the Free Software Foundation.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is distributed in the hope that it will be useful,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; wit=
hout even the implied warranty of</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General=
 Public License for more details.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 You should have received a copy of the GNU General Public License along</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program;=
 if not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Minimal set of mocked functio=
n/globals to get unit tests to</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * compile that use the ssl_* files */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;syshead.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjm=
p.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt=
;cmocka.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;ssl.h&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_verify.h&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+parse_line(const char *line, char **p, const int n, const=
 char *file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
    const int line_num, int msglevel, struct gc_arena *gc)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Dummy function to get the linker happy, should =
never be called */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(false);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
pem_password_callback(char *buf, int size, int rwflag, void *u)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+cert_hash_remember(struct tls_se=
ssion *session, const int cert_depth,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   const struct buffer *cert_hash)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+re=
sult_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+verify_cert(s=
truct tls_session *session, openvpn_x509_cert_t *cert, int cert_depth)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return FAILURE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><=
span>new file mode 100644</span><br><span>index 0000000..acaaad5</span><br>=
<span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=
.c</span><br><span>@@ -0,0 +1,139 @@</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  OpenVPN -- An application to securely tunnel IP networks</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP p=
ort, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             session authentication and key exchange,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet e=
ncryption, packet authentication, and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             packet compression.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Copyright (C) 2023 OpenVPN Inc &lt;sales@...515...&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; yo=
u can redistribute it and/or modify</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  it under the terms of the GNU General Public License ve=
rsion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publi=
shed by the Free Software Foundation.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  This program is distributed in the hope that it will be useful,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU =
General Public License for more details.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  You should have received a copy of the GNU General Public License a=
long</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this p=
rogram; if not, write to the Free Software Foundation, Inc.,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floo=
r, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;stdio.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg.h&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto.h&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options.h&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
ssl_backend.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;options_util.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;mock_msg.h&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;mss.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;ssl_verify_backend.h&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;win32.h&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Mock function to be allowed to include win32=
.c which is required for</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * getting the temp directory */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct signal_info siginfo_static; /* GLOBAL */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+strerror_win32(DWORD errnum, struct gc_arena *gc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(false);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+throw_signal(const int sign=
um)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(false);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+const char *unittest_cert =3D=
 &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                            &quot;MIIBuTCCAUCgAwIBAg=
IUTLtjSBzx53qZRvZ6Ur7D9kgoOHkwCgYIKoZIzj0EAwIw\n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                            &quot;EzERMA=
8GA1UEAwwIdW5pdHRlc3QwIBcNMjMxMTIxMDk1NDQ3WhgPMjA3ODA4MjQw\n&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
&quot;OTU0NDdaMBMxETAPBgNVBAMMCHVuaXR0ZXN0MHYwEAYHKoZIzj0CAQYFK4EEACID\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            &quot;YgAEHYB2hn2xx3f4lClXDtdi36P19pMZA+kI1Dkv/Vn10vBZ/j9oa+P99=
T8duz/e\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                        &quot;QlPeHpesNJO4fX8iEDj6+vMeWejOT7jAQ4MmG5EZjpcBK=
xCfwFooEvzu8bVujUcu\n&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            &quot;wTQEo1MwUTAdBgNVHQ4EFgQUPcgBEVXjF=
5vYfDsInoE3dF6UfQswHwYDVR0jBBgw\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                            &quot;FoAUPcgBEVXjF5vYfDsIn=
oE3dF6UfQswDwYDVR0TAQH/BAUwAwEB/zAKBggqhkjO\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            &quot;PQQDAgN=
nADBkAjBLPAGrQAyinigqiu0RomoV8TVaknVLFSq6H6A8jgvzfsFCUK1O\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                            &=
quot;dvNZhFPM6idKB+oCME2JLOBANCSV8o7aJzq7SYHKwPyb1J4JFlwKe/0Jpv7oh9b1\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
           &quot;IJbuaM9Z/VSKbrIXGg=3D=3D\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            &quot;-----END CE=
RTIFICATE-----\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const ch=
ar *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_tmp_dir()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *ret;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ret =3D win_get_tempdir();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ret =3D &quot;/tmp&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_non_null(ret);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_pem_encode_=
certificate(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls=
_root_ctx ctx =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    tls_ctx_client_new(&amp;ctx);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    tls_ctx_load_cert_file(&amp;ctx, unittest_cert, true=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    openvpn_x509_cert_t *cert =3D NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* we do not have methods to fe=
tch certificates from ssl contexts, use</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * internal TLS library methods for the unit test *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYP=
TO_OPENSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cert =
=3D SSL_CTX_get0_certificate(ctx.ctx);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#elif defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    cert =3D ctx.crt_chain;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *tmpfile =3D platform_create_temp_file(get_tmp_d=
ir(), &quot;ut_pem&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    backend_x509_write_pem(cert, tmpfile);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer exported_pem =3D buffer_read_from_fil=
e(tmpfile, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(BSTR(&amp;exported_pem), unittest_cert);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    unlink(tmpfile);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(cry=
pto_pem_encode_certificate)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPT=
O_OPENSSL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenS=
SL_add_all_algorithms();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D cmocka_run_=
group_tests_name(&quot;crypto tests&quot;, tests, NULL, NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    EVP_cleanup();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/471?usp=3Demail">change 471</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/471?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie248d35d063bb6878f3dd42840c=
77ba0d6fa3381 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 471 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--TA23DA8nIow=--

