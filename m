From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 22 Jan 2024 13:07:38 +0000
In-Reply-To: <gerrit.1705927509000.I5c06dc13e9d8ab73997f79b13c30ee8949e5e993@...2715...>
References: <gerrit.1705927509000.I5c06dc13e9d8ab73997f79b13c30ee8949e5e993@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <566acce01df4b38747c99ce40971df0129e562ed-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eyHgjpKJSYs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Ensure that all unit
 tests use unbuffered stdout and stderr
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

--eyHgjpKJSYs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/504?usp=3Demail

to look at the new patch set (#3).


Change subject: Ensure that all unit tests use unbuffered stdout and stderr
......................................................................

Ensure that all unit tests use unbuffered stdout and stderr

stderr is normally always unbuffered but stdout can be buffered. Especially,
when stdout is redirected it will become buffered while it is normally
unbuffered when connected to a terminal. This mean that if the unit exits
prematurely, the output in the buffered output will be lost.

As the unit test x_msg mock implementation prints even fatal on stdout
we ensure with this setup method that stdout is also unbuffered.

Change-Id: I5c06dc13e9d8ab73997f79b13c30ee8949e5e993
---
M tests/unit_tests/openvpn/test_argv.c
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_buffer.c
A tests/unit_tests/openvpn/test_common.h
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_misc.c
M tests/unit_tests/openvpn/test_ncp.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_pkcs11.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/openvpn/test_tls_crypt.c
14 files changed, 69 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/504/3

diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvp=
n/test_argv.c
index 1b18ac0..33b3dec 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -12,6 +12,7 @@

 #include "argv.h"
 #include "buffer.h"
+#include "test_common.h"

 /* Defines for use in the tests and the mock parse_line() */
 #define PATH1       "/s p a c e"
@@ -252,6 +253,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(argv_printf__multiple_spaces_in_format__parsed_as=
_one),
         cmocka_unit_test(argv_printf_cat__multiple_spaces_in_format__parse=
d_as_one),
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index a027330..3a3cb69 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -35,6 +35,7 @@
 #include <cmocka.h>
=20
 #include "auth_token.c"
+#include "test_common.h"

 struct test_context {
     struct tls_multi multi;
@@ -407,6 +408,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test_setup_teardown(auth_token_basic_test, setup, tear=
down),
         cmocka_unit_test_setup_teardown(auth_token_fail_invalid_key, setup=
, teardown),
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index ee84c1f..52ffb54 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -32,6 +32,7 @@

 #include "buffer.h"
 #include "buffer.c"
+#include "test_common.h"

 static void
 test_buffer_strprefix(void **state)
@@ -356,6 +357,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_buffer_strprefix),
         cmocka_unit_test(test_buffer_printf_catrunc),
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/open=
vpn/test_common.h
new file mode 100644
index 0000000..ee211bd
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -0,0 +1,40 @@
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stdio.h>
+#include <cmocka.h>
+#include <setjmp.h>
+
+/**
+ * Sets up the environment for unit tests like making both stderr and stdo=
ut
+ * non-buffered to avoid messages getting lost if the program exits early.
+ *
+ * This has a openvpn prefix to avoid confusion with cmocka's unit_test_se=
tup_*
+ * methods
+ */
+void
+openvpn_unit_test_setup()
+{
+    assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);
+    assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);
+}
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 08c9c44..01c16c9 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -39,6 +39,7 @@
 #include "ssl_backend.h"

 #include "mss.h"
+#include "test_common.h"

 static const char testtext[] =3D "Dummy text to test PEM encoding";

@@ -445,6 +446,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(crypto_pem_encode_decode_loopback),
         cmocka_unit_test(crypto_translate_cipher_names),
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index d90bfc3..e0479a8 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -40,6 +40,7 @@
 #include <openssl/core_names.h>
 #include <openssl/evp.h>
 #include <openssl/pkcs12.h>
+#include "test_common.h"

 #include <cryptoapi.h>
 #include <cryptoapi.c> /* pull-in the whole file to test static functions =
*/
@@ -486,6 +487,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_parse_hexstring),
         cmocka_unit_test(import_certs),
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 43ae96b..193f131 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -36,6 +36,7 @@

 #include "ssl_util.h"
 #include "options_util.h"
+#include "test_common.h"

 static void
 test_compat_lzo_string(void **state)
@@ -117,5 +118,6 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     return cmocka_run_group_tests(misc_tests, NULL, NULL);
 }
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn=
/test_ncp.c
index 72a1c3b..ecf1e39 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -35,6 +35,7 @@
 #include <cmocka.h>

 #include "ssl_ncp.c"
+#include "test_common.h"

 /* Defines for use in the tests and the mock parse_line() */

@@ -272,6 +273,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
 #if defined(ENABLE_CRYPTO_OPENSSL)
     OpenSSL_add_all_algorithms();
 #endif
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index 2a2a973..ff3f788 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -35,6 +35,7 @@

 #include "packet_id.h"
 #include "reliable.h"
+#include "test_common.h"

 struct test_packet_id_write_data {
     struct {
@@ -273,6 +274,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test_setup_teardown(test_packet_id_write_short,
                                         test_packet_id_write_setup,
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index b6c130e..81cdf88 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -37,11 +37,13 @@

 #include <setjmp.h>
 #include <cmocka.h>
+#include "test_common.h"

 #define token_name "Test Token"
 #define PIN "12345"
 #define HASHSIZE 20

+
 struct management *management; /* global */

 /* replacement for crypto_print_openssl_errors() */
@@ -459,6 +461,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test_setup_teardown(test_pkcs11_ids, setup_pkcs11,
                                         teardown_pkcs11),
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 7f05184..1084d66 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -33,6 +33,7 @@
 #include <string.h>
 #include <setjmp.h>
 #include <cmocka.h>
+#include "test_common.h"

 #include "crypto.h"
 #include "options.h"
@@ -628,6 +629,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_tls_decrypt_lite_none),
         cmocka_unit_test(test_tls_decrypt_lite_auth),
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c
index 335fca2..94deab6 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -40,6 +40,8 @@
 #include <openssl/core_names.h>
 #include <openssl/evp.h>

+#include "test_common.h"
+
 struct management *management; /* global */
 static int mgmt_callback_called;

@@ -119,6 +121,7 @@
 static void
 init_test()
 {
+    openvpn_unit_test_setup();
     prov[0] =3D OSSL_PROVIDER_load(NULL, "default");
     OSSL_PROVIDER_add_builtin(NULL, prov_name, xkey_provider_init);
     prov[1] =3D OSSL_PROVIDER_load(NULL, prov_name);
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index d0c3df7..18b9ec8 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -43,6 +43,7 @@
 #include "mss.h"
 #include "ssl_verify_backend.h"
 #include "win32.h"
+#include "test_common.h"

 /* Mock function to be allowed to include win32.c which is required for
  * getting the temp directory */
@@ -122,6 +123,8 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
+
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(crypto_pem_encode_certificate)
     };
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 465543a..a01fbe5 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -34,6 +34,7 @@
 #include <setjmp.h>
 #include <cmocka.h>

+#include "test_common.h"
 #include "tls_crypt.c"

 /* Define this function here as dummy since including the ssl_*.c files
@@ -673,6 +674,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test_setup_teardown(tls_crypt_loopback,
                                         test_tls_crypt_setup,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/504?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5c06dc13e9d8ab73997f79b13c30ee8949e5e993
Gerrit-Change-Number: 504
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--eyHgjpKJSYs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/504?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Ensure that all unit tests use unbuffered stdout and stderr<br><br>st=
derr is normally always unbuffered but stdout can be buffered. Especially,<=
br>when stdout is redirected it will become buffered while it is normally<b=
r>unbuffered when connected to a terminal. This mean that if the unit exits=
<br>prematurely, the output in the buffered output will be lost.<br><br>As =
the unit test x_msg mock implementation prints even fatal on stdout<br>we e=
nsure with this setup method that stdout is also unbuffered.<br><br>Change-=
Id: I5c06dc13e9d8ab73997f79b13c30ee8949e5e993<br>---<br>M tests/unit_tests/=
openvpn/test_argv.c<br>M tests/unit_tests/openvpn/test_auth_token.c<br>M te=
sts/unit_tests/openvpn/test_buffer.c<br>A tests/unit_tests/openvpn/test_com=
mon.h<br>M tests/unit_tests/openvpn/test_crypto.c<br>M tests/unit_tests/ope=
nvpn/test_cryptoapi.c<br>M tests/unit_tests/openvpn/test_misc.c<br>M tests/=
unit_tests/openvpn/test_ncp.c<br>M tests/unit_tests/openvpn/test_packet_id.=
c<br>M tests/unit_tests/openvpn/test_pkcs11.c<br>M tests/unit_tests/openvpn=
/test_pkt.c<br>M tests/unit_tests/openvpn/test_provider.c<br>M tests/unit_t=
ests/openvpn/test_ssl.c<br>M tests/unit_tests/openvpn/test_tls_crypt.c<br>1=
4 files changed, 69 insertions(+), 0 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/04/504/3</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_arg=
v.c</span><br><span>index 1b18ac0..33b3dec 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_argv.c</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_argv.c</span><br><span>@@ -12,6 +12,7 @@</span><br><span> </span=
><br><span> #include &quot;argv.h&quot;</span><br><span> #include &quot;buf=
fer.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;test_common.h&quot;</span><br><span> </span><br><span> /* Defines fo=
r use in the tests and the mock parse_line() */</span><br><span> #define PA=
TH1       &quot;/s p a c e&quot;</span><br><span>@@ -252,6 +253,7 @@</span>=
<br><span> int</span><br><span> main(void)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</s=
pan><br><span>     const struct CMUnitTest tests[] =3D {</span><br><span>  =
       cmocka_unit_test(argv_printf__multiple_spaces_in_format__parsed_as_o=
ne),</span><br><span>         cmocka_unit_test(argv_printf_cat__multiple_sp=
aces_in_format__parsed_as_one),</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c</=
span><br><span>index a027330..3a3cb69 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/test_auth_token.c</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_auth_token.c</span><br><span>@@ -35,6 +35,7 @@</span><br><span>=
 #include &lt;cmocka.h&gt;</span><br><span> </span><br><span> #include &quo=
t;auth_token.c&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;test_common.h&quot;</span><br><span> </span><br><span> stru=
ct test_context {</span><br><span>     struct tls_multi multi;</span><br><s=
pan>@@ -407,6 +408,7 @@</span><br><span> int</span><br><span> main(void)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 openvpn_unit_test_setup();</span><br><span>     const struct CMUnitTest te=
sts[] =3D {</span><br><span>         cmocka_unit_test_setup_teardown(auth_t=
oken_basic_test, setup, teardown),</span><br><span>         cmocka_unit_tes=
t_setup_teardown(auth_token_fail_invalid_key, setup, teardown),</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests=
/openvpn/test_buffer.c</span><br><span>index ee84c1f..52ffb54 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -32,6 +32,7 @@<=
/span><br><span> </span><br><span> #include &quot;buffer.h&quot;</span><br>=
<span> #include &quot;buffer.c&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><span> </span=
><br><span> static void</span><br><span> test_buffer_strprefix(void **state=
)</span><br><span>@@ -356,6 +357,7 @@</span><br><span> int</span><br><span>=
 main(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    openvpn_unit_test_setup();</span><br><span>     const struct=
 CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_test(test_bu=
ffer_strprefix),</span><br><span>         cmocka_unit_test(test_buffer_prin=
tf_catrunc),</span><br><span>diff --git a/tests/unit_tests/openvpn/test_com=
mon.h b/tests/unit_tests/openvpn/test_common.h</span><br><span>new file mod=
e 100644</span><br><span>index 0000000..ee211bd</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/tests/unit_tests/openvpn/test_common.h</span><br><=
span>@@ -0,0 +1,40 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- =
An application to securely tunnel IP networks</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             over a single UDP port, with suppo=
rt for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             session authentication and key exchange,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pack=
et authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet compression.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is distributed in the hope that it will be useful,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY;=
 without even the implied warranty of</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =
 See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gen=
eral Public License for more details.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this prog=
ram; if not, write to the Free Software Foundation, Inc.,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setj=
mp.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Sets up the environment for unit tests like=
 making both stderr and stdout</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * non-buffered to avoid messages getting lost if the program ex=
its early.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * This has a openvpn pref=
ix to avoid confusion with cmocka&#39;s unit_test_setup_*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * methods</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+op=
envpn_unit_test_setup()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(setvbuf(stderr, NULL, _I=
ONBF, BUFSIZ), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/test=
s/unit_tests/openvpn/test_crypto.c</span><br><span>index 08c9c44..01c16c9 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -39=
,6 +39,7 @@</span><br><span> #include &quot;ssl_backend.h&quot;</span><br><=
span> </span><br><span> #include &quot;mss.h&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br=
><span> </span><br><span> static const char testtext[] =3D &quot;Dummy text=
 to test PEM encoding&quot;;</span><br><span> </span><br><span>@@ -445,6 +4=
46,7 @@</span><br><span> int</span><br><span> main(void)</span><br><span> {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_te=
st_setup();</span><br><span>     const struct CMUnitTest tests[] =3D {</spa=
n><br><span>         cmocka_unit_test(crypto_pem_encode_decode_loopback),</=
span><br><span>         cmocka_unit_test(crypto_translate_cipher_names),</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/test=
s/unit_tests/openvpn/test_cryptoapi.c</span><br><span>index d90bfc3..e0479a=
8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_cryptoapi.c</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><sp=
an>@@ -40,6 +40,7 @@</span><br><span> #include &lt;openssl/core_names.h&gt;=
</span><br><span> #include &lt;openssl/evp.h&gt;</span><br><span> #include =
&lt;openssl/pkcs12.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;test_common.h&quot;</span><br><span> </span><br><span> =
#include &lt;cryptoapi.h&gt;</span><br><span> #include &lt;cryptoapi.c&gt; =
/* pull-in the whole file to test static functions */</span><br><span>@@ -4=
86,6 +487,7 @@</span><br><span> int</span><br><span> main(void)</span><br><=
span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_=
unit_test_setup();</span><br><span>     const struct CMUnitTest tests[] =3D=
 {</span><br><span>         cmocka_unit_test(test_parse_hexstring),</span><=
br><span>         cmocka_unit_test(import_certs),</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_mi=
sc.c</span><br><span>index 43ae96b..193f131 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_misc.c</span><br><span>@@ -36,6 +36,7 @@</span><br><span> </spa=
n><br><span> #include &quot;ssl_util.h&quot;</span><br><span> #include &quo=
t;options_util.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;test_common.h&quot;</span><br><span> </span><br><span> st=
atic void</span><br><span> test_compat_lzo_string(void **state)</span><br><=
span>@@ -117,5 +118,6 @@</span><br><span> int</span><br><span> main(void)</=
span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  openvpn_unit_test_setup();</span><br><span>     return cmocka_run_group_t=
ests(misc_tests, NULL, NULL);</span><br><span> }</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.=
c</span><br><span>index 72a1c3b..ecf1e39 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_ncp.c</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_ncp.c</span><br><span>@@ -35,6 +35,7 @@</span><br><span> #include &=
lt;cmocka.h&gt;</span><br><span> </span><br><span> #include &quot;ssl_ncp.c=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;test_common.h&quot;</span><br><span> </span><br><span> /* Defines for use=
 in the tests and the mock parse_line() */</span><br><span> </span><br><spa=
n>@@ -272,6 +273,7 @@</span><br><span> int</span><br><span> main(void)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
penvpn_unit_test_setup();</span><br><span> #if defined(ENABLE_CRYPTO_OPENSS=
L)</span><br><span>     OpenSSL_add_all_algorithms();</span><br><span> #end=
if</span><br><span>diff --git a/tests/unit_tests/openvpn/test_packet_id.c b=
/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>index 2a2a973..f=
f3f788 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_packet_id=
.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_packet_id.c</span><b=
r><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #include &quot=
;packet_id.h&quot;</span><br><span> #include &quot;reliable.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common.=
h&quot;</span><br><span> </span><br><span> struct test_packet_id_write_data=
 {</span><br><span>     struct {</span><br><span>@@ -273,6 +274,7 @@</span>=
<br><span> int</span><br><span> main(void)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</s=
pan><br><span>     const struct CMUnitTest tests[] =3D {</span><br><span>  =
       cmocka_unit_test_setup_teardown(test_packet_id_write_short,</span><b=
r><span>                                         test_packet_id_write_setup=
,</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tes=
ts/unit_tests/openvpn/test_pkcs11.c</span><br><span>index b6c130e..81cdf88 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -3=
7,11 +37,13 @@</span><br><span> </span><br><span> #include &lt;setjmp.h&gt;=
</span><br><span> #include &lt;cmocka.h&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><span>=
 </span><br><span> #define token_name &quot;Test Token&quot;</span><br><spa=
n> #define PIN &quot;12345&quot;</span><br><span> #define HASHSIZE 20</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> struct management *management; /* global */</span><br><span> </s=
pan><br><span> /* replacement for crypto_print_openssl_errors() */</span><b=
r><span>@@ -459,6 +461,7 @@</span><br><span> int</span><br><span> main(void=
)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    openvpn_unit_test_setup();</span><br><span>     const struct CMUnitTes=
t tests[] =3D {</span><br><span>         cmocka_unit_test_setup_teardown(te=
st_pkcs11_ids, setup_pkcs11,</span><br><span>                              =
           teardown_pkcs11),</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>in=
dex 7f05184..1084d66 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span>=
<br><span>@@ -33,6 +33,7 @@</span><br><span> #include &lt;string.h&gt;</spa=
n><br><span> #include &lt;setjmp.h&gt;</span><br><span> #include &lt;cmocka=
.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;test_common.h&quot;</span><br><span> </span><br><span> #include &quot;cry=
pto.h&quot;</span><br><span> #include &quot;options.h&quot;</span><br><span=
>@@ -628,6 +629,7 @@</span><br><span> int</span><br><span> main(void)</span=
><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    op=
envpn_unit_test_setup();</span><br><span>     const struct CMUnitTest tests=
[] =3D {</span><br><span>         cmocka_unit_test(test_tls_decrypt_lite_no=
ne),</span><br><span>         cmocka_unit_test(test_tls_decrypt_lite_auth),=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_provider.c b/te=
sts/unit_tests/openvpn/test_provider.c</span><br><span>index 335fca2..94dea=
b6 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_provider.c</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/test_provider.c</span><br><spa=
n>@@ -40,6 +40,8 @@</span><br><span> #include &lt;openssl/core_names.h&gt;<=
/span><br><span> #include &lt;openssl/evp.h&gt;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> struct management *management; /* global */</span><br><span> static int=
 mgmt_callback_called;</span><br><span> </span><br><span>@@ -119,6 +121,7 @=
@</span><br><span> static void</span><br><span> init_test()</span><br><span=
> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit=
_test_setup();</span><br><span>     prov[0] =3D OSSL_PROVIDER_load(NULL, &q=
uot;default&quot;);</span><br><span>     OSSL_PROVIDER_add_builtin(NULL, pr=
ov_name, xkey_provider_init);</span><br><span>     prov[1] =3D OSSL_PROVIDE=
R_load(NULL, prov_name);</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>index =
d0c3df7..18b9ec8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test=
_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br>=
<span>@@ -43,6 +43,7 @@</span><br><span> #include &quot;mss.h&quot;</span><=
br><span> #include &quot;ssl_verify_backend.h&quot;</span><br><span> #inclu=
de &quot;win32.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;test_common.h&quot;</span><br><span> </span><br><span> /*=
 Mock function to be allowed to include win32.c which is required for</span=
><br><span>  * getting the temp directory */</span><br><span>@@ -122,6 +123=
,8 @@</span><br><span> int</span><br><span> main(void)</span><br><span> {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test=
_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     const struct CMUnitTest tests[] =3D {</span><br><span>         =
cmocka_unit_test(crypto_pem_encode_certificate)</span><br><span>     };</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests=
/unit_tests/openvpn/test_tls_crypt.c</span><br><span>index 465543a..a01fbe5=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><spa=
n>@@ -34,6 +34,7 @@</span><br><span> #include &lt;setjmp.h&gt;</span><br><s=
pan> #include &lt;cmocka.h&gt;</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><=
span> #include &quot;tls_crypt.c&quot;</span><br><span> </span><br><span> /=
* Define this function here as dummy since including the ssl_*.c files</spa=
n><br><span>@@ -673,6 +674,7 @@</span><br><span> int</span><br><span> main(=
void)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    openvpn_unit_test_setup();</span><br><span>     const struct CMUni=
tTest tests[] =3D {</span><br><span>         cmocka_unit_test_setup_teardow=
n(tls_crypt_loopback,</span><br><span>                                     =
    test_tls_crypt_setup,</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/504?usp=3Demail">change =
504</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/504?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5c06dc13e9d8ab73997f79b13c3=
0ee8949e5e993 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 504 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--eyHgjpKJSYs=--

