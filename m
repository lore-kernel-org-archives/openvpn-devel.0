From: Gert Doering <gert@...1296...>
Date: Mon, 19 Jan 2026 22:50:53 +0100
Message-ID: <20260119215058.27888-1-gert@...1296...>
In-Reply-To: <gerrit.1767808679000.I33583e51e1143c53fbe0aef16546fa3f602b17c0@...2715...>
References: <gerrit.1767808679000.I33583e51e1143c53fbe0aef16546fa3f602b17c0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] openvpnserv: Add a first unit test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

This adds the required build infrastructure
and adds tests for two functions related to
GetItfDnsDomains().

Change-Id: I33583e51e1143c53fbe0aef16546fa3f602b17c0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1459
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1459
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/configure.ac b/configure.ac
index 8ba5673..d3d548b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1460,6 +1460,7 @@
         tests/unit_tests/Makefile
         tests/unit_tests/example_test/Makefile
         tests/unit_tests/openvpn/Makefile
+        tests/unit_tests/openvpnserv/Makefile
         tests/unit_tests/plugins/Makefile
         tests/unit_tests/plugins/auth-pam/Makefile
 	sample/Makefile
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 2c8f310..fc15382 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -10,13 +10,29 @@
 
 set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)
 
-target_include_directories(openvpnserv PRIVATE
-    ${CMAKE_CURRENT_BINARY_DIR}/../../
-    ../../include/
-    ../openvpn/
-    ../compat/
-    ${MC_GEN_DIR}
+function(add_common_options target)
+    target_include_directories(${target} PRIVATE
+        ${CMAKE_CURRENT_BINARY_DIR}/../../
+        ../../include/
+        ../openvpn/
+        ../compat/
+        ${MC_GEN_DIR}
     )
+    target_compile_options(${target} PRIVATE
+        -D_UNICODE
+        -UNTDDI_VERSION
+        -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+    )
+    target_link_libraries(${target} PRIVATE
+        advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib
+        shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcch.lib)
+    if (MINGW)
+        target_compile_options(${target} PRIVATE -municode)
+        target_link_options(${target} PRIVATE -municode)
+    endif ()
+endfunction()
+
+add_common_options(openvpnserv)
 target_sources(openvpnserv PRIVATE
     common.c
     interactive.c
@@ -26,18 +42,6 @@
     ../openvpn/wfp_block.c ../openvpn/wfp_block.h
     openvpnserv_resources.rc
     )
-target_compile_options(openvpnserv PRIVATE
-    -D_UNICODE
-    -UNTDDI_VERSION
-    -D_WIN32_WINNT=_WIN32_WINNT_VISTA
-    )
-target_link_libraries(openvpnserv
-    advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib
-    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcch.lib)
-if (MINGW)
-    target_compile_options(openvpnserv PRIVATE -municode)
-    target_link_options(openvpnserv PRIVATE -municode)
-endif ()
 
 # below we generate a DLL which contains an event source for event log messages from eventmsg.mc template
 file(MAKE_DIRECTORY ${MC_GEN_DIR})
@@ -74,3 +78,30 @@
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
+        add_common_options(${test_name})
+        target_link_libraries(${test_name} PUBLIC ${CMOCKA_LIBRARIES})
+        target_include_directories(${test_name} PRIVATE
+            .
+            ../../tests/unit_tests/openvpn
+        )
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
 AUTOMAKE_OPTIONS = foreign
 
 if ENABLE_UNITTESTS
-SUBDIRS = example_test openvpn plugins
+SUBDIRS = example_test openvpn openvpnserv plugins
 endif
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
index f898e89..156e5a9 100644
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
diff --git a/tests/unit_tests/openvpnserv/Makefile.am b/tests/unit_tests/openvpnserv/Makefile.am
new file mode 100644
index 0000000..6064978
--- /dev/null
+++ b/tests/unit_tests/openvpnserv/Makefile.am
@@ -0,0 +1,16 @@
+AUTOMAKE_OPTIONS = foreign
+
+AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) service Unit-Tests'
+
+if WIN32
+test_binaries = openvpnserv_testdriver
+endif
+
+openvpnserv_testdriver_CFLAGS  = -I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpnserv @TEST_CFLAGS@
+openvpnserv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
+openvpnserv_testdriver_SOURCES = test_openvpnserv.c \
+	$(top_srcdir)/src/openvpnserv/common.c \
+	$(top_srcdir)/src/openvpnserv/validate.c \
+	$(top_srcdir)/src//openvpn/wfp_block.c \
+	$(top_srcdir)/src//openvpn/wfp_block.h
+
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test_openvpnserv.c
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
+ *  it under the terms of the GNU General Public License as published by the
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
+    PCWSTR domain = L"openvpn.net";
+    size_t domain_len = wcslen(domain);
+    assert_true(ListContainsDomain(domain, domain, domain_len));
+    assert_true(ListContainsDomain(L"openvpn.com,openvpn.net", domain, domain_len));
+    assert_true(ListContainsDomain(L"openvpn.net,openvpn.com", domain, domain_len));
+
+    assert_false(ListContainsDomain(L"openvpn.com", domain, domain_len));
+    assert_false(ListContainsDomain(L"internal.openvpn.net", domain, domain_len));
+}
+
+#define BUF_SIZE 64
+static void
+test_convert_itf_dns_domains(void **state)
+{
+    DWORD size, orig_size, len, res_len;
+    LSTATUS err;
+    const DWORD glyph_size = sizeof(wchar_t);
+
+    wchar_t domains_1[BUF_SIZE] = L"openvpn.com";
+    len = (DWORD)wcslen(domains_1) + 1;
+    size = orig_size = len * glyph_size;
+    wchar_t domains_1_res[BUF_SIZE] = L".openvpn.com";
+    res_len = len + 2; /* adds . and \0 */
+    err = ConvertItfDnsDomains(L"openvpn.net", domains_1, &size, BUF_SIZE);
+    assert_memory_equal(domains_1, domains_1_res, size);
+    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(err, NO_ERROR);
+
+    wchar_t domains_2[BUF_SIZE] = L"openvpn.com,openvpn.net";
+    len = (DWORD)wcslen(domains_2) + 1;
+    size = orig_size = len * glyph_size;
+    wchar_t domains_2_res[BUF_SIZE] = L".openvpn.com";
+    res_len = (DWORD)wcslen(domains_2_res) + 2;
+    err = ConvertItfDnsDomains(L"openvpn.net", domains_2, &size, BUF_SIZE);
+    assert_memory_equal(domains_2, domains_2_res, size);
+    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(err, NO_ERROR);
+
+    wchar_t domains_3[BUF_SIZE] = L"openvpn.com,openvpn.net";
+    len = (DWORD)wcslen(domains_3) + 1;
+    size = orig_size = len * glyph_size;
+    wchar_t domains_3_res[BUF_SIZE] = L".openvpn.net";
+    res_len = (DWORD)wcslen(domains_3_res) + 2;
+    err = ConvertItfDnsDomains(L"openvpn.com", domains_3, &size, BUF_SIZE);
+    assert_memory_equal(domains_3, domains_3_res, size);
+    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(err, NO_ERROR);
+
+    wchar_t domains_4[BUF_SIZE] = L"openvpn.com,openvpn.net";
+    len = (DWORD)wcslen(domains_4) + 1;
+    size = orig_size = len * glyph_size;
+    wchar_t domains_4_res[BUF_SIZE] = L".openvpn.com\0.openvpn.net";
+    res_len = len + 3; /* adds two . and one \0 */
+    err = ConvertItfDnsDomains(NULL, domains_4, &size, BUF_SIZE);
+    assert_memory_equal(domains_4, domains_4_res, size);
+    assert_int_equal(size, res_len * glyph_size);
+    assert_int_equal(err, NO_ERROR);
+}
+
+int
+wmain(void)
+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(test_list_contains_domain),
+        cmocka_unit_test(test_convert_itf_dns_domains),
+    };
+
+    int ret = cmocka_run_group_tests_name("openvpnserv tests", tests, NULL, NULL);
+
+    return ret;
+}

