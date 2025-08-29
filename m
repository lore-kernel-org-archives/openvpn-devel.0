From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 29 Aug 2025 14:59:47 +0000
In-Reply-To: <gerrit.1756402061000.If546f64a4554b292623bfcfe9ee53bac17dfa803@...2715...>
References: <gerrit.1756402061000.If546f64a4554b292623bfcfe9ee53bac17dfa803@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b157d2e6eca82e85e378771835771b7ca1a1677e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iUqn1q7v0Vg="; charset=UTF-8
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

--iUqn1q7v0Vg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1160?usp=3Demail

to look at the new patch set (#4).


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
4 files changed, 177 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1160/4

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 45044af..35513e9 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -628,9 +628,11 @@
     target_compile_options(openvpn PRIVATE -DPLUGIN_LIBDIR=3D\"${PLUGIN_DI=
R}\")

     find_library(resolv resolv)
-    # some platform like BSDs already include resolver functionality in th=
e libc and not have an extra resolv library
+    # some platform like BSDs already include resolver functionality in th=
e libc
+    # and do not have an extra resolv library
     if (${resolv} OR APPLE)
-        target_link_libraries(openvpn PUBLIC -lresolv)
+        set(RESOLV_LIBRARIES resolv)
+        target_link_libraries(openvpn PUBLIC ${RESOLV_LIBRARIES})
     endif ()
 endif ()

@@ -653,6 +655,7 @@
         "test_packet_id"
         "test_pkt"
         "test_provider"
+        "test_socket"
         "test_ssl"
         "test_user_pass"
         "test_push_update_msg"
@@ -849,6 +852,16 @@
         src/openvpn/base64.c
         )

+    target_link_libraries(test_socket PUBLIC ${RESOLV_LIBRARIES})
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
index b24e03c..d030185 100644
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
+socket_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ $(SOCKETS_LIBS)
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
index b24e4c4..28e541c 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -46,4 +46,18 @@
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
 #endif
+
+void
+management_sleep(const int n)
+{
+}
diff --git a/tests/unit_tests/openvpn/test_socket.c b/tests/unit_tests/open=
vpn/test_socket.c
new file mode 100644
index 0000000..2da2529
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_socket.c
@@ -0,0 +1,126 @@
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
+static bool
+check_mapped_ipv4_address(void)
+{
+    struct gc_arena gc =3D gc_new();
+    const char *ipv4_output =3D "::255.255.255.255";
+    struct in6_addr addr;
+    assert_int_equal(inet_pton(AF_INET6, ipv4_output, &addr), 1);
+    const char *test_output =3D print_in6_addr(addr, 0, &gc);
+    bool ret =3D strcmp(test_output, ipv4_output) =3D=3D 0;
+    gc_free(&gc);
+    return ret;
+}
+
+static void
+test_add_in6_addr(void **state)
+{
+    /* Note that some of the result strings need to account for
+       print_in6_addr formatting the addresses potentially as IPv4 */
+    bool mapped_ipv4 =3D check_mapped_ipv4_address();
+    test_add_in6_addr_tc("::", 1, "::1");
+    test_add_in6_addr_tc("::ff", 1, "::100");
+    test_add_in6_addr_tc("::ffff", 1, mapped_ipv4 ? "::0.1.0.0" : "::1:0");
+    test_add_in6_addr_tc("ffff::ffff", 1, "ffff::1:0");
+    test_add_in6_addr_tc("::ffff:ffff", 1, "::1:0:0");
+    test_add_in6_addr_tc("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", 1, "::=
");
+    test_add_in6_addr_tc("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", 2, "::=
1");
+
+    test_add_in6_addr_tc("::", UINT32_MAX, mapped_ipv4 ? "::255.255.255.25=
5" : "::ffff:ffff");
+    test_add_in6_addr_tc("::1", UINT32_MAX, "::1:0:0");
+    test_add_in6_addr_tc("::ffff", UINT32_MAX, "::1:0:fffe");
+    test_add_in6_addr_tc("ffff::ffff", UINT32_MAX, "ffff::1:0:fffe");
+    test_add_in6_addr_tc("::ffff:ffff", UINT32_MAX, "::1:ffff:fffe");
+    test_add_in6_addr_tc("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", UINT32=
_MAX,
+                         mapped_ipv4 ? "::255.255.255.254" : "::ffff:fffe"=
);
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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--iUqn1q7v0Vg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1160?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add new unit test module test_socket<br><br>With a first UT that =
tests add_in6_addr() (and<br>print_in6_addr implicitly).<br><br>Change-Id: =
If546f64a4554b292623bfcfe9ee53bac17dfa803<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M tests/unit_test=
s/openvpn/Makefile.am<br>M tests/unit_tests/openvpn/mock_management.c<br>A =
tests/unit_tests/openvpn/test_socket.c<br>4 files changed, 177 insertions(+=
), 12 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/60/1160/4</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.t=
xt</span><br><span>index 45044af..35513e9 100644</span><br><span>--- a/CMak=
eLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -628,9 +=
628,11 @@</span><br><span>     target_compile_options(openvpn PRIVATE -DPLU=
GIN_LIBDIR=3D\&quot;${PLUGIN_DIR}\&quot;)</span><br><span> </span><br><span=
>     find_library(resolv resolv)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    # some platform like BSDs already include resolver function=
ality in the libc and not have an extra resolv library</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    # some platform like BSDs already in=
clude resolver functionality in the libc</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    # and do not have an extra resolv library</span><b=
r><span>     if (${resolv} OR APPLE)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        target_link_libraries(openvpn PUBLIC -lresolv)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(RESOLV_LIBRAR=
IES resolv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
target_link_libraries(openvpn PUBLIC ${RESOLV_LIBRARIES})</span><br><span> =
    endif ()</span><br><span> endif ()</span><br><span> </span><br><span>@@=
 -653,6 +655,7 @@</span><br><span>         &quot;test_packet_id&quot;</span=
><br><span>         &quot;test_pkt&quot;</span><br><span>         &quot;tes=
t_provider&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     &quot;test_socket&quot;</span><br><span>         &quot;test_ssl&quot;<=
/span><br><span>         &quot;test_user_pass&quot;</span><br><span>       =
  &quot;test_push_update_msg&quot;</span><br><span>@@ -849,6 +852,16 @@</sp=
an><br><span>         src/openvpn/base64.c</span><br><span>         )</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tar=
get_link_libraries(test_socket PUBLIC ${RESOLV_LIBRARIES})</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_socket PRIVA=
TE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/uni=
t_tests/openvpn/mock_get_random.c</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        tests/unit_tests/openvpn/mock_management.c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openv=
pn/mock_win32_execve.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        src/openvpn/env_set.c</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        src/openvpn/run_command.c</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        src/openvpn/socket_util.c</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     target_sources(test_us=
er_pass PRIVATE</span><br><span>         tests/unit_tests/openvpn/mock_get_=
random.c</span><br><span>         tests/unit_tests/openvpn/mock_win32_execv=
e.c</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tes=
ts/unit_tests/openvpn/Makefile.am</span><br><span>index b24e03c..d030185 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><=
span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -4,23 +4=
,17 @@</span><br><span> </span><br><span> AM_TESTSUITE_SUMMARY_HEADER =3D &=
#39; for $(PACKAGE_STRING) Unit-Tests&#39;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-test_binaries=3D</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_binaries =3D crypto_testdriver pac=
ket_id_testdriver auth_token_testdriver \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	ncp_testdriver misc_testdriver pkt_testdriver ssl_te=
stdriver \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	user_pas=
s_testdriver push_update_msg_testdriver provider_testdriver socket_testdriv=
er</span><br><span> </span><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><sp=
an> test_binaries +=3D argv_testdriver buffer_testdriver</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-te=
st_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_testdriv=
er ncp_testdriver misc_testdriver \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	pkt_testdriver ssl_testdriver user_pass_testdriver push_upda=
te_msg_testdriver</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-if HAVE_LD_WRAP_SUPPORT</=
span><br><span> if !WIN32</span><br><span> test_binaries +=3D tls_crypt_tes=
tdriver</span><br><span> endif</span><br><span> endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-test_binaries +=3D provid=
er_testdriver</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> if WIN32</span><br><span> test_binaries +=3D cryptoapi_testdriver=
</span><br><span> LDADD =3D -lws2_32</span><br><span>@@ -343,4 +337,22 @@</=
span><br><span> 	$(top_srcdir)/src/openvpn/platform.c \</span><br><span> 	$=
(top_srcdir)/src/openvpn/push_util.c \</span><br><span> 	$(top_srcdir)/src/=
openvpn/options_util.c \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	$(top_srcdir)/src/openvpn/otime.c</span><br><span>\ No newline at end o=
f file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_testdriver=
_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(=
top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-DSOURCEDIR=3D\&q=
uot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
socket_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ $(SOCKETS_LIBS)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+socket_testdriver_SOURCES =3D test_socket.c \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_common.h  =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_random.c=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_management.=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/s=
rc/openvpn/buffer.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform.c \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/env_=
set.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdi=
r)/src/openvpn/run_command.c \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/socket_util.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>diff --git a/tests/unit_=
tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.=
c</span><br><span>index b24e4c4..28e541c 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/mock_management.c</span><br><span>+++ b/tests/unit_test=
s/openvpn/mock_management.c</span><br><span>@@ -46,4 +46,18 @@</span><br><s=
pan> {</span><br><span>     return NULL;</span><br><span> }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+management_set_state(struct management *man, const int state, const c=
har *detail,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              const in_addr_t *tun_local_ip, const struct in6_addr *tun_loc=
al_ip6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         const struct openvpn_sockaddr *local_addr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     const struct openvpn=
_sockaddr *remote_addr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+management_sleep(const int n)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_socket.c=
 b/tests/unit_tests/openvpn/test_socket.c</span><br><span>new file mode 100=
644</span><br><span>index 0000000..2da2529</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/test_socket.c</span><br><span>=
@@ -0,0 +1,126 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An a=
pplication to securely tunnel IP networks</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             over a single UDP port, with support f=
or SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2021-2025 Arne Schwabe &lt;arne@...1227...&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  This program is free software; you can redist=
ribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  it under the terms of the GNU General Public License version 2</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the =
Free Software Foundation.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pr=
ogram is distributed in the hope that it will be useful,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without =
even the implied warranty of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publ=
ic License for more details.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You =
should have received a copy of the GNU General Public License along</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if n=
ot, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef H=
AVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;config.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio.h&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg.h&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string.=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;s=
etjmp.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;cmocka.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;win32.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* stubs for some unu=
sed functions instead of pulling in too many dependencies */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct signal_info siginfo_static;=
 /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+signal_reset(struct signal_info *si, int =
signum)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stru=
ct win32_signal win32_signal; /* GLOBAL */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+win32_signal=
_get(struct win32_signal *ws)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse=
_line(const char *line, char **p, const int n, const char *file, const int =
line_num,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
 int msglevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_add_in6_addr_tc(const char *orig_str, uint32_t a=
dd, const char *expect_str)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 in6_addr orig, result, expected;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, ori=
g_str, &amp;orig), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(inet_pton(AF_INET6, expect_str, &amp;expected), 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    result =3D add_=
in6_addr(orig, add);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *result_str =3D print_in6_addr(result, 0, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(res=
ult_str, expect_str);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_memory_equal(&amp;result, &amp;expected, sizeof(struct in6_add=
r));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+check_mapped_ipv4_address(void)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *ipv4_output =3D &quot;::255.255=
.255.255&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct in6_addr addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(inet_pton(AF_INET6, ipv4_output, &amp;addr), 1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *test_ou=
tput =3D print_in6_addr(addr, 0, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool ret =3D strcmp(test_output, ipv4_output) =
=3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_add_in6_addr(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Note that some of the result strings need to account for=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       print_in6_ad=
dr formatting the addresses potentially as IPv4 */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    bool mapped_ipv4 =3D check_mapped_ipv4_a=
ddress();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_a=
dd_in6_addr_tc(&quot;::&quot;, 1, &quot;::1&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quot;::ff&quot;=
, 1, &quot;::100&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    test_add_in6_addr_tc(&quot;::ffff&quot;, 1, mapped_ipv4 ? &quot;::=
0.1.0.0&quot; : &quot;::1:0&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    test_add_in6_addr_tc(&quot;ffff::ffff&quot;, 1, &quot;f=
fff::1:0&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 test_add_in6_addr_tc(&quot;::ffff:ffff&quot;, 1, &quot;::1:0:0&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_t=
c(&quot;ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff&quot;, 1, &quot;::&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_add=
r_tc(&quot;ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff&quot;, 2, &quot;::1&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quot;::&q=
uot;, UINT32_MAX, mapped_ipv4 ? &quot;::255.255.255.255&quot; : &quot;::fff=
f:ffff&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
est_add_in6_addr_tc(&quot;::1&quot;, UINT32_MAX, &quot;::1:0:0&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc=
(&quot;::ffff&quot;, UINT32_MAX, &quot;::1:0:fffe&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quot;ffff::=
ffff&quot;, UINT32_MAX, &quot;ffff::1:0:fffe&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quot;::ffff:fff=
f&quot;, UINT32_MAX, &quot;::1:ffff:fffe&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    test_add_in6_addr_tc(&quot;ffff:ffff:ffff:=
ffff:ffff:ffff:ffff:ffff&quot;, UINT32_MAX,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                         mapped_ipv4 ? &quot;::255.=
255.255.254&quot; : &quot;::ffff:fffe&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struc=
t CMUnitTest socket_tests[] =3D {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    cmocka_unit_test(test_add_in6_addr)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests(socket_test=
s, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1160?usp=3Demail">change 1160</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1160?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If546f64a4554b292623bfcfe9ee=
53bac17dfa803 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1160 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--iUqn1q7v0Vg=--

