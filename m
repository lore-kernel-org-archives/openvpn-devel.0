From: Gert Doering <gert@...1296...>
Date: Thu, 15 Jan 2026 09:28:12 +0100
Message-ID: <20260115082817.18618-1-gert@...1296...>
In-Reply-To: <gerrit.1767876064000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
References: <gerrit.1767876064000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tests/unit_tests: Port to cmocka 2.0.0
 API
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

But add compat layer so that we can still build
against older versions of cmocka. Mostly this is
trivial but the custom check function changed its
prototype, so that requires some more work.

This backport commit additionally includes the fix
for test_tls_crypt from commit
6246f2113f6e1fda13bca8de863dd5cc396ab6ef since the
other test fixes from the original commit are not
relevant to release/2.6.

Change-Id: Ifb6594700db71d219643a29c581099c778bcbbc6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1449
Message-Id: <20251218104042.5961-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35144.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1462
(cherry picked from commit 6db186e0b1d9783ea96e8a945a47fd23b45e4778)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1462
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index f7cb5a7..6983d111 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -291,6 +291,18 @@
     )
 set(HAVE_CONFIG_VERSION_H YES)
 
+if (BUILD_TESTING)
+    find_package(cmocka CONFIG)
+    if (TARGET cmocka::cmocka)
+        set(CMOCKA_LIBRARIES cmocka::cmocka)
+    else ()
+        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
+        set(CMOCKA_LIBRARIES PkgConfig::cmocka)
+    endif ()
+    set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRARIES})
+    check_include_files(cmocka_version.h HAVE_CMOCKA_VERSION_H)
+endif ()
+
 configure_file(config.h.cmake.in config.h)
 configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
 # TODO we should remove the need for this, and always include config.h
@@ -541,14 +553,6 @@
 
 
 if (BUILD_TESTING)
-    find_package(cmocka CONFIG)
-    if (TARGET cmocka::cmocka)
-        set(CMOCKA_LIBRARIES cmocka::cmocka)
-    else ()
-        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
-        set(CMOCKA_LIBRARIES PkgConfig::cmocka)
-    endif ()
-
     set(unit_tests
         "test_auth_token"
         "test_buffer"
diff --git a/config.h.cmake.in b/config.h.cmake.in
index cedc5be..bf60d39 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -86,6 +86,9 @@
 /* git version information in config-version.h */
 #cmakedefine HAVE_CONFIG_VERSION_H
 
+/* cmocka version information available in cmocka_version.h (>= 2.0.0) */
+#cmakedefine HAVE_CMOCKA_VERSION_H
+
 /* Define to 1 if you have the `daemon' function. */
 #cmakedefine HAVE_DAEMON
 
diff --git a/configure.ac b/configure.ac
index e77fd47..fb8d530 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1525,7 +1525,16 @@
 	[have_cmocka="yes"],
 	[AC_MSG_WARN([cmocka.pc not found on the system using pkg-config ${pkg_config_found}.  Unit tests disabled])]
 )
-AM_CONDITIONAL([ENABLE_UNITTESTS], [test "${enable_unit_tests}" = "yes" -a "${have_cmocka}" = "yes" ])
+AM_CONDITIONAL([ENABLE_UNITTESTS], [false])
+if test "${enable_unit_tests}" = "yes" -a "${have_cmocka}" = "yes"; then
+   AM_CONDITIONAL([ENABLE_UNITTESTS], [true])
+
+   saved_CFLAGS="${CFLAGS}"
+   CFLAGS="${CFLAGS} ${CMOCKA_CFLAGS}"
+   # detect cmocka < 2.0.0 that had no cmocka_version.h
+   AC_CHECK_HEADERS([cmocka_version.h])
+   CFLAGS="${saved_CFLAGS}"
+fi
 AC_SUBST([ENABLE_UNITTESTS])
 
 TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS}"
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
index 50e16d6..e5e4420 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -25,6 +25,27 @@
 #include <setjmp.h>
 #include <cmocka.h>
 
+/* Do we use cmocka < 2.0.0? */
+#ifndef HAVE_CMOCKA_VERSION_H
+#define HAVE_OLD_CMOCKA_API 1
+/* compat with various versions of cmocka.h
+ * Older versions have LargestIntegralType. Newer
+ * versions use uintmax_t. But LargestIntegralType
+ * is not guaranteed to be equal to uintmax_t, so
+ * we can't use that unconditionally. So we only use
+ * it if cmocka.h does not define LargestIntegralType.
+ */
+#ifndef LargestIntegralType
+#define LargestIntegralType uintmax_t
+#endif
+/* redefine 2.x API in terms of 1.x API */
+#define CMockaValueData             LargestIntegralType
+#define check_expected_uint         check_expected
+#define expect_uint_value           expect_value
+#define expect_check_data           expect_check
+#define cast_ptr_to_cmocka_value(x) (x)
+#endif
+
 /**
  * Sets up the environment for unit tests like making both stderr and stdout
  * non-buffered to avoid messages getting lost if the program exits early.
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 5eb864e..bf5a8ce 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -112,8 +112,8 @@
 __wrap_buffer_write_file(const char *filename, const struct buffer *buf)
 {
     const char *pem = BSTR(buf);
-    check_expected(filename);
-    check_expected(pem);
+    check_expected_ptr(filename);
+    check_expected_ptr(pem);
 
     return mock_type(bool);
 }
@@ -121,7 +121,7 @@
 struct buffer
 __wrap_buffer_read_from_file(const char *filename, struct gc_arena *gc)
 {
-    check_expected(filename);
+    check_expected_ptr(filename);
 
     const char *pem_str = mock_ptr_type(const char *);
     struct buffer ret = alloc_buf_gc(strlen(pem_str) + 1, gc);

