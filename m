From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 23 Jan 2024 18:53:26 +0000
In-Reply-To: <gerrit.1705927509000.I5c06dc13e9d8ab73997f79b13c30ee8949e5e993@...2715...>
References: <gerrit.1705927509000.I5c06dc13e9d8ab73997f79b13c30ee8949e5e993@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <eab6bebeb2a706a96ce17a5ca72aa4eac03330b6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OaY+wYjmGs0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OaY+wYjmGs0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/50=
4?usp=3Demail )

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240123104358.495517-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
122.html
Signed-off-by: Gert Doering <gert@...1296...>
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
index 0000000..50e16d6
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
+#include <setjmp.h>
+#include <cmocka.h>
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
=20
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--OaY+wYjmGs0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/504?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Ensure that all unit tests use unbuffered stdo=
ut and stderr<br><br>stderr is normally always unbuffered but stdout can be=
 buffered. Especially,<br>when stdout is redirected it will become buffered=
 while it is normally<br>unbuffered when connected to a terminal. This mean=
 that if the unit exits<br>prematurely, the output in the buffered output w=
ill be lost.<br><br>As the unit test x_msg mock implementation prints even =
fatal on stdout<br>we ensure with this setup method that stdout is also unb=
uffered.<br><br>Change-Id: I5c06dc13e9d8ab73997f79b13c30ee8949e5e993<br>Ack=
ed-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;202401=
23104358.495517-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com=
/openvpn-devel@lists.sourceforge.net/msg28122.html<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_ar=
gv.c<br>M tests/unit_tests/openvpn/test_auth_token.c<br>M tests/unit_tests/=
openvpn/test_buffer.c<br>A tests/unit_tests/openvpn/test_common.h<br>M test=
s/unit_tests/openvpn/test_crypto.c<br>M tests/unit_tests/openvpn/test_crypt=
oapi.c<br>M tests/unit_tests/openvpn/test_misc.c<br>M tests/unit_tests/open=
vpn/test_ncp.c<br>M tests/unit_tests/openvpn/test_packet_id.c<br>M tests/un=
it_tests/openvpn/test_pkcs11.c<br>M tests/unit_tests/openvpn/test_pkt.c<br>=
M tests/unit_tests/openvpn/test_provider.c<br>M tests/unit_tests/openvpn/te=
st_ssl.c<br>M tests/unit_tests/openvpn/test_tls_crypt.c<br>14 files changed=
, 69 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/ope=
nvpn/test_argv.c</span><br><span>index 1b18ac0..33b3dec 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_argv.c</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_argv.c</span><br><span>@@ -12,6 +12,7 @@</span><br>=
<span> </span><br><span> #include &quot;argv.h&quot;</span><br><span> #incl=
ude &quot;buffer.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;test_common.h&quot;</span><br><span> </span><br><span> =
/* Defines for use in the tests and the mock parse_line() */</span><br><spa=
n> #define PATH1       &quot;/s p a c e&quot;</span><br><span>@@ -252,6 +25=
3,7 @@</span><br><span> int</span><br><span> main(void)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_tes=
t_setup();</span><br><span>     const struct CMUnitTest tests[] =3D {</span=
><br><span>         cmocka_unit_test(argv_printf__multiple_spaces_in_format=
__parsed_as_one),</span><br><span>         cmocka_unit_test(argv_printf_cat=
__multiple_spaces_in_format__parsed_as_one),</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_a=
uth_token.c</span><br><span>index a027330..3a3cb69 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_auth_token.c</span><br><span>@@ -35,6 +35,7 @@</sp=
an><br><span> #include &lt;cmocka.h&gt;</span><br><span> </span><br><span> =
#include &quot;auth_token.c&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;test_common.h&quot;</span><br><span> </span><b=
r><span> struct test_context {</span><br><span>     struct tls_multi multi;=
</span><br><span>@@ -407,6 +408,7 @@</span><br><span> int</span><br><span> =
main(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    openvpn_unit_test_setup();</span><br><span>     const struct =
CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_test_setup_te=
ardown(auth_token_basic_test, setup, teardown),</span><br><span>         cm=
ocka_unit_test_setup_teardown(auth_token_fail_invalid_key, setup, teardown)=
,</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tes=
ts/unit_tests/openvpn/test_buffer.c</span><br><span>index ee84c1f..52ffb54 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -3=
2,6 +32,7 @@</span><br><span> </span><br><span> #include &quot;buffer.h&quo=
t;</span><br><span> #include &quot;buffer.c&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br>=
<span> </span><br><span> static void</span><br><span> test_buffer_strprefix=
(void **state)</span><br><span>@@ -356,6 +357,7 @@</span><br><span> int</sp=
an><br><span> main(void)</span><br><span> {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span>    =
 const struct CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit=
_test(test_buffer_strprefix),</span><br><span>         cmocka_unit_test(tes=
t_buffer_printf_catrunc),</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h</span><br><span=
>new file mode 100644</span><br><span>index 0000000..50e16d6</span><br><spa=
n>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_common.=
h</span><br><span>@@ -0,0 +1,40 @@</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  OpenVPN -- An application to securely tunnel IP networks</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2541...=
07...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free so=
ftware; you can redistribute it and/or modify</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public =
License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  as published by the Free Software Foundation.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  This program is distributed in the hope that it will be usef=
ul,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT =
ANY WARRANTY; without even the implied warranty of</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICU=
LAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  GNU General Public License for more details.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  w=
ith this program; if not, write to the Free Software Foundation, Inc.,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, =
Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;st=
dio.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;setjmp.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;cmocka.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Sets up the environment for un=
it tests like making both stderr and stdout</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * non-buffered to avoid messages getting lost if t=
he program exits early.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This has a=
 openvpn prefix to avoid confusion with cmocka&#39;s unit_test_setup_*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * methods</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+openvpn_unit_test_setup()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(setvbuf(std=
err, NULL, _IONBF, BUFSIZ), 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cr=
ypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>index 08c9c=
44..01c16c9 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_cryp=
to.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br=
><span>@@ -39,6 +39,7 @@</span><br><span> #include &quot;ssl_backend.h&quot=
;</span><br><span> </span><br><span> #include &quot;mss.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&qu=
ot;</span><br><span> </span><br><span> static const char testtext[] =3D &qu=
ot;Dummy text to test PEM encoding&quot;;</span><br><span> </span><br><span=
>@@ -445,6 +446,7 @@</span><br><span> int</span><br><span> main(void)</span=
><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    op=
envpn_unit_test_setup();</span><br><span>     const struct CMUnitTest tests=
[] =3D {</span><br><span>         cmocka_unit_test(crypto_pem_encode_decode=
_loopback),</span><br><span>         cmocka_unit_test(crypto_translate_ciph=
er_names),</span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypt=
oapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>index d9=
0bfc3..e0479a8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_c=
ryptoapi.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_cryptoapi.c<=
/span><br><span>@@ -40,6 +40,7 @@</span><br><span> #include &lt;openssl/cor=
e_names.h&gt;</span><br><span> #include &lt;openssl/evp.h&gt;</span><br><sp=
an> #include &lt;openssl/pkcs12.h&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><span> </spa=
n><br><span> #include &lt;cryptoapi.h&gt;</span><br><span> #include &lt;cry=
ptoapi.c&gt; /* pull-in the whole file to test static functions */</span><b=
r><span>@@ -486,6 +487,7 @@</span><br><span> int</span><br><span> main(void=
)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    openvpn_unit_test_setup();</span><br><span>     const struct CMUnitTes=
t tests[] =3D {</span><br><span>         cmocka_unit_test(test_parse_hexstr=
ing),</span><br><span>         cmocka_unit_test(import_certs),</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/op=
envpn/test_misc.c</span><br><span>index 43ae96b..193f131 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_misc.c</span><br><span>@@ -36,6 +36,7 @@</span><br=
><span> </span><br><span> #include &quot;ssl_util.h&quot;</span><br><span> =
#include &quot;options_util.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><span> </span>=
<br><span> static void</span><br><span> test_compat_lzo_string(void **state=
)</span><br><span>@@ -117,5 +118,6 @@</span><br><span> int</span><br><span>=
 main(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    openvpn_unit_test_setup();</span><br><span>     return cmock=
a_run_group_tests(misc_tests, NULL, NULL);</span><br><span> }</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/open=
vpn/test_ncp.c</span><br><span>index 72a1c3b..ecf1e39 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_ncp.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_ncp.c</span><br><span>@@ -35,6 +35,7 @@</span><br><spa=
n> #include &lt;cmocka.h&gt;</span><br><span> </span><br><span> #include &q=
uot;ssl_ncp.c&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;test_common.h&quot;</span><br><span> </span><br><span> /* De=
fines for use in the tests and the mock parse_line() */</span><br><span> </=
span><br><span>@@ -272,6 +273,7 @@</span><br><span> int</span><br><span> ma=
in(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    openvpn_unit_test_setup();</span><br><span> #if defined(ENABLE_=
CRYPTO_OPENSSL)</span><br><span>     OpenSSL_add_all_algorithms();</span><b=
r><span> #endif</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>ind=
ex 2a2a973..ff3f788 100644</span><br><span>--- a/tests/unit_tests/openvpn/t=
est_packet_id.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_packet_=
id.c</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #=
include &quot;packet_id.h&quot;</span><br><span> #include &quot;reliable.h&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;test_common.h&quot;</span><br><span> </span><br><span> struct test_packet_=
id_write_data {</span><br><span>     struct {</span><br><span>@@ -273,6 +27=
4,7 @@</span><br><span> int</span><br><span> main(void)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_tes=
t_setup();</span><br><span>     const struct CMUnitTest tests[] =3D {</span=
><br><span>         cmocka_unit_test_setup_teardown(test_packet_id_write_sh=
ort,</span><br><span>                                         test_packet_i=
d_write_setup,</span><br><span>diff --git a/tests/unit_tests/openvpn/test_p=
kcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>index b6c1=
30e..81cdf88 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkc=
s11.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11.c</span><b=
r><span>@@ -37,11 +37,13 @@</span><br><span> </span><br><span> #include &lt=
;setjmp.h&gt;</span><br><span> #include &lt;cmocka.h&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</sp=
an><br><span> </span><br><span> #define token_name &quot;Test Token&quot;</=
span><br><span> #define PIN &quot;12345&quot;</span><br><span> #define HASH=
SIZE 20</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> struct management *management; /* global */</span><=
br><span> </span><br><span> /* replacement for crypto_print_openssl_errors(=
) */</span><br><span>@@ -459,6 +461,7 @@</span><br><span> int</span><br><sp=
an> main(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    openvpn_unit_test_setup();</span><br><span>     const str=
uct CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_test_setu=
p_teardown(test_pkcs11_ids, setup_pkcs11,</span><br><span>                 =
                        teardown_pkcs11),</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span=
><br><span>index 7f05184..1084d66 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_pkt.c</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &lt;stri=
ng.h&gt;</span><br><span> #include &lt;setjmp.h&gt;</span><br><span> #inclu=
de &lt;cmocka.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;test_common.h&quot;</span><br><span> </span><br><span> #incl=
ude &quot;crypto.h&quot;</span><br><span> #include &quot;options.h&quot;</s=
pan><br><span>@@ -628,6 +629,7 @@</span><br><span> int</span><br><span> mai=
n(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    openvpn_unit_test_setup();</span><br><span>     const struct CMU=
nitTest tests[] =3D {</span><br><span>         cmocka_unit_test(test_tls_de=
crypt_lite_none),</span><br><span>         cmocka_unit_test(test_tls_decryp=
t_lite_auth),</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pr=
ovider.c b/tests/unit_tests/openvpn/test_provider.c</span><br><span>index 3=
35fca2..94deab6 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
provider.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_provider.c</=
span><br><span>@@ -40,6 +40,8 @@</span><br><span> #include &lt;openssl/core=
_names.h&gt;</span><br><span> #include &lt;openssl/evp.h&gt;</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;t=
est_common.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> struct management *management; /* global */</span><br><spa=
n> static int mgmt_callback_called;</span><br><span> </span><br><span>@@ -1=
19,6 +121,7 @@</span><br><span> static void</span><br><span> init_test()</s=
pan><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 openvpn_unit_test_setup();</span><br><span>     prov[0] =3D OSSL_PROVIDER_=
load(NULL, &quot;default&quot;);</span><br><span>     OSSL_PROVIDER_add_bui=
ltin(NULL, prov_name, xkey_provider_init);</span><br><span>     prov[1] =3D=
 OSSL_PROVIDER_load(NULL, prov_name);</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br=
><span>index d0c3df7..18b9ec8 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=
.c</span><br><span>@@ -43,6 +43,7 @@</span><br><span> #include &quot;mss.h&=
quot;</span><br><span> #include &quot;ssl_verify_backend.h&quot;</span><br>=
<span> #include &quot;win32.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><span> </span>=
<br><span> /* Mock function to be allowed to include win32.c which is requi=
red for</span><br><span>  * getting the temp directory */</span><br><span>@=
@ -122,6 +123,8 @@</span><br><span> int</span><br><span> main(void)</span><=
br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    open=
vpn_unit_test_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     const struct CMUnitTest tests[] =3D {</span><br><s=
pan>         cmocka_unit_test(crypto_pem_encode_certificate)</span><br><spa=
n>     };</span><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_cr=
ypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>index 465=
543a..a01fbe5 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_tl=
s_crypt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</=
span><br><span>@@ -34,6 +34,7 @@</span><br><span> #include &lt;setjmp.h&gt;=
</span><br><span> #include &lt;cmocka.h&gt;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot=
;</span><br><span> #include &quot;tls_crypt.c&quot;</span><br><span> </span=
><br><span> /* Define this function here as dummy since including the ssl_*=
.c files</span><br><span>@@ -673,6 +674,7 @@</span><br><span> int</span><br=
><span> main(void)</span><br><span> {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span>     const=
 struct CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_test_=
setup_teardown(tls_crypt_loopback,</span><br><span>                        =
                 test_tls_crypt_setup,</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/504?usp=3De=
mail">change 504</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/504?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5c06dc13e9d8ab73997f79b13c3=
0ee8949e5e993 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 504 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--OaY+wYjmGs0=--

