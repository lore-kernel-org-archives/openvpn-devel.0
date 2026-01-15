From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 Jan 2026 09:23:22 +0000
In-Reply-To: <gerrit.1767876064000.I5c06dc13e9d8ab73997f79b13c30ee8949e5e993@...2715...>
References: <gerrit.1767876064000.I5c06dc13e9d8ab73997f79b13c30ee8949e5e993@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cf0fe707ce6589fa18d43c3da741343d4f831e42-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="z8eW9mYJD8E="; charset=UTF-8
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

--z8eW9mYJD8E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1461?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1461/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I5c06dc13e9d8ab73997f79b13c30ee8949e5e993
Gerrit-Change-Number: 1461
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: plaisthos <arne-openvpn@...1227...>

--z8eW9mYJD8E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1461?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Ensure that all unit tests use unbu=
ffered stdout and stderr<br><br>stderr is normally always unbuffered but st=
dout can be buffered. Especially,<br>when stdout is redirected it will beco=
me buffered while it is normally<br>unbuffered when connected to a terminal=
. This mean that if the unit exits<br>prematurely, the output in the buffer=
ed output will be lost.<br><br>As the unit test x_msg mock implementation p=
rints even fatal on stdout<br>we ensure with this setup method that stdout =
is also unbuffered.<br><br>Change-Id: I5c06dc13e9d8ab73997f79b13c30ee8949e5=
e993<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg28122.html<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerri=
t URL: https://gerrit.openvpn.net/c/openvpn/+/1461<br>(cherry picked from c=
ommit 7869617a0f85089fb5e6fbe2db6f03542a8f33f4)<br>Message-Id: &lt;20260115=
082807.18596-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/ope=
nvpn-devel@lists.sourceforge.net/msg35272.html<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_argv.c=
<br>M tests/unit_tests/openvpn/test_auth_token.c<br>M tests/unit_tests/open=
vpn/test_buffer.c<br>A tests/unit_tests/openvpn/test_common.h<br>M tests/un=
it_tests/openvpn/test_crypto.c<br>M tests/unit_tests/openvpn/test_cryptoapi=
.c<br>M tests/unit_tests/openvpn/test_misc.c<br>M tests/unit_tests/openvpn/=
test_ncp.c<br>M tests/unit_tests/openvpn/test_packet_id.c<br>M tests/unit_t=
ests/openvpn/test_pkt.c<br>M tests/unit_tests/openvpn/test_provider.c<br>M =
tests/unit_tests/openvpn/test_tls_crypt.c<br>12 files changed, 63 insertion=
s(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/61/1461/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit=
_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c</span><br=
><span>index 1b18ac0..33b3dec 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_argv.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ar=
gv.c</span><br><span>@@ -12,6 +12,7 @@</span><br><span> </span><br><span> #=
include &quot;argv.h&quot;</span><br><span> #include &quot;buffer.h&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_c=
ommon.h&quot;</span><br><span> </span><br><span> /* Defines for use in the =
tests and the mock parse_line() */</span><br><span> #define PATH1       &qu=
ot;/s p a c e&quot;</span><br><span>@@ -252,6 +253,7 @@</span><br><span> in=
t</span><br><span> main(void)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span=
>     const struct CMUnitTest tests[] =3D {</span><br><span>         cmocka=
_unit_test(argv_printf__multiple_spaces_in_format__parsed_as_one),</span><b=
r><span>         cmocka_unit_test(argv_printf_cat__multiple_spaces_in_forma=
t__parsed_as_one),</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c</span><br><spa=
n>index a027330..3a3cb69 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_auth_token.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_a=
uth_token.c</span><br><span>@@ -35,6 +35,7 @@</span><br><span> #include &lt=
;cmocka.h&gt;</span><br><span> </span><br><span> #include &quot;auth_token.=
c&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;test_common.h&quot;</span><br><span> </span><br><span> struct test_conte=
xt {</span><br><span>     struct tls_multi multi;</span><br><span>@@ -407,6=
 +408,7 @@</span><br><span> int</span><br><span> main(void)</span><br><span=
> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit=
_test_setup();</span><br><span>     const struct CMUnitTest tests[] =3D {</=
span><br><span>         cmocka_unit_test_setup_teardown(auth_token_basic_te=
st, setup, teardown),</span><br><span>         cmocka_unit_test_setup_teard=
own(auth_token_fail_invalid_key, setup, teardown),</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test=
_buffer.c</span><br><span>index df1fdcb..c30ba42 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_buffer.c</span><br><span>@@ -32,6 +32,7 @@</span><br><sp=
an> </span><br><span> #include &quot;buffer.h&quot;</span><br><span> #inclu=
de &quot;buffer.c&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;test_common.h&quot;</span><br><span> </span><br><span> s=
tatic void</span><br><span> test_buffer_strprefix(void **state)</span><br><=
span>@@ -369,6 +370,7 @@</span><br><span> int</span><br><span> main(void)</=
span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  openvpn_unit_test_setup();</span><br><span>     const struct CMUnitTest t=
ests[] =3D {</span><br><span>         cmocka_unit_test(test_buffer_strprefi=
x),</span><br><span>         cmocka_unit_test_setup_teardown(test_buffer_li=
st_aggregate_separator_empty,</span><br><span>diff --git a/tests/unit_tests=
/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h</span><br><=
span>new file mode 100644</span><br><span>index 0000000..50e16d6</span><br>=
<span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_com=
mon.h</span><br><span>@@ -0,0 +1,40 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP=
 port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             session authentication and key exchange,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet=
 encryption, packet authentication, and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet compression.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...220...=
..2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fre=
e software; you can redistribute it and/or modify</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pub=
lic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  as published by the Free Software Foundation.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  GNU General Public License for more details.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  You should have received a copy of the GNU General =
Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  with this program; if not, write to the Free Software Foundation, Inc.=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin St=
reet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;stdio.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;setjmp.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;cmocka.h&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets up the environment =
for unit tests like making both stderr and stdout</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * non-buffered to avoid messages getting los=
t if the program exits early.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This=
 has a openvpn prefix to avoid confusion with cmocka&#39;s unit_test_setup_=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * methods</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+openvpn_unit_test_setup()</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(set=
vbuf(stderr, NULL, _IONBF, BUFSIZ), 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>ind=
ex 4b1627a..ff639678 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c<=
/span><br><span>@@ -39,6 +39,7 @@</span><br><span> #include &quot;ssl_backe=
nd.h&quot;</span><br><span> </span><br><span> #include &quot;mss.h&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_co=
mmon.h&quot;</span><br><span> </span><br><span> static const char testtext[=
] =3D &quot;Dummy text to test PEM encoding&quot;;</span><br><span> </span>=
<br><span>@@ -479,6 +480,7 @@</span><br><span> int</span><br><span> main(vo=
id)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    openvpn_unit_test_setup();</span><br><span>     const struct CMUnitT=
est tests[] =3D {</span><br><span>         cmocka_unit_test(crypto_pem_enco=
de_decode_loopback),</span><br><span>         cmocka_unit_test(crypto_trans=
late_cipher_names),</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span=
>index 18e38d0..e5f6557 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_cryptoapi.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_cry=
ptoapi.c</span><br><span>@@ -40,6 +40,7 @@</span><br><span> #include &lt;op=
enssl/core_names.h&gt;</span><br><span> #include &lt;openssl/evp.h&gt;</spa=
n><br><span> #include &lt;openssl/pkcs12.h&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><sp=
an> </span><br><span> #include &lt;cryptoapi.h&gt;</span><br><span> #includ=
e &lt;cryptoapi.c&gt; /* pull-in the whole file to test static functions */=
</span><br><span>@@ -582,6 +583,7 @@</span><br><span> int</span><br><span> =
main(void)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    openvpn_unit_test_setup();</span><br><span>     const struct =
CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_test(test_par=
se_hexstring),</span><br><span>         cmocka_unit_test(import_certs),</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit=
_tests/openvpn/test_misc.c</span><br><span>index eac3466..68ca9b6 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_misc.c</span><br><span>@@ -36,6 +36,7 @@<=
/span><br><span> </span><br><span> #include &quot;ssl_util.h&quot;</span><b=
r><span> #include &quot;options_util.h&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><span=
> </span><br><span> static void</span><br><span> test_compat_lzo_string(voi=
d **state)</span><br><span>@@ -117,5 +118,6 @@</span><br><span> int</span><=
br><span> main(void)</span><br><span> {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span>     ret=
urn cmocka_run_group_tests(misc_tests, NULL, NULL);</span><br><span> }</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_t=
ests/openvpn/test_ncp.c</span><br><span>index 9e26c74..a8e1021 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_ncp.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_ncp.c</span><br><span>@@ -35,6 +35,7 @@</span=
><br><span> #include &lt;cmocka.h&gt;</span><br><span> </span><br><span> #i=
nclude &quot;ssl_ncp.c&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;test_common.h&quot;</span><br><span> </span><br><sp=
an> /* Defines for use in the tests and the mock parse_line() */</span><br>=
<span> </span><br><span>@@ -272,6 +273,7 @@</span><br><span> int</span><br>=
<span> main(void)</span><br><span> {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span> #if define=
d(ENABLE_CRYPTO_OPENSSL)</span><br><span>     OpenSSL_add_all_algorithms();=
</span><br><span> #endif</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c</span><br>=
<span>index 2a2a973..ff3f788 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_packet_id.c</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_packet_id.c</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br=
><span> #include &quot;packet_id.h&quot;</span><br><span> #include &quot;re=
liable.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;test_common.h&quot;</span><br><span> </span><br><span> struct tes=
t_packet_id_write_data {</span><br><span>     struct {</span><br><span>@@ -=
273,6 +274,7 @@</span><br><span> int</span><br><span> main(void)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn=
_unit_test_setup();</span><br><span>     const struct CMUnitTest tests[] =
=3D {</span><br><span>         cmocka_unit_test_setup_teardown(test_packet_=
id_write_short,</span><br><span>                                         te=
st_packet_id_write_setup,</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>index=
 62abafa..3a68c56 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><br=
><span>@@ -33,6 +33,7 @@</span><br><span> #include &lt;string.h&gt;</span><=
br><span> #include &lt;setjmp.h&gt;</span><br><span> #include &lt;cmocka.h&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;t=
est_common.h&quot;</span><br><span> </span><br><span> #include &quot;crypto=
.h&quot;</span><br><span> #include &quot;options.h&quot;</span><br><span>@@=
 -778,6 +779,7 @@</span><br><span> int</span><br><span> main(void)</span><b=
r><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openv=
pn_unit_test_setup();</span><br><span>     const struct CMUnitTest tests[] =
=3D {</span><br><span>         cmocka_unit_test(test_verify_hmac_none),</sp=
an><br><span>         cmocka_unit_test(test_tls_decrypt_lite_none),</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit=
_tests/openvpn/test_provider.c</span><br><span>index 8a0b816..934b2d3b 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_provider.c</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_provider.c</span><br><span>@@ -4=
0,6 +40,8 @@</span><br><span> #include &lt;openssl/core_names.h&gt;</span><=
br><span> #include &lt;openssl/evp.h&gt;</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> str=
uct management *management; /* global */</span><br><span> static int mgmt_c=
allback_called;</span><br><span> </span><br><span>@@ -119,6 +121,7 @@</span=
><br><span> static void</span><br><span> init_test()</span><br><span> {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_s=
etup();</span><br><span>     prov[0] =3D OSSL_PROVIDER_load(NULL, &quot;def=
ault&quot;);</span><br><span>     OSSL_PROVIDER_add_builtin(NULL, prov_name=
, xkey_provider_init);</span><br><span>     prov[1] =3D OSSL_PROVIDER_load(=
NULL, prov_name);</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>i=
ndex 3eac04c..5eb864e 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_tls_crypt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_c=
rypt.c</span><br><span>@@ -34,6 +34,7 @@</span><br><span> #include &lt;setj=
mp.h&gt;</span><br><span> #include &lt;cmocka.h&gt;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_commo=
n.h&quot;</span><br><span> #include &quot;tls_crypt.c&quot;</span><br><span=
> </span><br><span> /* Define this function here as dummy since including t=
he ssl_*.c files</span><br><span>@@ -673,6 +674,7 @@</span><br><span> int</=
span><br><span> main(void)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span>  =
   const struct CMUnitTest tests[] =3D {</span><br><span>         cmocka_un=
it_test_setup_teardown(tls_crypt_loopback,</span><br><span>                =
                         test_tls_crypt_setup,</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/146=
1?usp=3Demail">change 1461</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1461?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--z8eW9mYJD8E=--

