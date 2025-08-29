From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 29 Aug 2025 11:13:39 +0000
In-Reply-To: <gerrit.1756402061000.If546f64a4554b292623bfcfe9ee53bac17dfa803@...2715...>
References: <gerrit.1756402061000.If546f64a4554b292623bfcfe9ee53bac17dfa803@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e2494d112e6f2aa2e234bcfa8a8d2be6364ae106-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ISG3k7a07a8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add new unit test
 module test_socket
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ISG3k7a07a8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1160?usp=3Demail

to look at the new patch set (#2).


Change subject: Add new unit test module test_socket
......................................................................

Add new unit test module test_socket

With a first UT that tests add_in6_addr() (and
print_in6_addr implicitly).

Change-Id: If546f64a4554b292623bfcfe9ee53bac17dfa803
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/mock_management.c
A tests/unit_tests/openvpn/test_socket.c
4 files changed, 158 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1160/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 45044af..6ca08fb 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -653,6 +653,7 @@
         "test_packet_id"
         "test_pkt"
         "test_provider"
+        "test_socket"
         "test_ssl"
         "test_user_pass"
         "test_push_update_msg"
@@ -849,6 +850,15 @@
         src/openvpn/base64.c
         )

+    target_sources(test_socket PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        tests/unit_tests/openvpn/mock_management.c
+        tests/unit_tests/openvpn/mock_win32_execve.c
+        src/openvpn/env_set.c
+        src/openvpn/run_command.c
+        src/openvpn/socket_util.c
+        )
+
     target_sources(test_user_pass PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
         tests/unit_tests/openvpn/mock_win32_execve.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index b24e03c..07d3ee9 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -4,23 +4,17 @@

 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) Unit-Tests'

-test_binaries=3D
+test_binaries =3D crypto_testdriver packet_id_testdriver auth_token_testdr=
iver \
+	ncp_testdriver misc_testdriver pkt_testdriver ssl_testdriver \
+	user_pass_testdriver push_update_msg_testdriver provider_testdriver socke=
t_testdriver

 if HAVE_LD_WRAP_SUPPORT
 test_binaries +=3D argv_testdriver buffer_testdriver
-endif
-
-test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_testd=
river ncp_testdriver misc_testdriver \
-	pkt_testdriver ssl_testdriver user_pass_testdriver push_update_msg_testdr=
iver
-
-if HAVE_LD_WRAP_SUPPORT
 if !WIN32
 test_binaries +=3D tls_crypt_testdriver
 endif
 endif

-test_binaries +=3D provider_testdriver
-
 if WIN32
 test_binaries +=3D cryptoapi_testdriver
 LDADD =3D -lws2_32
@@ -343,4 +337,22 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/push_util.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
-	$(top_srcdir)/src/openvpn/otime.c
\ No newline at end of file
+	$(top_srcdir)/src/openvpn/otime.c
+
+socket_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
+	-DSOURCEDIR=3D\"$(top_srcdir)\" @TEST_CFLAGS@
+
+socket_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+socket_testdriver_SOURCES =3D test_socket.c \
+	mock_msg.c test_common.h  \
+	mock_get_random.c \
+	mock_management.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/env_set.c \
+	$(top_srcdir)/src/openvpn/run_command.c \
+	$(top_srcdir)/src/openvpn/socket_util.c
+
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/=
openvpn/mock_management.c
index b24e4c4..ea470ca 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -46,4 +46,19 @@
 {
     return NULL;
 }
+
+void
+management_set_state(struct management *man, const int state, const char *=
detail,
+                     const in_addr_t *tun_local_ip, const struct in6_addr =
*tun_local_ip6,
+                     const struct openvpn_sockaddr *local_addr,
+                     const struct openvpn_sockaddr *remote_addr)
+{
+}
+
+void
+management_sleep(const int n)
+{
+}
+
+
 #endif
diff --git a/tests/unit_tests/openvpn/test_socket.c b/tests/unit_tests/open=
vpn/test_socket.c
new file mode 100644
index 0000000..a73c53a
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_socket.c
@@ -0,0 +1,111 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021-2025 Arne Schwabe <arne@...1227...>
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
+#include "socket.h"
+#include "win32.h"
+
+/* stubs for some unused functions instead of pulling in too many dependen=
cies */
+struct signal_info siginfo_static; /* GLOBAL */
+
+int
+signal_reset(struct signal_info *si, int signum)
+{
+    assert_true(0);
+    return 0;
+}
+
+#ifdef _WIN32
+struct win32_signal win32_signal; /* GLOBAL */
+
+int
+win32_signal_get(struct win32_signal *ws)
+{
+    assert_true(0);
+    return 0;
+}
+#endif
+
+int
+parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
+           int msglevel, struct gc_arena *gc)
+{
+    assert_true(0);
+    return 0;
+}
+
+static void
+test_add_in6_addr_tc(const char *orig_str, uint32_t add, const char *expec=
t_str)
+{
+    struct in6_addr orig, result, expected;
+    struct gc_arena gc =3D gc_new();
+    assert_int_equal(inet_pton(AF_INET6, orig_str, &orig), 1);
+    assert_int_equal(inet_pton(AF_INET6, expect_str, &expected), 1);
+    result =3D add_in6_addr(orig, add);
+    const char *result_str =3D print_in6_addr(result, 0, &gc);
+    assert_string_equal(result_str, expect_str);
+    assert_memory_equal(&result, &expected, sizeof(struct in6_addr));
+    gc_free(&gc);
+}
+
+static void
+test_add_in6_addr(void **state)
+{
+    /* Note that some of the result strings need to account for
+       print_in6_addr formatting the addresses as IPv4 */
+    test_add_in6_addr_tc("::", 1, "::1");
+    test_add_in6_addr_tc("::ff", 1, "::100");
+    test_add_in6_addr_tc("::ffff", 1, "::0.1.0.0");
+    test_add_in6_addr_tc("ffff::ffff", 1, "ffff::1:0");
+    test_add_in6_addr_tc("::ffff:ffff", 1, "::1:0:0");
+    test_add_in6_addr_tc("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", 1, "::=
");
+    test_add_in6_addr_tc("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", 2, "::=
1");
+
+    test_add_in6_addr_tc("::", UINT32_MAX, "::255.255.255.255");
+    test_add_in6_addr_tc("::1", UINT32_MAX, "::1:0:0");
+    test_add_in6_addr_tc("::ffff", UINT32_MAX, "::1:0:fffe");
+    test_add_in6_addr_tc("ffff::ffff", UINT32_MAX, "ffff::1:0:fffe");
+    test_add_in6_addr_tc("::ffff:ffff", UINT32_MAX, "::1:ffff:fffe");
+    test_add_in6_addr_tc("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", UINT32=
_MAX, "::255.255.255.254");
+}
+
+const struct CMUnitTest socket_tests[] =3D {
+    cmocka_unit_test(test_add_in6_addr)
+};
+
+int
+main(void)
+{
+    return cmocka_run_group_tests(socket_tests, NULL, NULL);
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1160?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If546f64a4554b292623bfcfe9ee53bac17dfa803
Gerrit-Change-Number: 1160
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--ISG3k7a07a8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1160?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add new unit test module test_socket<br><br>With a first UT that =
tests add_in6_addr() (and<br>print_in6_addr implicitly).<br><br>Change-Id: =
If546f64a4554b292623bfcfe9ee53bac17dfa803<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M tests/unit_test=
s/openvpn/Makefile.am<br>M tests/unit_tests/openvpn/mock_management.c<br>A =
tests/unit_tests/openvpn/test_socket.c<br>4 files changed, 158 insertions(+=
), 10 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/60/1160/2</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.t=
xt</span><br><span>index 45044af..6ca08fb 100644</span><br><span>--- a/CMak=
eLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -653,6 +=
653,7 @@</span><br><span>         &quot;test_packet_id&quot;</span><br><spa=
n>         &quot;test_pkt&quot;</span><br><span>         &quot;test_provide=
r&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quo=
t;test_socket&quot;</span><br><span>         &quot;test_ssl&quot;</span><br=
><span>         &quot;test_user_pass&quot;</span><br><span>         &quot;t=
est_push_update_msg&quot;</span><br><span>@@ -849,6 +850,15 @@</span><br><s=
pan>         src/openvpn/base64.c</span><br><span>         )</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_sourc=
es(test_socket PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        tests/unit_tests/openvpn/mock_get_random.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_man=
agement.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        te=
sts/unit_tests/openvpn/mock_win32_execve.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        src/openvpn/env_set.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/run_command.c</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/socket_=
util.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     t=
arget_sources(test_user_pass PRIVATE</span><br><span>         tests/unit_te=
sts/openvpn/mock_get_random.c</span><br><span>         tests/unit_tests/ope=
nvpn/mock_win32_execve.c</span><br><span>diff --git a/tests/unit_tests/open=
vpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>inde=
x b24e03c..07d3ee9 100644</span><br><span>--- a/tests/unit_tests/openvpn/Ma=
kefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span>=
<br><span>@@ -4,23 +4,17 @@</span><br><span> </span><br><span> AM_TESTSUITE=
_SUMMARY_HEADER =3D &#39; for $(PACKAGE_STRING) Unit-Tests&#39;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_binaries=
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_binaries =
=3D crypto_testdriver packet_id_testdriver auth_token_testdriver \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	ncp_testdriver misc_testdri=
ver pkt_testdriver ssl_testdriver \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	user_pass_testdriver push_update_msg_testdriver provider_t=
estdriver socket_testdriver</span><br><span> </span><br><span> if HAVE_LD_W=
RAP_SUPPORT</span><br><span> test_binaries +=3D argv_testdriver buffer_test=
driver</span><br><span style=3D"color: hsl(0, 100%, 40%);">-endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-test_binaries +=3D crypto_testdriver packet_id_testd=
river auth_token_testdriver ncp_testdriver misc_testdriver \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	pkt_testdriver ssl_testdriver user_=
pass_testdriver push_update_msg_testdriver</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
if HAVE_LD_WRAP_SUPPORT</span><br><span> if !WIN32</span><br><span> test_bi=
naries +=3D tls_crypt_testdriver</span><br><span> endif</span><br><span> en=
dif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
test_binaries +=3D provider_testdriver</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> if WIN32</span><br><span> test_binaries =
+=3D cryptoapi_testdriver</span><br><span> LDADD =3D -lws2_32</span><br><sp=
an>@@ -343,4 +337,22 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platfor=
m.c \</span><br><span> 	$(top_srcdir)/src/openvpn/push_util.c \</span><br><=
span> 	$(top_srcdir)/src/openvpn/options_util.c \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/otime.c</span><br><s=
pan>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/otime.c</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+socket_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$=
(top_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	-DSOURCEDIR=3D\&quot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+socket_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+socket_testdriver_SOURCES =3D test_socket.c =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_c=
ommon.h  \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get=
_random.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_ma=
nagement.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/openvpn/buffer.c \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform.c \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/env_set.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$=
(top_srcdir)/src/openvpn/run_command.c \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/socket_util.c</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_man=
agement.c</span><br><span>index b24e4c4..ea470ca 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/mock_management.c</span><br><span>+++ b/tests/u=
nit_tests/openvpn/mock_management.c</span><br><span>@@ -46,4 +46,19 @@</spa=
n><br><span> {</span><br><span>     return NULL;</span><br><span> }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+management_set_state(struct management *man, const int state,=
 const char *detail,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                     const in_addr_t *tun_local_ip, const struct in6_addr =
*tun_local_ip6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 const struct openvpn_sockaddr *local_addr,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     const struct o=
penvpn_sockaddr *remote_addr)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+management_sleep(const int n)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_socket.c b/tests/unit=
_tests/openvpn/test_socket.c</span><br><span>new file mode 100644</span><br=
><span>index 0000000..a73c53a</span><br><span>--- /dev/null</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_socket.c</span><br><span>@@ -0,0 +1,11=
1 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to=
 securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             over a single UDP port, with support for SSL/TLS-ba=
sed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             s=
ession authentication and key exchange,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet encryption, packet authentication=
, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C=
) 2021-2025 Arne Schwabe &lt;arne@...1227...&gt;</span><br><span style=3D"c=
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
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www.gnu.org/licenses/&gt;.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;stdio.h&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg.h&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket.h&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;win32.h&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* stubs for some unused function=
s instead of pulling in too many dependencies */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+struct signal_info siginfo_static; /* GLOBAL *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+signal_reset(struct signal_info *si, int signum)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _W=
IN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct win32_si=
gnal win32_signal; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+win32_signal_get(struct=
 win32_signal *ws)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_line(con=
st char *line, char **p, const int n, const char *file, const int line_num,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           int msgl=
evel, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_add_in6_addr_tc(const char *orig_str, uint32_t add, const=
 char *expect_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr=
 orig, result, expected;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, orig_str, &a=
mp;orig), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(inet_pton(AF_INET6, expect_str, &amp;expected), 1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    result =3D add_in6_addr(=
orig, add);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *result_str =3D print_in6_addr(result, 0, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(result_str, =
expect_str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_memory_equal(&amp;result, &amp;expected, sizeof(struct in6_addr));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_add_in6_addr(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Note that some of the result strings need to account for</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+       print_in6_addr formatt=
ing the addresses as IPv4 */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    test_add_in6_addr_tc(&quot;::&quot;, 1, &quot;::1&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc=
(&quot;::ff&quot;, 1, &quot;::100&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quot;::ffff&quot;, 1, &quot=
;::0.1.0.0&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   test_add_in6_addr_tc(&quot;ffff::ffff&quot;, 1, &quot;ffff::1:0&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_add=
r_tc(&quot;::ffff:ffff&quot;, 1, &quot;::1:0:0&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quot;ffff:ffff=
:ffff:ffff:ffff:ffff:ffff:ffff&quot;, 1, &quot;::&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quot;ffff:f=
fff:ffff:ffff:ffff:ffff:ffff:ffff&quot;, 2, &quot;::1&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quot;::&quot;, UINT32_MAX,=
 &quot;::255.255.255.255&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    test_add_in6_addr_tc(&quot;::1&quot;, UINT32_MAX, &quot;::=
1:0:0&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    te=
st_add_in6_addr_tc(&quot;::ffff&quot;, UINT32_MAX, &quot;::1:0:fffe&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_ad=
dr_tc(&quot;ffff::ffff&quot;, UINT32_MAX, &quot;ffff::1:0:fffe&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc=
(&quot;::ffff:ffff&quot;, UINT32_MAX, &quot;::1:ffff:fffe&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quo=
t;ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff&quot;, UINT32_MAX, &quot;::255.25=
5.255.254&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+const struct CMUnitTest socket_tests[] =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_uni=
t_test(test_add_in6_addr)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return cmocka_run_group_tests(socket_tests, NULL, NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1160?=
usp=3Demail">change 1160</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1160?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If546f64a4554b292623bfcfe9ee=
53bac17dfa803 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1160 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ISG3k7a07a8=--

