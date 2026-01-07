From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 7 Jan 2026 17:58:07 +0000
References: <gerrit.1767808679000.I33583e51e1143c53fbe0aef16546fa3f602b17c0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a2571d5c549f9e8818d8be58fa700a7c0e4b975f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cBIaYZYsIcI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: Add a
 first unit test
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

--cBIaYZYsIcI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1459?usp=3Demail

to review the following change.


Change subject: openvpnserv: Add a first unit test
......................................................................

openvpnserv: Add a first unit test

This adds the required build infrastructure
and adds tests for two functions related to
GetItfDnsDomains().

Change-Id: I33583e51e1143c53fbe0aef16546fa3f602b17c0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnserv/CMakeLists.txt
M tests/unit_tests/Makefile.am
M tests/unit_tests/openvpn/test_common.h
A tests/unit_tests/openvpnserv/Makefile.am
A tests/unit_tests/openvpnserv/test_openvpnserv.c
5 files changed, 172 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1459/1

diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 2c8f310..67a89ef 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -74,3 +74,44 @@
 endif()

 add_dependencies(openvpnserv msg_mc_gen)
+
+if (BUILD_TESTING)
+    set(unit_tests
+        "test_openvpnserv"
+    )
+
+    foreach (test_name ${unit_tests})
+        add_test(${test_name} ${test_name})
+        add_executable(${test_name}
+            ../../tests/unit_tests/openvpnserv/${test_name}.c
+            ${MC_GEN_DIR}/eventmsg.h
+        )
+
+        target_link_libraries(${test_name} PUBLIC ${CMOCKA_LIBRARIES})
+        target_include_directories(${test_name} PRIVATE
+            .
+            ../../include
+            ../openvpn
+            ${MC_GEN_DIR}
+            ../../tests/unit_tests/openvpn
+        )
+        target_compile_options(${test_name} PRIVATE
+            -D_UNICODE
+            -UNTDDI_VERSION
+            -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+        )
+        target_link_libraries(${test_name} PRIVATE
+            advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib
+            shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcc=
h.lib)
+        if (MINGW)
+            target_compile_options(${test_name} PRIVATE -municode)
+            target_link_options(${test_name} PRIVATE -municode)
+        endif ()
+    endforeach()
+
+    target_sources(test_openvpnserv PRIVATE
+        common.c
+        validate.c
+        ../openvpn/wfp_block.c ../openvpn/wfp_block.h
+    )
+endif ()
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index 33fefaa..ce6278e 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -1,5 +1,5 @@
 AUTOMAKE_OPTIONS =3D foreign

 if ENABLE_UNITTESTS
-SUBDIRS =3D example_test openvpn plugins
+SUBDIRS =3D example_test openvpn openvpnserv plugins
 endif
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/open=
vpn/test_common.h
index 3a0598d..4153ca3 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -20,8 +20,9 @@
  *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

-#include <stdio.h>
 #include <setjmp.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <cmocka.h>

 /* Do we use cmocka < 2.0.0? */
diff --git a/tests/unit_tests/openvpnserv/Makefile.am b/tests/unit_tests/op=
envpnserv/Makefile.am
new file mode 100644
index 0000000..5758cd4
--- /dev/null
+++ b/tests/unit_tests/openvpnserv/Makefile.am
@@ -0,0 +1,15 @@
+AUTOMAKE_OPTIONS =3D foreign
+
+EXTRA_DIST =3D input
+
+AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) service Unit-Tests'
+
+if WIN32
+test_binaries =3D openvpnserv_testdriver
+endif
+
+openvpnserv_testdriver_CFLAGS  =3D -I$(top_srcdir)/include -I$(top_srcdir)=
/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpnserv @TE=
ST_CFLAGS@
+openvpnserv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/open=
vpn
+openvpnserv_testdriver_SOURCES =3D test_openvpnserv.c \
+	$(top_srcdir)/src/openvpnserv/common.c
+
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_t=
ests/openvpnserv/test_openvpnserv.c
new file mode 100644
index 0000000..348de4f
--- /dev/null
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c
@@ -0,0 +1,113 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 Frank Lichtenheld <frank@...2641...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by t=
he
+ *  Free Software Foundation, either version 2 of the License,
+ *  or (at your option) any later version.
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
+#include <setjmp.h>
+#include <cmocka.h>
+#include "test_common.h"
+
+#include <winsock2.h>
+#include <windows.h>
+
+#include "interactive.c"
+
+BOOL
+ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)
+{
+    return TRUE;
+}
+
+static void
+test_list_contains_domain(void **state)
+{
+    PCWSTR domain =3D L"openvpn.net";
+    size_t domain_len =3D wcslen(domain);
+    assert_true(ListContainsDomain(domain, domain, domain_len));
+    assert_true(ListContainsDomain(L"openvpn.com,openvpn.net", domain, dom=
ain_len));
+    assert_true(ListContainsDomain(L"openvpn.net,openvpn.com", domain, dom=
ain_len));
+
+    assert_false(ListContainsDomain(L"openvpn.com", domain, domain_len));
+    assert_false(ListContainsDomain(L"internal.openvpn.net", domain, domai=
n_len));
+}
+
+#define BUF_SIZE 64
+static void
+test_convert_itf_dns_domains(void **state)
+{
+    DWORD size, orig_size, len, res_len;
+    LSTATUS err;
+    const DWORD glyph_size =3D sizeof(wchar_t);
+
+    wchar_t domains_1[BUF_SIZE] =3D L"openvpn.com";
+    len =3D (DWORD)wcslen(domains_1) + 1;
+    size =3D orig_size =3D len * glyph_size;
+    wchar_t domains_1_res[BUF_SIZE] =3D L".openvpn.com";
+    res_len =3D len + 2; /* adds . and \0 */
+    err =3D ConvertItfDnsDomains(L"openvpn.net", domains_1, &size, BUF_SIZ=
E);
+    assert_memory_equal(domains_1, domains_1_res, size);
+    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(err, NO_ERROR);
+
+    wchar_t domains_2[BUF_SIZE] =3D L"openvpn.com,openvpn.net";
+    len =3D (DWORD)wcslen(domains_2) + 1;
+    size =3D orig_size =3D len * glyph_size;
+    wchar_t domains_2_res[BUF_SIZE] =3D L".openvpn.com";
+    res_len =3D (DWORD)wcslen(domains_2_res) + 2;
+    err =3D ConvertItfDnsDomains(L"openvpn.net", domains_2, &size, BUF_SIZ=
E);
+    assert_memory_equal(domains_2, domains_2_res, size);
+    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(err, NO_ERROR);
+
+    wchar_t domains_3[BUF_SIZE] =3D L"openvpn.com,openvpn.net";
+    len =3D (DWORD)wcslen(domains_3) + 1;
+    size =3D orig_size =3D len * glyph_size;
+    wchar_t domains_3_res[BUF_SIZE] =3D L".openvpn.net";
+    res_len =3D (DWORD)wcslen(domains_3_res) + 2;
+    err =3D ConvertItfDnsDomains(L"openvpn.com", domains_3, &size, BUF_SIZ=
E);
+    assert_memory_equal(domains_3, domains_3_res, size);
+    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(err, NO_ERROR);
+
+    wchar_t domains_4[BUF_SIZE] =3D L"openvpn.com,openvpn.net";
+    len =3D (DWORD)wcslen(domains_4) + 1;
+    size =3D orig_size =3D len * glyph_size;
+    wchar_t domains_4_res[BUF_SIZE] =3D L".openvpn.com\0.openvpn.net";
+    res_len =3D len + 3; /* adds two . and one \0 */
+    err =3D ConvertItfDnsDomains(NULL, domains_4, &size, BUF_SIZE);
+    assert_memory_equal(domains_4, domains_4_res, size);
+    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(err, NO_ERROR);
+}
+
+int
+wmain(void)
+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_list_contains_domain),
+        cmocka_unit_test(test_convert_itf_dns_domains),
+    };
+
+    int ret =3D cmocka_run_group_tests_name("openvpnserv tests", tests, NU=
LL, NULL);
+
+    return ret;
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1459?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33583e51e1143c53fbe0aef16546fa3f602b17c0
Gerrit-Change-Number: 1459
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--cBIaYZYsIcI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1459?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnserv: Add a first unit test<br><br>T=
his adds the required build infrastructure<br>and adds tests for two functi=
ons related to<br>GetItfDnsDomains().<br><br>Change-Id: I33583e51e1143c53fb=
e0aef16546fa3f602b17c0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>---<br>M src/openvpnserv/CMakeLists.txt<br>M tests/unit_tests/M=
akefile.am<br>M tests/unit_tests/openvpn/test_common.h<br>A tests/unit_test=
s/openvpnserv/Makefile.am<br>A tests/unit_tests/openvpnserv/test_openvpnser=
v.c<br>5 files changed, 172 insertions(+), 2 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1=
459/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv=
/CMakeLists.txt</span><br><span>index 2c8f310..67a89ef 100644</span><br><sp=
an>--- a/src/openvpnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnse=
rv/CMakeLists.txt</span><br><span>@@ -74,3 +74,44 @@</span><br><span> endif=
()</span><br><span> </span><br><span> add_dependencies(openvpnserv msg_mc_g=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+if (BUILD_TESTING)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    set(unit_tests</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &quot;test_openvpnserv&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    foreach (test_name ${unit_tests})</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        add_test(${test_name} ${tes=
t_name})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add=
_executable(${test_name}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ../../tests/unit_tests/openvpnserv/${test_name}.c</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            ${MC_GEN_DIR}/ev=
entmsg.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        target_link_libraries(${test_nam=
e} PUBLIC ${CMOCKA_LIBRARIES})</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        target_include_directories(${test_name} PRIVATE</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            .</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            ../../include</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            ../openvpn</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            ${MC_GEN_DIR}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ../../t=
ests/unit_tests/openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  target_compile_options(${test_name} PRIVATE</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            -D_UNICODE</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            -UNTDDI_VERSION</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            -D_WIN32_WINNT=3D_WIN32_WI=
NNT_VISTA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        target_link_=
libraries(${test_name} PRIVATE</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib r=
pcrt4.lib</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcch.lib)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (MINGW)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            target_compil=
e_options(${test_name} PRIVATE -municode)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            target_link_options(${test_name} PRIVATE =
-municode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
ndif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endforea=
ch()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_openvpnser=
v PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
mmon.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        valid=
ate.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ../ope=
nvpn/wfp_block.c ../openvpn/wfp_block.h</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+endif ()</span><br><span>diff --git a/tests/unit_tests/Makefile.am b/=
tests/unit_tests/Makefile.am</span><br><span>index 33fefaa..ce6278e 100644<=
/span><br><span>--- a/tests/unit_tests/Makefile.am</span><br><span>+++ b/te=
sts/unit_tests/Makefile.am</span><br><span>@@ -1,5 +1,5 @@</span><br><span>=
 AUTOMAKE_OPTIONS =3D foreign</span><br><span> </span><br><span> if ENABLE_=
UNITTESTS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SUBDIRS =3D =
example_test openvpn plugins</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+SUBDIRS =3D example_test openvpn openvpnserv plugins</span><br><sp=
an> endif</span><br><span>diff --git a/tests/unit_tests/openvpn/test_common=
.h b/tests/unit_tests/openvpn/test_common.h</span><br><span>index 3a0598d..=
4153ca3 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_common.h=
</span><br><span>+++ b/tests/unit_tests/openvpn/test_common.h</span><br><sp=
an>@@ -20,8 +20,9 @@</span><br><span>  *  with this program; if not, see &l=
t;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;stdio.h&=
gt;</span><br><span> #include &lt;setjmp.h&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;stdio.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span=
> #include &lt;cmocka.h&gt;</span><br><span> </span><br><span> /* Do we use=
 cmocka &lt; 2.0.0? */</span><br><span>diff --git a/tests/unit_tests/openvp=
nserv/Makefile.am b/tests/unit_tests/openvpnserv/Makefile.am</span><br><spa=
n>new file mode 100644</span><br><span>index 0000000..5758cd4</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpnserv/Makefil=
e.am</span><br><span>@@ -0,0 +1,15 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+AUTOMAKE_OPTIONS =3D foreign</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+EXTRA_DIST =3D input</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_TESTSUI=
TE_SUMMARY_HEADER =3D &#39; for $(PACKAGE_STRING) service Unit-Tests&#39;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+if WIN32</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+test_binaries =3D openvpnserv_testdriver</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+openvpnserv_testdriver_CFLAGS  =3D -I$(top_srcdir)/include -I$(=
top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/open=
vpnserv @TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+openvpnserv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/ope=
nvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpnserv_tes=
tdriver_SOURCES =3D test_openvpnserv.c \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpnserv/common.c</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>diff --git a/test=
s/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/=
test_openvpnserv.c</span><br><span>new file mode 100644</span><br><span>ind=
ex 0000000..348de4f</span><br><span>--- /dev/null</span><br><span>+++ b/tes=
ts/unit_tests/openvpnserv/test_openvpnserv.c</span><br><span>@@ -0,0 +1,113=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to =
securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             over a single UDP port, with support for SSL/TLS-bas=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             se=
ssion authentication and key exchange,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet encryption, packet authentication,=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2025 Frank Lichtenheld &lt;frank@...2641...&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  This program is free software; you can redistribute it and/=
or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it und=
er the terms of the GNU General Public License as published by the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Free Software Foundation=
, either version 2 of the License,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  or (at your option) any later version.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  GNU General Public License for more details.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www.gnu.org/licenses/&g=
t;.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common.h&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;winsock2.h&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;windows.h&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;interactive.c&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+BOOL</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATU=
S *status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_list_contains_domain(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    PCWSTR domain =3D L&quot;openvpn.net&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    size_t domain_len =3D wcslen(domain);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ListCon=
tainsDomain(domain, domain, domain_len));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(ListContainsDomain(L&quot;openvpn.com=
,openvpn.net&quot;, domain, domain_len));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(ListContainsDomain(L&quot;openvpn.net=
,openvpn.com&quot;, domain, domain_len));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(ListContainsDomain(L&quot;openvpn.com&quot;, domain, do=
main_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_false(ListContainsDomain(L&quot;internal.openvpn.net&quot;, domain, doma=
in_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define BUF_SIZE 64</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_convert_itf_dns_domains(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    DWORD size, orig_size, len, res_len;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const DWORD glyph_size =3D s=
izeof(wchar_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_1[B=
UF_SIZE] =3D L&quot;openvpn.com&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    len =3D (DWORD)wcslen(domains_1) + 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    size =3D orig_size =3D len * g=
lyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar=
_t domains_1_res[BUF_SIZE] =3D L&quot;.openvpn.com&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    res_len =3D len + 2; /* adds . an=
d \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D =
ConvertItfDnsDomains(L&quot;openvpn.net&quot;, domains_1, &amp;size, BUF_SI=
ZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(domains_1, domains_1_res, size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(size, res_len * glyph_size);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(er=
r, NO_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_2[BUF=
_SIZE] =3D L&quot;openvpn.com,openvpn.net&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    len =3D (DWORD)wcslen(domains_2) + 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D orig_size =
=3D len * glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    wchar_t domains_2_res[BUF_SIZE] =3D L&quot;.openvpn.com&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    res_len =3D (DWORD)wcs=
len(domains_2_res) + 2;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    err =3D ConvertItfDnsDomains(L&quot;openvpn.net&quot;, domains_2, &=
amp;size, BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_memory_equal(domains_2, domains_2_res, size);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(size, res_len * =
glyph_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(err, NO_ERROR);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar=
_t domains_3[BUF_SIZE] =3D L&quot;openvpn.com,openvpn.net&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    len =3D (DWORD)wcslen(doma=
ins_3) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size=
 =3D orig_size =3D len * glyph_size;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    wchar_t domains_3_res[BUF_SIZE] =3D L&quot;.openvpn.ne=
t&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res_len=
 =3D (DWORD)wcslen(domains_3_res) + 2;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    err =3D ConvertItfDnsDomains(L&quot;openvpn.com&quot=
;, domains_3, &amp;size, BUF_SIZE);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_memory_equal(domains_3, domains_3_res, size);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(s=
ize, res_len * glyph_size);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(err, NO_ERROR);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    wchar_t domains_4[BUF_SIZE] =3D L&quot;openvpn.com,openvpn.net&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    len =3D (DW=
ORD)wcslen(domains_4) + 1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    size =3D orig_size =3D len * glyph_size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    wchar_t domains_4_res[BUF_SIZE] =3D L=
&quot;.openvpn.com\0.openvpn.net&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    res_len =3D len + 3; /* adds two . and one \0 */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D ConvertItf=
DnsDomains(NULL, domains_4, &amp;size, BUF_SIZE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_memory_equal(domains_4, domains_4_=
res, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(size, res_len * glyph_size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(err, NO_ERROR);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wmain(void)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct CMUnitTest t=
ests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_list_contains_domain),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_convert_itf_dns_dom=
ains),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int ret =3D cmocka_run_group_tests_name(&=
quot;openvpnserv tests&quot;, tests, NULL, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1459?usp=3Demail">change 1459</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1459?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33583e51e1143c53fbe0aef1654=
6fa3f602b17c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1459 </div>
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

--cBIaYZYsIcI=--

