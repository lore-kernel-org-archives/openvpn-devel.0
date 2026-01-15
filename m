From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 Jan 2026 09:23:26 +0000
In-Reply-To: <gerrit.1767876064000.I5c06dc13e9d8ab73997f79b13c30ee8949e5e993@...2715...>
References: <gerrit.1767876064000.I5c06dc13e9d8ab73997f79b13c30ee8949e5e993@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cf0fe707ce6589fa18d43c3da741343d4f831e42-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M2m45hvasuQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Ensure that all
 unit tests use unbuffered stdout and stderr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--M2m45hvasuQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
61?usp=3Demail )

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
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
122.html
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1461
(cherry picked from commit 7869617a0f85089fb5e6fbe2db6f03542a8f33f4)
Message-Id: <20260115082807.18596-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
272.html
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
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_tls_crypt.c
12 files changed, 63 insertions(+), 0 deletions(-)




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
index df1fdcb..c30ba42 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -32,6 +32,7 @@

 #include "buffer.h"
 #include "buffer.c"
+#include "test_common.h"

 static void
 test_buffer_strprefix(void **state)
@@ -369,6 +370,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_buffer_strprefix),
         cmocka_unit_test_setup_teardown(test_buffer_list_aggregate_separat=
or_empty,
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
index 4b1627a..ff639678 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -39,6 +39,7 @@
 #include "ssl_backend.h"

 #include "mss.h"
+#include "test_common.h"

 static const char testtext[] =3D "Dummy text to test PEM encoding";

@@ -479,6 +480,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(crypto_pem_encode_decode_loopback),
         cmocka_unit_test(crypto_translate_cipher_names),
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 18e38d0..e5f6557 100644
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
@@ -582,6 +583,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_parse_hexstring),
         cmocka_unit_test(import_certs),
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index eac3466..68ca9b6 100644
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
index 9e26c74..a8e1021 100644
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
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 62abafa..3a68c56 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -33,6 +33,7 @@
 #include <string.h>
 #include <setjmp.h>
 #include <cmocka.h>
+#include "test_common.h"

 #include "crypto.h"
 #include "options.h"
@@ -778,6 +779,7 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_verify_hmac_none),
         cmocka_unit_test(test_tls_decrypt_lite_none),
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c
index 8a0b816..934b2d3b 100644
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
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 3eac04c..5eb864e 100644
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1461?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I5c06dc13e9d8ab73997f79b13c30ee8949e5e993
Gerrit-Change-Number: 1461
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: plaisthos <arne-openvpn@...1227...>

--M2m45hvasuQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1461?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Ensure that all unit tests use unbuffered stdout=
 and stderr<br><br>stderr is normally always unbuffered but stdout can be b=
uffered. Especially,<br>when stdout is redirected it will become buffered w=
hile it is normally<br>unbuffered when connected to a terminal. This mean t=
hat if the unit exits<br>prematurely, the output in the buffered output wil=
l be lost.<br><br>As the unit test x_msg mock implementation prints even fa=
tal on stdout<br>we ensure with this setup method that stdout is also unbuf=
fered.<br><br>Change-Id: I5c06dc13e9d8ab73997f79b13c30ee8949e5e993<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28122.h=
tml<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:=
//gerrit.openvpn.net/c/openvpn/+/1461<br>(cherry picked from commit 7869617=
a0f85089fb5e6fbe2db6f03542a8f33f4)<br>Message-Id: &lt;20260115082807.18596-=
1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg35272.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_argv.c<br>M tests/u=
nit_tests/openvpn/test_auth_token.c<br>M tests/unit_tests/openvpn/test_buff=
er.c<br>A tests/unit_tests/openvpn/test_common.h<br>M tests/unit_tests/open=
vpn/test_crypto.c<br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>M tests=
/unit_tests/openvpn/test_misc.c<br>M tests/unit_tests/openvpn/test_ncp.c<br=
>M tests/unit_tests/openvpn/test_packet_id.c<br>M tests/unit_tests/openvpn/=
test_pkt.c<br>M tests/unit_tests/openvpn/test_provider.c<br>M tests/unit_te=
sts/openvpn/test_tls_crypt.c<br>12 files changed, 63 insertions(+), 0 delet=
ions(-)<br><br></pre>
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
ts/unit_tests/openvpn/test_buffer.c</span><br><span>index df1fdcb..c30ba42 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -3=
2,6 +32,7 @@</span><br><span> </span><br><span> #include &quot;buffer.h&quo=
t;</span><br><span> #include &quot;buffer.c&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br>=
<span> </span><br><span> static void</span><br><span> test_buffer_strprefix=
(void **state)</span><br><span>@@ -369,6 +370,7 @@</span><br><span> int</sp=
an><br><span> main(void)</span><br><span> {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span>    =
 const struct CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit=
_test(test_buffer_strprefix),</span><br><span>         cmocka_unit_test_set=
up_teardown(test_buffer_list_aggregate_separator_empty,</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn=
/test_common.h</span><br><span>new file mode 100644</span><br><span>index 0=
000000..50e16d6</span><br><span>--- /dev/null</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_common.h</span><br><span>@@ -0,0 +1,40 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunne=
l IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         over a single UDP port, with support for SSL/TLS-based</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             session authenti=
cation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet encryption, packet authentication, and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compres=
sion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2016-2021 Fox=
 Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is free software; you can redistribute it and/or modify=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the te=
rms of the GNU General Public License version 2</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundatio=
n.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in=
 the hope that it will be useful,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warran=
ty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTAB=
ILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more d=
etails.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received =
a copy of the GNU General Public License along</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the Free=
 Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;stdio.h&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Sets up the environment for unit tests like making both stderr and stdout=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * non-buffered to =
avoid messages getting lost if the program exits early.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * This has a openvpn prefix to avoid confusion with cmo=
cka&#39;s unit_test_setup_*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * methods</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+openvpn_unit_test_setup()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(setvbuf(stdout, NULL, _=
IONBF, BUFSIZ), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_cryp=
to.c</span><br><span>index 4b1627a..ff639678 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_crypto.c</span><br><span>+++ b/tests/unit_test=
s/openvpn/test_crypto.c</span><br><span>@@ -39,6 +39,7 @@</span><br><span> =
#include &quot;ssl_backend.h&quot;</span><br><span> </span><br><span> #incl=
ude &quot;mss.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;test_common.h&quot;</span><br><span> </span><br><span> sta=
tic const char testtext[] =3D &quot;Dummy text to test PEM encoding&quot;;<=
/span><br><span> </span><br><span>@@ -479,6 +480,7 @@</span><br><span> int<=
/span><br><span> main(void)</span><br><span> {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span> =
    const struct CMUnitTest tests[] =3D {</span><br><span>         cmocka_u=
nit_test(crypto_pem_encode_decode_loopback),</span><br><span>         cmock=
a_unit_test(crypto_translate_cipher_names),</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cry=
ptoapi.c</span><br><span>index 18e38d0..e5f6557 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_cryptoapi.c</span><br><span>@@ -40,6 +40,7 @@</span><b=
r><span> #include &lt;openssl/core_names.h&gt;</span><br><span> #include &l=
t;openssl/evp.h&gt;</span><br><span> #include &lt;openssl/pkcs12.h&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_comm=
on.h&quot;</span><br><span> </span><br><span> #include &lt;cryptoapi.h&gt;<=
/span><br><span> #include &lt;cryptoapi.c&gt; /* pull-in the whole file to =
test static functions */</span><br><span>@@ -582,6 +583,7 @@</span><br><spa=
n> int</span><br><span> main(void)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br>=
<span>     const struct CMUnitTest tests[] =3D {</span><br><span>         c=
mocka_unit_test(test_parse_hexstring),</span><br><span>         cmocka_unit=
_test(import_certs),</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_misc.c b/tests/unit_tests/openvpn/test_misc.c</span><br><span>index ea=
c3466..68ca9b6 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_m=
isc.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc.c</span><br>=
<span>@@ -36,6 +36,7 @@</span><br><span> </span><br><span> #include &quot;s=
sl_util.h&quot;</span><br><span> #include &quot;options_util.h&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=
.h&quot;</span><br><span> </span><br><span> static void</span><br><span> te=
st_compat_lzo_string(void **state)</span><br><span>@@ -117,5 +118,6 @@</spa=
n><br><span> int</span><br><span> main(void)</span><br><span> {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();<=
/span><br><span>     return cmocka_run_group_tests(misc_tests, NULL, NULL);=
</span><br><span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_ncp.c b/tests/unit_tests/openvpn/test_ncp.c</span><br><span>index 9e26c=
74..a8e1021 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ncp.=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ncp.c</span><br><span=
>@@ -35,6 +35,7 @@</span><br><span> #include &lt;cmocka.h&gt;</span><br><sp=
an> </span><br><span> #include &quot;ssl_ncp.c&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span>=
<br><span> </span><br><span> /* Defines for use in the tests and the mock p=
arse_line() */</span><br><span> </span><br><span>@@ -272,6 +273,7 @@</span>=
<br><span> int</span><br><span> main(void)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</s=
pan><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span>     Open=
SSL_add_all_algorithms();</span><br><span> #endif</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/te=
st_packet_id.c</span><br><span>index 2a2a973..ff3f788 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_packet_id.c</span><br><span>@@ -35,6 +35,7 @@</s=
pan><br><span> </span><br><span> #include &quot;packet_id.h&quot;</span><br=
><span> #include &quot;reliable.h&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><span> </s=
pan><br><span> struct test_packet_id_write_data {</span><br><span>     stru=
ct {</span><br><span>@@ -273,6 +274,7 @@</span><br><span> int</span><br><sp=
an> main(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    openvpn_unit_test_setup();</span><br><span>     const str=
uct CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_test_setu=
p_teardown(test_packet_id_write_short,</span><br><span>                    =
                     test_packet_id_write_setup,</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.=
c</span><br><span>index 62abafa..3a68c56 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_pkt.c</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &=
lt;string.h&gt;</span><br><span> #include &lt;setjmp.h&gt;</span><br><span>=
 #include &lt;cmocka.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;test_common.h&quot;</span><br><span> </span><br><span=
> #include &quot;crypto.h&quot;</span><br><span> #include &quot;options.h&q=
uot;</span><br><span>@@ -778,6 +779,7 @@</span><br><span> int</span><br><sp=
an> main(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    openvpn_unit_test_setup();</span><br><span>     const str=
uct CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_test(test=
_verify_hmac_none),</span><br><span>         cmocka_unit_test(test_tls_decr=
ypt_lite_none),</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
provider.c b/tests/unit_tests/openvpn/test_provider.c</span><br><span>index=
 8a0b816..934b2d3b 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_provider.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_provider.=
c</span><br><span>@@ -40,6 +40,8 @@</span><br><span> #include &lt;openssl/c=
ore_names.h&gt;</span><br><span> #include &lt;openssl/evp.h&gt;</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;test_common.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> struct management *management; /* global */</span><br><=
span> static int mgmt_callback_called;</span><br><span> </span><br><span>@@=
 -119,6 +121,7 @@</span><br><span> static void</span><br><span> init_test()=
</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    openvpn_unit_test_setup();</span><br><span>     prov[0] =3D OSSL_PROVID=
ER_load(NULL, &quot;default&quot;);</span><br><span>     OSSL_PROVIDER_add_=
builtin(NULL, prov_name, xkey_provider_init);</span><br><span>     prov[1] =
=3D OSSL_PROVIDER_load(NULL, prov_name);</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_cr=
ypt.c</span><br><span>index 3eac04c..5eb864e 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_tls_crypt.c</span><br><span>@@ -34,6 +34,7 @@</span><br><=
span> #include &lt;setjmp.h&gt;</span><br><span> #include &lt;cmocka.h&gt;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;test_common.h&quot;</span><br><span> #include &quot;tls_crypt.=
c&quot;</span><br><span> </span><br><span> /* Define this function here as =
dummy since including the ssl_*.c files</span><br><span>@@ -673,6 +674,7 @@=
</span><br><span> int</span><br><span> main(void)</span><br><span> {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setu=
p();</span><br><span>     const struct CMUnitTest tests[] =3D {</span><br><=
span>         cmocka_unit_test_setup_teardown(tls_crypt_loopback,</span><br=
><span>                                         test_tls_crypt_setup,</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1461?usp=3Demail">change 1461</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1461?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5c06dc13e9d8ab73997f79b13c3=
0ee8949e5e993 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1461 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: plaisthos &lt;arne-openvpn@...2639...=
..&gt; </div>

</body></html>=

--M2m45hvasuQ=--

