From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 22:49:19 +0000
References: <gerrit.1760136547000.I08e50030b1b692d351509f541e5c0b03b5170615@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0708aaa6628b05e977adc058ddeeab4b5e3e2a8a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uFEhQGk5N/g="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_dhcp: Start a
 dhcp helper functions UT
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

--uFEhQGk5N/g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1267?usp=3Demail

to review the following change.


Change subject: test_dhcp: Start a dhcp helper functions UT
......................................................................

test_dhcp: Start a dhcp helper functions UT

Use extra define to allow testing code only
used on Windows but not actually dependent
on Windows.

Change-Id: I08e50030b1b692d351509f541e5c0b03b5170615
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M src/openvpn/dhcp.c
M src/openvpn/dhcp.h
M src/openvpn/tun.h
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/mock_msg.h
A tests/unit_tests/openvpn/test_dhcp.c
7 files changed, 154 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1267/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 37bfc03..811a324 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -658,6 +658,7 @@
         "test_auth_token"
         "test_buffer"
         "test_crypto"
+        "test_dhcp"
         "test_misc"
         "test_ncp"
         "test_packet_id"
@@ -918,6 +919,11 @@
             )
     endif ()

+    target_compile_definitions(test_dhcp PRIVATE DHCP_UNIT_TEST)
+    target_sources(test_dhcp PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        )
+
     if (TARGET test_networking)
         target_link_options(test_networking PRIVATE -Wl,--wrap=3Dparse_lin=
e)
         target_compile_options(test_networking PRIVATE -UNDEBUG)
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 56f03f2..0893ec7 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -186,7 +186,7 @@
     return 0;
 }

-#if defined(_WIN32)
+#if defined(_WIN32) || defined(DHCP_UNIT_TEST)

 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index 3fcd2b6..2ad31a6 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -93,7 +93,7 @@

 in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);

-#if defined(_WIN32)
+#if defined(_WIN32) || defined(DHCP_UNIT_TEST)
 #include "tun.h"

 bool build_dhcp_options_string(struct buffer *buf, const struct tuntap_opt=
ions *o);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 6562c22..741798d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -59,7 +59,7 @@
 #define DCO_WIN_REFERENCE_STRING "ovpn-dco"
 #endif

-#if defined(_WIN32) || defined(TARGET_ANDROID)
+#if defined(_WIN32) || defined(TARGET_ANDROID) || defined(DHCP_UNIT_TEST)

 #define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 8e94665..79987ad 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -4,7 +4,7 @@

 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) Unit-Tests'

-test_binaries =3D argv_testdriver buffer_testdriver crypto_testdriver pack=
et_id_testdriver auth_token_testdriver \
+test_binaries =3D argv_testdriver buffer_testdriver crypto_testdriver dhcp=
_testdriver packet_id_testdriver auth_token_testdriver \
 	ncp_testdriver misc_testdriver pkt_testdriver ssl_testdriver \
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socke=
t_testdriver

@@ -71,6 +71,15 @@
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/mss.c

+dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/sr=
c/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
+dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
+dhcp_testdriver_SOURCES =3D test_dhcp.c \
+	mock_msg.c mock_msg.h test_common.h \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/win32-util.c
+
 ssl_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn=
/mock_msg.h
index c6321dc..62afde5 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -23,6 +23,8 @@
 #ifndef MOCK_MSG_H
 #define MOCK_MSG_H

+#include "error.h"
+
 /**
  * Mock debug level defaults to 0, which gives clean(-ish) test reports.  =
Call
  * this function from your test driver to increase debug output when you
diff --git a/tests/unit_tests/openvpn/test_dhcp.c b/tests/unit_tests/openvp=
n/test_dhcp.c
new file mode 100644
index 0000000..1219a7e
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_dhcp.c
@@ -0,0 +1,133 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@...515...>
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
+#include "test_common.h"
+#include "mock_msg.h"
+
+#include "dhcp.c"
+
+uint16_t
+ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_pa=
yload,
+            const uint8_t *src_addr, const uint8_t *dest_addr, const int p=
roto)
+{
+    return 0;
+}
+const char *
+print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)
+{
+    return "dummy";
+}
+
+static void
+test_write_dhcp_search_str(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer out_buf =3D alloc_buf_gc(512, &gc);
+    struct buffer clear_buf =3D alloc_buf_gc(512, &gc);
+    bool error =3D false;
+
+#define LONGDOMAIN "a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaally-long-domain"
+    const char *search_list[] =3D {
+        "openvpn.net",
+        "openvpn.com",
+        LONGDOMAIN,
+        "subdomain." LONGDOMAIN ".top123",  /* maximum length */
+        "subdomain-" LONGDOMAIN "-top123",  /* maximum length */
+        "subdomain." LONGDOMAIN ".top1234", /* too long */
+        "sub..domain",                      /* invalid */
+    };
+    const char output_1[27] =3D "\x77\x1a\x07openvpn\x03net\x00\x07openvpn=
\x{03}com";
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list, 2, &e=
rror);
+    assert_memory_equal(BPTR(&out_buf), output_1, sizeof(output_1));
+    assert_false(error);
+
+    /* buf too small */
+    struct buffer small_buf =3D alloc_buf_gc(27, &gc);
+    buf_clear(&small_buf);
+    write_dhcp_search_str(&small_buf, DHCP_DOMAIN_SEARCH, search_list, 2, =
&error);
+    assert_memory_equal(BPTR(&small_buf), BPTR(&clear_buf), buf_forward_ca=
pacity_total(&small_buf));
+    assert_true(error);
+    error =3D false;
+
+    const unsigned char output_2[0xEC + 3] =3D "\x77\xEE\xEC" LONGDOMAIN;
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 2, 1=
, &error);
+    assert_memory_equal(BPTR(&out_buf), output_2, sizeof(output_2));
+    assert_false(error);
+
+    const unsigned char output_3[0xEC + 3 + 10 + 7] =3D "\x77\xFF\x09subdo=
main\xEC" LONGDOMAIN "\x06top123";
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 3, 1=
, &error);
+    assert_memory_equal(BPTR(&out_buf), output_3, sizeof(output_3));
+    assert_false(error);
+
+    const unsigned char output_4[0xEC + 3 + 10 + 7] =3D "\x77\xFF\xFDsubdo=
main-" LONGDOMAIN "-top123";
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 4, 1=
, &error);
+    assert_memory_equal(BPTR(&out_buf), output_4, sizeof(output_4));
+    assert_false(error);
+
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 5, 1=
, &error);
+    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_capa=
city_total(&clear_buf));
+    assert_true(error);
+    error =3D false;
+
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list, 3, &e=
rror);
+    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_capa=
city_total(&clear_buf));
+    assert_true(error);
+    error =3D false;
+
+    /* FIXME: should probably throw an error instead adding that \x00 ? */
+    const char output_5[15] =3D "\x77\x0d\x03sub\x00\x{06}domain";
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 6, 1=
, &error);
+    assert_memory_equal(BPTR(&out_buf), output_5, sizeof(output_5));
+    assert_false(error);
+
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_write_dhcp_search_str),
+    };
+
+    return cmocka_run_group_tests_name("dhcp", tests, NULL, NULL);
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1267?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I08e50030b1b692d351509f541e5c0b03b5170615
Gerrit-Change-Number: 1267
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--uFEhQGk5N/g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1267?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">test_dhcp: Start a dhcp helper functions UT=
<br><br>Use extra define to allow testing code only<br>used on Windows but =
not actually dependent<br>on Windows.<br><br>Change-Id: I08e50030b1b692d351=
509f541e5c0b03b5170615<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/dhcp.c<br>M src/openvp=
n/dhcp.h<br>M src/openvpn/tun.h<br>M tests/unit_tests/openvpn/Makefile.am<b=
r>M tests/unit_tests/openvpn/mock_msg.h<br>A tests/unit_tests/openvpn/test_=
dhcp.c<br>7 files changed, 154 insertions(+), 4 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/6=
7/1267/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><sp=
an>index 37bfc03..811a324 100644</span><br><span>--- a/CMakeLists.txt</span=
><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -658,6 +658,7 @@</span><=
br><span>         &quot;test_auth_token&quot;</span><br><span>         &quo=
t;test_buffer&quot;</span><br><span>         &quot;test_crypto&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;test_dhcp&qu=
ot;</span><br><span>         &quot;test_misc&quot;</span><br><span>        =
 &quot;test_ncp&quot;</span><br><span>         &quot;test_packet_id&quot;</=
span><br><span>@@ -918,6 +919,11 @@</span><br><span>             )</span><b=
r><span>     endif ()</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    target_compile_definitions(test_dhcp PRIVATE DHCP_U=
NIT_TEST)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target=
_sources(test_dhcp PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tests/unit_tests/openvpn/mock_get_random.c</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     if (TARGET test_networkin=
g)</span><br><span>         target_link_options(test_networking PRIVATE -Wl=
,--wrap=3Dparse_line)</span><br><span>         target_compile_options(test_=
networking PRIVATE -UNDEBUG)</span><br><span>diff --git a/src/openvpn/dhcp.=
c b/src/openvpn/dhcp.c</span><br><span>index 56f03f2..0893ec7 100644</span>=
<br><span>--- a/src/openvpn/dhcp.c</span><br><span>+++ b/src/openvpn/dhcp.c=
</span><br><span>@@ -186,7 +186,7 @@</span><br><span>     return 0;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(_WIN32) || defined(DHCP_UNIT_TEST)</span><br><span> </s=
pan><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br><span>=
 #pragma GCC diagnostic push</span><br><span>diff --git a/src/openvpn/dhcp.=
h b/src/openvpn/dhcp.h</span><br><span>index 3fcd2b6..2ad31a6 100644</span>=
<br><span>--- a/src/openvpn/dhcp.h</span><br><span>+++ b/src/openvpn/dhcp.h=
</span><br><span>@@ -93,7 +93,7 @@</span><br><span> </span><br><span> in_ad=
dr_t dhcp_extract_router_msg(struct buffer *ipbuf);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defi=
ned(DHCP_UNIT_TEST)</span><br><span> #include &quot;tun.h&quot;</span><br><=
span> </span><br><span> bool build_dhcp_options_string(struct buffer *buf, =
const struct tuntap_options *o);</span><br><span>diff --git a/src/openvpn/t=
un.h b/src/openvpn/tun.h</span><br><span>index 6562c22..741798d 100644</spa=
n><br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h=
</span><br><span>@@ -59,7 +59,7 @@</span><br><span> #define DCO_WIN_REFEREN=
CE_STRING &quot;ovpn-dco&quot;</span><br><span> #endif</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32) || d=
efined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(_WIN32) || defined(TARGET_ANDROID) || defined(DHCP_UNIT_TEST=
)</span><br><span> </span><br><span> #define TUN_ADAPTER_INDEX_INVALID ((DW=
ORD)-1)</span><br><span> </span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>ind=
ex 8e94665..79987ad 100644</span><br><span>--- a/tests/unit_tests/openvpn/M=
akefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span=
><br><span>@@ -4,7 +4,7 @@</span><br><span> </span><br><span> AM_TESTSUITE_=
SUMMARY_HEADER =3D &#39; for $(PACKAGE_STRING) Unit-Tests&#39;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_binaries =
=3D argv_testdriver buffer_testdriver crypto_testdriver packet_id_testdrive=
r auth_token_testdriver \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_binaries =3D argv_testdriver buffer_testdriver crypto_testdriver=
 dhcp_testdriver packet_id_testdriver auth_token_testdriver \</span><br><sp=
an> 	ncp_testdriver misc_testdriver pkt_testdriver ssl_testdriver \</span><=
br><span> 	user_pass_testdriver push_update_msg_testdriver provider_testdri=
ver socket_testdriver</span><br><span> </span><br><span>@@ -71,6 +71,15 @@<=
/span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/mss.c</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dhcp_testdriver_CFLAGS  =3D -I$(top_srcdi=
r)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dhcp_testdriver_LDFLAG=
S =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dhcp_testdriver_SOURCES =3D test_dhcp.c \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h t=
est_common.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock=
_get_random.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/openvpn/platform.c \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util.c</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ssl=
_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(top=
_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_C=
FLAGS@</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_msg.h b/t=
ests/unit_tests/openvpn/mock_msg.h</span><br><span>index c6321dc..62afde5 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/mock_msg.h</span><br><=
span>+++ b/tests/unit_tests/openvpn/mock_msg.h</span><br><span>@@ -23,6 +23=
,8 @@</span><br><span> #ifndef MOCK_MSG_H</span><br><span> #define MOCK_MSG=
_H</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;error.h&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /**</span><br><span>  * Mock debug level defaul=
ts to 0, which gives clean(-ish) test reports.  Call</span><br><span>  * th=
is function from your test driver to increase debug output when you</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_dhcp.c b/tests/unit_tes=
ts/openvpn/test_dhcp.c</span><br><span>new file mode 100644</span><br><span=
>index 0000000..1219a7e</span><br><span>--- /dev/null</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_dhcp.c</span><br><span>@@ -0,0 +1,133 @@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securel=
y tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             over a single UDP port, with support for SSL/TLS-based</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session a=
uthentication and key exchange,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet encryption, packet authentication, and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 O=
penVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms o=
f the GNU General Public License version 2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the =
hope that it will be useful,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY=
 or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy =
of the GNU General Public License along</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.=
org/licenses/&gt;.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;stdio.h&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;stdarg.h&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_msg.h&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;dhcp.c&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+uint16_t</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ip_checksum(const sa_family_t af, const uint8_t *payload, cons=
t int len_payload,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           const uint8_t *src_addr, const uint8_t *dest_addr, const int pro=
to)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_are=
na *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return &quot;dummy&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_write_dhcp_search_str(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer out_buf =3D alloc_buf_gc(51=
2, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer clear_buf =3D alloc_buf_gc(512, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool error =3D false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define LONGDOMAIN &quot;a-reaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally-long-domain&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *search_list[] =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;=
openvpn.net&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &quot;openvpn.com&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        LONGDOMAIN,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        &quot;subdomain.&quot; LONGDOMAIN &quot;.top123&quot;, =
 /* maximum length */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &quot;subdomain-&quot; LONGDOMAIN &quot;-top123&quot;,  /* maximu=
m length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
&quot;subdomain.&quot; LONGDOMAIN &quot;.top1234&quot;, /* too long */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;sub..domai=
n&quot;,                      /* invalid */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char output_1[27] =3D &quot;\x77\x1a\x07openvpn\x03net=
\x00\x07openvpn\x{03}com&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    buf_clear(&amp;out_buf);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    write_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN_SE=
ARCH, search_list, 2, &amp;error);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_memory_equal(BPTR(&amp;out_buf), output_1, sizeof=
(output_1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* buf too small =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 small_buf =3D alloc_buf_gc(27, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    buf_clear(&amp;small_buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_search_str(&amp;small_buf,=
 DHCP_DOMAIN_SEARCH, search_list, 2, &amp;error);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;small_buf),=
 BPTR(&amp;clear_buf), buf_forward_capacity_total(&amp;small_buf));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(error);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned char output_2[0xEC + 3=
] =3D &quot;\x77\xEE\xEC&quot; LONGDOMAIN;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_clear(&amp;out_buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_search_str(&amp;out_buf, D=
HCP_DOMAIN_SEARCH, search_list + 2, 1, &amp;error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;out_buf=
), output_2, sizeof(output_2));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(error);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const unsigned char output_3[0xEC + 3 + 10 + 7] =3D &quot;\x77\xFF\x09sub=
domain\xEC&quot; LONGDOMAIN &quot;\x06top123&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;out_buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_search_str(&amp;o=
ut_buf, DHCP_DOMAIN_SEARCH, search_list + 3, 1, &amp;error);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;=
out_buf), output_3, sizeof(output_3));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(error);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const unsigned char output_4[0xEC + 3 + 10 + 7] =3D &quot;\x77\xFF=
\xFDsubdomain-&quot; LONGDOMAIN &quot;-top123&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;out_buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_search_str(&amp;o=
ut_buf, DHCP_DOMAIN_SEARCH, search_list + 4, 1, &amp;error);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;=
out_buf), output_4, sizeof(output_4));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(error);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_clear(&amp;out_buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    write_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN_SEARCH, s=
earch_list + 5, 1, &amp;error);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_memory_equal(BPTR(&amp;out_buf), BPTR(&amp;clear_buf=
), buf_forward_capacity_total(&amp;clear_buf));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    error =3D false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    buf_clear(&amp;out_buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    write_dhcp_search_str(&amp;out_buf, DHCP_DOMAI=
N_SEARCH, search_list, 3, &amp;error);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;out_buf), BPTR(&amp;cl=
ear_buf), buf_forward_capacity_total(&amp;clear_buf));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(error);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    error =3D false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* FIXME: should probably throw an error instead a=
dding that \x00 ? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char output_5[15] =3D &quot;\x77\x0d\x03sub\x00\x{06}domain&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&am=
p;out_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    writ=
e_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN_SEARCH, search_list + 6, 1, &am=
p;error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_memory_equal(BPTR(&amp;out_buf), output_5, sizeof(output_5));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(error);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_write_dhcp_search_str),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_gro=
up_tests_name(&quot;dhcp&quot;, tests, NULL, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1267?usp=3Dema=
il">change 1267</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1267?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I08e50030b1b692d351509f541e5=
c0b03b5170615 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1267 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--uFEhQGk5N/g=--

